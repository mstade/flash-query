package se.stade.flash.dom.events
{
    import flash.events.IEventDispatcher;
    import flash.utils.Dictionary;

    public class MultiTargetBinder implements EventBinder
    {
        public static function from(target:IEventDispatcher, ... targets):MultiTargetBinder
        {
            targets = [target].concat(targets);
            return new MultiTargetBinder(Vector.<IEventDispatcher>(targets));
        }
        
        public function MultiTargetBinder(targets:Vector.<IEventDispatcher> = null)
        {
            for each (var target:IEventDispatcher in targets)
            {
                add(target);
            }
        }
        
        private var binders:Vector.<EventBinder> = new Vector.<EventBinder>;
        private var binderTable:Dictionary = new Dictionary;
        
        public function add(target:IEventDispatcher):void
        {
            if (target in binderTable)
                return;
            
            var binder:EventBinder = new SingleTargetBinder(target);
            
            binders.push(binder);
            binderTable[target] = binder; 
        }
        
        public function remove(target:IEventDispatcher):void
        {
            if (target in binderTable)
            {
                var binder:EventBinder = binderTable[target];
                binder.dispose();
                   
                binders.splice(binders.indexOf(binder), 1);
                delete binderTable[target];
            }
        }
        
        public function bind(types:String, handler:Function, options:Object = null):void
        {
            for each (var binder:EventBinder in binders)
            {
                binder.bind(types, handler, options);
            }
        }
        
        public function bindMap(map:Object):void
        {
            for each (var binder:EventBinder in binders)
            {
                binder.bindMap(map);
            }
        }
        
        public function unbind(types:String = null):void
        {
            for each (var binder:EventBinder in binders)
            {
                binder.unbind(types);
            }
        }
        
        public function dispose():void
        {
            for each (var binder:EventBinder in binders)
            {
                binder.dispose();
            }
            
            binders = new <EventBinder>[];
        }
    }
}
