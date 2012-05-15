package com.ee.lc.workspace {
	import com.ee.lc.workspace.api.model.Task;
	import com.ee.lc.workspace.restricted.WorkspaceServerLogin;
	import com.ee.lc.workspace.restricted.WorkspaceUserManager;
	import com.ee.lc.workspace.restricted.responder.DefaultResponder;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.data.DataService;
	import mx.data.events.DataServiceFaultEvent;
	import mx.messaging.ChannelSet;
	import mx.messaging.channels.AMFChannel;
	import mx.rpc.AbstractOperation;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;


    /**
     * An adapter for communicating with the Livecycle Workspace Sever.
     *
     */
	[Event(name="loginSuccessful", type="flash.events.Event")]
	[Event(name="loginFailed", type="mx.rpc.events.FaultEvent")]
	[Event(name="logoutSuccessful", type="flash.events.Event")]
	[Event(name="logoutFailed", type="mx.rpc.events.FaultEvent")]
	[Event(name="loadTasksFault", type="flash.events.Event")]
	public class WorkspaceAdapter extends EventDispatcher
	{
		public static const LOGOUT_SUCCESSFUL : String = "logoutSuccessful";
		public static const LOGOUT_FAILED : String = "logoutFailed";
		public static const LOGIN_SUCCESSFUL : String = "loginSuccessful";
		public static const LOGIN_FAILED : String = "loginFailed";
		public static const LOAD_TASKS_FAULT : String = "loadTasksFault";
		
		private static const TASKS:String = "tasks";
		private static const LOGOUT : String = "logout";
		private static const AUTHENTICATION : String = "authentication";

		
		[Bindable]
		public var lcServerUrl : String;
		
		[Bindable]
		public var tasks : ArrayCollection; 
		
		private var task : Task;
		private var taskDataService : DataService;
		private var amfChannel : AMFChannel;
		private var channelSet : ChannelSet;
		private var remoteObject : RemoteObject;
		private var workspaceUM : WorkspaceUserManager = new WorkspaceUserManager();
		private var workspaceServerLogin : WorkspaceServerLogin = new WorkspaceServerLogin();
		
		private var _pollingInterval : Number = 120000;

		[Bindable]
		public function get pollingInterval():Number
		{
			return _pollingInterval;
		}

		public function set pollingInterval(value:Number):void
		{
			if( value > 0 && !isNaN(value) )
			{
				_pollingInterval = value;
			}
		}

		public function login( username : String, password : String ) : void
		{
			workspaceUM.addEventListener(LOGIN_SUCCESSFUL, umLoginSuccessful );
			workspaceUM.login( lcServerUrl, username, password );
		}	
		
		public function logout() : void
		{
			
			if( !workspaceUM.hasEventListener( LOGOUT_SUCCESSFUL ) )
			{
				workspaceUM.addEventListener( LOGOUT_SUCCESSFUL, function(event:Event):void{
					workspaceRemoteObjectLogout();
				});
			}
			if( !workspaceUM.hasEventListener( LOGOUT_FAILED ) )
			{
				workspaceUM.addEventListener( LOGOUT_FAILED, function(event:Event):void{
					dispatchEvent( new Event(LOGOUT_FAILED) );
				});
			}
			workspaceUM.logout(lcServerUrl);
		}
		
		private function workspaceRemoteObjectLogout() : void
		{
			if( taskDataService == null )
			{
				initDataServiceAndChannelSet();
			}
			
			if( remoteObject == null )
			{
				initRemoteObject();
			}
			
			var operation:AbstractOperation = remoteObject.getOperation(LOGOUT);
			var asyncToken:AsyncToken = operation.send();
			
			asyncToken.addResponder( new DefaultResponder(function(data:Object):void{
				taskDataService.disconnect();
				taskDataService.logout();
				dispatchEvent( new Event(LOGOUT_SUCCESSFUL) );
				
			}, function(info:Object):void{
				dispatchEvent( new Event(LOGOUT_FAILED) );
			} ) );
			
			
		}
		
		private function initRemoteObject() : void
		{
			remoteObject = new RemoteObject();
			remoteObject.destination = AUTHENTICATION;
			
			if( channelSet == null )
			{
				initChannelSetAndChannels();
			}
			
			remoteObject.channelSet = channelSet;
		}
		
		public function getTasks() : void
		{
			if( taskDataService == null )
			{
				initDataServiceAndChannelSet();
			}
			if( tasks == null )
			{
				tasks = new ArrayCollection();
			}
			
			tasks.removeAll();
			
			taskDataService.fill( tasks );
		}
		
		private function initDataServiceAndChannelSet() : void
		{
			taskDataService = new DataService(TASKS);
			if( channelSet == null )
			{
				initChannelSetAndChannels();
			}
			
			taskDataService.channelSet = channelSet;
			
			taskDataService.addEventListener(ResultEvent.RESULT, function(event:ResultEvent):void{
			});
			
			taskDataService.addEventListener(DataServiceFaultEvent.FAULT, function(event:DataServiceFaultEvent):void{
				dispatchEvent( new Event(LOAD_TASKS_FAULT) );
			});
		}
		
		private function initChannelSetAndChannels() : void
		{
			channelSet = new ChannelSet();
			amfChannel = new AMFChannel("my-amf", lcServerUrl + "/workspace-server/messagebroker/amfpolling");
			amfChannel["pollingInterval"] = pollingInterval;
			channelSet.channels = [amfChannel];
		}
		
		
		private function umLoginSuccessful( event : Event ) : void
		{
			if( !workspaceServerLogin.hasEventListener(LOGIN_SUCCESSFUL) )
			{
				workspaceServerLogin.addEventListener(LOGIN_SUCCESSFUL, workspaceServerLoginSuccessful );
			}
			workspaceServerLogin.login(lcServerUrl,workspaceUM.assertionID);
		}
		
		private function workspaceServerLoginSuccessful( event : Event ) : void
		{
			dispatchEvent( new Event(LOGIN_SUCCESSFUL) );
		}
	}
}