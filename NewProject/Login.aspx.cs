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
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["MachineParameterList"] = null;
          
        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            //try
            //{

            //    if (!string.IsNullOrEmpty(txtUsername.Value) && !string.IsNullOrEmpty(txtPassword.Value))
            //    {
            //        string username;
            //        Response.Redirect("~/ProductionOEEDashboard.aspx", false);
            //        Session["Username"] = txtUsername.Value;
            //    }
            //    else
            //    {
            //        txtUsername.Value = "";
            //        txtPassword.Value = "";
            //        lblErrorMsg.InnerText = "Enter Username or Password";
            //        lblErrorMsg.Visible = true;
            //    }
            //}
            //catch (Exception ex)
            //{
            //    Logger.WriteErrorLog(ex.ToString());
            //}

            try
            {

                if (!string.IsNullOrEmpty(txtUsername.Value) && !string.IsNullOrEmpty(txtPassword.Value) && !string.IsNullOrEmpty(txtCorporateID.Value))
                {
                    if (DBAccess.checkLoginData(txtUsername.Value, txtPassword.Value, txtCorporateID.Value))
                    {
                        string companyid = DBAccess.getCompanyIDOfLoginUser(txtUsername.Value);
                        string role = DBAccess.getRoleOfLoginUser(txtUsername.Value, companyid);
                        Session["CompanyName"] = companyid;
                        Session["ScreenShowHide"] = DBAccess.getMenuListForLoginUser(Session["CompanyName"].ToString(), txtUsername.Value, "ScreenView");
                        Session["ModuleShowHide"] = DBAccess.getMenuListForLoginUser(Session["CompanyName"].ToString(), txtUsername.Value, "ModuleView");
                        Session["UserRole"] = role;
                        string username;
                        if(role.Replace(" ", "").ToLower() == "superadmin")
                        {
                            Response.Redirect("~/CompanyGroupMaster.aspx", false);
                        }
                        else
                        {
                            Response.Redirect("~/ProductionOEEDashboard.aspx", false);
                        }
                      
                        Session["Username"] = txtUsername.Value;
                    }
                    else
                    {
                        txtUsername.Value = "";
                        txtPassword.Value = "";
                        lblErrorMsg.InnerText = "Incorrect Corporate ID or Username or Password";
                        lblErrorMsg.Visible = true;
                    }

                }
                else
                {
                    txtUsername.Value = "";
                    txtPassword.Value = "";
                    lblErrorMsg.InnerText = "Enter Corporate ID, Username and Password";
                    lblErrorMsg.Visible = true;
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.ToString());
            }
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static bool checkSuperAdminOrNot()
        {
            bool checkSuperAdminOr = false;
            if (HttpContext.Current.Session["UserRole"] == null)
            {
            }
            else
            {
                string userrole = (string)HttpContext.Current.Session["UserRole"];
                userrole = userrole.Replace(" ", "").ToLower();
                if (userrole == "superadmin")
                {
                    checkSuperAdminOr = true;
                }
            }
            return checkSuperAdminOr;
        }
    }
}