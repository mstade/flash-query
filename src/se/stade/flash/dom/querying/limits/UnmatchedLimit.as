package se.stade.flash.dom.querying.limits
{
    import se.stade.flash.dom.querying.QueryLimit;
    import se.stade.flash.dom.querying.QueryResult;
    
    public class UnmatchedLimit implements QueryLimit
    {
        public static function of(length:uint):UnmatchedLimit
        {
            return new UnmatchedLimit(length);
        }
        
        public function UnmatchedLimit(length:uint)
        {
            this.length = length;
        }
        
        private var length:uint;
        
        public function isReached(result:QueryResult):Boolean
        {
            return result.unmatched.length >= length;
        }
    }
}