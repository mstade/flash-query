package se.stade.flash.dom
{
    import flash.display.DisplayObject;
    
    import se.stade.flash.dom.nodes.DisplayNodeFactory;
    import se.stade.flash.dom.nodes.NodeList;
    import se.stade.flash.dom.querying.DisplayListQuery;
    import se.stade.flash.dom.querying.ElementMatcher;
    import se.stade.flash.dom.querying.InvalidExpressionMatcher;
    import se.stade.flash.dom.querying.InvertMatcher;
    import se.stade.flash.dom.querying.NodeSelector;
    import se.stade.flash.dom.querying.QueryLimit;
    import se.stade.flash.dom.querying.QueryResult;
    import se.stade.flash.dom.querying.SimpleDisplayQuery;
    import se.stade.flash.dom.querying.TypeMatcher;
    import se.stade.flash.dom.querying.css.parsing.SelectorsLevel3;
    import se.stade.flash.dom.querying.limits.CombinedLimit;
    import se.stade.flash.dom.querying.limits.MatchLimit;
    import se.stade.flash.dom.querying.limits.NoLimit;
    import se.stade.flash.dom.querying.limits.UnmatchedLimit;
    import se.stade.flash.dom.traversals.Ancestors;
    import se.stade.flash.dom.traversals.Children;
    import se.stade.flash.dom.traversals.Descendants;
    import se.stade.flash.dom.traversals.DisplayListTraversal;
    import se.stade.flash.dom.traversals.LinearTraversal;
    import se.stade.flash.dom.traversals.SiblingDirection;
    import se.stade.flash.dom.traversals.Siblings;
    import se.stade.parsing.Language;
    import se.stade.parsing.ParseError;
    import se.stade.stilts.Disposable;
    
    public dynamic class FlashQuery extends ElementProxy implements Disposable
    {
        public static const Empty:FlashQuery = new FlashQuery(null);
        
        public static function from(element:DisplayObject,
                                    ... additionalElements):FlashQuery
        {
            var allElements:Vector.<DisplayObject> = new <DisplayObject>[];
            
            if (element)
                allElements.push(element);
            
            if (additionalElements.length > 0)
                allElements = allElements.concat(
                    Vector.<DisplayObject>(additionalElements)
                );
            
            return new FlashQuery(DisplayNodeFactory.convert(allElements));
        }
        
        public function FlashQuery(elements:Vector.<DisplayNode>,
                                   language:Language = null)
        {
            setContext(this);
            this.language = language;
            matcher = new NodeSelector(elements);
            
            super(elements);
        }
        
        protected var matcher:ElementMatcher;
        
        override public function add(node:DisplayNode):Boolean
        {
            if (matcher.matches(node.element))
            {
                return super.add(node);
            }
            
            return false;
        }
        
        private var _context:FlashQuery;
        
        /**
         * The parent query from which this query originates. If this query
         * doesn't have a parent, this property returns this query instance.
         * 
         * @return The <c>FlashQuery</c> instance from which query originates;
         *         or itself if no parent query exists.
         */
        public function get context():FlashQuery
        {
            return _context;
        }
        
        private function setContext(parent:FlashQuery):void
        {
            _context = parent;
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
        
        private var displayWatcher:DisplayListWatcher;
        
        public function subscribe():void
        {
            if (displayWatcher)
                return;
            
            displayWatcher = new DisplayListWatcher(this);
        }
        
        public function unsubscribe():void
        {
            if (displayWatcher)
            {
                displayWatcher.dispose();
                displayWatcher = null;
            }
        }
        
        override public function get(property:*):*
        {
            if (property is Class)
                return findType(property);
            else if (property in super)
                return super.get(property);
            else if (property is DisplayObject)
                return from(property as DisplayObject);
            else
                return find(String(property));
        }
        
        override public function set(properties:Object):void
        {
            super.set(properties);
            displayWatcher && displayWatcher.set(properties);
        }
        
        override public function addEventListener(type:String,
                                                  listener:Function,
                                                  useCapture:Boolean=false,
                                                  priority:int=0,
                                                  useWeakReference:Boolean=false):void
        {
            super.addEventListener(type, listener,
                                   useCapture,
                                   priority,
                                   useWeakReference);
            
            if (displayWatcher)
            {
                displayWatcher.addEventListener(type,
                                                listener,
                                                useCapture,
                                                priority,
                                                useWeakReference);
            }
        }
        
        override public function removeEventListener(type:String,
                                                     listener:Function,
                                                     useCapture:Boolean=false):void
        {
            super.removeEventListener(type, listener, useCapture);
            
            if (displayWatcher)
            {
                displayWatcher.removeEventListener(type,
                                                   listener,
                                                   useCapture);
            }
        }
        
        protected function parse(expression:String):DisplayListQuery
        {
            var selector:ElementMatcher;
            
            try
            {
                selector = language.parse(expression) as ElementMatcher
            }
            catch (error:ParseError)
            {
                CONFIG::debug
                {
                    trace("[DEBUG::FlashQuery] Parsing '" +
                          expression + "' failed with error:", error.message);
                }
            }
            
            selector ||= InvalidExpressionMatcher.from(expression);
            return new SimpleDisplayQuery(selector);
        }
        
        protected function wrap(query:DisplayListQuery,
                                traversal:DisplayListTraversal,
                                limit:QueryLimit):FlashQuery
        {
            var result:QueryResult = query.find(traversal, limit);
            
            var wrapped:FlashQuery = new FlashQuery(result.matched, language);
            wrapped.matcher = query.matcher;
            wrapped.setContext(this);
            
            return wrapped;
        }
        
        public function join(other:FlashQuery):FlashQuery
        {
            var combined:Vector.<DisplayNode> = nodes.concat(other.nodes);
            var joined:FlashQuery = new FlashQuery(combined, language);
            joined.setContext(this);
            
            return joined;
        }
        
        public function eq(index:int):FlashQuery
        {
            var slice:FlashQuery = new FlashQuery(nodes.slice(index, index + 1));
            slice.setContext(this);
            
            return slice;
        }
        
        public function get first():FlashQuery
        {
            return eq(0);
        }
        
        public function get last():FlashQuery
        {
            return eq(length - 1);
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
        public function find(expression:String, limit:QueryLimit = null):FlashQuery
        {
            return wrap(
                parse(expression),
                Descendants.fromListOf(nodes),
                limit
            );
        }
        
        public function findType(Type:Class, limit:QueryLimit = null):FlashQuery
        {
            return wrap(
                SimpleDisplayQuery.from(new TypeMatcher(Type)),
                Descendants.fromListOf(nodes),
                limit
            );
        }
        
        public function filter(expression:String, limit:QueryLimit = null):FlashQuery
        {
            return wrap(
                parse(expression),
                LinearTraversal.over(NodeList.from(nodes)),
                limit
            );
        }
        
        public function children(expression:String = "*", limit:QueryLimit = null):FlashQuery
        {
            return wrap(
                parse(expression),
                Children.fromListOf(nodes),
                limit
            );
        }
        
        public function parent(expression:String = "*"):FlashQuery
        {
            return ancestors(expression, CombinedLimit.of(
                MatchLimit.of(1),
                UnmatchedLimit.of(1)
            ));
        }
        
        public function ancestors(expression:String = "*", limit:QueryLimit = null):FlashQuery
        {
            return wrap(
                parse(expression),
                Ancestors.fromListOf(nodes),
                limit
            );
        }
        
        public function ancestorsUntil(expression:String):FlashQuery
        {
            return ancestors(expression, UnmatchedLimit.of(1));
        }
        
        public function closest(expression:String):FlashQuery
        {
            return ancestors(expression, MatchLimit.of(1));
        }
        
        public function are(expression:String):Boolean
        {
            return filter(expression).length == length;
        }
        
        public function areAny(expression:String):Boolean
        {
            return filter(expression, MatchLimit.of(1)).length > 0;
        }
        
        public function has(expression:String, limit:QueryLimit = null):FlashQuery
        {
            return wrap(
                parse(expression),
                Descendants.fromListOf(nodes),
                limit
            );
        }
        
        public function siblings(expression:String = "*", limit:QueryLimit = null):FlashQuery
        {
            return wrap(
                parse(expression),
                Siblings.fromListOf(nodes, SiblingDirection.Following),
                limit
            );
        }
        
        public function prev(expression:String = "*", limit:QueryLimit = null):FlashQuery
        {
            return wrap(
                parse(expression),
                Siblings.fromListOf(nodes, SiblingDirection.Preceeding),
                limit
            );
        }
        
        public function prevUntil(expression:String):FlashQuery
        {
            return prev(expression, UnmatchedLimit.of(1));
        }
        
        public function next(expression:String = "*", limit:QueryLimit = null):FlashQuery
        {
            return wrap(
                parse(expression),
                Siblings.fromListOf(nodes, SiblingDirection.Preceeding),
                limit
            );
        }
        
        public function nextUntil(expression:String):FlashQuery
        {
            return next(expression, UnmatchedLimit.of(1));
        }
        
        public function not(expression:String, limit:QueryLimit = null):FlashQuery
        {
            var query:DisplayListQuery = parse(expression);
            
            if (query is SimpleDisplayQuery)
            {
                query = SimpleDisplayQuery.from(
                    InvertMatcher.from(parse(expression).matcher)
                );
            }
            
            return wrap(query, LinearTraversal.fromListOf(nodes), limit);
        }
        
        public function slice(start:int, end:int):FlashQuery
        {
            var pie:FlashQuery = new FlashQuery(nodes.slice(start, end));
            pie.setContext(this);
            
            return pie;
        }
        
        override public function dispose():void
        {
            unsubscribe();
            setContext(this);
            
            super.dispose();
        }
    }
}
