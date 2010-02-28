package org.goverla.controls.properties.editors {
	
	import flash.events.Event;
	
	import mx.core.Repeater;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	
	import org.goverla.collections.ArrayList;
	import org.goverla.collections.HashMap;
	import org.goverla.controls.properties.PropertyEditor;
	import org.goverla.controls.properties.classes.CollectionPropertyDefinition;
	import org.goverla.controls.properties.classes.PropertiesUtil;
	import org.goverla.controls.properties.classes.PropertyDefinition;
	import org.goverla.utils.Arrays;

	public class CollectionEditorBase extends BaseEditor {
		
		[Bindable]
		public var itemsRepeater : Repeater;
		
		public var moveupButtonsArray : Object;
		
		public var removeButtonsArray : Object;
		
		public var propertyEditorsArray : Object;
		
		public override function set property(value : PropertyDefinition) : void {
			if (super.property != null && super.property.bindable) {
				super.property.removeEventListener(CollectionEvent.COLLECTION_CHANGE, onCollectionPropertyChange);
			}
			
			super.property = value;
			invalidateProperties();
			
			if (value != null && value.bindable) {
				value.addEventListener(CollectionEvent.COLLECTION_CHANGE, onCollectionPropertyChange, false, 0, true);
			}
		}
		
		public override function set value(value : Object) : void {
			super.value = value;
			_valueChanged = true;
			invalidateProperties();
		}
		
		public function get itemsEditor() : String {
			return _itemsEditor;
		}
			
		public function set itemsEditor(value : String) : void {
			_itemsEditor = value;
		}
		
		public function get itemsClass() : String {
			return _itemsClass;
		}
			
		public function set itemsClass(value : String) : void {
			_itemsClass = value;
		}
		
		[Bindable]
		public function get showAddButton() : Boolean {
			return _showAddButton;
		}

		public function set showAddButton(value : Boolean) : void {
			_showAddButton = value;
		}
		
		[Bindable]
		public function get showRemoveButton() : Boolean {
			return _showRemoveButton;
		}

		public function set showRemoveButton(value : Boolean) : void {
			_showRemoveButton = value;
		}
		
		[Bindable]
		public function get showMoveUpButton() : Boolean {
			return _showMoveUpButton;
		}

		public function set showMoveUpButton(value : Boolean) : void {
			_showMoveUpButton = value;
		}
		
		protected function get collection() : ArrayList {
			return ArrayList(value);
		}
		
		protected override function commitProperties() : void {
			super.commitProperties();
			
			if (_valueChanged) {
				_valueChanged = false;
				
				if (property != null)
				{
					itemsRepeater.dataProvider = value;
				}
			}
		}
		
		protected function getItemProperty(item : Object) : CollectionPropertyDefinition {
			var result : CollectionPropertyDefinition = 
				CollectionPropertyDefinition(_cachedProperties.getItem(item));
			if (result == null) {
				result = new CollectionPropertyDefinition(property.name,
						item,
						PropertiesUtil.getEditorClassByName(itemsEditor), 
						property.editorInitialization,
						null, null,
						property.bindable);
				_cachedProperties.addItem(item, result);
			}
			
			return result;
		}
		
		protected function onAddButtonClick() : void {
			var entryClass : Class = PropertiesUtil.getEntryClassByName(itemsClass);
			collection.addItem(new entryClass());
		}
		
		protected function onMoveUpButtonClick(event : Event) : void {
			var index : int = (moveupButtonsArray as Array).indexOf(event.target);
			if (index > 0) {
				moveUpItem(index);
			}
		}
		
		protected function onRemoveButtonClick(event : Event) : void {
			var index : int = (removeButtonsArray as Array).indexOf(event.target);
			if (index >= 0) {
				var item : Object = collection.getItemAt(index);
				_cachedProperties.removeItemAt(item);
				collection.removeItem(item);
			}
		}
		
		private function onCollectionPropertyChange(event : CollectionEvent) : void {
			if (event.kind == CollectionEventKind.UPDATE) {
				var item : Object = PropertyChangeEvent(event.items[0]).source;
				for each (var propertyEditor : PropertyEditor in (propertyEditorsArray as Array)) {
					if (propertyEditor.editor != null && propertyEditor.editor.value == item) {
						propertyEditor.editor.updateValueByPropertyValue();
					}
				}
			}
		}
		
		private function moveUpItem(index : int) : void {
			Arrays.replaceItems(collection, index, index - 1);
		}
		
		private var _itemsEditor : String;
		
		private var _itemsClass : String;
		
		private var _showAddButton : Boolean = true;
		
		private var _showRemoveButton : Boolean = true;
		
		private var _showMoveUpButton : Boolean = true;
		
		private var _cachedProperties : HashMap = new HashMap();
		
		private var _valueChanged : Boolean;
		
	}
	
}