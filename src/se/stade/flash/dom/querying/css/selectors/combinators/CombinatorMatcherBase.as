package se.stade.flash.dom.querying.css.selectors.combinators
{
    import se.stade.stilts.errors.AbstractTypeError;
    import se.stade.flash.dom.querying.ElementMatcher;

    internal class CombinatorMatcherBase
    {
        public function CombinatorMatcherBase(left:ElementMatcher, right:ElementMatcher, self:CombinatorMatcherBase)
        {
            if (self != this)
                throw new AbstractTypeError();
            
            _left = left;
            _right = right;
        }
        
        private var _left:ElementMatcher;
        public function get left():ElementMatcher
        {
            return _left;
        }
        
        private var _right:ElementMatcher;
        public function get right():ElementMatcher
        {
            return _right;
        }
    }
}