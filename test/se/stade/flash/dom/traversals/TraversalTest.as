package se.stade.flash.dom.traversals
{
    import flash.display.DisplayObject;
    
    import org.flexunit.assertThat;
    import org.hamcrest.object.equalTo;
    
    import se.stade.flash.dom.manipulation.mxml.MXMLBuilder;

    public class TraversalTest
    {
        public static function createDOM():DisplayObject
        {
            return new MXMLBuilder(
                <Group xmlns="library://ns.adobe.com/flex/spark">
                    <Button />
                    <List />
                                
                    <Group>
                        <Group>
                            <CheckBox />
                            <ButtonBar />
                        </Group>
                                
                        <Group>
                            <RadioButton />
                            <Scroller />
                        </Group>
                    </Group>
                </Group>).build();
        }
        
        public function assertHasNext(traverser:DisplayListTraversal, times:uint):void
        {
            var count:uint;
            
            while (traverser.hasNext)
            {
                traverser.getNext();
                count++;   
            }
            
            assertThat(count, equalTo(times))
        }
        
        public function assertReset(traverser:DisplayListTraversal, times:uint):void
        {
            while (traverser.getNext()) {}
            
            traverser.reset();
            assertHasNext(traverser, times);
        }
    }
}