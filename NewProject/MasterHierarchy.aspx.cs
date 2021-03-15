using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace NewProject
{
    public partial class MasterHierarchy : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           // Control div = Page.FindControl("div1");
            //if (div != null)
            //{
            //    div.Visible = false;
            //}
            //HtmlControl control = (HtmlControl)Page.FindControl("div1");
            //if (control != null)
            //{
            //    control.Visible = false;
            //}
            if(!IsPostBack)
            {
               
                divPlantContainer.Visible = true;
                divPlantHierarchyContainer.Visible = false;
                BindPlantData();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "setActiveValue", "setActiveSubmenuValue('');", true);
            }
        }
        private void BindPlantData()
        {
            try
            {
                List<PlantData> list = new List<PlantData>();
                list.Add(new PlantData() { Plant="Plant-01",PlantDesc="Plant-01 Desc"});
                list.Add(new PlantData() { Plant = "Plant-02", PlantDesc = "Plant-02 Desc" });
                list.Add(new PlantData() { Plant = "Plant-03", PlantDesc = "Plant-03 Desc" });
                gvPlantData.DataSource = list;
                gvPlantData.DataBind();
            }
            catch(Exception ex)
            { }
        }

        protected void gvPlantData_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(gvPlantData, "Select$" + e.Row.RowIndex);
                    e.Row.Attributes["style"] = "cursor:pointer";


                }
            }
            catch (Exception ex)
            {

            }
        }

        protected void gvPlantData_SelectedIndexChanged(object sender, EventArgs e)
        {
            int index = gvPlantData.SelectedRow.RowIndex;
            string plant = gvPlantData.SelectedRow.Cells[0].Text;
            divPlantContainer.Visible = false;
            divPlantHierarchyContainer.Visible = true;
            liShopMenu.Visible = false;
            liCellMenu.Visible = false;
            liGroupMenu.Visible = false;
            lblSCGroupLvl.Visible = false;
            DropDownList3.Visible = false;
            if (plant=="Plant-01")
            {
                lblSCGroupLvl.Visible = true;
                List<ListItem> list = new List<ListItem>();
                list.Add(new ListItem("Shop1"));
                DropDownList3.DataSource = list;
                DropDownList3.DataBind();
                DropDownList3.Visible = true;
                lblSCGroupLvl.Text = "Shop";
                liShopMenu.Visible = true;
                liGroupMenu.Visible = true;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "setActiveValue", "setActiveSubmenuValue('shopMenu');", true);
            }
            else if (plant == "Plant-02")
            {
                List<ListItem> list = new List<ListItem>();
                list.Add(new ListItem("Cell1"));
                DropDownList3.DataSource = list;
                DropDownList3.DataBind();
                lblSCGroupLvl.Visible = true;
                DropDownList3.Visible = true;
                lblSCGroupLvl.Text = "Cell";
                liCellMenu.Visible = true;
                liGroupMenu.Visible = true;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "setActiveValue", "setActiveSubmenuValue('cellMenu');", true);
            }
            else
            {
                lblSCGroupLvl.Visible = false;
                DropDownList3.Visible = false;
                liGroupMenu.Visible = true;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "setActiveValue", "setActiveSubmenuValue('groupMenu');", true);
            }
        }

        protected void backBtn_Click(object sender, EventArgs e)
        {
            BindPlantData();
            divPlantContainer.Visible = true;
            divPlantHierarchyContainer.Visible = false;
        }
    }
    public class PlantData
    {
        public string Plant { get; set; }
        public string PlantDesc { get; set; }
    }
}