package se.stade.flash.dom.query
{
	import flash.display.DisplayObject;

	public final class QueryResult
	{
		public function QueryResult(matches:Array = null, unmatched:Array = null)
		{
			_matches = matches || [];
			_unmatched = unmatched || [];
		}
		
		private var _matches:Array;
		public function get matches():Array
		{
			return _matches;
		}
		
		private var _unmatched:Array;
		public function get unmatched():Array
		{
			return _unmatched;
		}
	}
}