package se.stade.flash.dom.querying.css.selectors.combinators
{
    import se.stade.flash.dom.querying.ElementMatcher;
    import se.stade.parsing.Expression;

    public interface CombinatorMatcher extends ElementMatcher, Expression
    {
        function get left():ElementMatcher;
        function get right():ElementMatcher;
    }
}