package se.stade.flash.dom.querying.limits
{
    import se.stade.flash.dom.querying.QueryLimit;
    import se.stade.flash.dom.querying.QueryResult;
    
    public final class NoLimit implements QueryLimit
    {
        public static const Instance:NoLimit = new NoLimit;
        
        public function isReached(result:QueryResult):Boolean
        {
            return false;
        }
    }
}