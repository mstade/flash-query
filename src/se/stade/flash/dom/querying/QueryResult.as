package se.stade.flash.dom.querying
{
    import se.stade.flash.dom.DisplayNode;

    public final class QueryResult
    {
        public function QueryResult(matched:Vector.<DisplayNode> = null,
                                    unmatched:Vector.<DisplayNode> = null)
        {
            _matched = matched || new Vector.<DisplayNode>;
            _unmatched = unmatched || new Vector.<DisplayNode>;
        }
        
        private var _matched:Vector.<DisplayNode>;
        public function get matched():Vector.<DisplayNode>
        {
            return _matched;
        }
        
        private var _unmatched:Vector.<DisplayNode>;
        public function get unmatched():Vector.<DisplayNode>
        {
            return _unmatched;
        }
    }
}
