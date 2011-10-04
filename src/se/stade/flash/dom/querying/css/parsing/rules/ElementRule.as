package se.stade.flash.dom.querying.css.parsing.rules
{
    import se.stade.flash.dom.querying.css.parsing.SelectorToken;
    import se.stade.flash.dom.querying.css.selectors.type.ElementSelector;
    import se.stade.flash.dom.querying.css.selectors.type.NamespaceSelector;
    import se.stade.parsing.Expression;
    import se.stade.parsing.Token;
    import se.stade.parsing.TokenStream;
    import se.stade.parsing.pratt.Parser;
    import se.stade.parsing.pratt.PrefixRule;
    
    public class ElementRule implements PrefixRule
    {
        public function ElementRule(ElementSelectorType:Class)
        {
            this.ElementSelectorType = ElementSelectorType;
        }
        
        private var ElementSelectorType:Class;
        
        public function evaluate(current:Token, stream:TokenStream, parser:Parser, priority:uint):Expression
        {
            if (current.type == SelectorToken.Namespace)
            {
                var namespace:NamespaceSelector = new NamespaceSelector(current.value.substr(0, -1));
                var name:Token = stream.accept(SelectorToken.Name);
                
                if (name)
                    return new ElementSelector(name.value, namespace);
                else
                    return new ElementSelector("", namespace);
            }
            
            return new ElementSelectorType(current.value);
        }
    }
}