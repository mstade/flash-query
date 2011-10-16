package se.stade.flash.dom.nodes
{
    import flash.display.DisplayObjectContainer;
    import flash.events.Event;
    import flash.events.IEventDispatcher;
    
    import se.stade.flash.dom.DisplayNode;
    import se.stade.flash.dom.DisplayNodeList;

    internal class VisualElementNode implements DisplayNode
    {
        public function VisualElementNode(element:*)
        {
            _element = element;
        }
        
        private var _element:*;
        public function get element():*
        {
            return _element;
        }
        
        public function get index():int
        {
            var owner:DisplayObjectContainer = element["owner"];
            return owner ? owner.getChildIndex(_element) : -1;
        }
        
        public function get parent():DisplayNode
        {
            return DisplayNodeFactory.from(element["owner"]);
        }
        
        public function get children():DisplayNodeList
        {
            return EmptyNodeList.Instance;
        }
        
        private var _nextSiblings:DisplayNodeList;
        public function get nextSiblings():DisplayNodeList
        {
            _nextSiblings ||= new FollowingSiblingList(this);
            return _nextSiblings;
        }
        
        private var _prevSiblings:DisplayNodeList;
        public function get prevSiblings():DisplayNodeList
        {
            _prevSiblings ||= new PreceedingSiblingList(this);
            return _prevSiblings;
        }
        
        public function addEventListener(type:String,
                                         listener:Function,
                                         useCapture:Boolean = false,
                                         priority:int = 0, 
                                         useWeakReference:Boolean = false):void
        {
            element.addEventListener(type,
                                     listener,
                                     useCapture,
                                     priority,
                                     useWeakReference);
        }
        
        public function dispatchEvent(event:Event):Boolean
        {
            return element.dispatchEvent(event);
        }
        
        public function removeEventListener(type:String,
                                            listener:Function,
                                            useCapture:Boolean = false):void
        {
            element.removeEventListener(type, listener, useCapture);
        }
        
        public function hasEventListener(type:String):Boolean
        {
            return element.hasEventListener(type);
        }
        
        public function willTrigger(type:String):Boolean
        {
            return element.willTrigger(type);
        }
    }
}
