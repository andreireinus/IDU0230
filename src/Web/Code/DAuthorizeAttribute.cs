using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace Web.Code
{
    public class DAuthorizeAttribute : AuthorizeAttribute
    {
        private static RouteValueDictionary noAccessRouteValueDictionary = new RouteValueDictionary
            {
                { "action", "Login" },
                { "controller", "Auth" }
            };

        protected override bool AuthorizeCore(HttpContextBase httpContext)
        {
            var user_id = httpContext.Session["user_id"];
            if (user_id == null || (!(user_id is int)))
            {
                return false;
            }

            var intValue = (int)user_id;
            if (intValue > 0)
            {
                return true;
            }
            return false;
        }

        protected override void HandleUnauthorizedRequest(AuthorizationContext filterContext)
        {
            filterContext.Result = new RedirectToRouteResult(noAccessRouteValueDictionary);
        }
    }
}