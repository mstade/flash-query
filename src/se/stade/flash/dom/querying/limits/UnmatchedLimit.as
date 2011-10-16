package se.stade.flash.dom.querying.limits
{
    import se.stade.flash.dom.querying.QueryLimit;
    
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
        
        public function isReached(matched:uint, unmatched:uint):Boolean
        {
            return unmatched >= length;
        }
    }
}
