package se.stade.flash.dom.query.css.selectors
{
	import se.stade.stilts.errors.AbstractTypeError;
	import se.stade.flash.dom.query.DisplayObjectMatcher;

	internal class CombinatorMatcherBase
	{
		public function CombinatorMatcherBase(left:DisplayObjectMatcher, right:DisplayObjectMatcher, self:CombinatorMatcherBase)
		{
			if (self != this)
				throw new AbstractTypeError();
			
			_left = left;
			_right = right;
		}
		
		private var _left:DisplayObjectMatcher;
		public function get left():DisplayObjectMatcher
		{
			return _left;
		}
		
		private var _right:DisplayObjectMatcher;
		public function get right():DisplayObjectMatcher
		{
			return _right;
		}
	}
}