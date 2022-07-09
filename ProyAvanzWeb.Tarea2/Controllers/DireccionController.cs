using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using System.Data;
using System.Data.SqlClient;

namespace ProyAvanzWeb.Tarea2.Controllers
{
    public class DireccionController : Controller
    {
        private readonly IConfiguration _configuration;

        public DireccionController(IConfiguration configuration)
        {
            this._configuration = configuration;
        }

        internal List<SelectListItem> getProvincias()
        {
            List<SelectListItem> tmpProvs = new List<SelectListItem>();

            using (SqlConnection sqlConnection = new SqlConnection(_configuration.GetConnectionString("SqlConnection")))
            {
                DataTable tmpTable = new DataTable();
                sqlConnection.Open();
                SqlDataAdapter sqlAdapter = new SqlDataAdapter("usp_provincia_listar", sqlConnection);
                sqlAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;
                sqlAdapter.SelectCommand.Parameters.AddWithValue("salida", 0);
                sqlAdapter.Fill(tmpTable);

                foreach (DataRow row in tmpTable.Rows)
                {
                    tmpProvs.Add(
                        new SelectListItem()
                        {
                            Text = row["Nombre"].ToString(),
                            Value = row["Id"].ToString()
                        }
                    );
                }
            }
            return tmpProvs;
        }

        public IActionResult GetCantones(int id)
        {
            List<SelectListItem> tmpCantones = new List<SelectListItem>();

            using (SqlConnection sqlConnection = new SqlConnection(_configuration.GetConnectionString("SqlConnection")))
            {
                DataTable tmpTable = new DataTable();
                sqlConnection.Open();
                SqlDataAdapter sqlAdapter = new SqlDataAdapter("usp_canton_obtener", sqlConnection);
                sqlAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;
                sqlAdapter.SelectCommand.Parameters.AddWithValue("id", id);
                sqlAdapter.SelectCommand.Parameters.AddWithValue("salida", 0);
                sqlAdapter.Fill(tmpTable);

                foreach (DataRow row in tmpTable.Rows)
                {
                    tmpCantones.Add(
                        new SelectListItem()
                        {
                            Text = row["Nombre"].ToString(),
                            Value = row["Id"].ToString()
                        }
                    );
                }
            }
            return new OkObjectResult(tmpCantones);
        }

        public IActionResult GetDistritos(int id)
        {
            List<SelectListItem> tmpDistritos = new List<SelectListItem>();

            using (SqlConnection sqlConnection = new SqlConnection(_configuration.GetConnectionString("SqlConnection")))
            {
                DataTable tmpTable = new DataTable();
                sqlConnection.Open();
                SqlDataAdapter sqlAdapter = new SqlDataAdapter("usp_distrito_obtener", sqlConnection);
                sqlAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;
                sqlAdapter.SelectCommand.Parameters.AddWithValue("id", id);
                sqlAdapter.SelectCommand.Parameters.AddWithValue("salida", 0);
                sqlAdapter.Fill(tmpTable);

                foreach (DataRow row in tmpTable.Rows)
                {
                    tmpDistritos.Add(
                        new SelectListItem()
                        {
                            Text = row["Nombre"].ToString(),
                            Value = row["Id"].ToString()
                        }
                    );
                }
            }
            return new OkObjectResult(tmpDistritos);
        }
    }
}
