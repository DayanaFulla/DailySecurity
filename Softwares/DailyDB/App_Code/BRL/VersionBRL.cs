using DailyDB.App_Code.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DailyDB.App_Code.BRL
{
    class VersionBRL
    {
        private static Model.Version GetVersionFromRow(VersionDS.VersionRow row)
        {
            return new Model.Version()
            {
                versionMayor = row.versionMayor,
                versionMenor = row.versionMenor,
                patch = row.patch
            };
        }

        public static Model.Version GetVersion()
        {
            DAL.VersionDSTableAdapters.VersionTableAdapter adapter = new DAL.VersionDSTableAdapters.VersionTableAdapter();
            VersionDS.VersionDataTable table = adapter.GetVersion();
            if (table.Rows.Count == 0)
                return null;

            Model.Version version = GetVersionFromRow(table[0]);
            return version;
        }
    }
}
