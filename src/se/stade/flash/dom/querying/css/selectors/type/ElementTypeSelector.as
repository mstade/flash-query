package se.stade.flash.dom.querying.css.selectors.type
{
    import avmplus.getQualifiedClassName;
    
    import flash.display.DisplayObject;
    
    import se.stade.flash.dom.querying.TypeMatcher;
    import se.stade.flash.dom.querying.css.selectors.Selector;

    public class ElementTypeSelector implements Selector
    {
        public function ElementTypeSelector(Type:Class)
        {
            type = new TypeMatcher(Type);
            selector = getQualifiedClassName(Type).replace("::", "|");
        }
        
        private var type:TypeMatcher;
        private var selector:String;
        
        public function matches(element:DisplayObject):Boolean
        {
            return type.matches(element);
        }
        
        public function toString():String
        {
            return selector;
        }
    }
}
