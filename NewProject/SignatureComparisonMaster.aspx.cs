using MongoDB.Bson;
using MongoDB.Driver;
using NewProject.DataBaseAccess;
using NewProject.Model;
using OfficeOpenXml;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NewProject
{
    public partial class SignatureComparisonMaster : System.Web.UI.Page
    {
       
        bool txtVisible, lblVisible;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindCompanyData();
                btnView_Click(null, null);

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
                string accestype = list.Where(x => x.Screen == "Signature Comparison").Select(x => x.Value).FirstOrDefault();
                if (accestype == "Read")
                {
                    btnImport.Visible = false;
                    gvSignatureComparisionDetails.ShowFooter = false;
                    DBAccess.ShowHideColumnOfGrid(gvSignatureComparisionDetails, false, "Action");
                }
                else
                {
                    btnImport.Visible = true;
                    gvSignatureComparisionDetails.ShowFooter = true;
                    DBAccess.ShowHideColumnOfGrid(gvSignatureComparisionDetails, true, "Action");
                }
            }
            catch (Exception ex)
            {

            }
        }
        private void BindCompanyData()
        {
            try
            {
                List<string> list = DBAccess.getCompanyData();
                ddlCompany.DataSource = list;
                ddlCompany.DataBind();
                BindPlantData();
            }
            catch(Exception ex)
            {

            }
        }
        private void BindPlantData()
        {
            try
            {
                List<string> list = DBAccess.getPlantData(ddlCompany.SelectedValue);
                ddlPlant.DataSource = list;
                ddlPlant.DataBind();
                bindMachineID();

            }
            catch (Exception ex)
            {

            }
        }
        private void bindMachineID()
        {
            try
            {
                ddlMachine.DataSource = MongoDBAccess.getMachineID(ddlCompany.SelectedValue,ddlPlant.SelectedValue);
                ddlMachine.DataBind();
                BindParameters();
            }
            catch (Exception ex)
            {

            }
        }
        private void BindParameters()
        {
            try
            {
                BsonArray machineNames = new BsonArray();
                machineNames.Add(ddlMachine.SelectedValue);
                List<ListItem> parameterList = new List<ListItem>();
                parameterList = MongoDBAccess.getParameterListForMachines(machineNames, ddlCompany.SelectedValue, ddlPlant.SelectedValue);
                lbProcessParameters.DataSource = parameterList;
                lbProcessParameters.DataBind();
                if (parameterList.Count > 0)
                {
                    for (int i = 0; i < lbProcessParameters.Items.Count; i++)
                    {
                        lbProcessParameters.Items[i].Selected = true;
                    }
                }
                BindSignatureID();
            }
            catch (Exception ex)
            {

            }
        }
        private void BindSignatureID()
        {
            try
            {
                string selctedSignatureId = ddlSignatureID.SelectedValue;
                string machine = ddlMachine.SelectedValue;
                BsonArray parameters = new BsonArray();
                foreach (ListItem item in lbProcessParameters.Items)
                {
                    if (item.Selected)
                    {
                        if (parameters == "")
                        {
                            parameters.Add(item.Value);
                        }
                        else
                        {
                            parameters.Add(item.Value);
                        }
                    }
                }
                List<string> parameterList = new List<string>();
                parameterList = MongoDBAccess.getSignatureId(ddlCompany.SelectedValue,ddlPlant.SelectedValue, machine, parameters);
                ddlSignatureID.Items.Clear();
                ddlSignatureID.DataSource = parameterList;
                ddlSignatureID.DataBind();
                ddlSignatureID.Items.Insert(0, "All");
                try
                {
                    if (selctedSignatureId != "")
                    {
                        ddlSignatureID.SelectedValue = selctedSignatureId;
                    }
                }
                catch (Exception ex) { }

            }
            catch (Exception ex)
            {

            }
        }
        //private void BindNewSignatureID()
        //{
        //    try
        //    {
        //        string machine = ddlMachine.SelectedValue;
        //        BsonArray parameters = new BsonArray();
        //        foreach (ListItem item in lbProcessParameters.Items)
        //        {
        //            if (item.Selected)
        //            {
        //                if (parameters == "")
        //                {
        //                    parameters.Add(item.Value);
        //                }
        //                else
        //                {
        //                    parameters.Add(item.Value);
        //                }
        //            }
        //        }
        //        List<string> parameterList = new List<string>();
        //        parameterList = MongoDBAccess.getSignatureId(machine, parameters);
        //        for (int i = 0; i < parameterList.Count; i++)
        //        {
        //            if (ddlSignatureID.Items.FindByText(parameterList[i]) == null)
        //            {
        //                ddlSignatureID.Items.Add(parameterList[i]);
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {

        //    }
        //}
        protected void ddlCompany_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                BindPlantData();
            }
            catch (Exception ex)
            { }
        }

        protected void ddlPlant_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                bindMachineID();
            }
            catch (Exception ex)
            { }
        }
        protected void ddlMachine_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindParameters();
        }

        protected void lbProcessParameters_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindSignatureID();
        }
        private void BindSignatureDetails()
        {
            try
            {
                BindSignatureID();
                string company = ddlCompany.SelectedValue == null ? "" : ddlCompany.SelectedValue.ToString();
                string plant = ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString();
                string machineId = ddlMachine.SelectedValue == null ? "" : ddlMachine.SelectedValue.ToString();
                string parameters = "";
                int selectedParameterCount = 0;
                string selectedParameter = "";
                foreach (ListItem item in lbProcessParameters.Items)
                {
                    if (item.Selected)
                    {
                        selectedParameterCount++;
                        selectedParameter = item.Value;
                        parameters += "'" + item.Value + "',";
                    }
                }
                if (parameters.Length > 0)
                {
                    parameters = parameters.Remove(parameters.Length - 1);
                }
                string signatureid = ddlSignatureID.SelectedValue == null ? "" : ddlSignatureID.SelectedValue.ToString();
                if(company=="")
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "warning", "openWarningModal('Please select Company.');", true);
                    return;
                }
                if (plant == "")
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "warning", "openWarningModal('Please select Plant.');", true);
                    return;
                }
                if (machineId == "")
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "warning", "openWarningModal('Please select Machine.');", true);
                    return;
                }
                if (selectedParameterCount == 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "warning", "openWarningModal('Please select Process Parameter.');", true);
                    return;
                }
                if (signatureid == "")
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "warning", "openWarningModal('Please select Signature ID.');", true);
                    return;
                }
                //EDIT & ADD NEW will be enabled for 1 Machine, 1 Parameter and 1 Signature only 
                if (company!="" && plant!="" && machineId != "" && selectedParameterCount == 1 && signatureid != "All")
                {
                    btnSave.Visible = true;
                    txtVisible = true;
                    lblVisible = false;
                }
                else
                {
                    btnSave.Visible = false;
                    txtVisible = false;
                    lblVisible = true;
                }


                List<SignatureComparisionDetails> signatureComparisionDetails = MongoDBAccess.getSignatureComparisonMasterData(company,plant,machineId,parameters,signatureid);
                gvSignatureComparisionDetails.DataSource = signatureComparisionDetails;
                gvSignatureComparisionDetails.DataBind();
                if (signatureComparisionDetails.Count > 0)
                {
                    gvSignatureComparisionDetails.FooterRow.Visible = false;
                }
                //EDIT & ADD NEW will be enabled for 1 Machine, 1 Parameter and 1 Signature only 
                if (company != "" && plant != "" && machineId != "" && selectedParameterCount == 1 && signatureid != "All")
                {
                    if (signatureComparisionDetails.Count > 0)
                    {
                        gvSignatureComparisionDetails.FooterRow.Visible = true;
                    } 
                    (gvSignatureComparisionDetails.FooterRow.FindControl("lblSignatureIDNew") as Label).Text = signatureid;
                    (gvSignatureComparisionDetails.FooterRow.FindControl("lblParemeterIDNew") as Label).Text = selectedParameter;
                }
                // BindNewSignatureID();
                //for (int i = 0; i < gvSignatureComparisionDetails.Rows.Count; i++)
                //{
                //    (gvSignatureComparisionDetails.Rows[i].FindControl("lblSeconds") as Label).Visible = lblVisible;
                //    (gvSignatureComparisionDetails.Rows[i].FindControl("txtSeconds") as TextBox).Visible = txtVisible;
                //    (gvSignatureComparisionDetails.Rows[i].FindControl("lblSignatureValue") as Label).Visible = lblVisible;
                //    (gvSignatureComparisionDetails.Rows[i].FindControl("txtSignatureValue") as TextBox).Visible = txtVisible;
                //}
            }
            catch (Exception ex)
            {

            }
        }
        protected void gvSignatureComparisionDetails_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                (e.Row.FindControl("lblSeconds") as Label).Visible = lblVisible;
                (e.Row.FindControl("txtSeconds") as TextBox).Visible = txtVisible;
                (e.Row.FindControl("lblSignatureValue") as Label).Visible = lblVisible;
                (e.Row.FindControl("txtSignatureValue") as TextBox).Visible = txtVisible;
            }
        }
        protected void btnImport_Click(object sender, EventArgs e)
        {
            try
            {
                int success = 0;
                string APP_PATH = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);
                DataTable dtMaster = new DataTable();
                if (fpFile.HasFile)
                {
                    string fileName = fpFile.FileName;
                    if (Path.GetExtension(fileName) != ".xlsx" && Path.GetExtension(fileName) != ".xls")
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "RecordsTextopenModaladded", "openWarningModal('Please choose the valid .xlsx or .xls file');", true);
                        return;
                    }
                    else
                    {
                        if (!Directory.Exists(Server.MapPath("ImportedFiles")))
                        {
                            Directory.CreateDirectory(Server.MapPath("ImportedFiles"));
                        }
                        string savedFileName = Server.MapPath("ImportedFiles//" + fileName);
                        fpFile.SaveAs(savedFileName);
                        string Errormsg = "";
                        dtMaster = GetDataTableFromFile(savedFileName);

                        var distinctValues = dtMaster.AsEnumerable()
                        .Select(row => new {
                            CompanyID = row.Field<string>("CompanyID"),
                            PlantID = row.Field<string>("PlantID"),
                            MachineID = row.Field<string>("MachineID"),
                            ParameterID = row.Field<string>("ParameterID"),
                            SignatureID = row.Field<string>("SignatureID")
                        }).Distinct();
                        List<SignatureComparisionData> existingSeqList = new List<SignatureComparisionData>();
                        foreach (var item in distinctValues)
                        {
                            //if data exist store it in another list
                            if (isSignatureDetailsExist(item.CompanyID,item.PlantID, item.MachineID, item.ParameterID, item.SignatureID))
                            {
                                SignatureComparisionData existingSeqdata = new SignatureComparisionData();
                                existingSeqdata.Company = item.CompanyID;
                                existingSeqdata.Plant = item.PlantID;
                                existingSeqdata.MachineID = item.MachineID;
                                existingSeqdata.ParameterID = item.ParameterID;
                                existingSeqdata.SignatureID = item.SignatureID;
                                List<SignatureComparisionDetails> seqList = new List<SignatureComparisionDetails>();
                                var paramSignatureList = dtMaster.AsEnumerable().Where(myRow => myRow.Field<string>("ParameterID") == item.ParameterID && myRow.Field<string>("SignatureID") == item.SignatureID);
                                foreach (var data in paramSignatureList)
                                {
                                    SignatureComparisionDetails seqData = new SignatureComparisionDetails();
                                    seqData.SignatureID = data.ItemArray[4].ToString();
                                    seqData.Frequency = data.ItemArray[5].ToString();
                                    seqData.ParameterValue = data.ItemArray[6].ToString();
                                    seqList.Add(seqData);
                                }
                                existingSeqdata.SignatureData = seqList;
                                existingSeqList.Add(existingSeqdata);
                            }
                            else
                            {
                                List<SignatureComparisionDetails> masterList = new List<SignatureComparisionDetails>();
                                var paramSignatureList = dtMaster.AsEnumerable().Where(myRow => myRow.Field<string>("ParameterID") == item.ParameterID && myRow.Field<string>("SignatureID") == item.SignatureID);
                                foreach (var data in paramSignatureList)
                                {
                                    SignatureComparisionDetails seqData = new SignatureComparisionDetails();
                                    seqData.CompanyID = data.ItemArray[0].ToString();
                                    seqData.PlantID = data.ItemArray[1].ToString();
                                    seqData.MachineID = data.ItemArray[2].ToString();
                                    seqData.ParameterID = data.ItemArray[3].ToString();
                                    seqData.SignatureID = data.ItemArray[4].ToString();
                                    seqData.Frequency = data.ItemArray[5].ToString();
                                    seqData.ParameterValue = data.ItemArray[6].ToString();
                                    masterList.Add(seqData);
                                }
                                MongoDBAccess.insertSignatureComparisonMasterData(masterList);
                            }
                        }
                        if (existingSeqList.Count > 0)
                        {

                            Session["SignatureExistingData"] = existingSeqList;
                            ScriptManager.RegisterStartupScript(this, GetType(), "openModal", "openExistingSignatureDataModal();", true);
                            btnOverwrite.Enabled = true;
                            btnChangeSave.Visible = false;
                            btnChange.Visible = true;
                            btnChangeCancel.Visible = false;
                            lvExistingSignature.DataSource = existingSeqList;
                            lvExistingSignature.DataBind();
                        }
                        else
                        {
                            Session["SignatureExistingData"] = null;
                        }
                    }
                    BindSignatureDetails();
                    //if (success <= 0)
                    //{
                    //    ScriptManager.RegisterStartupScript(this, GetType(), "RecordsTextopenModaladded", "openErrorModal('Excel file import failed.');", true);
                    //    return;
                    //}
                    //if (success > 0)
                    //{
                    //    gvPMMaster.EditIndex = -1;
                    //    bindPMMasterDetails();
                    //}
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "RecordsTextopenModaladded", "openErrorModal('Please choose a file to import.');", true);
                }

            }
            catch (Exception ex)
            {

            }
        }
        private bool isSignatureDetailsExist(string company,string plant, string machine, string parameter, string signature)
        {
            return MongoDBAccess.isSignatureIdDetailsExists( company,  plant,  machine,  parameter,  signature);
        }
        private static int GetLastUsedRow(ExcelWorksheet sheet)
        {
            var row = sheet.Dimension.End.Row;
            while (row >= 1)
            {
                var range = sheet.Cells[row, 1, row, sheet.Dimension.End.Column];
                if (range.Any(c => !string.IsNullOrEmpty(c.Text)))
                {
                    break;
                }
                row--;
            }
            return row;
        }
        private DataTable GetDataTableFromFile(string fileName)
        {
            DataTable dtPOMaster = new DataTable();
            int rowNum = 0;
            string pono = "";
            using (var pck = new ExcelPackage())
            {
                using (var stream = File.OpenRead(fileName))
                {
                    pck.Load(stream);
                }
                var workBook = pck.Workbook;
                if (workBook != null)
                {
                    try
                    {
                        string selectedParameter = "";
                        foreach (ListItem item in lbProcessParameters.Items)
                        {
                            if (item.Selected)
                            {
                                selectedParameter += "&" + item.Value + "&";
                            }
                        }
                        var worksheet = workBook.Worksheets[1];
                        dtPOMaster.Columns.Add("CompanyID");
                        dtPOMaster.Columns.Add("PlantID");
                        dtPOMaster.Columns.Add("MachineID");
                        dtPOMaster.Columns.Add("ParameterID");
                        dtPOMaster.Columns.Add("SignatureID");
                        dtPOMaster.Columns.Add("Seconds");
                        dtPOMaster.Columns.Add("SignatureValue");
                        //dtPOMaster.Columns.Add("DueDate", typeof(DateTime));
                        string machine = ddlMachine.SelectedItem.ToString();
                        string company =  ddlCompany.SelectedItem.ToString();
                        string plant = ddlPlant.SelectedItem.ToString();
                        int startRow = 2, tblColStart = 0;
                        int lastRow = GetLastUsedRow(worksheet);
                        rowNum = startRow;
                        for (rowNum = startRow; rowNum <= lastRow; rowNum++)
                        {
                            string parameter = worksheet.Cells[rowNum, 1].Text;
                            if (selectedParameter.IndexOf(parameter, StringComparison.Ordinal) >= 0)
                            {
                                var wsRow = worksheet.Cells[rowNum, 1, rowNum, 13];
                                var tblRow = dtPOMaster.NewRow();
                                tblColStart = 3;
                                bool enteredCell = false;
                                tblRow[0] = company;
                                tblRow[1] = plant;
                                tblRow[2] = machine;
                                //tblColStart++;
                                foreach (var cell in wsRow)
                                {
                                    enteredCell = true;
                                    tblRow[tblColStart] = cell.Text.Trim();
                                    tblColStart++;
                                }
                                dtPOMaster.Rows.Add(tblRow);
                            }
                        }
                    }
                    catch (Exception ex)
                    {


                        Logger.WriteDebugLog("Error while importing Signature Comparison Details : " + ex.Message);
                    }
                }
            }
            return dtPOMaster;
        }

        protected void btnView_Click(object sender, EventArgs e)
        {
            BindSignatureDetails();
        }

        //Copy Function
        protected void btnCopySignatureValue_Click(object sender, EventArgs e)
        {
            try
            {
                int index = Convert.ToInt32(((sender as LinkButton).NamingContainer as GridViewRow).RowIndex);
                string machine = ddlMachine.SelectedValue;
                string company = ddlCompany.SelectedValue;
                string plant = ddlPlant.SelectedValue;
                string parameter = (gvSignatureComparisionDetails.Rows[index].FindControl("lblParemeterID") as Label).Text;
                string signatueID = (gvSignatureComparisionDetails.Rows[index].FindControl("lblSignatureID") as Label).Text;
                lblSrcCopyCompany.Text = company;
                lblSrcCopyPlant.Text = plant;
                lblSrcCopyMachine.Text = machine;
                lblSrcCopyParameter.Text = parameter;
                lblSrcCopySignature.Text = signatueID;
                ddlDestiCopyMachine.DataSource = MongoDBAccess.getMachineID(company,plant);
                ddlDestiCopyMachine.DataBind();
                txtDestiCopySignature.Text = "";
                ddlDestiCopyMachine_SelectedIndexChanged(null, null);
                ScriptManager.RegisterStartupScript(this, GetType(), "warning", "openCopySignatureValueModal();", true);
            }
            catch (Exception ex)
            {

            }

        }
        protected void ddlDestiCopyMachine_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                string company = lblSrcCopyCompany.Text;
                string plant = lblSrcCopyPlant.Text;
                BsonArray machineNames = new BsonArray();
                machineNames.Add(ddlDestiCopyMachine.SelectedValue);
                ddlDestiCopyParameter.DataSource = MongoDBAccess.getParameterListForMachines(machineNames,company,plant);
                ddlDestiCopyParameter.DataBind();
                ScriptManager.RegisterStartupScript(this, GetType(), "warning", "openCopySignatureValueModal();", true);
            }
            catch (Exception ex)
            {

            }
        }

        protected void btnCopy_Click(object sender, EventArgs e)
        {
            try
            {
                string srcCompany = lblSrcCopyCompany.Text;
                string srcPlant = lblSrcCopyPlant.Text;
                string srcMachine = lblSrcCopyMachine.Text;
                string srcSignature = lblSrcCopySignature.Text;
                string srcParameter = lblSrcCopyParameter.Text;
                srcParameter = "'" + srcParameter + "'";

                string destiMachine = ddlDestiCopyMachine.SelectedValue;
                string destiSignature = txtDestiCopySignature.Text;
                string destiParameter = ddlDestiCopyParameter.SelectedValue;


                //get source data details
                //BsonArray parameters = new BsonArray();
                //parameters.Add(srcParameter);
                //var filter = "{'CompanyID':'" + srcCompany + "','PlantID':'" + srcPlant + "',MachineID: '" + srcMachine + "',SignatureID: '" + srcSignature + "',ParameterID: '" + srcParameter + "'}";
                List<SignatureComparisionDetails> sourceDetails = new List<SignatureComparisionDetails>();
               // sourceDetails = _MongoDatabase.GetCollection<SignatureComparisionDetails>("PP_AMGIOT_SignatureMaster").Find(filter).ToList();
                sourceDetails = MongoDBAccess.getSignatureComparisonMasterData(srcCompany, srcPlant,srcMachine,srcParameter,srcSignature);


                List<SignatureComparisionDetails> masterList = new List<SignatureComparisionDetails>();
                for (int i = 0; i < sourceDetails.Count; i++)
                {
                    SignatureComparisionDetails master = new SignatureComparisionDetails();
                    master.CompanyID = srcCompany;
                    master.PlantID = srcPlant;
                    master.MachineID = destiMachine;
                    master.ParameterID = destiParameter;
                    master.SignatureID = destiSignature;
                    master.Frequency = sourceDetails[i].Frequency;
                    master.ParameterValue = sourceDetails[i].ParameterValue;
                    masterList.Add(master);
                }
                MongoDBAccess.insertSignatureComparisonMasterData(masterList);
                BindSignatureDetails();

                //get dsetination detail from db for validation.
                //BsonArray destiparameters = new BsonArray();
                //destiparameters.Add(destiParameter);
                //var destifilter = "{MachineID: '" + destiMachine + "',SignatureID: '" + destiSignature + "',Parameter: '" + destiParameter + "'}";
                //List<SignatureComparisionDetails> destiDetails = new List<SignatureComparisionDetails>();
                //destiDetails = _MongoDatabase.GetCollection<SignatureComparisionDetails>("SignatureComparisionMaster").Find(destifilter).ToList();

                //List<SignatureComparisionDetails> existingDataList = new List<SignatureComparisionDetails>();
                //var collection = _MongoDatabase.GetCollection<SignatureComparisionDetails>("SignatureComparisionMaster");
                //if (destiDetails.Count > 0)
                //{
                //    foreach (SignatureComparisionDetails item in sourceDetails)
                //    {
                //        //check new machine and parameter contain entered signature id

                //    }
                //}
                //else
                //{

                //}

            }
            catch (Exception ex)
            { }
        }

        #region ------- Change Signature Id ------
        protected void btnChangeSignatureID_Click(object sender, EventArgs e)
        {
            try
            {
                int index = Convert.ToInt32(((sender as LinkButton).NamingContainer as GridViewRow).RowIndex);
                lblChangeSignCompany.Text = ddlCompany.SelectedValue;
                lblChangeSignPlant.Text = ddlPlant.SelectedValue;
                lblChangeSignMachine.Text = ddlMachine.SelectedValue;
                lblChangeParameter.Text = (gvSignatureComparisionDetails.Rows[index].FindControl("lblParemeterID") as Label).Text;
                lblChangeSignIdFrom.Text = (gvSignatureComparisionDetails.Rows[index].FindControl("lblSignatureID") as Label).Text;
                txtChangeSignatureID.Text = "";
                ScriptManager.RegisterStartupScript(this, GetType(), "warning", "openChangeSignatureIDModal();", true);
            }
            catch (Exception ex)
            {

            }
        }
        #endregion

        protected void btnChangeSignature_Click(object sender, EventArgs e)
        {
            try
            {
               
                string company = lblChangeSignCompany.Text;
                string plant = lblChangeSignPlant.Text;
                string machine = lblChangeSignMachine.Text;
                string parameter = lblChangeParameter.Text;
                string idFrom = lblChangeSignIdFrom.Text;
                string idTo = txtChangeSignatureID.Text;
                //update query
                MongoDBAccess.updateSignatureIdMasterData(company,plant,machine,parameter,idFrom,idTo);
                BindSignatureDetails();
            }
            catch (Exception ex)
            { }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
               
                for (int i = 0; i < gvSignatureComparisionDetails.Rows.Count; i++)
                {
                    string hdnValue = (gvSignatureComparisionDetails.Rows[i].FindControl("hdnUpdate") as HiddenField).Value;
                    if (hdnValue.Equals("update", StringComparison.OrdinalIgnoreCase))
                    {
                        string id = (gvSignatureComparisionDetails.Rows[i].FindControl("hdnID") as HiddenField).Value;
                        SignatureComparisionDetails master = new SignatureComparisionDetails();
                        master.CompanyID = ddlCompany.SelectedValue;
                        master.PlantID = ddlPlant.SelectedValue;
                        master.MachineID = ddlMachine.SelectedValue;
                        master.ParameterID = (gvSignatureComparisionDetails.Rows[i].FindControl("lblParemeterID") as Label).Text;
                        master.SignatureID = (gvSignatureComparisionDetails.Rows[i].FindControl("lblSignatureID") as Label).Text;
                        master.Frequency = (gvSignatureComparisionDetails.Rows[i].FindControl("txtSeconds") as TextBox).Text;
                        master.ParameterValue = (gvSignatureComparisionDetails.Rows[i].FindControl("txtSignatureValue") as TextBox).Text;
                        if (master.Frequency == "")
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "warning", "openWarningModal('Please enter Seconds.');", true);
                            return;
                        }
                        if (master.ParameterValue == "")
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "warning", "openWarningModal('Please enter Signature Value.');", true);
                            return;
                        }
                        MongoDBAccess.updateSignatureFreqAndParameterMasterDataByID(id, master);
                    }
                }
                BindSignatureDetails();
            }
            catch (Exception ex)
            {

            }
        }
        protected void btnInsert_Click(object sender, EventArgs e)
        {
            try
            {
                List<SignatureComparisionDetails> list = new List<SignatureComparisionDetails>();
                SignatureComparisionDetails master = new SignatureComparisionDetails();
                master.CompanyID = ddlCompany.SelectedValue;
                master.PlantID = ddlPlant.SelectedValue;
                master.MachineID = ddlMachine.SelectedValue;
                master.ParameterID = (gvSignatureComparisionDetails.FooterRow.FindControl("lblParemeterIDNew") as Label).Text;
                master.SignatureID = (gvSignatureComparisionDetails.FooterRow.FindControl("lblSignatureIDNew") as Label).Text;
                master.Frequency = (gvSignatureComparisionDetails.FooterRow.FindControl("txtSecondsNew") as TextBox).Text.Trim();
                master.ParameterValue = (gvSignatureComparisionDetails.FooterRow.FindControl("txtSignatureValueNew") as TextBox).Text.Trim();
                list.Add(master);
                if (master.CompanyID == "")
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "warning", "openWarningModal('Please select Company.');", true);
                    return;
                }
                if (master.PlantID == "")
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "warning", "openWarningModal('Please select Plant.');", true);
                    return;
                }
                if (master.MachineID == "")
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "warning", "openWarningModal('Please select Machine.');", true);
                    return;
                }
                if (master.ParameterID == "")
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "warning", "openWarningModal('Please select Process Parameter.');", true);
                    return;
                }
                if (master.SignatureID == "")
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "warning", "openWarningModal('Please select Signature ID.');", true);
                    return;
                }
                if (master.Frequency == "")
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "warning", "openWarningModal('Please enter Seconds.');", true);
                    return;
                }
                if (master.ParameterValue == "")
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "warning", "openWarningModal('Please enter Signature Value.');", true);
                    return;
                }
                MongoDBAccess.insertSignatureComparisonMasterData(list);
                BindSignatureDetails();
            }
            catch (Exception ex)
            {

            }
        }
        static string appPath = HttpContext.Current.Server.MapPath("");
        public static string GetReportPath(string reportName)
        {
            string src;
            src = Path.Combine(appPath, "ExportTempaltes", reportName);
            return src;
        }
        public static string SafeFileName(string name)
        {
            StringBuilder str = new StringBuilder(name);
            foreach (char c in System.IO.Path.GetInvalidFileNameChars())
            {
                str = str.Replace(c, '_');
            }
            return str.ToString();
        }
        private static void DownloadFile(string filename, byte[] bytearray)
        {
            try
            {
                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.Charset = "";
                HttpContext.Current.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment; filename=\"" + Path.GetFileName(filename) + "\"");
                HttpContext.Current.Response.OutputStream.Write(bytearray, 0, bytearray.Length);
                HttpContext.Current.Response.Flush();
                HttpContext.Current.Response.SuppressContent = true;
                HttpContext.Current.ApplicationInstance.CompleteRequest();

            }
            catch(Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
  

        }



        protected void lnlImportFileTemplate_Click(object sender, EventArgs e)
        {
            string sourcePath = "";
            try
            {
                string templatefile = string.Empty;
                string Filename = "SignatureComparisonMasterTemplate.xlsx";

                string Source = string.Empty;
                Source = GetReportPath(Filename);
                sourcePath = Source;
                string Template = string.Empty;
                Template = "SignatureComparisonTemplate_" + DateTime.Now + ".xlsx";
                string destination = string.Empty;
                destination = Path.Combine(appPath, "Temp", SafeFileName(Template));
                if (!File.Exists(Source))
                {
                    Logger.WriteDebugLog("While Exporting Signature Comparison Template- \n " + Source);
                }

                FileInfo newFile = new FileInfo(Source);
                ExcelPackage Excel = new ExcelPackage(newFile, true);
                var exelworksheet = Excel.Workbook.Worksheets[1];
                DownloadFile(destination, Excel.GetAsByteArray());

            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message + " ----- Path : "+ sourcePath);
            }
        }

        protected void btnOverwrite_Click(object sender, EventArgs e)
        {
            try
            {
                if (Session["SignatureExistingData"] != null)
                {
                    List<SignatureComparisionData> list = null;
                    for (int i = 0; i < lvExistingSignature.Items.Count; i++)
                    {
                        if ((lvExistingSignature.Items[i].FindControl("chkSelect") as CheckBox).Checked)
                        {
                            list = Session["SignatureExistingData"] as List<SignatureComparisionData>;
                            string company = (lvExistingSignature.Items[i].FindControl("hdnComany") as HiddenField).Value;
                            string plant = (lvExistingSignature.Items[i].FindControl("hdnPlant") as HiddenField).Value;
                            string machine = (lvExistingSignature.Items[i].FindControl("hdnMachine") as HiddenField).Value;
                            string paremeter = (lvExistingSignature.Items[i].FindControl("lblParameter") as Label).Text;
                            string signatureid = (lvExistingSignature.Items[i].FindControl("lblSignatureID") as Label).Text;
                            MongoDBAccess.deleteSignatureMasterData(company, plant, machine, paremeter, signatureid);
                            var destiList = list.Where(k =>k.Company==company && k.Plant==plant &&  k.MachineID == machine && k.SignatureID == signatureid && k.ParameterID == paremeter).Select(k => k.SignatureData).ToList();
                            List<SignatureComparisionDetails> finalList = new List<SignatureComparisionDetails>();
                            foreach (var data in destiList)
                            {
                                for (int j = 0; j < data.Count; j++)
                                {
                                    SignatureComparisionDetails seqData = new SignatureComparisionDetails();
                                    seqData.CompanyID = company;
                                    seqData.PlantID = plant;
                                    seqData.MachineID = machine;
                                    seqData.ParameterID = paremeter;
                                    seqData.SignatureID = signatureid;
                                    seqData.Frequency = data[j].Frequency;
                                    seqData.ParameterValue = data[j].ParameterValue;
                                    finalList.Add(seqData);
                                }
                            }
                            list.RemoveAll(k => k.Company == company && k.Plant == plant &&  k.MachineID == machine && k.SignatureID == signatureid && k.ParameterID == paremeter);
                            Session["SignatureExistingData"] = list;
                            MongoDBAccess.insertSignatureComparisonMasterData(finalList);
                        }
                    }
                    if (list.Count > 0)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "openModal", "openExistingSignatureDataModal();", true);
                        btnChangeSave.Visible = false;
                        btnChange.Visible = true;
                        btnChangeCancel.Visible = false;
                        lvExistingSignature.DataSource = list;
                        lvExistingSignature.DataBind();
                    }
                }
                BindSignatureDetails();
            }
            catch (Exception ex)
            { }
        }

        protected void btnChange_Click(object sender, EventArgs e)
        {
            try
            {
                if (Session["SignatureExistingData"] != null)
                {
                    btnOverwrite.Enabled = false;
                    btnChangeSave.Visible = true;
                    btnChange.Visible = false;
                    btnChangeCancel.Visible = true;
                    List<SignatureComparisionData> list = Session["SignatureExistingData"] as List<SignatureComparisionData>;
                    lvExistingSignature.DataSource = list;
                    lvExistingSignature.DataBind();
                    ScriptManager.RegisterStartupScript(this, GetType(), "openModal", "openExistingSignatureDataModal();", true);
                }
            }
            catch (Exception ex)
            {

            }
        }

        protected void btnChangeSave_Click(object sender, EventArgs e)
        {
            try
            {
                if (Session["SignatureExistingData"] != null)
                {
                    List<SignatureComparisionData> list = null;
                    for (int i = 0; i < lvExistingSignature.Items.Count; i++)
                    {
                        if ((lvExistingSignature.Items[i].FindControl("chkSelect") as CheckBox).Checked)
                        {
                            list = Session["SignatureExistingData"] as List<SignatureComparisionData>;
                            string company = (lvExistingSignature.Items[i].FindControl("hdnComany") as HiddenField).Value;
                            string plant = (lvExistingSignature.Items[i].FindControl("hdnPlant") as HiddenField).Value;
                            string machine = (lvExistingSignature.Items[i].FindControl("hdnMachine") as HiddenField).Value;
                            string paremeter = (lvExistingSignature.Items[i].FindControl("lblParameter") as Label).Text;
                            string signatureidOld = (lvExistingSignature.Items[i].FindControl("hdnSignatureID") as HiddenField).Value;
                            string signatureid = (lvExistingSignature.Items[i].FindControl("txtSignature") as TextBox).Text.Trim();
                            var destiList = list.Where(k => k.Company == company && k.Plant == plant && k.MachineID == machine && k.SignatureID == signatureidOld && k.ParameterID == paremeter).Select(k => k.SignatureData).ToList();
                            List<SignatureComparisionDetails> finalList = new List<SignatureComparisionDetails>();
                            foreach (var data in destiList)
                            {
                                for (int j = 0; j < data.Count; j++)
                                {
                                    SignatureComparisionDetails seqData = new SignatureComparisionDetails();
                                    seqData.CompanyID = company;
                                    seqData.PlantID = plant;
                                    seqData.MachineID = machine;
                                    seqData.ParameterID = paremeter;
                                    seqData.SignatureID = signatureid;
                                    seqData.Frequency = data[j].Frequency;
                                    seqData.ParameterValue = data[j].ParameterValue;
                                    finalList.Add(seqData);
                                }
                            }
                            list.RemoveAll(k => k.Company == company && k.Plant == plant && k.MachineID == machine && k.SignatureID == signatureidOld && k.ParameterID == paremeter);
                            Session["SignatureExistingData"] = list;;
                            MongoDBAccess.insertSignatureComparisonMasterData(finalList);
                        }
                    }
                    if (list.Count > 0)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "openModal", "openExistingSignatureDataModal();", true);
                        btnOverwrite.Enabled = false;
                        btnChangeSave.Visible = false;
                        btnChange.Visible = true;
                        btnChangeCancel.Visible = false;
                        lvExistingSignature.DataSource = list;
                        lvExistingSignature.DataBind();
                    }
                }
                BindSignatureDetails();
            }
            catch (Exception ex)
            {

            }
        }

        protected void btnChangeCancel_Click(object sender, EventArgs e)
        {
            try
            {
                if (Session["SignatureExistingData"] != null)
                {
                    btnOverwrite.Enabled = true;
                    btnChangeSave.Visible = false;
                    btnChange.Visible = true;
                    btnChangeCancel.Visible = false;
                    List<SignatureComparisionData> list = Session["SignatureExistingData"] as List<SignatureComparisionData>;
                    lvExistingSignature.DataSource = list;
                    lvExistingSignature.DataBind();
                    ScriptManager.RegisterStartupScript(this, GetType(), "openModal", "openExistingSignatureDataModal();", true);
                }
            }
            catch (Exception ex)
            {

            }
        }

        protected void lvExistingSignature_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            try
            {
                if (e.Item.ItemType == ListViewItemType.DataItem)
                {
                    if (btnChange.Visible)
                    {
                        (e.Item.FindControl("lblSignatureID") as Label).Visible = true;
                        (e.Item.FindControl("txtSignature") as TextBox).Visible = false;
                    }
                    else
                    {
                        (e.Item.FindControl("lblSignatureID") as Label).Visible = false;
                        (e.Item.FindControl("txtSignature") as TextBox).Visible = true;
                    }
                }
            }
            catch (Exception ex) { }
        }

        

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static bool isSignatureIDExistForValidation(string company,string plant, string machine, string parameter, string signature)
        {
            bool isExist = false;
            try
            {
                SignatureComparisonMaster page = new SignatureComparisonMaster();
                isExist = page.isSignatureDetailsExist(company,plant, machine, parameter, signature);

            }
            catch (Exception ex)
            {

            }
            return isExist;
        }

    }
}