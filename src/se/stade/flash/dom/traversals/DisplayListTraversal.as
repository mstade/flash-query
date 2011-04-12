package se.stade.flash.dom.traversals
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	/**
	 * A DisplayListTraverser is used to traverse a list of
	 * DisplayObject instances. The traverser only walks in
	 * one direction, but it can be reset to use a specific
	 * element as the starting point of the traversal.
	 * 
	 * @author Marcus Stade
	 */
	public interface DisplayListTraversal
	{
		/**
		 * Determines wether or not there is a next display object in the list.
		 * 
		 * @return True if there is a next display object in the list; false otherwise. 
		 */
		function get hasNext():Boolean;
		
		/**
		 * Steps the traverser one step forward and returns the item in that
		 * position.
		 * 
		 * @return The next display object in the list. 
		 */
		function getNext():DisplayObject;
		
		/**
		 * Resets the state of the traverser to it's initial values.
		 */
		function reset():void;
	}
}