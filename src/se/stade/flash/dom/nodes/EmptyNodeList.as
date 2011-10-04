package se.stade.flash.dom.nodes
{
    import se.stade.flash.dom.DisplayNode;
    import se.stade.flash.dom.DisplayNodeList;
    
    internal final class EmptyNodeList implements DisplayNodeList
    {
        public static const Instance:EmptyNodeList = new EmptyNodeList;
        
        public function get length():uint
        {
            return 0;
        }
        
        public function itemAt(index:int):DisplayNode
        {
            return null;
        }
        
        public function has(node:DisplayNode):Boolean
        {
            return false;
        }
        
        public function indexOf(node:DisplayNode):int
        {
            return -1;
        }
        
        public function append(node:DisplayNode):DisplayNode
        {
            return null;
        }
        
        public function insert(node:DisplayNode, index:int):DisplayNode
        {
            return null;
        }
        
        public function replace(oldNode:DisplayNode, newNode:DisplayNode):DisplayNode
        {
            return null;
        }
        
        public function remove(node:DisplayNode):DisplayNode
        {
            return null;
        }
    }
}