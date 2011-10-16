package se.stade.flash.dom.querying.css.parsing.rules
{
    import se.stade.flash.dom.querying.ElementMatcher;
    import se.stade.parsing.pratt.PrefixRule;

    public interface PseudoRuleCollection extends PrefixRule
    {
        function setParser(name:String, parser:PrefixRule):void;
        function setMatcher(name:String, matcher:ElementMatcher):void;
    }
}
