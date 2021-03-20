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
    public partial class ManagePassword : System.Web.UI.Page
    {
        protected string SuccessMessage { get; private set; }
        private ApplicationSignInManager signInManager;
        private ApplicationUserManager manager;

        public ManagePassword()
        {
            manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            signInManager = Context.GetOwinContext().GetUserManager<ApplicationSignInManager>();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (HasPassword(manager))
                {
                    changePasswordHolder.Visible = true;
                }
                else
                {
                    setPassword.Visible = true;
                    changePasswordHolder.Visible = false;
                }

                var message = Request.QueryString["m"];
                if (message != null)
                {
                    Form.Action = ResolveUrl("~/ManageAccount");
                }
            }
        }

        protected void SetPassword_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                IdentityResult result = manager.AddPassword(User.Identity.GetUserId(), password.Text);
                if (result.Succeeded)
                {
                    Response.Redirect("~/ManageAccount?m=SetPwdSuccess");
                }
                else
                {
                    AddErrors(result);
                }
            }
        }

        protected void ChangePassword_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                IdentityResult result = manager.ChangePassword(User.Identity.GetUserId(), CurrentPassword.Text, NewPassword.Text);
                if (result.Succeeded)
                {
                    var user = manager.FindById(User.Identity.GetUserId());
                    signInManager.SignIn(user, isPersistent: false, rememberBrowser: false);
                    Response.Redirect("~/ManageAccount?m=ChangePwdSuccess");
                }
                else
                {
                    AddErrors(result);
                }
            }
        }

        private bool HasPassword(ApplicationUserManager manager)
        {
            return manager.HasPassword(User.Identity.GetUserId());
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