package se.stade.flash.dom.traversals
{
    import se.stade.flash.dom.DisplayNode;
    
    public class Siblings implements DisplayListTraversal
    {
        public static function of(direction:uint, node:DisplayNode, ... nodes):DisplayListTraversal
        {
            if (nodes.length)
            {
                nodes = [node].concat(nodes);
                return fromListOf(Vector.<DisplayNode>(nodes), direction);
            }
            
            return new Siblings(node, direction); 
        }
        
        public static function fromListOf(nodes:Vector.<DisplayNode>, direction:uint):DisplayListTraversal
        {
            var siblings:Vector.<DisplayListTraversal> = new <DisplayListTraversal>[];
            
            for each (var node:DisplayNode in nodes)
            {
                siblings.push(new Siblings(node, direction));
            }
            
            return CompositeTraversal.over(siblings);
        }
        
        public function Siblings(node:DisplayNode, direction:uint)
        {
            if (direction == SiblingDirection.Following)
                traverser = LinearTraversal.over(node.nextSiblings);
            else if (direction == SiblingDirection.Preceeding)
                traverser = LinearTraversal.over(node.prevSiblings);
            else
                traverser = LinearTraversal.over(node.prevSiblings, node.nextSiblings);
        }
        
        private var traverser:DisplayListTraversal;
        
        public function getNext():DisplayNode
        {
            return traverser.getNext();
        }
        
        public function get hasNext():Boolean
        {
            return traverser.hasNext;
        }
        
        public function reset():void
        {
            traverser.reset();
        }
    }
}
