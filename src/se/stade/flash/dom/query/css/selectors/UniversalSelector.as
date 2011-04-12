package se.stade.flash.dom.query.css.selectors
{
	import flash.display.DisplayObject;
	
	import se.stade.flash.dom.query.DisplayObjectMatcher;
	
	public class UniversalSelector implements DisplayObjectMatcher
	{
		public function UniversalSelector(namespace:DisplayObjectMatcher)
		{
			this.namespace = namespace;
		}
		
		protected var namespace:DisplayObjectMatcher;
		
		public function matches(element:DisplayObject):Boolean
		{
			return namespace ? namespace.matches(element) : true;
		}
		
		public function toString():String
		{
			return namespace ? namespace + "|*" : "*|*";
		}
	}
}