package se.stade.flash.dom.manipulation.mxml
{
    import mx.controls.Button;
    
    import org.flexunit.assertThat;
    import org.hamcrest.core.isA;
    import org.hamcrest.object.notNullValue;
    
    import spark.components.Button;
    import spark.components.Group;
    import spark.components.List;
    
    public class MXMLBuilderTest
    {
        private var document:MXMLBuilder;
        
        [Before]
        public function setUp():void
        {
            document = new MXMLBuilder(
                <Group xmlns="library://ns.adobe.com/flex/spark"
                       xmlns:mx="library://ns.adobe.com/flex/mx">
                    <Button />
                
                    <Group>
                        <layout>
                            <HorizontalLayout />
                        </layout>
                
                        <Group>
                            <Button />
                            <mx:Button />
                        </Group>
                    </Group>
                
                    <List />
                </Group>
            );
        }
        
        [Test]
        public function shouldBuildDomFromXML():void
        {
            var root:Group = document.build() as Group;
            assertThat(root, notNullValue());
            assertThat(root.getElementAt(0), isA(spark.components.Button));
            assertThat(root.getElementAt(2), isA(spark.components.List));
            
            var level1:Group = root.getElementAt(1) as Group;
            assertThat(level1, notNullValue());
            
            var level2:Group = level1.getElementAt(0) as Group;
            assertThat(level2, notNullValue());
            assertThat(level2.getElementAt(0), isA(spark.components.Button));
            assertThat(level2.getElementAt(1), isA(mx.controls.Button));
        }
    }
}