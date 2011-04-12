package se.stade.flash.dom.query.css.selectors
{
	import flash.display.DisplayObject;
	import se.stade.flash.dom.query.DisplayObjectMatcher;

	public class GroupSelector extends CombinatorMatcherBase implements CombinatorMatcher
	{
		public function GroupSelector(left:DisplayObjectMatcher, right:DisplayObjectMatcher)
		{
			super(left, right, this);
		}
		
		public function matches(element:DisplayObject):Boolean
		{
			return left.matches(element) || right.matches(element);
		}
		
		public function toString():String
		{
			return left + ", " + right;
		}
	}
}