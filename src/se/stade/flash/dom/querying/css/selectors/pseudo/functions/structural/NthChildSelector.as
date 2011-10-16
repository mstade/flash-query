package se.stade.flash.dom.querying.css.selectors.pseudo.functions.structural
{
    import flash.display.DisplayObject;
    
    import se.stade.babbla.formatting.format;
    import se.stade.flash.dom.querying.css.selectors.Selector;
    import se.stade.flash.dom.querying.css.selectors.pseudo.functions.PseudoFunctionBase;
    
    public class NthChildSelector extends PseudoFunctionBase implements Selector
    {
        public static const Name:String = "nth-child";
        
        public function NthChildSelector(a:int, b:int)
        {
            super(Name, format("{0}n+{1}", a, b));
            this.a = a;
            this.b = b;
        }
        
        private var a:int;
        private var b:int;
        
        public function matches(element:DisplayObject):Boolean
        {
            if (element.parent)
            {
                try
                {
                    var i:int = element.parent.getChildIndex(element);
                    return isNth(a, b, i);
                }
                catch (error:SecurityError)
                {
                    return false;
                }
            }
            
            return false;
        }
    }
}
