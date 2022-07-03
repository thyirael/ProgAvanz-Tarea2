using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using ProyAvanzWeb.Tarea2.Models;

namespace ProyAvanzWeb.Tarea2.Data
{
    public class ProyAvanzWebTarea2Context : DbContext
    {
        public ProyAvanzWebTarea2Context (DbContextOptions<ProyAvanzWebTarea2Context> options)
            : base(options)
        {
        }

        public DbSet<ProyAvanzWeb.Tarea2.Models.Edificio>? Edificio { get; set; }
    }
}
