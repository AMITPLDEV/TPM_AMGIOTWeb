using iTextSharp.text;
using iTextSharp.text.pdf;
using NewProject.DataBaseAccess;
using NewProject.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NewProject
{
    public partial class ProcessParameterMaster : System.Web.UI.Page
    {
        List<string> listSourceType = new List<string>();
        List<string> listSourceDataType = new List<string>();
        List<string> listPollingFrequency = new List<string>();
        List<string> listDataGroup = new List<string>();
        List<System.Web.UI.WebControls.ListItem> listPollingType = new List<System.Web.UI.WebControls.ListItem>();
        List<string> listCycleFrequencyTime = new List<string>();
        List<string> listNumberOfCycle = new List<string>();
        List<string> listUnit = new List<string>();
        List<ParameterWiseValidationData> listParameterWiseValidation = new List<ParameterWiseValidationData>();
        List<SourceTypeWiseValidationData> listSourceTypeWiseValidation = new List<SourceTypeWiseValidationData>();
        List<ProcessParameterMasterData> allLevelDataForPDF = new List<ProcessParameterMasterData>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["ParameterWiseValidationData"] = null;
                btnControllerLvl_Click(null, null);
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
                string accestype = list.Where(x => x.Screen == "Process Param.").Select(x => x.Value).FirstOrDefault();
                if (accestype == "Read")
                {
                    btnControllerSave.Visible = false;
                    gvControllerLvlData.ShowFooter = false;

                    btnModelLvlSave.Visible = false;
                    btnModelLvlDelete.Visible = false;
                    btnModelLvlCopy.Visible = false;
                    gvMTBModeldata.ShowFooter = false;
                    DBAccess.ShowHideColumnOfGrid(gvMTBModeldata, false, "Delete");

                    btnMachineLvlSave.Visible = false;
                    btnMachineLvlDelete.Visible = false;
                    btnCopyMachineLvl.Visible = false;
                    gvMAchineLvlData.ShowFooter = false;
                    DBAccess.ShowHideColumnOfGrid(gvMAchineLvlData, false, "Delete");
                }
                else
                {
                    btnControllerSave.Visible = true;
                    gvControllerLvlData.ShowFooter = true;

                    btnModelLvlSave.Visible = true;
                    btnModelLvlDelete.Visible = true;
                    btnModelLvlCopy.Visible = true;
                    gvMTBModeldata.ShowFooter = true;
                    DBAccess.ShowHideColumnOfGrid(gvMTBModeldata, true, "Delete");

                    btnMachineLvlSave.Visible = true;
                    btnMachineLvlDelete.Visible = true;
                    btnCopyMachineLvl.Visible = true;
                    gvMAchineLvlData.ShowFooter = true;
                    DBAccess.ShowHideColumnOfGrid(gvMTBModeldata, true, "Delete");
                }
            }
            catch (Exception ex)
            {

            }
        }
        private void BindControllerLevelDdlValue()
        {
            BindCNCMakeForController();
            BindCNCModelForController();
        }

        
        //private void BindCompanyForController()
        //{
        //    try
        //    {
        //        List<string> list = DBAccess.getCompanyData();
        //        ddlControlLvlCompany.DataSource = list;
        //        ddlControlLvlCompany.DataBind();
        //        BindPlantForController();
        //    }
        //    catch (Exception ex)
        //    {
        //        Logger.WriteErrorLog(ex.Message);
        //    }
        //}
        //private void BindPlantForController()
        //{
        //    try
        //    {
        //        List<string> list = DBAccess.getPlantData(ddlControlLvlCompany.SelectedValue);
        //        ddlControlLvlPlant.DataSource = list;
        //        ddlControlLvlPlant.DataBind();
        //        BindCNCMakeForController();
        //    }
        //    catch (Exception ex)
        //    {
        //        Logger.WriteErrorLog(ex.Message);
        //    }
        //}
        private void BindCNCMakeForController()
        {
            try
            {
                List<string> list = DBAccess.getCNCMakeData("", "");
                ddlControlLvlCNCMake.DataSource = list;
                ddlControlLvlCNCMake.DataBind();
                BindCNCModelForController();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        private void BindCNCModelForController()
        {
            try
            {
                List<string> list = DBAccess.getCNCModelData("", "", ddlControlLvlCNCMake.SelectedValue);
                ddlControlLvlCNCModel.DataSource = list;
                ddlControlLvlCNCModel.DataBind();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        private void BindModelLevelDdlValue()
        {
            //BindCNCMakeForModel();
            //BindCNCModelForModel();
        }


        //private void BindCompanyForModel()
        //{
        //    try
        //    {
        //        List<string> list = DBAccess.getCompanyData();
        //        ddlModelLvlCompany.DataSource = list;
        //        ddlModelLvlCompany.DataBind();
        //        BindPlantForModel();
        //    }
        //    catch (Exception ex)
        //    {
        //        Logger.WriteErrorLog(ex.Message);
        //    }
        //}
        //private void BindPlantForModel()
        //{
        //    try
        //    {
        //        List<string> list = DBAccess.getPlantData(ddlModelLvlCompany.SelectedValue);
        //        ddlModelLvlPlant.DataSource = list;
        //        ddlModelLvlPlant.DataBind();
        //        BindCNCMakeForModel();
        //    }
        //    catch (Exception ex)
        //    {
        //        Logger.WriteErrorLog(ex.Message);
        //    }
        //}
        private void BindCNCMakeForModel()
        {
            try
            {
                //List<string> list = DBAccess.getCNCMakeData(ddlModelLvlCompany.SelectedValue, ddlModelLvlPlant.SelectedValue);
                List<string> list = DBAccess.getCNCMakeData("", "");
                ddlModelLvlCNCMake.DataSource = list;
                ddlModelLvlCNCMake.DataBind();
                BindCNCModelForModel();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }

        private void BindCNCModelForModel()
        {
            try
            {
                // List<string> list = DBAccess.getCNCModelData(ddlModelLvlCompany.SelectedValue, ddlModelLvlPlant.SelectedValue, ddlModelLvlCNCMake.SelectedValue);
                List<string> list = DBAccess.getCNCModelData("","", ddlModelLvlCNCMake.SelectedValue);
                ddlModelLvlCNCModel.DataSource = list;
                ddlModelLvlCNCModel.DataBind();
                //BindMTBForModel();
               // BindMachineTypeForModel();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        private void BindMTBForModel()
        {
            try
            {
                //ddlModelLvlMTB.DataSource = DBAccess.getMTBData(ddlModelLvlCompany.SelectedValue, ddlModelLvlPlant.SelectedValue, ddlModelLvlCNCMake.SelectedValue, ddlModelLvlCNCModel.SelectedValue);
                ddlModelLvlMTB.DataSource = DBAccess.getMTBData("", "", "", "");
                ddlModelLvlMTB.DataBind();
                BindMachineTypeForModel();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        private void BindMachineTypeForModel()
        {
            try
            {
                //ddlModelLvlMachineType.DataSource = DBAccess.getMachineTypeData(ddlModelLvlCompany.SelectedValue, ddlModelLvlPlant.SelectedValue, ddlModelLvlCNCMake.SelectedValue, ddlModelLvlCNCModel.SelectedValue, ddlModelLvlMTB.SelectedValue);
                ddlModelLvlMachineType.DataSource = DBAccess.getMachineTypeData("", "", "", "", ddlModelLvlMTB.SelectedValue);
                ddlModelLvlMachineType.DataBind();
                BindMachineModelForModel();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        private void BindMachineModelForModel()
        {
            try
            {
                //ddlModelLvlMachineModel.DataSource = DBAccess.getMachineModelData(ddlModelLvlCompany.SelectedValue, ddlModelLvlPlant.SelectedValue, ddlModelLvlCNCMake.SelectedValue, ddlModelLvlCNCModel.SelectedValue, ddlModelLvlMTB.SelectedValue, ddlModelLvlMachineType.SelectedValue);
                ddlModelLvlMachineModel.DataSource = DBAccess.getMachineModelData("", "", "", "", ddlModelLvlMTB.SelectedValue, ddlModelLvlMachineType.SelectedValue);
                ddlModelLvlMachineModel.DataBind();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }


        private void BindCompanyForMachine()
        {
            try
            {
                List<string> list = DBAccess.getCompanyData();
                ddlMachineLvlCompany.DataSource = list;
                ddlMachineLvlCompany.DataBind();
                BindPlantForMachine();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        private void BindPlantForMachine()
        {
            try
            {
                List<string> list = DBAccess.getPlantData(ddlMachineLvlCompany.SelectedValue);
                ddlMachineLvlPlant.DataSource = list;
                ddlMachineLvlPlant.DataBind();
               // BindCNCMakeForMachine();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        private void BindCNCMakeForMachine()
        {
            try
            {
                // List<string> list = DBAccess.getCNCMakeData(ddlMachineLvlCompany.SelectedValue, ddlMachineLvlPlant.SelectedValue);
                List<string> list = DBAccess.getCNCMakeData("", "");
                ddlMachineLvlCNCMake.DataSource = list;
                ddlMachineLvlCNCMake.DataBind();
                BindCNCModelForMachine();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        private void BindCNCModelForMachine()
        {
            try
            {
                // List<string> list = DBAccess.getCNCModelData(ddlMachineLvlCompany.SelectedValue, ddlMachineLvlPlant.SelectedValue, ddlMachineLvlCNCMake.SelectedValue);
                List<string> list = DBAccess.getCNCModelData("", "", ddlMachineLvlCNCMake.SelectedValue);
                ddlMachineLvlCNCModel.DataSource = list;
                ddlMachineLvlCNCModel.DataBind();
                //BindMTBForMachine();
               // BindMachineTypeForMachine();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        private void BindMTBForMachine()
        {
            try
            {
                // ddlMachineLvlMTB.DataSource = DBAccess.getMTBData(ddlMachineLvlCompany.SelectedValue, ddlMachineLvlPlant.SelectedValue, ddlMachineLvlCNCMake.SelectedValue, ddlMachineLvlCNCModel.SelectedValue);
                ddlMachineLvlMTB.DataSource = DBAccess.getMTBData("", "", "", "");
                ddlMachineLvlMTB.DataBind();
                BindMachineTypeForMachine();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        private void BindMachineTypeForMachine()
        {
            try
            {
                // ddlMachineLvlMachineType.DataSource = DBAccess.getMachineTypeData(ddlMachineLvlCompany.SelectedValue, ddlMachineLvlPlant.SelectedValue, ddlMachineLvlCNCMake.SelectedValue, ddlMachineLvlCNCModel.SelectedValue, ddlMachineLvlMTB.SelectedValue);
                ddlMachineLvlMachineType.DataSource = DBAccess.getMachineTypeData("", "", "", "", ddlMachineLvlMTB.SelectedValue);
                ddlMachineLvlMachineType.DataBind();
                BindMachineModelForMachine();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        private void BindMachineModelForMachine()
        {
            try
            {
                //ddlMachineLvlMachineModel.DataSource = DBAccess.getMachineModelData(ddlMachineLvlCompany.SelectedValue, ddlMachineLvlPlant.SelectedValue, ddlMachineLvlCNCMake.SelectedValue, ddlMachineLvlCNCModel.SelectedValue, ddlMachineLvlMTB.SelectedValue, ddlMachineLvlMachineType.SelectedValue);
                ddlMachineLvlMachineModel.DataSource = DBAccess.getMachineModelData("", "", "", "", ddlMachineLvlMTB.SelectedValue, ddlMachineLvlMachineType.SelectedValue);
                ddlMachineLvlMachineModel.DataBind();
                BindMachineIDForMachine();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        private void BindMachineIDForMachine()
        {
            try
            {
                //  ddlMachineLvlMachineID.DataSource = DBAccess.getMachineIDData(ddlMachineLvlCompany.SelectedValue, ddlMachineLvlPlant.SelectedValue, ddlMachineLvlCNCMake.SelectedValue, ddlMachineLvlCNCModel.SelectedValue, ddlMachineLvlMTB.SelectedValue, ddlMachineLvlMachineType.SelectedValue, ddlMachineLvlMachineModel.SelectedValue);
                ddlMachineLvlMachineID.DataSource = DBAccess.getMachineIDData(ddlMachineLvlCompany.SelectedValue, ddlMachineLvlPlant.SelectedValue, ddlMachineLvlCNCMake.SelectedValue, ddlMachineLvlCNCModel.SelectedValue, "", ddlMachineLvlMachineType.SelectedValue, ddlMachineLvlMachineModel.SelectedValue);
                ddlMachineLvlMachineID.DataBind();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        private void BindSourceTypeData(DropDownList ddl)
        {
            try
            {
                if (ddl == null)
                {
                    listSourceType = DBAccess.getSourceTypeData();
                }
                else
                {
                    ddl.DataSource = listSourceType;
                    ddl.DataBind();
                }
                
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        private void BindSourceDataTypeData(DropDownList ddl)
        {
            try
            {
                if (ddl == null)
                {
                    listSourceDataType = DBAccess.getSourceDataTypeData();
                    listSourceDataType.Insert(0, "None");
                    Session["SourceDataTypeList"] = listSourceDataType;
                }
                else
                {
                    ddl.DataSource = listSourceDataType;
                    ddl.DataBind();
                }
               // ddl.Items.Insert(0, new ListItem("None"));
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        private void BindPollingFrequencyData(DropDownList ddl)
        {
            try
            {
                if (ddl == null)
                {
                    listPollingFrequency = DBAccess.getPollingFrequencyData();
                }
                else
                {
                    ddl.DataSource = listPollingFrequency;
                    ddl.DataBind();
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        private void BindDataGroupData(DropDownList ddl)
        {
            try
            {
                if (ddl == null)
                {
                    listDataGroup = DBAccess.getDataGroupData();
                }
                else
                {
                    ddl.DataSource = listDataGroup;
                    ddl.DataBind();
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        private void BindPollingTypeData(DropDownList ddl)
        {
            try
            {
                if (ddl == null)
                {
                    listPollingType = DBAccess.getPollingTypeData();
                }
                else
                {
                    ddl.DataSource = listPollingType;
                    ddl.DataTextField = "text";
                    ddl.DataValueField = "value";
                    ddl.DataBind();
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        private void BindNoOfCycleData(DropDownList ddl)
        {
            try
            {
                if (ddl == null)
                {
                    listNumberOfCycle = DBAccess.getNumberOfCycleData();
                }
                else
                {
                    ddl.DataSource = listNumberOfCycle;
                    ddl.DataBind();
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        private void BindCycleFrequencyTimeData(DropDownList ddl)
        {
            try
            {
                if (ddl == null)
                {
                    listCycleFrequencyTime = DBAccess.getCycleFrequencyTimeData();
                }
                else
                {
                    ddl.DataSource = listCycleFrequencyTime;
                    ddl.DataBind();
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        private void BindUpperLowerUnitData(DropDownList ddl)
        {
            try
            {
                if (ddl == null)
                {
                    listUnit = DBAccess.getProcessParameterUpperLowerUnit();
                    listUnit.Insert(0,"None");
                }
                else
                {
                    ddl.DataSource = listUnit;
                    ddl.DataBind();
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        private void addDropDownValuesToList()
        {
            BindSourceTypeData(null);
            BindSourceDataTypeData(null);
            BindSourceDataTypeData(null);
            BindPollingFrequencyData(null);
            BindDataGroupData(null);
            BindPollingTypeData(null);
            BindCycleFrequencyTimeData(null);
            BindNoOfCycleData(null);
            BindUpperLowerUnitData(null);
        }
        private void getParmeterWiseValidationList()
        {
            try
            {
                List<ParameterWiseValidationData> list = DBAccess.getProcessParmeterWiseValidationList();
                Session["ParameterWiseValidationData"] = list;
            }
            catch(Exception ex)
            {

            }
        }
        private void getSourceTypeWiseValidationList()
        {
            try
            {
                List<SourceTypeWiseValidationData> list = DBAccess.getSourceTypeWiseValidationList();
                Session["SourceTypeWiseValidationData"] = list;
            }
            catch (Exception ex)
            {

            }
        }
        private string getSourceAddressClass(List<string> param)
        {
            string result = "";
            if (param.Contains("Number"))
            {
                result = "allowNumber";
            }
            else if (param.Contains("StartWithChar"))
            {
                result = "allowStartWithChar";
            }
            else if (param.Contains("Float"))
            {
                result = "allowDecimal";
            }
            return result;
        }
        private bool isSourceAddandTypeMandatory(string sourceType,string param)
        {
            bool isMandatory = false;
            if (Session["SourceTypeWiseValidationData"] == null)
            {
                getSourceTypeWiseValidationList();
            }
            listSourceTypeWiseValidation = Session["SourceTypeWiseValidationData"] as List<SourceTypeWiseValidationData>;
            var result = listSourceTypeWiseValidation.Where(w => w.SourceType == sourceType && w.IsEnabled==true).ToList();
            if (result.Count > 0)
            {
                SourceTypeWiseValidationData stValidationData = result[0];
                if(param=="Address1")
                {
                    if(stValidationData.SourceAdd1.Contains("Mandatory"))
                    {
                        isMandatory = true;
                    }
                }
                else if (param == "Address2")
                {
                    if (stValidationData.SourceAdd2.Contains("Mandatory"))
                    {
                        isMandatory = true;
                    }
                }
                else if (param == "DataType1")
                {
                    if (stValidationData.DataType1Condition.Contains("Mandatory"))
                    {
                        isMandatory = true;
                    }
                }
                else if (param == "DataType2")
                {
                    if (stValidationData.DataType2Condition.Contains("Mandatory"))
                    {
                        isMandatory = true;
                    }
                }
            }
            return isMandatory;
        }
        private bool isSourceAddOrTypeContainValidationParam(string sourceType, string param,string validationParam)
        {
            bool isControlEnabled = false;
            if (Session["SourceTypeWiseValidationData"] == null)
            {
                getSourceTypeWiseValidationList();
            }
            listSourceTypeWiseValidation = Session["SourceTypeWiseValidationData"] as List<SourceTypeWiseValidationData>;
            var result = listSourceTypeWiseValidation.Where(w => w.SourceType == sourceType).ToList();
            if (result.Count > 0)
            {
                SourceTypeWiseValidationData stValidationData = result[0];
                if (param == "Address1")
                {
                    if (stValidationData.SourceAdd1.Contains(validationParam))
                    {
                        isControlEnabled = true;
                    }
                }
                else if (param == "Address2")
                {
                    if (stValidationData.SourceAdd2.Contains(validationParam))
                    {
                        isControlEnabled = true;
                    }
                }
                else if (param == "DataType1")
                {
                    if (stValidationData.DataType1Condition.Contains(validationParam))
                    {
                        isControlEnabled = true;
                    }
                }
                else if (param == "DataType2")
                {
                    if (stValidationData.DataType2Condition.Contains(validationParam))
                    {
                        isControlEnabled = true;
                    }
                }
            }
            return isControlEnabled;
        }
        private void setSourceAddressAndDataType(string sourcetype, TextBox txtSAdd1, TextBox txtSAdd2, DropDownList ddlSDataType1, DropDownList ddlSDataType2,string hdnDataType1, string hdnDataType2,int index)
        {
            try
            {
                bool isOkayToAssign = false;
                if (index >= 0)
                {
                    isOkayToAssign = true;
                }
                if (isOkayToAssign)
                {
                    allLevelDataForPDF[index].SrcDataType1PDF = "";
                    allLevelDataForPDF[index].SrcDataType2PDF = "";
                }
                //allLevelDataForPDF[index].IsDataType1Enabled = true;
                // allLevelDataForPDF[index].IsDataType2Enabled = true;
                int flag = 0;
                if (Session["SourceTypeWiseValidationData"] == null)
                {
                    getSourceTypeWiseValidationList();
                }
                if (Session["SourceDataTypeList"] != null)
                {
                    listSourceDataType = (List<string>)Session["SourceDataTypeList"];
                }
                listSourceTypeWiseValidation = Session["SourceTypeWiseValidationData"] as List<SourceTypeWiseValidationData>;
                if (listSourceTypeWiseValidation.Count > 0)
                {
                    var result = listSourceTypeWiseValidation.Where(w => w.SourceType == sourcetype).ToList();
                    if (result.Count>0)
                    {
                        SourceTypeWiseValidationData stValidationData = result[0];
                        if (stValidationData.IsEnabled)
                        {
                            txtSAdd1.Visible = true;
                            txtSAdd2.Visible = true;
                            ddlSDataType1.Visible = true;
                            ddlSDataType2.Visible = true;
                            string existingclass = "";
                            bool isControlEnabled =!(isSourceAddOrTypeContainValidationParam(sourcetype, "Address1","Hide"));
                            //check cotrol visibility
                            txtSAdd1.Visible = isControlEnabled;
                            if (isControlEnabled)
                            {

                                existingclass = txtSAdd1.CssClass;
                                List<string> existingCsList = existingclass.Split(' ').ToList();
                                existingclass = "";
                                //Remove the class contain "Allow" - means remove old class
                                for (int i = existingCsList.Count - 1; i >= 0; i--)
                                {
                                    if (existingCsList[i].Contains("allow"))
                                    {
                                        existingCsList.RemoveAt(i);
                                    }
                                    else
                                    {
                                        existingclass = existingclass + existingCsList[i];
                                    }
                                }
                                txtSAdd1.CssClass = existingclass + " " + getSourceAddressClass(stValidationData.SourceAdd1);
                            }

                            isControlEnabled = !(isSourceAddOrTypeContainValidationParam(sourcetype, "Address2","Hide"));
                            txtSAdd2.Visible = isControlEnabled;
                            if (isControlEnabled)
                            {
                                existingclass = txtSAdd2.CssClass;
                                List<string> existingCsList = existingclass.Split(' ').ToList();
                                existingclass = "";
                                //Remove the class contain "Allow" - means remove old class
                                for (int i = existingCsList.Count - 1; i >= 0; i--)
                                {
                                    if (existingCsList[i].Contains("allow"))
                                    {
                                        existingCsList.RemoveAt(i);
                                    }
                                    else
                                    {
                                        existingclass = existingclass + existingCsList[i];
                                    }
                                }
                                txtSAdd2.CssClass = existingclass + " " + getSourceAddressClass(stValidationData.SourceAdd2);
                            }
                            if (ddlSDataType1 != null)
                            {
                                isControlEnabled = !(isSourceAddOrTypeContainValidationParam(sourcetype, "DataType1","Hide"));
                                ddlSDataType1.Visible = isControlEnabled;
                                if (isControlEnabled)
                                {
                                    bool removeNone = isSourceAddOrTypeContainValidationParam(sourcetype, "DataType1", "RemoveNone");
                                    //if data is not defined ( in validation master), show dropdown values from datatype master
                                    if (stValidationData.SourceDataType1[1].Trim() == "" && stValidationData.SourceDataType1.Count == 2)
                                    {
                                        List<string> datatypeList = new List<string>();
                                        datatypeList.AddRange(listSourceDataType);
                                        if (removeNone)
                                        {
                                            datatypeList.Remove("None");
                                        }
                                        ddlSDataType1.DataSource = datatypeList;
                                        ddlSDataType1.DataBind();
                                    }
                                    else
                                    {
                                        List<string> datatypeList = new List<string>();
                                        datatypeList.AddRange(stValidationData.SourceDataType1);
                                        if (removeNone)
                                        {
                                            if (datatypeList != null && datatypeList.Count > 0)
                                            {
                                                datatypeList.Remove("None");
                                            }
                                        }
                                        ddlSDataType1.DataSource = datatypeList;
                                        ddlSDataType1.DataBind();
                                    }

                                    if (hdnDataType1 != "")
                                    {
                                        ddlSDataType1.SelectedValue = hdnDataType1;
                                    }
                                    if (isOkayToAssign)
                                    {
                                        allLevelDataForPDF[index].SrcDataType1PDF = ddlSDataType1.SelectedValue;
                                    }
                                }
                            }
                            if (ddlSDataType2 != null)
                            {
                                isControlEnabled = !(isSourceAddOrTypeContainValidationParam(sourcetype, "DataType2","Hide"));
                                ddlSDataType2.Visible = isControlEnabled;
                                if (isControlEnabled)
                                {
                                    bool removeNone = isSourceAddOrTypeContainValidationParam(sourcetype, "DataType2", "RemoveNone");
                                    if (stValidationData.SourceDataType2[1].Trim() == "" && stValidationData.SourceDataType2.Count == 2)
                                    {
                                        List<string> datatypeList = new List<string>();
                                        datatypeList.AddRange(listSourceDataType);
                                        if (removeNone)
                                        {
                                            datatypeList.Remove("None");
                                        }
                                        ddlSDataType2.DataSource = datatypeList;
                                        ddlSDataType2.DataBind();

                                    }
                                    else
                                    {
                                        List<string> datatypeList = new List<string>();
                                        datatypeList.AddRange(stValidationData.SourceDataType2);
                                        if (removeNone)
                                        {
                                            if (datatypeList != null && datatypeList.Count > 0)
                                            {
                                                datatypeList.Remove("None");
                                            }
                                        }
                                        ddlSDataType2.DataSource = datatypeList;
                                        ddlSDataType2.DataBind();
                                    }

                                    if (hdnDataType2 != "")
                                    {
                                        ddlSDataType2.SelectedValue = hdnDataType2;
                                    }
                                    if (isOkayToAssign)
                                    {
                                        allLevelDataForPDF[index].SrcDataType2PDF = ddlSDataType2.SelectedValue;
                                    }
                                }
                            }
                        }
                        else
                        {
                            txtSAdd1.Visible = false;
                            txtSAdd2.Visible = false;
                            ddlSDataType1.Visible = false;
                            ddlSDataType2.Visible = false;
                            if (isOkayToAssign)
                            {
                                allLevelDataForPDF[index].SrcDataType1PDF = "";
                                allLevelDataForPDF[index].SrcDataType2PDF = "";
                            }
                        }
                    }
                    else
                    {
                        flag = 1;
                     
                    }
                }
                else
                {
                    flag = 1;
                }
                if (flag == 1)
                {
                    txtSAdd1.Visible = true;
                    txtSAdd2.Visible = true;
                    ddlSDataType1.Visible = true;
                    if (ddlSDataType1 != null)
                    {
                        ddlSDataType1.DataSource = listSourceDataType;
                        ddlSDataType1.DataBind();
                        if (hdnDataType1 != "")
                        {
                            ddlSDataType1.SelectedValue = hdnDataType1;
                        }
                        if (isOkayToAssign)
                        {
                            allLevelDataForPDF[index].SrcDataType1PDF = ddlSDataType1.SelectedValue;
                        }
                    }
                    ddlSDataType2.Visible = true;
                    if (ddlSDataType2 != null)
                    {
                        ddlSDataType2.DataSource = listSourceDataType;
                        ddlSDataType2.DataBind();
                        if (hdnDataType2 != "")
                        {
                            ddlSDataType2.SelectedValue = hdnDataType2;
                        }
                        if (isOkayToAssign)
                        {
                            allLevelDataForPDF[index].SrcDataType2PDF = ddlSDataType2.SelectedValue;
                        }
                    }
                }
            }
            catch(Exception ex)
            {

            }
        }
        private void setPollingFreqencyValidation(string parameter,DropDownList ddlPollingFrq,string hdnFreq)
        {
            try
            {
                if (Session["ParameterWiseValidationData"] == null)
                {
                    getParmeterWiseValidationList();
                }
                listParameterWiseValidation = Session["ParameterWiseValidationData"] as List<ParameterWiseValidationData>;
                if (ddlPollingFrq != null)
                {
                    if (listParameterWiseValidation.Count > 0)
                    {
                        var result = listParameterWiseValidation.Where(w => w.Parameter == parameter).ToList();
                        if (result.Count > 0)
                        {
                            ParameterWiseValidationData validationData = result[0];
                            ddlPollingFrq.DataSource = validationData.PolliFreq;
                            ddlPollingFrq.DataBind();
                            ddlPollingFrq.SelectedValue = hdnFreq;
                        }
                        else
                        {
                            ddlPollingFrq.DataSource = listPollingFrequency;
                            ddlPollingFrq.DataBind();
                            ddlPollingFrq.SelectedValue = hdnFreq;
                        }
                    }
                    else
                    {
                        ddlPollingFrq.DataSource = listPollingFrequency;
                        ddlPollingFrq.DataBind();
                        ddlPollingFrq.SelectedValue = hdnFreq;
                    }
                }
            }
            catch(Exception ex)
            {

            }
        }
        private void BindControllerLevelData()
        {
            try
            {
                if (ddlControlLvlCNCMake.SelectedValue == "")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select CNC Make.');", true);
                    return;
                }
                if (ddlControlLvlCNCModel.SelectedValue == "")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select CNC Model.');", true);
                    return;
                }
                addDropDownValuesToList();
                if (Session["ParameterWiseValidationData"] != null)
                {
                    listParameterWiseValidation= Session["ParameterWiseValidationData"] as List<ParameterWiseValidationData>;
                }
                if (Session["SourceTypeWiseValidationData"] != null)
                {
                    listSourceTypeWiseValidation = Session["SourceTypeWiseValidationData"] as List<SourceTypeWiseValidationData>;
                }
                List<ProcessParameterMasterData> list = DBAccess.getProcessParameterControllerLevelData(ddlControlLvlCNCMake.SelectedValue, ddlControlLvlCNCModel.SelectedValue, "", "");
                int listcountFlag = 0;
                if (list.Count == 0)
                {
                    listcountFlag = 1;
                    list.Add(new ProcessParameterMasterData());
                }
                allLevelDataForPDF = list;
                gvControllerLvlData.DataSource = list;
                gvControllerLvlData.DataBind();
                if (listcountFlag == 1)
                {
                    gvControllerLvlData.Rows[0].Visible = false;
                }
                DropDownList ddl;
                ddl = gvControllerLvlData.FooterRow.FindControl("ddlSourceTypeNew") as DropDownList;
                BindSourceTypeData(ddl);
                ddlSourceTypeNewController_SelectedIndexChanged(null, null);
                //ddl = gvControllerLvlData.FooterRow.FindControl("ddlDataType1New") as DropDownList;
                //BindSourceDataTypeData(ddl);
                //ddl = gvControllerLvlData.FooterRow.FindControl("ddlDataType2New") as DropDownList;
                //BindSourceDataTypeData(ddl);
                ddl = gvControllerLvlData.FooterRow.FindControl("ddlPollingFrequencyNew") as DropDownList;
                BindPollingFrequencyData(ddl);
                ddl = gvControllerLvlData.FooterRow.FindControl("ddlDataGroupNew") as DropDownList;
                BindDataGroupData(ddl);
                ddl = gvControllerLvlData.FooterRow.FindControl("ddlPollingTypeNew") as DropDownList;
                BindPollingTypeData(ddl);
                //if (ddl.SelectedValue == "ReadBasedOnCustomTimePeriod") //kkkkk
                //{
                //    ddlPollingTypeNewController_SelectedIndexChanged(ddl, null);
                //}
                ddl = gvControllerLvlData.FooterRow.FindControl("ddlCycleFrequencyTimeNew") as DropDownList;
                BindCycleFrequencyTimeData(ddl);
                ddl = gvControllerLvlData.FooterRow.FindControl("ddlNoOfCycleNew") as DropDownList;
                BindNoOfCycleData(ddl);
                ddl = gvControllerLvlData.FooterRow.FindControl("ddlUnitNew") as DropDownList;
                BindUpperLowerUnitData(ddl);
                Session["ProcessParamMasterData"] = allLevelDataForPDF;
            }
            catch (Exception ex)
            { }
        }
      
        protected void gvControllerLvlData_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int index = e.Row.RowIndex;
                string hdnvalue = "";
                DropDownList ddl = new DropDownList();
                //string hdnvalue = (e.Row.FindControl("hdnSourceType") as HiddenField).Value;
               // DropDownList ddl = (e.Row.FindControl("ddlSourceType") as DropDownList);
               // ddl.DataSource = listSourceType;
                //ddl.DataBind();
               // ddl.SelectedValue = hdnvalue;

                string sourceType= (e.Row.FindControl("lblSourceType") as Label).Text;
                setSourceAddressAndDataType(sourceType, (e.Row.FindControl("txtSourceAdd1") as TextBox), (e.Row.FindControl("txtSourceAdd2") as TextBox), (e.Row.FindControl("ddlDataType1") as DropDownList), (e.Row.FindControl("ddlDataType2") as DropDownList), (e.Row.FindControl("hdnDataType1") as HiddenField).Value, (e.Row.FindControl("hdnDataType2") as HiddenField).Value,index);

                string parameter = (e.Row.FindControl("lblParemeterID") as Label).Text;
                setPollingFreqencyValidation(parameter, (e.Row.FindControl("ddlPollingFrequency") as DropDownList), (e.Row.FindControl("hdnPollingFrequency") as HiddenField).Value);
               
                
                ddl = (e.Row.FindControl("ddlDataGroup") as DropDownList);
                if (ddl != null)
                {
                    hdnvalue = (e.Row.FindControl("hdnDataGroup") as HiddenField).Value;
                    ddl.DataSource = listDataGroup;
                    ddl.DataBind();
                    ddl.SelectedValue = hdnvalue;
                }
                ddl = (e.Row.FindControl("ddlPollingType") as DropDownList);
                if (ddl != null)
                {
                    hdnvalue = (e.Row.FindControl("hdnPollingType") as HiddenField).Value;
                    ddl.DataSource = listPollingType;
                    ddl.DataTextField = "text";
                    ddl.DataValueField = "value";
                    ddl.DataBind();
                    ddl.SelectedValue = hdnvalue;                    
                    if (hdnvalue == "ReadBasedOnCustomTimePeriod") //kkkk
                    {
                        (e.Row.FindControl("ddlCycleFrequencyTime") as DropDownList).Visible = false;
                        (e.Row.FindControl("ddlNoOfCycle") as DropDownList).Visible = false;
                    }
                    else
                    {
                        (e.Row.FindControl("ddlCycleFrequencyTime") as DropDownList).Visible = true;
                        (e.Row.FindControl("ddlNoOfCycle") as DropDownList).Visible = true;
                    }
                }
                ddl = (e.Row.FindControl("ddlCycleFrequencyTime") as DropDownList);
                if (ddl != null)
                {
                    hdnvalue = (e.Row.FindControl("hdnCycleFreqTime") as HiddenField).Value;
                    ddl.DataSource = listCycleFrequencyTime;
                    ddl.DataBind();
                    if (hdnvalue != "")  //kkkk
                    {
                        ddl.SelectedValue = hdnvalue;
                    }
                }
                ddl = (e.Row.FindControl("ddlNoOfCycle") as DropDownList);
                if (ddl != null)
                {
                    hdnvalue = (e.Row.FindControl("hdnNoOfCycle") as HiddenField).Value;
                    ddl.DataSource = listNumberOfCycle;
                    ddl.DataBind();
                    if (hdnvalue != "")  //kkkk
                    {
                        ddl.SelectedValue = hdnvalue;
                    }
                }
                ddl = (e.Row.FindControl("ddlUnit") as DropDownList);
                if (ddl != null)
                {
                    hdnvalue = (e.Row.FindControl("hdnUnit") as HiddenField).Value;
                    ddl.DataSource = listUnit;
                    ddl.DataBind();
                    if (hdnvalue != "")
                    {
                        ddl.SelectedValue = hdnvalue;
                    }
                    else
                    {
                        ddl.SelectedValue = "None";
                    }
                   
                }
            }
        }

        protected void btnInsertControllerLevel_Click(object sender, EventArgs e)
        {
            try
            {
                ProcessParameterMasterData data = new ProcessParameterMasterData();
                //data.Company = ddlControlLvlCompany.SelectedValue;
                //data.Plant = ddlControlLvlPlant.SelectedValue;
                data.Company ="";
                data.Plant = "";
                data.CNCMake = ddlControlLvlCNCMake.SelectedValue;
                data.CNCModel = ddlControlLvlCNCModel.SelectedValue;
                data.ParemeterID = (gvControllerLvlData.FooterRow.FindControl("txtParameterIDNew") as TextBox).Text.Trim();
                data.SourceType = (gvControllerLvlData.FooterRow.FindControl("ddlSourceTypeNew") as DropDownList).SelectedValue;
                data.SourceAdd1 = (gvControllerLvlData.FooterRow.FindControl("txtSourceAdd1New") as TextBox).Text;
                data.SourceDatatype1 = (gvControllerLvlData.FooterRow.FindControl("ddlDataType1New") as DropDownList).Text;
                data.SourceAdd2 = (gvControllerLvlData.FooterRow.FindControl("txtSourceAdd2New") as TextBox).Text;
                data.SourceDatatype2 = (gvControllerLvlData.FooterRow.FindControl("ddlDataType2New") as DropDownList).Text;
                data.PollingFrequency = (gvControllerLvlData.FooterRow.FindControl("ddlPollingFrequencyNew") as DropDownList).Text;
                data.DataGroup = (gvControllerLvlData.FooterRow.FindControl("ddlDataGroupNew") as DropDownList).Text;
                data.PollingType = (gvControllerLvlData.FooterRow.FindControl("ddlPollingTypeNew") as DropDownList).Text;
                data.CycleFreqTime = (gvControllerLvlData.FooterRow.FindControl("ddlCycleFrequencyTimeNew") as DropDownList).Text;
                data.NoOfCycle = (gvControllerLvlData.FooterRow.FindControl("ddlNoOfCycleNew") as DropDownList).Text;
                data.IsEnabled = (gvControllerLvlData.FooterRow.FindControl("chkIsEnabledNew") as CheckBox).Checked;
                data.ShouldNotBeDisabled = (gvControllerLvlData.FooterRow.FindControl("chkShouldNotBeDisabledNew") as CheckBox).Checked;
                data.UpperWarning = (gvControllerLvlData.FooterRow.FindControl("txtUpperWarningNew") as TextBox).Text.Trim(); 
                data.LowerWarning = (gvControllerLvlData.FooterRow.FindControl("txtLowerWarningNew") as TextBox).Text.Trim();
                data.UpperError = (gvControllerLvlData.FooterRow.FindControl("txtUpperErrorNew") as TextBox).Text.Trim();
                data.LowerError = (gvControllerLvlData.FooterRow.FindControl("txtLowerErrorNew") as TextBox).Text.Trim();
                data.Unit = (gvControllerLvlData.FooterRow.FindControl("ddlUnitNew") as DropDownList).SelectedValue;
                //if (data.Company == "" || data.Company == null)
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Company.');", true);
                //    return;
                //}
                //if (data.Plant == "" || data.Plant == null)
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Plant.');", true);
                //    return;
                //}
                if (data.CNCMake == "" || data.CNCMake == null)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select CNC Make.');", true);
                    return;
                }
                if (data.CNCModel == "" || data.CNCModel == null)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Series / Model.');", true);
                    return;
                }
                if (data.ParemeterID == "")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Parameter ID.');", true);
                    return;
                }
                if (isSourceAddandTypeMandatory(data.SourceType, "Address1"))
                {
                    if (data.SourceAdd1 == "")
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Source Address 1.');", true);
                        return;
                    }
                }
                if (isSourceAddandTypeMandatory(data.SourceType, "DataType1"))
                {
                    if (data.SourceDatatype1 == "" || data.SourceDatatype1 == null)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Source Data Type 1.');", true);
                        return;
                    }
                }
                if (isSourceAddandTypeMandatory(data.SourceType, "Address2"))
                {
                    if (data.SourceAdd2 == "")
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Source Address 2.');", true);
                        return;
                    }
                }
                if (isSourceAddandTypeMandatory(data.SourceType, "DataType2"))
                {
                    if (data.SourceDatatype2 == "" || data.SourceDatatype2 == null)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Source Data Type 2.');", true);
                        return;
                    }
                }
                if (data.UpperWarning != "" || data.UpperError != "")
                {
                    double uw = Convert.ToDouble(data.UpperWarning);
                    double ue = Convert.ToDouble(data.UpperError);
                    if (ue <= uw)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Upper Error Limit should be greater than Upper Warning Limit.');", true);
                        return;
                    }
                }
                if (data.LowerError != "" || data.LowerWarning != "")
                {
                    double lw = Convert.ToDouble(data.LowerWarning);
                    double le = Convert.ToDouble(data.LowerError);
                    if (le >= lw)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Lower Error Limit should be less than Lower Warning Limit.');", true);
                        return;
                    }
                }
                //if (data.SourceType == "" || data.SourceType == null)
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Source Type.');", true);
                //    return;
                //}
                //if (data.SourceAdd1 == "")
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Source Address 1.');", true);
                //    return;
                //}
                //if (data.SourceDatatype1 == "" || data.SourceDatatype1 == null)
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Source Data Type 1.');", true);
                //    return;
                //}
                //if (data.SourceAdd2 == "")
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Source Address 2.');", true);
                //    return;
                //}
                //if (data.SourceDatatype2 == "" || data.SourceDatatype2 == null)
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Source Data Type 2.');", true);
                //    return;
                //}
                //if (data.PollingFrequency == "" || data.PollingFrequency == null)
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Polling Frequency.');", true);
                //    return;
                //}
                //if (data.DataGroup == "" || data.DataGroup == null)
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Data Group.');", true);
                //    return;
                //}
                //if (data.PollingType == "" || data.PollingType == null)
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Polling Type.');", true);
                //    return;
                //}
                //if (data.PollingType != "ReadBasedOnCustomTimePeriod")
                //{
                //    if (data.CycleFreqTime == "" || data.CycleFreqTime == null)
                //    {
                //        ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Cycle Frequency Time.');", true);
                //        return;
                //    }
                //    if (data.NoOfCycle == "" || data.NoOfCycle == null)
                //    {
                //        ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select No. of Cycles.');", true);
                //        return;
                //    }
                //}
                //if (data.UpperWarning == "")
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Upper Warning Limit.');", true);
                //    return;
                //}
                //if (data.LowerWarning == "")
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Lower Warning Limit.');", true);
                //    return;
                //}
                //if (data.UpperError == "")
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Upper Error Limit.');", true);
                //    return;
                //}
                //if (data.LowerError == "")
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Lower Error Limit.');", true);
                //    return;
                //}
                //if (data.Unit == "")
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Unit.');", true);
                //    return;
                //}
                int result;
                DBAccess.insertUpdateProcessParameterControllerData(data, "ControllerLevel",out result);
                if (result == 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openErrorModal('Failed to insert record.');", true);
                    return;
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "success", "showSuccessMsg('Record saved Successfully.','');", true);
                }
                BindControllerLevelData();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }


        protected void ddlPollingTypeNew_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddl = sender as DropDownList;
            if (ddl.SelectedValue == "ReadBasedOnCustomTimePeriod")
            {
                (gvMTBModeldata.FooterRow.FindControl("ddlCycleFrequencyTimeNew") as DropDownList).Visible = false;
                (gvMTBModeldata.FooterRow.FindControl("ddlNoOfCycleNew") as DropDownList).Visible = false;
            }
            else
            {
                (gvMTBModeldata.FooterRow.FindControl("ddlCycleFrequencyTimeNew") as DropDownList).Visible = true;
                (gvMTBModeldata.FooterRow.FindControl("ddlNoOfCycleNew") as DropDownList).Visible = true;
            }
        }

        protected void ddlPollingTypeModel_SelectedIndexChanged(object sender, EventArgs e)
        {
            int rowIndex = Convert.ToInt32(((sender as DropDownList).NamingContainer as GridViewRow).RowIndex);
            DropDownList ddl = sender as DropDownList;
            if (ddl.SelectedValue == "ReadBasedOnCustomTimePeriod")
            {
                (gvMTBModeldata.Rows[rowIndex].FindControl("ddlCycleFrequencyTime") as DropDownList).Visible = false;
                (gvMTBModeldata.Rows[rowIndex].FindControl("ddlNoOfCycle") as DropDownList).Visible = false;
            }
            else
            {
                (gvMTBModeldata.Rows[rowIndex].FindControl("ddlCycleFrequencyTime") as DropDownList).Visible = true;
                (gvMTBModeldata.Rows[rowIndex].FindControl("ddlNoOfCycle") as DropDownList).Visible = true;
            }
        }
        protected void ddlPollingTypeNewModel_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddl = sender as DropDownList;
            if (ddl.SelectedValue == "ReadBasedOnCustomTimePeriod")
            {
                (gvMTBModeldata.FooterRow.FindControl("ddlCycleFrequencyTimeNew") as DropDownList).Visible = false;
                (gvMTBModeldata.FooterRow.FindControl("ddlNoOfCycleNew") as DropDownList).Visible = false;
            }
            else
            {
                (gvMTBModeldata.FooterRow.FindControl("ddlCycleFrequencyTimeNew") as DropDownList).Visible = true;
                (gvMTBModeldata.FooterRow.FindControl("ddlNoOfCycleNew") as DropDownList).Visible = true;
            }
        }
        protected void ddlPollingTypeController_SelectedIndexChanged(object sender, EventArgs e)
        {
            int rowIndex = Convert.ToInt32(((sender as DropDownList).NamingContainer as GridViewRow).RowIndex);
            DropDownList ddl = sender as DropDownList;
            if (ddl.SelectedValue == "ReadBasedOnCustomTimePeriod")
            {
                (gvControllerLvlData.Rows[rowIndex].FindControl("ddlCycleFrequencyTime") as DropDownList).Visible = false;
                (gvControllerLvlData.Rows[rowIndex].FindControl("ddlNoOfCycle") as DropDownList).Visible = false;
            }
            else
            {
                (gvControllerLvlData.Rows[rowIndex].FindControl("ddlCycleFrequencyTime") as DropDownList).Visible = true;
                (gvControllerLvlData.Rows[rowIndex].FindControl("ddlNoOfCycle") as DropDownList).Visible = true;
            }
        }

        protected void ddlPollingTypeNewController_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddl = sender as DropDownList;
            if (ddl.SelectedValue == "ReadBasedOnCustomTimePeriod")
            {
                (gvControllerLvlData.FooterRow.FindControl("ddlCycleFrequencyTimeNew") as DropDownList).Visible = false;
                (gvControllerLvlData.FooterRow.FindControl("ddlNoOfCycleNew") as DropDownList).Visible = false;
            }
            else
            {
                (gvControllerLvlData.FooterRow.FindControl("ddlCycleFrequencyTimeNew") as DropDownList).Visible = true;
                (gvControllerLvlData.FooterRow.FindControl("ddlNoOfCycleNew") as DropDownList).Visible = true;
            }
        }

        protected void ddlPollingTypeMachineLvl_SelectedIndexChanged(object sender, EventArgs e)
        {
            int rowIndex = Convert.ToInt32(((sender as DropDownList).NamingContainer as GridViewRow).RowIndex);
            DropDownList ddl = sender as DropDownList;
            if (ddl.SelectedValue == "ReadBasedOnCustomTimePeriod")
            {
                (gvMAchineLvlData.Rows[rowIndex].FindControl("ddlCycleFrequencyTime") as DropDownList).Visible = false;
                (gvMAchineLvlData.Rows[rowIndex].FindControl("ddlNoOfCycle") as DropDownList).Visible = false;
            }
            else
            {
                (gvMAchineLvlData.Rows[rowIndex].FindControl("ddlCycleFrequencyTime") as DropDownList).Visible = true;
                (gvMAchineLvlData.Rows[rowIndex].FindControl("ddlNoOfCycle") as DropDownList).Visible = true;
            }
        }

        protected void ddlPollingTypeNewMachineLvl_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddl = sender as DropDownList;
            if (ddl.SelectedValue == "ReadBasedOnCustomTimePeriod")
            {
                (gvMAchineLvlData.FooterRow.FindControl("ddlCycleFrequencyTimeNew") as DropDownList).Visible = false;
                (gvMAchineLvlData.FooterRow.FindControl("ddlNoOfCycleNew") as DropDownList).Visible = false;
            }
            else
            {
                (gvMAchineLvlData.FooterRow.FindControl("ddlCycleFrequencyTimeNew") as DropDownList).Visible = true;
                (gvMAchineLvlData.FooterRow.FindControl("ddlNoOfCycleNew") as DropDownList).Visible = true;
            }
        }

        protected void btnControllerView_Click(object sender, EventArgs e)
        {
            BindControllerLevelData();
        }

        protected void btnControllerSave_Click(object sender, EventArgs e)
        {
            try
            {
                bool showSuccessFlag = false;
                for (int i = 0; i < gvControllerLvlData.Rows.Count; i++)
                {
                    string updatedValue = (gvControllerLvlData.Rows[i].FindControl("hdnUpdate") as HiddenField).Value;
                    if (string.Equals("updated", updatedValue, StringComparison.OrdinalIgnoreCase))
                    {
                        (gvControllerLvlData.Rows[i].FindControl("hdnUpdate") as HiddenField).Value = "";
                        ProcessParameterMasterData data = new ProcessParameterMasterData();
                        //data.Company = ddlControlLvlCompany.SelectedValue;
                        //data.Plant = ddlControlLvlPlant.SelectedValue;
                        data.Company = "";
                        data.Plant = "";
                        data.CNCMake = ddlControlLvlCNCMake.SelectedValue;
                        data.CNCModel = ddlControlLvlCNCModel.SelectedValue;
                        data.MTB = "";
                        data.MachineType = "";
                        data.MachineModel = "";
                        data.MachineID = "";
                        data.ParemeterID = (gvControllerLvlData.Rows[i].FindControl("lblParemeterID") as Label).Text;
                        //data.SourceType = (gvControllerLvlData.Rows[i].FindControl("ddlSourceType") as DropDownList).SelectedValue;
                        data.SourceType = (gvControllerLvlData.Rows[i].FindControl("lblSourceType") as Label).Text;
                        data.SourceAdd1 = (gvControllerLvlData.Rows[i].FindControl("txtSourceAdd1") as TextBox).Text;
                        data.SourceDatatype1 = (gvControllerLvlData.Rows[i].FindControl("ddlDataType1") as DropDownList).Text;
                        data.SourceAdd2 = (gvControllerLvlData.Rows[i].FindControl("txtSourceAdd2") as TextBox).Text;
                        data.SourceDatatype2 = (gvControllerLvlData.Rows[i].FindControl("ddlDataType2") as DropDownList).Text;
                        data.PollingFrequency = (gvControllerLvlData.Rows[i].FindControl("ddlPollingFrequency") as DropDownList).Text;
                        data.DataGroup = (gvControllerLvlData.Rows[i].FindControl("ddlDataGroup") as DropDownList).Text;
                        data.PollingType = (gvControllerLvlData.Rows[i].FindControl("ddlPollingType") as DropDownList).Text;
                        data.CycleFreqTime = (gvControllerLvlData.Rows[i].FindControl("ddlCycleFrequencyTime") as DropDownList).Text;
                        data.NoOfCycle = (gvControllerLvlData.Rows[i].FindControl("ddlNoOfCycle") as DropDownList).Text;
                        data.IsEnabled = (gvControllerLvlData.Rows[i].FindControl("chkIsEnabled") as CheckBox).Checked;
                        data.ShouldNotBeDisabled = (gvControllerLvlData.Rows[i].FindControl("chkShouldNotBeDisabled") as CheckBox).Checked;
                        data.UpperWarning = (gvControllerLvlData.Rows[i].FindControl("txtUpperWarning") as TextBox).Text.Trim();
                        data.LowerWarning = (gvControllerLvlData.Rows[i].FindControl("txtLowerWarning") as TextBox).Text.Trim();
                        data.UpperError = (gvControllerLvlData.Rows[i].FindControl("txtUpperError") as TextBox).Text.Trim();
                        data.LowerError = (gvControllerLvlData.Rows[i].FindControl("txtLowerError") as TextBox).Text.Trim();
                        data.Unit = (gvControllerLvlData.Rows[i].FindControl("ddlUnit") as DropDownList).SelectedValue;
                        //if (data.Company == "" || data.Company == null)
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Company.');", true);
                        //    return;
                        //}
                        //if (data.Plant == "" || data.Plant == null)
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Plant.');", true);
                        //    return;
                        //}
                        if (data.CNCMake == "" || data.CNCMake == null)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select CNC Make.');", true);
                            return;
                        }
                        if (data.CNCModel == "" || data.CNCModel == null)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Series / Model.');", true);
                            return;
                        }
                        if (data.ParemeterID == "")
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Parameter ID.');", true);
                            return;
                        }
                        if (isSourceAddandTypeMandatory(data.SourceType, "Address1"))
                        {
                            if (data.SourceAdd1 == "")
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Source Address 1 for Parameter ID " + data.ParemeterID + ".');", true);
                                return;
                            }
                        }
                        if (isSourceAddandTypeMandatory(data.SourceType, "DataType1"))
                        {
                            if (data.SourceDatatype1 == "" || data.SourceDatatype1 == null)
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Source Data Type 1 for Parameter ID " + data.ParemeterID + ".');", true);
                                return;
                            }
                        }
                        if (isSourceAddandTypeMandatory(data.SourceType, "Address2"))
                        {
                            if (data.SourceAdd2 == "")
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Source Address 2 for Parameter ID " + data.ParemeterID + ".');", true);
                                return;
                            }
                        }
                        if (isSourceAddandTypeMandatory(data.SourceType, "DataType2"))
                        {
                            if (data.SourceDatatype2 == "" || data.SourceDatatype2 == null)
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Source Data Type 2 for Parameter ID " + data.ParemeterID + ".');", true);
                                return;
                            }
                        }
                        if (data.UpperWarning != "" || data.UpperError != "")
                        {
                            double uw = Convert.ToDouble(data.UpperWarning);
                            double ue = Convert.ToDouble(data.UpperError);
                            if (ue <= uw)
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Upper Error Limit should be greater than Upper Warning Limit for Parameter ID " + data.ParemeterID + ".');", true);
                                return;
                            }
                        }
                        if (data.LowerError != "" || data.LowerWarning != "")
                        {
                            double lw = Convert.ToDouble(data.LowerWarning);
                            double le = Convert.ToDouble(data.LowerError);
                            if (le >= lw)
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Lower Error Limit should be less than Lower Warning Limit for Parameter ID " + data.ParemeterID + ".');", true);
                                return;
                            }
                        }
                        //if (data.SourceType == "" || data.SourceType == null)
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Source Type.');", true);
                        //    return;
                        //}
                        //if (data.SourceAdd1 == "")
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Source Address 1.');", true);
                        //    return;
                        //}
                        //if (data.SourceDatatype1 == "" || data.SourceDatatype1 == null)
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Source Data Type 1.');", true);
                        //    return;
                        //}
                        //if (data.SourceAdd2 == "")
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Source Address 2.');", true);
                        //    return;
                        //}
                        //if (data.SourceDatatype2 == "" || data.SourceDatatype2 == null)
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Source Data Type 2.');", true);
                        //    return;
                        //}
                        //if (data.PollingFrequency == "" || data.PollingFrequency == null)
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Polling Frequency.');", true);
                        //    return;
                        //}
                        //if (data.DataGroup == "" || data.DataGroup == null)
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Data Group.');", true);
                        //    return;
                        //}
                        //if (data.PollingType == "" || data.PollingType == null)
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Polling Type.');", true);
                        //    return;
                        //}
                        //if (data.PollingType != "ReadBasedOnCustomTimePeriod")
                        //{
                        //    if (data.CycleFreqTime == "" || data.CycleFreqTime == null)
                        //    {
                        //        ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Cycle Frequency Time.');", true);
                        //        return;
                        //    }
                        //    if (data.NoOfCycle == "" || data.NoOfCycle == null)
                        //    {
                        //        ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select No. of Cycles.');", true);
                        //        return;
                        //    }
                        //}
                        //if (data.UpperWarning == "")
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Upper Warning Limit.');", true);
                        //    return;
                        //}
                        //if (data.LowerWarning == "")
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Lower Warning Limit.');", true);
                        //    return;
                        //}
                        //if (data.UpperError == "")
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Upper Error Limit.');", true);
                        //    return;
                        //}
                        //if (data.LowerError == "")
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Lower Error Limit.');", true);
                        //    return;
                        //}
                        //if (data.Unit == "")
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Unit.');", true);
                        //    return;
                        //}
                        int result;
                        DBAccess.insertUpdateProcessParameterControllerData(data, "ControllerLevel",out result);
                        if (result == 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openErrorModal('Failed to update record.');", true);
                            return;
                        }
                        else
                        {
                            showSuccessFlag = true;
                        }
                    }
                }
                if (showSuccessFlag)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "success", "showSuccessMsg('Record saved Successfully.','');", true);
                }
                BindControllerLevelData();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }

       

        private void BindModelData()
        {
            try
            {
                if (ddlModelLvlCNCMake.SelectedValue == "")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select CNC Make.');", true);
                    return;
                }
                if (ddlModelLvlCNCModel.SelectedValue == "")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select CNC Model.');", true);
                    return;
                }
                if (ddlModelLvlMTB.SelectedValue == "")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select MTB.');", true);
                    return;
                }
                if (ddlModelLvlMachineType.SelectedValue == "")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Machine Type.');", true);
                    return;
                }
                if (ddlModelLvlMachineModel.SelectedValue == "")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Machine Model.');", true);
                    return;
                }
                addDropDownValuesToList();
                if (Session["ParameterWiseValidationData"] != null)
                {
                    listParameterWiseValidation = Session["ParameterWiseValidationData"] as List<ParameterWiseValidationData>;
                }
                if (Session["SourceTypeWiseValidationData"] != null)
                {
                    listSourceTypeWiseValidation = Session["SourceTypeWiseValidationData"] as List<SourceTypeWiseValidationData>;
                }
                ProcessParameterMasterData data = new ProcessParameterMasterData();
                data.MTB = ddlModelLvlMTB.SelectedValue;
                data.MachineType = ddlModelLvlMachineType.SelectedValue;
                data.MachineModel = ddlModelLvlMachineModel.SelectedValue;
                data.CNCMake = ddlModelLvlCNCMake.SelectedValue;
                data.CNCModel = ddlModelLvlCNCModel.SelectedValue;
                //data.Company = ddlModelLvlCompany.SelectedValue;
                //data.Plant = ddlModelLvlPlant.SelectedValue;
                data.Company ="";
                data.Plant = "";
                data.Level = ddlModelLevelView.SelectedValue;
                List<ProcessParameterMasterData> list = DBAccess.getProcessParameterModelLevelData(data);
                int listcountFlag = 0;
                if (list.Count == 0)
                {
                    listcountFlag = 1;
                    list.Add(new ProcessParameterMasterData());
                }
                allLevelDataForPDF = list;
                gvMTBModeldata.DataSource = list;
                gvMTBModeldata.DataBind();
                if (listcountFlag == 1)
                {
                    gvMTBModeldata.Rows[0].Visible = false;
                }
                DropDownList ddl;
                ddl = gvMTBModeldata.FooterRow.FindControl("ddlSourceTypeNew") as DropDownList;
                BindSourceTypeData(ddl);
                ddlSourceTypeNewModel_SelectedIndexChanged(null, null);
                //ddl = gvMTBModeldata.FooterRow.FindControl("ddlDataType1New") as DropDownList;
                //BindSourceDataTypeData(ddl);
                //ddl = gvMTBModeldata.FooterRow.FindControl("ddlDataType2New") as DropDownList;
                //BindSourceDataTypeData(ddl);
                ddl = gvMTBModeldata.FooterRow.FindControl("ddlPollingFrequencyNew") as DropDownList;
                BindPollingFrequencyData(ddl);
                ddl = gvMTBModeldata.FooterRow.FindControl("ddlDataGroupNew") as DropDownList;
                BindDataGroupData(ddl);
                ddl = gvMTBModeldata.FooterRow.FindControl("ddlPollingTypeNew") as DropDownList;
                BindPollingTypeData(ddl);
                //if (ddl.SelectedValue == "ReadBasedOnCustomTimePeriod") //kkkkk
                //{
                //    ddlPollingTypeNewModel_SelectedIndexChanged(ddl, null);
                //}
                ddl = gvMTBModeldata.FooterRow.FindControl("ddlCycleFrequencyTimeNew") as DropDownList;
                BindCycleFrequencyTimeData(ddl);
                ddl = gvMTBModeldata.FooterRow.FindControl("ddlNoOfCycleNew") as DropDownList;
                BindNoOfCycleData(ddl);
                ddl = gvMTBModeldata.FooterRow.FindControl("ddlUnitNew") as DropDownList;
                BindUpperLowerUnitData(ddl);
                Session["ProcessParamMasterData"] = allLevelDataForPDF;
            }
            catch (Exception ex)
            { }
        }
        protected void gvMTBModeldata_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int index = e.Row.RowIndex;
                string hdnvalue = "";
                DropDownList ddl = new DropDownList();
                //string hdnvalue = (e.Row.FindControl("hdnSourceType") as HiddenField).Value;
                // DropDownList ddl = (e.Row.FindControl("ddlSourceType") as DropDownList);
                // ddl.DataSource = listSourceType;
                //ddl.DataBind();
                // ddl.SelectedValue = hdnvalue;

                string sourceType = (e.Row.FindControl("lblSourceType") as Label).Text;
                setSourceAddressAndDataType(sourceType, (e.Row.FindControl("txtSourceAdd1") as TextBox), (e.Row.FindControl("txtSourceAdd2") as TextBox), (e.Row.FindControl("ddlDataType1") as DropDownList), (e.Row.FindControl("ddlDataType2") as DropDownList), (e.Row.FindControl("hdnDataType1") as HiddenField).Value, (e.Row.FindControl("hdnDataType2") as HiddenField).Value, index);

                string parameter = (e.Row.FindControl("lblParemeterID") as Label).Text;
                setPollingFreqencyValidation(parameter, (e.Row.FindControl("ddlPollingFrequency") as DropDownList), (e.Row.FindControl("hdnPollingFrequency") as HiddenField).Value);


                ddl = (e.Row.FindControl("ddlDataGroup") as DropDownList);
                if (ddl != null)
                {
                    hdnvalue = (e.Row.FindControl("hdnDataGroup") as HiddenField).Value;
                    ddl.DataSource = listDataGroup;
                    ddl.DataBind();
                    ddl.SelectedValue = hdnvalue;
                }
                ddl = (e.Row.FindControl("ddlPollingType") as DropDownList);
                if (ddl != null)
                {
                    hdnvalue = (e.Row.FindControl("hdnPollingType") as HiddenField).Value;
                    ddl.DataSource = listPollingType;
                    ddl.DataTextField = "text";
                    ddl.DataValueField = "value";
                    ddl.DataBind();
                    ddl.SelectedValue = hdnvalue;
                    if (hdnvalue == "ReadBasedOnCustomTimePeriod") //kkkk
                    {
                        (e.Row.FindControl("ddlCycleFrequencyTime") as DropDownList).Visible = false;
                        (e.Row.FindControl("ddlNoOfCycle") as DropDownList).Visible = false;
                    }
                    else
                    {
                        (e.Row.FindControl("ddlCycleFrequencyTime") as DropDownList).Visible = true;
                        (e.Row.FindControl("ddlNoOfCycle") as DropDownList).Visible = true;
                    }
                }
                ddl = (e.Row.FindControl("ddlCycleFrequencyTime") as DropDownList);
                if (ddl != null)
                {
                    hdnvalue = (e.Row.FindControl("hdnCycleFreqTime") as HiddenField).Value;
                    ddl.DataSource = listCycleFrequencyTime;
                    ddl.DataBind();
                    if (hdnvalue != "")  //kkkk
                    {
                        ddl.SelectedValue = hdnvalue;
                    }
                }
                ddl = (e.Row.FindControl("ddlNoOfCycle") as DropDownList);
                if (ddl != null)
                {
                    hdnvalue = (e.Row.FindControl("hdnNoOfCycle") as HiddenField).Value;
                    ddl.DataSource = listNumberOfCycle;
                    ddl.DataBind();
                    if (hdnvalue != "")  //kkkk
                    {
                        ddl.SelectedValue = hdnvalue;
                    }
                }
                ddl = (e.Row.FindControl("ddlUnit") as DropDownList);
                if (ddl != null)
                {
                    hdnvalue = (e.Row.FindControl("hdnUnit") as HiddenField).Value;
                    ddl.DataSource = listUnit;
                    ddl.DataBind();
                    if (hdnvalue != "")
                    {
                        ddl.SelectedValue = hdnvalue;
                    }
                    else
                    {
                        ddl.SelectedValue = "None";
                    }

                }
                hdnvalue = (e.Row.FindControl("hdnDeleteFlag") as HiddenField).Value;
                if (hdnvalue == "1")
                {
                    (e.Row.FindControl("chkDeleteSelection") as CheckBox).Visible = true;
                }
                else
                {
                    (e.Row.FindControl("chkDeleteSelection") as CheckBox).Visible = false;
                }
            }
        }
        protected void btnInsertModelLvl_Click(object sender, EventArgs e)
        {
            try
            {
                ProcessParameterMasterData data = new ProcessParameterMasterData();
                //data.Company = ddlModelLvlCompany.SelectedValue;
                //data.Plant = ddlModelLvlPlant.SelectedValue;
                data.Company = "";
                data.Plant = "";
                data.CNCMake = ddlModelLvlCNCMake.SelectedValue;
                data.CNCModel = ddlModelLvlCNCModel.SelectedValue;
                data.MTB = ddlModelLvlMTB.SelectedValue;
                data.MachineModel = ddlModelLvlMachineModel.SelectedValue;
                data.MachineType = ddlModelLvlMachineType.SelectedValue;
                data.ParemeterID = (gvMTBModeldata.FooterRow.FindControl("txtParameterIDNew") as TextBox).Text.Trim();
                data.SourceType = (gvMTBModeldata.FooterRow.FindControl("ddlSourceTypeNew") as DropDownList).SelectedValue;
                data.SourceAdd1 = (gvMTBModeldata.FooterRow.FindControl("txtSourceAdd1New") as TextBox).Text;
                data.SourceDatatype1 = (gvMTBModeldata.FooterRow.FindControl("ddlDataType1New") as DropDownList).Text;
                data.SourceAdd2 = (gvMTBModeldata.FooterRow.FindControl("txtSourceAdd2New") as TextBox).Text;
                data.SourceDatatype2 = (gvMTBModeldata.FooterRow.FindControl("ddlDataType2New") as DropDownList).Text;
                data.PollingFrequency = (gvMTBModeldata.FooterRow.FindControl("ddlPollingFrequencyNew") as DropDownList).Text;
                data.DataGroup = (gvMTBModeldata.FooterRow.FindControl("ddlDataGroupNew") as DropDownList).Text;
                data.PollingType = (gvMTBModeldata.FooterRow.FindControl("ddlPollingTypeNew") as DropDownList).Text;
                data.CycleFreqTime = (gvMTBModeldata.FooterRow.FindControl("ddlCycleFrequencyTimeNew") as DropDownList).Text;
                data.NoOfCycle = (gvMTBModeldata.FooterRow.FindControl("ddlNoOfCycleNew") as DropDownList).Text;
                data.IsEnabled = (gvMTBModeldata.FooterRow.FindControl("chkIsEnabledNew") as CheckBox).Checked;
                data.ShouldNotBeDisabled = (gvMTBModeldata.FooterRow.FindControl("chkShouldNotBeDisabledNew") as CheckBox).Checked;
                data.UpperWarning = (gvMTBModeldata.FooterRow.FindControl("txtUpperWarningNew") as TextBox).Text.Trim();
                data.LowerWarning = (gvMTBModeldata.FooterRow.FindControl("txtLowerWarningNew") as TextBox).Text.Trim();
                data.UpperError = (gvMTBModeldata.FooterRow.FindControl("txtUpperErrorNew") as TextBox).Text.Trim();
                data.LowerError = (gvMTBModeldata.FooterRow.FindControl("txtLowerErrorNew") as TextBox).Text.Trim();
                data.Unit = (gvMTBModeldata.FooterRow.FindControl("ddlUnitNew") as DropDownList).SelectedValue;
                //if (data.Company == "" || data.Company == null)
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Company.');", true);
                //    return;
                //}
                //if (data.Plant == "" || data.Plant == null)
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Plant.');", true);
                //    return;
                //}
                if (data.CNCMake == "" || data.CNCMake == null)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select CNC Make.');", true);
                    return;
                }
                if (data.CNCModel == "" || data.CNCModel == null)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Series / Model.');", true);
                    return;
                }
                if (data.MTB == "" || data.MTB == null)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select MTB.');", true);
                    return;
                }
                if (data.MachineType == "" || data.MachineType == null)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Machine Type.');", true);
                    return;
                }
                if (data.MachineModel == "" || data.MachineModel == null)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Machine Model.');", true);
                    return;
                }
                if (data.ParemeterID == "")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Parameter ID.');", true);
                    return;
                }
                if (isSourceAddandTypeMandatory(data.SourceType, "Address1"))
                {
                    if (data.SourceAdd1 == "")
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Source Address 1.');", true);
                        return;
                    }
                }
                if (isSourceAddandTypeMandatory(data.SourceType, "DataType1"))
                {
                    if (data.SourceDatatype1 == "" || data.SourceDatatype1 == null)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Source Data Type 1.');", true);
                        return;
                    }
                }
                if (isSourceAddandTypeMandatory(data.SourceType, "Address2"))
                {
                    if (data.SourceAdd2 == "")
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Source Address 2.');", true);
                        return;
                    }
                }
                if (isSourceAddandTypeMandatory(data.SourceType, "DataType2"))
                {
                    if (data.SourceDatatype2 == "" || data.SourceDatatype2 == null)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Source Data Type 2.');", true);
                        return;
                    }
                }
                if (data.UpperWarning != "" || data.UpperError != "")
                {
                    double uw = Convert.ToDouble(data.UpperWarning);
                    double ue = Convert.ToDouble(data.UpperError);
                    if (ue <= uw)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Upper Error Limit should be greater than Upper Warning Limit.');", true);
                        return;
                    }
                }
                if (data.LowerError != "" || data.LowerWarning != "")
                {
                    double lw = Convert.ToDouble(data.LowerWarning);
                    double le = Convert.ToDouble(data.LowerError);
                    if (le >= lw)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Lower Error Limit should be less than Lower Warning Limit.');", true);
                        return;
                    }
                }
                //if (data.SourceType == "" || data.SourceType == null)
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Source Type.');", true);
                //    return;
                //}
                //if (data.SourceAdd1 == "")
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Source Address 1.');", true);
                //    return;
                //}
                //if (data.SourceDatatype1 == "" || data.SourceDatatype1 == null)
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Source Data Type 1.');", true);
                //    return;
                //}
                //if (data.SourceAdd2 == "")
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Source Address 2.');", true);
                //    return;
                //}
                //if (data.SourceDatatype2 == "" || data.SourceDatatype2 == null)
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Source Data Type 2.');", true);
                //    return;
                //}
                //if (data.PollingFrequency == "" || data.PollingFrequency == null)
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Polling Frequency.');", true);
                //    return;
                //}
                //if (data.DataGroup == "" || data.DataGroup == null)
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Data Group.');", true);
                //    return;
                //}
                //if (data.PollingType == "" || data.PollingType == null)
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Polling Type.');", true);
                //    return;
                //}
                //if (data.PollingType != "ReadBasedOnCustomTimePeriod")
                //{
                //    if (data.CycleFreqTime == "" || data.CycleFreqTime == null)
                //    {
                //        ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Cycle Frequency Time.');", true);
                //        return;
                //    }
                //    if (data.NoOfCycle == "" || data.NoOfCycle == null)
                //    {
                //        ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select No. of Cycles.');", true);
                //        return;
                //    }
                //}
                //if (data.UpperWarning == "")
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Upper Warning Limit.');", true);
                //    return;
                //}
                //if (data.LowerWarning == "")
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Lower Warning Limit.');", true);
                //    return;
                //}
                //if (data.UpperError == "")
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Upper Error Limit.');", true);
                //    return;
                //}
                //if (data.LowerError == "")
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Lower Error Limit.');", true);
                //    return;
                //}
                //if (data.Unit == "")
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Unit.');", true);
                //    return;
                //}
                int result;
                DBAccess.insertUpdateProcessParameterControllerData(data, "ModelLevel",out result);
                if (result == 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openErrorModal('Failed to insert record.');", true);
                    return;
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "success", "showSuccessMsg('Record saved Successfully.','');", true);
                }
                BindModelData();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }

        protected void btnModelLvlView_Click(object sender, EventArgs e)
        {
            BindModelData();
        }

        protected void btnModelLvlSave_Click(object sender, EventArgs e)
        {
            try
            {
                bool showSuccessFlag = false;
                for (int i = 0; i < gvMTBModeldata.Rows.Count; i++)
                {
                    string updatedValue = (gvMTBModeldata.Rows[i].FindControl("hdnUpdate") as HiddenField).Value;
                    if (string.Equals("updated", updatedValue, StringComparison.OrdinalIgnoreCase))
                    {
                        (gvMTBModeldata.Rows[i].FindControl("hdnUpdate") as HiddenField).Value = "";
                        ProcessParameterMasterData data = new ProcessParameterMasterData();
                        //data.Company = ddlModelLvlCompany.SelectedValue;
                        //data.Plant = ddlModelLvlPlant.SelectedValue;
                        data.Company = "";
                        data.Plant = "";
                        data.MTB = ddlModelLvlMTB.SelectedValue;
                        data.MachineType = ddlModelLvlMachineType.SelectedValue;
                        data.MachineModel = ddlModelLvlMachineModel.SelectedValue;
                        data.CNCModel = ddlModelLvlCNCModel.SelectedValue;
                        data.CNCMake = ddlModelLvlCNCMake.SelectedValue;
                        data.MachineID = "";
                        data.ParemeterID = (gvMTBModeldata.Rows[i].FindControl("lblParemeterID") as Label).Text;
                        //data.SourceType = (gvMTBModeldata.Rows[i].FindControl("ddlSourceType") as DropDownList).SelectedValue;
                        data.SourceType = (gvMTBModeldata.Rows[i].FindControl("lblSourceType") as Label).Text;
                        data.SourceAdd1 = (gvMTBModeldata.Rows[i].FindControl("txtSourceAdd1") as TextBox).Text;
                        data.SourceDatatype1 = (gvMTBModeldata.Rows[i].FindControl("ddlDataType1") as DropDownList).Text;
                        data.SourceAdd2 = (gvMTBModeldata.Rows[i].FindControl("txtSourceAdd2") as TextBox).Text;
                        data.SourceDatatype2 = (gvMTBModeldata.Rows[i].FindControl("ddlDataType2") as DropDownList).Text;
                        data.PollingFrequency = (gvMTBModeldata.Rows[i].FindControl("ddlPollingFrequency") as DropDownList).Text;
                        data.DataGroup = (gvMTBModeldata.Rows[i].FindControl("ddlDataGroup") as DropDownList).Text;
                        data.PollingType = (gvMTBModeldata.Rows[i].FindControl("ddlPollingType") as DropDownList).Text;
                        data.CycleFreqTime = (gvMTBModeldata.Rows[i].FindControl("ddlCycleFrequencyTime") as DropDownList).Text;
                        data.NoOfCycle = (gvMTBModeldata.Rows[i].FindControl("ddlNoOfCycle") as DropDownList).Text;
                        data.IsEnabled = (gvMTBModeldata.Rows[i].FindControl("chkIsEnabled") as CheckBox).Checked;
                        data.ShouldNotBeDisabled = (gvMTBModeldata.Rows[i].FindControl("chkShouldNotBeDisabled") as CheckBox).Checked;
                        data.UpperWarning = (gvMTBModeldata.Rows[i].FindControl("txtUpperWarning") as TextBox).Text.Trim();
                        data.LowerWarning = (gvMTBModeldata.Rows[i].FindControl("txtLowerWarning") as TextBox).Text.Trim();
                        data.UpperError = (gvMTBModeldata.Rows[i].FindControl("txtUpperError") as TextBox).Text.Trim();
                        data.LowerError = (gvMTBModeldata.Rows[i].FindControl("txtLowerError") as TextBox).Text.Trim();
                        data.Unit = (gvMTBModeldata.Rows[i].FindControl("ddlUnit") as DropDownList).SelectedValue;
                        //if (data.Company == "" || data.Company == null)
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Company.');", true);
                        //    return;
                        //}
                        //if (data.Plant == "" || data.Plant == null)
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Plant.');", true);
                        //    return;
                        //}
                        if (data.CNCMake == "" || data.CNCMake == null)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select CNC Make.');", true);
                            return;
                        }
                        if (data.CNCModel == "" || data.CNCModel == null)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Series / Model.');", true);
                            return;
                        }
                        if (data.MTB == "" || data.MTB == null)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select MTB.');", true);
                            return;
                        }
                        if (data.MachineType == "" || data.MachineType == null)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Machine Type.');", true);
                            return;
                        }
                        if (data.MachineModel == "" || data.MachineModel == null)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Machine Model.');", true);
                            return;
                        }
                        if (data.ParemeterID == "")
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Parameter ID.');", true);
                            return;
                        }
                        if (isSourceAddandTypeMandatory(data.SourceType, "Address1"))
                        {
                            if (data.SourceAdd1 == "")
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Source Address 1 for Parameter ID " + data.ParemeterID + ".');", true);
                                return;
                            }
                        }
                        if (isSourceAddandTypeMandatory(data.SourceType, "DataType1"))
                        {
                            if (data.SourceDatatype1 == "" || data.SourceDatatype1 == null)
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Source Data Type 1 for Parameter ID " + data.ParemeterID + ".');", true);
                                return;
                            }
                        }
                        if (isSourceAddandTypeMandatory(data.SourceType, "Address2"))
                        {
                            if (data.SourceAdd2 == "")
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Source Address 2 for Parameter ID " + data.ParemeterID + ".');", true);
                                return;
                            }
                        }
                        if (isSourceAddandTypeMandatory(data.SourceType, "DataType2"))
                        {
                            if (data.SourceDatatype2 == "" || data.SourceDatatype2 == null)
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Source Data Type 2 for Parameter ID " + data.ParemeterID + ".');", true);
                                return;
                            }
                        }
                        if (data.UpperWarning != "" || data.UpperError != "")
                        {
                            double uw = Convert.ToDouble(data.UpperWarning);
                            double ue = Convert.ToDouble(data.UpperError);
                            if (ue <= uw)
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Upper Error Limit should be greater than Upper Warning Limit for Parameter ID " + data.ParemeterID + ".');", true);
                                return;
                            }
                        }
                        if (data.LowerError != "" || data.LowerWarning != "")
                        {
                            double lw = Convert.ToDouble(data.LowerWarning);
                            double le = Convert.ToDouble(data.LowerError);
                            if (le >= lw)
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Lower Error Limit should be less than Lower Warning Limit for Parameter ID " + data.ParemeterID + ".');", true);
                                return;
                            }
                        }
                        //if (data.SourceType == "" || data.SourceType == null)
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Source Type.');", true);
                        //    return;
                        //}
                        //if (data.SourceAdd1 == "")
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Source Address 1.');", true);
                        //    return;
                        //}
                        //if (data.SourceDatatype1 == "" || data.SourceDatatype1 == null)
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Source Data Type 1.');", true);
                        //    return;
                        //}
                        //if (data.SourceAdd2 == "")
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Source Address 2.');", true);
                        //    return;
                        //}
                        //if (data.SourceDatatype2 == "" || data.SourceDatatype2 == null)
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Source Data Type 2.');", true);
                        //    return;
                        //}
                        //if (data.PollingFrequency == "" || data.PollingFrequency == null)
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Polling Frequency.');", true);
                        //    return;
                        //}
                        //if (data.DataGroup == "" || data.DataGroup == null)
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Data Group.');", true);
                        //    return;
                        //}
                        //if (data.PollingType == "" || data.PollingType == null)
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Polling Type.');", true);
                        //    return;
                        //}
                        //if (data.PollingType != "ReadBasedOnCustomTimePeriod")
                        //{
                        //    if (data.CycleFreqTime == "" || data.CycleFreqTime == null)
                        //    {
                        //        ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Cycle Frequency Time.');", true);
                        //        return;
                        //    }
                        //    if (data.NoOfCycle == "" || data.NoOfCycle == null)
                        //    {
                        //        ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select No. of Cycles.');", true);
                        //        return;
                        //    }
                        //}
                        //if (data.UpperWarning == "")
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Upper Warning Limit.');", true);
                        //    return;
                        //}
                        //if (data.LowerWarning == "")
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Lower Warning Limit.');", true);
                        //    return;
                        //}
                        //if (data.UpperError == "")
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Upper Error Limit.');", true);
                        //    return;
                        //}
                        //if (data.LowerError == "")
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Lower Error Limit.');", true);
                        //    return;
                        //}
                        //if (data.Unit == "")
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Unit.');", true);
                        //    return;
                        //}
                        int result;
                        DBAccess.insertUpdateProcessParameterControllerData(data, "ModelLevel",out result);
                        if (result == 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openErrorModal('Failed to update record.');", true);
                            return;
                        }
                        else
                        {
                            showSuccessFlag = true;
                        }
                    }
                }
                if (showSuccessFlag)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "success", "showSuccessMsg('Record saved Successfully.','');", true);
                }
                BindModelData();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("From btnModelLvlSave_Click" + ex.Message);
            }
        }

      

        private void BindMachineLevelData()
        {
            try
            {
                if (ddlMachineLvlCompany.SelectedValue == "")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Company.');", true);
                    return;
                }
                if (ddlMachineLvlPlant.SelectedValue == "")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Plant.');", true);
                    return;
                }
                if (ddlMachineLvlCNCMake.SelectedValue == "")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select CNC Make.');", true);
                    return;
                }
                if (ddlMachineLvlCNCModel.SelectedValue == "")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select CNC Model.');", true);
                    return;
                }
                if (ddlMachineLvlMTB.SelectedValue == "")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select MTB.');", true);
                    return;
                }
                if (ddlMachineLvlMachineType.SelectedValue == "")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Machine Type.');", true);
                    return;
                }
                if (ddlMachineLvlMachineModel.SelectedValue == "")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Machine Model.');", true);
                    return;
                }
                if (ddlMachineLvlMachineID.SelectedValue == "")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Machine ID.');", true);
                    return;
                }
                addDropDownValuesToList();
                if (Session["ParameterWiseValidationData"] != null)
                {
                    listParameterWiseValidation = Session["ParameterWiseValidationData"] as List<ParameterWiseValidationData>;
                }
                if (Session["SourceTypeWiseValidationData"] != null)
                {
                    listSourceTypeWiseValidation = Session["SourceTypeWiseValidationData"] as List<SourceTypeWiseValidationData>;
                }
                ProcessParameterMasterData data = new ProcessParameterMasterData();
                data.MTB = ddlMachineLvlMTB.SelectedValue;
                data.MachineType = ddlMachineLvlMachineType.SelectedValue;
                data.MachineModel = ddlMachineLvlMachineModel.SelectedValue;
                data.CNCMake = ddlMachineLvlCNCMake.SelectedValue;
                data.CNCModel = ddlMachineLvlCNCModel.SelectedValue;
                data.MachineID = ddlMachineLvlMachineID.SelectedValue;

                data.Company = ddlMachineLvlCompany.SelectedValue;
                data.Plant = ddlMachineLvlPlant.SelectedValue;
                data.Level = ddlMachineLevelView.SelectedValue;
                List<ProcessParameterMasterData> list = DBAccess.getProcessParameterMachineLevelLevelData(data);
                int listcountFlag = 0;
                if (list.Count == 0)
                {
                    listcountFlag = 1;
                    list.Add(new ProcessParameterMasterData());
                }
                allLevelDataForPDF = list;
                gvMAchineLvlData.DataSource = list;
                gvMAchineLvlData.DataBind();
                if (listcountFlag == 1)
                {
                    gvMAchineLvlData.Rows[0].Visible = false;
                }
                DropDownList ddl;
                ddl = gvMAchineLvlData.FooterRow.FindControl("ddlSourceTypeNew") as DropDownList;
                BindSourceTypeData(ddl);
                ddlSourceTypeNewMachine_SelectedIndexChanged(null, null);
                //ddl = gvMAchineLvlData.FooterRow.FindControl("ddlDataType1New") as DropDownList;
                //BindSourceDataTypeData(ddl);
                //ddl = gvMAchineLvlData.FooterRow.FindControl("ddlDataType2New") as DropDownList;
                //BindSourceDataTypeData(ddl);
                ddl = gvMAchineLvlData.FooterRow.FindControl("ddlPollingFrequencyNew") as DropDownList;
                BindPollingFrequencyData(ddl);
                ddl = gvMAchineLvlData.FooterRow.FindControl("ddlDataGroupNew") as DropDownList;
                BindDataGroupData(ddl);
                ddl = gvMAchineLvlData.FooterRow.FindControl("ddlPollingTypeNew") as DropDownList;
                BindPollingTypeData(ddl);
                //if (ddl.SelectedValue == "ReadBasedOnCustomTimePeriod") //kkkkk
                //{
                //    ddlPollingTypeNewMachineLvl_SelectedIndexChanged(ddl, null);
                //}
                ddl = gvMAchineLvlData.FooterRow.FindControl("ddlCycleFrequencyTimeNew") as DropDownList;
                BindCycleFrequencyTimeData(ddl);
                ddl = gvMAchineLvlData.FooterRow.FindControl("ddlNoOfCycleNew") as DropDownList;
                BindNoOfCycleData(ddl);
                ddl = gvMAchineLvlData.FooterRow.FindControl("ddlUnitNew") as DropDownList;
                BindUpperLowerUnitData(ddl);
                Session["ProcessParamMasterData"] = allLevelDataForPDF;
            }
            catch (Exception ex)
            { }
        }

        protected void gvMAchineLvlData_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int index = e.Row.RowIndex;
                string hdnvalue = "";
                DropDownList ddl = new DropDownList();
                //string hdnvalue = (e.Row.FindControl("hdnSourceType") as HiddenField).Value;
                // DropDownList ddl = (e.Row.FindControl("ddlSourceType") as DropDownList);
                // ddl.DataSource = listSourceType;
                //ddl.DataBind();
                // ddl.SelectedValue = hdnvalue;

                string sourceType = (e.Row.FindControl("lblSourceType") as Label).Text;
                setSourceAddressAndDataType(sourceType, (e.Row.FindControl("txtSourceAdd1") as TextBox), (e.Row.FindControl("txtSourceAdd2") as TextBox), (e.Row.FindControl("ddlDataType1") as DropDownList), (e.Row.FindControl("ddlDataType2") as DropDownList), (e.Row.FindControl("hdnDataType1") as HiddenField).Value, (e.Row.FindControl("hdnDataType2") as HiddenField).Value,index);

                string parameter = (e.Row.FindControl("lblParemeterID") as Label).Text;
                setPollingFreqencyValidation(parameter, (e.Row.FindControl("ddlPollingFrequency") as DropDownList), (e.Row.FindControl("hdnPollingFrequency") as HiddenField).Value);


                ddl = (e.Row.FindControl("ddlDataGroup") as DropDownList);
                if (ddl != null)
                {
                    hdnvalue = (e.Row.FindControl("hdnDataGroup") as HiddenField).Value;
                    ddl.DataSource = listDataGroup;
                    ddl.DataBind();
                    ddl.SelectedValue = hdnvalue;
                }
                ddl = (e.Row.FindControl("ddlPollingType") as DropDownList);
                if (ddl != null)
                {
                    hdnvalue = (e.Row.FindControl("hdnPollingType") as HiddenField).Value;
                    ddl.DataSource = listPollingType;
                    ddl.DataTextField = "text";
                    ddl.DataValueField = "value";
                    ddl.DataBind();
                    ddl.SelectedValue = hdnvalue;
                    if (hdnvalue == "ReadBasedOnCustomTimePeriod") //kkkk
                    {
                        (e.Row.FindControl("ddlCycleFrequencyTime") as DropDownList).Visible = false;
                        (e.Row.FindControl("ddlNoOfCycle") as DropDownList).Visible = false;
                    }
                    else
                    {
                        (e.Row.FindControl("ddlCycleFrequencyTime") as DropDownList).Visible = true;
                        (e.Row.FindControl("ddlNoOfCycle") as DropDownList).Visible = true;
                    }
                }
                ddl = (e.Row.FindControl("ddlCycleFrequencyTime") as DropDownList);
                if (ddl != null)
                {
                    hdnvalue = (e.Row.FindControl("hdnCycleFreqTime") as HiddenField).Value;
                    ddl.DataSource = listCycleFrequencyTime;
                    ddl.DataBind();
                    if (hdnvalue != "")  //kkkk
                    {
                        ddl.SelectedValue = hdnvalue;
                    }
                }
                ddl = (e.Row.FindControl("ddlNoOfCycle") as DropDownList);
                if (ddl != null)
                {
                    hdnvalue = (e.Row.FindControl("hdnNoOfCycle") as HiddenField).Value;
                    ddl.DataSource = listNumberOfCycle;
                    ddl.DataBind();
                    if (hdnvalue != "")  //kkkk
                    {
                        ddl.SelectedValue = hdnvalue;
                    }
                }
                ddl = (e.Row.FindControl("ddlUnit") as DropDownList);
                if (ddl != null)
                {
                    hdnvalue = (e.Row.FindControl("hdnUnit") as HiddenField).Value;
                    ddl.DataSource = listUnit;
                    ddl.DataBind();
                    if (hdnvalue != "")
                    {
                        ddl.SelectedValue = hdnvalue;
                    }
                    else
                    {
                        ddl.SelectedValue = "None";
                    }

                }
                hdnvalue = (e.Row.FindControl("hdnDeleteFlag") as HiddenField).Value;
                if (hdnvalue == "1")
                {
                    (e.Row.FindControl("chkDeleteSelection") as CheckBox).Visible = true;
                }
                else
                {
                    (e.Row.FindControl("chkDeleteSelection") as CheckBox).Visible = false;
                }
            }
        }
        protected void btnMachineLvlView_Click(object sender, EventArgs e)
        {
            BindMachineLevelData();
        }

        protected void btnMachineLvlSave_Click(object sender, EventArgs e)
        {
            try
            {
                bool showSuccessFlag = false;
                for (int i = 0; i < gvMAchineLvlData.Rows.Count; i++)
                {
                    string updatedValue = (gvMAchineLvlData.Rows[i].FindControl("hdnUpdate") as HiddenField).Value;
                    if (string.Equals("updated", updatedValue, StringComparison.OrdinalIgnoreCase))
                    {
                        (gvMAchineLvlData.Rows[i].FindControl("hdnUpdate") as HiddenField).Value = "";
                        ProcessParameterMasterData data = new ProcessParameterMasterData();
                        data.Company = ddlMachineLvlCompany.SelectedValue;
                        data.Plant = ddlMachineLvlPlant.SelectedValue;
                        data.MTB = ddlMachineLvlMTB.SelectedValue;
                        data.MachineType = ddlMachineLvlMachineType.SelectedValue;
                        data.MachineModel = ddlMachineLvlMachineModel.SelectedValue;
                        data.CNCModel = ddlMachineLvlCNCModel.SelectedValue;
                        data.CNCMake = ddlMachineLvlCNCMake.SelectedValue;
                        data.MachineID = ddlMachineLvlMachineID.SelectedValue;
                        data.ParemeterID = (gvMAchineLvlData.Rows[i].FindControl("lblParemeterID") as Label).Text;
                        // data.SourceType = (gvMAchineLvlData.Rows[i].FindControl("ddlSourceType") as DropDownList).SelectedValue;
                        data.SourceType = (gvMAchineLvlData.Rows[i].FindControl("lblSourceType") as Label).Text;
                        data.SourceAdd1 = (gvMAchineLvlData.Rows[i].FindControl("txtSourceAdd1") as TextBox).Text;
                        data.SourceDatatype1 = (gvMAchineLvlData.Rows[i].FindControl("ddlDataType1") as DropDownList).Text;
                        data.SourceAdd2 = (gvMAchineLvlData.Rows[i].FindControl("txtSourceAdd2") as TextBox).Text;
                        data.SourceDatatype2 = (gvMAchineLvlData.Rows[i].FindControl("ddlDataType2") as DropDownList).Text;
                        data.PollingFrequency = (gvMAchineLvlData.Rows[i].FindControl("ddlPollingFrequency") as DropDownList).Text;
                        data.DataGroup = (gvMAchineLvlData.Rows[i].FindControl("ddlDataGroup") as DropDownList).Text;
                        data.PollingType = (gvMAchineLvlData.Rows[i].FindControl("ddlPollingType") as DropDownList).Text;
                        data.CycleFreqTime = (gvMAchineLvlData.Rows[i].FindControl("ddlCycleFrequencyTime") as DropDownList).Text;
                        data.NoOfCycle = (gvMAchineLvlData.Rows[i].FindControl("ddlNoOfCycle") as DropDownList).Text;
                        data.IsEnabled = (gvMAchineLvlData.Rows[i].FindControl("chkIsEnabled") as CheckBox).Checked;
                        data.ShouldNotBeDisabled = (gvMAchineLvlData.Rows[i].FindControl("chkShouldNotBeDisabled") as CheckBox).Checked;
                        data.IsEnabledForDataRead = (gvMAchineLvlData.Rows[i].FindControl("chkIsEnabledForDataRead") as CheckBox).Checked;
                        data.UpperWarning = (gvMAchineLvlData.Rows[i].FindControl("txtUpperWarning") as TextBox).Text.Trim();
                        data.LowerWarning = (gvMAchineLvlData.Rows[i].FindControl("txtLowerWarning") as TextBox).Text.Trim();
                        data.UpperError = (gvMAchineLvlData.Rows[i].FindControl("txtUpperError") as TextBox).Text.Trim();
                        data.LowerError = (gvMAchineLvlData.Rows[i].FindControl("txtLowerError") as TextBox).Text.Trim();
                        data.Unit = (gvMAchineLvlData.Rows[i].FindControl("ddlUnit") as DropDownList).SelectedValue;
                        if (data.Company == "" || data.Company == null)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Company.');", true);
                            return;
                        }
                        if (data.Plant == "" || data.Plant == null)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Plant.');", true);
                            return;
                        }
                        if (data.CNCMake == "" || data.CNCMake == null)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select CNC Make.');", true);
                            return;
                        }
                        if (data.CNCModel == "" || data.CNCModel == null)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Series / Model.');", true);
                            return;
                        }
                        if (data.MTB == "" || data.MTB == null)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select MTB.');", true);
                            return;
                        }
                        if (data.MachineType == "" || data.MachineType == null)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Machine Type.');", true);
                            return;
                        }
                        if (data.MachineModel == "" || data.MachineModel == null)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Machine Model.');", true);
                            return;
                        }
                        if (data.MachineID == "" || data.MachineID == null)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Machine ID.');", true);
                            return;
                        }
                        if (data.ParemeterID == "")
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Parameter ID.');", true);
                            return;
                        }
                        if (isSourceAddandTypeMandatory(data.SourceType, "Address1"))
                        {
                            if (data.SourceAdd1 == "")
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Source Address 1 for Parameter ID " + data.ParemeterID + ".');", true);
                                return;
                            }
                        }
                        if (isSourceAddandTypeMandatory(data.SourceType, "DataType1"))
                        {
                            if (data.SourceDatatype1 == "" || data.SourceDatatype1 == null)
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Source Data Type 1 for Parameter ID " + data.ParemeterID + ".');", true);
                                return;
                            }
                        }
                        if (isSourceAddandTypeMandatory(data.SourceType, "Address2"))
                        {
                            if (data.SourceAdd2 == "")
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Source Address 2 for Parameter ID " + data.ParemeterID + ".');", true);
                                return;
                            }
                        }
                        if (isSourceAddandTypeMandatory(data.SourceType, "DataType2"))
                        {
                            if (data.SourceDatatype2 == "" || data.SourceDatatype2 == null)
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Source Data Type 2 for Parameter ID " + data.ParemeterID + ".');", true);
                                return;
                            }
                        }
                        if (data.UpperWarning != "" || data.UpperError != "")
                        {
                            double uw = Convert.ToDouble(data.UpperWarning);
                            double ue = Convert.ToDouble(data.UpperError);
                            if (ue <= uw)
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Upper Error Limit should be greater than Upper Warning Limit for Parameter ID " + data.ParemeterID + ".');", true);
                                return;
                            }
                        }
                        if (data.LowerError != "" || data.LowerWarning != "")
                        {
                            double lw = Convert.ToDouble(data.LowerWarning);
                            double le = Convert.ToDouble(data.LowerError);
                            if (le >= lw)
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Lower Error Limit should be less than Lower Warning Limit for Parameter ID " + data.ParemeterID + ".');", true);
                                return;
                            }
                        }
                        //if (data.SourceType == "" || data.SourceType == null)
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Source Type.');", true);
                        //    return;
                        //}
                        //if (data.SourceAdd1 == "")
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Source Address 1.');", true);
                        //    return;
                        //}
                        //if (data.SourceDatatype1 == "" || data.SourceDatatype1 == null)
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Source Data Type 1.');", true);
                        //    return;
                        //}
                        //if (data.SourceAdd2 == "")
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Source Address 2.');", true);
                        //    return;
                        //}
                        //if (data.SourceDatatype2 == "" || data.SourceDatatype2 == null)
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Source Data Type 2.');", true);
                        //    return;
                        //}
                        //if (data.PollingFrequency == "" || data.PollingFrequency == null)
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Polling Frequency.');", true);
                        //    return;
                        //}
                        //if (data.DataGroup == "" || data.DataGroup == null)
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Data Group.');", true);
                        //    return;
                        //}
                        //if (data.PollingType == "" || data.PollingType == null)
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Polling Type.');", true);
                        //    return;
                        //}
                        //if (data.PollingType != "ReadBasedOnCustomTimePeriod")
                        //{
                        //    if (data.CycleFreqTime == "" || data.CycleFreqTime == null)
                        //    {
                        //        ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Cycle Frequency Time.');", true);
                        //        return;
                        //    }
                        //    if (data.NoOfCycle == "" || data.NoOfCycle == null)
                        //    {
                        //        ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select No. of Cycles.');", true);
                        //        return;
                        //    }
                        //}
                        //if (data.UpperWarning == "")
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Upper Warning Limit.');", true);
                        //    return;
                        //}
                        //if (data.LowerWarning == "")
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Lower Warning Limit.');", true);
                        //    return;
                        //}
                        //if (data.UpperError == "")
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Upper Error Limit.');", true);
                        //    return;
                        //}
                        //if (data.LowerError == "")
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Lower Error Limit.');", true);
                        //    return;
                        //}
                        //if (data.Unit == "")
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Unit.');", true);
                        //    return;
                        //}
                        int result;
                        DBAccess.insertUpdateProcessParameterControllerData(data, "MachineLevelParameters",out result);
                        if (result == 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openErrorModal('Failed to update record.');", true);
                            return;
                        }
                        else
                        {
                            showSuccessFlag = true;
                        }
                    }
                }
                if (showSuccessFlag)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "success", "showSuccessMsg('Record saved Successfully.','');", true);
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
                ProcessParameterMasterData data = new ProcessParameterMasterData();
                data.Company = ddlMachineLvlCompany.SelectedValue;
                data.Plant = ddlMachineLvlPlant.SelectedValue;
                data.CNCMake = ddlMachineLvlCNCMake.SelectedValue;
                data.CNCMake = ddlMachineLvlCNCMake.SelectedValue;
                data.CNCModel = ddlMachineLvlCNCModel.SelectedValue;
                data.MTB = ddlMachineLvlMTB.SelectedValue;
                data.MachineModel = ddlMachineLvlMachineModel.SelectedValue;
                data.MachineType = ddlMachineLvlMachineType.SelectedValue;
                data.MachineID = ddlMachineLvlMachineID.SelectedValue;
                data.ParemeterID = (gvMAchineLvlData.FooterRow.FindControl("txtParameterIDNew") as TextBox).Text;
                data.SourceType = (gvMAchineLvlData.FooterRow.FindControl("ddlSourceTypeNew") as DropDownList).SelectedValue;
                data.SourceAdd1 = (gvMAchineLvlData.FooterRow.FindControl("txtSourceAdd1New") as TextBox).Text;
                data.SourceDatatype1 = (gvMAchineLvlData.FooterRow.FindControl("ddlDataType1New") as DropDownList).Text;
                data.SourceAdd2 = (gvMAchineLvlData.FooterRow.FindControl("txtSourceAdd2New") as TextBox).Text;
                data.SourceDatatype2 = (gvMAchineLvlData.FooterRow.FindControl("ddlDataType2New") as DropDownList).Text;
                data.PollingFrequency = (gvMAchineLvlData.FooterRow.FindControl("ddlPollingFrequencyNew") as DropDownList).Text;
                data.DataGroup = (gvMAchineLvlData.FooterRow.FindControl("ddlDataGroupNew") as DropDownList).Text;
                data.PollingType = (gvMAchineLvlData.FooterRow.FindControl("ddlPollingTypeNew") as DropDownList).Text;
                data.CycleFreqTime = (gvMAchineLvlData.FooterRow.FindControl("ddlCycleFrequencyTimeNew") as DropDownList).Text;
                data.NoOfCycle = (gvMAchineLvlData.FooterRow.FindControl("ddlNoOfCycleNew") as DropDownList).Text;
                data.IsEnabled = (gvMAchineLvlData.FooterRow.FindControl("chkIsEnabledNew") as CheckBox).Checked;
                data.ShouldNotBeDisabled = (gvMAchineLvlData.FooterRow.FindControl("chkShouldNotBeDisabledNew") as CheckBox).Checked;
                data.IsEnabledForDataRead = (gvMAchineLvlData.FooterRow.FindControl("chkIsEnabledForDataReadNew") as CheckBox).Checked;
                data.UpperWarning = (gvMAchineLvlData.FooterRow.FindControl("txtUpperWarningNew") as TextBox).Text.Trim();
                data.LowerWarning = (gvMAchineLvlData.FooterRow.FindControl("txtLowerWarningNew") as TextBox).Text.Trim();
                data.UpperError = (gvMAchineLvlData.FooterRow.FindControl("txtUpperErrorNew") as TextBox).Text.Trim();
                data.LowerError = (gvMAchineLvlData.FooterRow.FindControl("txtLowerErrorNew") as TextBox).Text.Trim();
                data.Unit = (gvMAchineLvlData.FooterRow.FindControl("ddlUnitNew") as DropDownList).SelectedValue;
                if (data.Company == "" || data.Company == null)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Company.');", true);
                    return;
                }
                if (data.Plant == "" || data.Plant == null)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Plant.');", true);
                    return;
                }
                if (data.CNCMake == "" || data.CNCMake == null)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select CNC Make.');", true);
                    return;
                }
                if (data.CNCModel == "" || data.CNCModel == null)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Series / Model.');", true);
                    return;
                }
                if (data.MTB == "" || data.MTB == null)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select MTB.');", true);
                    return;
                }
                if (data.MachineType == "" || data.MachineType == null)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Machine Type.');", true);
                    return;
                }
                if (data.MachineModel == "" || data.MachineModel == null)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Machine Model.');", true);
                    return;
                }
                if (data.MachineID == "" || data.MachineID == null)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Machine ID.');", true);
                    return;
                }
                if (data.ParemeterID == "")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Parameter ID.');", true);
                    return;
                }
                if (isSourceAddandTypeMandatory(data.SourceType, "Address1"))
                {
                    if (data.SourceAdd1 == "")
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Source Address 1.');", true);
                        return;
                    }
                }
                if (isSourceAddandTypeMandatory(data.SourceType, "DataType1"))
                {
                    if (data.SourceDatatype1 == "" || data.SourceDatatype1 == null)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Source Data Type 1.');", true);
                        return;
                    }
                }
                if (isSourceAddandTypeMandatory(data.SourceType, "Address2"))
                {
                    if (data.SourceAdd2 == "")
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Source Address 2.');", true);
                        return;
                    }
                }
                if (isSourceAddandTypeMandatory(data.SourceType, "DataType2"))
                {
                    if (data.SourceDatatype2 == "" || data.SourceDatatype2 == null)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Source Data Type 2.');", true);
                        return;
                    }
                }
                if (data.UpperWarning != "" || data.UpperError != "")
                {
                    double uw = Convert.ToDouble(data.UpperWarning);
                    double ue = Convert.ToDouble(data.UpperError);
                    if (ue <= uw)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Upper Error Limit should be greater than Upper Warning Limit.');", true);
                        return;
                    }
                }
                if (data.LowerError != "" || data.LowerWarning != "")
                {
                    double lw = Convert.ToDouble(data.LowerWarning);
                    double le = Convert.ToDouble(data.LowerError);
                    if (le >= lw)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Lower Error Limit should be less than Lower Warning Limit.');", true);
                        return;
                    }
                }
                //if (data.SourceType == "" || data.SourceType == null)
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Source Type.');", true);
                //    return;
                //}
                //if (data.SourceAdd1 == "")
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Source Address 1.');", true);
                //    return;
                //}
                //if (data.SourceDatatype1 == "" || data.SourceDatatype1 == null)
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Source Data Type 1.');", true);
                //    return;
                //}
                //if (data.SourceAdd2 == "")
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Source Address 2.');", true);
                //    return;
                //}
                //if (data.SourceDatatype2 == "" || data.SourceDatatype2 == null)
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Source Data Type 2.');", true);
                //    return;
                //}
                //if (data.PollingFrequency == "" || data.PollingFrequency == null)
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Polling Frequency.');", true);
                //    return;
                //}
                //if (data.DataGroup == "" || data.DataGroup == null)
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Data Group.');", true);
                //    return;
                //}
                //if (data.PollingType == "" || data.PollingType == null)
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Polling Type.');", true);
                //    return;
                //}
                //if (data.PollingType != "ReadBasedOnCustomTimePeriod")
                //{
                //    if (data.CycleFreqTime == "" || data.CycleFreqTime == null)
                //    {
                //        ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select Cycle Frequency Time.');", true);
                //        return;
                //    }
                //    if (data.NoOfCycle == "" || data.NoOfCycle == null)
                //    {
                //        ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please select No. of Cycles.');", true);
                //        return;
                //    }
                //}
                //if (data.UpperWarning == "")
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Upper Warning Limit.');", true);
                //    return;
                //}
                //if (data.LowerWarning == "")
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Lower Warning Limit.');", true);
                //    return;
                //}
                //if (data.UpperError == "")
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Upper Error Limit.');", true);
                //    return;
                //}
                //if (data.LowerError == "")
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Lower Error Limit.');", true);
                //    return;
                //}
                //if (data.Unit == "")
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openWarningModal('Please enter Unit.');", true);
                //    return;
                //}
                int result;
                DBAccess.insertUpdateProcessParameterControllerData(data, "MachineLevelParameters",out result);
                if (result == 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openErrorModal('Failed to insert record.');", true);
                    return;
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "success", "showSuccessMsg('Record saved Successfully.','');", true);
                }
                BindMachineLevelData();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }

        protected void btnControllerLvl_Click(object sender, EventArgs e)
        {
            // BindControllerLevelDdlValue();
            //BindCompanyForController();
            getParmeterWiseValidationList();
            getSourceTypeWiseValidationList();
            BindCNCMakeForController();
            BindControllerLevelData();
        }

        protected void btnModelLvl_Click(object sender, EventArgs e)
        {
            getParmeterWiseValidationList();
            getSourceTypeWiseValidationList();
            BindMTBForModel();
            BindCNCMakeForModel();
           // BindCompanyForModel();
            BindModelData();
        }

        protected void btnMachineLvl_Click(object sender, EventArgs e)
        {
            getParmeterWiseValidationList();
            getSourceTypeWiseValidationList();
            //BindCNCMakeForMachine();
            BindCompanyForMachine();
            BindCNCMakeForMachine();
            BindMTBForMachine();
            BindMachineLevelData();
        }

        protected void btnDeleteController_Click(object sender, EventArgs e)
        {
            try
            {
                bool showDeleteSuccess = false;
                for (int i = 0; i < gvControllerLvlData.Rows.Count; i++)
                {
                    if ((gvControllerLvlData.Rows[i].FindControl("chkDeleteSelection") as CheckBox).Checked)
                    {
                        ProcessParameterMasterData data = new ProcessParameterMasterData();
                        data.CNCMake = (gvControllerLvlData.Rows[i].FindControl("hdnCNCMake") as HiddenField).Value;
                        data.CNCModel = (gvControllerLvlData.Rows[i].FindControl("hdnCNCModel") as HiddenField).Value;
                        data.ParemeterID = (gvControllerLvlData.Rows[i].FindControl("lblParemeterID") as Label).Text;
                        int result=DBAccess.deleteProcessParameterControllerData(data);
                        if (result == 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openErrorModal('Failed to delete record.');", true);
                            return;
                        }
                        else
                        {
                            showDeleteSuccess = true;
                        }
                    }

                }
                if(showDeleteSuccess)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "success", "showSuccessMsg('Record deleted Successfully.','');", true);
                }
                BindControllerLevelData();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }

        protected void btnDeleteModel_Click(object sender, EventArgs e)
        {
            try
            {
                bool showDeleteSuccess = false;
                for (int i = 0; i < gvMTBModeldata.Rows.Count; i++)
                {
                    if ((gvMTBModeldata.Rows[i].FindControl("chkDeleteSelection") as CheckBox).Checked)
                    {
                        ProcessParameterMasterData data = new ProcessParameterMasterData();
                        data.MTB = (gvMTBModeldata.Rows[i].FindControl("hdnMTB") as HiddenField).Value;
                        data.MachineType = (gvMTBModeldata.Rows[i].FindControl("hdnMachineType") as HiddenField).Value;
                        data.MachineModel = (gvMTBModeldata.Rows[i].FindControl("hdnMachineModel") as HiddenField).Value;
                        data.CNCMake = (gvMTBModeldata.Rows[i].FindControl("hdnCNCMake") as HiddenField).Value;
                        data.CNCModel = (gvMTBModeldata.Rows[i].FindControl("hdnCNCModel") as HiddenField).Value;
                        data.ParemeterID = (gvMTBModeldata.Rows[i].FindControl("lblParemeterID") as Label).Text;
                        int result=DBAccess.deleteProcessParameterModelData(data);
                        if (result == 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openErrorModal('Failed to delete record.');", true);
                            return;
                        }
                        else
                        {
                            showDeleteSuccess = true;
                        }
                    }

                }
                if (showDeleteSuccess)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "success", "showSuccessMsg('Record deleted Successfully.','');", true);
                }
                BindModelData();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }

        protected void btnDeleteMachine_Click(object sender, EventArgs e)
        {
            try
            {
                bool showDeleteSuccess = false;
                for (int i = 0; i < gvMAchineLvlData.Rows.Count; i++)
                {
                    if ((gvMAchineLvlData.Rows[i].FindControl("chkDeleteSelection") as CheckBox).Checked)
                    {
                        ProcessParameterMasterData data = new ProcessParameterMasterData();
                        data.Company = (gvMAchineLvlData.Rows[i].FindControl("hdnCompany") as HiddenField).Value;
                        data.Plant = (gvMAchineLvlData.Rows[i].FindControl("hdnPlant") as HiddenField).Value;
                        data.MTB = (gvMAchineLvlData.Rows[i].FindControl("hdnMTB") as HiddenField).Value;
                        data.MachineType = (gvMAchineLvlData.Rows[i].FindControl("hdnMachineType") as HiddenField).Value;
                        data.MachineModel = (gvMAchineLvlData.Rows[i].FindControl("hdnMachineModel") as HiddenField).Value;
                        data.CNCMake = (gvMAchineLvlData.Rows[i].FindControl("hdnCNCMake") as HiddenField).Value;
                        data.CNCModel = (gvMAchineLvlData.Rows[i].FindControl("hdnCNCModel") as HiddenField).Value;
                        data.MachineID = (gvMAchineLvlData.Rows[i].FindControl("hdnMachineID") as HiddenField).Value;
                        data.ParemeterID = (gvMAchineLvlData.Rows[i].FindControl("lblParemeterID") as Label).Text;
                        int result=DBAccess.deleteProcessParameterMachineData(data);
                        if (result == 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "warning", "openErrorModal('Failed to delete record.');", true);
                            return;
                        }
                        else
                        {
                            showDeleteSuccess = true;
                        }
                    }

                }
                if (showDeleteSuccess)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "success", "showSuccessMsg('Record deleted Successfully.','');", true);
                }
                BindMachineLevelData();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        protected void ddlControlLvlCompany_SelectedIndexChanged(object sender, EventArgs e)
        {
            //BindPlantForController();
        }

        protected void ddlControlLvlPlant_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindCNCMakeForController();
        }
        protected void ddlControlLvlCNCMake_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindCNCModelForController();
        }

        protected void ddlModelLvlCompany_SelectedIndexChanged(object sender, EventArgs e)
        {
           // BindPlantForModel();
        }

        protected void ddlModelLvlPlant_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindCNCMakeForModel();
        }
        protected void ddlModelLvlCNCMake_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindCNCModelForModel();
        }

        protected void ddlModelLvlCNCModel_SelectedIndexChanged(object sender, EventArgs e)
        {
            //  BindMTBForModel();
            BindMachineTypeForModel();
        }

        protected void ddlModelLvlMTB_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindMachineTypeForModel();
        }

        protected void ddlModelLvlMachineType_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindMachineModelForModel();
        }

        protected void ddlMachineLvlCompany_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindPlantForMachine();
            ddlMachineLvlPlant_SelectedIndexChanged(null,null);
        }

        protected void ddlMachineLvlPlant_SelectedIndexChanged(object sender, EventArgs e)
        {
            // BindCNCMakeForMachine();
            BindMachineIDForMachine();
        }
        protected void ddlMachineLvlCNCMake_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindCNCModelForMachine();
            ddlMachineLvlCNCModel_SelectedIndexChanged(null, null);
        }

        protected void ddlMachineLvlCNCModel_SelectedIndexChanged(object sender, EventArgs e)
        {
            // BindMTBForMachine();
            //BindMachineTypeForMachine();
            BindMachineIDForMachine();
        }

        protected void ddlMachineLvlMTB_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindMachineTypeForMachine();
        }

        protected void ddlMachineLvlMachineType_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindMachineModelForMachine();
        }

        protected void ddlMachineLvlMachineModel_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindMachineIDForMachine();
        }

        protected void ddlSourceTypeNewController_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                string sourcetype= (gvControllerLvlData.FooterRow.FindControl("ddlSourceTypeNew") as DropDownList).SelectedValue;
                setSourceAddressAndDataType(sourcetype, (gvControllerLvlData.FooterRow.FindControl("txtSourceAdd1New") as TextBox), (gvControllerLvlData.FooterRow.FindControl("txtSourceAdd2New") as TextBox), (gvControllerLvlData.FooterRow.FindControl("ddlDataType1New") as DropDownList), (gvControllerLvlData.FooterRow.FindControl("ddlDataType2New") as DropDownList), "", "",-1);
            }
            catch(Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }

        protected void ddlSourceTypeNewModel_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                string sourcetype = (gvMTBModeldata.FooterRow.FindControl("ddlSourceTypeNew") as DropDownList).SelectedValue;
                setSourceAddressAndDataType(sourcetype, (gvMTBModeldata.FooterRow.FindControl("txtSourceAdd1New") as TextBox), (gvMTBModeldata.FooterRow.FindControl("txtSourceAdd2New") as TextBox), (gvMTBModeldata.FooterRow.FindControl("ddlDataType1New") as DropDownList), (gvMTBModeldata.FooterRow.FindControl("ddlDataType2New") as DropDownList), "", "",-1);
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }

        protected void ddlSourceTypeNewMachine_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                string sourcetype = (gvMAchineLvlData.FooterRow.FindControl("ddlSourceTypeNew") as DropDownList).SelectedValue;
                setSourceAddressAndDataType(sourcetype, (gvMAchineLvlData.FooterRow.FindControl("txtSourceAdd1New") as TextBox), (gvMAchineLvlData.FooterRow.FindControl("txtSourceAdd2New") as TextBox), (gvMAchineLvlData.FooterRow.FindControl("ddlDataType1New") as DropDownList), (gvMAchineLvlData.FooterRow.FindControl("ddlDataType2New") as DropDownList), "", "",-1);
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }

        protected void btnModelLvlCopy_Click(object sender, EventArgs e)
        {
            try
            {

                try
                {
                    string srcModel = ddlModelLvlMachineModel.SelectedValue;
                    lblModelLvlCopySrcModel.Text = srcModel;
                    lbModelLvlCopyDistModel.Items.Clear();
                    foreach(System.Web.UI.WebControls.ListItem item in ddlModelLvlMachineModel.Items)
                    {
                        if (item.Value != srcModel)
                        {
                            lbModelLvlCopyDistModel.Items.Add(item);
                        }
                    }
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "success", "openCopyModelLvlData();", true);
                }
                catch(Exception ex)
                {

                }
            }
            catch(Exception ex)
            {

            }
        }

        protected void btnModelLvlCopyConfirm_Click(object sender, EventArgs e)
        {
            try
            {
                string srcModel = lblModelLvlCopySrcModel.Text;
                foreach (System.Web.UI.WebControls.ListItem item in lbModelLvlCopyDistModel.Items)
                {
                    if (item.Selected)
                    {
                        DBAccess.copyModelLevelDataToSelectedModel(srcModel, item.Value, ddlModelLvlCNCMake.SelectedValue, ddlModelLvlCNCModel.SelectedValue, ddlModelLvlMachineType.SelectedValue, ddlModelLvlMTB.SelectedValue);
                    }
                }
            }
            catch (Exception ex)
            { }
        }

        protected void btnCopyMachineLvl_Click(object sender, EventArgs e)
        {
            try
            {
                string srcMachineID = ddlMachineLvlMachineID.SelectedValue;
                lblMachineLvlCopySrcMachineID.Text = srcMachineID;
                lbMachineLvlCopyDistID.Items.Clear();
                foreach (System.Web.UI.WebControls.ListItem item in ddlMachineLvlMachineID.Items)
                {
                    if (item.Value != srcMachineID)
                    {
                        lbMachineLvlCopyDistID.Items.Add(item);
                    }
                }
                ScriptManager.RegisterStartupScript(this, this.GetType(), "success", "openCopyMachineLvlData();", true);
            }
            catch (Exception ex)
            {

            }
        }

        protected void btnMachineLvlCopyConfirm_Click(object sender, EventArgs e)
        {
            try
            {
                string srcMachineId = lblMachineLvlCopySrcMachineID.Text;
                foreach (System.Web.UI.WebControls.ListItem item in lbMachineLvlCopyDistID.Items)
                {
                    if (item.Selected)
                    {
                        DBAccess.copyMachineLevelDataToSelectedModel(srcMachineId,item.Value,ddlMachineLvlCompany.SelectedValue,ddlMachineLvlPlant.SelectedValue,ddlMachineLvlCNCMake.SelectedValue,ddlMachineLvlCNCModel.SelectedValue,ddlMachineLvlMTB.SelectedValue,ddlMachineLvlMachineType.SelectedValue,ddlMachineLvlMachineModel.SelectedValue);
                    }
                }
            }
            catch (Exception ex)
            { }
        }
        private PdfPCell getPdfCellWithBoldText(string value)        {            iTextSharp.text.Font font = FontFactory.GetFont("Calibri (Body)", 11, iTextSharp.text.Font.BOLD);            iTextSharp.text.Font boldFont = new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.TIMES_ROMAN, 10, iTextSharp.text.Font.BOLD);            Chunk chunk = new Chunk(value, font);            chunk.Font.Color = new iTextSharp.text.BaseColor(77, 77, 77);            chunk.Font.Size = 8;            Phrase phrase = new Phrase();            phrase.Add(chunk);            PdfPCell cell = new PdfPCell(phrase);            cell.ExtraParagraphSpace = 3;            cell.BorderColor = new BaseColor(122, 121, 121);            return cell;        }        private PdfPCell getPdfCellWithBoldTextBlueColor(string value)        {            iTextSharp.text.Font font = FontFactory.GetFont("Calibri (Body)", 11, iTextSharp.text.Font.BOLD);            iTextSharp.text.Font boldFont = new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.TIMES_ROMAN, 10, iTextSharp.text.Font.BOLD);            Chunk chunk = new Chunk(value, font);            chunk.Font.Color = new iTextSharp.text.BaseColor(35, 35, 115);            chunk.Font.Size = 8;            Phrase phrase = new Phrase();            phrase.Add(chunk);            PdfPCell cell = new PdfPCell(phrase);            cell.ExtraParagraphSpace = 3;            cell.BorderColor = new BaseColor(122, 121, 121);            return cell;        }        private PdfPCell getPdfCellWithBoldHeader(string value)        {            iTextSharp.text.Font font = FontFactory.GetFont("Calibri (Body)", 13, iTextSharp.text.Font.BOLD |  iTextSharp.text.Font.UNDERLINE);            iTextSharp.text.Font boldFont = new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.TIMES_ROMAN, 10, iTextSharp.text.Font.BOLD);            Chunk chunk = new Chunk(value, font);            chunk.Font.Color = new iTextSharp.text.BaseColor(0, 32, 96);            chunk.Font.Size = 10;            Phrase phrase = new Phrase();            phrase.Add(chunk);            PdfPCell cell = new PdfPCell(phrase);            cell.ExtraParagraphSpace = 3;            cell.BorderColor = new BaseColor(122, 121, 121);            return cell;        }        private PdfPCell getPdfCellWithoutBoldText(string value)        {            iTextSharp.text.Font font = FontFactory.GetFont("Calibri (Body)", 10);            Chunk chunk = new Chunk(value, font);            chunk.Font.Color = new iTextSharp.text.BaseColor(10, 10, 10);            chunk.Font.Size = 7;            Phrase phrase = new Phrase();            phrase.Add(chunk);            PdfPCell cell = new PdfPCell(phrase);            cell.ExtraParagraphSpace = 3;            cell.BorderColor = new BaseColor(122, 121, 121);            return cell;        }
        private PdfPCell getPdfCellWithoutBoldRedText(string value)        {            iTextSharp.text.Font font = FontFactory.GetFont("Calibri (Body)", 10);            Chunk chunk = new Chunk(value, font);            chunk.Font.Color = new iTextSharp.text.BaseColor(255, 0, 0);            chunk.Font.Size = 7;            Phrase phrase = new Phrase();            phrase.Add(chunk);            PdfPCell cell = new PdfPCell(phrase);            cell.ExtraParagraphSpace = 3;            cell.BorderColor = new BaseColor(122, 121, 121);            return cell;        }
        protected void btnModelExportPDF_Click(object sender, EventArgs e)
        {
            generatePDF("Model Level Data","ModelLevelData","ModelLvl");
        }


        protected void btnControllerExportPDF_Click(object sender, EventArgs e)
        {
            generatePDF("Controller Level Data","ControllerLevelData","ControllerLvl");
        }

        protected void btnMachineExportPDF_Click(object sender, EventArgs e)
        {
            generatePDF("Machine Level Data","MachineLevelData","MachineLvl");
        }
        private void generatePDF(string headerName,string filename,string param)
        {
            try
            {
                if (Session["ProcessParamMasterData"] == null)
                {
                    return;
                }
                List<ProcessParameterMasterData> list = Session["ProcessParamMasterData"] as List<ProcessParameterMasterData>;
                Document pdfDoc = new Document(PageSize.A2, 15, 15, 25, 25);
                PdfWriter pdfWriter = PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
                pdfDoc.Open();

                PdfPTable modelLvlTable = new PdfPTable(1);
                modelLvlTable.SplitLate = false;
                modelLvlTable.WidthPercentage = 100;
                modelLvlTable.SpacingBefore = 20;
                modelLvlTable.DefaultCell.HorizontalAlignment = Element.ALIGN_CENTER;
                modelLvlTable.DefaultCell.VerticalAlignment = Element.ALIGN_MIDDLE;

                //header
                modelLvlTable.AddCell(new PdfPCell(getPdfCellWithBoldHeader(headerName)) { HorizontalAlignment = Element.ALIGN_CENTER, Colspan = 1, Border = 0 });

                //Filter
                if (param == "ModelLvl")
                {
                    PdfPTable filterTble = new PdfPTable(4);
                    filterTble.WidthPercentage = 100;
                    filterTble.SpacingBefore = 20;
                    filterTble.DefaultCell.HorizontalAlignment = Element.ALIGN_CENTER;
                    filterTble.DefaultCell.VerticalAlignment = Element.ALIGN_MIDDLE;
                    filterTble.AddCell(new PdfPCell(getPdfCellWithBoldText("CNC Make: " + ddlModelLvlCNCMake.SelectedValue)));
                    filterTble.AddCell(new PdfPCell(getPdfCellWithBoldText("Series / Model: " + ddlModelLvlCNCModel.SelectedValue)));
                    filterTble.AddCell(new PdfPCell(getPdfCellWithBoldText("Machine Type: " + ddlModelLvlMachineType.SelectedValue)));
                    filterTble.AddCell(new PdfPCell(getPdfCellWithBoldText("Machine Model: " + ddlModelLvlMachineModel.SelectedValue)));
                    modelLvlTable.AddCell(new PdfPCell(filterTble) { Colspan = 1, Border = 0 });
                }
                else if(param == "ControllerLvl")
                {
                    PdfPTable filterTble = new PdfPTable(4);
                    filterTble.WidthPercentage = 100;
                    filterTble.SpacingBefore = 20;
                   
                    filterTble.DefaultCell.HorizontalAlignment = Element.ALIGN_CENTER;
                    filterTble.DefaultCell.VerticalAlignment = Element.ALIGN_MIDDLE;
                    filterTble.AddCell(new PdfPCell(getPdfCellWithBoldText("CNC Make: " + ddlControlLvlCNCMake.SelectedValue)));
                    filterTble.AddCell(new PdfPCell(getPdfCellWithBoldText("Series / Model : " + ddlControlLvlCNCModel.SelectedValue)) {  Colspan = 3 });
                    modelLvlTable.AddCell(new PdfPCell(filterTble) { Colspan = 1, Border = 0 });
                }
                else if (param == "MachineLvl")
                {
                    PdfPTable filterTble = new PdfPTable(4);
                    filterTble.WidthPercentage = 100;
                    filterTble.SpacingBefore = 20;
                    filterTble.DefaultCell.HorizontalAlignment = Element.ALIGN_CENTER;
                    filterTble.DefaultCell.VerticalAlignment = Element.ALIGN_MIDDLE;
                    filterTble.AddCell(new PdfPCell(getPdfCellWithBoldText("Company : " + ddlMachineLvlCompany.SelectedValue)));
                    filterTble.AddCell(new PdfPCell(getPdfCellWithBoldText("Plant: " + ddlMachineLvlPlant.SelectedValue)));
                    filterTble.AddCell(new PdfPCell(getPdfCellWithBoldText("CNC Make: " + ddlMachineLvlCNCMake.SelectedValue)));
                    filterTble.AddCell(new PdfPCell(getPdfCellWithBoldText("Series / Model: " + ddlMachineLvlCNCModel.SelectedValue)));
                    filterTble.AddCell(new PdfPCell(getPdfCellWithBoldText("MTB: " + ddlMachineLvlMTB.SelectedValue)));
                    filterTble.AddCell(new PdfPCell(getPdfCellWithBoldText("Machine Type: " + ddlMachineLvlMachineType.SelectedValue)));
                    filterTble.AddCell(new PdfPCell(getPdfCellWithBoldText("Machine Model: " + ddlMachineLvlMachineModel.SelectedValue)));
                    filterTble.AddCell(new PdfPCell(getPdfCellWithBoldText("Machine ID: " + ddlMachineLvlMachineID.SelectedValue)));
                    modelLvlTable.AddCell(new PdfPCell(filterTble) { Colspan = 1, Border = 0 });
                }

                //Data
                PdfPTable modelDataTbl = new PdfPTable(15);
                modelDataTbl.SplitLate = false;
                modelDataTbl.WidthPercentage = 100;
                modelDataTbl.SpacingBefore = 10;
                modelDataTbl.DefaultCell.HorizontalAlignment = Element.ALIGN_CENTER;
                modelDataTbl.DefaultCell.VerticalAlignment = Element.ALIGN_MIDDLE;
                modelDataTbl.AddCell(new PdfPCell(getPdfCellWithBoldText("Parameter ID")) { BackgroundColor = new BaseColor(214, 215, 223) });
                modelDataTbl.AddCell(new PdfPCell(getPdfCellWithBoldText("Source Type")) { BackgroundColor = new BaseColor(214, 215, 223) });
                modelDataTbl.AddCell(new PdfPCell(getPdfCellWithBoldText("Source Address 1")) { BackgroundColor = new BaseColor(214, 215, 223) });
                modelDataTbl.AddCell(new PdfPCell(getPdfCellWithBoldText("Source Data Type 1")) { BackgroundColor = new BaseColor(214, 215, 223) });
                modelDataTbl.AddCell(new PdfPCell(getPdfCellWithBoldText("Source Address 2")) { BackgroundColor = new BaseColor(214, 215, 223) });
                modelDataTbl.AddCell(new PdfPCell(getPdfCellWithBoldText("Source Data Type 2")) { BackgroundColor = new BaseColor(214, 215, 223) });

                PdfPTable pollingFrqTbl = new PdfPTable(2);
                pollingFrqTbl.AddCell(new PdfPCell(getPdfCellWithBoldText("Polling")) { HorizontalAlignment = Element.ALIGN_CENTER, Colspan = 2, BackgroundColor = new BaseColor(214, 215, 223) });
                pollingFrqTbl.AddCell(new PdfPCell(getPdfCellWithBoldText("Frequency (Sec)")) { HorizontalAlignment = Element.ALIGN_CENTER, Colspan = 1, BackgroundColor = new BaseColor(214, 215, 223) });
                pollingFrqTbl.AddCell(new PdfPCell(getPdfCellWithBoldText("Time")) { HorizontalAlignment = Element.ALIGN_CENTER, Colspan = 1 });
                modelDataTbl.AddCell(new PdfPCell(pollingFrqTbl) { Colspan = 1, BackgroundColor = new BaseColor(214, 215, 223) });

                PdfPTable cycleFrqTbl = new PdfPTable(2);
                cycleFrqTbl.AddCell(new PdfPCell(getPdfCellWithBoldText("Cycle")) { HorizontalAlignment = Element.ALIGN_CENTER, Colspan = 2, BackgroundColor = new BaseColor(214, 215, 223) });
                cycleFrqTbl.AddCell(new PdfPCell(getPdfCellWithBoldText("Frequency (Hr)")) { HorizontalAlignment = Element.ALIGN_CENTER, Colspan = 1, BackgroundColor = new BaseColor(214, 215, 223) });
                cycleFrqTbl.AddCell(new PdfPCell(getPdfCellWithBoldText("Number")) { HorizontalAlignment = Element.ALIGN_CENTER, Colspan = 1 });
                modelDataTbl.AddCell(new PdfPCell(cycleFrqTbl) { Colspan = 1, BackgroundColor = new BaseColor(214, 215, 223) });


                modelDataTbl.AddCell(new PdfPCell(getPdfCellWithBoldText("Upper Warning Limit")) { BackgroundColor = new BaseColor(214, 215, 223) });
                modelDataTbl.AddCell(new PdfPCell(getPdfCellWithBoldText("Lower Warning Limit")) { BackgroundColor = new BaseColor(214, 215, 223) });
                modelDataTbl.AddCell(new PdfPCell(getPdfCellWithBoldText("Upper Error Limit")) { BackgroundColor = new BaseColor(214, 215, 223) });
                modelDataTbl.AddCell(new PdfPCell(getPdfCellWithBoldText("Lower Error Limit")) { BackgroundColor = new BaseColor(214, 215, 223) });
                modelDataTbl.AddCell(new PdfPCell(getPdfCellWithBoldText("Unit")) { BackgroundColor = new BaseColor(214, 215, 223) });
                modelDataTbl.AddCell(new PdfPCell(getPdfCellWithBoldText("Is Enabled?")) { BackgroundColor = new BaseColor(214, 215, 223) });
                modelDataTbl.AddCell(new PdfPCell(getPdfCellWithBoldText("Parameter Level")) { BackgroundColor = new BaseColor(214, 215, 223) });
                if (list.Count > 0)
                {
                    for (int i = 0; i < list.Count; i++)
                    {
                        modelDataTbl.AddCell(new PdfPCell(getPdfCellWithoutBoldText(list[i].ParemeterID)));
                        modelDataTbl.AddCell(new PdfPCell(getPdfCellWithoutBoldText(list[i].SourceType)));
                        modelDataTbl.AddCell(new PdfPCell(getPdfCellWithoutBoldText(list[i].SourceAdd1)));
                        modelDataTbl.AddCell(new PdfPCell(getPdfCellWithoutBoldText(list[i].SrcDataType1PDF)));
                        modelDataTbl.AddCell(new PdfPCell(getPdfCellWithoutBoldText(list[i].SourceAdd2)));
                        modelDataTbl.AddCell(new PdfPCell(getPdfCellWithoutBoldText(list[i].SrcDataType2PDF)));

                        PdfPTable pollingFrqTbl1 = new PdfPTable(2);
                        pollingFrqTbl1.AddCell(new PdfPCell(getPdfCellWithoutBoldText(list[i].PollingFrequency)) { HorizontalAlignment = Element.ALIGN_CENTER, Colspan = 1 });
                        string pollingtype = list[i].PollingType;
                        if (pollingtype == "DuringCycleOnce")
                        {
                            pollingtype = "OnceDuringCycle";
                        }
                        pollingFrqTbl1.AddCell(new PdfPCell(getPdfCellWithoutBoldText(pollingtype)) { HorizontalAlignment = Element.ALIGN_CENTER, Colspan = 1 });
                        modelDataTbl.AddCell(new PdfPCell(pollingFrqTbl1) { Colspan = 1 });

                        PdfPTable cycleFrqTbl1 = new PdfPTable(2);
                        string cycleFrqTime = list[i].CycleFreqTime;
                        if (cycleFrqTime == "0")
                        {
                            cycleFrqTime = "None";
                        }
                        cycleFrqTbl1.AddCell(new PdfPCell(getPdfCellWithoutBoldText(cycleFrqTime)) { HorizontalAlignment = Element.ALIGN_CENTER, Colspan = 1 });
                        cycleFrqTbl1.AddCell(new PdfPCell(getPdfCellWithoutBoldText(list[i].NoOfCycle)) { HorizontalAlignment = Element.ALIGN_CENTER, Colspan = 1 });
                        modelDataTbl.AddCell(new PdfPCell(cycleFrqTbl1) { Colspan = 1 });


                        modelDataTbl.AddCell(new PdfPCell(getPdfCellWithoutBoldText(list[i].UpperWarning)));
                        modelDataTbl.AddCell(new PdfPCell(getPdfCellWithoutBoldText(list[i].LowerWarning)));
                        modelDataTbl.AddCell(new PdfPCell(getPdfCellWithoutBoldText(list[i].UpperError)));
                        modelDataTbl.AddCell(new PdfPCell(getPdfCellWithoutBoldText(list[i].LowerError)));
                        modelDataTbl.AddCell(new PdfPCell(getPdfCellWithoutBoldText(list[i].Unit)));
                        if (list[i].IsEnabled)
                        {
                            byte[] checkfile;
                            checkfile = System.IO.File.ReadAllBytes(Server.MapPath("~/Images/Check.png"));//ImagePath  
                            iTextSharp.text.Image checkjpg = iTextSharp.text.Image.GetInstance(checkfile);
                            checkjpg.BackgroundColor = new iTextSharp.text.BaseColor(255, 255, 255);
                            checkjpg.ScaleToFit(10f, 10f);
                            PdfPCell cell = new PdfPCell(checkjpg, false);
                            cell.BorderWidth = 1;
                            cell.Padding = 2;
                            cell.HorizontalAlignment = Element.ALIGN_LEFT;
                            modelDataTbl.AddCell(cell).BorderColor = new BaseColor(122, 121, 121);
                        }
                        else
                        {
                            byte[] uncheckfile;
                            uncheckfile = System.IO.File.ReadAllBytes(Server.MapPath("~/Images/Uncheck.png"));//ImagePath  
                            iTextSharp.text.Image uncheckjpg = iTextSharp.text.Image.GetInstance(uncheckfile);
                            uncheckjpg.BackgroundColor = new iTextSharp.text.BaseColor(255, 255, 255);
                            uncheckjpg.ScaleToFit(10f, 10f);
                            PdfPCell cell = new PdfPCell(uncheckjpg, false);
                            cell.BorderWidth = 1;
                            cell.Padding = 2;
                            cell.HorizontalAlignment = Element.ALIGN_LEFT;
                            modelDataTbl.AddCell(cell).BorderColor = new BaseColor(122, 121, 121);
                        }
                        modelDataTbl.AddCell(new PdfPCell(getPdfCellWithoutBoldText(list[i].ScreenName)));

                    }
                }
                modelLvlTable.AddCell(new PdfPCell(modelDataTbl) { Colspan = 1, Border = 0 });

                pdfDoc.Add(modelLvlTable);
                pdfWriter.CloseStream = false;
                pdfDoc.Close();
                Response.Buffer = true;
                Response.ContentType = "application/pdf";
                Response.AddHeader("content-disposition", "attachment;filename="+ filename + ".pdf");
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.Write(pdfDoc);
                //Response.End();
                Response.Flush();
            }
            catch (Exception ex)
            {

            }
        }
    }


}