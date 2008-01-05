package org.goverla.collections
{
	import mx.collections.ArrayCollection;
	
	import org.flex2unit.framework.TestCase;

	public class ListCollectionViewIteratorTest extends TestCase
	{
		
		public function testNext() : void {
			
			var list : ArrayCollection = new ArrayCollection();
			var obj : Object = new Object();
			
			list.addItem(obj);
			
			var iterator : ListCollectionViewIterator = new ListCollectionViewIterator(list);
			
			assertTrue("ListCollectionViewIterator.hasNext()", iterator.hasNext());
			assertEquals(iterator.next(), obj);
			assertFalse("ListCollectionViewIterator.hasNext()", iterator.hasNext());
		}
	}
}