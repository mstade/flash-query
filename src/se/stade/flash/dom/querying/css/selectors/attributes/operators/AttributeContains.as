package se.stade.flash.dom.querying.css.selectors.attributes.operators
{
    public class AttributeContains implements AttributeOperator
    {
        public function AttributeContains(attribute:String)
        {
            this.attribute = attribute;
        }
        
        private var attribute:String;
        
        public function matches(value:*):Boolean
        {
            return String(value).indexOf(attribute) > -1;
        }
        
        public function toString():String
        {
            return " *= '" + attribute + "'";
        }
    }
}