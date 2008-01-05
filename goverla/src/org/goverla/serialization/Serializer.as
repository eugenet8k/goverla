package org.goverla.serialization
{
	import flash.utils.ByteArray;
	
	public class Serializer
	{
		
		public static function toAMF(object : Object) : ByteArray {
			var result : ByteArray = new ByteArray();
			result.writeObject(object);
			result.position = 0;
			return result;
		}

		public static function toAMFString(object : Object) : String {
			var bytes : ByteArray = toAMF(object);
			var result : String = bytes.readUTFBytes(bytes.length);
			return result;
		}

		public static function fromAMF(source : ByteArray) : Object {
			source.position = 0;
			return source.readObject();
		}

		public static function fromAMFString(source : String) : Object {
			var bytes : ByteArray = new ByteArray();
			bytes.writeUTFBytes(source);
			return fromAMF(bytes);
		}
		
	}
}