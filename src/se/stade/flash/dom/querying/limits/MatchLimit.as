package se.stade.flash.dom.querying.limits
{
    import se.stade.flash.dom.querying.QueryLimit;
    import se.stade.flash.dom.querying.QueryResult;
    
    public final class MatchLimit implements QueryLimit
    {
        public static function of(length:uint):MatchLimit
        {
            return new MatchLimit(length);
        }
        
        public function MatchLimit(length:uint)
        {
            this.length = length;
        }
        
        private var length:uint;
        
        public function isReached(result:QueryResult):Boolean
        {
            return result.matches.length >= length;
        }
    }
}