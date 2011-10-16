package se.stade.flash.dom.traversals
{
    import se.stade.flash.dom.DisplayNode;
    
    public class Ancestors implements DisplayListTraversal
    {
        public static function of(node:DisplayNode, ...nodes):DisplayListTraversal
        {
            if (nodes.length)
            {
                nodes = [node].concat(nodes);
                return fromListOf(Vector.<DisplayNode>(nodes));
            }
            
            return Ancestors(node);
        }
        
        public static function fromListOf(nodes:Vector.<DisplayNode>):DisplayListTraversal
        {
            var traversals:Vector.<DisplayListTraversal> = new <DisplayListTraversal>[];
            
            for each (var node:DisplayNode in nodes)
            {
                traversals.push(new Ancestors(node));
            }
            
            return CompositeTraversal.over(traversals);
        }
        
        public function Ancestors(node:DisplayNode)
        {
            this.node = node;
            reset();
        }
        
        private var node:DisplayNode;
        private var current:DisplayNode;
        
        public function getNext():DisplayNode
        {
            if (hasNext)
                current = current.parent;
            
            return current;
        }
        
        public function get hasNext():Boolean
        {
            return !!current.parent;
        }
        
        public function reset():void
        {
            current = node;
        }
    }
}
