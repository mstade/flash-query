package se.stade.flash.dom
{
    import flash.display.DisplayObject;
    import flash.events.Event;
    import flash.events.IEventDispatcher;
    import flash.utils.Dictionary;
    
    import se.stade.flash.dom.events.EventListenerCollection;
    import se.stade.flash.dom.events.EventListenerParameters;
    import se.stade.flash.dom.querying.DisplayQuery;
    import se.stade.flash.dom.querying.QueryResult;
    import se.stade.flash.dom.traversals.DepthFirstTraversal;
    import se.stade.flash.dom.traversals.DisplayListTraversal;
    import se.stade.stilts.Disposable;

    public class DisplayListWatcher implements Disposable
    {
        public function DisplayListWatcher(query:DisplayQuery, context:FlashQuery, elements:Array)
        {
            this.query = query;
            this.context = context;
            
            context.addEventListener(Event.ADDED, handleAddedElement);
            context.addEventListener(Event.REMOVED, handleRemovedElement);
        }
        
        private var query:DisplayQuery;
        private var context:FlashQuery;
        private var elements:Array;
        
        public function dispose():void
        {
            context = null;
            context.removeEventListener(Event.ADDED, handleAddedElement);
            context.removeEventListener(Event.REMOVED, handleAddedElement);
        }
        
        private var properties:Dictionary = new Dictionary;
        
        public function set(properties:Object):void
        {
            for (var name:String in properties)
            {
                this.properties[name] = properties[name];
            }
        }
        
        protected var events:EventListenerCollection = new EventListenerCollection;
        
        public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
        {
            events.add(type, listener, useCapture, priority, useWeakReference);
        }
        
        public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
        {
            events.remove(type, listener, useCapture);
        }
        
        protected function handleAddedElement(added:Event):void
        {
            var addedElements:DisplayListTraversal = new DepthFirstTraversal(
                new <DisplayObject>[added.target as DisplayObject]
            );
            
            var result:ElementProxy = new ElementProxy(query.execute(addedElements).matches);
            result.set(properties);
            
            for each (var event:EventListenerParameters in events.getListeners())
            {
                result.addEventListener(event.type,
                                        event.listener,
                                        event.useCapture,
                                        event.priority,
                                        event.useWeakReference);
            }
            
            elements.push.apply(result.toArray());
        }
        
        protected function handleRemovedElement(removed:Event):void
        {
            var removedElements:DisplayListTraversal = new DepthFirstTraversal(
                new <DisplayObject>[removed.target as DisplayObject]
            );
            
            var result:ElementProxy = new ElementProxy(query.execute(removedElements).matches);
            
            for each (var event:EventListenerParameters in events.getListeners())
            {
                result.removeEventListener(event.type, event.listener, event.useCapture);
            }
            
            var lookup:Dictionary = new Dictionary;
            
            for each (var element:DisplayObject in result.elements)
            {
                lookup[element] = true;
            }
            
            for (var i:int = 0; i < elements.length; i++)
            {
                if (elements[i] in lookup)
                {
                    elements.splice(i, 1);
                    elements[i].removeEventListener(Event.ADDED, handleAddedElement);
                    elements[i].removeEventListener(Event.REMOVED, handleRemovedElement);
                }
            }
        }
    }
}