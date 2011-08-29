package se.stade.flash.dom.querying.css.selectors.attributes.operators
{
    import flash.utils.Dictionary;

    public class AttributeIsOneOf implements AttributeOperator
    {
        public function AttributeIsOneOf(values:String)
        {
            valueTable = new Dictionary();
            var valueList:Array = values.replace(/\s+/g, " ").split(" ");

            for each (var value:String in valueList)
            {
                valueTable[value] = value;
            }

            selector = " ~= '" + valueList.join(" ") + "'";
        }

        private var selector:String;
        private var valueTable:Dictionary;

        public function matches(value:*):Boolean
        {
            return String(value) in valueTable;
        }

        public function toString():String
        {
            return selector;
        }
    }
}
