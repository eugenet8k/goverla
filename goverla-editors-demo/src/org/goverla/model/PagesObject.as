package org.goverla.model {
	import org.goverla.collections.ArrayList;
	
	public class PagesObject extends EditableObject {
		
		[Bindable]
		[Serializable]
		[Editable(group="General", dependentGroup="Page", editor="CheckBoxEditor", label="page", 
			bindable="true", index="5")]
		public function get page() : Boolean {
			return _page;
		}
		
		public function set page(value : Boolean) : void {
			_page = value;
		}
		
		[Serializable]
		[Editable(group="Page", editor="StringEditor", label="start template:",
			bindable="true", index="0")]
		public function get startTemplate() : String {
			return _startTemplate;
		}
		
		public function set startTemplate(value : String) : void {
			_startTemplate = value;
		}
		
		[Serializable]
		[Editable(group="Page", editor="CollectionEditor", label="aliases:",
			itemsEditor="TwoStringsEditor", itemsClass="PageAliasEntry", itemField1="alias", itemField2="target",
			bindable="true", index="1")]
		public function get pageAliases() : ArrayList {
			if (_pageAliases == null) {
				_pageAliases = new ArrayList();
			}
			return _pageAliases;
		}
		
		private var _page : Boolean;
		
		private var _startTemplate : String;

		private var _pageAliases : ArrayList;
				
	}
	
}