package se.stade.flash.dom
{
	import flash.events.Event;

	public interface Element
	{
		function get alpha():Number;
		function set alpha(value:Number):void;
		
		function get x():Number;
		function set x(value:Number):void;
		
		function get y():Number;
		function set y(value:Number):void;
		
		function get width():Number;
		function set width(value:Number):void;
		
		function get height():Number;
		function set height(value:Number):void;
		
		function get visible():Boolean;
		function set visible(value:Boolean):void;
		
		function dispatchEvent(event:Event):Boolean;
		function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void;
		function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void;
	}
}