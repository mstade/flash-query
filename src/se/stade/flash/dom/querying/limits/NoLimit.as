package se.stade.flash.dom.querying.limits
{
    import se.stade.flash.dom.querying.QueryLimit;
    
    public final class NoLimit implements QueryLimit
    {
        public static const Instance:NoLimit = new NoLimit;
        
        public function isReached(matched:uint, unmatched:uint):Boolean
        {
            return false;
        }
    }
}
