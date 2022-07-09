using System.ComponentModel.DataAnnotations;

namespace ProyAvanzWeb.Tarea2.Models
{
    public class Servicio
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [DataType(DataType.Text)]
        [Display(Name = "Servicio")]
        public string NombreServicio { get; set; }

        [Required]
        [DataType(DataType.Text)]
        [Display(Name = "Tipo de servicio")]
        public int IdTipoServicio { get; set; }

        [Display(Name = "Tipo de servicio")]
        public string NombreTipoServicio { get; set; } = string.Empty;

        [Required]
        [DataType(DataType.Text)]
        [Display(Name = "Unidad de medida")]
        public int IdUnidadMedida { get; set; }

        [Display(Name = "Unidad de medida")]
        public string NombreUnidadMedida { get; set; } = string.Empty;

        [Required]
        [DataType(DataType.Text)]
        [Display(Name = "Empresa")]
        public string Empresa { get; set; }

        [DataType(DataType.Text)]
        public bool Estado { get; set; }
    }
}
