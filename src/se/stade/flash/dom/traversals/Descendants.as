package se.stade.flash.dom.traversals
{
    import se.stade.flash.dom.DisplayNode;
    import se.stade.flash.dom.DisplayNodeList;
    import se.stade.flash.dom.nodes.NodeList;
    
    public class Descendants implements DisplayListTraversal
    {
        public static function of(node:DisplayNode, ... nodes):Descendants
        {
            nodes = [node].concat(nodes);
            return fromListOf(Vector.<DisplayNode>(nodes));
        }
        
        public static function fromListOf(nodes:Vector.<DisplayNode>):Descendants
        {
            var list:DisplayNodeList = new NodeList(nodes);
            return new Descendants(new LinearTraversal(list)); 
        }
        
        public function Descendants(nodes:LinearTraversal)
        {
            start = nodes;
            reset();
        }
        
        private var start:DisplayListTraversal;
        private var trail:Vector.<DisplayListTraversal>;
        
        private function get current():DisplayListTraversal
        {
            return trail.length ? trail[trail.length - 1] : null;
        }
        
        public function get hasNext():Boolean
        {
            while (current)
            {
                if (current.hasNext)
                    return true;
                
                trail.pop();
            }
            
            return false;
        }
        
        public function getNext():DisplayNode
        {
            if (!hasNext)
                return null;
            
            var next:DisplayNode = current.getNext();
            
            if (next)
            {
                trail.push(Children.of(next));
            }
            
            return next;
        }
        
        public function reset():void
        {
            start.reset();
            trail = new <DisplayListTraversal>[start];
        }
    }
}
