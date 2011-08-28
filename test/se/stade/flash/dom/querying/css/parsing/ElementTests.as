package se.stade.flash.dom.querying.css.parsing
{
    import org.flexunit.assertThat;
    import org.flexunit.runners.Parameterized;
    import org.hamcrest.core.isA;
    import org.hamcrest.object.equalTo;
    
    import se.stade.flash.dom.querying.css.selectors.type.ElementSelector;
    import se.stade.parsing.Expression;
    import se.stade.parsing.Language;
    
    Parameterized;
    [RunWith("org.flexunit.runners.Parameterized")]
    public class ElementTests
    {	
        private var css:Language;
        
        [Before]
        public function setUp():void
        {
            css = new SelectorsLevel3;
        }
        
        public static var queries:Array = [
            ["element",          "element"],
            ["root|element",     "root|element"],
            ["root.sub|element", "root.sub|element"],
            
            ["*",          "*"],
            ["root|*",     "root|*"],
            ["root.sub|*", "root.sub|*"],
            
            ["*|",         "*|"],
            ["root|*",     "root|*"],
            ["root.sub|*", "root.sub|*"],
        ];
        
        
        [Test(dataProvider="queries")]
        public function shouldParseSelector(input:String, expectedOutput:String):void
        {
            var selector:Expression = css.parse(input);
            assertThat(selector, isA(ElementSelector));
            assertThat(selector, equalTo(expectedOutput));
        }
    }
}