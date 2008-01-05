package org.goverla.serialization.deserializers.requirements
{
	import org.goverla.interfaces.IRequirement;
	import org.goverla.serialization.constants.SerializationConstants;
	import org.goverla.utils.Objects;
	
	

	public class ClassNodeRequirement implements IRequirement
	{
		
		public function meet(object:Object):Boolean
		{
			return Objects.castToXML(object).@type == SerializationConstants.CLASS_NODE_TYPE;
		}
		
	}
}