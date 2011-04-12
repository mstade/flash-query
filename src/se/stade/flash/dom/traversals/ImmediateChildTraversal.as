package se.stade.flash.dom.traversals
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	public class ImmediateChildTraversal extends LinearTraversal implements DisplayListTraversal
	{
		public function ImmediateChildTraversal(roots:Vector.<DisplayObjectContainer>)
		{
			var immediateChildren:Vector.<DisplayObject> = new <DisplayObject>[];
			
			for each (var root:DisplayObjectContainer in roots)
			{
				for (var i:int = 0; i < root.numChildren; i++)
				{
					immediateChildren.push(root.getChildAt(i));
				}
			}
			
			super(immediateChildren);
		}
	}
}