package se.stade.flash.dom.traversals
{
    import flash.display.DisplayObject;
    
    import flexunit.framework.Assert;
    
    import org.flexunit.assertThat;
    import org.hamcrest.core.isA;
    
    import spark.components.CheckBox;
    import spark.components.RadioButton;
    
    public class PrecedingSiblingTraversalTest extends TraversalTest
    {		
        private var traverser:PrecedingSiblingTraversal;
        
        [Before]
        public function setUp():void
        {
            var dom:Object = createDOM(); 
            var start1:DisplayObject = dom.getElementAt(2).getElementAt(0).getElementAt(1);
            var start2:DisplayObject = dom.getElementAt(2).getElementAt(1).getElementAt(1);
            
            traverser = new PrecedingSiblingTraversal(new <DisplayObject>[start1, start2]);
        }
        
        [Test]
        public function shouldReturnCheckBoxAndRadioButton():void
        {
            assertThat(traverser.getNext(), isA(CheckBox));
            assertThat(traverser.getNext(), isA(RadioButton));
        }
        
        [Test]
        public function shouldReturnHasNextTwice():void
        {
            assertHasNext(traverser, 2);
        }
        
        [Test]
        public function shouldReturnHasNextTwiceAfterReset():void
        {
            assertReset(traverser, 2);
        }
    }
}