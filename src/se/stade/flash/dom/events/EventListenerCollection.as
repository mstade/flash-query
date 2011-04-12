package se.stade.flash.dom.events
{
	import flash.utils.Dictionary;

	public class EventListenerCollection
	{
		private var bubble:Dictionary = new Dictionary();
		private var capture:Dictionary = new Dictionary();
		
		public function add(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			var events:Object = useCapture ? capture : bubble;
			
			if (type in listener == false)
				events[type] = new Dictionary();
			
			events[type][listener] = new EventListenerParameters(type, listener, useCapture, priority, useWeakReference);
		}

		public function remove(type:String, listener:Function, useCapture:Boolean=false):void
		{
			var events:Object = useCapture ? capture : bubble;
			
			if (type in events && listener in events[type])
			{	
				delete events[type][listener];
				
				for (var deferred:* in events[type])
					return;
				
				delete events[type];
			}
		}
		
		private function addHandlersToList(event:Dictionary, listeners:Vector.<EventListenerParameters>):void
		{
			for (var listener:* in event)
			{
				listeners.push(event[listener]);
			}
		}
		
		private function compileHandlerList(events:Dictionary):Vector.<EventListenerParameters>
		{
			var listeners:Vector.<EventListenerParameters> = new <EventListenerParameters>[];
			
			for each (var event:Dictionary in events)
			{
				addHandlersToList(event, listeners);
			}
			
			return listeners;
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
	}
}