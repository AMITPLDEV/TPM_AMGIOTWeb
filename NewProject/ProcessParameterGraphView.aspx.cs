using MongoDB.Bson.Serialization.Attributes;
using MongoDB.Driver;
using NewProject.Model;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using Type = NewProject.Model.Type;

namespace NewProject
{
    public partial class ProcessParameterGraphView : System.Web.UI.Page
    {
        private readonly static IMongoClient _MongoClient = null;
        private readonly static IMongoDatabase _MongoDatabase;
       // private static string mongoDBConnString = "mongodb://172.36.0.107:27017";
        private static string mongoDBConnString = "mongodb://localhost:27017";
        static ProcessParameterGraphView()
        {
            _MongoClient = new MongoClient(mongoDBConnString);
         //   _MongoDatabase = _MongoClient.GetDatabase("AMGIOT");
              _MongoDatabase = _MongoClient.GetDatabase("AMG_IOT");
        }
        protected void Page_Load(object sender, EventArgs e)
        {

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
                            for (int j = i; j < i + 6; j++)
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
        static string conString = WebConfigurationManager.ConnectionStrings["ConnString"].ToString();
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

        public static ChartData1 getChartData2(string MachineID, string Parameters, string FromDate, int ToDate)
        {
            List<ChartData> chartDatasList = new List<ChartData>();
            ChartData chartData = null;


            var filter = "{$and : [{ UpdatedTS: {$gte: ISODate('" + Util.GetDateTime(FromDate).ToString("yyyy-MM-ddTHH:mm:ssZ") + "')} },{ UpdatedTS: {$lte: ISODate('" + Util.GetDateTime(FromDate).AddHours(ToDate).ToString("yyyy-MM-ddTHH:mm:ssZ") + "')} }, {MachineID : {$in : " + MachineID + "}},{ParamterID : {$in :'P3', 'P4', 'P5', 'P6', 'P7, 'P8', 'P9','P10}}]}";
            var dataset = _MongoDatabase.GetCollection<gvChartData>("PPT_AMGIOT_FlatData_Test").Find(filter).ToList();


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
    }
    public class gvChartData
    {
        [BsonDateTimeOptions(Kind = DateTimeKind.Local)]
        public DateTime? UpdatedTS { get; set; }
        public string ParameterID { get; set; }
        public string ParameterValue { get; set; }
    }
}