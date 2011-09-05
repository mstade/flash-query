package se.stade.flash.dom.querying.css.selectors.pseudo.classes
{
    public class PseudoClassBase
    {
        public function PseudoClassBase(name:String)
        {
            this.name = ":" + name;
        }
        
        protected var name:String;
        
        public function toString():String
        {
            return name;
        }
    }
}