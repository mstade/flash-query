package se.stade.flash.dom.querying.css.selectors.type
{
    import avmplus.getQualifiedClassName;
    
    import flash.display.DisplayObject;
    
    import se.stade.flash.dom.querying.ElementMatcher;
    import se.stade.parsing.Expression;

    public class ElementTypeSelector implements ElementMatcher, Expression
    {
        public function ElementTypeSelector(Type:Class)
        {
            this.Type = Type;
            selector = getQualifiedClassName(Type).replace("::", "|");
        }
        
        private var Type:Class;
        private var selector:String;
        
        public function matches(element:DisplayObject):Boolean
        {
            return Type && element is Type;
        }
        
        public function toString():String
        {
            return selector;
        }
    }
}