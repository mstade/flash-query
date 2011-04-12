package se.stade.flash.dom.query
{
    import flash.display.DisplayObject;
    
    import se.stade.flash.dom.query.css.selectors.InvalidSelector;
    import se.stade.flash.dom.traversals.DisplayListTraversal;

    public class QueryExecutor
    {
        public function QueryExecutor(parser:QueryParser, traverser:DisplayListTraversal)
        {
            this.parser = parser;
            this.traverser = traverser;
        }
        
        private var parser:QueryParser;
        private var traverser:DisplayListTraversal;
        
        public function process(query:String, limit:Number = Number.MAX_VALUE, breakOnUnmatched:Boolean = false):QueryResult
        {
            var selector:DisplayObjectMatcher = parser.interpret(query);
            
            if (!query || selector is InvalidSelector)
                return new QueryResult();
            
            var matches:Array = [];
            var unmatched:Array = [];
            
            while (traverser.hasNext && matches.length < limit)
            {
                var element:DisplayObject = traverser.getNext();
                
                if (selector.matches(element))
                    matches.push(element);
                else if (breakOnUnmatched)
                    break;
                else
                    unmatched.push(element);
            }
            
            return new QueryResult(matches, unmatched);
        }
    }
}