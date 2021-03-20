using NewProject.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Owin;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using NewProject.DataBaseAccess;
using System.Security.Claims;

namespace NewProject
{
    public partial class LoginPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var cookie = Request.Cookies["Username"];
                if (cookie == null)
                    Response.Redirect("~/LoginInitial.aspx");
                else
                {
                    Session["Username"] = cookie.Value;
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtPassword.Value))
            {
                try
                {
                    var userName = Session["Username"].ToString();
                    if (!string.IsNullOrEmpty(userName))
                    {
                        using (ApplicationDbContext _context = new ApplicationDbContext())
                        {
                            var companyId = _context.UserRoles.Where(x => x.Userid.Equals(userName)).Select(x => x.CompanyID).FirstOrDefault();
                            if (!string.IsNullOrEmpty(companyId))
                            {
                                Session["CompanyName"] = companyId;
                                var authMethod = _context.Companies.Where(x => x.CompanyID.Equals(companyId)).FirstOrDefault();
                                if (authMethod != null)
                                {
                                    var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
                                    var signinManager = Context.GetOwinContext().GetUserManager<ApplicationSignInManager>();
                                    var user = manager.FindByNameAsync(userName).Result;
                                    if (string.IsNullOrEmpty(authMethod.AuthenticationMethod) || !authMethod.AuthenticationMethod.Equals("LocalAD", StringComparison.OrdinalIgnoreCase))
                                    {
                                        try
                                        {
                                            if (user != null)
                                            {
                                                var userIdentity = user.GenerateUserIdentityAsync(manager).Result;
                                                var result = signinManager.PasswordSignInAsync(user.UserName, txtPassword.Value, RememberMe.Checked, shouldLockout: false).Result;
                                                if (result == SignInStatus.Success)
                                                {
                                                    if (!authMethod.AuthenticationMethod.Equals("AzureAD", StringComparison.OrdinalIgnoreCase))
                                                    {
                                                        Session["ScreenShowHide"] = DBAccess.getMenuListForLoginUser(Session["CompanyName"].ToString(), user.UserName, "ScreenView");
                                                        Session["ModuleShowHide"] = DBAccess.getMenuListForLoginUser(Session["CompanyName"].ToString(), user.UserName, "ModuleView");
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
                                                        Response.Redirect("~/AzureADLogin");
                                                    }
                                                }
                                                else if (result == SignInStatus.RequiresVerification)
                                                {
                                                    Session["2FAMethod"] = authMethod.TwoFactorAuthMethod;
                                                    if (authMethod.TwoFactorAuthMethod.Equals("PhoneOTP", StringComparison.OrdinalIgnoreCase))
                                                    {
                                                        if (string.IsNullOrEmpty(user.PhoneNumber))
                                                        {
                                                            Response.Redirect("~/AddPhoneNumber");
                                                        }
                                                        else
                                                        {
                                                            Response.Redirect("~/TwoFactorAuthenticationSignIn?RememberMe='" + RememberMe.Checked + "'");
                                                        }
                                                    }
                                                    else if (authMethod.TwoFactorAuthMethod.Equals("TOTP", StringComparison.OrdinalIgnoreCase))
                                                    {
                                                        if (user.IsTOTPAuthenticatorEnabled && !string.IsNullOrEmpty(user.TOTPAuthenticatorSecretKey))
                                                        {
                                                            Response.Redirect("~/TwoFactorAuthenticationSignInTOTP?RememberMe='" + RememberMe.Checked + "'");
                                                        }
                                                        else
                                                        {
                                                            Response.Redirect("~/EnableAuthenticatorLogin");
                                                        }
                                                    }
                                                    else
                                                        Response.Redirect("~/TwoFactorAuthenticationSignIn?RememberMe='" + RememberMe.Checked + "'");
                                                }
                                                else
                                                {
                                                    ShowHideError("Invalid Login. Your password may be incorrect.", true);
                                                }
                                            }
                                            else
                                            {
                                                ShowHideError("Invalid Login. Please try again.", true);
                                            }
                                        }
                                        catch (Exception ex)
                                        {
                                            if (ex.GetType().Name != "ThreadAbortException")
                                                ShowHideError(ex.Message, true);
                                        }
                                    }
                                }
                            }
                            else
                            {
                                ShowHideError("Could not find company id for the user.", true);
                            }
                        }
                    }
                    else
                    {
                        ShowHideError("Invalid Login. Please try again.", true);
                    }
                }
                catch (Exception ex)
                {
                    if (ex.GetType().Name != "ThreadAbortException")
                        ShowHideError(ex.Message, true);
                }
            }
            else
            {
                ShowHideError("Please enter password.", true);
            }
        }

        private void ShowHideError(string errorMessage, bool showError)
        {
            txtPassword.Value = "";
            lblErrorMsg.InnerText = errorMessage;
            lblErrorMsg.Visible = showError;
        }
    }
}