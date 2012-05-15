package com.ee.lc.workspace.restricted.utils
{
	/**
	 * find value in keyvalue string: eg: 
	 * findKeyValue(a, a=1&b=2 ) => 1
	 */	
	public function findKeyValue(key:String, keyValues:String, listDelimiter:String = "&", valueDelmiter : String = "=" ) : String
	{
		if( keyValues == null || keyValues.length == 0 )
		{
			return null;
		}
		
		var keyValuePairs : Array = keyValues.split(listDelimiter);
		
		for( var x : String in keyValuePairs )
		{
			var pair : Array = keyValuePairs[x].split(valueDelmiter);
			var pairKey : String = pair[0];
			var pairValue : String = pair[1];
			if( pairKey == key )
			{
				return pairValue;
			}
		}
		
		return null;
	}
}