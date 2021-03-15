using NewProject.DataBaseAccess;
using NewProject.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NewProject
{
    public partial class LevelHierarchyNew : System.Web.UI.Page
    {
        private static string userRole = "", Company="",Plant="";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string companyid = "";
                if (Session["UserRole"] == null)
                {
                    //lblCompany.Visible = true;
                    //ddlCompany.Visible = false;
                }
                else
                {
                    userRole = (string)Session["UserRole"];
                    userRole = userRole.Replace(" ", "").ToLower();
                    if (userRole == "superadmin")
                    {
                        companyid = "";
                    }
                    else
                    if (userRole == "companyadmin")
                    {
                        companyid = Session["CompanyName"].ToString();
                    }
                    else
                    {

                        companyid = Session["CompanyName"].ToString();
                    }
                }
                BindData(companyid);
                BindLevelHeirarchyData("d", "d");
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
                string accestype = list.Where(x => x.Screen == "Level Heirarchy").Select(x => x.Value).FirstOrDefault();
                if (accestype == "Read")
                {
                    btnSave.Visible = false;
                }
                else
                {
                    btnSave.Visible = true;
                }
            }
            catch (Exception ex)
            {

            }
        }

        private void BindData(string companyid)
        {
            DataTable dt = DBAccess.getLevelHierarchyData(companyid);
            var distGroup = dt.AsEnumerable().Select(k => k.Field<string>("Entity")).Distinct();
            List<GroupData> listGooup = new List<GroupData>();
            foreach (var groupRow in distGroup)
            {
                GroupData data = new GroupData();
                data.Group = groupRow;
                List<CompanyData> listCompany = new List<CompanyData>();
                var distCompany = dt.AsEnumerable().Where(k => k.Field<string>("Entity") == groupRow).Select(k => k.Field<string>("CompanyID")).Distinct();
                foreach (var companyRow in distCompany)
                {
                    if (companyRow != null && companyRow != "null")
                    {
                        CompanyData dataCompany = new CompanyData();
                        dataCompany.Company = companyRow;
                        List<PlantData1> listPlant = new List<PlantData1>();
                        var distPlant = dt.AsEnumerable().Where(k => k.Field<string>("Entity") == groupRow && k.Field<string>("CompanyID") == companyRow).Select(k => k.Field<string>("PlantID")).Distinct();
                        foreach (var plantRow in distPlant)
                        {
                            if (plantRow != null && plantRow != "null")
                            {
                                PlantData1 dataPlant = new PlantData1();
                                dataPlant.Plant = plantRow;
                                dataPlant.Company = companyRow;
                                dataPlant.Group = groupRow;
                                listPlant.Add(dataPlant);
                            }
                        }
                        if (listPlant.Count == 0)
                        {
                            dataCompany.IconVisibility = "iconhidden";
                        }
                        else
                        {
                            int c = distPlant.Count();
                            dataCompany.IconVisibility = "iconvisible";
                        }
                        dataCompany.PlantList = listPlant;
                        listCompany.Add(dataCompany);
                    }
                }
                data.CompanyList = listCompany;
                if (listCompany.Count == 0)
                {
                    data.IconVisibility = "iconhidden";
                }
                else
                {
                    data.IconVisibility = "iconvisible";
                }
                listGooup.Add(data);
            }

            //List<GroupData> listGooup = new List<GroupData>();
            //GroupData data = new GroupData();
            //data.Group = "Group 1";
            //List<CompanyData> listCompany = new List<CompanyData>();
            //CompanyData dataCompany = new CompanyData();
            //dataCompany.Company="Company 1";
            //List<PlantData1> listPlant = new List<PlantData1>();
            //listPlant.Add(new PlantData1() { Plant = "Plant 1" });
            //listPlant.Add(new PlantData1() { Plant = "Plant 2" });
            //dataCompany.PlantList = listPlant;
            //listCompany.Add(dataCompany);
            //dataCompany = new CompanyData();
            //dataCompany.Company = "Company 2";
            //listPlant = new List<PlantData1>();
            //listPlant.Add(new PlantData1() { Plant = "Plant 1" });
            //listPlant.Add(new PlantData1() { Plant = "Plant 2" });
            //dataCompany.PlantList = listPlant;
            //listCompany.Add(dataCompany);
            //data.CompanyList = listCompany;
            //listGooup.Add(data);



            //data = new GroupData();
            //data.Group = "Group 2";
            //listCompany = new List<CompanyData>();
            //dataCompany = new CompanyData();
            //dataCompany.Company = "Company 3";
            //listPlant = new List<PlantData1>();
            //listPlant.Add(new PlantData1() { Plant = "Plant 1" });
            //listPlant.Add(new PlantData1() { Plant = "Plant 2" });
            //dataCompany.PlantList = listPlant;
            //listCompany.Add(dataCompany);
            //dataCompany = new CompanyData();
            //dataCompany.Company = "Company 4";
            //listPlant = new List<PlantData1>();
            //listPlant.Add(new PlantData1() { Plant = "Plant 4" });
            //listPlant.Add(new PlantData1() { Plant = "Plant 5" });
            //dataCompany.PlantList = listPlant;
            //listCompany.Add(dataCompany);
            //data.CompanyList = listCompany;
            //listGooup.Add(data);

            // gridview.DataSource = listGooup;
            //  gridview.DataBind();
            lvData.DataSource = listGooup;
            lvData.DataBind();
        }

        protected void btnCompany_Click(object sender, EventArgs e)
        {

        }

        protected void lnkGroup_Click(object sender, EventArgs e)
        {
            try
            {
                int index = ((sender as LinkButton).NamingContainer as ListViewItem).DataItemIndex;
                LinkButton linkBtn = (lvData.Items[index].FindControl("lnkGroup") as LinkButton);
                ListView lvCompany = (lvData.Items[index].FindControl("lvCompany") as ListView);
                if (linkBtn.CssClass == "glyphicon glyphicon-chevron-right")
                {
                    linkBtn.CssClass = "glyphicon glyphicon-chevron-down";
                    lvCompany.Visible = true;
                }
                else
                {
                    linkBtn.CssClass = "glyphicon glyphicon-chevron-right";
                    lvCompany.Visible = false;
                }
            }
            catch (Exception ex)
            { }
        }

        protected void lnkCompany_Click(object sender, EventArgs e)
        {
            try
            {
                ListViewItem i1 = (sender as LinkButton).NamingContainer as ListViewItem;
                int index = ((sender as LinkButton).NamingContainer as ListViewItem).DataItemIndex;
                LinkButton linkBtn = i1.FindControl("lnkCompany") as LinkButton;
                ListView lvPlant = i1.FindControl("lvPlant") as ListView;
                if (linkBtn.CssClass == "glyphicon glyphicon-chevron-right")
                {
                    linkBtn.CssClass = "glyphicon glyphicon-chevron-down";
                    lvPlant.Visible = true;
                }
                else
                {
                    linkBtn.CssClass = "glyphicon glyphicon-chevron-right";
                    lvPlant.Visible = false;
                }
            }
            catch (Exception ex)
            { }
        }

        protected void lnkPlant_Click(object sender, EventArgs e)
        {
            try
            {
                ListViewItem items = (sender as LinkButton).NamingContainer as ListViewItem;
                string group = (items.FindControl("hdnGroup") as HiddenField).Value;
                Company = (items.FindControl("hdnCompany") as HiddenField).Value;
                Plant = (items.FindControl("lnkPlant") as LinkButton).Text;
                BindLevelHeirarchyData(Company,Plant);
            }
            catch (Exception ex)
            {

            }
        }
        private void BindLevelHeirarchyData(string company,string plant)
        {
            try
            {
                //string company = "";
                //if (ddlCompany.Visible)
                //{
                //    company = ddlCompany.SelectedValue == null ? "" : ddlCompany.SelectedValue.ToString();
                //}
                List<LevelHeirarchyDetails> dataList = new List<LevelHeirarchyDetails>();
                LevelHeirarchyDetails data = new LevelHeirarchyDetails();
                //data.CompanyID = company;
                //data.PlantID = ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString();
                data.CompanyID = company;
                data.PlantID = plant;
                dataList =DBAccess.getLevelHeirarchyDetails(data);
                if (dataList.Count > 0)
                {
                    cbShop.Checked = dataList.Where(x => x.KeyValue == "Shop").Select(x => x.CheckOrUncheck).FirstOrDefault() == null ? false : dataList.Where(x => x.KeyValue == "Shop").Select(x => x.CheckOrUncheck).FirstOrDefault();
                    lbShop.Visible = dataList.Where(x => x.KeyValue == "Shop").Select(x => x.CheckOrUncheck).FirstOrDefault() == null ? false : dataList.Where(x => x.KeyValue == "Shop").Select(x => x.CheckOrUncheck).FirstOrDefault();

                    cbShopCell.Checked = dataList.Where(x => x.KeyValue == "ShopCell").Select(x => x.CheckOrUncheck).FirstOrDefault() == null ? false : dataList.Where(x => x.KeyValue == "ShopCell").Select(x => x.CheckOrUncheck).FirstOrDefault();
                    lbShopCell.Visible = dataList.Where(x => x.KeyValue == "ShopCell").Select(x => x.CheckOrUncheck).FirstOrDefault() == null ? false : dataList.Where(x => x.KeyValue == "ShopCell").Select(x => x.CheckOrUncheck).FirstOrDefault();

                    cbShopGroup.Checked = dataList.Where(x => x.KeyValue == "ShopGroup").Select(x => x.CheckOrUncheck).FirstOrDefault() == null ? false : dataList.Where(x => x.KeyValue == "ShopGroup").Select(x => x.CheckOrUncheck).FirstOrDefault();
                    lbShopGroup.Visible = dataList.Where(x => x.KeyValue == "ShopGroup").Select(x => x.CheckOrUncheck).FirstOrDefault() == null ? false : dataList.Where(x => x.KeyValue == "ShopGroup").Select(x => x.CheckOrUncheck).FirstOrDefault();

                    cbShopCellGroup.Checked = dataList.Where(x => x.KeyValue == "ShopCellGroup").Select(x => x.CheckOrUncheck).FirstOrDefault() == null ? false : dataList.Where(x => x.KeyValue == "ShopCellGroup").Select(x => x.CheckOrUncheck).FirstOrDefault();
                    lbShopCellGroup.Visible = dataList.Where(x => x.KeyValue == "ShopCellGroup").Select(x => x.CheckOrUncheck).FirstOrDefault() == null ? false : dataList.Where(x => x.KeyValue == "ShopCellGroup").Select(x => x.CheckOrUncheck).FirstOrDefault();

                    cbCell.Checked = dataList.Where(x => x.KeyValue == "Cell").Select(x => x.CheckOrUncheck).FirstOrDefault() == null ? false : dataList.Where(x => x.KeyValue == "Cell").Select(x => x.CheckOrUncheck).FirstOrDefault();
                    lbCell.Visible = dataList.Where(x => x.KeyValue == "Cell").Select(x => x.CheckOrUncheck).FirstOrDefault() == null ? false : dataList.Where(x => x.KeyValue == "Cell").Select(x => x.CheckOrUncheck).FirstOrDefault();

                    cbCellGroup.Checked = dataList.Where(x => x.KeyValue == "CellGroup").Select(x => x.CheckOrUncheck).FirstOrDefault() == null ? false : dataList.Where(x => x.KeyValue == "CellGroup").Select(x => x.CheckOrUncheck).FirstOrDefault();
                    lbCellGroup.Visible = dataList.Where(x => x.KeyValue == "CellGroup").Select(x => x.CheckOrUncheck).FirstOrDefault() == null ? false : dataList.Where(x => x.KeyValue == "CellGroup").Select(x => x.CheckOrUncheck).FirstOrDefault();

                    cbPlantGroup.Checked = dataList.Where(x => x.KeyValue == "Group").Select(x => x.CheckOrUncheck).FirstOrDefault() == null ? false : dataList.Where(x => x.KeyValue == "Group").Select(x => x.CheckOrUncheck).FirstOrDefault();
                    lbGroup.Visible = dataList.Where(x => x.KeyValue == "Group").Select(x => x.CheckOrUncheck).FirstOrDefault() == null ? false : dataList.Where(x => x.KeyValue == "Group").Select(x => x.CheckOrUncheck).FirstOrDefault();

                    hfEffectiveFromDate.Value = dataList.Select(x => x.EffectiveFromDate).FirstOrDefault() == null ? "" : dataList.Select(x => x.EffectiveFromDate).FirstOrDefault();
                }
                else
                {
                    cbShop.Checked = false;
                    cbShopCell.Checked = false;
                    cbShopGroup.Checked = false;
                    cbShopCellGroup.Checked = false;
                    cbCell.Checked = false;
                    cbCellGroup.Checked = false;
                    cbPlantGroup.Checked = false;
                    hfEffectiveFromDate.Value ="";

                    lbShop.Visible = false;
                    lbShopCell.Visible = false;
                    lbShopGroup.Visible = false;
                    lbShopCellGroup.Visible = false;
                    lbCell.Visible = false;
                    lbCellGroup.Visible = false;
                    lbGroup.Visible = false;
                }
               

            }
            catch(Exception ex)
            {

            }
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                List<LevelHeirarchyDetails> datalist = new List<LevelHeirarchyDetails>();
                LevelHeirarchyDetails data = new LevelHeirarchyDetails();
                //data.CompanyID = ddlCompany.SelectedValue==null?"":ddlCompany.SelectedValue.ToString();
                //data.PlantID = ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString();
                data.CompanyID = Company;
                data.PlantID = Plant;
                if (data.CompanyID == "")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openWarningModal('Company ID required.');", true);
                    return;
                }
                if (data.PlantID == "")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openWarningModal('Plant ID required.');", true);
                    return;
                }
                data.EffectiveFromDate = hfEffectiveFromDate.Value == null ? DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") : hfEffectiveFromDate.Value;
                data.EffectiveToDate = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss").ToString();
                if (cbShop.Checked)
                {
                    data.KeyValue = "Shop";
                    DBAccess.saveupdateLevelHeirarchyMenuDetails(data, "Check");
                }
                else
                {
                    data.KeyValue = "Shop";
                    DBAccess.saveupdateLevelHeirarchyMenuDetails(data, "UnCheck");
                }
                if (cbShopCell.Checked)
                {
                    data.KeyValue = "ShopCell";
                    DBAccess.saveupdateLevelHeirarchyMenuDetails(data, "Check");
                }
                else
                {
                    data.KeyValue = "ShopCell";
                    DBAccess.saveupdateLevelHeirarchyMenuDetails(data, "UnCheck");
                }
                if (cbShopGroup.Checked)
                {
                    data.KeyValue = "ShopGroup";
                    DBAccess.saveupdateLevelHeirarchyMenuDetails(data, "Check");
                }
                else
                {
                    data.KeyValue = "ShopGroup";
                    DBAccess.saveupdateLevelHeirarchyMenuDetails(data, "UnCheck");
                }
                if (cbShopCellGroup.Checked)
                {
                    data.KeyValue = "ShopCellGroup";
                    DBAccess.saveupdateLevelHeirarchyMenuDetails(data, "Check");
                }
                else
                {
                    data.KeyValue = "ShopCellGroup";
                    DBAccess.saveupdateLevelHeirarchyMenuDetails(data, "UnCheck");
                }
                if (cbCell.Checked)
                {
                    data.KeyValue = "Cell";
                    DBAccess.saveupdateLevelHeirarchyMenuDetails(data, "Check");
                }
                else
                {
                    data.KeyValue = "Cell";
                    DBAccess.saveupdateLevelHeirarchyMenuDetails(data, "UnCheck");
                }
                if (cbCellGroup.Checked)
                {
                    data.KeyValue = "CellGroup";
                    DBAccess.saveupdateLevelHeirarchyMenuDetails(data, "Check");
                }
                else
                {
                    data.KeyValue = "CellGroup";
                    DBAccess.saveupdateLevelHeirarchyMenuDetails(data, "UnCheck");
                }
                if (cbPlantGroup.Checked)
                {
                    data.KeyValue = "Group";
                    DBAccess.saveupdateLevelHeirarchyMenuDetails(data, "Check");
                }
                else
                {
                    data.KeyValue = "Group";
                    DBAccess.saveupdateLevelHeirarchyMenuDetails(data, "UnCheck");
                }

                if (cbShop.Checked )
                {
                    data.KeyID = "5";
                    data.DisplayValue = "Shop";
                    DBAccess.saveupdateLevelHeirarchyDetails(data, "Check");
                }
                else
                {
                    data.KeyID = "5";
                    data.DisplayValue = "Shop";
                    DBAccess.saveupdateLevelHeirarchyDetails(data, "UnCheck");
                }

                if (cbCell.Checked)
                {
                    data.KeyID = "6";
                    data.DisplayValue = "Cell";
                    DBAccess.saveupdateLevelHeirarchyDetails(data, "Check");
                }
                else
                {
                    data.KeyID = "6";
                    data.DisplayValue = "Cell";
                    DBAccess.saveupdateLevelHeirarchyDetails(data, "UnCheck");
                }
                if (cbPlantGroup.Checked)
                {
                    data.KeyID = "7";
                    data.DisplayValue = "Group";
                    DBAccess.saveupdateLevelHeirarchyDetails(data, "Check");
                }
                else
                {
                    data.KeyID = "7";
                    data.DisplayValue = "Group";
                    DBAccess.saveupdateLevelHeirarchyDetails(data, "UnCheck");
                }
                ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Record saved Successfully.','');", true);
                BindLevelHeirarchyData(Company,Plant);
            }
            catch(Exception ex)
            {

            }
        }


       
        private string getCompanyID()
        {
            string companyID = "";
            try
            {
                //if (userRole == "SuperAdmin")
                //{
                //    companyID = ddlCompany.SelectedValue == null ? "" : ddlCompany.SelectedValue.ToString();
                //}
                //else if (userRole == "CompanyAdmin")
                //{
                //    companyID = lblCompany.Text;
                //}
                //else
                //{
                //    companyID = lblCompany.Text;
                //}
            }
            catch(Exception ex)
            {

            }
            return companyID;
        }
      
        private string getGroupIdForCompany(string companyid)
        {
            string groupid = "None";
            try
            {

                groupid = DBAccess.getGroupIDForCompany(companyid);
                if (groupid == "")
                {
                    groupid = "None";
                }
               // lblGroup.Text = groupid;
                //if (groupid == "")
                //{
                //    grpDiv.Visible = false;
                //}
                //else
                //{
                //    grpDiv.Visible = true;
                //}
            }
            catch (Exception ex)
            {

            }
            return groupid;
        }
      

        protected void lbShop_Click(object sender, EventArgs e)
        {
            try
            {
                string plantID = Plant;
                if (plantID == "")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openWarningModal('Plant ID required.');", true);
                    return;
                }
                Session["LHPlant"] = plantID;
                if (hfLevelType.Value == "")
                {
                    Session["LHLevelTypeToSelect"] = null;
                }
                else
                {
                    Session["LHLevelTypeToSelect"] = hfLevelType.Value;
                }
               
                //Response.Redirect("~/LevelHierarchyMaster.aspx", false);
                ScriptManager.RegisterStartupScript(this, GetType(), "navigation", "onSubMenuClickedToNavigate('LevelHierarchyMaster','LevelHierarchyMaster.aspx');", true);
            }
            catch(Exception ex)
            {

            }
        }
    }
}