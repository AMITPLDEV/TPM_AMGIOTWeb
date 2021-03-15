using MongoDB.Bson;
using NewProject.DataBaseAccess;
using NewProject.Model;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NewProject
{
    public partial class MachineDocuments : System.Web.UI.Page
    {
        static string appPath = HttpContext.Current.Server.MapPath("");
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindMachineModel();
                hdnDataView.Value = "ListView";
                BindMachineDocuments();
                List<string> listColumnName = new List<string>();
                listColumnName.Add("Machine Slno");
                listColumnName.Add("MTB");
                listColumnName.Add("Model Number");
                //listColumnName.Add("MTB Sl.No.");
                listColumnName.Add("Category");
                listColumnName.Add("Sub-Category");
                // listColumnName.Add("L3");
                listColumnName.Add("Version");
                listColumnName.Add("Updated By");
                listColumnName.Add("Updated TS");
                listColumnName.Add("Document");
                cblColumnSelector.DataSource = listColumnName;
                cblColumnSelector.DataBind();
                foreach (ListItem data in cblColumnSelector.Items)
                {
                    data.Selected = true;
                }
                // btnDownloadClick_Click(null, null);
            }
        }
        private void BindMachineModel()
        {

            try
            {
                ddlModel.DataSource = DBAccess.getMachineModelData("", "", "", "", "", "");
                ddlModel.DataBind();
                ddlModel.Items.Insert(0, "All");
                BindMachineSerialNumber();
            }
            catch (Exception ex)
            {

            }
        }
        private void BindMachineSerialNumber()
        {

            try
            {
                ddlMachineNumber.DataSource = DBAccess.getMachineSerialNumberData("", "", "", "", "", "", ddlModel.SelectedValue == "All" ? "" : ddlModel.SelectedValue);
                ddlMachineNumber.DataBind();
                ddlMachineNumber.Items.Insert(0, "All");
            }
            catch (Exception ex)
            {

            }
        }
        private string getDdlValue(DropDownList ddl)
        {
            string str = "";
            try
            {

                foreach (ListItem item in ddl.Items)
                {
                    str += "'" + item.Value + "',";
                }
                if (str.Length > 0)
                {
                    str = str.Remove(str.Length - 1);
                }
                // str += "]}";
            }
            catch (Exception ex)
            { }
            return str;
        }
        private string getISODate(string date)
        {
            //2020 - 10 - 22T04: 35:41.471Z
            DateTime datetime = Util.GetDateTime(date);
            string isodate = datetime.Year.ToString() + "-" + datetime.Month.ToString("00") + "-" + datetime.Day.ToString("00") + "T00:00:00Z";
            return isodate;
        }
        private string getISOToDate(string date)
        {
            //2020 - 10 - 22T04: 35:41.471Z
            DateTime datetime = Util.GetDateTime(date);
            string isodate = datetime.Year.ToString() + "-" + datetime.Month.ToString("00") + "-" + datetime.Day.ToString("00") + "T00:00:00Z";
            return isodate;
        }
        private void BindMachineDocuments()
        {
            try
            {
                hdnFieldIDForPB.Value = "";
                hdnColNameForPB.Value = "";
                hdnFileNameForPB.Value = "";
                string view = "nodate";
                string fromDate = "", toDate = "";
                if (txtFromDate.Text.Trim() == "" && txtFromDate.Text.Trim() == "")
                {
                    view = "nodate";

                }
                else
                {

                    if (txtFromDate.Text.Trim() == "")
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select From Date.');", true);
                        return;
                    }
                    if (txtToDate.Text.Trim() == "")
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select To Date.');", true);
                        return;
                    }
                    fromDate = txtFromDate.Text.Trim();
                    toDate = txtToDate.Text.Trim();
                    view = "date";
                }



                BsonArray model = new BsonArray();
                if (ddlModel.SelectedValue == "All")
                {
                    foreach (ListItem item in ddlModel.Items)
                    {
                        model.Add(item.Value);
                    }
                }
                else
                {
                    model.Add(ddlModel.SelectedValue);
                }
                BsonArray machineSlno = new BsonArray();
                if (ddlMachineNumber.SelectedValue == "All")
                {
                    foreach (ListItem item in ddlMachineNumber.Items)
                    {
                        machineSlno.Add(item.Value);
                    }
                }
                else
                {
                    machineSlno.Add(ddlMachineNumber.SelectedValue);
                }

                BsonArray category = new BsonArray();
                if (ddlCategory.SelectedValue == "All")
                {
                    foreach (ListItem item in ddlCategory.Items)
                    {
                        category.Add(item.Value);
                    }
                }
                else
                {
                    category.Add(ddlCategory.SelectedValue);
                }
                BsonArray subcategory = new BsonArray();
                if (ddlSubCategory.SelectedValue == "All")
                {
                    foreach (ListItem item in ddlSubCategory.Items)
                    {
                        subcategory.Add(item.Value);
                    }
                }
                else
                {
                    subcategory.Add(ddlSubCategory.SelectedValue);
                }

                List<eDocumentData> list = MongoDBAccess.getMachineDocumentsDetails(model, machineSlno, category, subcategory, fromDate, toDate, view);
                lvMachineDocs.DataSource = list;
                lvMachineDocs.DataBind();
                lvMachineDocsCardView.DataSource = list;
                lvMachineDocsCardView.DataBind();
            }
            catch (Exception ex)
            {

            }
        }
        public static byte[] concatByteArray(byte[] first, byte[] second)
        {
            return first.Concat(second).ToArray();
        }
        private MachineDocumentsData setAndGetData(string MachineID, string MTB, string MTBSeialNumber, string ModelNumber, string DocumentName)
        {
            MachineDocumentsData data = new MachineDocumentsData();
            data.MachineID = MachineID;
            data.MTB = MTB;
            data.MTBSeialNumber = MTBSeialNumber;
            data.ModelNumber = ModelNumber;
            data.FileName = DocumentName;


            return data;
        }

        public static string GetFilePath(string reportName)
        {
            string src;
            src = Path.Combine(appPath, "MachineFiles", reportName);
            return src;
        }
      
        protected void lnkFilename_Click(object sender, EventArgs e)
        {
            try
            {


                int rowIndex = Convert.ToInt32(((sender as LinkButton).NamingContainer as ListViewDataItem).DataItemIndex);
                string fileBase64 = (lvMachineDocs.Items[rowIndex].FindControl("hdnFileArrayString") as HiddenField).Value;
                string fileName = (lvMachineDocs.Items[rowIndex].FindControl("hdnFileName") as HiddenField).Value;
                hdnFileBase64Data.Value = fileBase64;
                hdnFileNameForDownload.Value = fileName;
                if (!string.IsNullOrEmpty(fileBase64))
                {
                    string filePathForDelete = Path.Combine(appPath, "MachineFiles");
                    Array.ForEach(Directory.GetFiles(filePathForDelete), File.Delete);
                    string filePathForInsert = GetFilePath(fileName);
                    byte[] fileByte = Convert.FromBase64String(fileBase64);
                    File.WriteAllBytes(filePathForInsert, fileByte);
                    iframeMachineDocs.Src = "MachineFiles/" + fileName + "#toolbar=0";

                }
                else
                {
                    iframeMachineDocs.Src = "";
                }
            }
            catch (Exception ex)
            {

            }
        }

        protected void btnDownloadFile_Click(object sender, EventArgs e)
        {
            try
            {
                if (Session["eDocDetailsForDownload"] != null)
                {
                    MachineDocumentsData data = Session["eDocDetailsForDownload"] as MachineDocumentsData;
                    if (!string.IsNullOrEmpty(data.FileName) && !string.IsNullOrEmpty(data.FileInBase64))
                    {
                        byte[] fileByte = Convert.FromBase64String(data.FileInBase64);
                        string filename = data.FileName;
                        Response.Clear();
                        MemoryStream ms = new MemoryStream(fileByte);
                        Response.ContentType = "application/" + data.FileExtension;
                        Response.AddHeader("content-disposition", "attachment;filename=" + filename);
                        Response.Buffer = true;
                        ms.WriteTo(Response.OutputStream);
                        Response.End();
                    }
                }
            }
            catch (Exception ex)
            {

            }
        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static MachineDocumentsData getFileNamePath(string fileId, string filenameStr, string colName)
        {
            string filePath = "";
            MachineDocumentsData data = new MachineDocumentsData();
            try
            {
                byte[] fileByte = null;
                string fileBase64 = "";
                fileByte = MongoDBAccess.getEDocFilesInByte(fileId, colName);
                if (fileByte != null)
                {
                    fileBase64 = Convert.ToBase64String(fileByte);
                }
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
                    // data.FileName = "MachineFiles/" + fileName + "#toolbar=0";
                    data.FileName = filenameStr;
                    data.FileInBase64 = fileBase64;
                    data.FileType = filetype;
                    data.FileExtension = extension;
                }
                else
                {
                    data.FileName = "";
                    data.FileInBase64 = "";
                    data.FileType = "";
                    data.FileExtension = "";
                }
            }
            catch (Exception ex)
            {
                data.FileName = "";
                data.FileInBase64 = "";
                data.FileType = "";
                data.FileExtension = "";
            }
            HttpContext.Current.Session["eDocDetailsForDownload"] = data;
            return data;
        }

        protected void btnView_Click(object sender, EventArgs e)
        {
            try
            {
                BindMachineDocuments();
            }
            catch(Exception ex)
            { }
        }

        protected void ddlModel_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                BindMachineSerialNumber();
            }
            catch (Exception ex)
            { }
        }
        //[System.Web.Services.WebMethod(EnableSession = true)]
        //public static string getFileNamePath(string fileArrayString,string filenameStr)
        //{
        //    string filePath = "";
        //    try
        //    {

        //        string fileBase64 = fileArrayString;
        //        string fileName = filenameStr;
        //       // hdnFileBase64Data.Value = fileBase64;
        //       // hdnFileNameForDownload.Value = fileName;
        //        if (!string.IsNullOrEmpty(fileBase64))
        //        {
        //            string filePathForDelete = Path.Combine(appPath, "MachineFiles");
        //            Array.ForEach(Directory.GetFiles(filePathForDelete), File.Delete);
        //            string filePathForInsert = GetFilePath(fileName);
        //            byte[] fileByte = Convert.FromBase64String(fileBase64);
        //            File.WriteAllBytes(filePathForInsert, fileByte);
        //            filePath = "MachineFiles/" + fileName + "#toolbar=0";

        //        }
        //        else
        //        {
        //            filePath = "";
        //        }
        //    }
        //    catch (Exception ex)
        //    {

        //    }
        //    return filePath;
        //}
    }
}