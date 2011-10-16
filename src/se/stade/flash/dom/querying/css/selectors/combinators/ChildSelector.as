package se.stade.flash.dom.querying.css.selectors.combinators
{
    import flash.display.DisplayObject;
    
    import se.stade.flash.dom.querying.css.selectors.Selector;
    
    public class ChildSelector
                 extends CombinatorMatcherBase
                 implements CombinatorMatcher
    {
        public function ChildSelector(parent:Selector, child:Selector)
        {
            super(parent, child, this);
        }
        
        public function matches(element:DisplayObject):Boolean
        {
            return right.matches(element) && left.matches(element.parent);
        }
        
        public function toString():String
        {
            return left + " > " + right;
        }
    }
}
