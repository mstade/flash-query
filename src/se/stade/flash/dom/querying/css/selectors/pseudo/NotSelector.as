package se.stade.flash.dom.querying.css.selectors.pseudo
{
	import flash.display.DisplayObject;
	
	import se.stade.flash.dom.querying.ElementMatcher;
	import se.stade.parsing.Expression;
	
	public class NotSelector implements ElementMatcher, Expression
	{
		public function NotSelector(selector:ElementMatcher)
		{
			this.selector = selector;
		}
		
		protected var selector:ElementMatcher;
		
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