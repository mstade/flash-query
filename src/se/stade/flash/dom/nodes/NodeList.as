package se.stade.flash.dom.nodes
{
    import se.stade.flash.dom.DisplayNode;
    import se.stade.flash.dom.DisplayNodeList;
    
    public class NodeList implements DisplayNodeList
    {
        public static function from(nodes:Vector.<DisplayNode>):NodeList
        {
            return new NodeList(nodes);
        }
        
        public function NodeList(nodes:Vector.<DisplayNode>)
        {
            nodes ||= new Vector.<DisplayNode>;
            this.nodes = nodes;
        }
        
        private var nodes:Vector.<DisplayNode>;
        
        public function get length():uint
        {
            return nodes.length;
        }
        
        public function itemAt(index:int):DisplayNode
        {
            return nodes[index];
        }
        
        public function has(node:DisplayNode):Boolean
        {
            return nodes.indexOf(node) >= 0;
        }
        
        public function indexOf(node:DisplayNode):int
        {
            return nodes.indexOf(node);
        }
        
        public function append(node:DisplayNode):DisplayNode
        {
            nodes.push(node);
            return node;
        }
        
        public function insert(node:DisplayNode, index:int):DisplayNode
        {
            nodes.splice(index, 0, node);
            return node;
        }
        
        public function replace(oldNode:DisplayNode, newNode:DisplayNode):DisplayNode
        {
            var index:int = nodes.indexOf(oldNode);
            
            if (index >= 0)
            {
                nodes[index] = newNode;
                return oldNode;
            }
            
            return null;
        }
        
        public function remove(node:DisplayNode):DisplayNode
        {
            var index:int = nodes.indexOf(node);
            
            if (index >= 0)
            {
                nodes.splice(index, 1);
                return node;
            }
            
            return null;
        }
    }
}
