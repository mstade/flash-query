package se.stade.flash.dom.querying.css.parsing.rules
{
    import se.stade.flash.dom.querying.ElementMatcher;
    import se.stade.flash.dom.querying.css.parsing.SelectorToken;
    import se.stade.parsing.Expression;
    import se.stade.parsing.LinearTokenStream;
    import se.stade.parsing.Token;
    import se.stade.parsing.TokenStream;
    import se.stade.parsing.pratt.Parser;
    import se.stade.parsing.pratt.PrefixRule;
    
    public class PseudoFunctionRule implements PrefixRule
    {
        public function PseudoFunctionRule(SelectoryType:Class)
        {
            this.SelectorType = SelectoryType;
        }
        
        private var SelectorType:Class;
        
        public function evaluate(current:Token, following:TokenStream, parser:Parser, priority:uint):Expression
        {
            var input:String = "";
            
            while (following.acceptAnythingBut(SelectorToken.FunctionEnd))
            {
                input += following.current.value;
            }
            
            following.expect(SelectorToken.FunctionEnd);
            
            return new SelectorType(input);
        }
    }
}