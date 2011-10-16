package se.stade.flash.dom
{
    import flash.events.Event;
    import flash.events.IEventDispatcher;
    
    import se.stade.flash.dom.events.EventListenerCollection;
    import se.stade.flash.dom.nodes.DisplayNodeFactory;
    import se.stade.stilts.Disposable;
    import se.stade.stilts.PropertySet;

    public class DisplayListWatcher implements Disposable
    {
        public function DisplayListWatcher(query:FlashQuery)
        {
            this.query = query;
            query.context.addEventListener(Event.ADDED, handleAddedElement);
        }
        
        private var query:FlashQuery;
        
        public function dispose():void
        {
            query.context.removeEventListener(Event.ADDED, handleAddedElement);
            
            query = null;
            events = null;
            properties = null;
        }
        
        private var properties:PropertySet = new PropertySet;
        
        public function set(properties:Object):void
        {
            this.properties.setProperties(properties);
        }
        
        protected var events:EventListenerCollection = new EventListenerCollection;
        
        public function addEventListener(type:String,
                                         listener:Function,
                                         useCapture:Boolean=false,
                                         priority:int=0,
                                         useWeakReference:Boolean=false):void
        {
            events.add(type, listener, useCapture, priority, useWeakReference);
        }
        
        public function removeEventListener(type:String,
                                            listener:Function,
                                            useCapture:Boolean=false):void
        {
            events.remove(type, listener, useCapture);
        }
        
        protected function handleAddedElement(added:Event):void
        {
            var node:DisplayNode = DisplayNodeFactory
                                   .from(added.target as IEventDispatcher);
            if (query.add(node))
            {
                events.bind(node.element);
                properties.applyTo(node.element);
                
                node.addEventListener(Event.REMOVED_FROM_STAGE, handleRemovedElement);
            }
        }
        
        protected function handleRemovedElement(removed:Event):void
        {
            var target:DisplayNode = DisplayNodeFactory
                                     .from(removed.target as IEventDispatcher);
            
            query.remove(target);
            events.unbind(target);
            
            target.removeEventListener(Event.ADDED, handleAddedElement);
            target.removeEventListener(Event.REMOVED_FROM_STAGE, handleRemovedElement);
        }
    }
}
