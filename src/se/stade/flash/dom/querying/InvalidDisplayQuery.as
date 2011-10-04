package se.stade.flash.dom.querying
{
    import se.stade.flash.dom.DisplayNode;
    import se.stade.flash.dom.querying.css.selectors.InvalidSelector;
    import se.stade.flash.dom.traversals.DisplayListTraversal;
    
    public class InvalidDisplayQuery implements DisplayListQuery
    {
        public function InvalidDisplayQuery(selector:InvalidSelector)
        {
            _selector = selector;
        }
        
        private var _selector:ElementMatcher;
        public function get selector():ElementMatcher
        {
            return _selector;
        }
        
        public function find(traversal:DisplayListTraversal, limit:QueryLimit=null):QueryResult
        {
            return QueryResult.Empty;
        }
    }
}