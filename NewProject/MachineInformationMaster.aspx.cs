using NewProject.Model;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NewProject
{
    public partial class MachineInformationMaster : System.Web.UI.Page
    {
        string constr = ConfigurationManager.ConnectionStrings["ConnString1"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                HttpContext.Current.Session.Clear();
                LoadMachineInformation();
            }
        }



        private void LoadMachineInformation()
        {
            List<MachineInfoEntity> machineInfoEntities = new List<MachineInfoEntity>();
            try
            {
                machineInfoEntities = GetAllEmployeeData();
                if (machineInfoEntities != null && machineInfoEntities.Count > 0)
                {
                    dgMachineInfo.DataSource = machineInfoEntities;
                    dgMachineInfo.DataBind();
                }
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        private List<MachineInfoEntity> GetAllEmployeeData()
        {
            List<MachineInfoEntity> machineInfoEntities = new List<MachineInfoEntity>();
            try
            {
                SqlConnection conn = new SqlConnection(constr);
                SqlCommand cmd = new SqlCommand("select * from machineinformation", conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        machineInfoEntities.Add(new MachineInfoEntity()
                        {
                            MachineID = reader["machineid"].ToString(),
                            MachineDisplayName = reader["MachineDisplayName"].ToString(),
                            MachineType = reader["MachineType"].ToString(),
                            MachineModel = reader["MachineModel"].ToString(),
                            MTB = reader["MachineMTB"].ToString(),
                            ControllerType = reader["ControllerType"].ToString(),
                            CNCPaths = Convert.ToInt32(reader["CNCPaths"]),
                            ServoAxis = Convert.ToInt32(reader["ServoAxis"]),
                            SpindleNumber = Convert.ToInt32(reader["SpindleNumber"]),
                            CNCIP = reader["IP"].ToString(),
                            CNCPortNumber = Convert.ToInt32(reader["IPPortNO"]),
                            IsEnabled = (reader["TPMTrakEnabled"] != null && Convert.ToInt32(reader["TPMTrakEnabled"]).Equals(1)) ? true : false
                        });
                    }
                }
                if (reader != null) reader.Close();
                if (conn != null) conn.Close();
            }
            catch (Exception ex)
            {

            }
            return machineInfoEntities;
        }

        public class MachineInfoEntity
        {
            public string MachineID { get; set; }
            public string MachineDisplayName { get; set; }
            public string MachineType { get; set; }
            public string MachineModel { get; set; }
            public string MTB { get; set; }
            public string ControllerType { get; set; }
            public int CNCPaths { get; set; }
            public int ServoAxis { get; set; }
            public int SpindleNumber { get; set; }
            public string CNCIP { get; set; }
            public int CNCPortNumber { get; set; }
            public bool IsEnabled { get; set; }
        }
    }
}