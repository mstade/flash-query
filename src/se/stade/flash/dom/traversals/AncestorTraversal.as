package se.stade.flash.dom.traversals
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	public class AncestorTraversal extends LinearTraversal implements DisplayListTraversal
	{
		public function AncestorTraversal(startNodes:Vector.<DisplayObject>)
		{
			var ancestors:Vector.<DisplayObject> = new <DisplayObject>[];
			
			for each (var root:DisplayObject in startNodes)
			{
				var ancestor:DisplayObjectContainer = root.parent;
				
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