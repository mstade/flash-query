package se.stade.flash.dom.nodes
{
    import flash.display.DisplayObject;
    import flash.events.Event;
    import flash.events.IEventDispatcher;
    
    import se.stade.flash.dom.DisplayNode;
    import se.stade.flash.dom.DisplayNodeList;

    internal final class DisplayObjectNode implements DisplayNode
    {
        public function DisplayObjectNode(element:DisplayObject)
        {
            _element = element;
        }
        
        private var _element:DisplayObject;
        public function get element():IEventDispatcher
        {
            return _element;
        }
        
        public function get index():int
        {
            return _element.parent ? _element.parent.getChildIndex(_element) : -1;
        }
        
        public function get parent():DisplayNode
        {
            return DisplayNodeFactory.from(_element.parent);
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
        
        public function get numChildren():int
        {
            return 0;
        }
        
        public function get hasChildren():Boolean
        {
            return false;
        }
        
        public function get canHaveChildren():Boolean
        {
            return false;
        }
        
        public function getChildAt(index:int):DisplayNode
        {
            return null;
        }
        
        public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
        {
            element.addEventListener(type, listener, useCapture, priority, useWeakReference);
        }
        
        public function dispatchEvent(event:Event):Boolean
        {
            return element.dispatchEvent(event);
        }
        
        public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
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