using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using NewProject.Model;
using Type = NewProject.Model.Type;

namespace NewProject
{
    public partial class Production1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
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
            
                bindData();
                //bindCardViewData();
                bindContextList();
            }
        }
        private List<ContextListDetails> getList(string view)
        {
            List<ContextListDetails> list = new List<ContextListDetails>();
            ContextListDetails contextListDetails = new ContextListDetails();
            contextListDetails.View = view +" 1";
            contextListDetails.AE = "12";
            contextListDetails.PE = "23";
            contextListDetails.QE = "45";
            list.Add(contextListDetails);
            contextListDetails = new ContextListDetails();
            contextListDetails.View = view + " 2";
            contextListDetails.AE = "12";
            contextListDetails.PE = "23";
            contextListDetails.QE = "45";
            list.Add(contextListDetails);
            contextListDetails = new ContextListDetails();
            contextListDetails.View = view + " 3";
            contextListDetails.AE = "12";
            contextListDetails.PE = "23";
            contextListDetails.QE = "45";
            list.Add(contextListDetails);
            contextListDetails = new ContextListDetails();
            contextListDetails.View = view + " 4";
            contextListDetails.AE = "12";
            contextListDetails.PE = "23";
            contextListDetails.QE = "45";
            list.Add(contextListDetails);
            contextListDetails = new ContextListDetails();
            contextListDetails.View = view + " 5";
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
            private void bindData()
            {
              //  hfView.Value = "ListView";
                if (hfMainView.Value == "CompanyView")
                {
                    List<ContextListDetails> contextListDetails= getList("Company");
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
                    ls.Add("Company");
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
                    List<ContextListDetails> contextListDetails = new List<ContextListDetails>();
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
                    }
                    else
                    {
                        contextListDetails = getList("Plant");
                        lvPlantDashboard.DataSource = contextListDetails;
                        lvPlantDashboard.DataBind();
                        lvPlantDashboard.Visible = true;
                        lvDivDashboard.Visible = false;

                        lvCardViewPlantDashboard.DataSource = contextListDetails;
                        lvCardViewPlantDashboard.DataBind();
                        lvCardViewPlantDashboard.Visible = true;
                        lvCardViewDivDashboard.Visible = false;
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
                    cblRowSelector.DataSource = contextListDetails.Select(x => x.View).ToList();
                    cblRowSelector.DataBind();
                    List<string> ls = new List<string>();
                    ls.Add("Cell");
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
                    cblRowSelector.DataSource = contextListDetails.Select(x => x.View).ToList();
                    cblRowSelector.DataBind();
                    List<string> ls = new List<string>();
                    ls.Add("Machine");
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
        
            }
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
                ls.Add("Company");
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
                ls.Add("Cell");
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
                ls.Add("Machine");
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
            bindData();
            bindContextList();
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
            lbBack.Visible = true;
            hfselectedContext.Value = "CellView";
            hfMainView.Value = "CellView";
            bindData();
            bindContextList();
            setBackListItems("PlantView");
        }

        protected void lvCellDashboard_ItemEditing(object sender, ListViewEditEventArgs e)
        {
            lbBack.Visible = true;
            hfselectedContext.Value = "MachineView";
            hfMainView.Value = "MachineView";
            bindData();
            bindContextList();
            setBackListItems("CellView");
        }

        protected void lvCompanyDashboard_ItemEditing(object sender, ListViewEditEventArgs e)
        {
            lbBack.Visible = true;
            hfselectedContext.Value = "PlantView";
            hfMainView.Value = "PlantView";
            bindData();
            bindContextList();
            setBackListItems("CompanyView");


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
                if (Session["BackList"] != null)
                {
                    List<string> ls = (List<string>)Session["BackList"];
                    if (ls.Count > 0)
                    {
                        lbBack.Visible = true;
                        hfselectedContext.Value = ls[ls.Count-1].ToString();
                        hfMainView.Value = ls[ls.Count-1].ToString();
                        ls.RemoveAt(ls.Count-1);
                        Session["BackList"] = ls;
                        //if (hfView.Value == "CardView")
                        //{
                          //  bindCardViewData();
                        //}
                        //else
                        //{
                            bindData();
                        //}
                     
                        bindContextList();
                    }
                    else
                    {
                        Session["BackList"] = null;
                        lbBack.Visible = false;
                    }
                    if (ls.Count == 0)
                    {
                        Session["BackList"] = null;
                        lbBack.Visible = false;
                    }
                }
            }
            catch(Exception ex)
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
        public static ChartData1 getzoomChartData( double xvalue, double yvalue)
        {
            ChartData1 chartData = new ChartData1();
            try
            {
                List<ChartData> chartDatasList= (List <ChartData> )HttpContext.Current.Session["ChartData"];
           
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
            catch(Exception ex)
            {

            }
            return chartData;
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static YearChartData getYearChartData(string view)
        {
            YearChartData yearChartData = new YearChartData();
            try
            {
                Production1 production1 = new Production1();
                List<ContextListDetails> contextListDetails = new List<ContextListDetails>();
                if (view == "CompanyView")
                {
                    contextListDetails = production1.getList("Company");
                }
                if (view == "PlantView")
                {
                    contextListDetails = production1.getList("Plant");
                }
                if (view == "CellView")
                {
                    contextListDetails = production1.getList("Cell");
                }
                if (view == "MachineView")
                {
                    contextListDetails = production1.getList("Machine");
                }
                List<double[]> yAxisDataSet = new List<double[]>();
                List<string[]> xAxisDataSet = new List<string[]>();
                string[] xAxisData = null;
                double[] yAxisData = null;
                for (int i = 0; i < contextListDetails.Count; i++)
                {
                    xAxisData = new string[1];
                    xAxisData[0] = contextListDetails[i].View;
                    yAxisData = new double[1];
                    yAxisData[0] = Convert.ToDouble(contextListDetails[i].AE);
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
        public static List<ContextListDetails> getMonthChartData(string view)
        {
            YearChartData yearChartData = new YearChartData();
            List<ContextListDetails> finalcontextListDetails = new List<ContextListDetails>();
            ContextListDetails contextListDetail = null;
            try
            {
                Production1 production1 = new Production1();
                List<ContextListDetails> contextListDetails = new List<ContextListDetails>();
                if (view == "CompanyView")
                {
                    contextListDetails = production1.getList("Company");
                }
                if (view == "PlantView")
                {
                    contextListDetails = production1.getList("Plant");
                }
                if (view == "CellView")
                {
                    contextListDetails = production1.getList("Cell");
                }
                if (view == "MachineView")
                {
                    contextListDetails = production1.getList("Machine");
                }
                    string appendString = "";
                for (int month = 0; month < 2; month++)
                {
                    for (int i = 0; i < contextListDetails.Count; i++)
                    {
                        contextListDetail = new ContextListDetails();
                        if (month == 0)
                        {
                            contextListDetail.Month = "Jan";
                        }
                        else
                        {
                            contextListDetail.Month = "Feb";
                        }
                        contextListDetail.View = contextListDetails[i].View;
                        contextListDetail.AE = contextListDetails[i].AE;
                        contextListDetail.QE = contextListDetails[i].QE;
                        contextListDetail.PE = contextListDetails[i].PE;
                        finalcontextListDetails.Add(contextListDetail);
                    }
                }
            }
            catch (Exception ex)
            {

            }
            return finalcontextListDetails;
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
                        type.style=styles1;
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
            catch(Exception ex)
            {
                
            }
            
          
            return chartData1;
        }

        protected void lvCardViewPlantDashboard_ItemEditing(object sender, ListViewEditEventArgs e)
        {
            lbBack.Visible = true;
            hfselectedContext.Value = "CellView";
            hfMainView.Value = "CellView";
            bindData();
            bindContextList();
            setBackListItems("PlantView");
        }

        protected void lvCardViewCompanyDashboard_ItemEditing(object sender, ListViewEditEventArgs e)
        {
            lbBack.Visible = true;
            hfselectedContext.Value = "PlantView";
            hfMainView.Value = "PlantView";
            bindData();
            bindContextList();
            setBackListItems("CompanyView");
        }

        protected void lvCardViewCellDashboard_ItemEditing(object sender, ListViewEditEventArgs e)
        {
            lbBack.Visible = true;
            hfselectedContext.Value = "MachineView";
            hfMainView.Value = "MachineView";
            bindData();
            bindContextList();
            setBackListItems("CellView");
        }

        protected void btnYearSearch_Click(object sender, EventArgs e)
        {
            try
            {
                bindData();
                bindContextList();
                Label lbl = (Label)Page.Master.FindControl("lblShowSelectedItems");
                lbl.Text = lbl.Text + " - " + txtYear.Text;
                ScriptManager.RegisterStartupScript(this, GetType(), "showChart", "bindColumnChart();", true);
            }
            catch(Exception ex)
            {

            }
        }
    }
    public class YearChartData
    {
        public List<double[]> yAxis { get; set; }
        public List<string[]> xAxis { get; set; }
    }
    public class ChartData1
    {
        public List<double[]> data { get; set; }
        public List<Type> type { get; set; }
        public List<Plotline> plotLines { get; set; }
    }
    //public class Type
    //{
    //    public double x { get; set; }
    //    public string text { get; set; }
    //    public string title { get; set; }
    //    public List<Styles> style { get; set; }
    //}
    //public class Plotline
    //{
    //    public string color { get; set; }
    //    public double value { get; set; }
    //    public int width { get; set; }
    //    public List<XLabel> label { get; set; }
    //}
    public class XLabel
    {
    
        public string text { get; set; }
        public List<Styles>  style{ get; set; }
        public int rotation { get; set; }
    }
    public class Styles
    {
        public string color { get; set; }
    }
    public class ChartData
    {
        public DateTime Time { get; set; }
        public string ParameterID { get; set; }
        public string Value { get; set; }
    }
    public class ContextList
    {
        public string ContextName { get; set; }
        public string ContextNameForReference { get; set; }
    }
    public class ContextListDetails
    {
        public string Month { get; set; }
        public string View { get; set; }
        public string AE { get; set; }
        public string QE { get; set; }
        public string PE { get; set; }
    }
}