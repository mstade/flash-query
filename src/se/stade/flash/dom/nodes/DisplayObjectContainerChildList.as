package se.stade.flash.dom.nodes
{
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    
    import se.stade.flash.dom.DisplayNode;
    import se.stade.flash.dom.DisplayNodeList;
    
    internal final class DisplayObjectContainerChildList implements DisplayNodeList
    {
        public function DisplayObjectContainerChildList(container:DisplayObjectContainer)
        {
            this.container = container;
        }
        
        private var container:DisplayObjectContainer;
        
        public function get length():uint
        {
            return container.numChildren;
        }
        
        public function itemAt(index:int):DisplayNode
        {
            if (index < 0 || index > length - 1)
                return null;
            
            return DisplayNodeFactory.from(container.getChildAt(index));
        }
        
        public function has(node:DisplayNode):Boolean
        {
            return indexOf(node) != -1;
        }
        
        public function indexOf(node:DisplayNode):int
        {
            return container.getChildIndex(node.element as DisplayObject);
        }
        
        public function append(node:DisplayNode):DisplayNode
        {
            return insert(node, length);
        }
        
        public function insert(node:DisplayNode, index:int):DisplayNode
        {
            container.addChildAt(node.element as DisplayObject, index);
            return node;
        }
        
        public function replace(oldNode:DisplayNode, newNode:DisplayNode):DisplayNode
        {
            var oldIndex:int = oldNode.index;
            
            container.removeChildAt(oldIndex);
            container.addChildAt(newNode.element as DisplayObject, oldIndex);
            
            return oldNode;
        }
        
        public function remove(node:DisplayNode):DisplayNode
        {
            container.removeChild(node.element as DisplayObject);
            return node;
        }
    }
}
