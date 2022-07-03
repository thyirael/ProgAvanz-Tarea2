
namespace ProyAvanzWeb.Tarea2.Models
{
    public class ServiciosXEdificio
    {
        public int IdEdificio { get; set; }
        public int IdServicio { get; set; }
        public DateTime FechaCorte { get; set; }
        public decimal Consumo { get; set; }
    }
}
