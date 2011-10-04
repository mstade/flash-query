package se.stade.flash.dom.traversals
{
    import flash.display.DisplayObject;
    
    import org.flexunit.assertThat;
    import org.hamcrest.object.equalTo;
    
    import spark.components.Button;
    import spark.components.ButtonBar;
    import spark.components.CheckBox;
    import spark.components.Group;
    import spark.components.List;
    import spark.components.RadioButton;
    import spark.components.Scroller;

    public class TraversalTest
    {
        /**
         * Returns the following DOM:
         * <Group>
         * 
         *     <Button />
         *     <List />
         * 
         *     <Group>
         * 
         *         <Group>
         *             <CheckBox />
         *             <ButtonBar />
         *         </Group>
         * 
         *         <Group>
         *             <RadioButton />
         *             <Scroller />
         *         </Group>
         * 
         *     </Group>
         * 
         * </Group>
         */
        public static function createDOM():DisplayObject
        {
            var group:Group = new Group;
            group.addElement(new Button);
            group.addElement(new List);
            
            var subGroup:Group = group.addElement(new Group) as Group;
            var subSubGroup1:Group = subGroup.addElement(new Group) as Group;
            subSubGroup1.addElement(new CheckBox);
            subSubGroup1.addElement(new ButtonBar);
            
            var subSubGroup2:Group = subGroup.addElement(new Group) as Group;
            subSubGroup2.addElement(new RadioButton);
            subSubGroup2.addElement(new Scroller);
            
            return group;
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