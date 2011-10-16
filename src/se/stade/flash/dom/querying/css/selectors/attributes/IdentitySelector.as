package se.stade.flash.dom.querying.css.selectors.attributes
{
    import flash.display.DisplayObject;
    
    import se.stade.flash.dom.querying.css.selectors.Selector;

    public class IdentitySelector implements Selector
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
