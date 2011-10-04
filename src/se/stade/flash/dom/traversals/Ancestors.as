package se.stade.flash.dom.traversals
{
    import se.stade.flash.dom.DisplayNode;
	
	public class Ancestors extends Linear implements DisplayListTraversal
	{
        public static function of(nodes:Vector.<DisplayNode>):Ancestors
        {
            return new Ancestors(nodes);
        }
        
		public function Ancestors(nodes:Vector.<DisplayNode>)
		{
			var ancestors:Vector.<DisplayNode> = new <DisplayNode>[];
			
			for each (var node:DisplayNode in nodes)
			{
				var ancestor:DisplayNode = node.parent;
				
				while (ancestor)
				{
					ancestors.push(ancestor);
                    ancestor = ancestor.parent;
				}
			}
			
			super(ancestors);
		}
	}
}