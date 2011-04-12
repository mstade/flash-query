package se.stade.flash.dom.query.parsing
{
	public class LastInFirstOutStream implements TokenStream
	{
		public function LastInFirstOutStream(tokens:Vector.<Token> = null)
		{
			this.tokens = tokens || new Vector.<Token>;
			this.scopes = Vector.<Scope>([
				new Scope(-1, tokens.length)
			]);
			
			currentIndex = -1;
		}
		
		private var currentIndex:int;
		private var tokens:Vector.<Token>;
		
		public function get token():Token
		{
			if (0 <= currentIndex && currentIndex < tokens.length)
				return tokens[currentIndex];
			
			return null;
		}
		
		public function peek(value:* = null):Token
		{
			var nextIndex:int = currentIndex + 1;
			
			if (nextIndex < tokens.length)
			{
				var next:Token = tokens[nextIndex];
				
				if (!value)
					return next;
				else if (next.value == value)
					return next;
				else if (value is Class && next is value)
					return next;
			}
			
			return null;
		}
		
		public function match(value:*):Token
		{
			var hasNext:Token = peek(value);
			
			if (hasNext)
				next();
			
			return hasNext;
		}

		public function retract():TokenStream
		{
			currentIndex = Math.max(--currentIndex, -1);
			
			if (currentIndex < currentScope.start)
				scopes.pop();
			
			return this;
		}
		
		public function next():TokenStream
		{
			currentIndex = Math.min(++currentIndex, tokens.length);
			
			if (currentIndex > currentScope.end)
				scopes.pop();
			
			return this;
		}

		public function skip(value:*):TokenStream
		{
			while (match(value))
			{
				next();
			}
			
			return this;
		}
		
		public function jump(count:int):TokenStream
		{
			while (count)
			{
				next();
				count--;
			}
			
			return this;
		}
		
		public function evaluate(rule:ParseRule):*
		{
			var startIndex:int = currentIndex;
			var startScopes:Vector.<Scope> = scopes.slice();
			
			var result:* = rule.evaluate(this);
			
			if (!result)
			{
				currentIndex = startIndex;
				scopes = startScopes;
			}
			
			return result;
		}
		
		private var scopes:Vector.<Scope>;
		
		private function get currentScope():Scope
		{
			return scopes[scopes.length - 1];
		}

		public function scope(start:*, end:*):TokenStream
		{
			if (match(start))
			{
				var startIndex:int = currentIndex;
				
				while (!match(end))
				{
					next();
				}
				
				currentIndex = startIndex;
				scopes.push(new Scope(startIndex, currentIndex));
				return this;
			}
			
			return null;
		}
	}
}