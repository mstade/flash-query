package se.stade.flash.dom.query.css.selectors
{
	import flash.display.DisplayObject;
	
	import se.stade.daffodil.Reflect;
	import se.stade.flash.dom.query.DisplayObjectMatcher;
	
	public class NamespaceSelector implements DisplayObjectMatcher
	{
		public static const Any:NamespaceSelector = new NamespaceSelector("*");
		
		public function NamespaceSelector(ns:String)
		{
			this.ns = ns;
		}
		
		private var ns:String;
		
		public function matches(element:DisplayObject):Boolean
		{
			if (ns == "*")
				return true;
			
			return Reflect.types.inPackage(ns).on(element) == true;
		}
		
		public function toString():String
		{
			return ns;
		}
	}
}