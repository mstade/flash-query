package se.stade.flash.dom
{
    import flash.display.*;
    
    import se.stade.colligo.*;
    import se.stade.flash.dom.events.*;
    import se.stade.flash.dom.nodes.*;
    import se.stade.flash.dom.querying.*;
    import se.stade.flash.dom.querying.css.parsing.*;
    import se.stade.flash.dom.querying.css.selectors.*;
    import se.stade.flash.dom.querying.css.selectors.type.*;
    import se.stade.flash.dom.querying.limits.*;
    import se.stade.flash.dom.traversals.*;
    import se.stade.parsing.*;
    import se.stade.stilts.*;
    
    public dynamic class FlashQuery extends ElementProxy implements Disposable
    {
        public static const Empty:FlashQuery = new FlashQuery(null);
        
        public static function from(element:DisplayObject, ... additionalElements):FlashQuery
        {
            var allElements:Vector.<DisplayObject> = new <DisplayObject>[];
            
            if (element)
                allElements.push(element);
            
            if (additionalElements.length > 0)
                allElements = allElements.concat(Vector.<DisplayObject>(additionalElements));
            
            return new FlashQuery(DisplayNodeFactory.convert(allElements));
        }
        
        public function FlashQuery(elements:Vector.<DisplayNode>, language:Language = null)
        {
            super(elements || new Vector.<DisplayNode>);
            
            _context = this;
            this.language = language;
            this.query = new ValidDisplayQuery(UniversalSelector.Instance);
        }
        
        protected var query:ValidDisplayQuery;
        
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
        
        private var displayWatcher:DisplayListWatcher;
        
        public function get live():Boolean
        {
            return !!displayWatcher;
        }
        
        public function set live(value:Boolean):void
        {
            if (value != live)
            {
                live && displayWatcher.dispose();
                displayWatcher = value ? new DisplayListWatcher(query, context, nodes) : null;
            }
        }
        
        protected var liveProperties:Object = {};
        
        override public function get(property:*):*
        {
            if (property is Class)
                return findType(property);
            else if (property in super)
                return super.get(property);
            else
                return find(String(property));
        }
        
        override public function set(properties:Object):void
        {
            super.set(properties);
            
            for each (var name:String in properties)
            {
                this.liveProperties[name] = properties[name];
            }
        }
        
        override public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
        {
            super.addEventListener(type, listener, useCapture, priority, useWeakReference);
            
            if (live)
            {
                displayWatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
            }
        }
        
        override public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
        {
            super.removeEventListener(type, listener, useCapture);
            
            if (live)
            {
                displayWatcher.removeEventListener(type, listener, useCapture);
            }
        }
        
        protected function parse(expression:String):ValidDisplayQuery
        {
            try
            {
                var selector:ElementMatcher = language.parse(expression) as ElementMatcher || new InvalidSelector(expression);
            }
            catch (error:ParseError)
            {
                CONFIG::debug
                {
                    trace("[DEBUG::FlashQuery] Parsing '" + expression + "' failed with error:", error.message);
                }
                
                selector = new InvalidSelector(expression);
            }
            
            return new ValidDisplayQuery(selector);
        }
        
        protected function wrap(elements:Vector.<DisplayNode>):FlashQuery
        {
            var result:FlashQuery = new FlashQuery(elements, language);
            result._context = this;
            result.query = query;
            
            return result;
        }
        
        public function join(other:FlashQuery):FlashQuery
        {
            var result:FlashQuery = wrap(nodes.concat(other.nodes));
            result.query = ValidDisplayQuery.from(
                SelectorGroup.from(
                    query.selector,
                    other.query.selector
                )
            );
            
            return result;
        }
        
        public function eq(index:int):FlashQuery
        {
            return wrap(nodes.slice(index, index + 1));
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
                parse(expression)
                .find(Descendants.of(nodes), limit)
                .matches
            );
        }
        
        public function findType(Type:Class, limit:QueryLimit = null):FlashQuery
        {
            return wrap(
                ValidDisplayQuery.from(new ElementTypeSelector(Type))
                .find(Descendants.of(nodes), limit)
                .matches
            );
        }
        
        public function filter(expression:String, limit:QueryLimit = null):FlashQuery
        {
            return wrap(
                parse(expression)
                .find(Linear.of(nodes), limit)
                .matches
            );
        }
        
        public function children(expression:String = "*", limit:QueryLimit = null):FlashQuery
        {
            return wrap(
                parse(expression)
                .find(Children.of(nodes), limit)
                .matches
            );
        }
        
        public function parent(expression:String = "*"):FlashQuery
        {
            return ancestors(expression, MatchLimit.of(1));
        }
        
        public function ancestors(expression:String = "*", limit:QueryLimit = null):FlashQuery
        {
            return wrap(
                parse(expression)
                .find(Ancestors.of(nodes), limit)
                .matches
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
                parse(expression)
                .find(Descendants.of(nodes), limit)
                .matches
            );
        }
        
        public function siblings(expression:String = "*", limit:QueryLimit = null):FlashQuery
        {
            return wrap(
                parse(expression)
                .find(Siblings.of(nodes), limit)
                .matches
            );
        }
        
        public function prev(expression:String = "*", limit:QueryLimit = null):FlashQuery
        {
            return wrap(
                parse(expression)
                .find(PrecedingSiblings.of(nodes), limit)
                .matches
            );
        }
        
        public function prevUntil(expression:String):FlashQuery
        {
            return prev(expression, UnmatchedLimit.of(1));
        }
        
        public function next(expression:String = "*", limit:QueryLimit = null):FlashQuery
        {
            return wrap(
                parse(expression)
                .find(FollowingSiblings.of(nodes), limit)
                .matches
            );
        }
        
        public function nextUntil(expression:String):FlashQuery
        {
            return next(expression, UnmatchedLimit.of(1));
        }
        
        public function not(expression:String, limit:QueryLimit = null):FlashQuery
        {
            return wrap(
                parse(expression)
                .find(Linear.of(nodes), limit)
                .unmatched
            );
        }
        
        public function slice(start:int, end:int):FlashQuery
        {
            return wrap(nodes.slice(start, end));
        }
        
        public function dispose():void
        {
            live = false;
            nodes = new <DisplayNode>[];
            _context = this;
        }
    }
}