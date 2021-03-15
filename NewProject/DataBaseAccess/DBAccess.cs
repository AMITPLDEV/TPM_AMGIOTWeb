using NewProject.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace NewProject.DataBaseAccess
{

    public class DBAccess
    {
        internal static List<string> getCompanyData()
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<string> listData = new List<string>();
            try
            {
                SqlCommand cmd = new SqlCommand("select distinct CompanyID from Company where EffectiveTodate='9999-12-31 00:00:00.000'", con);
                cmd.CommandType = CommandType.Text;
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        listData.Add(sdr["CompanyID"].ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("While getting Company Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return listData;
        }
        internal static List<string> getPlantData(string company)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<string> listData = new List<string>();
            try
            {
                SqlCommand cmd = new SqlCommand("select distinct PlantID from PlantInformation where  (CompanyID=@company or ISNULL(@company,'')='') and EffectiveToDate='9999-12-31 00:00:00.000'", con);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@company", (company));
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        listData.Add(sdr["PlantID"].ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("While getting PlantID Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return listData;
        }
        internal static List<string> getCNCMakeData(string company, string plant)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<string> listData = new List<string>();
            try
            {
                SqlCommand cmd = new SqlCommand("select distinct CNC_Make from CNCMakeModelInfo  where (CompanyID=@company or ISNULL(@company,'')='') and (PlantID=@plant or ISNULL(@plant,'')='')", con);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@company", company);
                cmd.Parameters.AddWithValue("@plant", plant);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        listData.Add(sdr["CNC_Make"].ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("While getting CNC Make Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return listData;
        }
        internal static List<string> getPLCMakeData(string company, string plant)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<string> listData = new List<string>();
            try
            {
                SqlCommand cmd = new SqlCommand("select distinct PLC_Make from PLCMakeModelInfo  where (CompanyID=@company or ISNULL(@company,'')='') and (PlantID=@plant or ISNULL(@plant,'')='')", con);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@company", company);
                cmd.Parameters.AddWithValue("@plant", plant);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        listData.Add(sdr["PLC_Make"].ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("While getting PLC_Make Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return listData;
        }
        internal static List<string> getCNCModelData(string company, string plant, string cncMake)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<string> listData = new List<string>();
            try
            {
                SqlCommand cmd = new SqlCommand("select distinct CNC_Model from CNCMakeModelInfo where CNC_Make=@make  and  (CompanyID=@company or ISNULL(@company,'')='') and (PlantID=@plant or ISNULL(@plant,'')='')", con);
                cmd.Parameters.AddWithValue("@make", cncMake);
                cmd.Parameters.AddWithValue("@company", company);
                cmd.Parameters.AddWithValue("@plant", plant);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        listData.Add(sdr["CNC_Model"].ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("While getting CNC Make Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return listData;
        }
        internal static List<string> getPLCModelData(string company, string plant, string plcMake)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<string> listData = new List<string>();
            try
            {
                SqlCommand cmd = new SqlCommand("select distinct PLC_Model from PLCMakeModelInfo where PLC_Make=@make  and  (CompanyID=@company or ISNULL(@company,'')='') and (PlantID=@plant or ISNULL(@plant,'')='')", con);
                cmd.Parameters.AddWithValue("@make", plcMake);
                cmd.Parameters.AddWithValue("@company", company);
                cmd.Parameters.AddWithValue("@plant", plant);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        listData.Add(sdr["PLC_Model"].ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("getPLCModelData " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return listData;
        }
        internal static List<string> getInterface()
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<string> listData = new List<string>();
            try
            {
                SqlCommand cmd = new SqlCommand("select distinct Interface from InterfaceProtocolInfo", con);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        listData.Add(sdr["Interface"].ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("getInterface " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return listData;
        }
        internal static List<string> getProtocol(string interfaceid)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<string> listData = new List<string>();
            try
            {
                SqlCommand cmd = new SqlCommand("select distinct Protocol from InterfaceProtocolInfo where Interface=@Interface", con);
                cmd.Parameters.AddWithValue("@Interface", interfaceid);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        listData.Add(sdr["Protocol"].ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("getProtocol " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return listData;
        }
        internal static List<string> getMTBData(string company, string plant, string cncMake, string cncModel)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<string> listData = new List<string>();
            try
            {
                SqlCommand cmd = new SqlCommand("select distinct MTB from MachineTypeModelInfo where (CNC_Make=@cncmake or ISNULL(@cncmake,'')='') and (CNC_Model=@cncmodel or ISNULL(@cncmodel,'')='') and (CompanyID=@company or ISNULL(@company,'')='') and  (PlantID=@plant or ISNULL(@plant,'')='')", con);
                cmd.Parameters.AddWithValue("@cncmake", cncMake);
                cmd.Parameters.AddWithValue("@cncmodel", cncModel);
                cmd.Parameters.AddWithValue("@company", company);
                cmd.Parameters.AddWithValue("@plant", plant);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        listData.Add(sdr["MTB"].ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("While getting MTB Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return listData;
        }
        internal static List<string> getMachineTypeData(string company, string plant, string cncMake, string cncModel, string mtb)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<string> listData = new List<string>();
            try
            {
                SqlCommand cmd = new SqlCommand("select distinct MachineType from MachineTypeModelInfo where (CNC_Make=@cncmake or ISNULL(@cncmake,'')='') and (CNC_Model=@cncmodel or ISNULL(@cncmodel,'')='')   and  (MTB=@mtb or ISNULL(@mtb,'')='') and (CompanyID=@company or ISNULL(@company,'')='') and  (PlantID=@plant or ISNULL(@plant,'')='')", con);
                cmd.Parameters.AddWithValue("@cncmake", cncMake);
                cmd.Parameters.AddWithValue("@cncmodel", cncModel);
                cmd.Parameters.AddWithValue("@mtb", mtb);
                cmd.Parameters.AddWithValue("@company", company);
                cmd.Parameters.AddWithValue("@plant", plant);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        listData.Add(sdr["MachineType"].ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("While getting Machine Type Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return listData;
        }
        internal static List<string> getMachineModelData(string company, string plant, string cncMake, string cncModel, string mtb, string machineType)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<string> listData = new List<string>();
            try
            {
                SqlCommand cmd = new SqlCommand(@"select distinct MachineModel from MachineTypeModelInfo where (CNC_Make=@cncmake or ISNULL(@cncmake,'')='') and 
(CNC_Model = @cncmodel or ISNULL(@cncmodel, '') = '')  and (MTB = @mtb or ISNULL(@mtb, '') = '') and (MachineType = @machinetype or ISNULL(@machinetype, '') = '') and (CompanyID=@company or ISNULL(@company,'')='') and  (PlantID=@plant or ISNULL(@plant,'')='')", con);
                cmd.Parameters.AddWithValue("@cncmake", cncMake);
                cmd.Parameters.AddWithValue("@cncmodel", cncModel);
                cmd.Parameters.AddWithValue("@mtb", mtb);
                cmd.Parameters.AddWithValue("@machinetype", machineType);
                cmd.Parameters.AddWithValue("@company", company);
                cmd.Parameters.AddWithValue("@plant", plant);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        listData.Add(sdr["MachineModel"].ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("While getting Machine model Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return listData;
        }
        internal static List<string> getMachineIDData(string company, string plant, string cncMake, string cncModel, string mtb, string machineType, string machineModel)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<string> listData = new List<string>();
            try
            {
                SqlCommand cmd = new SqlCommand(@"select distinct M.Machineid from Machineinformation M
                                            left join PlantMachine PM on M.CompanyID=PM.CompanyID and M.Machineid=PM.MachineID
                                            where  (M.CNC_Make=@cncmake or ISNULL(@cncmake,'')='') 
                                            and (M.CNC_Model=@cncmodel or ISNULL(@cncmodel,'')='') 
                                            and (M.MachineMTB = @mtb or ISNULL(@mtb, '') = '') 
                                            and (M.MachineType = @machinetype or ISNULL(@machinetype, '') = '') 
                                            and (M.MachineModel = @machinemodel or ISNULL(@machinemodel, '') = '') 
                                            and (M.CompanyID=@company or ISNULL(@company,'')='') 
                                            and  (PM.PlantID=@plant or ISNULL(@plant,'')='')
                                            and M.EffectiveTodate='9999-12-31 00:00:00.000' and PM.EffectiveToDate='9999-12-31 00:00:00.000'", con);
                cmd.Parameters.AddWithValue("@cncmake", cncMake);
                cmd.Parameters.AddWithValue("@cncmodel", cncModel);
                cmd.Parameters.AddWithValue("@mtb", mtb);
                cmd.Parameters.AddWithValue("@machinetype", machineType);
                cmd.Parameters.AddWithValue("@machinemodel", machineModel);
                cmd.Parameters.AddWithValue("@company", company);
                cmd.Parameters.AddWithValue("@plant", plant);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        listData.Add(sdr["Machineid"].ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("While getting Machine model Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return listData;
        }
        internal static List<string> getMachineSerialNumberData(string company, string plant, string cncMake, string cncModel, string mtb, string machineType, string machineModel)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<string> listData = new List<string>();
            try
            {
                SqlCommand cmd = new SqlCommand(@"select distinct M.SerialNumber from Machineinformation M
Left join PlantMachine PM on M.CompanyID=PM.CompanyID and M.Machineid=PM.MachineID
where  (M.CNC_Make=@cncmake or ISNULL(@cncmake,'')='') and (M.CNC_Model=@cncmodel or ISNULL(@cncmodel,'')='') 
 and (M.MachineMTB = @mtb or ISNULL(@mtb, '') = '') and (M.MachineType = @machinetype or ISNULL(@machinetype, '') = '') 
 and (M.MachineModel = @machinemodel or ISNULL(@machinemodel, '') = '') and (M.CompanyID=@company or ISNULL(@company,'')='') 
 and  (PM.PlantID=@plant or ISNULL(@plant,'')='') and M.EffectiveTodate='9999-12-31 00:00:00.000' and PM.EffectiveToDate='9999-12-31 00:00:00.000'", con);
                cmd.Parameters.AddWithValue("@cncmake", cncMake);
                cmd.Parameters.AddWithValue("@cncmodel", cncModel);
                cmd.Parameters.AddWithValue("@mtb", mtb);
                cmd.Parameters.AddWithValue("@machinetype", machineType);
                cmd.Parameters.AddWithValue("@machinemodel", machineModel);
                cmd.Parameters.AddWithValue("@company", company);
                cmd.Parameters.AddWithValue("@plant", plant);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        listData.Add(sdr["SerialNumber"].ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("While getting Machine Serial Number Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return listData;
        }
        #region ----- Process Parameter Master ------
        internal static List<string> getSourceTypeData()
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<string> listData = new List<string>();
            try
            {
                SqlCommand cmd = new SqlCommand("select distinct SourceType from SourceTypeInfo", con);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        listData.Add(sdr["SourceType"].ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("While getting Source Type Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return listData;
        }
        internal static List<string> getSourceDataTypeData()
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<string> listData = new List<string>();
            try
            {
                SqlCommand cmd = new SqlCommand("select distinct SourceDatatype from SourceDatatypeInfo", con);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        listData.Add(sdr["SourceDatatype"].ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("While getting Source DataType Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return listData;
        }
        internal static List<string> getPollingFrequencyData()
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<string> listData = new List<string>();
            try
            {
                SqlCommand cmd = new SqlCommand("select distinct PollingFrequency from PollingFreqInfo", con);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        listData.Add(sdr["PollingFrequency"].ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("While getting Polling Frequency Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return listData;
        }
        internal static List<string> getDataGroupData()
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<string> listData = new List<string>();
            try
            {
                SqlCommand cmd = new SqlCommand("select distinct DataGroup from DataGroupInfo", con);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        listData.Add(sdr["DataGroup"].ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("While getting Polling Frequency Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return listData;
        }
        //internal static List<string> getPollingTypeData()
        //{
        //    SqlConnection con = ConnectionManager.GetConnection();
        //    SqlDataReader sdr = null;
        //    List<string> listData = new List<string>();
        //    try
        //    {
        //        SqlCommand cmd = new SqlCommand("select distinct PollingType from PollingTypeInfo", con);
        //        sdr = cmd.ExecuteReader();
        //        if (sdr.HasRows)
        //        {
        //            while (sdr.Read())
        //            {
        //                listData.Add(sdr["PollingType"].ToString());
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        Logger.WriteErrorLog("While getting Polling Type Data " + ex.Message);

        //    }
        //    finally
        //    {
        //        if (con != null) { con.Close(); }
        //        if (sdr != null) { sdr.Close(); }
        //    }
        //    return listData;
        //}
        internal static List<ListItem> getPollingTypeData()
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<ListItem> listData = new List<ListItem>();
            try
            {
                SqlCommand cmd = new SqlCommand("select distinct PollingType from PollingTypeInfo", con);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        if (sdr["PollingType"].ToString() == "DuringCycleOnce")
                        {
                            listData.Add(new ListItem("OnceDuringCycle", sdr["PollingType"].ToString()));
                        }
                        else
                        {
                            listData.Add(new ListItem(sdr["PollingType"].ToString(), sdr["PollingType"].ToString()));
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("While getting Polling Type Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return listData;
        }
        internal static List<string> getNumberOfCycleData()
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<string> listData = new List<string>();
            try
            {
                SqlCommand cmd = new SqlCommand("select distinct NoOfCycles from NoOfCyclesInfo", con);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        listData.Add(sdr["NoOfCycles"].ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("While getting Polling Type Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return listData;
        }
        internal static List<string> getCycleFrequencyTimeData()
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<string> listData = new List<string>();
            List<double> listDouble = new List<double>();
            try
            {
                SqlCommand cmd = new SqlCommand("select distinct CycleFreqTime from CycleFreqTimeInfo", con);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        string time = sdr["CycleFreqTime"].ToString();
                        double number;
                        bool isnumber = double.TryParse(time, out number);
                        if (isnumber)
                        {
                            double d1 = Convert.ToDouble(time);
                            double timeInHrs = (d1 / 3600);
                            listDouble.Add(timeInHrs);
                            listDouble.Sort();
                        }
                        //listData.Add(sdr["CycleFreqTime"].ToString());
                    }
                    if (listDouble.Count > 0)
                    {
                        listData = listDouble.ConvertAll<string>(x => x.ToString());
                        for (int i = 0; i < listData.Count; i++)
                        {
                            if (listData[i] == "0")
                            {
                                listData[i] = "None";
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("While getting Cycle Frequency Time Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return listData;
        }
        internal static List<string> getProcessParameterUpperLowerUnit()
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<string> listData = new List<string>();
            try
            {
                SqlCommand cmd = new SqlCommand("select distinct Unit from ParametersUnitMaster", con);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        listData.Add(sdr["Unit"].ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("While getting Process Parameter Unit Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return listData;
        }
        internal static List<ParameterWiseValidationData> getProcessParmeterWiseValidationList()
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<ParameterWiseValidationData> listData = new List<ParameterWiseValidationData>();
            ParameterWiseValidationData data = null;
            try
            {
                SqlCommand cmd = new SqlCommand("select * from ParameterwisePollingFreqMaster", con);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        data = new ParameterWiseValidationData();
                        data.Parameter = sdr["Parameter"].ToString();
                        string pollingFreq = sdr["PollingFreq"].ToString();
                        data.PolliFreq = pollingFreq.Split(',').ToList();
                        listData.Add(data);
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("While getting Process Parameter wise Validation Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return listData;
        }
        internal static List<SourceTypeWiseValidationData> getSourceTypeWiseValidationList()
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<SourceTypeWiseValidationData> listData = new List<SourceTypeWiseValidationData>();
            SourceTypeWiseValidationData data = null;
            try
            {
                SqlCommand cmd = new SqlCommand("select * from SourceTypeInfo", con);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        data = new SourceTypeWiseValidationData();
                        data.SourceType = sdr["SourceType"].ToString();
                        data.IsEnabled = sdr["IsEnabled"].ToString() == "1" ? true : false;
                        string addressRule = sdr["SourceAddress1"].ToString();
                        data.SourceAdd1 = addressRule.Split(',').ToList();
                        addressRule = sdr["SourceAddress2"].ToString();
                        data.SourceAdd2 = addressRule.Split(',').ToList();
                        string datatype1 = sdr["SourceDataType1"].ToString();
                        data.SourceDataType1 = datatype1.Split(',').ToList();
                        data.SourceDataType1.Insert(0, "None");
                        string datatype2 = sdr["SourceDataType2"].ToString();
                        data.SourceDataType2 = datatype2.Split(',').ToList();
                        data.SourceDataType2.Insert(0, "None");
                        string datatype1Condition = sdr["SourceDataType1Condition"].ToString();
                        data.DataType1Condition = datatype1Condition.Split(',').ToList();
                        string datatype2Condition = sdr["SourceDataType2Condition"].ToString();
                        data.DataType2Condition = datatype2Condition.Split(',').ToList();
                        listData.Add(data);
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("While getting Process Parameter wise Validation Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return listData;
        }

        internal static List<ProcessParameterMasterData> getProcessParameterControllerLevelData(string cncMake, string cncModel, string company, string plant)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<ProcessParameterMasterData> listData = new List<ProcessParameterMasterData>();
            ProcessParameterMasterData data = null;
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Masters_ProcessParameters_ViewData]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CNC_MAKE", cncMake);
                cmd.Parameters.AddWithValue("@CNC_Model", cncModel);
                cmd.Parameters.AddWithValue("@Company", company);
                cmd.Parameters.AddWithValue("@Plant", plant);
                cmd.Parameters.AddWithValue("@ScreenName", "ControllerLevel");
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        data = new ProcessParameterMasterData();
                        data.CNCModel = sdr["CNC_Model"].ToString();
                        data.CNCMake = sdr["CNC_MAKE"].ToString();
                        data.ParemeterID = sdr["ParameterID"].ToString();
                        data.SourceType = sdr["SourceType"].ToString();
                        data.SourceAdd1 = sdr["SourceAddress1"].ToString();
                        data.SourceAdd2 = sdr["SourceAddress2"].ToString();
                        data.SourceDatatype1 = sdr["SourceDataType1"].ToString();
                        data.SourceDatatype2 = sdr["SourceDataType2"].ToString();
                        data.PollingFrequency = sdr["PollingFrequency"].ToString();
                        data.DataGroup = sdr["DataGroup"].ToString();
                        data.PollingType = sdr["PollingType"].ToString();
                        //data.CycleFreqTime = sdr["CyclesFreqTime"].ToString();
                        string time = sdr["CyclesFreqTime"].ToString();
                        double number;
                        bool isnumber = double.TryParse(time, out number);
                        if (isnumber)
                        {
                            double d1 = Convert.ToDouble(time)
;
                            time = (d1 / 3600).ToString();
                        }
                        data.CycleFreqTime = time;
                        data.NoOfCycle = sdr["NoOfCycles"].ToString();
                        if (sdr["IsMandatory"].ToString() != null && sdr["IsMandatory"].ToString() != "")
                        {
                            if (Convert.ToBoolean(sdr["IsMandatory"].ToString()))
                            {
                                data.ShouldNotBeDisabled = true;
                            }
                            else
                            {
                                data.ShouldNotBeDisabled = false;
                            }
                        }
                        if (sdr["IsEnabledForDataRead"].ToString() != null && sdr["IsEnabledForDataRead"].ToString() != "")
                        {
                            if (Convert.ToBoolean(sdr["IsEnabledForDataRead"].ToString()))
                            {
                                data.IsEnabled = true;
                            }
                            else
                            {
                                data.IsEnabled = false;
                            }
                        }

                        data.UpperWarning = sdr["UpperWarningLimit"].ToString();
                        data.LowerWarning = sdr["LowerWarningLimit"].ToString();
                        data.UpperError = sdr["UpperErrorLimit"].ToString();
                        data.LowerError = sdr["LowerErrorLimit"].ToString();
                        data.Unit = sdr["Unit"].ToString();
                        listData.Add(data);
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("While getting Process Parameter Controller Level Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return listData;
        }
        internal static int insertUpdateProcessParameterControllerData(ProcessParameterMasterData data, string param, out int res)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            res = 0;
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Masters_ProcessParameters_InsertData]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ScreenName", param);
                cmd.Parameters.AddWithValue("@Company", data.Company);
                cmd.Parameters.AddWithValue("@Plant", data.Plant);
                cmd.Parameters.AddWithValue("@MTB", data.MTB);
                cmd.Parameters.AddWithValue("@CNC_MAKE", data.CNCMake);
                cmd.Parameters.AddWithValue("@CNC_Model", data.CNCModel);
                cmd.Parameters.AddWithValue("@MachineType", data.MachineType);
                cmd.Parameters.AddWithValue("@MachineModel", data.MachineModel);
                cmd.Parameters.AddWithValue("@MachineID", data.MachineID);
                cmd.Parameters.AddWithValue("@ParameterID", data.ParemeterID);
                cmd.Parameters.AddWithValue("@SourceType", data.SourceType);
                cmd.Parameters.AddWithValue("@SourceAddress1", data.SourceAdd1);
                cmd.Parameters.AddWithValue("@SourceDataType1", data.SourceDatatype1);
                cmd.Parameters.AddWithValue("@SourceAddress2", data.SourceAdd2);
                cmd.Parameters.AddWithValue("@SourceDataType2", data.SourceDatatype2);
                cmd.Parameters.AddWithValue("@PollingFrequency", data.PollingFrequency);
                cmd.Parameters.AddWithValue("@DataGroup", data.DataGroup);
                cmd.Parameters.AddWithValue("@PollingType", data.PollingType);
                if (data.PollingType == "ReadBasedOnCustomTimePeriod")
                {
                    cmd.Parameters.AddWithValue("@NoOfCycles", DBNull.Value);
                    cmd.Parameters.AddWithValue("@CyclesFreqTime", DBNull.Value);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@NoOfCycles", data.NoOfCycle);
                    //if(data.CycleFreqTime=="None" || )
                    if (string.Equals(data.CycleFreqTime, "None", StringComparison.OrdinalIgnoreCase) || string.Equals(data.CycleFreqTime, "NA", StringComparison.OrdinalIgnoreCase))
                    {
                        data.CycleFreqTime = "0";
                    }
                    double number;
                    bool isnumber = double.TryParse(data.CycleFreqTime, out number);
                    if (isnumber)
                    {
                        double d1 = Convert.ToDouble(data.CycleFreqTime);
                        data.CycleFreqTime = (d1 * 3600).ToString();
                    }
                    cmd.Parameters.AddWithValue("@CyclesFreqTime", data.CycleFreqTime);
                    //cmd.Parameters.AddWithValue("@CyclesFreqTime", data.CycleFreqTime);
                }
                cmd.Parameters.AddWithValue("@IsMandatory", data.ShouldNotBeDisabled);
                cmd.Parameters.AddWithValue("@IsEnabledForDataRead", data.IsEnabled);
                cmd.Parameters.AddWithValue("@UpdatedTS", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@UpdatedBy", "pct");
                cmd.Parameters.AddWithValue("@UpperWarningLimit", data.UpperWarning);
                cmd.Parameters.AddWithValue("@LowerWarningLimit", data.LowerWarning);
                cmd.Parameters.AddWithValue("@UpperErrorLimit", data.UpperError);
                cmd.Parameters.AddWithValue("@LowerErrorLimit", data.LowerError);
                cmd.Parameters.AddWithValue("@Unit", data.Unit);
                res = cmd.ExecuteNonQuery();

            }
            catch (Exception ex)
            {
                res = 0;
                Logger.WriteErrorLog("While inserting Process Parameter Controller Level Master Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
            }
            return res;
        }
        internal static int deleteProcessParameterControllerData(ProcessParameterMasterData data)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            int res = 0;
            try
            {
                SqlCommand cmd = new SqlCommand("delete from CNCLevelParameters where CNC_MAKE=@CNC_MAKE and CNC_Model=@CNC_Model and ParameterID=@ParameterID", con);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@CNC_MAKE", data.CNCMake);
                cmd.Parameters.AddWithValue("@CNC_Model", data.CNCModel);
                cmd.Parameters.AddWithValue("@ParameterID", data.ParemeterID);
                res = cmd.ExecuteNonQuery();

            }
            catch (Exception ex)
            {
                res = 0;
                Logger.WriteErrorLog("While deleting Process Parameter Controller Level Master Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
            }
            return res;
        }

        internal static List<ProcessParameterMasterData> getProcessParameterModelLevelData(ProcessParameterMasterData inputData)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<ProcessParameterMasterData> listData = new List<ProcessParameterMasterData>();
            ProcessParameterMasterData data = null;
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Masters_ProcessParameters_ViewData]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CNC_MAKE", inputData.CNCMake);
                cmd.Parameters.AddWithValue("@CNC_Model", inputData.CNCModel);
                cmd.Parameters.AddWithValue("@MachineType", inputData.MachineType);
                cmd.Parameters.AddWithValue("@MachineModel", inputData.MachineModel);
                cmd.Parameters.AddWithValue("@MTB", inputData.MTB);
                cmd.Parameters.AddWithValue("@Company", inputData.Company);
                cmd.Parameters.AddWithValue("@Plant", inputData.Plant);
                cmd.Parameters.AddWithValue("@LevelFilter", inputData.Level == "All" ? "" : inputData.Level);
                cmd.Parameters.AddWithValue("@ScreenName", "ModelLevel");
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        data = new ProcessParameterMasterData();
                        data.CNCModel = sdr["CNC_Model"].ToString();
                        data.CNCMake = sdr["CNC_MAKE"].ToString();
                        data.MachineType = sdr["MachineType"].ToString();
                        data.MachineModel = sdr["MachineModel"].ToString();
                        data.MTB = sdr["MTB"].ToString();
                        data.ParemeterID = sdr["ParameterID"].ToString();
                        data.SourceType = sdr["SourceType"].ToString();
                        data.SourceAdd1 = sdr["SourceAddress1"].ToString();
                        data.SourceAdd2 = sdr["SourceAddress2"].ToString();
                        data.SourceDatatype1 = sdr["SourceDataType1"].ToString();
                        data.SourceDatatype2 = sdr["SourceDataType2"].ToString();
                        data.PollingFrequency = sdr["PollingFrequency"].ToString();
                        data.DataGroup = sdr["DataGroup"].ToString();
                        data.PollingType = sdr["PollingType"].ToString();
                        // data.CycleFreqTime = sdr["CyclesFreqTime"].ToString();
                        string time = sdr["CyclesFreqTime"].ToString();
                        double number;
                        bool isnumber = double.TryParse(time, out number);
                        if (isnumber)
                        {
                            double d1 = Convert.ToDouble(time)
;
                            time = (d1 / 3600).ToString();
                        }
                        data.CycleFreqTime = time;
                        data.NoOfCycle = sdr["NoOfCycles"].ToString();
                        if (sdr["IsMandatory"].ToString() != null && sdr["IsMandatory"].ToString() != "")
                        {
                            if (Convert.ToBoolean(sdr["IsMandatory"].ToString()))
                            {
                                data.ShouldNotBeDisabled = true;
                            }
                            else
                            {
                                data.ShouldNotBeDisabled = false;
                            }
                        }
                        if (sdr["IsEnabledForDataRead"].ToString() != null && sdr["IsEnabledForDataRead"].ToString() != "")
                        {
                            if (Convert.ToBoolean(sdr["IsEnabledForDataRead"].ToString()))
                            {
                                data.IsEnabled = true;
                            }
                            else
                            {
                                data.IsEnabled = false;
                            }
                        }
                        data.UpperWarning = sdr["UpperWarningLimit"].ToString();
                        data.LowerWarning = sdr["LowerWarningLimit"].ToString();
                        data.UpperError = sdr["UpperErrorLimit"].ToString();
                        data.LowerError = sdr["LowerErrorLimit"].ToString();
                        data.Unit = sdr["Unit"].ToString();
                        data.ScreenName = sdr["ScreenName"].ToString();
                        data.DeleteFlag = sdr["AllowToDelete"].ToString();
                        listData.Add(data);
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("While getting Process Parameter Model Level Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return listData;
        }
        internal static int deleteProcessParameterModelData(ProcessParameterMasterData data)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            int res = 0;
            try
            {
                SqlCommand cmd = new SqlCommand("delete from ModelLevelParameters where MTB=@mtb and MachineType=@machinetype and MachineModel=@machinemodel and CNC_MAKE=@CNC_MAKE and CNC_Model=@CNC_Model and ParameterID=@ParameterID", con);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@mtb", data.MTB);
                cmd.Parameters.AddWithValue("@machinetype", data.MachineType);
                cmd.Parameters.AddWithValue("@machinemodel", data.MachineModel);
                cmd.Parameters.AddWithValue("@CNC_MAKE", data.CNCMake);
                cmd.Parameters.AddWithValue("@CNC_Model", data.CNCModel);
                cmd.Parameters.AddWithValue("@ParameterID", data.ParemeterID);
                res = cmd.ExecuteNonQuery();

            }
            catch (Exception ex)
            {
                res = 0;
                Logger.WriteErrorLog("While deleting Process Parameter Model Level Master Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
            }
            return res;
        }
        internal static int copyModelLevelDataToSelectedModel(string sourceModel, string distinationModel, string cncMake, string cncModel, string cncMachineType, string mtb)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            int res = 0;
            try
            {
                SqlCommand cmd = new SqlCommand(@"If exists(select * from ModelLevelParameters where  CNC_MAKE=@CNC_MAKE and CNC_Model=@CNC_Model and MTB=@mtb and machinetype=@machinetype and MachineModel=@destiMachinemodel)
Begin
Delete from ModelLevelParameters where  CNC_MAKE=@CNC_MAKE and CNC_Model=@CNC_Model and MTB=@mtb and machinetype=@machinetype and MachineModel=@destiMachinemodel
END
Insert into ModelLevelParameters( MTB, CNC_MAKE, CNC_Model, MachineType, MachineModel, ParameterID, SourceType, SourceAddress1, SourceDataType1, SourceAddress2, SourceDataType2, PollingFrequency, DataGroup, PollingType,
CyclesFreqTime, NoOfCycles, IsEnabledForDataRead, IsMandatory, UpperWarningLimit, LowerWarningLimit, UpperErrorLimit, LowerErrorLimit, UpdatedBy, UpdatedTS, Unit, CompanyID, PlantID, SyncedStatus)
select MTB, CNC_MAKE, CNC_Model, MachineType, @destiMachinemodel, ParameterID, SourceType, SourceAddress1, SourceDataType1, SourceAddress2, SourceDataType2, PollingFrequency, DataGroup, PollingType,
CyclesFreqTime, NoOfCycles, IsEnabledForDataRead, IsMandatory, UpperWarningLimit, LowerWarningLimit, UpperErrorLimit, LowerErrorLimit, UpdatedBy, UpdatedTS, Unit, CompanyID, PlantID, SyncedStatus
FROM ModelLevelParameters where  CNC_MAKE=@CNC_MAKE and CNC_Model=@CNC_Model and MTB=@mtb and  machinetype=@machinetype and MachineModel=@srcMachinemodel", con);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@mtb", mtb);
                cmd.Parameters.AddWithValue("@machinetype", cncMachineType);
                cmd.Parameters.AddWithValue("@srcMachinemodel", sourceModel);
                cmd.Parameters.AddWithValue("@destiMachinemodel", distinationModel);
                cmd.Parameters.AddWithValue("@CNC_MAKE", cncMake);
                cmd.Parameters.AddWithValue("@CNC_Model", cncModel);
                res = cmd.ExecuteNonQuery();

            }
            catch (Exception ex)
            {
                res = 0;
                Logger.WriteErrorLog("While deleting Process Parameter Model Level Master Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
            }
            return res;
        }
        internal static List<ProcessParameterMasterData> getProcessParameterMachineLevelLevelData(ProcessParameterMasterData inputData)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<ProcessParameterMasterData> listData = new List<ProcessParameterMasterData>();
            ProcessParameterMasterData data = null;
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Masters_ProcessParameters_ViewData]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CNC_MAKE", inputData.CNCMake);
                cmd.Parameters.AddWithValue("@CNC_Model", inputData.CNCModel);
                cmd.Parameters.AddWithValue("@MachineType", inputData.MachineType);
                cmd.Parameters.AddWithValue("@MachineModel", inputData.MachineModel);
                cmd.Parameters.AddWithValue("@MTB", inputData.MTB);
                cmd.Parameters.AddWithValue("@MachineID", inputData.MachineID);
                cmd.Parameters.AddWithValue("@Company", inputData.Company);
                cmd.Parameters.AddWithValue("@Plant", inputData.Plant);
                cmd.Parameters.AddWithValue("@LevelFilter", inputData.Level == "All" ? "" : inputData.Level);
                cmd.Parameters.AddWithValue("@ScreenName", "MachineLevelParameters");
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        data = new ProcessParameterMasterData();
                        data.Company = inputData.Company;
                        data.Plant = inputData.Plant;
                        data.CNCModel = sdr["CNC_Model"].ToString();
                        data.CNCMake = sdr["CNC_MAKE"].ToString();
                        data.MachineType = sdr["MachineType"].ToString();
                        data.MachineModel = sdr["MachineModel"].ToString();
                        data.MTB = sdr["MTB"].ToString();
                        data.MachineID = sdr["Machineid"].ToString();
                        data.ParemeterID = sdr["ParameterID"].ToString();
                        data.SourceType = sdr["SourceType"].ToString();
                        data.SourceAdd1 = sdr["SourceAddress1"].ToString();
                        data.SourceAdd2 = sdr["SourceAddress2"].ToString();
                        data.SourceDatatype1 = sdr["SourceDataType1"].ToString();
                        data.SourceDatatype2 = sdr["SourceDataType2"].ToString();
                        data.PollingFrequency = sdr["PollingFrequency"].ToString();
                        data.DataGroup = sdr["DataGroup"].ToString();
                        data.PollingType = sdr["PollingType"].ToString();
                        // data.CycleFreqTime = sdr["CyclesFreqTime"].ToString();
                        string time = sdr["CyclesFreqTime"].ToString();
                        double number;
                        bool isnumber = double.TryParse(time, out number);
                        if (isnumber)
                        {
                            double d1 = Convert.ToDouble(time)
;
                            time = (d1 / 3600).ToString();
                        }
                        data.CycleFreqTime = time;
                        data.NoOfCycle = sdr["NoOfCycles"].ToString();
                        if (sdr["IsMandatory"].ToString() != null && sdr["IsMandatory"].ToString() != "")
                        {
                            if (Convert.ToBoolean(sdr["IsMandatory"].ToString()))
                            {
                                data.ShouldNotBeDisabled = true;
                            }
                            else
                            {
                                data.ShouldNotBeDisabled = false;
                            }
                        }
                        if (sdr["IsEnabledForDataRead"].ToString() != null && sdr["IsEnabledForDataRead"].ToString() != "")
                        {
                            if (Convert.ToBoolean(sdr["IsEnabledForDataRead"].ToString()))
                            {
                                data.IsEnabled = true;
                            }
                            else
                            {
                                data.IsEnabled = false;
                            }
                        }
                        if (sdr["IsEnabledForDataRead"].ToString() != null && sdr["IsEnabledForDataRead"].ToString() != "")
                        {
                            if (Convert.ToBoolean(sdr["IsEnabledForDataRead"].ToString()))
                            {
                                data.IsEnabledForDataRead = true;
                            }
                            else
                            {
                                data.IsEnabledForDataRead = false;
                            }
                        }
                        data.UpperWarning = sdr["UpperWarningLimit"].ToString();
                        data.LowerWarning = sdr["LowerWarningLimit"].ToString();
                        data.UpperError = sdr["UpperErrorLimit"].ToString();
                        data.LowerError = sdr["LowerErrorLimit"].ToString();
                        data.Unit = sdr["Unit"].ToString();
                        data.ScreenName = sdr["ScreenName"].ToString();
                        data.DeleteFlag = sdr["AllowToDelete"].ToString();
                        listData.Add(data);
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("While getting Process Parameter Machine Level Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return listData;
        }
        internal static int deleteProcessParameterMachineData(ProcessParameterMasterData data)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            int res = 0;
            try
            {
                SqlCommand cmd = new SqlCommand("delete from MachineLevelParameters where MTB=@mtb and MachineType=@machinetype and MachineModel=@machinemodel and CNC_MAKE=@CNC_MAKE and CNC_Model=@CNC_Model and MachineID=@machineid and ParameterID=@ParameterID and CompanyID=@Company and PlantID=@Plant", con);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@mtb", data.MTB);
                cmd.Parameters.AddWithValue("@machinetype", data.MachineType);
                cmd.Parameters.AddWithValue("@machinemodel", data.MachineModel);
                cmd.Parameters.AddWithValue("@CNC_MAKE", data.CNCMake);
                cmd.Parameters.AddWithValue("@CNC_Model", data.CNCModel);
                cmd.Parameters.AddWithValue("@machineid", data.MachineID);
                cmd.Parameters.AddWithValue("@ParameterID", data.ParemeterID);
                cmd.Parameters.AddWithValue("@Company", data.Company);
                cmd.Parameters.AddWithValue("@Plant", data.Plant);
                res = cmd.ExecuteNonQuery();

            }
            catch (Exception ex)
            {
                res = 0;
                Logger.WriteErrorLog("While deleting Process Parameter Machine Level Master Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
            }
            return res;
        }
        internal static int copyMachineLevelDataToSelectedModel(string sourceMachineID, string distinationMachineID, string company, string plant, string cncMake, string cncModel, string mtb, string cncMachineType, string machinemodel)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            int res = 0;
            try
            {
                SqlCommand cmd = new SqlCommand(@"If exists(select * from MachineLevelParameters where CompanyID=@company and PlantID=@plant and  CNC_MAKE=@CNC_MAKE and CNC_Model=@CNC_Model and MTB=@mtb and machinetype=@machinetype and MachineModel=@machinemodel and MachineID=@destmachineID)
Begin
Delete from MachineLevelParameters where machinetype=@machinetype and CompanyID=@company and PlantID=@plant and  CNC_MAKE=@CNC_MAKE and CNC_Model=@CNC_Model and MTB=@mtb and MachineModel=@machinemodel and MachineID=@destmachineID
END
Insert into MachineLevelParameters( MTB, CNC_MAKE, CNC_Model, MachineType, MachineModel, ParameterID, SourceType, SourceAddress1, SourceDataType1, SourceAddress2, SourceDataType2, PollingFrequency, DataGroup, PollingType,
CyclesFreqTime, NoOfCycles, IsEnabledForDataRead, IsMandatory, UpperWarningLimit, LowerWarningLimit, UpperErrorLimit, LowerErrorLimit, UpdatedBy, UpdatedTS, Unit, CompanyID, PlantID, SyncedStatus,MachineID)
select MTB, CNC_MAKE, CNC_Model, MachineType, MachineModel, ParameterID, SourceType, SourceAddress1, SourceDataType1, SourceAddress2, SourceDataType2, PollingFrequency, DataGroup, PollingType,
CyclesFreqTime, NoOfCycles, IsEnabledForDataRead, IsMandatory, UpperWarningLimit, LowerWarningLimit, UpperErrorLimit, LowerErrorLimit, UpdatedBy, UpdatedTS, Unit, CompanyID, PlantID, SyncedStatus,@destmachineID
FROM MachineLevelParameters where CompanyID=@company and PlantID=@plant and  CNC_MAKE=@CNC_MAKE and CNC_Model=@CNC_Model and MTB=@mtb and  machinetype=@machinetype and MachineModel=@machinemodel and MachineID=@srcmachineID", con);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@mtb", mtb);
                cmd.Parameters.AddWithValue("@machinetype", cncMachineType);
                cmd.Parameters.AddWithValue("@machinemodel", machinemodel);
                cmd.Parameters.AddWithValue("@CNC_MAKE", cncMake);
                cmd.Parameters.AddWithValue("@CNC_Model", cncModel);
                cmd.Parameters.AddWithValue("@company", company);
                cmd.Parameters.AddWithValue("@plant", plant);
                cmd.Parameters.AddWithValue("@srcmachineID", sourceMachineID);
                cmd.Parameters.AddWithValue("@destmachineID", distinationMachineID);
                res = cmd.ExecuteNonQuery();

            }
            catch (Exception ex)
            {
                res = 0;
                Logger.WriteErrorLog("While deleting Process Parameter Model Level Master Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
            }
            return res;
        }
        #endregion

        #region -----Process Parameters-----
        internal static List<ProcessParameterData> getProcessParameterMasterData(string machineID)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<ProcessParameterData> masterDataList = new List<ProcessParameterData>();
            ProcessParameterData masterData = null;
            try
            {
                SqlCommand cmd = new SqlCommand("select * from MachineLevelParameters where MachineID=@MachineID", con);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@MachineID", machineID);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        masterData = new ProcessParameterData();
                        masterData.LowValue = sdr["LowerLimit"].ToString();
                        masterData.HighValue = sdr["UpperLimit"].ToString();
                        masterData.ChartType = sdr["Unit"].ToString();
                        masterData.MachineID = sdr["Machineid"].ToString();
                        masterData.HeaderName = sdr["ParameterID"].ToString();
                        masterDataList.Add(masterData);
                    }
                }

            }
            catch (Exception ex)
            {

                Logger.WriteErrorLog("get Proess Parameter Master Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return masterDataList;
        }


        #endregion


        #region -- Get CompanyDetails

        internal static List<string> getCompanyDetails()
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<string> listData = new List<string>();
            try
            {
                SqlCommand cmd = new SqlCommand("select * from Company", con);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        listData.Add(sdr["CompanyName"].ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("While getting Company Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return listData;
        }
        #endregion



        #region -----Process Parameter Master AGI-------
        internal static List<ProcessParameterMasterData> getProcessParameterAGIControllerLevelData(string cncCompany, string cncPlant, string cncMake, string cncModel)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<ProcessParameterMasterData> listData = new List<ProcessParameterMasterData>();
            ProcessParameterMasterData data = null;
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Masters_AGIProcessParameters_ViewData]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Company", cncCompany);
                cmd.Parameters.AddWithValue("@Plant", cncPlant);
                cmd.Parameters.AddWithValue("@CNC_MAKE", cncMake);
                cmd.Parameters.AddWithValue("@CNC_Model", cncModel);
                cmd.Parameters.AddWithValue("@ScreenName", "ControllerLevel");
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        data = new ProcessParameterMasterData();
                        data.CNCModel = sdr["CNC_Model"].ToString();
                        data.CNCMake = sdr["CNC_MAKE"].ToString();
                        data.ParemeterID = sdr["ParameterID"].ToString();
                        data.SourceType = sdr["SourceType"].ToString();
                        data.SourceAdd1 = sdr["SourceAddress1"].ToString();
                        data.SourceAdd2 = sdr["SourceAddress2"].ToString();
                        data.SourceDatatype1 = sdr["SourceDataType1"].ToString();
                        data.SourceDatatype2 = sdr["SourceDataType2"].ToString();
                        data.PollingFrequency = sdr["PollingFrequency"].ToString();
                        data.DataGroup = sdr["DataGroup"].ToString();
                        data.PollingType = sdr["PollingType"].ToString();
                        //data.CycleFreqTime = sdr["CyclesFreqTime"].ToString();
                        string time = sdr["CyclesFreqTime"].ToString();
                        double number;
                        bool isnumber = double.TryParse(time, out number);
                        if (isnumber)
                        {
                            double d1 = Convert.ToDouble(time)
;
                            time = (d1 / 3600).ToString();
                        }
                        data.CycleFreqTime = time;
                        data.NoOfCycle = sdr["NoOfCycles"].ToString();
                        if (sdr["IsMandatory"].ToString() != null && sdr["IsMandatory"].ToString() != "")
                        {
                            if (Convert.ToBoolean(sdr["IsMandatory"].ToString()))
                            {
                                data.ShouldNotBeDisabled = true;
                            }
                            else
                            {
                                data.ShouldNotBeDisabled = false;
                            }
                        }
                        if (sdr["IsEnabledForDataRead"].ToString() != null && sdr["IsEnabledForDataRead"].ToString() != "")
                        {
                            if (Convert.ToBoolean(sdr["IsEnabledForDataRead"].ToString()))
                            {
                                data.IsEnabled = true;
                            }
                            else
                            {
                                data.IsEnabled = false;
                            }
                        }
                        data.UpperWarning = sdr["UpperWarningLimit"].ToString();
                        data.LowerWarning = sdr["LowerWarningLimit"].ToString();
                        data.UpperError = sdr["UpperErrorLimit"].ToString();
                        data.LowerError = sdr["LowerErrorLimit"].ToString();
                        data.Unit = sdr["Unit"].ToString();
                        listData.Add(data);
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("While getting Process Parameter Controller Level Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return listData;
        }

        internal static int insertUpdateProcessParameterAGIControllerData(ProcessParameterMasterData data, string param, out int res)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            res = 0;
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Masters_AGIProcessParameters_InsertData]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ScreenName", param);
                cmd.Parameters.AddWithValue("@Company", data.Company);
                cmd.Parameters.AddWithValue("@Plant", data.Plant);
                cmd.Parameters.AddWithValue("@MTB", data.MTB);
                cmd.Parameters.AddWithValue("@CNC_MAKE", data.CNCMake);
                cmd.Parameters.AddWithValue("@CNC_Model", data.CNCModel);
                cmd.Parameters.AddWithValue("@MachineType", data.MachineType);
                cmd.Parameters.AddWithValue("@MachineModel", data.MachineModel);
                cmd.Parameters.AddWithValue("@MachineID", data.MachineID);
                cmd.Parameters.AddWithValue("@ParameterID", data.ParemeterID);
                cmd.Parameters.AddWithValue("@SourceType", data.SourceType);
                cmd.Parameters.AddWithValue("@SourceAddress1", data.SourceAdd1);
                cmd.Parameters.AddWithValue("@SourceDataType1", data.SourceDatatype1);
                cmd.Parameters.AddWithValue("@SourceAddress2", data.SourceAdd2);
                cmd.Parameters.AddWithValue("@SourceDataType2", data.SourceDatatype2);
                cmd.Parameters.AddWithValue("@PollingFrequency", data.PollingFrequency);
                cmd.Parameters.AddWithValue("@DataGroup", data.DataGroup);
                cmd.Parameters.AddWithValue("@PollingType", data.PollingType);
                if (data.PollingType == "ReadBasedOnCustomTimePeriod")
                {
                    cmd.Parameters.AddWithValue("@NoOfCycles", DBNull.Value);
                    cmd.Parameters.AddWithValue("@CyclesFreqTime", DBNull.Value);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@NoOfCycles", data.NoOfCycle);
                    //cmd.Parameters.AddWithValue("@CyclesFreqTime", data.CycleFreqTime);
                    if (string.Equals(data.CycleFreqTime, "None", StringComparison.OrdinalIgnoreCase) || string.Equals(data.CycleFreqTime, "NA", StringComparison.OrdinalIgnoreCase))
                    {
                        data.CycleFreqTime = "0";
                    }
                    double number;
                    bool isnumber = double.TryParse(data.CycleFreqTime, out number);
                    if (isnumber)
                    {
                        double d1 = Convert.ToDouble(data.CycleFreqTime);
                        data.CycleFreqTime = (d1 * 3600).ToString();
                    }
                    cmd.Parameters.AddWithValue("@CyclesFreqTime", data.CycleFreqTime);
                }
                cmd.Parameters.AddWithValue("@IsMandatory", data.ShouldNotBeDisabled);
                cmd.Parameters.AddWithValue("@IsEnabledForDataRead", data.IsEnabled);
                cmd.Parameters.AddWithValue("@UpdatedTS", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@UpdatedBy", "pct");
                cmd.Parameters.AddWithValue("@UpperWarningLimit", data.UpperWarning);
                cmd.Parameters.AddWithValue("@LowerWarningLimit", data.LowerWarning);
                cmd.Parameters.AddWithValue("@UpperErrorLimit", data.UpperError);
                cmd.Parameters.AddWithValue("@LowerErrorLimit", data.LowerError);
                cmd.Parameters.AddWithValue("@Unit", data.Unit);
                res = cmd.ExecuteNonQuery();

            }
            catch (Exception ex)
            {
                res = 0;
                Logger.WriteErrorLog("While inserting Process Parameter Controller Level Master Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
            }
            return res;
        }

        internal static int deleteProcessParameterAGIControllerData(ProcessParameterMasterData data)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            int res = 0;
            try
            {
                SqlCommand cmd = new SqlCommand("delete from CNCLevelParametersAGI where CNC_MAKE=@CNC_MAKE and CNC_Model=@CNC_Model and ParameterID=@ParameterID", con);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@CNC_MAKE", data.CNCMake);
                cmd.Parameters.AddWithValue("@CNC_Model", data.CNCModel);
                cmd.Parameters.AddWithValue("@ParameterID", data.ParemeterID);
                res = cmd.ExecuteNonQuery();

            }
            catch (Exception ex)
            {
                res = 0;
                Logger.WriteErrorLog("While deleting Process Parameter Controller Level Master Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
            }
            return res;
        }

        internal static List<ProcessParameterMasterData> getProcessParameterAGIModelLevelData(ProcessParameterMasterData inputData)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<ProcessParameterMasterData> listData = new List<ProcessParameterMasterData>();
            ProcessParameterMasterData data = null;
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Masters_AGIProcessParameters_ViewData]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Company", inputData.Company);
                cmd.Parameters.AddWithValue("@Plant", inputData.Plant);
                cmd.Parameters.AddWithValue("@CNC_MAKE", inputData.CNCMake);
                cmd.Parameters.AddWithValue("@CNC_Model", inputData.CNCModel);
                cmd.Parameters.AddWithValue("@MachineType", inputData.MachineType);
                cmd.Parameters.AddWithValue("@MachineModel", inputData.MachineModel);
                cmd.Parameters.AddWithValue("@MTB", inputData.MTB);
                cmd.Parameters.AddWithValue("@LevelFilter", inputData.Level == "All" ? "" : inputData.Level);
                cmd.Parameters.AddWithValue("@ScreenName", "ModelLevel");
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        data = new ProcessParameterMasterData();
                        data.CNCModel = sdr["CNC_Model"].ToString();
                        data.CNCMake = sdr["CNC_MAKE"].ToString();
                        data.MachineType = sdr["MachineType"].ToString();
                        data.MachineModel = sdr["MachineModel"].ToString();
                        data.MTB = sdr["MTB"].ToString();
                        data.ParemeterID = sdr["ParameterID"].ToString();
                        data.SourceType = sdr["SourceType"].ToString();
                        data.SourceAdd1 = sdr["SourceAddress1"].ToString();
                        data.SourceAdd2 = sdr["SourceAddress2"].ToString();
                        data.SourceDatatype1 = sdr["SourceDataType1"].ToString();
                        data.SourceDatatype2 = sdr["SourceDataType2"].ToString();
                        data.PollingFrequency = sdr["PollingFrequency"].ToString();
                        data.DataGroup = sdr["DataGroup"].ToString();
                        data.PollingType = sdr["PollingType"].ToString();
                        // data.CycleFreqTime = sdr["CyclesFreqTime"].ToString();
                        string time = sdr["CyclesFreqTime"].ToString();
                        double number;
                        bool isnumber = double.TryParse(time, out number);
                        if (isnumber)
                        {
                            double d1 = Convert.ToDouble(time)
;
                            time = (d1 / 3600).ToString();
                        }
                        data.CycleFreqTime = time;
                        data.NoOfCycle = sdr["NoOfCycles"].ToString();
                        if (sdr["IsMandatory"].ToString() != null && sdr["IsMandatory"].ToString() != "")
                        {
                            if (Convert.ToBoolean(sdr["IsMandatory"].ToString()))
                            {
                                data.ShouldNotBeDisabled = true;
                            }
                            else
                            {
                                data.ShouldNotBeDisabled = false;
                            }
                        }
                        if (sdr["IsEnabledForDataRead"].ToString() != null && sdr["IsEnabledForDataRead"].ToString() != "")
                        {
                            if (Convert.ToBoolean(sdr["IsEnabledForDataRead"].ToString()))
                            {
                                data.IsEnabled = true;
                            }
                            else
                            {
                                data.IsEnabled = false;
                            }
                        }
                        data.UpperWarning = sdr["UpperWarningLimit"].ToString();
                        data.LowerWarning = sdr["LowerWarningLimit"].ToString();
                        data.UpperError = sdr["UpperErrorLimit"].ToString();
                        data.LowerError = sdr["LowerErrorLimit"].ToString();
                        data.Unit = sdr["Unit"].ToString();
                        data.ScreenName = sdr["ScreenName"].ToString();
                        data.DeleteFlag = sdr["AllowToDelete"].ToString();
                        listData.Add(data);
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("While getting Process Parameter Model Level Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return listData;
        }

        internal static int deleteProcessParameterAGIModelData(ProcessParameterMasterData data)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            int res = 0;
            try
            {
                SqlCommand cmd = new SqlCommand("delete from ModelLevelParametersAGI where MTB=@mtb and MachineType=@machinetype and MachineModel=@machinemodel and CNC_MAKE=@CNC_MAKE and CNC_Model=@CNC_Model and ParameterID=@ParameterID", con);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@mtb", data.MTB);
                cmd.Parameters.AddWithValue("@machinetype", data.MachineType);
                cmd.Parameters.AddWithValue("@machinemodel", data.MachineModel);
                cmd.Parameters.AddWithValue("@CNC_MAKE", data.CNCMake);
                cmd.Parameters.AddWithValue("@CNC_Model", data.CNCModel);
                cmd.Parameters.AddWithValue("@ParameterID", data.ParemeterID);
                res = cmd.ExecuteNonQuery();

            }
            catch (Exception ex)
            {
                res = 0;
                Logger.WriteErrorLog("While deleting Process Parameter Model Level Master Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
            }
            return res;
        }

        internal static List<ProcessParameterMasterData> getProcessParameterAGIMachineLevelLevelData(ProcessParameterMasterData inputData)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<ProcessParameterMasterData> listData = new List<ProcessParameterMasterData>();
            ProcessParameterMasterData data = null;
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Masters_AGIProcessParameters_ViewData]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Company", inputData.Company);
                cmd.Parameters.AddWithValue("@Plant", inputData.Plant);
                cmd.Parameters.AddWithValue("@CNC_MAKE", inputData.CNCMake);
                cmd.Parameters.AddWithValue("@CNC_Model", inputData.CNCModel);
                cmd.Parameters.AddWithValue("@MachineType", inputData.MachineType);
                cmd.Parameters.AddWithValue("@MachineModel", inputData.MachineModel);
                cmd.Parameters.AddWithValue("@MTB", inputData.MTB);
                cmd.Parameters.AddWithValue("@MachineID", inputData.MachineID);
                cmd.Parameters.AddWithValue("@LevelFilter", inputData.Level == "All" ? "" : inputData.Level);
                cmd.Parameters.AddWithValue("@ScreenName", "MachineLevelParameters");
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        data = new ProcessParameterMasterData();
                        data.Company = inputData.Company;
                        data.Plant = inputData.Plant;
                        data.CNCModel = sdr["CNC_Model"].ToString();
                        data.CNCMake = sdr["CNC_MAKE"].ToString();
                        data.MachineType = sdr["MachineType"].ToString();
                        data.MachineModel = sdr["MachineModel"].ToString();
                        data.MTB = sdr["MTB"].ToString();
                        data.MachineID = sdr["Machineid"].ToString();
                        data.ParemeterID = sdr["ParameterID"].ToString();
                        data.SourceType = sdr["SourceType"].ToString();
                        data.SourceAdd1 = sdr["SourceAddress1"].ToString();
                        data.SourceAdd2 = sdr["SourceAddress2"].ToString();
                        data.SourceDatatype1 = sdr["SourceDataType1"].ToString();
                        data.SourceDatatype2 = sdr["SourceDataType2"].ToString();
                        data.PollingFrequency = sdr["PollingFrequency"].ToString();
                        data.DataGroup = sdr["DataGroup"].ToString();
                        data.PollingType = sdr["PollingType"].ToString();
                        //data.CycleFreqTime = sdr["CyclesFreqTime"].ToString();
                        string time = sdr["CyclesFreqTime"].ToString();
                        double number;
                        bool isnumber = double.TryParse(time, out number);
                        if (isnumber)
                        {
                            double d1 = Convert.ToDouble(time)
;
                            time = (d1 / 3600).ToString();
                        }
                        data.CycleFreqTime = time;
                        data.NoOfCycle = sdr["NoOfCycles"].ToString();
                        if (sdr["IsMandatory"].ToString() != null && sdr["IsMandatory"].ToString() != "")
                        {
                            if (Convert.ToBoolean(sdr["IsMandatory"].ToString()))
                            {
                                data.ShouldNotBeDisabled = true;
                            }
                            else
                            {
                                data.ShouldNotBeDisabled = false;
                            }
                        }
                        if (sdr["IsEnabledForDataRead"].ToString() != null && sdr["IsEnabledForDataRead"].ToString() != "")
                        {
                            if (Convert.ToBoolean(sdr["IsEnabledForDataRead"].ToString()))
                            {
                                data.IsEnabled = true;
                            }
                            else
                            {
                                data.IsEnabled = false;
                            }
                        }
                        if (sdr["IsEnabledForDataRead"].ToString() != null && sdr["IsEnabledForDataRead"].ToString() != "")
                        {
                            if (Convert.ToBoolean(sdr["IsEnabledForDataRead"].ToString()))
                            {
                                data.IsEnabledForDataRead = true;
                            }
                            else
                            {
                                data.IsEnabledForDataRead = false;
                            }
                        }
                        data.UpperWarning = sdr["UpperWarningLimit"].ToString();
                        data.LowerWarning = sdr["LowerWarningLimit"].ToString();
                        data.UpperError = sdr["UpperErrorLimit"].ToString();
                        data.LowerError = sdr["LowerErrorLimit"].ToString();
                        data.Unit = sdr["Unit"].ToString();
                        data.ScreenName = sdr["ScreenName"].ToString();
                        data.DeleteFlag = sdr["AllowToDelete"].ToString();
                        listData.Add(data);
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("While getting Process Parameter Machine Level Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return listData;
        }
        internal static int deleteProcessParameterAGIMachineData(ProcessParameterMasterData data)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            int res = 0;
            try
            {
                SqlCommand cmd = new SqlCommand("delete from MachineLevelParametersAGI where MTB=@mtb and MachineType=@machinetype and MachineModel=@machinemodel and CNC_MAKE=@CNC_MAKE and CNC_Model=@CNC_Model and MachineID=@machineid and ParameterID=@ParameterID  and CompanyID=@Company and PlantID=@Plant", con);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@mtb", data.MTB);
                cmd.Parameters.AddWithValue("@machinetype", data.MachineType);
                cmd.Parameters.AddWithValue("@machinemodel", data.MachineModel);
                cmd.Parameters.AddWithValue("@CNC_MAKE", data.CNCMake);
                cmd.Parameters.AddWithValue("@CNC_Model", data.CNCModel);
                cmd.Parameters.AddWithValue("@machineid", data.MachineID);
                cmd.Parameters.AddWithValue("@ParameterID", data.ParemeterID);
                cmd.Parameters.AddWithValue("@Company", data.Company);
                cmd.Parameters.AddWithValue("@Plant", data.Plant);
                res = cmd.ExecuteNonQuery();

            }
            catch (Exception ex)
            {
                res = 0;
                Logger.WriteErrorLog("While deleting Process Parameter Machine Level Master Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
            }
            return res;
        }
        internal static int copyModelLevelDataToSelectedModelAGI(string sourceModel, string distinationModel, string cncMake, string cncModel, string cncMachineType, string mtb)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            int res = 0;
            try
            {
                SqlCommand cmd = new SqlCommand(@"If exists(select * from ModelLevelParametersAGI where  CNC_MAKE=@CNC_MAKE and CNC_Model=@CNC_Model and MTB=@mtb and machinetype=@machinetype and MachineModel=@destiMachinemodel)
Begin
Delete from ModelLevelParametersAGI where  CNC_MAKE=@CNC_MAKE and CNC_Model=@CNC_Model and MTB=@mtb and machinetype=@machinetype and MachineModel=@destiMachinemodel
END
Insert into ModelLevelParametersAGI( MTB, CNC_MAKE, CNC_Model, MachineType, MachineModel, ParameterID, SourceType, SourceAddress1, SourceDataType1, SourceAddress2, SourceDataType2, PollingFrequency, DataGroup, PollingType,
CyclesFreqTime, NoOfCycles, IsEnabledForDataRead, IsMandatory, UpperWarningLimit, LowerWarningLimit, UpperErrorLimit, LowerErrorLimit, UpdatedBy, UpdatedTS, Unit, CompanyID, PlantID, SyncedStatus)
select MTB, CNC_MAKE, CNC_Model, MachineType, @destiMachinemodel, ParameterID, SourceType, SourceAddress1, SourceDataType1, SourceAddress2, SourceDataType2, PollingFrequency, DataGroup, PollingType,
CyclesFreqTime, NoOfCycles, IsEnabledForDataRead, IsMandatory, UpperWarningLimit, LowerWarningLimit, UpperErrorLimit, LowerErrorLimit, UpdatedBy, UpdatedTS, Unit, CompanyID, PlantID, SyncedStatus
FROM ModelLevelParametersAGI where  CNC_MAKE=@CNC_MAKE and CNC_Model=@CNC_Model and MTB=@mtb and  machinetype=@machinetype and MachineModel=@srcMachinemodel", con);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@mtb", mtb);
                cmd.Parameters.AddWithValue("@machinetype", cncMachineType);
                cmd.Parameters.AddWithValue("@srcMachinemodel", sourceModel);
                cmd.Parameters.AddWithValue("@destiMachinemodel", distinationModel);
                cmd.Parameters.AddWithValue("@CNC_MAKE", cncMake);
                cmd.Parameters.AddWithValue("@CNC_Model", cncModel);
                res = cmd.ExecuteNonQuery();

            }
            catch (Exception ex)
            {
                res = 0;
                Logger.WriteErrorLog("While deleting Process Parameter Model Level Master Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
            }
            return res;
        }
        internal static int copyMachineLevelDataToSelectedModelAGI(string sourceMachineID, string distinationMachineID, string company, string plant, string cncMake, string cncModel, string mtb, string cncMachineType, string machinemodel)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            int res = 0;
            try
            {
                SqlCommand cmd = new SqlCommand(@"If exists(select * from MachineLevelParametersAGI where CompanyID=@company and PlantID=@plant and  CNC_MAKE=@CNC_MAKE and CNC_Model=@CNC_Model and MTB=@mtb and machinetype=@machinetype and MachineModel=@machinemodel and MachineID=@destmachineID)
Begin
Delete from MachineLevelParametersAGI where machinetype=@machinetype and CompanyID=@company and PlantID=@plant and  CNC_MAKE=@CNC_MAKE and CNC_Model=@CNC_Model and MTB=@mtb and MachineModel=@machinemodel and MachineID=@destmachineID
END
Insert into MachineLevelParametersAGI( MTB, CNC_MAKE, CNC_Model, MachineType, MachineModel, ParameterID, SourceType, SourceAddress1, SourceDataType1, SourceAddress2, SourceDataType2, PollingFrequency, DataGroup, PollingType,
CyclesFreqTime, NoOfCycles, IsEnabledForDataRead, IsMandatory, UpperWarningLimit, LowerWarningLimit, UpperErrorLimit, LowerErrorLimit, UpdatedBy, UpdatedTS, Unit, CompanyID, PlantID, SyncedStatus,MachineID)
select MTB, CNC_MAKE, CNC_Model, MachineType, MachineModel, ParameterID, SourceType, SourceAddress1, SourceDataType1, SourceAddress2, SourceDataType2, PollingFrequency, DataGroup, PollingType,
CyclesFreqTime, NoOfCycles, IsEnabledForDataRead, IsMandatory, UpperWarningLimit, LowerWarningLimit, UpperErrorLimit, LowerErrorLimit, UpdatedBy, UpdatedTS, Unit, CompanyID, PlantID, SyncedStatus,@destmachineID
FROM MachineLevelParametersAGI where CompanyID=@company and PlantID=@plant and  CNC_MAKE=@CNC_MAKE and CNC_Model=@CNC_Model and MTB=@mtb and  machinetype=@machinetype and MachineModel=@machinemodel and MachineID=@srcmachineID", con);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@mtb", mtb);
                cmd.Parameters.AddWithValue("@machinetype", cncMachineType);
                cmd.Parameters.AddWithValue("@machinemodel", machinemodel);
                cmd.Parameters.AddWithValue("@CNC_MAKE", cncMake);
                cmd.Parameters.AddWithValue("@CNC_Model", cncModel);
                cmd.Parameters.AddWithValue("@company", company);
                cmd.Parameters.AddWithValue("@plant", plant);
                cmd.Parameters.AddWithValue("@srcmachineID", sourceMachineID);
                cmd.Parameters.AddWithValue("@destmachineID", distinationMachineID);
                res = cmd.ExecuteNonQuery();

            }
            catch (Exception ex)
            {
                res = 0;
                Logger.WriteErrorLog("While deleting Process Parameter Model Level Master Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
            }
            return res;
        }
        #endregion

        internal static List<ListItem> getMachineIDs(string companyid, string plantid)
        {
            //string companyid,string plantid
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<ListItem> listData = new List<ListItem>();
            ListItem listItem = null;
            try
            {
                //SqlCommand cmd = new SqlCommand(@"select distinct Machineid from Machineinformation", con);
                SqlCommand cmd = new SqlCommand(@"select distinct Machineid from Machineinformation where PlantID=@plantid and CompanyID=@companyid", con);
                cmd.Parameters.AddWithValue("@plantid", plantid);
                cmd.Parameters.AddWithValue("@companyid", companyid);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        listItem = new ListItem();
                        listItem.Text = sdr["Machineid"].ToString();
                        listItem.Value = sdr["Machineid"].ToString();
                        listData.Add(listItem);
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("While getting Machine  Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return listData;
        }
        #region ----- Troubleshooting -----------
        internal static string getMTBModelForParameter(string machineid, string parameter, out string model)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            string mtb = "";
            model = "";
            try
            {
                SqlCommand cmd = new SqlCommand("select MTB,MachineModel from MachineLevelParameters where MachineID=@machineid and ParameterID=@parameter", con);
                cmd.Parameters.AddWithValue("@machineid", machineid);
                cmd.Parameters.AddWithValue("@parameter", parameter);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        mtb = sdr["MTB"].ToString();
                        model = sdr["MachineModel"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("While getting MTB & Model Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return mtb;
        }
        #endregion

        #region ------ Alarm History ---------
        internal static ShiftData getCurrentShiftDetails()
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            ShiftData data = new ShiftData();
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_GetCurrentShift]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        data.Shiftname = sdr["ShiftName"].ToString();
                        data.StartTime = sdr["StartTime"].ToString();
                        data.EndTime = sdr["EndTime"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return data;
        }
        internal static string getMTBForMachine(string company, string plant, string machine)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            string mtb = "";
            try
            {
                SqlCommand cmd = new SqlCommand("select MachineMTB from Machineinformation where Machineid=@machine and CompanyID=@company and PlantID=@plant", con);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@machine", machine);
                cmd.Parameters.AddWithValue("@company", company);
                cmd.Parameters.AddWithValue("@plant", plant);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        mtb = sdr["MachineMTB"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return mtb;
        }

        #endregion

        #region ------Login ------
        internal static bool checkLoginData(string userID, string password,string corporateid)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            bool exists = false;
            try
            {
                SqlCommand cmd = new SqlCommand("select * from UserInfo where Userid=@Userid and Password=@Password and CorporateID=@CorporateID and EffectiveToDate='9999-12-31 00:00:00.000'", con);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@Userid", userID);
                cmd.Parameters.AddWithValue("@Password", password);
                cmd.Parameters.AddWithValue("@CorporateID", corporateid);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    exists = true;
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("checkLoginData: " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return exists;
        }
        internal static string getCompanyIDOfLoginUser(string userID)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            string role = "";
            try
            {
                SqlCommand cmd = new SqlCommand("select CompanyID from UserRole where Userid=@Userid and EffectiveToDate='9999-12-31 00:00:00.000'", con);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@Userid", userID);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        role = sdr["CompanyID"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("getCompanyIDOfLoginUser:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return role;
        }

        internal static string getRoleOfLoginUser(string userID,string corporateid)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            string role = "";
            try
            {
                SqlCommand cmd = new SqlCommand("select Role from UserRole where Userid=@Userid and CompanyID=@CompanyID and EffectiveToDate='9999-12-31 00:00:00.000'", con);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@Userid", userID);
                cmd.Parameters.AddWithValue("@CompanyID", corporateid);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        role = sdr["Role"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("getRoleOfLoginUser:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return role;
        }
       
        #endregion

        #region ---------Group Details-------------
        internal static string checkGroupEffectiveDate(CompanyGroupDetails data)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            string date = "";
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Masters_TPM_EntityAndCompany]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EntityID", data.GroupID);
                cmd.Parameters.AddWithValue("@Entity", data.GroupName);
                cmd.Parameters.AddWithValue("@ContactPerson", data.ContactPerson);
                cmd.Parameters.AddWithValue("@Email", data.Email);
                cmd.Parameters.AddWithValue("@Phone1", data.Phone);
                cmd.Parameters.AddWithValue("@Address1", data.Address);
                cmd.Parameters.AddWithValue("@Place", data.Place);
                cmd.Parameters.AddWithValue("@State", data.State);
                cmd.Parameters.AddWithValue("@Country", data.Country);
                cmd.Parameters.AddWithValue("@PIN", data.Pin);
                cmd.Parameters.AddWithValue("@EffectiveFromDate", data.EffectiveFromDate);
                cmd.Parameters.AddWithValue("@EffectiveToDate", data.EffectiveToDate);
                cmd.Parameters.AddWithValue("@Param", "DateValidation");
                cmd.Parameters.AddWithValue("@Type", "Entity");
                cmd.Parameters.AddWithValue("@Param1", data.NewOrEditParam == "New" ? "" : data.NewOrEditParam);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        date = sdr["EffectiveTodate"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("checkEffectiveDate:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return date;
        }
        internal static string saveUpdateGroupDetails(CompanyGroupDetails data)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            string success = "";
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Masters_TPM_EntityAndCompany]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EntityID", data.GroupID);
                cmd.Parameters.AddWithValue("@Entity", data.GroupName);
                cmd.Parameters.AddWithValue("@ContactPerson", data.ContactPerson);
                cmd.Parameters.AddWithValue("@Email", data.Email);
                cmd.Parameters.AddWithValue("@Phone1", data.Phone);
                cmd.Parameters.AddWithValue("@Address1", data.Address);
                cmd.Parameters.AddWithValue("@Place", data.Place);
                cmd.Parameters.AddWithValue("@State", data.State);
                cmd.Parameters.AddWithValue("@Country", data.Country);
                cmd.Parameters.AddWithValue("@PIN", data.Pin);
                cmd.Parameters.AddWithValue("@EffectiveFromDate", data.EffectiveFromDate);
                cmd.Parameters.AddWithValue("@EffectiveToDate", data.EffectiveToDate);
                cmd.Parameters.AddWithValue("@Param", "Save");
                cmd.Parameters.AddWithValue("@Type", "Entity");
                cmd.Parameters.AddWithValue("@Param1", data.NewOrEditParam=="New"?"":data.NewOrEditParam);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        success = sdr["SaveFlag"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("saveUpdateGroupDetails:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return success;
        }
        internal static List<CompanyGroupDetails> getGroupDetails(string groupName)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<CompanyGroupDetails> grpDetailsList = new List<CompanyGroupDetails>();
            CompanyGroupDetails grpData = null;
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Masters_TPM_EntityAndCompany]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Entity", groupName);
                cmd.Parameters.AddWithValue("@Type", "Entity");
                cmd.Parameters.AddWithValue("@Param", "View");
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        grpData = new CompanyGroupDetails();
                        grpData.GroupID = sdr["EntityID"].ToString();
                        grpData.GroupName = sdr["Entity"].ToString();
                        grpData.ContactPerson = sdr["ContactPerson"].ToString();
                        grpData.Place = sdr["Place"].ToString();
                        grpData.State = sdr["State"].ToString();
                        grpData.Country = sdr["Country"].ToString();
                        grpData.Pin = sdr["PIN"].ToString();
                        grpData.Email = sdr["Email"].ToString();
                        grpData.Phone = sdr["Phone1"].ToString();
                        grpData.Address = sdr["Address1"].ToString();
                        grpData.EffectiveFromDate = Util.GetDateTime(sdr["EffectiveFromDate"].ToString()).ToString("dd-MM-yyyy HH:mm:ss");
                        grpData.EffectiveToDate = Util.GetDateTime(sdr["EffectiveToDate"].ToString()).ToString("dd-MM-yyyy HH:mm:ss");
                        grpDetailsList.Add(grpData);
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("getGroupDetails:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return grpDetailsList;
        }
        internal static int deleteGroupCompanyDetails(CompanyGroupDetails data, string type)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            int result = 0;
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Masters_TPM_EntityAndCompany]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EntityID", data.GroupID);
                cmd.Parameters.AddWithValue("@CompanyID", data.CompanyID);
                cmd.Parameters.AddWithValue("@EffectiveFromDate", data.EffectiveFromDate);
                cmd.Parameters.AddWithValue("@EffectiveToDate", data.EffectiveToDate);
                cmd.Parameters.AddWithValue("@Param", "Delete");
                cmd.Parameters.AddWithValue("@Type", type);
                result = cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("deleteGroupCompanyDetails:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return result;
        }
        #endregion

        #region --------Company Details---------
        internal static List<CompanyGroupDetails> getCompanyDetails(string companyName)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<CompanyGroupDetails> cmpnyDetailsList = new List<CompanyGroupDetails>();
            CompanyGroupDetails cmpnyData = null;
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Masters_TPM_EntityAndCompany]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyName", companyName);
                cmd.Parameters.AddWithValue("@Type", "Company");
                cmd.Parameters.AddWithValue("@Param", "View");
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        cmpnyData = new CompanyGroupDetails();
                        cmpnyData.GroupID = sdr["Entity"].ToString();
                        cmpnyData.CompanyID = sdr["CompanyID"].ToString();
                        cmpnyData.CompanyName = sdr["CompanyName"].ToString();
                        cmpnyData.ContactPerson = sdr["ContactPerson"].ToString();
                        cmpnyData.Place = sdr["Place"].ToString();
                        cmpnyData.State = sdr["State"].ToString();
                        cmpnyData.Country = sdr["Country"].ToString();
                        cmpnyData.Pin = sdr["PIN"].ToString();
                        cmpnyData.Email = sdr["Email"].ToString();
                        cmpnyData.Phone = sdr["Phone1"].ToString();
                        cmpnyData.Address = sdr["Address1"].ToString();
                        cmpnyData.UserID = sdr["Userid"].ToString();
                        cmpnyData.Password = sdr["Password"].ToString();
                        cmpnyData.EffectiveFromDate = Util.GetDateTime(sdr["EffectiveFromDate"].ToString()).ToString("dd-MM-yyyy HH:mm:ss");
                        cmpnyData.EffectiveToDate = Util.GetDateTime(sdr["EffectiveToDate"].ToString()).ToString("dd-MM-yyyy HH:mm:ss");
                        cmpnyDetailsList.Add(cmpnyData);
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("getCompanyDetails:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return cmpnyDetailsList;
        }
        internal static string saveUpdateCompanyDetails(CompanyGroupDetails data)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            string success = "";
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Masters_TPM_EntityAndCompany]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Entity", data.GroupID);
                cmd.Parameters.AddWithValue("@CompanyID", data.CompanyID);
                cmd.Parameters.AddWithValue("@CompanyName", data.CompanyName);
                cmd.Parameters.AddWithValue("@ContactPerson", data.ContactPerson);
                cmd.Parameters.AddWithValue("@Email", data.Email);
                cmd.Parameters.AddWithValue("@Phone1", data.Phone);
                cmd.Parameters.AddWithValue("@Address1", data.Address);
                cmd.Parameters.AddWithValue("@Place", data.Place);
                cmd.Parameters.AddWithValue("@State", data.State);
                cmd.Parameters.AddWithValue("@Country", data.Country);
                cmd.Parameters.AddWithValue("@PIN", data.Pin);
                //cmd.Parameters.AddWithValue("@Password", data.Password);
                //cmd.Parameters.AddWithValue("@Username", data.UserID);
                cmd.Parameters.AddWithValue("@EffectiveFromDate", data.EffectiveFromDate);
                cmd.Parameters.AddWithValue("@EffectiveToDate", data.EffectiveToDate);
                cmd.Parameters.AddWithValue("@Param", "Save");
                cmd.Parameters.AddWithValue("@Type", "Company");
                cmd.Parameters.AddWithValue("@Param1", data.NewOrEditParam == "New" ? "" : data.NewOrEditParam);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        success = sdr["SaveFlag"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("saveUpdateCompanyDetails:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return success;
        }
        internal static string checkCompanyEffectiveDate(CompanyGroupDetails data)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            string date = "";
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Masters_TPM_EntityAndCompany]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Entity", data.GroupID == "None" ? "" : data.GroupID);
                cmd.Parameters.AddWithValue("@CompanyID", data.CompanyID);
                cmd.Parameters.AddWithValue("@CompanyName", data.CompanyName);
                cmd.Parameters.AddWithValue("@ContactPerson", data.ContactPerson);
                cmd.Parameters.AddWithValue("@Email", data.Email);
                cmd.Parameters.AddWithValue("@Phone1", data.Phone);
                cmd.Parameters.AddWithValue("@Address1", data.Address);
                cmd.Parameters.AddWithValue("@Place", data.Place);
                cmd.Parameters.AddWithValue("@State", data.State);
                cmd.Parameters.AddWithValue("@Country", data.Country);
                cmd.Parameters.AddWithValue("@PIN", data.Pin);
                //cmd.Parameters.AddWithValue("@Password", data.Password);
                //cmd.Parameters.AddWithValue("@Username", data.UserID);
                cmd.Parameters.AddWithValue("@EffectiveFromDate", data.EffectiveFromDate);
                cmd.Parameters.AddWithValue("@EffectiveToDate", data.EffectiveToDate);
                cmd.Parameters.AddWithValue("@Param", "DateValidation");
                cmd.Parameters.AddWithValue("@Type", "Company");
                cmd.Parameters.AddWithValue("@Param1", data.NewOrEditParam == "New" ? "" : data.NewOrEditParam);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        date = sdr["EffectiveTodate"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("checkCompanyEffectiveDate:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return date;
        }
        internal static string saveUpdateCompanyAdminDetails(CompanyGroupDetails data)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            string success = "";
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Masters_TPM_UserRoleInformation]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                //cmd.Parameters.AddWithValue("@Entity", data.GroupID == "None" ? "" : data.GroupID);
                cmd.Parameters.AddWithValue("@CorporateID", data.GroupID);
                cmd.Parameters.AddWithValue("@CompanyID", data.CompanyID);
                cmd.Parameters.AddWithValue("@Role", "CompanyAdmin");
                cmd.Parameters.AddWithValue("@UserId", data.UserID);
                cmd.Parameters.AddWithValue("@Password", data.Password);
                cmd.Parameters.AddWithValue("@EffectiveFromDate", data.EffectiveFromDate);
                cmd.Parameters.AddWithValue("@EffectiveToDate", data.EffectiveToDate);
                cmd.Parameters.AddWithValue("@UpdatedBy", HttpContext.Current.Session["Username"] == null ? "" : HttpContext.Current.Session["Username"].ToString());
                cmd.Parameters.AddWithValue("@UpdatedTS", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@Param", "Save");
                cmd.Parameters.AddWithValue("@Param1", data.NewOrEditParam == "New" ? "" : data.NewOrEditParam);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        success = sdr["SaveFlag"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("saveUpdateCompanyAdminDetails:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return success;
        }
        #endregion

        #region ----------Plant Details----------------------
        internal static List<PlantLevelDetails> getPlantDetails(PlantLevelDetails inputdata)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<PlantLevelDetails> dataList = new List<PlantLevelDetails>();
            PlantLevelDetails data = null;
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Masters_TPM_PlantInformation]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", inputdata.CompanyID);
                cmd.Parameters.AddWithValue("@PlantID", inputdata.PlantID);
                cmd.Parameters.AddWithValue("@Param", "View");
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        data = new PlantLevelDetails();
                        data.CompanyID = sdr["CompanyID"].ToString();
                        data.PlantID = sdr["PlantID"].ToString();
                        data.Description = sdr["Description"].ToString();
                        data.Code = sdr["PlantCode"].ToString();
                        data.Address = sdr["PlantAddress"].ToString();
                        data.Country = sdr["PlantCountry"].ToString();
                        data.Region = sdr["PlantRegion"].ToString();
                        data.GeoLocation = sdr["PlantGeoLocation"].ToString();
                        data.City = sdr["PlantCity"].ToString();
                        data.EffectiveFromDate = Util.GetDateTime(sdr["EffectiveFromDate"].ToString()).ToString("dd-MM-yyyy HH:mm:ss");
                        data.EffectiveToDate = Util.GetDateTime(sdr["EffectiveToDate"].ToString()).ToString("dd-MM-yyyy HH:mm:ss");
                        dataList.Add(data);
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("getPlantDetails:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return dataList;
        }
        internal static string saveUpdatePlantDetails(PlantLevelDetails data)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            string success = "";
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Masters_TPM_PlantInformation]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", data.CompanyID == "None" ? "" : data.CompanyID);
                cmd.Parameters.AddWithValue("@PlantID", data.PlantID);
                cmd.Parameters.AddWithValue("@Description", data.Description);
                cmd.Parameters.AddWithValue("@PlantCode", data.Code);
                cmd.Parameters.AddWithValue("@PlantAddress", data.Address);
                cmd.Parameters.AddWithValue("@PlantCountry", data.Country);
                cmd.Parameters.AddWithValue("@PlantRegion", data.Region);
                cmd.Parameters.AddWithValue("@PlantGeoLocation", data.GeoLocation);
                cmd.Parameters.AddWithValue("@PlantCity", data.City);
                cmd.Parameters.AddWithValue("@UpdatedBy", HttpContext.Current.Session["Username"] == null ? "" : HttpContext.Current.Session["Username"].ToString());
                cmd.Parameters.AddWithValue("@UpdatedTS", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@EffectiveFromDate", data.EffectiveFromDate);
                cmd.Parameters.AddWithValue("@EffectiveToDate", data.EffectiveToDate);
                cmd.Parameters.AddWithValue("@Param1", data.NewOrEditParam=="New"?"":data.NewOrEditParam);
                cmd.Parameters.AddWithValue("@Param", "Save");
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        success = sdr["SaveFlag"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("saveUpdatePlantDetails:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return success;
        }
        internal static string checkPlantEffectiveDate(PlantLevelDetails data)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            string date = "";
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Masters_TPM_PlantInformation]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", data.CompanyID == "None" ? "" : data.CompanyID);
                cmd.Parameters.AddWithValue("@PlantID", data.PlantID);
                cmd.Parameters.AddWithValue("@Description", data.Description);
                cmd.Parameters.AddWithValue("@PlantCode", data.Code);
                cmd.Parameters.AddWithValue("@PlantAddress", data.Address);
                cmd.Parameters.AddWithValue("@PlantCountry", data.Country);
                cmd.Parameters.AddWithValue("@PlantRegion", data.Region);
                cmd.Parameters.AddWithValue("@PlantGeoLocation", data.GeoLocation);
                cmd.Parameters.AddWithValue("@PlantCity", data.City);
                cmd.Parameters.AddWithValue("@UpdatedBy", HttpContext.Current.Session["Username"] == null ? "" : HttpContext.Current.Session["Username"].ToString());
                cmd.Parameters.AddWithValue("@UpdatedTS", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@EffectiveFromDate", data.EffectiveFromDate);
                cmd.Parameters.AddWithValue("@EffectiveToDate", data.EffectiveToDate);
                cmd.Parameters.AddWithValue("@Param1", data.NewOrEditParam == "New" ? "" : data.NewOrEditParam);
                cmd.Parameters.AddWithValue("@Param", "DateValidation");
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        date = sdr["EffectiveTodate"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("checkPlantEffectiveDate:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return date;
        }
        internal static int deletePlantDetails(PlantLevelDetails data)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            int result = 0;
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Masters_TPM_PlantInformation]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", data.CompanyID);
                cmd.Parameters.AddWithValue("@PlantID", data.PlantID);
                cmd.Parameters.AddWithValue("@EffectiveFromDate", data.EffectiveFromDate);
                cmd.Parameters.AddWithValue("@EffectiveToDate", data.EffectiveToDate);
                cmd.Parameters.AddWithValue("@Param", "Delete");
                result = cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("deletePlantDetails:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return result;
        }
        #endregion

        #region -------Shop Details-----
        internal static List<PlantLevelDetails> getPlantShopDetails(PlantLevelDetails inputdata)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<PlantLevelDetails> dataList = new List<PlantLevelDetails>();
            PlantLevelDetails data = null;
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Master_TPM_ShopCellGroup]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", inputdata.CompanyID);
                cmd.Parameters.AddWithValue("@PlantID", inputdata.PlantID == "All" ? "" : inputdata.PlantID);
                cmd.Parameters.AddWithValue("@Param", "View");
                cmd.Parameters.AddWithValue("@Type", "Shop");
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        data = new PlantLevelDetails();
                        data.CompanyID = sdr["CompanyID"].ToString();
                        data.PlantID = sdr["PlantID"].ToString();
                        data.ShopID = sdr["ShopID"].ToString();
                        data.Description = sdr["ShopName"].ToString();
                        data.GeoLocation = sdr["GeoLocation"].ToString();
                        data.EffectiveFromDate = Util.GetDateTime(sdr["EffectiveFromDate"].ToString()).ToString("dd-MM-yyyy HH:mm:ss");
                        data.EffectiveToDate = Util.GetDateTime(sdr["EffectiveToDate"].ToString()).ToString("dd-MM-yyyy HH:mm:ss");
                        dataList.Add(data);
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("getShopDetails:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return dataList;
        }

        internal static string saveUpdatePlantShopDetails(PlantLevelDetails data)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            string success = "";
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Master_TPM_ShopCellGroup]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", data.CompanyID == "None" ? "" : data.CompanyID);
                cmd.Parameters.AddWithValue("@PlantID", data.PlantID);
                cmd.Parameters.AddWithValue("@ShopID", data.ShopID);
                cmd.Parameters.AddWithValue("@ShopName", data.Description);
                cmd.Parameters.AddWithValue("@GeoLocation", data.GeoLocation);
                cmd.Parameters.AddWithValue("@UpdatedBy", HttpContext.Current.Session["Username"] == null ? "" : HttpContext.Current.Session["Username"].ToString());
                cmd.Parameters.AddWithValue("@UpdatedTS", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@EffectiveFromDate", data.EffectiveFromDate);
                cmd.Parameters.AddWithValue("@EffectiveToDate", data.EffectiveToDate);
                cmd.Parameters.AddWithValue("@Param1", data.NewOrEditParam == "New" ? "" : data.NewOrEditParam);
                cmd.Parameters.AddWithValue("@Param", "Save");
                cmd.Parameters.AddWithValue("@Type", "Shop");
               
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        success = sdr["SaveFlag"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("saveUpdatePlantShopDetails:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return success;
        }

        internal static string checkShopEffectiveDate(PlantLevelDetails data)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            string date = "";
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Master_TPM_ShopCellGroup]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", data.CompanyID == "None" ? "" : data.CompanyID);
                cmd.Parameters.AddWithValue("@PlantID", data.PlantID);
                cmd.Parameters.AddWithValue("@ShopID", data.ShopID);
                cmd.Parameters.AddWithValue("@ShopName", data.Description);
                cmd.Parameters.AddWithValue("@GeoLocation", data.GeoLocation);
                cmd.Parameters.AddWithValue("@UpdatedBy", HttpContext.Current.Session["Username"] == null ? "" : HttpContext.Current.Session["Username"].ToString());
                cmd.Parameters.AddWithValue("@UpdatedTS", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@EffectiveFromDate", data.EffectiveFromDate);
                cmd.Parameters.AddWithValue("@EffectiveToDate", data.EffectiveToDate);
                cmd.Parameters.AddWithValue("@Param1", data.NewOrEditParam == "New" ? "" : data.NewOrEditParam);
                cmd.Parameters.AddWithValue("@Param", "DateValidation");
                cmd.Parameters.AddWithValue("@Type", "Shop");

                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        date = sdr["EffectiveTodate"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("checkShopEffectiveDate:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return date;
        }
        internal static int deleteShopCellGroupDetails(PlantLevelDetails data,string type)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            int result = 0;
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Master_TPM_ShopCellGroup]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", data.CompanyID);
                cmd.Parameters.AddWithValue("@PlantID", data.PlantID);
                cmd.Parameters.AddWithValue("@ShopID", data.ShopID);
                cmd.Parameters.AddWithValue("@CellID", data.CellID);
                cmd.Parameters.AddWithValue("@GroupID", data.GroupID);
                cmd.Parameters.AddWithValue("@EffectiveFromDate", data.EffectiveFromDate);
                cmd.Parameters.AddWithValue("@EffectiveToDate", data.EffectiveToDate);
                cmd.Parameters.AddWithValue("@Param", "Delete");
                cmd.Parameters.AddWithValue("@Type", type);
                result = cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("deleteShopCellGroupDetails:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return result;
        }
        #endregion

        #region ------Shop Cell ------
        internal static List<PlantLevelDetails> getShopCellDetails(PlantLevelDetails inputdata)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<PlantLevelDetails> dataList = new List<PlantLevelDetails>();
            PlantLevelDetails data = null;
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Master_TPM_ShopCellGroup]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", inputdata.CompanyID);
                cmd.Parameters.AddWithValue("@PlantID", inputdata.PlantID=="All"? "" : inputdata.PlantID );
                cmd.Parameters.AddWithValue("@ShopID", inputdata.ShopID=="All"?"":inputdata.ShopID);
                cmd.Parameters.AddWithValue("@Param", "View");
                cmd.Parameters.AddWithValue("@Type", "ShopCell");
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        data = new PlantLevelDetails();
                        data.CompanyID = sdr["CompanyID"].ToString();
                        data.PlantID = sdr["PlantID"].ToString();
                        data.ShopID = sdr["ShopID"].ToString();
                        data.CellID = sdr["CellID"].ToString();
                        data.Description = sdr["CellName"].ToString();
                        data.EffectiveFromDate = Util.GetDateTime(sdr["EffectiveFromDate"].ToString()).ToString("dd-MM-yyyy HH:mm:ss");
                        data.EffectiveToDate = Util.GetDateTime(sdr["EffectiveToDate"].ToString()).ToString("dd-MM-yyyy HH:mm:ss");
                        dataList.Add(data);
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("getShopCellDetails:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return dataList;
        }
        internal static string checkShopCellEffectiveDate(PlantLevelDetails data)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            string date = "";
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Master_TPM_ShopCellGroup]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", data.CompanyID == "None" ? "" : data.CompanyID);
                cmd.Parameters.AddWithValue("@PlantID", data.PlantID);
                cmd.Parameters.AddWithValue("@ShopID", data.ShopID);
                cmd.Parameters.AddWithValue("@CellID", data.CellID);
                cmd.Parameters.AddWithValue("@CellName", data.Description);
                cmd.Parameters.AddWithValue("@UpdatedBy", HttpContext.Current.Session["Username"] == null ? "" : HttpContext.Current.Session["Username"].ToString());
                cmd.Parameters.AddWithValue("@UpdatedTS", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@EffectiveFromDate", data.EffectiveFromDate);
                cmd.Parameters.AddWithValue("@EffectiveToDate", data.EffectiveToDate);
                cmd.Parameters.AddWithValue("@Param1", data.NewOrEditParam == "New" ? "" : data.NewOrEditParam);
                cmd.Parameters.AddWithValue("@Param", "DateValidation");
                cmd.Parameters.AddWithValue("@Type", "ShopCell");
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        date = sdr["EffectiveTodate"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("checkShopCellEffectiveDate:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return date;
        }
        internal static string saveUpdateShopCellDetails(PlantLevelDetails data)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            string success = "";
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Master_TPM_ShopCellGroup]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", data.CompanyID == "None" ? "" : data.CompanyID);
                cmd.Parameters.AddWithValue("@PlantID", data.PlantID);
                cmd.Parameters.AddWithValue("@ShopID", data.ShopID);
                cmd.Parameters.AddWithValue("@CellID", data.CellID);
                cmd.Parameters.AddWithValue("@CellName", data.Description);
                cmd.Parameters.AddWithValue("@UpdatedBy", HttpContext.Current.Session["Username"] == null ? "" : HttpContext.Current.Session["Username"].ToString());
                cmd.Parameters.AddWithValue("@UpdatedTS", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@EffectiveFromDate", data.EffectiveFromDate);
                cmd.Parameters.AddWithValue("@EffectiveToDate", data.EffectiveToDate);
                cmd.Parameters.AddWithValue("@Param1", data.NewOrEditParam=="New"?"":data.NewOrEditParam);
                cmd.Parameters.AddWithValue("@Param", "Save");
                cmd.Parameters.AddWithValue("@Type", "ShopCell");
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        success = sdr["SaveFlag"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("saveUpdateShopCellDetails:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return success;
        }
        #endregion

        #region ------Shop Group ------
        internal static List<PlantLevelDetails> getShopGroupDetails(PlantLevelDetails inputdata)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<PlantLevelDetails> dataList = new List<PlantLevelDetails>();
            PlantLevelDetails data = null;
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Master_TPM_ShopCellGroup]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", inputdata.CompanyID);
                cmd.Parameters.AddWithValue("@PlantID", inputdata.PlantID == "All" ? "" : inputdata.PlantID);
                cmd.Parameters.AddWithValue("@ShopID", inputdata.ShopID == "All" ? "" : inputdata.ShopID);
                cmd.Parameters.AddWithValue("@Param", "View");
                cmd.Parameters.AddWithValue("@Type", "ShopGroup");
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        data = new PlantLevelDetails();
                        data.CompanyID = sdr["CompanyID"].ToString();
                        data.PlantID = sdr["PlantID"].ToString();
                        data.ShopID = sdr["ShopID"].ToString();
                        data.GroupID = sdr["GroupID"].ToString();
                        data.Description = sdr["GroupName"].ToString();
                        data.EffectiveFromDate = Util.GetDateTime(sdr["EffectiveFromDate"].ToString()).ToString("dd-MM-yyyy HH:mm:ss");
                        data.EffectiveToDate = Util.GetDateTime(sdr["EffectiveToDate"].ToString()).ToString("dd-MM-yyyy HH:mm:ss");
                        dataList.Add(data);
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("getShopGroupDetails:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return dataList;
        }
        internal static string checkShopGroupEffectiveDate(PlantLevelDetails data)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            string date = "";
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Master_TPM_ShopCellGroup]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", data.CompanyID == "None" ? "" : data.CompanyID);
                cmd.Parameters.AddWithValue("@PlantID", data.PlantID);
                cmd.Parameters.AddWithValue("@ShopID", data.ShopID);
                cmd.Parameters.AddWithValue("GroupID", data.GroupID);
                cmd.Parameters.AddWithValue("@GroupName", data.Description);
                cmd.Parameters.AddWithValue("@UpdatedBy", HttpContext.Current.Session["Username"] == null ? "" : HttpContext.Current.Session["Username"].ToString());
                cmd.Parameters.AddWithValue("@UpdatedTS", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@EffectiveFromDate", data.EffectiveFromDate);
                cmd.Parameters.AddWithValue("@EffectiveToDate", data.EffectiveToDate);
                cmd.Parameters.AddWithValue("@Param1", data.NewOrEditParam == "New" ? "" : data.NewOrEditParam);
                cmd.Parameters.AddWithValue("@Param", "DateValidation");
                cmd.Parameters.AddWithValue("@Type", "ShopGroup");
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        date = sdr["EffectiveTodate"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("checkShopGroupEffectiveDate:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return date;
        }
        internal static string saveUpdateShopGroupDetails(PlantLevelDetails data)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            string success = "";
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Master_TPM_ShopCellGroup]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", data.CompanyID == "None" ? "" : data.CompanyID);
                cmd.Parameters.AddWithValue("@PlantID", data.PlantID);
                cmd.Parameters.AddWithValue("@ShopID", data.ShopID);
                cmd.Parameters.AddWithValue("GroupID", data.GroupID);
                cmd.Parameters.AddWithValue("@GroupName", data.Description);
                cmd.Parameters.AddWithValue("@UpdatedBy", HttpContext.Current.Session["Username"] == null ? "" : HttpContext.Current.Session["Username"].ToString());
                cmd.Parameters.AddWithValue("@UpdatedTS", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@EffectiveFromDate", data.EffectiveFromDate);
                cmd.Parameters.AddWithValue("@EffectiveToDate", data.EffectiveToDate);
                cmd.Parameters.AddWithValue("@Param1", data.NewOrEditParam == "New" ? "" : data.NewOrEditParam);
                cmd.Parameters.AddWithValue("@Param", "Save");
                cmd.Parameters.AddWithValue("@Type", "ShopGroup");
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        success = sdr["SaveFlag"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("saveUpdateShopGroupDetails:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return success;
        }
        #endregion


        #region ------Shop Group ------
        internal static List<PlantLevelDetails> getShopCellGroupDetails(PlantLevelDetails inputdata)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<PlantLevelDetails> dataList = new List<PlantLevelDetails>();
            PlantLevelDetails data = null;
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Master_TPM_ShopCellGroup]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", inputdata.CompanyID);
                cmd.Parameters.AddWithValue("@PlantID", inputdata.PlantID == "All" ? "" : inputdata.PlantID);
                cmd.Parameters.AddWithValue("@ShopID", inputdata.ShopID == "All" ? "" : inputdata.ShopID);
                cmd.Parameters.AddWithValue("@CellID", inputdata.CellID == "All" ? "" : inputdata.CellID);
                cmd.Parameters.AddWithValue("@Param", "View");
                cmd.Parameters.AddWithValue("@Type", "ShopCellGroup");
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        data = new PlantLevelDetails();
                        data.CompanyID = sdr["CompanyID"].ToString();
                        data.PlantID = sdr["PlantID"].ToString();
                        data.ShopID = sdr["ShopID"].ToString();
                        data.CellID = sdr["CellID"].ToString();
                        data.GroupID = sdr["GroupID"].ToString();
                        data.Description = sdr["GroupName"].ToString();
                        data.EffectiveFromDate = Util.GetDateTime(sdr["EffectiveFromDate"].ToString()).ToString("dd-MM-yyyy HH:mm:ss");
                        data.EffectiveToDate = Util.GetDateTime(sdr["EffectiveToDate"].ToString()).ToString("dd-MM-yyyy HH:mm:ss");
                        dataList.Add(data);
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("getShopCellGroupDetails:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return dataList;
        }
        internal static string checkShopCellGroupEffectiveDate(PlantLevelDetails data)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            string date = "";
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Master_TPM_ShopCellGroup]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", data.CompanyID == "None" ? "" : data.CompanyID);
                cmd.Parameters.AddWithValue("@PlantID", data.PlantID);
                cmd.Parameters.AddWithValue("@ShopID", data.ShopID);
                cmd.Parameters.AddWithValue("@CellID", data.CellID);
                cmd.Parameters.AddWithValue("GroupID", data.GroupID);
                cmd.Parameters.AddWithValue("@GroupName", data.Description);
                cmd.Parameters.AddWithValue("@UpdatedBy", HttpContext.Current.Session["Username"] == null ? "" : HttpContext.Current.Session["Username"].ToString());
                cmd.Parameters.AddWithValue("@UpdatedTS", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@EffectiveFromDate", data.EffectiveFromDate);
                cmd.Parameters.AddWithValue("@EffectiveToDate", data.EffectiveToDate);
                cmd.Parameters.AddWithValue("@Param1", data.NewOrEditParam == "New" ? "" : data.NewOrEditParam);
                cmd.Parameters.AddWithValue("@Param", "DateValidation");
                cmd.Parameters.AddWithValue("@Type", "ShopGroup");
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        date = sdr["EffectiveTodate"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("checkShopCellGroupEffectiveDate:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return date;
        }
        internal static string saveUpdateShopCellGroupDetails(PlantLevelDetails data)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            string success = "";
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Master_TPM_ShopCellGroup]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", data.CompanyID == "None" ? "" : data.CompanyID);
                cmd.Parameters.AddWithValue("@PlantID", data.PlantID);
                cmd.Parameters.AddWithValue("@ShopID", data.ShopID);
                cmd.Parameters.AddWithValue("@CellID", data.CellID);
                cmd.Parameters.AddWithValue("GroupID", data.GroupID);
                cmd.Parameters.AddWithValue("@GroupName", data.Description);
                cmd.Parameters.AddWithValue("@UpdatedBy", HttpContext.Current.Session["Username"] == null ? "" : HttpContext.Current.Session["Username"].ToString());
                cmd.Parameters.AddWithValue("@UpdatedTS", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@EffectiveFromDate", data.EffectiveFromDate);
                cmd.Parameters.AddWithValue("@EffectiveToDate", data.EffectiveToDate);
                cmd.Parameters.AddWithValue("@Param1", data.NewOrEditParam == "New" ? "" : data.NewOrEditParam);
                cmd.Parameters.AddWithValue("@Param", "Save");
                cmd.Parameters.AddWithValue("@Type", "ShopGroup");
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        success = sdr["SaveFlag"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("saveUpdateShopCellGroupDetails:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return success;
        }
        #endregion
        #region -------General--------

        internal static string getGroupIDForCompany(string companyid)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            string groupid = "";
            try
            {
                SqlCommand cmd = new SqlCommand("select Entity from Company where CompanyID=@CompanyID and  EffectiveToDate='9999-12-31 00:00:00.000'", con);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@CompanyID", companyid);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        groupid = sdr["Entity"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("getGroupIDForCompany:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return groupid;
        }
        internal static List<LevelHeirarchyDetails> getCheckedShopCellList(string companyid,string plantid)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<LevelHeirarchyDetails> list = new List<LevelHeirarchyDetails>();
            LevelHeirarchyDetails data = null;
            try
            {
                SqlCommand cmd = new SqlCommand("select * from [UserDefinedEntityMenu] where CompanyID=@CompanyID and PlantID=@PlantID and EffectiveToDate='9999-12-31 00:00:00.000'", con);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@CompanyID", companyid);
                cmd.Parameters.AddWithValue("@PlantID", plantid);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        data = new LevelHeirarchyDetails();
                        data.KeyValue = sdr["KeyValue"].ToString();
                        if(Util.GetDateTime(sdr["EffectiveToDate"].ToString()).ToString("dd-MM-yyyy HH:mm:ss")== "31-12-9999 00:00:00")
                        {
                            data.CheckOrUncheck = true;
                            data.Display = "display:block";
                        }
                        else
                        {
                            data.CheckOrUncheck = false;
                            data.Display = "display:none";
                        }
                        list.Add(data);
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("getCheckedShopCellList:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return list;
        }


        internal static List<string> getCountry()
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<string> list = new List<string>();
            try
            {
                SqlCommand cmd = new SqlCommand("select CountryName from Country", con);
                cmd.CommandType = CommandType.Text;
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        list.Add(sdr["CountryName"].ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("getCountry:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return list;
        }

        internal static List<string> getState()
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<string> list = new List<string>();
            try
            {
                SqlCommand cmd = new SqlCommand("select StateName from State", con);
                cmd.CommandType = CommandType.Text;
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        list.Add(sdr["StateName"].ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("getState:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return list;
        }
        internal static List<string> getGroupIDs()
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<string> groupIDList = new List<string>();
            try
            {
                SqlCommand cmd = new SqlCommand("select distinct EntityID from dbo.Entity where EffectiveTodate='9999-12-31 00:00:00.000'", con);
                cmd.CommandType = CommandType.Text;
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        groupIDList.Add(sdr["EntityID"].ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("getGroupID (Entity):  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return groupIDList;
        }

        internal static List<string> getCompanyIDs(string group)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<string> cmpyIDList = new List<string>();
            try
            {
                SqlCommand cmd = new SqlCommand("select distinct CompanyID from Company where Entity=@Group and EffectiveTodate='9999-12-31 00:00:00.000'", con);
                cmd.Parameters.AddWithValue("@Group", group);
                cmd.CommandType = CommandType.Text;
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        cmpyIDList.Add(sdr["CompanyID"].ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("getCompanyIDs :  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return cmpyIDList;
        }

        internal static List<string> getPlantsIDs(string companyid)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<string> plantIDList = new List<string>();
            try
            {
                SqlCommand cmd = new SqlCommand("select distinct PlantID from PlantInformation where (CompanyID=@CompanyID or ISNULL(@CompanyID,'')='') and EffectiveTodate='9999-12-31 00:00:00.000'", con);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@CompanyID", companyid);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        plantIDList.Add(sdr["PlantID"].ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("getPlantsIDs:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return plantIDList;
        }

        internal static List<string> getShopIDs(string companyid,string plantid)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<string> shopIDList = new List<string>();
            try
            {
                SqlCommand cmd = new SqlCommand("select  distinct ShopID from PlantShop where (CompanyID=@CompanyID or ISNULL(@CompanyID,'')='') and (PlantID=@PlantID or ISNULL(@PlantID,'')='') and EffectiveTodate='9999-12-31 00:00:00.000'", con);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@CompanyID", companyid);
                cmd.Parameters.AddWithValue("@PlantID", plantid=="All"?"":plantid);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        shopIDList.Add(sdr["ShopID"].ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("getShopIDs:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return shopIDList;
        }


        internal static List<string> getLevelAssignedPlantIDs(string companyid, string type)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<string> shopIDList = new List<string>();
            try
            {
                SqlCommand cmd = new SqlCommand("select distinct PlantID from UserDefinedEntityMenu  where(CompanyID = @CompanyID or ISNULL(@CompanyID, '') = '') and EffectiveTodate = '9999-12-31 00:00:00.000' and KeyValue = @Type", con);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@CompanyID", companyid);
                cmd.Parameters.AddWithValue("@Type",type);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        shopIDList.Add(sdr["PlantID"].ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("getLevelAssignedPlantIDs:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return shopIDList;
        }

        internal static List<string> getGroupIDsWithPlantFiletr(string companyid, string plantid)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<string> shopIDList = new List<string>();
            try
            {
                SqlCommand cmd = new SqlCommand("select  distinct GroupID from [Group] where CompanyID=@CompanyID and PlantID=@PlantID and EffectiveTodate='9999-12-31 00:00:00.000'", con);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@CompanyID", companyid);
                cmd.Parameters.AddWithValue("@PlantID", plantid);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        shopIDList.Add(sdr["GroupID"].ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("getGroupIDsWithPlantFiletr:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return shopIDList;
        }
        internal static List<string> getCellIDs()
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<string> shopIDList = new List<string>();
            try
            {
                SqlCommand cmd = new SqlCommand(" select distinct CellID from CellInfo where EffectiveTodate='9999-12-31 00:00:00.000'", con);
                cmd.CommandType = CommandType.Text;
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        shopIDList.Add(sdr["CellID"].ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("getCellIDs:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return shopIDList;
        }

        internal static List<string> getGroupID()
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<string> shopIDList = new List<string>();
            try
            {
                SqlCommand cmd = new SqlCommand("select distinct  GroupID from[Group] where EffectiveTodate = '9999-12-31 00:00:00.000'", con);
                cmd.CommandType = CommandType.Text;
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        shopIDList.Add(sdr["GroupID"].ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("getGroupID:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return shopIDList;
        }

        internal static List<string> getCellIDs(string company, string plant, string shop)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<string> list = new List<string>();
            try
            {
                SqlCommand cmd = new SqlCommand(@"select distinct CellID from CellInfo where (CompanyID=@company or ISNULL(@company,'')='') and (PlantID=@plant or ISNULL(@plant,'')='') and (ShopID=@shop or ISNULL(@shop,'')='')
and EffectiveTodate='9999-12-31 00:00:00.000'", con);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@company", company);
                cmd.Parameters.AddWithValue("@plant", plant=="All"?"":plant);
                cmd.Parameters.AddWithValue("@shop", shop=="All"?"":shop);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        list.Add(sdr["CellID"].ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("getCellIDs: " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return list;
        }
        internal static List<string> getGroupIDs(string company, string plant, string shop,string cell)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<string> list = new List<string>();
            try
            {
                SqlCommand cmd = new SqlCommand(@"select distinct GroupID from [Group] where (CompanyID=@company or ISNULL(@company,'')='') and (PlantID=@plant or ISNULL(@plant,'')='') and (ShopID=@shop or ISNULL(@shop,'')='') and (CellID=@cell or ISNULL(@cell,'')='')
and EffectiveTodate='9999-12-31 00:00:00.000'", con);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@company", company);
                cmd.Parameters.AddWithValue("@plant", plant == "All" ? "" : plant);
                cmd.Parameters.AddWithValue("@shop", shop == "All" ? "" : shop);
                cmd.Parameters.AddWithValue("@cell", cell == "All" ? "" : cell);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        list.Add(sdr["GroupID"].ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("getGroupIDs: " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return list;
        }
        #endregion

        #region ----- Cell Maser Data -----
        internal static List<CellData> getCellMasterDetails(string company, string plant)
        {
            List<CellData> listData = new List<CellData>();
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            CellData data = null;
            try
            {
                SqlCommand cmd = new SqlCommand(@"[dbo].[s_Master_TPM_ShopCellGroup]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", company);
                cmd.Parameters.AddWithValue("@PlantID", plant);
                cmd.Parameters.AddWithValue("@Param", "View");
                cmd.Parameters.AddWithValue("@Type", "Cell");
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        data = new CellData();
                        data.CompanyID = sdr["CompanyID"].ToString();
                        data.PlantID = sdr["PlantID"].ToString();
                        data.CellId = sdr["CellID"].ToString();
                        data.CellDesc = sdr["CellName"].ToString();
                        data.EffectiveFromDate = sdr["EffectiveFromDate"].ToString();
                        data.EffectiveToDate = sdr["EffectiveToDate"].ToString();
                        listData.Add(data);
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("While getting Cell Master Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return listData;
        }
        internal static string checkCellEffectiveDate(CellData data)
        {
            string date = "";
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Master_TPM_ShopCellGroup]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", data.CompanyID);
                cmd.Parameters.AddWithValue("@PlantID", data.PlantID);
                cmd.Parameters.AddWithValue("@CellID", data.CellId);
                cmd.Parameters.AddWithValue("@CellName", data.CellDesc);
                cmd.Parameters.AddWithValue("@UpdatedTS", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@UpdatedBy", data.UpdatedBy);
                cmd.Parameters.AddWithValue("@EffectiveFromDate", Util.GetDateTime(data.EffectiveFromDate).ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@EffectiveToDate", Util.GetDateTime(data.EffectiveToDate).ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@Param", "DateValidation");
                cmd.Parameters.AddWithValue("@Type", "Cell");
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        date = sdr["EffectiveTodate"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("checkCellEffectiveDate:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return date;
        }
        internal static string insertUpdateCellMasterDetails(CellData data, string param1)
        {
            string success = "";
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Master_TPM_ShopCellGroup]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", data.CompanyID);
                cmd.Parameters.AddWithValue("@PlantID", data.PlantID);
                cmd.Parameters.AddWithValue("@CellID", data.CellId);
                cmd.Parameters.AddWithValue("@CellName", data.CellDesc);
                cmd.Parameters.AddWithValue("@UpdatedTS", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@UpdatedBy", data.UpdatedBy);
                cmd.Parameters.AddWithValue("@EffectiveFromDate", Util.GetDateTime(data.EffectiveFromDate).ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@EffectiveToDate", Util.GetDateTime(data.EffectiveToDate).ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@Param", "Save");
                cmd.Parameters.AddWithValue("@Type", "Cell");
                cmd.Parameters.AddWithValue("@Param1", param1);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        success = sdr["SaveFlag"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("while inserting or updating Cell master data:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return success;
        }
        internal static int deleteCellMasterDetails(CellData data)
        {
            int result = 0;
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Master_TPM_ShopCellGroup]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", data.CompanyID);
                cmd.Parameters.AddWithValue("@PlantID", data.PlantID);
                cmd.Parameters.AddWithValue("@CellID", data.CellId);
                cmd.Parameters.AddWithValue("@EffectiveFromDate", Util.GetDateTime(data.EffectiveFromDate).ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@EffectiveToDate", Util.GetDateTime(data.EffectiveToDate).ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@Param", "Delete");
                cmd.Parameters.AddWithValue("@Type", "Cell");
                result = cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("while deleting Cell  master data:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return result;
        }
        #endregion

        #region ----- Cell Group Maser Data -----
        internal static List<CellData> getCellGroupMasterDetails(string company, string plant, string cellID)
        {
            List<CellData> listData = new List<CellData>();
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            CellData data = null;
            try
            {
                SqlCommand cmd = new SqlCommand(@"[dbo].[s_Master_TPM_ShopCellGroup]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", company);
                cmd.Parameters.AddWithValue("@PlantID", plant);
                cmd.Parameters.AddWithValue("@CellID", cellID);
                cmd.Parameters.AddWithValue("@Param", "View");
                cmd.Parameters.AddWithValue("@Type", "CellGroup");
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        data = new CellData();
                        data.CompanyID = sdr["CompanyID"].ToString();
                        data.PlantID = sdr["PlantID"].ToString();
                        data.CellId = sdr["CellID"].ToString();
                        data.GroupID = sdr["GroupID"].ToString();
                        data.GroupDesc = sdr["GroupName"].ToString();
                        data.EffectiveFromDate = sdr["EffectiveFromDate"].ToString();
                        data.EffectiveToDate = sdr["EffectiveTodate"].ToString();
                        listData.Add(data);
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("While getting Cell Group Master Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return listData;
        }
        internal static string checkCellGroupEffectiveDate(CellData data)
        {
            string date = "";
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Master_TPM_ShopCellGroup]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", data.CompanyID);
                cmd.Parameters.AddWithValue("@PlantID", data.PlantID);
                cmd.Parameters.AddWithValue("@CellID", data.CellId);
                cmd.Parameters.AddWithValue("@GroupID", data.GroupID);
                cmd.Parameters.AddWithValue("@GroupName", data.GroupDesc);
                cmd.Parameters.AddWithValue("@UpdatedTS", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@UpdatedBy", data.UpdatedBy);
                cmd.Parameters.AddWithValue("@EffectiveFromDate", Util.GetDateTime(data.EffectiveFromDate).ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@EffectiveToDate", Util.GetDateTime(data.EffectiveToDate).ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@Param", "DateValidation");
                cmd.Parameters.AddWithValue("@Type", "CellGroup");
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        date = sdr["EffectiveTodate"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("checkCellGroupEffectiveDate:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return date;
        }
        internal static string insertUpdateCellGroupMasterDetails(CellData data, string param1)
        {
            string success = "";
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Master_TPM_ShopCellGroup]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", data.CompanyID);
                cmd.Parameters.AddWithValue("@PlantID", data.PlantID);
                cmd.Parameters.AddWithValue("@CellID", data.CellId);
                cmd.Parameters.AddWithValue("@GroupID", data.GroupID);
                cmd.Parameters.AddWithValue("@GroupName", data.GroupDesc);
                cmd.Parameters.AddWithValue("@UpdatedTS", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@UpdatedBy", data.UpdatedBy);
                cmd.Parameters.AddWithValue("@EffectiveFromDate", Util.GetDateTime(data.EffectiveFromDate).ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@EffectiveToDate", Util.GetDateTime(data.EffectiveToDate).ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@Param", "Save");
                cmd.Parameters.AddWithValue("@Type", "CellGroup");
                cmd.Parameters.AddWithValue("@Param1", param1);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        success = sdr["SaveFlag"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("while inserting or updating Cell Group master data:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return success;
        }
        internal static int deleteCellGroupMasterDetails(CellData data)
        {
            int result = 0;
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Master_TPM_ShopCellGroup]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", data.CompanyID);
                cmd.Parameters.AddWithValue("@PlantID", data.PlantID);
                cmd.Parameters.AddWithValue("@CellID", data.CellId);
                cmd.Parameters.AddWithValue("@GroupID", data.GroupID);
                cmd.Parameters.AddWithValue("@EffectiveFromDate", Util.GetDateTime(data.EffectiveFromDate).ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@EffectiveToDate", Util.GetDateTime(data.EffectiveToDate).ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@Param", "Delete");
                cmd.Parameters.AddWithValue("@Type", "CellGroup");
                result = cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("while deleting Cell Group master data:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return result;
        }
        #endregion
        #region ----- Plant Group Maser Data -----
        internal static List<CellData> getPlantGroupMasterDetails(string company, string plant, string groupSearch)
        {
            List<CellData> listData = new List<CellData>();
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            CellData data = null;
            try
            {
                SqlCommand cmd = new SqlCommand(@"[dbo].[s_Master_TPM_ShopCellGroup]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", company);
                cmd.Parameters.AddWithValue("@PlantID", plant=="All"?"":plant);
                cmd.Parameters.AddWithValue("@GroupID", groupSearch);
                cmd.Parameters.AddWithValue("@Param", "View");
                cmd.Parameters.AddWithValue("@Type", "PlantGroup");
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        data = new CellData();
                        data.CompanyID = sdr["CompanyID"].ToString();
                        data.PlantID = sdr["PlantID"].ToString();
                        data.GroupID = sdr["GroupID"].ToString();
                        data.GroupDesc = sdr["GroupName"].ToString();
                        data.EffectiveFromDate = sdr["EffectiveFromDate"].ToString();
                        data.EffectiveToDate = sdr["EffectiveToDate"].ToString();
                        listData.Add(data);
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("While getting Plant Group Master Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return listData;
        }
        internal static string checkGroupEffectiveDate(CellData data)
        {
            string date = "";
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Master_TPM_ShopCellGroup]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", data.CompanyID);
                cmd.Parameters.AddWithValue("@PlantID", data.PlantID);
                cmd.Parameters.AddWithValue("@GroupID", data.GroupID);
                cmd.Parameters.AddWithValue("@GroupName", data.GroupDesc);
                cmd.Parameters.AddWithValue("@UpdatedTS", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@UpdatedBy", data.UpdatedBy);
                cmd.Parameters.AddWithValue("@EffectiveFromDate", Util.GetDateTime(data.EffectiveFromDate).ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@EffectiveToDate", Util.GetDateTime(data.EffectiveToDate).ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@Param", "DateValidation");
                cmd.Parameters.AddWithValue("@Type", "PlantGroup");
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        date = sdr["EffectiveTodate"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("checkGroupEffectiveDate:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return date;
        }
        internal static string insertUpdatePlantGroupMasterDetails(CellData data, string param1)
        {
            string success = "";
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Master_TPM_ShopCellGroup]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", data.CompanyID);
                cmd.Parameters.AddWithValue("@PlantID", data.PlantID);
                cmd.Parameters.AddWithValue("@GroupID", data.GroupID);
                cmd.Parameters.AddWithValue("@GroupName", data.GroupDesc);
                cmd.Parameters.AddWithValue("@UpdatedTS", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@UpdatedBy", data.UpdatedBy);
                cmd.Parameters.AddWithValue("@EffectiveFromDate", Util.GetDateTime(data.EffectiveFromDate).ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@EffectiveToDate", Util.GetDateTime(data.EffectiveToDate).ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@Param", "Save");
                cmd.Parameters.AddWithValue("@Type", "PlantGroup");
                cmd.Parameters.AddWithValue("@Param1", param1);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        success = sdr["SaveFlag"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("while inserting or updating Plant Group master data:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return success;
        }
        internal static int deletePlantGroupMasterDetails(CellData data)
        {
            int result = 0;
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Master_TPM_ShopCellGroup]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", data.CompanyID);
                cmd.Parameters.AddWithValue("@PlantID", data.PlantID);
                cmd.Parameters.AddWithValue("@GroupID", data.GroupID);
                cmd.Parameters.AddWithValue("@EffectiveFromDate", Util.GetDateTime(data.EffectiveFromDate).ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@EffectiveToDate", Util.GetDateTime(data.EffectiveToDate).ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@Param", "Delete");
                cmd.Parameters.AddWithValue("@Type", "PlantGroup");
                result = cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("while deleting Plant Group  master data:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return result;
        }
        #endregion
        #region ----- Machine Master Details ---
        internal static List<MachineData> getMachineMasterDetails(string companyid,string searchMachineTxt,string type)
        {
            List<MachineData> listData = new List<MachineData>();
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            MachineData data = null;
            try
            {
                SqlCommand cmd = new SqlCommand(@"[dbo].[s_Masters_TPM_MachineInformation]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", companyid);
                cmd.Parameters.AddWithValue("@MachineID", searchMachineTxt);
                cmd.Parameters.AddWithValue("@Type", type);
                cmd.Parameters.AddWithValue("@Param", "View");
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        data = new MachineData();
                        data.CompanyID = sdr["CompanyID"].ToString();
                        data.MachineID = sdr["Machineid"].ToString();
                        if (type == "MachineInformation")
                        {
                            data.IOTID = sdr["IoTID"].ToString();
                            data.MachineDisplayName = sdr["MachineDisplayName"].ToString();
                            data.MachineType = sdr["MachineType"].ToString();
                            data.MachineMTB = sdr["MachineMTB"].ToString();
                            data.MachineModel = sdr["MachineModel"].ToString();
                            data.CNCMake = sdr["CNC_Make"].ToString();
                            data.CNCModel = sdr["CNC_Model"].ToString();
                            data.SerialNumber = sdr["SerialNumber"].ToString();
                            data.PLCMake = sdr["PLC_Make"].ToString();
                            data.PLCModel = sdr["PLC_Model"].ToString();
                            data.ControllerType = sdr["ControllerType"].ToString();
                        }
                        else if (type == "MachineCharacteristic")
                        {
                            data.Mchrrate = sdr["MachineHour_Rate"].ToString();
                            data.MachinewiseOwner = sdr["MachineOwner"].ToString();
                            data.OEETarget = sdr["OEE_Target"].ToString();
                            if (string.Equals(sdr["MultiSpindle_Flag"].ToString(), "true", StringComparison.OrdinalIgnoreCase))
                            {
                                data.MultiSpindleFlag = true;
                            }
                            else
                            {
                                data.MultiSpindleFlag = false;
                            }
                            data.AutoSetupChangeDown = sdr["Auto_Setup_ChangeDown"].ToString();
                            if (string.Equals(sdr["CriticalMachine_Enabled"].ToString(), "true", StringComparison.OrdinalIgnoreCase))
                            {
                                data.CriticalMachineEnabled = true;
                            }
                            else
                            {
                                data.CriticalMachineEnabled = false;
                            }
                            data.EffectiveFromDate = sdr["EffectiveFromDate"].ToString();
                            data.EffectiveToDate = sdr["EffectiveTodate"].ToString();
                        }
                        else if (type == "MachineSource")
                        {
                            data.InterfaceID = sdr["InterfaceId"].ToString();
                            data.IPAddress = sdr["IPAddress"].ToString();
                            data.IPPortNo = sdr["PortNumber"].ToString();
                            data.Protocol = sdr["Protocol"].ToString();
                            if (string.Equals(sdr["OEEEnabled"].ToString(), "true", StringComparison.OrdinalIgnoreCase))
                            {
                                data.OEEEnabled = true;
                            }
                            else
                            {
                                data.OEEEnabled = false;
                            }
                            if (string.Equals(sdr["CNC_Param_Enabled"].ToString(), "true", StringComparison.OrdinalIgnoreCase))
                            {
                                data.CNCParamEnabled = true;
                            }
                            else
                            {
                                data.CNCParamEnabled = false;
                            }
                            if (string.Equals(sdr["Energy_Enabled"].ToString(), "true", StringComparison.OrdinalIgnoreCase))
                            {
                                data.EneryEnabled = true;
                            }
                            else
                            {
                                data.EneryEnabled = false;
                            }
                            if (string.Equals(sdr["AGI_Enabled"].ToString(), "true", StringComparison.OrdinalIgnoreCase))
                            {
                                data.AGIEnabled = true;
                            }
                            else
                            {
                                data.AGIEnabled = false;
                            }
                            if (string.Equals(sdr["Device_Enabled"].ToString(), "true", StringComparison.OrdinalIgnoreCase))
                            {
                                data.DeviceEnabled = true;
                            }
                            else
                            {
                                data.DeviceEnabled = false;
                            }
                        }
                  
                        //data.IPAddress = sdr["IPAddress"].ToString();
                        //data.IPPortNo = sdr["IPPortNO"].ToString();
               
                       

                       
                        //if (sdr["DAPEnabled"].ToString() == "1")
                        //{
                        //    data.DAPEnabled = true;
                        //}
                        //else
                        //{
                        //    data.DAPEnabled = false;
                        //}
                        //if (string.Equals(sdr["EthernetEnabled"].ToString(), "true", StringComparison.OrdinalIgnoreCase))
                        //{
                        //    data.EthernetEnabled = true;
                        //}
                        //else
                        //{
                        //    data.EthernetEnabled = false;
                        //}
                        //if (string.Equals(sdr["Nto1Device"].ToString(), "true", StringComparison.OrdinalIgnoreCase))
                        //{
                        //    data.Nto1Device = true;
                        //}
                        //else
                        //{
                        //    data.Nto1Device = false;
                        //}
                        //data.DNCIP = sdr["DNCIP"].ToString();
                        //data.DNCIPPortNo = sdr["DNCIPPortNo"].ToString();
                        //if (sdr["DNCTransferEnabled"].ToString() == "1")
                        //{
                        //    data.DNCTransferEnabled = true;
                        //}
                        //else
                        //{
                        //    data.DNCTransferEnabled = false;
                        //}
                        //if (string.Equals(sdr["ProgramFoldersEnabled"].ToString(), "true", StringComparison.OrdinalIgnoreCase))
                        //{
                        //    data.ProgramFolderEnabled = true;
                        //}
                        //else
                        //{
                        //    data.ProgramFolderEnabled = false;
                        //}
                       
                        //if (string.Equals(sdr["AGIEnabled"].ToString(), "true", StringComparison.OrdinalIgnoreCase))
                        //{
                        //    data.AGIEnabled = true;
                        //}
                        //else
                        //{
                        //    data.AGIEnabled = false;
                        //}
                        //data.OPCUAURL = sdr["OPCUAURL"].ToString();
          
                        //data.OEETarget = sdr["OEETarget"].ToString();
                        //if (sdr["EnablePartCountByMacro"].ToString() == "1")
                        //{
                        //    data.EnablePartCountByMacro = true;
                        //}
                        //else
                        //{
                        //    data.EnablePartCountByMacro = false;
                        //}
                      
                        listData.Add(data);
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("While getting Machine Master Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return listData;

        }
        internal static string checkMachineEffectiveDate(MachineData data)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            string date = "";
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Masters_TPM_MachineInformation]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", data.CompanyID);
                cmd.Parameters.AddWithValue("@MachineID", data.MachineID);
                cmd.Parameters.AddWithValue("@EffectiveFromDate", Util.GetDateTime(data.EffectiveFromDate).ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@EffectiveToDate", Util.GetDateTime(data.EffectiveToDate).ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@Param", "DateValidation");
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        date = sdr["EffectiveTodate"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("checkMachineEffectiveDate:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return date;
        }
        internal static string insertUpdateMachineInfoMasterDetails_old(MachineData data, string param1)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            string success = "";
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Masters_TPM_MachineInformation]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", data.CompanyID);
                cmd.Parameters.AddWithValue("@MachineID", data.MachineID);
                cmd.Parameters.AddWithValue("@InterfaceID", data.InterfaceID);
                cmd.Parameters.AddWithValue("@MachineDisplayName", data.MachineDisplayName);
                cmd.Parameters.AddWithValue("@MachineType", data.MachineType);
                cmd.Parameters.AddWithValue("@MachineMTB", data.MachineMTB);
                cmd.Parameters.AddWithValue("@MachineModel", data.MachineModel);
                cmd.Parameters.AddWithValue("@CNCMake", data.CNCMake);
                cmd.Parameters.AddWithValue("@CNCModel", data.CNCModel);
                cmd.Parameters.AddWithValue("@IPAddress", data.IPAddress);
                cmd.Parameters.AddWithValue("@IPPortNO", data.IPPortNo);
                cmd.Parameters.AddWithValue("@Mchrrate", data.Mchrrate);
                if (data.TPMTrakEnabled)
                {
                    cmd.Parameters.AddWithValue("@TPMTrakEnabled", 1);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@TPMTrakEnabled", 0);
                }
                if (data.MultiSpindleFlag)
                {
                    cmd.Parameters.AddWithValue("@MultiSpindleFlag", 1);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@MultiSpindleFlag", 0);
                }
                cmd.Parameters.AddWithValue("@DeviceType", data.DeviceType);
                cmd.Parameters.AddWithValue("@MachinewiseOwner", data.MachinewiseOwner);
                if (data.CriticalMachineEnabled)
                {
                    cmd.Parameters.AddWithValue("@CriticalMachineEnabled", 1);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@CriticalMachineEnabled", 0);
                }
                if (data.DAPEnabled)
                {
                    cmd.Parameters.AddWithValue("@DAPEnabled", 1);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@DAPEnabled", 0);
                }
                if (data.EthernetEnabled)
                {
                    cmd.Parameters.AddWithValue("@EthernetEnabled", 1);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@EthernetEnabled", 0);
                }
                if (data.Nto1Device)
                {
                    cmd.Parameters.AddWithValue("@Nto1Device", 1);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@Nto1Device", 0);
                }
                cmd.Parameters.AddWithValue("@DNCIP", data.DNCIP);
                cmd.Parameters.AddWithValue("@DNCIPPortNo", data.DNCIPPortNo);
                if (data.DNCTransferEnabled)
                {
                    cmd.Parameters.AddWithValue("@DNCTransferEnabled", 1);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@DNCTransferEnabled", 0);
                }
                if (data.ProgramFolderEnabled)
                {
                    cmd.Parameters.AddWithValue("@ProgramFolderEnabled", 1);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@ProgramFolderEnabled", 0);
                }
                cmd.Parameters.AddWithValue("@AutoSetupchangeDown", data.AutoSetupChangeDown);
                if (data.AGIEnabled)
                {
                    cmd.Parameters.AddWithValue("@AGIEnabled", 1);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@AGIEnabled", 0);
                }
                cmd.Parameters.AddWithValue("@OPCUAURL", data.OPCUAURL);
                cmd.Parameters.AddWithValue("@ControllerType", data.ControllerType);
                cmd.Parameters.AddWithValue("@SerialNumber", data.SerialNumber);
                cmd.Parameters.AddWithValue("@OEETarget", data.OEETarget);
                if (data.EnablePartCountByMacro)
                {
                    cmd.Parameters.AddWithValue("@EnablePartCountByMacro", 1);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@EnablePartCountByMacro", 0);
                }
                cmd.Parameters.AddWithValue("@UpdatedTS", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@UpdatedBy", data.UpdatedBy);
                cmd.Parameters.AddWithValue("@EffectiveFromDate", Util.GetDateTime(data.EffectiveFromDate).ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@EffectiveToDate", Util.GetDateTime(data.EffectiveToDate).ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@Param", "Save");
                cmd.Parameters.AddWithValue("@Param1", param1);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        success = sdr["SaveFlag"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("while inserting or updating machine master data:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return success;
        }

        internal static string insertUpdateMachineInfoMasterDetails(MachineData data, string param1,string type)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            string success = "";
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Masters_TPM_MachineInformation]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", data.CompanyID);
                cmd.Parameters.AddWithValue("@MachineID", data.MachineID);
                if (type == "MachineInformation")
                {
                    cmd.Parameters.AddWithValue("@IotId", data.IOTID);
                    cmd.Parameters.AddWithValue("@MachineDisplayName", data.MachineDisplayName);
                    cmd.Parameters.AddWithValue("@MachineType", data.MachineType);
                    cmd.Parameters.AddWithValue("@MachineMTB", data.MachineMTB);
                    cmd.Parameters.AddWithValue("@MachineModel", data.MachineModel);
                    cmd.Parameters.AddWithValue("@CNC_Make", data.CNCMake);
                    cmd.Parameters.AddWithValue("@CNC_Model", data.CNCModel);
                    cmd.Parameters.AddWithValue("@PLC_Make", data.PLCMake);
                    cmd.Parameters.AddWithValue("@PLC_Model", data.PLCModel);
                    cmd.Parameters.AddWithValue("@ControllerType", data.ControllerType);
                    cmd.Parameters.AddWithValue("@SerialNumber", data.SerialNumber);
                }

                if (type == "MachineCharacteristic")
                {
                    cmd.Parameters.AddWithValue("@MachineHour_Rate", data.Mchrrate);
                    if (data.MultiSpindleFlag)
                    {
                        cmd.Parameters.AddWithValue("@MultiSpindle_Flag", 1);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@MultiSpindle_Flag", 0);
                    }
                    cmd.Parameters.AddWithValue("@MachineOwner", data.MachinewiseOwner);
                    if (data.CriticalMachineEnabled)
                    {
                        cmd.Parameters.AddWithValue("@CriticalMachine_Enabled", 1);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@CriticalMachine_Enabled", 0);
                    }
                    cmd.Parameters.AddWithValue("@Auto_Setup_ChangeDown", data.AutoSetupChangeDown);
                    cmd.Parameters.AddWithValue("@OEE_Target", data.OEETarget);
                    cmd.Parameters.AddWithValue("@EffectiveFromDate", Util.GetDateTime(data.EffectiveFromDate).ToString("yyyy-MM-dd HH:mm:ss"));
                    cmd.Parameters.AddWithValue("@EffectiveToDate", Util.GetDateTime(data.EffectiveToDate).ToString("yyyy-MM-dd HH:mm:ss"));
                }

                if (type == "MachineSource")
                {
                    cmd.Parameters.AddWithValue("@IPAddress", data.IPAddress);
                    cmd.Parameters.AddWithValue("@PortNumber", data.IPPortNo);
                    cmd.Parameters.AddWithValue("@Protocol", data.Protocol);
                    cmd.Parameters.AddWithValue("@InterfaceId", data.InterfaceID);
                    if (data.OEEEnabled)
                    {
                        cmd.Parameters.AddWithValue("@OEEEnabled", 1);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@OEEEnabled", 0);
                    }
                    if (data.CNCParamEnabled)
                    {
                        cmd.Parameters.AddWithValue("@CNC_Param_Enabled", 1);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@CNC_Param_Enabled", 0);
                    }
                    if (data.EneryEnabled)
                    {
                        cmd.Parameters.AddWithValue("@Energy_Enabled", 1);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@Energy_Enabled", 0);
                    }
                    if (data.AGIEnabled)
                    {
                        cmd.Parameters.AddWithValue("@AGI_Enabled", 1);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@AGI_Enabled", 0);
                    }
                    if (data.DeviceEnabled)
                    {
                        cmd.Parameters.AddWithValue("@Device_Enabled", 1);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@Device_Enabled", 0);
                    }
                }


               
                //cmd.Parameters.AddWithValue("@UpdatedTS", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                //cmd.Parameters.AddWithValue("@UpdatedBy", data.UpdatedBy);
 
                cmd.Parameters.AddWithValue("@Param", "Save");
                cmd.Parameters.AddWithValue("@Type", type);
                int result=cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("while inserting or updating machine master data:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return success;
        }
        internal static int deleteMachineMasterDetails(MachineData data)
        {
            int result = 0;
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Masters_TPM_MachineInformation]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", data.CompanyID);
                cmd.Parameters.AddWithValue("@MachineID", data.MachineID);
                cmd.Parameters.AddWithValue("@EffectiveFromDate", Util.GetDateTime(data.EffectiveFromDate).ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@EffectiveToDate", Util.GetDateTime(data.EffectiveToDate).ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@Param", "Delete");
                result = cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("while deleting machine master data:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return result;
        }
        #endregion

        #region ------- Employee Master -----
        internal static List<string> getUserRole(string company)
        {
            List<string> list = new List<string>();
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            try
            {
                SqlCommand cmd = new SqlCommand(@"select distinct RoleName from CompanyRole where CompanyID=@company and EffectiveToDate='9999-12-31 00:00:00.000'", con);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@company", company);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        list.Add(sdr["RoleName"].ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("While getting Employee Role " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return list;
        }
        internal static string checkEmployeeEffectiveDate(UserData data)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            string date = "";
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Masters_TPM_UserRoleInformation]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CorporateID", data.CorporateID);
                cmd.Parameters.AddWithValue("@UserId", data.UserID);
                cmd.Parameters.AddWithValue("@EffectiveFromDate", Util.GetDateTime(data.EffectiveFromDate).ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@EffectiveToDate", Util.GetDateTime(data.EffectiveToDate).ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@Param", "DateValidation");
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        date = sdr["EffectiveTodate"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("checkEmployeeEffectiveDate: " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return date;
        }
        internal static string getCorporateIDForEmployee(string company, out bool isGroupUser)
        {
            string corpname = "";
            isGroupUser = false;
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            try
            {
                SqlCommand cmd = new SqlCommand(@"select Entity from Company where CompanyID=@company and EffectiveToDate='9999-12-31 00:00:00.000'", con);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@company", company);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        corpname = sdr["Entity"].ToString();    
                    }
                    if (corpname == "" || corpname == null)
                    {
                        corpname = company;
                    }
                    else
                    {
                        isGroupUser = true;
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("While getting Employee Corporate ID " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return corpname;
        }
        internal static List<UserData> getEmployeeMasterDetails(string companyid,string searchMachineTxt)
        {
            List<UserData> listData = new List<UserData>();
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            UserData data = null;
            try
            {
                SqlCommand cmd = new SqlCommand(@"[dbo].[s_Masters_TPM_UserRoleInformation]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@UserId", searchMachineTxt);
                cmd.Parameters.AddWithValue("@CompanyID", companyid);
                cmd.Parameters.AddWithValue("@Param", "View");
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        data = new UserData();
                        data.CorporateID = sdr["CorporateID"].ToString();
                        data.CompanyID = sdr["CompanyID"].ToString();
                        data.UserID = sdr["Userid"].ToString();
                        data.Username = sdr["UserName"].ToString();
                        if (string.Equals(sdr["IsGroupUser"].ToString(), "true", StringComparison.OrdinalIgnoreCase))
                        {
                            data.IsGroupUser = true;
                        }
                        else
                        {
                            data.IsGroupUser = false;
                        }
                        data.IOTID = sdr["IOTID"].ToString();
                        data.Address = sdr["Address"].ToString();
                        data.Password = sdr["Password"].ToString();
                        data.Email = sdr["Email"].ToString();
                        data.MobileNo = sdr["MobileNo"].ToString();
                        //byte[] bytes = (byte[])sdr["UserImage"];
                        //string strBase64 = Convert.ToBase64String(bytes);
                        //data.UserImageInBase64 = sdr["UserImage"].ToString();
                        data.UserImageInBase64 = "";
                        data.Role = sdr["Role"].ToString();
                        if (string.Equals(sdr["isEmployee"].ToString(), "1", StringComparison.OrdinalIgnoreCase))
                        {
                            data.IsEmployee = true;
                        }
                        else
                        {
                            string str = sdr["isEmployee"].ToString();
                            data.IsEmployee = false;
                        }
                        //data.EmployeeID = sdr["Employeeid"].ToString();
                        data.EffectiveFromDate = sdr["EffectiveFromDate"].ToString();
                        data.EffectiveToDate = sdr["EffectiveToDate"].ToString();
                        listData.Add(data);
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("While getting Employee Master Data " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return listData;
        }
        internal static string insertUpdateEmployeeInfoMasterDetails(UserData data, string param1)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            string success = "";
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Masters_TPM_UserRoleInformation]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CorporateID", data.CorporateID);
                cmd.Parameters.AddWithValue("@CompanyID", data.CompanyID);
                cmd.Parameters.AddWithValue("@UserId", data.UserID);
                cmd.Parameters.AddWithValue("@UserName", data.Username);
                cmd.Parameters.AddWithValue("@IsGroupUser", data.IsGroupUser);
                cmd.Parameters.AddWithValue("@IOTID", data.IOTID);
                cmd.Parameters.AddWithValue("@Address", data.Address);
                cmd.Parameters.AddWithValue("@Password", data.Password);
                cmd.Parameters.AddWithValue("@Email", data.Email);
                cmd.Parameters.AddWithValue("@MobileNO", data.MobileNo);
                //cmd.Parameters.AddWithValue("@UserImage", data.UserImage);
                cmd.Parameters.AddWithValue("@Role", data.Role);
                cmd.Parameters.AddWithValue("@IsEmployee", data.IsEmployee);
                //cmd.Parameters.AddWithValue("@EmployeeID", data.EmployeeID);
                cmd.Parameters.AddWithValue("@UpdatedTS", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@UpdatedBy", data.UpdatedBy);
                cmd.Parameters.AddWithValue("@EffectiveFromDate", Util.GetDateTime(data.EffectiveFromDate).ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@EffectiveToDate", Util.GetDateTime(data.EffectiveToDate).ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@Param", "Save");
                cmd.Parameters.AddWithValue("@Param1", param1);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        success = sdr["SaveFlag"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("while inserting or updating employee master data: " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return success;
        }
        internal static int deleteEmployeeMasterDetails(UserData data)
        {
            int result = 0;
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Masters_TPM_UserRoleInformation]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CorporateID", data.CorporateID);
                cmd.Parameters.AddWithValue("@UserId", data.UserID);
                cmd.Parameters.AddWithValue("@Role", data.Role);
                cmd.Parameters.AddWithValue("@EffectiveFromDate", Util.GetDateTime(data.EffectiveFromDate).ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@EffectiveToDate", Util.GetDateTime(data.EffectiveToDate).ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@Param", "Delete");
                result = cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("while deleting employee master data: " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return result;
        }
        #endregion

        #region -------- Level Heirarchy------------------
        internal static List<LevelHeirarchyDetails> getLevelHeirarchyDetails(LevelHeirarchyDetails inputdata)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<LevelHeirarchyDetails> dataList = new List<LevelHeirarchyDetails>();
            LevelHeirarchyDetails data = null;
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Masters_TPM_UserDefinedEntity]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", inputdata.CompanyID);
                cmd.Parameters.AddWithValue("@PlantID", inputdata.PlantID == "All" ? "" : inputdata.PlantID);
                cmd.Parameters.AddWithValue("@Param", "View");
                cmd.Parameters.AddWithValue("@Param1", "UserDefinedEntityMenu");
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        data = new LevelHeirarchyDetails();
                        data.CompanyID = sdr["CompanyID"].ToString();
                        data.PlantID = sdr["PlantID"].ToString();
                        data.KeyValue = sdr["KeyValue"].ToString();
                        data.EffectiveFromDate = Util.GetDateTime(sdr["EffectiveFromDate"].ToString()).ToString("dd-MM-yyyy HH:mm:ss");
                        data.EffectiveToDate = Util.GetDateTime(sdr["EffectiveToDate"].ToString()).ToString("dd-MM-yyyy HH:mm:ss");
                        data.CheckOrUncheck = true;
                        dataList.Add(data);
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("getLevelHeirarchyDetails:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return dataList;
        }

        internal static int saveupdateLevelHeirarchyMenuDetails(LevelHeirarchyDetails data,string param)
        {
            int result = 0;
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Masters_TPM_UserDefinedEntity]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyId", data.CompanyID);
                cmd.Parameters.AddWithValue("@PlantID", data.PlantID);
                cmd.Parameters.AddWithValue("@KeyValue", data.KeyValue);
                cmd.Parameters.AddWithValue("@EffectiveFromDate", Util.GetDateTime(data.EffectiveFromDate).ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@EffectiveToDate", Util.GetDateTime(data.EffectiveToDate).ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@Param", param);
                cmd.Parameters.AddWithValue("@Param1", "UserDefinedEntityMenu");
                result = cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("saveupdateLevelHeirarchyMenuDetails:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return result;
        }
        internal static int saveupdateLevelHeirarchyDetails(LevelHeirarchyDetails data, string param)
        {
            int result = 0;
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Masters_TPM_UserDefinedEntity]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyId", data.CompanyID);
                cmd.Parameters.AddWithValue("@PlantID", data.PlantID);
                cmd.Parameters.AddWithValue("@KeyId", data.KeyID);
                cmd.Parameters.AddWithValue("@DisplayValue", data.DisplayValue);
                cmd.Parameters.AddWithValue("@EffectiveFromDate", Util.GetDateTime(data.EffectiveFromDate).ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@EffectiveToDate", Util.GetDateTime(data.EffectiveToDate).ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@UpdatedBy", HttpContext.Current.Session["Username"] == null ? "" : HttpContext.Current.Session["Username"].ToString());
                cmd.Parameters.AddWithValue("@UpdatedTS", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@Param", param);
                cmd.Parameters.AddWithValue("@Param1", "UserDefinedEntity");
                result = cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("saveupdateLevelHeirarchyDetails:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return result;
        }

        #region ----- Level Hierarchy -----
        internal static DataTable getLevelHierarchyData(string companyid)
        {
            DataTable dt = new DataTable();
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            try
            {
                SqlCommand cmd = new SqlCommand(@"select c.Entity,c.CompanyID,p.PlantID from Company c left join PlantInformation p on (c.CompanyID=p.CompanyID) where c.EffectiveToDate='9999-12-31 00:00:00.000'
and(p.EffectiveToDate = '9999-12-31 00:00:00.000' or p.EffectiveToDate is null) and (c.CompanyID=@CompanyID or isnull(@CompanyID,'')='')", con);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@CompanyID", companyid);
                sdr = cmd.ExecuteReader();
                dt.Load(sdr);
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("getLevelHierarchyData : " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return dt;
        }
        #endregion
        #endregion

        #region --------Assign Machines---------------
        //internal static DataTable getAllPlantForMachinePlantAssociationFilter(string company)
        //{
        //    SqlConnection con = ConnectionManager.GetConnection();
        //    DataTable dt = new DataTable();
        //    try
        //    {
        //        //SqlCommand cmd = new SqlCommand(@"[s_Masters_TPM_AssignMachines]", con);
        //        //cmd.CommandType = CommandType.StoredProcedure;
        //        //cmd.Parameters.AddWithValue("@CompanyId", company);
        //        //cmd.Parameters.AddWithValue("@Param", "View");
        //        //cmd.Parameters.AddWithValue("@Type", "PlantMachine");
        //        SqlCommand cmd = new SqlCommand(@"[s_Masters_TPM_AssignMachines]", con);
        //        cmd.CommandType = CommandType.Text
        //        cmd.Parameters.AddWithValue("@CompanyId", company);
        //        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        //        sda.Fill(dt);
        //    }
        //    catch (Exception ex)
        //    {
        //        Logger.WriteErrorLog("getAllMachinePlantAssociation - " + ex.Message);
        //    }
        //    finally
        //    {
        //        if (con != null) con.Close();
        //    }
        //    return dt;
        //}
        internal static DataTable getAllMachinePlantAssociation(string company,string machine,string plant)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            DataTable dt = new DataTable();
            try
            {
                SqlCommand cmd = new SqlCommand(@"[s_Masters_TPM_AssignMachines]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyId", company);
                cmd.Parameters.AddWithValue("@DPlantID", plant);
                cmd.Parameters.AddWithValue("@MachineId", machine);
                cmd.Parameters.AddWithValue("@Param", "View");
                cmd.Parameters.AddWithValue("@Type", "PlantMachine");
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                sda.Fill(dt);
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("getAllMachinePlantAssociation - " + ex.Message);
            }
            finally
            {
                if (con != null) con.Close();
            }
            return dt;
        }
        internal static void saveUpdateAssignMachineToPlantDetails(MachineAssignDetails data)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            int success = 0;
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Masters_TPM_AssignMachines]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyId", data.CompanyID == "None" ? "" : data.CompanyID);
                cmd.Parameters.AddWithValue("@PlantId", data.PlantID);
                cmd.Parameters.AddWithValue("@MachineId", data.MachineID );
                cmd.Parameters.AddWithValue("@UpdatedBy", HttpContext.Current.Session["Username"] == null ? "" : HttpContext.Current.Session["Username"].ToString());
                cmd.Parameters.AddWithValue("@UpdatedTS", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@EffectiveFromDate", data.EffectiveFromDate);
                cmd.Parameters.AddWithValue("@EffectiveToDate", data.EffectiveToDate);
                cmd.Parameters.AddWithValue("@Param1",data.CheckOrUncheck );
                cmd.Parameters.AddWithValue("@Param", "Save");
                cmd.Parameters.AddWithValue("@Type", "PlantMachine");
                success = cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("saveUpdateAssignMachineToPlantDetails:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
          //  return success;
        }

        internal static DataTable getAllMachineShopAssociation(string company,string plant,string shop,string cell, string type,string machine,string selectedcolumn)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            DataTable dt = new DataTable();
            try
            {
                SqlCommand cmd = new SqlCommand(@"[s_Masters_TPM_AssignMachines]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyId", company);
                cmd.Parameters.AddWithValue("@PlantId", plant);
                if (type == "ShopMachine")
                {
                    cmd.Parameters.AddWithValue("@DShopID", selectedcolumn);
                }
                if (type == "ShopCellMachine" || type=="CellMachine")
                {
                    cmd.Parameters.AddWithValue("@DCellID", selectedcolumn);
                }
                if (type == "ShopCellGroupMachine" || type == "ShopGroupMachine" || type == "CellGroupMachine" || type == "GroupMachine")
                {
                    cmd.Parameters.AddWithValue("@DGroupID", selectedcolumn);
                }
                cmd.Parameters.AddWithValue("@ShopId", shop);
                cmd.Parameters.AddWithValue("@CellId", cell);
              
                //cmd.Parameters.AddWithValue("@CellId", cell);
                cmd.Parameters.AddWithValue("@Param", "View");
                cmd.Parameters.AddWithValue("@Type", type);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                sda.Fill(dt);
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("getAllMachineShopAssociation - " + ex.Message);
            }
            finally
            {
                if (con != null) con.Close();
            }
            return dt;
        }

        internal static void saveUpdateAssignMachineToShopDetails(MachineAssignDetails data)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            int success = 0;
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Masters_TPM_AssignMachines]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyId", data.CompanyID == "None" ? "" : data.CompanyID);
                cmd.Parameters.AddWithValue("@PlantId", data.PlantID);
                cmd.Parameters.AddWithValue("@MachineId", data.MachineID);
                cmd.Parameters.AddWithValue("@ShopId", data.ShopID);
                cmd.Parameters.AddWithValue("@CellId", data.CellID);
                cmd.Parameters.AddWithValue("@GroupId", data.GroupID);
                cmd.Parameters.AddWithValue("@UpdatedBy", HttpContext.Current.Session["Username"] == null ? "" : HttpContext.Current.Session["Username"].ToString());
                cmd.Parameters.AddWithValue("@UpdatedTS", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@EffectiveFromDate", data.EffectiveFromDate);
                cmd.Parameters.AddWithValue("@EffectiveToDate", data.EffectiveToDate);
                cmd.Parameters.AddWithValue("@Param1", data.CheckOrUncheck);
                cmd.Parameters.AddWithValue("@Param", "Save");
                cmd.Parameters.AddWithValue("@Type", data.Type);
                success = cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("saveUpdateAssignMachineToShopDetails:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
              //return success;
        }
        #endregion

        #region -----Role Details ----
        internal static List<RoleDetails> getRoleDetails(RoleDetails inputdata)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<RoleDetails> dataList = new List<RoleDetails>();
            RoleDetails data = null;
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Masters_TPM_CompanyRoleInformation]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", inputdata.CompanyID);
                cmd.Parameters.AddWithValue("@RoleName", inputdata.RoleName);
                cmd.Parameters.AddWithValue("@Param", "View");
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        data = new RoleDetails();
                        data.CompanyID = sdr["CompanyID"].ToString();
                        data.RoleName = sdr["RoleName"].ToString();
                        data.RoleID = sdr["RoleID"].ToString();
                        data.EffectiveFromDate = Util.GetDateTime(sdr["EffectiveFromDate"].ToString()).ToString("dd-MM-yyyy HH:mm:ss");
                        data.EffectiveToDate = Util.GetDateTime(sdr["EffectiveToDate"].ToString()).ToString("dd-MM-yyyy HH:mm:ss");
                        dataList.Add(data);
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("getRoleDetails:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return dataList;
        }
        internal static string checkRoleEffectiveDate(RoleDetails data)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            string date = "";
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Masters_TPM_CompanyRoleInformation]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", data.CompanyID == "None" ? "" : data.CompanyID);
                cmd.Parameters.AddWithValue("@RoleId", data.RoleID);
                cmd.Parameters.AddWithValue("@RoleName", data.RoleName);
                cmd.Parameters.AddWithValue("@UpdatedBy", data.UpdatedBy);
                cmd.Parameters.AddWithValue("@UpdatedTS",data.UpdatedTS);
                cmd.Parameters.AddWithValue("@EffectiveFromDate", data.EffectiveFromDate);
                cmd.Parameters.AddWithValue("@EffectiveToDate", data.EffectiveToDate);
                cmd.Parameters.AddWithValue("@Param1", data.NewOrEditParam == "New" ? "" : data.NewOrEditParam);
                cmd.Parameters.AddWithValue("@Param", "DateValidation");

                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        date = sdr["EffectiveTodate"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("checkRoleEffectiveDate:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return date;
        }
        internal static string saveUpdateRoleDetails(RoleDetails data)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            string success = "";
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Masters_TPM_CompanyRoleInformation]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", data.CompanyID == "None" ? "" : data.CompanyID);
                cmd.Parameters.AddWithValue("@RoleId", data.RoleID);
                cmd.Parameters.AddWithValue("@RoleName", data.RoleName);
                cmd.Parameters.AddWithValue("@UpdatedBy", data.UpdatedBy);
                cmd.Parameters.AddWithValue("@UpdatedTS",data.UpdatedTS);
                cmd.Parameters.AddWithValue("@EffectiveFromDate", data.EffectiveFromDate);
                cmd.Parameters.AddWithValue("@EffectiveToDate", data.EffectiveToDate);
                cmd.Parameters.AddWithValue("@Param1", data.NewOrEditParam == "New" ? "" : data.NewOrEditParam);
                cmd.Parameters.AddWithValue("@Param", "Save");

                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        success = sdr["SaveFlag"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("saveUpdateRoleDetails:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return success;
        }

        internal static int deleteRoleGroupDetails(RoleDetails data)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            int result = 0;
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Master_TPM_ShopCellGroup]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", data.CompanyID);
                cmd.Parameters.AddWithValue("@EffectiveFromDate", data.EffectiveFromDate);
                cmd.Parameters.AddWithValue("@EffectiveToDate", data.EffectiveToDate);
                cmd.Parameters.AddWithValue("@Param", "Delete");
                result = cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("deleteRoleGroupDetails:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return result;
        }
        #endregion

        #region -----User Role Rights---

        internal static DataTable getUserRoleRightsDetails(string company,string role)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            DataTable dt = new DataTable();
            try
            {
                SqlCommand cmd = new SqlCommand(@"[s_Masters_TPM_UserRoleRights]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", company);
              //  cmd.Parameters.AddWithValue("@Role", role=="All"?"":role);
                cmd.Parameters.AddWithValue("@Param", "View");
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                sda.Fill(dt);
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("getUserRoleRightsDetails - " + ex.Message);
            }
            finally
            {
                if (con != null) con.Close();
            }
            return dt;
        }
        internal static string saveUpdateUserRoleRightsDetails(UserRoleData data)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            string success = "";
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Masters_TPM_UserRoleRights]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", data.CompanyID);
                cmd.Parameters.AddWithValue("@Module", data.Module);
                cmd.Parameters.AddWithValue("@Screen", data.Screen);
                cmd.Parameters.AddWithValue("@Role", data.RoleID);
                cmd.Parameters.AddWithValue("@AccessType", data.Value);
                cmd.Parameters.AddWithValue("@UpdatedTS", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@Param", "Save");
                cmd.Parameters.AddWithValue("@Param1", data.CheckOrUncheck);
                cmd.ExecuteNonQuery();
              
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("saveUpdateUserRoleRightsDetails:  " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return success;
        }

        internal static void ShowHideActionColumnOfGrid(GridView gridView, bool isVisible)
        {
            foreach (DataControlField col in gridView.Columns)
            {
                if (col.HeaderText == "Action")
                {
                    col.Visible = isVisible;
                }
            }
        }

        internal static void ShowHideColumnOfGrid(GridView gridView, bool isVisible,string columnName)
        {
            foreach (DataControlField col in gridView.Columns)
            {
                if (col.HeaderText == columnName)
                {
                    col.Visible = isVisible;
                }
            }
        }

        internal static List<MenuShowHide> getMenuListForLoginUser(string company,string userid,string param)
        {
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            List<MenuShowHide> list = new List<MenuShowHide>();
            MenuShowHide data = null;
            try
            {
                SqlCommand cmd = new SqlCommand(@"[s_Masters_TPM_GetMenuBasedOnUserRights]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyId", company);
                cmd.Parameters.AddWithValue("@UserID", userid);
                cmd.Parameters.AddWithValue("@Param", param);

                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        data = new MenuShowHide();
                        data.Module = sdr["Module"].ToString();
                        data.Screen = sdr["Screen"].ToString();
                        data.Value = sdr[3].ToString();
                        if(data.Value=="Read" || data.Value == "Modify")
                        {
                            data.Visible = true;
                        }
                        else
                        {
                            data.Visible = false;
                        }
                        list.Add(data);
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("getMenuListForLoginUser - " + ex.Message);
            }
            finally
            {
                if (con != null) con.Close();
                if (sdr != null) { sdr.Close(); }
            }
            return list;
        }
        #endregion

        #region ----- User Rights Exception Master----
        internal static List<UserRoleData> getUserIDListForUserRightsException(string company, string role)
        {
            List<UserRoleData> list = new List<UserRoleData>();
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Masters_TPM_UserRightsExceptions]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", company);
                cmd.Parameters.AddWithValue("@Role", role);
                cmd.Parameters.AddWithValue("@Param", "Userlist");
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        UserRoleData data = new UserRoleData();
                        data.UserID = sdr["Userid"].ToString();
                        list.Add(data);
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("getUserIDListForUserRightsException " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return list;
        }
        internal static DataTable getUserRightsExceptionDetails(string company, string role, string useridlist)
        {
            DataTable dt = new DataTable();
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Masters_TPM_UserRightsExceptions]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CompanyID", company);
                cmd.Parameters.AddWithValue("@Role", role);
                cmd.Parameters.AddWithValue("@UserID", useridlist);
                cmd.Parameters.AddWithValue("@Param", "View");
                sdr = cmd.ExecuteReader();
                dt.Load(sdr);
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("while getting User Right Exception details " + ex.Message);

            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return dt;
        }
        internal static string insertUpdateUserRightExceptionDetails(UserRoleData data)
        {
            string result = "";
            SqlConnection con = ConnectionManager.GetConnection();
            SqlDataReader sdr = null;
            try
            {
                SqlCommand cmd = new SqlCommand("[dbo].[s_Masters_TPM_UserRightsExceptions]", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@UserID", data.UserID);
                cmd.Parameters.AddWithValue("@CompanyID", data.CompanyID);
                cmd.Parameters.AddWithValue("@Module", data.Module);
                cmd.Parameters.AddWithValue("@Screen", data.Screen);
                cmd.Parameters.AddWithValue("@AccessType", data.Value);
                cmd.Parameters.AddWithValue("@UpdatedTS", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.Parameters.AddWithValue("@Param", "Save");
                sdr = cmd.ExecuteReader();

            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("while inserting User Right Exception details: " + ex.Message);
            }
            finally
            {
                if (con != null) { con.Close(); }
                if (sdr != null) { sdr.Close(); }
            }
            return result;
        }
        #endregion
    }

}