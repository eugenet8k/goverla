package org.goverla.utils {
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	import mx.collections.ArrayCollection;
	import mx.core.Application;
	import mx.core.Container;
	import mx.core.UIComponent;
	import mx.core.UIComponentDescriptor;
	
	import org.goverla.errors.IllegalArgumentError;
	import org.goverla.reflection.Overload;
	import org.goverla.utils.ui.UIComponentSize;

	/**
	 * @author Maxym Hryniv
	 */
	public class UIUtil {
		
		public static function getApplicationMousePosition() : Point {
			return new Point(Application.application.mouseX,
				Application.application.mouseY);
		}
		
		public static function isMouseOut(component : DisplayObject) : Boolean 
		{
			if(component.mouseX < 0)
				return true;
			if(component.mouseY < 0)
				return true;
			if(component.mouseX > component.width)
				return true;
			if(component.mouseY > component.height)
				return true;
			return false;
		}
		public static function fitToScreen(component : UIComponent) : void {
			var position : Point = component.parent.localToGlobal(new Point(component.x, component.y));
			
			var screenSize : Point = component.systemManager.screen.size;
			if(position.x + component.width > screenSize.x) {
				position.x -= position.x + component.width - screenSize.x;
			}

			if(position.y + component.height > screenSize.y) {
				position.y -= position.y + component.height - screenSize.y;
			}
			
			if(position.x < 0) {
				position.x = 0;
			}
			
			if(position.y < 0) {
				position.y = 0;
			}
			
			var localPosition : Point = component.parent.globalToLocal(position);
			component.x = localPosition.x;
			component.y = localPosition.y;
			
		}
		
		public static function addIfHasNot(parent : UIComponent, child : UIComponent) : void
		{
			if(!hasChild(parent, child))
			{
				parent.addChild(child);
			}
		}
		public static function removeIfHas(parent : UIComponent, child : UIComponent) : void
		{
			if(hasChild(parent, child))
			{
				parent.removeChild(child);
			}
		} 
		
		public static function hasChild(parent : UIComponent, child : UIComponent) : Boolean 
		{
			try
			{
				parent.getChildIndex(child);
				return true;
			}
			catch(e : ArgumentError)
			{
				return false;
			}
			return false;
		}
		
		public static function applyStyles(target : UIComponent, stylesDescriptor : Object) : void {
			for(var style : String in stylesDescriptor) {
				target.setStyle(style, stylesDescriptor[style]);
			}
		}	
		
		public static function setChildrenVisibility(view : DisplayObjectContainer, value : Boolean) : void {
			for (var index : Number = 0; index < Container(view).numChildren; index++) {
				var child : DisplayObject = Container(view).getChildAt(index);
				child.visible = value;			
			
				if (child is DisplayObjectContainer) {
					setChildrenVisibility(DisplayObjectContainer(child), value);	
				}
			}		
		}
		
		public static function setWidth(target : UIComponent, value : Object) : void {
			var o : Overload = new Overload(UIUtil);
			o.addHandler([UIComponent, Number], setWidthByNumber);
			o.addHandler([UIComponent, String], setWidthByString);
			o.forward(arguments);
		}
		
		private static function setWidthByNumber(target : UIComponent, value : Number) : void {
			target.width = value;
		}
		
		private static function setWidthByString(target : UIComponent, value : String) : void {
			var percentWidth : Number = Number(percentSizeRegExp.exec(value)[1]);
			target.percentWidth = percentWidth;
		}
	
		public static function setHeight(target : UIComponent, value : Object) : void {
			var o : Overload = new Overload(UIUtil);
			o.addHandler([UIComponent, Number], setHeightByNumber);
			o.addHandler([UIComponent, String], setWidthByString);
			o.forward(arguments);
		}
		
		private static function setHeightByNumber(target : UIComponent, value : Number) : void {
			target.height = value;
		}
		
		private static function setHeightByString(target : UIComponent, value : String) : void {
			var percentHeight : Number = Number(percentSizeRegExp.exec(value)[1]);
			target.percentHeight = percentHeight;
		}
	
		public static function squareContainsPoint(startPoint : Point, size : UIComponentSize, point : Point) : Boolean {
			var result : Boolean = (startPoint.x < point.x) 
									&& (startPoint.x + size.width > point.x)
									&& (startPoint.y < point.y) 
									&& (startPoint.y + size.height > point.y);
			return result;
		}
		
		public static function setSelectedItem(dataProviderObject : Object, item : Object) : int {
			var dataProvider : ArrayCollection = ArrayCollection(dataProviderObject.dataProvider);
			
			if (dataProvider.contains(item)) {
				dataProviderObject.selectedIndex = dataProvider.getItemIndex(item); 
			} else {
				throw new IllegalArgumentError("dataProvider doesn't contain such item: " + item);
			}

			return dataProviderObject.selectedIndex;
		}
		
		public static function rotateComponent(target : UIComponent, angle : Number, startingPoint : Point) : void {
			var globalStartPoint : Point = target.localToGlobal(startingPoint);
			target.rotation -= angle;
			var globalEndPoint : Point = target.localToGlobal(startingPoint);
			target.x += globalStartPoint.x - globalEndPoint.x;
			target.y += globalStartPoint.y - globalEndPoint.y;
			
/*			var radianAngle : Number = Math.PI * angle / 360;
			var cos : Number = Math.cos(radianAngle);
			var sin : Number = Math.sin(radianAngle);
			var matrix : Matrix = new MatrixMatrix(cos, sin, -sin, cos, 0, 0);
			matrix.*/
			
		}
		
		private static function updateAnchor(component : UIComponent
				, anchorSet : Boolean
				, styleName : String
				, value : Number) : void {
			if(anchorSet) {
				component.setStyle(styleName, value);
			} else {
				component.setStyle(styleName, undefined);
			}
		}
		
		private static function get percentSizeRegExp() : RegExp {
			var result : RegExp = /(d+)%/;
			return result;
		}
		
		private static function applyAllStyles(object : UIComponent, childDescriptor : UIComponentDescriptor) : void {
			applyStyles(object, childDescriptor.stylesFactory());
		}
		
		public static function getApplicationMouseShift(startPosition : Point) : Point {
			return new Point(Application.application.mouseX - startPosition.x,
					Application.application.mouseY - startPosition.y);
		}
	
		public static function sumPoint(point1 : Point, point2 : Point) : Point {
			return new Point(point1.x + point2.x, point1.y + point2.y);
		}

		private static function applyEvents(target : UIComponent, document : UIComponent, childDescriptor : UIComponentDescriptor) : void {
			for(var eventName : String in childDescriptor.events) {
				target.addEventListener(eventName, childDescriptor.events[eventName]);
			}
		}
			
	}
}