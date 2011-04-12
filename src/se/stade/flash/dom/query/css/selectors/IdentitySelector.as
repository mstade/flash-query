package se.stade.flash.dom.query.css.selectors
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	import se.stade.flash.dom.query.DisplayObjectMatcher;

	public class IdentitySelector implements DisplayObjectMatcher
	{
		public function IdentitySelector(name:String)
		{
			this.name = name;
		}
		
		private var name:String;
		
		public function matches(element:DisplayObject):Boolean
		{
			if ("id" in element)
				return element["id"] == name;
			else if ("name" in element)
				return element["name"] == name;
			
			return false;
		}
		
		public function toString():String
		{
			return "#" + name;
		}
	}
}