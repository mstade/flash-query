package se.stade.flash.dom.query.css.selectors.attributes
{
	public class AttributeContains implements AttributeValue
	{
		public function AttributeContains(attribute:String)
		{
			this.attribute = attribute;
			
			representation = "*= '" + attribute + "'";
		}
		
		private var attribute:String;
		private var representation:String;
		
		public function matches(value:*):Boolean
		{
			return String(value).indexOf(attribute) > -1;
		}
		
		public function toString():String
		{
			return null;
		}
	}
}