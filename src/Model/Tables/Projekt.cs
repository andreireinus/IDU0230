using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Tables
{
    [Table("projekt", Schema = "public")]
    public class Projekt
    {
        [Key]
        public int projekt_id { get; set; }
        public int klient_id { get; set; }
        public int projekti_seisund_id { get; set; }
        public string nimi { get; set; }
    }
}
