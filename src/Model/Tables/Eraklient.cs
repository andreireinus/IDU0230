using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Tables
{
    [Table("eraklient", Schema = "public")]
    public class Eraklient
    {
        [Key]
        public int klient_id { get; set; }
        public int isik_id { get; set; }

        [ForeignKey("isik_id")]
        public virtual Isik Isik { get; set; }
    }
}
