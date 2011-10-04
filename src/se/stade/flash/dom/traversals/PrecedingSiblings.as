package se.stade.flash.dom.traversals
{
	import se.stade.flash.dom.DisplayNode;
	
	public class PrecedingSiblings extends Linear
	{
        public static function of(nodes:Vector.<DisplayNode>):PrecedingSiblings
        {
            return new PrecedingSiblings(nodes);
        }
        
		public function PrecedingSiblings(nodes:Vector.<DisplayNode>)
		{
			var siblings:Vector.<DisplayNode> = new <DisplayNode>[];
			
			for each (var node:DisplayNode in nodes)
			{
                var parent:DisplayNode = node.parent;
                
				for (var i:int = 0; i < parent.children.length; i++)
				{
					if (i == node.index)
						break;
					
					siblings.push(parent.children.itemAt(i));
				}
			}
			
			super(siblings);
		}
	}
}