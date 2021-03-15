using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NewProject
{
    public class BasePageClass : System.Web.UI.Page
    {
        //
        string s = "";
        

        public BasePageClass()
        {
            //(Page.FindControl("ddlCompany_ForUserRoleRights") as DropDownList).Visible=false;

            //IControlSet controlSet = this as IControlSet;
           Control ss= FindControlRecursive(Page, "btnUserATRoleSave");
           // Button dd = GetMyContentPlaceHolder();
            //if (controlSet != null)
            //{
            //    controlSet.Name.Text = "someName";
            //}

        }
       

        //public void PageFunc(Page page,string classname)
        //{
        //    typeof
        //}
        //public System.Web.UI.WebControls.Button GetMyContentPlaceHolder()
        //{
        //    Button holder = null;
        //   UserRoleRights  site = this.Page as UserRoleRights;
        //    if (site != null)
        //    {
        //        holder = site.FindControl("btnUserATRoleSave") as Button;
        //    }
        //    return holder;
        //}
 
    //protected override void OnLoad(EventArgs e)

    //{
    //    //Page.FindControl("btnUserRoleRights") as Button;
    //    try
    //    {

    //      Control dd= FindControlRecursive(btnUserRoleRights,)

    //    }
    //    catch (Exception ex)
    //    {
    //    }
    //}

    public Control FindControlRecursive(Control root, string id)
        {
            if (root.ID == id)
                return root;

            foreach (Control control in root.Controls)
            {
                Control foundControl = FindControlRecursive(control, id);
                if (foundControl != null)
                    return foundControl;
            }

            return null;
        }
    }

    //public IEnumerable<Control> GetAllControls(this Control parent)
    //{
    //    foreach (Control control in parent.Controls)
    //    {
    //        yield return control;
    //        if (control.HasControls())
    //        {
    //            IEnumerable<Control> foundControl = GetAllControls(control);
    //            foreach (Control child in foundControl)
    //            {
    //                yield return child;
    //            }
    //        }
    //    }
    //}


}
