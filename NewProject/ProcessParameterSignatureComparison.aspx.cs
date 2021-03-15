using MongoDB.Bson;
using MongoDB.Bson.Serialization;
using MongoDB.Bson.Serialization.Attributes;
using MongoDB.Bson.Serialization.Serializers;
using MongoDB.Driver;
using NewProject.DataBaseAccess;
using NewProject.HelperClass;
using NewProject.Model;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Runtime.Serialization.Formatters.Binary;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utf8Json;
using Type = NewProject.Model.Type;

namespace NewProject
{
    public partial class ProcessParameterSignatureComparison : System.Web.UI.Page
    {
       
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtFromDateTime.Text = DateTime.Now.AddHours(-2).ToString("dd-MM-yyyy HH:mm:ss");
                //txtFromDateTime.Text = "06-10-2020 06:00:00";
                // txtToDateTime.Text = DateTime.Now.AddDays(-1).ToString("dd-MM-yyyy HH:mm:ss");
                //bindMachineID();
                //bindParameters();
                bindCompany();
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
                string accestype = list.Where(x => x.Screen == "Graph View").Select(x => x.Value).FirstOrDefault();
                if (accestype == "Read")
                {
                    btnSaveDataForReference.Visible = false;
                }
                else
                {
                    btnSaveDataForReference.Visible = true;
                }
            }
            catch (Exception ex)
            {

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
                    catch(Exception ex)
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
                    multiselectddlMachineID.Items[0].Selected = true;
                }
                else
                {
                    List<string> machines = (List<string>)Session["PPMachines"];
                    //Session["PPMachines"] = null;
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
                            }
                        }
                    }
                }
                bindParameters();
            }
            catch (Exception ex)
               {

            }
        }
        private void bindParameters()
        {
            try
            {
                //BsonArray machineNames = new BsonArray();
                //foreach(ListItem item in multiselectddlMachineID.Items)
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
                //var match = new BsonDocument
                //    {
                //        {
                //            "$match", new BsonDocument
                //            {
                //                { "MachineID" , new BsonDocument{
                //                    { "$in" ,machineNames }
                //                } }
                //            }
                //        }
                //    };
                //var project = new BsonDocument
                //    {
                //        {
                //            "$project" ,new BsonDocument {

                //                { "ParameterID" , "$ParameterID"},
                //                { "_id" , 0 }
                //            }
                //        }
                //    };
                //var group = new BsonDocument
                //    {
                //        {
                //            "$group" ,new BsonDocument {
                //                {"_id" , "" },
                //                {"distinct",new BsonDocument
                //                {
                //                    {"$addToSet" , "$$ROOT" }
                //                } }
                //            }
                //        }
                //    };
                //var unwind = new BsonDocument
                //    {
                //        {
                //            "$unwind" ,new BsonDocument {
                //                {"path" , "$distinct" },
                //                {"preserveNullAndEmptyArrays", false }
                //            }
                //        }
                //    };
                //var replaceRoot = new BsonDocument
                //    {
                //        {
                //            "$replaceRoot" ,new BsonDocument {
                //                {"newRoot" , "$distinct" }
                //            }
                //        }
                //    };

                //AggregateOptions aggregateOptions = new AggregateOptions { AllowDiskUse = true };
                //PipelineDefinition<BsonDocument, BsonDocument> pipeline2 = new BsonDocument[]
                //{
                //       match,project,group,unwind,replaceRoot
                //};
                //IAsyncCursor<BsonDocument> result = _MongoDatabase.GetCollection<BsonDocument>("ProcessParameterMaster").Aggregate(pipeline2, aggregateOptions);
                //var resultSet = IAsyncCursorExtensions.ToList<BsonDocument>(result);

                //List<ListItem> listItemList = new List<ListItem>();
                //foreach (BsonDocument doc in resultSet)
                //{
                //    listItemList.Add(new ListItem(doc["ParameterID"].AsString, doc["ParameterID"].AsString));
                //}
                BsonArray machineNames = new BsonArray();
                foreach (ListItem item in multiselectddlMachineID.Items)
                {
                    if (item.Selected)
                    {
                        if (machineNames == "")
                        {
                            machineNames.Add(item.Value);
                        }
                        else
                        {
                            machineNames.Add(item.Value);
                        }
                    }
                }

                //List<string> selectedParameterList = new List<string>();
                //if (Session["PPParameters"] == null)
                //{

                //    foreach (ListItem item in cbParameterList.Items)
                //    {
                //        if (item.Selected)
                //        {
                //            selectedParameterList.Add(item.Text);
                //        }
                //    }
                //}
                //else
                //{
                //    selectedParameterList = (List<string>)Session["PPParameters"];
                //   // Session["PPParameters"] = null;
                //    foreach (ListItem item in cbParameterList.Items)
                //    {
                //        item.Selected = false;
                //    }
                //    for (int i = 0; i < selectedParameterList.Count; i++)
                //    {
                //        foreach (ListItem item in cbParameterList.Items)
                //        {
                //            if (item.Text == selectedParameterList[i])
                //            {
                //                item.Selected = true;
                //            }
                //        }
                //    }
                //}
                List<string> selectedParameterList = new List<string>();
                if (Session["PPParameters"] == null)
                {
                }
                else
                {
                    selectedParameterList = (List<string>)Session["PPParameters"];
                }


                foreach (ListItem item in cbParameterList.Items)
                {
                    if (item.Selected)
                    {
                        if (selectedParameterList.Contains(item.Text))
                        {

                        }
                        else
                        {
                            selectedParameterList.Add(item.Text);
                        }
                    }
                    else
                    {
                        if(selectedParameterList.Contains(item.Text)){
                            selectedParameterList.Remove(item.Text);
                        }
                    }
                }
                Session["PPParameters"] = selectedParameterList;




                List<ListItem> parameterList = new List<ListItem>();
                if (cbCommonParametersOnly.Checked)
                {
                    parameterList = MongoDBAccess.getCoomomParameterListForMachines(machineNames,ddlCompany.SelectedValue==null?"": ddlCompany.SelectedValue.ToString(),ddlPlant.SelectedValue==null?"":ddlPlant.SelectedValue.ToString());
                }
                else
                {
                    parameterList = MongoDBAccess.getParameterListForMachines(machineNames, ddlCompany.SelectedValue == null ? "" : ddlCompany.SelectedValue.ToString(), ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString());
                }
            
                cbParameterList.DataSource = parameterList.OrderBy(x=>x.Text);
                cbParameterList.DataBind();
                //if (parameterList.Count > 0)
                //{
                //    cbParameterList.Items[0].Selected = true;
                //}
                bool selected = false;
                for (int i = 0; i < selectedParameterList.Count; i++)
                {
                    foreach (ListItem item in cbParameterList.Items)
                    {
                        if (item.Text == selectedParameterList[i])
                        {
                            item.Selected = true;
                            selected = true;
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

            }
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string getDataForGraph(string MachineID, string Parameters, string FromDate, double ToDate,string Company,string Plant)
        {
            //FromDate = "15-01-2021 14:04:16";
            //ToDate = 2;
            Stopwatch stopwatch = new Stopwatch();
            stopwatch.Start();
            Logger.WriteDebugLog(" Start " + stopwatch.Elapsed.TotalSeconds + "  DateTime" + DateTime.Now);
            //Dictionary<string, ChartDetails> keyValuePairs = new Dictionary<string, ChartDetails>();
            Dictionary<string, Dictionary<string, ChartDetails>> keyValuePairs = new Dictionary<string, Dictionary<string, ChartDetails>>();
            Dictionary<string, ChartDetails> machineKeyValuePair = new Dictionary<string, ChartDetails>();

            List<SignatureComparisionChartData> listChartData = new List<SignatureComparisionChartData>();
            int count = 0;
            try
            {
                string[] machines = MachineID.Split(',').ToArray();
                string[] parameters = Parameters.Split(',');
                string parameterNames = "";
                if (parameters.Length > 0)
                {
                    for (int i = 0; i < parameters.Length; i++)
                    {
                        if (parameterNames == "")
                        {
                            parameterNames = "['" + parameters[i] + "'";
                        }
                        else
                        {
                            parameterNames += ",'" + parameters[i] + "'";
                        }
                    }
                    parameterNames += "]";
                }
                string machineNames = "";
                if (machines.Length > 0)
                {
                    for (int i = 0; i < machines.Length; i++)
                    {
                        if (machineNames == "")
                        {
                            machineNames = "['" + machines[i] + "'";
                        }
                        else
                        {
                            machineNames += ",'" + machines[i] + "'";
                        }
                    }
                    machineNames += "]";
                }
                stopwatch.Restart();
                Logger.WriteDebugLog(" Before Query Call Seconds : " + stopwatch.Elapsed.TotalSeconds + "  DateTime" + DateTime.Now);

                //var filter = "{$and : [{ UpdatedTS: {$gte: ISODate('" + Util.GetDateTime(FromDate).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ") + "')} },{ UpdatedTS: {$lte: ISODate('" + Util.GetDateTime(FromDate).AddSeconds(ToDate).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ") + "')} }, {MachineID : {$in : " + machineNames + "}}]}";
                //var dataset = _MongoDatabase.GetCollection<BsonDocument>("PPT_AMGIOT_ColumnData_Test").Find(filter).ToList();

                List<BsonDocument> dataset = MongoDBAccess.getDataForListOfValues(FromDate, ToDate, machineNames,Company,Plant);

                HttpContext.Current.Session["GraphDataset"] = dataset;
                Logger.WriteDebugLog(" After Query Call Milliseconds: " + stopwatch.Elapsed.TotalMilliseconds.ToString() + "----Seconds: " + stopwatch.Elapsed.TotalSeconds.ToString() + "---  DateTime " + DateTime.Now);
                Logger.WriteDebugLog(" Total Records " + dataset.Count);
                stopwatch.Restart();
                SignatureComparisionChartData chartData = null;
                foreach (string paramID in parameters)
                {
                    chartData = new SignatureComparisionChartData();
                    List<SignatureComparisionChartMachineDetails> machineDetails = new List<SignatureComparisionChartMachineDetails>();
                    SignatureComparisionChartMachineDetails machineDetail = null;
                    //string parameterName = paramID.Replace("-", "");
                    string parameterName = paramID;
                    foreach (string machineID in machines)
                    {
                        machineDetail = new SignatureComparisionChartMachineDetails();
                        string cycleStartTime = "", parameterID = "";
                        double[] xyAxisData = null;
                        List<double[]> listXYAxisData = new List<double[]>();
                        chartData.ParameterID = paramID;
                        List<Plotline> plotlinesList = new List<Plotline>();
                        Plotline plotline = null;
                        List<Type> typeList = new List<Type>();
                        Type type = null;
                        var tempparamDetailsData = new BsonDocument();
                        machineDetail.CompanyID = Company;
                        machineDetail.PlantID = Plant;
                        machineDetail.MachineID = machineID;
                        List<CycleInformationData> listCycleData = new List<CycleInformationData>();
                        CycleInformationData data = null;
                        List<double[]> listEachCycleData = null;
                        double[] eachCycleData = null;
                        int cycleCount = 0;
                        int i = 0;


                        foreach (var item in dataset)
                        {

                            if (item.Contains(parameterName) && item["MachineID"].AsString == machineID)
                            {
                                if (item["CycleStartTS"] == BsonNull.Value)
                                {

                                }
                                else
                                {


                                    if (cycleStartTime != item["CycleStartTS"].AsLocalTime.ToString("yyyy-MM-dd HH:mm:ss"))
                                    {

                                        if (i != 0)
                                        {

                                            type = new Type();
                                            type.x = (double)(Convert.ToDateTime(tempparamDetailsData["UpdatedTS"].AsLocalTime) - new DateTime(1970, 1, 1, 0, 0, 0)).TotalMilliseconds;
                                            type.text = "Cycle End";
                                            type.title = "E";
                                            List<Styles> styles2 = new List<Styles>();
                                            Styles style2 = new Styles();
                                            style2.color = "green";
                                            styles2.Add(style2);
                                            type.style = styles2;
                                            typeList.Add(type);

                                            plotline = new Plotline();
                                            plotline.color = "red";
                                            plotline.value = (double)(Convert.ToDateTime(tempparamDetailsData["UpdatedTS"].AsLocalTime) - new DateTime(1970, 1, 1, 0, 0, 0)).TotalMilliseconds;
                                            plotline.width = 3;
                                            List<XLabel> labelsend = new List<XLabel>();
                                            XLabel labelend = new XLabel();
                                            labelend.text = "Cycle End";
                                            labelend.rotation = 90;

                                            List<Styles> stylesend = new List<Styles>();
                                            Styles styleend = new Styles();
                                            styleend.color = "white";
                                            stylesend.Add(styleend);
                                            labelend.style = stylesend;

                                            labelsend.Add(labelend);
                                            plotline.label = labelsend;
                                            plotlinesList.Add(plotline);

                                            listEachCycleData = new List<double[]>();
                                            for (int cycleC = cycleCount; cycleC < listXYAxisData.Count; cycleC++)
                                            {
                                                eachCycleData = new double[2];
                                                eachCycleData = listXYAxisData[cycleC] as double[];
                                                listEachCycleData.Add(eachCycleData);
                                            }
                                            for (int cycleC = cycleCount; cycleC < listXYAxisData.Count; cycleC++)
                                            {
                                                //listCycleData[cycleC].CycleData = listEachCycleData;
                                                if (tempparamDetailsData["CycleEndTS"] == BsonNull.Value)
                                                {

                                                }
                                                else
                                                {
                                                    listCycleData[cycleC].CycleEnd = tempparamDetailsData["CycleEndTS"].AsLocalTime.ToString("yyyy-MM-dd HH:mm:ss");
                                                }

                                            }
                                            cycleCount = listXYAxisData.Count;
                                        }

                                        i++;

                                        cycleStartTime = item["CycleStartTS"].AsLocalTime.ToString("yyyy-MM-dd HH:mm:ss");


                                        if (item.Contains(parameterName))
                                        {
                                            xyAxisData = new double[2];
                                            xyAxisData[0] = (double)(Convert.ToDateTime(item["UpdatedTS"].AsLocalTime) - new DateTime(1970, 1, 1, 0, 0, 0)).TotalMilliseconds;
                                            System.Type ss = item[parameterName].GetType();
                                            if (ss.Name == "BsonDouble")
                                            {
                                               
                                                xyAxisData[1] = Math.Round(item[parameterName].AsDouble,3);
                                            }
                                            else if (ss.Name == "BsonInt32")
                                            {
                                                xyAxisData[1] = item[parameterName].AsInt32;
                                            }
                                            else
                                            {
                                                xyAxisData[1] = 0;
                                            }
                                              
                                            listXYAxisData.Add(xyAxisData);
                                        }
                                        //else
                                        //{
                                        //    xyAxisData[1] = 67.0;
                                        //}



                                        type = new Type();
                                        type.x = (double)(Convert.ToDateTime(item["UpdatedTS"].AsLocalTime) - new DateTime(1970, 1, 1, 0, 0, 0)).TotalMilliseconds;
                                        type.text = "Cycle Start";
                                        type.title = "B";
                                        List<Styles> styles1 = new List<Styles>();
                                        Styles style1 = new Styles();
                                        style1.color = "green";
                                        styles1.Add(style1);
                                        type.style = styles1;
                                        typeList.Add(type);



                                        plotline = new Plotline();
                                        plotline.color = "green";
                                        plotline.value = (double)(Convert.ToDateTime(item["UpdatedTS"].AsLocalTime) - new DateTime(1970, 1, 1, 0, 0, 0)).TotalMilliseconds;
                                        plotline.width = 3;
                                        List<XLabel> labels = new List<XLabel>();
                                        XLabel label = new XLabel();
                                        label.text = "Cycle Start";
                                        label.rotation = 90;
                                        List<Styles> styles = new List<Styles>();
                                        Styles style = new Styles();
                                        style.color = "white";
                                        styles.Add(style);
                                        label.style = styles;
                                        labels.Add(label);
                                        plotline.label = labels;
                                        plotlinesList.Add(plotline);


                                    }
                                    else
                                    {


                                        cycleStartTime = item["CycleStartTS"].AsLocalTime.ToString("yyyy-MM-dd HH:mm:ss");
                                        if (item.Contains(parameterName))
                                        {
                                            xyAxisData = new double[2];
                                            xyAxisData[0] = (double)(Convert.ToDateTime(item["UpdatedTS"].AsLocalTime) - new DateTime(1970, 1, 1, 0, 0, 0)).TotalMilliseconds;

                                        
                                            System.Type paramtype = item[parameterName].GetType();
                                            if (paramtype.Name == "BsonDouble")

                                            { 
                                                xyAxisData[1] = Math.Round(item[parameterName].AsDouble);
                                            }else if (paramtype.Name == "BsonInt32")
                                          
                                            {
                                                xyAxisData[1] = item[parameterName].AsInt32;
                                            }
                                            else
                                            {
                                                xyAxisData[1] = 0;
                                            }

                                            listXYAxisData.Add(xyAxisData);
                                        }

                                        tempparamDetailsData = item;

                                    }
                                    data = new CycleInformationData();
                                    data.CycleStart = cycleStartTime;
                                    listCycleData.Add(data);
                                }
                            }
                            count++;
                        }

                        if (listXYAxisData.Count > 0)
                        {
                            if (tempparamDetailsData.Count() > 0)
                            {


                                type = new Type();
                                type.x = (double)(Convert.ToDateTime(tempparamDetailsData["UpdatedTS"].AsLocalTime) - new DateTime(1970, 1, 1, 0, 0, 0)).TotalMilliseconds;
                                type.text = "Cycle End";
                                type.title = "E";
                                List<Styles> styles1 = new List<Styles>();
                                Styles style1 = new Styles();
                                style1.color = "green";
                                styles1.Add(style1);
                                type.style = styles1;
                                typeList.Add(type);


                                plotline = new Plotline();
                                plotline.color = "red";
                                plotline.value = (double)(Convert.ToDateTime(tempparamDetailsData["UpdatedTS"].AsLocalTime) - new DateTime(1970, 1, 1, 0, 0, 0)).TotalMilliseconds;
                                plotline.width = 3;
                                List<XLabel> labelsend = new List<XLabel>();
                                XLabel labelend = new XLabel();
                                labelend.text = "Cycle End";
                                labelend.rotation = 90;

                                List<Styles> stylesend = new List<Styles>();
                                Styles styleend = new Styles();
                                styleend.color = "white";
                                stylesend.Add(styleend);
                                labelend.style = stylesend;

                                labelsend.Add(labelend);
                                plotline.label = labelsend;
                                plotlinesList.Add(plotline);

                                listEachCycleData = new List<double[]>();
                                for (int cycleC = cycleCount; cycleC < listXYAxisData.Count; cycleC++)
                                {
                                    eachCycleData = new double[2];
                                    eachCycleData = listXYAxisData[cycleC] as double[];
                                    listEachCycleData.Add(eachCycleData);
                                }
                                for (int cycleC = cycleCount; cycleC < listXYAxisData.Count; cycleC++)
                                {
                                    // listCycleData[cycleC].CycleData = listEachCycleData;
                                    if (tempparamDetailsData["CycleEndTS"] == BsonNull.Value)
                                    {

                                    }
                                    else
                                    {
                                        listCycleData[cycleC].CycleEnd = tempparamDetailsData["CycleEndTS"].AsLocalTime.ToString("yyyy-MM-dd HH:mm:ss");
                                    }

                                }
                                cycleCount = listXYAxisData.Count;
                            }
                        }
                        List<string> listSignatureId = new List<string>();
                        machineDetail.SignatureID = listSignatureId;
                        machineDetail.plotLines = plotlinesList;
                        machineDetail.type = typeList;
                        machineDetail.data = listXYAxisData;
                        machineDetail.CycleData = listCycleData;
                        machineDetails.Add(machineDetail);
                    }
                    chartData.signatureComparisionChartMachineDetails = machineDetails;
                    listChartData.Add(chartData);

                }
                Logger.WriteDebugLog(" After object building " + stopwatch.Elapsed.TotalMilliseconds.ToString() + "----Seconds: " + stopwatch.Elapsed.TotalSeconds.ToString() + "   DateTime " + DateTime.Now);
                HttpContext.Current.Session["ProcessParameterMasterDetails"] = getProcessParameterMasterData();
                Logger.WriteDebugLog(" After getProcessParameterMasterData " + stopwatch.Elapsed.TotalMilliseconds.ToString() + "  DateTime " + DateTime.Now);
            }
            catch (Exception ex)
            {
                Logger.WriteDebugLog(" Count " + count + " -- " + ex.Message);
            }
            stopwatch.Stop();

            HttpContext.Current.Session["SignatureComparisonData"] = listChartData;
            stopwatch.Restart();
            Logger.WriteDebugLog(" Before Json Conversion " + stopwatch.Elapsed.TotalMilliseconds.ToString() + "----Seconds: " + stopwatch.Elapsed.TotalSeconds.ToString() + "   DateTime " + DateTime.Now);
            string json = JsonConvert.SerializeObject(listChartData);
            // var json = Utf8Json.JsonSerializer.ToJsonString(listChartData);
            Logger.WriteDebugLog(" After Json Conversion " + stopwatch.Elapsed.TotalMilliseconds.ToString() + "----Seconds: " + stopwatch.Elapsed.TotalSeconds.ToString() + "   DateTime " + DateTime.Now);
            //return strserialize;
            // var ChartData = StringCompressionAndDecompression.Compress(JsonConvert.SerializeObject(listChartData));
            //  var ChartData1 = StringCompressionAndDecompression.Zip(listChartData.ToString());


            return json;
        }

       

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string saveDataForReference(string machineid, string parameterid, string cycleStart, string cycleEnd,string companyid,string plantid)
        {
            string sucess = "";
            var query = "";
            try
            {

                if((cycleStart==null || cycleStart == "undefined" ||cycleStart=="" ) || (cycleEnd == null || cycleEnd == "undefined" || cycleEnd == ""))
                {
                    sucess = "CycleEndEmpty";
                  //  return;
                }
                else
                {
                    double seconds = (Util.GetDateTime(cycleEnd) - Util.GetDateTime(cycleStart)).TotalSeconds;


                    List<BsonDocument> signarureIDForParam = MongoDBAccess.getMaxSignatureID(machineid, parameterid,companyid, plantid);

                    string signatureID = 1.ToString() ;
                    foreach (BsonDocument data in signarureIDForParam)
                    {
                        signatureID = (Convert.ToInt32(data["SignatureID"].ToString())+1).ToString();
                    }


                    List<BsonDocument> dataset = MongoDBAccess.getSignatureListToSave(cycleStart, cycleEnd, machineid, parameterid, seconds,companyid,plantid);

                    List<SignatureComparisionDetails> masterList = new List<SignatureComparisionDetails>();
                    SignatureComparisionDetails masterdata = null;
                    int frequency = 1;
                    foreach (BsonDocument data in dataset)
                    {
                        foreach (BsonElement element in data)
                        {
                            // BsonArray priceArray = element.Value;
                            foreach (BsonValue value in element.Value.AsBsonArray)
                            {
                                //add value here///da
                                if(value["averageValue"] == BsonNull.Value  || value["averageValue"].ToString() == "BsonNull")
                                {

                                }
                                else
                                {
                                    masterdata = new SignatureComparisionDetails();
                                    masterdata.CompanyID = companyid;
                                    masterdata.PlantID = plantid;
                                    masterdata.MachineID = machineid;
                                    masterdata.ParameterID = parameterid;
                                    masterdata.SignatureID = signatureID;
                                    masterdata.Frequency = frequency.ToString();
                                    if (value["averageValue"] == BsonNull.Value)
                                    {
                                        masterdata.ParameterValue = "";
                                    }
                                    else
                                    {
                                        masterdata.ParameterValue = value["averageValue"].ToString();
                                    }
                                    masterdata.ParameterValue = value["averageValue"].ToString();
                                    masterList.Add(masterdata);
                                    frequency++;
                                }
                               
                            }
                        }
                    }

                    //var collection = _MongoDatabase.GetCollection<SignatureComparisionDetails>("PP_AMGIOT_SignatureMaster");
                    //sucess = "Inserted";
                    //collection.InsertManyAsync(masterList).Wait();
                    sucess = MongoDBAccess.saveSignatureDetailsForReference(masterList);
                }
             
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("PP Save Signature : "+ex.Message);
                sucess = ex.Message;
            }
            return sucess;
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<SignatureComparisionZoomChartData> getzoomChartData(double xvalue, double yvalue, string machineid, string parameterid, string signatureid, string cycleStart, string cycleEnd,string companyid,string plantid)
        {
            List<SignatureComparisionZoomChartData> chartDetails = new List<SignatureComparisionZoomChartData>();
            SignatureComparisionZoomChartData chartData = new SignatureComparisionZoomChartData();
            try
            {

                List<double[]> actualDataList = new List<double[]>();
                List<SignatureComparisionChartData> dataList = new List<SignatureComparisionChartData>();
                if (HttpContext.Current.Session["SignatureComparisonData"] == null)
                {

                }
                else
                {
                    dataList = (List<SignatureComparisionChartData>)HttpContext.Current.Session["SignatureComparisonData"];
                }


                var cycleStartInMilliSecond = (double)(Convert.ToDateTime(cycleStart) - new DateTime(1970, 1, 1, 0, 0, 0)).TotalMilliseconds;
                List<BsonDocument> actualDataset = new List<BsonDocument>();
                if (HttpContext.Current.Session["GraphDataset"] == null)
                {

                }
                else
                {
                    actualDataset = (List<BsonDocument>)HttpContext.Current.Session["GraphDataset"];
                }


                var machineFiletr = actualDataset.Where(x => x["MachineID"] == machineid && x["CompanyID"] == companyid && x["PlantID"] == plantid).ToList();
                foreach (BsonDocument rowSet in machineFiletr)
                {
                    if (rowSet.Contains(parameterid))
                    {
                        if (rowSet.Contains("CycleStartTS"))
                        {
                            if (rowSet["CycleStartTS"] == BsonNull.Value)
                            {
                            }
                            else
                            {
                                double actualCycleStart = (double)(Convert.ToDateTime(rowSet["CycleStartTS"].AsLocalTime) - new DateTime(1970, 1, 1, 0, 0, 0)).TotalMilliseconds;
                                if (actualCycleStart == cycleStartInMilliSecond)
                                {
                                    double[] xyAxisData = new double[2];


                                    xyAxisData[0] = (double)(Convert.ToDateTime(rowSet["UpdatedTS"].AsLocalTime) - new DateTime(1970, 1, 1, 0, 0, 0)).TotalMilliseconds; ;

                                    System.Type ss = rowSet[parameterid].GetType();
                                    if (ss.Name == "BsonDouble")
                                    {
                                        xyAxisData[1] = Math.Round(rowSet[parameterid].AsDouble,3);
                                    }
                                    else if (ss.Name == "BsonInt32")
                                    {
                                        xyAxisData[1] = rowSet[parameterid].AsInt32;
                                    }
                                    else
                                    {
                                        xyAxisData[1] = 0;
                                    }
                                    actualDataList.Add(xyAxisData);
                                }

                            }
                        }
                    }
                }

  
                List<double[]> referenceDataList = new List<double[]>();
                //var filter = "{'MachineID':'" + machineid.Replace(" ", "") + "','ParameterID':{'$in':['" + parameterid + "']},'SignatureID':'" + signatureid + "'}";
                //var dataset = _MongoDatabase.GetCollection<BsonDocument>("PP_AMGIOT_SignatureMaster").Find(filter).ToList();
                List<BsonDocument> dataset = MongoDBAccess.getSignatureMaterDetailsWithFilter(machineid, parameterid, signatureid, companyid,plantid);

                foreach (var item in dataset)
                {
                    if (item["ParameterValue"] == BsonNull.Value || item["ParameterValue"].ToString() == "BsonNull")
                    {
                        continue;
                    }
                    else
                    {
                        double[] xyAxisData = new double[2];
                        DateTime date = Convert.ToDateTime(cycleStart).AddSeconds(Convert.ToInt32(item["Frequency"].ToString()));
                        xyAxisData[0] = (double)(date - new DateTime(1970, 1, 1, 0, 0, 0)).TotalMilliseconds;
                        xyAxisData[1] = double.Parse(item["ParameterValue"].ToString());
                        referenceDataList.Add(xyAxisData);
                    }
                
                }
                if (dataset.Count > 0)
                {
                    if (actualDataList.Count > referenceDataList.Count)
                    {
                        int refererenceCount = referenceDataList.Count;
                        while (!(refererenceCount == actualDataList.Count))
                        {
                            double[] xyAxisData = new double[2];
                            xyAxisData[0] = actualDataList[referenceDataList.Count - 1][0];
                            xyAxisData[1] = referenceDataList[refererenceCount - 1][1];
                            referenceDataList.Add(xyAxisData);
                            refererenceCount++;
                        }
                    }
                }
             

                chartData.referenceData = referenceDataList;
                chartData.actualData = actualDataList;
                chartDetails.Add(chartData);
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog("PP getzoomChartData - " + ex.Message);  
            }
            return chartDetails;
        }


        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<plotLines> getMasterData(string MachineID, string ParameterID, string LimitSelected,string CompanyID,string PlantID)
        {

            List<plotLines> plotLines = new List<plotLines>();
            plotLines plotLine = null;

            ProcessParameterTransactionMasterData masterdata = new ProcessParameterTransactionMasterData();

            try
            {
                List<ProcessParameterTransactionMasterData> processParameterTransactionMasterDatas = new List<ProcessParameterTransactionMasterData>();
                if (HttpContext.Current.Session["ProcessParameterMasterDetails"] == null)
                {
                    processParameterTransactionMasterDatas = getProcessParameterMasterData();
                    HttpContext.Current.Session["ProcessParameterMasterDetails"] = processParameterTransactionMasterDatas;
                }
                else
                {
                    processParameterTransactionMasterDatas =(List<ProcessParameterTransactionMasterData>) HttpContext.Current.Session["ProcessParameterMasterDetails"];
                }

                //masterdata.UpperErrorLimit = processParameterTransactionMasterDatas.Where(x => x.ParameterID == ParameterID).Select(x => x.UpperErrorLimit).FirstOrDefault();

                //masterdata.UpperWarningLimit = processParameterTransactionMasterDatas.Where(x => x.ParameterID == ParameterID).Select(x => x.UpperWarningLimit).FirstOrDefault();

                //masterdata.LowerWarningLimit = processParameterTransactionMasterDatas.Where(x => x.ParameterID == ParameterID).Select(x => x.LowerWarningLimit).FirstOrDefault();

                //masterdata.LowerErrorLimit = processParameterTransactionMasterDatas.Where(x => x.ParameterID == ParameterID).Select(x => x.LowerErrorLimit).FirstOrDefault();
                plotLine = new plotLines();
                plotLine.color = "red";
                plotLine.width = 2;
                plotLine.value = Convert.ToDecimal(processParameterTransactionMasterDatas.Where(x => x.ParameterID == ParameterID && x.MachineID == MachineID && x.CompanyID==CompanyID && x.PlantID==PlantID).Select(x => x.UpperErrorLimit).FirstOrDefault());
                plotLines.Add(plotLine);

                plotLine = new plotLines();
                plotLine.color = "red";
                plotLine.width = 2;
                plotLine.value = Convert.ToDecimal(processParameterTransactionMasterDatas.Where(x => x.ParameterID == ParameterID && x.MachineID == MachineID && x.CompanyID == CompanyID && x.PlantID == PlantID).Select(x => x.LowerErrorLimit).FirstOrDefault());
                plotLines.Add(plotLine);


                if (LimitSelected.Contains("UpperWarningLimit"))
                {
                    plotLine = new plotLines();
                    plotLine.color = "yellow";
                    plotLine.dashStyle = "shortdash";
                    plotLine.width = 2;
                    plotLine.value = Convert.ToDecimal(processParameterTransactionMasterDatas.Where(x => x.ParameterID == ParameterID && x.MachineID == MachineID && x.CompanyID == CompanyID && x.PlantID == PlantID).Select(x => x.UpperWarningLimit).FirstOrDefault());
                    plotLines.Add(plotLine);
                }

                if (LimitSelected.Contains("LowerWarningLimit"))
                {
                    plotLine = new plotLines();
                    plotLine.color = "yellow";
                    plotLine.dashStyle = "shortdash";
                    plotLine.width = 2;
                    plotLine.value = Convert.ToDecimal(processParameterTransactionMasterDatas.Where(x => x.ParameterID == ParameterID && x.MachineID == MachineID && x.CompanyID == CompanyID && x.PlantID == PlantID).Select(x => x.LowerWarningLimit).FirstOrDefault());
                    plotLines.Add(plotLine);
                }
            }
            catch(Exception ex)
            {

            }
            return plotLines;
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<string> getSignatureIDs(string MachineID, string ParameterID,string CompanyID,string PlantID)
        {

            List<string> signatureIds = new List<string>();
            try
            {
                List<SignatureComparisionDetails> signatureComparisionDetails = new List<SignatureComparisionDetails>();
                //if (HttpContext.Current.Session["SignatureComparisionMasterDetails"] == null)
                //{
                    signatureComparisionDetails = getSignatureComparisionMasterData();
                //}
                //else
                //{
                //    signatureComparisionDetails = (List<SignatureComparisionDetails>)HttpContext.Current.Session["SignatureComparisionMasterDetails"];
                //}
                signatureIds = signatureComparisionDetails.Where(x => x.MachineID == MachineID && x.ParameterID == ParameterID && x.CompanyID==CompanyID && x.PlantID==PlantID).Select(x => x.SignatureID).Distinct().ToList();
            }
            catch (Exception ex)
            {

            }
            return signatureIds;
        }
        private static List<ProcessParameterTransactionMasterData> getProcessParameterMasterData()
        {
            List<ProcessParameterTransactionMasterData> processParameterTransactionMasterDatas = new List<ProcessParameterTransactionMasterData>();
            try
            {
                //var filter = "{}";

                //processParameterTransactionMasterDatas = _MongoDatabase.GetCollection<ProcessParameterTransactionMasterData>("ProcessParameterMaster").Find(filter).ToList();
                processParameterTransactionMasterDatas = MongoDBAccess.getProcessParameterMasterDetails();

            }
            catch (Exception ex)
            {

            }
            return processParameterTransactionMasterDatas;
        }
        private static List<SignatureComparisionDetails> getSignatureComparisionMasterData()
        {

            List<SignatureComparisionDetails> signatureComparisionDetails = new List<SignatureComparisionDetails>();
            try
            {
                //var filter = "{}";

                //signatureComparisionDetails = _MongoDatabase.GetCollection<SignatureComparisionDetails>("PP_AMGIOT_SignatureMaster").Find(filter).ToList();
                signatureComparisionDetails = MongoDBAccess.getSignatureMasterDetails();
                HttpContext.Current.Session["SignatureComparisionMasterDetails"] = signatureComparisionDetails;
            }
            catch (Exception ex)
            {

            }
            return signatureComparisionDetails;
        }

        protected void multiselectddlMachineID_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                bindParameters();
                ScriptManager.RegisterStartupScript(this, GetType(), "stayMultiselectedList", "stayMultiselectedList();", true);

            }
            catch(Exception ex)
            {

            }
        }

        protected void cbCommonParametersOnly_CheckedChanged(object sender, EventArgs e)
        {
            try
            {
                bindParameters();

            }
            catch (Exception ex)
            {

            }

        }
        protected void ddlCompany_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                bindPlant();
            }
            catch (Exception ex)
            {

            }
        }

        protected void ddlPlant_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                bindMachineID();
            }
            catch (Exception ex)
            {

            }
        }
    }
}