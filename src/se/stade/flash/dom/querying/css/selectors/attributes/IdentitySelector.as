package se.stade.flash.dom.querying.css.selectors.attributes
{
    import flash.display.DisplayObject;
    
    import se.stade.flash.dom.querying.ElementMatcher;
    import se.stade.parsing.Expression;

    public class IdentitySelector implements ElementMatcher, Expression
    {
        public function IdentitySelector(name:String)
        {
            this.name = name;
        }
        
        private var name:String;
        
        public function matches(element:DisplayObject):Boolean
        {
            if ("id" in element)
                return element["id"] == name;
            else
                return element.name == name;
        }
        
        public function toString():String
        {
            return "#" + name;
        }
    }
}