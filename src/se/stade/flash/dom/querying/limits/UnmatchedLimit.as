package se.stade.flash.dom.querying.limits
{
    import se.stade.flash.dom.querying.QueryLimit;
    import se.stade.flash.dom.querying.QueryResult;
    
    public class UnmatchedLimit implements QueryLimit
    {
        public static function of(limit:uint):UnmatchedLimit
        {
            return new UnmatchedLimit(limit);
        }
        
        public function UnmatchedLimit(limit:uint)
        {
            this.limit = limit;
        }
        
        private var limit:uint;
        
        public function isReached(result:QueryResult):Boolean
        {
            return result.unmatched.length >= limit;
        }
    }
}