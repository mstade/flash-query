package se.stade.flash.dom.query.css.selectors
{
	import flash.display.DisplayObject;
	
	import se.stade.flash.dom.query.DisplayObjectMatcher;
	import se.stade.flash.dom.query.css.StyleNameCollection;
	
	public class StyleClassSelector implements DisplayObjectMatcher 
	{
		public function StyleClassSelector(names:StyleNameCollection)
		{
			this.names = names;
		}
		
		private var names:StyleNameCollection;
		
		
		public function get attribute():String
		{
			return "styleName";
		}
		
		public function matches(element:DisplayObject):Boolean
		{
			if ("styleName" in element && element["styleName"] is String)
			{
				var styleName:StyleNameCollection = new StyleNameCollection(element["styleName"]);
				return styleName.includes(names);
			}
			
			return false;
		}
		
		public function toString():String
		{
			return names.toString().replace(/\s/, '.');
		}
	}
}