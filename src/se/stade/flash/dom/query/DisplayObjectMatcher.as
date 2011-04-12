package se.stade.flash.dom.query
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	/**
	 * A matcher acts as a predicate to determine wether
	 * the given element mathes it or not.
	 * 
	 * @author Marcus Stade
	 */
	public interface DisplayObjectMatcher
	{
		function matches(element:DisplayObject):Boolean;
	}
}