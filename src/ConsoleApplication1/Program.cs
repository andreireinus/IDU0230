using Model;
using Model.Tables;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApplication1
{
    class Program
    {
        static void Main(string[] args)
        {
            Database.SetInitializer<DataContext>(null);
            using (var db = new DataContext())
            {
                FillDatabase(db);
                var a = db.GetTooaeg(1, 1);
            }
        }

        private static void FillDatabase(DataContext db)
        {
            //ClearDatabase(db);
            var org = db.Organisatsioonid.Where(a => a.nimi.Contains("odec")).FirstOrDefault();
            org.nimi = "OÜ Codecat";

            foreach (var proj in db.Projektid.Where(a => a.nimi.Contains("ike ")))
            {
                proj.nimi = "Väikene projekt";
            }
            db.SaveChanges();
        }

        private static Tootaja LisaTootaja(DataContext db, string eesnimi, string perenimi, string kasutajanimi, string parool,
            string aadress, string telefon, string email)
        {
            var osapool = new Osapool
            {
                aadress = aadress,
                email = email,
                telefon = telefon
            };
            db.Osapooled.Add(osapool);

            var isik = new Isik
            {
                eesnimi = eesnimi,
                perekonnanimi = perenimi,
                Osapool = osapool
            };
            db.Isikud.Add(isik);

            var tootaja = new Tootaja
            {
                Isik = isik,
                kasutajanimi = kasutajanimi,
                parool = parool
            };
            db.Tootajad.Add(tootaja);
            db.SaveChanges();

            return tootaja;
        }


        private static void ClearDatabase(DataContext db)
        {
            db.Osapooled.RemoveRange(db.Osapooled);
            db.Arikliendid.RemoveRange(db.Arikliendid);
            db.Erakliendid.RemoveRange(db.Erakliendid);
            db.Organisatsioonid.RemoveRange(db.Organisatsioonid);
            db.Isikud.RemoveRange(db.Isikud);
            db.Tooajad.RemoveRange(db.Tooajad);
            db.ProjektiLiikmed.RemoveRange(db.ProjektiLiikmed);
            db.Tooajad.RemoveRange(db.Tooajad);
            db.Projektid.RemoveRange(db.Projektid);
            db.Kliendid.RemoveRange(db.Kliendid);
            db.SaveChanges();
        }
    }
}
