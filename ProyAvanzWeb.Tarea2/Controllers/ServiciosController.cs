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
    public class ServiciosController : Controller
    {
        private readonly IConfiguration _configuration;
        public ServiciosController(IConfiguration configuration)
        {
            this._configuration = configuration;
        }

        // GET: Servicios
        public IActionResult Index()
        {
            DataTable tbl = new DataTable();

            using (SqlConnection sqlConnection = new SqlConnection(_configuration.GetConnectionString("SqlConnection")))
            {
                sqlConnection.Open();
                SqlDataAdapter sqlAdapter = new SqlDataAdapter("usp_servicio_listar", sqlConnection);
                sqlAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;
                sqlAdapter.SelectCommand.Parameters.AddWithValue("salida", 0);
                sqlAdapter.Fill(tbl);
            }
            return View(tbl);
        }

        // GET: Servicios/Create
        public IActionResult Create()
        {
            Servicio srv = new Servicio();

            ViewData["TipoServicios"] = getTiposServicio();
            ViewData["Unidades"] = getUnidadesMedida();

            return View(srv);
        }

        // POST: Servicios/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Create([Bind("NombreServicio,IdTipoServicio,IdUnidadMedida,Empresa")] Servicio servicio)
        {
            if (ModelState.IsValid)
            {
                using (SqlConnection sqlConnection = new SqlConnection(_configuration.GetConnectionString("SqlConnection")))
                {
                    sqlConnection.Open();
                    SqlCommand sqlCmd = new SqlCommand("usp_servicio_guardar", sqlConnection);
                    sqlCmd.CommandType = CommandType.StoredProcedure;
                    sqlCmd.Parameters.AddWithValue("id", 0);
                    sqlCmd.Parameters.AddWithValue("nombreServicio", servicio.NombreServicio);
                    sqlCmd.Parameters.AddWithValue("idTipoServicio", servicio.IdTipoServicio);
                    sqlCmd.Parameters.AddWithValue("idUnidadMedida", servicio.IdUnidadMedida);
                    sqlCmd.Parameters.AddWithValue("empresa", servicio.Empresa);
                    sqlCmd.Parameters.AddWithValue("estado", 1);
                    sqlCmd.Parameters.AddWithValue("salida", 0);
                    sqlCmd.ExecuteNonQuery();
                }

                return RedirectToAction(nameof(Index));
            }

            return View(servicio);
        }

        // GET: Servicios/Edit/5
        public IActionResult Edit(int? id)
        {
            Servicio servicio = new Servicio();

            ViewData["TipoServicios"] = getTiposServicio();
            ViewData["Unidades"] = getUnidadesMedida();

            if (id > 0)
            {
                servicio = getServicioById(id);
            }

            return View(servicio);
        }

        // POST: Servicio/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Edit(int id, [Bind("Id,NombreServicio,IdTipoServicio,IdUnidadMedida,Empresa,Estado")] Servicio servicio)
        {
            if (ModelState.IsValid)
            {
                using (SqlConnection sqlConnection = new SqlConnection(_configuration.GetConnectionString("SqlConnection")))
                {
                    sqlConnection.Open();
                    SqlCommand sqlCmd = new SqlCommand("usp_servicio_guardar", sqlConnection);
                    sqlCmd.CommandType = CommandType.StoredProcedure;
                    sqlCmd.Parameters.AddWithValue("id", servicio.Id);
                    sqlCmd.Parameters.AddWithValue("nombreServicio", servicio.NombreServicio);
                    sqlCmd.Parameters.AddWithValue("idTipoServicio", servicio.IdTipoServicio);
                    sqlCmd.Parameters.AddWithValue("idUnidadMedida", servicio.IdUnidadMedida);
                    sqlCmd.Parameters.AddWithValue("empresa", servicio.Empresa);
                    sqlCmd.Parameters.AddWithValue("estado", servicio.Estado);
                    sqlCmd.Parameters.AddWithValue("salida", 0);
                    sqlCmd.ExecuteNonQuery();
                }

                return RedirectToAction(nameof(Index));
            }

            return View(servicio);
        }

        // GET: Servicio/Delete/5
        public IActionResult Delete(int? id)
        {
            Servicio srv = getServicioById(id);

            return View(srv);
        }

        // POST: Servicio/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public IActionResult DeleteConfirmed(int id)
        {
            using (SqlConnection sqlConnection = new SqlConnection(_configuration.GetConnectionString("SqlConnection")))
            {
                sqlConnection.Open();
                SqlCommand sqlCmd = new SqlCommand("usp_servicio_eliminar", sqlConnection);
                sqlCmd.CommandType = CommandType.StoredProcedure;
                sqlCmd.Parameters.AddWithValue("id", id);
                sqlCmd.Parameters.AddWithValue("salida", 0);
                sqlCmd.ExecuteNonQuery();
            }
            return RedirectToAction(nameof(Index));
        }

        // LIST TIPO SERVICIO
        internal List<SelectListItem> getTiposServicio()
        {
            List<SelectListItem> tmpTipos = new List<SelectListItem>();

            using (SqlConnection sqlConnection = new SqlConnection(_configuration.GetConnectionString("SqlConnection")))
            {
                DataTable tmpTable = new DataTable();
                sqlConnection.Open();
                SqlDataAdapter sqlAdapter = new SqlDataAdapter("usp_tipoServicio_listar", sqlConnection);
                sqlAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;
                sqlAdapter.SelectCommand.Parameters.AddWithValue("salida", 0);
                sqlAdapter.Fill(tmpTable);

                foreach (DataRow row in tmpTable.Rows)
                {
                    tmpTipos.Add(
                        new SelectListItem()
                        {
                            Text = row["Nombre"].ToString(),
                            Value = row["Id"].ToString()
                        }
                    );
                }
            }
            return tmpTipos;
        }

        // LIST UNIDAD MEDIDA
        internal List<SelectListItem> getUnidadesMedida()
        {
            List<SelectListItem> tmpUnidades = new List<SelectListItem>();

            using (SqlConnection sqlConnection = new SqlConnection(_configuration.GetConnectionString("SqlConnection")))
            {
                DataTable tmpTable = new DataTable();
                sqlConnection.Open();
                SqlDataAdapter sqlAdapter = new SqlDataAdapter("usp_unidadMedida_listar", sqlConnection);
                sqlAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;
                sqlAdapter.SelectCommand.Parameters.AddWithValue("salida", 0);
                sqlAdapter.Fill(tmpTable);

                foreach (DataRow row in tmpTable.Rows)
                {
                    tmpUnidades.Add(
                        new SelectListItem()
                        {
                            Text = row["NombreUnidad"].ToString(),
                            Value = row["Id"].ToString()
                        }
                    );
                }
            }
            return tmpUnidades;
        }

        internal Servicio getServicioById(int? id)
        {
            Servicio srv = new Servicio();

            using (SqlConnection sqlConnection = new SqlConnection(_configuration.GetConnectionString("SqlConnection")))
            {
                DataTable tmpTable = new DataTable();
                sqlConnection.Open();
                SqlDataAdapter sqlAdapter = new SqlDataAdapter("usp_servicio_obtener", sqlConnection);
                sqlAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;
                sqlAdapter.SelectCommand.Parameters.AddWithValue("id", id);
                sqlAdapter.SelectCommand.Parameters.AddWithValue("salida", 0);
                sqlAdapter.Fill(tmpTable);

                foreach (DataRow row in tmpTable.Rows)
                {
                    srv.Id = Convert.ToInt32(row["Id"]);
                    srv.NombreServicio = row["NombreServicio"].ToString();
                    srv.IdTipoServicio = Convert.ToInt32(row["IdTipoServicio"]);
                    srv.NombreTipoServicio = row["NombreTipoServicio"].ToString();
                    srv.IdUnidadMedida = Convert.ToInt32(row["IdUnidadMedida"]);
                    srv.NombreUnidadMedida = row["NombreUnidadMedida"].ToString();
                    srv.Empresa = row["Empresa"].ToString();
                    srv.Estado = Convert.ToBoolean(row["Estado"]);
                }
            }

            return srv;
        }
    }
}
