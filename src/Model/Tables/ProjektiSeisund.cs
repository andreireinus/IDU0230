using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Tables
{
    [Table("projekti_seisund", Schema = "public")]
    public class ProjektiSeisund
    {
        [Key]
        public int projekti_seisund_id { get; set; }
        public string nimetus { get; set; }
        public string kirjeldus { get; set; }
    }
}
