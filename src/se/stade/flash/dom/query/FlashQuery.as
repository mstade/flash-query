package se.stade.flash.dom.query
{
	import flash.display.*;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import se.stade.colligo.*;
	import se.stade.daffodil.Reflect;
	import se.stade.daffodil.qualify;
	import se.stade.daffodil.types.QualifiedType;
	import se.stade.flash.dom.*;
	import se.stade.flash.dom.events.*;
	import se.stade.flash.dom.query.css.parsing.*;
	import se.stade.flash.dom.query.css.selectors.ElementSelector;
	import se.stade.flash.dom.query.css.selectors.NamespaceSelector;
	import se.stade.flash.dom.traversals.*;
	import se.stade.stilts.Disposable;
	
	public dynamic class FlashQuery extends ElementProxy implements Element, Countable, Collection, Processable, Indexable, Disposable, Arrayable
	{
		public static const empty:FlashQuery = new FlashQuery(null);
        
        public static function from(element:DisplayObject, ... additionalElements):FlashQuery
        {
            var elements:Vector.<DisplayObject> = Vector.<DisplayObject>([element].concat(additionalElements));
            return new FlashQuery(elements);
        }
        
		public function FlashQuery(elements:Vector.<DisplayObject>, parser:QueryParser = null)
		{
            if (!elements)
				elements = new Vector.<DisplayObject>;
			
			super(elements);
            
            _context = this;
			_parser = parser || new SelectorParser(new SelectorLexer());
		}
        
        private function fromElements(elements:Array, query:String):FlashQuery
        {
            var wrapped:FlashQuery = new FlashQuery(Vector.<DisplayObject>(elements), parser);
            wrapped._context = this;
            wrapped.query = query;
            
            return wrapped;
        }
        
        private function execute(query:String, traverser:DisplayListTraversal, limit:Number = Number.MAX_VALUE, breakOnUnmatched:Boolean = false):FlashQuery
        {
            var executor:QueryExecutor = new QueryExecutor(parser, traverser);
            return fromElements(executor.process(query, limit, breakOnUnmatched).matches, query);
        }
        
        private namespace depthfirst;
        
        depthfirst function execute(query:String, elements:*, limit:Number = Number.MAX_VALUE, breakOnUnmatched:Boolean = false):FlashQuery
        {
            if (elements is DisplayObject)
                elements = new <DisplayObject>[elements];
            
            return execute(query, new DepthFirstTraversal(elements), limit, breakOnUnmatched);
        }
        
        private var query:String = "";
		
		private var _context:FlashQuery;
		
		/**
		 * The parent query from which this query originates. If this query doesn't have a
         * parent, this property will return this query instance, i.e. itself.
		 * 
		 * @return The <c>FlashQuery</c> instance from which query originates; or itself if
         *         no parent query exists.
		 */
		public function get context():FlashQuery
		{
			return _context;
		}
		
		private var _parser:QueryParser;
		public function get parser():QueryParser
		{
			return _parser;
		}
		
		public function set parser(value:QueryParser):void
		{
			_parser = value;
		}
        
        private var _live:Boolean
        public function get live():Boolean
        {
            return _live;
        }
        
        public function set live(value:Boolean):void
        {
            if (value != live)
            {
                _live = value;
                
                if (live)
                {
                    context.addEventListener(Event.ADDED, handleAddedElement);
                    context.addEventListener(Event.REMOVED, handleRemovedElement);
                }
                else
                {
                    context.removeEventListener(Event.ADDED, handleAddedElement);
                    context.removeEventListener(Event.REMOVED, handleAddedElement);
                }
            }
        }
        
        protected var liveProperties:Object = {};
        
        override public function get(property:String):*
        {
            var value:* = super.get(property);
            
            if (!value)
                return find(property);
        }
        
        override public function set(properties:Object):void
        {
            super.set(properties);
            
            for each (var name:String in properties)
            {
                this.liveProperties[name] = properties[name];
            }
        }
        
        protected function handleAddedElement(added:Event):void
        {
            var result:FlashQuery = depthfirst::execute(query, added.target);
            
            result.set(liveProperties);
            
            for each (var event:EventListenerParameters in events.getListeners())
            {
                result.addEventListener(event.type, event.listener, event.useCapture, event.priority, event.useWeakReference);
            }
            
            list = list.concat(result.toArray());
        }
        
        protected function handleRemovedElement(removed:Event):void
        {
            var result:FlashQuery = depthfirst::execute(query, removed.target);
            
            for each (var event:EventListenerParameters in events.getListeners())
            {
                result.removeEventListener(event.type, event.listener, event.useCapture);
            }
            
            var lookup:Dictionary = new Dictionary;
            
            for each (var element:DisplayObject in result.elements)
            {
                lookup[element] = true;
            }
            
            for (var i:int = 0; i < count; i++)
            {
                if (this[i] in lookup)
                {
                    list.splice(i, 1);
                }
            }
        }
        
		private var _roots:Vector.<DisplayObjectContainer>;
		protected function get roots():Vector.<DisplayObjectContainer>
		{
			if (!_roots)
			{
				_roots = new <DisplayObjectContainer>[];
				
				for each (var root:DisplayObject in list)
				{
					if (root is DisplayObjectContainer)
						_roots.push(root);
				}
			}
			
			return _roots;
		}
		
		protected var events:EventListenerCollection = new EventListenerCollection();
		
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			if (listeningForEvents)
				super.addEventListener(type, listener, useCapture, priority, useWeakReference);
			
			events.add(type, listener, useCapture, priority, useWeakReference);
		}
		
		override public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			super.removeEventListener(type, listener, useCapture);
			events.remove(type, listener, useCapture);
		}
		
		protected var listeningForEvents:Boolean = true;
		
		public function resumeEventListening():void
		{
			listeningForEvents = true;
			
			for each (var event:EventListenerParameters in events)
			{
				super.addEventListener(event.type, event.listener, event.useCapture, event.priority, event.useWeakReference);
			}
		}
		
		public function suspendEventListening():void
		{
			listeningForEvents = false;
			
			for each (var event:EventListenerParameters in events)
			{
				super.removeEventListener(event.type, event.listener, event.useCapture);
			}
		}
        
        public function wrap(element:DisplayObject, ... additionalElements):FlashQuery
        {
            return fromElements([element].concat(additionalElements), "");
        }
		
		public function join(other:FlashQuery):FlashQuery
		{
            return fromElements(list.concat(other.list), query + ", " + other.query);
		}
		
		public function eq(index:int):FlashQuery
		{
            return fromElements(list.slice(index, index + 1), query);
		}
		
		public function first():FlashQuery
		{
			return eq(1);
		}
		
		public function last():FlashQuery
		{
			return eq(count - 1);
		}
        
		/**
		 * Selects descendants of the elements in this query, filtered by a
		 * selector string. 
		 *
		 * @param query A selector string.
		 * 
		 * @return A <c>FlashQuery</c> instance consisting of any elements that
		 * matched the given selector. If no matches are found, the result is
		 * empty.
		 */
		public function find(query:String, limit:Number = Number.MAX_VALUE):FlashQuery
		{
            return depthfirst::execute(query, children().elements, limit);
		}
        
        public function type(query:Class, limit:Number = Number.MAX_VALUE):FlashQuery
        {
            var type:QualifiedType = Reflect.first.type.on(query);
            
            var namespace:NamespaceSelector = new NamespaceSelector(type.packageName);
            var selector:ElementSelector = new ElementSelector(type.name, namespace);
            
            var matches:Array = [];
            var traverser:DepthFirstTraversal = new DepthFirstTraversal(elements);
            
            while (traverser.hasNext && matches.length < limit)
            {
                var element:DisplayObject = traverser.getNext();
                
                if (selector.matches(element))
                    matches.push(element);
            }
            
            return fromElements(matches, type.qualifiedName);
        }
		
		public function filter(query:String, limit:Number = Number.MAX_VALUE):FlashQuery
		{
            return execute(query, new LinearTraversal(elements), limit);
		}
		
		public function children(query:String = "*", limit:Number = Number.MAX_VALUE):FlashQuery
		{
            return execute(query, new ImmediateChildTraversal(roots), limit);
		}
		
		public function parent(query:String = "*"):FlashQuery
		{
			return ancestors(query, 1);
		}
		
		public function ancestors(query:String = "*", limit:Number = Number.MAX_VALUE):FlashQuery
		{
            return execute(query, new AncestorTraversal(elements), limit);
		}
		
		public function ancestorsUntil(query:String, limit:Number = Number.MAX_VALUE):FlashQuery
		{
            return execute(query, new AncestorTraversal(elements), limit, true);
		}
		
		public function are(query:String):Boolean
		{
			return filter(query).count == count;
		}
		
		public function areAny(query:String):Boolean
		{
			return filter(query, 1).count > 0;
		}
		
		public function end():FlashQuery
		{
			return context;
		}
		
		public function has(query:String, limit:Number = Number.MAX_VALUE):FlashQuery
		{
			var hasMatchingChildren:Array = [];
			
			for each (var root:DisplayObjectContainer in roots)
			{
				if (depthfirst::execute(query, root, limit).count > 0)
					hasMatchingChildren.push(root);
				
				if (limit < hasMatchingChildren.length)
					continue;
			}
			
			return fromElements(hasMatchingChildren, query);
		}
		
		public function siblings(query:String = "*", limit:Number = Number.MAX_VALUE):FlashQuery
		{
            return execute(query, new SiblingTraversal(elements), limit);
		}
		
		public function prev(query:String = "*", limit:Number = Number.MAX_VALUE):FlashQuery
		{
            return execute(query, new PrecedingSiblingTraversal(elements), limit);
		}
		
		public function prevUntil(query:String, limit:Number = Number.MAX_VALUE):FlashQuery
		{
            return execute(query, new PrecedingSiblingTraversal(elements), limit, true);
		}
		
		public function next(query:String = "*", limit:Number = Number.MAX_VALUE):FlashQuery
		{
            return execute(query, new FollowingSiblingTraversal(elements), limit);
		}
		
		public function nextUntil(query:String, limit:Number = Number.MAX_VALUE):FlashQuery
		{
            return execute(query, new FollowingSiblingTraversal(elements), limit, true);
		}
		
		public function not(query:String, limit:Number = Number.MAX_VALUE):FlashQuery
		{
            var executor:QueryExecutor = new QueryExecutor(parser, new LinearTraversal(elements));
            return fromElements(executor.process(query, limit, false).unmatched, query);
		}
		
		public function slice(start:int, end:int):FlashQuery
		{
            return fromElements(list.slice(start, end), query);
		}
        
        public function dispose():void
        {
            live = false;
            list = [];
            _context = this;
            
            suspendEventListening();
            events = new EventListenerCollection();
        }
	}
}