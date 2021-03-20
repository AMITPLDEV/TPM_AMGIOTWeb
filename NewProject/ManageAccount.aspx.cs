using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using NewProject.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NewProject
{
    public partial class ManageAccount : System.Web.UI.Page
    {
        private ApplicationUserManager manager;
        private ApplicationSignInManager signInManager;
        protected string SuccessMessage { get; private set; }
        public bool HasPhoneNumber { get; private set; }
        public bool TwoFactorEnabled { get; private set; }
        public bool TwoFactorBrowserRemembered { get; private set; }
        public int LoginsCount { get; set; }
        public bool TotpAuthenticatorEnabled { get; private set; }

        public ManageAccount()
        {
            manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            signInManager = Context.GetOwinContext().GetUserManager<ApplicationSignInManager>();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            HasPhoneNumber = string.IsNullOrEmpty(manager.GetPhoneNumber(User.Identity.GetUserId()));
            PhoneNumber.Text = manager.GetPhoneNumber(User.Identity.GetUserId()) ?? String.Empty;
            TwoFactorEnabled = manager.GetTwoFactorEnabled(User.Identity.GetUserId());
            LoginsCount = manager.GetLogins(User.Identity.GetUserId()).Count;
            var authenticationManager = HttpContext.Current.GetOwinContext().Authentication;
            var user = manager.FindById(User.Identity.GetUserId());
            if (user != null)
                TotpAuthenticatorEnabled = user.IsTOTPAuthenticatorEnabled;
            if (!IsPostBack)
            {
                if (HasPassword(manager))
                {
                    ChangePassword.Visible = true;
                }
                else
                {
                    CreatePassword.Visible = true;
                    ChangePassword.Visible = false;
                }

                var message = Request.QueryString["m"];
                if (message != null)
                {
                    Form.Action = ResolveUrl("~/ManageAccount");
                    SuccessMessage = message == "ChangePwdSuccess" ? "Your password has been changed."
                        : message == "SetPwdSuccess" ? "Your password has been set."
                        : message == "RemoveLoginSuccess" ? "The account was removed."
                        : message == "AddPhoneNumberSuccess" ? "Phone number has been added"
                        : message == "RemovePhoneNumberSuccess" ? "Phone number was removed"
                        : message == "AuthenticatorEnableSuccess" ? "Authenticator is enabled for your login"
                        : message == "AuthenticatorEnableFailed" ? "Authenticator could not be enabled for your login"
                        : message == "AuthenticatorDisableSuccess" ? "TOTP Authenticator successfully disabled"
                        : message == "TwoFactorEnableSuccess" ? "Two factor authentication successfully enabled"
                        : message == "TwoFactorEnableFail" ? "Could not enable two factor authentication"
                        : message == "TwoFactorDisableSuccess" ? "Two factor authentication successfully disabled"
                        : message == "TwoFactorDisableFail" ? "Could not disable two factor authentication"
                        : String.Empty;
                    successMessage.Visible = !String.IsNullOrEmpty(SuccessMessage);
                }
            }
        }

        // Remove phonenumber from user
        protected void RemovePhone_Click(object sender, EventArgs e)
        {
            var result = manager.SetPhoneNumber(User.Identity.GetUserId(), null);
            if (!result.Succeeded)
            {
                return;
            }
            var user = manager.FindById(User.Identity.GetUserId());
            if (user != null)
            {
                signInManager.SignIn(user, isPersistent: false, rememberBrowser: false);
                Response.Redirect("~/ManageAccount?m=RemovePhoneNumberSuccess");
            }
        }

        //EnableTwoFactorAuthentication 
        protected void TwoFactorEnable_Click(object sender, EventArgs e)
        {
            var result = manager.SetTwoFactorEnabled(User.Identity.GetUserId(), true);
            if(result.Succeeded)
                Response.Redirect("~/ManageAccount?m=TwoFactorEnableSuccess");
            else
                Response.Redirect("~/ManageAccount?m=TwoFactorEnableFail");
        }

        // DisableTwoFactorAuthentication
        protected void TwoFactorDisable_Click(object sender, EventArgs e)
        {
            var result = manager.SetTwoFactorEnabled(User.Identity.GetUserId(), false);
            if (result.Succeeded)
                Response.Redirect("~/ManageAccount?m=TwoFactorDisableSuccess");
            else
                Response.Redirect("~/ManageAccount?m=TwoFactorDisableFail");
        }

        protected void TotpAuthenticatorEnable_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/EnableAuthenticatorLogin");
        }

        protected async void TotpAuthenticatorDisable_Click(object sender, EventArgs e)
        {
            var user = manager.FindById(User.Identity.GetUserId());
            if (user != null)
            {
                user.IsTOTPAuthenticatorEnabled = false;
                user.TOTPAuthenticatorSecretKey = null;
                var result = manager.UpdateAsync(user).Result;
                if(result.Succeeded)
                {
                    await signInManager.SignInAsync(user, false, false);
                    Response.Redirect("~/ManageAccount?m=AuthenticatorDisableSuccess");
                }
                else
                {
                    AddErrors(result);
                }
            }
        }

        private void AddErrors(IdentityResult result)
        {
            foreach (var error in result.Errors)
            {
                ModelState.AddModelError("", error);
            }
        }

        private bool HasPassword(ApplicationUserManager manager)
        {
            return manager.HasPassword(User.Identity.GetUserId());
        }
    }
}