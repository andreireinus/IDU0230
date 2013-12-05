using Model;
using Model.Views;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using Web.Code;

namespace Web.Controllers
{
    public class WorkplaceController : BaseController
    {
        [DAuthorize]
        public ActionResult Index(string id)
        {
            SetTitle("Tööaegade nimekiri");

            if (id == "all")
            {
                return View(_db.GetTooaegadeKoguNimekiri(UserId));
            }

            return View(_db.GetTooaegadeNimekiri(UserId));
        }

        [DAuthorize]
        public ActionResult Confirm(int id)
        {
            try
            {
                _db.KinnitaTooaeg(id);
            }
            catch (Exception ex)
            {
                AddErrorMessage(ex);
            }
            return RedirectToAction("Edit", new { id });
        }

        [DAuthorize]
        public ActionResult Create()
        {
            SetTitle("Tööaeg", "Lisa uus");

            if (_db.GetProjektid(UserId).Count == 0)
            {
                return RedirectToAction("NoProjects", "Message");
            }

            var model = new TooaegCreate
            {
                Kirjeldus = "",
                Algus = DateTime.Now.AddHours(-2),
                Lopp = DateTime.Now
            };

            return View(model);
        }

        [HttpPost]
        [DAuthorize]
        [ValidateAntiForgeryToken]
        public ActionResult Create(TooaegCreate model)
        {
            SetTitle("Tööaeg", "Lisa uus");
            model.Messages.Clear();

            if (!ModelState.IsValid)
            {
                ModelState.PushToSession(AddErrorMessage);
                
                return View(model);
            }

            try
            {
                _db.InsertTooaeg(model.ValitudProjektNr, model.Algus, model.Lopp, model.Kirjeldus);
            }
            catch (Exception ex)
            {
                model.Messages.Error(ex.Message);
                return View(model);
            }

            return RedirectToAction("Index");
        }

        [DAuthorize]
        public ActionResult Edit(int id)
        {
            var tooaeg = _db.GetTooaeg(id, UserId);
            if (tooaeg == null)
            {
                return new HttpNotFoundResult();
            }

            var model = new TooaegEdit
            {
                Algus = tooaeg.algus,
                Lopp = tooaeg.lopp,
                Kirjeldus = tooaeg.kirjeldus,
                TooaegId = tooaeg.tooaeg_id,
                ProjektiNimi = _db.GetProjektiNimi(tooaeg)
            };

            return View(model);
        }

        [HttpPost]
        [DAuthorize]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(TooaegEdit model)
        {
            if (!ModelState.IsValid)
            {
                ModelState.PushToSession(AddErrorMessage);

                return View(model);
            }

            try
            {
                _db.UpdateTooaeg(model.TooaegId, model.Algus, model.Lopp, model.Kirjeldus);
                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {
                AddErrorMessage(ex);
                return View(model);
            }
        }

        [DAuthorize]
        public ActionResult Delete(int id)
        {
            return View(id);
        }

        [DAuthorize]
        [HttpPost]
        public ActionResult Delete(int id, bool confirm)
        {
            try
            {
                _db.DeleteTooaeg(id);
            }
            catch (Exception ex)
            {
                AddErrorMessage(ex);
            }

            return RedirectToAction("Index");
        }

    }
}