package se.stade.flash.dom.querying
{
    import se.stade.flash.dom.DisplayNode;

    public final class QueryResult
    {
        public static const Empty:QueryResult = new QueryResult;
        
        public function QueryResult(matches:Vector.<DisplayNode> = null, unmatched:Vector.<DisplayNode> = null)
        {
            _matches = matches || new Vector.<DisplayNode>;
            _unmatched = unmatched || new Vector.<DisplayNode>;
        }
        
        private var _matches:Vector.<DisplayNode>;
        public function get matches():Vector.<DisplayNode>
        {
            return _matches;
        }
        
        private var _unmatched:Vector.<DisplayNode>;
        public function get unmatched():Vector.<DisplayNode>
        {
            return _unmatched;
        }
    }
}