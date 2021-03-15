using MongoDB.Bson;
using MongoDB.Driver;
using NewProject.DataBaseAccess;
using NewProject.Model;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using Type = NewProject.Model.Type;

namespace NewProject
{
    public partial class ProductionOEEDashboard : System.Web.UI.Page
    {
        private readonly static IMongoClient _MongoClient = null;
        private readonly static IMongoDatabase _MongoDatabase;
        private static string mongoDBConnString = ConfigurationManager.AppSettings["mongoDBConnString"].ToString();
        //    private static string mongoDBConnString = "mongodb://localhost:27017";
        static ProductionOEEDashboard()
        {
            _MongoClient = new MongoClient(mongoDBConnString);
            _MongoDatabase = _MongoClient.GetDatabase("AMGIOT");
           //    _MongoDatabase = _MongoClient.GetDatabase("AMG_IOT");
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["DashboardLevelHistory"] = null;
                Session["BackList"] = null;
                hfselectedContext.Value = "CompanyView";
                hfMainView.Value = "CompanyView";
                Label lbl = (Label)Page.Master.FindControl("lblShowSelectedItems");
                if (hfMainView.Value == "CompanyView")
                {
                    lbl.Text = "Company View";
                }
                else if (hfMainView.Value == "PlantView")
                {
                    lbl.Text = "Plant View";
                }
                else if (hfMainView.Value == "CellView")
                {
                    lbl.Text = "Cell View";
                }
                else
                {
                    lbl.Text = "Machine View";
                }
                //filterToday.Checked = true;
                filterCustomeYear.Checked = true;
                txtYear.Text = "2019";
                string date;
                string frequency = getSelectedFrequency(out date);
                bindData("","","","",frequency,date);
                //bindCardViewData();
               // bindContextList();
            }
        }
        private List<ContextListDetails> getList(string view)
        {
            List<ContextListDetails> list = new List<ContextListDetails>();
            ContextListDetails contextListDetails = new ContextListDetails();
            contextListDetails.View = view;
            contextListDetails.AE = "12";
            contextListDetails.PE = "23";
            contextListDetails.QE = "45";
            list.Add(contextListDetails);
            contextListDetails = new ContextListDetails();
            contextListDetails.View = view;
            contextListDetails.AE = "12";
            contextListDetails.PE = "23";
            contextListDetails.QE = "45";
            list.Add(contextListDetails);
            contextListDetails = new ContextListDetails();
            contextListDetails.View = view;
            contextListDetails.AE = "12";
            contextListDetails.PE = "23";
            contextListDetails.QE = "45";
            list.Add(contextListDetails);
            contextListDetails = new ContextListDetails();
            contextListDetails.View = view;
            contextListDetails.AE = "12";
            contextListDetails.PE = "23";
            contextListDetails.QE = "45";
            list.Add(contextListDetails);
            contextListDetails = new ContextListDetails();
            contextListDetails.View = view;
            contextListDetails.AE = "12";
            contextListDetails.PE = "23";
            contextListDetails.QE = "45";
            list.Add(contextListDetails);
            contextListDetails = new ContextListDetails();
            contextListDetails.View = view + " 6";
            contextListDetails.AE = "12";
            contextListDetails.PE = "23";
            contextListDetails.QE = "45";
            list.Add(contextListDetails);
            contextListDetails = new ContextListDetails();
            contextListDetails.View = view + " 7";
            contextListDetails.AE = "12";
            contextListDetails.PE = "23";
            contextListDetails.QE = "45";
            list.Add(contextListDetails);
            contextListDetails = new ContextListDetails();
            contextListDetails.View = view + " 8";
            contextListDetails.AE = "12";
            contextListDetails.PE = "23";
            contextListDetails.QE = "45";
            list.Add(contextListDetails);

        
            return list;
        }
        private List<ContextListDetails> getListforCompany(List<string> view)
        {
            List<ContextListDetails> list = new List<ContextListDetails>();
            ContextListDetails contextListDetails = null;
            for (int i = 0; i < view.Count; i++)
            {
                contextListDetails = new ContextListDetails();
                contextListDetails.View = view[i];
                contextListDetails.AE = "12";
                contextListDetails.PE = "23";
                contextListDetails.QE = "45";
                list.Add(contextListDetails);
            }
            return list;
        }
        private void bindData(string companyName,string plantName,string cellName,string machineName,string frequency,string date)
        {
            //  hfView.Value = "ListView";
            if (hfMainView.Value == "CompanyView")
            {



                List<string> compName= DBAccess.getCompanyDetails();
                List<ContextListDetails> contextListDetails = getListforCompany(compName);
                lvCompanyDashboard.DataSource = contextListDetails;
                lvCompanyDashboard.DataBind();
                divCompanyView.Visible = true;
                divPlantView.Visible = false;
                divCellView.Visible = false;
                divMachineView.Visible = false;

                lvCardViewCompanyDashboard.DataSource = contextListDetails;
                lvCardViewCompanyDashboard.DataBind();
                divCardViewCompany.Visible = true;
                divCardViewPlant.Visible = false;
                divCardViewCell.Visible = false;
                divCardViewMachine.Visible = false;

                hfselectedContext.Value = "CompanyView";
                cblRowSelector.DataSource = contextListDetails.Select(x => x.View).ToList();
                cblRowSelector.DataBind();
                List<string> ls = new List<string>();
                //ls.Add("Company");
                ls.Add("Company Description");
                ls.Add("OEE (%)");
                ls.Add("QE (%)");
                ls.Add("Part Count");
                ls.Add("Down Time (hh:mm)");
                cblColumnSelector.DataSource = ls;
                cblColumnSelector.DataBind();

            }
            else
          if (hfMainView.Value == "PlantView")
            {
                List<ContextListDetails> contextListDetails = new List<ContextListDetails>();
                List<LevelDashboardData> plantListDetails = new List<LevelDashboardData>();
                if (hfselectedContext.Value == "BUDiv")
                {
                    contextListDetails = getList("BUDiv");
                    lvDivDashboard.DataSource = contextListDetails;
                    lvDivDashboard.DataBind();
                    lvDivDashboard.Visible = true;
                    lvPlantDashboard.Visible = false;

                    lvCardViewDivDashboard.DataSource = contextListDetails;
                    lvCardViewDivDashboard.DataBind();
                    lvCardViewDivDashboard.Visible = true;
                    lvCardViewPlantDashboard.Visible = false;

                    cblRowSelector.DataSource = contextListDetails.Select(x => x.View).ToList();
                    cblRowSelector.DataBind();
                }
                else
                {

                    // contextListDetails = getList("Plant");
                    plantListDetails = BindPlantData(companyName, plantName, frequency, date);
                    string[] dateForMonth=date.Replace("T00:00:00", "").Split('-');
                    Session["PlantViewMonthData"] = getPlantMonthDayGridData(companyName, plantName, "Month", dateForMonth[0]+"-"+dateForMonth[1]+"-01");
                    if (filterCurrentMonth.Checked || filterCustomeMonth.Checked || filterCurrentYear.Checked || filterCustomeYear.Checked)
                    {
                        date = date + "T00:00:00";
                    }
                    Session["PlantViewDayData"] = getPlantMonthDayGridData(companyName, plantName, "Day", date);
                    lvPlantDashboard.DataSource = plantListDetails;
                    lvPlantDashboard.DataBind();
                    lvPlantDashboard.Visible = true;
                    lvDivDashboard.Visible = false;

                    lvCardViewPlantDashboard.DataSource = plantListDetails;
                    lvCardViewPlantDashboard.DataBind();
                    lvCardViewPlantDashboard.Visible = true;
                    lvCardViewDivDashboard.Visible = false;

                    cblRowSelector.DataSource = plantListDetails.Select(x => x.PlantName).ToList();
                    cblRowSelector.DataBind();
                }
                divPlantView.Visible = true;
                divCellView.Visible = false;
                divMachineView.Visible = false;
                divCompanyView.Visible = false;


                divCardViewPlant.Visible = true;
                divCardViewCell.Visible = false;
                divCardViewMachine.Visible = false;
                divCardViewCompany.Visible = false;

                // hfselectedContext.Value = "PlantView";
              
                List<string> ls = new List<string>();
                //ls.Add("Plant");
                ls.Add("Plant Description");
                ls.Add("OEE (%)");
                ls.Add("QE (%)");
                ls.Add("Part Count");
                ls.Add("Down Time (hh:mm)");
                ls.Add("Attendance (%)");
                ls.Add("Safety KPI (%)");
                cblColumnSelector.DataSource = ls;
                cblColumnSelector.DataBind();
            }
            else if (hfMainView.Value == "CellView")
            {
                List<LevelDashboardData> contextListDetails = BindCellData(companyName,plantName,frequency,date);
                string[] dateForMonth = date.Replace("T00:00:00", "").Split('-');
                Session["CellViewMonthData"] = getCellMonthDayGridData(companyName, plantName, "Month", dateForMonth[0] + "-" + dateForMonth[1] + "-01");
                if (filterCurrentMonth.Checked || filterCustomeMonth.Checked || filterCurrentYear.Checked || filterCustomeYear.Checked)
                {
                    date = date + "T00:00:00";
                }
                Session["CellViewMonthData"] = getCellMonthDayGridData(companyName, plantName, "Day", date);
                lvCellDashboard.DataSource = contextListDetails;
                lvCellDashboard.DataBind();
                divCellView.Visible = true;
                divPlantView.Visible = false;
                divMachineView.Visible = false;
                divCompanyView.Visible = false;

                lvCardViewCellDashboard.DataSource = contextListDetails;
                lvCardViewCellDashboard.DataBind();
                divCardViewCell.Visible = true;
                divCardViewPlant.Visible = false;
                divCardViewMachine.Visible = false;
                divCardViewCompany.Visible = false;

                hfselectedContext.Value = "CellView";
                cblRowSelector.DataSource = contextListDetails.Select(x => x.CellName).ToList();
                cblRowSelector.DataBind();
                List<string> ls = new List<string>();
                //ls.Add("Cell");
                ls.Add("Cell Description");
                ls.Add("OEE (%)");
                ls.Add("AE (%)");
                ls.Add("PE (%)");
                ls.Add("QE (%)");
                cblColumnSelector.DataSource = ls;
                cblColumnSelector.DataBind();
            }
            else
            {
                List<LevelDashboardData> contextListDetails =BindMachineData(companyName,plantName,cellName,frequency,date);
                string[] dateForMonth = date.Replace("T00:00:00", "").Split('-');
                Session["MachineViewMonthData"] = getMachineMonthDayGridData(companyName, plantName, cellName, "Month", dateForMonth[0] + "-" + dateForMonth[1] + "-01");


                if (filterCurrentMonth.Checked || filterCustomeMonth.Checked || filterCurrentYear.Checked || filterCustomeYear.Checked)
                {
                    date = date + "T00:00:00";
                }
                Session["MachineViewDayData"] = getMachineMonthDayGridData(companyName, plantName,cellName, "Day", date);
                lvMachineDashboard.DataSource = contextListDetails;
                lvMachineDashboard.DataBind();
                divMachineView.Visible = true;
                divCellView.Visible = false;
                divPlantView.Visible = false;
                divCompanyView.Visible = false;

                lvCardViewMachineDashboard.DataSource = contextListDetails;
                lvCardViewMachineDashboard.DataBind();
                divCardViewCell.Visible = false;
                divCardViewPlant.Visible = false;
                divCardViewMachine.Visible = true;
                divCardViewCompany.Visible = false;

                hfselectedContext.Value = "MachineView";
                cblRowSelector.DataSource = contextListDetails.Select(x => x.MachineName).ToList();
                cblRowSelector.DataBind();
                List<string> ls = new List<string>();
                //ls.Add("Machine");
                ls.Add("Machine Description");
                ls.Add("OEE (%)");
                ls.Add("AE (%)");
                ls.Add("PE (%)");
                ls.Add("QE (%)");
                ls.Add("Part Count");
                ls.Add("Rejection");
                ls.Add("Down Time (hh:mm)");
                cblColumnSelector.DataSource = ls;
                cblColumnSelector.DataBind();
            }
            Label lbl = (Label)Page.Master.FindControl("lblShowSelectedItems");
            if (hfMainView.Value == "CompanyView")
            {
                lbl.Text = "Company View";
            }
            else if (hfMainView.Value == "PlantView")
            {
                lbl.Text = "Plant View";
            }
            else if (hfMainView.Value == "CellView")
            {
                lbl.Text = "Cell View";
            }
            else
            {
                lbl.Text = "Machine View";
            }

            if (hfView.Value == "CardView")
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "RecordsTextopenModaladded", "showViews('CardView');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "RecordsTextopenModaladded", "showViews('ListView');", true);
            }
            //ScriptManager.RegisterStartupScript(this, GetType(), "showChart", "bindColumnChart('AvgOEE');", true);
            ScriptManager.RegisterStartupScript(this, GetType(), "showChart", "passParamForYearGraph();", true);
            
