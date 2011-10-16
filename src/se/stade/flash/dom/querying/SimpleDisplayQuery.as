package se.stade.flash.dom.querying
{
    import flash.display.DisplayObject;
    
    import se.stade.flash.dom.DisplayNode;
    import se.stade.flash.dom.querying.limits.NoLimit;
    import se.stade.flash.dom.traversals.DisplayListTraversal;

    public class SimpleDisplayQuery implements DisplayListQuery
    {
        public static function from(selector:ElementMatcher):SimpleDisplayQuery
        {
            return new SimpleDisplayQuery(selector);
        }
        
        public function SimpleDisplayQuery(matcher:ElementMatcher)
        {
            _matcher = matcher;
        }
        
        private var _matcher:ElementMatcher;
        public function get matcher():ElementMatcher
        {
            return _matcher;
        }

        public function find(traverser:DisplayListTraversal,
                             limit:QueryLimit = null):QueryResult
        {
            var result:QueryResult = new QueryResult;
            
            if (matcher is InvalidExpressionMatcher)
                return result;
            
            limit ||= NoLimit.Instance;
            
            while (traverser.hasNext && !limit.isReached(result.matched.length,
                                                         result.unmatched.length))
            {
                var node:DisplayNode = traverser.getNext();
                var element:DisplayObject = node.element;
                
                if (element && matcher.matches(element))
                    result.matched.push(node);
                else
                    result.unmatched.push(node);
            }
            
            return result;
        }
    }
}
