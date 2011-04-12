package se.stade.flash.dom.traversals
{
	import flash.display.DisplayObject;
	
	public class FollowingSiblingTraversal extends LinearTraversal
	{
		public function FollowingSiblingTraversal(roots:Vector.<DisplayObject>)
		{
			var siblings:Vector.<DisplayObject> = new <DisplayObject>[];
			
			for each (var root:DisplayObject in roots)
			{
				if (root.parent)
				{
					var firstSibling:int = root.parent.getChildIndex(root) + 1;
					
					for (var i:int = firstSibling; i < root.parent.numChildren; i++)
					{
						siblings.push(root.parent.getChildAt(i));
					}
				}
			}
			
			super(siblings);
		}
	}
}