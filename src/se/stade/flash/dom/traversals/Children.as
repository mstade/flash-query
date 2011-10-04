package se.stade.flash.dom.traversals
{
    import se.stade.flash.dom.DisplayNode;
	
	public class Children extends Linear implements DisplayListTraversal
	{
        public static function of(parents:Vector.<DisplayNode>):Children
        {
            return new Children(parents);
        }
        
		public function Children(parents:Vector.<DisplayNode>)
		{
			var children:Vector.<DisplayNode> = new <DisplayNode>[];
			
			for each (var parent:DisplayNode in parents)
			{
				for (var i:int = 0; i < parent.children.length; i++)
				{
                    children.push(parent.children.itemAt(i));
				}
			}
			
			super(children);
		}
	}
}