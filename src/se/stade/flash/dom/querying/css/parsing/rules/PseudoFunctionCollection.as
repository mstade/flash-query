package se.stade.flash.dom.querying.css.parsing.rules
{
    import se.stade.flash.dom.querying.ElementMatcher;
    import se.stade.parsing.pratt.PrefixRule;

    public class PseudoFunctionCollection extends PseudoRuleCollectionBase implements PrefixRule, PseudoRuleCollection
    {
        public function setParser(name:String, parser:PrefixRule):void
        {
            name = name.replace(/:/g, "").replace(/\(|\)/g, "");
            rules[":" + name + "("] = parser;
        }
        
        public function setMatcher(name:String, matcher:ElementMatcher):void
        {
            name = name.replace(/:/g, "").replace(/\(|\)/g, "");
            rules[":" + name + "("] = matcher;
        }
    }
}
