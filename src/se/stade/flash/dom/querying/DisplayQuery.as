package se.stade.flash.dom.querying
{
	import flash.display.DisplayObject;
	
	import se.stade.flash.dom.querying.limits.NoLimit;
	import se.stade.flash.dom.traversals.DisplayListTraversal;

    public class DisplayQuery
    {
        public function DisplayQuery(selector:ElementMatcher)
        {
            _selector = selector;
        }
        
        private var _selector:ElementMatcher;
        public function get selector():ElementMatcher
        {
            return _selector;
        }
        
        public function execute(traverser:DisplayListTraversal, limit:QueryLimit = null):QueryResult
        {
            limit ||= NoLimit.Instance;
            
            var result:QueryResult = new QueryResult;
            
            while (traverser.hasNext && !limit.isReached(result))
            {
                var element:DisplayObject = traverser.getNext();
                
                if (selector.matches(element))
                    result.matches.push(element);
                else
                    result.unmatched.push(element);
            }
            
            return result;
        }
    }
}