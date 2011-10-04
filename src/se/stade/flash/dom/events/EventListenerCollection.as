package se.stade.flash.dom.events
{
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;

	public class EventListenerCollection
	{
		private var bubble:Dictionary = new Dictionary;
		private var capture:Dictionary = new Dictionary;
		
		public function add(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			var events:Dictionary = useCapture ? capture : bubble;
			
			events[type] ||= new Dictionary;
			events[type][listener] = new EventListenerParameters(type, listener, useCapture, priority, useWeakReference);
		}

		public function remove(type:String, listener:Function, useCapture:Boolean=false):void
		{
			var events:Dictionary = useCapture ? capture : bubble;
			
			if (type in events && listener in events[type])
			{	
				delete events[type][listener];
				
				for (var hasListener:* in events[type])
					break;
					
				if (!hasListener)
				    delete events[type];
			}
		}
		
		private function compileHandlerList(events:Dictionary):Vector.<EventListenerParameters>
		{
			var parameters:Vector.<EventListenerParameters> = new <EventListenerParameters>[];
			
			for each (var event:Dictionary in events)
			{
                for (var listener:* in event)
                {
                    parameters.push(event[listener]);
                }
			}
			
			return parameters;
		}
		
		public function getListeners():Vector.<EventListenerParameters>
		{
			return getBubbleListeners().concat(getCaptureListeners());
		}
		
		public function getBubbleListeners():Vector.<EventListenerParameters>
		{
			return compileHandlerList(bubble);
		}
		
		public function getCaptureListeners():Vector.<EventListenerParameters>
		{
			return compileHandlerList(capture);
		}
        
        public function addListener(dispatcher:IEventDispatcher):void
        {
            for each (var event:EventListenerParameters in getListeners())
            {
                event.addListener(dispatcher);
            }
        }
        
        public function removeListener(dispatcher:IEventDispatcher):void
        {
            for each (var event:EventListenerParameters in getListeners())
            {
                event.removeListener(dispatcher);
            }
        }
	}
}