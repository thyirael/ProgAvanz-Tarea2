using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using ProyAvanzWeb.Tarea2.Data;
using ProyAvanzWeb.Tarea2.Models;

namespace ProyAvanzWeb.Tarea2.Controllers
{
    public class EdificiosController : Controller
    {
        private readonly IConfiguration _configuration;

        public EdificiosController(IConfiguration configuration)
        {
            this._configuration = configuration;
        }

        // GET: Edificios
        public IActionResult Index()
        {
            DataTable tbl = new DataTable();

            using (SqlConnection sqlConnection = new SqlConnection(_configuration.GetConnectionString("SqlConnection")))
            {
                sqlConnection.Open();
                SqlDataAdapter sqlAdapter = new SqlDataAdapter("usp_edificio_listar", sqlConnection);
                sqlAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;
                sqlAdapter.SelectCommand.Parameters.AddWithValue("salida", 0);
                sqlAdapter.Fill(tbl);
            }
            return View(tbl);
        }

        // GET: Edificios/Create
        public IActionResult Create()
        {
            Edificio ed = new Edificio();

            using (DireccionController c = new DireccionController(_configuration))
            {
                ViewData["Provincias"] = c.getProvincias();
            }

            return View(ed);
        }

        // POST: Edificios/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Create([Bind("NombreEdificio,Capacidad,FechaCompra,IdProvincia,IdCanton,IdDistrito,IdTipoPropiedad,FechaFinalContrato")] Edificio edificio)
        {
            if (ModelState.IsValid)
            {
                using (SqlConnection sqlConnection = new SqlConnection(_configuration.GetConnectionString("SqlConnection")))
                {
                    sqlConnection.Open();
                    SqlCommand sqlCmd = new SqlCommand("usp_edificio_guardar", sqlConnection);
                    sqlCmd.CommandType = CommandType.StoredProcedure;
                    sqlCmd.Parameters.AddWithValue("id", 0);
                    sqlCmd.Parameters.AddWithValue("nombreEdificio", edificio.NombreEdificio);
                    sqlCmd.Parameters.AddWithValue("capacidad", edificio.Capacidad);
                    sqlCmd.Parameters.AddWithValue("fechaCompra", edificio.FechaCompra);
                    sqlCmd.Parameters.AddWithValue("idProvincia", edificio.IdProvincia);
                    sqlCmd.Parameters.AddWithValue("idCanton", edificio.IdCanton);
                    sqlCmd.Parameters.AddWithValue("idDistrito", edificio.IdDistrito);
                    sqlCmd.Parameters.AddWithValue("idTipoPropiedad", edificio.IdTipoPropiedad);
                    sqlCmd.Parameters.AddWithValue("fechaFinalContrato", string.IsNullOrEmpty(edificio.FechaFinalContrato.ToString())? DateTime.Parse("01/01/1900"): edificio.FechaFinalContrato);
                    sqlCmd.Parameters.AddWithValue("estado", 1);
                    sqlCmd.Parameters.AddWithValue("salida", 0);
                    sqlCmd.ExecuteNonQuery();
                }

                return RedirectToAction(nameof(Index));
            }

            return View(edificio);
        }

        // GET: Edificios/Edit/5
        public IActionResult Edit(int? id)
        {
            Edificio edificio = new Edificio();

            using (DireccionController c = new DireccionController(_configuration))
            {
                ViewData["Provincias"] = c.getProvincias();
            }

            if (id > 0)
            {
                edificio = getEdificioById(id);
            }

            return View(edificio);
        }

