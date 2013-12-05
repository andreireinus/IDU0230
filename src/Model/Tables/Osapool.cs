using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Tables
{
    [Table("osapool", Schema = "public")]
    public class Osapool
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int osapool_id { get; set; }

        public string aadress { get; set; }
        public string telefon { get; set; }
        public string email { get; set; }

        //[ForeignKey("osapool_id")]
        //public virtual Isik Isik { get; set; }

        //[ForeignKey("osapool_id")]
        //public virtual Organisatsioon Organisatsioon { get; set; }

    }
}
