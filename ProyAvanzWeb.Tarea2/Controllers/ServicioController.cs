using Microsoft.AspNetCore.Mvc;

namespace ProyAvanzWeb.Tarea2.Controllers
{
    public class ServicioController : Controller
    {
        public IActionResult Servicio()
        {
            return View();
        }
        public IActionResult AddServicio()
        {
            return View();
        }
    }
}
