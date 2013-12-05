using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Tables
{
    [Table("tootaja_roll", Schema = "public")]
    public class TootajaRoll
    {
        [Key]
        public int tootaja_roll_id { get; set; }
        public string nimetus { get; set; }
        public string kirjeldus { get; set; }
    }
}
