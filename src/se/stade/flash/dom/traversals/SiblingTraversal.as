package se.stade.flash.dom.traversals
{
	import flash.display.DisplayObject;
	
	public class SiblingTraversal implements DisplayListTraversal
	{
		public function SiblingTraversal(roots:Vector.<DisplayObject>)
		{
			precedingSiblings = new PrecedingSiblingTraversal(roots);
			followingSiblings = new FollowingSiblingTraversal(roots);
		}
		
		protected var precedingSiblings:PrecedingSiblingTraversal;
		protected var followingSiblings:FollowingSiblingTraversal;
		
		public function getNext():DisplayObject
		{
			if (precedingSiblings.hasNext)
				return precedingSiblings.getNext();
			else if (followingSiblings.hasNext)
				return followingSiblings.getNext();
			
			return undefined;
		}

		public function get hasNext():Boolean
		{
			return precedingSiblings.hasNext || followingSiblings.hasNext;
		}

		public function reset():void
		{
			precedingSiblings.reset();
			followingSiblings.reset();
		}
	}
}