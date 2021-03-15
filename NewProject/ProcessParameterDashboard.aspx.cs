using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MongoDB.Bson;
using MongoDB.Bson.Serialization;
using MongoDB.Bson.Serialization.Serializers;
using MongoDB.Driver;
using NewProject.DataBaseAccess;
using NewProject.Model;

namespace NewProject
{
    public partial class ProcessParameterDashboard : System.Web.UI.Page
    {
        public static int PreviousIndex;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //  ScriptManager.RegisterStartupScript(Page, typeof(Page), "NoFileopenModal", "showLoader();", true);
                Session["ProcessParameterDashboardData"] = null;
                //Session["PPMachines"] = null;
                //Session["PPParameters"] = null;
                txtFromDateTime.Text = DateTime.Now.ToString("dd-MM-yyyy HH:mm:ss");
                hdnNoOfColumns.Value = "6";
                txtNoOfColumns.Text = "6";
                bindCompany();
                //bindMachineID();
                //bindParameters();
                BindData();
                lbBackToLive.Visible = false;
                //alarmInterval_Tick(null, null);
                divTimeBarContainer.Visible = false;
            }
        }
        private void bindCompany()
        {
            try
            {
                List<string> company = new List<string>();
                company = DBAccess.getCompanyData();
                ddlCompany.DataSource = company;
                ddlCompany.DataBind();

                if (Session["PPCompany"] == null)
                {

                }
                else
                {
                    try
                    {
                        ddlCompany.SelectedValue = (string)Session["PPCompany"];
                    }
                    catch (Exception ex)
                    {

                    }
                   
                }

                bindPlant();
            }
            catch (Exception ex)
            {

            }
        }
        private void bindPlant()
        {
            try
            {
                List<string> plant = new List<string>();
                plant = DBAccess.getPlantData(ddlCompany.SelectedValue == null ? "" : ddlCompany.SelectedValue.ToString());
                ddlPlant.DataSource = plant;
                ddlPlant.DataBind();
                if (Session["PPPlant"] == null)
                {

                }
                else
                {
                   
                    try
                    {
                        ddlPlant.SelectedValue = (string)Session["PPPlant"];
                    }
                    catch(Exception ex)
                    {

                    }
                    
                }
                // bindMachineID();
                bindMultipleMachineIDs();
            }
            catch (Exception ex)
            {

            }
        }
        private void bindMultipleMachineIDs()
        {
            try
            {
                //List<ListItem> listItemList = new List<ListItem>();
                //listItemList = DBAccess.getMachineIDs(ddlCompany.SelectedValue == null ? "" : ddlCompany.SelectedValue.ToString(), ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString());
                //multiselectddlMachineID.DataSource = listItemList;
                //multiselectddlMachineID.DataTextField = "Text";
                //multiselectddlMachineID.DataValueField = "Value";
                //multiselectddlMachineID.DataBind();

                List<string> listItemList = new List<string>();
                listItemList = MongoDBAccess.getMachineID(ddlCompany.SelectedValue == null ? "" : ddlCompany.SelectedValue.ToString(), ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString());
                multiselectddlMachineID.DataSource = listItemList;
                multiselectddlMachineID.DataBind();

                if (Session["PPMachines"] == null)
                {
                    if (listItemList.Count > 0)
                    {
                        multiselectddlMachineID.Items[0].Selected = true;
                    }
                }
                else
                {
                    List<string> machines = (List<string>)Session["PPMachines"];
                    // Session["PPMachines"] = null;
                    bool selected = false;
                    foreach (ListItem item in multiselectddlMachineID.Items)
                    {
                        item.Selected = false;
                    }
                    for (int i = 0; i < machines.Count; i++)
                    {
                        foreach (ListItem item in multiselectddlMachineID.Items)
                        {
                            if (item.Text == machines[i])
                            {
                                item.Selected = true;
                                selected = true;
                            }
                        }
                    }
                    if (!selected)
                    {
                        if (machines.Count > 0)
                        {
                            multiselectddlMachineID.Items[0].Selected = true;
                        }
                    }
                }
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
                List<ListItem> listItemList = new List<ListItem>();
                //listItemList = DBAccess.getMachineIDs(ddlCompany.SelectedValue == null ? "" : ddlCompany.SelectedValue.ToString(), ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString());


                //multiselectddlMachineID.DataSource = listItemList;
                //multiselectddlMachineID.DataTextField = "Text";
                //multiselectddlMachineID.DataValueField = "Value";
                //multiselectddlMachineID.DataBind();



                ListItem items = null;
                items = new ListItem();
                items.Text = "Common Parameters";
                items.Value = "CommonParameters";
                listItemList.Add(items);
                foreach (ListItem item in multiselectddlMachineID.Items)
                {
                    if (item.Selected)
                    {
                        items = new ListItem();
                        items.Text = item.Text;
                        items.Value = item.Text;
                        listItemList.Add(items);
                    }
                }

                ddlMachines.DataSource = listItemList;
                ddlMachines.DataTextField = "Text";
                ddlMachines.DataValueField = "Value";
                ddlMachines.DataBind();
                PreviousIndex = ddlMachines.SelectedIndex;



                //if (Session["PPMachines"] == null)
                //{
                //    if (listItemList.Count > 0)
                //    {
                //        multiselectddlMachineID.Items[0].Selected = true;
                //    }
                //}
                //else
                //{
                //    List<string> machines = (List<string>)Session["PPMachines"];
                //    // Session["PPMachines"] = null;
                //    foreach (ListItem item in multiselectddlMachineID.Items)
                //    {
                //        item.Selected = false;
                //    }
                //    for (int i = 0; i < machines.Count; i++)
                //    {
                //        foreach (ListItem item in multiselectddlMachineID.Items)
                //        {
                //            if (item.Text == machines[i])
                //            {
                //                item.Selected = true;
                //            }
                //        }
                //    }
                //}
                bindParameters();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        private void bindParameters()
        {
            try
            {

                BsonArray machineNames = new BsonArray();
                //foreach (ListItem item in multiselectddlMachineID.Items)
                //{
                //    if (item.Selected)
                //    {
                //        if (machineNames == "")
                //        {
                //            machineNames.Add(item.Value);
                //        }
                //        else
                //        {
                //            machineNames.Add(item.Value);
                //        }
                //    }
                //}
                //  machineNames.Add(ddlMachineID.Text);

                //machineNames.Add(ddlMachines.SelectedValue == null ? "" : ddlMachines.SelectedValue.ToString());

                //List<string> selectedParameterList = new List<string>();
                //foreach (ListItem item in cbParameterList.Items)
                //{
                //    if (item.Selected)
                //    {
                //        selectedParameterList.Add(item.Text);
                //    }
                //}

                //List<string> selectedParameterList = new List<string>();
                //if (Session["PPParameters"] == null)
                //{
                //}
                //else
                //{
                //    selectedParameterList = (List<string>)Session["PPParameters"];
                //}
                //foreach (ListItem item in cbParameterList.Items)
                //{
                //    if (item.Selected)
                //    {
                //        if (selectedParameterList.Contains(item.Text))
                //        {

                //        }
                //        else
                //        {
                //            selectedParameterList.Add(item.Text);
                //        }
                //    }
                //}
                //Session["PPParameters"] = selectedParameterList;

                Dictionary<string, ParameterListForMachine> machineParmeterPair = new Dictionary<string, ParameterListForMachine>();
                if (Session["MachineParameterList"] == null)
                {

                }
                else
                {
                    machineParmeterPair = (Dictionary<string, ParameterListForMachine>)Session["MachineParameterList"];
                }
                var selectedParameterList = machineParmeterPair.Where(x => x.Key == ddlMachines.SelectedValue.ToString()).Select(x => x.Value).ToList();



                List<ListItem> parameterList = new List<ListItem>();
                //if (cbCommonParametersOnly.Checked)
                //{
                //    parameterList = MongoDBAccess.getCoomomParameterListForMachines(machineNames);
                //}
                //else
                //{
                //    parameterList = MongoDBAccess.getParameterListForMachines(machineNames);
                //}

                if (ddlMachines.SelectedValue == "CommonParameters")
                {

                    for (int i = 1; i < ddlMachines.Items.Count; i++)
                    {
                        machineNames.Add(ddlMachines.Items[i].Value == null ? "" : ddlMachines.Items[i].Value.ToString());
                    }
                    parameterList = MongoDBAccess.getCoomomParameterListForMachines(machineNames, ddlCompany.SelectedValue==null?"": ddlCompany.SelectedValue.ToString(), ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString());
                }
                else
                {
                    machineNames.Add(ddlMachines.SelectedValue == null ? "" : ddlMachines.SelectedValue.ToString());
                    parameterList = MongoDBAccess.getParameterListForMachines(machineNames, ddlCompany.SelectedValue == null ? "" : ddlCompany.SelectedValue.ToString(), ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString());
                }


                cbParameterList.DataSource = parameterList;
                cbParameterList.DataBind();
                //if (parameterList.Count > 0)
                //{
                //    cbParameterList.Items[0].Selected = true;
                //}
                //bool selected = false;
                //for (int i = 0; i < selectedParameterList.Count; i++)
                //{
                //    foreach (ListItem item in cbParameterList.Items)
                //    {
                //        if (item.Text == selectedParameterList[i])
                //        {
                //            item.Selected = true;
                //            selected = true;
                //        }
                //    }
                //}
                //if (!selected)
                //{
                //    if (parameterList.Count > 0)
                //    {
                //        cbParameterList.Items[0].Selected = true;
                //    }
                //}

                bool selected = false;
                for (int i = 0; i < selectedParameterList.Count; i++)
                {
                    for (int j = 0; j < selectedParameterList[i].Parameters.Count; j++)
                    {
                        foreach (ListItem item in cbParameterList.Items)
                        {
                            if (item.Text == selectedParameterList[i].Parameters[j].ToString())
                            {
                                item.Selected = true;
                                selected = true;
                            }
                        }
                    }
                }
                if (!selected)
                {
                    if (parameterList.Count > 0)
                    {
                        cbParameterList.Items[0].Selected = true;
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        private List<ProcessParameterTransactionMasterData> getProcessParameterMasterData(string machineId,string company,string plant)
        {
            List<ProcessParameterTransactionMasterData> processParameterTransactionMasterDatas = new List<ProcessParameterTransactionMasterData>();
            try
            {
                // var filter = "{MachineID: '" + machineId + "'}";
                //var filter = "{}";
                //var filter = "{MachineID: {$in : " + machineId + "}}";

                //processParameterTransactionMasterDatas = _MongoDatabase.GetCollection<ProcessParameterTransactionMasterData>("ProcessParameterMaster").Find(filter).ToList();
                processParameterTransactionMasterDatas = MongoDBAccess.getProcessParameterMasterDetailsWithFilter(company, plant, machineId);
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
            return processParameterTransactionMasterDatas;
        }



        private void BindForTroubleShoot(DateTime fromDate, DateTime toDate)
        {
            try
            {
                Logger.WriteDebugLog("Eneter BindForTroubleShoot " + fromDate + "  ;  " + toDate);
                string machineName = "", machineForList = "", machineNameForT="";
                BsonArray machin = new BsonArray();
                //foreach (ListItem item in multiselectddlMachineID.Items)
                //{
                //    if (item.Selected)
                //    {
                //        machin.Add(item.Text);
                //        machineName = "'" + item.Text + "'";
                //        machineForList = item.Text;
                //    }
                //}

                BsonDocument parameters = new BsonDocument();
                parameters.Add(new BsonElement("CompanyID", "$CompanyID"));
                parameters.Add(new BsonElement("PlantID", "$PlantID"));
                parameters.Add(new BsonElement("MachineID", "$MachineID"));
                parameters.Add(new BsonElement("UpdatedTS", "$UpdatedTS"));
                //foreach (ListItem item in cbParameterList.Items)
                //{
                //    if (item.Selected)
                //    {
                //        parameters.Add(new BsonElement(item.Text, "$" + item.Text));
                //    }
                //}


                //setParametersInDictionary(ddlMachines.SelectedValue == null ? "" : ddlMachines.SelectedValue.ToString());
                Dictionary<string, ParameterListForMachine> machineParmeterPair = new Dictionary<string, ParameterListForMachine>();
                if (Session["MachineParameterList"] == null)
                {

                }
                else
                {
                    machineParmeterPair = (Dictionary<string, ParameterListForMachine>)Session["MachineParameterList"];
                }
                var machinesList = machineParmeterPair.Select(x => x.Key).ToList();
                for (int i = 0; i < machinesList.Count; i++)
                {
                    if (machinesList[i] == hfSelectedMachineForTroubleShoot.Value)
                    {
                        machin.Add(machinesList[i]);
                        machineName = "'" + machinesList[i] + "'";
                        machineForList = machinesList[i];
                        machineNameForT = machinesList[i];
                    }
                }

                var paramList = machineParmeterPair.Where(x => x.Key == hfSelectedMachineForTroubleShoot.Value).Select(x => x.Value).Distinct().ToList();
                for (int i = 0; i < paramList.Count; i++)
                {
                    for (int j = 0; j < paramList[i].Parameters.Count; j++)
                    {
                        parameters.Add(new BsonElement(paramList[i].Parameters[j].ToString(), "$" + paramList[i].Parameters[j].ToString()));

                    }
                }



                List<BsonDocument> dataset = MongoDBAccess.getPPTroubleShootDetails(fromDate, toDate, machin, parameters, hfSelectedCompanyForTroubleShoot.Value, hfSelectedPlantForTroubleShoot.Value);

                List<ProcessParameterMongoData> resultSet = new List<ProcessParameterMongoData>();
                ProcessParameterMongoData data1 = null;
                foreach (BsonDocument rowSet in dataset)
                {
                    DateTime? updatedTS = DateTime.Now;
                    string MachineId = "",PlantID="",CompanyID="";
                    //data1 = new ProcessParameterMongoData();
                    foreach (BsonElement element in rowSet)
                    {

                        if (element.Name == "_id")
                        {
                            data1._id = element.Value.AsObjectId;
                        }
                        else if (element.Name == "UpdatedTS")
                        {
                            if (element.Value == BsonNull.Value)
                            {
                                // data1.CycleStart = "";
                            }
                            else
                            {
                                //  data1.UpdatedTS = element.Value.AsDateTime;

                                updatedTS = element.Value.AsLocalTime;
                            }

                        }
                        else if (element.Name == "MachineID")
                        {
                            //data1.MachineID = element.Value.ToString();
                            MachineId = element.Value.ToString();
                        }
                        else if (element.Name == "CompanyID")
                        {
                            //data1.MachineID = element.Value.ToString();
                            CompanyID = element.Value.ToString();
                        }
                        else if (element.Name == "PlantID")
                        {
                            //data1.MachineID = element.Value.ToString();
                            PlantID = element.Value.ToString();
                        }
                        else
                        {
                            if (element.Name == "SyncedStatus")
                            {
                                continue;
                            }
                            else
                            {

                                System.Type type = element.Value.GetType();
                                if (type.Name == "BsonDouble" || type.Name == "BsonInt32" || type.Name == "BsonInt64" || type.Name == "BsonInt")
                                {

                                    //if (element.Name == null && data1.ParameterValue == null)
                                    //{

                                    //}
                                    //else
                                    //{
                                    data1 = new ProcessParameterMongoData();
                                    data1.ParamterID = element.Name;
                                    if (type.Name == "BsonDouble")
                                    {
                                        data1.ParameterValue = Math.Round(element.Value.AsDouble, 3).ToString();
                                    }
                                    else
                                    {
                                        data1.ParameterValue = element.Value.ToString();
                                    }
                                    //data1.ParameterValue = element.Value.ToString();
                                    data1.MachineID = MachineId;
                                    data1.CompanyID = CompanyID;
                                    data1.PlantID = PlantID;
                                    data1.UpdatedTS = updatedTS;
                                    resultSet.Add(data1);
                                    //}
                                }
                                else
                                {

                                }

                            }

                        }
                    }


                }

                List<ProcessParameterTransactionMasterData> processParameterMasterDatas = new List<ProcessParameterTransactionMasterData>();
                processParameterMasterDatas = getProcessParameterMasterData("[" + machineName + "]", hfSelectedCompanyForTroubleShoot.Value, hfSelectedPlantForTroubleShoot.Value);
                List<ProcessParameterDashboardMachineData> machinesData = new List<ProcessParameterDashboardMachineData>();
                ProcessParameterDashboardMachineData machineData = null;
                //for (int mi = 0; mi < distinctMachineID.Count; mi++)
                //{
                Logger.WriteDebugLog("Result Count -" + resultSet.Count);
                if (resultSet.Count > 0)
                {
                    machineData = new ProcessParameterDashboardMachineData();
                    machineData.MachineID = machineForList;

                    List<ProcessParameterData> list = new List<ProcessParameterData>();
                    for (int i = 0; i < resultSet.Count; i++)
                    {
                        if (resultSet[i].ParamterID == "P3" || resultSet[i].ParamterID == "P4" || resultSet[i].ParamterID == "P5" || resultSet[i].ParamterID == "P6" || resultSet[i].ParamterID == "P7" || resultSet[i].ParamterID == "P8" || resultSet[i].ParamterID == "P9" || resultSet[i].ParamterID == "P10")
                        {
                            continue;
                        }
                        ProcessParameterData data = new ProcessParameterData();
                        machineData.CompanyID= resultSet[i].CompanyID;
                        machineData.PlantID = resultSet[i].PlantID;
                        data.HeaderName = resultSet[i].ParamterID;
                        data.Value = resultSet[i].ParameterValue;
                        data.UpdatedTS = Convert.ToDateTime(resultSet[i].UpdatedTS).ToString("dd-MM-yyyy HH:mm:ss.fff");
                        //j => j.MachineID == machineID &&
                        data.ChartType = processParameterMasterDatas.Where(j => j.ParameterID == resultSet[i].ParamterID && j.MachineID == machineNameForT).Select(x => x.Unit).ToList().FirstOrDefault();
                        data.HighValue = processParameterMasterDatas.Where(j => j.ParameterID == resultSet[i].ParamterID && j.MachineID == machineNameForT).Select(x => x.UpperErrorLimit).ToList().FirstOrDefault();
                        data.LowValue = processParameterMasterDatas.Where(j => j.ParameterID == resultSet[i].ParamterID && j.MachineID == machineNameForT).Select(x => x.LowerErrorLimit).ToList().FirstOrDefault();
                        //data.HighValue = resultSet[i].ParameterValue ==null?"":(Convert.ToDecimal(resultSet[i].ParameterValue) + 50).ToString();
                        //data.LowValue = "0";
                        string upperwarning = processParameterMasterDatas.Where(j => j.ParameterID == resultSet[i].ParamterID && j.MachineID == machineNameForT).Select(x => x.UpperWarningLimit).ToList().FirstOrDefault();
                        string lowerwarning = processParameterMasterDatas.Where(j => j.ParameterID == resultSet[i].ParamterID && j.MachineID == machineNameForT).Select(x => x.LowerWarningLimit).ToList().FirstOrDefault();
                        data.HighValue = data.HighValue == null || data.HighValue == "NULL" ? "0" : data.HighValue;
                        data.LowValue = data.LowValue == null || data.LowValue == "NULL" ? "0" : data.LowValue;
                        upperwarning = upperwarning == null || upperwarning == "NULL" ? "0" : upperwarning;
                        lowerwarning = lowerwarning == null || lowerwarning == "NULL" ? "0" : lowerwarning;
                        if (data.HighValue != "")
                        {
                            if (Convert.ToDecimal(resultSet[i].ParameterValue) <= Convert.ToDecimal(upperwarning) && Convert.ToDecimal(resultSet[i].ParameterValue) >= Convert.ToDecimal(lowerwarning))
                            {
                                data.BackColor = "#2db32d";
                                data.BackColorForReference = "green";
                                data.TrubleshootIconVisibility = false;
                            }
                            else if ((Convert.ToDecimal(resultSet[i].ParameterValue) <= Convert.ToDecimal(data.HighValue) && Convert.ToDecimal(resultSet[i].ParameterValue) > Convert.ToDecimal(upperwarning)) || (Convert.ToDecimal(resultSet[i].ParameterValue) <= Convert.ToDecimal(data.LowValue) && Convert.ToDecimal(resultSet[i].ParameterValue) > Convert.ToDecimal(lowerwarning)))
                            {
                                data.BackColor = "yellow";
                                data.BackColorForReference = "yellow";
                                data.TrubleshootIconVisibility = true;

                            }
                            else
                            {
                                data.BackColor = "red";
                                data.BackColorForReference = "red";
                                data.TrubleshootIconVisibility = true;
                            }
                        }
                        else
                        {
                            data.BackColor = "#2db32d";
                            data.BackColorForReference = "green";
                            data.TrubleshootIconVisibility = false;
                        }

                        data.NextLineVisibility = "none";
                        if (data.HeaderName == "P3" || data.HeaderName == "P4" || data.HeaderName == "P5" || data.HeaderName == "P6" || data.HeaderName == "P7" || data.HeaderName == "P8" || data.HeaderName == "P9" || data.HeaderName == "P10")
                        {
                            data.TemplateType = "";
                        }
                        else
                        {
                            data.TemplateType = "multipletxt";
                        }

                        list.Add(data);
                    }

                    machineData.parameterDetails = list;
                    machinesData.Add(machineData);
                }
                //  }
                Session["ProcessParameterDashboardData"] = machinesData;
                bindColorCodeAndUnitGrouping();
                Label lbl = (Label)Page.Master.FindControl("lblShowSelectedItems");
                lbl.Text = "Last Refreshed DateTime: " + DateTime.Now.ToString("dd-MM-yyyy HH:mm:ss");
                //divTimeBarContainer.Visible = false;
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("BindForTroubleShoot Error - " + ex.Message);
            }
        }

        private void BindData()
        {
            try
            {
                List<string> machines = new List<string>();
                List<string> parameterList = new List<string>();

                string companyName = ddlCompany.SelectedValue == null ? "" : ddlCompany.SelectedValue.ToString();
                string plantName = ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString();

                //string machineNames = "";
                //foreach (ListItem item in multiselectddlMachineID.Items)
                //{
                //    if (item.Selected)
                //    {
                //        if (machineNames == "")
                //        {
                //            machineNames = "['" + item.Text + "'";
                //        }
                //        else
                //        {
                //            machineNames += ",'" + item.Text + "'";
                //        }
                //        machines.Add(item.Text);
                //    }
                //}
                //if (machineNames != "")
                //{
                //    machineNames += "]";
                //}
                //else
                //{
                //    machineNames = "['']";
                //}

                //string parameterName = "";
                //foreach (ListItem item in cbParameterList.Items)
                //{
                //    if (item.Selected)
                //    {
                //        if (parameterName == "")
                //        {
                //            parameterName = "['" + item.Text + "'";
                //        }
                //        else
                //        {
                //            parameterName += ",'" + item.Text + "'";
                //        }
                //      //  parameterList.Add(item.Text);
                //    }
                //}
                //if (parameterName != "")
                //{
                //    parameterName += "]";
                //}
                //else
                //{
                //    parameterName = "['']";
                //}

                //var filter = "{MachineID : {$in : " + machineNames + "}, ParamterID: {$in :" + parameterName + "}}";
                //var result = _MongoDatabase.GetCollection<ProcessParameterMongoData>("PPT_AMGIOT_FlatData").Find(filter).ToList();

                setParametersInDictionary(ddlMachines.SelectedValue == null ? "" : ddlMachines.SelectedValue.ToString());
                Dictionary<string, ParameterListForMachine> machineParmeterPair = new Dictionary<string, ParameterListForMachine>();
                if (Session["MachineParameterList"] == null)
                {

                }
                else
                {
                    machineParmeterPair = (Dictionary<string, ParameterListForMachine>)Session["MachineParameterList"];
                }
                //Session["PPMachines"] = machineParmeterPair.Select(x => x.Key).ToList();

                var paramList = machineParmeterPair.Select(x => x.Value).Distinct().ToList();
                for (int i = 0; i < paramList.Count; i++)
                {
                    for (int j = 0; j < paramList[i].Parameters.Count; j++)
                    {
                        if (parameterList.Contains(paramList[i].Parameters[j].ToString()))
                        {

                        }
                        else
                        {
                            parameterList.Add(paramList[i].Parameters[j].ToString());
                        }
                    }
                }
                var machinesList = machineParmeterPair.Select(x => x.Key).ToList();
                string machineNames = "";
                for (int i = 0; i < machinesList.Count; i++)
                {
                    if (machineNames == "")
                    {
                        machineNames = "['" + machinesList[i] + "'";
                    }
                    else
                    {
                        machineNames += ",'" + machinesList[i] + "'";
                    }
                }
                if (machineNames != "")
                {
                    machineNames += "]";
                }
                else
                {
                    machineNames = "['']";
                }


                Session["PPMachines"] = machineParmeterPair.Where(x => x.Key != "CommonParameters").Select(x => x.Key).ToList();
                Session["PPCompany"] = companyName;
                Session["PPPlant"] = plantName;
                //  Session["PPMachines"] = machines;
                Session["PPParameters"] = parameterList;




                List<BsonDocument> dataset = MongoDBAccess.getPPLiveDataDetails(machineParmeterPair,companyName,plantName);



                List<ProcessParameterMongoData> result = new List<ProcessParameterMongoData>();
                ProcessParameterMongoData data1 = null;
                foreach (BsonDocument rowSet in dataset)
                {
                    DateTime? updatedTS = DateTime.Now;
                    string MachineId = "", CompanyID="",PlantID="";
                    //data1 = new ProcessParameterMongoData();
                    foreach (BsonElement element in rowSet)
                    {

                        if (element.Name == "_id")
                        {
                            data1._id = element.Value.AsObjectId;
                        }
                        else if (element.Name == "UpdatedTS")
                        {
                            if (element.Value == BsonNull.Value)
                            {
                            }
                            else
                            {
                                updatedTS = element.Value.AsLocalTime;
                            }

                        }
                        else if (element.Name == "MachineID")
                        {
                            //data1.MachineID = element.Value.ToString();
                            MachineId = element.Value.ToString();
                        }
                        else if (element.Name == "CompanyID")
                        {
                            //data1.MachineID = element.Value.ToString();
                            CompanyID = element.Value.ToString();
                        }
                        else if (element.Name == "PlantID")
                        {
                            //data1.MachineID = element.Value.ToString();
                            PlantID = element.Value.ToString();
                        }
                        else
                        {
                            if (element.Name == "SyncedStatus")
                            {
                                continue;
                            }
                            else
                            {

                                System.Type type = element.Value.GetType();
                                if (type.Name == "BsonDouble" || type.Name == "BsonInt32" || type.Name == "BsonInt64" || type.Name == "BsonInt")
                                {

                                    //if (element.Name == null && data1.ParameterValue == null)
                                    //{

                                    //}
                                    //else
                                    //{
                                    data1 = new ProcessParameterMongoData();
                                    data1.ParamterID = element.Name;
                                    if (type.Name == "BsonDouble")
                                    {
                                        data1.ParameterValue = Math.Round(element.Value.AsDouble, 3).ToString();
                                    }
                                    else
                                    {
                                        data1.ParameterValue = element.Value.ToString();
                                    }
                                    //data1.ParameterValue = element.Value.ToString();
                                    data1.CompanyID = CompanyID;
                                    data1.PlantID = PlantID;
                                    data1.MachineID = MachineId;
                                    data1.UpdatedTS = updatedTS;
                                    result.Add(data1);
                                    //}
                                }
                                else
                                {

                                }

                            }

                        }
                    }


                }


                List<string> distinctMachineID = result.Select(x => x.MachineID).Distinct().ToList();
                //List<ProcessParameterData> masterData = new List<ProcessParameterData>();
                //masterData = DBAccess.getProcessParameterMasterData(machineID);
                List<ProcessParameterTransactionMasterData> processParameterMasterDatas = new List<ProcessParameterTransactionMasterData>();
                processParameterMasterDatas = getProcessParameterMasterData(machineNames,companyName,plantName);
                List<ProcessParameterDashboardMachineData> machinesData = new List<ProcessParameterDashboardMachineData>();
                ProcessParameterDashboardMachineData machineData = null;
                for (int mi = 0; mi < distinctMachineID.Count; mi++)
                {
                    machineData = new ProcessParameterDashboardMachineData();
                    machineData.MachineID = distinctMachineID[mi];
                    //machineData.CompanyID = result.Select(x => x.MachineID).Distinct().ToList().FirstOrDefault();
                    //machineData.PlantID = ;
                    var resultSet = result.Where(x => x.MachineID == distinctMachineID[mi]).ToList();
                    List<ProcessParameterData> list = new List<ProcessParameterData>();

                    for (int i = 0; i < resultSet.Count; i++)
                    {
                        if (resultSet[i].ParamterID == "P3" || resultSet[i].ParamterID == "P4" || resultSet[i].ParamterID == "P5" || resultSet[i].ParamterID == "P6" || resultSet[i].ParamterID == "P7" || resultSet[i].ParamterID == "P8" || resultSet[i].ParamterID == "P9" || resultSet[i].ParamterID == "P10")
                        {
                            continue;
                        }
                        ProcessParameterData data = new ProcessParameterData();


                        machineData.CompanyID = resultSet[i].CompanyID;
                        machineData.PlantID = resultSet[i].PlantID;

                        data.HeaderName = resultSet[i].ParamterID;
                        data.Value = resultSet[i].ParameterValue;

                        data.UpdatedTS = Convert.ToDateTime(resultSet[i].UpdatedTS).ToString("dd-MM-yyyy HH:mm:ss.fff"); ;
                        //j => j.MachineID == machineID &&
                        data.ChartType = processParameterMasterDatas.Where(j => j.ParameterID == resultSet[i].ParamterID && j.MachineID == distinctMachineID[mi]).Select(x => x.Unit).ToList().FirstOrDefault();
                        data.HighValue = processParameterMasterDatas.Where(j => j.ParameterID == resultSet[i].ParamterID && j.MachineID == distinctMachineID[mi]).Select(x => x.UpperErrorLimit).ToList().FirstOrDefault();
                        data.LowValue = processParameterMasterDatas.Where(j => j.ParameterID == resultSet[i].ParamterID && j.MachineID == distinctMachineID[mi]).Select(x => x.LowerErrorLimit).ToList().FirstOrDefault();
                        //data.HighValue = resultSet[i].ParameterValue ==null?"":(Convert.ToDecimal(resultSet[i].ParameterValue) + 50).ToString();
                        //data.LowValue = "0";
                        string upperwarning = processParameterMasterDatas.Where(j => j.ParameterID == resultSet[i].ParamterID && j.MachineID == distinctMachineID[mi]).Select(x => x.UpperWarningLimit).ToList().FirstOrDefault();
                        string lowerwarning = processParameterMasterDatas.Where(j => j.ParameterID == resultSet[i].ParamterID && j.MachineID == distinctMachineID[mi]).Select(x => x.LowerWarningLimit).ToList().FirstOrDefault();
                        data.HighValue = data.HighValue == null || data.HighValue == "NULL" ? "0" : data.HighValue;
                        data.LowValue = data.LowValue == null || data.LowValue == "NULL" ? "0" : data.LowValue;
                        upperwarning = upperwarning == null || upperwarning == "NULL" ? "0" : upperwarning;
                        lowerwarning = lowerwarning == null || lowerwarning == "NULL" ? "0" : lowerwarning;
                        if (data.HighValue != "")
                        {
                            if (Convert.ToDecimal(resultSet[i].ParameterValue) <= Convert.ToDecimal(upperwarning) && Convert.ToDecimal(resultSet[i].ParameterValue) >= Convert.ToDecimal(lowerwarning))
                            {
                                data.BackColor = "#2db32d";
                                data.BackColorForReference = "green";
                                data.TrubleshootIconVisibility = false;
                            }
                            else if ((Convert.ToDecimal(resultSet[i].ParameterValue) <= Convert.ToDecimal(data.HighValue) && Convert.ToDecimal(resultSet[i].ParameterValue) > Convert.ToDecimal(upperwarning)) || (Convert.ToDecimal(resultSet[i].ParameterValue) <= Convert.ToDecimal(data.LowValue) && Convert.ToDecimal(resultSet[i].ParameterValue) > Convert.ToDecimal(lowerwarning)))
                            {
                                data.BackColor = "yellow";
                                data.BackColorForReference = "yellow";
                                data.TrubleshootIconVisibility = true;

                            }
                            else
                            {
                                data.BackColor = "red";
                                data.BackColorForReference = "red";
                                data.TrubleshootIconVisibility = true;
                            }
                        }
                        else
                        {
                            data.BackColor = "#2db32d";
                            data.BackColorForReference = "green";
                            data.TrubleshootIconVisibility = false;
                        }

                        data.NextLineVisibility = "none";
                        if (data.HeaderName == "P3" || data.HeaderName == "P4" || data.HeaderName == "P5" || data.HeaderName == "P6" || data.HeaderName == "P7" || data.HeaderName == "P8" || data.HeaderName == "P9" || data.HeaderName == "P10")
                        {
                            data.TemplateType = "";
                        }
                        else
                        {
                            data.TemplateType = "multipletxt";
                        }

                        list.Add(data);
                    }

                    machineData.parameterDetails = list;
                    machinesData.Add(machineData);

                }
                Session["ProcessParameterDashboardData"] = machinesData;
                bindColorCodeAndUnitGrouping();
                Label lbl = (Label)Page.Master.FindControl("lblShowSelectedItems");
                lbl.Text = "Last Refreshed DateTime: " + DateTime.Now.ToString("dd-MM-yyyy HH:mm:ss");
                divTimeBarContainer.Visible = false;
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }

        private void bindColorCodeAndUnitGrouping()
        {
            try
            {
                int noofcolumn = 6;
                if (hdnNoOfColumns.Value == "" || hdnNoOfColumns.Value == null)
                {
                    noofcolumn = 6;
                }
                else
                {
                    noofcolumn = Convert.ToInt32(hdnNoOfColumns.Value);
                }
                List<ProcessParameterDashboardMachineData> list = new List<ProcessParameterDashboardMachineData>();
                if (Session["ProcessParameterDashboardData"] == null)
                {
                    BindData();
                }
                else
                {
                    list = (List<ProcessParameterDashboardMachineData>)Session["ProcessParameterDashboardData"];
                }
                List<ProcessParameterDashboardMachineData> list1 = new List<ProcessParameterDashboardMachineData>();
                ProcessParameterDashboardMachineData machinedata = null; ;

                if (chkEnableGroup.Checked)
                {
                    //var groupList = list.GroupBy(u => u.ChartType).Select(grp => grp.ToList()).ToList();
                    var groupList = list.GroupBy(u => u.parameterDetails.GroupBy(x => x.ChartType).Select(g => g.ToList())).Select(z => z.ToList()).ToList();
                    int chartID = 0;
                    List<string> disctinctMachine = new List<string>();
                    disctinctMachine = list.Select(x => x.MachineID).ToList();
                    List<ProcessParameterDashboardMachineData> groupedList = new List<ProcessParameterDashboardMachineData>();
                    ProcessParameterDashboardMachineData groupedData = null;
                    for (int d = 0; d < disctinctMachine.Count; d++)
                    {
                        machinedata = new ProcessParameterDashboardMachineData();
                        machinedata.MachineID = disctinctMachine[d];
                        machinedata.CompanyID = list[0].CompanyID;
                        machinedata.PlantID = list[0].PlantID;
                        var gruoupedData = list[d].parameterDetails.GroupBy(u => u.ChartType).Select(grp => grp.ToList()).ToList();
                        List<ProcessParameterData> parametersData = new List<ProcessParameterData>();
                        ProcessParameterData data = null;
                        foreach (var group in gruoupedData)
                        {
                            int groupCont = group.Count - 1;
                            int j = 0;
                            foreach (var value in group)
                            {
                                data = new ProcessParameterData();
                                data.HeaderName = value.HeaderName;
                                data.Value = value.Value;
                                data.UpdatedTS = value.UpdatedTS;
                                data.ChartType = value.ChartType;
                                data.HighValue = value.HighValue;
                                data.LowValue = value.LowValue;
                                data.BackColor = value.BackColor;
                                data.TrubleshootIconVisibility = value.TrubleshootIconVisibility;
                                if (groupCont == j)
                                {
                                    data.NextLineVisibility = "block";
                                }
                                else
                                {
                                    if ((j + 1) % noofcolumn == 0)
                                    {
                                        data.NextLineVisibility = "block";
                                    }
                                    else
                                    {
                                        data.NextLineVisibility = "none";
                                    }
                                    //data.NextLineVisibility = "none";
                                }
                                j++;
                                if (value.TemplateType == "multipletxt")
                                {
                                    data.Template1Visibility = "table";
                                    data.Template2Visibility = "none";
                                    data.GraphHighLowVisibility = "visible";
                                }
                                else
                                {
                                    data.Template2Visibility = "table";
                                    data.Template1Visibility = "none";
                                    data.GraphHighLowVisibility = "visible";
                                }
                                data.chartContainerID = "chartContainer" + chartID;
                                parametersData.Add(data);
                                chartID++;
                            }
                        }

                        machinedata.parameterDetails = parametersData;
                        list1.Add(machinedata);
                    }

                }
                else if (cbSortRYG.Checked || cbSortGYR.Checked || cbRed.Checked || cbGreen.Checked || cbYellow.Checked)
                {
                    var groupList = list.GroupBy(u => u.parameterDetails.GroupBy(x => x.BackColorForReference).Select(g => g.ToList())).ToList();
                    int chartID = 0;

                    List<string> colors = new List<string>();
                    if (cbSortRYG.Checked)
                    {
                        colors.Add("red");
                        colors.Add("yellow");
                        colors.Add("green");
                    }
                    else if (cbSortGYR.Checked)
                    {
                        colors.Add("green");
                        colors.Add("yellow");
                        colors.Add("red");
                    }
                    else
                    {
                        if (cbRed.Checked) colors.Add("red");
                        if (cbYellow.Checked) colors.Add("yellow");
                        if (cbGreen.Checked) colors.Add("green");

                    }



                    foreach (var group1 in groupList)
                    {
                        foreach (var machine in group1)
                        {
                            machinedata = new ProcessParameterDashboardMachineData();
                            machinedata.MachineID = machine.MachineID;
                            machinedata.CompanyID = machine.CompanyID;
                            machinedata.PlantID = machine.PlantID;
                            List<ProcessParameterData> parametersData = new List<ProcessParameterData>();
                            ProcessParameterData data = null;
                            foreach (string color in colors)
                            {
                                foreach (var value in machine.parameterDetails)
                                {
                                    if (value.BackColorForReference == color)
                                    {
                                        data = new ProcessParameterData();
                                        data.HeaderName = value.HeaderName;
                                        data.Value = value.Value;
                                        data.UpdatedTS = value.UpdatedTS;
                                        data.ChartType = value.ChartType;
                                        data.HighValue = value.HighValue;
                                        data.LowValue = value.LowValue;
                                        data.BackColor = value.BackColor;
                                        data.TrubleshootIconVisibility = value.TrubleshootIconVisibility;
                                        if ((chartID + 1) % noofcolumn == 0)
                                        {
                                            data.NextLineVisibility = "block";
                                        }
                                        else
                                        {
                                            data.NextLineVisibility = "none";
                                        }
                                        if (value.TemplateType == "multipletxt")
                                        {
                                            data.Template1Visibility = "table";
                                            data.Template2Visibility = "none";
                                            data.GraphHighLowVisibility = "visible";
                                        }
                                        else
                                        {
                                            data.Template2Visibility = "table";
                                            data.Template1Visibility = "none";
                                            data.GraphHighLowVisibility = "hidden";
                                        }
                                        data.chartContainerID = "chartContainer" + chartID;
                                        parametersData.Add(data);
                                        chartID++;
                                    }
                                }
                            }
                            machinedata.parameterDetails = parametersData;
                            list1.Add(machinedata);

                        }
                    }

                }
                else
                {

                    int chartID = 0;
                    for (int i = 0; i < list.Count; i++)
                    {
                        machinedata = new ProcessParameterDashboardMachineData();
                        machinedata.MachineID = list[i].MachineID;
                        machinedata.CompanyID = list[i].CompanyID;
                        machinedata.PlantID = list[i].PlantID;
                        List<ProcessParameterData> parametersData = new List<ProcessParameterData>();
                        ProcessParameterData data = null;
                        for (int j = 0; j < list[i].parameterDetails.Count; j++)
                        {
                            data = new ProcessParameterData();
                            data.HeaderName = list[i].parameterDetails[j].HeaderName;
                            data.Value = list[i].parameterDetails[j].Value;
                            data.UpdatedTS = list[i].parameterDetails[j].UpdatedTS;
                            data.ChartType = list[i].parameterDetails[j].ChartType;
                            data.HighValue = list[i].parameterDetails[j].HighValue;
                            data.LowValue = list[i].parameterDetails[j].LowValue;
                            data.BackColor = list[i].parameterDetails[j].BackColor;
                            data.TrubleshootIconVisibility = list[i].parameterDetails[j].TrubleshootIconVisibility;
                            if ((j + 1) % noofcolumn == 0)
                            {
                                data.NextLineVisibility = "block";
                            }
                            else
                            {
                                data.NextLineVisibility = "none";
                            }
                            if (list[i].parameterDetails[j].TemplateType == "multipletxt")
                            {
                                data.Template1Visibility = "table";
                                data.Template2Visibility = "none";
                                data.GraphHighLowVisibility = "visible";
                            }
                            else
                            {
                                data.Template2Visibility = "table";
                                data.Template1Visibility = "none";
                                data.GraphHighLowVisibility = "hidden";
                            }
                            data.chartContainerID = "chartContainer" + chartID;
                            chartID++;
                            parametersData.Add(data);
                        }
                        machinedata.parameterDetails = parametersData;
                        list1.Add(machinedata);
                    }
                }

                lvProcessParamTextView.DataSource = list1;
                lvProcessParamTextView.DataBind();
                lvChartData.DataSource = list1;
                string ss = list1.ToJson();
                Logger.WriteDebugLog("Data:   " + ss);
                lvChartData.DataBind();
                //ClientScript.RegisterStartupScript(this.GetType(), "bindChart", "BindCharts();", true);
                ScriptManager.RegisterStartupScript(this, GetType(), "bindTimeBar", "BindTimeBar();", true);
                ScriptManager.RegisterStartupScript(this, GetType(), "bindChart", "BindCharts();", true);
                if (hdView.Value == "MeterView")
                {
                    //  ClientScript.RegisterStartupScript(this.GetType(), "meterView", "showViews('', 'MeterView');", true);
                    ScriptManager.RegisterStartupScript(this, GetType(), "meterView", "showViews('', 'MeterView');", true);
                }
                else
                {
                    //ClientScript.RegisterStartupScript(this.GetType(), "listView", "showViews('', 'ListView');", true);
                    ScriptManager.RegisterStartupScript(this, GetType(), "listView", "showViews('', 'ListView');", true);
                }
                // ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "unblockLoader", "$.unblockUI({ });", true);
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        private ProcessParameterData setGetProcessData(string headerName, string Value, string chartname, string highValue, string lowValue, string backcolor, string NextLineVisibility, string TemplateType)
        {
            ProcessParameterData data = new ProcessParameterData();
            data.HeaderName = headerName;
            data.Value = Value;
            data.ChartType = chartname;
            data.HighValue = highValue;
            data.LowValue = lowValue;
            data.BackColor = backcolor;
            data.NextLineVisibility = NextLineVisibility;
            data.TemplateType = TemplateType;
            return data;
        }

        protected void btnNoOfColumnsOk_Click(object sender, EventArgs e)
        {
            // BindData();
            bindColorCodeAndUnitGrouping();
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "unblockLoader", "$.unblockUI({ });", true);
        }

        protected void chkEnableGroup_CheckedChanged(object sender, EventArgs e)
        {
            // BindData();
            bindColorCodeAndUnitGrouping();
        }

        protected void ddlMachineID_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                BindData();
                //bindPa

            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }

        protected void cbSortRYG_CheckedChanged(object sender, EventArgs e)
        {
            try
            {
                bindColorCodeAndUnitGrouping();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }

        }

        protected void cbSortGYR_CheckedChanged(object sender, EventArgs e)
        {
            try
            {
                bindColorCodeAndUnitGrouping();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }

        protected void cbShow_CheckedChanged(object sender, EventArgs e)
        {
            try
            {
                bindColorCodeAndUnitGrouping();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }

        protected void cbRed_CheckedChanged(object sender, EventArgs e)
        {
            try
            {
                bindColorCodeAndUnitGrouping();
            }
            catch (Exception ex)
            {

            }
        }

        protected void cbYellow_CheckedChanged(object sender, EventArgs e)
        {
            try
            {
                bindColorCodeAndUnitGrouping();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }

        protected void cbGreen_CheckedChanged(object sender, EventArgs e)
        {
            try
            {
                bindColorCodeAndUnitGrouping();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }

        protected void cbCommonParametersOnly_CheckedChanged(object sender, EventArgs e)
        {
            try
            {
                bindParameters();
                ScriptManager.RegisterStartupScript(this, GetType(), "bindTimeBar", "BindTimeBar();", true);
                ScriptManager.RegisterStartupScript(this, GetType(), "bindChart", "BindCharts();", true);
                ScriptManager.RegisterStartupScript(this, GetType(), "bindAlarm", "BindAlarmDetails();", true);
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }

        protected void multiselectddlMachineID_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {

                Dictionary<string, ParameterListForMachine> machineParmeterPair = new Dictionary<string, ParameterListForMachine>();
                if (Session["MachineParameterList"] == null)
                {

                }
                else
                {
                    machineParmeterPair = (Dictionary<string, ParameterListForMachine>)Session["MachineParameterList"];
                }

                foreach (ListItem item in multiselectddlMachineID.Items)
                {
                    if (item.Selected)
                    {

                    }
                    else
                    {
                        if (machineParmeterPair.Keys.Contains(item.Text))
                        {
                            machineParmeterPair.Remove(item.Text);
                        }

                    }
                }
                Session["MachineParameterList"] = machineParmeterPair;
                bindMachineID();
                ScriptManager.RegisterStartupScript(this, GetType(), "bindTimeBar", "BindTimeBar();", true);
                ScriptManager.RegisterStartupScript(this, GetType(), "bindChart", "BindCharts();", true);
                ScriptManager.RegisterStartupScript(this, GetType(), "bindAlarm", "BindAlarmDetails();", true);
                ScriptManager.RegisterStartupScript(this, GetType(), "stayMultiselectedList", "stayMultiselectedList();", true);
            }
            catch (Exception ex)
            {

            }
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            try
            {
                hfLiveOrHistoryAlarm.Value = "Live";
                lbBackToLive.Visible = false;
                BindData();
                hfSeletcedDateTime.Value = "";
                ScriptManager.RegisterStartupScript(this, GetType(), "enableInterval", "enableAlarmInterval();", true);
                ScriptManager.RegisterStartupScript(this, GetType(), "bindAlarm", "BindAlarmDetails();", true);
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "unblockLoader", "$.unblockUI({ });", true);
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }


        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<ProcessParameterDashboardAlarmDetails> bindAlarmDetails(string machineNames, string fromDate, string toDate, string liveOrhistory,string company, string plant)
        {
            List<ProcessParameterDashboardAlarmDetails> machinesAlarmData = new List<ProcessParameterDashboardAlarmDetails>();
            try
            {

                DateTime fromDateTime = DateTime.Now;
                DateTime toDateTime = DateTime.Now;
                BsonArray machineName = new BsonArray();
                //string[] machines = machineNames.Split(',');
                //for (int i = 0; i < machines.Length; i++)
                //{
                //    machineName.Add(machines[i]);

                //}
              
                if (HttpContext.Current.Session["PPCompany"] == null)
                {

                }
                else
                {
                    company = (string)HttpContext.Current.Session["PPCompany"];
                }

                if (HttpContext.Current.Session["PPPlant"] == null){

                }
                else
                {
                    plant = (string)HttpContext.Current.Session["PPPlant"];
                }
              
                if (liveOrhistory == "History")
                {
                    machineName.Add(machineNames);
                    fromDateTime = Util.GetDateTime(fromDate);
                    toDateTime = Util.GetDateTime(toDate);
                    machinesAlarmData = MongoDBAccess.getAlarmHistoryDetails(machineName, fromDateTime, toDateTime, company, plant);
                }
                else
                {
                    Dictionary<string, ParameterListForMachine> machineParmeterPair = new Dictionary<string, ParameterListForMachine>();
                    if (HttpContext.Current.Session["MachineParameterList"] == null)
                    {
                        machineName.Add(machineNames);
                    }
                    else
                    {
                        machineParmeterPair = (Dictionary<string, ParameterListForMachine>)HttpContext.Current.Session["MachineParameterList"];
                        var machinesList = machineParmeterPair.Select(x => x.Key).ToList();
                        for (int i = 0; i < machinesList.Count; i++)
                        {
                            machineName.Add(machinesList[i]);
                        }
                    }

                    machinesAlarmData = MongoDBAccess.getAlarmLiveDetails(machineName, company, plant);
                }


            }
            catch (Exception ex)
            {

            }
            return machinesAlarmData;
        }


        protected void lbTroubleshootMachine_Click(object sender, EventArgs e)
        {
            try
            {
                Logger.WriteDebugLog("Before call set Next, Prev Date, nextdate, and Start Date" + hfLatestDateForPrev.Value + ";; " + hfLatestDateForNext.Value + ";; " + hfStartDate.Value);
                LinkButton lb = (LinkButton)sender;
                ListViewItem item = (ListViewItem)lb.NamingContainer;
                string MachineID = (item.FindControl("hfmachineID") as HiddenField).Value;
                //ddlMachineID.SelectedValue = MachineID;
                hfSelectedMachineForTroubleShoot.Value = MachineID;
                hfSelectedCompanyForTroubleShoot.Value = (item.FindControl("hfCompanyID") as HiddenField).Value;
                hfSelectedPlantForTroubleShoot.Value = (item.FindControl("hfPlantID") as HiddenField).Value;
                //ddlMachines.SelectedValue = MachineID;
                //bindParameters();

                //foreach (ListItem items in multiselectddlMachineID.Items)
                //{
                //    if (items.Text == MachineID)
                //    {
                //        items.Selected = true;
                //    }
                //    else
                //    {
                //        items.Selected = false;
                //    }
                //}
                //BindData();
                //DateTime toDate = Util.GetDateTime(txtFromDateTime.Text);
                hfStartDate.Value = Util.GetDateTime(txtFromDateTime.Text).ToString();
                // BindForTroubleShoot();
                hfLatestDateForPrev.Value = hfStartDate.Value;
                hfLatestDateForNext.Value = hfStartDate.Value;

                Logger.WriteDebugLog("Before call set Next, Prev Date, nextdate, and Start Date" + hfLatestDateForPrev.Value + ";; " + hfLatestDateForNext.Value + ";; " + hfStartDate.Value);
                setNextPrev("");
                divTimeBarContainer.Visible = true;
                // ScriptManager.RegisterStartupScript(this, GetType(), "bindChart", "BindAlarmDetails();", true);
                ScriptManager.RegisterStartupScript(this, GetType(), "clearInterval", "clearAlarmInterval();", true);
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "unblockLoader", "$.unblockUI({ });", true);
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "unblockLoader", "$.unblockUI({ });", true);
            }
        }


        [System.Web.Services.WebMethod(EnableSession = true)]
        public static ProcessParameterDashboardTimeBarData getTimeChartData()
        {
            ProcessParameterDashboardTimeBarData timeBardata = timeBardata = new ProcessParameterDashboardTimeBarData();
            try
            {

                if (HttpContext.Current.Session["TimeBarChartData"] != null)
                {
                    timeBardata = (ProcessParameterDashboardTimeBarData)HttpContext.Current.Session["TimeBarChartData"];
                }
                // HttpContext.Current.Session["TimeBarChartData"] = null;
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
            return timeBardata;
        }

        protected void lbPrevious_Click(object sender, EventArgs e)
        {
            try
            {
                setNextPrev("Previous");
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "unblockLoader", "$.unblockUI({ });", true);
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }

        protected void lbNext_Click(object sender, EventArgs e)
        {
            try
            {
                setNextPrev("Next");
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "unblockLoader", "$.unblockUI({ });", true);
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }

        private void setNextPrev(string param)
        {
            try
            {


                double interval = Convert.ToDouble(ConfigurationManager.AppSettings["ProcessParameterDashboardTroubleShootInterval"].ToString());
                double negativeInterval = -interval;
                DateTime toDate = DateTime.Now, fromDate = toDate.AddMinutes(negativeInterval);
                if (param == "Next")
                {
                    fromDate = Util.GetDateTime(hfLatestDateForNext.Value);
                    toDate = fromDate.AddMinutes(interval);
                    hfLatestDateForPrev.Value = fromDate.ToString();
                    hfLatestDateForNext.Value = toDate.ToString();
                }
                else
                {
                    Logger.WriteDebugLog("Prev else " + hfLatestDateForPrev.Value + ";; " + hfStartDate.Value);
                    toDate = Util.GetDateTime(hfLatestDateForPrev.Value);
                    fromDate = toDate.AddMinutes(negativeInterval);
                    hfLatestDateForPrev.Value = fromDate.ToString();
                    hfLatestDateForNext.Value = toDate.ToString();
                }
                Logger.WriteDebugLog("Latest Date For Next and Start Date" + hfLatestDateForNext.Value + " ;; " + hfStartDate.Value);
                if (hfLatestDateForNext.Value == hfStartDate.Value)
                {
                    lbNext.Visible = false;
                    lbPrevious.Visible = true;
                }
                else
                {
                    lbNext.Visible = true;
                    lbPrevious.Visible = true;
                }

                List<ProcessParameterDashboardTimeBarData> timeBardataList = new List<ProcessParameterDashboardTimeBarData>();
                ProcessParameterDashboardTimeBarData timeBardata = timeBardata = new ProcessParameterDashboardTimeBarData();
                List<double[]> listXYAxisData = new List<double[]>();
                Logger.WriteDebugLog("Set Next Prev: " + fromDate + "   " + toDate);
                Logger.WriteDebugLog("Set Next Prev: " + fromDate.ToString("dd-MM-yyyy HH:mm:ss.fff") + "   " + toDate.ToString("dd-MM-yyyy HH:mm:ss.fff"));
                for (DateTime date = fromDate; date <= toDate; date = date.AddSeconds(0.5))
                {
                    //Logger.WriteDebugLog(date.ToString("dd-MM-yyyy HH:mm:ss.fff"));
                    double[] xyAxisData = null;
                    xyAxisData = new double[2];
                    xyAxisData[0] = (double)(date - new DateTime(1970, 1, 1, 0, 0, 0, 0)).TotalMilliseconds;
                    xyAxisData[1] = 1;
                    listXYAxisData.Add(xyAxisData);
                }
                timeBardata.data = listXYAxisData;
                Session["TimeBarChartData"] = timeBardata;
                hfSeletcedDateTime.Value = "";
                hfLiveOrHistoryAlarm.Value = "History";
                //BindData();
                BindForTroubleShoot(fromDate, toDate);
                //ScriptManager.RegisterStartupScript(this, GetType(), "bindTimeBar", "BindTimeBar();", true);
                //ScriptManager.RegisterStartupScript(this, GetType(), "bindChart", "BindCharts();", true);
                ScriptManager.RegisterStartupScript(this, GetType(), "bindAlarm", "BindAlarmDetails();", true);
                divTimeBarContainer.Visible = true;
                lbBackToLive.Visible = true;
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("setNextPrev - " + ex.Message);
            }
        }

        protected void btnParticulatDateSelected_Click(object sender, EventArgs e)
        {
            try
            {
                double time1 = Convert.ToDouble(hfSeletcedDateTime.Value);
                TimeSpan time = TimeSpan.FromMilliseconds(time1);
                DateTime v = new DateTime(time.Ticks);
                DateTime first = new DateTime(v.Year, v.Month, v.Day, v.Hour, v.Minute, v.Second, v.Millisecond);
                DateTime second = new DateTime(1970, 1, 1, 0, 0, 0, 0);
                DateTime result = new DateTime(first.Ticks + second.Ticks);
                //if (v.Millisecond != 0)
                //{
                //    result = result.AddMilliseconds(500);
                //}
                bindColorCodeAndUnitGrouping();
                ScriptManager.RegisterStartupScript(this, GetType(), "bindTimeBar", "BindTimeBar();", true);
                ScriptManager.RegisterStartupScript(this, GetType(), "bindChart", "BindCharts();", true);
            }
            catch (Exception ex)
            {

            }
        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string getDatetime(string UpdatedTS)
        {
            string dt = "";
            try
            {
                double updatedts = Convert.ToDouble(UpdatedTS);
                TimeSpan time = TimeSpan.FromMilliseconds(updatedts);
                DateTime v = new DateTime(time.Ticks);
                DateTime first = new DateTime(v.Year, v.Month, v.Day, v.Hour, v.Minute, v.Second, v.Millisecond);
                DateTime second = new DateTime(1970, 1, 1, 0, 0, 0, 0);
                DateTime result = new DateTime(first.Ticks + second.Ticks);
                dt = result.ToString("dd-MM-yyyy HH:mm:ss");
                if (v.Millisecond != 0)
                {
                    //   result = result.AddMilliseconds(500);
                    dt += "." + v.Millisecond;
                }
                else
                {
                    dt += ".000";
                }
                Logger.WriteDebugLog("Click " + dt);
            }
            catch (Exception ex)
            {

            }
            return dt;
        }

        protected void lbBackToLive_Click(object sender, EventArgs e)
        {
            try
            {
                //List<string> machines = (List<string>)Session["PPMachines"];
                //List<string> parameters = (List<string>)Session["PPParameters"];

                //string companyName = (string)Session["PPCompany"];
                //string plantName = (string)Session["PPPlant"];
                //foreach (ListItem item in multiselectddlMachineID.Items)
                //{
                //    item.Selected = false;
                //}
                //for (int i = 0; i < machines.Count; i++)
                //{
                //    foreach (ListItem item in multiselectddlMachineID.Items)
                //    {
                //        if (item.Text == machines[i])
                //        {
                //            item.Selected = true;
                //        }
                //    }
                //}
                //foreach (ListItem item in cbParameterList.Items)
                //{
                //    item.Selected = false;
                //}
                //for (int i = 0; i < parameters.Count; i++)
                //{
                //    foreach (ListItem item in cbParameterList.Items)
                //    {
                //        if (item.Text == parameters[i])
                //        {
                //            item.Selected = true;
                //        }
                //    }
                //}
                bindCompany();
                btnOK_Click(null, null);

            }
            catch (Exception ex)
            {

            }
        }

        protected void lbLaunchToGraphView_Click(object sender, EventArgs e)
        {
            try
            {
                LinkButton btn = sender as LinkButton;
                //Get the listviewitem from button
                ListViewItem item = (ListViewItem)(sender as Control).NamingContainer;

                //Find the label control
                HiddenField machineName = (HiddenField)item.FindControl("hfmachineID");

                //Response.Redirect("~/ProcessParameterSignatureComparison.aspx", false);
                List<string> machines = new List<string>();
                machines.Add(machineName.Value);


                //need to get from grid
                Session["PPCompany"] = (item.FindControl("hfCompanyID") as HiddenField).Value;
                Session["PPPlant"] = (item.FindControl("hfPlantID") as HiddenField).Value;


                Session["PPMachines"] = machines;
                ScriptManager.RegisterStartupScript(this, GetType(), "navigation", "onSubMenuClickedToNavigate('ProcessParameterSignatureComparison','ProcessParameterSignatureComparison.aspx');", true);
            }
            catch (Exception ex)
            {

            }
        }

        protected void btnTimeClickinTimeBar_Click(object sender, EventArgs e)
        {
            try
            {
                //double time1 = Convert.ToDouble(hfSeletcedDateTime.Value);
                //TimeSpan time = TimeSpan.FromMilliseconds(time1);
                //DateTime v = new DateTime(time.Ticks);
                //DateTime first = new DateTime(v.Year, v.Month, v.Day, v.Hour, v.Minute, v.Second, v.Millisecond);
                //DateTime second = new DateTime(1970, 1, 1, 0, 0, 0, 0);
                //DateTime result = new DateTime(first.Ticks + second.Ticks);
                ////if (v.Millisecond != 0)
                ////{
                ////    result = result.AddMilliseconds(500);
                ////}
                //bindColorCodeAndUnitGrouping();
                string dt = "";
                double updatedts = Convert.ToDouble(hfSeletcedDateTime.Value);
                TimeSpan time = TimeSpan.FromMilliseconds(updatedts);
                DateTime v = new DateTime(time.Ticks);
                DateTime first = new DateTime(v.Year, v.Month, v.Day, v.Hour, v.Minute, v.Second, v.Millisecond);
                DateTime second = new DateTime(1970, 1, 1, 0, 0, 0, 0);
                DateTime result = new DateTime(first.Ticks + second.Ticks);
                dt = result.ToString("dd-MM-yyyy HH:mm:ss");
                BindForTroubleShoot(Util.GetDateTime(hfLatestDateForPrev.Value), result);
                //ScriptManager.RegisterStartupScript(this, GetType(), "bindTimeBar", "BindTimeBar();", true);
                //ScriptManager.RegisterStartupScript(this, GetType(), "bindChart", "BindCharts();", true);
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "unblockLoader", "$.unblockUI({ });", true);
            }
            catch (Exception ex)
            {

            }
        }

        protected void ddlCompany_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                Session["MachineParameterList"] = null;
                bindPlant();
                ScriptManager.RegisterStartupScript(this, GetType(), "bindTimeBar", "BindTimeBar();", true);
                ScriptManager.RegisterStartupScript(this, GetType(), "bindChart", "BindCharts();", true);
                ScriptManager.RegisterStartupScript(this, GetType(), "bindAlarm", "BindAlarmDetails();", true);
            }
            catch (Exception ex)
            {

            }
        }

        protected void ddlPlant_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                Session["MachineParameterList"] = null;
                //bindMachineID();
                bindMultipleMachineIDs();
                ScriptManager.RegisterStartupScript(this, GetType(), "bindTimeBar", "BindTimeBar();", true);
                ScriptManager.RegisterStartupScript(this, GetType(), "bindChart", "BindCharts();", true);
                ScriptManager.RegisterStartupScript(this, GetType(), "bindAlarm", "BindAlarmDetails();", true);
            }
            catch (Exception ex)
            {

            }
        }
        private void setParametersInDictionary(string machineName)
        {
            try
            {
                Dictionary<string, ParameterListForMachine> machineParmeterPair = new Dictionary<string, ParameterListForMachine>();
                if (Session["MachineParameterList"] == null)
                {

                }
                else
                {
                    machineParmeterPair = (Dictionary<string, ParameterListForMachine>)Session["MachineParameterList"];
                }

                Dictionary<string, ParameterListForMachine> machineParmeterPair1 = machineParmeterPair.ToDictionary(dwItem => dwItem.Key, dwItem => dwItem.Value as ParameterListForMachine);
                // Dictionary<string, ParameterListForMachine> machineParmeterPair1 = new Dictionary<string, ParameterListForMachine>(machineParmeterPair);
                //// machineParmeterPair1 = machineParmeterPair;

                List<string> previousCommonParameterList = new List<string>();
                var previousCommonParameterListFromDict = machineParmeterPair1.Where(x => x.Key == "CommonParameters").Select(x => x.Value).ToList();
                for (int i = 0; i < previousCommonParameterListFromDict.Count; i++)
                {
                    for (int j = 0; j < previousCommonParameterListFromDict[i].Parameters.Count; j++)
                    {
                        if (previousCommonParameterList.Contains(previousCommonParameterListFromDict[i].Parameters[j].ToString()))
                        {

                        }
                        else
                        {
                            previousCommonParameterList.Add(previousCommonParameterListFromDict[i].Parameters[j].ToString());
                        }
                    }
                }

                if (machineParmeterPair.ContainsKey(machineName) == true)
                {

                    for (int i = 0; i < cbParameterList.Items.Count; i++)
                    {
                        if (cbParameterList.Items[i].Selected)
                        {
                            if (machineParmeterPair[machineName].Parameters.Contains(cbParameterList.Items[i].Text))
                            {

                            }
                            else
                            {
                                machineParmeterPair[machineName].Parameters.Add(cbParameterList.Items[i].Text);
                            }

                        }
                        else
                        {
                            if (machineParmeterPair[machineName].Parameters.Contains(cbParameterList.Items[i].Text))
                            {
                                machineParmeterPair[machineName].Parameters.Remove(cbParameterList.Items[i].Text);
                            }
                        }
                    }
                    machineParmeterPair[machineName].Parameters = machineParmeterPair[machineName].Parameters.OrderBy(x => x).ToList();

                }
                else
                {
                    List<string> paramlist = new List<string>();
                    ParameterListForMachine parameters = new ParameterListForMachine();
                    for (int i = 0; i < cbParameterList.Items.Count; i++)
                    {
                        if (cbParameterList.Items[i].Selected)
                        {
                            if (paramlist.Contains(cbParameterList.Items[i].Text))
                            {

                            }
                            else
                            {
                                paramlist.Add(cbParameterList.Items[i].Text);
                            }
                        }
                        else
                        {
                            if (paramlist.Contains(cbParameterList.Items[i].Text))
                            {
                                paramlist.Remove(cbParameterList.Items[i].Text);
                            }
                        }
                    }
                    parameters.Parameters = paramlist.OrderBy(x=>x).ToList();
                    machineParmeterPair.Add(machineName, parameters);
                   
                }



                List<string> currentCommonParameterList = new List<string>();
                var currentCommonParameterListFromDict = machineParmeterPair1.Where(x => x.Key == "CommonParameters").Select(x => x.Value).ToList();
                for (int i = 0; i < currentCommonParameterListFromDict.Count; i++)
                {
                    for (int j = 0; j < currentCommonParameterListFromDict[i].Parameters.Count; j++)
                    {
                        if (currentCommonParameterList.Contains(currentCommonParameterListFromDict[i].Parameters[j].ToString()))
                        {

                        }
                        else
                        {
                            currentCommonParameterList.Add(currentCommonParameterListFromDict[i].Parameters[j].ToString());
                        }
                    }
                }

                if (machineName == "CommonParameters")
                {
                    var commonParameterList = machineParmeterPair.Where(x => x.Key == "CommonParameters").Select(x => x.Value).ToList();
                    for (int m = 1; m < ddlMachines.Items.Count; m++)
                    {
                        string ddlMachineName = ddlMachines.Items[m].Value;
                        if (machineParmeterPair.ContainsKey(ddlMachineName) == true)
                        {

                            //for(int i=0;i< commonParameterList.Count; i++)
                            //{
                            //    if (machineParmeterPair[ddlMachineName].Parameters.Contains(commonParameterList[i].ToString()))
                            //    {

                            //    }
                            //    else
                            //    {
                            //        machineParmeterPair[ddlMachineName].Parameters.Add(cbParameterList.Items[i].Text);
                            //    }
                            //}

                            for (int i = 0; i < commonParameterList.Count; i++)
                            {
                                for (int j = 0; j < commonParameterList[i].Parameters.Count; j++)
                                {
                                    if (machineParmeterPair[ddlMachineName].Parameters.Contains(commonParameterList[i].Parameters[j].ToString()))
                                    {
                                        //machineParmeterPair[ddlMachineName].Parameters.Remove(commonParameterList[i].Parameters[j].ToString());
                                    }
                                    else
                                    {
                                        machineParmeterPair[ddlMachineName].Parameters.Add(commonParameterList[i].Parameters[j].ToString());
                                    }

                                }
                            }

                            for (int i = 0; i < previousCommonParameterList.Count; i++)
                            {
                                //for (int j = 0; j < previousCommonParameterList[i].Parameters.Count; j++)
                                //{
                                //if (commonParameterList[0].Parameters.Contains(previousCommonParameterList[i].Parameters[j].ToString()))
                                //{

                                //}
                                //else
                                //{
                                //    if (machineParmeterPair[ddlMachineName].Parameters.Contains(previousCommonParameterList[i].Parameters[j].ToString()))
                                //    {
                                //        machineParmeterPair[ddlMachineName].Parameters.Remove(commonParameterList[i].Parameters[j].ToString());
                                //    }

                                //}
                                //}
                                if (currentCommonParameterList.Contains(previousCommonParameterList[i].ToString()))
                                {

                                }
                                else
                                {
                                    if (machineParmeterPair[ddlMachineName].Parameters.Contains(previousCommonParameterList[i].ToString()))
                                    {
                                        machineParmeterPair[ddlMachineName].Parameters.Remove(previousCommonParameterList[i].ToString());
                                    }

                                }
                            }



                            machineParmeterPair[ddlMachineName].Parameters = machineParmeterPair[ddlMachineName].Parameters.OrderBy(x => x).ToList();
                            //for (int i = 0; i < cbParameterList.Items.Count; i++)
                            //{
                            //    if (cbParameterList.Items[i].Selected)
                            //    {
                            //        if (machineParmeterPair[ddlMachineName].Parameters.Contains(cbParameterList.Items[i].Text))
                            //        {

                            //        }
                            //        else
                            //        {
                            //            machineParmeterPair[ddlMachineName].Parameters.Add(cbParameterList.Items[i].Text);
                            //        }

                            //    }
                            //    else
                            //    {
                            //        //if (machineParmeterPair[ddlMachineName].Parameters.Contains(cbParameterList.Items[i].Text))
                            //        //{
                            //        //    machineParmeterPair[ddlMachineName].Parameters.Remove(cbParameterList.Items[i].Text);
                            //        //}
                            //    }
                            //}

                        }
                        else
                        {
                            List<string> paramlist = new List<string>();
                            ParameterListForMachine parameters = new ParameterListForMachine();
                            //for (int i = 0; i < commonParameterList.Count; i++)
                            //{

                            //    if (paramlist.Contains(commonParameterList[i].ToString()))
                            //    {

                            //    }
                            //    else
                            //    {
                            //        paramlist.Add(cbParameterList.Items[i].Text);
                            //    }

                            //}

                            for (int i = 0; i < commonParameterList.Count; i++)
                            {
                                for (int j = 0; j < commonParameterList[i].Parameters.Count; j++)
                                {
                                    if (paramlist.Contains(commonParameterList[i].Parameters[j].ToString()))
                                    {

                                    }
                                    else
                                    {
                                        paramlist.Add(commonParameterList[i].Parameters[j].ToString());
                                    }

                                }
                            }


                            //for (int i = 0; i < cbParameterList.Items.Count; i++)
                            //{
                            //    if (cbParameterList.Items[i].Selected)
                            //    {
                            //        if (paramlist.Contains(cbParameterList.Items[i].Text))
                            //        {

                            //        }
                            //        else
                            //        {
                            //            paramlist.Add(cbParameterList.Items[i].Text);
                            //        }
                            //    }
                            //    else
                            //    {
                            //        if (paramlist.Contains(cbParameterList.Items[i].Text))
                            //        {
                            //            paramlist.Remove(cbParameterList.Items[i].Text);
                            //        }
                            //    }
                            //}
                            parameters.Parameters = paramlist.OrderBy(x=>x).ToList();
                            machineParmeterPair.Add(ddlMachineName, parameters);
                        }
                    }

                }


                machineParmeterPair.OrderBy(x => x.Key);
                Session["MachineParameterList"] = machineParmeterPair;
            }
            catch (Exception ex)
            {

            }
        }
        protected void ddlMachines_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                string previousMachine = ddlMachines.Items[PreviousIndex].Value;
                PreviousIndex = ddlMachines.SelectedIndex;

                setParametersInDictionary(previousMachine);
                bindParameters();
                ScriptManager.RegisterStartupScript(this, GetType(), "bindTimeBar", "BindTimeBar();", true);
                ScriptManager.RegisterStartupScript(this, GetType(), "bindChart", "BindCharts();", true);
                ScriptManager.RegisterStartupScript(this, GetType(), "bindAlarm", "BindAlarmDetails();", true);
            }
            catch (Exception ex)
            {

            }
        }
    }
    public class ParameterListForMachine
    {
        public List<string> Parameters { get; set; } = new List<string>();
    }
}