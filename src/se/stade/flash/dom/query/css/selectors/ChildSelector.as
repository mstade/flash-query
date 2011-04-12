package se.stade.flash.dom.query.css.selectors
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import se.stade.flash.dom.query.DisplayObjectMatcher;
	
	public class ChildSelector extends CombinatorMatcherBase implements CombinatorMatcher
	{
		public function ChildSelector(parent:DisplayObjectMatcher, child:DisplayObjectMatcher)
		{
			super(parent, child, this);
		}
		
		public function matches(element:DisplayObject):Boolean
		{
			return right.matches(element) && left.matches(element.parent);
		}
		
		public function toString():String
		{
			return left + " > " + right;
		}
	}
}