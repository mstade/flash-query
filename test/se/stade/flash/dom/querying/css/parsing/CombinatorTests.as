package se.stade.flash.dom.querying.css.parsing
{
    import org.flexunit.assertThat;
    import org.flexunit.runners.Parameterized;
    import org.hamcrest.core.isA;
    import org.hamcrest.object.equalTo;
    
    import se.stade.flash.dom.querying.css.selectors.combinators.ChildSelector;
    import se.stade.flash.dom.querying.css.selectors.combinators.DescendantSelector;
    import se.stade.flash.dom.querying.css.selectors.GroupSelector;
    import se.stade.flash.dom.querying.css.selectors.combinators.SiblingSelector;
    import se.stade.parsing.Expression;
    import se.stade.parsing.Language;
    
    Parameterized;
    [RunWith("org.flexunit.runners.Parameterized")]
    public class CombinatorTests
    {
        private var css:Language;
        
        [Before]
        public function setUp():void
        {
            css = new SelectorsLevel3;
        }
        
        public static var queries:Array = [
            [GroupSelector,      "li, p",  "li, p"],
            [ChildSelector,      "li > p", "li > p"],
            [DescendantSelector, "li p",   "li p"],
            
            [GroupSelector,      "li, p, p",   "li, p, p"],
            [ChildSelector,      "li > p > p", "li > p > p"],
            [DescendantSelector, "li p p",     "li p p"],
            
            [SiblingSelector, "li + p",  "li + p"],
            [SiblingSelector, "li ~ p",  "li ~ p"],
            [SiblingSelector, "li +> p", "li + p"],
            [SiblingSelector, "li <+ p", "li <+ p"],
            [SiblingSelector, "li ~> p", "li ~ p"],
            [SiblingSelector, "li <~ p", "li <~ p"],
            
            [SiblingSelector, "li + p + p",   "li + p + p"],
            [SiblingSelector, "li ~ p ~ p",   "li ~ p ~ p"],
            [SiblingSelector, "li +> p +> p", "li + p + p"],
            [SiblingSelector, "li <+ p <+ p", "li <+ p <+ p"],
            [SiblingSelector, "li ~> p ~> p", "li ~ p ~ p"],
            [SiblingSelector, "li <~ p <~ p", "li <~ p <~ p"],
        ];
        
        [Test(dataProvider="queries")]
        public function shouldParseCombinator(SelectorType:Class, query:String, expectedOutput:String):void
        {
            var selector:Expression = css.parse(query);
            assertThat(selector, isA(SelectorType));
            assertThat(selector, equalTo(expectedOutput));
        }
    }
}