using Dapper;

namespace ProyAvanzWeb.Tarea2.DataAccess
{
    public class DataAccess : IDisposable
    {
        private readonly DapperContext _context;

        public DataAccess(DapperContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<Provincia>> GetAll()
        {

        }

        public void Dispose()
        {
        }
    }
}