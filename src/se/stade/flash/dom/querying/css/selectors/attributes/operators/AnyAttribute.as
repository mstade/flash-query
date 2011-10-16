package se.stade.flash.dom.querying.css.selectors.attributes.operators
{
    public class AnyAttribute implements AttributeOperator
    {
        public static const Instance:AnyAttribute = new AnyAttribute;
        
        public function matches(value:*):Boolean
        {
            return true;
        }
        
        public function toString():String
        {
            return "";
        }
    }
}
