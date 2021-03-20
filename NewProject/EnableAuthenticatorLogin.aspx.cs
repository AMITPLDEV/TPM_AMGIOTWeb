using Google.Authenticator;
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
    public partial class EnableAuthenticatorLogin : System.Web.UI.Page
    {
        private ApplicationUserManager manager;
        private ApplicationSignInManager signinManager;

        string AuthenticationCode
        {
            get
            {
                if (ViewState["AuthenticationCode"] != null)
                    return ViewState["AuthenticationCode"].ToString().Trim();
                return string.Empty;
            }
            set
            {
                ViewState["AuthenticationCode"] = value.Trim();
            }
        }

        string AuthenticationTitle { get { return "TPMAMGIOT"; } }
        string AuthenticationBarCodeImage { get; set; }
        string AuthenticationManualCode { get; set; }

        public EnableAuthenticatorLogin()
        {
            manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            signinManager = Context.GetOwinContext().GetUserManager<ApplicationSignInManager>();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                lblResult.Text = string.Empty;
                lblResult.Visible = false;
                GenerateTwoFactorAuthentication();
                imgQrCode.ImageUrl = AuthenticationBarCodeImage;
                lblManualSetupCode.Text = AuthenticationManualCode;
                lblAccountName.Text = AuthenticationTitle;
            }
        }

        protected void btnValidate_Click(object sender, EventArgs e)
        {
            string pin = txtSecurityCode.Text.Trim();
            bool status = ValidateTwoFactorPIN(pin);
            if (status)
            {
                lblResult.Visible = true;
                lblResult.Text = "Code Successfully Verified. Authenticator has been enabled for your login.";
                var user = manager.FindByNameAsync(User.Identity.Name).Result;
                if (user != null)
                {
                    manager.SetTwoFactorEnabledAsync(User.Identity.GetUserId(), true);
                    user.IsTOTPAuthenticatorEnabled = true;
                    user.TOTPAuthenticatorSecretKey = AuthenticationCode;
                    var res = manager.UpdateAsync(user).Result;
                    if (res.Succeeded)
                    {
                        signinManager.AuthenticationManager.SignOut();
                        Response.Redirect("~/LoginInitial");
                    }
                    else
                    {
                        AddErrors(res);
                    }
                }
                else
                {
                    ModelState.AddModelError("", "User not found.");
                    Response.Redirect("/ManageAccount?m=AuthenticatorEnableFailed");
                }
            }
            else
            {
                lblResult.Visible = true;
                lblResult.Text = "Invalid Code.";
            }
        }

        public bool ValidateTwoFactorPIN(String pin)
        {
            TwoFactorAuthenticator tfa = new TwoFactorAuthenticator();
            return tfa.ValidateTwoFactorPIN(AuthenticationCode, pin);
        }

        public bool GenerateTwoFactorAuthentication()
        {
            Guid guid = Guid.NewGuid();
            string uniqueUserKey = Convert.ToString(guid).Replace("-", "").Substring(0, 20);
            AuthenticationCode = uniqueUserKey;
            Dictionary<string, string> result = new Dictionary<string, string>();
            TwoFactorAuthenticator tfa = new TwoFactorAuthenticator();
            var setupInfo = tfa.GenerateSetupCode("Complio", AuthenticationTitle, AuthenticationCode, false, 3);
            if (setupInfo != null)
            {
                AuthenticationBarCodeImage = setupInfo.QrCodeSetupImageUrl;
                AuthenticationManualCode = setupInfo.ManualEntryKey;
                return true;
            }
            return false;
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