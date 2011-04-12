package se.stade.flash.dom.query.css.selectors.attributes
{
	public class UnknownAttribute implements AttributeValue
	{
		public function UnknownAttribute(attribute:String)
		{
			this.attribute = attribute;
		}
		
		private var attribute:String;
		
		public function matches(value:*):Boolean
		{
			return false;
		}
		
		public function toString():String
		{
			return attribute;
		}
	}
}