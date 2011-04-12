package se.stade.flash.dom.traversals
{
	import flash.display.DisplayObject;
	
	public class PrecedingSiblingTraversal extends LinearTraversal
	{
		public function PrecedingSiblingTraversal(roots:Vector.<DisplayObject>)
		{
			var siblings:Vector.<DisplayObject> = new <DisplayObject>[];
			
			for each (var root:DisplayObject in roots)
			{
				if (root.parent)
				{
					var rootIndex:int = root.parent.getChildIndex(root);
					
					for (var i:int = 0; i < root.parent.numChildren; i++)
					{
						if (i == rootIndex)
							break;
						
						siblings.push(root.parent.getChildAt(i));
					}
				}
			}
			
			super(siblings);
		}
	}
}