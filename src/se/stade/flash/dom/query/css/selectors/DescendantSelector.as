package se.stade.flash.dom.query.css.selectors
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import se.stade.flash.dom.query.DisplayObjectMatcher;
	
	public class DescendantSelector extends CombinatorMatcherBase implements CombinatorMatcher
	{
		public function DescendantSelector(ancestor:DisplayObjectMatcher, descendant:DisplayObjectMatcher)
		{
			super(ancestor, descendant, this);
		}
		
		public function matches(element:DisplayObject):Boolean
		{
			if (right.matches(element))
			{
				var ancestor:DisplayObjectContainer = element.parent;
				
				while (ancestor)
				{
					if (left.matches(ancestor))
						return true;
					
					ancestor = ancestor.parent;
				}
			}
			
			return false;
		}
		
		public function toString():String
		{
			return left + " " + right;
		}
	}
}