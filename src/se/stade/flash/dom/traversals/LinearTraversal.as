package se.stade.flash.dom.traversals
{
	import flash.display.DisplayObject;
	
	public class LinearTraversal implements DisplayListTraversal
	{
		public function LinearTraversal(elements:Vector.<DisplayObject>)
		{
			this.elements = elements;
			reset();
		}
		
		private var elements:Vector.<DisplayObject>;
		private var current:int;
		
		public function get hasNext():Boolean
		{
			return elements.length
				   && current < elements.length - 1;
		}
		
		public function getNext():DisplayObject
		{
			if (hasNext)
				return elements[++current];
			
			return null;
		}
		
		public function reset():void
		{
			current = -1;
		}
	}
}