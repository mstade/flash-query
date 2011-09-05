package se.stade.flash.dom.querying.css.parsing.rules
{
    import se.stade.flash.dom.querying.ElementMatcher;
    import se.stade.flash.dom.querying.css.parsing.SelectorToken;
    import se.stade.parsing.Expression;
    import se.stade.parsing.ParseError;
    import se.stade.parsing.Token;
    import se.stade.parsing.TokenStream;
    import se.stade.parsing.pratt.Parser;
    import se.stade.parsing.pratt.PrefixRule;
    
    public class PseudoSelectorRule implements PrefixRule
    {
        public function PseudoSelectorRule(SelectorType:Class)
        {
            this.SelectorType = SelectorType;
        }
        
        private var SelectorType:Class;
        
        public function evaluate(current:Token, following:TokenStream, parser:Parser, priority:uint):Expression
        {
            try
            {
                var expression:ElementMatcher = ElementMatcher(parser.interpret(following, priority));
            }
            catch (error:ParseError)
            {
                throw ParseError.expected("selector expression").got(following.current);
            }
            
            following.expect(SelectorToken.FunctionEnd);
            return new SelectorType(expression);
        }
    }
}