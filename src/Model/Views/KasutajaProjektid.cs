using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Views
{
    public class KasutajaProjektid
    {
        public int projekti_liige_id { get; set; }
        public string projekti_nimi { get; set; }
        public int klient_id { get; set; }
        public string kliendi_nimi { get; set; }
    }
}
