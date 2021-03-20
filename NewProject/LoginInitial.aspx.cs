using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using NewProject.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NewProject
{
    public partial class LoginInitial : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtUserName.Value) && !string.IsNullOrEmpty(txtCorporateID.Value))
            {
                try
                {
                    var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
                    try
                    {
                        var user = manager.FindByNameAsync(txtUserName.Value).Result;
                        if (user != null)
                        {
                            if (user.CorporateID.Equals(txtCorporateID.Value))
                            {
                                HttpCookie httpCookie = new HttpCookie("Username", txtUserName.Value)
                                {
                                    Expires = DateTime.Now.AddMinutes(20)
                                };
                                Response.SetCookie(httpCookie);
                                Response.Redirect("~/LoginPassword");
                            }
                            else
                            {
                                ShowHideError("Entered Corporate ID does not exists for selected user.", true);
                            }
                        }
                        else
                        {
                            ShowHideError("User not found. Please try again.", true);
                        }
                    }
                    catch (Exception ex)
                    {
                        if (ex.GetType().Name != "ThreadAbortException")
                            ShowHideError(ex.Message, true);
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
                ShowHideError("Please enter Corporate ID and UserName both.", true);
            }
        }

        private void ShowHideError(string errorMessage, bool showError)
        {
            txtCorporateID.Value = "";
            txtUserName.Value = "";
            lblErrorMsg.InnerText = errorMessage;
            lblErrorMsg.Visible = showError;
        }
    }
}