using NewProject.DataBaseAccess;
using NewProject.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NewProject
{
    public partial class LevelHierarchyMaster : System.Web.UI.Page
    {
        private static int PlantIndexToDelete = -1, ShopIndexToDelete = -1, ShopCellIndexToDelete = -1, ShopGroupIndexToDelete = -1, ShopCellGroupIndexToDelete = -1, selectedDeleteRowIndex=-1, RoleIndexToDelete=-1;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //Session["LHPlant"] = null;
                BindCountry();
                string company = (string)Session["CompanyName"];
                //lblCompany_ForShop.Text = company;
                //lblCompany_ForPlantGroup.Text = company;
               // lblCompany_ForCell.Text = company;
                //lblCompany_ForAssignMachine.Text = company;
                lblCompany_ForRoleNewEdit.Text = company;
                lblCompany.Text = company;
                
                BindPlantIDs();
                // btnEmployee_Click(null, null);
                // ScriptManager.RegisterStartupScript(this, this.GetType(), "setActiveValue", "setActiveSubmenuValue();", true);
                ShowHideList(Session["CompanyName"]==null?"": Session["CompanyName"].ToString(), ddlPlant.SelectedValue==null?"":ddlPlant.SelectedValue.ToString(),"",false);
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
                   
                    btnNewPlantShop.Visible = false;
                    DBAccess.ShowHideActionColumnOfGrid(gvShopDetails, false);
                    btnNewOrEditShopCell.Visible = false;
                    DBAccess.ShowHideActionColumnOfGrid(gvShopCellDetails, false);
                    btnNewOrEditShopCellGroup.Visible = false;
                    DBAccess.ShowHideActionColumnOfGrid(gvShopCellGroupDetails, false);
                    btnNewOrEditShopGroup.Visible = false;
                    DBAccess.ShowHideActionColumnOfGrid(gvShopGroupDetails, false);
                    btnCellNew.Visible = false;
                    DBAccess.ShowHideActionColumnOfGrid(gvCellData, false);
                    btnCGNew.Visible = false;
                    DBAccess.ShowHideActionColumnOfGrid(gvCellGroupData, false);
                    btnPlantGroupNew.Visible = false;
                    DBAccess.ShowHideActionColumnOfGrid(gvPlantGroupData, false);
                    btnAssignMachineToCellSave.Visible = false;
                    btnAssignMachineToShopSave.Visible = false;
                    btnAssignMachineToGroupSave.Visible = false;
                }
                else
                {
                   
                    btnNewPlantShop.Visible = true;
                    DBAccess.ShowHideActionColumnOfGrid(gvShopDetails, true);
                    btnNewOrEditShopCell.Visible = true;
                    DBAccess.ShowHideActionColumnOfGrid(gvShopCellDetails, true);
                    btnNewOrEditShopCellGroup.Visible = true;
                    DBAccess.ShowHideActionColumnOfGrid(gvShopCellGroupDetails, true);
                    btnNewOrEditShopGroup.Visible = true;
                    DBAccess.ShowHideActionColumnOfGrid(gvShopGroupDetails, true);
                    btnCellNew.Visible = true;
                    DBAccess.ShowHideActionColumnOfGrid(gvCellData, true);
                    btnCGNew.Visible = true;
                    DBAccess.ShowHideActionColumnOfGrid(gvCellGroupData, true);
                    btnPlantGroupNew.Visible = true;
                    DBAccess.ShowHideActionColumnOfGrid(gvPlantGroupData, true);
                    btnAssignMachineToCellSave.Visible = true;
                    btnAssignMachineToShopSave.Visible = true;
                    btnAssignMachineToGroupSave.Visible = true;
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        private void ShowHideList(string companyID,string plantID,string type, bool isMachine)
        {
            try
            {
                if (plantID == "DisablePlantLevelMenu")
                {
                    Shop.Visible = false;
                    Cell.Visible = false;
                    Group.Visible =false;
                    return;
                }
                List<LevelHeirarchyDetails> shopcelllist = new List<LevelHeirarchyDetails>();
                shopcelllist = DBAccess.getCheckedShopCellList(companyID, plantID);
                if (type == "Shop")
                {
                    if (shopcelllist.Where(x => x.KeyValue == "Shop").Select(x => x.CheckOrUncheck).FirstOrDefault())
                    {
                        ShopGroup.Attributes.Add("style", shopcelllist.Where(x => x.KeyValue == "ShopGroup").Select(x => x.Display).FirstOrDefault() == null ? "display:none" : shopcelllist.Where(x => x.KeyValue == "ShopGroup").Select(x => x.Display).FirstOrDefault());
                        ShopCell.Attributes.Add("style", shopcelllist.Where(x => x.KeyValue == "ShopCell").Select(x => x.Display).FirstOrDefault() == null ? "display:none" : shopcelllist.Where(x => x.KeyValue == "ShopCell").Select(x => x.Display).FirstOrDefault());
                        ShopCellGroup.Attributes.Add("style", shopcelllist.Where(x => x.KeyValue == "ShopCellGroup").Select(x => x.Display).FirstOrDefault() == null ? "display:none" : shopcelllist.Where(x => x.KeyValue == "ShopCellGroup").Select(x => x.Display).FirstOrDefault());
                        //ScriptManager.RegisterStartupScript(this, this.GetType(), "setActiveValueShop", "setSubActiveMenu('Shop');", true);


                        btnassignShop.Visible = true;
                        btnassignShopCell.Visible = shopcelllist.Where(x => x.KeyValue == "ShopCell").Select(x => x.CheckOrUncheck).FirstOrDefault();
                        btnassignShopCellGroup.Visible = shopcelllist.Where(x => x.KeyValue == "ShopCellGroup").Select(x => x.CheckOrUncheck).FirstOrDefault();
                        btnassignShopGroup.Visible = shopcelllist.Where(x => x.KeyValue == "ShopGroup").Select(x => x.CheckOrUncheck).FirstOrDefault();
                    }
                    else
                    {
                        ShopGroup.Attributes.Add("style", "display:none");
                        ShopCell.Attributes.Add("style", "display:none");
                        ShopCellGroup.Attributes.Add("style", "display:none");
                        // ScriptManager.RegisterStartupScript(this, this.GetType(), "setActiveValueShop", "setSubActiveMenu('Shop');", true);

                        btnassignShop.Visible = false;
                        btnassignShopCell.Visible = false;
                        btnassignShopCellGroup.Visible = false;
                        btnassignShopGroup.Visible = false;
                    }
                    if (!isMachine)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "setActiveValueShop", "setSubActiveMenu('Shop');", true);
                    }
                }
                else if (type == "Cell")
                {
                    if (shopcelllist.Where(x => x.KeyValue == "Cell").Select(x => x.CheckOrUncheck).FirstOrDefault())
                    {
                        CellGroup.Attributes.Add("style", shopcelllist.Where(x => x.KeyValue == "CellGroup").Select(x => x.Display).FirstOrDefault() == null ? "display:none" : shopcelllist.Where(x => x.KeyValue == "CellGroup").Select(x => x.Display).FirstOrDefault());
                       // ScriptManager.RegisterStartupScript(this, this.GetType(), "setActiveValueCell", "setSubActiveMenu('Cell');", true);

                        btnassignCell.Visible = true;
                        btnassignCellGroup.Visible = shopcelllist.Where(x => x.KeyValue == "CellGroup").Select(x => x.CheckOrUncheck).FirstOrDefault();
                    }
                    else
                    {
                        CellGroup.Attributes.Add("style", "display:none");
                      //  ScriptManager.RegisterStartupScript(this, this.GetType(), "setActiveValueCell", "setSubActiveMenu('Cell');", true);

                        btnassignCell.Visible = false;
                        btnassignCellGroup.Visible = false;
                    }
                    if (!isMachine)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "setActiveValueCell", "setSubActiveMenu('Cell');", true);
                    }
                }
                else
                {
                    Shop.Visible = shopcelllist.Where(x => x.KeyValue == "Shop").Select(x => x.CheckOrUncheck).FirstOrDefault();
                    Cell.Visible = shopcelllist.Where(x => x.KeyValue == "Cell").Select(x => x.CheckOrUncheck).FirstOrDefault();
                    Group.Visible = shopcelllist.Where(x => x.KeyValue == "Group").Select(x => x.CheckOrUncheck).FirstOrDefault();


                    AssignMachineToShop.Visible = shopcelllist.Where(x => x.KeyValue == "Shop").Select(x => x.CheckOrUncheck).FirstOrDefault();
                    AssignMachineToCell.Visible = shopcelllist.Where(x => x.KeyValue == "Cell").Select(x => x.CheckOrUncheck).FirstOrDefault();
                    AssignMachineToGroup.Visible = shopcelllist.Where(x => x.KeyValue == "Group").Select(x => x.CheckOrUncheck).FirstOrDefault();


                    if (!isMachine)
                    {
                        if(Session["LHLevelTypeToSelect"] !=null)
                        {
                            string leveltype = Session["LHLevelTypeToSelect"].ToString();
                            if (leveltype == "Shop")
                            {
                                btnShop_Click(null, null);
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "setActiveValuePlant", "setPlantLevelMenu('#LHmastermenu4');", true);
                            }else
                            if (leveltype == "Cell")
                            {
                                btnCell_Click(null, null);
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "setActiveValuePlant", "setPlantLevelMenu('#LHmastermenu5');", true);
                            }else
                            if (leveltype == "Group")
                            {
                                btnPlantGroup_Click(null, null);
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "setActiveValuePlant", "setPlantLevelMenu('#LHmastermenu6');", true);
                            }
                            else
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openWarningModal('Not assigned any levels.');", true);
                            }

                            
                            Session["LHLevelTypeToSelect"] =null;
                        }
                        else
                        {
                            if (Shop.Visible)
                            {
                                btnShop_Click(null, null);
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "setActiveValuePlant", "setPlantLevelMenu('#LHmastermenu4');", true);
                            }
                            else if (Cell.Visible)
                            {
                                btnCell_Click(null, null);
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "setActiveValuePlant", "setPlantLevelMenu('#LHmastermenu5');", true);
                            }
                            else if (Group.Visible)
                            {
                                btnPlantGroup_Click(null, null);
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "setActiveValuePlant", "setPlantLevelMenu('#LHmastermenu6');", true);
                            }
                            else
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openWarningModal('Not assigned any levels.');", true);
                            }
                        }
                        
                    }
                    else
                    {

                        if (Shop.Visible)
                        {
                            btnAssignMachineToShop_Click(null, null);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "setActiveValuePlant", "setActiveAssignMachineMenu('#assignMachinemenu3');", true);
                        }
                        else if (Cell.Visible)
                        {
                            btnAssignMachineToCell_Click(null, null);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "setActiveValuePlant", "setActiveAssignMachineMenu('#assignMachinemenu1');", true);
                        }
                        else if (Group.Visible)
                        {
                           btnAssignMachineToGroup_Click(null, null);
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "setActiveValuePlant", "setActiveAssignMachineMenu('#assignMachinemenu2');", true);
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openWarningModal('Not assigned any levels.');", true);
                        }
                        //ScriptManager.RegisterStartupScript(this, this.GetType(), "setActivePlantMenu", "setActiveAssignMachineMenu();", true);
                    }
                   
                }

            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }


        private void BindCountry()
        {
            try
            {
                List<string> country = new List<string>();
                country = DBAccess.getCountry();
                country.Insert(0, "");
                //ddlPlantCountry.DataSource = country;
                //ddlPlantCountry.DataBind();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }
        private void BindPlantIDs()
        {
            try
            {
                List<string> plantIDs = new List<string>();
                plantIDs = DBAccess.getPlantsIDs(Session["CompanyName"].ToString());
                ddlPlant_ForShopEditNew.DataSource = plantIDs;
                ddlPlant_ForShopEditNew.DataBind();
                ddlPlant_ForShopCellNewEdit.DataSource = plantIDs;
                ddlPlant_ForShopCellNewEdit.DataBind();
                ddlPlant_ForShopGroupNewEdit.DataSource = plantIDs;
                ddlPlant_ForShopGroupNewEdit.DataBind();
                ddlPlant_ForShopCellGroupNewEdit.DataSource = plantIDs;
                ddlPlant_ForShopCellGroupNewEdit.DataBind();

                ddlPlant.DataSource = plantIDs;
                ddlPlant.DataBind();

                if (plantIDs.Count > 1)
                {
                    plantIDs.Insert(0, "All");
                }
                //ddlPlant_ShopView.DataSource = plantIDs;
                //ddlPlant_ShopView.DataBind();
                //ddlPlantForCell.DataSource = plantIDs;
                //ddlPlantForCell.DataBind();
                //ddlPlant_ForGroup.DataSource = plantIDs;
                //ddlPlant_ForGroup.DataBind();

                ddlPlant.SelectedValue = (string)Session["LHPlant"];
                ddlPlant_ForShopEditNew.SelectedValue = (string)Session["LHPlant"];
                ddlPlant_ForShopCellNewEdit.SelectedValue = (string)Session["LHPlant"];
                ddlPlant_ForShopGroupNewEdit.SelectedValue = (string)Session["LHPlant"];
                ddlPlant_ForShopCellGroupNewEdit.SelectedValue = (string)Session["LHPlant"];
               // ddlPlant_ShopView.SelectedValue = (string)Session["LHPlant"];
              //  ddlPlantForCell.SelectedValue = (string)Session["LHPlant"];
                //ddlPlant_ForGroup.SelectedValue = (string)Session["LHPlant"];

              //  ddlPlant_ShopView.Enabled = false;
               // ddlPlantForCell.Enabled = false;
                //ddlPlant_ForGroup.Enabled = false;
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }
    
        private void BindShopIDsForView(string plantid)
        {
            try
            {
                List<string> shopIDs = new List<string>();
                shopIDs = DBAccess.getShopIDs(Session["CompanyName"].ToString(),plantid);
                if (shopIDs.Count > 1)
                {
                    shopIDs.Insert(0, "All");
                }
                ddlShop_ForShopCellView.DataSource = shopIDs;
                ddlShop_ForShopCellView.DataBind();
                ddlShop_ForShopGroupView.DataSource = shopIDs;
                ddlShop_ForShopGroupView.DataBind();
                ddlShop_ForShopCellGroupView.DataSource = shopIDs;
                ddlShop_ForShopCellGroupView.DataBind();

                //BindCellIDsForView(plantid, ddlShop_ForShopCellGroupView.SelectedValue == null ? "" : ddlShop_ForShopCellGroupView.SelectedValue.ToString());
                BindCellIDsForView(plantid, lblShop_ForShopCellGroupView.Text);
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }
        private void BindShopIDsForNewEdit(string plantid)
        {
            try
            {
                List<string> shopIDs = new List<string>();
                shopIDs = DBAccess.getShopIDs(Session["CompanyName"].ToString(), plantid);
                ddlShop_ForShopCellNewEdit.DataSource = shopIDs;
                ddlShop_ForShopCellNewEdit.DataBind();
                ddlShop_ForShopGroupNewEdit.DataSource = shopIDs;
                ddlShop_ForShopGroupNewEdit.DataBind();
                ddlShop_ForShopCellGRoupNewEdit.DataSource = shopIDs;
                ddlShop_ForShopCellGRoupNewEdit.DataBind();
                BindCellIDsForEditNew(plantid, ddlShop_ForShopCellGRoupNewEdit.SelectedValue == null ? "" : ddlShop_ForShopCellGRoupNewEdit.SelectedValue.ToString());
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }
        private void BindCellIDsForView(string plant,string shop)
        {
            try
            {
                List<string> cellIDs = new List<string>();
                cellIDs = DBAccess.getCellIDs(Session["CompanyName"].ToString(), plant,shop);
                if (cellIDs.Count > 1)
                {
                    cellIDs.Insert(0, "All");
                }
                ddlCell_ForShopCellGroupView.DataSource = cellIDs;
                ddlCell_ForShopCellGroupView.DataBind();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }
        private void BindCellIDsForEditNew(string plant, string shop)
        {
            try
            {
                List<string> cellIDs = new List<string>();
                cellIDs = DBAccess.getCellIDs(Session["CompanyName"].ToString(), plant, shop);
                ddlCell_ForShopCellGroupNewEdit.DataSource = cellIDs;
                ddlCell_ForShopCellGroupNewEdit.DataBind();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }
        private void BindPlantIDsForAssignMachines(DropDownList ddl, bool isAllRequired, string type)
        {
            try
            {
                ddl.DataSource = DBAccess.getLevelAssignedPlantIDs(Session["CompanyName"].ToString(), type);
                ddl.DataBind();
                if (isAllRequired)
                {
                    ddl.Items.Insert(0, "All");
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        private void BindShopIDs(DropDownList ddl, string plantid, bool isAllRequired)
        {
            try
            {
                ddl.DataSource = DBAccess.getShopIDs(Session["CompanyName"].ToString(), plantid);
                ddl.DataBind();
                if (isAllRequired)
                {
                    ddl.Items.Insert(0, "All");
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        private void BindShopIDsForMultiSelect(ListBox ddl, string plantid, bool isAllRequired)
        {
            try
            {
                ddl.DataSource = DBAccess.getShopIDs(Session["CompanyName"].ToString(), plantid);
                ddl.DataBind();
                if (isAllRequired)
                {
                    ddl.Items.Insert(0, "All");
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        private void BindCellIDs(DropDownList ddl, string plant, string shop, bool isAllRequired)
        {
            try
            {
                List<string> cellIDs = new List<string>();
                cellIDs = DBAccess.getCellIDs(Session["CompanyName"].ToString(), plant, shop);
                ddl.DataSource = cellIDs;
                ddl.DataBind();
                if (isAllRequired)
                {
                    ddl.Items.Insert(0, "All");
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        private void BindCellIDsForMultiSelect(ListBox ddl, string plant, string shop, bool isAllRequired)
        {
            try
            {
                List<string> cellIDs = new List<string>();
                cellIDs = DBAccess.getCellIDs(Session["CompanyName"].ToString(), plant, shop);
                ddl.DataSource = cellIDs;
                ddl.DataBind();
                if (isAllRequired)
                {
                    ddl.Items.Insert(0, "All");
                }
            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace(ex, true);
                Logger.WriteErrorLog($"Error : {ex.Message} at Page : {stackTrace.GetFrame(0).GetFileName()} in Method : {stackTrace.GetFrame(1).GetMethod().Name} at Line Number :  {stackTrace.GetFrame(0).GetFileLineNumber()}");
            }
        }
        private void BindGroupIDs(DropDownList ddl, string plant, string shop,string cell, bool isAllRequired)
        {
            try
            {
                List<string> groupids = new List<string>();
                groupids = DBAccess.getGroupIDs(Session["CompanyName"].ToString(), plant, shop,cell);
                ddl.DataSource = groupids;
                ddl.DataBind();
                if (isAllRequired)
                {
                    ddl.Items.Insert(0, "All");
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        private void BindGroupIDsForMultiSelect(ListBox ddl, string plant, string shop, string cell, bool isAllRequired)
        {
            try
            {
                List<string> groupids = new List<string>();
                groupids = DBAccess.getGroupIDs(Session["CompanyName"].ToString(), plant, shop, cell);
                ddl.DataSource = groupids;
                ddl.DataBind();
                if (isAllRequired)
                {
                    ddl.Items.Insert(0, "All");
                }
            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace(ex, true);
                Logger.WriteErrorLog($"Error : {ex.Message} at Page : {stackTrace.GetFrame(0).GetFileName()} in Method : {stackTrace.GetFrame(1).GetMethod().Name} at Line Number :  {stackTrace.GetFrame(0).GetFileLineNumber()}");
            }
        }
        //private void BindGroupIDsForNewEdit(string plantID)
        //{
        //    try
        //    {
        //        List<string>   = new List<string>();
        //        grpIDs = DBAccess.getGroupIDsWithPlantFiletr(Session["CompanyName"].ToString(), plantID);
        //        ddlShop_ForShopCellNewEdit.DataSource = grpIDs;
        //        ddlShop_ForShopCellNewEdit.DataBind();
        //    }
        //    catch (Exception ex)
        //    {

        //    }
        //}

        protected void btnRole_Click(object sender, EventArgs e)
        {
            BindRoleData();
            ShowHideList("", "DisablePlantLevelMenu", "",false);
        }

        protected void btnPlant_Click(object sender, EventArgs e)
        {
            //try
            //{

            //    BindPlantData();
            //    ShowHideList("", "DisablePlantLevelMenu", "");
            //}
            //catch(Exception ex)
            //{

            //}
        }

      
        protected void btnShop_Click(object sender, EventArgs e)
        {
            try
            {

                Session["LHShop"] = null;
                BindPlantIDs();
                //BindShopIDsForView(ddlPlant_ShopView.SelectedValue == null ? "" : ddlPlant_ShopView.SelectedValue.ToString());
                BindShopIDsForView(ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString());

                ddlPlant_ForShopCellNewEdit_SelectedIndexChanged(null, null);
                ddlPlant_ForShopGroupNewEdit_SelectedIndexChanged(null, null);
                ddlPlant_ForShopCellGroupNewEdit_SelectedIndexChanged(null, null);
                //BindCellIDsForView(ddlPlant_ShopView.SelectedValue == null ? "" : ddlPlant_ShopView.SelectedValue.ToString(), ddlShop_ForShopCellGroupView.SelectedValue == null ? "" : ddlShop_ForShopCellGroupView.SelectedValue.ToString());
                //BindCellIDsForEditNew(ddlPlant_ShopView.SelectedValue == null ? "" : ddlPlant_ShopView.SelectedValue.ToString(), ddlShop_ForShopCellGroupView.SelectedValue == null ? "" : ddlShop_ForShopCellGroupView.SelectedValue.ToString());
                //BindCellIDsForView(ddlPlant_ShopView.SelectedValue == null ? "" : ddlPlant_ShopView.SelectedValue.ToString(), lblShop_ForShopCellGroupView.Text);
                //BindCellIDsForEditNew(ddlPlant_ShopView.SelectedValue == null ? "" : ddlPlant_ShopView.SelectedValue.ToString(), ddlShop_ForShopCellGRoupNewEdit.SelectedValue == null ? "" : ddlShop_ForShopCellGRoupNewEdit.SelectedValue.ToString());
                BindCellIDsForView(ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString(), lblShop_ForShopCellGroupView.Text);
                BindCellIDsForEditNew(ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString(), ddlShop_ForShopCellGRoupNewEdit.SelectedValue == null ? "" : ddlShop_ForShopCellGRoupNewEdit.SelectedValue.ToString());
                BindPlantShopData();
                BindShopCellData();
                BindShopGroupData();
                BindShopCellGroupData();
                ShowHideList(Session["CompanyName"].ToString(), ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString(),"Shop",false);
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        protected void btnShopGroup_Click(object sender, EventArgs e)
        {
            BindShopGroupData();
        }

        protected void btnShopCellGroup_Click(object sender, EventArgs e)
        {

            //BindCellIDsForView(ddlPlant_ShopView.SelectedValue == null ? "" : ddlPlant_ShopView.SelectedValue.ToString(), ddlShop_ForShopCellGroupView.SelectedValue == null ? "" : ddlShop_ForShopCellGroupView.SelectedValue.ToString());
            //BindCellIDsForEditNew(ddlPlant_ShopView.SelectedValue == null ? "" : ddlPlant_ShopView.SelectedValue.ToString(), ddlShop_ForShopCellGroupView.SelectedValue == null ? "" : ddlShop_ForShopCellGroupView.SelectedValue.ToString());
            //BindPlantIDs();
            //ddlPlant_ForShopCellGroupNewEdit_SelectedIndexChanged(null, null);
            BindCellIDsForView(ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString(), lblShop_ForShopCellGroupView.Text);
            BindCellIDsForEditNew(ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString(), ddlShop_ForShopCellGRoupNewEdit.SelectedValue == null ? "" : ddlShop_ForShopCellGRoupNewEdit.SelectedValue.ToString());
            BindShopCellGroupData();
        }

        protected void btnShopCell_Click(object sender, EventArgs e)
        {
            BindShopCellData();
        }


       
        #region ------Shop------
        private void setShopDetailsRowColor(string shopid)
        {
            try
            {
                lblShop_ForShopCellView.Text = shopid;
                lblShop_ForShopCellGroupView.Text = shopid;
                lblShop_ForShopGroupView.Text = shopid;
                foreach (GridViewRow row in gvShopDetails.Rows)
                {
                    //if (row.RowIndex == gvShopDetails.SelectedIndex)
                    //{
                    //    row.BackColor = ColorTranslator.FromHtml("red");
                    //}
                    //else
                    //{
                    //    row.BackColor = System.Drawing.Color.Transparent;/*ColorTranslator.FromHtml("#FFFFFF");*/
                    //}
                    if((row.FindControl("lblShopID") as Label).Text == shopid)
                    {
                        row.BackColor = ColorTranslator.FromHtml("red");
                    }
                    else
                    {
                        row.BackColor = System.Drawing.Color.Transparent;
                    }
                }
                BindCellIDsForView(ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString(), lblShop_ForShopCellGroupView.Text);
                BindCellIDsForEditNew(ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString(), ddlShop_ForShopCellGRoupNewEdit.SelectedValue == null ? "" : ddlShop_ForShopCellGRoupNewEdit.SelectedValue.ToString());
                BindShopCellData();
                BindShopGroupData();
                BindShopCellGroupData();
            }
            catch(Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
         
        }
        protected void gvShopDetails_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                //int index = gvShopDetails.SelectedRow.RowIndex;
                //string slno = gvShopDetails.SelectedRow.Cells[0].Text;
                //string partnumber = gvShopDetails.SelectedRow.Cells[1].Text;
                //string line = gvShopDetails.SelectedRow.Cells[2].Text;
                string shopid = (gvShopDetails.SelectedRow.FindControl("lblShopID") as Label).Text;
                Session["LHShop"] = shopid;
                setShopDetailsRowColor(shopid);


            }
            catch (Exception ex)
            {
                StackTrace stackTrace = new StackTrace(ex, true);
                Logger.WriteErrorLog($"Error : {ex.Message} at Page : {stackTrace.GetFrame(0).GetFileName()} in Method : {stackTrace.GetFrame(1).GetMethod().Name} at Line Number :  {stackTrace.GetFrame(0).GetFileLineNumber()}");
            }
        }

        protected void gvShopDetails_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(gvShopDetails, "Select$" + e.Row.RowIndex);
                e.Row.Attributes["style"] = "cursor:pointer";
            }
        }
        private void BindPlantShopData()
        {
            try
            {
                List<PlantLevelDetails> plantDetails = new List<PlantLevelDetails>();
                PlantLevelDetails data = new PlantLevelDetails();
                data.CompanyID = Session["CompanyName"].ToString();
                data.PlantID = ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString();
                plantDetails = DBAccess.getPlantShopDetails(data);
                gvShopDetails.DataSource = plantDetails;
                gvShopDetails.DataBind();
                if (Session["LHShop"] == null)
                {
                    if (gvShopDetails.Rows.Count > 0)
                    {
                        Session["LHShop"] = (gvShopDetails.Rows[0].FindControl("lblShopID") as Label).Text;
                    }
                }
                setShopDetailsRowColor(Session["LHShop"].ToString());
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }

        }
        protected void btnNewEditPlantShop_Click(object sender, EventArgs e)
        {
            try
            {
                PlantLevelDetails data = new PlantLevelDetails();
                data.CompanyID = Session["CompanyName"].ToString();
                data.PlantID = ddlPlant_ForShopEditNew.SelectedValue == null ? "" : ddlPlant_ForShopEditNew.SelectedValue.ToString();
                data.ShopID = txtShopID.Text;
                data.Description = txtShopDesc.Text;
                data.GeoLocation = txtShopGeoLocation.Text;
                data.EffectiveFromDate = Util.GetDateTime(txtShopEffFromDate.Text).ToString("yyyy-MM-dd HH:mm:ss");
                data.EffectiveToDate = Util.GetDateTime(txtShopEffToDate.Text).ToString("yyyy-MM-dd HH:mm:ss");
                data.NewOrEditParam = hfShopEditNew.Value;
                string date = DBAccess.checkShopEffectiveDate(data);
                if (date == "")
                {

                }
                else
                {
                    DateTime maxEfffromdate, enteredEffeFromDate;
                    maxEfffromdate = Util.GetDateTime(date);
                    enteredEffeFromDate = Util.GetDateTime(data.EffectiveFromDate);
                    if (enteredEffeFromDate <= maxEfffromdate)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openWarningModal('Effective from date should be greater than " + maxEfffromdate.ToString("dd-MM-yyyy HH:mm:ss") + "');", true);
                        return;
                    }
                }
                string Success = DBAccess.saveUpdatePlantShopDetails(data);
                if (Success == "Exist")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openWarningModal('Shop ID already exists.');", true);
                }
                else if (Success == "Inserted")
                {
                    BindShopIDsForView(ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString());
                    ddlPlant_ForShopGroupNewEdit_SelectedIndexChanged(null, null);
                    ddlPlant_ForShopCellNewEdit_SelectedIndexChanged(null, null);
                    ddlPlant_ForShopCellGroupNewEdit_SelectedIndexChanged(null, null);
                    BindPlantShopData();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Record saved Successfully.','');", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "clearAllModalScreen()", true);
                }
                else if (Success == "Updated")
                {
                    BindPlantShopData();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Record updated Successfully.','');", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "clearAllModalScreen()", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "openErrorModal('Failed to insert record.');", true);
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }

        protected void btnPlantShopView_Click(object sender, EventArgs e)
        {
            try
            {
                BindPlantShopData();
                ReBindningGrids_Shop();
            }
            catch(Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
           
        }


        protected void lbDeleteShop_Click(object sender, EventArgs e)
        {
            try
            {
               ShopIndexToDelete = Convert.ToInt32(((sender as LinkButton).NamingContainer as GridViewRow).RowIndex);
                string deleteMsg = "Are you sure you want to delete Shop ID " + (gvShopDetails.Rows[ShopIndexToDelete].FindControl("lblShopID") as Label).Text  + ".";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "openPlantShopDeleteConfirmModal('" + deleteMsg + " ?')", true);
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }

        protected void btnDeletePlantShopConfirm_Click(object sender, EventArgs e)
        {
            try
            {
                PlantLevelDetails data = new PlantLevelDetails();
                data.CompanyID = (gvShopDetails.Rows[ShopIndexToDelete].FindControl("lblCompanyID") as Label).Text;
                data.PlantID = (gvShopDetails.Rows[ShopIndexToDelete].FindControl("lblPlantID") as Label).Text;
                data.ShopID = (gvShopDetails.Rows[ShopIndexToDelete].FindControl("lblShopID") as Label).Text;
                data.GroupID = "";
                data.CellID = "";
                data.EffectiveFromDate = Util.GetDateTime(((gvShopDetails.Rows[ShopIndexToDelete].FindControl("lblEffevtiveFromDate") as Label).Text)).ToString("yyyy-MM-dd HH:mm:ss");
                data.EffectiveToDate = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                int result = DBAccess.deleteShopCellGroupDetails(data,"Shop");
                if (result > 0)
                {
                    
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Record deleted Successfully.','');", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "clearAllModalScreen()", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "openErrorModal('Failed to delete record.');", true);
                    return;
                }
                ReBindningGrids_Shop();
                BindPlantShopData();
                ShopIndexToDelete = -1;
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }

        }

        private void ReBindningGrids_Shop()
        {
            try
            {
                BindShopIDsForView(ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString());
                BindShopCellData();
                BindShopGroupData();
                BindShopCellGroupData();
            }
            catch(Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }

        }
        #endregion

        #region -----Shop Cell-------------------
        private void BindShopCellData()
        {

            try
            {
                List<PlantLevelDetails> plantDetails = new List<PlantLevelDetails>();
                PlantLevelDetails data = new PlantLevelDetails();
                data.CompanyID = Session["CompanyName"].ToString();
                data.PlantID = ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString();
                //data.ShopID = ddlShop_ForShopCellView.SelectedValue == null ? "" : ddlShop_ForShopCellView.SelectedValue.ToString();
                data.ShopID = lblShop_ForShopCellView.Text;
                plantDetails = DBAccess.getShopCellDetails(data);
                gvShopCellDetails.DataSource = plantDetails;
                gvShopCellDetails.DataBind();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }
        protected void btnNewEditShopCellSave_Click(object sender, EventArgs e)
        {
            try
            {
                PlantLevelDetails data = new PlantLevelDetails();
                data.CompanyID = Session["CompanyName"].ToString();
                data.PlantID = ddlPlant_ForShopCellNewEdit.SelectedValue == null ? "" : ddlPlant_ForShopCellNewEdit.SelectedValue.ToString();
                data.ShopID = ddlShop_ForShopCellNewEdit.SelectedValue == null ? "" : ddlShop_ForShopCellNewEdit.SelectedValue.ToString();
                data.CellID = txtCellID.Text;
                data.Description = txtCellDesc.Text;
                data.EffectiveFromDate = Util.GetDateTime(txtCellEffFromDate.Text).ToString("yyyy-MM-dd HH:mm:ss");
                data.EffectiveToDate = Util.GetDateTime(txtCellEffToDate.Text).ToString("yyyy-MM-dd HH:mm:ss");
                data.NewOrEditParam = hfShopCellEditNew.Value;
                string date = DBAccess.checkShopCellEffectiveDate(data);
                if (date == "")
                {

                }
                else
                {
                    DateTime maxEfffromdate, enteredEffeFromDate;
                    maxEfffromdate = Util.GetDateTime(date);
                    enteredEffeFromDate = Util.GetDateTime(data.EffectiveFromDate);
                    if (enteredEffeFromDate <= maxEfffromdate)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openWarningModal('Effective from date should be greater than " + maxEfffromdate.ToString("dd-MM-yyyy HH:mm:ss") + "');", true);
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "openModal('neweditShopCellModal')", true);
                        return;
                    }
                }
                string Success = DBAccess.saveUpdateShopCellDetails(data);
                if (Success == "Exist")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openWarningModal('Cell ID already exists.');", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "openModal('neweditShopCellModal')", true);
                }
                else if (Success == "Inserted")
                {
                    BindShopCellData();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Record saved Successfully.','');", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "clearAllModalScreen()", true);
                }
                else if (Success == "Updated")
                {
                    BindShopCellData();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Record updated Successfully.','');", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "clearAllModalScreen()", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "openErrorModal('Failed to insert record.');", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "openModal('neweditShopCellModal')", true);
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }

        protected void btnDeleteShopCellConfirmation_Click(object sender, EventArgs e)
        {
            try
            {
                PlantLevelDetails data = new PlantLevelDetails();
                data.CompanyID = (gvShopCellDetails.Rows[ShopCellIndexToDelete].FindControl("lblCompanyID") as Label).Text;
                data.PlantID = (gvShopCellDetails.Rows[ShopCellIndexToDelete].FindControl("lblPlantID") as Label).Text;
                data.ShopID = (gvShopCellDetails.Rows[ShopCellIndexToDelete].FindControl("lblShopID") as Label).Text;
                data.CellID = (gvShopCellDetails.Rows[ShopCellIndexToDelete].FindControl("lblCellID") as Label).Text;
                data.GroupID = "";
                data.EffectiveFromDate = Util.GetDateTime(((gvShopCellDetails.Rows[ShopCellIndexToDelete].FindControl("lblEffevtiveFromDate") as Label).Text)).ToString("yyyy-MM-dd HH:mm:ss");
                data.EffectiveToDate = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                int result = DBAccess.deleteShopCellGroupDetails(data, "ShopCell");
                if (result > 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Record deleted Successfully.','');", true);

                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "openErrorModal('Failed to delete record.');", true);
                }
                BindShopCellData();
                ShopCellIndexToDelete = -1;
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }

      
        protected void btnShopCellView_Click(object sender, EventArgs e)
        {
            BindShopCellData();
        }

        protected void lbDeleteShopCell_Click(object sender, EventArgs e)
        {
            try
            {
                ShopCellIndexToDelete = Convert.ToInt32(((sender as LinkButton).NamingContainer as GridViewRow).RowIndex);
                string deleteMsg = "Are you sure you want to delete Cell ID " + (gvShopCellDetails.Rows[ShopCellIndexToDelete].FindControl("lblCellID") as Label).Text + ".";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "openShopCellDeleteConfirmModal('" + deleteMsg + " ?')", true);
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }

        protected void ddlPlant_ForShopCellNewEdit_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindShopIDsForNewEdit(ddlPlant_ForShopCellNewEdit.SelectedValue==null?"":ddlPlant_ForShopCellNewEdit.SelectedValue.ToString());
        }


        #endregion

        #region -------Shop Group------

        private void BindShopGroupData()
        {

            try
            {
                List<PlantLevelDetails> plantDetails = new List<PlantLevelDetails>();
                PlantLevelDetails data = new PlantLevelDetails();
                data.CompanyID = Session["CompanyName"].ToString();
                data.PlantID = ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString();
                //data.ShopID = ddlShop_ForShopGroupView.SelectedValue == null ? "" : ddlShop_ForShopGroupView.SelectedValue.ToString();
                data.ShopID = lblShop_ForShopGroupView.Text;
                plantDetails = DBAccess.getShopGroupDetails(data);
                gvShopGroupDetails.DataSource = plantDetails;
                gvShopGroupDetails.DataBind();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }
        protected void btnShopGroupView_Click(object sender, EventArgs e)
        {
            BindShopGroupData();
        }

      
        protected void btnDeleteShopGroupConfirmation_Click(object sender, EventArgs e)
        {
            try
            {
                PlantLevelDetails data = new PlantLevelDetails();
                data.CompanyID = (gvShopGroupDetails.Rows[ShopGroupIndexToDelete].FindControl("lblCompanyID") as Label).Text;
                data.PlantID = (gvShopGroupDetails.Rows[ShopGroupIndexToDelete].FindControl("lblPlantID") as Label).Text;
                data.ShopID = (gvShopGroupDetails.Rows[ShopGroupIndexToDelete].FindControl("lblShopID") as Label).Text;
                data.CellID = "";
                data.GroupID = (gvShopGroupDetails.Rows[ShopGroupIndexToDelete].FindControl("lblGroupID") as Label).Text;
                data.EffectiveFromDate = Util.GetDateTime(((gvShopGroupDetails.Rows[ShopGroupIndexToDelete].FindControl("lblEffevtiveFromDate") as Label).Text)).ToString("yyyy-MM-dd HH:mm:ss");
                data.EffectiveToDate = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                int result = DBAccess.deleteShopCellGroupDetails(data, "ShopCell");
                if (result > 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Record deleted Successfully.','');", true);

                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "openErrorModal('Failed to delete record.');", true);
                }
                BindShopGroupData();
                ShopGroupIndexToDelete = -1;
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }

        protected void lbDeleteShopGroup_Click(object sender, EventArgs e)
        {
            try
            {
                ShopGroupIndexToDelete = Convert.ToInt32(((sender as LinkButton).NamingContainer as GridViewRow).RowIndex);
                string deleteMsg = "Are you sure you want to delete Group ID " + (gvShopGroupDetails.Rows[ShopGroupIndexToDelete].FindControl("lblGroupID") as Label).Text + ".";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "openShopGroupDeleteConfirmModal('" + deleteMsg + " ?')", true);
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }

        protected void ddlPlant_ForShopGroupNewEdit_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindShopIDsForNewEdit(ddlPlant_ForShopGroupNewEdit.SelectedValue == null ? "" : ddlPlant_ForShopGroupNewEdit.SelectedValue.ToString());
        }
        protected void btnNewEditShopGroupSave_Click(object sender, EventArgs e)
        {
            try
            {
                PlantLevelDetails data = new PlantLevelDetails();
                data.CompanyID = Session["CompanyName"].ToString();
                data.PlantID = ddlPlant_ForShopGroupNewEdit.SelectedValue == null ? "" : ddlPlant_ForShopGroupNewEdit.SelectedValue.ToString();
                data.ShopID = ddlShop_ForShopGroupNewEdit.SelectedValue == null ? "" : ddlShop_ForShopGroupNewEdit.SelectedValue.ToString();
                data.GroupID = txtGroupId.Text;
                data.Description = txtGroupDesc.Text;
                data.EffectiveFromDate = Util.GetDateTime(txtGroupEffFromDate.Text).ToString("yyyy-MM-dd HH:mm:ss");
                data.EffectiveToDate = Util.GetDateTime(txtGroupEffToDate.Text).ToString("yyyy-MM-dd HH:mm:ss");
                data.NewOrEditParam = hfShopGroupEditNew.Value;
                string date = DBAccess.checkShopGroupEffectiveDate(data);
                if (date == "")
                {

                }
                else
                {
                    DateTime maxEfffromdate, enteredEffeFromDate;
                    maxEfffromdate = Util.GetDateTime(date);
                    enteredEffeFromDate = Util.GetDateTime(data.EffectiveFromDate);
                    if (enteredEffeFromDate <= maxEfffromdate)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openWarningModal('Effective from date should be greater than " + maxEfffromdate.ToString("dd-MM-yyyy HH:mm:ss") + "');", true);
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "openModal('neweditShopGroupModal')", true);
                        return;
                    }
                }
                string Success = DBAccess.saveUpdateShopGroupDetails(data);
                if (Success == "Exist")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openWarningModal('Group ID already exists.');", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "openModal('neweditShopGroupModal')", true);
                }
                else if (Success == "Inserted")
                {
                    BindShopGroupData();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Record saved Successfully.','');", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "clearAllModalScreen()", true);
                }
                else if (Success == "Updated")
                {
                    BindShopGroupData();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Record updated Successfully.','');", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "clearAllModalScreen()", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "openErrorModal('Failed to insert record.');", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "openModal('neweditShopGroupModal')", true);
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }

        #endregion

        #region ----- Shop Cell Group --------
        private void BindShopCellGroupData()
        {

            try
            {
                List<PlantLevelDetails> plantDetails = new List<PlantLevelDetails>();
                PlantLevelDetails data = new PlantLevelDetails();
                data.CompanyID = Session["CompanyName"].ToString();
                data.PlantID = ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString();
                //data.ShopID = ddlShop_ForShopCellGroupView.SelectedValue == null ? "" : ddlShop_ForShopCellGroupView.SelectedValue.ToString();
                data.ShopID = lblShop_ForShopCellGroupView.Text;
                data.CellID = ddlCell_ForShopCellGroupView.SelectedValue == null ? "" : ddlCell_ForShopCellGroupView.SelectedValue.ToString();
                plantDetails = DBAccess.getShopCellGroupDetails(data);
                gvShopCellGroupDetails.DataSource = plantDetails;
                gvShopCellGroupDetails.DataBind();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }
        protected void btnShopCellGroupView_Click(object sender, EventArgs e)
        {

            BindShopCellGroupData();
        }
        protected void btnNewEditShopCellGroupSave_Click(object sender, EventArgs e)
        {
            try
            {
                PlantLevelDetails data = new PlantLevelDetails();
                data.CompanyID = Session["CompanyName"].ToString();
                data.PlantID = ddlPlant_ForShopCellGroupNewEdit.SelectedValue == null ? "" : ddlPlant_ForShopCellGroupNewEdit.SelectedValue.ToString();
                data.ShopID = ddlShop_ForShopCellGRoupNewEdit.SelectedValue == null ? "" : ddlShop_ForShopCellGRoupNewEdit.SelectedValue.ToString();
                data.CellID = ddlCell_ForShopCellGroupNewEdit.SelectedValue == null ? "" : ddlCell_ForShopCellGroupNewEdit.SelectedValue.ToString();
                data.GroupID = txtShopCellGroupID.Text;
                data.Description = txtShopCellGroupName.Text;
                data.EffectiveFromDate = Util.GetDateTime(txtShopCellGroupEffFromDate.Text).ToString("yyyy-MM-dd HH:mm:ss");
                data.EffectiveToDate = Util.GetDateTime(txtShopCellGroupEffToDate.Text).ToString("yyyy-MM-dd HH:mm:ss");
                data.NewOrEditParam = hfShopCellGroupEditNew.Value;
                string date = DBAccess.checkShopCellGroupEffectiveDate(data);
                if (date == "")
                {

                }
                else
                {
                    DateTime maxEfffromdate, enteredEffeFromDate;
                    maxEfffromdate = Util.GetDateTime(date);
                    enteredEffeFromDate = Util.GetDateTime(data.EffectiveFromDate);
                    if (enteredEffeFromDate <= maxEfffromdate)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openWarningModal('Effective from date should be greater than " + maxEfffromdate.ToString("dd-MM-yyyy HH:mm:ss") + "');", true);
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "openModal('neweditShopCellGroupModal')", true);
                        return;
                    }
                }
                string Success = DBAccess.saveUpdateShopCellGroupDetails(data);
                if (Success == "Exist")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openWarningModal('Group ID already exists.');", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "openModal('neweditShopCellGroupModal')", true);
                }
                else if (Success == "Inserted")
                {
                    BindShopCellGroupData();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Record saved Successfully.','');", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "clearAllModalScreen()", true);
                }
                else if (Success == "Updated")
                {
                    BindShopCellGroupData();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Record updated Successfully.','');", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "clearAllModalScreen()", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "openErrorModal('Failed to insert record.');", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "openModal('neweditShopCellGroupModal')", true);
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }


        protected void btnDeleteShopCellGroupConfirm_Click(object sender, EventArgs e)
        {

            try
            {
                PlantLevelDetails data = new PlantLevelDetails();
                data.CompanyID = (gvShopCellGroupDetails.Rows[ShopCellGroupIndexToDelete].FindControl("lblCompanyID") as Label).Text;
                data.PlantID = (gvShopCellGroupDetails.Rows[ShopCellGroupIndexToDelete].FindControl("lblPlantID") as Label).Text;
                data.ShopID = (gvShopCellGroupDetails.Rows[ShopCellGroupIndexToDelete].FindControl("lblShopID") as Label).Text;
                data.CellID = (gvShopCellGroupDetails.Rows[ShopCellGroupIndexToDelete].FindControl("lblCellID") as Label).Text;
                data.GroupID = (gvShopCellGroupDetails.Rows[ShopCellGroupIndexToDelete].FindControl("lblGroupID") as Label).Text;
                data.EffectiveFromDate = Util.GetDateTime(((gvShopCellGroupDetails.Rows[ShopCellGroupIndexToDelete].FindControl("lblEffevtiveFromDate") as Label).Text)).ToString("yyyy-MM-dd HH:mm:ss");
                data.EffectiveToDate = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                int result = DBAccess.deleteShopCellGroupDetails(data, "ShopCellGroup");
                if (result > 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Record deleted Successfully.','');", true);

                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "openErrorModal('Failed to delete record.');", true);
                }
                BindShopCellGroupData();
                ShopCellGroupIndexToDelete = -1;
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }
        protected void lbDeleteShopCellGroup_Click(object sender, EventArgs e)
        {
            try
            {
                ShopCellGroupIndexToDelete = Convert.ToInt32(((sender as LinkButton).NamingContainer as GridViewRow).RowIndex);
                string deleteMsg = "Are you sure you want to delete Group ID " + (gvShopCellGroupDetails.Rows[ShopCellGroupIndexToDelete].FindControl("lblGroupID") as Label).Text + ".";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "openShopCellGroupDeleteConfirmModal('" + deleteMsg + " ?')", true);
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }
        protected void ddlPlant_ForShopCellGroupNewEdit_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindShopIDsForNewEdit(ddlPlant_ForShopCellGroupNewEdit.SelectedValue==null?"":ddlPlant_ForShopCellGroupNewEdit.SelectedValue.ToString());
        }

        protected void ddlShop_ForShopCellGRoupNewEdit_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindCellIDsForEditNew(ddlPlant_ForShopCellGroupNewEdit.SelectedValue == null ? "" : ddlPlant_ForShopCellGroupNewEdit.SelectedValue.ToString(), ddlShop_ForShopCellGRoupNewEdit.SelectedValue == null ? "" : ddlShop_ForShopCellGRoupNewEdit.SelectedValue.ToString());
        }
        protected void ddlShop_ForShopCellGroupView_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindCellIDsForView(ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString(), ddlShop_ForShopCellGroupView.SelectedValue == null ? "" : ddlShop_ForShopCellGroupView.SelectedValue.ToString());
        }
        #endregion

        #region ------- Cell Data------
        private void setCellDetailsRowColor(string cellid)
        {
            try
            {
                lblCellIDForCellGroup.Text = cellid;
                foreach (GridViewRow row in gvCellData.Rows)
                {
                    //if (row.RowIndex == gvCellData.SelectedIndex)
                    //{
                    //    row.BackColor = ColorTranslator.FromHtml("red");
                    //}
                    //else
                    //{
                    //    row.BackColor = System.Drawing.Color.Transparent;/*ColorTranslator.FromHtml("#FFFFFF");*/
                    //}
                    if ((row.FindControl("lblCellId") as Label).Text == cellid)
                    {
                        row.BackColor = ColorTranslator.FromHtml("red");
                    }
                    else
                    {
                        row.BackColor = System.Drawing.Color.Transparent;
                    }
                }
                BindCellGroupData();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }

        }
        protected void gvCellData_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                //int index = gvShopDetails.SelectedRow.RowIndex;
                //string slno = gvShopDetails.SelectedRow.Cells[0].Text;
                //string partnumber = gvShopDetails.SelectedRow.Cells[1].Text;
                //string line = gvShopDetails.SelectedRow.Cells[2].Text;
                string cellid = (gvCellData.SelectedRow.FindControl("lblCellId") as Label).Text;
                Session["LHCell"] = cellid;
                setCellDetailsRowColor(cellid);
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }

        protected void gvCellData_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(gvCellData, "Select$" + e.Row.RowIndex);
                e.Row.Attributes["style"] = "cursor:pointer";
            }
        }

        protected void btnCell_Click(object sender, EventArgs e)
        {
            try
            {
                Session["LHCell"] = null;
                //BindPlantForCell(ddlPlantForCell, true);
                //ddlPlantForCell.SelectedValue = (string) Session["LHPlant"];
                BindPlantForCell(ddlCellPlantID, false);
                ddlCellPlantID.SelectedValue = (string)Session["LHPlant"];
                BindCellDettails();

                //Bind Cell Group Data
                btnCellGroup_Click(null, null);

               
                //Bind PlantGroup Data
                // btnPlantGroup_Click(null, null);
                ShowHideList(Session["CompanyName"].ToString(), ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString(),"Cell",false);
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }
        private void BindPlantForCell(DropDownList ddl, bool isAllRequired)
        {
            try
            {
                if (Session["CompanyName"] == null)
                {
                    Response.Redirect("~/LoginInitial", false);
                    return;
                }
                ddl.DataSource = DBAccess.getPlantData(Session["CompanyName"].ToString());
                ddl.DataBind();
                if (isAllRequired)
                {
                    ddl.Items.Insert(0, "All");
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }
        private void BindCellDettails()
        {
            try
            {
                List<CellData> list = DBAccess.getCellMasterDetails(Session["CompanyName"].ToString(), ddlPlant.SelectedValue == "All" ? "" : ddlPlant.SelectedValue);
                gvCellData.DataSource = list;
                gvCellData.DataBind();
                if (Session["LHCell"] == null)
                {
                    if (gvCellData.Rows.Count > 0)
                    {
                        Session["LHCell"] = (gvCellData.Rows[0].FindControl("lblCellId") as Label).Text;
                    }
                }
                setCellDetailsRowColor(Session["LHCell"].ToString());
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }
        protected void btnCellView_Click(object sender, EventArgs e)
        {
            BindCellDettails();
            //Bind Cell Group Data
            btnCellGroup_Click(null, null);

            //Bind PlantGroup Data
           // btnPlantGroup_Click(null, null);
        }

        protected void btnCellNew_Click(object sender, EventArgs e)
        {
            try
            {
               
                hdnCellInserUpdateParam.Value = "";
                txtCellCellID.Enabled = true;
                ddlCellPlantID.Enabled = false;
                txtCellCellID.Text = "";
                txtCellCellDesc.Text = "";
                txtCellEffectiveFromDate.Text = DateTime.Now.ToString("dd-MM-yyyy HH:mm:ss");
                txtCellEffectiveToDate.Text = Util.GetDateTime("01-01-9999 00:00:00").ToString("dd-MM-yyyy HH:mm:ss");
                txtCellEffectiveFromDate.Enabled = true;
                txtCellEffectiveToDate.Enabled = false;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "openModal", "openAddEditCellInfo();", true);
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }

        protected void lblCellEdit_Click(object sender, EventArgs e)
        {
            try
            {
                hdnCellInserUpdateParam.Value = "Edit";
                int rowIndex = Convert.ToInt32(((sender as LinkButton).NamingContainer as GridViewRow).RowIndex);
                txtCellCellID.Enabled = false;
                ddlCellPlantID.Enabled = false;
                ddlCellPlantID.SelectedValue = (gvCellData.Rows[rowIndex].FindControl("lblPlantID") as Label).Text;
                txtCellCellID.Text = (gvCellData.Rows[rowIndex].FindControl("lblCellId") as Label).Text;
                txtCellCellDesc.Text = (gvCellData.Rows[rowIndex].FindControl("lblCellDesc") as Label).Text;
                txtCellEffectiveFromDate.Text = (gvCellData.Rows[rowIndex].FindControl("lblEffectiveFromDate") as Label).Text;
                txtCellEffectiveToDate.Text = (gvCellData.Rows[rowIndex].FindControl("lblEffectiveToDate") as Label).Text;
                txtCellEffectiveFromDate.Enabled = false;
                txtCellEffectiveToDate.Enabled = false;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "openModal", "openAddEditCellInfo();", true);
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }

        protected void btnCellInserUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                CellData data = new CellData();
                data.CompanyID = Session["CompanyName"].ToString();
                data.PlantID = ddlCellPlantID.SelectedValue;
                data.CellId = txtCellCellID.Text;
                data.CellDesc = txtCellCellDesc.Text;
                data.UpdatedBy = HttpContext.Current.Session["Username"] == null ? "" : HttpContext.Current.Session["Username"].ToString();
                data.EffectiveFromDate = txtCellEffectiveFromDate.Text;
                data.EffectiveToDate = txtCellEffectiveToDate.Text;

                string date = DBAccess.checkCellEffectiveDate(data);
                if (date == "")
                {

                }
                else
                {
                    DateTime maxEfffromdate, enteredEffeFromDate;
                    maxEfffromdate = Util.GetDateTime(date);
                    enteredEffeFromDate = Util.GetDateTime(data.EffectiveFromDate);
                    if (enteredEffeFromDate <= maxEfffromdate)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "openInfo", "openAddEditCellInfo();", true);
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openWarningModal('Effective from date should be greater than " + maxEfffromdate.ToString("dd-MM-yyyy HH:mm:ss") + "');", true);
                        return;
                    }
                }
                string Success = DBAccess.insertUpdateCellMasterDetails(data, hdnCellInserUpdateParam.Value);
                if (Success == "Exist")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "openInfo", "openAddEditCellInfo();", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openWarningModal('Cell ID already exists.');", true);
                    return;
                }
                else if (Success == "Inserted")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Record saved Successfully.','');", true);
                }
                else if (Success == "Updated")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Record updated Successfully.','');", true);

                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openAddEditCellInfo();", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "openErrorModal('Failed to insert record.');", true);
                    return;
                }
                BindCellDettails();
                if (hdnCellInserUpdateParam.Value == "")
                {
                    //Bind Cell Group Data
                    btnCellGroup_Click(null, null);
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }



        protected void lblCellDalete_Click(object sender, EventArgs e)
        {
            try
            {
                selectedDeleteRowIndex = Convert.ToInt32(((sender as LinkButton).NamingContainer as GridViewRow).RowIndex);
                string deleteMsg = "Are you sure you want to delete Cell ID " + (gvCellData.Rows[selectedDeleteRowIndex].FindControl("lblCellId") as Label).Text + ".";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "openCellDeleteConfirmModal('" + deleteMsg + " ?')", true);
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }



        protected void btnCellDeleteConfirm_Click(object sender, EventArgs e)
        {
            try
            {
                CellData data = new CellData();
                data.CompanyID = Session["CompanyName"].ToString();
                data.PlantID = (gvCellData.Rows[selectedDeleteRowIndex].FindControl("lblPlantID") as Label).Text;
                data.CellId = (gvCellData.Rows[selectedDeleteRowIndex].FindControl("lblCellId") as Label).Text;
                data.EffectiveToDate = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                data.EffectiveFromDate = (gvCellData.Rows[selectedDeleteRowIndex].FindControl("lblEffectiveFromDate") as Label).Text;
                int result = DBAccess.deleteCellMasterDetails(data);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "clearModal", "clearTheModalScreen();", true);
                if (result > 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Record deleted Successfully.','');", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "openErrorModal('Failed to delete record.');", true);
                }
                BindCellDettails();
                selectedDeleteRowIndex = -1;

                //Bind Cell Group Data
                btnCellGroup_Click(null, null);
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }

        #endregion
        #region ------- Cell Group Master-------
        protected void btnCellGroup_Click(object sender, EventArgs e)
        {
            try
            {
                BindCellIDForCellGroup(ddlCellIDForCellGroup, ddlPlant.SelectedValue, true);
                BindPlantForCell(ddlCGPlantID, false);
                ddlCGPlantID.SelectedValue = (string)Session["LHPlant"];
                BindCellIDForCellGroup(ddlCGCellID, ddlCGPlantID.SelectedValue, false);
                BindCellGroupData();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }
        private void BindCellIDForCellGroup(DropDownList ddl, string plant, bool isAllRequired)
        {
            try
            {
                ddl.DataSource = DBAccess.getCellIDs(Session["CompanyName"].ToString(), plant == "All" ? "" : plant, "");
                ddl.DataBind();
                if (isAllRequired)
                {
                    ddl.Items.Insert(0, "All");
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }
        private void BindCellGroupData()
        {
            try
            {

                //List<CellData> list = DBAccess.getCellGroupMasterDetails(Session["CompanyName"].ToString(), ddlPlantForCell.SelectedValue == "All" ? "" : ddlPlantForCell.SelectedValue, ddlCellIDForCellGroup.SelectedValue == "All" ? "" : ddlCellIDForCellGroup.SelectedValue);
                List<CellData> list = DBAccess.getCellGroupMasterDetails(Session["CompanyName"].ToString(), ddlPlant.SelectedValue == "All" ? "" : ddlPlant.SelectedValue, lblCellIDForCellGroup.Text);
                gvCellGroupData.DataSource = list;
                gvCellGroupData.DataBind();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }
        protected void btnCGView_Click(object sender, EventArgs e)
        {
            BindCellGroupData();
        }

        protected void btnCGNew_Click(object sender, EventArgs e)
        {
            try
            {
                hdnCellGroupParam.Value = "";
                ddlCGPlantID.Enabled = false;
                ddlCGCellID.Enabled = true;
                txtCGGroupID.Enabled = true;
                BindCellIDForCellGroup(ddlCGCellID, ddlCGPlantID.SelectedValue, false);
                txtCGGroupID.Text = "";
                txtCGGroupDesc.Text = "";
                txtCGEffectiveFromDate.Text = DateTime.Now.ToString("dd-MM-yyyy HH:mm:ss");
                txtCGEffectiveToDate.Text = Util.GetDateTime("01-01-9999 00:00:00").ToString("dd-MM-yyyy HH:mm:ss");
                txtCGEffectiveFromDate.Enabled = true;
                txtCGEffectiveToDate.Enabled = false;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "openModal", "openAddEditCellGroupInfo();", true);
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }

        protected void lbCellGroupEdit_Click(object sender, EventArgs e)
        {
            try
            {
                hdnCellGroupParam.Value = "Edit";
                int rowIndex = Convert.ToInt32(((sender as LinkButton).NamingContainer as GridViewRow).RowIndex);
                ddlCGPlantID.Enabled = false;
                ddlCGCellID.Enabled = false;
                txtCGGroupID.Enabled = false;
                hdnCompanyID.Value = (gvCellGroupData.Rows[rowIndex].FindControl("lblCompanyID") as Label).Text;
                ddlCGPlantID.SelectedValue = (gvCellGroupData.Rows[rowIndex].FindControl("lblPlantID") as Label).Text;
                BindCellIDForCellGroup(ddlCGCellID, ddlCGPlantID.SelectedValue, false);
                string str = (gvCellGroupData.Rows[rowIndex].FindControl("lblCellId") as Label).Text;
                ddlCGCellID.SelectedValue = (gvCellGroupData.Rows[rowIndex].FindControl("lblCellId") as Label).Text;
                txtCGGroupID.Text = (gvCellGroupData.Rows[rowIndex].FindControl("lblGroupID") as Label).Text;
                txtCGGroupDesc.Text = (gvCellGroupData.Rows[rowIndex].FindControl("lblGroupDesc") as Label).Text;
                txtCGEffectiveFromDate.Text = (gvCellGroupData.Rows[rowIndex].FindControl("lblEffectiveFromDate") as Label).Text;
                txtCGEffectiveToDate.Text = (gvCellGroupData.Rows[rowIndex].FindControl("lblEffectiveToDate") as Label).Text;
                txtCGEffectiveFromDate.Enabled = false;
                txtCGEffectiveToDate.Enabled = false;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "openModal", "openAddEditCellGroupInfo();", true);
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }

        protected void btnCGInsertUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                CellData data = new CellData();
                data.CompanyID = Session["CompanyName"].ToString();
                data.PlantID = ddlCGPlantID.SelectedValue;
                data.CellId = ddlCGCellID.SelectedValue;
                data.GroupID = txtCGGroupID.Text;
                data.GroupDesc = txtCGGroupDesc.Text;
                data.UpdatedBy = HttpContext.Current.Session["Username"] == null ? "" : HttpContext.Current.Session["Username"].ToString();
                data.EffectiveFromDate = txtCGEffectiveFromDate.Text;
                data.EffectiveToDate = txtCGEffectiveToDate.Text;
                string date = DBAccess.checkCellGroupEffectiveDate(data);
                if (date == "")
                {

                }
                else
                {
                    DateTime maxEfffromdate, enteredEffeFromDate;
                    maxEfffromdate = Util.GetDateTime(date);
                    enteredEffeFromDate = Util.GetDateTime(data.EffectiveFromDate);
                    if (enteredEffeFromDate <= maxEfffromdate)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "openInfo", "openAddEditCellGroupInfo();", true);
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openWarningModal('Effective from date should be greater than " + maxEfffromdate.ToString("dd-MM-yyyy HH:mm:ss") + "');", true);
                        return;
                    }
                }
                string Success = DBAccess.insertUpdateCellGroupMasterDetails(data, hdnCellGroupParam.Value);
                if (Success == "Exist")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "openInfo", "openAddEditCellGroupInfo();", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openWarningModal('Group ID already exists.');", true);
                    return;
                }
                else if (Success == "Inserted")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Record saved Successfully.','');", true);
                }
                else if (Success == "Updated")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Record updated Successfully.','');", true);

                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openAddEditCellGroupInfo();", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "openErrorModal('Failed to insert record.');", true);
                    return;
                }
                BindCellGroupData();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }
        protected void lblCellGroupDelete_Click(object sender, EventArgs e)
        {
            try
            {
                selectedDeleteRowIndex = Convert.ToInt32(((sender as LinkButton).NamingContainer as GridViewRow).RowIndex);
                string deleteMsg = "Are you sure you want to delete Group ID " + (gvCellGroupData.Rows[selectedDeleteRowIndex].FindControl("lblGroupID") as Label).Text + ".";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "openCellGroupDeleteConfirmModal('" + deleteMsg + " ?')", true);
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }

        protected void ddlCGPlantID_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                BindCellIDForCellGroup(ddlCGCellID, ddlCGPlantID.SelectedValue, false);
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }


        protected void btnCGDeleteConfirm_Click(object sender, EventArgs e)
        {
            try
            {
                CellData data = new CellData();
                data.CompanyID = (gvCellGroupData.Rows[selectedDeleteRowIndex].FindControl("lblCompanyID") as Label).Text;
                data.PlantID = (gvCellGroupData.Rows[selectedDeleteRowIndex].FindControl("lblPlantID") as Label).Text;
                data.CellId = (gvCellGroupData.Rows[selectedDeleteRowIndex].FindControl("lblCellId") as Label).Text;
                data.GroupID = (gvCellGroupData.Rows[selectedDeleteRowIndex].FindControl("lblGroupID") as Label).Text;
                data.EffectiveToDate = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                data.EffectiveFromDate = (gvCellGroupData.Rows[selectedDeleteRowIndex].FindControl("lblEffectiveFromDate") as Label).Text;
                int result = DBAccess.deleteCellGroupMasterDetails(data);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "clearModal", "clearTheModalScreen();", true);
                if (result > 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Record deleted Successfully.','');", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "openErrorModal('Failed to delete record.');", true);
                }
                BindCellGroupData();
                selectedDeleteRowIndex = -1;
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }


        #endregion

        #region ------ Plant Group Master -------
        protected void btnPlantGroup_Click(object sender, EventArgs e)
        {
            try
            {
             
                BindPlantForCell(ddlPGPlantID, false);
                //BindPlantForCell(ddlPlant_ForGroup, true);
                ddlPGPlantID.SelectedValue = (string)Session["LHPlant"];
              //  ddlPlant_ForGroup.SelectedValue = (string)Session["LHPlant"];
                txtPlantGroupSearch.Text = "";
                BindPlantGroupDettails();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }
        private void BindPlantGroupDettails()
        {
            try
            {
                //List<CellData> list = DBAccess.getPlantGroupMasterDetails(Session["CompanyName"].ToString(), ddlPlantForCell.SelectedValue == "All" ? "" : ddlPlantForCell.SelectedValue, txtPlantGroupSearch.Text.Trim());
                List<CellData> list = DBAccess.getPlantGroupMasterDetails(Session["CompanyName"].ToString(), ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString(), txtPlantGroupSearch.Text.Trim());
                gvPlantGroupData.DataSource = list;
                gvPlantGroupData.DataBind();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }

        }

        protected void btnPlantGroupView_Click(object sender, EventArgs e)
        {
            BindPlantGroupDettails();
        }

        protected void btnPlantGroupNew_Click(object sender, EventArgs e)
        {
            try
            {
                hdnPlantGroupInsertUpdate.Value = "";
                txtPGGroupID.Enabled = true;
                ddlPGPlantID.Enabled = false;
                txtPGGroupID.Text = "";
                txtPGGroupDesc.Text = "";
                txtPGEffectiveFromDate.Text = DateTime.Now.ToString("dd-MM-yyyy HH:mm:ss");
                txtPGEffectiveToDate.Text = Util.GetDateTime("01-01-9999 00:00:00").ToString("dd-MM-yyyy HH:mm:ss");
                txtPGEffectiveFromDate.Enabled = true;
                txtPGEffectiveToDate.Enabled = false;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "openModal", "openAddEditPlantGroupInfo();", true);
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }

        protected void lbPlantGroupEdit_Click(object sender, EventArgs e)
        {
            try
            {
                hdnPlantGroupInsertUpdate.Value = "Edit";
                int rowIndex = Convert.ToInt32(((sender as LinkButton).NamingContainer as GridViewRow).RowIndex);
                txtPGGroupID.Enabled = false;
                ddlPGPlantID.Enabled = false;
                ddlPGPlantID.SelectedValue = (gvPlantGroupData.Rows[rowIndex].FindControl("lblPlantID") as Label).Text;
                txtPGGroupID.Text = (gvPlantGroupData.Rows[rowIndex].FindControl("lblGroupID") as Label).Text;
                txtPGGroupDesc.Text = (gvPlantGroupData.Rows[rowIndex].FindControl("lblGroupDesc") as Label).Text;
                txtPGEffectiveFromDate.Text = (gvPlantGroupData.Rows[rowIndex].FindControl("lblEffectiveFromDate") as Label).Text;
                txtPGEffectiveToDate.Text = (gvPlantGroupData.Rows[rowIndex].FindControl("lblEffectiveToDate") as Label).Text;
                txtPGEffectiveFromDate.Enabled = false;
                txtPGEffectiveToDate.Enabled = false;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "openModal", "openAddEditPlantGroupInfo();", true);
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }

        protected void lbPlantGroupDelete_Click(object sender, EventArgs e)
        {
            try
            {
                selectedDeleteRowIndex = Convert.ToInt32(((sender as LinkButton).NamingContainer as GridViewRow).RowIndex);
                string deleteMsg = "Are you sure you want to delete Group ID " + (gvPlantGroupData.Rows[selectedDeleteRowIndex].FindControl("lblGroupID") as Label).Text + ".";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "openPlantGroupDeleteConfirmModal('" + deleteMsg + " ?')", true);
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }

        protected void btnPlantGroupInsertUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                CellData data = new CellData();
                data.CompanyID = Session["CompanyName"].ToString();
                data.PlantID = ddlPGPlantID.SelectedValue;
                data.GroupID = txtPGGroupID.Text;
                data.GroupDesc = txtPGGroupDesc.Text;
                data.UpdatedBy = HttpContext.Current.Session["Username"] == null ? "" : HttpContext.Current.Session["Username"].ToString();
                data.EffectiveFromDate = txtPGEffectiveFromDate.Text;
                data.EffectiveToDate = txtPGEffectiveToDate.Text;
                string date = DBAccess.checkGroupEffectiveDate(data);
                if (date == "")
                {

                }
                else
                {
                    DateTime maxEfffromdate, enteredEffeFromDate;
                    maxEfffromdate = Util.GetDateTime(date);
                    enteredEffeFromDate = Util.GetDateTime(data.EffectiveFromDate);
                    if (enteredEffeFromDate <= maxEfffromdate)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "openInfo", "openAddEditPlantGroupInfo();", true);
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openWarningModal('Effective from date should be greater than " + maxEfffromdate.ToString("dd-MM-yyyy HH:mm:ss") + "');", true);
                        return;
                    }
                }
                string Success = DBAccess.insertUpdatePlantGroupMasterDetails(data, hdnPlantGroupInsertUpdate.Value);
                if (Success == "Exist")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "openInfo", "openAddEditPlantGroupInfo();", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openWarningModal('Group ID already exists.');", true);
                    return;
                }
                else if (Success == "Inserted")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Record saved Successfully.','');", true);
                }
                else if (Success == "Updated")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Record updated Successfully.','');", true);

                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openAddEditPlantGroupInfo();", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "openErrorModal('Failed to insert record.');", true);
                    return;
                }
                BindPlantGroupDettails();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }

        protected void btnPlantGroupDeleteConfirm_Click(object sender, EventArgs e)
        {
            try
            {
                CellData data = new CellData();
                data.CompanyID = Session["CompanyName"].ToString();
                data.PlantID = (gvPlantGroupData.Rows[selectedDeleteRowIndex].FindControl("lblPlantID") as Label).Text;
                data.GroupID = (gvPlantGroupData.Rows[selectedDeleteRowIndex].FindControl("lblGroupID") as Label).Text;
                data.EffectiveToDate = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                data.EffectiveFromDate = (gvPlantGroupData.Rows[selectedDeleteRowIndex].FindControl("lblEffectiveFromDate") as Label).Text;
                int result = DBAccess.deletePlantGroupMasterDetails(data);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "clearModal", "clearTheModalScreen();", true);
                if (result > 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Record deleted Successfully.','');", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "openErrorModal('Failed to delete record.');", true);
                }
                BindPlantGroupDettails();
                selectedDeleteRowIndex = -1;
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }

        #endregion
  
      
        protected void ddlPlant_ShopView_SelectedIndexChanged(object sender, EventArgs e)
        {
           // ShowHideList((string)Session["CompanyName"], ddlPlant_ShopView.SelectedValue == null ? "" : ddlPlant_ShopView.SelectedValue.ToString(), "Shop");
        }

        protected void ddlPlantForCell_SelectedIndexChanged(object sender, EventArgs e)
        {
          //  ShowHideList((string)Session["CompanyName"], ddlPlantForCell.SelectedValue == null ? "" : ddlPlantForCell.SelectedValue.ToString(), "Cell");
        }

        protected void btnGroup_Click(object sender, EventArgs e)
        {
            btnPlantGroup_Click(null, null);
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            //try
            //{
            //    if (hfSelectedPlant.Value == "" || hfSelectedPlant.Value == "DisablePlantLevelMenu")
            //    {
            //        ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openWarningModal('Select any one Plant ID.');", true);
            //    }
            //    Session["LHPlant"] = hfSelectedPlant.Value;
            //    ShowHideList((string)Session["CompanyName"], Session["LHPlant"].ToString(), "Plant");
            //}
            //catch (Exception ex)
            //{

            //}
        }
        protected void lbbtnNext_Click(object sender, EventArgs e)
        {
            //try
            //{
            //    if (hfSelectedPlant.Value == "" || hfSelectedPlant.Value == "DisablePlantLevelMenu")
            //    {
            //        ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openWarningModal('Select any one Plant ID.');", true);
            //    }
            //    Session["LHPlant"] = hfSelectedPlant.Value;
            //    ShowHideList((string)Session["CompanyName"], Session["LHPlant"].ToString(), "Plant");
            //}
            //catch (Exception ex)
            //{

            //}
        }
        protected void btnNextImg_Click(object sender, ImageClickEventArgs e)
        {
            //try
            //{
            //    if (hfSelectedPlant.Value == "" || hfSelectedPlant.Value == "DisablePlantLevelMenu")
            //    {
            //        ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openWarningModal('Select any one Plant ID.');", true);
            //    }
            //    Session["LHPlant"] = hfSelectedPlant.Value;
            //    ShowHideList((string)Session["CompanyName"], Session["LHPlant"].ToString(), "Plant");
            //}
            //catch (Exception ex)
            //{

            //}
        }

        #region ----- Assign Machines----
        protected void btnAssignMachine_Click(object sender, EventArgs e)
        {
            //BindPlantIDs();

            //BindPlantForCell(ddlPlant_ForAssignMachine, false);
            //ddlPlant_ForAssignMachine_SelectedIndexChanged(null, null);


            // btnAssignMachineToPlant_Click(null, null);
            // ShowHideList("", "DisablePlantLevelMenu", "");
            //divCompanyPlant.Visible=fa

            ShowHideList(Session["CompanyName"].ToString(), ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString(), "", true);
        }
        protected void btnAssignMachineToPlant_Click(object sender, EventArgs e)
        {
           // BindAssignMachineToPlantData();
        }
        protected void btnAssignMachineToShop_Click(object sender, EventArgs e)
        {
            //cbassignShop.Checked = true;
            //cbassignShopCell.Checked = false;
            //cbassignShopCellGroup.Checked = false;
            //cbassignShopGroup.Checked = false;
            //ShowHideMachineAssignMenuList(Session["CompanyName"].ToString(), ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString(), "Shop");
           // ShowHideList(Session["CompanyName"].ToString(), ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString(), "Shop",true);
            clearAssignMachineToShopMenus();
            btnassignShop.CssClass = "selected-btn blinking";
            btnassignShopCell.CssClass = "unselected-btn";
            btnassignShopCellGroup.CssClass = "unselected-btn";
            btnassignShopGroup.CssClass = "unselected-btn";
            showHideFilterSectionShop();
            BindAssignMachineToShopData();
        }
        protected void btnAssignMachineToCell_Click(object sender, EventArgs e)
        {
            //ShowHideMachineAssignMenuList(Session["CompanyName"].ToString(), ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString(), "Cell");
           // ShowHideList(Session["CompanyName"].ToString(), ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString(), "Cell",true);
            btnassignCell.CssClass = btnassignCell.CssClass.Replace("selected-btn blinking unselected-btn", "");
            btnassignCellGroup.CssClass = btnassignCell.CssClass.Replace("selected-btn blinking unselected-btn", "");
            btnassignCell.CssClass = "selected-btn blinking";
            btnassignCellGroup.CssClass = "unselected-btn";
            showHideFilterSectionCell();
            BindAssignMachineToCellData();
        }

        protected void btnAssignMachineToGroup_Click(object sender, EventArgs e)
        {
            BindGroupIDsForMultiSelect(multiselectGorup_ForGroup, ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString(), "", "", false);
            foreach(ListItem item in multiselectGorup_ForGroup.Items)
            {
                item.Selected = true;
            }
            BindAssignMachineToGroupData();
           // BindShopIDs(ddlShop_ForAssignMachineToGroup, ddlPlant_ForAssignMachine.SelectedValue == null ? "" : ddlPlant_ForAssignMachine.SelectedValue.ToString(), false);
            //BindPlantIDsForAssignMachines(ddlPlant_ForAssignMachineToGroup, false, "Group");
            // BindGroupIDs(ddlGroup_ForAssignMachineToGroup, ddlPlant_ForAssignMachineToGroup.SelectedValue == null ? "" : ddlPlant_ForAssignMachineToGroup.SelectedValue.ToString(),"", "", false);
        }
        private void clearAssignMachineToShopMenus()
        {
            btnassignShop.CssClass = btnassignCell.CssClass.Replace("selected-btn blinking unselected-btn", "");
            btnassignShopCell.CssClass = btnassignCell.CssClass.Replace("selected-btn blinking unselected-btn", "");
            btnassignShopCellGroup.CssClass = btnassignCell.CssClass.Replace("selected-btn blinking unselected-btn", "");
            btnassignShopGroup.CssClass = btnassignCell.CssClass.Replace("selected-btn blinking unselected-btn", "");
        }
        protected void ddlPlant_ForAssignMachine_SelectedIndexChanged(object sender, EventArgs e)
        {
           // ShowHideMachineAssignMenuList(Session["CompanyName"].ToString(), ddlPlant_ForAssignMachine.SelectedValue == null ? "" : ddlPlant_ForAssignMachine.SelectedValue.ToString(), "");
        }
        private void ShowHideMachineAssignMenuList(string companyID, string plantID, string type)
        {
            try
            {
                List<LevelHeirarchyDetails> shopcelllist = new List<LevelHeirarchyDetails>();
                shopcelllist = DBAccess.getCheckedShopCellList(companyID, plantID);
                if (type == "Shop")
                {
                    if (shopcelllist.Where(x => x.KeyValue == "Shop").Select(x => x.CheckOrUncheck).FirstOrDefault())
                    {
                        btnassignShop.Visible = true;
                        btnassignShopCell.Visible= shopcelllist.Where(x => x.KeyValue == "ShopCell").Select(x => x.CheckOrUncheck).FirstOrDefault();
                        btnassignShopCellGroup.Visible = shopcelllist.Where(x => x.KeyValue == "ShopCellGroup").Select(x => x.CheckOrUncheck).FirstOrDefault();
                        btnassignShopGroup.Visible = shopcelllist.Where(x => x.KeyValue == "ShopGroup").Select(x => x.CheckOrUncheck).FirstOrDefault();
                    }
                    else
                    {
                        btnassignShop.Visible = false;
                        btnassignShopCell.Visible = false;
                        btnassignShopCellGroup.Visible = false;
                        btnassignShopGroup.Visible = false;
                    }
                }
                else if (type == "Cell")
                {
                    if (shopcelllist.Where(x => x.KeyValue == "Cell").Select(x => x.CheckOrUncheck).FirstOrDefault())
                    {
                        btnassignCell.Visible = true;
                        btnassignCellGroup.Visible= shopcelllist.Where(x => x.KeyValue == "CellGroup").Select(x => x.CheckOrUncheck).FirstOrDefault();
                    }
                    else
                    {
                        btnassignCell.Visible = false;
                        btnassignCellGroup.Visible = false;
                    }
                }
                else
                {
                    AssignMachineToShop.Visible = shopcelllist.Where(x => x.KeyValue == "Shop").Select(x => x.CheckOrUncheck).FirstOrDefault();
                    AssignMachineToCell.Visible = shopcelllist.Where(x => x.KeyValue == "Cell").Select(x => x.CheckOrUncheck).FirstOrDefault();
                    AssignMachineToGroup.Visible = shopcelllist.Where(x => x.KeyValue == "Group").Select(x => x.CheckOrUncheck).FirstOrDefault();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "setActivePlantMenu", "setActiveAssignMachineMenu();", true);
                }

            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }
     
        private void showHideFilterSectionCell()
        {
            BindCellIDs(ddlCell_ForAssignMachineToCell, ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString(), "", false);
            if (!btnassignCell.CssClass.Contains("unselected-btn"))
            {
                //assignCell_GroupName.Visible = false;
                //assignCell_GroupDDL.Visible = false;
                assignCell_CellName.Visible = false;
                assignCell_CellDDL.Visible = false;
                lblmultiselectCell_ForCell.Text = "Cell";
                BindCellIDsForMultiSelect(multiselectCell_ForCell, ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString(), "", false);
            }
            else if (!btnassignCellGroup.CssClass.Contains("unselected-btn"))
            {
                assignCell_CellName.Visible = true;
                assignCell_CellDDL.Visible = true;
                lblmultiselectCell_ForCell.Text = "Group";
                BindGroupIDsForMultiSelect(multiselectCell_ForCell, ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString(), "", ddlCell_ForAssignMachineToCell.SelectedValue == null ? "" : ddlCell_ForAssignMachineToCell.SelectedValue.ToString(), false);
            }
            foreach (ListItem item in multiselectCell_ForCell.Items)
            {
                item.Selected = true;
            }
            //BindPlantIDsForAssignMachines(ddlPlant_ForAssignMachineToCell, false, type);

            //BindGroupIDs(ddlGroup_ForAssignMachineToCell, ddlPlant_ForAssignMachineToCell.SelectedValue == null ? "" : ddlPlant_ForAssignMachineToCell.SelectedValue.ToString(), "", ddlCell_ForAssignMachineToCell.SelectedValue == null ? "" : ddlCell_ForAssignMachineToCell.SelectedValue.ToString(), false);
        }
        private void showHideFilterSectionShop()
        {
            //if (cbassignShop.Checked)
            //{
            //    type = "Shop";
            //    assignShop_CellDDL.Visible = false;
            //    assignShop_CellName.Visible = false;
            //    assignShop_GroupDDL.Visible = false;
            //    assignShop_GroupName.Visible = false;
            //}
            //else if (cbassignShopCell.Checked)
            //{
            //    type = "ShopCell";
            //    assignShop_CellDDL.Visible = true;
            //    assignShop_CellName.Visible = true;
            //    assignShop_GroupDDL.Visible = false;
            //    assignShop_GroupName.Visible = false;
            //}
            //else if (cbassignShopCellGroup.Checked)
            //{
            //    type = "ShopCellGroup";
            //    //ddlCell_ForAssignMachineToShop.Visible = true;
            //    //ddlGroup_ForAssignMachineToShop.Visible = false;
            //    assignShop_CellDDL.Visible = true;
            //    assignShop_CellName.Visible = true;
            //    assignShop_GroupDDL.Visible = true;
            //    assignShop_GroupName.Visible = true;
            //}
            //else if (cbassignShopGroup.Checked)
            //{
            //    type = "ShopGroup";
            //    assignShop_CellDDL.Visible = false;
            //    assignShop_CellName.Visible = false;
            //    assignShop_GroupDDL.Visible = true;
            //    assignShop_GroupName.Visible = true;
            //    //ddlCell_ForAssignMachineToShop.Visible = false;
            //    //ddlGroup_ForAssignMachineToShop.Visible = true;
            //}
            BindShopIDs(ddlShop_ForAssignMachineToShop, ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString(), false);
            BindCellIDs(ddlCell_ForAssignMachineToShop, ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString(), ddlShop_ForAssignMachineToShop.SelectedValue == null ? "" : ddlShop_ForAssignMachineToShop.SelectedValue.ToString(), false);
            if (!btnassignShop.CssClass.Contains("unselected-btn"))
            {
                assignShop_ShopDLL.Visible = false;
                assignShop_ShopName.Visible = false;
                assignShop_CellDDL.Visible = false;
                assignShop_CellName.Visible = false;
                lblmultiselectShopCellGroup_ForShop.Text = "Shop";
                BindShopIDsForMultiSelect(multiselectShop_ForShop, ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString(), false);
            }
            else if (!btnassignShopCell.CssClass.Contains("unselected-btn"))
            {
                assignShop_ShopDLL.Visible = true;
                assignShop_ShopName.Visible = true;
                assignShop_CellDDL.Visible = false;
                assignShop_CellName.Visible = false;
                lblmultiselectShopCellGroup_ForShop.Text = "Cell";
                BindCellIDsForMultiSelect(multiselectShop_ForShop, ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString(), ddlShop_ForAssignMachineToShop.SelectedValue == null ? "" : ddlShop_ForAssignMachineToShop.SelectedValue.ToString(), false);
            }
            else if (!btnassignShopCellGroup.CssClass.Contains("unselected-btn"))
            {
                //ddlCell_ForAssignMachineToShop.Visible = true;
                //ddlGroup_ForAssignMachineToShop.Visible = false;
                assignShop_ShopDLL.Visible = true;
                assignShop_ShopName.Visible = true;
                assignShop_CellDDL.Visible = true;
                assignShop_CellName.Visible = true;
                lblmultiselectShopCellGroup_ForShop.Text = "Group";
                BindGroupIDsForMultiSelect(multiselectShop_ForShop, ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString(), ddlShop_ForAssignMachineToShop.SelectedValue == null ? "" : ddlShop_ForAssignMachineToShop.SelectedValue.ToString(), ddlCell_ForAssignMachineToShop.SelectedValue == null ? "" : ddlCell_ForAssignMachineToShop.SelectedValue.ToString(), false);
            }
            else if (!btnassignShopGroup.CssClass.Contains("unselected-btn"))
            {
                assignShop_ShopDLL.Visible = true;
                assignShop_ShopName.Visible = true;
                assignShop_CellDDL.Visible = false;
                assignShop_CellName.Visible = false;
                //ddlCell_ForAssignMachineToShop.Visible = false;
                //ddlGroup_ForAssignMachineToShop.Visible = true;
                lblmultiselectShopCellGroup_ForShop.Text = "Group";
                BindGroupIDsForMultiSelect(multiselectShop_ForShop, ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString(), ddlShop_ForAssignMachineToShop.SelectedValue == null ? "" : ddlShop_ForAssignMachineToShop.SelectedValue.ToString(), "", false);
            }
            foreach (ListItem item in multiselectShop_ForShop.Items)
            {
                item.Selected = true;
            }
            //BindPlantIDsForAssignMachines(ddlPlant_ForAssignMachineToShop, false,type);
  
            //BindGroupIDs(ddlGroup_ForAssignMachineToShop, ddlPlant_ForAssignMachineToShop.SelectedValue == null ? "" : ddlPlant_ForAssignMachineToShop.SelectedValue.ToString(), ddlShop_ForAssignMachineToShop.SelectedValue == null ? "" : ddlShop_ForAssignMachineToShop.SelectedValue.ToString(), ddlCell_ForAssignMachineToShop.SelectedValue == null ? "" : ddlCell_ForAssignMachineToShop.SelectedValue.ToString(), false);
        }
      

        //protected void ddlPlant_ForAssignMachineToShop_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    BindShopIDs(ddlShop_ForAssignMachineToShop, ddlPlant_ForAssignMachineToShop.SelectedValue == null ? "" : ddlPlant_ForAssignMachineToShop.SelectedValue.ToString(), false);
        //    BindCellIDs(ddlCell_ForAssignMachineToShop, ddlPlant_ForAssignMachineToShop.SelectedValue == null ? "" : ddlPlant_ForAssignMachineToShop.SelectedValue.ToString(), ddlShop_ForAssignMachineToShop.SelectedValue == null ? "" : ddlShop_ForAssignMachineToShop.SelectedValue.ToString(), false);
        //    BindGroupIDs(ddlGroup_ForAssignMachineToShop, ddlPlant_ForAssignMachineToShop.SelectedValue == null ? "" : ddlPlant_ForAssignMachineToShop.SelectedValue.ToString(), ddlShop_ForAssignMachineToShop.SelectedValue == null ? "" : ddlShop_ForAssignMachineToShop.SelectedValue.ToString(), ddlCell_ForAssignMachineToShop.SelectedValue == null ? "" : ddlCell_ForAssignMachineToShop.SelectedValue.ToString(), false);
        //}

        protected void ddlShop_ForAssignMachineToShop_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindCellIDs(ddlCell_ForAssignMachineToShop, ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString(), ddlShop_ForAssignMachineToShop.SelectedValue == null ? "" : ddlShop_ForAssignMachineToShop.SelectedValue.ToString(), false);
            //BindGroupIDs(ddlGroup_ForAssignMachineToShop, ddlPlant_ForAssignMachine.SelectedValue == null ? "" : ddlPlant_ForAssignMachine.SelectedValue.ToString(), ddlShop_ForAssignMachineToShop.SelectedValue == null ? "" : ddlShop_ForAssignMachineToShop.SelectedValue.ToString(), ddlCell_ForAssignMachineToShop.SelectedValue == null ? "" : ddlCell_ForAssignMachineToShop.SelectedValue.ToString(), false);
        }

        private void ClearDataGridColumns(GridView gridView)
        {
            if (gridView.Columns.Count > 0)
            {
                for (int i = gridView.Columns.Count - 1; i >= 0; i--)
                {
                    gridView.Columns.RemoveAt(i);
                }
            }
        }

        protected void cbassignShop_CheckedChanged(object sender, EventArgs e)
        {
            showHideFilterSectionShop();
        }

        protected void cbassignShopGroup_CheckedChanged(object sender, EventArgs e)
        {
            showHideFilterSectionShop();
        }

        protected void cbassignShopCell_CheckedChanged(object sender, EventArgs e)
        {
            showHideFilterSectionShop();
        }

        protected void cbassignShopCellGroup_CheckedChanged(object sender, EventArgs e)
        {
            showHideFilterSectionShop();
        }

        private DataTable convertDatatypeStringToBool(DataTable dt,int indextochangetype)
        {
            DataTable dtCloned = dt.Clone();
            try
            {


                for (int i = 0; i < dt.Columns.Count; i++)
                {
                    if (i <= indextochangetype)
                    {
                        dtCloned.Columns[i].DataType = typeof(string);
                    }
                    else
                    {
                        dtCloned.Columns[i].DataType = typeof(bool);
                    }
               
                }
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    DataRow newrow = dtCloned.NewRow();
                    for (int j = 0; j < dt.Columns.Count; j++)
                    {
                        if (dt.Rows[i][j].ToString() == "0")
                        {
                            newrow[j] = false;
                        }
                        else if (dt.Rows[i][j].ToString() == "1")
                        {
                            newrow[j] = true;
                        }
                        else
                        {
                            string s= dt.Rows[i][j].ToString();
                            newrow[j]= dt.Rows[i][j].ToString();
                            //dtCloned.Rows[i][j] = dt.Rows[i][j].ToString();
                        }
                    }
                    dtCloned.Rows.Add(newrow);
                }

            }
            catch(Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
            return dtCloned;
        }
        //private void BindAssignMachineToPlantData()
        //{
        //    try
        //    {
        //        DataTable dt = DBAccess.getAllMachinePlantAssociation(lblCompany_ForAssignMachine.Text);
        //        ClearDataGridColumns(gvAssignMahineToPlantDetails);
        //        TemplateField tempField = new TemplateField();
        //        tempField.HeaderText = "";
        //        tempField.ItemTemplate = new DynamicTemplateField(DataControlRowType.DataRow);
        //        gvAssignMahineToPlantDetails.Columns.Add(tempField);
        //        DataTable dtData = convertDatatypeStringToBool(dt,1);
        //        if (dtData != null)
        //        {
        //            foreach (DataColumn dataColumn in dtData.Columns)
        //            {

        //                if (dataColumn.ColumnName.Equals("CompanyID", StringComparison.OrdinalIgnoreCase) || dataColumn.ColumnName.Equals("EffectiveFromdate", StringComparison.OrdinalIgnoreCase) || dataColumn.ColumnName.Equals("EffectiveTodate", StringComparison.OrdinalIgnoreCase))
        //                {
        //                    continue;
        //                }
        //                else if (dataColumn.ColumnName.Equals("MachineID", StringComparison.OrdinalIgnoreCase))
        //                {
        //                    BoundField boundField = new BoundField();
        //                    boundField.HeaderText = "Machine ID";
        //                    boundField.DataField = dataColumn.ColumnName;
        //                    boundField.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        //                    gvAssignMahineToPlantDetails.Columns.Add(boundField);
        //                }
        //                else
        //                {
        //                    CheckBoxField checkBoxField = new CheckBoxField();
        //                    checkBoxField.HeaderText = dataColumn.ColumnName;
        //                    checkBoxField.DataField = dataColumn.ColumnName;
        //                    checkBoxField.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
        //                    gvAssignMahineToPlantDetails.Columns.Add(checkBoxField);

        //                }
        //            }

        //            gvAssignMahineToPlantDetails.DataSource = dtData;
        //            gvAssignMahineToPlantDetails.DataBind();
        //            gvAssignMahineToPlantDetails.Columns[0].Visible = false;
        //        }
        //    }
        //    catch(Exception ex)
        //    {

        //    }
        //}

        private void BindAssignMachineToShopData()
        {
            try
            {
                string type="";
                //start from 0
                
                int columnIndextoBeginBoolType = 0;
                string selectedcolumn = "";
                foreach (ListItem item in multiselectShop_ForShop.Items)
                {
                    if (item.Selected)
                    {
                        if (selectedcolumn == "")
                        {
                            selectedcolumn = "'" + item.Text + "'";
                        }
                        else
                        {
                            selectedcolumn += ",'" + item.Text + "'";
                        }
                    }
                }
                if (!btnassignShop.CssClass.Contains("unselected-btn"))
                {
                    type = "ShopMachine";
                    columnIndextoBeginBoolType = 2;
                }
                else if (!btnassignShopCell.CssClass.Contains("unselected-btn"))
                {
                    type = "ShopCellMachine";
                    columnIndextoBeginBoolType = 3;
                }
                else if (!btnassignShopCellGroup.CssClass.Contains("unselected-btn"))
                {
                    type = "ShopCellGroupMachine";
                    columnIndextoBeginBoolType = 4;
                }
                else if (!btnassignShopGroup.CssClass.Contains("unselected-btn"))
                {
                    type = "ShopGroupMachine";
                    columnIndextoBeginBoolType = 3;
                }
                DataTable dt = DBAccess.getAllMachineShopAssociation(lblCompany.Text, ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString(), ddlShop_ForAssignMachineToShop.SelectedValue == null ? "" : ddlShop_ForAssignMachineToShop.SelectedValue.ToString(),ddlCell_ForAssignMachineToShop.SelectedValue==null?"": ddlCell_ForAssignMachineToShop.SelectedValue.ToString(),type,txtSearchMachine_ForShop.Text,selectedcolumn);
                ClearDataGridColumns(gvAssignMachineToShopDetails);
                TemplateField tempField = new TemplateField();
                tempField.HeaderText = "";
                tempField.ItemTemplate = new DynamicTemplateField(DataControlRowType.DataRow);
                gvAssignMachineToShopDetails.Columns.Add(tempField);
                DataTable dtData = convertDatatypeStringToBool(dt, columnIndextoBeginBoolType);
                if (dtData != null)
                {
                    foreach (DataColumn dataColumn in dtData.Columns)
                    {
                        if (dataColumn.ColumnName.Equals("CompanyID", StringComparison.OrdinalIgnoreCase) || dataColumn.ColumnName.Equals("EffectiveFromdate", StringComparison.OrdinalIgnoreCase) || dataColumn.ColumnName.Equals("EffectiveTodate", StringComparison.OrdinalIgnoreCase) || dataColumn.ColumnName.Equals("PlantID", StringComparison.OrdinalIgnoreCase) || dataColumn.ColumnName.Equals("ShopID", StringComparison.OrdinalIgnoreCase) || dataColumn.ColumnName.Equals("CellID", StringComparison.OrdinalIgnoreCase))
                        {
                            continue;
                        }
                        //else if (dataColumn.ColumnName.Equals("ShopID", StringComparison.OrdinalIgnoreCase))
                        //{
                        //    if (type == "Shop")
                        //    {
                        //        continue;
                        //    }
                        //    else
                        //    {
                        //        BoundField boundField = new BoundField();
                        //        boundField.HeaderText = "Shop ID";
                        //        boundField.DataField = dataColumn.ColumnName;
                        //        boundField.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                        //        gvAssignMachineToShopDetails.Columns.Add(boundField);
                        //    }
                          
                        //}
                        else if (dataColumn.ColumnName.Equals("MachineID", StringComparison.OrdinalIgnoreCase))
                        {
                            BoundField boundField = new BoundField();
                            boundField.HeaderText = "Machine ID";
                            boundField.DataField = dataColumn.ColumnName;
                            boundField.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                            gvAssignMachineToShopDetails.Columns.Add(boundField);
                        }
                        else
                        {
                            CheckBoxField checkBoxField = new CheckBoxField();
                            checkBoxField.HeaderText = dataColumn.ColumnName;
                            checkBoxField.DataField = dataColumn.ColumnName;
                            checkBoxField.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                            gvAssignMachineToShopDetails.Columns.Add(checkBoxField);

                        }
                    }

                    gvAssignMachineToShopDetails.DataSource = dtData;
                    gvAssignMachineToShopDetails.DataBind();
                    gvAssignMachineToShopDetails.Columns[0].Visible = false;
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }

        private void BindAssignMachineToCellData()
        {
            try
            {
                string type = "";
                //start from 0
                int columnIndextoBeginBoolType = 0;
                string selectedcolumn = "";
                foreach (ListItem item in multiselectCell_ForCell.Items)
                {
                    if (item.Selected)
                    {
                        if (selectedcolumn == "")
                        {
                            selectedcolumn = "'" + item.Text + "'";
                        }
                        else
                        {
                            selectedcolumn += ",'" + item.Text + "'";
                        }
                    }
                }
                if (!btnassignCell.CssClass.Contains("unselected-btn"))
                {
                    type = "CellMachine";
                    columnIndextoBeginBoolType = 2;

                }
                else if (!btnassignCellGroup.CssClass.Contains("unselected-btn"))
                {
                    type = "CellGroupMachine";
                    columnIndextoBeginBoolType =3;
                }
                DataTable dt = DBAccess.getAllMachineShopAssociation(lblCompany.Text, ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString(),"", ddlCell_ForAssignMachineToCell.SelectedValue == null ? "" : ddlCell_ForAssignMachineToCell.SelectedValue.ToString(), type,txtSearchMachine_ForCell.Text,selectedcolumn);
                ClearDataGridColumns(gvAssignMachineToCellDetails);
                TemplateField tempField = new TemplateField();
                tempField.HeaderText = "";
                tempField.ItemTemplate = new DynamicTemplateField(DataControlRowType.DataRow);
                gvAssignMachineToCellDetails.Columns.Add(tempField);
                DataTable dtData = convertDatatypeStringToBool(dt, columnIndextoBeginBoolType);
                if (dtData != null)
                {
                    foreach (DataColumn dataColumn in dtData.Columns)
                    {
                        if (dataColumn.ColumnName.Equals("CompanyID", StringComparison.OrdinalIgnoreCase) || dataColumn.ColumnName.Equals("EffectiveFromdate", StringComparison.OrdinalIgnoreCase) || dataColumn.ColumnName.Equals("EffectiveTodate", StringComparison.OrdinalIgnoreCase) || dataColumn.ColumnName.Equals("PlantID", StringComparison.OrdinalIgnoreCase) || dataColumn.ColumnName.Equals("ShopID", StringComparison.OrdinalIgnoreCase) || dataColumn.ColumnName.Equals("CellID", StringComparison.OrdinalIgnoreCase))
                        {
                            continue;
                        }
                        //else if (dataColumn.ColumnName.Equals("ShopID", StringComparison.OrdinalIgnoreCase))
                        //{
                        //    if (type == "Shop")
                        //    {
                        //        continue;
                        //    }
                        //    else
                        //    {
                        //        BoundField boundField = new BoundField();
                        //        boundField.HeaderText = "Shop ID";
                        //        boundField.DataField = dataColumn.ColumnName;
                        //        boundField.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                        //        gvAssignMachineToShopDetails.Columns.Add(boundField);
                        //    }

                        //}
                        else if (dataColumn.ColumnName.Equals("MachineID", StringComparison.OrdinalIgnoreCase))
                        {
                            BoundField boundField = new BoundField();
                            boundField.HeaderText = "Machine ID";
                            boundField.DataField = dataColumn.ColumnName;
                            boundField.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                            gvAssignMachineToCellDetails.Columns.Add(boundField);
                        }
                        else
                        {
                            CheckBoxField checkBoxField = new CheckBoxField();
                            checkBoxField.HeaderText = dataColumn.ColumnName;
                            checkBoxField.DataField = dataColumn.ColumnName;
                            checkBoxField.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                            gvAssignMachineToCellDetails.Columns.Add(checkBoxField);

                        }
                    }

                    gvAssignMachineToCellDetails.DataSource = dtData;
                    gvAssignMachineToCellDetails.DataBind();
                    gvAssignMachineToCellDetails.Columns[0].Visible = false;
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }

        private void BindAssignMachineToGroupData()
        {
            try
            {
                string type = "GroupMachine";
                //start from 0
                int columnIndextoBeginBoolType = 2;
                string selectedcolumn = "";
                foreach (ListItem item in multiselectCell_ForCell.Items)
                {
                    if (item.Selected)
                    {
                        if (selectedcolumn == "")
                        {
                            selectedcolumn = "'" + item.Text + "'";
                        }
                        else
                        {
                            selectedcolumn += ",'" + item.Text + "'";
                        }
                    }
                }
                DataTable dt = DBAccess.getAllMachineShopAssociation(lblCompany.Text, ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString(), "", "", type,txtSearchMachine_ForGroup.Text,selectedcolumn);
                ClearDataGridColumns(gvAssignMachineToGroupDetails);
                TemplateField tempField = new TemplateField();
                tempField.HeaderText = "";
                tempField.ItemTemplate = new DynamicTemplateField(DataControlRowType.DataRow);
                gvAssignMachineToGroupDetails.Columns.Add(tempField);
                DataTable dtData = convertDatatypeStringToBool(dt, columnIndextoBeginBoolType);
                if (dtData != null)
                {
                    foreach (DataColumn dataColumn in dtData.Columns)
                    {
                        if (dataColumn.ColumnName.Equals("CompanyID", StringComparison.OrdinalIgnoreCase) || dataColumn.ColumnName.Equals("EffectiveFromdate", StringComparison.OrdinalIgnoreCase) || dataColumn.ColumnName.Equals("EffectiveTodate", StringComparison.OrdinalIgnoreCase) || dataColumn.ColumnName.Equals("PlantID", StringComparison.OrdinalIgnoreCase) || dataColumn.ColumnName.Equals("ShopID", StringComparison.OrdinalIgnoreCase) || dataColumn.ColumnName.Equals("CellID", StringComparison.OrdinalIgnoreCase))
                        {
                            continue;
                        }
                        else if (dataColumn.ColumnName.Equals("MachineID", StringComparison.OrdinalIgnoreCase))
                        {
                            BoundField boundField = new BoundField();
                            boundField.HeaderText = "Machine ID";
                            boundField.DataField = dataColumn.ColumnName;
                            boundField.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                            gvAssignMachineToGroupDetails.Columns.Add(boundField);
                        }
                        else
                        {
                            CheckBoxField checkBoxField = new CheckBoxField();
                            checkBoxField.HeaderText = dataColumn.ColumnName;
                            checkBoxField.DataField = dataColumn.ColumnName;
                            checkBoxField.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                            gvAssignMachineToGroupDetails.Columns.Add(checkBoxField);

                        }
                    }

                    gvAssignMachineToGroupDetails.DataSource = dtData;
                    gvAssignMachineToGroupDetails.DataBind();
                    gvAssignMachineToGroupDetails.Columns[0].Visible = false;
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }

        protected void btnassignCell_Click(object sender, EventArgs e)
        {
            btnassignCell.CssClass = btnassignCell.CssClass.Replace("selected-btn blinking unselected-btn", "");
            btnassignCell.CssClass = "selected-btn blinking";
            btnassignCellGroup.CssClass = btnassignCell.CssClass.Replace("selected-btn blinking unselected-btn", "");
            btnassignCellGroup.CssClass = "unselected-btn";
            showHideFilterSectionCell();
            BindAssignMachineToCellData();
        }

        protected void btnassignCellGroup_Click(object sender, EventArgs e)
        {
            btnassignCellGroup.CssClass = btnassignCell.CssClass.Replace("selected-btn blinking unselected-btn", "");
            btnassignCellGroup.CssClass = "selected-btn blinking";
            btnassignCell.CssClass = btnassignCell.CssClass.Replace("selected-btn blinking unselected-btn", "");
            btnassignCell.CssClass = "unselected-btn";
            showHideFilterSectionCell();
            BindAssignMachineToCellData();
        }

        //protected void ddlPlant_ForAssignMachineToGroup_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    BindGroupIDs(ddlGroup_ForAssignMachineToGroup, ddlPlant_ForAssignMachineToGroup.SelectedValue == null ? "" : ddlPlant_ForAssignMachineToGroup.SelectedValue.ToString(), "", "", false);
        //}

        protected void btnassignShop_Click(object sender, EventArgs e)
        {
            clearAssignMachineToShopMenus();
            btnassignShop.CssClass = "selected-btn blinking";
            btnassignShopCell.CssClass = "unselected-btn";
            btnassignShopCellGroup.CssClass = "unselected-btn";
            btnassignShopGroup.CssClass = "unselected-btn";
            showHideFilterSectionShop();
            BindAssignMachineToShopData();
        }

        protected void btnassignShopCell_Click(object sender, EventArgs e)
        {
            clearAssignMachineToShopMenus();
            btnassignShopCell.CssClass = "selected-btn blinking";
            btnassignShop.CssClass = "unselected-btn";
            btnassignShopCellGroup.CssClass = "unselected-btn";
            btnassignShopGroup.CssClass = "unselected-btn";
            showHideFilterSectionShop();
            BindAssignMachineToShopData();
        }

        protected void btnassignShopCellGroup_Click(object sender, EventArgs e)
        {
            clearAssignMachineToShopMenus();
            btnassignShopCellGroup.CssClass = "selected-btn blinking";
            btnassignShop.CssClass = "unselected-btn";
            btnassignShopCell.CssClass = "unselected-btn";
            btnassignShopGroup.CssClass = "unselected-btn";
            showHideFilterSectionShop();
            BindAssignMachineToShopData();
        }

        protected void btnassignShopGroup_Click(object sender, EventArgs e)
        {
            clearAssignMachineToShopMenus();
            btnassignShopGroup.CssClass = "selected-btn blinking";
            btnassignShop.CssClass = "unselected-btn";
            btnassignShopCell.CssClass = "unselected-btn";
            btnassignShopCellGroup.CssClass = "unselected-btn";
            showHideFilterSectionShop();
            BindAssignMachineToShopData();
        }

        protected void gvAssignMahineToPlantDetails_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            GridViewRow gvRow = e.Row;
            if (gvRow.RowType == DataControlRowType.DataRow)
            {
                for (int i = 0; i < gvRow.Cells.Count; i++)
                {
                    if (gvRow.Cells[i].HasControls())
                    {
                        if (gvRow.Cells[i].Controls[0].GetType().Equals(typeof(CheckBox)))
                        {
                            CheckBox checkBox = (CheckBox)gvRow.Cells[i].Controls[0];
                            checkBox.Enabled = true;
                        }
                    }
                }
            }
        }

        //protected void btnAssignMachineToPlantView_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        BindAssignMachineToPlantData();
        //    }catch(Exception ex)
        //    {

        //    }
        //}

        protected void btnAssignMachineToShopView_Click(object sender, EventArgs e)
        {
            try
            {
                BindAssignMachineToShopData();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }

        protected void btnAssignMachineToShopSave_Click(object sender, EventArgs e)
        {
            try
            {
                //string companyid = lblCompany_ForAssignMachine.Text;
                //string plantid = ddlPlant_ForAssignMachine.SelectedValue==null?"":ddlPlant_ForAssignMachine.SelectedValue.ToString();
                string companyid = lblCompany.Text;
                string plantid = ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString();
                string shopid= ddlShop_ForAssignMachineToShop.SelectedValue == null ? "" : ddlShop_ForAssignMachineToShop.SelectedValue.ToString();
                string cellid= ddlCell_ForAssignMachineToShop.SelectedValue == null ? "" : ddlCell_ForAssignMachineToShop.SelectedValue.ToString();
                MachineAssignDetails data = null;

                string type = "";
                if (!btnassignShop.CssClass.Contains("unselected-btn"))
                {
                    type = "ShopMachine";
                }
                else if (!btnassignShopCell.CssClass.Contains("unselected-btn"))
                {
                    type = "ShopCellMachine";
                }
                else if (!btnassignShopCellGroup.CssClass.Contains("unselected-btn"))
                {
                    type = "ShopCellGroupMachine";
                }
                else if (!btnassignShopGroup.CssClass.Contains("unselected-btn"))
                {
                    type = "ShopGroupMachine";
                }
                foreach (GridViewRow selectedRow in gvAssignMachineToShopDetails.Rows)
                {
                    string machineid = selectedRow.Cells[1].Text;
                    for (int i = 2; i < selectedRow.Cells.Count; i++)
                    {
                        data = new MachineAssignDetails();
                        CheckBox checkBox = (CheckBox)selectedRow.Cells[i].Controls[0];
                        data.CompanyID = companyid;
                        data.MachineID = machineid;
                        data.PlantID = plantid;
                        data.EffectiveFromDate = "";
                        data.EffectiveToDate = "";
                        if(type== "ShopMachine")
                        {
                            data.ShopID = gvAssignMachineToShopDetails.HeaderRow.Cells[i].Text;
                        }else if(type== "ShopCellMachine")
                        {
                            data.ShopID = shopid;
                            if (shopid == "")
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openWarningModal('Shop ID required.');", true);
                                return;
                            }
                            data.CellID = gvAssignMachineToShopDetails.HeaderRow.Cells[i].Text;
                        }
                        else if(type == "ShopCellGroupMachine")
                        {
                            data.ShopID = shopid;
                            data.CellID =cellid;
                            if (shopid == "" || cellid=="")
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openWarningModal('Shop ID and Cell ID required.');", true);
                                return;
                            }
                            data.GroupID = gvAssignMachineToShopDetails.HeaderRow.Cells[i].Text;
                        }
                        else if(type== "ShopGroupMachine")
                        {
                            data.ShopID =shopid;
                            if (shopid == "" )
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openWarningModal('Shop ID required.');", true);
                                return;
                            }
                            data.GroupID = gvAssignMachineToShopDetails.HeaderRow.Cells[i].Text;
                        }


                        data.Type = type;
                        if (checkBox.Checked)
                        {
                            data.CheckOrUncheck = "Check";
                            DBAccess.saveUpdateAssignMachineToShopDetails(data);
                        }
                        else
                        {
                            data.CheckOrUncheck = "Uncheck";
                            DBAccess.saveUpdateAssignMachineToShopDetails(data);
                        }
                        //if (sucess <= 0)
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "openErrorModal('Failed to insert records, for Machine ID " + machineid + "');", true);
                        //    return;
                        //}
                    }
                }
                BindAssignMachineToShopData();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Records saved Successfully.','');", true);

            }
            catch (Exception ex)
            {
                BindAssignMachineToShopData();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "openErrorModal('Failed to insert records: " + ex.Message + "');", true);
                Logger.WriteErrorLogDetailed(ex);
            }
        }

        protected void gvAssignMachineToShopDetails_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            GridViewRow gvRow = e.Row;
            if (gvRow.RowType == DataControlRowType.DataRow)
            {
                for (int i = 0; i < gvRow.Cells.Count; i++)
                {
                    if (gvRow.Cells[i].HasControls())
                    {
                        if (gvRow.Cells[i].Controls[0].GetType().Equals(typeof(CheckBox)))
                        {
                            CheckBox checkBox = (CheckBox)gvRow.Cells[i].Controls[0];
                            checkBox.Enabled = true;
                        }
                    }
                }
            }
        }

        protected void btnAssignMachineToCellView_Click(object sender, EventArgs e)
        {
            try
            {
                BindAssignMachineToCellData();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }

        protected void btnAssignMachineToCellSave_Click(object sender, EventArgs e)
        {
            try
            {
                //string companyid = lblCompany_ForAssignMachine.Text;
                //string plantid = ddlPlant_ForAssignMachine.SelectedValue == null ? "" : ddlPlant_ForAssignMachine.SelectedValue.ToString();
                string companyid = lblCompany.Text;
                string plantid = ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString();
                string cellid= ddlCell_ForAssignMachineToCell.SelectedValue == null ? "" : ddlCell_ForAssignMachineToCell.SelectedValue.ToString();
                MachineAssignDetails data = null;

                string type = "";
                if (!btnassignCell.CssClass.Contains("unselected-btn"))
                {
                    type = "CellMachine";
                }
                else if (!btnassignCellGroup.CssClass.Contains("unselected-btn"))
                {
                    type = "CellGroupMachine";
                }
                foreach (GridViewRow selectedRow in gvAssignMachineToCellDetails.Rows)
                {
                    string machineid = selectedRow.Cells[1].Text;
                    for (int i = 2; i < selectedRow.Cells.Count; i++)
                    {
                        data = new MachineAssignDetails();
                        CheckBox checkBox = (CheckBox)selectedRow.Cells[i].Controls[0];
                        data.CompanyID = companyid;
                        data.MachineID = machineid;
                        data.PlantID = plantid;
                        data.EffectiveFromDate = "";
                        data.EffectiveToDate = "";
                        if (type == "CellMachine")
                        {
                            data.CellID = gvAssignMachineToCellDetails.HeaderRow.Cells[i].Text;
                        }
                        else if (type == "CellGroupMachine")
                        {
                            if (cellid == "")
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openWarningModal('Cell ID required.');", true);
                                return;
                            }
                            data.CellID = cellid;
                            data.GroupID = gvAssignMachineToCellDetails.HeaderRow.Cells[i].Text;
                        }
                       
                        data.Type = type;
                        if (checkBox.Checked)
                        {
                            data.CheckOrUncheck = "Check";
                            DBAccess.saveUpdateAssignMachineToShopDetails(data);
                        }
                        else
                        {
                            data.CheckOrUncheck = "Uncheck";
                            DBAccess.saveUpdateAssignMachineToShopDetails(data);
                        }
                    }
                }
                BindAssignMachineToCellData();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Records saved Successfully.','');", true);

            }
            catch (Exception ex)
            {
                BindAssignMachineToCellData();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "openErrorModal('Failed to insert records: " + ex.Message + "');", true);

            }
        }

        protected void gvAssignMachineToCellDetails_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            GridViewRow gvRow = e.Row;
            if (gvRow.RowType == DataControlRowType.DataRow)
            {
                for (int i = 0; i < gvRow.Cells.Count; i++)
                {
                    if (gvRow.Cells[i].HasControls())
                    {
                        if (gvRow.Cells[i].Controls[0].GetType().Equals(typeof(CheckBox)))
                        {
                            CheckBox checkBox = (CheckBox)gvRow.Cells[i].Controls[0];
                            checkBox.Enabled = true;
                        }
                    }
                }
            }
        }

        protected void btnAssignMachineToGroupSave_Click(object sender, EventArgs e)
        {
            try
            {
                //string companyid = lblCompany_ForAssignMachine.Text;
                //string plantid = ddlPlant_ForAssignMachine.SelectedValue == null ? "" : ddlPlant_ForAssignMachine.SelectedValue.ToString();
                string companyid = lblCompany.Text;
                string plantid = ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString();
                MachineAssignDetails data = null;

                string type = "GroupMachine";
                foreach (GridViewRow selectedRow in gvAssignMachineToGroupDetails.Rows)
                {
                    string machineid = selectedRow.Cells[1].Text;
                    for (int i = 2; i < selectedRow.Cells.Count; i++)
                    {
                        data = new MachineAssignDetails();
                        CheckBox checkBox = (CheckBox)selectedRow.Cells[i].Controls[0];
                        data.CompanyID = companyid;
                        data.MachineID = machineid;
                        data.PlantID = plantid;
                        data.EffectiveFromDate = "";
                        data.EffectiveToDate = "";
                        data.GroupID = gvAssignMachineToGroupDetails.HeaderRow.Cells[i].Text;
                        data.Type = type;
                        if (checkBox.Checked)
                        {
                            data.CheckOrUncheck = "Check";
                            DBAccess.saveUpdateAssignMachineToShopDetails(data);
                        }
                        else
                        {
                            data.CheckOrUncheck = "Uncheck";
                            DBAccess.saveUpdateAssignMachineToShopDetails(data);
                        }
                    }
                }
                BindAssignMachineToGroupData();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Records saved Successfully.','');", true);

            }
            catch (Exception ex)
            {
                BindAssignMachineToGroupData();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "openErrorModal('Failed to insert records: " + ex.Message + "');", true);

            }
        }

        protected void btnAssignMachineToGroupView_Click(object sender, EventArgs e)
        {
            try
            {
                BindAssignMachineToGroupData();
            }
            catch(Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }

        }
        protected void gvAssignMachineToGroupDetails_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            GridViewRow gvRow = e.Row;
            if (gvRow.RowType == DataControlRowType.DataRow)
            {
                for (int i = 0; i < gvRow.Cells.Count; i++)
                {
                    if (gvRow.Cells[i].HasControls())
                    {
                        if (gvRow.Cells[i].Controls[0].GetType().Equals(typeof(CheckBox)))
                        {
                            CheckBox checkBox = (CheckBox)gvRow.Cells[i].Controls[0];
                            checkBox.Enabled = true;
                        }
                    }
                }
            }
        }

        protected void ddlPlant_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["LHPlant"] = ddlPlant.SelectedValue.ToString();
            if (hfActiveMenu.Value=="Machine")
            {
                ShowHideList(lblCompany.Text, ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString(), "", true);
            }
            else{
                ShowHideList(lblCompany.Text, ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString(), "", false);
            }
            
           // ShowHideMachineAssignMenuList(lblCompany.Text, ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString(), "");
        }

        protected void btnAssignMachineToPlantSave_Click(object sender, EventArgs e)
        {
            //try
            //{
            //    //string value = hdnCheckChange1.Value;
            //    //if (value.Equals("Update", StringComparison.OrdinalIgnoreCase))
            //    //{
            //    string companyid = lblCompany_ForAssignMachine.Text;
            //    MachineAssignDetails data = null;
            //    foreach (GridViewRow selectedRow in gvAssignMahineToPlantDetails.Rows)
            //    {

            //        // string IsUpdate = selectedRow.Cells[0].Text;
            //        string machineid = selectedRow.Cells[1].Text;
            //        //string effectiveFromDate = selectedRow.Cells[3].Text==""?DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"): Util.GetDateTime(selectedRow.Cells[3].Text).ToString("yyyy-MM-dd HH:mm:ss");
            //        //string effectiveToDate = selectedRow.Cells[4].Text == "" ? DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") : Util.GetDateTime(selectedRow.Cells[4].Text).ToString("yyyy-MM-dd HH:mm:ss");
            //        for (int i = 2; i < selectedRow.Cells.Count; i++)
            //        {
            //            data = new MachineAssignDetails();
            //            string plantid = gvAssignMahineToPlantDetails.HeaderRow.Cells[i].Text;
            //            CheckBox checkBox = (CheckBox)selectedRow.Cells[i].Controls[0];

            //            data.CompanyID = companyid;
            //            data.MachineID = machineid;
            //            data.PlantID = plantid;
            //            data.EffectiveFromDate = "";
            //            data.EffectiveToDate = "";
            //            if (checkBox.Checked)
            //            {
            //                data.CheckOrUncheck = "Check";
            //                DBAccess.saveUpdateAssignMachineToPlantDetails(data);
            //            }
            //            else
            //            {
            //                data.CheckOrUncheck = "Uncheck";
            //                DBAccess.saveUpdateAssignMachineToPlantDetails(data);
            //            }
            //        }
            //    }

            //    // ScriptManager.RegisterStartupScript(this, this.GetType(), "Success", "showpop5('Saved Successfully.')", true);
            //    // hdnCheckChange1.Value = "";
            //    // }
            //    BindAssignMachineToPlantData();
            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Records saved Successfully.','');", true);
              
            //}
            //catch (Exception ex)
            //{
            //    BindAssignMachineToPlantData();
            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "openErrorModal('Failed to insert records: "+ex.Message +"');", true);
               
            //}
        }

    
        //protected void ddlPlant_ForAssignMachineToCell_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    BindCellIDs(ddlCell_ForAssignMachineToCell, ddlPlant_ForAssignMachineToCell.SelectedValue == null ? "" : ddlPlant_ForAssignMachineToCell.SelectedValue.ToString(), "", false);
        //    BindGroupIDs(ddlGroup_ForAssignMachineToCell, ddlPlant_ForAssignMachineToCell.SelectedValue == null ? "" : ddlPlant_ForAssignMachineToCell.SelectedValue.ToString(), "", ddlCell_ForAssignMachineToCell.SelectedValue == null ? "" : ddlCell_ForAssignMachineToCell.SelectedValue.ToString(), false);
        //}

     

        //protected void ddlCell_ForAssignMachineToCell_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    BindGroupIDs(ddlGroup_ForAssignMachineToCell, ddlPlant_ForAssignMachineToCell.SelectedValue == null ? "" : ddlPlant_ForAssignMachineToCell.SelectedValue.ToString(), "", ddlCell_ForAssignMachineToCell.SelectedValue == null ? "" : ddlCell_ForAssignMachineToCell.SelectedValue.ToString(), false);
        //}

        #endregion

        #region -----Role Details-------
        private void BindRoleData()
        {
            //try
            //{
            //    List<RoleDetails> roleDetails = new List<RoleDetails>();
            //    RoleDetails data = new RoleDetails();
            //    data.CompanyID = Session["CompanyName"].ToString();
            //    data.RoleName = txtRoleNameSearch.Text;
            //    roleDetails = DBAccess.getRoleDetails(data);
            //    gvRoleDetails.DataSource = roleDetails;
            //    gvRoleDetails.DataBind();
            //}
            //catch (Exception ex)
            //{

            //}

        }
        protected void btnNewEditRoleSave_Click(object sender, EventArgs e)
        {
            try
            {
                RoleDetails data = new RoleDetails();
                data.CompanyID = Session["CompanyName"].ToString();
                data.RoleName = txtRoleName.Text;
                data.UpdatedBy = HttpContext.Current.Session["Username"] == null ? "" : HttpContext.Current.Session["Username"].ToString();
                data.UpdatedTS = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                data.EffectiveFromDate = Util.GetDateTime(txtShopEffFromDate.Text).ToString("yyyy-MM-dd HH:mm:ss");
                data.EffectiveToDate = Util.GetDateTime(txtShopEffToDate.Text).ToString("yyyy-MM-dd HH:mm:ss");
                data.NewOrEditParam = hfShopEditNew.Value;
                string date = DBAccess.checkRoleEffectiveDate(data);
                if (date == "")
                {

                }
                else
                {
                    DateTime maxEfffromdate, enteredEffeFromDate;
                    maxEfffromdate = Util.GetDateTime(date);
                    enteredEffeFromDate = Util.GetDateTime(data.EffectiveFromDate);
                    if (enteredEffeFromDate <= maxEfffromdate)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openWarningModal('Effective from date should be greater than " + maxEfffromdate.ToString("dd-MM-yyyy HH:mm:ss") + "');", true);
                        return;
                    }
                }
                string Success = DBAccess.saveUpdateRoleDetails(data);
                if (Success == "Exist")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openWarningModal('Shop ID already exists.');", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "openModal('neweditRoleModal')", true);
                }
                else if (Success == "Inserted")
                {
                    BindRoleData();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Record saved Successfully.','');", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "clearAllModalScreen()", true);
                }
                else if (Success == "Updated")
                {
                    BindRoleData();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Record updated Successfully.','');", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "clearAllModalScreen()", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "openErrorModal('Failed to insert record.');", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "openModal('neweditRoleModal')", true);
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLogDetailed(ex);
            }
        }
        protected void btnRoleView_Click(object sender, EventArgs e)
        {
            BindRoleData();
        }
        protected void lbDeleteRole_Click(object sender, EventArgs e)
        {
            //try
            //{
            //    RoleIndexToDelete = Convert.ToInt32(((sender as LinkButton).NamingContainer as GridViewRow).RowIndex);
            //    string deleteMsg = "Are you sure you want to delete Role ID " + (gvRoleDetails.Rows[RoleIndexToDelete].FindControl("lblRoleID") as Label).Text + ".";
            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "openRoleDeleteConfirmModal('" + deleteMsg + "')", true);
            //}
            //catch (Exception ex)
            //{

            //}
        }

        protected void btnDeleteRoleConfirm_Click(object sender, EventArgs e)
        {
        //    try
        //    {
        //        RoleDetails data = new RoleDetails();
        //        data.CompanyID = (gvRoleDetails.Rows[RoleIndexToDelete].FindControl("lblCompanyID") as Label).Text;
        //        data.RoleID = (gvRoleDetails.Rows[RoleIndexToDelete].FindControl("lblRoleID") as Label).Text;
        //        data.RoleName = (gvRoleDetails.Rows[RoleIndexToDelete].FindControl("lblRoleName") as Label).Text;
        //        data.UpdatedBy = HttpContext.Current.Session["Username"] == null ? "" : HttpContext.Current.Session["Username"].ToString();
        //        data.UpdatedTS = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
        //        data.EffectiveFromDate = Util.GetDateTime(((gvRoleDetails.Rows[RoleIndexToDelete].FindControl("lblEffevtiveFromDate") as Label).Text)).ToString("yyyy-MM-dd HH:mm:ss");
        //        data.EffectiveToDate = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
        //        int result = DBAccess.deleteRoleGroupDetails(data);
        //        if (result > 0)
        //        {

        //            ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Record deleted Successfully.','');", true);
        //            ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "clearAllModalScreen()", true);
        //        }
        //        else
        //        {
        //            ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "openErrorModal('Failed to delete record.');", true);
        //            return;
        //        }
        //        BindRoleData();
        //        RoleIndexToDelete = -1;
        //    }
        //    catch (Exception ex)
        //    {

        //    }
        }


        #endregion
    }

    public class DynamicTemplateField : ITemplate
    {
        DataControlRowType type;
        public DynamicTemplateField(DataControlRowType type)
        {
            this.type = type;
        }
        public void InstantiateIn(Control container)
        {
            switch (type)
            {
                case DataControlRowType.DataRow:
                    HiddenField hfUpdate = new HiddenField();
                    hfUpdate.ID = "hdfUpdate";
                    hfUpdate.ClientIDMode = ClientIDMode.Static;
                    container.Controls.Add(hfUpdate);
                    break;
            }
            //HiddenField hfUpdate = new HiddenField();
            //hfUpdate.ID = "hdfUpdate";
            //container.Controls.Add(hfUpdate);
        }
    }
}