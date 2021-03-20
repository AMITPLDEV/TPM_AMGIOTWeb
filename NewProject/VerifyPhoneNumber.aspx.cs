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
    public partial class VerifyPhoneNumber : System.Web.UI.Page
    {
        private ApplicationUserManager manager;
        private ApplicationSignInManager signinManager;
        private string phoneNumber;

        public VerifyPhoneNumber()
        {
            manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            signinManager = Context.GetOwinContext().GetUserManager<ApplicationSignInManager>();
            phoneNumber = Request.QueryString["PhoneNumber"];
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            var code = manager.GenerateChangePhoneNumberToken(User.Identity.GetUserId(), phoneNumber);
            PhoneNumber.Value = phoneNumber;
        }

        protected void Code_Click(object sender, EventArgs e)
        {
            if (!ModelState.IsValid)
            {
                ModelState.AddModelError("", "Invalid code");
                return;
            }

            var result = manager.ChangePhoneNumber(User.Identity.GetUserId(), PhoneNumber.Value, Code.Text);
            if (result.Succeeded)
            {
                var user = manager.FindById(User.Identity.GetUserId());

                if (user != null)
                {
                    signinManager.SignIn(user, isPersistent: false, rememberBrowser: false);
                    Response.Redirect("~/ManageAccount?m=AddPhoneNumberSuccess");
                }
            }

            // If we got this far, something failed, redisplay form
            ModelState.AddModelError("", "Failed to verify phone number.");
        }
    }
}