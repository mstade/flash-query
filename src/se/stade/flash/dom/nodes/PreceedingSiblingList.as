package se.stade.flash.dom.nodes
{
    import se.stade.flash.dom.DisplayNode;
    import se.stade.flash.dom.DisplayNodeList;
    
    internal final class PreceedingSiblingList implements DisplayNodeList
    {
        public function PreceedingSiblingList(reference:DisplayNode)
        {
            this.reference = reference;
        }
        
        private var reference:DisplayNode;
        
        private function get children():DisplayNodeList
        {
            return reference.parent.children;
        }
        
        public function get length():uint
        {
            return reference.index;
        }
        
        public function itemAt(index:int):DisplayNode
        {
            if (index > -1 && index < length - 1)
                return children.itemAt(length - index - 1);
            else
                return null;
        }
        
        public function has(node:DisplayNode):Boolean
        {
            return children.has(node) && children.indexOf(node) < length;
        }
        
        public function indexOf(node:DisplayNode):int
        {
            var index:int = children.indexOf(node);
            
            if (index > -1 && index < length)
                return index - length + 1;
            else
                return -1;
        }
        
        public function append(node:DisplayNode):DisplayNode
        {
            return children.insert(node, 0);
        }
        
        public function insert(node:DisplayNode, index:int):DisplayNode
        {
            if (index > -1 && index < length)
                return children.insert(node, length - index - 1);
            
            return null;
        }
        
        public function replace(oldNode:DisplayNode, newNode:DisplayNode):DisplayNode
        {
            return has(oldNode) ? children.replace(oldNode, newNode) : null;
        }
        
        public function remove(node:DisplayNode):DisplayNode
        {
            return has(node) ? children.remove(node) : null;
        }
    }
}