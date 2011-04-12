package se.stade.flash.dom.query.css.parsing.rules
{
	import flash.utils.Dictionary;
	
	import se.stade.flash.dom.query.css.parsing.tokens.IdentToken;
	import se.stade.flash.dom.query.css.selectors.NamespaceSelector;
	import se.stade.flash.dom.query.parsing.ParseRule;
	import se.stade.flash.dom.query.parsing.Token;
	import se.stade.flash.dom.query.parsing.TokenStream;
	
	public class NamespaceRule implements ParseRule
	{
		public function NamespaceRule(defaultNamespace:String = "*")
		{
			namespaces = new Dictionary();
			this.defaultNamespace = defaultNamespace;
		}
		
		private var namespaces:Dictionary;
		
		public function setNamespace(prefix:String, namespace:String):void
		{
			namespaces[prefix] = namespace;
		}
		
		public function getNamespace(prefix:String):String
		{
			return namespaces[prefix] || prefix;
		}
		
		public function get defaultNamespace():String
		{
			return getNamespace("*");
		}
		
		public function set defaultNamespace(value:String):void
		{
			setNamespace("*", value || "*");
		}
		
		public function get defaultSelector():NamespaceSelector
		{
			return new NamespaceSelector(getNamespace("*"));
		}
		
		public function evaluate(stream:TokenStream):*
		{
			if (stream.match("|"))
				return new NamespaceSelector("");
			else if (stream.match(IdentToken) || stream.match("*"))
			{
				var ns:String = getNamespace(stream.token.value);
				
				if (stream.match("|"))
					return new NamespaceSelector(ns);
			}
		}
	}
}