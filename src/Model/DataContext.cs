using Model.Views;
using Npgsql;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class DataContext : DbContext
    {
        public DbSet<Model.Tables.Ariklient> Arikliendid { get; set; }
        public DbSet<Model.Tables.Eraklient> Erakliendid { get; set; }
        public DbSet<Model.Tables.Tootaja> Tootajad { get; set; }
        public DbSet<Model.Tables.Projekt> Projektid { get; set; }
        public DbSet<Model.Tables.Tooaeg> Tooajad { get; set; }

        public DataContext()
            : base("db")
        {
            Database.SetInitializer<DataContext>(null);
        }


        public Model.Tables.Tooaeg GetTooaeg(int tooaeg_id, int user_id)
        {
            var query = from tooaeg
                            in Tooajad
                        where
                            tooaeg.tooaeg_id == tooaeg_id
                        select tooaeg;

            return query.AsNoTracking().FirstOrDefault();
        }

        public List<KasutajaProjektid> GetProjektid(int user_id)
        {
            var param = (new ParameterList("user_id", user_id)).ToArray();

            return Database
                .SqlQuery<KasutajaProjektid>("SELECT * FROM fn_kasutajaProjektid(:user_id)", param)
                .ToList();
        }

        public List<Tooaeg> GetTooaegadeNimekiri(int user_id)
        {
            var param = new ParameterList("user_id", user_id);

            return Database.SqlQuery<Tooaeg>("SELECT * FROM fn_tooaegadeNimekiri(:user_id)", param.ToArray()).ToList();
        }

        public List<Tooaeg> GetTooaegadeKoguNimekiri(int user_id)
        {
            var param = new ParameterList("user_id", user_id);

            return Database.SqlQuery<Tooaeg>("SELECT * FROM fn_tooaegadeKoguNimekiri(:user_id)", param.ToArray()).ToList();
        }

        public int Auth(string username, string passwordHash)
        {
            ParameterList paramList = new ParameterList();
            paramList.Add("password", passwordHash);
            paramList.Add("username", username);

            var data = Database.SqlQuery<int>("SELECT * FROM fn_valideeriKasutaja(:username,:password)", paramList.ToArray());

            return data.First();
        }

        public int InsertTooaeg(int projektiLiigeId, DateTime algus, DateTime lopp, string kirjeldus)
        {
            ParameterList pl = new ParameterList();
            pl.Add(":p1", projektiLiigeId);
            pl.Add(":p2", algus);
            pl.Add(":p3", lopp);
            pl.Add(":p4", kirjeldus);

            return Database.SqlQuery<int>("SELECT * FROM fn_lisaTooaeg(:p1,:p2,:p3,:p4)", pl.ToArray()).First();
        }

        private Type voidType = typeof(object);
        public void UpdateTooaeg(int tooaeg_id, DateTime algus, DateTime lopp, string kirjeldus)
        {
            ParameterList pl = new ParameterList();
            pl.Add(":p1", tooaeg_id);
            pl.Add(":p2", algus);
            pl.Add(":p3", lopp);
            pl.Add(":p4", kirjeldus);

            Database.SqlQuery<object>("SELECT fn_uuendaTooaeg(:p1,:p2,:p3,:p4)", pl.ToArray()).ToList();
        }


        public void DeleteTooaeg(int id)
        {
            ParameterList pl = new ParameterList();
            pl.Add(":p1", id);

            Database.SqlQuery<object>("SELECT fn_kustutaTooaeg(:p1)", pl.ToArray()).ToList();
        }

        public void KinnitaTooaeg(int tooaeg_id)
        {
            ParameterList pl = new ParameterList();
            pl.Add(":p1", tooaeg_id);

            Database.SqlQuery<object>("SELECT fn_kinnitaTooaeg(:p1)", pl.ToArray()).ToList();

        }

        public string GetProjektiNimi(Tables.Tooaeg tooaeg)
        {
            var projekt = Projektid.First(p => p.projekt_id == tooaeg.ProjektiLiige.projekt_id);

            return string.Format("{0}, {1}", GetKliendiNimi(projekt.klient_id), projekt.nimi);
        }


        public string GetKliendiNimi(int klient_id)
        {
            var ariklient = Arikliendid.FirstOrDefault(a => a.klient_id == klient_id);
            if (ariklient != null)
            {
                return ariklient.Organisatsioon.nimi;
            }

            var eraklient = Erakliendid.First(a => a.klient_id == klient_id);
            return eraklient.Isik.Nimi;
        }

    }

    public class ParameterList : List<NpgsqlParameter>
    {
        public ParameterList() { }
        public ParameterList(string name, object value)
        {
            Add(name, value);
        }

        public void Add(string name, object value)
        {
            this.Add(new NpgsqlParameter(name, value));
        }
    }
}
