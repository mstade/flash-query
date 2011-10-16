package se.stade.flash.dom.events
{
    import flash.events.Event;
    import flash.events.IEventDispatcher;

    public class EventListenerParameters
    {
        public function EventListenerParameters(type:String,
                                                listener:Function,
                                                useCapture:Boolean = false,
                                                priority:int = 0,
                                                useWeakReference:Boolean = false)
        {
            _type = type;
            _listener = listener;
            _useCapture = useCapture;
            _priority = priority;
            _useWeakReference = useWeakReference;
        }
        
        private var _type:String;
        public function get type():String
        {
            return _type;
        }
        
        private var _listener:Function;
        public function get listener():Function
        {
            return _listener;
        }
        
        private var _useCapture:Boolean;
        public function get useCapture():Boolean
        {
            return _useCapture;
        }
        
        private var _priority:int;
        public function get priority():int
        {
            return _priority;
        }
        
        private var _useWeakReference:Boolean;
        public function get useWeakReference():Boolean
        {
            return _useWeakReference;
        }
        
        public function addListener(dispatcher:IEventDispatcher):void
        {
            dispatcher.addEventListener(type,
                                        listener,
                                        useCapture,
                                        priority,
                                        useWeakReference);
        }
        
        public function removeListener(dispatcher:IEventDispatcher):void
        {
            dispatcher.removeEventListener(type, listener, useCapture);
        }
    }
}
