package se.stade.flash.dom.querying.css.selectors.type
{
    import flash.display.DisplayObject;
    
    import se.stade.babbla.formatting.format;
    import se.stade.daffodil.Reflect;
    import se.stade.flash.dom.querying.ElementMatcher;
    import se.stade.flash.dom.querying.css.parsing.SelectorToken;
    
    public class ImplementsSelector extends ElementSelectorBase implements ElementMatcher
    {
        public function ImplementsSelector(name:String, namespace:NamespaceSelector = null)
        {
            super(SelectorToken.Implements + "{type})", name, namespace);
            //reflection = Reflect.first.type.implementing(name);
        }
    }
}