package org.goverla.utils {
	
	import mx.collections.ArrayCollection;
	import mx.collections.ListCollectionView;
	
	import org.flex2unit.framework.TestCase;
	import org.goverla.collections.ArrayList;
	import org.goverla.collections.ListCollectionViewIterator;
	import org.goverla.utils.comparing.PropertyCompareRequirement;
	import org.goverla.utils.comparing.ValueComparer;
	import org.goverla.utils.converting.StringToBooleanConverter;
	import org.goverla.utils.sorting.NormalSorter;

	public class ArraysTest extends TestCase {
		
		public function testSort() : void {
			var sorter : NormalSorter = new NormalSorter();
			var list : ArrayList = new ArrayList();
			for(var i : uint = 100; i > 1; i--) {
				list.addItem(Math.random());
			}
			
			sorter.sort(list, new ValueComparer());
			assertTrue(Arrays.isSorted(list));
			
		}
		
		public function testIsSorted() : void {
			var list : ArrayList = new ArrayList();
			for(var i : uint = 0; i < 100; i++) {
				list.addItem(i);
			}
			assertTrue(Arrays.isSorted(list));
			list.addFirst(1);
			assertFalse(Arrays.isSorted(list));
			
		}

		public function testRepeatItem() : void {
			
			var count : int = 10;
			var item : Object  = new Object();
			var result : Array = Arrays.repeatItem(item, count);
			for(var i : int = 0; i < count; i++) {
				assertEquals(result[i], item);
			}
			
		}
		
		public function testInsertAll() : void {
			
			var count : int = 10;
			var result : ListCollectionView = new ArrayCollection();
			var list : ListCollectionView = new ArrayCollection();
			
			for (var i : int = 0; i < count; i++) { 
				list.addItem(new Object());
			}
			
			result = Arrays.insertAll(result, list);
			assertEquals(result.length, count);
			
			for (i = 0; i < count; i++) { 
				assertEquals(result.getItemAt(i), list.getItemAt(i));
			}
		}
		
		public function testSubList() : void {
			
			var list : ListCollectionView = new ArrayCollection();
			var countAll : int = 10;
			var count : int = 5;
			var beginIndex : int = 3;
			
			for (var i : int = 0; i < countAll; i++) {
				list.addItem(new Object());
			}
			
			var result : ArrayCollection = Arrays.subList(list, beginIndex, count);
			
			assertEquals(result.length, count);
			
			for (i = 0; i < count; i++) {
				assertEquals(result.getItemAt(i), list.getItemAt(beginIndex + i));
			}
		}
		
   		public function testRemoveItems() : void {
   			
   			var list : ListCollectionView = new ArrayCollection();
   			var result : ListCollectionView = new ArrayCollection();
			var countAll : int = 10;
			var count : int = 5;
			var beginIndex : int = 3;
			
			for (var i : int = 0; i < countAll; i++) {
				var item : Object = new Object();
				list.addItem(item);
				result.addItem(item);
			}
			
			Arrays.removeItems(result, beginIndex, count);
			
			assertEquals(result.length, countAll - count);
			
			for (i = 0; i < beginIndex; i++) {
				assertEquals(result.getItemAt(i), list.getItemAt(i));
			}

			for (i = beginIndex; i < result.length; i++) {
				assertEquals(result.getItemAt(i), list.getItemAt(i + count));
			}
   		}
   		
   		public function testRemoveAll() : void {
   			
   			var initialList : ListCollectionView = new ArrayCollection();
   			var list : ListCollectionView = new ArrayCollection();
   			var result : ListCollectionView = new ArrayCollection();
			var countAll : int = 10;
			var count : int = 5;
			var beginIndex : int = 3;
			
			for (var i : int = 0; i < countAll; i++) {
				var item : Object = new Object();
				list.addItem(item);
				result.addItem(item);
				initialList.addItem(item);
			}
			
			Arrays.removeItems(list, beginIndex, count);
			
			Arrays.removeAll(result, list);
			
			assertEquals(result.length, count);
			
			for (i = 0; i < count; i++) {
				assertEquals(result.getItemAt(i), initialList.getItemAt(beginIndex + i));
			}
   		}
   		
   		public function testGetConverted() : void {
   			
   			var list : ListCollectionView = new ArrayCollection();
   			var result : ArrayCollection = new ArrayCollection();
			var converter : StringToBooleanConverter = new StringToBooleanConverter();
			var countAll : uint = 10; 
			
			for (var i : uint = 0; i < countAll; i++) {
				var itemTrue : String = new String("true");
				list.addItem(itemTrue);
			}
			for (i = 0; i < countAll; i++) {
				var itemFalse : String = new String("false");
				list.addItem(itemFalse);
			}
			
			result = Arrays.getConverted(list, converter);

			for (i = 0; i < countAll; i++) {
				assertTrue("Arrays.getConverted", result.getItemAt(i));
			}
			for (i = 0; i < countAll; i++) {
				assertFalse("Arrays.getConverted", result.getItemAt(countAll + i));
			}
   		}
   		
   		public function testFindSimilarElements() : void {
   			
   			var list1 : ArrayCollection = new ArrayCollection();
   			var list2 : ArrayCollection = new ArrayCollection();
   			var result : ArrayCollection = new ArrayCollection();
			var count1 : uint = 5;
			var count2 : uint = 5;
			var countSimilar : uint = 5;
			
			for (var i : uint = 0; i < count1; i++) {
				list1.addItem(new Object());
			}
			for (i = 0; i < countSimilar; i++) {
				var item : Object = new Object();
				list1.addItem(item);
				list2.addItem(item);
			}
			for (i = 0; i < count2; i++) {
				list2.addItem(new Object());
			}
			
			result = Arrays.findSimilarElements(list1, list2);
			
			assertEquals(result.length, countSimilar);
			
			for (i = 0; i < countSimilar; i++) {
				assertEquals(result.getItemAt(i), list1.getItemAt(count1 + i));
			}
   		}
   		
   		public function testMerge() : void {
   			
   			var list1 : ListCollectionView = new ArrayCollection();
   			var list2 : ListCollectionView = new ArrayCollection();
   			var result : ArrayCollection = new ArrayCollection();
			var count1 : uint = 5;
			var count2 : uint = 5;
			
			for (var i : uint = 0; i < count1; i++) {
				list1.addItem(new Object());
			}
			for (i = 0; i < count2; i++) {
				list2.addItem(new Object());
			}
			
			result = Arrays.merge(list1, list2);
			
			assertEquals(result.length, count1 + count2);
			
			for (i = 0; i < count1; i++) {
				assertEquals(result.getItemAt(i), list1.getItemAt(i));
			}
			for (i = 0; i < count2; i++) {
				assertEquals(result.getItemAt(count1 + i), list2.getItemAt(i));
			}
   		}
   		
   		public function testObjectToArray() : void {
   			
   			var count : uint = 10;
   			var item : Object = new Object();
   			
   			for (var i : uint = 0; i < count; i++) {
	   			item["property" + i] = "value" + i;
   			}
   			
   			var result : Array = Arrays.objectToArray(item);
   			
   			assertEquals(result.length, count);

			result.sort();
   			for (i = 0; i < count; i++) {
				assertEquals(result[i], item["property" + i]);
   			}
   		}
   		
   		public function testGetByRequirement() : void {
   			
			var count : int = 10;
			var propertyName : String = new String("property1");
			var propertyValue : String = new String("someValue");
			var list : ListCollectionView = new ArrayCollection();
			
			for (var i : int = 0; i < count; i++) {
				var item : Object = new Object();
				item["property" + i] = propertyValue;
				list.addItem(item);
			}
			
			var iterator : ListCollectionViewIterator = new ListCollectionViewIterator(list);
			var requirement : PropertyCompareRequirement = new PropertyCompareRequirement(propertyName, propertyValue);
			
			var result : ArrayCollection = Arrays.getByRequirement(iterator, requirement);
			
			assertEquals(result.length, 1);
			
			assertEquals(result.getItemAt(0), list.getItemAt(1));
   		}
   		
   		public function testGetByRequirements() : void {
   			
   			var count : uint = 10;
   			var countRequirements : uint = 5;
   			var propertyValue : String = new String("someValue");
			var list : ListCollectionView = new ArrayCollection();
			
			for (var i : uint = 0; i < count; i++) {
				var item1 : Object = new Object();
				for (var j : uint = 0; j <= i; j++) {
					item1["property" + j] = propertyValue;
				}
				list.addItem(item1);
			}
			
			var iterator : ListCollectionViewIterator = new ListCollectionViewIterator(list);
			var requirements : ArrayCollection = new ArrayCollection();
			
			for (i = 0; i < countRequirements; i++) {
				requirements.addItem(new PropertyCompareRequirement("property" + i, propertyValue));
			}
			
			var result : ArrayCollection = Arrays.getByRequirements(iterator, requirements);
			
			assertEquals(result.length, count - (countRequirements - 1));
			
			for (i = 0; i < count - (countRequirements - 1); i++) {
				assertEquals(result.getItemAt(i), list.getItemAt(i + countRequirements - 1));
			}
   		}
   		
   		public function testContainsByRequirement() : void {
   			
			var count : int = 10;
			var propertyName : String = new String("property1");
			var propertyValue : String = new String("someValue");
			var list : ListCollectionView = new ArrayCollection();
			
			for (var i : int = 0; i < count; i++) {
				var item : Object = new Object();
				item["property" + i] = propertyValue;
				list.addItem(item);
			}
			
			var iterator : ListCollectionViewIterator = new ListCollectionViewIterator(list);
			var requirement : PropertyCompareRequirement = new PropertyCompareRequirement(propertyName, propertyValue);
			
			var result : Boolean = Arrays.containsByRequirement(iterator, requirement);
			
			assertTrue("Arrays.containsByRequirement", result);
   		}
   		
   		public function testIndexByRequirement() : void {
   			
			var count : int = 10;
			var itemIndex : uint = 1;
			var propertyName : String = new String("property" + itemIndex);
			var propertyValue : String = new String("someValue");
			var list : ListCollectionView = new ArrayCollection();
			var array : Array = new Array();
			
			for (var i : int = 0; i < count; i++) {
				var item : Object = new Object();
				item["property" + i] = propertyValue;
				list.addItem(item);
				array.push(item);
			}
			
			var requirement : PropertyCompareRequirement = new PropertyCompareRequirement(propertyName, propertyValue);
			
			var resultList : uint = Arrays.indexByRequirement(list, requirement);
			var resultArray : uint = Arrays.indexByRequirement(array, requirement);
			
			assertEquals(resultList, itemIndex);
			assertEquals(resultArray, itemIndex);
   		}
   		
   		public function testUpdateByList() : void {
   			var list1 : ArrayCollection = new ArrayCollection([1, 2, 3, 4, 5]);
   			var list2 : ArrayCollection = new ArrayCollection([3, 4, 5, 6, 7]);
   			
   			Arrays.updateByList(list1, list2);
   			
   			assertEquals(list1.getItemAt(0), 3);
   			assertEquals(list1.getItemAt(1), 4);
   			assertEquals(list1.getItemAt(2), 5);
   			assertEquals(list1.getItemAt(3), 6);
   			assertEquals(list1.getItemAt(4), 7);
   		}
   		
   	}
}