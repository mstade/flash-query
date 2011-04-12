package se.stade.flash.dom.query.css.selectors
{
	import se.stade.flash.dom.query.DisplayObjectMatcher;

	public interface CombinatorMatcher extends DisplayObjectMatcher
	{
		function get left():DisplayObjectMatcher;
		function get right():DisplayObjectMatcher;
	}
}