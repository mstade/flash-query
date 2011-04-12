package se.stade.flash.dom.query.css.selectors.attributes
{

	public class AnyAttribute implements AttributeValue
	{
		public static const instance:AnyAttribute = new AnyAttribute;
		
		public function matches(value:*):Boolean
		{
			return true;
		}
		
		public function toString():String
		{
			return "";
		}
	}
}