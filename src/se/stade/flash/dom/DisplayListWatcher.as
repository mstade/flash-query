package se.stade.flash.dom
{
    import flash.display.DisplayObject;
    import flash.events.Event;
    import flash.events.IEventDispatcher;
    import flash.utils.Dictionary;
    
    import se.stade.flash.dom.events.EventListenerCollection;
    import se.stade.flash.dom.nodes.DisplayNodeFactory;
    import se.stade.flash.dom.querying.QueryResult;
    import se.stade.flash.dom.querying.ValidDisplayQuery;
    import se.stade.flash.dom.traversals.DepthFirst;
    import se.stade.stilts.Disposable;
    import se.stade.stilts.PropertySet;

    public class DisplayListWatcher implements Disposable
    {
        public function DisplayListWatcher(query:ValidDisplayQuery, context:FlashQuery, nodes:Vector.<DisplayNode>)
        {
            this.query = query;
            this.context = context;
            context.addEventListener(Event.ADDED, handleAddedElement);
            context.addEventListener(Event.REMOVED_FROM_STAGE, handleRemovedElement);
            
            this.nodes = nodes;
            
            for each (var node:DisplayNode in nodes)
            {
                nodeTable[node.element] = node;
            }
        }
        
        private var query:ValidDisplayQuery;
        private var context:FlashQuery;
        
        private var nodes:Vector.<DisplayNode>;
        private var nodeTable:Dictionary = new Dictionary;
        
        public function dispose():void
        {
            context.removeEventListener(Event.ADDED, handleAddedElement);
            context.removeEventListener(Event.REMOVED, handleAddedElement);
            context = null;
            query = null;
            nodes = null;
        }
        
        private var properties:PropertySet = new PropertySet;
        
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
            var result:QueryResult = query.find(
                DepthFirst.through(
                    DisplayNodeFactory.list(added.target as DisplayObject)
                )
            );
            
            var distinctMatches:Vector.<DisplayNode> = new <DisplayNode>[];
            
            for each (var node:DisplayNode in result.matches)
            {
                if (node.element in nodeTable)
                    continue;
                
                distinctMatches.push(node);
                nodeTable[node.element] = node;
            }
            
            var targets:ElementProxy = new ElementProxy(distinctMatches);
            
            properties.applyTo(targets);
            events.addListener(targets);
            targets.addEventListener(Event.REMOVED_FROM_STAGE, handleRemovedElement);
            
            nodes.push.apply(nodes, targets.toArray());
        }
        
        protected function handleRemovedElement(removed:Event):void
        {
            var target:DisplayNode = DisplayNodeFactory.from(removed.target as IEventDispatcher);
            
            target.removeEventListener(Event.ADDED, handleAddedElement);
            target.removeEventListener(Event.REMOVED_FROM_STAGE, handleRemovedElement);
            
            events.removeListener(target);
            
            for (var i:int = 0; i < nodes.length; i++)
            {
                if (nodes[i].element == target.element)
                {
                    delete nodeTable[nodes[i].element];
                    nodes.splice(i, 1);
                }
            }
        }
    }
}