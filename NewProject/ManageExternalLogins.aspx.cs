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
    public partial class ManageExternalLogins : System.Web.UI.Page
    {
        protected string SuccessMessage { get; private set; }
        protected bool CanRemoveExternalLogins { get; private set; }
        private ApplicationUserManager manager;
        private ApplicationSignInManager signInManager;

        public ManageExternalLogins()
        {
            manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            signInManager = Context.GetOwinContext().GetUserManager<ApplicationSignInManager>();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            CanRemoveExternalLogins = manager.GetLogins(User.Identity.GetUserId()).Count() > 1;
            SuccessMessage = string.Empty;
            successMessage.Visible = !string.IsNullOrEmpty(SuccessMessage);
        }

        public void RemoveLogin(string loginProvider, string providerKey)
        {
            var result = manager.RemoveLogin(User.Identity.GetUserId(), new UserLoginInfo(loginProvider, providerKey));
            string msg = string.Empty;
            if (result.Succeeded)
            {
                var user = manager.FindById(User.Identity.GetUserId());
                signInManager.SignIn(user, isPersistent: false, rememberBrowser: false);
                msg = "?m=RemoveLoginSuccess";
            }
            Response.Redirect("~/ManageAccount" + msg);
        }

        public IEnumerable<UserLoginInfo> GetLogins()
        {
            var accounts = manager.GetLogins(User.Identity.GetUserId());
            CanRemoveExternalLogins = accounts.Count() > 1 || HasPassword(manager);
            return accounts;
        }

        private bool HasPassword(ApplicationUserManager manager)
        {
            return manager.HasPassword(User.Identity.GetUserId());
        }
    }
}