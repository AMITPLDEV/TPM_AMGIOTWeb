using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NewProject
{
    public partial class Unauthenticated : System.Web.UI.MasterPage
    {
        public string UserNamePropertyOnMasterPage
        {
            get { return lblShowSelectedItems.Text; }
            set { lblShowSelectedItems.Text = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["Username"]!=null)
            {
                lblUserName.InnerText = Session["Username"].ToString();
            }
            else
            {
                Response.Redirect("~/LoginInitial", false);
            }
        }
    }
}