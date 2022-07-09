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
    public class ServiciosEdificio : Controller
    {
        private readonly IConfiguration _configuration;
        public ServiciosEdificio(IConfiguration configuration)
        {
            this._configuration = configuration;
        }

        // GET: ServiciosEdificio
        public IActionResult Index()
        {
            DataTable tbl = new DataTable();

            using (SqlConnection sqlConnection = new SqlConnection(_configuration.GetConnectionString("SqlConnection")))
            {
                sqlConnection.Open();
                SqlDataAdapter sqlAdapter = new SqlDataAdapter("usp_serviciosxedificio_listar", sqlConnection);
                sqlAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;
                sqlAdapter.SelectCommand.Parameters.AddWithValue("salida", 0);
                sqlAdapter.Fill(tbl);
            }
            return View(tbl);
        }

        // GET: ServiciosEdificio/Create
        public IActionResult Create()
        {
            ServiciosXEdificio srved = new ServiciosXEdificio();

            ViewData["Edificios"] = getEdificios();
            ViewData["Servicios"] = getServicios();

            return View(srved);
        }

        // POST: ServiciosEdificio/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Create([Bind("IdEdificio,IdServicio,FechaCorte,Consumo")] ServiciosXEdificio serviciosEdificio)
        {
            if (ModelState.IsValid)
            {
                var res = 0;
                ViewData["Edificios"] = getEdificios();
                ViewData["Servicios"] = getServicios();

                using (SqlConnection sqlConnection = new SqlConnection(_configuration.GetConnectionString("SqlConnection")))
                {
                    sqlConnection.Open();
                    SqlCommand sqlCmd = new SqlCommand("usp_serviciosxedificio_guardar", sqlConnection);
                    sqlCmd.CommandType = CommandType.StoredProcedure;
                    sqlCmd.Parameters.AddWithValue("id", 0);
                    sqlCmd.Parameters.AddWithValue("idEdificio", serviciosEdificio.IdEdificio);
                    sqlCmd.Parameters.AddWithValue("idServicio", serviciosEdificio.IdServicio);
                    sqlCmd.Parameters.AddWithValue("FechaCorte", serviciosEdificio.FechaCorte);
                    sqlCmd.Parameters.AddWithValue("Consumo", serviciosEdificio.Consumo);

                    sqlCmd.Parameters.Add("salida", SqlDbType.Int);
                    sqlCmd.Parameters["salida"].Direction = ParameterDirection.Output;

                    sqlCmd.ExecuteNonQuery();

                    res = Convert.ToInt32(sqlCmd.Parameters["salida"].Value);
                }

                if (res == -1)
                {
                    ViewBag.errorMessage = "El servicio ya se encuentra registrado para el edificio";
                }
                else
                {
                    return RedirectToAction(nameof(Index));
                }
            }

            return View(serviciosEdificio);
        }

        // GET: ServiciosEdificio/Edit/5
        public IActionResult Edit(int? id)
        {
            ServiciosXEdificio srved = new ServiciosXEdificio();

            ViewData["Edificios"] = getEdificios();
            ViewData["Servicios"] = getServicios();

            if (id > 0)
            {
                srved = getServiciosXEdificioById(id);
            }

            return View(srved);
        }

        // POST: ServiciosEdificio/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Edit(int id, [Bind("Id,IdEdificio,IdServicio,FechaCorte,Consumo")] ServiciosXEdificio serviciosEdificio)
        {
            if (ModelState.IsValid)
            {
                var res = 0;
                ViewData["Edificios"] = getEdificios();
                ViewData["Servicios"] = getServicios();

                using (SqlConnection sqlConnection = new SqlConnection(_configuration.GetConnectionString("SqlConnection")))
                {

                    sqlConnection.Open();
                    SqlCommand sqlCmd = new SqlCommand("usp_serviciosxedificio_guardar", sqlConnection);
                    sqlCmd.CommandType = CommandType.StoredProcedure;
                    sqlCmd.Parameters.AddWithValue("id", serviciosEdificio.Id);
                    sqlCmd.Parameters.AddWithValue("idEdificio", serviciosEdificio.IdEdificio);
                    sqlCmd.Parameters.AddWithValue("idServicio", serviciosEdificio.IdServicio);
                    sqlCmd.Parameters.AddWithValue("fechaCorte", serviciosEdificio.FechaCorte);
                    sqlCmd.Parameters.AddWithValue("consumo", serviciosEdificio.Consumo);

                    sqlCmd.Parameters.Add("salida", SqlDbType.Int);
                    sqlCmd.Parameters["salida"].Direction = ParameterDirection.Output;
                    
                    sqlCmd.ExecuteNonQuery();

                    res = Convert.ToInt32(sqlCmd.Parameters["salida"].Value);
                }

                if (res==-1)
                {
                    ViewBag.errorMessage = "El servicio ya se encuentra registrado para el edificio";
                }
                else
                {
                    return RedirectToAction(nameof(Index));
                }
            }
            return View(serviciosEdificio);
        }

        // GET: ServiciosEdificio/Delete/5
        public IActionResult Delete(int? id)
        {
            ServiciosXEdificio srved = getServiciosXEdificioById(id);

            return View(srved);
        }

        // POST: ServiciosEdificio/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public IActionResult DeleteConfirmed(int id)
        {
            using (SqlConnection sqlConnection = new SqlConnection(_configuration.GetConnectionString("SqlConnection")))
            {
                sqlConnection.Open();
                SqlCommand sqlCmd = new SqlCommand("usp_serviciosxedificio_eliminar", sqlConnection);
                sqlCmd.CommandType = CommandType.StoredProcedure;
                sqlCmd.Parameters.AddWithValue("id", id);
                sqlCmd.Parameters.AddWithValue("salida", 0);
                sqlCmd.ExecuteNonQuery();
            }
            return RedirectToAction(nameof(Index));
        }

        // LIST EDIFICIOS
        internal List<SelectListItem> getEdificios()
        {
            List<SelectListItem> tmpEdificios = new List<SelectListItem>();

            using (SqlConnection sqlConnection = new SqlConnection(_configuration.GetConnectionString("SqlConnection")))
            {
                DataTable tmpTable = new DataTable();
                sqlConnection.Open();
                SqlDataAdapter sqlAdapter = new SqlDataAdapter("usp_edificio_listar", sqlConnection);
                sqlAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;
                sqlAdapter.SelectCommand.Parameters.AddWithValue("salida", 0);
                sqlAdapter.Fill(tmpTable);

                foreach (DataRow row in tmpTable.Rows)
                {
                    tmpEdificios.Add(
                        new SelectListItem()
                        {
                            Text = row["NombreEdificio"].ToString(),
                            Value = row["Id"].ToString()
                        }
                    );
                }
            }
            return tmpEdificios;
        }

        // LIST SERVICIOS
        internal List<SelectListItem> getServicios()
        {
            List<SelectListItem> tmpServicios = new List<SelectListItem>();

            using (SqlConnection sqlConnection = new SqlConnection(_configuration.GetConnectionString("SqlConnection")))
            {
                DataTable tmpTable = new DataTable();
                sqlConnection.Open();
                SqlDataAdapter sqlAdapter = new SqlDataAdapter("usp_servicio_listar", sqlConnection);
                sqlAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;
                sqlAdapter.SelectCommand.Parameters.AddWithValue("salida", 0);
                sqlAdapter.Fill(tmpTable);

                foreach (DataRow row in tmpTable.Rows)
                {
                    tmpServicios.Add(
                        new SelectListItem()
                        {
                            Text = row["NombreServicio"].ToString(),
                            Value = row["Id"].ToString()
                        }
                    );
                }
            }
            return tmpServicios;
        }

        internal ServiciosXEdificio getServiciosXEdificioById(int? id)
        {
            ServiciosXEdificio srvEd = new ServiciosXEdificio();

            using (SqlConnection sqlConnection = new SqlConnection(_configuration.GetConnectionString("SqlConnection")))
            {
                DataTable tmpTable = new DataTable();
                sqlConnection.Open();
                SqlDataAdapter sqlAdapter = new SqlDataAdapter("usp_serviciosxedificio_obtener", sqlConnection);
                sqlAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;
                sqlAdapter.SelectCommand.Parameters.AddWithValue("id", id);
                sqlAdapter.SelectCommand.Parameters.AddWithValue("salida", 0);
                sqlAdapter.Fill(tmpTable);

                foreach (DataRow row in tmpTable.Rows)
                {
                    srvEd.Id = Convert.ToInt32(row["Id"]);
                    srvEd.IdEdificio = Convert.ToInt32(row["IdEdificio"]);
                    srvEd.NombreEdificio = row["NombreEdificio"].ToString();
                    srvEd.IdServicio = Convert.ToInt32(row["IdServicio"]);
                    srvEd.NombreServicio = row["NombreServicio"].ToString();
                    srvEd.FechaCorte = Convert.ToDateTime(row["FechaCorte"]);
                    srvEd.Consumo = Convert.ToDecimal(row["Consumo"]);
                }
            }

            return srvEd;
        }
    }
}
