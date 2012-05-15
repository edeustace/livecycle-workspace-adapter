package com.rma.lc.workspace.api.model
{
	import mx.collections.ArrayCollection;
	import mx.collections.ListCollectionView;


	[Managed]
	[RemoteClass(alias="com.adobe.workspace.tasks.Task")]
	public class Task
	{
		public var currentAssignment: Assignment;
		public var taskACL : TaskACL;
		public var isDeadlined:Boolean=false;
		public var isInitialTask:Boolean=false;
		public var isInitalTask:Boolean=false;
		public var canInvokeFromStartTask:Boolean=false;
		public var isDraft:Boolean=false;
		public var assignments:ListCollectionView;
		public var actionInstanceId:Number;
		public var attachments:ListCollectionView;
		public var consultGroupId:String;
		public var creationId:String;
		public var createTime:Date;
		public var completeTime:Date;
		public var deadline:Date;
		public var description:String;
		public var trcVariableName:String;
		public var forwardGroupId:String;
		public var imageUrl:String;
		public var instructions:String;
		public var nextReminder:Date;
		public var numForms:Number;
		public var numFormsToBeSaved:Number;
		public var processInstance:ProcessInstance;		
		public var processInstanceId:Number;
		public var processInstanceStatus:Number;
		public var processVariables:ListCollectionView;
		public var priority:Number;
		public var reminderCount:Number;
		public var routeList:Array;
		public var savedFormCount:Number;
		public var selectedRoute:String;
		public var serializedImageTicket:String;
		public var serviceName:String;
		public var serviceTitle:String;
		public var stepName:String;
		public var status:Number;
		public var taskId:String;
		public var updateTime:Date;
		public var isLocked:Boolean;
		public var isShowAttachments:Boolean;
		public var isStartTask:Boolean;
		public var isActive:Boolean;
		public var isRouteSelectionRequired:Boolean;
		public var isVisible:Boolean;
		public var isShowRemoveTask:Boolean;
		public var taskUserInfo:Array;
		public var availableCommands:ArrayCollection;
		public var routeCommands:ArrayCollection;
		public var outOfOfficeUserName:String;
		public var outOfOfficeUserId:String;
		public var classOfTask:String;
		public var isCustomUI:Boolean;
		public var isApprovalUI:Boolean;
		public var isMustOpenToComplete:Boolean;
		public var isOpenFullScreen:Boolean;
	}

}
