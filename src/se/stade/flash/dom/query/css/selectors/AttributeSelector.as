package se.stade.flash.dom.query.css.selectors
{
	import flash.display.DisplayObject;
	
	import se.stade.flash.dom.query.DisplayObjectMatcher;
	import se.stade.flash.dom.query.css.selectors.attributes.AnyAttribute;
	import se.stade.flash.dom.query.css.selectors.attributes.AttributeValue;

	public class AttributeSelector implements DisplayObjectMatcher
	{
		public function AttributeSelector(name:String, attribute:AttributeValue, namespace:DisplayObjectMatcher)
		{
			this.name = name;
			this.attribute = attribute || AnyAttribute.instance;
			this.namespace = namespace || NamespaceSelector.Any;
			
		}
		
		private var name:String;
		private var attribute:AttributeValue;
		private var namespace:DisplayObjectMatcher;
		
		public function matches(element:DisplayObject):Boolean
		{
			if (name in element)
			{
				var value:* = element[name];
				
				if (attribute.matches(value))
					return namespace.matches(element);
			}
			
			return false;
		}
		
		public function toString():String
		{
			return "[" + name + (attribute ? " " + attribute : "") + "]";
		}
	}
}