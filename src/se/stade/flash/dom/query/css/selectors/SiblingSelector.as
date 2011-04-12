package se.stade.flash.dom.query.css.selectors
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import se.stade.flash.dom.query.DisplayObjectMatcher;
	
	public class SiblingSelector extends CombinatorMatcherBase implements CombinatorMatcher
	{
		public function SiblingSelector(sibling:DisplayObjectMatcher, target:DisplayObjectMatcher, maxDistance:uint = uint.MAX_VALUE)
		{
			super(sibling, target, this);
			this.maxDistance = Math.max(1, maxDistance);
		}
		
		protected var maxDistance:uint;
		
		public function matches(element:DisplayObject):Boolean
		{
			var start:int = element.parent.getChildIndex(element);
			
			if (start > 0 && left.matches(element))
			{
				for (var i:int = 0; i < maxDistance && start >= 0; i++, start--)
				{
					var sibling:DisplayObject = element.parent.getChildAt(i);
					if (right.matches(sibling))
						return true;
				}
			}
			
			return false;
		}
		
		public function toString():String
		{
			var sign:String = (maxDistance > 1) ? " ~ " : " + ";
			return left + sign + right;
		}
	}
}