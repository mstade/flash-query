package se.stade.flash.dom.querying.css.selectors
{
	import flash.display.DisplayObject;
	
	import se.stade.flash.dom.querying.ElementMatcher;
	import se.stade.parsing.Expression;

	public class GroupSelector implements ElementMatcher, Expression
	{
		public function GroupSelector(selectors:Vector.<ElementMatcher>)
		{
            this.selectors = selectors || new Vector.<ElementMatcher>;
		}
        
        private var selectors:Vector.<ElementMatcher>;
		
		public function matches(element:DisplayObject):Boolean
		{
            for each (var selector:ElementMatcher in selectors)
            {
                if (selector.matches(element))
                    return true;
            }
            
            return false;
		}
		
		public function toString():String
		{
            return selectors.join(", ");
		}
	}
}