package se.stade.flash.dom.querying.css.selectors.type
{
    import se.stade.daffodil.Reflect;
    import se.stade.daffodil.types.TypeReflection;
    import se.stade.flash.dom.querying.ElementMatcher;
    import se.stade.flash.dom.querying.css.parsing.SelectorToken;
    
    public class ExtendsSelector extends ElementSelectorBase implements ElementMatcher
    {
        public function ExtendsSelector(name:String, namespace:NamespaceSelector = null)
        {
            super(SelectorToken.Extends + "{type})", name, namespace);
            //reflection = Reflect.first.type.extending(name);
        }
    }
}