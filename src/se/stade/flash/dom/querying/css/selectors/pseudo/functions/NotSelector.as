package se.stade.flash.dom.querying.css.selectors.pseudo.functions
{
    import flash.display.DisplayObject;
    
    import se.stade.flash.dom.querying.ElementMatcher;
    import se.stade.flash.dom.querying.css.selectors.Selector;
    import se.stade.parsing.Expression;
    
    public class NotSelector extends PseudoFunctionBase implements Selector
    {
        public static const Name:String = "not";
        
        public function NotSelector(expression:Selector)
        {
            super(Name, expression.toString());
        }
        
        private var expression:Selector;
        
        public function matches(element:DisplayObject):Boolean
        {
            return !expression.matches(element);
        }
    }
}
