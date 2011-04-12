package se.stade.flash.dom.query.css.selectors
{
	import flash.display.DisplayObject;
	
	import se.stade.flash.dom.query.DisplayObjectMatcher;
	
	/**
	 * The ignored selector is used to ignore selectors that
	 * are syntactically valid, but not implemented yet for
	 * whatever reason.
	 * 
	 * @author mstade
	 */
	public class IgnoredSelector implements DisplayObjectMatcher
	{
		/**
		 * @inheritDoc 
		 */
		public function matches(element:DisplayObject):Boolean
		{
			return true;
		}
		
		public function toString():String
		{
			return "";
		}
	}
}