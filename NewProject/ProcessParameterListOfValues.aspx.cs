using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;
using MongoDB.Driver;
using NewProject.DataBaseAccess;
using NewProject.HelperClass;
using NewProject.Model;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NewProject
{
    public partial class ProcessParameterListOfValues : System.Web.UI.Page
    {
      
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtFromDateTime.Text = DateTime.Now.AddHours(-2).ToString("dd-MM-yyyy HH:mm:ss");
                bindCompany();
                //bindMachineID();
                //  bindParameters();
                // ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "blockLoader", "callLoader();", true);
                bindData();
              //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "unblockLoader", "$.unblockUI({ });", true);
            }
        }
        private void bindCompany()
        {
            try
            {
                List<string> company = new List<string>();
                company = DBAccess.getCompanyData();
                ddlCompany.DataSource = company;
                ddlCompany.DataBind();

                if (Session["PPCompany"] == null)
                {

                }
                else
                {
                    try
                    {
                        ddlCompany.SelectedValue = (string)Session["PPCompany"];
                    }
                    catch(Exception ex)
                    {

                    }
                   
                }

                bindPlant();
            }
            catch (Exception ex)
            {

            }
        }
        private void bindPlant()
        {
            try
            {
                List<string> plant = new List<string>();
                plant = DBAccess.getPlantData(ddlCompany.SelectedValue == null ? "" : ddlCompany.SelectedValue.ToString());
                ddlPlant.DataSource = plant;
                ddlPlant.DataBind();
                if (Session["PPPlant"] == null)
                {

                }
                else
                {
                    try
                    {
                        ddlPlant.SelectedValue = (string)Session["PPPlant"];
                    }
                    catch (Exception ex)
                    {

                    }
                    
                }
                bindMachineID();
            }
            catch (Exception ex)
            {

            }
        }
        private void bindMachineID()
        {
            try
            {
                //List<ListItem> listItemList = new List<ListItem>();
                //listItemList = DBAccess.getMachineIDs(ddlCompany.SelectedValue == null ? "" : ddlCompany.SelectedValue.ToString(), ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString());
                //multiselectddlMachineID.DataSource = listItemList;
                //multiselectddlMachineID.DataTextField = "Text";
                //multiselectddlMachineID.DataValueField = "Value";
                //multiselectddlMachineID.DataBind();
                List<string> listItemList = new List<string>();
                listItemList = MongoDBAccess.getMachineID(ddlCompany.SelectedValue == null ? "" : ddlCompany.SelectedValue.ToString(), ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString());
                multiselectddlMachineID.DataSource = listItemList;
                multiselectddlMachineID.DataBind();
                if (Session["PPMachines"] == null)
                {
                    if (listItemList.Count > 0)
                    {
                        multiselectddlMachineID.Items[0].Selected = true;
                    }

                }
                else
                {
                    List<string> machines = (List<string>)Session["PPMachines"];
                    // Session["PPMachines"] = null;
                    foreach (ListItem item in multiselectddlMachineID.Items)
                    {
                        item.Selected = false;
                    }
                    for (int i = 0; i < machines.Count; i++)
                    {
                        foreach (ListItem item in multiselectddlMachineID.Items)
                        {
                            if (item.Text == machines[i])
                            {
                                item.Selected = true;
                            }
                        }
                    }
                }
                bindParameters();
            }
            catch (Exception ex)
            {

            }
        }
        private void bindParameters()
        {
            try
            {
                BsonArray machineNames = new BsonArray();
                foreach (ListItem item in multiselectddlMachineID.Items)
                {
                    if (item.Selected)
                    {
                        if (machineNames == "")
                        {
                            machineNames.Add(item.Value);
                        }
                        else
                        {
                            machineNames.Add(item.Value);
                        }
                    }
                }
                //List<string> selectedParameterList = new List<string>();
                //foreach (ListItem item in cbParameterList.Items)
                //{
                //    if (item.Selected)
                //    {
                //        selectedParameterList.Add(item.Text);
                //    }
                //}
                List<string> selectedParameterList = new List<string>();
                if (Session["PPParameters"] == null)
                {
                }
                else
                {
                    selectedParameterList = (List<string>)Session["PPParameters"];
                }


                foreach (ListItem item in cbParameterList.Items)
                {
                    if (item.Selected)
                    {
                        if (selectedParameterList.Contains(item.Text))
                        {

                        }
                        else
                        {
                            selectedParameterList.Add(item.Text);
                        }
                    }
                    else
                    {
                        if (selectedParameterList.Contains(item.Text))
                        {
                            selectedParameterList.Remove(item.Text);
                        }
                    }
                }
                Session["PPParameters"] = selectedParameterList;

                List<ListItem> parameterList = new List<ListItem>();
                if (cbCommonParametersOnly.Checked)
                {
                    parameterList = MongoDBAccess.getCoomomParameterListForMachines(machineNames, ddlCompany.SelectedValue == null ? "" : ddlCompany.SelectedValue.ToString(), ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString());
                }
                else
                {
                    parameterList = MongoDBAccess.getParameterListForMachines(machineNames, ddlCompany.SelectedValue == null ? "" : ddlCompany.SelectedValue.ToString(), ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString());
                }
              
                cbParameterList.DataSource = parameterList;
                cbParameterList.DataBind();
                //if (parameterList.Count > 0)
                //{
                //    cbParameterList.Items[0].Selected = true;
                //}
                bool selected = false;
                for (int i = 0; i < selectedParameterList.Count; i++)
                {
                    foreach (ListItem item in cbParameterList.Items)
                    {
                        if (item.Text == selectedParameterList[i])
                        {
                            item.Selected = true;
                            selected = true;
                        }
                    }
                }
                if (!selected)
                {
                    if (parameterList.Count > 0)
                    {
                        cbParameterList.Items[0].Selected = true;
                    }
                }
            }
            catch (Exception ex)
            {

            }
        }
        private void bindData()
        {
            try
            {
                string machineNames = "", parameterNames = "";
                foreach(ListItem item in multiselectddlMachineID.Items)
                {
                    if (item.Selected)
                    {
                        if (machineNames == "")
                        {
                            machineNames = "['" + item.Text + "'";
                        }
                        else
                        {
                            machineNames += ",'" +item.Text + "'";
                        }
                    }
                }
                if (machineNames != "")
                {
                    machineNames += "]";
                }
                else
                {
                    machineNames = "['']";
                }
                List<string> headerName = new List<string>();
                headerName.Add("MachineID");
                headerName.Add("CycleStartTS");
                headerName.Add("CycleEndTS");
                headerName.Add("UpdatedTS");
                foreach (ListItem item in cbParameterList.Items)
                {
                    if (item.Selected)
                    {
                        if (parameterNames == "")
                        {
                            parameterNames = "['" +item.Text + "'";
                        }
                        else
                        {
                            parameterNames += ",'" + item.Text + "'";
                        }
                        //headerName.Add(item.Text.Replace("-",""));
                        headerName.Add(item.Text);
                    }
                }
                if (parameterNames != "")
                {
                    parameterNames += "]";
                }
                else
                {
                    parameterNames = "['']";
                }
                string FromDate = txtFromDateTime.Text;
                double ToDate = ddlSelectHour.SelectedValue==null?0.5:Convert.ToDouble(ddlSelectHour.SelectedValue);
                //var filter = "{$and : [{ UpdatedTS: {$gte: ISODate('" + Util.GetDateTime(FromDate).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ") + "')} },{ UpdatedTS: {$lte: ISODate('" + Util.GetDateTime(FromDate).AddHours(ToDate).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ") + "')} }, {MachineID : {$in : " + machineNames + "}}]}";
                //var dataset = _MongoDatabase.GetCollection<BsonDocument>("PPT_AMGIOT_ColumnData_Test").Find(filter).ToList();

                List<BsonDocument> dataset = MongoDBAccess.getDataForListOfValues(FromDate, ToDate, machineNames,ddlCompany.SelectedValue == null ? "" : ddlCompany.SelectedValue.ToString(), ddlPlant.SelectedValue == null ? "" : ddlPlant.SelectedValue.ToString());

                for (int i = gvListOfValues.Columns.Count -1; i >= 0; i--)
                {
                    gvListOfValues.Columns.RemoveAt(i);
                }
                for (int i = headerName.Count - 1; i >= 0; i--)
                {
                    BoundField boundField = new BoundField();
                    boundField.DataField = headerName[i].ToString();
                    boundField.HeaderText = headerName[i].ToString();
                    gvListOfValues.Columns.Insert(0, boundField);
                }
                
                DataTable dt = new DataTable();
                for(int i=0;i< headerName.Count; i++)
                {
                    dt.Columns.Add(headerName[i]);
                }
               
                foreach (BsonDocument document in dataset)
                {
                    DataRow dr = dt.NewRow();
                    foreach (BsonElement elm in document.Elements)
                    {
                        if (dt.Columns.Contains(elm.Name))
                        {
                            if(elm.Name=="CycleStartTS" || elm.Name== "CycleEndTS" || elm.Name== "UpdatedTS")
                            {
                                if (elm.Value == BsonNull.Value)
                                {
                                    dr[elm.Name] = "";
                                }
                                else
                                {
                                    dr[elm.Name] = elm.Value.AsLocalTime.ToString("dd-MM-yyyy HH:mm:ss");
                                }

                                // dr[elm.Name] = elm.Value.AsDateTime.ToString("dd-MM-yyyy HH:mm:ss");

                            }
                            else
                            {
                                System.Type type = elm.Value.GetType();
                                if (type.Name == "BsonDouble")
                                {
                                    dr[elm.Name] = Math.Round(elm.Value.AsDouble, 3);
                                }
                                else
                                {
                                    dr[elm.Name] = elm.Value;
                                }
                               
                            }
                           
                        }

                    }
                    dt.Rows.Add(dr);
                }
                DataView dv = dt.DefaultView;
                dv.Sort = "MachineID";
                DataTable sortedDT = dv.ToTable();
                gvListOfValues.DataSource = sortedDT;
                gvListOfValues.DataBind();
                Session["ProcessParameterListOfValuesDetails"] = dt;
            }
            catch(Exception ex)
            {

            }
        }

        protected void btnOK_Click(object sender, EventArgs e)
        {
            try
            {
                bindData();
                 
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "unblockLoader", "$.unblockUI({ });", true);
            }
            catch(Exception ex)
            {

            }
        }

        protected void btnExportToExcel_Click(object sender, EventArgs e)
        {
            try
            {
                DataTable listOfValuesDetails = new DataTable();
                if (Session["ProcessParameterListOfValuesDetails"] == null)
                {
                    bindData();
                    listOfValuesDetails = (DataTable)Session["ProcessParameterListOfValuesDetails"];
                }
                else
                {
                    listOfValuesDetails = (DataTable)Session["ProcessParameterListOfValuesDetails"];
                }
               string generated= GenerateExcelReport.generateProcessParameterListOfValuesReoprt(listOfValuesDetails);
                if(generated.Equals("TemplateNotFound", StringComparison.OrdinalIgnoreCase))
                {
                    ScriptManager.RegisterStartupScript(this, typeof(Page), "Success" + 1, "<script>sucessMsg('Template Not Found.','','error')</script>", false);
                }
                else if (generated.Equals("DataNotFound", StringComparison.OrdinalIgnoreCase))
                {
                    ScriptManager.RegisterStartupScript(this, typeof(Page), "Success" + 1, "<script>sucessMsg('Data Not Found.','','warning')</script>", false);
                }
                else if (generated.Equals("Error", StringComparison.OrdinalIgnoreCase))
                {
                    ScriptManager.RegisterStartupScript(this, typeof(Page), "Success" + 1, "<script>sucessMsg('Error, While generating repoort.','','error')</script>", false);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, typeof(Page), "Success" + 1, "<script>sucessMsg('Report generated successfully.','','sucess')</script>", false);
                }
             
            }
            catch(Exception ex)
            {

            }
        }

        protected void multiselectddlMachineID_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                bindParameters();
                ScriptManager.RegisterStartupScript(this, GetType(), "stayMultiselectedList", "stayMultiselectedList();", true);
            }
            catch (Exception ex)
            {

            }
        }

        protected void cbCommonParametersOnly_CheckedChanged(object sender, EventArgs e)
        {
            try
            {
                bindParameters();

            }
            catch (Exception ex)
            {

            }
        }
        protected void ddlCompany_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                bindPlant();
            }
            catch (Exception ex)
            {

            }
        }

        protected void ddlPlant_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                bindMachineID();
            }
            catch (Exception ex)
            {

            }
        }

    }

}