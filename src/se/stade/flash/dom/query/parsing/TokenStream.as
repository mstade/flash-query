package se.stade.flash.dom.query.parsing
{
	public interface TokenStream
	{
		function get token():Token;
		
		function peek(value:* = null):Token;
		function match(value:*):Token;
		
		function next():TokenStream;
		function retract():TokenStream;
		function skip(value:*):TokenStream;
		function jump(count:int):TokenStream;
		
		function scope(start:*, end:*):TokenStream; 
		
		function evaluate(rule:ParseRule):*;
	}
}