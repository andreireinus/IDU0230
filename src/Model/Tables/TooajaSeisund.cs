using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Tables
{

    [Table("tooaja_seisund", Schema = "public")]
    public class TooajaSeisund
    {
        [Key]
        public int tooaja_seisund_id { get; set; }
        public string nimetus { get; set; }
        public string kirjeldus { get; set; }
    }
}
