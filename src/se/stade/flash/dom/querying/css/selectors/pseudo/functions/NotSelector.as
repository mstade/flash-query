package se.stade.flash.dom.querying.css.selectors.pseudo.functions
{
	import flash.display.DisplayObject;
	
	import se.stade.flash.dom.querying.ElementMatcher;
	import se.stade.parsing.Expression;
	
	public class NotSelector extends PseudoFunctionBase implements ElementMatcher, Expression
	{
        public static const Name:String = "not";
        
		public function NotSelector(expression:ElementMatcher)
		{
            super(Name, String(expression));
		}
        
        private var expression:ElementMatcher;
		
		public function matches(element:DisplayObject):Boolean
		{
			return !expression.matches(element);
		}
	}
}