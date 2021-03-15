using MongoDB.Bson;
using NewProject.DataBaseAccess;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NewProject.Model;

namespace NewProject
{
    public partial class AlarmHistory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                ScriptManager.RegisterStartupScript(this, this.GetType(), "setActiveValue", "setActiveSubmenuValue();", true);
            }
        }
       
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<string> getCompanyDetails()
        {
            List<string> list = new List<string>();
            try
            {
                 list = DBAccess.getCompanyData();
            }
            catch(Exception ex)
            {

            }
            return list;
        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<string> getPlantDetails(string company)
        {
            List<string> list = new List<string>();
            try
            {
                list = DBAccess.getPlantData(company);
            }
            catch (Exception ex)
            {

            }
            return list;
        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<string> getMachineDetial(string company,string plant)
        {
            List<string> list = new List<string>();
            try
            {
                list = DBAccess.getMachineIDData(company,plant,"","","","","");
            }
            catch (Exception ex)
            {

            }
            return list;
        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<AlarmHistoryData> getCNCAlarmDetails(string company, string plant,string machine)
        {
            List<AlarmHistoryData> list = new List<AlarmHistoryData>();
            try
            {
                list =  MongoDBAccess.getCNCAlarmData(company, plant, machine);
            }
            catch (Exception ex)
            {

            }
            return list;
        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<AlarmHistoryData> getCNCAlarmSolutionDetails(string company, string plant, string machine,string alarmNum)
        {
            List<AlarmHistoryData> list = new List<AlarmHistoryData>();
            try
            {

                list = MongoDBAccess.getCNCAlarmSolutionData(company, plant, machine,  alarmNum);
                //var filter = "{'metadata.AlarmNo':'" + alarmNum + "','metadata.MTB':'" + mtb + "'}";
                //var dataset = _MongoDatabase.GetCollection<BsonDocument>("CNC&PreventiveAlarms.files").Find(filter).ToList();
                //int slno = 1;
                //foreach (var item in dataset)
                //{
                //    data = new AlarmHistoryData();
                //    BsonDocument metadata = item["metadata"].AsBsonDocument;
                //    data.AlarmNo = metadata["AlarmNo"].ToString();
                //    data.AlarmCause = metadata["Cause"].ToString();
                //    data.AlarmSolution = metadata["Solution"].ToString();
                //    data.SlNo = slno.ToString();
                //    list.Add(data);
                //    slno++;
                //}
            }
            catch (Exception ex)
            {

            }
            return list;
        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<AlarmHistoryData> getPreventiveAlarmDetails(string company, string plant, string machine)
        {
            List<AlarmHistoryData> list = new List<AlarmHistoryData>();
            try
            {
                list = MongoDBAccess.getPreventiveAlarmData(company, plant, machine);
            }
            catch (Exception ex)
            {

            }
            return list;
        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<AlarmHistoryData> getPredictiveAlarmDetails(string company, string plant, string machine)
        {
            List<AlarmHistoryData> list = new List<AlarmHistoryData>();
            AlarmHistoryData data = null;
            try
            {
                data = new AlarmHistoryData();
                data.AlarmNo = "1150";
                data.Message = "Check/Replace spindle belts";
                data.Duration = "Hour";
                data.HoursLeft = "0.00";
                data.Time = "100";
                list.Add(data);
                data = new AlarmHistoryData();
                data.AlarmNo = "1151";
                data.Message = "Check X-slide backlash";
                data.Duration = "Hour";
                data.HoursLeft = "145";
                data.Time = "40";
                list.Add(data);
            }
            catch (Exception ex)
            {

            }
            return list;
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<AlarmHistoryDocData> getFileInformation(string alarmNo,  string colName,string machineid,string company,string plant,string cncCause,string cncSolution)
        {
            List<AlarmHistoryDocData> listDoc = new List<AlarmHistoryDocData>();
            try
            {
                string mtb = DBAccess.getMTBForMachine(company,plant, machineid);
                List<AlarmHistoryDocData> documentIdList= MongoDBAccess.getAlarmHistoryDocumentList(alarmNo, colName, machineid, company, plant, cncCause, cncSolution,mtb);

                byte[] fileByte = null;
                foreach (var fileObjId in documentIdList)
                {
                    AlarmHistoryDocData data = new AlarmHistoryDocData();
                    string fileid = fileObjId.FileID;
                    string filenameStr = fileObjId.FileName;


                    string fileBase64 = "";
                    ObjectId id = new ObjectId(fileid);
                    Logger.WriteDebugLog("Download alarm doc File: Before: " + DateTime.Now);
                    fileByte = MongoDBAccess.getAlarmFilesInByte(fileid, colName);
                    Logger.WriteDebugLog("Download alarm doc File: After: " + DateTime.Now);
                    if (fileByte != null)
                    {
                        fileBase64 = Convert.ToBase64String(fileByte);
                    }
                    Logger.WriteDebugLog("Download eDoc File: After base64: " + DateTime.Now);
                    string fileName = filenameStr;
                    if (!string.IsNullOrEmpty(fileBase64))
                    {
                        string extension = "";
                        if (filenameStr != "")
                        {
                            var list = filenameStr.Split('.').ToList();
                            extension = list[list.Count - 1].ToLower();
                        }
                        string filetype = "";
                        if ((extension == "mp4") || (extension == "wmv") || (extension == "avi") || (extension == "mov") || (extension == "qt") || (extension == "yuv") || (extension == "mkv") || (extension == "webm") || (extension == "flv") || (extension == "ogg") || (extension == "gif"))
                        {
                            filetype = "video";
                        }
                        else if (extension == "png" || extension == "jpg" || extension == "tif" || extension == "tiff" || extension == "bmp" || extension == "jpeg" || extension == "gif" || extension == "eps" || extension == "tif" || extension == "tif" || extension == "tif")
                        {
                            filetype = "image";
                        }
                        else if (extension == "pdf")
                        {
                            filetype = "pdf";
                        }
                        else if (extension == "xlsx" || extension == "xlsm" || extension == "xlsb" || extension == "xltx" || extension == "xltm" || extension == "xls" || extension == "xlt" || extension == "xml" || extension == "xlam" || extension == "xlw" || extension == "xlr")
                        {
                            filetype = "excel";
                        }
                        else
                        {
                            filetype = "other";
                        }
                        data.FileName = filenameStr;
                        data.FileInBase64 = fileBase64;
                        data.FileType = filetype;
                        data.FileExtension = extension;
                        listDoc.Add(data);
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteDebugLog("Download alarm doc File: Error: " + DateTime.Now + "   --- " + ex.Message);
            }
            Logger.WriteDebugLog("Download alarm doc File: data return: " + DateTime.Now);
            return listDoc;
        }
    }
}