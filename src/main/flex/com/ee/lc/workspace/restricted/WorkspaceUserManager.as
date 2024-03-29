package com.ee.lc.workspace.restricted
{
import com.ee.lc.workspace.WorkspaceAdapter;
import com.ee.lc.workspace.restricted.utils.findKeyValue;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.net.URLRequestMethod;

import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;
import mx.rpc.http.HTTPService;

[Event(name="loginFailed", type="flash.events.Event")]
[Event(name="loginSuccessful", type="flash.events.Event")]
[Event(name="logoutFailed", type="flash.events.Event")]
[Event(name="logoutSuccessful", type="flash.events.Event")]

/**
 * Provides login/logout behaviour to the Workspace user manager servlet.
 */
public class WorkspaceUserManager extends EventDispatcher
{
    private static const ASSERTION_ID:String = "assertionid";
    private static const AUTHENTICATED:String = "authenticated";

    [Bindable]
    public var assertionID:String;

    public function login(rootUrl:String, username:String, password:String):void
    {
        var service:HTTPService = new HTTPService();

        service.url = rootUrl + "/um/login";
        service.method = URLRequestMethod.POST;
        service.addEventListener(ResultEvent.RESULT, function (event:ResultEvent):void
        {

            var isAuthenticated:Boolean = findKeyValue(AUTHENTICATED, event.result as String) == "true";

            if (isAuthenticated)
            {
                assertionID = findKeyValue(ASSERTION_ID, event.result as String);
                dispatchEvent(new Event(WorkspaceAdapter.LOGIN_SUCCESSFUL));
            }
            else
            {
                dispatchEvent(new Event(WorkspaceAdapter.LOGIN_FAILED));
            }

        });

        service.addEventListener(FaultEvent.FAULT, function (event:FaultEvent):void
        {
            dispatchEvent(new Event(WorkspaceAdapter.LOGIN_FAILED));
        });
        service.send({ j_username:username, j_password:password, um_no_redirect:true});
    }

    public function logout(rootUrl:String):void
    {
        var service:HTTPService = new HTTPService();

        service.url = rootUrl + "/um/logout";
        service.method = URLRequestMethod.POST;
        service.addEventListener(ResultEvent.RESULT, function (event:ResultEvent):void
        {

            var isAuthenticated:Boolean = findKeyValue(AUTHENTICATED, event.result as String) == "true";

            if (!isAuthenticated)
            {
                dispatchEvent(new Event(WorkspaceAdapter.LOGOUT_SUCCESSFUL));
            }
            else
            {
                dispatchEvent(new Event(WorkspaceAdapter.LOGOUT_FAILED));
            }

        });

        service.addEventListener(FaultEvent.FAULT, function (event:FaultEvent):void
        {
            dispatchEvent(new Event(WorkspaceAdapter.LOGOUT_FAILED));
        });
        service.send({ um_no_redirect:true});
    }
}
}