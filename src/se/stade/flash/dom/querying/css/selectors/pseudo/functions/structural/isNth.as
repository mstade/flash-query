package se.stade.flash.dom.querying.css.selectors.pseudo.functions.structural
{
    public function isNth(a:int, b:int, index:int):Boolean
    {
        index += 1;
        
        if (a == 0)
        {
            if (b == 0)
                return false;
            
            return index == b;
        }
        else
        {
            var n:Number = (index - b) / a + 1;
            return n is int && n > 0;
        }
    }
}
