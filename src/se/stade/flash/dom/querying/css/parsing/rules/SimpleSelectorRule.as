package se.stade.flash.dom.querying.css.parsing.rules
{
    import flash.utils.Dictionary;
    
    import se.stade.flash.dom.querying.ElementMatcher;
    import se.stade.flash.dom.querying.css.parsing.SelectorToken;
    import se.stade.flash.dom.querying.css.selectors.SelectorSequence;
    import se.stade.flash.dom.querying.css.selectors.pseudo.HasSelector;
    import se.stade.flash.dom.querying.css.selectors.pseudo.NotSelector;
    import se.stade.flash.dom.querying.css.selectors.type.ElementSelector;
    import se.stade.flash.dom.querying.css.selectors.type.ExtendsSelector;
    import se.stade.flash.dom.querying.css.selectors.type.ImplementsSelector;
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
            rules[SelectorToken.Name] = rules[SelectorToken.Namespace] = new ElementRule(ElementSelector);
            
            // #id | .class | [attribute]
            rules[SelectorToken.Id]             = new IdentityRule;
            rules[SelectorToken.Class]          = new ClassRule;
            rules[SelectorToken.AttributeStart] = new AttributeRule;
            
            // Psuedo
            setPseudoFunction(SelectorToken.Not,        NotSelector);
            setPseudoFunction(SelectorToken.Has,        HasSelector);
            setPseudoFunction(SelectorToken.Extends,    ExtendsSelector);
            setPseudoFunction(SelectorToken.Implements, ImplementsSelector); 
        }
        
        private var rules:Dictionary;
        
        public function setPseudoClass(name:String, SelectorType:Class):void
        {
            name = name.replace(/:/g, "");
            rules[":" + name] = new PseudoClassRule(SelectorType);
        }
        
        public function setPseudoFunction(name:String, SelectorType:Class):void
        {
            setPseudoExpression(name, new QueryRule(SelectorType));
        }
        
        public function setPseudoExpression(name:String, parameterParser:PrefixRule):void
        {
            name = name.replace(/:/g, "").replace(/\(|\)/g, "");
            rules[":" + name + "("] = new PseudoFunctionRule(parameterParser); 
        }
        
        public function evaluate(current:Token, following:TokenStream, parser:Parser, priority:uint):Expression
        {
            var selectors:Vector.<ElementMatcher> = new <ElementMatcher>[];
            
            var rule:PrefixRule = getRule(current);
            selectors.push(rule.evaluate(current, following, parser, priority));
            
            while (following.accept(SelectorToken.Id,
                                    SelectorToken.Class,
                                    SelectorToken.AttributeStart,
                                    SelectorToken.PseudoClass,
                                    SelectorToken.Function))
            {
                rule = getRule(following.current);
                selectors.push(rule.evaluate(following.current, following, parser, priority));
            }
            
            return selectors.length > 1 ? new SelectorSequence(selectors) : Expression(selectors[0]);
        }
        
        private function getRule(current:Token):PrefixRule
        {
            if (current.type in rules)
                return rules[current.type];
            if (current.value in rules)
                return rules[current.value];

            return null;
        }
    }
}