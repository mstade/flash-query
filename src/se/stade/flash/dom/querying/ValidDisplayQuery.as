package se.stade.flash.dom.querying
{
	import flash.display.DisplayObject;
	
	import se.stade.flash.dom.DisplayNode;
	import se.stade.flash.dom.querying.limits.NoLimit;
	import se.stade.flash.dom.traversals.DisplayListTraversal;

    public class ValidDisplayQuery implements DisplayListQuery
    {
        public static function from(selector:ElementMatcher):ValidDisplayQuery
        {
            return new ValidDisplayQuery(selector);
        }
        
        public function ValidDisplayQuery(selector:ElementMatcher)
        {
            _selector = selector;
        }
        
        private var _selector:ElementMatcher;
        public function get selector():ElementMatcher
        {
            return _selector;
        }

        public function find(traverser:DisplayListTraversal, limit:QueryLimit = null):QueryResult
        {
            limit ||= NoLimit.Instance;
            var result:QueryResult = new QueryResult;
            
            while (traverser.hasNext && !limit.isReached(result))
            {
                var node:DisplayNode = traverser.getNext();
                
                if (matches(node))
                    result.matches.push(node);
                else
                    result.unmatched.push(node);
            }
            
            return result;
        }
        
        public function matches(node:DisplayNode):Boolean
        {
            return node.element is DisplayObject && selector.matches(DisplayObject(node.element));
        }
    }
}