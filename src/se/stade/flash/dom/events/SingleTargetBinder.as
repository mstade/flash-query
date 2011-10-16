package se.stade.flash.dom.events
{
    import flash.events.Event;
    import flash.events.IEventDispatcher;
    import flash.utils.Dictionary;
    
    import se.stade.stilts.Disposable;

    public class SingleTargetBinder implements EventBinder
    {
        /**
         * Creates an EventBinder used to bind events to the specifed target.
         */
        public function SingleTargetBinder(target:IEventDispatcher)
        {
            this.target = target;
        }
        
        private var target:IEventDispatcher;
        private var events:Dictionary = new Dictionary;
        
        private function stripNamespace(type:String):String
        {
            return type.split(".", 1)[0];
        }
        
        private function getNamespace(type:String):String
        {
            return type.substr(stripNamespace(type).length);
        }
        
        private function splitEvents(types:String):Array
        {
            return types.replace(/\s+/g, " ").split(" ");
        }
        
        public function bind(types:String,
                             handler:Function,
                             options:Object = null):void
        {
            var list:Array = splitEvents(types);
            
            options ||= {
                parameters:    [],
                priority:      0,
                weak:          false,
                capture:       false,
                allowBubble:   false
            };
            
            var params:Array = "params" in options     ? options.params
                             : "parameters" in options ? options.parameters
                             : [];

            var priority:int = "priority" in options ? options.priority
                             : 0;

            var weak:Boolean = "weak" in options             ? options.weak
                             : "useWeakReference" in options ? options.useWeakReference
                             : false;
    
            var capture:Boolean = "capture" in options    ? options.capture
                                : "useCapture" in options ? options.useCapture
                                : false;
            
            var allowBubble:Boolean = "bubble" in options        ? options.bubble
                                    : "allowBubble" in options   ? options.allowBubble
                                    : "preventBubble" in options ? !options.preventBubble
                                    : false;
            
            for each (var type:String in list)
            {
                if (type.charAt(0) == ".")
                    continue; // Invalid event
                
                events[type] ||= new Dictionary;
                
                events[type][handler] = function(event:Event):void
                {
                    var result:* = handler.apply(target, [event].concat(params));
                    
                    if (result || allowBubble)
                        return;
                    
                    event.preventDefault();
                    event.stopPropagation();
                };
                
                type = stripNamespace(type);
                target.addEventListener(type, events[type][handler],
                                        capture, priority, weak);
            }
        }
        
        public function bindMap(events:Object):void
        {
            for (var type:String in events)
            {
                if (events[type] is Function)
                    bind(type, events[type]);
                else
                    bind(type, events[type].handler, events[type]);
            }
        }
        
        public function unbind(types:String = null):void
        {
            if (!type)
            {
                for (var type:String in events)
                {
                    unbind(type);
                }
            }
            
            var list:Array = splitEvents(types);
            
            for each (type in list)
            {
                if (type.charAt(0) == ".")
                {
                    for (var storedType:String in events)
                    {
                        if (type == getNamespace(storedType))
                        {
                            unbind(storedType);
                        }
                    }
                }
                else if (type in events)
                {
                    var actualType:String = stripNamespace(type);
                    
                    for each (var wrapper:Function in events[type])
                    {
                        target.removeEventListener(actualType, wrapper);
                    }
                    
                    delete events[type];
                }
            }
        }
        
        public function dispose():void
        {
            for (var type:String in events)
            {
                unbind(type);
            }
        }
    }
}
