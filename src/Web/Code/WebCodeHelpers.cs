using System.Linq.Expressions;
using System.Web.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc.Html;
using System.Web.Routing;
using Model.Views;
using System.Text;
using Model;


namespace Web.Code
{
    public static class WebCodeHelpers
    {
        public static void PushToSession(this ModelStateDictionary msd, Action<string> each)
        {
            foreach (var a in msd.SelectMany(b => b.Value.Errors))
            {
                each(a.ErrorMessage);
            }
        }

        public static MvcHtmlString ToMvcString(this string str)
        {
            return new MvcHtmlString(str);
        }

        public static MvcHtmlString ToMvcString(this StringBuilder sb)
        {
            return sb.ToString().ToMvcString();
        }

        public static MvcHtmlString ProjektideDropDown(this HtmlHelper helper, int user_id)
        {
            List<KasutajaProjektid> projektid = new List<KasutajaProjektid>();
            using (var db = new DataContext())
            {
                projektid.AddRange(db.GetProjektid(user_id));
            }
            StringBuilder sb = new StringBuilder();
            sb.AppendFormat("<select class='form-control' name='ValitudProjektNr' id='ValitudProjektNr'>");

            foreach (var kliendi_nimi in projektid.Select(d => d.kliendi_nimi).Distinct())
            {
                sb.AppendFormat("<optgroup label='{0}'>", kliendi_nimi);
                foreach (var projekt in projektid.Where(p => p.kliendi_nimi == kliendi_nimi))
                {
                    sb.AppendFormat("<option value='{0}'>{1}</option>", projekt.projekti_liige_id, projekt.projekti_nimi);
                }
                sb.AppendFormat("</optgroup>");
            }

            sb.AppendFormat("</select>");
            return sb.ToMvcString();
        }

        public static MvcHtmlString ShowErrorMessages(this HtmlHelper helper)
        {
            var messages = helper.ViewContext.HttpContext.Session["msg"] as Messages;
            if (messages == null)
            {
                return "".ToMvcString();
            }
            //var message = helper. Session[]
            StringBuilder sb = new StringBuilder();

            foreach (var message in messages)
            {
                sb.Append("<div class=\"alert alert-danger alert-dismissable\">");
                sb.Append("<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-hidden=\"true\">&times;</button>");
                sb.AppendFormat("{0}</div>", message.Text);
            }

            helper.ViewContext.HttpContext.Session["msg"] = null;
            return sb.ToMvcString();
        }
    }
}