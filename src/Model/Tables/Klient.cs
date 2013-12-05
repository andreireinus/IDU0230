using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Tables
{
    [Table("klient", Schema = "public")]
    public class Klient
    {
        [Key]
        public int klient_id { get; set; }

        public int tootaja_id { get; set; }

        //[ForeignKey("tootaja_id")]
        //public Tootaja Kliendihaldur { get; set; }
    }
}
