using Model.Views;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Web.Code;
using Web.Logic;

namespace Web.Controllers
{
    public class AuthController : BaseController
    {
        private readonly UtilService _service = new UtilService();
        public ActionResult Login()
        {
            SetTitle("Autoriseerimine");

            var cred = new LoginCredentials
            {
                Username = string.Empty,
                Password = string.Empty
            };

            return View(cred);
        }

        [HttpPost]
        public ActionResult Login(LoginCredentials cred)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var user_id = _service.Auth(cred.Username, cred.Password);

                    if (user_id != -1)
                    {
                        Session.Add("user_id", user_id);
                        Session.Add("user_name", _service.GetUserName(user_id));
                        return RedirectToAction("", "");
                    }
                }
                catch (Exception e)
                {
                    Trace.WriteLine(e.ToString());
                    Debug.WriteLine(e.ToString());

                    AddErrorMessage(e);
                }
            }
            return View(cred);
        }

        public ActionResult Logout()
        {
            Session.RemoveAll();
            return RedirectToAction("", "");
        }
    }
}