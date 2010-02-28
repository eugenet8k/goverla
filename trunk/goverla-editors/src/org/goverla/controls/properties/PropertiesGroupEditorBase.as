package org.goverla.controls.properties {
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.events.StateChangeEvent;
	
	import org.goverla.containers.CollapsablePanel;
	import org.goverla.controls.properties.classes.PropertiesGroup;

	public class PropertiesGroupEditorBase extends CollapsablePanel {
		
		[Bindable]
		public function get group() : PropertiesGroup {
			return _group;
		}

		public function set group(value : PropertiesGroup) : void {
			_group = value;
			dispatchEvent(new Event("groupChange"));
		}
		
		[Bindable(event="groupChange")]
		[Bindable(event="populateRepeater")]
		public function get properties() : ArrayCollection {
			if (collapsed) {
				return null;
			} else {
				return group != null ? group.properties : null;
			}
		}
		
		protected override function changeCurrentState(state : String, fireChange : Boolean = true) : void {
			super.changeCurrentState(state, fireChange);
			
			group.collapsed = collapsed;
		}
		
		protected override function onCurrentStateChange(event : StateChangeEvent) : void {
			super.onCurrentStateChange(event);
			
			if (!collapsed && numChildren == 0) {
				dispatchEvent(new Event("populateRepeater"));
			}
		}
		
		private var _group : PropertiesGroup;
		
	}
	
}