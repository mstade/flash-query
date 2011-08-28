package se.stade.flash.dom.querying.css.selectors.attributes
{
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	
	import se.stade.flash.dom.querying.ElementMatcher;
	import se.stade.parsing.Expression;
	
	public class ClassSelector implements ElementMatcher, Expression
	{
		public function ClassSelector(names:Array)
		{
            classes = new Dictionary;
            
            for each (var name:String in names)
            {
                classes[name] = true;
            }
            
            selector = names ? "." + names.join(".") : "";
		}
		
        private var selector:String;
        private var classes:Dictionary;
		
		
		public function get attribute():String
		{
			return "styleName";
		}
		
		public function matches(element:DisplayObject):Boolean
		{
			if ("styleName" in element && element["styleName"] is String)
			{
                var names:Array = String(element["styleName"]).split(" ");
                
                for each (var name:String in names)
                {
                    if (name in classes == false)
                        return false;
                }
                
                return true;
			}
			
			return false;
		}
		
		public function toString():String
		{
            return selector;
		}
	}
}