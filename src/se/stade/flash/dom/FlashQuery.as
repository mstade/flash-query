package se.stade.flash.dom
{
	import flash.display.*;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import se.stade.colligo.*;
	import se.stade.daffodil.Reflect;
	import se.stade.daffodil.types.QualifiedType;
	import se.stade.flash.dom.events.*;
	import se.stade.flash.dom.querying.DisplayQuery;
	import se.stade.flash.dom.querying.ElementMatcher;
	import se.stade.flash.dom.querying.QueryLimit;
	import se.stade.flash.dom.querying.QueryResult;
	import se.stade.flash.dom.querying.css.parsing.*;
	import se.stade.flash.dom.querying.css.selectors.SelectorGroup;
	import se.stade.flash.dom.querying.css.selectors.InvalidSelector;
	import se.stade.flash.dom.querying.css.selectors.type.ElementSelector;
	import se.stade.flash.dom.querying.css.selectors.type.ElementTypeSelector;
	import se.stade.flash.dom.querying.css.selectors.type.NamespaceSelector;
	import se.stade.flash.dom.querying.css.selectors.type.UniversalSelector;
	import se.stade.flash.dom.querying.limits.LimitGroup;
	import se.stade.flash.dom.querying.limits.MatchLimit;
	import se.stade.flash.dom.querying.limits.UnmatchedLimit;
	import se.stade.flash.dom.traversals.*;
	import se.stade.parsing.Language;
	import se.stade.parsing.ParseError;
	import se.stade.stilts.Disposable;
	
	public dynamic class FlashQuery extends ElementProxy implements Element, Countable, Collection, Processable, Indexable, Disposable, Arrayable
	{
		public static const Empty:FlashQuery = new FlashQuery(null);
        
        public static function from(element:DisplayObject, ... additionalElements):FlashQuery
        {
            var allElements:Vector.<DisplayObject> = new <DisplayObject>[];
            
            if (element)
                allElements.push(element);
            
            if (additionalElements.length > 0)
                allElements = allElements.concat(Vector.<DisplayObject>(additionalElements));
            
            return new FlashQuery(allElements);
        }
        
		public function FlashQuery(elements:Vector.<DisplayObject>, language:Language = null)
		{
			super(elements || new Vector.<DisplayObject>);
            
            _context = this;
			this.language = language;
            this.query = new DisplayQuery(UniversalSelector.Instance);
		}
        
        private var query:DisplayQuery;
        
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
		
		private var _language:Language;
		public function get language():Language
		{
            _language ||= new SelectorsLevel3;
			return _language;
		}
		
		public function set language(value:Language):void
		{
			_language = value;
		}
        
        private var liveDisplay:DisplayListWatcher;
        
        public function get live():Boolean
        {
            return liveDisplay != null;
        }
        
        public function set live(value:Boolean):void
        {
            if (value != live)
            {
                if (live)
                {
                    liveDisplay.dispose();
                    liveDisplay = null;
                }
                
                if (value)
                {
                    liveDisplay = new DisplayListWatcher(query, context, list);
                }
            }
        }
        
        protected var liveProperties:Object = {};
        
        override public function get(property:String):*
        {
            var value:* = super.get(property);
            return (value === undefined) ? find(property) : value;
        }
        
        override public function set(properties:Object):void
        {
            super.set(properties);
            
            for each (var name:String in properties)
            {
                this.liveProperties[name] = properties[name];
            }
        }
        
        protected function parse(expression:String):DisplayQuery
        {
            try
            {
                var selector:ElementMatcher = language.parse(expression) as ElementMatcher || new InvalidSelector(expression);
            }
            catch (error:ParseError)
            {
                trace("[FlashQuery WARNING] parsing '" + expression + "' failed with error:", error.message);
                selector = new InvalidSelector(expression);
            }
            
            return new DisplayQuery(selector);
        }
        
        protected function execute(query:DisplayQuery,
                                 traversal:DisplayListTraversal = null,
                                 limit:QueryLimit = null):FlashQuery
        {
            traversal ||= new DepthFirstTraversal(elements);
            var result:QueryResult = query.execute(traversal, limit);
            
            return wrap(result.matches);
        }
        
        protected function wrap(elements:Vector.<DisplayObject>):FlashQuery
        {
            var result:FlashQuery = new FlashQuery(elements, language);
            result._context = this;
            result.query = query;
            
            return result;
        }
        
        protected function parseAndExecute(expression:String,
                                         traversal:DisplayListTraversal = null,
                                         limit:QueryLimit = null):FlashQuery
        {
            var query:DisplayQuery = parse(expression);
            return execute(query, traversal, limit);
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
		
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
            
            if (liveDisplay)
            {
                liveDisplay.addEventListener(type, listener, useCapture, priority, useWeakReference);
            }
		}
		
		override public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			super.removeEventListener(type, listener, useCapture);
            
            if (liveDisplay)
            {
                liveDisplay.removeEventListener(type, listener, useCapture);
            }
		}
		
		public function join(other:FlashQuery):FlashQuery
		{
            var result:FlashQuery = wrap(elements.concat(other.elements));
            result._contextcontext = this;
            
            var selectors:Vector.<ElementMatcher> = new <ElementMatcher>[query.selector, other.query.selector];
            result.query = new DisplayQuery(new SelectorGroup(selectors));
            
            return result;
		}
		
		public function eq(index:int):FlashQuery
		{
            return wrap(elements.slice(index, index + 1));
		}
		
		public function first():FlashQuery
		{
			return eq(0);
		}
		
		public function last():FlashQuery
		{
			return eq(count - 1);
		}
        
		/**
		 * Selects descendants of the elements in this query, filtered by a
		 * selector string. 
		 *
		 * @param expression A selector expression.
		 * 
		 * @return A <c>FlashQuery</c> instance consisting of any elements that
		 * matched the given expression. If no matches are found, the result is
		 * empty.
		 */
		public function find(expression:String, limit:Number = uint.MAX_VALUE):FlashQuery
		{
            return parseAndExecute(expression, new DepthFirstTraversal(children().elements), new MatchLimit(limit));
		}
        
        public function type(Type:Class, limit:Number = uint.MAX_VALUE):FlashQuery
        {
            var query:DisplayQuery = new DisplayQuery(new ElementTypeSelector(Type));
            
            return execute(query, new DepthFirstTraversal(elements), new MatchLimit(limit));
        }
		
		public function filter(expression:String, limit:Number = uint.MAX_VALUE):FlashQuery
		{
            return parseAndExecute(expression, new LinearTraversal(elements), new MatchLimit(limit));
		}
		
		public function children(expression:String = "*", limit:Number = uint.MAX_VALUE):FlashQuery
		{
            return parseAndExecute(expression, new ImmediateChildTraversal(roots), new MatchLimit(limit));
		}
		
		public function parent(expression:String = "*"):FlashQuery
		{
			return ancestors(expression, 1);
		}
		
		public function ancestors(expression:String = "*", limit:Number = uint.MAX_VALUE):FlashQuery
		{
            return parseAndExecute(expression, new AncestorTraversal(elements), new MatchLimit(limit));
		}
		
		public function ancestorsUntil(expression:String, limit:Number = uint.MAX_VALUE):FlashQuery
		{
            return parseAndExecute(expression, new AncestorTraversal(elements), new MatchLimit(limit));
		}
		
		public function are(expression:String):Boolean
		{
			return filter(expression).count == count;
		}
		
		public function areAny(expression:String):Boolean
		{
			return filter(expression, 1).count > 0;
		}
		
		public function has(expression:String, limit:Number = uint.MAX_VALUE):FlashQuery
		{
			var matchingChildren:Vector.<DisplayObject> = new <DisplayObject>[];
            
            var query:DisplayQuery = parse(expression);
            var max:QueryLimit = new MatchLimit(limit);
			
			for each (var root:DisplayObjectContainer in roots)
			{
                var traversal:DepthFirstTraversal = new DepthFirstTraversal(new <DisplayObject>[root]);
                
				if (query.execute(traversal, max).matches.length > 0)
                    matchingChildren.push(root);
				
				if (limit == matchingChildren.length)
					break;
			}
			
			return wrap(matchingChildren);
		}
		
		public function siblings(expression:String = "*", limit:Number = uint.MAX_VALUE):FlashQuery
		{
            return parseAndExecute(expression, new SiblingTraversal(elements), new MatchLimit(limit));
		}
		
		public function prev(expression:String = "*", limit:Number = uint.MAX_VALUE):FlashQuery
		{
            return parseAndExecute(expression, new PrecedingSiblingTraversal(elements), new MatchLimit(limit));
		}
		
		public function prevUntil(expression:String, limit:Number = uint.MAX_VALUE):FlashQuery
		{
            return parseAndExecute(expression, new PrecedingSiblingTraversal(elements), LimitGroup.of(
                MatchLimit.of(limit),
                UnmatchedLimit.of(1)
            ));
		}
		
		public function next(expression:String = "*", limit:Number = uint.MAX_VALUE):FlashQuery
		{
            return parseAndExecute(expression, new FollowingSiblingTraversal(elements), new MatchLimit(limit));
		}
		
		public function nextUntil(expression:String, limit:Number = uint.MAX_VALUE):FlashQuery
		{
            return parseAndExecute(expression, new FollowingSiblingTraversal(elements), LimitGroup.of(
                MatchLimit.of(limit),
                UnmatchedLimit.of(1)
            ));
		}
		
		public function not(expression:String, limit:Number = uint.MAX_VALUE):FlashQuery
		{
            var query:DisplayQuery = parse(expression);
            var result:QueryResult = query.execute(new LinearTraversal(elements), new MatchLimit(limit));
            
            return wrap(result.unmatched);
		}
		
		public function slice(start:int, end:int):FlashQuery
		{
            return wrap(elements.slice(start, end));
		}
        
        public function dispose():void
        {
            live = false;
            list = [];
            _context = this;
        }
	}
}