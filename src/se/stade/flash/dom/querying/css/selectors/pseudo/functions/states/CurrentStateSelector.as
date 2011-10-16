package se.stade.flash.dom.querying.css.selectors.pseudo.functions.states
{
    import flash.display.DisplayObject;
    
    import se.stade.flash.dom.querying.css.selectors.Selector;
    import se.stade.flash.dom.querying.css.selectors.pseudo.functions.PseudoFunctionBase;
    
    public class CurrentStateSelector extends PseudoFunctionBase implements Selector
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
