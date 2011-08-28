package se.stade.flash.dom.querying
{
    import flash.display.DisplayObject;

	public final class QueryResult
	{
		public function QueryResult(matches:Vector.<DisplayObject> = null, unmatched:Vector.<DisplayObject> = null)
		{
			_matches = matches || new Vector.<DisplayObject>();
			_unmatched = unmatched || new Vector.<DisplayObject>();
		}
		
		private var _matches:Vector.<DisplayObject>;
		public function get matches():Vector.<DisplayObject>
		{
			return _matches;
		}
		
		private var _unmatched:Vector.<DisplayObject>;
		public function get unmatched():Vector.<DisplayObject>
		{
			return _unmatched;
		}
	}
}