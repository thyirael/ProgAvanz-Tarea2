using System.ComponentModel.DataAnnotations;

namespace ProyAvanzWeb.Tarea2.Models
{
    public class ServiciosXEdificio
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [DataType(DataType.Text)]
        [Display(Name = "Edificio")]
        public int IdEdificio { get; set; }

        [Display(Name = "Edificio")]
        public string NombreEdificio { get; set; } = string.Empty;

        [Required]
        [DataType(DataType.Text)]
        [Display(Name = "Servicio")]
        public int IdServicio { get; set; }

        [Display(Name = "Servicio")]
        public string NombreServicio { get; set; } = string.Empty;

        [Required]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:dd MMM yyyy}")]
        public DateTime FechaCorte { get; set; }

        [Required]
        [DataType(DataType.Text)]
        public decimal Consumo { get; set; }
    }
}
