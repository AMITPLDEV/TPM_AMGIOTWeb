using Elmah;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.Configuration;

namespace NewProject.DataBaseAccess
{
    public class ConnectionManager
    {
        #region "Create Connection String---"
        static string conString = WebConfigurationManager.ConnectionStrings["ConString"].ToString();


        public static bool timeOut = false;
        public static SqlConnection GetConnection()
        {

            bool writeDown = false;
            DateTime dt = DateTime.Now;
            SqlConnection conn = new SqlConnection(conString);
            do
            {
                try
                {
                    // SqlDependency.Stop(WebConfigurationManager.ConnectionStrings["ConString"].ConnectionString);
                    // if (conn.State == ConnectionState.Open)
                    //   conn.Close();

                    conn.Open();

                }
                catch (Exception ex)
                {
                    if (writeDown == false)
                    {
                        dt = DateTime.Now.AddSeconds(60);
                        Logger.WriteErrorLog(ex.Message);
                        ErrorSignal.FromCurrentContext().Raise(ex);
                        writeDown = true;

                    }
                    if (dt < DateTime.Now)
                    {
                        Logger.WriteErrorLog(ex.Message);
                        ErrorSignal.FromCurrentContext().Raise(ex);
                        throw;
                    }
                    Thread.Sleep(1000);
                }

            } while (conn.State != ConnectionState.Open);
            return conn;
        }
        #endregion
    }
}