using NewProject.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NewProject
{
    public partial class SiteMaster : MasterPage
    {
        public string UserNamePropertyOnMasterPage
        {
            get
            {
                // Get value of control on master page  
                return lblShowSelectedItems.Text;
            }
            set
            {
                // Set new value for control on master page  
                lblShowSelectedItems.Text = value;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {

            //if (Session["ThemeValue"] != null)
            //{
            //    if (Session["ThemeValue"].ToString() == "light")
            //    {
            //        mainBody.Attributes["class"] = "";
            //        mainBody.Attributes.Add("class", "light-mode");
            //        chkToggleTheme.Checked = true;
            //    }
            //    else
            //    {
            //        mainBody.Attributes["class"] = "";
            //        chkToggleTheme.Checked = false;
            //    }
            //}

            if (Session["Username"] != null)
            {
                lblUserName.InnerText = Session["Username"].ToString() + " - " + Session["UserRole"].ToString();
            }
            else
            {
                Response.Redirect("~/Login.aspx", false);
            }
            if (Session["CompanyName"] != null)
            {
                smCompanyName.InnerText = Session["CompanyName"].ToString();
            }
            else
            {
                Response.Redirect("~/Login.aspx", false);
            }
            //if (Session["UserRole"] == null)
            //{

            //}
            //else
            //{
            //    string userRole = (string)Session["UserRole"];
            //    if (userRole.Replace(" ","").Trim() == "SuperAdmin")
            //    {

            //    }
            //    else if (userRole.Replace(" ", "").Trim() == "CompanyAdmin")
            //    {
            //        CompanyGroupMaster.Visible = false;
            //    }
            //    else
            //    {
            //        CompanyGroupMaster.Visible = false;
            //        LevelHierarchy.Visible = false;
            //    }
            //}
            showhideMenus();
        }
        private void showhideMenus()
        {
            try
            {
                List<MenuShowHide> list = new List<MenuShowHide>();
                if (Session["ScreenShowHide"] == null)
                {
                    //list=DBAcess
                }
                else
                {
                    list = (List<MenuShowHide>)Session["ScreenShowHide"];
                }

                //Masters
                CompanyGroupMaster.Visible = list.Where(x => x.Screen == "Company Group Master").Select(x => x.Visible).FirstOrDefault();
                LevelHierarchy.Visible = list.Where(x => x.Screen == "Level Heirarchy").Select(x => x.Visible).FirstOrDefault();
                LevelHierarchyMaster.Visible = list.Where(x => x.Screen == "Heirarchy masters").Select(x => x.Visible).FirstOrDefault();
                UserRoleRights.Visible = list.Where(x => x.Screen == "User Roles").Select(x => x.Visible).FirstOrDefault();
                ProcessParameterMaster.Visible = list.Where(x => x.Screen == "Process Param.").Select(x => x.Visible).FirstOrDefault();
                ProcessParameterMasterAGI.Visible = list.Where(x => x.Screen == "AGI Param.").Select(x => x.Visible).FirstOrDefault();
                MachineDocumentMaster.Visible = list.Where(x => x.Screen == "eDocs").Select(x => x.Visible).FirstOrDefault();
                SignatureComparisionMaster.Visible = list.Where(x => x.Screen == "Signature Comparison").Select(x => x.Visible).FirstOrDefault();
                Parts.Visible = list.Where(x => x.Screen == "Parts").Select(x => x.Visible).FirstOrDefault();
                LossCodes.Visible = list.Where(x => x.Screen == "Loss Codes").Select(x => x.Visible).FirstOrDefault();
                RejectionCodes.Visible = list.Where(x => x.Screen == "Rejection Codes").Select(x => x.Visible).FirstOrDefault();
                InspectionData.Visible = list.Where(x => x.Screen == "Inspection Data").Select(x => x.Visible).FirstOrDefault();


                //Process Parameters
                ProcessParameterDashboard.Visible = list.Where(x => x.Screen == "Dashboard").Select(x => x.Visible).FirstOrDefault();
                ProcessParameterSignatureComparison.Visible = list.Where(x => x.Screen == "Graph View").Select(x => x.Visible).FirstOrDefault();
                ProcessParameterListOfValues.Visible = list.Where(x => x.Screen == "List of Values").Select(x => x.Visible).FirstOrDefault();
                KB.Visible = list.Where(x => x.Screen == "KB").Select(x => x.Visible).FirstOrDefault();
                AlarmHistory.Visible = list.Where(x => x.Screen == "Alarm").Select(x => x.Visible).FirstOrDefault();
            }
            catch(Exception ex)
            {

            }
          
        }
        protected void chkToggleTheme_CheckedChanged(object sender, EventArgs e)
        {
            //if (chkToggleTheme.Checked)
            //{
            //    mainBody.Attributes["class"] = "";
            //    mainBody.Attributes.Add("class", "light-mode");
            //    Session["ThemeValue"] = "light";
            //}
            //else
            //{
            //    mainBody.Attributes["class"] = "";
            //    Session["ThemeValue"] = "dark";
            //}
        }
    }
}