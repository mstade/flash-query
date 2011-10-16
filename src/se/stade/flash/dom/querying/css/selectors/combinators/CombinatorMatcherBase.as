package se.stade.flash.dom.querying.css.selectors.combinators
{
    import se.stade.flash.dom.querying.ElementMatcher;
    import se.stade.flash.dom.querying.css.selectors.Selector;
    import se.stade.stilts.errors.AbstractTypeError;

    internal class CombinatorMatcherBase
    {
        public function CombinatorMatcherBase(left:Selector, right:Selector, self:CombinatorMatcherBase)
        {
            if (self != this)
                throw new AbstractTypeError();
            
            _left = left;
            _right = right;
        }
        
        private var _left:Selector;
        public function get left():Selector
        {
            return _left;
        }
        
        private var _right:Selector;
        public function get right():Selector
        {
            return _right;
        }
    }
}
