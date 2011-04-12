package se.stade.flash.dom.query.css.selectors
{
	import flash.display.DisplayObject;
	
	import se.stade.flash.dom.query.DisplayObjectMatcher;
	
	public class NegatedSelector implements DisplayObjectMatcher
	{
		public function NegatedSelector(selector:DisplayObjectMatcher)
		{
			this.selector = selector;
		}
		
		protected var selector:DisplayObjectMatcher;
		
		public function matches(element:DisplayObject):Boolean
		{
			return !selector.matches(element);
		}
		
		public function toString():String
		{
			return ":not(" + selector + ")";
		}
	}
}