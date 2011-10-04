package se.stade.flash.dom.querying.css.selectors.attributes.operators
{
    public class AttributeEndsWith implements AttributeOperator
    {
        public function AttributeEndsWith(end:String)
        {
            this.end = end;
        }
        
        private var end:String;
        
        public function matches(value:*):Boolean
        {
            return String(value).slice(-end.length) == end;
        }
        
        public function toString():String
        {
            return " $= '" + end + "'";
        }
    }
}