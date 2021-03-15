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
    public partial class ProcessParameters : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hdnNoOfColumns.Value = "4";
                txtNoOfColumns.Text = "4";
                BindData();
            }
        }
        private void BindData()
        {
            List<ProcessParameterData> list = new List<ProcessParameterData>();
            list.Add(setGetProcessData("HYDRAULIC LEVEL", "42", "Liters", "40", "30", "red", "none", "multipletxt"));
            list.Add(setGetProcessData("COOLANT LEVEL", "30", "Liters", "40", "20", "yellow", "none", "multipletxt"));
            list.Add(setGetProcessData("LUBRICATION PRESSURE", "3", "Bar", "8", "5", "red", "none", "multipletxt"));
            list.Add(setGetProcessData("R-N VOLTAGE", "240", "Voltage", "300", "0", "red", "none", "multipletxt"));
            list.Add(setGetProcessData("Y-N VOLTAGE", "240", "Voltage", "300", "0", "red", "none", "multipletxt"));
            list.Add(setGetProcessData("B-N VOLTAGE", "240", "Voltage", "300", "0", "red", "none", "multipletxt"));
            list.Add(setGetProcessData("DRIVE ENCODER BATTERY", "240", "Voltage", "300", "0", "#2db32d", "none", "multipletxt"));
            list.Add(setGetProcessData("CNC MEMORY BATTERY", "240", "Voltage", "300", "0", "#2db32d", "none", "multipletxt"));
            list.Add(setGetProcessData("PANEL TEMPERATURE", "35", "Temperature", "40", "25", "#2db32d", "none", "multipletxt"));
            list.Add(setGetProcessData("HYDRAULIC PRESSURE", "11", "Bar", "12", "10", "#2db32d", "none", "multipletxt"));
            list.Add(setGetProcessData("SLIDE LUB PRESSURE-Z", "0.4", "Bar", "0.7", "0.2", "#2db32d", "none", "multipletxt"));
            list.Add(setGetProcessData("TAIL STOCK CLAMP Pr", "3", "Bar", "4", "2", "#2db32d", "none", "multipletxt"));
            list.Add(setGetProcessData("SPINDLE COOLANT FLOW Pr", "3", "Bar", "3", "1", "#2db32d", "none", "multipletxt"));
            list.Add(setGetProcessData("SYSTEM AIR PRESSURE", "5", "Bar", "6", "4", "red", "none", "multipletxt"));
            List<ProcessParameterData> list1 = new List<ProcessParameterData>();
            int noofcolumn = 4;
            if (hdnNoOfColumns.Value == "" || hdnNoOfColumns.Value == null)
            {
                noofcolumn = 4;
            }
            else
            {
                noofcolumn = Convert.ToInt32(hdnNoOfColumns.Value);
            }
            if (chkEnableGroup.Checked)
            {
                var groupList = list.GroupBy(u => u.ChartType).Select(grp => grp.ToList()).ToList();
                int i = 0;
                foreach (var group in groupList)
                {
                    int groupCont = group.Count - 1;
                    int j = 0;
                    foreach (var value in group)
                    {
                        ProcessParameterData data = new ProcessParameterData();
                        data.HeaderName = value.HeaderName;
                        data.Value = value.Value;
                        data.ChartType = value.ChartType;
                        data.HighValue = value.HighValue;
                        data.LowValue = value.LowValue;
                        data.BackColor = value.BackColor;

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
                        }
                        else
                        {
                            data.Template2Visibility = "table";
                            data.Template1Visibility = "none";
                        }
                        data.chartContainerID = "chartContainer" + i;
                        list1.Add(data);
                        i++;
                    }
                }
            }
            else
            {
                for (int i = 0; i < list.Count; i++)
                {
                    ProcessParameterData data = new ProcessParameterData();
                    data.HeaderName = list[i].HeaderName;
                    data.Value = list[i].Value;
                    data.ChartType = list[i].ChartType;
                    data.HighValue = list[i].HighValue;
                    data.LowValue = list[i].LowValue;
                    data.BackColor = list[i].BackColor;
                    if ((i + 1) % noofcolumn == 0)
                    {
                        data.NextLineVisibility = "block";
                    }
                    else
                    {
                        data.NextLineVisibility = "none";
                    }
                    if (list[i].TemplateType == "multipletxt")
                    {
                        data.Template1Visibility = "table";
                        data.Template2Visibility = "none";
                    }
                    else
                    {
                        data.Template2Visibility = "table";
                        data.Template1Visibility = "none";
                    }
                    data.chartContainerID = "chartContainer" + i;
                    list1.Add(data);
                }
            }
            lvProcessParamTextView.DataSource = list1;
            lvProcessParamTextView.DataBind();
            lvChartData.DataSource = list1;
            lvChartData.DataBind();
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "BindCharts();", true);
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
            BindData();
        }

        protected void chkEnableGroup_CheckedChanged(object sender, EventArgs e)
        {
            BindData();
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
                            for (int j = i; j < i+6; j++)
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
    }
  
}