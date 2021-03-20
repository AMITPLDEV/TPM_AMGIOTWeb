using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
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
    public partial class TwoFactorAuthenticationSignInTOTP : System.Web.UI.Page
    {
        private ApplicationSignInManager signinManager;
        private ApplicationUserManager manager;

        public TwoFactorAuthenticationSignInTOTP()
        {
            manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            signinManager = Context.GetOwinContext().GetUserManager<ApplicationSignInManager>();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var userId = signinManager.GetVerifiedUserId<ApplicationUser, string>();
                if (userId == null)
                {
                    Response.Redirect("~/Error?handler=TwoFactorAuthenticationSignInTOTP.Page_Load.userId&msg=UserNotFound", true);
                }
                if (Session["2FAMethod"] != null)
                {
                    string twoFaMethod = Session["2FAMethod"].ToString();
                    if (!twoFaMethod.Equals("TOTP", StringComparison.OrdinalIgnoreCase) && !string.IsNullOrEmpty(twoFaMethod))
                    {
                        ModelState.AddModelError("", "Invalid operation. Please login again.");
                    }
                }
            }
        }

        protected void VerifyTOTP_Click(object sender, EventArgs e)
        {
            bool rememberMe = false;
            bool.TryParse(Request.QueryString["RememberMe"], out rememberMe);
            if (!string.IsNullOrEmpty(AuthenticatorTOTP.Text))
            {
                if (ModelState.IsValid)
                {
                    var user = manager.FindById(signinManager.GetVerifiedUserId<ApplicationUser, string>());
                    if (user == null)
                    {
                        ErrorMessage.Visible = true;
                        ErrorMessage.Text = "Unable to load two-factor authentication user.";
                    }
                    else
                    {
                        var authenticatorCode = AuthenticatorTOTP.Text.Replace(" ", string.Empty).Replace("-", string.Empty);
                        var result = signinManager.TwoFactorSignInAsync("TOTPAuthenticator", authenticatorCode, rememberMe, false).Result;
                        if(result == SignInStatus.Success)
                        {
                            string companyId = Session["CompanyName"] != null ? Session["CompanyName"].ToString() : "";
                            Session["ScreenShowHide"] = DBAccess.getMenuListForLoginUser(companyId, user.UserName, "ScreenView");
                            Session["ModuleShowHide"] = DBAccess.getMenuListForLoginUser(companyId, user.UserName, "ModuleView");
                            Session["UserRole"] = DBAccess.getRoleOfLoginUser(user.UserName, companyId); ;
                            if (Session["UserRole"].ToString().Replace(" ", "").ToLower() == "superadmin")
                            {
                                Response.Redirect("~/CompanyGroupMaster", false);
                            }
                            else
                            {
                                Response.Redirect("~/ProductionOEEDashboard", false);
                            }
                        }
                        else
                        {
                            ErrorMessage.Visible = true;
                            ErrorMessage.Text = "Invalid code.";
                        }
                    }
                }
            }
            else
            {
                ErrorMessage.Text = "TOTP code is required.";
            }
        }
    }
}