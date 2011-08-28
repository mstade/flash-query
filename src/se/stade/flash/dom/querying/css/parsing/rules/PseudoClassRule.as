package se.stade.flash.dom.querying.css.parsing.rules
{
    import se.stade.parsing.Expression;
    import se.stade.parsing.Token;
    import se.stade.parsing.TokenStream;
    import se.stade.parsing.pratt.Parser;
    import se.stade.parsing.pratt.PrefixRule;
    
    public class PseudoClassRule implements PrefixRule
    {
        public function PseudoClassRule(SelectorType:Class)
        {
            this.SelectorType = SelectorType;
        }
        
        private var SelectorType:Class;
        
        public function evaluate(current:Token, following:TokenStream, parser:Parser, priority:uint):Expression
        {
            return new SelectorType();
        }
    }
}