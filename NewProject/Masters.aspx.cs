using NewProject.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NewProject
{
    public partial class Masters : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindMTBData();
                BindControllerLevelData();
                BindMachineLevelData();
            }
        }
        private void BindMTBData()
        {
            List<ProcessParameterMasterData> list = new List<ProcessParameterMasterData>();
            list.Add(setGetProcessData("", "", "MGTL", "MCV 400", "P1", "Macro", "F003", "Boolean", "", "", "0.5", "Custom PMC", "Within Cycle Reading", "60 min.", "3", true, false, "", "", false));
            list.Add(setGetProcessData("", "", "MGTL", "MCV 400", "P2", "PMC", "F003", "Boolean", "", "", "0.5", "Custom PMC", "Continious Reading", "60 min.", "1", false, true, "", "", false));
            list.Add(setGetProcessData("", "", "MGTL", "MCV 400", "P3", "Focas Function", "F003", "Boolean", "", "", "0.5", "Custom Macro", "Within Cycle Reading", "60 min.", "10", true, false, "", "", false));
            list.Add(setGetProcessData("", "", "MGTL", "MCV 400", "P4", "Macro", "F003", "Boolean", "", "", "0.5", "Custom Dia", "Continious Reading", "60 min.", "3", true, true, "", "", false));
            gvMTBModeldata.DataSource = list;
            gvMTBModeldata.DataBind();
        }
        private ProcessParameterMasterData setGetProcessData(string MachineID, string MachineType, string MTB, string MachineModel, string ParemeterID, string SourceType, string SourceAdd1, string SourceAdd2, string SourceDatatype1, string SourceDatatype2, string PollingFrequency, string DataGroup, string PollingType, string CycleFreqTime, string NoOfCycle, bool IsEnabled, bool ShouldNotBeDisabled, string CNCMake, string CNCModel, bool IsEnabledForDataRead)
        {
            ProcessParameterMasterData data = new ProcessParameterMasterData();
            data.MachineID = MachineID;
            data.MachineType = MachineType;
            data.MTB = MTB;
            data.MachineModel = MachineModel;
            data.ParemeterID = ParemeterID;
            data.SourceType = SourceType;
            data.SourceAdd1 = SourceAdd1;
            data.SourceAdd2 = SourceAdd2;
            data.SourceDatatype1 = SourceDatatype1;
            data.SourceDatatype2 = SourceDatatype2;
            data.PollingFrequency = PollingFrequency;
            data.DataGroup = DataGroup;
            data.PollingType = PollingType;
            data.CycleFreqTime = CycleFreqTime;
            data.NoOfCycle = NoOfCycle;
            data.IsEnabled = IsEnabled;
            data.ShouldNotBeDisabled = ShouldNotBeDisabled;
            data.CNCModel = CNCModel;
            data.CNCMake = CNCMake;
            data.IsEnabledForDataRead = IsEnabledForDataRead;
            return data;
        }

        protected void gvMTBModeldata_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string hdnvalue = (e.Row.FindControl("hdnSourceType") as HiddenField).Value;
                DropDownList ddl = (e.Row.FindControl("ddlSourceType") as DropDownList);
                ddl.SelectedValue = hdnvalue;

                hdnvalue = (e.Row.FindControl("hdnPollingFrequency") as HiddenField).Value;
                ddl = (e.Row.FindControl("ddlPollingFrequency") as DropDownList);
                ddl.SelectedValue = hdnvalue;
                hdnvalue = (e.Row.FindControl("hdnDataGroup") as HiddenField).Value;
                ddl = (e.Row.FindControl("ddlDataGroup") as DropDownList);
                ddl.SelectedValue = hdnvalue;
                hdnvalue = (e.Row.FindControl("hdnPollingType") as HiddenField).Value;
                ddl = (e.Row.FindControl("ddlPollingType") as DropDownList);
                ddl.SelectedValue = hdnvalue;

                hdnvalue = (e.Row.FindControl("hdnCycleFreqTime") as HiddenField).Value;
                ddl = (e.Row.FindControl("ddlCycleFrequencyTime") as DropDownList);
                ddl.SelectedValue = hdnvalue;
                hdnvalue = (e.Row.FindControl("hdnNoOfCycle") as HiddenField).Value;
                ddl = (e.Row.FindControl("ddlNoOfCycle") as DropDownList);
                ddl.SelectedValue = hdnvalue;
            }
        }

        private void BindControllerLevelData()
        {
            List<ProcessParameterMasterData> list = new List<ProcessParameterMasterData>();
            list.Add(setGetProcessData("", "VMC", "MGTL", "MCV 400", "Cycle Start", "Alarm History", "F003", "Boolean", "", "", "5 sec", "Custom Signals", "Continious Reading", "30 min.", "4", true, false, "Fanuc", "OiTD", false));
            list.Add(setGetProcessData("", "VMC", "MGTL", "MCV 400", "P2", "Alarm History", "F003", "Boolean", "", "", "60 sec", "Custom System Parameters", "Read Based On Custom TimePeriod", "30 min.", "6", true, true, "Fanuc", "OiTD", false));
            list.Add(setGetProcessData("", "VMC", "MGTL", "MCV 400", "P3", "PMC", "F003", "Boolean", "", "", "500 ms", "Custom PM", "Continious Reading", "60 min.", "8", true, true, "Fanuc", "OiTD", false));
            list.Add(setGetProcessData("", "VMC", "MGTL", "MCV 400", "P4", "Focas Function", "F003", "Boolean", "", "", "60 sec", "Custom Signals", "Read Based On Custom TimePeriod", "60 min.", "6", false, false, "Fanuc", "OiTD", false));
            list.Add(setGetProcessData("", "VMC", "MGTL", "MCV 400", "P5", "Tool Life", "F003", "Boolean", "", "", "5 sec", "Fixed Data", "Read Based On Custom TimePeriod", "30 min.", "2", false, true, "Fanuc", "OiTD", false));
            gvControllerLvlData.DataSource = list;
            gvControllerLvlData.DataBind();
        }
        protected void gvControllerLvlData_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string hdnvalue = (e.Row.FindControl("hdnSourceType") as HiddenField).Value;
                DropDownList ddl = (e.Row.FindControl("ddlSourceType") as DropDownList);
                ddl.SelectedValue = hdnvalue;

                hdnvalue = (e.Row.FindControl("hdnPollingFrequency") as HiddenField).Value;
                ddl = (e.Row.FindControl("ddlPollingFrequency") as DropDownList);
                ddl.SelectedValue = hdnvalue;
                hdnvalue = (e.Row.FindControl("hdnDataGroup") as HiddenField).Value;
                ddl = (e.Row.FindControl("ddlDataGroup") as DropDownList);
                ddl.SelectedValue = hdnvalue;
                hdnvalue = (e.Row.FindControl("hdnPollingType") as HiddenField).Value;
                ddl = (e.Row.FindControl("ddlPollingType") as DropDownList);
                ddl.SelectedValue = hdnvalue;

                hdnvalue = (e.Row.FindControl("hdnCycleFreqTime") as HiddenField).Value;
                ddl = (e.Row.FindControl("ddlCycleFrequencyTime") as DropDownList);
                ddl.SelectedValue = hdnvalue;
                hdnvalue = (e.Row.FindControl("hdnNoOfCycle") as HiddenField).Value;
                ddl = (e.Row.FindControl("ddlNoOfCycle") as DropDownList);
                ddl.SelectedValue = hdnvalue;
            }
        }
        private void BindMachineLevelData()
        {
            List<ProcessParameterMasterData> list = new List<ProcessParameterMasterData>();
            list.Add(setGetProcessData("ACE-01", "", "MGTL", "MCV 400", "P1", "Dia", "F003", "Boolean", "", "", "0.5", "Tool Life", "Within Cycle Reading", "60 min.", "5", true, true, "", "", true));
            list.Add(setGetProcessData("ACE-01", "", "MGTL", "MCV 400", "P2", "Macro", "F003", "Boolean", "", "", "0.5", "Operation History", "Continious Reading", "60 min.", "1", true, false, "", "", false));
            list.Add(setGetProcessData("ACE-01", "", "MGTL", "MCV 400", "P3", "PMC", "F003", "Boolean", "", "", "0.5", "Alarm History", "Read Based On Custom TimePeriod", "60 min.", "2", false, false, "", "", true));
            list.Add(setGetProcessData("ACE-01", "", "MGTL", "MCV 400", "P4", "Dia", "F003", "Boolean", "", "", "0.5", "Custom PMC", "Continious Reading", "60 min.", "7", true, true, "", "", false));
            gvMAchineLvlData.DataSource = list;
            gvMAchineLvlData.DataBind();
        }

        protected void gvMAchineLvlData_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string hdnvalue = (e.Row.FindControl("hdnSourceType") as HiddenField).Value;
                DropDownList ddl = (e.Row.FindControl("ddlSourceType") as DropDownList);
                ddl.SelectedValue = hdnvalue;

                hdnvalue = (e.Row.FindControl("hdnPollingFrequency") as HiddenField).Value;
                ddl = (e.Row.FindControl("ddlPollingFrequency") as DropDownList);
                ddl.SelectedValue = hdnvalue;
                hdnvalue = (e.Row.FindControl("hdnDataGroup") as HiddenField).Value;
                ddl = (e.Row.FindControl("ddlDataGroup") as DropDownList);
                ddl.SelectedValue = hdnvalue;
                hdnvalue = (e.Row.FindControl("hdnPollingType") as HiddenField).Value;
                ddl = (e.Row.FindControl("ddlPollingType") as DropDownList);
                ddl.SelectedValue = hdnvalue;

                hdnvalue = (e.Row.FindControl("hdnCycleFreqTime") as HiddenField).Value;
                ddl = (e.Row.FindControl("ddlCycleFrequencyTime") as DropDownList);
                ddl.SelectedValue = hdnvalue;
                hdnvalue = (e.Row.FindControl("hdnNoOfCycle") as HiddenField).Value;
                ddl = (e.Row.FindControl("ddlNoOfCycle") as DropDownList);
                ddl.SelectedValue = hdnvalue;
            }
        }
    }
}