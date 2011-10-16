package se.stade.flash.dom.nodes
{
    import se.stade.flash.dom.DisplayNode;
    import se.stade.flash.dom.DisplayNodeList;
    
    public class VisualElementContainerChildList implements DisplayNodeList
    {
        public function VisualElementContainerChildList(container:Object)
        {
            this.container = container;
        }
        
        private var container:Object;
        
        public function get length():uint
        {
            return container.numElements;
        }
        
        public function itemAt(index:int):DisplayNode
        {
            if (index < 0 || index > length - 1)
                return null;
            
            return DisplayNodeFactory.from(container.getElementAt(index));
        }
        
        public function has(node:DisplayNode):Boolean
        {
            return indexOf(node) != -1;
        }
        
        public function indexOf(node:DisplayNode):int
        {
            return container.getElementIndex(node.element);
        }
        
        public function append(node:DisplayNode):DisplayNode
        {
            return insert(node, length);
        }
        
        public function insert(node:DisplayNode, index:int):DisplayNode
        {
            container.addElementAt(node.element, index);
            return node;
        }
        
        public function replace(oldNode:DisplayNode, newNode:DisplayNode):DisplayNode
        {
            var oldIndex:int = oldNode.index;
            
            container.removeElementAt(oldIndex);
            container.addElementAt(newNode.element, oldIndex);
            
            return oldNode;
        }
        
        public function remove(node:DisplayNode):DisplayNode
        {
            container.removeElement(node.element);
            return node;
        }
    }
}
