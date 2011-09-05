package se.stade.flash.dom.querying.css.selectors
{
	import flash.display.DisplayObject;
	
	import se.stade.flash.dom.querying.ElementMatcher;
	import se.stade.parsing.Expression;
	
	public class InvalidSelector implements ElementMatcher, Expression
	{
		public function InvalidSelector(token:String):void
		{
			this.token = token;
		}
		
		private var token:String;
		
		public function matches(element:DisplayObject):Boolean
		{
			return false;
		}
		
		public function toString():String
		{
			return "<<INVALID: " + token + ">>";
		}
	}
}