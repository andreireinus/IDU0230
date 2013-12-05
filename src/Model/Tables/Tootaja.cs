using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Tables
{
    [Table("tootaja", Schema = "public")]
    public class Tootaja
    {
        [Key]
        public int tootaja_id { get; set; }

        [ForeignKey("tootaja_id")]
        public virtual Isik Isik { get; set; }

        public string kasutajanimi { get; set; }
        public string parool { get; set; }
    }
}
