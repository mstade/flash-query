package se.stade.flash.dom.querying
{
    import flash.display.DisplayObject;

    /**
     * A matcher acts as a predicate to determine wether
     * the given element mathes it or not.
     */
    public interface ElementMatcher
    {
        function matches(element:DisplayObject):Boolean;
    }
}
