using NewProject.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MongoDB.Bson;
using MongoDB.Driver;
using System.IO;
using NewProject.DataBaseAccess;
using System.Reflection;

namespace NewProject
{
    public partial class MachineDocumentMaster : System.Web.UI.Page
    {

        static string appPath = HttpContext.Current.Server.MapPath("");
        List<string> listMachineType = new List<string>();
        List<string> listMachineModel = new List<string>();
        List<string> listMachineSlno = new List<string>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //foreach (ListItem item in lbMachineModelModelLvl.Items)
                //{
                //    item.Selected = true;
                //}
                //BindModelLevelData();
                //  BindMachine();
                btnCompanyLevel_Click(null, null);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "setActiveValue", "setActiveSubmenuValue();", true);
            }
            ReadOrModifyPage();
        }
        private void ReadOrModifyPage()
        {
            try
            {
                List<MenuShowHide> list = new List<MenuShowHide>();
                if (Session["ScreenShowHide"] == null)
                {
                    Session["ScreenShowHide"] = DBAccess.getMenuListForLoginUser(Session["CompanyName"].ToString(), Session["Username"].ToString(), "ScreenView");
                    list = (List<MenuShowHide>)Session["ScreenShowHide"];
                }
                else
                {
                    list = (List<MenuShowHide>)Session["ScreenShowHide"];
                }
                string accestype = list.Where(x => x.Screen == "eDocs").Select(x => x.Value).FirstOrDefault();
                if (accestype == "Read")
                {
                    btnSaveCompanyLvl.Visible = false;
                    btnDeleteCompanyLvl.Visible = false;
                    gvCompanyLevel.ShowFooter = false;
                    DBAccess.ShowHideColumnOfGrid(gvCompanyLevel, false, "Delete");

                    btnSaveModelLvl.Visible = false;
                    btnDeleteModelLvl.Visible = false;
                    gvModelLvlData.ShowFooter = false;
                    DBAccess.ShowHideColumnOfGrid(gvModelLvlData, false, "Delete");

                    btnSaveMachineLvl.Visible = false;
                    btnDeleteMachineLvl.Visible = false;
                    gvMachineLvlData.ShowFooter = false;
                    DBAccess.ShowHideColumnOfGrid(gvMachineLvlData, false, "Delete");
                }
                else
                {
                    btnSaveCompanyLvl.Visible = true;
                    btnDeleteCompanyLvl.Visible = true;
                    gvCompanyLevel.ShowFooter = true;
                    DBAccess.ShowHideColumnOfGrid(gvCompanyLevel, true, "Delete");

                    btnSaveModelLvl.Visible = true;
                    btnDeleteModelLvl.Visible = true;
                    gvModelLvlData.ShowFooter = true;
                    DBAccess.ShowHideColumnOfGrid(gvModelLvlData, true, "Delete");

                    btnSaveMachineLvl.Visible = true;
                    btnDeleteMachineLvl.Visible = true;
                    gvMachineLvlData.ShowFooter = true;
                    DBAccess.ShowHideColumnOfGrid(gvMachineLvlData, true, "Delete");
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        private void BindMachineType(DropDownList ddl, string mtb)
        {
            try
            {
                if (ddl == null)
                {
                    listMachineType = DBAccess.getMachineTypeData("", "", "", "", mtb);
                }
                else
                {
                    ddl.DataSource = listMachineType;
                    ddl.DataBind();
                }

            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        private void BindMachineModel(DropDownList ddl, string mtb, string machinetype)
        {
            try
            {
                if (ddl == null)
                {
                    listMachineModel = DBAccess.getMachineModelData("", "", "", "", mtb, machinetype);
                }
                else
                {
                    ddl.DataSource = listMachineModel;
                    ddl.DataBind();
                }

            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        private void BindMachineSlno(DropDownList ddl, string mtb, string machinetype, string machinemodel, string cncmake, string cncmodel)
        {
            try
            {
                if (ddl == null)
                {
                    listMachineSlno = DBAccess.getMachineSerialNumberData("", "", cncmake, cncmodel, mtb, machinetype, machinemodel);
                }
                else
                {
                    ddl.DataSource = listMachineSlno;
                    ddl.DataBind();
                }

            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        private void BindMTBData()
        {
            try
            {
                List<string> list = DBAccess.getMTBData("", "", "", "");
                ddlMTBCompanyLvl.DataSource = list;
                ddlMTBCompanyLvl.DataBind();
                ddlMTBModelLvl.DataSource = list;
                ddlMTBModelLvl.DataBind();
                ddlMTBMachineLvl.DataSource = list;
                ddlMTBMachineLvl.DataBind();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }

        private eDocumentData setGetModelData(string filename, string updatedby, string ts, string model, string version, string cat, string subcat)
        {
            eDocumentData data = new eDocumentData();
            data.Filename = filename;
            data.UpdatedBy = updatedby;
            data.UpdatedTS = ts;
            data.Model = model;
            data.Version = version;
            data.Category = cat;
            data.Subcategory = subcat;
            return data;
        }

        private void BindCompanyLevel()
        {
            try
            {
                string mtb = ddlMTBCompanyLvl.SelectedValue;
                List<eDocumentData> list = MongoDBAccess.getCompanyLvlEdocData(mtb);
                int listcountFlag = 0;
                if (list.Count == 0)
                {
                    listcountFlag = 1;
                    eDocumentData data = new eDocumentData();
                    list.Add(data);
                }
                Session["eDocMasterData"] = list;
                //list.Add(setGetModelData("EData Requirement AMGIoT.xlsx", "pct", "2020-10-01 10:01:00", "M1", "V1", "", ""));
                //list.Add(setGetModelData("HDCPY000.BMP", "pct", "2020-10-01 14:01:00", "M1", "V1", "", ""));
                //list.Add(setGetModelData("jquery-tips-and-tricks_0_0.mp4", "pct", "2020-10-01 12:00:00", "M1", "V2", "", ""));
                //list.Add(setGetModelData("OD Machine - Basics of Programming.pdf", "pct", "2020-10-02 17:01:00", "M1, M2", "V1", "", ""));

                gvCompanyLevel.DataSource = list;
                gvCompanyLevel.DataBind();
                if (listcountFlag == 1)
                {
                    gvCompanyLevel.Rows[0].Visible = false;
                }
                //(gvCompanyLevel.FooterRow.FindControl("txtDateOfDispatchNew") as TextBox).Text = DateTime.Now.ToString("dd-MM-yyyy");
                DropDownList ddl = new DropDownList();
                ddl = (gvCompanyLevel.FooterRow.FindControl("ddlCNCMakeNew") as DropDownList);
                ddl.DataSource = DBAccess.getCNCMakeData("", "");
                ddl.DataBind();
                string cncmake = ddl.SelectedValue;
                ddl = (gvCompanyLevel.FooterRow.FindControl("ddlCNCModelNew") as DropDownList);
                ddl.DataSource = DBAccess.getCNCModelData("", "", cncmake);
                ddl.DataBind();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        protected void btnCompanyLevel_Click(object sender, EventArgs e)
        {

            BindMTBData();
            BindCompanyLevel();
        }
        protected void btnInsertCompanyLvl_Click(object sender, EventArgs e)
        {
            try
            {
                string username = "";
                if (Session["Username"] != null)
                {
                    username = Session["Username"].ToString();
                }
                else
                {
                    Response.Redirect("~/LoginInitial", false);
                }

                eDocumentData data = new eDocumentData();
                data.MTB = ddlMTBCompanyLvl.SelectedValue;
                data.CNCMake = (gvCompanyLevel.FooterRow.FindControl("ddlCNCMakeNew") as DropDownList).SelectedValue;
                data.CNCModel = (gvCompanyLevel.FooterRow.FindControl("ddlCNCModelNew") as DropDownList).SelectedValue;
                data.Category = (gvCompanyLevel.FooterRow.FindControl("ddlCategoryNew") as DropDownList).SelectedValue;
                data.Subcategory = (gvCompanyLevel.FooterRow.FindControl("ddlSubCategoryNew") as DropDownList).SelectedValue;
                // data.CustomerName = (gvCompanyLevel.FooterRow.FindControl("txtCustomerNameNew") as TextBox).Text;
                // data.DateOfDispatchInDate = Util.GetDateTime((gvCompanyLevel.FooterRow.FindControl("txtDateOfDispatchNew") as TextBox).Text);
                data.Version = (gvCompanyLevel.FooterRow.FindControl("txtVersionNew") as TextBox).Text;
                data.UpdatedBy = username;
                FileUpload fileUpload = gvCompanyLevel.FooterRow.FindControl("fileUploddNew") as FileUpload;
                foreach (HttpPostedFile postedFile in fileUpload.PostedFiles)
                {
                    string fileName = Path.GetFileName(postedFile.FileName);
                    Stream fs = postedFile.InputStream;
                    BinaryReader br = new BinaryReader(fs);
                    byte[] bytes = br.ReadBytes((Int32)fs.Length);
                    //foreach (ListItem modelItem in lbModelModelLvl.Items)
                    //{
                    //    if (modelItem.Selected)
                    //    {
                    //        string model = modelItem.Value;
                    data.FileType = System.IO.Path.GetExtension(postedFile.FileName);
                    if (data.FileType.Length > 0)
                    {
                        data.FileType = data.FileType.Remove(0, 1);
                    }
                    data.Document = bytes;
                    data.Filename = fileName;
                    MongoDBAccess.uploadCompanyLvlEdocData(data);
                    // }
                    //}
                }
                BindCompanyLevel();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        protected void btnViewCompanyLvl_Click(object sender, EventArgs e)
        {
            // BindMTBData();
            BindCompanyLevel();
        }

        protected void btnSaveCompanyLvl_Click(object sender, EventArgs e)
        {
            try
            {
                string username = "";
                if (Session["Username"] != null)
                {
                    username = Session["Username"].ToString();
                }
                else
                {
                    Response.Redirect("~/LoginInitial", false);
                }
                eDocumentData data = new eDocumentData();
                for (int i = 0; i < gvCompanyLevel.Rows.Count; i++)
                {
                    FileUpload fileUpload = gvCompanyLevel.Rows[i].FindControl("fileUpload") as FileUpload;
                    data.MTB = (gvCompanyLevel.Rows[i].FindControl("hdnMTB") as HiddenField).Value;
                    data.CNCMake = (gvCompanyLevel.Rows[i].FindControl("lblCNCMake") as Label).Text;
                    data.CNCModel = (gvCompanyLevel.Rows[i].FindControl("lblCNCModel") as Label).Text;
                    data.Category = (gvCompanyLevel.Rows[i].FindControl("lblCategory") as Label).Text;
                    data.Subcategory = (gvCompanyLevel.Rows[i].FindControl("lblSubcategory") as Label).Text;
                    //data.CustomerName = (gvCompanyLevel.Rows[i].FindControl("lblCustomerName") as Label).Text;
                    // data.DateOfDispatchInDate = Util.GetDateTime((gvCompanyLevel.Rows[i].FindControl("lblDateOfDispatch") as Label).Text);
                    data.Version = (gvCompanyLevel.Rows[i].FindControl("lblVersion") as Label).Text;
                    data.UpdatedBy = username;
                    data.FileID = (gvCompanyLevel.Rows[i].FindControl("hdnFileID") as HiddenField).Value;
                    string version = (gvCompanyLevel.Rows[i].FindControl("lblVersion") as Label).Text;
                    if (fileUpload.HasFile)
                    {
                        foreach (HttpPostedFile postedFile in fileUpload.PostedFiles)
                        {

                            string fileName = Path.GetFileName(postedFile.FileName);
                            Stream fs = postedFile.InputStream;
                            BinaryReader br = new BinaryReader(fs);
                            byte[] bytes = br.ReadBytes((Int32)fs.Length);
                            MongoDBAccess.deleteEdocData(data.FileID, "MTBLeveleDoc");
                            data.FileType = System.IO.Path.GetExtension(postedFile.FileName);
                            if (data.FileType.Length > 0)
                            {
                                data.FileType = data.FileType.Remove(0, 1);
                            }
                            data.Document = bytes;
                            data.Filename = fileName;
                            MongoDBAccess.uploadCompanyLvlEdocData(data);

                        }
                    }
                }
                BindCompanyLevel();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }

        }

        protected void btnDeleteCompanyLvl_Click(object sender, EventArgs e)
        {
            try
            {
                for (int i = 0; i < gvCompanyLevel.Rows.Count; i++)
                {
                    CheckBox chk = (gvCompanyLevel.Rows[i].FindControl("chkDeleteSelection") as CheckBox);
                    if (chk.Checked)
                    {
                        string id = (gvCompanyLevel.Rows[i].FindControl("hdnFileID") as HiddenField).Value;
                        MongoDBAccess.deleteCompanyLvlEdocData(id);
                    }
                }
                BindCompanyLevel();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        private ProcessParameterMasterData setGetProcessData(string MachineID, string MachineType, string MTB, string MachineModel, string ParemeterID, string SourceType, string SourceAdd1, string SourceAdd2, string SourceDatatype1, string SourceDatatype2, string PollingFrequency, string DataGroup, string PollingType, string CycleFreqTime, string NoOfCycle, bool IsEnabled, bool ShouldNotBeDisabled, string CNCMake, string CNCModel, bool IsEnabledForDataRead)
        {
            ProcessParameterMasterData data = new ProcessParameterMasterData();
            data.MachineID = MachineID;
            data.MachineType = MachineType;
            data.MTB = MTB;
            data.MachineModel = MachineModel;
            data.ParemeterID = ParemeterID;
            data.SourceType = SourceType;
            data.SourceAdd1 = SourceAdd1;
            data.SourceAdd2 = SourceAdd2;
            data.SourceDatatype1 = SourceDatatype1;
            data.SourceDatatype2 = SourceDatatype2;
            data.PollingFrequency = PollingFrequency;
            data.DataGroup = DataGroup;
            data.PollingType = PollingType;
            data.CycleFreqTime = CycleFreqTime;
            data.NoOfCycle = NoOfCycle;
            data.IsEnabled = IsEnabled;
            data.ShouldNotBeDisabled = ShouldNotBeDisabled;
            data.CNCModel = CNCModel;
            data.CNCMake = CNCMake;
            data.IsEnabledForDataRead = IsEnabledForDataRead;
            return data;
        }
        private void setDropdownValues(string param)
        {
            BindMachineType(null, "");
            BindMachineModel(null, "", "");
            if (param == "machine")
            {
                BindMachineSlno(null, "", "", "", "", "");
            }
        }
        private void BindModelLevelData()
        {
            try
            {
                //string modellist = "";
                //foreach (ListItem item in lbMachineModelModelLvl.Items)
                //{
                //    if (item.Selected)
                //    {
                //        modellist += "'" + item.Value + "',";
                //    }
                //}
                //if (modellist.Length > 0)
                //{
                //    modellist = modellist.Remove(modellist.Length - 1);
                //}
                string mtb = ddlMTBModelLvl.SelectedValue;
                string model = ddlMachineModelModelLvl.SelectedValue;
                BsonArray levelView = new BsonArray();
                if (ddlModelLevelView.SelectedValue == "All")
                {
                    foreach (ListItem item in ddlModelLevelView.Items)
                    {
                        levelView.Add(item.Value);
                    }
                }
                else
                {
                    levelView.Add(ddlModelLevelView.SelectedValue);
                }

                List<eDocumentData> list = MongoDBAccess.getModelLvlEdocData(mtb, model, levelView);
                int listcountFlag = 0;
                if (list.Count == 0)
                {
                    listcountFlag = 1;
                    eDocumentData data = new eDocumentData();
                    list.Add(data);
                }
                Session["eDocMasterData"] = list;
                gvModelLvlData.DataSource = list;
                gvModelLvlData.DataBind();
                if (listcountFlag == 1)
                {
                    gvModelLvlData.Rows[0].Visible = false;
                }
                // (gvModelLvlData.FooterRow.FindControl("txtDateOfDispatchNew") as TextBox).Text = DateTime.Now.ToString("dd-MM-yyyy");
                DropDownList ddl = new DropDownList();
                ddl = (gvModelLvlData.FooterRow.FindControl("ddlCNCMakeNew") as DropDownList);
                ddl.DataSource = DBAccess.getCNCMakeData("", "");
                ddl.DataBind();
                string cncMake = ddl.SelectedValue;
                (gvModelLvlData.FooterRow.FindControl("hdnSelectedCNCMake") as HiddenField).Value = cncMake;
                ddl = (gvModelLvlData.FooterRow.FindControl("ddlCNCModelNew") as DropDownList);
                ddl.DataSource = DBAccess.getCNCModelData("", "", cncMake);
                ddl.DataBind();
                string cncModel = ddl.SelectedValue;
                (gvModelLvlData.FooterRow.FindControl("hdnSelectedCNCModel") as HiddenField).Value = cncModel;
                ddl = (gvModelLvlData.FooterRow.FindControl("ddlMachineType") as DropDownList);
                //ddl.DataSource = DBAccess.getMachineTypeData("", "", cncMake, cncModel, ddlMTBModelLvl.SelectedValue);
                ddl.DataSource = DBAccess.getMachineTypeData("", "", "", "", ddlMTBModelLvl.SelectedValue);
                ddl.DataBind();
                (gvModelLvlData.FooterRow.FindControl("hdnSelectedMachineType") as HiddenField).Value = ddl.SelectedValue;
                string machineType = ddl.SelectedValue;
                ddl = (gvModelLvlData.FooterRow.FindControl("ddlMachineModel") as DropDownList);
                //ddl.DataSource = DBAccess.getMachineModelData("", "", cncMake, cncModel, ddlMTBModelLvl.SelectedValue, machineType);
                ddl.DataSource = DBAccess.getMachineModelData("", "", "", "", ddlMTBModelLvl.SelectedValue, machineType);
                ddl.DataBind();
                (gvModelLvlData.FooterRow.FindControl("hdnSelectedMachineModel") as HiddenField).Value = ddl.SelectedValue;
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        protected void btnInsertModelLvl_Click(object sender, EventArgs e)
        {
            try
            {
                string username = "";
                if (Session["Username"] != null)
                {
                    username = Session["Username"].ToString();
                }
                else
                {
                    Response.Redirect("~/LoginInitial", false);
                }

                eDocumentData data = new eDocumentData();
                data.MTB = ddlMTBModelLvl.SelectedValue;
                data.CNCMake = (gvModelLvlData.FooterRow.FindControl("hdnSelectedCNCMake") as HiddenField).Value;
                data.CNCModel = (gvModelLvlData.FooterRow.FindControl("hdnSelectedCNCModel") as HiddenField).Value;
                //data.CNCMake = (gvModelLvlData.FooterRow.FindControl("ddlCNCMakeNew") as DropDownList).SelectedValue;
                //data.CNCModel = (gvModelLvlData.FooterRow.FindControl("ddlCNCModelNew") as DropDownList).SelectedValue;
                //data.MachineType = (gvModelLvlData.FooterRow.FindControl("ddlMachineType") as DropDownList).SelectedValue;
                //data.MachineModel = (gvModelLvlData.FooterRow.FindControl("ddlMachineModel") as DropDownList).SelectedValue;
                data.MachineType = (gvModelLvlData.FooterRow.FindControl("hdnSelectedMachineType") as HiddenField).Value;
                data.MachineModel = (gvModelLvlData.FooterRow.FindControl("hdnSelectedMachineModel") as HiddenField).Value;
                data.Category = (gvModelLvlData.FooterRow.FindControl("ddlCategoryNew") as DropDownList).SelectedValue;
                data.Subcategory = (gvModelLvlData.FooterRow.FindControl("ddlSubCategoryNew") as DropDownList).SelectedValue;
                // data.CustomerName = (gvModelLvlData.FooterRow.FindControl("txtCustomerNameNew") as TextBox).Text;
                // data.DateOfDispatchInDate = Util.GetDateTime((gvModelLvlData.FooterRow.FindControl("txtDateOfDispatchNew") as TextBox).Text);
                data.Version = (gvModelLvlData.FooterRow.FindControl("txtVersionNew") as TextBox).Text;
                data.UpdatedBy = username;
                FileUpload fileUpload = gvModelLvlData.FooterRow.FindControl("fileUploddNew") as FileUpload;
                foreach (HttpPostedFile postedFile in fileUpload.PostedFiles)
                {
                    string fileName = Path.GetFileName(postedFile.FileName);
                    Stream fs = postedFile.InputStream;
                    BinaryReader br = new BinaryReader(fs);
                    byte[] bytes = br.ReadBytes((Int32)fs.Length);
                    data.FileType = System.IO.Path.GetExtension(postedFile.FileName);
                    if (data.FileType.Length > 0)
                    {
                        data.FileType = data.FileType.Remove(0, 1);
                    }
                    data.Filename = fileName;
                    data.Document = bytes;
                    MongoDBAccess.uploadModelLvlEdocData(data);

                }
                BindModelLevelData();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        protected void btnDeleteModelLvl_Click(object sender, EventArgs e)
        {
            try
            {
                for (int i = 0; i < gvModelLvlData.Rows.Count; i++)
                {
                    CheckBox chk = (gvModelLvlData.Rows[i].FindControl("chkDeleteSelection") as CheckBox);
                    if (chk.Checked)
                    {

                        string id = (gvModelLvlData.Rows[i].FindControl("hdnFileID") as HiddenField).Value;
                        MongoDBAccess.deleteModelLvlEdocData(id);
                    }
                }
                BindModelLevelData();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        protected void btnViewModelLvl_Click(object sender, EventArgs e)
        {

            BindModelLevelData();
        }

        protected void btnSaveModelLvl_Click(object sender, EventArgs e)
        {
            try
            {
                string username = "";
                if (Session["Username"] != null)
                {
                    username = Session["Username"].ToString();
                }
                else
                {
                    Response.Redirect("~/LoginInitial", false);
                }

                //GridFSBucketOptions op = new GridFSBucketOptions();
                //op.BucketName = "ModelLeveleDoc";
                //GridFSBucketOptions gridFsOption = null;
                //IGridFSBucket bucket = null;

                ////create MTB Lvl bucket
                //GridFSBucketOptions opMTBLvl = new GridFSBucketOptions();
                //opMTBLvl.BucketName = "MTBLeveleDoc";
                //GridFSBucketOptions gridFsOptionMTBLvl = new GridFSBucketOptions(opMTBLvl);
                //IGridFSBucket bucketMTBLvl = new GridFSBucket(_MongoDatabase, gridFsOptionMTBLvl);
                eDocumentData data = new eDocumentData();
                for (int i = 0; i < gvModelLvlData.Rows.Count; i++)
                {
                    string updateStatus = (gvModelLvlData.Rows[i].FindControl("hdnUpdate") as HiddenField).Value;
                    if (updateStatus.Equals("updated", StringComparison.OrdinalIgnoreCase))
                    {
                        FileUpload fileUpload = gvModelLvlData.Rows[i].FindControl("fileUpload") as FileUpload;
                        data.MTB = (gvModelLvlData.Rows[i].FindControl("hdnMTB") as HiddenField).Value;
                        data.CNCMake = (gvModelLvlData.Rows[i].FindControl("lblCNCMake") as Label).Text;
                        data.CNCModel = (gvModelLvlData.Rows[i].FindControl("lblCNCModel") as Label).Text;
                        //data.MachineModel = (gvModelLvlData.Rows[i].FindControl("ddlMachineModel") as DropDownList).SelectedValue;
                        //data.MachineType = (gvModelLvlData.Rows[i].FindControl("ddlMachineType") as DropDownList).SelectedValue;
                        data.MachineModel = (gvModelLvlData.Rows[i].FindControl("hdnSelectedMachineModel") as HiddenField).Value;
                        data.MachineType = (gvModelLvlData.Rows[i].FindControl("hdnSelectedMachineType") as HiddenField).Value;
                        data.Category = (gvModelLvlData.Rows[i].FindControl("lblCategory") as Label).Text;
                        data.Subcategory = (gvModelLvlData.Rows[i].FindControl("lblSubcategory") as Label).Text;
                        // data.CustomerName = (gvModelLvlData.Rows[i].FindControl("lblCustomerName") as Label).Text;
                        // data.DateOfDispatchInDate = Util.GetDateTime((gvModelLvlData.Rows[i].FindControl("lblDateOfDispatch") as Label).Text);
                        data.Version = (gvModelLvlData.Rows[i].FindControl("lblVersion") as Label).Text;
                        data.UpdatedBy = username;
                        data.FileID = (gvModelLvlData.Rows[i].FindControl("hdnFileID") as HiddenField).Value;
                        string oldMachineType = (gvModelLvlData.Rows[i].FindControl("hdnMachineType") as HiddenField).Value;
                        string oldMachineModel = (gvModelLvlData.Rows[i].FindControl("hdnMachineModel") as HiddenField).Value;
                        string version = (gvModelLvlData.Rows[i].FindControl("lblVersion") as Label).Text;
                        data.FileType = (gvModelLvlData.Rows[i].FindControl("hdnFileType") as HiddenField).Value;
                        if (fileUpload.HasFile || data.MachineType != oldMachineType || data.MachineModel != oldMachineModel)
                        {
                            if (data.MachineType == "")
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Machine Type.');", true);
                                return;
                            }
                            if (data.MachineModel == "")
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Machine Model.');", true);
                                return;
                            }

                            string fileName = (gvModelLvlData.Rows[i].FindControl("hdnFileName") as HiddenField).Value;
                            byte[] bytes = null;
                            //if it is not come from mtb level delete the file from modelLvl and insert data else insert data to same bucket (but not required to delete the record because it may effect to file or record having same id) and take bytes from mtbLvl collcetion
                            if (oldMachineType != "" && oldMachineModel != "")
                            {
                                if (fileUpload.HasFile)
                                {
                                    foreach (HttpPostedFile postedFile in fileUpload.PostedFiles)
                                    {
                                        fileName = Path.GetFileName(postedFile.FileName);
                                        Stream fs = postedFile.InputStream;
                                        BinaryReader br = new BinaryReader(fs);
                                        bytes = br.ReadBytes((Int32)fs.Length);
                                        MongoDBAccess.deleteEdocData(data.FileID, "ModelLeveleDoc");
                                        data.FileType = System.IO.Path.GetExtension(postedFile.FileName);
                                        if (data.FileType.Length > 0)
                                        {
                                            data.FileType = data.FileType.Remove(0, 1);
                                        }
                                    }
                                }
                                else
                                {
                                    bytes = MongoDBAccess.getEDocFilesInByte(data.FileID, "ModelLeveleDoc");
                                    MongoDBAccess.deleteEdocData(data.FileID, "ModelLeveleDoc");
                                }
                            }
                            else
                            {
                                if (fileUpload.HasFile)
                                {
                                    foreach (HttpPostedFile postedFile in fileUpload.PostedFiles)
                                    {
                                        fileName = Path.GetFileName(postedFile.FileName);
                                        Stream fs = postedFile.InputStream;
                                        BinaryReader br = new BinaryReader(fs);
                                        bytes = br.ReadBytes((Int32)fs.Length);
                                        data.FileType = System.IO.Path.GetExtension(postedFile.FileName);
                                        if (data.FileType.Length > 0)
                                        {
                                            data.FileType = data.FileType.Remove(0, 1);
                                        }
                                    }
                                }
                                else
                                {
                                    bytes = MongoDBAccess.getEDocFilesInByte(data.FileID, "MTBLeveleDoc");
                                }
                            }
                            data.Document = bytes;
                            data.Filename = fileName;
                            MongoDBAccess.uploadModelLvlEdocData(data);
                        }
                    }
                }
                BindModelLevelData();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static MachineDocumentsData getFileNamePath(string fileId, string filenameStr, string colName)
        {
            MachineDocumentsData data = new MachineDocumentsData();
            try
            {
                byte[] fileByte = null;
                string fileBase64 = "";

                fileByte = MongoDBAccess.getEDocFilesInByte(fileId, colName);

                Logger.WriteDebugLog("Download eDoc File: After: " + DateTime.Now);
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
                Logger.WriteDebugLog("Download eDoc File: Error: " + DateTime.Now + "   --- " + ex.Message);
                data.FileName = "";
                data.FileInBase64 = "";
                data.FileType = "";
                data.FileExtension = "";
            }
            Logger.WriteDebugLog("Download eDoc File: data return: " + DateTime.Now);
            return data;
        }
        //[System.Web.Services.WebMethod(EnableSession = true)]
        //public static string getFileNamePath(string fileId, string filenameStr,string colName)
        //{
        //    string filePath = "";
        //    try
        //    {
        //        var filter = "{'files_id' :  ObjectId('" + fileId + "')}";
        //        var dataset2 = _MongoDatabase.GetCollection<BsonDocument>(colName+".chunks").Find(filter).ToList();
        //        byte[] fileByte = null;
        //        string fileBase64 = "";
        //        foreach (var item in dataset2)
        //        {
        //            var fileBinaryData = item["data"];
        //            if (fileByte != null)
        //            {
        //                fileByte = concatByteArray(fileByte, (byte[])fileBinaryData);
        //            }
        //            else
        //            {
        //                fileByte = (byte[])fileBinaryData;
        //            }
        //        }
        //        if (fileByte != null)
        //        {
        //            fileBase64 = Convert.ToBase64String(fileByte);
        //        }
        //        string fileName = filenameStr;
        //        if (!string.IsNullOrEmpty(fileBase64))
        //        {
        //            string filePathForDelete = Path.Combine(appPath, "MachineFiles");
        //            Array.ForEach(Directory.GetFiles(filePathForDelete), File.Delete);
        //            string filePathForInsert = GetFilePath(fileName);
        //            //  byte[] fileByte = Convert.FromBase64String(fileBase64);
        //            File.WriteAllBytes(filePathForInsert, fileByte);
        //            filePath = "MachineFiles/" + fileName + "#toolbar=0";
        //        }
        //        else
        //        {
        //            filePath = "";
        //        }

        //        ObjectId id = new ObjectId(fileId);
        //        ////id = fileId;
        //        GridFSBucketOptions op = new GridFSBucketOptions();
        //        op.BucketName = colName;
        //        GridFSBucketOptions gridFsOption = new GridFSBucketOptions(op);
        //        IGridFSBucket bucket = new GridFSBucket(_MongoDatabase, gridFsOption);
        //        var filter1 = Builders<GridFSFileInfo<ObjectId>>.Filter.Eq(x => x.Filename, fileName);
        //        //var filter1 = Builders<GridFSFileInfo<ObjectId>>.Filter.Eq(x => x.Id, fileId);
        //        var searchResult = bucket.Find(filter1);
        //        var fileEntry = searchResult.FirstOrDefault();
        //        //  byte[] content = bucket.DownloadAsBytes(fileEntry.Id);
        //        byte[] content = bucket.DownloadAsBytes(id);
        //        // byte[] content = bucket.DownloadAsBytesAsync(searchResult[0].Id);

        //        //ObjectId id=new ObjectId(fileId);
        //        ////id = fileId;
        //        //GridFSBucketOptions op = new GridFSBucketOptions();
        //        //op.BucketName = "MTBLeveleDoc";
        //        //GridFSBucketOptions gridFsOption = new GridFSBucketOptions(op);
        //        //IGridFSBucket bucket = new GridFSBucket(_MongoDatabase, gridFsOption);
        //        //var bytes = bucket.DownloadAsBytesAsync(id);
        //        //Task<byte[]> b1= bucket.DownloadAsBytesAsync(id);
        //    }
        //    catch (Exception ex)
        //    {
        //        filePath = "";
        //    }
        //    return filePath;
        //}
        public static byte[] concatByteArray(byte[] first, byte[] second)
        {
            return first.Concat(second).ToArray();
        }
        public static string GetFilePath(string reportName)
        {
            string src;
            src = Path.Combine(appPath, "MachineFiles", reportName);
            return src;
        }



        protected void btnModelLevel_Click(object sender, EventArgs e)
        {
            BindMTBData();
            ddlMachineModelModelLvl.DataSource = DBAccess.getMachineModelData("", "", "", "", ddlMTBModelLvl.SelectedValue, "");
            ddlMachineModelModelLvl.DataBind();
            BindModelLevelData();
        }

        protected void btnMachineLevel_Click(object sender, EventArgs e)
        {
            BindMTBData();
            ddlMachineModelMachineLvl.DataSource = DBAccess.getMachineModelData("", "", "", "", ddlMTBMachineLvl.SelectedValue, "");
            ddlMachineModelMachineLvl.DataBind();
            ddlMachineSlnoMachineLvl.DataSource = DBAccess.getMachineSerialNumberData("", "", "", "", ddlMTBMachineLvl.SelectedValue, "", ddlMachineModelMachineLvl.SelectedValue);
            ddlMachineSlnoMachineLvl.DataBind();
            BindMachineLevelData();
        }

        private void BindMachineLevelData()
        {

            try
            {
                string mtb = ddlMTBMachineLvl.SelectedValue;
                string model = ddlMachineModelMachineLvl.SelectedValue;
                string machineSlno = ddlMachineSlnoMachineLvl.SelectedValue;
                BsonArray levelView = new BsonArray();
                if (ddlMachineLevelView.SelectedValue == "All")
                {
                    foreach (ListItem item in ddlMachineLevelView.Items)
                    {
                        levelView.Add(item.Value);
                    }
                }
                else
                {
                    levelView.Add(ddlMachineLevelView.SelectedValue);
                }

                List<eDocumentData> list = MongoDBAccess.getMachineLvlEdocData(mtb, model, machineSlno, levelView);
                int listcountFlag = 0;
                if (list.Count == 0)
                {
                    listcountFlag = 1;
                    eDocumentData data = new eDocumentData();
                    list.Add(data);
                }
                Session["eDocMasterData"] = list;
                gvMachineLvlData.DataSource = list;
                gvMachineLvlData.DataBind();
                if (listcountFlag == 1)
                {
                    gvMachineLvlData.Rows[0].Visible = false;
                }
                (gvMachineLvlData.FooterRow.FindControl("txtDateOfDispatchNew") as TextBox).Text = DateTime.Now.ToString("dd-MM-yyyy");
                DropDownList ddl = new DropDownList();
                ddl = (gvMachineLvlData.FooterRow.FindControl("ddlCNCMakeNew") as DropDownList);
                ddl.DataSource = DBAccess.getCNCMakeData("", "");
                ddl.DataBind();
                string cncMake = ddl.SelectedValue;
                (gvMachineLvlData.FooterRow.FindControl("hdnSelectedCNCMake") as HiddenField).Value = cncMake;
                ddl = (gvMachineLvlData.FooterRow.FindControl("ddlCNCModelNew") as DropDownList);
                ddl.DataSource = DBAccess.getCNCModelData("", "", cncMake);
                ddl.DataBind();
                string cncModel = ddl.SelectedValue;
                (gvMachineLvlData.FooterRow.FindControl("hdnSelectedCNCModel") as HiddenField).Value = cncModel;
                ddl = (gvMachineLvlData.FooterRow.FindControl("ddlMachineType") as DropDownList);
                //ddl.DataSource = DBAccess.getMachineTypeData("", "", cncMake, cncModel, ddlMTBMachineLvl.SelectedValue);
                ddl.DataSource = DBAccess.getMachineTypeData("", "", "", "", ddlMTBMachineLvl.SelectedValue);
                ddl.DataBind();
                (gvMachineLvlData.FooterRow.FindControl("hdnSelectedMachineType") as HiddenField).Value = ddl.SelectedValue;
                string machineType = ddl.SelectedValue;
                ddl = (gvMachineLvlData.FooterRow.FindControl("ddlMachineModel") as DropDownList);
                //ddl.DataSource = DBAccess.getMachineModelData("", "", cncMake, cncModel, ddlMTBMachineLvl.SelectedValue, machineType);
                ddl.DataSource = DBAccess.getMachineModelData("", "", "", "", ddlMTBMachineLvl.SelectedValue, machineType);
                ddl.DataBind();
                (gvMachineLvlData.FooterRow.FindControl("hdnSelectedMachineModel") as HiddenField).Value = ddl.SelectedValue;
                string machineModel = ddl.SelectedValue;
                ddl = (gvMachineLvlData.FooterRow.FindControl("ddlMachineSlno") as DropDownList);
                ddl.DataSource = DBAccess.getMachineSerialNumberData("", "", cncMake, cncModel, ddlMTBMachineLvl.SelectedValue, machineType, machineModel);
                ddl.DataBind();
                (gvMachineLvlData.FooterRow.FindControl("hdnSelectedMachineSlno") as HiddenField).Value = ddl.SelectedValue;
            }
            catch (Exception ex)
            {
                Logger.WriteDebugLog("Edoc Master: Machine data:  " + ex.Message);
            }
        }
        protected void btnViewMachineLvl_Click(object sender, EventArgs e)
        {
            BindMachineLevelData();
        }

        protected void btnSaveMachineLvl_Click(object sender, EventArgs e)
        {
            try
            {
                string username = "";
                if (Session["Username"] != null)
                {
                    username = Session["Username"].ToString();
                }
                else
                {
                    Response.Redirect("~/LoginInitial", false);
                }
                eDocumentData data = new eDocumentData();
                for (int i = 0; i < gvMachineLvlData.Rows.Count; i++)
                {
                    string updateStatus = (gvMachineLvlData.Rows[i].FindControl("hdnUpdate") as HiddenField).Value;
                    if (updateStatus.Equals("updated", StringComparison.OrdinalIgnoreCase))
                    {
                        FileUpload fileUpload = gvMachineLvlData.Rows[i].FindControl("fileUpload") as FileUpload;
                        data.MTB = (gvMachineLvlData.Rows[i].FindControl("hdnMTB") as HiddenField).Value;
                        data.CNCMake = (gvMachineLvlData.Rows[i].FindControl("lblCNCMake") as Label).Text;
                        data.CNCModel = (gvMachineLvlData.Rows[i].FindControl("lblCNCModel") as Label).Text;
                        //data.MachineModel = (gvMachineLvlData.Rows[i].FindControl("ddlMachineModel") as DropDownList).SelectedValue;
                        //data.MachineType = (gvMachineLvlData.Rows[i].FindControl("ddlMachineType") as DropDownList).SelectedValue;
                        //data.MachineSlno = (gvMachineLvlData.Rows[i].FindControl("ddlMachineSlno") as DropDownList).SelectedValue;
                        data.MachineModel = (gvMachineLvlData.Rows[i].FindControl("hdnSelectedMachineModel") as HiddenField).Value;
                        data.MachineType = (gvMachineLvlData.Rows[i].FindControl("hdnSelectedMachineType") as HiddenField).Value;
                        data.MachineSlno = (gvMachineLvlData.Rows[i].FindControl("hdnSelectedMachineSlno") as HiddenField).Value;
                        data.Category = (gvMachineLvlData.Rows[i].FindControl("lblCategory") as Label).Text;
                        data.Subcategory = (gvMachineLvlData.Rows[i].FindControl("lblSubcategory") as Label).Text;
                        data.CustomerName = (gvMachineLvlData.Rows[i].FindControl("lblCustomerName") as Label).Text;
                        data.DateOfDispatchInDate = Util.GetDateTime((gvMachineLvlData.Rows[i].FindControl("lblDateOfDispatch") as Label).Text);
                        data.Version = (gvMachineLvlData.Rows[i].FindControl("lblVersion") as Label).Text;
                        data.UpdatedBy = username;
                        data.FileID = (gvMachineLvlData.Rows[i].FindControl("hdnFileID") as HiddenField).Value;
                        string version = (gvMachineLvlData.Rows[i].FindControl("lblVersion") as Label).Text;
                        data.FileType = (gvMachineLvlData.Rows[i].FindControl("hdnFileType") as HiddenField).Value;
                        string oldMachineType = (gvMachineLvlData.Rows[i].FindControl("hdnMachineType") as HiddenField).Value;
                        string oldMachineModel = (gvMachineLvlData.Rows[i].FindControl("hdnMachineModel") as HiddenField).Value;
                        string oldMachineSlno = (gvMachineLvlData.Rows[i].FindControl("hdnMachineSlno") as HiddenField).Value;
                        if (fileUpload.HasFile || data.MachineType != oldMachineType || data.MachineModel != oldMachineModel || data.MachineSlno != oldMachineSlno)
                        {
                            if (data.MachineType == "")
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Machine Type.');", true);
                                return;
                            }
                            if (data.MachineModel == "")
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Machine Model.');", true);
                                return;
                            }
                            if (data.MachineSlno == "")
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Machine Slno.');", true);
                                return;
                            }
                            string fileName = (gvMachineLvlData.Rows[i].FindControl("hdnFileName") as HiddenField).Value;
                            byte[] bytes = null;
                            if (oldMachineType != "" && oldMachineModel != "" && oldMachineSlno != "")
                            {
                                if (fileUpload.HasFile)
                                {
                                    foreach (HttpPostedFile postedFile in fileUpload.PostedFiles)
                                    {
                                        fileName = Path.GetFileName(postedFile.FileName);
                                        Stream fs = postedFile.InputStream;
                                        BinaryReader br = new BinaryReader(fs);
                                        bytes = br.ReadBytes((Int32)fs.Length);
                                        MongoDBAccess.deleteEdocData(data.FileID, "MachineLeveleDoc");
                                        data.FileType = System.IO.Path.GetExtension(postedFile.FileName);
                                        if (data.FileType.Length > 0)
                                        {
                                            data.FileType = data.FileType.Remove(0, 1);
                                        }
                                    }
                                }
                                else
                                {
                                    bytes = MongoDBAccess.getEDocFilesInByte(data.FileID, "MachineLeveleDoc");
                                    MongoDBAccess.deleteEdocData(data.FileID, "MachineLeveleDoc");
                                }
                            }
                            else if (oldMachineType != "" && oldMachineModel != "")
                            {
                                if (fileUpload.HasFile)
                                {
                                    foreach (HttpPostedFile postedFile in fileUpload.PostedFiles)
                                    {
                                        fileName = Path.GetFileName(postedFile.FileName);
                                        Stream fs = postedFile.InputStream;
                                        BinaryReader br = new BinaryReader(fs);
                                        bytes = br.ReadBytes((Int32)fs.Length);
                                        data.FileType = System.IO.Path.GetExtension(postedFile.FileName);
                                        if (data.FileType.Length > 0)
                                        {
                                            data.FileType = data.FileType.Remove(0, 1);
                                        }
                                    }
                                }
                                else
                                {
                                    bytes = MongoDBAccess.getEDocFilesInByte(data.FileID, "ModelLeveleDoc");
                                }

                            }
                            else
                            {
                                if (fileUpload.HasFile)
                                {
                                    foreach (HttpPostedFile postedFile in fileUpload.PostedFiles)
                                    {
                                        fileName = Path.GetFileName(postedFile.FileName);
                                        Stream fs = postedFile.InputStream;
                                        BinaryReader br = new BinaryReader(fs);
                                        bytes = br.ReadBytes((Int32)fs.Length);
                                        data.FileType = System.IO.Path.GetExtension(postedFile.FileName);
                                        if (data.FileType.Length > 0)
                                        {
                                            data.FileType = data.FileType.Remove(0, 1);
                                        }
                                    }
                                }
                                else
                                {
                                    bytes = MongoDBAccess.getEDocFilesInByte(data.FileID, "MTBLeveleDoc");
                                }
                            }

                            //agin insert record
                            data.Document = bytes;
                            data.Filename = fileName;
                            MongoDBAccess.uploadMachineLvlEdocData(data);
                        }
                    }
                }
                BindMachineLevelData();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }

        protected void btnDeleteMachineLvl_Click(object sender, EventArgs e)
        {
            try
            {
                for (int i = 0; i < gvMachineLvlData.Rows.Count; i++)
                {
                    CheckBox chk = (gvMachineLvlData.Rows[i].FindControl("chkDeleteSelection") as CheckBox);
                    if (chk.Checked)
                    {

                        string id = (gvMachineLvlData.Rows[i].FindControl("hdnFileID") as HiddenField).Value;
                        MongoDBAccess.deleteMachineLvlEdocData(id);
                    }
                }
                BindMachineLevelData();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }

        protected void btnInsertMachineLvl_Click(object sender, EventArgs e)
        {
            try
            {
                string username = "";
                if (Session["Username"] != null)
                {
                    username = Session["Username"].ToString();
                }
                else
                {
                    Response.Redirect("~/LoginInitial", false);
                }

                eDocumentData data = new eDocumentData();
                data.MTB = ddlMTBMachineLvl.SelectedValue;
                //data.CNCMake = (gvMachineLvlData.FooterRow.FindControl("ddlCNCMakeNew") as DropDownList).SelectedValue;
                //data.CNCModel = (gvMachineLvlData.FooterRow.FindControl("ddlCNCModelNew") as DropDownList).SelectedValue;
                //data.MachineType = (gvMachineLvlData.FooterRow.FindControl("ddlMachineType") as DropDownList).SelectedValue;
                //data.MachineModel = (gvMachineLvlData.FooterRow.FindControl("ddlMachineModel") as DropDownList).SelectedValue;
                //data.MachineSlno = (gvMachineLvlData.FooterRow.FindControl("ddlMachineSlno") as DropDownList).SelectedValue;
                data.CNCMake = (gvMachineLvlData.FooterRow.FindControl("hdnSelectedCNCMake") as HiddenField).Value;
                data.CNCModel = (gvMachineLvlData.FooterRow.FindControl("hdnSelectedCNCModel") as HiddenField).Value;
                data.MachineType = (gvMachineLvlData.FooterRow.FindControl("hdnSelectedMachineType") as HiddenField).Value;
                data.MachineModel = (gvMachineLvlData.FooterRow.FindControl("hdnSelectedMachineModel") as HiddenField).Value;
                data.MachineSlno = (gvMachineLvlData.FooterRow.FindControl("hdnSelectedMachineSlno") as HiddenField).Value;
                data.Category = (gvMachineLvlData.FooterRow.FindControl("ddlCategoryNew") as DropDownList).SelectedValue;
                data.Subcategory = (gvMachineLvlData.FooterRow.FindControl("ddlSubCategoryNew") as DropDownList).SelectedValue;
                data.CustomerName = (gvMachineLvlData.FooterRow.FindControl("txtCustomerNameNew") as TextBox).Text;
                data.DateOfDispatchInDate = Util.GetDateTime((gvMachineLvlData.FooterRow.FindControl("txtDateOfDispatchNew") as TextBox).Text);
                data.Version = (gvMachineLvlData.FooterRow.FindControl("txtVersionNew") as TextBox).Text;
                data.UpdatedBy = username;
                FileUpload fileUpload = gvMachineLvlData.FooterRow.FindControl("fileUploddNew") as FileUpload;
                foreach (HttpPostedFile postedFile in fileUpload.PostedFiles)
                {
                    string fileName = Path.GetFileName(postedFile.FileName);
                    Stream fs = postedFile.InputStream;
                    BinaryReader br = new BinaryReader(fs);
                    byte[] bytes = br.ReadBytes((Int32)fs.Length);
                    data.FileType = System.IO.Path.GetExtension(postedFile.FileName);
                    if (data.FileType.Length > 0)
                    {
                        data.FileType = data.FileType.Remove(0, 1);
                    }
                    data.Filename = fileName;
                    data.Document = bytes;
                    MongoDBAccess.uploadMachineLvlEdocData(data);
                }
                BindMachineLevelData();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }

        protected void ddlCNCMakeNewMTBLvl_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                string cncmake = (gvCompanyLevel.FooterRow.FindControl("ddlCNCMakeNew") as DropDownList).SelectedValue;
                DropDownList ddl = (gvCompanyLevel.FooterRow.FindControl("ddlCNCModelNew") as DropDownList);
                ddl.DataSource = DBAccess.getCNCModelData("", "", cncmake);
                ddl.DataBind();
            }
            catch (Exception ex)
            { Logger.WriteErrorLog(ex.Message); }
        }

        protected void ddlCNCMakeNewModelLvl_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                string cncMake = (gvModelLvlData.FooterRow.FindControl("ddlCNCMakeNew") as DropDownList).SelectedValue;
                DropDownList ddl = (gvModelLvlData.FooterRow.FindControl("ddlCNCModelNew") as DropDownList);
                ddl.DataSource = DBAccess.getCNCModelData("", "", cncMake);
                ddl.DataBind();
                string cncModel = ddl.SelectedValue;
                ddl = (gvModelLvlData.FooterRow.FindControl("ddlMachineType") as DropDownList);
                ddl.DataSource = DBAccess.getMachineTypeData("", "", "", "", ddlMTBModelLvl.SelectedValue);
                ddl.DataBind();
                string machineType = ddl.SelectedValue;
                ddl = (gvModelLvlData.FooterRow.FindControl("ddlMachineModel") as DropDownList);
                ddl.DataSource = DBAccess.getMachineModelData("", "", "", "", ddlMTBModelLvl.SelectedValue, machineType);
                ddl.DataBind();
            }
            catch (Exception ex)
            { Logger.WriteErrorLog(ex.Message); }
        }
        protected void ddlCNCModelNewModelLvl_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                string cncMake = (gvModelLvlData.FooterRow.FindControl("ddlCNCMakeNew") as DropDownList).SelectedValue;
                DropDownList ddl;
                string cncModel = (gvModelLvlData.FooterRow.FindControl("ddlCNCModelNew") as DropDownList).SelectedValue;
                ddl = (gvModelLvlData.FooterRow.FindControl("ddlMachineType") as DropDownList);
                ddl.DataSource = DBAccess.getMachineTypeData("", "", "", "", ddlMTBModelLvl.SelectedValue);
                ddl.DataBind();
                string machineType = ddl.SelectedValue;
                ddl = (gvModelLvlData.FooterRow.FindControl("ddlMachineModel") as DropDownList);
                ddl.DataSource = DBAccess.getMachineModelData("", "", "", "", ddlMTBModelLvl.SelectedValue, machineType);
                ddl.DataBind();
            }
            catch (Exception ex)
            { Logger.WriteErrorLog(ex.Message); }
        }
        protected void ddlMachineTypeNewModelLvl_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                string cncMake = (gvModelLvlData.FooterRow.FindControl("ddlCNCMakeNew") as DropDownList).SelectedValue;
                string cncModel = (gvModelLvlData.FooterRow.FindControl("ddlCNCModelNew") as DropDownList).SelectedValue;
                string machineType = (gvModelLvlData.FooterRow.FindControl("ddlMachineType") as DropDownList).SelectedValue;
                DropDownList ddl = (gvModelLvlData.FooterRow.FindControl("ddlMachineModel") as DropDownList);
                ddl.DataSource = DBAccess.getMachineModelData("", "", "", "", ddlMTBModelLvl.SelectedValue, machineType);
                ddl.DataBind();
            }
            catch (Exception ex)
            { Logger.WriteErrorLog(ex.Message); }
        }

        protected void ddlCNCMakeNewMachineLvl_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                DropDownList ddl;
                string cncMake = (gvMachineLvlData.FooterRow.FindControl("ddlCNCMakeNew") as DropDownList).SelectedValue;
                ddl = (gvMachineLvlData.FooterRow.FindControl("ddlCNCModelNew") as DropDownList);
                ddl.DataSource = DBAccess.getCNCModelData("", "", cncMake);
                ddl.DataBind();
                string cncModel = ddl.SelectedValue;
                ddl = (gvMachineLvlData.FooterRow.FindControl("ddlMachineType") as DropDownList);
                ddl.DataSource = DBAccess.getMachineTypeData("", "", "", "", ddlMTBMachineLvl.SelectedValue);
                ddl.DataBind();
                string machineType = ddl.SelectedValue;
                ddl = (gvMachineLvlData.FooterRow.FindControl("ddlMachineModel") as DropDownList);
                ddl.DataSource = DBAccess.getMachineModelData("", "", "", "", ddlMTBMachineLvl.SelectedValue, machineType);
                ddl.DataBind();
                string machineModel = ddl.SelectedValue;
                ddl = (gvMachineLvlData.FooterRow.FindControl("ddlMachineSlno") as DropDownList);
                ddl.DataSource = DBAccess.getMachineSerialNumberData("", "", cncMake, cncModel, ddlMTBMachineLvl.SelectedValue, machineType, machineModel);
                ddl.DataBind();
            }
            catch (Exception ex)
            { Logger.WriteErrorLog(ex.Message); }
        }

        protected void ddlCNCModelNewMachineLvl_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                DropDownList ddl;
                string cncMake = (gvMachineLvlData.FooterRow.FindControl("ddlCNCMakeNew") as DropDownList).SelectedValue;
                string cncModel = (gvMachineLvlData.FooterRow.FindControl("ddlCNCModelNew") as DropDownList).SelectedValue;
                ddl = (gvMachineLvlData.FooterRow.FindControl("ddlMachineType") as DropDownList);
                ddl.DataSource = DBAccess.getMachineTypeData("", "", "", "", ddlMTBMachineLvl.SelectedValue);
                ddl.DataBind();
                string machineType = ddl.SelectedValue;
                ddl = (gvMachineLvlData.FooterRow.FindControl("ddlMachineModel") as DropDownList);
                ddl.DataSource = DBAccess.getMachineModelData("", "", "", "", ddlMTBMachineLvl.SelectedValue, machineType);
                ddl.DataBind();
                string machineModel = ddl.SelectedValue;
                ddl = (gvMachineLvlData.FooterRow.FindControl("ddlMachineSlno") as DropDownList);
                ddl.DataSource = DBAccess.getMachineSerialNumberData("", "", cncMake, cncModel, ddlMTBMachineLvl.SelectedValue, machineType, machineModel);
                ddl.DataBind();
            }
            catch (Exception ex)
            { Logger.WriteErrorLog(ex.Message); }
        }
        protected void ddlMachineTypeNewMachineLvl_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                DropDownList ddl;
                string cncMake = (gvMachineLvlData.FooterRow.FindControl("ddlCNCMakeNew") as DropDownList).SelectedValue;
                string cncModel = (gvMachineLvlData.FooterRow.FindControl("ddlCNCModelNew") as DropDownList).SelectedValue;
                string machineType = (gvMachineLvlData.FooterRow.FindControl("ddlMachineType") as DropDownList).SelectedValue;
                ddl = (gvMachineLvlData.FooterRow.FindControl("ddlMachineModel") as DropDownList);
                ddl.DataSource = DBAccess.getMachineModelData("", "", "", "", ddlMTBMachineLvl.SelectedValue, machineType);
                ddl.DataBind();
                string machineModel = ddl.SelectedValue;
                ddl = (gvMachineLvlData.FooterRow.FindControl("ddlMachineSlno") as DropDownList);
                ddl.DataSource = DBAccess.getMachineSerialNumberData("", "", cncMake, cncModel, ddlMTBMachineLvl.SelectedValue, machineType, machineModel);
                ddl.DataBind();
            }
            catch (Exception ex)
            { Logger.WriteErrorLog(ex.Message); }
        }
        protected void ddlMachineModelNewMachineLvl_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                DropDownList ddl;
                string cncMake = (gvMachineLvlData.FooterRow.FindControl("ddlCNCMakeNew") as DropDownList).SelectedValue;
                string cncModel = (gvMachineLvlData.FooterRow.FindControl("ddlCNCModelNew") as DropDownList).SelectedValue;
                string machineType = (gvMachineLvlData.FooterRow.FindControl("ddlMachineType") as DropDownList).SelectedValue;
                string machineModel = (gvMachineLvlData.FooterRow.FindControl("ddlMachineModel") as DropDownList).SelectedValue;
                ddl = (gvMachineLvlData.FooterRow.FindControl("ddlMachineSlno") as DropDownList);
                ddl.DataSource = DBAccess.getMachineSerialNumberData("", "", cncMake, cncModel, ddlMTBMachineLvl.SelectedValue, machineType, machineModel);
                ddl.DataBind();
            }
            catch (Exception ex)
            { Logger.WriteErrorLog(ex.Message); }
        }

        protected void ddlMTBModelLvl_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                ddlMachineModelModelLvl.DataSource = DBAccess.getMachineModelData("", "", "", "", ddlMTBModelLvl.SelectedValue, "");
                ddlMachineModelModelLvl.DataBind();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }

        protected void ddlMTBMachineLvl_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                ddlMachineModelMachineLvl.DataSource = DBAccess.getMachineModelData("", "", "", "", ddlMTBMachineLvl.SelectedValue, "");
                ddlMachineModelMachineLvl.DataBind();
                ddlMachineSlnoMachineLvl.DataSource = DBAccess.getMachineSerialNumberData("", "", "", "", ddlMTBMachineLvl.SelectedValue, "", ddlMachineModelMachineLvl.SelectedValue);
                ddlMachineSlnoMachineLvl.DataBind();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }

        protected void ddlMachineModelMachineLvl_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                ddlMachineSlnoMachineLvl.DataSource = DBAccess.getMachineSerialNumberData("", "", "", "", ddlMTBMachineLvl.SelectedValue, "", ddlMachineModelMachineLvl.SelectedValue);
                ddlMachineSlnoMachineLvl.DataBind();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }

        protected void ddlMachineTypeModelLvl_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                int rowIndex = Convert.ToInt32(((sender as DropDownList).NamingContainer as GridViewRow).RowIndex);
                DropDownList ddl = sender as DropDownList;
                string machineType = ddl.SelectedValue;
                string cncMake = (gvModelLvlData.Rows[rowIndex].FindControl("lblCNCMake") as Label).Text;
                string cncModel = (gvModelLvlData.Rows[rowIndex].FindControl("lblCNCModel") as Label).Text;
                ddl = (gvModelLvlData.Rows[rowIndex].FindControl("ddlMachineModel") as DropDownList);
                ddl.DataSource = DBAccess.getMachineModelData("", "", "", "", ddlMTBModelLvl.SelectedValue, machineType);
                ddl.DataBind();
                if (machineType == "")
                {
                    ddl.Items.Insert(0, "");
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }

        protected void gvModelLvlData_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string cncMake = (e.Row.FindControl("lblCNCMake") as Label).Text;
                string cncModel = (e.Row.FindControl("lblCNCModel") as Label).Text;
                string hdnvalue = (e.Row.FindControl("hdnMachineType") as HiddenField).Value;
                DropDownList ddl = (e.Row.FindControl("ddlMachineType") as DropDownList);
                ddl.DataSource = DBAccess.getMachineTypeData("", "", "", "", ddlMTBModelLvl.SelectedValue);
                ddl.DataBind();
                if (hdnvalue == "")
                {
                    ddl.Items.Insert(0, "");
                }
                else
                {
                    ddl.SelectedValue = hdnvalue;
                }
                string machineType = hdnvalue;
                hdnvalue = (e.Row.FindControl("hdnMachineModel") as HiddenField).Value;
                ddl = (e.Row.FindControl("ddlMachineModel") as DropDownList);
                ddl.DataSource = DBAccess.getMachineModelData("", "", "", "", ddlMTBModelLvl.SelectedValue, machineType);
                ddl.DataBind();
                if (hdnvalue == "")
                {
                    ddl.Items.Insert(0, "");
                }
                else
                {
                    ddl.SelectedValue = hdnvalue;
                }
                string level = (e.Row.FindControl("lblLevel") as Label).Text;
                if (level == "Model")
                {
                    (e.Row.FindControl("chkDeleteSelection") as CheckBox).Visible = true;
                }
                else
                {
                    (e.Row.FindControl("chkDeleteSelection") as CheckBox).Visible = false;
                }
            }
        }

        protected void ddlMachineTypeMachineLvl_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                int rowIndex = Convert.ToInt32(((sender as DropDownList).NamingContainer as GridViewRow).RowIndex);
                DropDownList ddl = sender as DropDownList;
                string machineType = ddl.SelectedValue;
                string cncMake = (gvMachineLvlData.Rows[rowIndex].FindControl("lblCNCMake") as Label).Text;
                string cncModel = (gvMachineLvlData.Rows[rowIndex].FindControl("lblCNCModel") as Label).Text;
                if (machineType == "")
                {
                    ddl = (gvMachineLvlData.Rows[rowIndex].FindControl("ddlMachineModel") as DropDownList);
                    ddl.Items.Clear();
                    ddl.Items.Insert(0, "");
                    ddl = (gvMachineLvlData.Rows[rowIndex].FindControl("ddlMachineSlno") as DropDownList);
                    ddl.Items.Clear();
                    ddl.Items.Insert(0, "");
                }
                else
                {
                    ddl = (gvMachineLvlData.Rows[rowIndex].FindControl("ddlMachineModel") as DropDownList);
                    ddl.DataSource = DBAccess.getMachineModelData("", "", "", "", ddlMTBMachineLvl.SelectedValue, machineType);
                    ddl.DataBind();
                    string machineModel = ddl.SelectedValue;
                    ddl = (gvMachineLvlData.Rows[rowIndex].FindControl("ddlMachineSlno") as DropDownList);
                    ddl.DataSource = DBAccess.getMachineSerialNumberData("", "", cncMake, cncModel, ddlMTBMachineLvl.SelectedValue, machineType, machineModel);
                    ddl.DataBind();
                }

            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }

        protected void ddlMachineModelMachineLvlUpdate_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                int rowIndex = Convert.ToInt32(((sender as DropDownList).NamingContainer as GridViewRow).RowIndex);
                DropDownList ddl = sender as DropDownList;
                string cncMake = (gvMachineLvlData.Rows[rowIndex].FindControl("lblCNCMake") as Label).Text;
                string cncModel = (gvMachineLvlData.Rows[rowIndex].FindControl("lblCNCModel") as Label).Text;
                string machineType = (gvMachineLvlData.Rows[rowIndex].FindControl("ddlMachineType") as DropDownList).SelectedValue;
                string machineModel = ddl.SelectedValue;
                if (machineModel == "")
                {
                    ddl = (gvMachineLvlData.Rows[rowIndex].FindControl("ddlMachineSlno") as DropDownList);
                    ddl.Items.Clear();
                    ddl.Items.Insert(0, "");
                }
                else
                {
                    ddl = (gvMachineLvlData.Rows[rowIndex].FindControl("ddlMachineSlno") as DropDownList);
                    ddl.DataSource = DBAccess.getMachineSerialNumberData("", "", cncMake, cncModel, ddlMTBMachineLvl.SelectedValue, machineType, machineModel);
                    ddl.DataBind();
                }

            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }

        protected void gvMachineLvlData_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string cncMake = (e.Row.FindControl("lblCNCMake") as Label).Text;
                string cncModel = (e.Row.FindControl("lblCNCModel") as Label).Text;
                string hdnvalue = (e.Row.FindControl("hdnMachineType") as HiddenField).Value;
                DropDownList ddl = (e.Row.FindControl("ddlMachineType") as DropDownList);
                ddl.DataSource = DBAccess.getMachineTypeData("", "", "", "", ddlMTBMachineLvl.SelectedValue);
                ddl.DataBind();
                if (hdnvalue == "")
                {
                    ddl.Items.Insert(0, "");
                }
                else
                {
                    ddl.SelectedValue = hdnvalue;
                }
                string machineType = hdnvalue;
                hdnvalue = (e.Row.FindControl("hdnMachineModel") as HiddenField).Value;
                ddl = (e.Row.FindControl("ddlMachineModel") as DropDownList);
                ddl.DataSource = DBAccess.getMachineModelData("", "", "", "", ddlMTBMachineLvl.SelectedValue, machineType);
                ddl.DataBind();
                if (hdnvalue == "")
                {
                    ddl.Items.Insert(0, "");
                }
                else
                {
                    ddl.SelectedValue = hdnvalue;
                }
                string machineModel = hdnvalue;
                hdnvalue = (e.Row.FindControl("hdnMachineSlno") as HiddenField).Value;
                ddl = (e.Row.FindControl("ddlMachineSlno") as DropDownList);
                ddl.DataSource = DBAccess.getMachineSerialNumberData("", "", cncMake, cncModel, ddlMTBMachineLvl.SelectedValue, machineType, machineModel);
                ddl.DataBind();
                if (hdnvalue == "")
                {
                    ddl.Items.Insert(0, "");
                }
                else
                {
                    ddl.SelectedValue = hdnvalue;
                }
                string level = (e.Row.FindControl("lblLevel") as Label).Text;
                if (level == "Machine")
                {
                    (e.Row.FindControl("chkDeleteSelection") as CheckBox).Visible = true;
                }
                else
                {
                    (e.Row.FindControl("chkDeleteSelection") as CheckBox).Visible = false;
                }
            }
        }

        protected void gvCompanyLevel_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                FileUpload flUpload = e.Row.FindControl("fileUpload") as FileUpload;
                ScriptManager.GetCurrent(this).RegisterPostBackControl(flUpload);
                //Button btnUpload = e.Row.FindControl("fileUploadBtn") as Button;
                //    ScriptManager.GetCurrent(this).RegisterPostBackControl(btnUpload);
            }
        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<string> getCNCModelForDdl(string MTB, string cncMake)
        {
            List<string> list = new List<string>();
            try
            {
                list = DBAccess.getCNCModelData("", "", cncMake);
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
            return list;
        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<string> getMachineTypeForDdl(string MTB, string cncMake, string cncModel)
        {
            List<string> list = new List<string>();
            try
            {
                //list = DBAccess.getMachineTypeData("", "", cncMake, cncModel, MTB);
                list = DBAccess.getMachineTypeData("", "", "", "", MTB);
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
            return list;
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<string> getMachineModelForDdl(string MTB, string cncMake, string cncModel, string machineType)
        {
            List<string> list = new List<string>();
            try
            {
                //list = DBAccess.getMachineModelData("", "", cncMake, cncModel, MTB, machineType);
                list = DBAccess.getMachineModelData("", "", "", "", MTB, machineType);
                if (machineType == "")
                {
                    list.Insert(0, "");
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
            return list;
        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<string> getMachineSerialNumberForDdl(string MTB, string cncMake, string cncModel, string machineType, string machineModel)
        {
            List<string> list = new List<string>();
            try
            {
                list = DBAccess.getMachineSerialNumberData("", "", cncMake, cncModel, MTB, machineType, machineModel);
                if (machineType == "")
                {
                    list.Insert(0, "");
                }

            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
            return list;
        }

        protected void gvCompanyLevel_Sorting(object sender, GridViewSortEventArgs e)
        {
            try
            {
                string sortField = e.SortExpression;
                System.Web.UI.WebControls.SortDirection sortDirection;
                SortGridview((GridView)sender, e, out sortDirection, out sortField);
                List<eDocumentData> list1 = Session["eDocMasterData"] as List<eDocumentData>;
                List<eDocumentData> list = Sort<eDocumentData>(list1, "UpdatedTS", sortDirection);
                Session["eDocMasterData"] = list;
                gvCompanyLevel.DataSource = list;
                gvCompanyLevel.DataBind();
                //(gvCompanyLevel.FooterRow.FindControl("txtDateOfDispatchNew") as TextBox).Text = DateTime.Now.ToString("dd-MM-yyyy");
                DropDownList ddl = new DropDownList();
                ddl = (gvCompanyLevel.FooterRow.FindControl("ddlCNCMakeNew") as DropDownList);
                ddl.DataSource = DBAccess.getCNCMakeData("", "");
                ddl.DataBind();
                string cncmake = ddl.SelectedValue;
                ddl = (gvCompanyLevel.FooterRow.FindControl("ddlCNCModelNew") as DropDownList);
                ddl.DataSource = DBAccess.getCNCModelData("", "", cncmake);
                ddl.DataBind();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }
        private void SortGridview(GridView gridView, GridViewSortEventArgs e, out System.Web.UI.WebControls.SortDirection sortDirection, out string sortField)
        {
            sortField = e.SortExpression;
            sortDirection = e.SortDirection;
            if (gridView.Attributes["CurrentSortField"] != null && gridView.Attributes["CurrentSortDirection"] != null)
            {
                if (sortField == gridView.Attributes["CurrentSortField"])
                {
                    if (gridView.Attributes["CurrentSortDirection"] == "ASC")
                    {
                        sortDirection = System.Web.UI.WebControls.SortDirection.Descending;
                    }
                    else
                    {
                        sortDirection = System.Web.UI.WebControls.SortDirection.Ascending;
                    }
                }
                gridView.Attributes["CurrentSortField"] = sortField;
                gridView.Attributes["CurrentSortDirection"] = (sortDirection == System.Web.UI.WebControls.SortDirection.Ascending ? "ASC" : "DESC");
            }
        }
        public List<eDocumentData> Sort<TKey>(List<eDocumentData> list, string sortBy, System.Web.UI.WebControls.SortDirection direction)
        {
            PropertyInfo property = list.GetType().GetGenericArguments()[0].GetProperty(sortBy);
            if (direction == System.Web.UI.WebControls.SortDirection.Ascending)
            {
                return list.OrderBy(e => property.GetValue(e, null)).ToList<eDocumentData>();
            }
            else
            {
                return list.OrderByDescending(e => property.GetValue(e, null)).ToList<eDocumentData>();
            }
        }

        protected void gvCompanyLevel_RowCreated(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (gvCompanyLevel.Attributes["CurrentSortField"] != null && gvCompanyLevel.Attributes["CurrentSortDirection"] != null)
                {
                    if (e.Row.RowType == DataControlRowType.Header)
                    {
                        foreach (TableCell tableCell in e.Row.Cells)
                        {
                            if (tableCell.HasControls())
                            {
                                LinkButton sortLinkButton = null;
                                if (tableCell.Controls[0] is LinkButton)
                                {
                                    sortLinkButton = (LinkButton)tableCell.Controls[0];
                                }

                                if (sortLinkButton != null && gvCompanyLevel.Attributes["CurrentSortField"] == sortLinkButton.CommandArgument)
                                {
                                    System.Web.UI.WebControls.Image image = new System.Web.UI.WebControls.Image();
                                    if (gvCompanyLevel.Attributes["CurrentSortDirection"] == "ASC")
                                    {
                                        image.ImageUrl = "~/Images/UpArrow2.png";
                                        image.Width = 15;
                                    }
                                    else
                                    {
                                        image.ImageUrl = "~/Images/UpArrow2.png";
                                        image.CssClass = "rotateImage";
                                        image.Width = 15;
                                    }
                                    tableCell.Controls.Add(new LiteralControl("&nbsp;"));
                                    tableCell.Controls.Add(image);
                                }
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }

        protected void gvModelLvlData_Sorting(object sender, GridViewSortEventArgs e)
        {
            try
            {
                string sortField = e.SortExpression;
                System.Web.UI.WebControls.SortDirection sortDirection;
                SortGridview((GridView)sender, e, out sortDirection, out sortField);
                List<eDocumentData> list1 = Session["eDocMasterData"] as List<eDocumentData>;
                List<eDocumentData> list = Sort<eDocumentData>(list1, "UpdatedTS", sortDirection);
                Session["eDocMasterData"] = list;
                gvModelLvlData.DataSource = list;
                gvModelLvlData.DataBind();
                DropDownList ddl = new DropDownList();
                ddl = (gvModelLvlData.FooterRow.FindControl("ddlCNCMakeNew") as DropDownList);
                ddl.DataSource = DBAccess.getCNCMakeData("", "");
                ddl.DataBind();
                string cncMake = ddl.SelectedValue;
                (gvModelLvlData.FooterRow.FindControl("hdnSelectedCNCMake") as HiddenField).Value = cncMake;
                ddl = (gvModelLvlData.FooterRow.FindControl("ddlCNCModelNew") as DropDownList);
                ddl.DataSource = DBAccess.getCNCModelData("", "", cncMake);
                ddl.DataBind();
                string cncModel = ddl.SelectedValue;
                (gvModelLvlData.FooterRow.FindControl("hdnSelectedCNCModel") as HiddenField).Value = cncModel;
                ddl = (gvModelLvlData.FooterRow.FindControl("ddlMachineType") as DropDownList);
                //ddl.DataSource = DBAccess.getMachineTypeData("", "", cncMake, cncModel, ddlMTBModelLvl.SelectedValue);
                ddl.DataSource = DBAccess.getMachineTypeData("", "", "", "", ddlMTBModelLvl.SelectedValue);
                ddl.DataBind();
                (gvModelLvlData.FooterRow.FindControl("hdnSelectedMachineType") as HiddenField).Value = ddl.SelectedValue;
                string machineType = ddl.SelectedValue;
                ddl = (gvModelLvlData.FooterRow.FindControl("ddlMachineModel") as DropDownList);
                //ddl.DataSource = DBAccess.getMachineModelData("", "", cncMake, cncModel, ddlMTBModelLvl.SelectedValue, machineType);
                ddl.DataSource = DBAccess.getMachineModelData("", "", "", "", ddlMTBModelLvl.SelectedValue, machineType);
                ddl.DataBind();
                (gvModelLvlData.FooterRow.FindControl("hdnSelectedMachineModel") as HiddenField).Value = ddl.SelectedValue;
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }

        protected void gvModelLvlData_RowCreated(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (gvModelLvlData.Attributes["CurrentSortField"] != null && gvModelLvlData.Attributes["CurrentSortDirection"] != null)
                {
                    if (e.Row.RowType == DataControlRowType.Header)
                    {
                        foreach (TableCell tableCell in e.Row.Cells)
                        {
                            if (tableCell.HasControls())
                            {
                                LinkButton sortLinkButton = null;
                                if (tableCell.Controls[0] is LinkButton)
                                {
                                    sortLinkButton = (LinkButton)tableCell.Controls[0];
                                }

                                if (sortLinkButton != null && gvModelLvlData.Attributes["CurrentSortField"] == sortLinkButton.CommandArgument)
                                {
                                    System.Web.UI.WebControls.Image image = new System.Web.UI.WebControls.Image();
                                    if (gvModelLvlData.Attributes["CurrentSortDirection"] == "ASC")
                                    {
                                        image.ImageUrl = "~/Images/UpArrow2.png";
                                        image.Width = 15;
                                    }
                                    else
                                    {
                                        image.ImageUrl = "~/Images/UpArrow2.png";
                                        image.CssClass = "rotateImage";
                                        image.Width = 15;
                                    }
                                    tableCell.Controls.Add(new LiteralControl("&nbsp;"));
                                    tableCell.Controls.Add(image);
                                }
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            { Logger.WriteErrorLog(ex.Message); }
        }

        protected void gvMachineLvlData_Sorting(object sender, GridViewSortEventArgs e)
        {
            try
            {
                string sortField = e.SortExpression;
                System.Web.UI.WebControls.SortDirection sortDirection;
                SortGridview((GridView)sender, e, out sortDirection, out sortField);
                List<eDocumentData> list1 = Session["eDocMasterData"] as List<eDocumentData>;
                List<eDocumentData> list = Sort<eDocumentData>(list1, "UpdatedTS", sortDirection);
                Session["eDocMasterData"] = list;
                gvMachineLvlData.DataSource = list;
                gvMachineLvlData.DataBind();
                (gvMachineLvlData.FooterRow.FindControl("txtDateOfDispatchNew") as TextBox).Text = DateTime.Now.ToString("dd-MM-yyyy");
                DropDownList ddl = new DropDownList();
                ddl = (gvMachineLvlData.FooterRow.FindControl("ddlCNCMakeNew") as DropDownList);
                ddl.DataSource = DBAccess.getCNCMakeData("", "");
                ddl.DataBind();
                string cncMake = ddl.SelectedValue;
                (gvMachineLvlData.FooterRow.FindControl("hdnSelectedCNCMake") as HiddenField).Value = cncMake;
                ddl = (gvMachineLvlData.FooterRow.FindControl("ddlCNCModelNew") as DropDownList);
                ddl.DataSource = DBAccess.getCNCModelData("", "", cncMake);
                ddl.DataBind();
                string cncModel = ddl.SelectedValue;
                (gvMachineLvlData.FooterRow.FindControl("hdnSelectedCNCModel") as HiddenField).Value = cncModel;
                ddl = (gvMachineLvlData.FooterRow.FindControl("ddlMachineType") as DropDownList);
                ddl.DataSource = DBAccess.getMachineTypeData("", "", "", "", ddlMTBMachineLvl.SelectedValue);
                ddl.DataBind();
                (gvMachineLvlData.FooterRow.FindControl("hdnSelectedMachineType") as HiddenField).Value = ddl.SelectedValue;
                string machineType = ddl.SelectedValue;
                ddl = (gvMachineLvlData.FooterRow.FindControl("ddlMachineModel") as DropDownList);
                ddl.DataSource = DBAccess.getMachineModelData("", "", "", "", ddlMTBMachineLvl.SelectedValue, machineType);
                ddl.DataBind();
                (gvMachineLvlData.FooterRow.FindControl("hdnSelectedMachineModel") as HiddenField).Value = ddl.SelectedValue;
                string machineModel = ddl.SelectedValue;
                ddl = (gvMachineLvlData.FooterRow.FindControl("ddlMachineSlno") as DropDownList);
                ddl.DataSource = DBAccess.getMachineSerialNumberData("", "", cncMake, cncModel, ddlMTBMachineLvl.SelectedValue, machineType, machineModel);
                ddl.DataBind();
                (gvMachineLvlData.FooterRow.FindControl("hdnSelectedMachineSlno") as HiddenField).Value = ddl.SelectedValue;
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }

        protected void gvMachineLvlData_RowCreated(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (gvMachineLvlData.Attributes["CurrentSortField"] != null && gvMachineLvlData.Attributes["CurrentSortDirection"] != null)
                {
                    if (e.Row.RowType == DataControlRowType.Header)
                    {
                        foreach (TableCell tableCell in e.Row.Cells)
                        {
                            if (tableCell.HasControls())
                            {
                                LinkButton sortLinkButton = null;
                                if (tableCell.Controls[0] is LinkButton)
                                {
                                    sortLinkButton = (LinkButton)tableCell.Controls[0];
                                }

                                if (sortLinkButton != null && gvMachineLvlData.Attributes["CurrentSortField"] == sortLinkButton.CommandArgument)
                                {
                                    System.Web.UI.WebControls.Image image = new System.Web.UI.WebControls.Image();
                                    if (gvMachineLvlData.Attributes["CurrentSortDirection"] == "ASC")
                                    {
                                        image.ImageUrl = "~/Images/UpArrow2.png";
                                        image.Width = 15;
                                    }
                                    else
                                    {
                                        image.ImageUrl = "~/Images/UpArrow2.png";
                                        image.CssClass = "rotateImage";
                                        image.Width = 15;
                                    }
                                    tableCell.Controls.Add(new LiteralControl("&nbsp;"));
                                    tableCell.Controls.Add(image);
                                }
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }
    }
}