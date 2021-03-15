using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NewProject
{
    public partial class ActivityTransaction : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindAtivityTransactionDetails();
            }
        }
        private void BindAtivityTransactionDetails()
        {
            try
            {
                DataTable dt = new DataTable();
                dt.Columns.Add("Sl No");
                dt.Columns.Add("Activity");
                dt.Columns.Add("Frequency");
                dt.Columns.Add("LastUpdate");
                dt.Columns.Add("Jul 2018");
                dt.Columns.Add("Oct 2018");
                dt.Columns.Add("Dec 2018");
                DataRow dr = null;
                dr = dt.NewRow();
                dr["Sl No"] = "1";
                dr["Activity"] = "Activity 1";
                dr["Frequency"] = "Daily";
                dr["LastUpdate"] = "11-02-2018";
                dr["Jul 2018"] = "P";
                dr["Oct 2018"] = "C";
                dr["Dec 2018"] = "P";
                dt.Rows.Add(dr);

                dr = dt.NewRow();
                dr["Sl No"] = "2";
                dr["Activity"] = "Activity 2";
                dr["Frequency"] = "Daily";
                dr["LastUpdate"] = "11-02-2018";
                dr["Jul 2018"] = "U";
                dr["Oct 2018"] = "P";
                dr["Dec 2018"] = "P";
                dt.Rows.Add(dr);

                for (int i = 4; i < dt.Columns.Count; i++)
                {
                    BoundField boundfield = new BoundField();

                    boundfield.DataField = dt.Columns[i].ColumnName.ToString();
                    boundfield.HeaderText = dt.Columns[i].ColumnName.ToString();
                    //if (listOfColNames[i].Equals("OEffy", StringComparison.OrdinalIgnoreCase) || listOfColNames[i].Equals("PEffy", StringComparison.OrdinalIgnoreCase) ||
                    //    listOfColNames[i].Equals("AEffy", StringComparison.OrdinalIgnoreCase) || listOfColNames[i].Equals("QEffy", StringComparison.OrdinalIgnoreCase))
                    //{
                    //    boundfield.DataFormatString = "{0:F0}";
                    //}
                    //boundfield.HeaderStyle.Width = new Unit("100px");
                    gvActivityTransactionDetails.Columns.Add(boundfield);
                }
                gvActivityTransactionDetails.DataSource = dt;
                gvActivityTransactionDetails.DataBind();
            }
            catch(Exception ex)
            {

            }
        }

        protected void gvActivityTransactionDetails_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                DataRowView drv = (DataRowView)e.Row.DataItem;

                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    for (int col = 4; col < e.Row.Cells.Count; col++)
                    {
                        if (e.Row.Cells[col].Text == "P")
                        {
                            e.Row.Cells[col].ForeColor = System.Drawing.Color.Red ;
                            e.Row.Cells[col].Font.Bold = true;
                        }
                        else if (e.Row.Cells[col].Text == "C")
                        {
                            e.Row.Cells[col].ForeColor = System.Drawing.Color.Green;
                            e.Row.Cells[col].Font.Bold = true;
                        }
                        else if (e.Row.Cells[col].Text == "U")
                        {
                            e.Row.Cells[col].ForeColor = System.Drawing.Color.FromArgb(247, 184, 10);
                            e.Row.Cells[col].Font.Bold = true;
                        }
                    }
                }
            }
            catch (Exception ex)
            {

            }
        }
                
    }
}