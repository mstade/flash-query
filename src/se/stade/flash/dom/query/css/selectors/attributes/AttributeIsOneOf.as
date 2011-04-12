package se.stade.flash.dom.query.css.selectors.attributes
{
	import flash.utils.Dictionary;

	public class AttributeIsOneOf implements AttributeValue
	{
		public function AttributeIsOneOf(values:Vector.<String>)
		{
			attributes = new Dictionary();
			
			for each (var value:String in values)
			{
				attributes[value] = true;
			}
			
			representation = "|= '" + values.join(" ") + "'";
		}
		
		private var attributes:Dictionary;
		private var representation:String;
		
		public function matches(value:*):Boolean
		{
			return String(value) in attributes;
		}
		
		public function toString():String
		{
			return representation;
		}
	}
}