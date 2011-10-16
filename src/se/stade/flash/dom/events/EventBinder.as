package se.stade.flash.dom.events
{
    import se.stade.stilts.Disposable;
    
    public interface EventBinder extends Disposable
    {
        /**
         * Binds one or more events to a handler.
         * 
         * Binding events is largely the same as adding event listeners, but
         * with a more powerful syntax. The type string supports adding just
         * a single event listener, or multiple listeners at once, separated
         * by a space character. Events can also be namespaced, so that they
         * are correctly separated when unbinding. Additionaly, zero or more
         * custom parameters can be supplied which will passed on to the event
         * handler.
         * 
         * By default, event bubbling is prevented when binding events. For
         * more information on how to change this behavior, please see the
         * <code>map()</code> method.
         * 
         * To bind a single event:
         * 
         * <code>
         *     bind("click", handler);
         * </code>
         * 
         * To bind a single event, with custom parameters:
         * 
         * <code>
         *     bind("click", handler, { parameters: ["hello", "world"] });
         * 
         *     // The handler will be called with the following signature:
         *     // handler(event, my, data);
         * </code>
         * 
         * The options parameter of the bind method allows you to specify
         * optional behavior of the handler. In this particular case, we added
         * additional parameters with which the handler should be called. Please
         * see the documentation for the <code>map()</code> method for more
         * information.
         * 
         * To bind multiple events:
         * 
         * <code>
         *     bind("rollOver rollOut", handler);
         * </code>
         * 
         * 
         * Namespacing events can be very useful to semantically separate
         * different handlers. For instance, consider this scenario:
         * 
         * <code>
         *     bind("click", saveDocument);
         *     bind("click", logUserAction);
         * </code>
         * 
         * In this case, the same event has multiple listeners that have very
         * different purposes. Now let's say we're in production mode and want
         * to remove the logging from our code. This call should do it:
         * 
         * <code>
         *     unbind("click");
         * </code>
         * 
         * But wait, since unbind only takes the type parameter, it would remove
         * both handlers. Clearly not what we would like in this case. This is
         * where namespacing helps out:
         * 
         * <code>
         *     bind("click", saveDocument);
         *     bind("click.debug", logUserAction);
         * </code>
         * 
         * Now when unbinding, we can do this:
         * 
         * <code>
         *     unbind("click.debug");
         * </code>
         * 
         * This leaves the normal click handler untouched, while the log handler
         * is removed.
         * 
         */ 
        function bind(types:String, handler:Function, options:Object = null):void;
        
        /**
         * Binds events to handlers by using a map.
         * 
         * This method provides exactly the same functionality as bind, but with
         * the twist that multiple events and handlers can be specified using a
         * map. The same type syntax still applies however, so multiple events
         * can be bound to one handler. This method is very useful when there's
         * the need to map multiple handlers to one or more events.
         * 
         * Example:
         * 
         * <code>
         *     bindMultiple({
         *         click:         saveDocument,
         *         "click.debug": logUserAction,
         * 
         *         "rollOver rollOut": function(event:Event):void
         *                             {
         *                                 trace(event.type, event.target);
         *                             }
         *     });
         * </code>
         * 
         * This method also has the ability to set additional parameters to the
         * event handlers, such as making sure the handler is a weak reference:
         * 
         * <code>
         *     bindMultiple({
         *         click: {
         *             handler: saveDocument,
         *             parameters: ["hello", "world"],
         *             useWeakReference: true
         *         }
         *     });
         * </code>
         * 
         * In this example, another map is used to specify options for the click
         * event. The map has the following format:
         * 
         * <code>
         *     // The handler property is the event handler is required.
         *     handler (or listener):      Function
         * 
         *     // All other properties are optional, defaults are in brackets.
         *     params (or parameters):     Array       [undefined]
         * 
         *     // By default, event binding prevents bubbling, unless the event
         *     // handler returns a non-false value. Setting this property to
         *     // true will change the default behavior of this event binding
         *     // to allow bubbling, regardless of the event handler result.
         *     bubble (or allowBubble):    Boolean     [false]
         * 
         *     // These properties match the options in IEventDispatcher.
         *     priority:                   Number      [0]
         *     capture (or useCapture):    Boolean     [false]
         *     weak (or useWeakReference): Boolean     [false]
         * </code>
         */
        function bindMap(events:Object):void;
        
        /**
         * Unbinds all event handlers associated with the given type. The type
         * is matched verbatim, including the namespace. For more information
         * on namespacing events, please see the <code>bind()</code> method.
         * 
         * Specifying a namespace but no type (i.e. the first character is a dot)
         * will remove all handlers in the namespace, regardless of type.
         * 
         * Not specifying a type at all, or passing null as the type, will
         * unbind all handlers in all namespaces. I.e., this unbinds everything.
         * 
         * Examples:
         * <code>
         *     // Unbinds all click handlers without a namespace:
         *     unbind("click");
         *     
         *     // Unbinds all click handlers in the "debug" namespace:
         *     unbind("click.debug");
         * 
         *     // Unbinds all handlers in the "debug" namespace:
         *     unbind(".debug);
         *     
         *     // Unbinds all click handlers in all namespaces:
         *     unbind("click.");
         * 
         *     // Unbinds everything:
         *     unbind();
         */
        function unbind(types:String = null):void; 
    }
}
