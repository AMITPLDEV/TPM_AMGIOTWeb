using MongoDB.Bson;
using Nest;
using NewProject.DataBaseAccess;
using NewProject.Model;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NewProject
{
    public partial class Troubleshooting : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    if(Session["ProjectTheme"]!=null)
                    {
                        if(Session["ProjectTheme"].ToString()== "light")
                        {
                            mainBody.Attributes["class"] = "";
                            mainBody.Attributes.Add("class", "light-mode");
                        }
                        else
                        {
                            mainBody.Attributes["class"] = "";
                        }
                    }
                    BindMTBData();
                    rbOperatorMode.SelectedValue = "Or";
                    if (Request.QueryString["param"] == "ProcessParameter")
                    {
                        parameterDetailsDiv.Visible = true;
                        string machineid = Request.QueryString["machineID"].ToString();
                        string parameter = Request.QueryString["parameterName"].ToString();
                        if (machineid != "" && parameter != "")
                        {
                            string model = "";
                            string mtb = DBAccess.getMTBModelForParameter(machineid, parameter, out model);
                            if (mtb != "")
                            {
                                ddlMTB.SelectedValue = mtb;
                                int modelFlag = 0;
                                if (model != "")
                                {
                                    foreach (ListItem item in lbModel.Items)
                                    {
                                        if (item.Value.Trim()==model.Trim())
                                        {
                                            modelFlag = 1;
                                            item.Selected = true;
                                        }
                                    }
                                }
                                if(modelFlag==0)
                                {
                                    foreach (ListItem item in lbModel.Items)
                                    {
                                        item.Selected = true;
                                    }
                                }
                            }
                            lblMachine.Text = machineid;
                            lblParameterID.Text = parameter;
                            lblProblem.Text = parameter;
                            txtSearch.Text = parameter;
                        }
                    }
                    else if (Request.QueryString["param"] == "Alarm")
                    {
                        string parameter = Request.QueryString["parameterName"].ToString();
                        parameterDetailsDiv.Visible = false;
                        lblMachine.Text = "";
                        lblParameterID.Text = parameter;
                        lblProblem.Text = parameter;
                        txtSearch.Text = parameter;
                        foreach (ListItem item in lbModel.Items)
                        {
                            item.Selected = true;
                        }
                    }
                    else if (Request.QueryString["param"] == "KB")
                    {
                        //if it is come from KB
                        parameterDetailsDiv.Visible = false;
                        lblMachine.Text = "";
                        lblParameterID.Text = "";
                        lblProblem.Text = "";
                        txtSearch.Text = "";
                        foreach (ListItem item in lbModel.Items)
                        {
                            item.Selected = true;
                        }
                    }
                    chartFilterDiv.Visible = false;
                    btnView_Click(null, null);
                    BindColumnFilterData();
                }
            }
            catch (Exception ex)
            { }
        }
        private void BindColumnFilterData()
        {
            try
            {
                List<ListItem> list = new List<ListItem>();
                for (int i = 0; i < gvServiceDetails.Columns.Count; i++)
                {
                    string text = gvServiceDetails.Columns[i].HeaderText;
                    string value = gvServiceDetails.Columns[i].AccessibleHeaderText;
                    list.Add(new ListItem(text, value));
                }
                cblColumnSelector.DataSource = list;
                cblColumnSelector.DataTextField = "text";
                cblColumnSelector.DataValueField = "value";
                cblColumnSelector.DataBind();
                foreach(ListItem item in cblColumnSelector.Items)
                {
                    item.Selected = true;
                }
            }
            catch (Exception ex)
            {

            }
        }
        private void BindMTBData()
        {
            try
            {
                List<string> list = DBAccess.getMTBData("", "", "", "");
                ddlMTB.DataSource = list;
                ddlMTB.DataBind();
                BindMachineModelData();
            }
            catch (Exception ex)
            {

            }
        }
        private void BindMachineModelData()
        {
            try
            {
                List<string> list = DBAccess.getMachineModelData("", "", "", "", ddlMTB.SelectedValue, "");
                lbModel.DataSource = list;
                lbModel.DataBind();
            }
            catch (Exception ex)
            {

            }
        }
        protected void ddlMTB_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                BindMachineModelData();
            }
            catch (Exception ex)
            { }
        }
        protected void btnView_Click(object sender, EventArgs e)
        {
            try
            {
                BindSearchData();
                BindMachineDocument();

            }
            catch (Exception ex)
            {

            }
        }
        private void BindSearchData()
        {
            try
            {
                var uris = new Uri(ConfigurationManager.AppSettings["elasticsearchConnString"].ToString());
                var settings = new ConnectionSettings(uris).DefaultIndex("servicereport2");
                var client = new ElasticClient(settings);
                string searchPrblm = txtSearch.Text.Trim();
                string mtb = ddlMTB.SelectedValue;
                string model = "";
                string wordSearchInput = "";
                List<string> selectedModel = new List<string>();
                foreach (ListItem item in lbModel.Items)
                {
                    if (item.Selected)
                    {
                        selectedModel.Add(item.Value);
                    }
                }

                //var searchResponse = client.Search<dynamic>(s => s
                // .Query(q => q
                // .Bool(b => b
                // .Should(fi => fi
                // .Match(m => m
                // .Field("Problem Description")
                // .Query(searchPrblm)
                // ),
                // fi => fi.Match(m => m
                // .Field("Problem Observed")
                // .Query(searchPrblm)
                // )
                // )
                // .Filter(
                // fi => fi.Term(t => t.Field("Principal").Value(mtb)),
                // fi => fi.Term(t => t.Field("Model Name").Value(model))
                // )
                // )
                // ));

                //var searchResponse = client.Search<dynamic>(s => s
                // .From(0)
                // .Size(10)
                // .Query(q => q
                // .Bool(b => b
                // .Should(fi => fi
                // .MultiMatch(m => m
                // .Query(searchPrblm)
                // .Fields("Problem Description")
                // .Fields("Problem Observed")
                // )
                // )
                // .Filter(m=> m.Term(t1=>t1.Field("Principal").Value(mtb))
                // //, m => m.Term(t1 => t1.Field("Model Name").Value(model))
                // )
                // )
                // ));


                // searchPrblm = searchPrblm.Replace("-", " ");
                int minimumShouldMatchValue = 1;
                Operator operatorMode = Operator.Or;
                if (rbOperatorMode.SelectedValue=="And")
                {
                    operatorMode = Operator.And;
                }
                if (chartFilterDiv.Visible)
                {
                    // searchPrblm = searchPrblm + " " + lblWordSearch.Text;
                    wordSearchInput = lblWordSearch.Text;
                }
                else
                {
                    if (searchPrblm.Trim() == "")
                    {
                        searchPrblm = "";
                        operatorMode = Operator.Or;
                        minimumShouldMatchValue = 0;
                    }
                }
                //var searchResponse = client.Search<dynamic>(s => s
                // //.Scroll("5m")
                // .From(0)
                // .Size(10000)
                // .Query(q => q
                // .Bool(b => b
                // .Should(fi => fi

                // .MultiMatch(m => m
                // .Query(searchPrblm)
                // .Fields(f => f.Field("Problem Description")
                // .Field("Problem Observed"))
                // .Type(TextQueryType.CrossFields)
                // .Operator(Operator.Or)
                // )

                // // , fi => fi.Term(t1 => t1.Field("Principal").Value(mtb))
                // //,fi => fi.Terms(t1 => t1.Field("Model Name").Terms(selectedModel))
                // )
                // .Filter(m => m.Term(t1 => t1.Field("Principal").Value(mtb))
                // ////, m => m.Term(t1 => t1.Field("Model Name").Value(model))
                // )
                // )
                // )
                // .Aggregations(a => a.Terms("AggCount", t1 => t1.Field("Problem Observed")))
                // );


                var searchResponse = client.Search<dynamic>(s => s
                                            .Scroll("10s")
                                            // .From(0)
                                            .Size(100)
                                            .Query(q => q
                                                .Bool(b => b
                                                        .Should(fi => fi.MultiMatch(m => m
                                                                .Query(searchPrblm)
                                                                .Fields(f => f.Field("problemDescription")
                                                                .Field("problemObserved"))
                                                                //.Type(TextQueryType.CrossFields)
                                                                .Operator(operatorMode)
                                                            ),
                                                            fi => fi.MultiMatch(m => m
                                                                .Query(wordSearchInput)
                                                                .Fields(f => f.Field("problemDescription")
                                                                .Field("problemObserved"))
                                                                //.Type(TextQueryType.CrossFields)
                                                                .Operator(operatorMode)
                                                            )
                                                        )
                                                        .Filter(m => m.Term(t1 => t1.Field("principal.keyword").Value(mtb))
                                                        , m => m.Terms(t1 => t1.Field("modelName.keyword").Terms(selectedModel))
                                                        )
                                                         .MinimumShouldMatch(minimumShouldMatchValue)

                                                )
                                            )
                                            .Aggregations(a => a.Terms("AggCount", t1 => t1.Field("problemDescription.keyword")))
                                          );
                var aggregateResponse = client.Search<dynamic>(s => s
                                          //.Scroll("10s")
                                          // .From(0)
                                          .Size(0)
                                          .Query(q => q
                                              .Bool(b => b
                                                      .Should(fi => fi.MultiMatch(m => m
                                                              .Query(searchPrblm)
                                                              .Fields(f => f.Field("problemDescription")
                                                              .Field("problemObserved"))
                                                              //.Type(TextQueryType.CrossFields)
                                                              .Operator(operatorMode)
                                                          ),
                                                          fi => fi.MultiMatch(m => m
                                                              .Query(wordSearchInput)
                                                              .Fields(f => f.Field("problemDescription")
                                                              .Field("problemObserved"))
                                                              //.Type(TextQueryType.CrossFields)
                                                              .Operator(operatorMode)
                                                          )
                                                      )
                                                      .Filter(m => m.Term(t1 => t1.Field("principal.keyword").Value(mtb))
                                                      , m => m.Terms(t1 => t1.Field("modelName.keyword").Terms(selectedModel))
                                                      )
                                                       .MinimumShouldMatch(minimumShouldMatchValue)

                                              )
                                          )
                                          .Aggregations(a => a.Terms("AggCount", t1 => t1.Field("problemDescription.keyword").Size(20)))
                                        );
                List<TroubleshootingData> list = new List<TroubleshootingData>();
                if (searchResponse.Shards.Successful > 0)
                {
                    TroubleshootingData data = null;
                    //var results = client.Scroll<dynamic>("10m", searchResponse.ScrollId);
                    while (searchResponse.Documents.Any())
                    {
                        foreach (var document in searchResponse.Documents)
                        {
                            //indexedList.Add(doc.Value<string>("propertyName"));
                            try
                            {
                                ////var doc1= document.ToJson;
                                //data = new TroubleshootingData();
                                //data.Region = document["Region"];
                                //data.Customer = document["Customer"];
                                //data.Principal = document["Principal"];
                                //data.ModelName = document["Model Name"];
                                //data.SlNo = document["Sl No"];
                                //data.WarrantyStatus = document["Warranty Status"];
                                //data.Category = document["Category"];
                                //data.TotalMcBDHours = document["Total M/c BD Hours"];
                                //data.Description = document["Description"];
                                //data.MainAssembly = document["Main Assembly"];
                                //data.MainArea = document["Main Area"];
                                //data.SubArea = document["Sub Area"];
                                //data.Solution = document["Solution"];
                                //data.SolutionDesc = document["Solution Description"];
                                //data.ProbableReasons = document["Probable reasons for this problem"];
                                //data.ProblemDesc = document["Problem Description"];
                                //data.ProblemObserved = document["Problem Observed"];


                                data = new TroubleshootingData();
                                data.Region = document["region"];
                                data.Customer = document["customer"];
                                data.Principal = document["principal"];
                                data.ModelName = document["modelName"];
                                data.SlNo = document["slNo"];
                                data.WarrantyStatus = document["warrantyStatus"];
                                data.Category = document["category"];
                                data.TotalMcBDHours = document["totalMcBDHours"];
                                data.Description = document["description"];
                                data.MainAssembly = document["mainAssembly"];
                                data.MainArea = document["mainArea"];
                                data.SubArea = document["subArea"];
                                data.Solution = document["solution"];
                                data.SolutionDesc = document["solutionDescription"];
                                data.ProbableReasons = document["probableReasons"];
                                data.ProblemDesc = document["problemDescription"];
                                data.ProblemObserved = document["problemObserved"];
                                list.Add(data);
                            }
                            catch (Exception ex)
                            { }
                        }
                        searchResponse = client.Scroll<dynamic>("10s", searchResponse.ScrollId);
                    }
                    Session["TroubleshootingPbmData"] = list;

                    //foreach (var document in searchResponse.Documents)
                    //{
                    // try
                    // {
                    // data = new TroubleshootingData();
                    // data.Region = document["Region"];
                    // data.Customer = document["Customer"];
                    // data.Principal = document["Principal"];
                    // data.ModelName = document["Model Name"];
                    // data.SlNo = document["Sl No"];
                    // data.WarrantyStatus = document["Warranty Status"];
                    // data.Category = document["Category"];
                    // data.TotalMcBDHours = document["Total M/c BD Hours"];
                    // data.Description = document["Description"];
                    // data.MainAssembly = document["Main Assembly"];
                    // data.MainArea = document["Main Area"];
                    // data.SubArea = document["Sub Area"];
                    // data.Solution = document["Solution"];
                    // data.SolutionDesc = document["Solution Description"];
                    // data.ProbableReasons = document["Probable reasons for this problem"];
                    // data.ProblemDesc = document["Problem Description"];
                    // data.ProblemObserved = document["Problem Observed"];
                    // list.Add(data);
                    // }
                    // catch (Exception ex)
                    // { }
                    //}



                }
                gvServiceDetails.DataSource = list;
                gvServiceDetails.DataBind();
                if (aggregateResponse.Shards.Successful > 0)
                {
                    //Aggragete Data
                    List<TroubleshootingChartData> listAggregate = new List<TroubleshootingChartData>();
                    TroubleshootingChartData dataAggregate = null;
                    var aggDataSet = aggregateResponse.Aggregations.Terms("AggCount");
                    foreach (var aggData in aggDataSet.Buckets)
                    {
                        dataAggregate = new TroubleshootingChartData();
                        dataAggregate.weight = Convert.ToDouble(aggData.DocCount);
                        dataAggregate.name = aggData.Key;
                        dataAggregate.clickStatus = "click";
                        listAggregate.Add(dataAggregate);
                    }
                    Session["TroubleshootingAggData"] = listAggregate;
                }
                ScriptManager.RegisterStartupScript(this, GetType(), "bindchart", "BindAggregationChart();", true);
            }
            catch (Exception ex)
            {

            }
        }
        private void BindSearchData1()
        {
            try
            {
                var uris = new Uri(ConfigurationManager.AppSettings["elasticsearchConnString"].ToString());
                var settings = new ConnectionSettings(uris).DefaultIndex("servicereport2");
                var client = new ElasticClient(settings);
                string searchPrblm = txtSearch.Text.Trim();
                string mtb = ddlMTB.SelectedValue;
                string model = "";
                List<string> selectedModel = new List<string>();
                foreach (ListItem item in lbModel.Items)
                {
                    if (item.Selected)
                    {
                        selectedModel.Add(item.Value);
                    }
                }

                //var searchResponse = client.Search<dynamic>(s => s
                //                         .Query(q => q
                //                                .Bool(b => b
                //                                    .Should(fi => fi
                //                                        .Match(m => m
                //                                              .Field("Problem Description")
                //                                              .Query(searchPrblm)
                //                                        ),
                //                                      fi => fi.Match(m => m
                //                                               .Field("Problem Observed")
                //                                                .Query(searchPrblm)
                //                                        )
                //                                    )
                //                                .Filter(
                //                                       fi => fi.Term(t => t.Field("Principal").Value(mtb)),
                //                                       fi => fi.Term(t => t.Field("Model Name").Value(model))
                //                                )
                //                                )
                //                            ));

                //var searchResponse = client.Search<dynamic>(s => s
                //                       .From(0)
                //                       .Size(10)
                //                       .Query(q => q
                //                              .Bool(b => b
                //                                  .Should(fi => fi
                //                                      .MultiMatch(m => m
                //                                            .Query(searchPrblm)
                //                                            .Fields("Problem Description")
                //                                            .Fields("Problem Observed")
                //                                      )
                //                                  )
                //                                  .Filter(m=> m.Term(t1=>t1.Field("Principal").Value(mtb))
                //                                       //, m => m.Term(t1 => t1.Field("Model Name").Value(model))
                //                                  )
                //                              )
                //                          ));


                // searchPrblm = searchPrblm.Replace("-", " ");
                if (chartFilterDiv.Visible)
                {
                    searchPrblm = searchPrblm + " " + lblWordSearch.Text;
                }
                else
                {
                    if (searchPrblm.Trim() == "")
                    {
                        searchPrblm = "a e i o u";
                    }
                }
                //var searchResponse = client.Search<dynamic>(s => s
                //                    //.Scroll("5m")
                //                           .From(0)
                //                           .Size(10000)
                //                    .Query(q => q
                //                           .Bool(b => b
                //                               .Should(fi => fi

                //                               .MultiMatch(m => m
                //                                     .Query(searchPrblm)
                //                                     .Fields(f => f.Field("Problem Description")
                //                                               .Field("Problem Observed"))
                //                                               .Type(TextQueryType.CrossFields)
                //                                               .Operator(Operator.Or)
                //                               )

                //                              // , fi => fi.Term(t1 => t1.Field("Principal").Value(mtb))
                //                                //,fi => fi.Terms(t1 => t1.Field("Model Name").Terms(selectedModel))
                //                               )
                //                           .Filter(m => m.Term(t1 => t1.Field("Principal").Value(mtb))
                //                           ////, m => m.Term(t1 => t1.Field("Model Name").Value(model))
                //                           )
                //                           )
                //                       )
                //                     .Aggregations(a => a.Terms("AggCount", t1 => t1.Field("Problem Observed")))
                //                        );
                var searchResponse = client.Search<dynamic>(s => s
                                         //.Scroll("5m")
                                         .From(0)
                                         .Size(10000)
                                  .Query(q => q
                                         .Bool(b => b
                                             .Should(fi => fi

                                             .MultiMatch(m => m
                                                   .Query(searchPrblm)
                                                   .Fields(f => f.Field("problemDescription")
                                                             .Field("problemObserved"))
                                                             .Type(TextQueryType.CrossFields)
                                                             .Operator(Operator.Or)
                                             )

                                             // , fi => fi.Term(t1 => t1.Field("Principal").Value(mtb))
                                             //,fi => fi.Terms(t1 => t1.Field("Model Name").Terms(selectedModel))
                                             )
                                         .Filter(m => m.Term(t1 => t1.Field("principal.keyword").Value(mtb))
                                         , m => m.Terms(t1 => t1.Field("modelName.keyword").Terms(selectedModel))
                                         )
                                         .MinimumShouldMatch(1)

                                         )
                                     )
                                   .Aggregations(a => a.Terms("AggCount", t1 => t1.Field("problemDescription.keyword")))
                                      );

                List<TroubleshootingData> list = new List<TroubleshootingData>();
                if (searchResponse.Shards.Successful > 0)
                {
                    TroubleshootingData data = null;
                    //var results = client.Scroll<dynamic>("10m", searchResponse.ScrollId);
                   // while (results.Documents.Any())
                   // {
                        foreach (var document in searchResponse.Documents)
                        {
                            //indexedList.Add(doc.Value<string>("propertyName"));
                            try
                            {
                            ////var doc1= document.ToJson;
                            //data = new TroubleshootingData();
                            //data.Region = document["Region"];
                            //data.Customer = document["Customer"];
                            //data.Principal = document["Principal"];
                            //data.ModelName = document["Model Name"];
                            //data.SlNo = document["Sl No"];
                            //data.WarrantyStatus = document["Warranty Status"];
                            //data.Category = document["Category"];
                            //data.TotalMcBDHours = document["Total M/c BD Hours"];
                            //data.Description = document["Description"];
                            //data.MainAssembly = document["Main Assembly"];
                            //data.MainArea = document["Main Area"];
                            //data.SubArea = document["Sub Area"];
                            //data.Solution = document["Solution"];
                            //data.SolutionDesc = document["Solution Description"];
                            //data.ProbableReasons = document["Probable reasons for this problem"];
                            //data.ProblemDesc = document["Problem Description"];
                            //data.ProblemObserved = document["Problem Observed"];

                          
                            data = new TroubleshootingData();
                            data.Region = document["region"];
                            data.Customer = document["customer"];
                            data.Principal = document["principal"];
                            data.ModelName = document["modelName"];
                            data.SlNo = document["slNo"];
                            data.WarrantyStatus = document["warrantyStatus"];
                            data.Category = document["category"];
                            data.TotalMcBDHours = document["totalMcBDHours"];
                            data.Description = document["description"];
                            data.MainAssembly = document["mainAssembly"];
                            data.MainArea = document["mainArea"];
                            data.SubArea = document["subArea"];
                            data.Solution = document["solution"];
                            data.SolutionDesc = document["solutionDescription"];
                            data.ProbableReasons = document["probableReasons"];
                            data.ProblemDesc = document["problemDescription"];
                            data.ProblemObserved = document["problemObserved"];
                            list.Add(data);
                            }
                            catch (Exception ex)
                            { }
                        }
                      //  results = client.Scroll<dynamic>("10m", results.ScrollId);
                   // }
                    Session["TroubleshootingPbmData"] = list;

                    //foreach (var document in searchResponse.Documents)
                    //{
                    //    try
                    //    {
                    //        data = new TroubleshootingData();
                    //        data.Region = document["Region"];
                    //        data.Customer = document["Customer"];
                    //        data.Principal = document["Principal"];
                    //        data.ModelName = document["Model Name"];
                    //        data.SlNo = document["Sl No"];
                    //        data.WarrantyStatus = document["Warranty Status"];
                    //        data.Category = document["Category"];
                    //        data.TotalMcBDHours = document["Total M/c BD Hours"];
                    //        data.Description = document["Description"];
                    //        data.MainAssembly = document["Main Assembly"];
                    //        data.MainArea = document["Main Area"];
                    //        data.SubArea = document["Sub Area"];
                    //        data.Solution = document["Solution"];
                    //        data.SolutionDesc = document["Solution Description"];
                    //        data.ProbableReasons = document["Probable reasons for this problem"];
                    //        data.ProblemDesc = document["Problem Description"];
                    //        data.ProblemObserved = document["Problem Observed"];
                    //        list.Add(data);
                    //    }
                    //    catch (Exception ex)
                    //    { }
                    //}

                    //Aggragete Data
                    List<TroubleshootingChartData> listAggregate = new List<TroubleshootingChartData>();
                    TroubleshootingChartData dataAggregate = null;
                    var aggDataSet = searchResponse.Aggregations.Terms("AggCount");
                    foreach (var aggData in aggDataSet.Buckets)
                    {
                        dataAggregate = new TroubleshootingChartData();
                        dataAggregate.weight = Convert.ToDouble(aggData.DocCount);
                        dataAggregate.name = aggData.Key;
                        dataAggregate.clickStatus = "click";
                        listAggregate.Add(dataAggregate);
                    }
                    Session["TroubleshootingAggData"] = listAggregate;
                }
                gvServiceDetails.DataSource = list;
                gvServiceDetails.DataBind();
                ScriptManager.RegisterStartupScript(this, GetType(), "bindchart", "BindAggregationChart();", true);
            }
            catch (Exception ex)
            {

            }
        }
        private void BindMachineDocument()
        {
            string mtb = ddlMTB.SelectedValue;
            //string model = "";
            //foreach (ListItem item in lbModel.Items)
            //{
            //    if(item.Selected)
            //    {
            //        //model += "'" + item.Value + "',";
            //        model = item.Value;
            //    }
            //}
            //if (model.Length > 0)
            //{
            //    model = model.Remove(model.Length - 1);
            //}
            BsonArray model = new BsonArray();
            foreach (ListItem item in lbModel.Items)
            {
                if (item.Selected)
                {
                    model.Add(item.Value);
                }
            }
            List<eDocumentData> list = MongoDBAccess.getTroubleshootingEdocuments(mtb, model);
            gvMachineLvlData.DataSource = list;
            gvMachineLvlData.DataBind();
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<TroubleshootingChartData> getAggregationDetails(string mtb, string model, string searchString)
        {
            List<TroubleshootingChartData> list = new List<TroubleshootingChartData>();
            try
            {
                if (HttpContext.Current.Session["TroubleshootingAggData"] != null)
                {
                    list = HttpContext.Current.Session["TroubleshootingAggData"] as List<TroubleshootingChartData>;
                }
                //     List<TroubleshootingChartData> list = new List<TroubleshootingChartData>();
                //var uris = new Uri("http://localhost:9200");
                // var settings = new ConnectionSettings(uris).DefaultIndex("servicereport");
                // var client = new ElasticClient(settings);
                // //var searchResponse = client.Search<dynamic>(s => s
                // //                       //.Query(q => q
                // //                       //       .Bool(b => b
                // //                       //           .Must(m => m.Term(t1 => t1.Field("Principal").Value(mtb)),
                // //                       //                 m => m.Term(t1 => t1.Field("Model Name").Value(model))
                // //                       //           )
                // //                       //       )
                // //                       //   )
                // //                       //.Aggregations(a => a.Cardinality("pcount", f => f.Field("Principal")))
                // //                       .Aggregations(a=> a.Filter("bethels_projects",f=>f.Filter(f1=>f1.Term(t=>t.Field("Principal").Value(mtb)
                // //                       );
                // var searchResponse = client.Search<dynamic>(s => s
                //                         // .From(0)
                //                         // .Size(20)
                //                         .Query(q => q
                //                                .Bool(b => b
                //                                    .Should(fi => fi

                //                                    .MultiMatch(m => m
                //                                          .Query(searchString)
                //                                          .Fields(f => f.Field("Problem Description")
                //                                                    .Field("Problem Observed"))
                //                                    )
                //                                     ,
                //                                     fi => fi.Term(t1 => t1.Field("Principal").Value(mtb))
                //                                    )
                //                                )
                //                            )
                //                         .Aggregations(a=>a.Terms("AggCount",t1=>t1.Field("Problem Observed")))
                //                            );
                // //foreach(var item in searchResponse.Aggregations.Values)
                // //{
                // //   // var data = item("Items");
                // //}
                // TroubleshootingChartData data = null;
                //var b1= searchResponse.Aggregations.Terms("AggCount");
                // foreach (var bucket in b1.Buckets)
                // {
                //     data = new TroubleshootingChartData();
                //     data.weight = Convert.ToDouble(bucket.DocCount);
                //     data.name = bucket.Key;
                //   //  data.color = "red";
                //     list.Add(data);
                // }

            }
            catch (Exception ex)
            {

            }
            return list;
        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static void setThemeInSession(string theme)
        {
            try
            {
                HttpContext.Current.Session["ProjectTheme"] = theme;
            }
            catch(Exception ex)
            {

            }
        }
            protected void btnWordFiterView_Click(object sender, EventArgs e)
        {
            try
            {
                chartFilterDiv.Visible = true;
                lblWordSearch.Text = hdnWordSearch.Value;
                BindSearchData();
            }
            catch (Exception ex)
            {

            }
        }

        protected void lbWordSearchClear_Click(object sender, EventArgs e)
        {
            try
            {
                chartFilterDiv.Visible = false;
                BindSearchData();
            }
            catch (Exception ex)
            {

            }
        }

        protected void lnkParamDataClear_Click(object sender, EventArgs e)
        {
            parameterDetailsDiv.Visible = false;
        }

        protected void gvServiceDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                gvServiceDetails.PageIndex = e.NewPageIndex;
                if(Session["TroubleshootingPbmData"] != null)
                {
                    gvServiceDetails.DataSource = Session["TroubleshootingPbmData"] as List<TroubleshootingData>;
                    gvServiceDetails.DataBind();
                }
                ScriptManager.RegisterStartupScript(this, GetType(), "bindchart", "BindAggregationChart();", true);
            }
            catch(Exception ex)
            {

            }
           
        }

        protected void gvServiceDetails_PreRender(object sender, EventArgs e)
        {
            try
            {
                GridView grid = (GridView)sender;
                if (grid != null)
                {
                    GridViewRow pagerRow = (GridViewRow)grid.BottomPagerRow;
                    if (pagerRow != null)
                    {
                        pagerRow.Visible = true;
                    }
                }
            }
            catch(Exception ex)
            { }
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
            return data;
        }

        protected void btnColumnSelectorOK_Click(object sender, EventArgs e)
        {
            try
            {
                string selectedColumn="";
                foreach(ListItem item in cblColumnSelector.Items)
                {
                    // selectedColumn += "|" + item.Value + "|";
                    int index = Convert.ToInt32(item.Value);
                    if (item.Selected)
                    {
                       
                        gvServiceDetails.Columns[index].Visible = true;
                    }
                    else
                    {
                        gvServiceDetails.Columns[index].Visible = false;
                    }
                }
            }
            catch(Exception ex)
            {
                Logger.WriteDebugLog("Column Selecte" + ex.Message);
            }
        }
    }
}