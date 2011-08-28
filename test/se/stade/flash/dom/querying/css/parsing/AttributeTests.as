package se.stade.flash.dom.querying.css.parsing
{
    import org.flexunit.assertThat;
    import org.flexunit.runners.Parameterized;
    import org.hamcrest.core.isA;
    import org.hamcrest.object.equalTo;
    
    import se.stade.flash.dom.querying.css.selectors.attributes.AttributeSelector;
    import se.stade.parsing.Expression;
    import se.stade.parsing.Language;
    
    Parameterized;
    [RunWith("org.flexunit.runners.Parameterized")]
    public class AttributeTests
    {	
        private var css:Language;
        
        [Before]
        public function setUp():void
        {
            css = new SelectorsLevel3;
        }
        
        public static var queries:Array = [
            ["[foo]",        "[foo]"],
            ["[foo = bar]",  "[foo = 'bar']"],
            ["[foo ^= bar]", "[foo ^= 'bar']"],
            ["[foo $= bar]", "[foo $= 'bar']"],
            ["[foo *= bar]", "[foo *= 'bar']"],
            ["[foo ~= bar]", "[foo ~= 'bar']"],
            
            ["[ns|foo]",        "[ns|foo]"],
            ["[ns|foo = bar]",  "[ns|foo = 'bar']"],
            ["[ns|foo ^= bar]", "[ns|foo ^= 'bar']"],
            ["[ns|foo $= bar]", "[ns|foo $= 'bar']"],
            ["[ns|foo *= bar]", "[ns|foo *= 'bar']"],
            ["[ns|foo ~= bar]", "[ns|foo ~= 'bar']"],
        ];
        
        [Test(dataProvider="queries")]
        public function shouldParseAttribute(query:String, expectedOutput:String):void
        {
            var selector:Expression = css.parse(query);
            assertThat(selector, isA(AttributeSelector));
            assertThat(selector, equalTo(expectedOutput));
        }
    }
}