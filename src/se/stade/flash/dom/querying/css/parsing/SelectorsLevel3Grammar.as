package se.stade.flash.dom.querying.css.parsing
{
    import se.stade.flash.dom.querying.css.parsing.rules.AttributeRule;
    import se.stade.flash.dom.querying.css.parsing.rules.ClassRule;
    import se.stade.flash.dom.querying.css.parsing.rules.CombinatorRule;
    import se.stade.flash.dom.querying.css.parsing.rules.ElementRule;
    import se.stade.flash.dom.querying.css.parsing.rules.IdentityRule;
    import se.stade.flash.dom.querying.css.parsing.rules.PseudoClassRule;
    import se.stade.flash.dom.querying.css.parsing.rules.PseudoFunctionRule;
    import se.stade.flash.dom.querying.css.parsing.rules.QueryRule;
    import se.stade.flash.dom.querying.css.parsing.rules.SimpleSelectorRule;
    import se.stade.flash.dom.querying.css.selectors.pseudo.HasSelector;
    import se.stade.flash.dom.querying.css.selectors.pseudo.NotSelector;
    import se.stade.flash.dom.querying.css.selectors.type.ElementSelector;
    import se.stade.flash.dom.querying.css.selectors.type.ExtendsSelector;
    import se.stade.flash.dom.querying.css.selectors.type.ImplementsSelector;
    import se.stade.parsing.pratt.ExpressionGrammar;
    import se.stade.parsing.pratt.PrefixRule;

    public class SelectorsLevel3Grammar extends ExpressionGrammar
    {
        public function SelectorsLevel3Grammar()
        {
            initialize();
        }
        
        public function initialize():void
        {
            _simpleSelector = new SimpleSelectorRule;
            
            // Type
            setPrefixFor(SelectorToken.Name,           simpleSelector);
            setPrefixFor(SelectorToken.Namespace,      simpleSelector);
            
            // Attributes
            setPrefixFor(SelectorToken.Id,             simpleSelector);
            setPrefixFor(SelectorToken.Class,          simpleSelector);
            setPrefixFor(SelectorToken.AttributeStart, simpleSelector);
            
            // Pseudo
            setPrefixFor(SelectorToken.Not,            simpleSelector);
            setPrefixFor(SelectorToken.Has,            simpleSelector);
            setPrefixFor(SelectorToken.Extends,        simpleSelector);
            setPrefixFor(SelectorToken.Implements,     simpleSelector);
            
            // Combinators
            var combinator:CombinatorRule = new CombinatorRule;
            setInfixFor(SelectorToken.Whitespace, combinator, 1);
            setInfixFor(SelectorToken.Child,      combinator, 1);
            setInfixFor(SelectorToken.Sibling,    combinator, 1);
        }
        
        private var _simpleSelector:SimpleSelectorRule;
        
        public function get simpleSelector():SimpleSelectorRule
        {
            return _simpleSelector;
        }
    }
}