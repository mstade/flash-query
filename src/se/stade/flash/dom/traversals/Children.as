package se.stade.flash.dom.traversals
{
    import se.stade.flash.dom.DisplayNode;
    
    public class Children extends LinearTraversal implements DisplayListTraversal
    {
        public static function of(parent:DisplayNode, ... parents):DisplayListTraversal
        {
            parents = [parent].concat(parents);
            return fromListOf(Vector.<DisplayNode>(parents));
        }
        
        public static function fromListOf(parents:Vector.<DisplayNode>):DisplayListTraversal
        {
            var children:Vector.<DisplayListTraversal> = new <DisplayListTraversal>[];
            
            for each (var parent:DisplayNode in parents)
            {
                children.push(new Children(parent));
            }
            
            return CompositeTraversal.over(children);
        }
        
        public function Children(parent:DisplayNode)
        {
            super(parent.children);
        }
    }
}
