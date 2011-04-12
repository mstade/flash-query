package se.stade.flash.dom.query.css.selectors.attributes
{

	public class AttributeEndsWith implements AttributeValue
	{
		public function AttributeEndsWith(attribute:String)
		{
			this.attribute = attribute;
			representation = "$= '" + attribute + "'";
		}
		
		private var attribute:String;
		private var representation:String;
		
		public function matches(value:*):Boolean
		{
			var end:String = String(value).slice(-attribute.length);
			return attribute == value;
		}
		
		public function toString():String
		{
			return representation;
		}
	}
}