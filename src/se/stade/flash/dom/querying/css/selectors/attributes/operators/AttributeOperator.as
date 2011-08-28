package se.stade.flash.dom.querying.css.selectors.attributes.operators
{
    import se.stade.parsing.Expression;

	public interface AttributeOperator extends Expression
	{
		function matches(value:*):Boolean;
	}
}