package se.stade.flash.dom.traversals
{
	import se.stade.flash.dom.DisplayNode;
	import se.stade.flash.dom.DisplayNodeList;
	
	public class DepthFirst implements DisplayListTraversal
	{
        public static function through(nodes:Vector.<DisplayNode>):DepthFirst
        {
            return new DepthFirst(nodes);
        }
        
		public function DepthFirst(nodes:Vector.<DisplayNode>)
		{
			start = nodes.slice();
			reset();
		}
		
		protected var start:Vector.<DisplayNode>;
		protected var trail:Vector.<DisplayNode>;
		
		public function get hasNext():Boolean
		{
			return trail.length > 0;
		}
		
		public function getNext():DisplayNode
		{
			var next:DisplayNode = trail.pop();
            
            if (next)
            {
                for (var i:int = next.children.length - 1; i >= 0; i--)
                {
                    trail.push(next.children.itemAt(i));
                }
            }
			
			return next;
		}
		
		public function reset():void
		{
			trail = start.slice();
		}
	}
}