package se.stade.flash.dom.querying
{
    public interface QueryLimit
    {
        function isReached(result:QueryResult):Boolean;
    }
}