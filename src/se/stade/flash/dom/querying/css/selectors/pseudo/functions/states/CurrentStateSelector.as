package se.stade.flash.dom.querying.css.selectors.pseudo.functions.states
{
    import flash.display.DisplayObject;
    
    import se.stade.flash.dom.querying.ElementMatcher;
    import se.stade.flash.dom.querying.css.selectors.pseudo.functions.PseudoFunctionBase;
    import se.stade.parsing.Expression;
    
    public class CurrentStateSelector extends PseudoFunctionBase implements ElementMatcher, Expression
    {
        public static const Name:String = "state";
        
        public function CurrentStateSelector(state:String)
        {
            super(Name, state);
            this.state = state;
        }
        
        private var state:String;
        
        public function matches(element:DisplayObject):Boolean
        {
            return "currentState" in element && element["currentState"] == state;
        }
    }
}