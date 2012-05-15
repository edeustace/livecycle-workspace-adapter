package com.rma.lc.workspace.api.model
{
	import mx.collections.ListCollectionView;
	
	[RemoteClass(alias="com.adobe.idp.taskmanager.dsc.client.query.ProcessInstanceRowImpl")]
	public class ProcessInstance
	{
		public var processName:String;
		public var description:String;
		public var processStartTime:Date;
		public var processCompleteTime:Date;
		public var processInstanceStatus:Number;
		public var processInstanceId:Number;
		public var initiatorId:String;
		public var initiator:String;
		public var tasks:ListCollectionView;
		public var processVariables:ListCollectionView;
		public var pendingTasks:ListCollectionView;
		public var imageUrl:String;
	}
}
