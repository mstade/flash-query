package se.stade.flash.dom
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	import se.stade.stilts.PropertySet;
	
	use namespace flash_proxy;
	
	/**
	 * Proxies a list of elements, allowing interaction with multiple
     * display objects as though they were one. While all properties
     * and methods of each proxied element can be called, no elements
     * can be added or removed from this list.
     * 
     * If the common indexing syntax is used (e.g. proxy[0]) it will
     * retrieve the node at that specific syntax. Otherwise the
     * proxied nodes' display object properties are called.
     * 
     * Only properties of the nodes' display objects will be proxied,
     * meaning any node property (like children, siblings etc.) will
     * not be proxied and must be called on each individual node.
	 */
	public dynamic class ElementProxy extends Proxy implements IEventDispatcher
	{
        public static function from(node:DisplayNode, ... nodes):ElementProxy
        {
            nodes = [node].concat(nodes);
            return new ElementProxy(Vector.<DisplayNode>(nodes));
        }
            
        
		/**
		 * Wraps the given elements in a proxy instance with a given context.
		 * 
		 * @param context The context container for the given elements.
		 * @param elements The elements to be affected by this proxy.
		 */
		public function ElementProxy(nodes:Vector.<DisplayNode> = null)
		{
            this.nodes = nodes ? nodes.slice() : new Vector.<DisplayNode>;
		}
        
        protected var nodes:Vector.<DisplayNode>;
        
        /**
         * @return The number of proxied elements. 
         */ 
        public function get length():uint
        {
            return nodes.length;
        }
        
        /**
         * @return An array containing all proxied nodes.
         */ 
        public function toArray():Array
        {
            var list:Array = [];
            
            for each (var node:DisplayNode in nodes)
            {
                list.push(node);
            }
            
            return list;
        }
        
        public function concat(other:ElementProxy):ElementProxy
        {
            return new ElementProxy(nodes.concat(other.nodes));
        }
            
		/**
		 * Multiple events can be specified by separating the event
         * types with a space character.
		 * 
		 * @copy flash.display.DisplayNode#addEventListener()
		 */
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int = 0, useWeakReference:Boolean=false):void
		{
			var events:Array = type.replace(/\s+/g, " ").split(" ");
			
			for each (var event:String in events)
			{
				for each (var node:DisplayNode in nodes)
				{
					node.addEventListener(event, listener, useCapture, priority, useWeakReference);
				}
			}
		}
		
		/**
		 * Multiple events can be specified by separating the event
         * types with a space character.
		 * 
		 * @copy flash.display.DisplayNode#removeEventListener()
		 */
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			var events:Array = type.replace(/\s+/g, " ").split(" ");
			
			for each (type in events)
			{
				for each (var node:DisplayNode in nodes)
				{
					node.removeEventListener(type, listener, useCapture);
				}
			}
		}
        
        /**
         * @copy flash.display.DisplayNode#hasEventListener()
         */
        public function hasEventListener(type:String):Boolean
        {
            for each (var node:DisplayNode in nodes)
            {
                if (node.hasEventListener(type))
                    return true;
            }
            
            return false;
        }
        
        /**
         * @copy flash.display.DisplayNode#willTrigger()
         */
        public function willTrigger(type:String):Boolean
        {
            for each (var node:DisplayNode in nodes)
            {
                if (node.willTrigger(type))
                    return true;
            }
            
            return false;
        }
		
		/**
		 * @copy flash.display.DisplayNode#dispatchEvent()
		 */
		public function dispatchEvent(event:Event):Boolean
		{
            var atLeastPartialSuccess:Boolean;
			for each (var node:DisplayNode in nodes)
			{
                atLeastPartialSuccess ||= node.dispatchEvent(event);
			}
			
			return atLeastPartialSuccess;
		}
        
        /**
         * If the specified property is an integer, the node at that
         * specific index will be returned. If the specified is a string
         * or QName, the common value of all proxied elements will be
         * returned. If there is no common value, undefined is returned.
         * 
         * Will also return undefined if an error is thrown while trying
         * to retrieve the value of a property.
         * 
         * @return A node, the common value of all proxied elements or undefined.
         */ 
        public function get(property:*):*
        {
            var index:int = parseInt(property);
            
            if (index == index)
                return nodes[index]; // Return a specific node if property is an index
            
            var value:* = undefined;
            
            for each (var node:DisplayNode in nodes)
            {
                if (property in node.element)
                {
                    try
                    {
                        value ||= node.element[property];
                        
                        if (value === node.element[property])
                            continue;
                        else
                            return undefined;
                    }
                    catch (error:Error)
                    {
                        return undefined;
                    }
                }
            }
        }
        
        /**
         * Sets all properties of a given object onto the proxies elements.
         * If an element doesn't support setting the given property, no error
         * is thrown and that element is ignored.
         */ 
        public function set(properties:Object):void
        {
            for (var property:String in properties)
            {
                var index:int = parseInt(property);
                
                if (index == index)
                    return; // We don't allow replacing elements
                
                var set:PropertySet = PropertySet.from(properties);
                
                for each (var node:DisplayNode in nodes)
                {
                    set.applyTo(node);
                }
            }
        }
        
        /**
         * Calls the specified method on each proxied elements and returns
         * and array with the results. If the method could not be called,
         * the returned result for that element is an error.
         * 
         * @return An array of the return values from each method call.
         */ 
        public function call(name:*, ... parameters):Array
        {
            var results:Array = [];
            
            for each (var node:DisplayNode in nodes)
            {
                if (name in node.element)
                {
                    try
                    {
                        var method:Function = node.element[name] as Function;
                        
                        if (method != null)
                        {
                            results.push(method.apply(node.element, parameters));
                        }
                    }
                    catch (error:Error)
                    {
                        results.push(error);
                    }
                }
            }
            
            return results;
        }
		
		// DisplayObject interface
		/**
		 * @copy flash.display.DisplayNode#alpha
         * @return The alpha of all proxied elements if they share the same value; NaN otherwise.
		 */
		public function get alpha():Number
		{
			return get("alpha");
		}
		
		/**
		 * @copy flash.display.DisplayNode#alpha
		 */
		public function set alpha(value:Number):void
		{
			set({alpha: value});
		}
		
		/**
		 * @copy flash.display.DisplayNode#x
         * @return The horizontal position of all proxied elements if they share the same value; NaN otherwise.
		 */
		public function get x():Number
		{
			return get("x");
		}
		
		/**
		 * @copy flash.display.DisplayNode#x
		 */
		public function set x(value:Number):void
		{
			set({x: value});
		}
		
		/**
		 * @copy flash.display.DisplayNode#y
         * @return The vertical position of all proxied elements if they share the same value; NaN otherwise.
		 */
		public function get y():Number
		{
			return get("y");
		}
		
		/**
		 * @copy flash.display.DisplayNode#y
		 */
		public function set y(value:Number):void
		{
			set({y: value});
		}
		
		/**
		 * @copy flash.display.DisplayNode#width 
         * @return The width of all proxied elements if they share the same value; NaN otherwise.
		 */
		public function get width():Number
		{
			return get("width");
		}
		
		/**
		 * @copy flash.display.DisplayNode#width
		 */
		public function set width(value:Number):void
		{
			set({width: value});
		}
		
		/**
		 * @copy flash.display.DisplayNode#height
         * @return The height of all proxied elements if they share the same value; NaN otherwise.
		 */
		public function get height():Number
		{
			return get("height");
		}
		
		/**
		 * @copy flash.display.DisplayNode#height
		 */
		public function set height(value:Number):void
		{
			set({height: value});
		}
		
		/**
		 * @copy flash.display.DisplayNode#visible
         * @return A boolean if all proxied elements share the same value; undefined otherwise.
		 */
		public function get visible():*
		{
			return get("visible");
		}
		
		/**
		 * @copy flash.display.DisplayNode#visible
		 */
		public function set visible(value:Boolean):void
		{
			set({visible: value});
		}

        // Proxy interface
        override flash_proxy function hasProperty(name:*):Boolean
        {
            var index:int = parseInt(name);
            
            if (index == index)
                return index >= 0 && index < nodes.length;
            
            for each (var node:DisplayNode in nodes)
            {
                if (name in node.element)
                    continue;
                
                return false;
            }
            
            return true;
        }
        
        override flash_proxy function getProperty(name:*):*
        {
            return get(name);
        }
        
        override flash_proxy function setProperty(name:*, value:*):void
        {
            set({name: value});
        }
        
        override flash_proxy function callProperty(name:*, ... rest):*
        {
            return call.apply(this, [name].concat(rest));
        }
        
        override flash_proxy function deleteProperty(name:*):Boolean
        {
            return false;
        }
        
        override flash_proxy function nextNameIndex(index:int):int
        {
            if (index < length)
                return index + 1;
            else
                return 0;
        }
        
        override flash_proxy function nextName(index:int):String
        {
            return String(index - 1);
        }
        
        override flash_proxy function nextValue(index:int):*
        {
            return nodes[index - 1];    	        	
        }
	}
}