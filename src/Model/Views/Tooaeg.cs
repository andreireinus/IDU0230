using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Views
{
    public class TooaegList
    {
        public bool ShowActiveOnly { get; set; }
        public List<Tooaeg> Tooajad { get; set; }
    }

    public class Tooaeg
    {
        [Column("tooaeg_id")]
        public int tooaeg_id { get; set; }

        [Column("seisund_nimetus")]
        [DisplayName("Seisund")]
        public string seisund_nimetus { get; set; }

        [Column("algus")]
        [DisplayName("Algus")]
        [DisplayFormat(DataFormatString = "{0:dd.MM.yyyy HH:mm}")]
        public DateTime algus { get; set; }

        [Column("lopp")]
        [DisplayName("Lõpp")]
        [DisplayFormat(DataFormatString = "{0:dd.MM.yyyy HH:mm}")]
        public DateTime lopp { get; set; }

        [Column("kirjeldus")]
        [DisplayName("Kirjeldus")]
        public string kirjeldus { get; set; }

        [Column("projekti_nimi")]
        [DisplayName("Projekt")]
        public string projekti_nimi { get; set; }

        [Column("kliendi_nimi")]
        [DisplayName("Klient")]
        public string kliendi_nimi { get; set; }
    }

    public class TooaegCreate
    {
        public TooaegCreate()
        {
            Messages = new Messages();
        }
        public Messages Messages { get; set; }

        [Required(ErrorMessage = "Projekt on valimata")]
        [DisplayName("Projekt")]
        public int ValitudProjektNr { get; set; }

        [Required(ErrorMessage = "Algus on kohustuslik väli")]
        [DisplayName("Algus")]
        [DisplayFormat(DataFormatString = "{0:dd.MM.yyyy HH:mm}")]
        public DateTime Algus { get; set; }

        [Required(ErrorMessage = "Lõpp on kohustuslik väli")]
        [DisplayName("Lõpp")]
        [DisplayFormat(DataFormatString = "{0:dd.MM.yyyy HH:mm}")]
        public DateTime Lopp { get; set; }

        [Required(ErrorMessage = "Kirjeldus on kohustuslik väli")]
        [DisplayName("Kirjeldus")]
        public string Kirjeldus { get; set; }
    }

    public class TooaegEdit
    {
        public TooaegEdit()
        {
            Messages = new Messages();
        }
        public Messages Messages { get; set; }

        [Required]
        [DisplayName("Projekt")]
        public string ProjektiNimi { get; set; }

        [Required]
        public int TooaegId { get; set; }

        [DisplayName("Algus")]
        [Required(ErrorMessage = "Algus on kohustuslik väli")]
        [DisplayFormat(ApplyFormatInEditMode = true, DataFormatString = "{0:dd.MM.yyyy HH:mm}")]
        public DateTime Algus { get; set; }

        [DisplayName("Lõpp")]
        [Required(ErrorMessage = "Lõpp on kohustuslik väli")]
        [DisplayFormat(ApplyFormatInEditMode = true, DataFormatString = "{0:dd.MM.yyyy HH:mm}")]
        public DateTime Lopp { get; set; }

        [DisplayName("Kirjeldus")]
        [Required(ErrorMessage = "Kirjeldus on kohustuslik väli")]
        public string Kirjeldus { get; set; }
    }

    public class Messages : List<Message>
    {
        public void Error(string message)
        {
            Add(new Message { Type = "Error", Text = message });
        }
    }
    public class Message
    {
        public string Type { get; set; }
        public string Text { get; set; }
    }
}
