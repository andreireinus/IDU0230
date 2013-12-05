using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Tables
{
    [Table("projekti_liige", Schema = "public")]
    public class ProjektiLiige
    {
        public ProjektiLiige()
        {
            Tooajad = new List<Tooaeg>();
        }

        [Key]
        [Column("projekti_liige_id")]
        public int projekti_liige_id { get; set; }

        [Column("tootaja_id")]
        public int tootaja_id { get; set; }

        [ForeignKey("tootaja_id")]
        public Tootaja Tootaja { get; set; }

        [Column("projekt_id")]
        public int projekt_id { get; set; }

        [Column("tootaja_roll_id")]
        public int tootaja_roll_id { get; set; }

        [Column("tunnihind")]
        public decimal Tunnihind { get; set; }

        [Column("on_aktiivne")]
        public bool OnAktiivne { get; set; }

        public ICollection<Tooaeg> Tooajad { get; set; }
    }
}
