package se.stade.flash.dom.querying.css.selectors.combinators
{
    import flash.display.DisplayObject;
    
    import se.stade.flash.dom.querying.ElementMatcher;
    
    public class ChildSelector extends CombinatorMatcherBase implements CombinatorMatcher
    {
        public function ChildSelector(parent:ElementMatcher, child:ElementMatcher)
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