namespace ProyAvanzWeb.Tarea2.Models
{
    public class ErrorViewModel
    {
        public string? RequestId { get; set; }

        public bool ShowRequestId => !string.IsNullOrEmpty(RequestId);
        public string messageDetail { get; set; }
    }
}