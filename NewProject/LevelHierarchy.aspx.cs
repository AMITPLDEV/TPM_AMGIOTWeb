using NewProject.DataBaseAccess;
using NewProject.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NewProject
{
    public partial class LevelHierarchy : System.Web.UI.Page
    {
        private static string userRole = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
             
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
                        // lblCompany.Visible = false;
                        //ddlGroup.Visible = true;
                        //ddlCompany.Visible = true;

                        ddlGroup.Enabled = true;
                        ddlCompany.Enabled = true;
                        BindGroupIDs();
                        BindCompanyIDs();
                        BindPlantIDs();
                    }
                    else if (userRole == "companyadmin")
                    {
                        //ddlGroup.Visible = false;
                        // lblCompany.Visible = true;
                        //ddlCompany.Visible = false;
                        ddlGroup.Enabled = false;
                        ddlCompany.Enabled = false;
                        string grpid=getGroupIdForCompany(Session["CompanyName"].ToString());
                        BindGroupIDs();
                        ddlGroup.SelectedValue = grpid;
                        BindCompanyIDs();
                        ddlCompany.SelectedValue = Session["CompanyName"].ToString();
                        BindPlantIDs();
                    }
                    else
                    {
                        //lblCompany.Visible = true;
                        //ddlCompany.Visible = false;
                        ddlGroup.Enabled = false;
                        ddlCompany.Enabled = false;
                    }
                }
                //lblCompany.Text = (string) Session["CompanyName"];
               
                
              //  BindGroupID();
               
                BindLevelHeirarchyData();
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
        private void BindLevelHeirarchyData()
        {
            try
            {
                string company = "";
                //if (lblCompany.Visible)
                //{
                //    company = lblCompany.Text;
                //}
                if (ddlCompany.Visible)
                {
                    company = ddlCompany.SelectedValue == null ? "" : ddlCompany.SelectedValue.ToString();
                }
                List<LevelHeirarchyDetails> dataList = new List<LevelHeirarchyDetails>();
                LevelHeirarchyDetails data = new LevelHeirarchyDetails();
                data.CompanyID = company;
                data.PlantID = ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString();
                dataList=DBAccess.getLevelHeirarchyDetails(data);
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
                data.CompanyID = ddlCompany.SelectedValue==null?"":ddlCompany.SelectedValue.ToString();
                data.PlantID = ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString();
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
                BindLevelHeirarchyData();
            }
            catch(Exception ex)
            {

            }
        }


        private void BindGroupIDs()
        {
            try
            {

                List<string> grpids = new List<string>();
                grpids = DBAccess.getGroupIDs();
                grpids.Insert(0, "None");
                ddlGroup.DataSource = grpids;
                ddlGroup.DataBind();
            }
            catch (Exception ex)
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
        private void BindPlantIDs()
        {
            try
            {
               
                //string companyID = getCompanyID();
                List<string> plantIDs = new List<string>();
                plantIDs = DBAccess.getPlantsIDs(ddlCompany.SelectedValue==null?"":ddlCompany.SelectedValue.ToString());
                ddlPlant.DataSource = plantIDs;
                ddlPlant.DataBind();
                if (Session["CHPlant"] != null)
                {
                    ddlPlant.SelectedValue = Session["CHPlant"].ToString();
                }
            }
            catch (Exception ex)
            {

            }
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
        private void BindCompanyIDs()
        {
            try
            {

                List<string> companyIDs = new List<string>();
                companyIDs = DBAccess.getCompanyIDs(ddlGroup.SelectedValue==null?"":ddlGroup.SelectedValue.ToString());
                ddlCompany.DataSource = companyIDs;
                ddlCompany.DataBind();
            }
            catch (Exception ex)
            {

            }
        }
        protected void ddlCompany_SelectedIndexChanged(object sender, EventArgs e)
        {
           // BindGroupID();
            BindPlantIDs();
            BindLevelHeirarchyData();
        }

        protected void ddlPlant_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["CHPlant"] = ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString();
            BindLevelHeirarchyData();
        }

        protected void lbShop_Click(object sender, EventArgs e)
        {
            try
            {
                string plantID = ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString();
              
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

        protected void ddlGroup_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindCompanyIDs();
            BindPlantIDs();
            BindLevelHeirarchyData();
        }
    }
}