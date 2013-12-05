using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Tables
{
    [Table("tooaeg", Schema = "public")]
    public class Tooaeg
    {
        [Key]
        [Column("tooaeg_id")]
        public int tooaeg_id { get; set; }

        [Column("projekti_liige_id")]
        public int projekti_liige_id { get; set; }

        [ForeignKey("projekti_liige_id")]
        public virtual ProjektiLiige ProjektiLiige { get; set; }

        [Column("tooaja_seisund_id")]
        public int tooaja_seisund_id { get; set; }
        
        //[ForeignKey("Tooaja_Seisund_ID")]
        //public virtual TooajaSeisund TooajaSeisund { get; set; }

        public DateTime algus { get; set; }
        public DateTime lopp { get; set; }
        public string kirjeldus { get; set; }
    }
}
