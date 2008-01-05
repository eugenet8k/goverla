package org.goverla.collections
{
	import org.flex2unit.framework.TestCase;

	public class TypedArrayCollectionTest extends TestCase
	{
		
		public function testAddAndGet() : void {
			
			var collection : TypedArrayCollection = new TypedArrayCollection(String);
			var element1 : String = "first element";
			var element2 : String = "second element";
			
			collection.addItem(element1);
			collection.addItem(element2);
			
			assertEquals(element1, collection.getItemAt(0));
			assertEquals(element2, collection.getItemAt(1));
		}
	}
}