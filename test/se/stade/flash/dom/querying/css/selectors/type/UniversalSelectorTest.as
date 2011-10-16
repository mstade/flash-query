package se.stade.flash.dom.querying.css.selectors.type
{
    import flash.display.Bitmap;
    import flash.display.DisplayObject;
    import flash.display.Shape;
    import flash.media.Video;
    
    import mx.core.UIComponent;
    
    import org.flexunit.assertThat;
    import org.flexunit.runners.Parameterized;
    import org.hamcrest.object.equalTo;
    import org.hamcrest.object.isTrue;
    
    import spark.components.Button;
    
    Parameterized;
    [RunWith("org.flexunit.runners.Parameterized")]
    public class UniversalSelectorTest
    {
        private var selector:UniversalSelector;
        
        [Before]
        public function setUp():void
        {
            selector = UniversalSelector.Instance;
        }
        
        public static var elements:Array = [
            [new Shape],
            [new Bitmap],
            [new Video],
            [new UIComponent],
            [new Button]
        ];
        
        [Test(dataProvider="elements")]
        public function shouldMatchEverything(element:DisplayObject):void
        {
            assertThat(selector.matches(element), isTrue());
        }
        
        [Test]
        public function shouldReturnCSSQuery():void
        {
            assertThat(selector.toString(), equalTo("*"));
        }
    }
}
