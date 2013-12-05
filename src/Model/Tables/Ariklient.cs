using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Tables
{
    [Table("ariklient", Schema = "public")]
    public class Ariklient
    {
        [Key]
        public int klient_id { get; set; }
        public int organisatsioon_id { get; set; }

        [ForeignKey("organisatsioon_id")]
        public virtual Organisatsioon Organisatsioon { get; set; }
    }
}
