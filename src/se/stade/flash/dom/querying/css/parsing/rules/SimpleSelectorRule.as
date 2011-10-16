package se.stade.flash.dom.querying.css.parsing.rules
{
    import flash.utils.Dictionary;
    
    import se.stade.flash.dom.querying.css.parsing.SelectorToken;
    import se.stade.flash.dom.querying.css.selectors.SelectorGroup;
    import se.stade.flash.dom.querying.css.selectors.pseudo.classes.states.NegativeStateSelector;
    import se.stade.flash.dom.querying.css.selectors.pseudo.classes.states.PositiveStateSelector;
    import se.stade.flash.dom.querying.css.selectors.pseudo.classes.structural.ElementIndexSelector;
    import se.stade.flash.dom.querying.css.selectors.pseudo.classes.structural.EmptySelector;
    import se.stade.flash.dom.querying.css.selectors.pseudo.functions.NotSelector;
    import se.stade.flash.dom.querying.css.selectors.pseudo.functions.states.CurrentStateSelector;
    import se.stade.flash.dom.querying.css.selectors.pseudo.functions.structural.HasSelector;
    import se.stade.flash.dom.querying.css.selectors.pseudo.functions.types.ExtendsSelector;
    import se.stade.flash.dom.querying.css.selectors.pseudo.functions.types.ImplementsSelector;
    import se.stade.flash.dom.querying.css.selectors.type.ElementSelector;
    import se.stade.parsing.Expression;
    import se.stade.parsing.Token;
    import se.stade.parsing.TokenStream;
    import se.stade.parsing.pratt.Parser;
    import se.stade.parsing.pratt.PrefixRule;
    
    public class SimpleSelectorRule implements PrefixRule
    {
        public function SimpleSelectorRule()
        {
            rules = new Dictionary;
            
            // Type
            rules[SelectorToken.Name] =
            rules[SelectorToken.Namespace] = new ElementRule;
            
            // #id | .class | [attribute]
            rules[SelectorToken.Id]             = new IdentityRule;
            rules[SelectorToken.Class]          = new ClassRule;
            rules[SelectorToken.AttributeStart] = new AttributeRule;
            
            // Psuedo classes
            pseudoClasses.setMatcher(EmptySelector.Name, new EmptySelector);
            
            pseudoClasses.setMatcher(ElementIndexSelector.FirstChild, new ElementIndexSelector(ElementIndexSelector.FirstChild, 0));
            pseudoClasses.setMatcher(ElementIndexSelector.LastChild,  new ElementIndexSelector(ElementIndexSelector.LastChild, -1));
            
            pseudoClasses.setMatcher("enabled",  new PositiveStateSelector("enabled"));
            pseudoClasses.setMatcher("selected", new PositiveStateSelector("selected"));
            pseudoClasses.setMatcher("checked",  SelectorGroup.named(":checked",
                new PositiveStateSelector("selected"),
                new PositiveStateSelector("checked")
            ));
            
            pseudoClasses.setMatcher("disabled", SelectorGroup.named(":disabled",
                    new NegativeStateSelector("enabled"),
                    new PositiveStateSelector("disabled")
            ));
            
            // Pseudo functions
            pseudoFunctions.setParser(NotSelector.Name,          new PseudoSelectorRule(NotSelector));
            pseudoFunctions.setParser(HasSelector.Name,          new PseudoSelectorRule(HasSelector));
            pseudoFunctions.setParser(ExtendsSelector.Name,      new PseudoFunctionRule(ExtendsSelector));
            pseudoFunctions.setParser(ImplementsSelector.Name,   new PseudoFunctionRule(ImplementsSelector));
            pseudoFunctions.setParser(CurrentStateSelector.Name, new PseudoFunctionRule(CurrentStateSelector));
        }
        
        private var rules:Dictionary;
        
        private var _pseudoClasses:PseudoRuleCollection = new PseudoClassCollection;
        public function get pseudoClasses():PseudoRuleCollection 
        {
            return _pseudoClasses;
        }
        
        private var _pseudoFunctions:PseudoRuleCollection = new PseudoFunctionCollection;
        public function get pseudoFunctions():PseudoRuleCollection 
        {
            return _pseudoFunctions;
        }
        
        
        private function getPseudoClassFactory(Type:Class):Function
        {
            return function(name:String):Expression
            {
                return new Type(name);
            }
        }
        
        public function evaluate(current:Token, following:TokenStream, parser:Parser, precedence:uint):Expression
        {
            var selectors:Array = [];
            
            var rule:PrefixRule = getRule(current);
            selectors.push(rule.evaluate(current, following, parser, precedence));
            
            while (following.accept(SelectorToken.Id,
                                    SelectorToken.Class,
                                    SelectorToken.AttributeStart,
                                    SelectorToken.PseudoClass,
                                    SelectorToken.Function))
            {
                rule = getRule(following.current);
                selectors.push(rule.evaluate(following.current, following, parser, precedence));
            }
            
            return selectors.length > 1 ? SelectorGroup.from.apply(null, selectors) : Expression(selectors[0]);
        }
        
        private function getRule(current:Token):PrefixRule
        {
            if (current.type == SelectorToken.PseudoClass)
                return pseudoClasses;
            else if (current.type == SelectorToken.Function)
                return pseudoFunctions;
            else if (current.type in rules)
                return rules[current.type];
            else if (current.value in rules)
                return rules[current.value];

            return null;
        }
    }
}
