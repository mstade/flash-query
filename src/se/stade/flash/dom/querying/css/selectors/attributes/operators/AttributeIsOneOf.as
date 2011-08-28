package se.stade.flash.dom.querying.css.selectors.attributes.operators
{
	import flash.utils.Dictionary;

	public class AttributeIsOneOf implements AttributeOperator
	{
		public function AttributeIsOneOf(values:String)
		{
			attribute = new Dictionary();
            valueList = values.split(" ");
			
			for each (var value:String in valueList)
			{
                attribute[value] = true;
			}
		}
		
        private var valueList:Array;
		private var attribute:Dictionary;
		
		public function matches(value:*):Boolean
		{
			return String(value) in attribute;
		}
		
		public function toString():String
		{
			return " ~= '" + valueList.join(" ") + "'";
		}
	}
}