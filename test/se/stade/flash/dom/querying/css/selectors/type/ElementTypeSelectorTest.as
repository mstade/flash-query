package se.stade.flash.dom.querying.css.selectors.type
{
    import flash.display.Bitmap;
    import flash.display.DisplayObject;
    import flash.display.Shape;
    import flash.media.Video;
    
    import flexunit.framework.Assert;
    
    import mx.controls.Button;
    import mx.core.UIComponent;
    
    import org.flexunit.assertThat;
    import org.flexunit.runners.Parameterized;
    import org.hamcrest.object.equalTo;
    import org.hamcrest.object.isTrue;
    
    import spark.components.Group;
    
    Parameterized;
    [RunWith("org.flexunit.runners.Parameterized")]
    public class ElementTypeSelectorTest
    {
        private var selector:ElementTypeSelector;
        
        [SetUp]
        public function setup():void
        {
            selector = null;
        }
        
        public static var matchingTypes:Array = [
            [DisplayObject, new Shape, new Video, new Bitmap],
            [UIComponent,   new UIComponent, new Button, new Group]
        ];
        
        [Test(dataProvider="matchingTypes")]
        public function shouldMatchTypes(Type:Class, ... elements):void
        {
            selector = new ElementTypeSelector(Type);
            
            for each (var element:DisplayObject in elements)
            {
                assertThat(selector.matches(element), isTrue());
            }
        }
        
        public static var typeQueries:Array = [
            [UIComponent,   "mx.core|UIComponent"],
            [DisplayObject, "flash.display|DisplayObject"]
        ];
        
        [Test(dataProvider="typeQueries")]
        public function shouldReturnValidExpression(Type:Class,
                                                    expectedExpression:String):void
        {
            selector = new ElementTypeSelector(Type);
            assertThat(selector.toString(), equalTo(expectedExpression));
        }
    }
}
