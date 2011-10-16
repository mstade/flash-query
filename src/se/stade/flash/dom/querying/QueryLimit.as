package se.stade.flash.dom.querying
{
    public interface QueryLimit
    {
        function isReached(matched:uint, unmatched:uint):Boolean;
    }
}
