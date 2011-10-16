package se.stade.flash.dom.querying.limits
{
    import se.stade.flash.dom.querying.QueryLimit;
    
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
        
        public function isReached(matched:uint, unmatched:uint):Boolean
        {
            return matched >= length;
        }
    }
}
