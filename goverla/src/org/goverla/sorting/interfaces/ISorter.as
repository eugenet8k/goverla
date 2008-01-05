package org.goverla.sorting.interfaces
{
	import mx.collections.ListCollectionView;
	
	import org.goverla.interfaces.IComparer;
	
	public interface ISorter
	{
		
		function sort(list : ListCollectionView, comparer : IComparer) : void;
		
	}
}