package com.rma.lc.workspace.restricted
{
	import com.rma.lc.workspace.restricted.utils.findKeyValue;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLRequestMethod;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	[Event(name="loginFailed", type="flash.events.Event")]
	[Event(name="loginSuccessful", type="flash.events.Event")]
	public class WorkspaceServerLogin extends EventDispatcher
	{
		private static const CONTEXT : String = "/workspace-server";
		private static const PATH : String = CONTEXT + "/authenticate";
		
		[Bindable]
		public var oid : String;
		
		[Bindable]
		public var userId:String;
		
		public function login(rootUrl:String, assertionID : String) : void
		{
			var service : HTTPService = new HTTPService();
			service.url = rootUrl + PATH;
			service.method = URLRequestMethod.POST;
			service.addEventListener(ResultEvent.RESULT, function(event:ResultEvent):void{
				
				var isValid : Boolean = findKeyValue("valid", event.result as String ) == "true";
				if( isValid )
				{
					oid = findKeyValue("oid", event.result as String );
					userId = findKeyValue("userid", event.result as String);
					dispatchEvent( new Event("loginSuccessful") );
				}
				else
				{
					dispatchEvent( new Event("loginFailed") );
				}
			});
			
			service.addEventListener(FaultEvent.FAULT, function(event:FaultEvent):void{
				dispatchEvent( new Event("loginFailed") );
			});
			service.send({assertionId: assertionID, renewAssertion:false, serverUrl: rootUrl + CONTEXT});
		}
		
		
	}
}