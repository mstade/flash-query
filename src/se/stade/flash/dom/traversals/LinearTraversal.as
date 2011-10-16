package se.stade.flash.dom.traversals
{
    import se.stade.flash.dom.DisplayNode;
    import se.stade.flash.dom.DisplayNodeList;
    import se.stade.flash.dom.nodes.NodeList;
    
    public class LinearTraversal implements DisplayListTraversal
    {
        public static function over(list:DisplayNodeList, ... lists):DisplayListTraversal
        {
            lists = [list].concat(lists);
            
            var traversals:Vector.<DisplayListTraversal> = new <DisplayListTraversal>[];
            
            for each (var list:DisplayNodeList in lists)
            {
                traversals.push(new LinearTraversal(list));
            }
            
            return CompositeTraversal.over(traversals);
        }
        
        public static function fromListOf(nodes:Vector.<DisplayNode>):LinearTraversal
        {
            return new LinearTraversal(NodeList.from(nodes));
        }
        
        public function LinearTraversal(nodes:DisplayNodeList)
        {
            this.nodes = nodes;
            reset();
        }
        
        private var current:int;
        private var nodes:DisplayNodeList;
        
        public function get hasNext():Boolean
        {
            return 0 <= current + 1 && current + 1 < nodes.length;
        }
        
        public function getNext():DisplayNode
        {
            return hasNext ? nodes.itemAt(++current) : null;
        }
        
        public function reset():void
        {
            current = -1;
        }
    }
}
