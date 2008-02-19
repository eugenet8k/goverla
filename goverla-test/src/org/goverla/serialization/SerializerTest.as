package org.goverla.serialization {
	import mx.collections.ArrayCollection;
	
	import org.flex2unit.framework.TestCase;
	import org.goverla.flash.geom.Point;

	public class SerializerTest extends TestCase {
		
		
		public function testToFromAmfString() : void {
			var object : ArrayCollection = new ArrayCollection();
			object.addItem(new Point(1, 5));
			object.addItem("hujn'a");
			var serialization : String = Serializer.toAMFString(object);
			var result : ArrayCollection = ArrayCollection(Serializer.fromAMFString(serialization));
			assertEquals(Point(object.getItemAt(0)).x, Point(result.getItemAt(0)).x);
			assertEquals(Point(object.getItemAt(0)).y, Point(result.getItemAt(0)).y);
			assertEquals(object.getItemAt(1), result.getItemAt(1));
			
		}

	}
}