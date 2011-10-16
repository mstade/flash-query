package se.stade.flash.dom.traversals
{
    import se.stade.flash.dom.DisplayNode;
    
    public class CompositeTraversal implements DisplayListTraversal
    {
        public static function over(traversals:Vector.<DisplayListTraversal>):DisplayListTraversal
        {
            traversals ||= new Vector.<DisplayListTraversal>;
            return traversals.length == 1 ? traversals[0] : new CompositeTraversal(traversals);
        }
        
        public function CompositeTraversal(traversals:Vector.<DisplayListTraversal>)
        {
            this.traversals = traversals || new Vector.<DisplayListTraversal>;
        }
        
        private var current:int;
        private var traversals:Vector.<DisplayListTraversal>;
        
        public function get hasNext():Boolean
        {
            while (current in traversals)
            {
                if (traversals[current].hasNext)
                    return true;
                
                current++;
            }
            
            return false;
        }
        
        public function getNext():DisplayNode
        {
            return hasNext ? traversals[current].getNext() : null;
        }
        
        public function reset():void
        {
            current = 0;
            
            for each (var traversal:DisplayListTraversal in traversals)
            {
                traversal.reset();
            }
        }
    }
}
