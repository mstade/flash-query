package se.stade.flash.dom.query.parsing
{
	import se.stade.stilts.string.formatting.format;

	public class RegExpConfiguration implements LexerConfiguration
	{
		private var dirtyDefinitions:int;
		private var definitionPatterns:Object = {};
		
		private var ruleParameters:Array = [];
		private var cachedRules:Vector.<LexerRule>;
		
		public function setDefinition(name:String, pattern:RegExp):void
		{
			definitionPatterns[name] = "(?: " + pattern.source + " )";
			dirtyDefinitions++;
			cachedRules = null;
		}
		
		public function setDefinitions(definitions:Object):void
		{
			for (var name:String in definitions)
			{
				setDefinition(name, definitions[name]);
			}
		}
		
		public function addRule(TokenClass:Class, pattern:RegExp, options:String="gix"):void
		{
			ruleParameters.push({
				pattern: pattern.source,
				options: options,
				factory: TokenClass
			});
		}
		
		public function getRules():Vector.<LexerRule>
		{
			if (cachedRules)
				return cachedRules;
			
			var lastCount:int = 0;
			
			while (dirtyDefinitions > 0 && dirtyDefinitions != lastCount) // Last condition is to detect infinite loops
			{
				lastCount = dirtyDefinitions;
				
				for (var name:String in definitionPatterns)
				{
					var formattedDefinition:String = format(definitionPatterns[name], definitionPatterns);
					
					if (formattedDefinition.search(/\{(?!\d,\d\}|,\d\}|\d\})/) == -1)
						dirtyDefinitions--;
					
					definitionPatterns[name] = formattedDefinition;
				}
			}
			
			dirtyDefinitions = 0;
			var rules:Vector.<LexerRule> = new <LexerRule>[];
			
			for each (var parameters:Object in ruleParameters)
			{
				var pattern:String = format(parameters.pattern, definitionPatterns);
				var expression:RegExp = new RegExp(pattern, parameters.options);
				rules.push( new RegExpLexerRule(expression, parameters.factory) );
			}
			
			return rules;
		}
	}
}