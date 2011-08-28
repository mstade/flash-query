package se.stade.flash.dom.querying.limits
{
    import se.stade.flash.dom.querying.QueryLimit;
    import se.stade.flash.dom.querying.QueryResult;
    
    public class LimitGroup implements QueryLimit
    {
        public static function of(limit:QueryLimit, ... limits):LimitGroup
        {
            limits = [limit].concat(limits);
            return new LimitGroup(Vector.<QueryLimit>([limits]));
        }
        
        public function LimitGroup(limits:Vector.<QueryLimit>)
        {
            this.limits = limits.slice();
        }
        
        private var limits:Vector.<QueryLimit>
        
        public function isReached(result:QueryResult):Boolean
        {
            for each (var limit:QueryLimit in limits)
            {
                if (limit.isReached(result))
                    return true;
            }
            
            return false;
        }
    }
}