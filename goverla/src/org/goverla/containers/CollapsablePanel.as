package org.goverla.containers {

	import flash.events.MouseEvent;
	
	import mx.containers.TitleWindow;
	import mx.events.StateChangeEvent;
	import mx.states.SetProperty;
	import mx.states.State;
	
	import org.goverla.constants.Icons;
	import org.goverla.constants.StyleConstants;
	import org.goverla.constants.StyleNames;
	import org.goverla.events.CollapsablePanelEvent;

	[Style(name="restoredStyleName", type="String", inherit="no")]
	
	[Style(name="collapsedStyleName", type="String", inherit="no")]
	
	public class CollapsablePanel extends TitleWindow {
		
		protected static const RESTORED_STATE : String = "";
		
		protected static const COLLAPSED_STATE : String = "collapsedState";
		
		protected static const RESTORED_STYLE_NAME : String = "restoredStyleName";
		
		protected static const COLLAPSED_STYLE_NAME : String = "collapsedStyleName";
		
		protected static const CLICK_TO_EXPAND : String = "Click to expand";
		
		protected static const CLICK_TO_COLLAPSE : String = "Click to collapse";
		
		protected static const RESTORED_ICON : Class = Icons.ICON_10X6_OPENED_UP;
		
		protected static const COLLAPSED_ICON : Class = Icons.ICON_10X6_CLOSED_UP;
		
		protected var setHeight : SetProperty;
		
		public function CollapsablePanel() {
			super();
			
			addEventListener(StateChangeEvent.CURRENT_STATE_CHANGE, onCurrentStateChange);
			addEventListener(StateChangeEvent.CURRENT_STATE_CHANGING, onCurrentStateChanging);
		}
		
		public function get collapsable() : Boolean {
			return _collapsable;
		}
		
		public function set collapsable(collapsable : Boolean) : void {
			_collapsable = collapsable;
			_collapsableChanged = true;
			invalidateProperties();
		}
		
		public function get collapsablePanelGroup() : CollapsablePanelGroup {
			return _collapsablePanelGroup;
		}
		
		public function set collapsablePanelGroup(collapsablePanelGroup : CollapsablePanelGroup) : void {
			if (_collapsablePanelGroup != null) {
				_collapsablePanelGroup.removeInstance(this);
			}
			_collapsablePanelGroup = collapsablePanelGroup;
			_collapsablePanelGroup.addInstance(this);
			_collapsablePanelGroupChanged = true;
			invalidateProperties();
		}
		
		public function get autoScrollManager() : AutoScrollManager {
			return _autoScrollManager;
		}
		
		public function set autoScrollManager(autoScrollManager : AutoScrollManager) : void {
			if (_autoScrollManager != null) {
				_autoScrollManager.removeInstance(this);
			}
			_autoScrollManager = autoScrollManager;
			_autoScrollManager.addInstance(this);
		}
		
		public function get collapsedIconSource() : Class {
			return _collapsedIconSource;
		}
		
		public function set collapsedIconSource(collapsedIconSource : Class) : void {
			_collapsedIconSource = collapsedIconSource;
			_collapsedIconSourceChanged = true;
			invalidateProperties();
		}
		
		public function get restoredIconSource() : Class {
			return _restoredIconSource;
		}
		
		public function set restoredIconSource(restoredIconSource : Class) : void {
			_restoredIconSource = restoredIconSource;
			_restoredIconSourceChanged = true;
			invalidateProperties();
		}
		
		public function get collapsed() : Boolean {
			return (currentState == COLLAPSED_STATE);
		}
		
		public function set collapsed(value : Boolean) : void {
			if (value) {
				collapse();
			} else {
				restore()
			}
		}
		
		protected function get oppositeState() : String {
			return (collapsed ? RESTORED_STATE : COLLAPSED_STATE);
		}
		
		override public function styleChanged(styleProp : String) : void {
			super.styleChanged(styleProp);
			
			var allStyles : Boolean = (styleProp == null || styleProp == "styleName");
			
			if (allStyles || styleProp == RESTORED_STYLE_NAME || styleProp == COLLAPSED_STYLE_NAME) {
				styleName = getStyleName();
			}
		}
		
		public function collapse() : void {
			changeCurrentState(COLLAPSED_STATE, false);
		}
		
		public function restore() : void {
			changeCurrentState(RESTORED_STATE, false);
		}
		
		override protected function createChildren() : void {
			super.createChildren();

			createCollapsedState();
			
			setOppositeState();
			setOppositeState();

			titleBar.addEventListener(MouseEvent.CLICK, onTitleBarClick);
		}
		
		override protected function commitProperties() : void {
			super.commitProperties();
			
			if (_collapsableChanged || _collapsedIconSourceChanged || _restoredIconSourceChanged) {
				titleIcon = getTitleIcon();
			}
			
			if (_collapsableChanged || _collapsablePanelGroupChanged) {
				titleBar.toolTip = getTitleBarToolTip();
			}
			
			_collapsableChanged = false;
			_collapsablePanelGroupChanged = false;
			_collapsedIconSourceChanged = false;
			_restoredIconSourceChanged = false;
		}
		
		protected function setOppositeState() : void {
			if (collapsable) {
				changeCurrentState(oppositeState);
			}
		}
		
		protected function changeCurrentState(state : String, fireChange : Boolean = true) : void {
			currentState = state;
			if (fireChange) {
				dispatchEvent(new CollapsablePanelEvent(CollapsablePanelEvent.STATE_CHANGE));
			}
		}

		protected function onTitleBarClick(event : MouseEvent) : void {
			setOppositeState();
		}
		
		protected function onCurrentStateChange(event : StateChangeEvent) : void {
			styleName = getStyleName();
			titleIcon = getTitleIcon();
			titleBar.toolTip = getTitleBarToolTip();
		}
		
		protected function onCurrentStateChanging(event : StateChangeEvent) : void {
			setHeight.value = getTitleBarHeight();
		}
		
		protected function getStyleName() : String {
			return (collapsed ? getStyle(COLLAPSED_STYLE_NAME) : getStyle(RESTORED_STYLE_NAME));
		}
		
		protected function getTitleIcon() : Class {
			var result : Class;
			if (collapsable) {
				result = (collapsed ? collapsedIconSource : restoredIconSource);
			}
			return result;
		}
		
		protected function getTitleBarToolTip() : String {
			var result : String;
			if (collapsable) {
				if (collapsed) {
					result = CLICK_TO_EXPAND;
				} else if (collapsablePanelGroup == null) {
					result = CLICK_TO_COLLAPSE;
				}
			}
			return result;
		}
		
		protected function getTitleBarHeight() : Number {
			return (titleBar.height + (getStyle(StyleNames.BORDER_STYLE) == 
				StyleConstants.BORDER_STYLE_SOLID ? getStyle(StyleNames.BORDER_THICKNESS) * 2 : 0));
		}
		
		private function createCollapsedState() : void {
			setHeight = new SetProperty(this, "height");
			
			var overrides : Array = new Array(setHeight);

			var collapsedState : State = new State();
			collapsedState.name = COLLAPSED_STATE;
			collapsedState.overrides = overrides;
			
			states.push(collapsedState);
		}

		private var _collapsable : Boolean = true;
		
		private var _collapsableChanged : Boolean;
		
		private var _collapsablePanelGroup : CollapsablePanelGroup;
		
		private var _collapsablePanelGroupChanged : Boolean;
		
		private var _autoScrollManager : AutoScrollManager;
		
		private var _collapsedIconSource : Class = COLLAPSED_ICON;
		
		private var _collapsedIconSourceChanged : Boolean = true;
		
		private var _restoredIconSource : Class = RESTORED_ICON;
		
		private var _restoredIconSourceChanged : Boolean = true;;
		
	}

}