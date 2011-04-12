package se.stade.flash.dom.traversals
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	public class DepthFirstTraversal implements DisplayListTraversal
	{
		public function DepthFirstTraversal(elements:Vector.<DisplayObject>)
		{
			start = elements.slice();
			reset();
		}
		
		protected var start:Vector.<DisplayObject>;
		protected var trail:Vector.<DisplayObject>;
		
		public function get hasNext():Boolean
		{
			return trail.length > 0;
		}
		
		public function getNext():DisplayObject
		{
			var next:DisplayObject = trail.pop();
			var container:DisplayObjectContainer = next as DisplayObjectContainer;
			
			if (container)
			{
				for (var i:int = container.numChildren - 1; i >= 0; i--)
				{
					trail.push(container.getChildAt(i));
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