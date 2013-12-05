using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Tables
{
    [Table("isik", Schema = "public")]
    public class Isik
    {
        [Key]
        public int isik_id { get; set; }

        [ForeignKey("isik_id")]
        public Osapool Osapool { get; set; }

        public string eesnimi { get; set; }
        public string perekonnanimi { get; set; }

        [NotMapped]
        public string Nimi
        {
            get
            {
                return string.Format("{0} {1}", eesnimi, perekonnanimi);
            }
        }
    }
}
