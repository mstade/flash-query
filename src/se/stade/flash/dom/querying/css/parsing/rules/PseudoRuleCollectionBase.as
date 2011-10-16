package se.stade.flash.dom.querying.css.parsing.rules
{
    import flash.utils.Dictionary;
    
    import se.stade.flash.dom.querying.ElementMatcher;
    import se.stade.parsing.Expression;
    import se.stade.parsing.ParseError;
    import se.stade.parsing.Token;
    import se.stade.parsing.TokenStream;
    import se.stade.parsing.pratt.Parser;
    import se.stade.parsing.pratt.PrefixRule;
    
    internal class PseudoRuleCollectionBase implements PrefixRule
    {
        protected var rules:Dictionary = new Dictionary;
        
        public function evaluate(current:Token, following:TokenStream, parser:Parser, precedence:uint):Expression
        {
            var rule:* = rules[current.type] || rules[current.value];
            
            if (rule is ElementMatcher)
                return rule;
            else if (rule is PrefixRule)
                return PrefixRule(rule).evaluate(current, following, parser, precedence);
            else
                throw ParseError.expected("known pseudo class token").got(current);
        }
    }
}
