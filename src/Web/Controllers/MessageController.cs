using Model.Views;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Web.Code;

namespace Web.Controllers
{
    public class MessageController : BaseController
    {
        public ActionResult NoProjects()
        {
            AddErrorMessage("Kasutajal ei ole aktiivseid projekte!");

            return View("Index");
        }
	}
}