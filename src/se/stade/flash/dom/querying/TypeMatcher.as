package se.stade.flash.dom.querying
{
    import flash.display.DisplayObject;
    
    public class TypeMatcher implements ElementMatcher
    {
        public function TypeMatcher(Type:Class)
        {
            this.Type = Type;
        }
        
        private var Type:Class;
        
        public function matches(element:DisplayObject):Boolean
        {
            return Type && element is Type;
        }
    }
}
