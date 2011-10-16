package se.stade.flash.dom.querying.css.selectors.pseudo.functions
{
    public class PseudoFunctionBase
    {
        public function PseudoFunctionBase(name:String, expression:String)
        {
            selector = ":" + name + "(" + expression + ")";
        }
        
        private var selector:String;
        
        public function toString():String
        {
            return selector;
        }
    }
}
