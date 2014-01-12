using Model;
using Model.Views;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Web.Code
{
    public class BaseController : Controller
    {
        protected readonly DataContext _db = new DataContext();

        protected int UserId { get { return (int)Session["user_id"]; } }

        protected void SetTitle(string title, string subTitle = "")
        {
            ViewBag.Title = title;
            ViewBag.SubTitle = subTitle;
        }

        protected void AddErrorMessage(string message)
        {
            if (Session["msg"] == null)
            {
                Session["msg"] = new Messages();
            }

            var msg = Session["msg"] as Messages;
            msg.Error(message);
        }

        protected void AddErrorMessage(Exception e)
        {
            AddErrorMessage(e.Message);

            if (e.InnerException != null)
            {
                AddErrorMessage(e.InnerException);
            }
        }
    }
}