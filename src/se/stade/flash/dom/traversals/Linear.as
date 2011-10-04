package se.stade.flash.dom.traversals
{
    import se.stade.flash.dom.DisplayNode;
    import se.stade.flash.dom.DisplayNodeList;
    
    public class Linear implements DisplayListTraversal
    {
        public static function of(nodes:Vector.<DisplayNode>):Linear
        {
            return new Linear(nodes);
        }
        
        public function Linear(nodes:Vector.<DisplayNode>)
        {
            this.nodes = nodes || new Vector.<DisplayNode>;
            reset();
        }
        
        private var nodes:Vector.<DisplayNode>;
        private var current:int;
        
        public function get hasNext():Boolean
        {
            return current < nodes.length - 1;
        }
        
        public function getNext():DisplayNode
        {
            if (hasNext)
                return nodes[++current];
            
            return null;
        }
        
        public function reset():void
        {
            current = -1;
        }
    }
}