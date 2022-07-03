using System.ComponentModel.DataAnnotations;

namespace ProyAvanzWeb.Tarea2.Models
{
    public class Edificio
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [DataType(DataType.Text)]
        [Display(Name = "Nombre del edificio")]
        public string NombreEdificio { get; set; }

        [Required]
        [DataType(DataType.Text)]
        public int Capacidad { get; set; }

        [Required]
        [DataType(DataType.Date)]
        [Display(Name = "Fecha de compra")]
        public DateTime FechaCompra { get; set; }

        [Required]
        [DataType(DataType.Text)]
        [Display(Name = "Provincia")]
        public int IdProvincia { get; set; }

        public string NombreProvincia { get; set; } = string.Empty;

        [Required]
        [DataType(DataType.Text)]
        [Display(Name = "Cantón")]
        public int IdCanton { get; set; }

        public string NombreCanton { get; set; } = string.Empty;

        [Required]
        [DataType(DataType.Text)]
        [Display(Name = "Distrito")]
        public int IdDistrito { get; set; }

        public string NombreDistrito { get; set; } = string.Empty;

        [Required]
        [DataType(DataType.Text)]
        [Display(Name = "Tipo de propiedad")]
        public int IdTipoPropiedad { get; set; }

        public string NombreTipoPropiedad { get; set; } = string.Empty;

        [Required]
        [DataType(DataType.Date)]
        [Display(Name = "Fecha final del contrato")]
        public DateTime FechaFinalContrato { get; set; }

        [DataType(DataType.Text)]
        public bool Estado { get; set; }

    }
}
