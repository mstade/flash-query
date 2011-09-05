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
    public class SelectorsLevel3Tests
    {		
        private var css:Language;
        
        [Before]
        public function setUp():void
        {
            css = new SelectorsLevel3;
        }
        
        /**
         * All of the following queries are valid and have
         * been picked up from various sources, listed below
         * in no particular order:
         *  
         * http://tools.css3.info/selectors-test/test.html
         */
        
        public static var valid:Array = [
            // Type selectors
            ["*"], ["*|"], ["root|*"],  ["root.sub|*"],
            ["e"], ["E"],  ["element"], ["root|element"], ["root.sub|element"],
            
            // Class selectors
            [".class"],
            [".first.second"],
            
            // Id selectors
            ["#id"],
            ["#id.first"],        [".first#id"],
            ["#id.first.second"], [".first.second#id"], [".first#id.second"],
            
            // Descendant selectors
            ["E F"],
            ["div div"],
            
            // Child selectors
            ["E > F"],
            ["div > div"],
            ["div ol > li div"],
            
            // Sibling selectors
            ["E + F"],
            ["h1 + p"],
            ["E ~ F"], 
            ["E <+ F"],
            ["E <~ F"],
            ["E +> F", "E + F"],
            ["E ~> F", "E ~ F"],
            ["li + p + p"],
            ["li ~ p ~ p"],
            ["li <+ p <+ p"],
            ["li <~ p <~ p"],
            ["li +> p +> p", "li + p + p"],
            ["li ~> p ~> p", "li ~ p ~ p"],
            
            // Groups
            ["li, p"],
            ["li, p, p"],
            ["li, p > p"],
            ["li p, p"],
            
            // Attribute selectors
            ["[foo]"],          ["[ns|foo]"],
            ["[foo = 'bar']"],  ["[ns|foo = 'bar']"],
            ["[foo ^= 'bar']"], ["[ns|foo ^= 'bar']"],
            ["[foo $= 'bar']"], ["[ns|foo $= 'bar']"],
            ["[foo *= 'bar']"], ["[ns|foo *= 'bar']"],
            ["[foo ~= 'bar']"], ["[ns|foo ~= 'bar']"],
            
            ["E[attribute]"],
            ["E[attribute=value]",  "E[attribute = 'value']"],
            
            ["div[align=left]",     "div[align = 'left']"],
            ["div[align = left]",   "div[align = 'left']"],
            ["div[align =left]",    "div[align = 'left']"],
            ["div[align= left]",    "div[align = 'left']"],
            ["div[title=match]",    "div[title = 'match']"],
            ["label[for=match]",    "label[for = 'match']"],
            
            ["E[attribute~=value]", "E[attribute ~= 'value']"],
            ["E[attribute^=value]", "E[attribute ^= 'value']"],
            ["E[attribute$=value]", "E[attribute $= 'value']"],
            
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
            
            // Pseudo classes
            [":empty"],       ["div:empty"],       ["div :empty"],       ["div > :empty"],
            [":checked"],     ["div:checked"],     ["div :checked"],     ["div > :checked"],
            [":enabled"],     ["div:enabled"],     ["div :enabled"],     ["div > :enabled"],
            [":disabled"],    ["div:disabled"],    ["div :disabled"],    ["div > :disabled"],
            [":selected"],    ["div:selected"],    ["div :selected"],    ["div > :selected"],
            [":last-child"],  ["div:last-child"],  ["div :last-child"],  ["div > :last-child"],
            [":first-child"], ["div:first-child"], ["div :first-child"], ["div > :first-child"],
            
            // Pseudo functions
            [":not(#id)"],    ["div:not(#id)"],    ["div :not(#id)"],    ["div > :not(#id)"],
            [":not(.class)"], ["div:not(.class)"], ["div :not(.class)"], ["div > :not(.class)"],
            [":state(over)"], ["div:state(over)"], ["div :state(over)"], ["div > :state(over)"],
        ];
        
        [Test(dataProvider="valid")]
        public function shouldParse(query:String, expectedOutput:String = ""):void
        {
            var selector:Expression = css.parse(query);
            assertThat(selector, isA(ElementMatcher));
            assertThat(selector, equalTo(expectedOutput || query));
        }
        
        public static var broken:Array = [
            ["p[foo],"],
        ];
        
        [Test(dataProvider="broken", expects="se.stade.parsing.ParseError")]
        public function shouldFailParsing(query:String):void
        {
            var selector:Expression = css.parse(query);
        }
    }
}