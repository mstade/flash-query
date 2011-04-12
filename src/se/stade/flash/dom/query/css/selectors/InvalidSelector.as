package se.stade.flash.dom.query.css.selectors
{
	import flash.display.DisplayObject;
	
	import se.stade.flash.dom.query.DisplayObjectMatcher;
	
	public class InvalidSelector implements DisplayObjectMatcher
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
			return "{" + token + "}";
		}
	}
}