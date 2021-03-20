using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using NewProject.DataBaseAccess;
using NewProject.HelperClass;
using NewProject.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NewProject
{
    public partial class TwoFactorAuthenticationSignIn : System.Web.UI.Page
    {
        private ApplicationSignInManager signinManager;
        private ApplicationUserManager manager;

        public TwoFactorAuthenticationSignIn()
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
                    Response.Redirect("~/Error?handler=TwoFactorAuthenticationSignIn.Page_Load.userId&msg=UserNotFound", true);
                }
                var userFactors = manager.GetValidTwoFactorProviders(userId);
                Providers.DataSource = userFactors.Select(x => x).ToList();
                Providers.DataBind();
                if (Session["2FAMethod"] != null)
                {
                    string twoFaMethod = Session["2FAMethod"].ToString();
                    if (twoFaMethod.Equals("PhoneOTP", StringComparison.OrdinalIgnoreCase))
                    {
                        SelectedProvider.Value = "Phone Code";
                        Providers.SelectedIndex = 0;
                    }
                    else
                    {
                        SelectedProvider.Value = "Email Code";
                        Providers.SelectedIndex = 1;
                    }
                }
                else
                {
                    SelectedProvider.Value = "Email Code";
                    Providers.SelectedIndex = 1;
                }
                Providers.Enabled = false;
            }
        }

        protected void CodeSubmit_Click(object sender, EventArgs e)
        {
            bool rememberMe = false;
            try
            {
                bool.TryParse(Request.QueryString["RememberMe"], out rememberMe);
                var result = signinManager.TwoFactorSignIn<ApplicationUser, string>(SelectedProvider.Value, Code.Text, isPersistent: rememberMe, rememberBrowser: RememberBrowser.Checked);
                switch (result)
                {
                    case SignInStatus.Success:
                        string companyId = Session["CompanyName"] != null ? Session["CompanyName"].ToString() : "";
                        Session["ScreenShowHide"] = DBAccess.getMenuListForLoginUser(companyId, User.Identity.Name, "ScreenView");
                        Session["ModuleShowHide"] = DBAccess.getMenuListForLoginUser(companyId, User.Identity.Name, "ModuleView");
                        Session["UserRole"] = DBAccess.getRoleOfLoginUser(User.Identity.Name, companyId); ;
                        if (Session["UserRole"].ToString().Replace(" ", "").ToLower() == "superadmin")
                        {
                            Response.Redirect("~/CompanyGroupMaster", false);
                        }
                        else
                        {
                            Response.Redirect("~/ProductionOEEDashboard", false);
                        }
                        break;
                    case SignInStatus.LockedOut:
                        Response.Redirect("~/Lockout");
                        break;
                    case SignInStatus.Failure:
                        FailureText.Text = "Invalid code";
                        ErrorMessage.Visible = true;
                        break;
                    default:
                        FailureText.Text = "Invalid code";
                        ErrorMessage.Visible = true;
                        break;
                }
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }

        protected void ProviderSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                if (!signinManager.SendTwoFactorCode(Providers.SelectedValue))
                {
                    Response.Redirect("~/Error");
                }

                var user = manager.FindById(signinManager.GetVerifiedUserId<ApplicationUser, string>());
                if (user != null)
                {
                    var code = manager.GenerateTwoFactorToken(user.Id, Providers.SelectedValue);
                }

                SelectedProvider.Value = Providers.SelectedValue;
                sendcode.Visible = false;
                verifycode.Visible = true;
            }
            catch (Exception ex)
            {
                Logger.WriteErrorLog(ex.Message);
            }
        }
    }
}