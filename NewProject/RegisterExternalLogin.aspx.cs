using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
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
    public partial class RegisterExternalLogin : System.Web.UI.Page
    {
        private ApplicationSignInManager signInManager;
        private ApplicationUserManager manager;
        protected string ProviderName
        {
            get { return (string)ViewState["ProviderName"] ?? String.Empty; }
            private set { ViewState["ProviderName"] = value; }
        }

        protected string ProviderAccountKey
        {
            get { return (string)ViewState["ProviderAccountKey"] ?? String.Empty; }
            private set { ViewState["ProviderAccountKey"] = value; }
        }

        public RegisterExternalLogin()
        {
            manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            signInManager = Context.GetOwinContext().GetUserManager<ApplicationSignInManager>();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Process the result from an auth provider in the request
            ProviderName = IdentityHelper.GetProviderNameFromRequest(Request);
            if (String.IsNullOrEmpty(ProviderName))
            {
                RedirectOnFail();
                return;
            }
            if (!IsPostBack)
            {
                var loginInfo = Context.GetOwinContext().Authentication.GetExternalLoginInfo();
                if (loginInfo == null)
                {
                    RedirectOnFail();
                    return;
                }
                var user = manager.Find(loginInfo.Login);
                if (user != null)
                {
                    signInManager.SignIn(user, isPersistent: false, rememberBrowser: false);
                    IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
                }
                else if (User.Identity.IsAuthenticated)
                {
                    // Apply Xsrf check when linking
                    var verifiedloginInfo = Context.GetOwinContext().Authentication.GetExternalLoginInfo(IdentityHelper.XsrfKey, User.Identity.GetUserId());
                    if (verifiedloginInfo == null)
                    {
                        RedirectOnFail();
                        return;
                    }

                    var result = manager.AddLogin(User.Identity.GetUserId(), verifiedloginInfo.Login);
                    if (result.Succeeded)
                    {
                        SignInToHome();
                    }
                    else
                    {
                        AddErrors(result);
                        return;
                    }
                }
                else
                {
                    email.Text = loginInfo.Email;
                }
            }
        }

        protected void LogIn_Click(object sender, EventArgs e)
        {
            CreateAndLoginUser();
        }

        private async void CreateAndLoginUser()
        {
            if (!IsValid)
            {
                return;
            }
            var usr = await manager.FindByEmailAsync(email.Text);
            if (usr != null)
            {
                var loginInfo = Context.GetOwinContext().Authentication.GetExternalLoginInfo();
                if (loginInfo == null)
                {
                    RedirectOnFail();
                    return;
                }
                var result = manager.AddLogin(usr.Id, loginInfo.Login);
                if (result.Succeeded)
                {
                    signInManager.SignIn(usr, isPersistent: false, rememberBrowser: false);
                    SignInToHome();
                    return;
                }
            }
            else
            {
                var user = new ApplicationUser() { UserName = email.Text.Split('@')[0], Email = email.Text, EmailConfirmed = false, PhoneNumberConfirmed = false, TwoFactorEnabled = false, LockoutEnabled = false, AccessFailedCount = 0, CorporateID = email.Text.Split('@')[0] + "Corp", UpdatedBy = email.Text.Split('@')[0] };
                IdentityResult result = manager.Create(user);
                if (result.Succeeded)
                {
                    var loginInfo = Context.GetOwinContext().Authentication.GetExternalLoginInfo();
                    if (loginInfo == null)
                    {
                        RedirectOnFail();
                        return;
                    }
                    result = manager.AddLogin(user.Id, loginInfo.Login);
                    if (result.Succeeded)
                    {
                        signInManager.SignIn(user, isPersistent: false, rememberBrowser: false);
                        //var code = manager.GenerateEmailConfirmationToken(user.Id);
                        //IdentityHelper.GetUserConfirmationRedirectUrl(code, user.Id)
                        SignInToHome();
                        return;
                    }
                }
                else
                {
                    if (result.Errors.Any(x => x.Contains("already taken")))
                    {
                        var loginInfo = Context.GetOwinContext().Authentication.GetExternalLoginInfo();
                    }
                }
                AddErrors(result);
            }
        }

        private void SignInToHome()
        {
            string companyId = Session["CompanyName"] != null ? Session["CompanyName"].ToString() : "";
            Session["ScreenShowHide"] = DBAccess.getMenuListForLoginUser(companyId, User.Identity.Name, "ScreenView");
            Session["ModuleShowHide"] = DBAccess.getMenuListForLoginUser(companyId, User.Identity.Name, "ModuleView");
            Session["UserRole"] = DBAccess.getRoleOfLoginUser(User.Identity.Name, companyId);
            if (Session["UserRole"].ToString().Replace(" ", "").ToLower() == "superadmin")
            {
                Response.Redirect("~/CompanyGroupMaster", false);
            }
            else
            {
                Response.Redirect("~/ProductionOEEDashboard", false);
            }
        }

        private void RedirectOnFail()
        {
            Response.Redirect((User.Identity.IsAuthenticated) ? "~/ManageAccount" : "~/LoginInitial");
        }

        private void AddErrors(IdentityResult result)
        {
            foreach (var error in result.Errors)
            {
                ModelState.AddModelError("", error);
            }
        }
    }
}