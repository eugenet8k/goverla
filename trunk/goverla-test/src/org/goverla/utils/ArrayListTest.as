package org.goverla.utils
{
	import mx.collections.ArrayCollection;
	
	import org.flex2unit.framework.TestCase;
	import org.goverla.collections.ArrayList;

	public class ArrayListTest extends TestCase
	{
		public function testGetItemIndices() : void 
		{
			var array : Array = ["a", "b", "a", "c", "a", "a"];
			var list : ArrayList = new ArrayList(array);
			var indices : ArrayList = list.getItemIndices("a");
			assertTrue(indices.contains(0));
			assertTrue(indices.contains(2));
			assertTrue(indices.contains(4));
			assertTrue(indices.contains(5));
			assertEquals(indices.length, 4);

			
		}
		
		public function testJoin() : void {
			var array : Array = ["a", "b", "c"];
			var list : ArrayList = new ArrayList(array);
			var result : String = list.join("\\");
			assertEquals(result, "a\\b\\c");
			
		}
		public function testReverse() : void {
			var array : Array = ["a", "b", "c"];
			var list : ArrayList = new ArrayList(array);
			list.reverse();
			assertEquals(list.getItemAt(0), "c");
			assertEquals(list.getItemAt(1), "b");
			assertEquals(list.getItemAt(2), "a");
			
		}
		
		public function testForEach() : void {
			var array : Array = ["a", "b", "c"];
			var list : ArrayList = new ArrayList(array);
			var index : uint = 0;
			for each(var obj : String in list) {
				assertEquals(obj, array[index]);
				index++;
			}
			assertEquals(index, array.length);
			
		}
		
		public function testAddItems() : void {
			
			var source : ArrayCollection = new ArrayCollection([1, "2", new Object()]);
			var result : ArrayList = new ArrayList(new ArrayCollection());
			
			result.addItems(source);
			
			assertEquals(source.length, result.length);
			for (var i : uint = 0; i < source.length; i++) {
				assertEquals(result.getItemAt(i), source.getItemAt(i));
			}
		}
		
		public function testAddFirst() : void {
			
			var sourceItem : Object = new Object();
			var sourceArray : Array = new Array(1, "2", sourceItem);
			var testArray : Array = new Array(1, "2", sourceItem);
			var source : ArrayCollection = new ArrayCollection(sourceArray);
			var item : Object = new Object();
			var result : ArrayList = new ArrayList(source);
			
			result.addFirst(item);
			
			assertEquals(4, result.length);
			assertEquals(result.getItemAt(0), item);
			for (var i : uint = 0; i < testArray.length; i++) {
				assertEquals(testArray[i], result.getItemAt(i + 1));
			}
		}
		
		public function testAddLast() : void {
			
			var source : ArrayCollection = new ArrayCollection([1, "2", new Object()]);
			var item : Object = new Object();
			var result : ArrayList = new ArrayList(source);
			
			result.addLast(item);
			
			assertEquals(4, result.length);
			assertEquals(result.getItemAt(result.length - 1), item);
		}
		
		public function testRemoveFirst() : void {
			
			var source : ArrayCollection = new ArrayCollection([new Object(), 1, "2"]);
			var result : ArrayList = new ArrayList(source);
			
			result.removeFirst();
			
			assertEquals(2, result.length);
			assertEquals(result.getItemAt(0), 1);
			assertEquals(result.getItemAt(1), "2");
		}
		
		public function testRemoveLast() : void {
			
			var source : ArrayCollection = new ArrayCollection([1, "2", new Object()]);
			var result : ArrayList = new ArrayList(source);
			
			result.removeLast();
			
			assertEquals(2, result.length);
			assertEquals(result.getItemAt(0), 1);
			assertEquals(result.getItemAt(1), "2");
		}
		
		public function testRemoveItems() : void {
			
			var obj : Object = new Object();
			var source : ArrayCollection = new ArrayCollection([1, "2", obj]);
			var result : ArrayList = new ArrayList(new ArrayCollection(["string", 1, obj, "2"]));
			
			result.removeItems(source);
			
			assertEquals(1, result.length);
			assertEquals(result.getItemAt(0), "string");
		}
		
		public function testSubList() : void {
			
			var list : ArrayList = new ArrayList();
			var countAll : int = 10;
			var count : int = 5;
			var beginIndex : int = 3;
			
			for (var i : int = 0; i < countAll; i++) {
				list.addItem(new Object());
			}
			
			var result : ArrayList = list.subList(beginIndex, count);
			
			assertEquals(result.length, count);
			
			for (i = 0; i < count; i++) {
				assertEquals(result.getItemAt(i), list.getItemAt(beginIndex + i));
			}
		}
		
		public function testRetainItems() : void {
			
			var obj : Object = new Object();
			var source : ArrayCollection = new ArrayCollection([1, "2", obj]);
			var result : ArrayList = new ArrayList(new ArrayCollection(["string", 1, obj, "2"]));
			
			result.retainItems(source);
			
			assertEquals(3, result.length);
			
			for (var i : int = 0; i < 3; i++) {
				assertTrue(result.contains(source.getItemAt(i)));
			}
		}
		
		public function testSetItems() : void {
			
			var obj1 : Object = new Object();
			var obj2 : Object = new Object();
			var beginIndex : int = 1;
			var source : ArrayList = new ArrayList(["5", 4, obj2]);
			var result : ArrayList = new ArrayList(new ArrayCollection(["string", 1, obj1, "2"]));
			
			result.setItems(source, beginIndex);
			
			for (var i : int = 0; i < 3; i++) {
				assertEquals(result.getItemAt(beginIndex + i), source.getItemAt(i));
			}
		}
		
		public function testAddItemsAt() : void {
			
			var obj1 : Object = new Object();
			var obj2 : Object = new Object();
			var beginIndex : int = 1;
			var source : ArrayList = new ArrayList(["5", 4, obj2]);
			var result : ArrayList = new ArrayList(new ArrayCollection(["string", 1, obj1, "2"]));
			
			result.addItemsAt(source, beginIndex);
			
			for (var i : int = 0; i < 3; i++) {
				assertEquals(result.getItemAt(beginIndex + i), source.getItemAt(i));
			}
		}
		
		public function testContainsItems() : void {
			
			var obj : Object = new Object();
			var source : ArrayCollection = new ArrayCollection([1, "2", obj]);
			var result : ArrayList = new ArrayList(new ArrayCollection(["string", 1, obj, "2"]));
			
			assertTrue(result.containsItems(source));
		}

		public function testLength() : void {
			var result : ArrayList = new ArrayList(new ArrayCollection(["string", 1, "ascsd", "2"]));
			assertEquals(result.length, 4);
		}
		
	}
}