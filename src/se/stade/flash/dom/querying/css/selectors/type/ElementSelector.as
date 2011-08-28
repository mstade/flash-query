package se.stade.flash.dom.querying.css.selectors.type
{
	import flash.display.DisplayObject;
	
	import se.stade.daffodil.Reflect;
	import se.stade.daffodil.types.TypeReflection;
	import se.stade.flash.dom.querying.ElementMatcher;

    public class ElementSelector extends ElementSelectorBase implements ElementMatcher
    {
        public static const Any:ElementSelector = new ElementSelector("*");
        
        public function ElementSelector(element:String = "", namespace:ElementMatcher = null)
        {
            super("{type}", element, namespace);
            reflection = Reflect.first.type.named(element);
        }
    }
}