package se.stade.flash.dom.querying.css.selectors.type
{
    import se.stade.daffodil.Reflect;
    import se.stade.flash.dom.querying.ElementMatcher;
    import se.stade.flash.dom.querying.css.selectors.Selector;

    public class ElementSelector extends ElementSelectorBase implements Selector
    {
        public function ElementSelector(element:String = "",
                                        namespace:ElementMatcher = null)
        {
            super("{type}", element, namespace);
            reflection = Reflect.first.type.named(element);
        }
    }
}
