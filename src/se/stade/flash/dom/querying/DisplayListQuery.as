package se.stade.flash.dom.querying
{
    import se.stade.flash.dom.traversals.DisplayListTraversal;

    public interface DisplayListQuery
    {
        function get matcher():ElementMatcher;
        
        function find(traversal:DisplayListTraversal,
                      limit:QueryLimit = null):QueryResult;
    }
}
