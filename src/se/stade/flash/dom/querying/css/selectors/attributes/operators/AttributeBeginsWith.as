package se.stade.flash.dom.querying.css.selectors.attributes.operators
{
    public class AttributeBeginsWith implements AttributeOperator
    {
        public function AttributeBeginsWith(attribute:String)
        {
            this.attribute = attribute;
        }
        
        private var attribute:String;

        public function matches(value:*):Boolean
        {
            var beginning:String = String(value).slice(0, attribute.length); 
            return attribute == beginning;
        }
        
        public function toString():String
        {
            return " ^= '" + attribute + "'";
        }
    }
}
