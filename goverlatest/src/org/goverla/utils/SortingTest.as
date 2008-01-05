package org.goverla.utils
{
	import org.flex2unit.framework.TestCase;
	import org.goverla.collections.ArrayList;
	import org.goverla.comparing.ValueComparer;
	import org.goverla.sorting.QuickSorter;

	public class SortingTest extends TestCase
	{
		public function testQuickSort() : void {
			var sorter : QuickSorter = new QuickSorter();
			var list : ArrayList = new ArrayList();
			for(var i : uint = 100; i > 1; i--) {
				list.addItem(Math.random());
			}
			
			sorter.sort(list, new ValueComparer());
			assertTrue(Arrays.isSorted(list));
			
		}
	}
}