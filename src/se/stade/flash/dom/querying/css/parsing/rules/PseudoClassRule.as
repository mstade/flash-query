package se.stade.flash.dom.querying.css.parsing.rules
{
    import se.stade.flash.dom.querying.ElementMatcher;
    import se.stade.flash.dom.querying.css.selectors.pseudo.classes.states.PositiveStateSelector;
    import se.stade.parsing.Expression;
    import se.stade.parsing.Token;
    import se.stade.parsing.TokenStream;
    import se.stade.parsing.pratt.Parser;
    import se.stade.parsing.pratt.PrefixRule;
    
    public class PseudoClassRule implements PrefixRule
    {
        public function PseudoClassRule(factory:Function)
        {
            create = factory;
        }
        
        private var create:Function;
        
        public function evaluate(current:Token, following:TokenStream, parser:Parser, priority:uint):Expression
        {
            var name:String = current.value.slice(1);
            return create(name);
        }
    }
}
