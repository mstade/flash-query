package se.stade.flash.dom.querying.css.selectors.combinators
{
    import se.stade.flash.dom.querying.css.selectors.Selector;

    public interface CombinatorMatcher extends Selector
    {
        function get left():Selector;
        function get right():Selector;
    }
}
