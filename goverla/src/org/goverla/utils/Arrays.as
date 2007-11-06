package org.goverla.utils {

	import mx.collections.ArrayCollection;
	import mx.collections.ListCollectionView;
	
	import org.goverla.collections.ListCollectionViewIterator;
	import org.goverla.collections.interfaces.IIterator;
	import org.goverla.collections.interfaces.IMap;
	import org.goverla.reflection.overload.Overload;
	import org.goverla.utils.interfaces.IConverter;
	import org.goverla.utils.interfaces.IRequirement;
	
	/**
	 * @author Maxym Hryniv
	 * @author Tutunnyk Eugene
	 */
	public class Arrays {
		
		public static function forceArray(source : Object) : Array {
			return source == null ? [] : source as Array;
		}
		
		public static function itemsEqual(firstList : ListCollectionView, secondList : ListCollectionView) : Boolean {
			if(firstList == secondList) 
				return true;
			if(firstList.length != secondList.length) 
				return false;


			var result : Boolean = true;
			for(var i : int = 0; i < firstList.length; i++) {
				if(firstList.getItemAt(i) != secondList.getItemAt(i)) {
					result = false;
					break;
				}
			}
			return result;
		}
		
		public static function removeItem(item : Object, list : Object) : Object {
			var o : Overload = new Overload(Arrays);
			o.addHandler([Object, Array], removeItemForArray);
			o.addHandler([Object, ListCollectionView], removeItemForListCollectionView);
			return o.forward(arguments);
		}	

		public static function removeItemForListCollectionView(item : Object, list : ListCollectionView) : Object {
			var index : int = list.getItemIndex(item);
			list.removeItemAt(index);
			return item;
		}
		
		public static function removeItemForArray(item : Object, list : Array) : Object {
			var index : int = list.indexOf(item);
			list.splice(index, 1);
			return item;
		}		
		
		public static function repeatItem(item : Object, length : Number) : Array {
			var list : ArrayCollection = new ArrayCollection();
			for (var index : Number = 0; index < length; index++) {
				list.addItem(item);	
			}
			return list.toArray();
		}
	
		public static function insertAll(target : ListCollectionView, list : ListCollectionView) : ListCollectionView {
			for(var i : Number = 0; i < list.length; i++) {
				target.addItem(list.getItemAt(i)); 
			}
			return target;
		}

		public static function subList(source : ListCollectionView, beginIndex : uint, length : uint) : ArrayCollection {
			var result : ArrayCollection = new ArrayCollection();
			for(var i : Number = 0; i < length; i++) {
				result.addItem(source.getItemAt(beginIndex + i)); 
			}
			return result;
		}

		public static function removeItems(source : ListCollectionView, beginIndex : uint, count : uint ) : void {
			for(var i : uint = 0; i < count; i++) {
				source.removeItemAt(beginIndex); 
			}
		}

		public static function removeAll(source : ListCollectionView, items : ListCollectionView) : void {
			for(var i : Number = 0; i < items.length; i++) {
				source.removeItemAt(source.getItemIndex(items.getItemAt(i))); 
			}
		}
		
		public static function forceSize(collection : ListCollectionView, length : int, defaultElement : Object) : void {
			if(collection.length > length) {
				removeItems(collection, length, collection.length - length);
			}
			if(collection.length < length) {
				var difference : Number = length - collection.length;
				insertAll(collection, new ArrayCollection(Arrays.repeatItem(defaultElement, difference))); 
			}
		}

		public static function getConverted(list : ListCollectionView, converter : IConverter) : ArrayCollection {
			var result : ArrayCollection = new ArrayCollection();
			for(var i : Number = 0; i < list.length; i++) {
				result.addItem(converter.convert(list.getItemAt(i))); 
			}
			return result;
		}
		
		public static function firstByRequirement(collection : Object, requirement : IRequirement) : Object {
			return getByRequirement(collection, requirement).getItemAt(0);
		}		
		
		public static function removeByRequirement(collection : ListCollectionView, requirement : IRequirement) : ArrayCollection {
			var items : ArrayCollection = getByRequirement(collection, requirement);
			removeAll(collection, items); 
			return items;
		}		

		public static function getByRequirement(collection : Object, requirement : IRequirement) : ArrayCollection {
			var o : Overload = new Overload(Arrays);
			o.addHandler([Array, IRequirement], getByRequirementForArray);
			o.addHandler([ListCollectionView, IRequirement], getByRequirementForListCollectionView);
			o.addHandler([IMap, IRequirement], getByRequirementForMap);
			o.addHandler([IIterator, IRequirement], getByRequirementForIIterator);
			return ArrayCollection(o.forward(arguments));
		}
		
		private static function getByRequirementForArray(array : Array, requirement : IRequirement) : ArrayCollection {
			return getByRequirement(new ArrayCollection(array), requirement);
		}
	
		private static function getByRequirementForListCollectionView(list : ListCollectionView, requirement : IRequirement) : ArrayCollection {
			return getByRequirement(new ListCollectionViewIterator(list), requirement);
		}
		
		private static function getByRequirementForMap(map : IMap, requirement : IRequirement) : ArrayCollection {
			return getByRequirement(map.valueIterator(), requirement);
		}
		
		private static function getByRequirementForIIterator(iterator : IIterator, requirement : IRequirement) : ArrayCollection {
			var result : ArrayCollection = new ArrayCollection();
			while (iterator.hasNext()) {
				var obj : Object = iterator.next();
				if(requirement.meet(obj)) {
					result.addItem(obj);
				}						
			}
			return result;
		}
		
		public static function firstByRequirements(collection : Object, requirements : ArrayCollection) : Object {
			return getByRequirements(collection, requirements).getItemAt(0);
		}		
		public static function getByRequirements(collection : Object, requirements : ArrayCollection) : ArrayCollection {
			var o : Overload = new Overload(Arrays);
			o.addHandler([ListCollectionView, ArrayCollection], getByRequirementsForListCollectionView);
			o.addHandler([IMap, ArrayCollection], getByRequirementsForMap);
			o.addHandler([IIterator, ArrayCollection], getByRequirementsForIIterator);
			return ArrayCollection(o.forward(arguments));		
		}
		
		private static function getByRequirementsForListCollectionView(list : ListCollectionView, requirements : ArrayCollection) : ArrayCollection {
			return getByRequirements(new ListCollectionViewIterator(list), requirements);
		}
		
		private static function getByRequirementsForMap(map : IMap, requirements : ArrayCollection) : ArrayCollection {
			return getByRequirements(map.valueIterator(), requirements);
		}
		
		private static function getByRequirementsForIIterator(iterator : IIterator, requirements : ArrayCollection) : ArrayCollection {
			var result : ArrayCollection = new ArrayCollection();		
			while (iterator.hasNext()) {
				var obj : Object = iterator.next();
				var allSatisfied : Boolean = true;
				for (var i : uint = 0; i < requirements.length; i++) {
					var requirement : IRequirement = IRequirement(requirements.getItemAt(i));
					if (!requirement.meet(obj)) {
						allSatisfied = false;
						break;
					}
				}
				if (allSatisfied) {
					result.addItem(obj);
				}
			}
			return result;	
		}	
	
		public static function containsByRequirement(collection : Object, requirement : IRequirement) : Boolean {
			var o : Overload = new Overload(Arrays);
			o.addHandler([Array, IRequirement], containsByRequirementForArray);
			o.addHandler([ListCollectionView, IRequirement], containsByRequirementForListCollectionView);
			o.addHandler([IMap, IRequirement], containsByRequirementForMap);
			o.addHandler([IIterator, IRequirement], containsByRequirementForIIterator);
			return o.forward(arguments);
		}
	
		private static function containsByRequirementForArray(list : Array, requirement : IRequirement) : Boolean {
			return containsByRequirement(new ArrayCollection(list), requirement);
		}
	
		private static function containsByRequirementForListCollectionView(list : ListCollectionView, requirement : IRequirement) : Boolean {
			return containsByRequirement(new ListCollectionViewIterator(list), requirement);
		}
	
		private static function containsByRequirementForMap(map : IMap, requirement : IRequirement) : Boolean {
			return containsByRequirement(map.valueIterator(), requirement);
		}
	
		private static function containsByRequirementForIIterator(iterator : IIterator, requirement : IRequirement) : Boolean {
			var result : ArrayCollection = getByRequirementForIIterator(iterator, requirement);
			return Boolean(result.length > 0);
		}
	
		public static function indexByRequirement(collection : Object, requirement : IRequirement) : int {
			var o : Overload = new Overload(Arrays);
			o.addHandler([Array, IRequirement], indexByRequirementForArray);
			o.addHandler([ListCollectionView, IRequirement], indexByRequirementForListCollectionView);
			return int(o.forward(arguments));
		}
		
		private static function indexByRequirementForArray(collection : Array, requirement : IRequirement) : int {
			var object : Object = getByRequirement(collection, requirement).getItemAt(0);
			return collection.indexOf(object);
		}

		private static function indexByRequirementForListCollectionView(collection : ListCollectionView, requirement : IRequirement) : int {
			var object : Object = getByRequirement(collection, requirement).getItemAt(0);
			return collection.getItemIndex(object);
		}

		public static function findSimilarElements(list1 : ArrayCollection, list2 : ArrayCollection) : ArrayCollection {
			var result : ArrayCollection = new ArrayCollection();
			for(var i : Number = 0; i < list1.length; i++) {
				if(list2.contains(list1.getItemAt(i))) {
					var index : Number = list2.getItemIndex(list1.getItemAt(i));
					result.addItem(list2.getItemAt(index));
				}
			}
			return result;
		}
		
		public static function addItems(target : ListCollectionView, items : ListCollectionView) : ListCollectionView {
			return addItemsAt(target, items, target.length);
		}		
		
		public static function addItemsAt(target : ListCollectionView, items : ListCollectionView, index : int) : ListCollectionView {
			for(var i : int = items.length - 1; i >= 0; i--) {
				target.addItemAt(items.getItemAt(i), index);
			}
			return target;
		}		
		
		public static function merge(firstListCollectionView : ListCollectionView, secondListCollectionView : ListCollectionView) : ArrayCollection {
			var result : ArrayCollection = new ArrayCollection();
			insertAll(result, firstListCollectionView);			
			insertAll(result, secondListCollectionView);			
			return result;
		}

		public static function clone(source : Array) : Array {
			var result : Array = new Array();
			for(var i : int = 0; i < source.length; i++) {
				result[i] = source[i];
			}
			return result;
		}
	
		public static function objectToArray(source : Object) : Array {
			var result : Array = new Array();
			for (var property : String in source) {
				result.push(source[property]);
			}
			return result;
		}
		
	}
	
}