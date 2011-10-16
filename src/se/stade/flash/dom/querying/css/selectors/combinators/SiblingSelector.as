package se.stade.flash.dom.querying.css.selectors.combinators
{
    import flash.display.DisplayObject;
    
    import se.stade.flash.dom.querying.css.selectors.Selector;
    
    public class SiblingSelector
                 extends CombinatorMatcherBase
                 implements CombinatorMatcher
    {
        public function SiblingSelector(sibling:Selector,
                                        target:Selector,
                                        maxDistance:int)
        {
            super(sibling, target, this);
            this.maxDistance = maxDistance;
        }
        
        protected var maxDistance:int;
        
        public function matches(element:DisplayObject):Boolean
        {
            var start:int = element.parent.getChildIndex(element);
            
            if (right.matches(element))
            {
                var subjectIndex:int = element.parent.getChildIndex(element);
                
                var endIndex:int = subjectIndex + maxDistance;
                endIndex = Math.max(0, Math.min(endIndex, element.parent.numChildren));
                
                var length:int = Math.abs(endIndex - subjectIndex) + 1;
                var direction:int = endIndex < subjectIndex ? -1 : 1;
                
                for (var i:int = 1; i < length; i++)
                {
                    var sibling:DisplayObject = element.parent.getChildAt(start + i * direction);
                    
                    if (left.matches(sibling))
                        return true;
                }
            }
            
            return false;
        }
        
        public function toString():String
        {
            var sign:String = maxDistance ==  1 ? " + " :
                              maxDistance  >  1 ? " ~ " : 
                              maxDistance == -1 ? " <+ " :
                                                  " <~ " ;
            
            return left + sign + right;
        }
    }
}
