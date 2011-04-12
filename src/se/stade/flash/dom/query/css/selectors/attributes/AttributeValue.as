package se.stade.flash.dom.query.css.selectors.attributes
{
	public interface AttributeValue
	{
		function matches(value:*):Boolean;
		function toString():String;
	}
}