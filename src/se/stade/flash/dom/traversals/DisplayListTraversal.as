package se.stade.flash.dom.traversals
{
	import flash.display.DisplayObject;

	/**
	 * A DisplayListTraverser is used to traverse a list of
	 * DisplayObject instances.
	 */
	public interface DisplayListTraversal
	{
		/**
		 * Indicates whether there is another element in line.
		 * 
		 * @return True if there is another element in line; false otherwise. 
		 */
		function get hasNext():Boolean;
		
		/**
		 * Steps the traverser one step forward and returns the element in
         * that position.
		 * 
		 * @return The next element in line. 
		 */
		function getNext():DisplayObject;
		
		/**
		 * Resets the state of the traverser to its initial state.
		 */
		function reset():void;
	}
}