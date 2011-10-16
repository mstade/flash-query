package se.stade.flash.dom.querying
{
    import flash.display.DisplayObject;
    
    import se.stade.flash.dom.DisplayNode;
    
    public class NodeSelector implements ElementMatcher
    {
        public static function from(node:DisplayNode, ... nodes):NodeSelector
        {
            nodes = [node].concat(nodes);
            return new NodeSelector(Vector.<DisplayNode>(nodes));
        }
        
        public function NodeSelector(nodes:Vector.<DisplayNode>)
        {
            this.nodes = nodes;
        }
        
        private var nodes:Vector.<DisplayNode>;
        
        public function matches(element:DisplayObject):Boolean
        {
            for each (var node:DisplayNode in nodes)
            {
                if (node.element == element)
                    return true;
            }
            
            return false;
        }
    }
}
