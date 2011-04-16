package se.stade.flash.dom.query.css.selectors
{
    import flash.display.DisplayObject;
    import flash.utils.getQualifiedClassName;
    
    import se.stade.daffodil.Reflect;
    import se.stade.flash.dom.query.DisplayObjectMatcher;

    public class ElementSelector implements DisplayObjectMatcher
    {
        public function ElementSelector(type:String, namespace:DisplayObjectMatcher)
        {
            this.type = type;
            this.namespace = namespace || NamespaceSelector.Any;
        }

        protected var type:String;
        protected var namespace:DisplayObjectMatcher;

        public function matches(element:DisplayObject):Boolean
        {
            var hasMatchingType:Boolean = Reflect.first
                                                 .type
                                                 .like(type)
                                                 .on(element);
            return hasMatchingType
                   && namespace.matches(element);
        }

        public function toString():String
        {
            return namespace + type;
        }
    }
}