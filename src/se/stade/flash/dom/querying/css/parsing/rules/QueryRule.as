package se.stade.flash.dom.querying.css.parsing.rules
{
    import se.stade.flash.dom.querying.ElementMatcher;
    import se.stade.parsing.Expression;
    import se.stade.parsing.Token;
    import se.stade.parsing.TokenStream;
    import se.stade.parsing.pratt.Parser;
    import se.stade.parsing.pratt.PrefixRule;
    
    public class QueryRule implements PrefixRule
    {
        public function QueryRule(SelectorType:Class)
        {
            this.SelectorType = SelectorType;
        }
        
        private var SelectorType:Class;
        
        public function evaluate(current:Token, following:TokenStream, parser:Parser, priority:uint):Expression
        {
            var expression:ElementMatcher = ElementMatcher(parser.interpret(following, priority));
            return new SelectorType(expression);
        }
    }
}