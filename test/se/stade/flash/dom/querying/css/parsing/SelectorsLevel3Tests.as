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
         * been picked up from various sources.
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
            
            /* Tests from: https://github.com/dperini/nwmatcher/blob/master/test/W3C-Selector-tests/W3C-Selector-tests-github.html */
            ["body"],
            ["div"],
            ["div.header"],
            
            [".unitTest"],
            [".test"],
            
            [".UI > *"],
            [".UI"],
            [".tilda"],
            [".plus"],
            
            ["h1, p"],
            ["a"],
            ["#results"],
            ["#root, #root2, #root3"],
            
            [".blox16"],
            [".blox17"],
            [".lastChild > p"],
            [".firstOfType > p"],
            [".lastOfType > p"],
            [".empty > .isEmpty"],
            ["html"],
            
            ["html.nopass pass"],
            
            /* :target selector */
            [".target :target"],
            
            /* test 1 : childhood selector */
            ["html > body"],
            [".test > .blox1"],
            
            /* test 2 : attribute existence selector */
            /* attribute with a value */
            [".blox2[align]"],
            
            /* attribute with empty value */
            [".blox3[align]"],
            
            /* attribute with empty value */
            [".blox4, .blox5"],
            [".blox4[align], .blox5[align]"],
            
            /* test3 : attribute value selector */
            ['.blox6[align="center"]'],
            ['.blox6[align="c"]'],
            ['.blox6[align="centera"]'],
            ['.blox6[foo="\e9"]'],
            ['.blox6[\_foo="c"]'],
            
            /* test 4 : [~=] */
            ['.blox7[class~="foo"]'],
            [".blox8, .blox9, .blox10"],
            ['.blox8[class~=""]'],
            ['.blox9[foo~=""]'],
            ['.blox10[foo~="foo"]'],
            
            /* test5 [^=] */
            [".attrStart > .t3"],
            [".attrStart > .t1[class^='unit']"],
            [".attrStart > .t2"],
            [".attrStart > .t2[class^='nit']"],
            [".attrStart > .t3[class^='']"],
            [".attrStart > .t4[foo^='\e9']"],
            
            /* test6 [$=] */
            [".attrEnd > .t3"],
            [".attrEnd > .t1[class$='t1']"],
            [".attrEnd > .t2"],
            [".attrEnd > .t2[class$='unit']"],
            [".attrEnd > .t3[align$='']"],
            [".attrEnd > .t4[foo$='\e9']"],
            
            /* test7 [*=] */
            ['.attrMiddle > .t3'],
            ['.attrMiddle > .t1[class*="t t"]'],
            ['.attrMiddle > .t2'],
            ['.attrMiddle > .t2[class*="a"]'],
            ['.attrMiddle > .t3[align*=""]'],
            ['.attrMiddle > .t4[foo*="\e9"]'],
            
            /* :first-child tests */
            ['.firstChild .unitTest:first-child'],
            ['.blox12:first-child'],
            ['.blox13:first-child'],
            ['.blox12, .blox13'],
            
            /* :root tests */
            // [':root'], // Root is a pretty useless selector
            
            /* :nth-child(n) tests */
            ['.nthchild1 > :nth-last-child(odd)'],
            ['.nthchild1 > :nth-child(odd)'],
        
            ['.nthchild2 > :nth-last-child(even)'],
            ['.nthchild2 > :nth-child(even)'],
            
            ['.nthchild3 > :nth-child(3n+2)'],
            ['.nthchild3 > :nth-last-child(3n+1)'],
            ['.nthchild3 > :nth-last-child(3n+3)'],
            
            ['.nthoftype1 > div:nth-of-type(odd)'],
            ['.nthoftype1 > div:nth-last-of-type(odd)'],
            ['.nthoftype1 > p'],
            
            ['.nthoftype2 > div:nth-of-type(even)'],
            ['.nthoftype2 > div:nth-last-of-type(even)'],
            ['.nthoftype2 > p'],
            
            ['.nthoftype3 > div:nth-of-type(3n+1)'],
            ['.nthoftype3 > div:nth-last-of-type(3n+1)'],
            ['.nthoftype3 > div:nth-last-of-type(3n+2)'],
            ['.nthoftype3 > p'],
            
            /* :not() tests */
            ['.blox14:not(span)'],
            ['.blox15:not([foo="blox14"])'],
            ['.blox16:not(.blox15)'],
            ['div:not(:not(div))'],
            
            /* :only-of-type tests */
            ['.blox17:only-of-type'],
            ['.blox18:only-of-type'],
            ['.blox18:not(:only-of-type)'],
            
            /* :last-child tests */
            ['.lastChild > :last-child'],
            ['.lastChild > :not(:last-child)'],
            
            /* :first-of-type tests */
            ['.firstOfType > *:first-of-type'],
            ['*.firstOfType > :not(:first-of-type)'],
            
            /* :last-of-type tests */
            ['.lastOfType > *:last-of-type'],
            ['*.lastOfType > :not(:last-of-type)'],
            
            /* :only-child tests */
            ['.onlyChild > *:not(:only-child)'],
            ['.onlyChild > .unitTest > *:only-child'],
        
            /* :only-of-type tests */
            ['.onlyOfType *:only-of-type'],
            ['.onlyOfType *:not(:only-of-type)'],
            
            /* :empty tests */
            ['.empty > *.isEmpty:empty'],
            ['.empty > .isNotEmpty'],
            ['.empty > .isNotEmpty:empty'],
            ['.empty > .isNotEmpty:not(:empty)'],
            
            /* :lang() tests */
            ['.lang :lang(en)'],
            ['.lang :lang(fr)'],
            ['.lang .t1'],
            ['.lang .t1:lang(es)'],
            ['.lang :lang(es-AR)'],
            
            /* [|=] tests */
            ['.attrLang .t1'],
            ['.attrLang .t1[lang|="en"]'],
            ['.attrLang [lang|="fr"]'],
            ['.attrLang .t2[lang|="en"]'],
            ['.attrLang .t3'],
            ['.attrLang .t3[lang|="es"]'],
            ['.attrLang [lang|="es-AR"]'],
            
            /* UI tests */
            ['.UI .t1:enabled > .unitTest'],
            ['.UI .t2:disabled > .unitTest'],
            ['.UI .t3:checked + div'],
            ['.UI .t4:not(:checked) + div'],
            
            /* ~ combinator tests */
            ['.tilda .t1'],
            ['.tilda .t1 ~ .unitTest'],
            ['.tilda .t1:hover ~ .unitTest'],
            
            /* ~ combinator tests */
            ['.plus .t1, .plus .t2'],
            ['.plus .t1 + .unitTest + .unitTest'],
            ['.plus .t1:hover + .unitTest + .unitTest'],
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
            
            ['.blox16:not(.blox15[foo="blox14"]'],
            
            /* Tests from http://www.w3.org/Style/CSS/Test/CSS3/Selectors/20060307/html/index.html */
            ['div,'],
            ['.5cm'],
            ['foo &amp; address, p'],
            ['[*=test]'],
            ['[*|*=test]'],
            
            ['div:subject'],
            [':canvas'],
            [':viewport'],
            [':window'],
            [':root'], // Root is a pretty useless selector so we choose not to implement it
            [':menu'],
            [':table'],
            [':select'],
            ['::canvas'],
            ['::viewport'],
            ['::window'],
            ['::menu'],
            ['::table'],
            ['::select'],
            
            ['..test'],
            ['.foo..quux'],
            ['.bar.'],
        ];
        
        [Test(dataProvider="broken", expects="se.stade.parsing.ParseError")]
        public function shouldFailParsing(query:String):void
        {
            var selector:Expression = css.parse(query);
        }
    }
}