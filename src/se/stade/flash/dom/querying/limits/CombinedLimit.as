package se.stade.flash.dom.querying.limits
{
    import se.stade.flash.dom.querying.QueryLimit;
    
    public class CombinedLimit implements QueryLimit
    {
        public static function of(limit:QueryLimit, ... limits):CombinedLimit
        {
            limits = [limit].concat(limits);
            return new CombinedLimit(Vector.<QueryLimit>([limits]));
        }
        
        public function CombinedLimit(limits:Vector.<QueryLimit>)
        {
            this.limits = limits.slice();
        }
        
        private var limits:Vector.<QueryLimit>
        
        public function isReached(matched:uint, unmatched:uint):Boolean
        {
            for each (var limit:QueryLimit in limits)
            {
                if (limit.isReached(matched, unmatched))
                    return true;
            }
            
            return false;
        }
    }
}
