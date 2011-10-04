package se.stade.flash.dom.traversals
{
	import se.stade.flash.dom.DisplayNode;
	
	public class Siblings implements DisplayListTraversal
	{
        public static function of(nodes:Vector.<DisplayNode>):Siblings
        {
            return new Siblings(nodes);
        }
        
		public function Siblings(nodes:Vector.<DisplayNode>)
		{
			precedingSiblings = new PrecedingSiblings(nodes);
			followingSiblings = new FollowingSiblings(nodes);
		}
		
		protected var precedingSiblings:PrecedingSiblings;
		protected var followingSiblings:FollowingSiblings;
		
		public function getNext():DisplayNode
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