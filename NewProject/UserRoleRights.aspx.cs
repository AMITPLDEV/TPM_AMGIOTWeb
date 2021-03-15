using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NewProject.DataBaseAccess;
using NewProject.Model;

namespace NewProject
{
    public partial class UserRoleRights : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                //GetAllControls(Page);
                if (!IsPostBack)
                {
                    btnUserRoleRights_Click(null, null);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "setActiveValue", "setActiveSubmenuValue();", true);
                  
                }
                ReadOrModifyPage();
            }
            catch(Exception ex)
            {

            }
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
                string accestype = list.Where(x => x.Screen == "User Roles").Select(x => x.Value).FirstOrDefault();
                if (accestype == "Read")
                {
                    btnUserRoleRightsSave.Visible = false;
                }
                else
                {
                    btnUserRoleRightsSave.Visible = true;
                }
            }
            catch(Exception ex)
            {

            }
        }
        //public IEnumerable<Control> GetAllControls(this Control parent)
        //{
        //    foreach (Control control in parent.Controls)
        //    {
        //        yield return control;
        //        if (control.HasControls())
        //        {
        //            IEnumerable<Control> foundControl = GetAllControls(control);
        //            foreach (Control child in foundControl)
        //            {
        //                yield return child;
        //            }
        //        }
        //    }
        //}

        #region ---------- User Rights Exception -----------
        protected void btnUserRightException_Click(object sender, EventArgs e)
        {
            try
            {
                BindCompanyID(ddlUserRightExptnCompany);
                ddlUserRightExptnCompany_SelectedIndexChanged(null, null);
                BindUserRightsExceptionData();
            }
            catch (Exception ex) { }
        }
        private void BindCompanyID(DropDownList ddl)
        {
            try
            {
                ddl.DataSource = DBAccess.getCompanyData();
                ddl.DataBind();
            
            }
            catch (Exception ex)
            {

            }
        }
        protected void ddlUserRightExptnCompany_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                ddlUserRightExptnRole.DataSource = DBAccess.getUserRole(ddlUserRightExptnCompany.SelectedValue);
                ddlUserRightExptnRole.DataBind();
            }
            catch (Exception ex)
            {

            }
        }
        private void BindUserRightsExceptionData()
        {
            try
            {
                string selectedUserIdList = "";
                for (int i = 0; i < gvUserIDList.Rows.Count; i++)
                {
                    if ((gvUserIDList.Rows[i].FindControl("chkUserIDChecked") as CheckBox).Checked)
                    {
                        if (selectedUserIdList == "")
                        {

                            selectedUserIdList += "'" + (gvUserIDList.Rows[i].FindControl("lblUserID") as Label).Text + "'";
                        }
                        else
                        {
                            selectedUserIdList += ",'" + (gvUserIDList.Rows[i].FindControl("lblUserID") as Label).Text + "'";
                        }
                    }

                }
                List<UserRoleData> list = new List<UserRoleData>();
                if (selectedUserIdList != "")
                {
                    DataTable userRightsDt = DBAccess.getUserRightsExceptionDetails(ddlUserRightExptnCompany.SelectedValue, ddlUserRightExptnRole.SelectedValue, selectedUserIdList);

                    UserRoleData data = new UserRoleData();
                    bool firstRowEntered = true; // For first list item insert header related vaulues
                    for (int i = 0; i < userRightsDt.Rows.Count; i++)
                    {
                        data = new UserRoleData();
                        if (firstRowEntered)
                        {
                            data.CompanyID = "Company";
                            data.Module = "Module";
                            data.Screen = "Screen";
                        }
                        else
                        {
                            data.CompanyID = userRightsDt.Rows[i]["CompanyID"].ToString();
                            data.Module = userRightsDt.Rows[i]["Module"].ToString();
                            data.Screen = userRightsDt.Rows[i]["Screen"].ToString();
                        }


                        List<UserRoleRightsData> listRights = new List<UserRoleRightsData>();
                        UserRoleRightsData rights = null;
                        for (int col = 3; col < userRightsDt.Columns.Count; col++)
                        {

                            rights = new UserRoleRightsData();
                            if (firstRowEntered)
                            {
                                rights.HeaderTemplateVisibility = "block";
                                rights.DataTemplateVisibility = "none";
                            }
                            else
                            {
                                rights.HeaderTemplateVisibility = "none";
                                rights.DataTemplateVisibility = "block";
                            }


                            rights.UserID = userRightsDt.Columns[col].ColumnName;
                            if (firstRowEntered)
                            {
                                int readCount = userRightsDt.AsEnumerable().Where(k => k.Field<string>(rights.UserID) == "Read").Count();
                                int modifyCount = userRightsDt.AsEnumerable().Where(k => k.Field<string>(rights.UserID) == "Modify").Count();
                                int noneCount = userRightsDt.AsEnumerable().Where(k => k.Field<string>(rights.UserID) == "None").Count();
                                int tableCount = userRightsDt.Rows.Count;
                                rights.IsModifyChcked = false;
                                rights.IsReadChecked = false;
                                rights.IsNoneChacked = false;
                                if (readCount == tableCount)
                                {
                                    rights.IsReadChecked = true;
                                }
                                else if (modifyCount == tableCount)
                                {
                                    rights.IsModifyChcked = true;
                                }
                                else if (noneCount == tableCount)
                                {
                                    rights.IsNoneChacked = true;
                                }
                            }
                            else
                            {
                                if (string.Equals(userRightsDt.Rows[i][col].ToString(), "Read", StringComparison.OrdinalIgnoreCase))
                                {
                                    rights.IsModifyChcked = false;
                                    rights.IsReadChecked = true;
                                    rights.IsNoneChacked = false;
                                }
                                else if (string.Equals(userRightsDt.Rows[i][col].ToString(), "Modify", StringComparison.OrdinalIgnoreCase))
                                {
                                    rights.IsModifyChcked = true;
                                    rights.IsReadChecked = false;
                                    rights.IsNoneChacked = false;
                                }
                                else if (string.Equals(userRightsDt.Rows[i][col].ToString() , "None", StringComparison.OrdinalIgnoreCase))
                                {
                                    rights.IsModifyChcked = false;
                                    rights.IsReadChecked = false;
                                    rights.IsNoneChacked = true;
                                }
                                else
                                {
                                    rights.IsModifyChcked = false;
                                    rights.IsReadChecked = false;
                                    rights.IsNoneChacked = false;
                                }
                            }
                            listRights.Add(rights);
                        }
                        data.UserRightValue = listRights;
                        list.Add(data);
                        if (firstRowEntered)
                        {
                            i = -1;
                            firstRowEntered = false;
                        }
                    }

                }
                lvUserAssignedToRole.DataSource = list;
                lvUserAssignedToRole.DataBind();
            }
            catch (Exception ex)
            { }
        }
        private void BindUserRightExceptionUserIdData()
        {
            try
            {
                List<UserRoleData> list = DBAccess.getUserIDListForUserRightsException(ddlUserRightExptnCompany.SelectedValue, ddlUserRightExptnRole.SelectedValue);
                if (list.Count > 0)
                {
                    list.Insert(0, new UserRoleData() { UserID = "Select All" });
                }
                gvUserIDList.DataSource = list;
                gvUserIDList.DataBind();
            }
            catch (Exception ex)
            { }
        }
        protected void btnUserRightExptnView_Click(object sender, EventArgs e)
        {
            try
            {
                BindUserRightExceptionUserIdData();
                BindUserRightsExceptionData();
            }
            catch (Exception ex) { }
        }

        protected void btnUserRightEcptnUserIdView_Click(object sender, EventArgs e)
        {
            try
            {

                BindUserRightsExceptionData();
            }
            catch (Exception ex) { }
        }

        protected void btnUserATRoleSave_Click(object sender, EventArgs e)
        {
            try
            {
                for (int i = 1; i < lvUserAssignedToRole.Items.Count; i++)
                {
                    string companyid = (lvUserAssignedToRole.Items[i].FindControl("lblCompanyID") as Label).Text;
                    string module = (lvUserAssignedToRole.Items[i].FindControl("lblModule") as Label).Text;
                    string screen = (lvUserAssignedToRole.Items[i].FindControl("lblScreen") as Label).Text;
                    ListView innerLisview = lvUserAssignedToRole.Items[i].FindControl("lvUserAssignedToRoleRights") as ListView;
                    for (int innerLvCount = 0; innerLvCount < innerLisview.Items.Count; innerLvCount++)
                    {
                        UserRoleData data = new UserRoleData();
                        data.UserID = (innerLisview.Items[innerLvCount].FindControl("lblUserID") as Label).Text;
                        data.CompanyID = companyid;
                        data.Module = module;
                        data.Screen = screen;
                        if ((innerLisview.Items[innerLvCount].FindControl("rbRead") as RadioButton).Checked)
                        {
                            data.Value = "Read";
                        }
                        else if ((innerLisview.Items[innerLvCount].FindControl("rbModify") as RadioButton).Checked)
                        {
                            data.Value = "Modify";
                        }
                        else
                        {
                            data.Value = "None";
                        }
                        DBAccess.insertUpdateUserRightExceptionDetails(data);
                    }
                }
                ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Record saved Successfully.','');", true);
            }
            catch (Exception ex)
            {

            }
        }
        #endregion


        #region  ------ User Role Rights-------
        protected void btnUserRoleRights_Click(object sender, EventArgs e)
        {
            BindCompanyID(ddlCompany_ForUserRoleRights);
            ddlCompany_ForUserRoleRights_SelectedIndexChanged(null, null);
            BindUserRoleRightsData();
        }
        private void BindUserRoleRightsData()
        {
            try
            {
                DataTable dt = new DataTable();
                dt = DBAccess.getUserRoleRightsDetails(ddlCompany_ForUserRoleRights.SelectedValue==null?"":ddlCompany_ForUserRoleRights.SelectedValue.ToString() , ddlRole_ForUserRoleRights.SelectedValue==null?"":ddlRole_ForUserRoleRights.SelectedValue.ToString());
                List<UserRoleData> list = new List<UserRoleData>();
                UserRoleData data = new UserRoleData();


                if (dt.Columns.Count > 3)
                {
                    data = new UserRoleData();
                    data.CompanyID = "Company ID";
                    data.Module = "Module";
                    data.Screen = "Screen";
                    List<UserRoleRightsData> listRights = new List<UserRoleRightsData>();
                    UserRoleRightsData rights = null;
                    for (int col = 3; col < dt.Columns.Count; col++)
                    {

                        rights = new UserRoleRightsData();
                        rights.RoleID = dt.Columns[col].ColumnName;
                        rights.HeaderTemplateVisibility = "block";
                        rights.DataTemplateVisibility = "none";

                        int readCount = dt.AsEnumerable().Where(k => k.Field<string>(rights.RoleID) == "Read").Count();
                        int modifyCount = dt.AsEnumerable().Where(k => k.Field<string>(rights.RoleID) == "Modify").Count();
                        int noneCount = dt.AsEnumerable().Where(k => k.Field<string>(rights.RoleID) == "None").Count();
                        int tableCount = dt.Rows.Count;
                        rights.IsModifyChcked = false;
                        rights.IsReadChecked = false;
                        rights.IsNoneChacked = false;
                        if (readCount == tableCount)
                        {
                            rights.IsReadChecked = true;
                        }
                        else if (modifyCount == tableCount)
                        {
                            rights.IsModifyChcked = true;
                        }
                        else if (noneCount == tableCount)
                        {
                            rights.IsNoneChacked = true;
                        }

                        listRights.Add(rights);
                    }
                    data.UserRightValue = listRights;
                    list.Add(data);
                }
                for (int row = 0; row < dt.Rows.Count; row++)
                {
                    data = new UserRoleData();
                    data.CompanyID = dt.Rows[row]["CompanyID"].ToString();
                    data.Module = dt.Rows[row]["Module"].ToString();
                    data.Screen = dt.Rows[row]["Screen"].ToString();
                    List<UserRoleRightsData> listRights = new List<UserRoleRightsData>();
                    UserRoleRightsData rights = null;
                    for (int col = 3; col < dt.Columns.Count; col++)
                    {
                        rights = new UserRoleRightsData();
                        rights.RoleID = dt.Columns[col].ColumnName;
                        rights.HeaderTemplateVisibility = "none";
                        rights.DataTemplateVisibility = "block";
                        if (dt.Rows[row][col].ToString() == "Read")
                        {
                            rights.IsModifyChcked = false;
                            rights.IsReadChecked = true;
                            rights.IsNoneChacked = false;
                        }
                        else if (dt.Rows[row][col].ToString() == "Modify")
                        {
                            rights.IsModifyChcked = true;
                            rights.IsReadChecked = false;
                            rights.IsNoneChacked = false;
                        }
                        else
                        {
                            rights.IsModifyChcked = false;
                            rights.IsReadChecked = false;
                            rights.IsNoneChacked = true;
                        }

                        listRights.Add(rights);
                    }
                    data.UserRightValue = listRights;
                    list.Add(data);
                }
                lvUserRoleRightsDetails.DataSource = list;
                lvUserRoleRightsDetails.DataBind();
            }
            catch (Exception ex)
            { }
        }
        protected void btnUserRoleRightsView_Click(object sender, EventArgs e)
        {
            BindUserRoleRightsData();
        }

        protected void btnUserRoleRightsSave_Click(object sender, EventArgs e)
        {
            try
            {
                for (int i = 1; i < lvUserRoleRightsDetails.Items.Count; i++)
                {
                    string companyid = (lvUserRoleRightsDetails.Items[i].FindControl("lblCompanyID") as Label).Text;
                    string module = (lvUserRoleRightsDetails.Items[i].FindControl("lblModule") as Label).Text;
                    string screen = (lvUserRoleRightsDetails.Items[i].FindControl("lblScreen") as Label).Text;
                    ListView innerLisview = lvUserRoleRightsDetails.Items[i].FindControl("lvRoleAssignToScreenDetails") as ListView;
                    for (int innerLvCount = 0; innerLvCount < innerLisview.Items.Count; innerLvCount++)
                    {
                        UserRoleData data = new UserRoleData();
                        data.RoleID = (innerLisview.Items[innerLvCount].FindControl("hfRoleID") as HiddenField).Value;
                        data.CompanyID = companyid;
                        data.Module = module;
                        data.Screen = screen;
                        if ((innerLisview.Items[innerLvCount].FindControl("rbRead") as RadioButton).Checked)
                        {
                            data.Value = "Read";
                            data.CheckOrUncheck = "Check";
                        }
                        else if ((innerLisview.Items[innerLvCount].FindControl("rbModify") as RadioButton).Checked)
                        {
                            data.Value = "Modify";
                            data.CheckOrUncheck = "Check";
                        }
                        else
                        {
                            data.Value = "None";
                            data.CheckOrUncheck = "UnCheck";
                        }
                        DBAccess.saveUpdateUserRoleRightsDetails(data);
                    }
                }
                ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Record saved Successfully.','');", true);
                BindUserRoleRightsData();
            }
            catch (Exception ex)
            {

            }
        }

        protected void ddlCompany_ForUserRoleRights_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                List<string> list = new List<string>();
                list = DBAccess.getUserRole(ddlCompany_ForUserRoleRights.SelectedValue == null ? "" : ddlCompany_ForUserRoleRights.SelectedValue.ToString());
                if (list.Count > 1)
                {
                    list.Insert(0, "All");
                }
                ddlRole_ForUserRoleRights.DataSource = list;
                ddlRole_ForUserRoleRights.DataBind();
            }
            catch (Exception ex)
            {

            }
        }
        #endregion


    }
}