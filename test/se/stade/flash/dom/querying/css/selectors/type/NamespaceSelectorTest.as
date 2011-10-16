package se.stade.flash.dom.querying.css.selectors.type
{
    import flash.display.Bitmap;
    import flash.display.DisplayObject;
    import flash.display.Shape;
    import flash.media.Video;
    
    import mx.controls.Image;
    import mx.core.UIComponent;
    
    import org.flexunit.assertThat;
    import org.flexunit.runners.Parameterized;
    import org.hamcrest.object.equalTo;
    import org.hamcrest.object.isFalse;
    import org.hamcrest.object.isTrue;
    
    import spark.components.Button;
    import spark.components.Group;
    
    Parameterized;
    [RunWith("org.flexunit.runners.Parameterized")]
    public class NamespaceSelectorTest
    {
        private var selector:NamespaceSelector;
        
        [Before]
        public function setUp():void
        {
            selector = null;
        }
        
        public static var matchingElements:Array = [
            ["*",                true, new UIComponent, new Image],
            ["foo",              false, new Video, new UIComponent],
            ["flash.display",    true, new Shape, new Bitmap],
            ["spark.components", true, new Button, new Group]
        ];
        
        [Test(dataProvider="matchingElements")]
        public function shouldMatchAccordingToSecondParameter(name:String,
                                                              shouldMatch:Boolean,
                                                              ... elements):void
        {
            selector = new NamespaceSelector(name);
            
            for each (var element:DisplayObject in elements)
            {
                assertThat(selector.matches(element), equalTo(shouldMatch));
            }
        }

        public static var namespaces:Array = [
            ["*"],
            ["foo"],
            ["flash.display"],
            ["some.namespace.that.might.be.a.little.bit.longer.than.usual"]
        ];
        
        [Test(dataProvider="namespaces")]
        public function shouldReturnCSSQuery(name:String):void
        {
            selector = new NamespaceSelector(name);
            assertThat(selector.toString(), equalTo(name + "|"));
        }
    }
}
