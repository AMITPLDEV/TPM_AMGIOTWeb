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
    public partial class CompanyGroupMaster : System.Web.UI.Page
    {
        private static int GroupIndexToDelete = -1, CompanyIndexToToDelete = -1, PlantIndexToDelete = -1, RoleIndexToDelete = -1, selectedDeleteRowIndex = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string company = (string)Session["CompanyName"];
                lblCompany_ForMachine.Text = company;
                lblCompany_ForPlant.Text = company;
                lblCompany_ForAssignMachine.Text = company;
                lblCompany_ForRole.Text = company;
                lblCompany_ForRoleNewEdit.Text = company;
                lblCompany_ForEmployee.Text = company;
                lblCompany_ForPlantNewEdit.Text = company;
                BindCountry();
                BindStates();
                BindGroupIDs();

                if (Session["UserRole"] == null)
                {

                }
                else
                {
                    string userRole = (string)Session["UserRole"];
                    if (userRole.Replace(" ", "").Trim().ToLower() == "superadmin")
                    {
                        btnGroup_Click(null, null);
                    }
                    else if (userRole.Replace(" ", "").Trim().ToLower() == "companyadmin")
                    {
                        btnRole_Click(null, null);
                        Group.Visible = false;
                        Company.Visible = false;
                    }
                    else
                    {
                        btnRole_Click(null, null);
                        Group.Visible = false;
                        Company.Visible = false;
                    }
                }
            
                ScriptManager.RegisterStartupScript(this, this.GetType(), "setActiveValue", "setActiveSubmenuValue();", true);
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
                string accestype = list.Where(x => x.Screen == "Company Group Master").Select(x => x.Value).FirstOrDefault();
                if (accestype == "Read")
                {
                    btnNewEditCompany.Visible = false;
                    btnNewEditGroup.Visible = false;
                    DBAccess.ShowHideActionColumnOfGrid(gvCompanyDetails, false);
                    DBAccess.ShowHideActionColumnOfGrid(gvGroupDetails, false);

                    btnMachineNew.Visible = false;
                    DBAccess.ShowHideActionColumnOfGrid(gvMachineData, false);
                    btnEmployeeNew.Visible = false;
                    DBAccess.ShowHideActionColumnOfGrid(gvEmployeeData, false);
                    btnNewRole.Visible = false;
                    DBAccess.ShowHideActionColumnOfGrid(gvRoleDetails, false);
                    btnNewPlant.Visible = false;
                    DBAccess.ShowHideActionColumnOfGrid(gvPlantDetails, false);
                    btnAssignMachineToPlantSave.Visible = false;

                    btnUserRoleRightsSave.Visible = false;
                    btnUserATRoleSave.Visible = false;
                }
                else
                {

                    btnNewEditCompany.Visible = true;
                    btnNewEditGroup.Visible = true;
                    DBAccess.ShowHideActionColumnOfGrid(gvCompanyDetails, true);
                    DBAccess.ShowHideActionColumnOfGrid(gvGroupDetails, true);

                    btnMachineNew.Visible = true;
                    DBAccess.ShowHideActionColumnOfGrid(gvMachineData, true);
                    btnEmployeeNew.Visible = true;
                    DBAccess.ShowHideActionColumnOfGrid(gvEmployeeData, true);
                    btnNewRole.Visible = true;
                    DBAccess.ShowHideActionColumnOfGrid(gvRoleDetails, true);
                    btnNewPlant.Visible = true;
                    DBAccess.ShowHideActionColumnOfGrid(gvPlantDetails, true);
                    btnAssignMachineToPlantSave.Visible = true;

                    btnUserRoleRightsSave.Visible = true;
                    btnUserATRoleSave.Visible = true;
                }
            }
            catch (Exception ex)
            {

            }
        }

        private void BindCountry()
        {
            try
            {
                List<string> country = new List<string>();
                country= DBAccess.getCountry();
                country.Insert(0, "");
                ddlGroupCountry.DataSource = country;
                ddlGroupCountry.DataBind();
                ddlCompanyCountry.DataSource = country;
                ddlCompanyCountry.DataBind();
                ddlPlantCountry.DataSource = country;
                ddlPlantCountry.DataBind();
            }
            catch (Exception ex)
            {

            }
        }
        private void BindStates()
        {
            try
            {
                List<string> state = new List<string>();
                state= DBAccess.getState();
                state.Insert(0, "");
                ddlGroupState.DataSource = state;
                ddlGroupState.DataBind();
                ddlCompanyState.DataSource = state;
                ddlCompanyState.DataBind();
            }
            catch (Exception ex)
            {

            }
        }
        private void BindGroupIDs()
        {
            try
            {
                List<string> groupIDs = new List<string>();
                groupIDs.Insert(0, "None");
                groupIDs = DBAccess.getGroupIDs();
                groupIDs.Insert(0, "None");
                ddlGroup_ForCompany.DataSource = groupIDs;
                ddlGroup_ForCompany.DataBind();
            }
            catch (Exception ex)
            {

            }
        }
        protected void btnGroup_Click(object sender, EventArgs e)
        {
            try
            {
                BindGroupData();
            }catch(Exception ex)
            {

            }
        }
        private void BindGroupData()
        {
            try
            {
                List<CompanyGroupDetails> grpDetailsList = new List<CompanyGroupDetails>();
                grpDetailsList = DBAccess.getGroupDetails(txtGroupSearch.Text);
                gvGroupDetails.DataSource = grpDetailsList;
                gvGroupDetails.DataBind();

            }
            catch(Exception ex)
            {

            }
        }
        protected void btnCompany_Click(object sender, EventArgs e)
        {
            try
            {
                BindGroupIDs();
                BindCompanyData();
            }
            catch (Exception ex)
            {

            }

        }
        private void BindCompanyData()
        {
            try
            {
                BindGroupIDs();
                List<CompanyGroupDetails> cmpnyDetailsList = new List<CompanyGroupDetails>();
                cmpnyDetailsList = DBAccess.getCompanyDetails(txtCompanySearch.Text);
                gvCompanyDetails.DataSource = cmpnyDetailsList;
                gvCompanyDetails.DataBind();
            }
            catch (Exception ex)
            {

            }
        }
        protected void gvGroupDetails_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }

        protected void gvCompanyDetails_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }

        protected void btnNewEditGroupSave_Click(object sender, EventArgs e)
        {
            try
            {
                CompanyGroupDetails grpData = new CompanyGroupDetails();
                grpData.GroupID = txtGroupId.Text;
                grpData.GroupName = txtGroupName.Text;
                grpData.ContactPerson = txtGroupContactPerson.Text;
                grpData.Email = txtGroupEmail.Text;
                grpData.Phone = txtGroupPhone.Text;
                grpData.Address = txtGroupAddress.Text;
                grpData.Place = txtGroupPlace.Text;
                //grpData.State = txtGroupState.Text;
                //grpData.Country = txtGroupCountry.Text;
                grpData.State = ddlGroupState.SelectedValue==null?"" : ddlGroupState.SelectedValue.ToString();
                grpData.Country = ddlGroupCountry.SelectedValue == null ? "" : ddlGroupCountry.SelectedValue.ToString();
                grpData.Pin = txtGroupPin.Text;
                grpData.EffectiveFromDate =Util.GetDateTime(txtGroupEffFromDate.Text).ToString("yyyy-MM-dd HH:mm:ss");
                grpData.EffectiveToDate = Util.GetDateTime(txtGroupEffToDate.Text).ToString("yyyy-MM-dd HH:mm:ss");
                grpData.NewOrEditParam = hfGroupEditNew.Value;
                string date = DBAccess.checkGroupEffectiveDate(grpData);
                if (date == "")
                {

                }
                else
                {
                    DateTime maxEfffromdate,enteredEffeFromDate;
                    maxEfffromdate = Util.GetDateTime(date);
                    enteredEffeFromDate = Util.GetDateTime(grpData.EffectiveFromDate);
                    if (enteredEffeFromDate <= maxEfffromdate)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openWarningModal('Effective from date should be greater than " + maxEfffromdate.ToString("dd-MM-yyyy HH:mm:ss") +"');", true);
                        return;
                    }
                }
                string Success = DBAccess.saveUpdateGroupDetails(grpData);
                if (Success == "Exist")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openWarningModal('Group ID already exists.');", true);
                }
                else if (Success == "Inserted")
                {
                    BindGroupIDs();
                    BindGroupData();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Record saved Successfully.','');", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "clearAllModalScreen()", true);
                }
                else if (Success == "Updated")
                {
                    BindGroupData();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Record updated Successfully.','');", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "clearAllModalScreen()", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "openErrorModal('Failed to insert record.');", true);
                }
            }
            catch(Exception ex)
            {

            }
        }

    

        protected void btnNewEditCompanySave_Click(object sender, EventArgs e)
        {
            try
            {
                CompanyGroupDetails cmpnyData = new CompanyGroupDetails();
                cmpnyData.GroupID = ddlGroup_ForCompany.SelectedValue == null ? "" : ddlGroup_ForCompany.SelectedValue.ToString();
                cmpnyData.CompanyID = txtCompanyID.Text;
                //if (cmpnyData.GroupID == "" || cmpnyData.GroupID == "None")
                //{
                //    cmpnyData.CorporateID = cmpnyData.CompanyID;
                //}
                //else
                //{
                //    cmpnyData.CorporateID = cmpnyData.GroupID;
                //}
                cmpnyData.CompanyName = txtCompanyName.Text;
                cmpnyData.ContactPerson = txtCompanyContactPerson.Text;
                cmpnyData.Place = txtCompanyPlace.Text;
                cmpnyData.State = ddlCompanyState.SelectedValue == null ? "" : ddlCompanyState.SelectedValue.ToString();
                cmpnyData.Country = ddlCompanyCountry.SelectedValue==null?"":ddlCompanyCountry.SelectedValue.ToString();
                cmpnyData.Pin = txtCompanyPin.Text;
                cmpnyData.Email = txtCompanyEmail.Text;
                cmpnyData.Phone = txtCompanyPhone.Text;
                cmpnyData.Address = txtCompanyAddress.Text;
                cmpnyData.EffectiveFromDate = Util.GetDateTime(txtCompanyEffFromDate.Text).ToString("yyyy-MM-dd HH:mm:ss");
                cmpnyData.EffectiveToDate = Util.GetDateTime(txtCompanyEffToDate.Text).ToString("yyyy-MM-dd HH:mm:ss");
                cmpnyData.UserID = txtCompanyUserId.Text;
                cmpnyData.Password = txtCompanyUserPassword.Text;
                cmpnyData.NewOrEditParam = hfComoanyNewEdit.Value;

                string date = DBAccess.checkCompanyEffectiveDate(cmpnyData);
                if (date == "")
                {

                }
                else
                {
                    DateTime maxEfffromdate, enteredEffeFromDate;
                    maxEfffromdate = Util.GetDateTime(date);
                    enteredEffeFromDate = Util.GetDateTime(cmpnyData.EffectiveFromDate);
                    if (enteredEffeFromDate <= maxEfffromdate)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openWarningModal('Effective from date should be greater than " + maxEfffromdate.ToString("dd-MM-yyyy HH:mm:ss") + "');", true);
                        return;
                    }
                }
                string Success = DBAccess.saveUpdateCompanyDetails(cmpnyData);
                string adminSuccess = DBAccess.saveUpdateCompanyAdminDetails(cmpnyData);
                if (Success == "Exist")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openWarningModal('Company ID already exists.');", true);
                    return;
                }
                else if (Success == "Inserted")
                {
                    if(adminSuccess== "Exist")
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openWarningModal('User ID already exists.');", true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Record saved Successfully.','');", true);
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "clearAllModalScreen()", true);
                    }
                }
                else if (Success == "Updated")
                {
                    if (adminSuccess == "Exist")
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openWarningModal('User ID already exists.');", true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Record updated Successfully.','');", true);
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "clearAllModalScreen()", true);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "openErrorModal('Failed to insert record.');", true);
                    return;
                }
                BindCompanyData();

            }
            catch (Exception ex)
            {

            }
        }
        protected void btnViewGroup_Click(object sender, EventArgs e)
        {
            BindGroupData();
        }

        protected void btnViewCompany_Click(object sender, EventArgs e)
        {
            BindCompanyData();
        }

        protected void btnDeleteGroupConfirm_Click(object sender, EventArgs e)
        {
            try
            {
                CompanyGroupDetails data = new CompanyGroupDetails();
                data.GroupID = (gvGroupDetails.Rows[GroupIndexToDelete].FindControl("lblGroupID") as Label).Text ;
                data.EffectiveFromDate = Util.GetDateTime(((gvGroupDetails.Rows[GroupIndexToDelete].FindControl("lblEffevtiveFromDate") as Label).Text)).ToString("yyyy-MM-dd HH:mm:ss");
                data.EffectiveToDate = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                int result = DBAccess.deleteGroupCompanyDetails(data, "Entity");
                if (result > 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Record deleted Successfully.','');", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "clearAllModalScreen()", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "openErrorModal('Failed to delete record.');", true);
                }
                BindGroupData();
                GroupIndexToDelete = -1;
            }
            catch(Exception ex)
            {

            }
        }

        protected void lbDeleteCompany_Click(object sender, EventArgs e)
        {
            try
            {
                CompanyIndexToToDelete  = Convert.ToInt32(((sender as LinkButton).NamingContainer as GridViewRow).RowIndex);
                string deleteMsg = "Are you sure you want to delete Company ID " + (gvCompanyDetails.Rows[CompanyIndexToToDelete].FindControl("lblCompanyID") as Label).Text  + ".";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "openCompanyDeleteConfirmModal('" + deleteMsg + " ?');", true);
            }
            catch (Exception ex)
            {

            }
        }

        protected void btnDeleteCompanyConfirm_Click(object sender, EventArgs e)
        {
            try
            {
                CompanyGroupDetails data = new CompanyGroupDetails();
                data.CompanyID = (gvCompanyDetails.Rows[CompanyIndexToToDelete].FindControl("lblCompanyID") as Label).Text;
                data.EffectiveFromDate = Util.GetDateTime(((gvCompanyDetails.Rows[CompanyIndexToToDelete].FindControl("lblEffevtiveFromDate") as Label).Text)).ToString("yyyy-MM-dd HH:mm:ss");
                data.EffectiveToDate = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                int result = DBAccess.deleteGroupCompanyDetails(data, "Company");
                if (result > 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Record deleted Successfully.','');", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "clearAllModalScreen()", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "openErrorModal('Failed to delete record.');", true);
                }
                BindCompanyData();
                CompanyIndexToToDelete = -1;
            }
            catch (Exception ex)
            {

            }
        }

        protected void lbDeleteGroup_Click(object sender, EventArgs e)
        {
            try
            {
                GroupIndexToDelete = Convert.ToInt32(((sender as LinkButton).NamingContainer as GridViewRow).RowIndex);
                string deleteMsg = "Are you sure you want to delete Group ID " + (gvGroupDetails.Rows[GroupIndexToDelete].FindControl("lblGroupID") as Label).Text + ".";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "openGroupDeleteConfirmModal('" + deleteMsg + " ?')", true);
            }
            catch(Exception ex)
            {

            }
        }


        #region-------User ---------
        protected void btnEmployee_Click(object sender, EventArgs e)
        {
            try
            {
                ddlEmpRole.DataSource = DBAccess.getUserRole(Session["CompanyName"].ToString());
                ddlEmpRole.DataBind();
                BindEmployeeDetails();
                //ShowHideList("", "DisablePlantLevelMenu", "");
            }
            catch (Exception ex)
            { }
        }

        private void BindEmployeeDetails()
        {
            try
            {
                List<UserData> list = DBAccess.getEmployeeMasterDetails(Session["CompanyName"].ToString(), txtEmployeeSearch.Text.Trim());
                gvEmployeeData.DataSource = list;
                gvEmployeeData.DataBind();
            }
            catch (Exception ex)
            { }
        }

        protected void btnEmployeeView_Click(object sender, EventArgs e)
        {
            try
            {
                BindEmployeeDetails();
            }
            catch (Exception ex)
            { }
        }

        protected void btnEmployeeNew_Click(object sender, EventArgs e)
        {
            try
            {
                //hdnEmpImageSource.Value = "";
                //imgEmpImagePreview.ImageUrl = "";
                //imgEmpImage.ImageUrl = "";
                hdnUserNEStatus.Value = "";
                txtEmpUserID.Enabled = true;
                txtEmpEffectiveToDate.Enabled = false;
                UserData data = new UserData();
                hdnEmpCorporateID.Value = "";
                hdnEmpIsGroupUser.Value = "";
                txtEmpUserID.Text = "";
                txtEmpUerName.Text = "";
                txtEmpIOTID.Text = "";
                txtEmpAddress.Text = "";
                txtEmpPassword.Text = "";
                txtEmpEmail.Text = "";
                txtEmpMobileNo.Text = "";
                chkEmpIsEmployee.Checked = false;
                chkEmpIsEmployee.Attributes["onclick"] = "return true";
                txtEmpEmployeeID.Text = "";
                if (chkEmpIsEmployee.Checked)
                {
                    txtEmpEmployeeID.ReadOnly = false;
                }
                else
                {
                    txtEmpEmployeeID.ReadOnly = true;
                }
                txtEmpEffectiveFromDate.Text = DateTime.Now.ToString("dd-MM-yyyy HH:mm:ss");
                txtEmpEffectiveToDate.Text = Util.GetDateTime("01-01-9999 00:00:00").ToString("dd-MM-yyyy HH:mm:ss");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "openModal", "openCloseAddEditEmployeeInfoModal('show')", true);
            }
            catch (Exception ex)
            {

            }
        }
        private string getCorporateIdForUser(string companyID, out bool isGroupUer)
        {
            string corpid = "";
            isGroupUer = false;
            try
            {
                corpid = DBAccess.getCorporateIDForEmployee(companyID, out isGroupUer);
            }
            catch (Exception ex)
            {

            }
            return corpid;
        }
        protected void lblEmployeeEdit_Click(object sender, EventArgs e)
        {
            try
            {
                hdnUserNEStatus.Value = "Edit";
                txtEmpUserID.Enabled = false;
                txtEmpEffectiveToDate.Enabled = false;
                int rowIndex = Convert.ToInt32(((sender as LinkButton).NamingContainer as GridViewRow).RowIndex);
                UserData data = new UserData();
                hdnEmpCorporateID.Value = (gvEmployeeData.Rows[rowIndex].FindControl("lblCorporateID") as Label).Text;
                hdnEmpIsGroupUser.Value = (gvEmployeeData.Rows[rowIndex].FindControl("chkIsGroupUser") as CheckBox).Checked.ToString();
                txtEmpUserID.Text = (gvEmployeeData.Rows[rowIndex].FindControl("lblUserID") as Label).Text;
                txtEmpUerName.Text = (gvEmployeeData.Rows[rowIndex].FindControl("lblUsername") as Label).Text;
                txtEmpIOTID.Text = (gvEmployeeData.Rows[rowIndex].FindControl("lblIOTID") as Label).Text;
                txtEmpAddress.Text = (gvEmployeeData.Rows[rowIndex].FindControl("lblAddress") as Label).Text;
                //txtEmpPassword.Text = (gvEmployeeData.Rows[rowIndex].FindControl("hfPassword") as HiddenField).Value;
                txtEmpPassword.Attributes.Add("value", (gvEmployeeData.Rows[rowIndex].FindControl("hfPassword") as HiddenField).Value);
                txtEmpEmail.Text = (gvEmployeeData.Rows[rowIndex].FindControl("lblEmail") as Label).Text;
                txtEmpMobileNo.Text = (gvEmployeeData.Rows[rowIndex].FindControl("lblMobileNo") as Label).Text;
                chkEmpIsEmployee.Checked = (gvEmployeeData.Rows[rowIndex].FindControl("chkIsEmployee") as CheckBox).Checked;
                chkEmpIsEmployee.Attributes["onclick"] = "return true";
                txtEmpEmployeeID.Text = (gvEmployeeData.Rows[rowIndex].FindControl("lblEmployeeID") as Label).Text;
                txtEmpEmployeeID.ReadOnly = true;
                string role = (gvEmployeeData.Rows[rowIndex].FindControl("lblRole") as Label).Text;
                if (role.Trim() != "")
                {
                    ddlEmpRole.SelectedValue = role;

                }
                txtEmpEffectiveFromDate.Text = (gvEmployeeData.Rows[rowIndex].FindControl("lblEffectiveFromDate") as Label).Text;
                txtEmpEffectiveToDate.Text = (gvEmployeeData.Rows[rowIndex].FindControl("lblEffectiveToDate") as Label).Text;
                //hdnEmpImageSource.Value = (gvEmployeeData.Rows[rowIndex].FindControl("hdnEmpImageSource") as HiddenField).Value;
                //imgEmpImagePreview.ImageUrl = "";
                //imgEmpImage.ImageUrl = "data:Image/png;base64," + hdnEmpImageSource.Value;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "openModal", "openCloseAddEditEmployeeInfoModal('show')", true);
            }
            catch (Exception ex)
            {

            }
        }

        protected void btnEmployeeInserUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                UserData data = new UserData();
                bool isGroupUSer = false;
                if (hdnUserNEStatus.Value == "")
                {
                    //data.CorporateID = getCorporateIdForUser(Session["CompanyName"].ToString(), out isGroupUSer);
                    string grpid = DBAccess.getGroupIDForCompany(Session["CompanyName"].ToString());
                    data.CorporateID = grpid == ""?"None": grpid;
                    data.CompanyID =Session["CompanyName"].ToString();
                    if(grpid=="" || grpid == "None")
                    {
                        data.IsGroupUser = false;
                    }
                    else
                    {
                        data.IsGroupUser = true;
                    }
                  
                }
                else
                {
                    data.CorporateID = hdnEmpCorporateID.Value;
                    data.CompanyID = Session["CompanyName"].ToString();
                    if (string.Equals(hdnEmpIsGroupUser.Value, "true", StringComparison.OrdinalIgnoreCase))
                    {
                        data.IsGroupUser = isGroupUSer;
                    }
                }
                data.UserID = txtEmpUserID.Text;
                data.Username = txtEmpUerName.Text;
                data.IOTID = txtEmpIOTID.Text;
                data.Address = txtEmpAddress.Text;
                data.Password = txtEmpPassword.Text;
                data.Email = txtEmpEmail.Text;
                data.MobileNo = txtEmpMobileNo.Text;
                data.Role = ddlEmpRole.SelectedValue;
                data.IsEmployee = chkEmpIsEmployee.Checked;
                if (data.IsEmployee)
                {
                    data.EmployeeID = txtEmpEmployeeID.Text;
                }
                else
                {
                    data.EmployeeID = "";
                }
                data.EffectiveFromDate = txtEmpEffectiveFromDate.Text;
                data.EffectiveToDate = txtEmpEffectiveToDate.Text;
                data.UpdatedBy = HttpContext.Current.Session["Username"] == null ? "" : HttpContext.Current.Session["Username"].ToString();

                //HttpPostedFile postedFile = fuEmpImage.PostedFile;
                //if (hdnUserNEStatus.Value == "")
                //{
                // if (postedFile.HasFile)
                // {
                // HttpPostedFile postedFile = fuEmpImage.PostedFile;
                // Stream stream = postedFile.InputStream;
                // BinaryReader binaryReader = new BinaryReader(stream);
                // byte[] bytes = binaryReader.ReadBytes((int)stream.Length);
                // data.UserImage = bytes;
                // }
                //}
                //else
                //{
                // if (fuEmpImage.HasFile)
                // {

                // Stream stream = postedFile.InputStream;
                // BinaryReader binaryReader = new BinaryReader(stream);
                // byte[] bytes = binaryReader.ReadBytes((int)stream.Length);
                // data.UserImage = bytes;
                // }
                // else
                // {
                // if(hdnEmpImageSource.Value!="" && hdnEmpImageSource.Value!=null)
                // {
                // data.UserImage = System.Convert.FromBase64String(hdnEmpImageSource.Value);
                // }
                // }
                //}
                string date = DBAccess.checkEmployeeEffectiveDate(data);
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
                        ScriptManager.RegisterStartupScript(this, GetType(), "openModal", "openCloseAddEditEmployeeInfoModal('show');", true);
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openWarningModal('Effective from date should be greater than " + maxEfffromdate.ToString("dd-MM-yyyy HH:mm:ss") + "');", true);
                        return;
                    }
                }
                string Success = DBAccess.insertUpdateEmployeeInfoMasterDetails(data, hdnUserNEStatus.Value);
                if (Success == "Exist")
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "openModal", "openCloseAddEditEmployeeInfoModal('show');", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openWarningModal('User ID already exists.');", true);
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
                    ScriptManager.RegisterStartupScript(this, GetType(), "openModal", "openCloseAddEditEmployeeInfoModal('show');", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "openErrorModal('Failed to insert record.');", true);
                    return;
                }
                BindEmployeeDetails();
            }
            catch (Exception ex)
            { }
        }
        protected void lblEmployeeDelete_Click(object sender, EventArgs e)
        {
            try
            {
                selectedDeleteRowIndex = Convert.ToInt32(((sender as LinkButton).NamingContainer as GridViewRow).RowIndex);
                string deleteMsg = "Are you sure you want to delete User ID " + (gvEmployeeData.Rows[selectedDeleteRowIndex].FindControl("lblUserID") as Label).Text + ".";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "openEmployeeDeleteConfirmModal('" + deleteMsg + " ?')", true);
            }
            catch (Exception ex)
            { }
        }
        protected void btnEmployeeDeleteConfirm_Click(object sender, EventArgs e)
        {
            try
            {
                UserData data = new UserData();
                data.CorporateID = (gvEmployeeData.Rows[selectedDeleteRowIndex].FindControl("lblCorporateID") as Label).Text;
                data.UserID = (gvEmployeeData.Rows[selectedDeleteRowIndex].FindControl("lblUserID") as Label).Text;
                data.Role = (gvEmployeeData.Rows[selectedDeleteRowIndex].FindControl("lblRole") as Label).Text;
                data.EffectiveToDate = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                data.EffectiveFromDate = (gvEmployeeData.Rows[selectedDeleteRowIndex].FindControl("lblEffectiveFromDate") as Label).Text;
                int result = DBAccess.deleteEmployeeMasterDetails(data);
                if (result > 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Record deleted Successfully.','');", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "openErrorModal('Failed to delete record.');", true);
                }
                BindEmployeeDetails();
                selectedDeleteRowIndex = -1;
            }
            catch (Exception ex)
            {

            }
        }
        #endregion

        #region  -------------Role--------
        protected void btnRole_Click(object sender, EventArgs e)
        {
            BindRoleData();
            //ShowHideList("", "DisablePlantLevelMenu", "");
        }

        private void BindRoleData()
        {
            try
            {
                List<RoleDetails> roleDetails = new List<RoleDetails>();
                RoleDetails data = new RoleDetails();
                data.CompanyID = Session["CompanyName"].ToString();
                data.RoleName = txtRoleNameSearch.Text;
                roleDetails = DBAccess.getRoleDetails(data);
                gvRoleDetails.DataSource = roleDetails;
                gvRoleDetails.DataBind();
            }
            catch (Exception ex)
            {

            }

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
                data.EffectiveFromDate = Util.GetDateTime(txtRoleEffFromDate.Text).ToString("yyyy-MM-dd HH:mm:ss");
                data.EffectiveToDate = Util.GetDateTime(txtRoleEffToDate.Text).ToString("yyyy-MM-dd HH:mm:ss");
                data.NewOrEditParam = hfRoleNewEdit.Value;
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

            }
        }
        protected void btnRoleView_Click(object sender, EventArgs e)
        {
            BindRoleData();
        }
        protected void lbDeleteRole_Click(object sender, EventArgs e)
        {
            try
            {
                RoleIndexToDelete = Convert.ToInt32(((sender as LinkButton).NamingContainer as GridViewRow).RowIndex);
                string deleteMsg = "Are you sure you want to delete Role ID " + (gvRoleDetails.Rows[RoleIndexToDelete].FindControl("lblRoleID") as Label).Text + ".";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "openRoleDeleteConfirmModal('" + deleteMsg + " ?')", true);
            }
            catch (Exception ex)
            {

            }
        }

        protected void btnDeleteRoleConfirm_Click(object sender, EventArgs e)
        {
            try
            {
                RoleDetails data = new RoleDetails();
                data.CompanyID = (gvRoleDetails.Rows[RoleIndexToDelete].FindControl("lblCompanyID") as Label).Text;
                data.RoleID = (gvRoleDetails.Rows[RoleIndexToDelete].FindControl("lblRoleID") as Label).Text;
                data.RoleName = (gvRoleDetails.Rows[RoleIndexToDelete].FindControl("lblRoleName") as Label).Text;
                data.UpdatedBy = HttpContext.Current.Session["Username"] == null ? "" : HttpContext.Current.Session["Username"].ToString();
                data.UpdatedTS = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                data.EffectiveFromDate = Util.GetDateTime(((gvRoleDetails.Rows[RoleIndexToDelete].FindControl("lblEffevtiveFromDate") as Label).Text)).ToString("yyyy-MM-dd HH:mm:ss");
                data.EffectiveToDate = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                int result = DBAccess.deleteRoleGroupDetails(data);
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
                BindRoleData();
                RoleIndexToDelete = -1;
            }
            catch (Exception ex)
            {

            }
        }


        #endregion

        #region -------Plant-------
        protected void btnPlant_Click(object sender, EventArgs e)
        {
            try
            {

                BindPlantData();
            }
            catch (Exception ex)
            {

            }
        }
        private void BindPlantData()
        {
            try
            {
                List<PlantLevelDetails> plantDetails = new List<PlantLevelDetails>();
                PlantLevelDetails data = new PlantLevelDetails();
                data.CompanyID = lblCompany_ForPlant.Text;
                data.PlantID = txtPlantSearch.Text;
                plantDetails = DBAccess.getPlantDetails(data);
                gvPlantDetails.DataSource = plantDetails;
                gvPlantDetails.DataBind();
                //if (Session["LHPlant"] == null)
                //{
                //    hfSelectedPlant.Value = "";
                //}
                //else
                //{
                //    hfSelectedPlant.Value = (string)Session["LHPlant"];
                //}
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "setSelectedPlantIdInGrid", "setSelectedPlantIdInGrid();", true);
            }
            catch (Exception ex)
            {

            }

        }
        protected void btnNewEditPlantSave_Click(object sender, EventArgs e)
        {
            try
            {
                PlantLevelDetails data = new PlantLevelDetails();
                data.CompanyID = lblCompany_ForPlantNewEdit.Text;
                data.PlantID = txtPlantID.Text;
                data.Description = txtPlantDesc.Text;
                data.Code = txtPlantCode.Text;
                data.Address = txtPlantAddress.Text;
                data.Country = ddlPlantCountry.SelectedValue == null ? "" : ddlPlantCountry.SelectedValue.ToString();
                data.Region = txtPlantRegion.Text;
                data.GeoLocation = txtPlantGeoLocation.Text;
                data.City = txtPlatCity.Text;
                data.EffectiveFromDate = Util.GetDateTime(txtPlantEffFromDate.Text).ToString("yyyy-MM-dd HH:mm:ss");
                data.EffectiveToDate = Util.GetDateTime(txtPlantEffToDate.Text).ToString("yyyy-MM-dd HH:mm:ss");
                data.NewOrEditParam = hfPlantEditNew.Value;
                string date = DBAccess.checkPlantEffectiveDate(data);
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
                string Success = DBAccess.saveUpdatePlantDetails(data);
                if (Success == "Exist")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openWarningModal('Plant ID already exists.');", true);
                }
                else if (Success == "Inserted")
                {
                  //  BindPlantIDs();
                    BindPlantData();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Record saved Successfully.','');", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "clearAllModalScreen()", true);
                }
                else if (Success == "Updated")
                {
                    BindPlantData();
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

            }
        }
        protected void btnPlantView_Click(object sender, EventArgs e)
        {
            BindPlantData();
        }
        protected void lbDeletePlant_Click(object sender, EventArgs e)
        {
            try
            {
                PlantIndexToDelete = Convert.ToInt32(((sender as LinkButton).NamingContainer as GridViewRow).RowIndex);
                string deleteMsg = "Are you sure you want to delete Plant ID " + (gvPlantDetails.Rows[PlantIndexToDelete].FindControl("lblPlantID") as Label).Text + ".";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "openPlantDeleteConfirmModal('" + deleteMsg + " ?')", true);
            }
            catch (Exception ex)
            {

            }
        }
        protected void btnDeletePlantConfirm_Click(object sender, EventArgs e)
        {
            try
            {
                PlantLevelDetails data = new PlantLevelDetails();
                data.CompanyID = (gvPlantDetails.Rows[PlantIndexToDelete].FindControl("lblCompanyID") as Label).Text;
                data.PlantID = (gvPlantDetails.Rows[PlantIndexToDelete].FindControl("lblPlantID") as Label).Text;
                data.EffectiveFromDate = Util.GetDateTime(((gvPlantDetails.Rows[PlantIndexToDelete].FindControl("lblEffevtiveFromDate") as Label).Text)).ToString("yyyy-MM-dd HH:mm:ss");
                data.EffectiveToDate = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                int result = DBAccess.deletePlantDetails(data);
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
               // BindPlantIDs();
                BindPlantData();
                PlantIndexToDelete = -1;
            }
            catch (Exception ex)
            {

            }
        }

        #endregion

        #region  ------------Machine----------
        protected void btnMachine_Click(object sender, EventArgs e)
        {
            try
            {
                BindMachineMTB(ddlNEMTB);
                ddlNEMTB_SelectedIndexChanged(null, null);
                //BindCNCMake(ddlNECNCMake);
                //ddlNECNCMake_SelectedIndexChanged(null, null);
                ddlControllerType_SelectedIndexChanged(null, null);
                BindMachineDetails();
                //ShowHideList("", "DisablePlantLevelMenu", "");
            }
            catch (Exception ex)
            {

            }
        }
        private void BindMachineDetails()
        {
            try
            {

                List<MachineData> list = DBAccess.getMachineMasterDetails(lblCompany_ForMachine.Text ,txtMachineIdSearch.Text.Trim(), "MachineInformation");
                gvMachineData.DataSource = list;
                gvMachineData.DataBind();
            }
            catch (Exception ex)
            {

            }
        }

        private void BindMachineMTB(DropDownList ddlMTB)
        {
            try
            {
                ddlMTB.DataSource = DBAccess.getMTBData("", "", "", "");
                ddlMTB.DataBind();
            }
            catch (Exception ex)
            {
            }
        }
        private void BindMachineType(DropDownList ddlMachieType, string mtb)
        {
            try
            {
                ddlMachieType.DataSource = DBAccess.getMachineTypeData("", "", "", "", mtb);
                ddlMachieType.DataBind();
            }
            catch (Exception ex)
            {
            }
        }
        private void BindMachineModel(DropDownList ddl, string mtb, string machinetype)
        {
            try
            {
                ddl.DataSource = DBAccess.getMachineModelData("", "", "", "", mtb, machinetype);
                ddl.DataBind();
            }
            catch (Exception ex)
            {
            }
        }
        private void BindCNCMake(DropDownList ddl)
        {
            try
            {
                List<string> list = DBAccess.getCNCMakeData("", "");
                ddl.DataSource = list;
                ddl.DataBind();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        private void BindPLCMake(DropDownList ddl)
        {
            try
            {
                List<string> list = DBAccess.getPLCMakeData("", "");
                ddl.DataSource = list;
                ddl.DataBind();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        private void BindCNCModel(DropDownList ddl, string cncmake)
        {
            try
            {
                List<string> list = DBAccess.getCNCModelData("", "", cncmake);
                ddl.DataSource = list;
                ddl.DataBind();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }

        private void BindPLCModel(DropDownList ddl, string cncmake)
        {
            try
            {
                List<string> list = DBAccess.getPLCModelData("", "", cncmake);
                ddl.DataSource = list;
                ddl.DataBind();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }

        private void BindInterface()
        {
            try
            {
                List<string> list = DBAccess.getInterface();
                ddlNEInterface.DataSource = list;
                ddlNEInterface.DataBind();
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
        protected void ddlNEMTB_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                BindMachineType(ddlNEMachineType, ddlNEMTB.SelectedValue);
                BindMachineModel(ddlNEMachineModel, ddlNEMTB.SelectedValue, ddlNEMachineType.SelectedValue);
                if (sender != null)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "openModal", "openCloseAddEditMachineInfoModal('show');", true);
                }
            }
            catch (Exception ex)
            {

            }
        }
        protected void ddlNEMachineType_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                BindMachineModel(ddlNEMachineModel, ddlNEMTB.SelectedValue, ddlNEMachineType.SelectedValue);
                if (sender != null)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "openModal", "openCloseAddEditMachineInfoModal('show');", true);
                }
            }
            catch (Exception ex)
            {

            }
        }
        protected void ddlControllerType_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                string controlertype = ddlControllerType.SelectedValue.ToString();
                if (controlertype == "CNC")
                {
                    makeName.Text = "CNC Make";
                    modelName.Text = "CNC Model";
                    BindCNCMake(ddlNECNCMake);
                    ddlNECNCMake_SelectedIndexChanged(null, null);
                    ddlNECNCModel.Visible = true;
                    ddlNECNCMake.Visible = true;
                }
                else if (controlertype == "PLC")
                {
                    makeName.Text = "PLC Make";
                    modelName.Text = "PLC Model";
                    BindPLCMake(ddlNECNCMake);
                    ddlNECNCMake_SelectedIndexChanged(null, null);
                    ddlNECNCModel.Visible = true;
                    ddlNECNCMake.Visible = true;
                }
                else
                {
                    makeName.Text = "";
                    modelName.Text = "";
                    ddlNECNCModel.Visible = false;
                    ddlNECNCMake.Visible = false;
                }
                if (sender != null)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "openModal", "openCloseAddEditMachineInfoModal('show');", true);
                }
            }
            catch(Exception ex)
            {

            }
        }
        protected void ddlNECNCMake_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                string controlertype = ddlControllerType.SelectedValue.ToString();
                if (controlertype == "CNC")
                {
                    BindCNCModel(ddlNECNCModel, ddlNECNCMake.SelectedValue);
                }
                else if (controlertype == "PLC")
                {
                    BindPLCModel(ddlNECNCModel, ddlNECNCMake.SelectedValue);
                }
               
                if (sender != null)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "openModal", "openCloseAddEditMachineInfoModal('show');", true);
                }
            }
            catch (Exception ex)
            {

            }
        }

        protected void btnMachineDataSourceInsertUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                MachineData data = new MachineData();
                data.CompanyID = Session["CompanyName"].ToString();
                data.MachineID = txtNEMachineID.Text.Trim();

                //DataSource
                data.InterfaceID = ddlNEInterface.SelectedValue == null ? "" : ddlNEInterface.SelectedValue.ToString();
                data.IPAddress = txtNEIPAddress.Text;
                data.IPPortNo = txtNEPortNumber.Text;
                data.Protocol = ddlNEProtocol.SelectedValue == null ? "" : ddlNEProtocol.SelectedValue.ToString();
                data.OEEEnabled = chkNEOEEEnabled.Checked;
                data.AGIEnabled = chkNEAGIEnabled.Checked;
                data.CNCParamEnabled = chkNECNCParamEnabled.Checked;
                data.EneryEnabled = chkNEEnergyEnabled.Checked;
                data.DeviceEnabled = chkNEDeviceEnabled.Checked;
                data.UpdatedBy = HttpContext.Current.Session["Username"] == null ? "" : HttpContext.Current.Session["Username"].ToString();
                string param = hdnMachineDataSourceStatus.Value;
                Session["MachineDataSource"] = data;
              //  string Success = DBAccess.insertUpdateMachineInfoMasterDetails(data, hdnMachineDataSourceStatus.Value, "MachineSource");

                //ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Record saved Successfully.','');", true);
                //List<MachineData>  list = DBAccess.getMachineMasterDetails(data.CompanyID, data.MachineID, "MachineSource");
                //gvMachineDataSourceDetails.DataSource = list;
                //gvMachineDataSourceDetails.DataBind();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "openModal", "closeAddEditMachineDataSourceModal('show')", true);
            }
            catch (Exception ex)
            {

            }
        }

        protected void btnMachineInsertUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                MachineData data = new MachineData();
                data.CompanyID = Session["CompanyName"].ToString();
                data.MachineID = txtNEMachineID.Text.Trim();
                data.IOTID = txtNEInterfaceID.Text.Trim();
                data.MachineDisplayName = txtNEMachineName.Text.Trim();
                data.MachineType = ddlNEMachineType.SelectedValue;
                data.MachineMTB = ddlNEMTB.SelectedValue;
                data.MachineModel = ddlNEMachineModel.SelectedValue;
                data.ControllerType = ddlControllerType.SelectedValue.ToString();
                if (data.ControllerType == "CNC")
                {
                    data.CNCMake = ddlNECNCMake.SelectedValue==null?"":ddlNECNCMake.SelectedValue.ToString();
                    data.CNCModel = ddlNECNCModel.SelectedValue == null ? "" : ddlNECNCModel.SelectedValue.ToString();
                }
                else if (data.ControllerType == "PLC")
                {
                    data.PLCMake = ddlNECNCMake.SelectedValue == null ? "" : ddlNECNCMake.SelectedValue.ToString();
                    data.PLCModel = ddlNECNCModel.SelectedValue == null ? "" : ddlNECNCModel.SelectedValue.ToString();
                }
                else
                {
                    data.CNCMake = "";
                    data.CNCModel = "";
                    data.PLCMake = "";
                    data.PLCModel = "";
                }
                data.SerialNumber = txtNESerialNumber.Text.Trim();

                //characteristics
                data.Mchrrate = txtNEMchrrate.Text.Trim();
                data.MachinewiseOwner = txtNEMachineOwner.Text.Trim();
                data.MultiSpindleFlag = chkNEMultiSpindleFlag.Checked;
                data.CriticalMachineEnabled = chkNECriticalMachine.Checked;
                data.AutoSetupChangeDown = txtNEAutoSetup.Text.Trim();
                data.OEETarget = txtNEOeeTarget.Text.Trim();
                data.EffectiveFromDate = txtNEEffFromDate.Text.Trim();
                data.EffectiveToDate = txtNEEffToDate.Text.Trim();


                //DataSource
                data.InterfaceID = ddlNEInterface.SelectedValue == null ? "" : ddlNEInterface.SelectedValue.ToString();
                data.IPAddress = txtNEIPAddress.Text;
                data.IPPortNo = txtNEPortNumber.Text;
                data.Protocol = ddlNEProtocol.SelectedValue == null ? "" : ddlNEProtocol.SelectedValue.ToString();
                data.OEEEnabled = chkNEOEEEnabled.Checked;
                data.AGIEnabled = chkNEAGIEnabled.Checked;
                data.CNCParamEnabled = chkNECNCParamEnabled.Checked;
                data.EneryEnabled = chkNEEnergyEnabled.Checked;
                data.DeviceEnabled = chkNEDeviceEnabled.Checked;

                //data.IPAddress = txtNEIPAddress.Text.Trim();
                //data.IPPortNo = txtNEIPPortNumber.Text.Trim();

                // data.TPMTrakEnabled = chkNETPMTrakEnabled.Checked;

                //data.DeviceType = txtNEDeviceType.Text.Trim();


                //data.DAPEnabled = chkNEDAPEnabled.Checked;
                //data.EthernetEnabled = chkNEEthernetEnabled.Checked;
                //data.Nto1Device = chkNENto1Device.Checked;
                //data.DNCIP = txtNEDNCIP.Text.Trim();
                //data.DNCIPPortNo = txtNEDNCIPPortNo.Text.Trim();
                //data.DNCTransferEnabled = chkNEDNCTransfer.Checked;
                //data.ProgramFolderEnabled = chkNEPgmFolderEnabled.Checked;

                //data.AGIEnabled = chkNEAGIEnabled.Checked;
                //data.OPCUAURL = txtNEOPCUAURL.Text.Trim();
                // data.ControllerType = txtNEControllerType.Text.Trim();


                //data.EnablePartCountByMacro = chkNEPartByMacro.Checked;

                data.UpdatedBy = HttpContext.Current.Session["Username"] == null ? "" : HttpContext.Current.Session["Username"].ToString();
                string param = hdnMachineNEStatus.Value;



                string Success = DBAccess.insertUpdateMachineInfoMasterDetails(data, hdnMachineNEStatus.Value, "MachineInformation");
                Success = DBAccess.insertUpdateMachineInfoMasterDetails(data, hdnMachineNEStatus.Value, "MachineCharacteristic");
                Success = DBAccess.insertUpdateMachineInfoMasterDetails(data, hdnMachineNEStatus.Value, "MachineSource");


                //string date = DBAccess.checkMachineEffectiveDate(data);
                //if (date == "")
                //{

                //}
                //else
                //{
                //    DateTime maxEfffromdate, enteredEffeFromDate;
                //    maxEfffromdate = Util.GetDateTime(date);
                //    enteredEffeFromDate = Util.GetDateTime(data.EffectiveFromDate);
                //    if (enteredEffeFromDate <= maxEfffromdate)
                //    {
                //        ScriptManager.RegisterStartupScript(this, GetType(), "openModal", "openCloseAddEditMachineInfoModal('show');", true);
                //        ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openWarningModal('Effective from date should be greater than " + maxEfffromdate.ToString("dd-MM-yyyy HH:mm:ss") + "');", true);
                //        return;
                //    }
                //}
                //string Success = DBAccess.insertUpdateMachineInfoMasterDetails(data, hdnMachineNEStatus.Value);
                //if (Success == "Exist")
                //{
                //    ScriptManager.RegisterStartupScript(this, GetType(), "openModal", "openCloseAddEditMachineInfoModal('show');", true);
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "openWarning", "openWarningModal('Machine ID already exists.');", true);
                //    return;
                //}
                //else if (Success == "Inserted")
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Record saved Successfully.','');", true);
                //}
                //else if (Success == "Updated")
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Record updated Successfully.','');", true);
                //}
                //else
                //{
                //    ScriptManager.RegisterStartupScript(this, GetType(), "openModal", "openCloseAddEditMachineInfoModal('show');", true);
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "openErrorModal('Failed to insert record.');", true);
                //    return;
                //}
                ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Record saved Successfully.','');", true);
                BindMachineDetails();
            }
            catch (Exception ex)
            {

            }
        }
        protected void lbMachineEdit_Click(object sender, EventArgs e)
        {
            try
            {
                int rowIndex = Convert.ToInt32(((sender as LinkButton).NamingContainer as GridViewRow).RowIndex);
                hdnMachineNEStatus.Value = "Edit";
                txtNEMachineID.Enabled = false;
                txtNEEffToDate.Enabled = false;
                string companyid= (gvMachineData.Rows[rowIndex].FindControl("lblCompanyID") as Label).Text; 
                string machineID= (gvMachineData.Rows[rowIndex].FindControl("lblMachineID") as Label).Text;
                List<MachineData> list = DBAccess.getMachineMasterDetails(companyid,machineID, "MachineInformation");
                if (list.Count > 0)
                {
                    txtNEMachineID.Text = list[0].MachineID;
                    txtNEInterfaceID.Text = list[0].IOTID;
                    txtNEMachineName.Text = list[0].MachineDisplayName;
                    ddlNEMTB.SelectedValue = list[0].MachineMTB;
                    BindMachineType(ddlNEMachineType, ddlNEMTB.SelectedValue);
                    ddlNEMachineType.SelectedValue = list[0].MachineType;
                    BindMachineModel(ddlNEMachineModel, ddlNEMTB.SelectedValue, ddlNEMachineType.SelectedValue);
                    ddlNEMachineModel.SelectedValue = list[0].MachineModel;
                    txtNESerialNumber.Text = list[0].SerialNumber;
                    ddlControllerType.SelectedValue = list[0].ControllerType;
                    ddlControllerType_SelectedIndexChanged(null, null);
                    if (ddlControllerType.SelectedValue == "CNC")
                    {
                        ddlNECNCMake.SelectedValue = list[0].CNCMake;
                    }
                    else if (ddlControllerType.SelectedValue == "PLC")
                    {
                        ddlNECNCMake.SelectedValue = list[0].PLCMake;
                    }
                    ddlNECNCMake_SelectedIndexChanged(null, null);
                    if (ddlControllerType.SelectedValue == "CNC")
                    {
                        ddlNECNCModel.SelectedValue =  list[0].CNCModel;
                    }
                    else if (ddlControllerType.SelectedValue == "PLC")
                    {
                        ddlNECNCModel.SelectedValue =  list[0].PLCModel;
                    }
                    //BindCNCMake(ddlNECNCMake);
                    //BindCNCModel(ddlNECNCModel, ddlNECNCMake.SelectedValue);
                    //BindCNCMake(ddlNECNCMake);
                    //BindPLCModel(ddlNECNCModel, ddlNECNCMake.SelectedValue);
                }
                list = DBAccess.getMachineMasterDetails(companyid, machineID, "MachineCharacteristic");
                if (list.Count > 0)
                {
                    txtNEMchrrate.Text = list[0].Mchrrate;
                    chkNEMultiSpindleFlag.Checked = list[0].MultiSpindleFlag;
                    txtNEMachineOwner.Text = list[0].MachinewiseOwner;
                    txtNEOeeTarget.Text = list[0].OEETarget;
                    chkNECriticalMachine.Checked = list[0].CriticalMachineEnabled;
                    txtNEAutoSetup.Text = list[0].AutoSetupChangeDown;
                    txtNEEffFromDate.Text = list[0].EffectiveFromDate;
                    txtNEEffToDate.Text = list[0].EffectiveToDate;
                }

                list = DBAccess.getMachineMasterDetails(companyid, machineID, "MachineSource");
                gvMachineDataSourceDetails.DataSource = list;
                gvMachineDataSourceDetails.DataBind();
                //txtNEIPAddress.Text = (gvMachineData.Rows[rowIndex].FindControl("lblIPAddress") as Label).Text;
                //txtNEIPPortNumber.Text = (gvMachineData.Rows[rowIndex].FindControl("lblIPPortNo") as Label).Text;

                //chkNETPMTrakEnabled.Checked = (gvMachineData.Rows[rowIndex].FindControl("chkTPMTrakEnabled") as CheckBox).Checked;

                //txtNEDeviceType.Text = (gvMachineData.Rows[rowIndex].FindControl("lblDeviceType") as Label).Text;

                //chkNEDAPEnabled.Checked = (gvMachineData.Rows[rowIndex].FindControl("chkDAPEnabled") as CheckBox).Checked;
                //chkNEEthernetEnabled.Checked = (gvMachineData.Rows[rowIndex].FindControl("chkEthernetEnabled") as CheckBox).Checked;
                //chkNENto1Device.Checked = (gvMachineData.Rows[rowIndex].FindControl("chkNto1Device") as CheckBox).Checked;
                //txtNEDNCIP.Text = (gvMachineData.Rows[rowIndex].FindControl("lblDNCIP") as Label).Text;
                //txtNEDNCIPPortNo.Text = (gvMachineData.Rows[rowIndex].FindControl("lblDNCIPPortNo") as Label).Text;
                //chkNEDNCTransfer.Checked = (gvMachineData.Rows[rowIndex].FindControl("chkDNCTransferEnabled") as CheckBox).Checked;
                //chkNEPgmFolderEnabled.Checked = (gvMachineData.Rows[rowIndex].FindControl("chkProgramFolderEnabled") as CheckBox).Checked;

                //chkNEAGIEnabled.Checked = (gvMachineData.Rows[rowIndex].FindControl("chkAGIEnabled") as CheckBox).Checked;
                //txtNEOPCUAURL.Text = (gvMachineData.Rows[rowIndex].FindControl("lblOPCUAURL") as Label).Text;
                // txtNEControllerType.Text = (gvMachineData.Rows[rowIndex].FindControl("lblControllerType") as Label).Text;
                //chkNEPartByMacro.Checked = (gvMachineData.Rows[rowIndex].FindControl("chkEnablePartCountByMacro") as CheckBox).Checked;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "openModal", "openCloseAddEditMachineInfoModal('show')", true);

            }
            catch (Exception ex)
            {

            }
        }
        protected void ddlNEInterface_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                List<string> list = DBAccess.getProtocol(ddlNEInterface.SelectedValue==null?"":ddlNEInterface.SelectedValue.ToString());
                ddlNEProtocol.DataSource = list;
                ddlNEProtocol.DataBind();
                if (sender != null)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "openModal", "openCloseAddEditMachineDataSourceModal('show');", true);
                }
            }
            catch(Exception ex)
            {

            }
        }

        protected void btnNewMachineDataSource_Click(object sender, EventArgs e)
        {
            try
            {
                BindInterface();
                ddlNEInterface_SelectedIndexChanged(null, null);
                hdnMachineDataSourceStatus.Value = "";
                txtNEIPAddress.Text = "";
                txtNEPortNumber.Text = "";
                chkNEOEEEnabled.Checked = false;
                chkNEAGIEnabled.Checked = false;
                chkNECNCParamEnabled.Checked = false;
                chkNEEnergyEnabled.Checked = false;
                chkNEDeviceEnabled.Checked = false;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "openModal", "openCloseAddEditMachineDataSourceModal('show')", true);
            }
            catch (Exception ex) { }
        }
        protected void lbMachineSataSourceEdit_Click(object sender, EventArgs e)
        {
            try
            {
                int rowIndex = Convert.ToInt32(((sender as LinkButton).NamingContainer as GridViewRow).RowIndex);
                hdnMachineDataSourceStatus.Value = "Edit";
                BindInterface();
                try {
                    ddlNEInterface.SelectedValue = (gvMachineDataSourceDetails.Rows[rowIndex].FindControl("lblInterfaceID") as Label).Text;
                }
                catch (Exception ex)
                {

                }
                ddlNEInterface_SelectedIndexChanged(null, null);
                try
                {

                }catch(Exception ex)
                {
                    ddlNEProtocol.SelectedValue = (gvMachineDataSourceDetails.Rows[rowIndex].FindControl("lblIPPortNo") as Label).Text;
                }
              
                txtNEIPAddress.Text = (gvMachineDataSourceDetails.Rows[rowIndex].FindControl("lblIPAddress") as Label).Text;
                txtNEPortNumber.Text=(gvMachineDataSourceDetails.Rows[rowIndex].FindControl("lblPortNumber") as Label).Text;
                chkNEOEEEnabled.Checked = (gvMachineDataSourceDetails.Rows[rowIndex].FindControl("chkOEEEnabled") as CheckBox).Checked;
                chkNEAGIEnabled.Checked = (gvMachineDataSourceDetails.Rows[rowIndex].FindControl("chkAGIEnabled") as CheckBox).Checked;
                chkNECNCParamEnabled.Checked = (gvMachineDataSourceDetails.Rows[rowIndex].FindControl("chkCNCParamEnabled") as CheckBox).Checked;
                chkNEEnergyEnabled.Checked = (gvMachineDataSourceDetails.Rows[rowIndex].FindControl("chkEnergyEnabled") as CheckBox).Checked;
                chkNEDeviceEnabled.Checked = (gvMachineDataSourceDetails.Rows[rowIndex].FindControl("chkDeviceEnabled") as CheckBox).Checked;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "openModal", "openCloseAddEditMachineDataSourceModal('show')", true);
            }
            catch(Exception ex)
            {

            }
        }


        protected void btnMachineNew_Click(object sender, EventArgs e)
        {
            try
            {
                hdnMachineNEStatus.Value = "";
                txtNEMachineID.Enabled = true;
                txtNEEffToDate.Enabled = false;
                txtNEMachineID.Text = "";
                txtNEInterfaceID.Text = "";
                txtNEMachineName.Text = "";
                ddlNEMTB_SelectedIndexChanged(null, null);
                ddlNECNCMake_SelectedIndexChanged(null, null);
               // txtNEIPAddress.Text = "";
                //txtNEIPPortNumber.Text = "";
                txtNEMchrrate.Text = "";
                //chkNETPMTrakEnabled.Checked = false;
                chkNEMultiSpindleFlag.Checked = false;
                //txtNEDeviceType.Text = "";
                txtNEMachineOwner.Text = "";
                chkNECriticalMachine.Checked = false;
                //chkNEDAPEnabled.Checked = false;
                //chkNEEthernetEnabled.Checked = false;
                //chkNENto1Device.Checked = false;
                //txtNEDNCIP.Text = "";
                //txtNEDNCIPPortNo.Text = "";
                //chkNEDNCTransfer.Checked = false;
                //chkNEPgmFolderEnabled.Checked = false;
                txtNEAutoSetup.Text = "";
                //chkNEAGIEnabled.Checked = false;
                //txtNEOPCUAURL.Text = "";
                //txtNEControllerType.Text = "";
                txtNESerialNumber.Text = "";
                txtNEOeeTarget.Text = "";
                //chkNEPartByMacro.Checked = false;
                txtNEEffFromDate.Text = DateTime.Now.ToString("dd-MM-yyyy HH:mm:ss");
                txtNEEffToDate.Text = Util.GetDateTime("01-01-9999 00:00:00").ToString("dd-MM-yyyy HH:mm:ss");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "openModal", "openCloseAddEditMachineInfoModal('show')", true);
            }
            catch (Exception ex) { }
        }
        protected void btnMachineView_Click(object sender, EventArgs e)
        {
            try
            {
                BindMachineDetails();
            }
            catch (Exception ex)
            {

            }
        }
        protected void lbMachineDelete_Click(object sender, EventArgs e)
        {
            try
            {

                selectedDeleteRowIndex = Convert.ToInt32(((sender as LinkButton).NamingContainer as GridViewRow).RowIndex);
                string deleteMsg = "Are you sure you want to delete Machine ID " + (gvMachineData.Rows[selectedDeleteRowIndex].FindControl("lblMachineID") as Label).Text + ".";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "confirmModal", "openMachineDeleteConfirmModal('" + deleteMsg + " ?')", true);
            }
            catch (Exception ex)
            {

            }
        }

        protected void btnMachineDeleteConfirm_Click(object sender, EventArgs e)
        {
            try
            {
                MachineData data = new MachineData();
                data.CompanyID = (gvMachineData.Rows[selectedDeleteRowIndex].FindControl("lblCompanyID") as Label).Text;
                data.MachineID = (gvMachineData.Rows[selectedDeleteRowIndex].FindControl("lblMachineID") as Label).Text;
                data.EffectiveToDate = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                data.EffectiveFromDate = (gvMachineData.Rows[selectedDeleteRowIndex].FindControl("lblEffectiveFromDate") as Label).Text;
                int result = DBAccess.deleteMachineMasterDetails(data);
                if (result > 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Record deleted Successfully.','');", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "openErrorModal('Failed to delete record.');", true);
                }
                BindMachineDetails();
                selectedDeleteRowIndex = -1;
            }
            catch (Exception ex)
            {

            }
        }
        #endregion

        #region ---------Assign Machine To Plant
        protected void btnAssignMachineToPlant_Click(object sender, EventArgs e)
        {
         
            List<string> plantids = DBAccess.getPlantData(lblCompany_ForAssignMachine.Text);
            multiselectPlant.DataSource = plantids;
            multiselectPlant.DataBind();
            foreach(ListItem item in multiselectPlant.Items)
            {
                item.Selected = true;
            }
            BindAssignMachineToPlantData();
        }

        private void BindAssignMachineToPlantData()
        {
            try
            {
                string plant = "";
                foreach (ListItem item in multiselectPlant.Items)
                {

                    if (item.Selected)
                    {
                        if (plant == "")
                        {
                            plant = "'" + item.Text + "'";
                        }
                        else
                        {
                            plant += ",'" + item.Text + "'";
                        }
                    }
                }
                DataTable dt = DBAccess.getAllMachinePlantAssociation(lblCompany_ForAssignMachine.Text,txtSearchMachineID_ForAssignToPlant.Text,plant);
                ClearDataGridColumns(gvAssignMahineToPlantDetails);
                TemplateField tempField = new TemplateField();
                tempField.HeaderText = "";
                tempField.ItemTemplate = new DynamicTemplateField(DataControlRowType.DataRow);
                gvAssignMahineToPlantDetails.Columns.Add(tempField);
                DataTable dtData = convertDatatypeStringToBool(dt, 1);
                if (dtData != null)
                {
                    foreach (DataColumn dataColumn in dtData.Columns)
                    {

                        if (dataColumn.ColumnName.Equals("CompanyID", StringComparison.OrdinalIgnoreCase) || dataColumn.ColumnName.Equals("EffectiveFromdate", StringComparison.OrdinalIgnoreCase) || dataColumn.ColumnName.Equals("EffectiveTodate", StringComparison.OrdinalIgnoreCase))
                        {
                            continue;
                        }
                        else if (dataColumn.ColumnName.Equals("MachineID", StringComparison.OrdinalIgnoreCase))
                        {
                            BoundField boundField = new BoundField();
                            boundField.HeaderText = "Machine ID";
                            boundField.DataField = dataColumn.ColumnName;
                            boundField.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                            gvAssignMahineToPlantDetails.Columns.Add(boundField);
                        }
                        else
                        {
                            CheckBoxField checkBoxField = new CheckBoxField();
                            checkBoxField.HeaderText = dataColumn.ColumnName;
                            checkBoxField.DataField = dataColumn.ColumnName;
                            checkBoxField.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                            gvAssignMahineToPlantDetails.Columns.Add(checkBoxField);

                        }
                    }

                    gvAssignMahineToPlantDetails.DataSource = dtData;
                    gvAssignMahineToPlantDetails.DataBind();
                    gvAssignMahineToPlantDetails.Columns[0].Visible = false;
                }
            }
            catch (Exception ex)
            {

            }
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

        protected void lbNavigateToPlantHierarchy_Click(object sender, EventArgs e)
        {
            try
            {
                LinkButton lb = (LinkButton)sender;
                GridViewRow item = (GridViewRow)lb.NamingContainer;
                string plantID = (item.FindControl("lblPlantID") as Label).Text;
                Session["LHPlant"] = plantID;
                //Response.Redirect("~/LevelHierarchyMaster.aspx", false);
                ScriptManager.RegisterStartupScript(this, GetType(), "navigation", "onSubMenuClickedToNavigate('LevelHierarchyMaster','LevelHierarchyMaster.aspx');", true);
            }
            catch (Exception ex)
            {

            }
        }
        protected void btnNavigateToCompanyHierarchy_Click(object sender, EventArgs e)
        {
            try
            {
                LinkButton lb = (LinkButton)sender;
                GridViewRow item = (GridViewRow)lb.NamingContainer;
                string plantID = (item.FindControl("lblPlantID") as Label).Text;
                Session["CHPlant"] = plantID;
                //Response.Redirect("~/LevelHierarchyMaster.aspx", false);
                ScriptManager.RegisterStartupScript(this, GetType(), "navigation", "onSubMenuClickedToNavigate('LevelHierarchy','LevelHierarchy.aspx');", true);
            }
            catch (Exception ex)
            {

            }
        }


        protected void btnAssignMachineToPlantView_Click(object sender, EventArgs e)
        {
            try
            {
                BindAssignMachineToPlantData();
            }
            catch (Exception ex)
            {

            }
        }

        protected void btnAssignMachineToPlantSave_Click(object sender, EventArgs e)
        {
            try
            {
                //string value = hdnCheckChange1.Value;
                //if (value.Equals("Update", StringComparison.OrdinalIgnoreCase))
                //{
                string companyid = lblCompany_ForAssignMachine.Text;
                MachineAssignDetails data = null;
                foreach (GridViewRow selectedRow in gvAssignMahineToPlantDetails.Rows)
                {

                    // string IsUpdate = selectedRow.Cells[0].Text;
                    string machineid = selectedRow.Cells[1].Text;
                    //string effectiveFromDate = selectedRow.Cells[3].Text==""?DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"): Util.GetDateTime(selectedRow.Cells[3].Text).ToString("yyyy-MM-dd HH:mm:ss");
                    //string effectiveToDate = selectedRow.Cells[4].Text == "" ? DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") : Util.GetDateTime(selectedRow.Cells[4].Text).ToString("yyyy-MM-dd HH:mm:ss");
                    for (int i = 2; i < selectedRow.Cells.Count; i++)
                    {
                        data = new MachineAssignDetails();
                        string plantid = gvAssignMahineToPlantDetails.HeaderRow.Cells[i].Text;
                        CheckBox checkBox = (CheckBox)selectedRow.Cells[i].Controls[0];

                        data.CompanyID = companyid;
                        data.MachineID = machineid;
                        data.PlantID = plantid;
                        data.EffectiveFromDate = "";
                        data.EffectiveToDate = "";
                        if (checkBox.Checked)
                        {
                            data.CheckOrUncheck = "Check";
                            DBAccess.saveUpdateAssignMachineToPlantDetails(data);
                        }
                        else
                        {
                            data.CheckOrUncheck = "Uncheck";
                            DBAccess.saveUpdateAssignMachineToPlantDetails(data);
                        }
                    }
                }

                // ScriptManager.RegisterStartupScript(this, this.GetType(), "Success", "showpop5('Saved Successfully.')", true);
                // hdnCheckChange1.Value = "";
                // }
                BindAssignMachineToPlantData();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "successMsg", "showSuccessMsg('Records saved Successfully.','');", true);

            }
            catch (Exception ex)
            {
                BindAssignMachineToPlantData();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "error", "openErrorModal('Failed to insert records: " + ex.Message + "');", true);

            }
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

        private DataTable convertDatatypeStringToBool(DataTable dt, int indextochangetype)
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
                            string s = dt.Rows[i][j].ToString();
                            newrow[j] = dt.Rows[i][j].ToString();
                            //dtCloned.Rows[i][j] = dt.Rows[i][j].ToString();
                        }
                    }
                    dtCloned.Rows.Add(newrow);
                }

            }
            catch (Exception ex)
            {

            }
            return dtCloned;
        }
        #endregion


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
                                else if (string.Equals(userRightsDt.Rows[i][col].ToString(), "None", StringComparison.OrdinalIgnoreCase))
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
                dt = DBAccess.getUserRoleRightsDetails(ddlCompany_ForUserRoleRights.SelectedValue == null ? "" : ddlCompany_ForUserRoleRights.SelectedValue.ToString(), ddlRole_ForUserRoleRights.SelectedValue == null ? "" : ddlRole_ForUserRoleRights.SelectedValue.ToString());
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