            bindContextList();
            if (cblRowSelector.Items.Count > 0)
            {
                cblRowSelector.Items.Insert(0, new ListItem("Select All", "Select All"));
            }
        }
        private  List<LevelDashboardData> BindPlantData(string companyName, string plantName,string frequency, string date)
        {
            List<LevelDashboardData> plantListDetails = new List<LevelDashboardData>();
            try
            {


                var match = new BsonDocument
                    {
                        {
                            "$match", new BsonDocument
                            {
                                { "Level" , "Level2"},
                                { "Level2.Level1Value" , companyName },
                                { "Level2.Frequency" , frequency},
                                { "Level2.pDate" , date}
                            }
                        }
                    };
                var project = new BsonDocument
                    {
                        {
                            "$project" ,new BsonDocument {
                            { "Level2.Level2Value" , "$Level2.Level2Value" },
                                { "Level2.OEffy" , "$Level2.OEffy" },
                                { "Level2.QEffy" , "$Level2.QEffy"},
                                { "Level2.AcceptedParts" , "$Level2.AcceptedParts"},
                                { "Level2.Dtime" , "$Level2.Dtime"},
                                { "_id" , 0 }
                            }
                        }
                    };
                var group = new BsonDocument
                    {
                        {
                            "$group" ,new BsonDocument {
                                {"_id" , "" },
                                {"distinct",new BsonDocument
                                {
                                    {"$addToSet" , "$$ROOT" }
                                } }
                            }
                        }
                    };
                var unwind = new BsonDocument
                    {
                        {
                            "$unwind" ,new BsonDocument {
                                {"path" , "$distinct" },
                                {"preserveNullAndEmptyArrays", false }
                            }
                        }
                    };
                var replaceRoot = new BsonDocument
                    {
                        {
                            "$replaceRoot" ,new BsonDocument {
                                {"newRoot" , "$distinct" }
                            }
                        }
                    };
                var pipeline = new[] { match, project, group, unwind, replaceRoot };
                AggregateOptions aggregateOptions = new AggregateOptions { AllowDiskUse = true };

                CancellationTokenSource source = new CancellationTokenSource();
                CancellationToken token = source.Token;
                PipelineDefinition<BsonDocument, BsonDocument> pipeline2 = new BsonDocument[]
                {
                       match,group,unwind,replaceRoot
                };
                IAsyncCursor<BsonDocument> result = _MongoDatabase.GetCollection<BsonDocument>("TPM_OEEAggregatedData").Aggregate(pipeline2, aggregateOptions);

                IAsyncCursorSource<int> cursorSource = null;

                var resultSet = IAsyncCursorExtensions.ToList<BsonDocument>(result);

                //var r4 = IAsyncCursorExtensions.ToEnumerable(result);
                LevelDashboardData plantData = null;
                foreach (BsonDocument doc in resultSet)
                {
                    BsonArray levelData = new BsonArray();
                    levelData = doc["Level2"].AsBsonArray;
                    foreach (var item in levelData)
                    {
                        plantData = new LevelDashboardData();
                        plantData.CompanyName = companyName;
                        plantData.PlantName = item["Level2Value"].ToString();
                        plantData.Description = item["Level2Value"].ToString();
                        plantData.OEE = item["OEffy"]==null?"":Math.Round(Convert.ToDouble(item["OEffy"]),4).ToString();
                        plantData.QualityRate = item["QEffy"]==null?"":Math.Round(Convert.ToDouble(item["QEffy"]),4).ToString();
                        //plantData.Revenue = item["AcceptedParts"]==null?"":Math.Round(Convert.ToDouble(item["AcceptedParts"]),4).ToString();
                        plantData.Revenue = String.Format("{0:#,##0.####}", item["AcceptedParts"] == null ? 0 : Convert.ToDouble(item["AcceptedParts"]));
                        if (item["DTime"] == null)
                        {
                            plantData.LossINR = "00:00";
                        }
                        else
                        {
                            var timeSpan = TimeSpan.FromSeconds(Convert.ToInt32(item["DTime"]));
                            plantData.LossINR = timeSpan.Hours + ":" + timeSpan.Minutes;
                        }
                        //  plantData.LossINR = item["DTime"]==null?"":Math.Round(Convert.ToDouble(item["DTime"]),4).ToString();
                        plantData.Attendance = "90";
                        plantData.SafetyKPI = "90";
                        plantListDetails.Add(plantData);
                    }
                }

            }
            catch (Exception ex)
            {

            }
            return plantListDetails;
        }

        private static List<LevelDashboardData> getPlantMonthDayGridData(string companyName, string plantName, string frequency, string date)
        {
            List<LevelDashboardData> plantListDetails = new List<LevelDashboardData>();
            try
            {
                

                var match = new BsonDocument
                    {
                        {
                            "$match", new BsonDocument
                            {
                                { "Level" , "Level2"},
                                { "Level2.Level1Value" , companyName},
                                { "Level2.Frequency" ,  frequency},
                                { "Level2.pDate" ,  date}
                            }
                        }
                    };
                var project = new BsonDocument
                    {
                        {
                            "$project" ,new BsonDocument {
                            { "Level2.Level2Value" , "$Level2.Level2Value" },
                                { "Level2.OEffy" , "$Level2.OEffy" },
                                { "Level2.QEffy" , "$Level2.QEffy"},
                                { "Level2.AcceptedParts" , "$Level2.AcceptedParts"},
                                { "Level2.Dtime" , "$Level2.Dtime"},
                                { "_id" , 0 }
                            }
                        }
                    };
                var group = new BsonDocument
                    {
                        {
                            "$group" ,new BsonDocument {
                                {"_id" , "" },
                                {"distinct",new BsonDocument
                                {
                                    {"$addToSet" , "$$ROOT" }
                                } }
                            }
                        }
                    };
                var unwind = new BsonDocument
                    {
                        {
                            "$unwind" ,new BsonDocument {
                                {"path" , "$distinct" },
                                {"preserveNullAndEmptyArrays", false }
                            }
                        }
                    };
                var replaceRoot = new BsonDocument
                    {
                        {
                            "$replaceRoot" ,new BsonDocument {
                                {"newRoot" , "$distinct" }
                            }
                        }
                    };
                var pipeline = new[] { match, project, group, unwind, replaceRoot };
                AggregateOptions aggregateOptions = new AggregateOptions { AllowDiskUse = true };

                CancellationTokenSource source = new CancellationTokenSource();
                CancellationToken token = source.Token;
                PipelineDefinition<BsonDocument, BsonDocument> pipeline2 = new BsonDocument[]
                {
                       match,group,unwind,replaceRoot
                };
                IAsyncCursor<BsonDocument> result = _MongoDatabase.GetCollection<BsonDocument>("TPM_OEEAggregatedData").Aggregate(pipeline2, aggregateOptions);

                IAsyncCursorSource<int> cursorSource = null;

                var resultSet = IAsyncCursorExtensions.ToList<BsonDocument>(result);

                //var r4 = IAsyncCursorExtensions.ToEnumerable(result);
                LevelDashboardData plantData = null;
                foreach (BsonDocument doc in resultSet)
                {
                    BsonArray levelData = new BsonArray();
                    levelData = doc["Level2"].AsBsonArray;
                    foreach (var item in levelData)
                    {
                        plantData = new LevelDashboardData();
                        plantData.CompanyName = companyName;
                        plantData.PlantName = item["Level2Value"].ToString();
                        plantData.Description = item["Level2Value"].ToString();
                        plantData.OEE = item["OEffy"] == null ? "" : Math.Round(Convert.ToDouble(item["OEffy"]), 4).ToString();
                       // plantData.OEE = String.Format("{0:#,##0.####}", item["OEffy"] == null ? 0 : Convert.ToDouble(item["OEffy"]) ;
                        plantData.QualityRate = item["QEffy"] == null ? "" : Math.Round(Convert.ToDouble(item["QEffy"]), 4).ToString();
                        plantData.Revenue = item["AcceptedParts"] == null ? "" : Math.Round(Convert.ToDouble(item["AcceptedParts"]), 4).ToString();
                      //  plantData.Revenue = String.Format("{0:#,##0.####}", item["AcceptedParts"] == null ? 0 : Convert.ToDouble(item["AcceptedParts"])) ;
                        if (item["DTime"] == null)
                        {
                            plantData.LossINR = "00:00";
                        }
                        else
                        {
                            var timeSpan = TimeSpan.FromSeconds(Convert.ToInt32(item["DTime"]));
                            plantData.LossINR = timeSpan.Hours + ":" + timeSpan.Minutes;
                        }
                        plantData.Attendance = "90";
                        plantData.SafetyKPI = "90";
                        plantData.pDate = item["pDate"].ToString();
                        plantListDetails.Add(plantData);
                    }
                }

            }
            catch (Exception ex)
            {

            }
            return plantListDetails;
        }
        private List<LevelDashboardData> BindCellData(string companyName, string plantName, string frequency, string date)
        {
            List<LevelDashboardData> cellListDetails = new List<LevelDashboardData>();
            try
            {
                var match = new BsonDocument
                    {
                        {
                            "$match", new BsonDocument
                            {
                                { "Level" , "Level3"},
                                { "Level3.Level1Value" , companyName },
                                { "Level3.Level2Value" , plantName},
                                { "Level3.Frequency" , frequency},
                                { "Level3.pDate" , date}
                            }
                        }
                    };
                var project = new BsonDocument
                    {
                        {
                            "$project" ,new BsonDocument {
                            { "Level3.Level3Value" , "$Level3.Level3Value" },
                                { "Level3.OEffy" , "$Level3.OEffy" },
                                { "Level3.QEffy" ,  "$Level3.QEffy"},
                                { "Level3.AEffy" , "$Level3.AEffy"},
                                { "Level3.PEffy", "$Level3.PEffy"},
                                { "Level3.AcceptedParts" , "$Level3.AcceptedParts"},
                                {"Level3.Dtime" , "$Level3.Dtime"},
                                {"Level3.RejCount" , "$Level3.RejCount"},
                                { "_id" , 0 }
                            }
                        }
                    };
                var group = new BsonDocument
                    {
                        {
                            "$group" ,new BsonDocument {
                                {"_id" , "" },
                                {"distinct",new BsonDocument
                                {
                                    {"$addToSet" , "$$ROOT" }
                                } }
                            }
                        }
                    };
                var unwind = new BsonDocument
                    {
                        {
                            "$unwind" ,new BsonDocument {
                                {"path" , "$distinct" },
                                {"preserveNullAndEmptyArrays", false }
                            }
                        }
                    };
                var replaceRoot = new BsonDocument
                    {
                        {
                            "$replaceRoot" ,new BsonDocument {
                                {"newRoot" , "$distinct" }
                            }
                        }
                    };
                AggregateOptions aggregateOptions = new AggregateOptions { AllowDiskUse = true };
                PipelineDefinition<BsonDocument, BsonDocument> pipeline2 = new BsonDocument[]
                {match,group,unwind,replaceRoot};
                IAsyncCursor<BsonDocument> result = _MongoDatabase.GetCollection<BsonDocument>("TPM_OEEAggregatedData").Aggregate(pipeline2, aggregateOptions);
                // var resultSet = IAsyncCursorExtensions.ToEnumerable(result);
                var resultSet = IAsyncCursorExtensions.ToList<BsonDocument>(result);
                LevelDashboardData data = null;
                foreach (BsonDocument doc in resultSet)
                {

                    // var levelData = doc["Level3"];
                    BsonArray levelData = new BsonArray();
                    levelData = doc["Level3"].AsBsonArray;
                    // BsonDocument levelData = doc["Level3"].AsBsonDocument;
                    foreach (var item in levelData)
                    {
                        data = new LevelDashboardData();
                        data.CompanyName = companyName;
                        data.PlantName = plantName;
                        data.CellName = item["Level3Value"].ToString();
                        data.Description = item["Level3Value"].ToString();
                        data.OEE = item["OEffy"]==null?"":Math.Round(Convert.ToDouble(item["OEffy"]),4).ToString();
                        data.AEffy = item["AEffy"]==null?"":Math.Round(Convert.ToDouble(item["AEffy"]),4).ToString();
                        data.PEffy = item["PEffy"]==null?"":Math.Round(Convert.ToDouble(item["PEffy"]),4).ToString();
                        data.QEffy = item["QEffy"]==null?"":Math.Round(Convert.ToDouble(item["QEffy"]),4).ToString();
                        //BsonArray sdAry = new BsonArray();
                        //sdAry= item["SD"].AsBsonArray;
                        //List<string> listCat = new List<string>();
                        //foreach (var dat1 in sdAry)
                        //{
                        // listCat.Add(dat1["DownID"].ToString());
                        //}
                        cellListDetails.Add(data);
                    }

                }
            }
            catch(Exception ex)
            {

            }
          
            return cellListDetails;
        }
        private static List<LevelDashboardData> getCellMonthDayGridData(string companyName, string plantName, string frequency, string date)
        {
            List<LevelDashboardData> cellListDetails = new List<LevelDashboardData>();
            try
            {
                var match = new BsonDocument
                    {
                        {
                            "$match", new BsonDocument
                            {
                                { "Level" , "Level3"},
                                { "Level3.Level1Value" , companyName },
                                { "Level3.Level2Value" , plantName},
                                { "Level3.Frequency" , frequency},
                                { "Level3.pDate" , date}
                            }
                        }
                    };
                var project = new BsonDocument
                    {
                        {
                            "$project" ,new BsonDocument {
                            { "Level3.Level3Value" , "$Level3.Level3Value" },
                                { "Level3.OEffy" , "$Level3.OEffy" },
                                { "Level3.QEffy" ,  "$Level3.QEffy"},
                                { "Level3.AEffy" , "$Level3.AEffy"},
                                { "Level3.PEffy", "$Level3.PEffy"},
                                { "Level3.AcceptedParts" , "$Level3.AcceptedParts"},
                                {"Level3.Dtime" , "$Level3.Dtime"},
                                {"Level3.RejCount" , "$Level3.RejCount"},
                                { "_id" , 0 }
                            }
                        }
                    };
                var group = new BsonDocument
                    {
                        {
                            "$group" ,new BsonDocument {
                                {"_id" , "" },
                                {"distinct",new BsonDocument
                                {
                                    {"$addToSet" , "$$ROOT" }
                                } }
                            }
                        }
                    };
                var unwind = new BsonDocument
                    {
                        {
                            "$unwind" ,new BsonDocument {
                                {"path" , "$distinct" },
                                {"preserveNullAndEmptyArrays", false }
                            }
                        }
                    };
                var replaceRoot = new BsonDocument
                    {
                        {
                            "$replaceRoot" ,new BsonDocument {
                                {"newRoot" , "$distinct" }
                            }
                        }
                    };
                AggregateOptions aggregateOptions = new AggregateOptions { AllowDiskUse = true };
                PipelineDefinition<BsonDocument, BsonDocument> pipeline2 = new BsonDocument[]
                {match,group,unwind,replaceRoot};
                IAsyncCursor<BsonDocument> result = _MongoDatabase.GetCollection<BsonDocument>("TPM_OEEAggregatedData").Aggregate(pipeline2, aggregateOptions);
                // var resultSet = IAsyncCursorExtensions.ToEnumerable(result);
                var resultSet = IAsyncCursorExtensions.ToList<BsonDocument>(result);
                LevelDashboardData data = null;
                foreach (BsonDocument doc in resultSet)
                {

                    // var levelData = doc["Level3"];
                    BsonArray levelData = new BsonArray();
                    levelData = doc["Level3"].AsBsonArray;
                    // BsonDocument levelData = doc["Level3"].AsBsonDocument;
                    foreach (var item in levelData)
                    {
                        data = new LevelDashboardData();
                        data.CompanyName = companyName;
                        data.PlantName = plantName;
                        data.CellName = item["Level3Value"].ToString();
                        data.Description = item["Level3Value"].ToString();
                        data.OEE = item["OEffy"] == null ? "" : Math.Round(Convert.ToDouble(item["OEffy"]), 4).ToString();
                        data.AEffy = item["AEffy"] == null ? "" : Math.Round(Convert.ToDouble(item["AEffy"]), 4).ToString();
                        data.PEffy = item["PEffy"] == null ? "" : Math.Round(Convert.ToDouble(item["PEffy"]), 4).ToString();
                        data.QEffy = item["QEffy"] == null ? "" : Math.Round(Convert.ToDouble(item["QEffy"]), 4).ToString();
                        data.pDate= item["pDate"].ToString();
                        cellListDetails.Add(data);
                    }

                }
            }
            catch (Exception ex)
            {

            }

            return cellListDetails;
        }
        private List<LevelDashboardData> BindMachineData(string companyName, string plantName,string cellName, string frequency, string date)
        {
            List<LevelDashboardData> machineListDetails = new List<LevelDashboardData>();
            try
            {
                var match = new BsonDocument
                    {
                        {
                            "$match", new BsonDocument
                            {
                                { "Level" , "Level4"},
                                { "Level4.Level1Value" , companyName },
                                { "Level4.Level2Value" , plantName},
                                { "Level4.Level3Value" , cellName},
                                { "Level4.Frequency" , frequency},
                                { "Level4.pDate" , date}
                            }
                        }
                    };
                var project = new BsonDocument
                    {
                        {
                            "$project" ,new BsonDocument {
                            { "Level4.Level4Value" ,  "$Level4.Level4Value" },
                                { "Level4.OEffy" , "$Level4.OEffy" },
                                {"Level4.QEffy" , "$Level4.QEffy"},
                                {"Level4.AEffy" , "$Level4.AEffy"},
                                { "Level4.PEffy" , "$Level4.PEffy"},
                                {"Level4.AcceptedParts" , "$Level4.AcceptedParts"},
                                {"Level4.Dtime" , "$Level4.Dtime"},
                                {"Level4.RejCount" , "$Level4.RejCount"},
                                { "_id" , 0 }
                            }
                        }
                    };
                var group = new BsonDocument
                    {
                        {
                            "$group" ,new BsonDocument {
                                {"_id" , "" },
                                {"distinct",new BsonDocument
                                {
                                    {"$addToSet" , "$$ROOT" }
                                } }
                            }
                        }
                    };
                var unwind = new BsonDocument
                    {
                        {
                            "$unwind" ,new BsonDocument {
                                {"path" , "$distinct" },
                                {"preserveNullAndEmptyArrays", false }
                            }
                        }
                    };
                var replaceRoot = new BsonDocument
                    {
                        {
                            "$replaceRoot" ,new BsonDocument {
                                {"newRoot" , "$distinct" }
                            }
                        }
                    };
                AggregateOptions aggregateOptions = new AggregateOptions { AllowDiskUse = true };
                PipelineDefinition<BsonDocument, BsonDocument> pipeline2 = new BsonDocument[]
                {match,group,unwind,replaceRoot};
                IAsyncCursor<BsonDocument> result = _MongoDatabase.GetCollection<BsonDocument>("TPM_OEEAggregatedData").Aggregate(pipeline2, aggregateOptions);
                // var resultSet = IAsyncCursorExtensions.ToEnumerable(result);
                var resultSet = IAsyncCursorExtensions.ToList<BsonDocument>(result);
                LevelDashboardData data = null;
                foreach (BsonDocument doc in resultSet)
                {
                    BsonArray levelData = new BsonArray();
                    levelData = doc["Level4"].AsBsonArray;
                    foreach (var item in levelData)
                    {
                        data = new LevelDashboardData();
                        data.CompanyName = companyName;
                        data.PlantName = plantName;
                        data.CellName = cellName;
                        data.MachineName = item["Level4Value"].ToString();
                        data.Description = item["Level4Value"].ToString();
                        data.OEE = item["OEffy"]==null?"":Math.Round(Convert.ToDouble(item["OEffy"]),4).ToString();
                        data.AEffy = item["AEffy"]==null?"":Math.Round(Convert.ToDouble(item["AEffy"]),4).ToString();
                        data.PEffy = item["PEffy"]==null?"":Math.Round(Convert.ToDouble(item["PEffy"]),4).ToString();
                        data.QEffy = item["QEffy"]==null?"":Math.Round(Convert.ToDouble(item["QEffy"]),4).ToString();
                        //data.AcceptedPart = item["AcceptedParts"]==null?"":Math.Round(Convert.ToDouble(item["AcceptedParts"]),4).ToString();
                        data.AcceptedPart = String.Format("{0:#,##0.####}", item["AcceptedParts"] == null ? 0 : Convert.ToDouble(item["AcceptedParts"]));
                        if (item["DTime"]==null)
                        {
                                 data.LossINR = "00:00";
                        }
                        else
                        {
                            var timeSpan = TimeSpan.FromSeconds(Convert.ToInt32(item["DTime"]));
                            data.LossINR = timeSpan.Hours + ":" + timeSpan.Minutes;
                        }
                        //data.LossINR = item["DTime"]==null?"":Math.Round(Convert.ToDouble(item["DTime"]),4).ToString();
                        data.RejectCount = item["RejCount"]==null?"":Math.Round(Convert.ToDouble(item["RejCount"]),4).ToString();
                        machineListDetails.Add(data);
                    }
                }
            }
            catch(Exception ex)
            {

            }
           
            return machineListDetails;
        }
        private static List<LevelDashboardData> getMachineMonthDayGridData(string companyName, string plantName, string cellName, string frequency, string date)
        {
            List<LevelDashboardData> machineListDetails = new List<LevelDashboardData>();
            try
            {
                var match = new BsonDocument
                    {
                        {
                            "$match", new BsonDocument
                            {
                                { "Level" , "Level4"},
                                { "Level4.Level1Value" , companyName },
                                { "Level4.Level2Value" , plantName},
                                { "Level4.Level3Value" , cellName},
                                { "Level4.Frequency" , frequency},
                                { "Level4.pDate" , date}
                            }
                        }
                    };
                var project = new BsonDocument
                    {
                        {
                            "$project" ,new BsonDocument {
                            { "Level4.Level4Value" ,  "$Level4.Level4Value" },
                                { "Level4.OEffy" , "$Level4.OEffy" },
                                {"Level4.QEffy" , "$Level4.QEffy"},
                                {"Level4.AEffy" , "$Level4.AEffy"},
                                { "Level4.PEffy" , "$Level4.PEffy"},
                                {"Level4.AcceptedParts" , "$Level4.AcceptedParts"},
                                {"Level4.Dtime" , "$Level4.Dtime"},
                                {"Level4.RejCount" , "$Level4.RejCount"},
                                { "_id" , 0 }
                            }
                        }
                    };
                var group = new BsonDocument
                    {
                        {
                            "$group" ,new BsonDocument {
                                {"_id" , "" },
                                {"distinct",new BsonDocument
                                {
                                    {"$addToSet" , "$$ROOT" }
                                } }
                            }
                        }
                    };
                var unwind = new BsonDocument
                    {
                        {
                            "$unwind" ,new BsonDocument {
                                {"path" , "$distinct" },
                                {"preserveNullAndEmptyArrays", false }
                            }
                        }
                    };
                var replaceRoot = new BsonDocument
                    {
                        {
                            "$replaceRoot" ,new BsonDocument {
                                {"newRoot" , "$distinct" }
                            }
                        }
                    };
                AggregateOptions aggregateOptions = new AggregateOptions { AllowDiskUse = true };
                PipelineDefinition<BsonDocument, BsonDocument> pipeline2 = new BsonDocument[]
                {match,group,unwind,replaceRoot};
                IAsyncCursor<BsonDocument> result = _MongoDatabase.GetCollection<BsonDocument>("TPM_OEEAggregatedData").Aggregate(pipeline2, aggregateOptions);
                // var resultSet = IAsyncCursorExtensions.ToEnumerable(result);
                var resultSet = IAsyncCursorExtensions.ToList<BsonDocument>(result);
                LevelDashboardData data = null;
                foreach (BsonDocument doc in resultSet)
                {
                    BsonArray levelData = new BsonArray();
                    levelData = doc["Level4"].AsBsonArray;
                    foreach (var item in levelData)
                    {
                        data = new LevelDashboardData();
                        data.CompanyName = companyName;
                        data.PlantName = plantName;
                        data.CellName = cellName;
                        data.MachineName = item["Level4Value"].ToString();
                        data.Description = item["Level4Value"].ToString();
                        data.OEE = item["OEffy"] == null ? "" : Math.Round(Convert.ToDouble(item["OEffy"]), 4).ToString();
                        data.AEffy = item["AEffy"] == null ? "" : Math.Round(Convert.ToDouble(item["AEffy"]), 4).ToString();
                        data.PEffy = item["PEffy"] == null ? "" : Math.Round(Convert.ToDouble(item["PEffy"]), 4).ToString();
                        data.QEffy = item["QEffy"] == null ? "" : Math.Round(Convert.ToDouble(item["QEffy"]), 4).ToString();
                        data.AcceptedPart = item["AcceptedParts"] == null ? "" : Math.Round(Convert.ToDouble(item["AcceptedParts"]), 4).ToString();

                        if (item["DTime"] == null)
                        {
                            data.LossINR = "00:00";
                        }
                        else
                        {
                            var timeSpan = TimeSpan.FromSeconds(Convert.ToInt32(item["DTime"]));
                            data.LossINR = timeSpan.Hours + ":" + timeSpan.Minutes;
                        }
                        //data.LossINR = item["DTime"]==null?"":Math.Round(Convert.ToDouble(item["DTime"]),4).ToString();
                        data.RejectCount = item["RejCount"] == null ? "" : Math.Round(Convert.ToDouble(item["RejCount"]), 4).ToString();
                        data.pDate = item["pDate"].ToString();
                        machineListDetails.Add(data);
                    }
                }
            }
            catch (Exception ex)
            {

            }

            return machineListDetails;
        }
        //public static async IAsyncEnumerable<BsonDocument> ToAsyncEnumerable(IAsyncCursor<BsonDocument> asyncCursor)
        //{
        //    while (await asyncCursor.MoveNextAsync())
        //    {
        //        foreach (var current in asyncCursor.Current)
        //        {
        //            yield return current;
        //        }
        //    }
        //}
        private void bindCardViewData()
        {

            hfView.Value = "CardView";
            if (hfMainView.Value == "CompanyView")
            {
                List<ContextListDetails> contextListDetails = getList("Company");
                lvCardViewCompanyDashboard.DataSource = contextListDetails;
                lvCardViewCompanyDashboard.DataBind();
                lvCardViewCompanyDashboard.Visible = true;
                lvCardViewPlantDashboard.Visible = false;
                lvCardViewCellDashboard.Visible = false;
                lvCardViewMachineDashboard.Visible = false;
                hfselectedContext.Value = "CompanyView";
                cblRowSelector.DataSource = contextListDetails.Select(x => x.View).ToList();
                cblRowSelector.DataBind();
                List<string> ls = new List<string>();
                //ls.Add("Company");
                ls.Add("Company Description");
                ls.Add("Avg. OEE");
                ls.Add("Quality Rate (PPM)");
                ls.Add("Revenue (INR)");
                ls.Add("Loss (INR)");
                cblColumnSelector.DataSource = ls;
                cblColumnSelector.DataBind();

            }
            else
          if (hfMainView.Value == "PlantView")
            {
                List<ContextListDetails> contextListDetails = getList("Plant");
                lvCardViewPlantDashboard.DataSource = contextListDetails;
                lvCardViewPlantDashboard.DataBind();
                lvCardViewPlantDashboard.Visible = true;
                lvCardViewCellDashboard.Visible = false;
                lvCardViewMachineDashboard.Visible = false;
                lvCardViewCompanyDashboard.Visible = false;
                hfselectedContext.Value = "PlantView";
                cblRowSelector.DataSource = contextListDetails.Select(x => x.View).ToList();
                cblRowSelector.DataBind();
                List<string> ls = new List<string>();
                ls.Add("Plant");
                ls.Add("Plant Description");
                ls.Add("Plant OEE");
                ls.Add("Quality Rate");
                ls.Add("Revenue");
                ls.Add("Loss (INR)");
                ls.Add("Attendance");
                ls.Add("Safety KPI");
                cblColumnSelector.DataSource = ls;
                cblColumnSelector.DataBind();
            }
            else if (hfMainView.Value == "CellView")
            {
                List<ContextListDetails> contextListDetails = getList("Cell");
                lvCardViewCellDashboard.DataSource = contextListDetails;
                lvCardViewCellDashboard.DataBind();
                lvCardViewCellDashboard.Visible = true;
                lvCardViewPlantDashboard.Visible = false;
                lvCardViewMachineDashboard.Visible = false;
                lvCardViewCompanyDashboard.Visible = false;
                hfselectedContext.Value = "CellView";
                cblRowSelector.DataSource = contextListDetails.Select(x => x.View).ToList();
                cblRowSelector.DataBind();
                List<string> ls = new List<string>();
                //ls.Add("Cell");
                ls.Add("Cell Description");
                ls.Add("OEE (%)");
                ls.Add("AE (%)");
                ls.Add("PE (%)");
                ls.Add("QE (%)");
                cblColumnSelector.DataSource = ls;
                cblColumnSelector.DataBind();
            }
            else
            {
                List<ContextListDetails> contextListDetails = getList("Machine");
                lvCardViewMachineDashboard.DataSource = contextListDetails;
                lvCardViewMachineDashboard.DataBind();
                lvCardViewCellDashboard.Visible = false;
                lvCardViewPlantDashboard.Visible = false;
                lvCardViewMachineDashboard.Visible = true;
                lvCardViewCompanyDashboard.Visible = false;
                hfselectedContext.Value = "MachineView";
                cblRowSelector.DataSource = contextListDetails.Select(x => x.View).ToList();
                cblRowSelector.DataBind();
                List<string> ls = new List<string>();
                //ls.Add("Machine");
                ls.Add("Machine Description");
                ls.Add("OEE (%)");
                ls.Add("AE (%)");
                ls.Add("PE (%)");
                ls.Add("QE (%)");
                ls.Add("Part Count");
                ls.Add("Rejection");
                ls.Add("Loss (hh: mm)");
                cblColumnSelector.DataSource = ls;
                cblColumnSelector.DataBind();
            }
            Label lbl = (Label)Page.Master.FindControl("lblShowSelectedItems");
            lbl.Text = hfMainView.Value;

            ScriptManager.RegisterStartupScript(this, GetType(), "RecordsTextopenModaladded", "showViews('CardView');", true);
            if (cblRowSelector.Items.Count > 0)
            {
                cblRowSelector.Items.Insert(0, new ListItem("Select All", "Select All"));
            }
        }
        private void bindContextList()
        {
            try
            {
                Label lbl = (Label)Page.Master.FindControl("lblShowSelectedItems");
                if (hfMainView.Value == "CompanyView")
                {
                    List<ListItem> listItems = new List<ListItem>();
                    lvContext.DataSource = listItems;
                    lvContext.DataBind();
                }
                else
                if (hfMainView.Value == "PlantView")
                {
                    List<ListItem> listItems = getPlantViewList().Where(j => j.Value != hfselectedContext.Value).ToList();
                    lvContext.DataSource = listItems;
                    lvContext.DataBind();
                    lbl.Text = getPlantViewList().Where(j => j.Value == hfselectedContext.Value).Select(x => x.Text).FirstOrDefault();
                }
                else if (hfMainView.Value == "CellView")
                {
                    List<ListItem> listItems = getCellViewList().Where(j => j.Value != hfselectedContext.Value).ToList();
                    lvContext.DataSource = listItems;
                    lvContext.DataBind();
                    lbl.Text = getCellViewList().Where(j => j.Value == hfselectedContext.Value).Select(x => x.Text).FirstOrDefault();
                }
                else
                {
                    List<ListItem> listItems = getMachineViewList().Where(j => j.Value != hfselectedContext.Value).ToList();
                    lvContext.DataSource = listItems;
                    lvContext.DataBind();
                    lbl.Text = getMachineViewList().Where(j => j.Value == hfselectedContext.Value).Select(x => x.Text).FirstOrDefault();
                }

                string date = "";
                string frequency = getSelectedFrequency(out date);
                lbl.Text = lbl.Text + " - " + date.Replace("T00:00:00","");
                //Label lbl = (Label)Page.Master.FindControl("lblShowSelectedItems");
                ////lbl.Text = hfMainView.Value + " -> " + hfselectedContext.Value;
                //if (hfMainView.Value == "CompanyView")
                //{
                //    lbl.Text = "Company View";
                //}
                //else if (hfMainView.Value == "PlantView")
                //{
                //    lbl.Text = "Plant View";
                //}
                //else if (hfMainView.Value == "CellView")
                //{
                //    lbl.Text = "Cell View";
                //}
                //else
                //{
                //    lbl.Text = "Machine View";
                //}


                //Site site = this.Master as Site;
                //if (site != null)
                //{
                //    Label SensorTemperatureLabel = site.FindControl("SensorTemperatureLabel") as Label;
                //    SensorTemperatureLabel.Text = DateTime.Now.ToString();
                //}

            }
            catch (Exception ex)
            {

            }
        }
        private List<ListItem> getPlantViewList()
        {
            List<ListItem> listItems = new List<ListItem>();
            ListItem listItem = new ListItem();
            listItem.Text = "BU / Div";
            listItem.Value = "BUDiv";
            listItems.Add(listItem);
            listItem = new ListItem();
            listItem.Text = "Customers";
            listItem.Value = "Customers";
            listItems.Add(listItem);
            listItem = new ListItem();
            listItem.Text = "Parts";
            listItem.Value = "Parts";
            listItems.Add(listItem);
            listItem = new ListItem();
            listItem.Text = "Plant View";
            listItem.Value = "PlantView";
            listItems.Add(listItem);
            return listItems;
        }
        private List<ListItem> getCellViewList()
        {
            List<ListItem> listItems = new List<ListItem>();
            ListItem listItem = new ListItem();
            listItem.Text = "Groups";
            listItem.Value = "Groups";
            listItems.Add(listItem);
            listItem = new ListItem();
            listItem.Text = "Operators";
            listItem.Value = "Operators";
            listItems.Add(listItem);
            listItem = new ListItem();
            listItem.Text = "Parts";
            listItem.Value = "Parts";
            listItems.Add(listItem);
            listItem = new ListItem();
            listItem.Text = "Supervisor";
            listItem.Value = "Supervisor";
            listItems.Add(listItem);
            listItem = new ListItem();
            listItem.Text = "Cell View";
            listItem.Value = "CellView";
            listItems.Add(listItem);
            return listItems;
        }
        private List<ListItem> getMachineViewList()
        {
            List<ListItem> listItems = new List<ListItem>();
            ListItem listItem = new ListItem();
            listItem.Text = "Operators";
            listItem.Value = "Operators";
            listItems.Add(listItem);
            listItem = new ListItem();
            listItem.Text = "Parts";
            listItem.Value = "Parts";
            listItems.Add(listItem);
            listItem = new ListItem();
            listItem.Text = "Machine View";
            listItem.Value = "MachineView";
            listItems.Add(listItem);
            return listItems;
        }

        protected void lvContext_SelectedIndexChanged(object sender, EventArgs e)
        {
            string contextName = (lvContext.Items[lvContext.SelectedIndex].FindControl("ContextNameForReference") as HiddenField).Value;
            hfselectedContext.Value = contextName;
            Label lbl = (Label)Page.Master.FindControl("lblShowSelectedItems");
            lbl.Text = hfselectedContext.Value;
            bindData("","","","","","");
           // bindContextList();
        }

        protected void lvContext_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            //if (e.Item.ItemType == DataControlCellType.DataCell)
            //{
            //    e.Item.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(lvContext, "Select$" + e.Item.DataItemIndex);
            //    e.Row.Attributes["style"] = "cursor:pointer";
            //}
        }

        protected void lvContext_SelectedIndexChanging(object sender, ListViewSelectEventArgs e)
        {
            int s = lvContext.SelectedIndex;
            var ss = e.NewSelectedIndex;
        }

        protected void lvPlantDashboard_ItemEditing(object sender, ListViewEditEventArgs e)
        {
            try
            {

                ListViewItem item = lvPlantDashboard.Items[e.NewEditIndex];
                string plantname = (item.FindControl("name") as LinkButton).Text;
                string companyName = (item.FindControl("hdnCompanyName") as HiddenField).Value;
                lbBack.Visible = true;
                hfselectedContext.Value = "CellView";
                hfMainView.Value = "CellView";
                string date;
                string frequency = getSelectedFrequency(out date);
                bindData(companyName, plantname, "", "", frequency, date);
                // bindContextList();
                setBackListItems("PlantView");

                //For back button operation
                List<DashboardLevelHistory> listLevelHistory = null;
                if (Session["DashboardLevelHistory"] != null)
                {
                    listLevelHistory = (List<DashboardLevelHistory>)Session["DashboardLevelHistory"];
                }
                else
                {
                    listLevelHistory = new List<DashboardLevelHistory>();
                }
                DashboardLevelHistory levelHistory = new DashboardLevelHistory();
                levelHistory.CompanyName = companyName;
                levelHistory.PlantName = plantname;
                levelHistory.CellName = "";
                levelHistory.MachineName = "";
                levelHistory.Frequency = frequency;
                levelHistory.Date = date;
                listLevelHistory.Add(levelHistory);
                Session["DashboardLevelHistory"] = listLevelHistory;
            }
            catch (Exception ex)
            {

            }
        }
        private string getSelectedFrequency(out string date)
        {
            string frequency = "";
            date = "";
            try
            {

                DateTime currentDate = DateTime.Now;
                if (filterToday.Checked)
                {
                    frequency = "Day";
                    date = (currentDate.Year-1) + "-" + currentDate.Month + "-" + currentDate.Day + "T00:00:00";
                }
                else if (filterCustomeDay.Checked)
                {
                    frequency = "Day";
                    date = (currentDate.Year-1) + "-" + currentDate.Month + "-" + txtCustomDay.Text + "T00:00:00";
                }
                else if (filterCurrentMonth.Checked)
                {
                    frequency = "Month";
                    date = (currentDate.Year-1) + "-" + currentDate.Month + "-01";
                }
                else if (filterCustomeMonth.Checked)
                {
                    frequency = "Month";
                    date = (currentDate.Year-1) + "-" + txtMonth.Text + "-01";
                }
                else if (filterCurrentYear.Checked)
                {
                    frequency = "Year";
                    date = currentDate.Year + "-01-01";
                }
                else if (filterCustomeYear.Checked)
                {
                    frequency = "Year";
                    date = txtYear.Text + "-01-01";
                }
                else
                {
                    frequency = "Day";
                    date = currentDate.Year + "-" + currentDate.Month + "-" + currentDate.Day + "T00:00:00";
                }
            }
            catch (Exception ex)
            {

            }
            return frequency;
        }
        protected void lvCellDashboard_ItemEditing(object sender, ListViewEditEventArgs e)
        {
            try
            {

                ListViewItem item = lvCellDashboard.Items[e.NewEditIndex];
                string cellName = (item.FindControl("name") as LinkButton).Text;
                string companyName = (item.FindControl("hdnCompanyName") as HiddenField).Value;
                string plantName = (item.FindControl("hdnPlantName") as HiddenField).Value;
                string date;
                string frequency = getSelectedFrequency(out date);
                lbBack.Visible = true;
                hfselectedContext.Value = "MachineView";
                hfMainView.Value = "MachineView";
                bindData(companyName, plantName, cellName, "", frequency, date);
                // bindContextList();
                setBackListItems("CellView");

                //For back button operation
                List<DashboardLevelHistory> listLevelHistory = null;
                if (Session["DashboardLevelHistory"] != null)
                {
                    listLevelHistory = (List<DashboardLevelHistory>)Session["DashboardLevelHistory"];
                }
                else
                {
                    listLevelHistory = new List<DashboardLevelHistory>();
                }
                DashboardLevelHistory levelHistory = new DashboardLevelHistory();
                levelHistory.CompanyName = companyName;
                levelHistory.PlantName = plantName;
                levelHistory.CellName = cellName;
                levelHistory.MachineName = "";
                levelHistory.Frequency = frequency;
                levelHistory.Date = date;
                listLevelHistory.Add(levelHistory);
                Session["DashboardLevelHistory"] = listLevelHistory;
            }
            catch (Exception ex)
            {

            }
        }

        protected void lvCompanyDashboard_ItemEditing(object sender, ListViewEditEventArgs e)
        {
            lbBack.Visible = true;
            hfselectedContext.Value = "PlantView";
            hfMainView.Value = "PlantView";
            string date;
            string frequency = getSelectedFrequency(out date);
            bindData("Bosch","","","",frequency,date);
            //bindContextList();
            setBackListItems("CompanyView");

            //For back button operation
            List<DashboardLevelHistory> listLevelHistory = new List<DashboardLevelHistory>();
            Session["DashboardLevelHistory"] = null;
            DashboardLevelHistory levelHistory = new DashboardLevelHistory();
            levelHistory.CompanyName = "Bosch";
            levelHistory.PlantName = "";
            levelHistory.CellName = "";
            levelHistory.MachineName = "";
            levelHistory.Frequency = frequency;
            levelHistory.Date = date;
            listLevelHistory.Add(levelHistory);
            Session["DashboardLevelHistory"] = listLevelHistory;
        }
        private void setBackListItems(string view)
        {
            if (Session["BackList"] == null)
            {
                List<string> ls = new List<string>();
                if (ls.Contains(view))
                {

                }
                else
                {
                    ls.Add(view);
                    Session["BackList"] = ls;
                }

            }
            else
            {
                List<string> ls = (List<string>)Session["BackList"];
                if (ls.Contains(view))
                {

                }
                else
                {
                    ls.Add(view);
                    Session["BackList"] = ls;
                }
            }
        }
        protected void lbBack_Click(object sender, EventArgs e)
        {
            gotoBack();
        }
        private void gotoBack()
        {
            try
            {
               
                if (Session["BackList"] != null && Session["DashboardLevelHistory"] != null)
                {
                    List<string> listOfView = (List<string>)Session["BackList"];
                    List<DashboardLevelHistory> listLevelHistory = (List<DashboardLevelHistory>)Session["DashboardLevelHistory"];
                    if (listOfView.Count > 0)
                    {
                        lbBack.Visible = true;
                        hfselectedContext.Value = listOfView[listOfView.Count - 1].ToString();
                        hfMainView.Value = listOfView[listOfView.Count - 1].ToString();
                        listOfView.RemoveAt(listOfView.Count - 1);
                        Session["BackList"] = listOfView;
                       
                        if (listLevelHistory.Count > 0)
                        {
                            string companyName = listLevelHistory[listLevelHistory.Count - 1].CompanyName;
                            string plantName = listLevelHistory[listLevelHistory.Count - 1].PlantName;
                            string cellName = listLevelHistory[listLevelHistory.Count - 1].CellName;
                            string machineName = listLevelHistory[listLevelHistory.Count - 1].MachineName;
                            string frequency = listLevelHistory[listLevelHistory.Count - 1].Frequency;
                            string date = listLevelHistory[listLevelHistory.Count - 1].Date;
                            bindData(companyName, plantName,cellName, machineName, frequency, date);
                            listLevelHistory.RemoveAt(listLevelHistory.Count - 1);
                            Session["DashboardLevelHistory"] = listLevelHistory;
                        }
                      
                       // bindContextList();
                    }
                    else
                    {
                        Session["BackList"] = null;
                        lbBack.Visible = false;
                        Session["DashboardLevelHistory"] = null;
                    }
                    if (listOfView.Count == 0 || listLevelHistory.Count==0)
                    {
                        Session["BackList"] = null;
                        lbBack.Visible = false;
                        Session["DashboardLevelHistory"] = null;
                    }
                }
            }
            catch (Exception ex)
            {

            }

        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static ChartData1 getChartData()
        {
            ChartData1 chartData1 = new ChartData1();
            chartData1 = getChartData1();
            return chartData1;
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static ChartData1 getzoomChartData(double xvalue, double yvalue)
        {
            ChartData1 chartData = new ChartData1();
            try
            {
                List<ChartData> chartDatasList = (List<ChartData>)HttpContext.Current.Session["ChartData"];

                try
                {
                    string[] data = new string[chartDatasList.Count];
                    double[] datad = null;
                    List<Type> typeList = new List<Type>();
                    List<Plotline> plotlinesList = new List<Plotline>();
                    Type type = null;
                    Plotline plotline = null;

                    List<double[]> DataListData = new List<double[]>();
                    for (int i = 0; i < chartDatasList.Count; i++)
                    {
                        bool exists = false;
                        if (double.Parse(chartDatasList[i].Value) == yvalue && (double)(chartDatasList[i].Time - new DateTime(1970, 1, 1, 0, 0, 0)).TotalMilliseconds == xvalue)
                        {
                            int k = 0;
                            for (int j = i; j < 7; j++)
                            {
                                datad = new double[2];
                                datad[1] = double.Parse(chartDatasList[j].Value);
                                //data[1] = (double) chartDatasList[i].Value;
                                datad[0] = (double)(chartDatasList[j].Time - new DateTime(1970, 1, 1, 0, 0, 0)).TotalMilliseconds;
                                //data[i] = chartDatasList[i].Time;
                                DataListData.Add(datad);
                                if (chartDatasList[j].ParameterID == "P13")
                                {
                                    type = new Type();
                                    type.x = (double)(chartDatasList[j].Time - new DateTime(1970, 1, 1, 0, 0, 0)).TotalMilliseconds;
                                    type.text = "Cycle Start";
                                    type.title = "Cycle Start";
                                    List<Styles> styles1 = new List<Styles>();
                                    Styles style1 = new Styles();
                                    style1.color = "green";
                                    styles1.Add(style1);
                                    type.style = styles1;
                                    typeList.Add(type);


                                    plotline = new Plotline();
                                    plotline.color = "green";
                                    plotline.value = (double)(chartDatasList[j].Time - new DateTime(1970, 1, 1, 0, 0, 0)).TotalMilliseconds;
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

                                if (chartDatasList[j].ParameterID == "P15")
                                {
                                    type = new Type();
                                    type.x = (double)(chartDatasList[j].Time - new DateTime(1970, 1, 1, 0, 0, 0)).TotalMilliseconds;
                                    type.text = "Grinding Start";
                                    type.title = "Grinding Start";
                                    List<Styles> styles1 = new List<Styles>();
                                    Styles style1 = new Styles();
                                    style1.color = "blue";
                                    styles1.Add(style1);
                                    type.style = styles1;
                                    typeList.Add(type);


                                    plotline = new Plotline();
                                    plotline.color = "blue";
                                    plotline.value = (double)(chartDatasList[j].Time - new DateTime(1970, 1, 1, 0, 0, 0)).TotalMilliseconds;
                                    plotline.width = 3;
                                    List<XLabel> labels = new List<XLabel>();
                                    XLabel label = new XLabel();
                                    label.text = "Grinding Start";
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

                                if (chartDatasList[j].ParameterID == "P20")
                                {
                                    type = new Type();
                                    type.x = (double)(chartDatasList[j].Time - new DateTime(1970, 1, 1, 0, 0, 0)).TotalMilliseconds;
                                    type.text = "Roughing End";
                                    type.title = "Roughing End";
                                    List<Styles> styles1 = new List<Styles>();
                                    Styles style1 = new Styles();
                                    style1.color = "pink";
                                    styles1.Add(style1);
                                    type.style = styles1;
                                    typeList.Add(type);


                                    plotline = new Plotline();
                                    plotline.color = "pink";
                                    plotline.value = (double)(chartDatasList[j].Time - new DateTime(1970, 1, 1, 0, 0, 0)).TotalMilliseconds;
                                    plotline.width = 3;
                                    List<XLabel> labels = new List<XLabel>();
                                    XLabel label = new XLabel();
                                    label.text = "Roughing End";
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

                                if (chartDatasList[j].ParameterID == "P21")
                                {
                                    type = new Type();
                                    type.x = (double)(chartDatasList[j].Time - new DateTime(1970, 1, 1, 0, 0, 0)).TotalMilliseconds;
                                    type.text = "Semi-finish End";
                                    type.title = "Semi-finish End";
                                    List<Styles> styles1 = new List<Styles>();
                                    Styles style1 = new Styles();
                                    style1.color = "aqua";
                                    styles1.Add(style1);
                                    type.style = styles1;
                                    typeList.Add(type);


                                    plotline = new Plotline();
                                    plotline.color = "aqua";
                                    plotline.value = (double)(chartDatasList[j].Time - new DateTime(1970, 1, 1, 0, 0, 0)).TotalMilliseconds;
                                    plotline.width = 3;
                                    List<XLabel> labels = new List<XLabel>();
                                    XLabel label = new XLabel();
                                    label.text = "Semi-finish End";
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

                                if (chartDatasList[j].ParameterID == "P22")
                                {
                                    type = new Type();
                                    type.x = (double)(chartDatasList[j].Time - new DateTime(1970, 1, 1, 0, 0, 0)).TotalMilliseconds;
                                    type.text = "Finish End";
                                    type.title = "Finish End";
                                    List<Styles> styles1 = new List<Styles>();
                                    Styles style1 = new Styles();
                                    style1.color = "blueviolet";
                                    styles1.Add(style1);
                                    type.style = styles1;
                                    typeList.Add(type);


                                    plotline = new Plotline();
                                    plotline.color = "blueviolet";
                                    plotline.value = (double)(chartDatasList[j].Time - new DateTime(1970, 1, 1, 0, 0, 0)).TotalMilliseconds;
                                    plotline.width = 3;
                                    List<XLabel> labels = new List<XLabel>();
                                    XLabel label = new XLabel();
                                    label.text = "Finish End";
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

                                if (chartDatasList[j].ParameterID == "P16")
                                {
                                    type = new Type();
                                    type.x = (double)(chartDatasList[j].Time - new DateTime(1970, 1, 1, 0, 0, 0)).TotalMilliseconds;
                                    type.text = "Grinding End";
                                    type.title = "Grinding End";
                                    List<Styles> styles1 = new List<Styles>();
                                    Styles style1 = new Styles();
                                    style1.color = "blue";
                                    styles1.Add(style1);
                                    type.style = styles1;
                                    typeList.Add(type);


                                    plotline = new Plotline();
                                    plotline.color = "blue";
                                    plotline.value = (double)(chartDatasList[j].Time - new DateTime(1970, 1, 1, 0, 0, 0)).TotalMilliseconds;
                                    plotline.width = 3;
                                    List<XLabel> labels = new List<XLabel>();
                                    XLabel label = new XLabel();
                                    label.text = "Grinding End";
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
                                if (chartDatasList[j].ParameterID == "P14")
                                {
                                    type = new Type();
                                    type.x = (double)(chartDatasList[j].Time - new DateTime(1970, 1, 1, 0, 0, 0)).TotalMilliseconds;
                                    type.text = "Cycle End";
                                    type.title = "Cycle End";
                                    typeList.Add(type);


                                    plotline = new Plotline();
                                    plotline.color = "red";
                                    plotline.value = (double)(chartDatasList[j].Time - new DateTime(1970, 1, 1, 0, 0, 0)).TotalMilliseconds;
                                    plotline.width = 3;
                                    List<XLabel> labels = new List<XLabel>();
                                    XLabel label = new XLabel();
                                    label.text = "Cycle End";
                                    label.rotation = 90;

                                    List<Styles> styles = new List<Styles>();
                                    Styles style = new Styles();
                                    style.color = "white";
                                    styles.Add(style);
                                    label.style = styles;

                                    labels.Add(label);
                                    plotline.label = labels;
                                    plotlinesList.Add(plotline);

                                    break;
                                }
                            }
                            chartData.data = DataListData;
                            chartData.type = typeList;
                            chartData.plotLines = plotlinesList;
                            exists = true;
                        }
                        if (exists)
                        {
                            break;
                        }
                    }

                }
                catch (Exception ex)
                {

                }
            }
            catch (Exception ex)
            {

            }
            return chartData;
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static YearChartData getYearChartData(string view, string param, string dateforYear)
        {
            YearChartData yearChartData = new YearChartData();
            try
            {
                ProductionOEEDashboard productionOEEDashboard = new ProductionOEEDashboard();
                List<LevelDashboardData> contextListDetails = new List<LevelDashboardData>();
                if (view == "CompanyView")
                {
                   // contextListDetails = production1.getList("Company");
                }
                if (view == "PlantView")
                {
                    //contextListDetails = production1.getList("Plant");
                    //  contextListDetails = (List<LevelDashboardData>)HttpContext.Current.Session["PlantViewData"];
                    List<DashboardLevelHistory> listLevelHistory = null;
                    if (HttpContext.Current.Session["DashboardLevelHistory"] != null)
                    {
                        listLevelHistory = (List<DashboardLevelHistory>)HttpContext.Current.Session["DashboardLevelHistory"];
                    }
                    else
                    {
                        listLevelHistory = new List<DashboardLevelHistory>();
                    }
                    string date = listLevelHistory[listLevelHistory.Count - 1].Date;
                    if (date.Contains("T"))
                    {

                    }
                    else
                    {
                        date = date + "T00:00:00";
                    }
                    //contextListDetails = getPlantMonthDayGridData(listLevelHistory[listLevelHistory.Count - 1].CompanyName, listLevelHistory[listLevelHistory.Count - 1].PlantName, "Day", date);
                    contextListDetails = productionOEEDashboard.BindPlantData(listLevelHistory[listLevelHistory.Count - 1].CompanyName, listLevelHistory[listLevelHistory.Count - 1].PlantName, "Year", dateforYear);

                }
                if (view == "CellView")
                {
                    // contextListDetails = production1.getList("Cell");
                    // contextListDetails = (List<LevelDashboardData>)HttpContext.Current.Session["CellViewData"];
                    List<DashboardLevelHistory> listLevelHistory = null;
                    if (HttpContext.Current.Session["DashboardLevelHistory"] != null)
                    {
                        listLevelHistory = (List<DashboardLevelHistory>)HttpContext.Current.Session["DashboardLevelHistory"];
                    }
                    else
                    {
                        listLevelHistory = new List<DashboardLevelHistory>();
                    }
                   
                    contextListDetails = productionOEEDashboard.BindCellData(listLevelHistory[listLevelHistory.Count - 1].CompanyName, listLevelHistory[listLevelHistory.Count - 1].PlantName, "Year", dateforYear);

                }
                if (view == "MachineView")
                {
                    // contextListDetails = production1.getList("Machine");
                    // contextListDetails = (List<LevelDashboardData>)HttpContext.Current.Session["MachineViewData"];
                    List<DashboardLevelHistory> listLevelHistory = null;
                    if (HttpContext.Current.Session["DashboardLevelHistory"] != null)
                    {
                        listLevelHistory = (List<DashboardLevelHistory>)HttpContext.Current.Session["DashboardLevelHistory"];
                    }
                    else
                    {
                        listLevelHistory = new List<DashboardLevelHistory>();
                    }

                    contextListDetails = productionOEEDashboard.BindMachineData(listLevelHistory[listLevelHistory.Count - 1].CompanyName, listLevelHistory[listLevelHistory.Count - 1].PlantName, listLevelHistory[listLevelHistory.Count - 1].CellName,  "Year", dateforYear);

                }
                List<double[]> yAxisDataSet = new List<double[]>();
                List<string[]> xAxisDataSet = new List<string[]>();
                string[] xAxisData = null;
                double[] yAxisData = null;
                for (int i = 0; i < contextListDetails.Count; i++)
                {
                    xAxisData = new string[1];
                    xAxisData[0] = contextListDetails[i].Description;
                    yAxisData = new double[1];
                    if (param == "AvgOEE")
                    {
                        yAxisData[0] = Convert.ToDouble(contextListDetails[i].OEE);
                    }
                    else
                    if (param == "QualityRate")
                    {
                        yAxisData[0] = Convert.ToDouble(contextListDetails[i].QualityRate);
                    }
                    else
                    if (param == "Revenue")
                    {
                        yAxisData[0] = Convert.ToDouble(contextListDetails[i].Revenue.Replace(",",""));
                    }
                    else
                    if (param == "LossINR")
                    {
                        string[] value = contextListDetails[i].LossINR.Split(':');
                        yAxisData[0] = ((Convert.ToInt16(value[0])*60)+ Convert.ToInt16(value[1]));
                    }
                    else
                    if (param == "Attendance")
                    {
                        yAxisData[0] = Convert.ToDouble(contextListDetails[i].Attendance);
                    }
                    else
                    if (param == "SafetyKPI")
                    {
                        yAxisData[0] = Convert.ToDouble(contextListDetails[i].SafetyKPI);
                    }
                    else
                    if (param == "AEEfficiency")
                    {
                        yAxisData[0] = Convert.ToDouble(contextListDetails[i].AEffy);
                    }
                    else
                    if (param == "PEEfficiency")
                    {
                        yAxisData[0] = Convert.ToDouble(contextListDetails[i].PEffy);
                    }
                    else
                    if (param == "QEEfficiency")
                    {
                        yAxisData[0] = Convert.ToDouble(contextListDetails[i].QEffy);
                    }
                    else
                    if (param == "PartCount")
                    {
                        yAxisData[0] = Convert.ToDouble(contextListDetails[i].AcceptedPart);
                    }
                    else
                    if (param == "Rejection")
                    {
                        yAxisData[0] = Convert.ToDouble(contextListDetails[i].RejectCount);
                    }
                    else
                    {
                        yAxisData[0] = Convert.ToDouble(contextListDetails[i].OEE);
                    }

                    xAxisDataSet.Add(xAxisData);
                    yAxisDataSet.Add(yAxisData);
                }
                yearChartData.xAxis = xAxisDataSet;
                yearChartData.yAxis = yAxisDataSet;

            }
            catch (Exception ex)
            {

            }
            return yearChartData;
        }

     
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<LevelDashboardData> getMonthChartData(string view, string month, string selectedMonth, string dateformonth)
        {
            YearChartData yearChartData = new YearChartData();
            List<LevelDashboardData> finalDataSet = new List<LevelDashboardData>();
            LevelDashboardData data = null;
            try
            {
                ProductionOEEDashboard production1 = new ProductionOEEDashboard();
                List<LevelDashboardData> contextListDetails = new List<LevelDashboardData>();

                ProductionOEEDashboard productionOEEDashboard = new ProductionOEEDashboard();
                if (view == "CompanyView")
                {
                    // contextListDetails = production1.getList("Company");
                }
                if (view == "PlantView")
                {
                    //contextListDetails = production1.getList("Plant");
                    //  contextListDetails = (List<LevelDashboardData>)HttpContext.Current.Session["PlantViewData"];
                    //if (HttpContext.Current.Session["PlantViewMonthData"] == null)
                    //{
             
                        List<DashboardLevelHistory> listLevelHistory = null;
                        if (HttpContext.Current.Session["DashboardLevelHistory"] != null)
                        {
                            listLevelHistory = (List<DashboardLevelHistory>)HttpContext.Current.Session["DashboardLevelHistory"];
                        }
                        else
                        {
                            listLevelHistory = new List<DashboardLevelHistory>();
                        }
                      //  string[] dateForMonth = listLevelHistory[listLevelHistory.Count - 1].Date.Replace("T00:00:00", "").Split('-');
                        contextListDetails = productionOEEDashboard.BindPlantData(listLevelHistory[listLevelHistory.Count-1].CompanyName, listLevelHistory[listLevelHistory.Count-1].PlantName, "Month",dateformonth);
                    //}
                    //else
                    //{
                    //    contextListDetails = (List<LevelDashboardData>)HttpContext.Current.Session["PlantViewMonthData"];
                    //}
                    

                }
                if (view == "CellView")
                {
                    //if (HttpContext.Current.Session["CellViewMonthData"] == null)
                    //{

                        List<DashboardLevelHistory> listLevelHistory = null;
                        if (HttpContext.Current.Session["DashboardLevelHistory"] != null)
                        {
                            listLevelHistory = (List<DashboardLevelHistory>)HttpContext.Current.Session["DashboardLevelHistory"];
                        }
                        else
                        {
                            listLevelHistory = new List<DashboardLevelHistory>();
                        }
                    // string[] dateForMonth = listLevelHistory[listLevelHistory.Count - 1].Date.Replace("T00:00:00", "").Split('-');
                    //contextListDetails = getCellMonthDayGridData(listLevelHistory[listLevelHistory.Count - 1].CompanyName, listLevelHistory[listLevelHistory.Count - 1].PlantName, "Month", dateForMonth[0] + "-" + dateForMonth[1] + "-01");
                    contextListDetails = productionOEEDashboard.BindCellData(listLevelHistory[listLevelHistory.Count - 1].CompanyName, listLevelHistory[listLevelHistory.Count - 1].PlantName, "Month", dateformonth);
                    //}
                    //else
                    //{
                    //    contextListDetails = (List<LevelDashboardData>)HttpContext.Current.Session["CellViewMonthData"];
                    //}


                }
                if (view == "MachineView")
                {
                    // contextListDetails = production1.getList("Machine");
                    // contextListDetails = (List<LevelDashboardData>)HttpContext.Current.Session["MachineViewData"];
                    //if (HttpContext.Current.Session["MachineViewMonthData"] == null)
                    //{

                        List<DashboardLevelHistory> listLevelHistory = null;
                        if (HttpContext.Current.Session["DashboardLevelHistory"] != null)
                        {
                            listLevelHistory = (List<DashboardLevelHistory>)HttpContext.Current.Session["DashboardLevelHistory"];
                        }
                        else
                        {
                            listLevelHistory = new List<DashboardLevelHistory>();
                        }
                       // string[] dateForMonth = listLevelHistory[listLevelHistory.Count - 1].Date.Replace("T00:00:00", "").Split('-');
                    //contextListDetails = getMachineMonthDayGridData(listLevelHistory[listLevelHistory.Count - 1].CompanyName, listLevelHistory[listLevelHistory.Count - 1].PlantName, listLevelHistory[listLevelHistory.Count - 1].CellName, "Month", dateForMonth[0] + "-" + dateForMonth[1] + "-01");
                    contextListDetails = productionOEEDashboard.BindMachineData(listLevelHistory[listLevelHistory.Count - 1].CompanyName, listLevelHistory[listLevelHistory.Count - 1].PlantName, listLevelHistory[listLevelHistory.Count - 1].CellName, "Month",dateformonth);
                    //}
                    //else
                    //{
                    //    contextListDetails = (List<LevelDashboardData>)HttpContext.Current.Session["MachineViewMonthData"];
                    //}
                }
                
                for (int i = 0; i < contextListDetails.Count; i++)
                {
                    //string s = Util.GetDateTime(contextListDetails[i].pDate).Month.ToString("00");
                    //if (Util.GetDateTime(contextListDetails[i].pDate).Month.ToString("00") == selectedMonth)
                    //{
                        data = new LevelDashboardData();
                        data.Month = month;
                        data.Description = contextListDetails[i].Description;
                        data.OEE = contextListDetails[i].OEE;
                        data.AEffy = contextListDetails[i].AEffy;
                        data.QEffy = contextListDetails[i].QEffy;
                        data.PEffy = contextListDetails[i].PEffy;
                        data.QualityRate = contextListDetails[i].QualityRate;
                        data.Revenue = contextListDetails[i].Revenue;
                        data.LossINR = contextListDetails[i].LossINR;
                        data.Attendance = contextListDetails[i].Attendance;
                        data.SafetyKPI = contextListDetails[i].SafetyKPI;
                        data.AcceptedPart = contextListDetails[i].AcceptedPart;
                        data.RejectCount = contextListDetails[i].RejectCount;
                        finalDataSet.Add(data);
                  //  }
                   
                }
            }
            catch (Exception ex)
            {

            }
            return finalDataSet;
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string getMonthChartDetails(string view, string month, string param, string selectedRows, string selectedMonth)
        {
            string datatable = "";
            try
            {
                ProductionOEEDashboard production1 = new ProductionOEEDashboard();
                List<LevelDashboardData> contextListDetails = new List<LevelDashboardData>();
                if (view == "CompanyView")
                {
                    // contextListDetails = production1.getList("Company");
                }
                if (view == "PlantView")
                {
                   
                    if (HttpContext.Current.Session["PlantViewMonthData"] == null)
                    {
                        contextListDetails = (List<LevelDashboardData>)HttpContext.Current.Session["PlantViewMonthData"];
                    }
                    else
                    {
                        List<DashboardLevelHistory> listLevelHistory = null;
                        if (HttpContext.Current.Session["DashboardLevelHistory"] != null)
                        {
                            listLevelHistory = (List<DashboardLevelHistory>)HttpContext.Current.Session["DashboardLevelHistory"];
                        }
                        else
                        {
                            listLevelHistory = new List<DashboardLevelHistory>();
                        }
                        contextListDetails = getPlantMonthDayGridData(listLevelHistory[listLevelHistory.Count].CompanyName, listLevelHistory[listLevelHistory.Count].PlantName, "Month", listLevelHistory[listLevelHistory.Count].Date);
                    }
                }
                if (view == "CellView")
                {
                    // contextListDetails = production1.getList("Cell");
                    contextListDetails = (List<LevelDashboardData>)HttpContext.Current.Session["CellViewData"];

                }
                if (view == "MachineView")
                {
                    // contextListDetails = production1.getList("Machine");
                    contextListDetails = (List<LevelDashboardData>)HttpContext.Current.Session["MachineViewData"];
                }
                string headerRow = "<table id='datatable'><tr><th></th>";
                string valueRow = "<tr><th>"+month+"</th>";
                for (int i = 0; i < contextListDetails.Count; i++)
                {
                    if (selectedRows.Contains(contextListDetails[i].Description))
                    {
                        headerRow += "<th>" + contextListDetails[i].Description + "</th>";
                        if (param == "AvgOEE")
                        {
                            valueRow += "<td>" + Convert.ToDouble(contextListDetails[i].OEE) + "</td>";
                        }
                        else
                   if (param == "QualityRate")
                        {
                            valueRow += "<td>" + Convert.ToDouble(contextListDetails[i].QualityRate) + "</td>";
                        }
                        else
                   if (param == "Revenue")
                        {
                            valueRow += "<td>" + Convert.ToDouble(contextListDetails[i].Revenue) + "</td>";
                        }
                        else
                   if (param == "LossINR")
                        {
                            valueRow += "<td>" + Convert.ToDouble(contextListDetails[i].LossINR) + "</td>";
                        }
                        else if (param == "Attendance")
                        {
                            valueRow += "<td>" + Convert.ToDouble(contextListDetails[i].Attendance) + "</td>";
                        }
                        else
             if (param == "SafetyKPI")
                        {
                            valueRow += "<td>" + Convert.ToDouble(contextListDetails[i].SafetyKPI) + "</td>";
                        }
                        else
             if (param == "AEEfficiency")
                        {
                            valueRow += "<td>" + Convert.ToDouble(contextListDetails[i].AEffy) + "</td>";
                        }
                        else
             if (param == "PEEfficiency")
                        {
                            valueRow += "<td>" + Convert.ToDouble(contextListDetails[i].PEffy) + "</td>";
                        }
                        else
             if (param == "QEEfficiency")
                        {
                            valueRow += "<td>" + Convert.ToDouble(contextListDetails[i].QEffy) + "</td>";
                        }
                        else
             if (param == "PartCount")
                        {
                            valueRow += "<td>" + Convert.ToDouble(contextListDetails[i].AcceptedPart) + "</td>";
                        }
                        else
             if (param == "Rejection")
                        {
                            valueRow += "<td>" + Convert.ToDouble(contextListDetails[i].RejectCount) + "</td>";
                        }
                        else
                        {
                            valueRow += "<td>" + Convert.ToDouble(contextListDetails[i].OEE) + "</td>";
                        }
                    }
                }
                headerRow += "</tr>";
                valueRow += "</tr>";
                datatable = headerRow + valueRow + "</table>";
            }
            catch (Exception ex)
            {

            }
            return datatable;
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string getDayChartDetails(string view, string month,string day, string param, string selectedRows)
        {
            string datatable = "";
            try
            {
                ProductionOEEDashboard production1 = new ProductionOEEDashboard();
                List<LevelDashboardData> contextListDetails = new List<LevelDashboardData>();
                if (view == "CompanyView")
                {
                    // contextListDetails = production1.getList("Company");
                }
                if (view == "PlantView")
                {
                    //contextListDetails = production1.getList("Plant");
                    contextListDetails = (List<LevelDashboardData>)HttpContext.Current.Session["PlantViewData"];

                }
                if (view == "CellView")
                {
                    // contextListDetails = production1.getList("Cell");
                    contextListDetails = (List<LevelDashboardData>)HttpContext.Current.Session["CellViewData"];

                }
                if (view == "MachineView")
                {
                    // contextListDetails = production1.getList("Machine");
                    contextListDetails = (List<LevelDashboardData>)HttpContext.Current.Session["MachineViewData"];
                }
                string headerRow = "<table id='daydatatable'><tr><th></th>";
                string valueRow = "<tr><th>" + day + "</th>";
                for (int i = 0; i < contextListDetails.Count; i++)
                {
                    if (selectedRows.Contains(contextListDetails[i].Description))
                    {
                        headerRow += "<th>" + contextListDetails[i].Description + "</th>";
                        if (param == "AvgOEE")
                        {
                            valueRow += "<td>" + Convert.ToDouble(contextListDetails[i].OEE) + "</td>";
                        }
                        else
                   if (param == "QualityRate")
                        {
                            valueRow += "<td>" + Convert.ToDouble(contextListDetails[i].QualityRate) + "</td>";
                        }
                        else
                   if (param == "Revenue")
                        {
                            valueRow += "<td>" + Convert.ToDouble(contextListDetails[i].Revenue) + "</td>";
                        }
                        else
                   if (param == "LossINR")
                        {
                            valueRow += "<td>" + Convert.ToDouble(contextListDetails[i].LossINR) + "</td>";
                        }
                        else if (param == "Attendance")
                        {
                            valueRow += "<td>" + Convert.ToDouble(contextListDetails[i].Attendance) + "</td>";
                        }
                        else
             if (param == "SafetyKPI")
                        {
                            valueRow += "<td>" + Convert.ToDouble(contextListDetails[i].SafetyKPI) + "</td>";
                        }
                        else
             if (param == "AEEfficiency")
                        {
                            valueRow += "<td>" + Convert.ToDouble(contextListDetails[i].AEffy) + "</td>";
                        }
                        else
             if (param == "PEEfficiency")
                        {
                            valueRow += "<td>" + Convert.ToDouble(contextListDetails[i].PEffy) + "</td>";
                        }
                        else
             if (param == "QEEfficiency")
                        {
                            valueRow += "<td>" + Convert.ToDouble(contextListDetails[i].QEffy) + "</td>";
                        }
                        else
             if (param == "PartCount")
                        {
                            valueRow += "<td>" + Convert.ToDouble(contextListDetails[i].AcceptedPart) + "</td>";
                        }
                        else
             if (param == "Rejection")
                        {
                            valueRow += "<td>" + Convert.ToDouble(contextListDetails[i].RejectCount) + "</td>";
                        }
                        else
                        {
                            valueRow += "<td>" + Convert.ToDouble(contextListDetails[i].OEE) + "</td>";
                        }
                    }
                }
                headerRow += "</tr>";
                valueRow += "</tr>";
                datatable = headerRow + valueRow + "</table>";
            }
            catch (Exception ex)
            {

            }
            return datatable;
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<LevelDashboardData> getDayChartData(string view, string month, string selectedDayMenu, string selectedMonth, string dateforday)
        {
            YearChartData yearChartData = new YearChartData();
            List<LevelDashboardData> finalcontextListDetails = new List<LevelDashboardData>();
            LevelDashboardData contextListDetail = null;
            try
            {
                ProductionOEEDashboard productionOEEDashboard = new ProductionOEEDashboard();
                List<LevelDashboardData> contextListDetails = new List<LevelDashboardData>();
                if (view == "CompanyView")
                {
                    // contextListDetails = production1.getList("Company");
                }
                if (view == "PlantView")
                {
                    //contextListDetails = production1.getList("Plant");
                    // contextListDetails = (List<LevelDashboardData>)HttpContext.Current.Session["PlantViewData"];
                    //if (HttpContext.Current.Session["PlantViewDayData"] == null)
                    //{

                        List<DashboardLevelHistory> listLevelHistory = null;
                        if (HttpContext.Current.Session["DashboardLevelHistory"] != null)
                        {
                            listLevelHistory = (List<DashboardLevelHistory>)HttpContext.Current.Session["DashboardLevelHistory"];
                        }
                        else
                        {
                            listLevelHistory = new List<DashboardLevelHistory>();
                        }
                        string date = listLevelHistory[listLevelHistory.Count - 1].Date;
                        if (date.Contains("T"))
                        {

                        }
                        else
                        {
                            date = date + "T00:00:00";
                        }
                    //contextListDetails = getPlantMonthDayGridData(listLevelHistory[listLevelHistory.Count - 1].CompanyName, listLevelHistory[listLevelHistory.Count - 1].PlantName, "Day", date);
                    contextListDetails = productionOEEDashboard.BindPlantData(listLevelHistory[listLevelHistory.Count - 1].CompanyName, listLevelHistory[listLevelHistory.Count - 1].PlantName, "Day", dateforday);
                    //}
                    //else
                    //{
                    //    contextListDetails = (List<LevelDashboardData>)HttpContext.Current.Session["PlantViewDayData"];
                    //}

                }
                if (view == "CellView")
                {
                    //if (HttpContext.Current.Session["CellViewDayData"] == null)
                    //{

                        List<DashboardLevelHistory> listLevelHistory = null;
                        if (HttpContext.Current.Session["DashboardLevelHistory"] != null)
                        {
                            listLevelHistory = (List<DashboardLevelHistory>)HttpContext.Current.Session["DashboardLevelHistory"];
                        }
                        else
                        {
                            listLevelHistory = new List<DashboardLevelHistory>();
                        }
                        string date = listLevelHistory[listLevelHistory.Count - 1].Date;
                        if (date.Contains("T"))
                        {

                        }
                        else
                        {
                            date = date + "T00:00:00";
                        }
                    //contextListDetails = getCellMonthDayGridData(listLevelHistory[listLevelHistory.Count - 1].CompanyName, listLevelHistory[listLevelHistory.Count - 1].PlantName, "Day",date);
                    contextListDetails = productionOEEDashboard.BindCellData(listLevelHistory[listLevelHistory.Count - 1].CompanyName, listLevelHistory[listLevelHistory.Count - 1].PlantName, "Day", dateforday);
                    //}
                    //else
                    //{
                    //    contextListDetails = (List<LevelDashboardData>)HttpContext.Current.Session["CellViewDayData"];
                    //}


                }
                if (view == "MachineView")
                {
                    //if (HttpContext.Current.Session["MachineViewDayData"] == null)
                    //{

                        List<DashboardLevelHistory> listLevelHistory = null;
                        if (HttpContext.Current.Session["DashboardLevelHistory"] != null)
                        {
                            listLevelHistory = (List<DashboardLevelHistory>)HttpContext.Current.Session["DashboardLevelHistory"];
                        }
                        else
                        {
                            listLevelHistory = new List<DashboardLevelHistory>();
                        }
                        string date = listLevelHistory[listLevelHistory.Count - 1].Date;
                        if (date.Contains("T"))
                        {
                         
                        }
                        else
                        {
                            date = date + "T00:00:00";
                        }
                    //contextListDetails = getMachineMonthDayGridData(listLevelHistory[listLevelHistory.Count - 1].CompanyName, listLevelHistory[listLevelHistory.Count - 1].PlantName, listLevelHistory[listLevelHistory.Count - 1].CellName, "Day",date );
                    contextListDetails = productionOEEDashboard.BindMachineData(listLevelHistory[listLevelHistory.Count - 1].CompanyName, listLevelHistory[listLevelHistory.Count - 1].PlantName, listLevelHistory[listLevelHistory.Count - 1].CellName, "Day", dateforday);
                    //}
                    //else
                    //{
                    //    contextListDetails = (List<LevelDashboardData>)HttpContext.Current.Session["MachineViewDayData"];
                    //}
                }
                for (int i = 0; i < contextListDetails.Count; i++)
                {
                   
                    //if (Util.GetDateTime(contextListDetails[i].pDate).Month.ToString("00") == selectedMonth && Util.GetDateTime(contextListDetails[i].pDate).Day.ToString("00") == selectedDayMenu)
                    //{
                        contextListDetail = new LevelDashboardData();
                        contextListDetail.Month = month;
                        contextListDetail.Description = contextListDetails[i].Description;
                        contextListDetail.OEE = contextListDetails[i].OEE;
                        contextListDetail.AEffy = contextListDetails[i].AEffy;
                        contextListDetail.QEffy = contextListDetails[i].QEffy;
                        contextListDetail.PEffy = contextListDetails[i].PEffy;
                        contextListDetail.QualityRate = contextListDetails[i].QualityRate;
                        contextListDetail.Revenue = contextListDetails[i].Revenue;
                        contextListDetail.LossINR = contextListDetails[i].LossINR;
                        contextListDetail.Attendance = contextListDetails[i].Attendance;
                        contextListDetail.SafetyKPI = contextListDetails[i].SafetyKPI;
                        contextListDetail.AcceptedPart = contextListDetails[i].AcceptedPart;
                        contextListDetail.RejectCount = contextListDetails[i].RejectCount;
                        finalcontextListDetails.Add(contextListDetail);
                    //}
                }
            }
            catch (Exception ex)
            {

            }
            return finalcontextListDetails;
        }
        static string conString = WebConfigurationManager.ConnectionStrings["ConString"].ToString();
        public static ChartData1 getChartData1()
        {
            List<ChartData> chartDatasList = new List<ChartData>();
            ChartData chartData = null;
            SqlDataReader sdr = null;
            string cmdStr = String.Format("SELECT IDD, MachineID, ParameterID, ParameterValue, UpdatedtimeStamp, Part, Opn, ProgramNo, Qualifier, Column1, Column2 FROM ProcessParameterTransaction_BajajIoT where ParameterID in ('P13', 'P15', 'P20', 'P21', 'P22', 'P16', 'P14') order by UpdatedtimeStamp");
            SqlConnection sqlConn = new SqlConnection(conString);
            sqlConn.Open();
            SqlCommand command = new SqlCommand(cmdStr, sqlConn);
            command.CommandType = System.Data.CommandType.Text;

            try
            {
                sdr = command.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        chartData = new ChartData();
                        DateTime dt = DateTime.Now;
                        //  dt = (DateTime)(chartDatasList[i].Time);
                        chartData.Time = (DateTime)(sdr["UpdatedtimeStamp"]);
                        chartData.ParameterID = sdr["ParameterID"].ToString();
                        chartData.Value = sdr["ParameterValue"].ToString();
                        //if (sdr["ParameterValue"].ToString() != "")
                        //{
                        //    chartData.Value = Convert.ToDouble(sdr["ParameterValue"]);
                        //}
                        //else
                        //{
                        //    chartData.Value = 0;
                        //}

                        chartDatasList.Add(chartData);
                    }
                }
            }
            catch (Exception ex)
            {
                //Logger.WriteErrorLog(ex.ToString());
            }
            finally
            {
                if (sqlConn != null)
                    sqlConn.Close();
            }
            HttpContext.Current.Session["ChartData"] = chartDatasList;
            ChartData1 chartData1 = new ChartData1();
            try
            {
                string[] data = new string[chartDatasList.Count];
                double[] datad = null;
                List<Type> typeList = new List<Type>();
                List<Plotline> plotlinesList = new List<Plotline>();
                Type type = null;
                Plotline plotline = null;

                List<double[]> DataListData = new List<double[]>();
                for (int i = 0; i < chartDatasList.Count; i++)
                {

                    datad = new double[2];
                    datad[1] = double.Parse(chartDatasList[i].Value);
                    //data[1] = (double) chartDatasList[i].Value;
                    datad[0] = (double)(chartDatasList[i].Time - new DateTime(1970, 1, 1, 0, 0, 0)).TotalMilliseconds;
                    //data[i] = chartDatasList[i].Time;
                    DataListData.Add(datad);
                    if (chartDatasList[i].ParameterID == "P13")
                    {
                        type = new Type();
                        type.x = (double)(chartDatasList[i].Time - new DateTime(1970, 1, 1, 0, 0, 0)).TotalMilliseconds;
                        type.text = "Cycle Start";
                        type.title = "Cycle Start";
                        List<Styles> styles1 = new List<Styles>();
                        Styles style1 = new Styles();
                        style1.color = "green";
                        styles1.Add(style1);
                        type.style = styles1;
                        typeList.Add(type);


                        plotline = new Plotline();
                        plotline.color = "green";
                        plotline.value = (double)(chartDatasList[i].Time - new DateTime(1970, 1, 1, 0, 0, 0)).TotalMilliseconds;
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

                    if (chartDatasList[i].ParameterID == "P14")
                    {
                        type = new Type();
                        type.x = (double)(chartDatasList[i].Time - new DateTime(1970, 1, 1, 0, 0, 0)).TotalMilliseconds;
                        type.text = "Cycle End";
                        type.title = "Cycle End";
                        typeList.Add(type);


                        plotline = new Plotline();
                        plotline.color = "red";
                        plotline.value = (double)(chartDatasList[i].Time - new DateTime(1970, 1, 1, 0, 0, 0)).TotalMilliseconds;
                        plotline.width = 3;
                        List<XLabel> labels = new List<XLabel>();
                        XLabel label = new XLabel();
                        label.text = "Cycle End";
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
                }
                chartData1.data = DataListData;
                chartData1.type = typeList;
                chartData1.plotLines = plotlinesList;
            }
            catch (Exception ex)
            {

            }


            return chartData1;
        }

        protected void lvCardViewPlantDashboard_ItemEditing(object sender, ListViewEditEventArgs e)
        {
            ListViewItem item = lvPlantDashboard.Items[e.NewEditIndex];
            string plantname = (item.FindControl("name") as LinkButton).Text;
            string companyName = (item.FindControl("hdnCompanyName") as HiddenField).Value;
            lbBack.Visible = true;
            hfselectedContext.Value = "CellView";
            hfMainView.Value = "CellView";
            string date;
            string frequency = getSelectedFrequency(out date);
            bindData(companyName, plantname, "", "", frequency, date);
           // bindContextList();
            setBackListItems("PlantView");

            //For back button operation
            List<DashboardLevelHistory> listLevelHistory = null;
            if (Session["DashboardLevelHistory"] != null)
            {
                listLevelHistory = (List<DashboardLevelHistory>)Session["DashboardLevelHistory"];
            }
            else
            {
                listLevelHistory = new List<DashboardLevelHistory>();
            }
            DashboardLevelHistory levelHistory = new DashboardLevelHistory();
            levelHistory.CompanyName = companyName;
            levelHistory.PlantName = plantname;
            levelHistory.CellName = "";
            levelHistory.MachineName = "";
            levelHistory.Frequency = frequency;
            levelHistory.Date = date;
            listLevelHistory.Add(levelHistory);
            Session["DashboardLevelHistory"] = listLevelHistory;
        }

        protected void lvCardViewCompanyDashboard_ItemEditing(object sender, ListViewEditEventArgs e)
        {
            lbBack.Visible = true;
            hfselectedContext.Value = "PlantView";
            hfMainView.Value = "PlantView";
            string date;
            string frequency = getSelectedFrequency(out date);
            bindData("Bosch", "", "", "", frequency, date);
           // bindContextList();
            setBackListItems("CompanyView");

            //For back button operation
            List<DashboardLevelHistory> listLevelHistory =  new List<DashboardLevelHistory>();
            Session["DashboardLevelHistory"] = null;
            DashboardLevelHistory levelHistory = new DashboardLevelHistory();
            levelHistory.CompanyName = "Bosch";
            levelHistory.PlantName = "";
            levelHistory.CellName = "";
            levelHistory.MachineName = "";
            levelHistory.Frequency = frequency;
            levelHistory.Date = date;
            listLevelHistory.Add(levelHistory);
            Session["DashboardLevelHistory"] = listLevelHistory;
        }

        protected void lvCardViewCellDashboard_ItemEditing(object sender, ListViewEditEventArgs e)
        {
            ListViewItem item = lvCellDashboard.Items[e.NewEditIndex];
            string cellName = (item.FindControl("name") as LinkButton).Text;
            string companyName = (item.FindControl("hdnCompanyName") as HiddenField).Value;
            string plantName = (item.FindControl("hdnPlantName") as HiddenField).Value;
            string date;
            string frequency = getSelectedFrequency(out date);
            lbBack.Visible = true;
            hfselectedContext.Value = "MachineView";
            hfMainView.Value = "MachineView";
            bindData(companyName, plantName, cellName, "", frequency, date);
            //bindContextList();
            setBackListItems("CellView");

            //For back button operation
            List<DashboardLevelHistory> listLevelHistory = null;
            if (Session["DashboardLevelHistory"] != null)
            {
                listLevelHistory = (List<DashboardLevelHistory>)Session["DashboardLevelHistory"];
            }
            else
            {
                listLevelHistory = new List<DashboardLevelHistory>();
            }
            DashboardLevelHistory levelHistory = new DashboardLevelHistory();
            levelHistory.CompanyName = companyName;
            levelHistory.PlantName = plantName;
            levelHistory.CellName = cellName;
            levelHistory.MachineName = "";
            levelHistory.Frequency = frequency;
            levelHistory.Date = date;
            listLevelHistory.Add(levelHistory);
            Session["DashboardLevelHistory"] = listLevelHistory;
        }

        protected void btnYearSearch_Click(object sender, EventArgs e)
        {
            try
            {
                List<string> ls = new List<string>();
                foreach(ListItem item in cblRowSelector.Items)
                {
                    if (item.Selected)
                    {
                        ls.Add(item.Text);
                    }
                }
                bindData("", "", "", "", "", "");
                //bindContextList();
                Label lbl = (Label)Page.Master.FindControl("lblShowSelectedItems");
               lbl.Text = lbl.Text + " - " + txtYear.Text;
                foreach (ListItem item in cblRowSelector.Items)
                {
                    if (ls.Contains(item.Text))
                    {
                        item.Selected = true;
                    }
                }
                if (ls.Count > 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showgrid", "selectRows();", true);
                }
              
            }
            catch (Exception ex)
            {

            }
        }

        protected void btnTimeSearch_Click(object sender, EventArgs e)
        {
            try
            {
                if (Session["DashboardLevelHistory"] != null)
                {
                    string date;
                    string frequency = getSelectedFrequency(out date);
                    List<DashboardLevelHistory> listLevelHistory = (List<DashboardLevelHistory>)Session["DashboardLevelHistory"];
                    string companyName = listLevelHistory[listLevelHistory.Count - 1].CompanyName;
                    string plantname = listLevelHistory[listLevelHistory.Count - 1].PlantName;
                    string cellName = listLevelHistory[listLevelHistory.Count - 1].CellName;
                    string machineName = listLevelHistory[listLevelHistory.Count - 1].MachineName;
                    bindData(companyName, plantname, cellName, machineName, frequency, date);
                }
                else
                {
                    string date;
                    string frequency = getSelectedFrequency(out date);
                    bindData("", "", "", "", frequency, date);
                }
            }
            catch(Exception ex)
            {

            }
        }
    }

  
}