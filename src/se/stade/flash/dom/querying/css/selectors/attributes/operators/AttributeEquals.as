package se.stade.flash.dom.querying.css.selectors.attributes.operators
{
    public class AttributeEquals implements AttributeOperator
    {
        public function AttributeEquals(attribute:String)
        {
            this.attribute = attribute;
            
            /* If the value is a number, we store away the precision so
             * that we can perform an accurate comparison with numerical
             * values. */
            if (isNumber(attribute))
            {
                var parts:Array = attribute.split(".");
                
                if (parts[0].length == 0 || parts[0] == "+" || parts[0] == "-")
                    parts[0] += "0";
                
                if (parts[1].length == 0)
                    parts[1] = "0";
    
                precision = parts[1].length;
                attribute = parts.join(".");
                numericalCheckRequired = true;
            }
        }
        
        private var precision:uint;
        private var attribute:String;
        private var numericalCheckRequired:Boolean;
        
        private function isNumber(value:String):Boolean
        {
            return /^ [+-]? ([0-9]+\.[0-9]* | \.[0-9]+) $/x.test(value);
        }
        
        public function matches(value:*):Boolean
        {
            if (numericalCheckRequired && value is Number)
                return attribute == Number(value).toFixed(precision);
            
            return attribute == String(value);
        }
        
        public function toString():String
        {
            return " = '" + attribute + "'";
        }
    }
}