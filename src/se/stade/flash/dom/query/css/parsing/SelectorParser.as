package se.stade.flash.dom.query.css.parsing
{
	import flash.utils.Dictionary;
	
	import se.stade.flash.dom.query.ChainMatcher;
	import se.stade.flash.dom.query.DisplayObjectMatcher;
	import se.stade.flash.dom.query.QueryParser;
	import se.stade.flash.dom.query.css.parsing.rules.AttributeRule;
	import se.stade.flash.dom.query.css.parsing.rules.AttributeValueRule;
	import se.stade.flash.dom.query.css.parsing.rules.CombinatorRule;
	import se.stade.flash.dom.query.css.parsing.rules.ElementRule;
	import se.stade.flash.dom.query.css.parsing.rules.IdentityRule;
	import se.stade.flash.dom.query.css.parsing.rules.NamespaceRule;
	import se.stade.flash.dom.query.css.parsing.rules.NegationRule;
	import se.stade.flash.dom.query.css.parsing.rules.PseudoRule;
	import se.stade.flash.dom.query.css.parsing.rules.SelectorGroupRule;
	import se.stade.flash.dom.query.css.parsing.rules.SelectorRule;
	import se.stade.flash.dom.query.css.parsing.rules.StyleClassRule;
	import se.stade.flash.dom.query.parsing.Lexer;
	import se.stade.flash.dom.query.parsing.ParseRule;
	import se.stade.flash.dom.query.parsing.Token;
	import se.stade.flash.dom.query.parsing.TokenStream;
	import se.stade.stilts.errors.NotImplementedError;
	
	public class SelectorParser implements QueryParser
	{
		public function SelectorParser(lexer:Lexer)
		{
			this.lexer = lexer;
			
			namespaceRule = new NamespaceRule();

			var negationRule:NegationRule = new NegationRule();
			selectorRule = new SelectorGroupRule(
				new CombinatorRule(
					new SelectorRule(
						new ElementRule(namespaceRule),
						new IdentityRule(),
						new StyleClassRule(),
						new AttributeRule(namespaceRule, new AttributeValueRule()),
						new PseudoRule(),
						negationRule
					)
				)
			);
			
			negationRule.selector = selectorRule;
		}
		
		private var namespaceRule:NamespaceRule;
		private var selectorRule:ParseRule;
		
		public function get defaultNamespace():String
		{
			return namespaceRule.defaultNamespace;
		}
		
		public function set defaultNamespace(value:String):void
		{
			namespaceRule.defaultNamespace = value;
		}
		
		public function setNamespace(prefix:String, namespace:String):void
		{
			namespaceRule.setNamespace(prefix, namespace);
		}
		
		public function getNamespace(prefix:String):String
		{
			return namespaceRule.getNamespace(prefix);
		}
		
		protected var lexer:Lexer;
		
		public function interpret(query:String):DisplayObjectMatcher
		{
			var tokens:TokenStream = lexer.scan(query);
			var selector:DisplayObjectMatcher = selectorRule.evaluate(tokens);
			
			return selector;
		}
	}
}