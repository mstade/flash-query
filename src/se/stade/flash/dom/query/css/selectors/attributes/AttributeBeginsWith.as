package se.stade.flash.dom.query.css.selectors.attributes
{
	import String;

	public class AttributeBeginsWith implements AttributeValue
	{
		public function AttributeBeginsWith(attribute:String)
		{
			this.attribute = attribute;
			representation = "^= '" + attribute + "'";
		}
		
		private var attribute:String;
		private var representation:String;

		public function matches(value:*):Boolean
		{
			var beginning:String = String(value).slice(0, attribute.length); 
			return attribute == beginning;
		}
		
		public function toString():String
		{
			return representation;
		}
	}
}