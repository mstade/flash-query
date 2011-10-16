package se.stade.flash.dom.querying.css.selectors.pseudo.classes.structural
{
    import flash.display.DisplayObject;
    
    import se.stade.flash.dom.querying.css.selectors.Selector;
    import se.stade.flash.dom.querying.css.selectors.pseudo.classes.PseudoClassBase;
    
    public class ElementIndexSelector extends PseudoClassBase implements Selector
    {
        public static const LastChild:String  = "last-child";
        public static const FirstChild:String = "first-child";
        
        public function ElementIndexSelector(name:String, index:int)
        {
            super(name)
            this.index = index;
        }
        
        private var index:int;
        
        public function matches(element:DisplayObject):Boolean
        {
            if (element.parent)
            {
                try
                {
                    var elementIndex:int = element.parent.getChildIndex(element);
                    
                    if (elementIndex < 1)
                        return elementIndex == element.parent.numChildren + index;
                    else
                        return elementIndex == index;
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
