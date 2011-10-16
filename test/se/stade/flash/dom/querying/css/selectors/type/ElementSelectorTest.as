package se.stade.flash.dom.querying.css.selectors.type
{
    import flash.display.DisplayObject;
    import flash.display.Shape;
    
    import flexunit.framework.Assert;
    
    import mx.controls.Button;
    import mx.core.UIComponent;
    
    import org.flexunit.assertThat;
    import org.flexunit.runners.Parameterized;
    import org.hamcrest.object.equalTo;
    import org.hamcrest.object.isTrue;
    
    import spark.components.Button;
    
    Parameterized;
    [RunWith("org.flexunit.runners.Parameterized")]
    public class ElementSelectorTest
    {
        private var selector:ElementSelector;
        
        [SetUp]
        public function setup():void
        {
            selector = null;
        }
        
        public static var matchingTypes:Array = [
            ["Shape", new Shape],
            ["flash.display|Shape", new Shape],
            
            ["UIComponent", new UIComponent],
            ["mx.core|UIComponent", new UIComponent],
            
            ["Button", new mx.controls.Button, new spark.components.Button],
            ["spark.components|Button", new spark.components.Button],
        ];
        
        [Test(dataProvider="matchingTypes")]
        public function shouldMatchTypes(name:String, ... elements):void
        {
            if (name.indexOf("|") >= 0)
            {
                selector = new ElementSelector(
                    name.split("|")[1],
                    new NamespaceSelector(name.split("|")[0])
                );
            }
            else
                selector = new ElementSelector(name);
            
            for each (var element:DisplayObject in elements)
            {
                assertThat(selector.matches(element), isTrue());
            }
            
            assertThat(selector.toString(), equalTo(name));
        }
    }
}
