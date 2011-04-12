package se.stade.flash.dom
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.utils.flash_proxy;
	
	import se.stade.colligo.Processable;
	import se.stade.colligo.filters.Filter;
	import se.stade.colligo.lists.ItemProxy;
	
	use namespace flash_proxy;
	
	/**
	 * The ElementProxy class provides functionality to modify the properties of multiple
	 * display objects at once. In essence, it acts like a processable but immutable array. No
	 * items can be added or removed from the proxy, however, any of the items properties or
	 * methods may be modifyed or called. While the common use case is to affect all display
	 * objects proxied by an instance of this class, it's possible to index and affect single
	 * display objects directly.
	 * 
	 * @author Marcus Stade
	 */
	public dynamic class ElementProxy extends ItemProxy implements Processable, Element
	{
		/**
		 * Wraps the given elements in a proxy instance with a given context.
		 * 
		 * @param context The context container for the given elements.
		 * @param elements The elements to be affected by this proxy.
		 */
		public function ElementProxy(elements:Vector.<DisplayObject>)
		{
			super(elements);
		}

		/**
		 * Gets a copy of the element list as is.
		 * 
		 * @return A copy of the element list. Each call to this method returns a new instance. 
		 */
		public function get elements():Vector.<DisplayObject>
		{
			return Vector.<DisplayObject>(list);
		}
		
		/**
		 * Gets a vector of any elements that match the given filter.
		 * 
		 * @param filter The filter that an element must match in order to be included in the vector.
		 * @return A vector containing any elements that matched the filter; an empty vector if no
		 * elements matches the filter.
		 */
		protected function getElements(filter:Filter):Vector.<DisplayObject>
		{
            return Vector.<DisplayObject>(filter.applyTo(list));
		}
		
		/**
		 * Registers an event listener with each of the proxied elements. Multiple events can
		 * be specified by separating the event types with a space character.
		 * 
		 * @copy flash.display.DisplayObject#addEventListener()
		 */
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int = 0, useWeakReference:Boolean=false):void
		{
			var events:Array = type.replace(/\s+/g, " ").split(" ");
			
			for each (var event:String in events)
			{
				for each (var element:DisplayObject in list)
				{
					element.addEventListener(event, listener, useCapture, priority, useWeakReference);
				}
			}
		}
		
		/**
		 * Removes the event listener from each of the proxied elements. Multiple events can
		 * be specified by separating the event types with a space character.
		 * 
		 * @copy flash.display.DisplayObject#removeEventListener()
		 */
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			var events:Array = type.replace(/\s+/g, " ").split(" ");
			
			for each (var event:String in events)
			{
				for each (var element:DisplayObject in list)
				{
					element.removeEventListener(type, listener, useCapture);
				}
			}
		}
		
		/**
		 * Dispatches an event from each of the proxied elements.
		 * 
		 * @copy flash.display.DisplayObject#dispatchEvent()
		 */
		public function dispatchEvent(event:Event):Boolean
		{
			for each (var element:DisplayObject in list)
			{
				element.dispatchEvent(event);
			}
			
			return list.length > 0;
		}
		
		final override flash_proxy function hasProperty(name:*):Boolean
		{
			var hasCommonProperty:Boolean = true;
			
			for each (var element:DisplayObject in list)
			{
				if (name in element)
					continue;
				
				return false;
			}
			
			return hasCommonProperty;
		}
		
		override protected function getProperty(name:*):*
		{
			var index:Number = parseInt(name);
			
			if (isNaN(index))
				return get(name);
			
			return list[index];
		}
		
		override protected function setProperty(name:*, value:*):void
		{
			var property:Object = {};
			property[name] = value;
			
			set(property);
		}

		
		// DisplayObject interface
		/**
		 * Gets the alpha of each proxied element.
		 * Returns NaN if no common value exists.
		 * 
		 * @copy flash.display.DisplayObject#alpha
		 */
		public function get alpha():Number
		{
			return get("alpha");
		}
		
		/**
		 * Sets the alpha of each proxied element.
		 * 
		 * @copy flash.display.DisplayObject#alpha
		 */
		public function set alpha(value:Number):void
		{
			set({alpha: value});
		}
		
		/**
		 * Gets the position along the x axis of each proxied element.
		 * Returns NaN if no common value exists.
		 * 
		 * @copy flash.display.DisplayObject#x
		 */
		public function get x():Number
		{
			return get("x");
		}
		
		/**
		 * Sets the position along the x axis of each proxied element.
		 * 
		 * @copy flash.display.DisplayObject#x
		 */
		public function set x(value:Number):void
		{
			set({x: value});
		}
		
		/**
		 * Gets the position along the y axis of each proxied element.
		 * Returns NaN if no common value exists.
		 * 
		 * @copy flash.display.DisplayObject#y
		 */
		public function get y():Number
		{
			return get("y");
		}
		
		/**
		 * Sets the position along the y axis of each proxied element.
		 * 
		 * @copy flash.display.DisplayObject#y
		 */
		public function set y(value:Number):void
		{
			set({y: value});
		}
		
		/**
		 * Gets the width of each proxied element.
		 * Returns NaN if no common value exists.
		 * 
		 * @copy flash.display.DisplayObject#width 
		 */
		public function get width():Number
		{
			return get("width");
		}
		
		/**
		 * Sets the width of each proxied element.
		 * 
		 * @copy flash.display.DisplayObject#width
		 */
		public function set width(value:Number):void
		{
			set({width: value});
		}
		
		/**
		 * Gets the height of each proxied element.
		 * Returns NaN if no common value exists.
		 * 
		 * @copy flash.display.DisplayObject#height
		 */
		public function get height():Number
		{
			return get("height");
		}
		
		/**
		 * Sets the height of each proxied element.
		 * 
		 * @copy flash.display.DisplayObject#height
		 */
		public function set height(value:Number):void
		{
			set({height: value});
		}
		
		/**
		 * @copy flash.display.DisplayObject#visible
		 */
		public function get visible():Boolean
		{
			return get("visible");
		}
		
		/**
		 * @copy flash.display.DisplayObject#visible
		 */
		public function set visible(value:Boolean):void
		{
			set({visible: value});
		}
	}
}