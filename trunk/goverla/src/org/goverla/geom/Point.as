package org.goverla.geom
{
	import flash.geom.Point;
	
	[RemoteClass(alias="org.goverla.geom.Point")]
	public class Point extends flash.geom.Point
	{
		public function Point(x : Number = 0.0, y : Number = 0.0) {
			super(x, y);
		}
	}
}