        // POST: Edificios/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Edit(int id, [Bind("Id,NombreEdificio,Capacidad,FechaCompra,IdProvincia,IdCanton,IdDistrito,IdTipoPropiedad,FechaFinalContrato,Estado")] Edificio edificio)
        {
            if (ModelState.IsValid)
            {
                using (SqlConnection sqlConnection = new SqlConnection(_configuration.GetConnectionString("SqlConnection")))
                {
                    sqlConnection.Open();
                    SqlCommand sqlCmd = new SqlCommand("usp_edificio_guardar", sqlConnection);
                    sqlCmd.CommandType = CommandType.StoredProcedure;
                    sqlCmd.Parameters.AddWithValue("id", edificio.Id);
                    sqlCmd.Parameters.AddWithValue("nombreEdificio", edificio.NombreEdificio);
                    sqlCmd.Parameters.AddWithValue("capacidad", edificio.Capacidad);
                    sqlCmd.Parameters.AddWithValue("fechaCompra", edificio.FechaCompra);
                    sqlCmd.Parameters.AddWithValue("idProvincia", edificio.IdProvincia);
                    sqlCmd.Parameters.AddWithValue("idCanton", edificio.IdCanton);
                    sqlCmd.Parameters.AddWithValue("idDistrito", edificio.IdDistrito);
                    sqlCmd.Parameters.AddWithValue("idTipoPropiedad", edificio.IdTipoPropiedad);
                    sqlCmd.Parameters.AddWithValue("fechaFinalContrato", string.IsNullOrEmpty(edificio.FechaFinalContrato.ToString()) ? DateTime.Parse("01/01/1900") : edificio.FechaFinalContrato);
                    sqlCmd.Parameters.AddWithValue("estado", edificio.Estado);
                    sqlCmd.Parameters.AddWithValue("salida", 0);
                    sqlCmd.ExecuteNonQuery();
                }

                return RedirectToAction(nameof(Index));
            }

            return View(edificio);
        }

        // GET: Edificios/Delete/5
        public IActionResult Delete(int? id)
        {
            Edificio edf = getEdificioById(id);

            return View(edf);
        }

        // POST: Edificios/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public IActionResult DeleteConfirmed(int id)
        {
            using (SqlConnection sqlConnection = new SqlConnection(_configuration.GetConnectionString("SqlConnection")))
            {
                sqlConnection.Open();
                SqlCommand sqlCmd = new SqlCommand("usp_edificio_eliminar", sqlConnection);
                sqlCmd.CommandType = CommandType.StoredProcedure;
                sqlCmd.Parameters.AddWithValue("id", id);
                sqlCmd.Parameters.AddWithValue("salida", 0);
                sqlCmd.ExecuteNonQuery();
            }
            return RedirectToAction(nameof(Index));
        }

        internal Edificio getEdificioById(int? id)
        {
            Edificio edf = new Edificio();

            using (SqlConnection sqlConnection = new SqlConnection(_configuration.GetConnectionString("SqlConnection")))
            {
                DataTable tmpTable = new DataTable();
                sqlConnection.Open();
                SqlDataAdapter sqlAdapter = new SqlDataAdapter("usp_edificio_obtener", sqlConnection);
                sqlAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;
                sqlAdapter.SelectCommand.Parameters.AddWithValue("id", id);
                sqlAdapter.SelectCommand.Parameters.AddWithValue("salida", 0);
                sqlAdapter.Fill(tmpTable);

                foreach (DataRow row in tmpTable.Rows)
                {
                    edf.Id = Convert.ToInt32(row["Id"]);
                    edf.NombreEdificio = row["NombreEdificio"].ToString();
                    edf.Capacidad = Convert.ToInt32(row["Capacidad"]);
                    edf.FechaCompra = Convert.ToDateTime(row["FechaCompra"]);
                    edf.IdProvincia = Convert.ToInt32(row["IdProvincia"]);
                    edf.NombreProvincia = row["NombreProvincia"].ToString();
                    edf.IdCanton = Convert.ToInt32(row["IdCanton"]);
                    edf.NombreCanton = row["NombreCanton"].ToString();
                    edf.IdDistrito = Convert.ToInt32(row["IdDistrito"]);
                    edf.NombreDistrito = row["NombreDistrito"].ToString();
                    edf.IdTipoPropiedad = Convert.ToInt32(row["IdTipoPropiedad"]);
                    edf.NombreTipoPropiedad = row["NombreTipoPropiedad"].ToString();
                    edf.FechaFinalContrato = Convert.ToDateTime(row["FechaFinalContrato"]);
                    edf.Estado = Convert.ToBoolean(row["Estado"]);
                }
            }

            return edf;
        }

        
    }
}
