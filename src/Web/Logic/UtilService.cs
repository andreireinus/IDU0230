using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Web.Logic
{
    public class UtilService
    {
        public int Auth(string username, string password)
        {
            using (var db = new DataContext())
            {
                return db.Auth(username, password);
            }
        }

        internal string GetUserName(int user_id)
        {
            using (var db = new DataContext())
            {
                var tootaja = db.Tootajad.First(u => u.tootaja_id == user_id);

                return tootaja.Isik.eesnimi + " " + tootaja.Isik.perekonnanimi;
            }
        }
    }
}