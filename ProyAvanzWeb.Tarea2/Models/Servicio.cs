namespace ProyAvanzWeb.Tarea2.Models
{
    public class Servicio
    {
        public int Id { get; set; }
        public string NombreServicio { get; set; }
        public int IdTipoServicio { get; set; }
        public int IdUnidadMedida { get; set; }
        public string Empresa { get; set; }
        public bool Estado { get; set; }
    }
}
