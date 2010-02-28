package org.goverla.model {

	import mx.events.FlexEvent;
	
	import org.goverla.collections.ArrayList;
	
	public class SequencePagesObject extends PagesObject {
		
		public static const POSITIONS : ArrayList = new ArrayList([
				new MemberEntry("placeholder"),
				new MemberEntry("prefix"),
				new MemberEntry("infix"),
				new MemberEntry("postfix")
			]);
		
		[Editable(group="General", editor="StringEditor", label="maxlength:", 
			bindable="true", index="1")]
		public function get maxLength() : String {
			return _maxLength;
		}
		
		public function set maxLength(value : String) : void {
			_maxLength = value;
		}
		
		[Editable(group="General", editor="StringEditor", label="index variable:", 
			bindable="true", index="2")]
		public function get indexVariable() : String {
			return _indexVariable;
		}
		
		public function set indexVariable(value : String) : void {
			_indexVariable = value;
		}
		
		[Bindable]
		[Editable(group="General", dependentGroup="Filter", editor="CheckBoxEditor", label="filter", 
			bindable="true", index="6")]
		public function get filter() : Boolean {
			return _filter;
		}
		
		public function set filter(value : Boolean) : void {
			_filter = value;
		}
		
		[Editable(group="Filter", editor="CollectionEditor",
			itemsEditor="ThreeStringsEditor", itemsClass="FilterEntry", label="conditions:",
			label1="string property:", label2="equals to:", label3="user variable:",
			itemField1="property", itemField2="value", itemField3="userVariable", 
			bindable="true", index="1")]
		public function get filterConditions() : ArrayList {
			if (_filterConditions == null) {
				_filterConditions = new ArrayList();
			}
			return _filterConditions;
		}
		
		[Bindable]
		[Editable(group="General", editor="CheckBoxEditor", label="navigator", 
			bindable="true", index="8")]
		public function get navigator() : Boolean {
			return _navigator;
		}
		
		public function set navigator(value : Boolean) : void {
			_navigator = value;
		}
		
		[Bindable]
		[Editable(group="General", dependentGroup="Sort", editor="CheckBoxEditor", label="sort", 
			bindable="true", index="7")]
		public function get sort() : Boolean {
			return _sort;
		}
		
		public function set sort(value : Boolean) : void {
			_sort = value;
		}
		
		[Editable(group="Sort", editor="StringEditor", label="sort by:",
			bindable="true", index="0")]
		public function get sortBy() : String {
			return _sortBy;
		}
		
		public function set sortBy(value : String) : void {
			_sortBy = value;
		}
		
		[Editable(group="Sort", editor="ComboBoxEditor", label="sort direction:", 
			dataProvider="ascending,descending,random", index="2")]
		public function get sortDirection() : String {
			return _sortDirection;
		}
		
		public function set sortDirection(value : String) : void {
			_sortDirection = value;
		}
		
		public function get positions() : ArrayList {
			return POSITIONS;
		}
		
		private var _maxLength : String;
		
		private var _indexVariable : String;
		
		private var _filter : Boolean;
		
		private var _filterConditions : ArrayList;
		
		private var _navigator : Boolean;
		
		private var _sort : Boolean;
		
		private var _sortBy : String;
		
		private var _sortDirection : String;
		
	}
	
}