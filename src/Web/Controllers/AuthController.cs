using Model.Views;
using System;
using System.Collections.Generic;
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
                Username = "a",
                Password = "b"
            };

            return View(cred);
        }

        [HttpPost]
        public ActionResult Login(LoginCredentials cred)
        {
            if (ModelState.IsValid)
            {
                var user_id = _service.Auth(cred.Username, cred.Password);

                if (user_id != -1)
                {
                    Session.Add("user_id", user_id);
                    Session.Add("user_name", _service.GetUserName(user_id));
                    return RedirectToAction("", "");
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