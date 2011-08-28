package se.stade.flash.dom.querying.css.parsing
{
    import org.flexunit.assertThat;
    import org.flexunit.runners.Parameterized;
    import org.hamcrest.core.isA;
    import org.hamcrest.object.equalTo;
    
    import se.stade.flash.dom.querying.ElementMatcher;
    import se.stade.parsing.Expression;
    import se.stade.parsing.Language;
    
    Parameterized;
    [RunWith("org.flexunit.runners.Parameterized")]
    public class ComplexQueryTests
    {
        private var css:Language;
        
        [Before]
        public function setUp():void
        {
            css = new SelectorsLevel3;
        }
        
        public static var queries:Array = [
            ["p[foo]"],
            ["p[foo][bar]"],
            ["p[foo] > [bar]"],
            ["p[foo] > [bar] > *, li"],
            ["p[foo] > [bar], li > p.foo"],
            
            // Really hairy
            ["p[foo = 'foo > bar'] > [bar]"],
            ["p[foo *= '\"foo\"' bar baz]",      "p[foo *= '\"foo\" bar baz']"],
            ["p[foo ^= foo, bar  ] > [bar]",     "p[foo ^= 'foo, bar'] > [bar]"],
            ["p[foo *= foo bar baz], [bar] > p", "p[foo *= 'foo bar baz'], [bar] > p"],
        ];
        
        [Test(dataProvider="queries")]
        public function expressionShouldMatchInput(query:String, expectedOutput:String = ""):void
        {
            var selector:Expression = css.parse(query);
            assertThat(selector, isA(ElementMatcher));
            assertThat(selector, equalTo(expectedOutput || query));
        }
    }
}