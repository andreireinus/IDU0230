using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Tables
{
    [Table("organisatsioon", Schema = "public")]
    public class Organisatsioon
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int organisatsioon_id { get; set; }

        //[ForeignKey("osapool_id")]
        //public Osapool Osapool { get; set; }
        
        public string registrikood { get; set; }
        public string nimi { get; set; }
    }
}
