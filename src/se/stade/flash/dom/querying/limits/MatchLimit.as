package se.stade.flash.dom.querying.limits
{
    import se.stade.flash.dom.querying.QueryLimit;
    import se.stade.flash.dom.querying.QueryResult;
    
    public final class MatchLimit implements QueryLimit
    {
        public static function of(limit:uint):MatchLimit
        {
            return new MatchLimit(limit);
        }
        
        public function MatchLimit(limit:uint)
        {
            this.limit = limit;
        }
        
        private var limit:uint;
        
        public function isReached(result:QueryResult):Boolean
        {
            return result.matches.length >= limit;
        }
    }
}