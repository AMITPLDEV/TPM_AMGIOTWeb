<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProcessParameterDashboard.aspx.cs" Inherits="NewProject.ProcessParameterDashboard" EnableEventValidation="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">



    <%--    <script src="https://code.highcharts.com/stock/highstock.js"></script>
    <script src="https://code.highcharts.com/stock/modules/data.js"></script>
    <script src="https://code.highcharts.com/stock/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/stock/modules/export-data.js"></script>

    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/highcharts-3d.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/modules/export-data.js"></script>
    <script src="https://code.highcharts.com/modules/accessibility.js"></script>--%>

    <script src="Scripts/HighStock9.0.0/highstock.js"></script>
    <script src="Scripts/HighStock9.0.0/data.js"></script>
    <script src="Scripts/HighStock9.0.0/exporting.js"></script>
    <script src="Scripts/HighStock9.0.0/export-data.js"></script>

    <script src="Scripts/HighChart9.0.0/highcharts.js"></script>
    <script src="Scripts/HighChart9.0.0/highcharts-3d.js"></script>
    <script src="Scripts/HighChart9.0.0/exporting.js"></script>
    <script src="Scripts/HighChart9.0.0/export-data.js"></script>
    <script src="Scripts/HighChart9.0.0/accessibility.js"></script>


    <%--            <link href="http://cdn.syncfusion.com/18.3.0.47/js/web/flat-azure/ej.web.all.min.css" rel="stylesheet" />
    <script src="http://cdn.syncfusion.com/js/assets/external/jquery-1.10.2.min.js"></script>
    <script src="http://cdn.syncfusion.com/18.3.0.47/js/web/ej.web.all.min.js"></script>--%>

    <link href="http://cdn.syncfusion.com/18.2.0.44/js/web/flat-azure/ej.web.all.min.css" rel="stylesheet" />
    <%--    <script src="http://cdn.syncfusion.com/js/assets/external/jquery-1.10.2.min.js"></script>--%>
    <script src="http://cdn.syncfusion.com/18.2.0.44/js/web/ej.web.all.min.js"></script>

    <%--       <link href="http://cdn.syncfusion.com/18.3.0.47/js/web/flat-azure/ej.web.all.min.css" rel="stylesheet" />
    <script src="http://cdn.syncfusion.com/js/assets/external/jquery-1.10.2.min.js"></script>
    <script src="http://cdn.syncfusion.com/js/assets/external/jquery.easing.1.3.min.js"></script>
    <script src="http://cdn.syncfusion.com/js/assets/external/jquery.globalize.min.js"></script>
    <script src="http://cdn.syncfusion.com/js/assets/external/jsrender.min.js"></script>
    <script src="http://cdn.syncfusion.com/18.3.0.47/js/web/ej.web.all.min.js"></script>--%>

    <%--     <script src="https://cdn.syncfusion.com/ej2/dist/ej2.min.js" type="text/javascript"></script>
    <link href="https://cdn.syncfusion.com/ej2/material.css" rel="stylesheet">--%>

    <%--    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">--%>

    <link rel="stylesheet" type="text/css" href="https://cdn3.devexpress.com/jslib/20.1.7/css/dx.common.css" />
    <link rel="stylesheet" type="text/css" href="https://cdn3.devexpress.com/jslib/20.1.7/css/dx.light.css" />
    <script src="https://cdn3.devexpress.com/jslib/20.1.7/js/dx.all.js"></script>

    <script src="Scripts/DateTimePickerFor331/moment.js"></script>
    <script src="Scripts/DateTimePickerFor331/bootstrap-datetimepicker.min.js"></script>
    <link href="Scripts/DateTimePickerFor331/bootstrap-datetimepicker.min.css" rel="stylesheet" />

    <link href="Scripts/MultiSelectDropdown/bootstrap-multiselect.css" rel="stylesheet" />
    <script src="Scripts/MultiSelectDropdown/bootstrap-multiselect.js"></script>

    <style id="PPDashboardStyle">
        body {
            line-height: unset;
        }

        .outer-ul .removeHover:hover {
            background-color: unset;
        }

        .outer-ul > li:hover {
            background-color: unset;
        }

        .template1 tr th {
            padding: 6px;
            font-size: 16px;
        }

        .template1 tr td {
            padding: 6px;
        }

        .sub-items-filtersection li {
            padding: 10px 0px;
        }

        .outer-ul .removeHover:hover {
            background-color: unset;
        }

        .main-div {
            box-shadow: 0px 0px 10px #2b2828ed;
        }

            .main-div table tr th {
                /*background-color: #6c7884;*/
                background-color: #d4d4d491;
                color: black;
            }

        .main-div-table-shadow table {
            box-shadow: 0px 0px 10px #2b2828ed;
        }

            .main-div-table-shadow table tr th {
                background-color: #6c7884;
            }

        .light-mode .main-div {
            box-shadow: 2px 2px 5px 2px #c3bfbfed !important;
        }

            .light-mode .main-div table tr th {
                background-color: #d4d4d491 !important;
            }

        .light-mode .main-div-table-shadow table {
            box-shadow: 0px 0px 10px #c3bfbfed !important;
        }

            .light-mode .main-div-table-shadow table tr th {
                background-color: #d4d4d491 !important;
            }

        .highchart-title {
            color: white;
        }

        .light-mode .highchart-title {
            color: #1a1a1af7 !important;
        }

        .minmax-label {
            color: #15f3f3;
        }

        .light-mode .minmax-label {
            color: #00149f !important;
        }

        #processParamChartViewContainer tr td {
            background-color: #171e21;
        }

        .light-mode #processParamChartViewContainer tr td {
            background-color: white !important;
        }

        .filter-checkbox label {
            font-weight: unset;
            margin-left: 2px;
        }

        .themetoggle {
            width: 99vw;
        }

        #cbParameterList tr td {
            padding: 5px 5px 5px 5px;
        }

            #cbParameterList tr td label {
                font-weight: unset;
            }

        #cbCommonParametersOnly {
            margin-left: 5px;
            margin-top: 12px;
            margin-right: 3px;
        }

        .multiselect-container {
            /*height: 300px;*/
            /*overflow-x: auto;*/
        }

        .multiselect-selected-text {
            padding-right: 181px;
        }

        .multiselect .dropdown-toggle {
            width: 50%;
        }

        .multiselect {
            width: 200px;
            overflow: hidden;
            display: block;
        }

        .multiselect-container label {
            color: black;
        }

        .multiselect span {
            color: black;
        }

        .multiselect-native-select > .btn-group > button {
            border-radius: 10px;
        }

        .timebar-btn {
            color: white;
            font-size: 28px;
            text-decoration: none;
        }

            .timebar-btn:hover {
                color: white;
                text-decoration: none;
            }

        .light-mode .timebar-btn {
            color: black !important;
        }

            .light-mode .timebar-btn:hover {
                color: black !important;
                text-decoration: none;
            }

        .alarm-msg-table tr td span, .alarm-msg-table tr th span, #alarmDiv span {
            color: black;
        }

        .glyp-icons {
            font-size: 17px;
            color: white;
        }

            .glyp-icons:hover {
                color: white;
                text-decoration: none;
            }

        .light-mode .glyp-icons {
            color: black !important;
        }

        .light-mode .glyp-icons {
            color: black !important;
            text-decoration: none;
        }

        .machine-table tr td {
            padding-top: 5px;
            padding-bottom: 5px;
        }

        .filter-checkbox > input {
            width: 1em;
            height: 1em;
            background-color: white;
            border-radius: 50%;
            /*vertical-align: sub;*/
            border: 1px solid #ddd;
            -webkit-appearance: none;
            outline: none;
            cursor: pointer;
        }

        .filter-checkbox > label {
            vertical-align: text-bottom;
            margin-bottom: 0px;
        }

        .filter-checkbox > input:checked {
            background-color: #056de3;
        }
    </style>

    <div class="themetoggle">

        <asp:HiddenField runat="server" ID="hdView" ClientIDMode="Static" />

        <%--<asp:Timer runat="server" ID="alarmInterval" OnTick="alarmInterval_Tick"></asp:Timer>--%>
        <table class="submenu-right-side" id="right-table">
            <tr>
                <%-- <td style="padding-top: 4px">
                    <asp:DropDownList runat="server" ID="ddlMachineID" ClientIDMode="Static" AutoPostBack="true" OnSelectedIndexChanged="ddlMachineID_SelectedIndexChanged" CssClass="form-control dropdown-list"></asp:DropDownList>

                </td>--%>
                <td>
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>

                            <asp:LinkButton runat="server" ID="lbBackToLive" ToolTip="Back" Style="transform: scaleX(-1);" CssClass="glyphicon glyphicon-share-alt glyp-icons" OnClientClick="callLoader();" OnClick="lbBackToLive_Click"></asp:LinkButton>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnOK" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                </td>
                <td style="padding-top: 4px">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <asp:DropDownList runat="server" ID="ddlCompany" CssClass="form-control dropdown-list" AutoPostBack="true" OnSelectedIndexChanged="ddlCompany_SelectedIndexChanged" Style="display: inline-block; width: 150px;" ClientIDMode="Static"></asp:DropDownList>
                            <asp:DropDownList runat="server" ID="ddlPlant" CssClass="form-control dropdown-list" AutoPostBack="true" OnSelectedIndexChanged="ddlPlant_SelectedIndexChanged" Style="display: inline-block; width: 150px;" ClientIDMode="Static"></asp:DropDownList>
                            <asp:ListBox ID="multiselectddlMachineID" runat="server" SelectionMode="Multiple" AutoPostBack="true" OnSelectedIndexChanged="multiselectddlMachineID_SelectedIndexChanged" CssClass="dropdown-list" ClientIDMode="Static" Style="width: 150px; display: inline-block;"></asp:ListBox>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnOK" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="ddlCompany" EventName="SelectedIndexChanged" />
                            <asp:AsyncPostBackTrigger ControlID="ddlPlant" EventName="SelectedIndexChanged" />

                        </Triggers>
                    </asp:UpdatePanel>

                </td>
                <td onmouseover="showPanelsTopRight(this,'panelExport','5px','40px');" onmouseout="hidePanels(this,'panelExport')">
                    <i class="glyphicon glyphicon-save" style="font-size: 17px;"></i>
                    <div class="panel panel-default panel-subitems" id="panelExport" onmouseover="showPanelsTopRight(this,'panelExport','5px','40px');" onmouseout="hidePanels(this,'panelExport')" style="width: 200px;">
                        <div class="panel-body">
                            <ul class="outer-ul">
                                <%--  <li>
                                    <span>Export as Excel</span>
                                </li>--%>
                                <li>
                                    <span onclick="printPDF(this);">Export as PDF</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </td>
                <td onmouseover="showPanelsTopRight(this,'panelView','5px','40px');" onmouseout="hidePanels(this,'panelView')">
                    <i class="glyphicon glyphicon-th" style="font-size: 17px;"></i>
                    <div class="panel panel-default panel-subitems" id="panelView" onmouseover="showPanelsTopRight(this,'panelView','5px','40px');" onmouseout="hidePanels(this,'panelView')" style="width: 200px;">
                        <div class="panel-body">
                            <ul class="outer-ul">
                                <li onclick="showViews(this,'ListView')">
                                    <span>Text View</span>
                                </li>
                                <li onclick="showViews(this,'MeterView')">
                                    <span>Meter View</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </td>

                <%--onmouseover="showPanelFilter(this,'panelFilter','5px','40px', 'ulFilter');" onmouseout="hidePanels(this,'panelFilter')"--%>
                <td>


                    <%-- <asp:UpdatePanel runat="server">
                        <ContentTemplate>--%>
                    <i class="glyphicon glyphicon-filter" style="font-size: 17px;" onclick="showPanelFilter(this,'panelFilter','9px','40px', 'ulFilter');"></i>
                    <div class="panel panel-default panel-subitems" id="panelFilter" style="width: 28%">
                        <div class="panel-body">
                            <i class="glyphicon glyphicon-remove" style="float: right" onclick="hidePanel('panelFilter')"></i>
                            <div id="divDashboardFilter">
                                <ul class="outer-ul" id="ulFilterForGraph">
                                    <li>
                                        <div style="border: 1px solid red; padding: 8px 10px 5px 10px; margin-top: 20px">


                                            <asp:UpdatePanel runat="server">
                                                <ContentTemplate>
                                                    <span style="margin-left: 9px; font-weight: bold">Machines: </span>
                                                    <asp:DropDownList runat="server" ID="ddlMachines" ClientIDMode="Static" CssClass="form-control dropdown-list" AutoPostBack="true" OnSelectedIndexChanged="ddlMachines_SelectedIndexChanged" Style="margin-bottom: 3px; margin-left: 5px; display: inline-block"></asp:DropDownList>
                                                </ContentTemplate>
                                                <Triggers>

                                                    <asp:AsyncPostBackTrigger ControlID="ddlCompany" EventName="SelectedIndexChanged" />
                                                    <asp:AsyncPostBackTrigger ControlID="ddlPlant" EventName="SelectedIndexChanged" />
                                                    <asp:AsyncPostBackTrigger ControlID="btnOK" EventName="Click" />
                                                    <asp:AsyncPostBackTrigger ControlID="multiselectddlMachineID" EventName="SelectedIndexChanged" />
                                                </Triggers>
                                            </asp:UpdatePanel>



                                            <asp:TextBox runat="server" ID="txtSearchParameters" ClientIDMode="Static" placeholder="Search Parameters" onkeyup="searchParameters();" AutoCompleteType="Disabled" CssClass="form-control" Style="margin-left: 5px; margin-bottom: 3px; min-width: 364px"></asp:TextBox>
                                            <%-- <asp:CheckBox runat="server" ID="cbCommonParametersOnly" ClientIDMode="Static" Font-Bold="false" Text="Common Parameters Only" AutoPostBack="true" CssClass="checkbox-text-fontweightset" OnCheckedChanged="cbCommonParametersOnly_CheckedChanged" />--%>
                                            <asp:CheckBox runat="server" ID="cbSelectAll" ClientIDMode="Static" onchange="selctAllParameters();" Font-Bold="false" Text="Select All" CssClass="checkbox-text-fontweightset" Style="margin-left: 10px" />
                                            <asp:UpdatePanel runat="server">
                                                <ContentTemplate>
                                                    <div style="height: 190px; overflow: auto;">
                                                        <asp:CheckBoxList runat="server" ID="cbParameterList" CssClass="checkbox-list" ClientIDMode="Static" RepeatDirection="Vertical" RepeatColumns="2" onchange="selctAllParametersWhenChange();">
                                                        </asp:CheckBoxList>
                                                    </div>
                                                </ContentTemplate>
                                                <Triggers>
                                                    <asp:AsyncPostBackTrigger ControlID="ddlMachines" EventName="SelectedIndexChanged" />
                                                    <asp:AsyncPostBackTrigger ControlID="multiselectddlMachineID" EventName="SelectedIndexChanged" />
                                                    <%--<asp:AsyncPostBackTrigger ControlID="cbCommonParametersOnly" EventName="CheckedChanged" />--%>
                                                </Triggers>
                                            </asp:UpdatePanel>
                                        </div>
                                        <table>
                                            <tr>
                                                <td style="padding-left: 0px">From Date:
                                                </td>
                                                <td class="input-group" style="min-width: 150px; border: 0">
                                                    <asp:TextBox ID="txtFromDateTime" runat="server" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control datetime-txtstyle" placeholder="From Date" Style="display: inline; margin-bottom: 8px;"></asp:TextBox>

                                                </td>
                                            </tr>
                                            <%--     <tr>
                                                <td style="padding-left: 0px">Select Hour:
                                                </td>
                                                <td class="input-group" style="min-width: 150px; border: 0">
                                                    <asp:DropDownList runat="server" ID="ddlSelectHour" ClientIDMode="Static" CssClass="form-control dropdown-list">
                                                        <asp:ListItem Value="0.5" Text="0.5 hr"></asp:ListItem>
                                                        <asp:ListItem Value="1" Text="1 hr"></asp:ListItem>
                                                        <asp:ListItem Value="2" Text="2 hr"></asp:ListItem>
                                                        <asp:ListItem Value="3" Text="3 hr"></asp:ListItem>
                                                        <asp:ListItem Value="4" Text="4 hr"></asp:ListItem>
                                                        <asp:ListItem Value="5" Text="5 hr"></asp:ListItem>
                                                        <asp:ListItem Value="6" Text="6 hr"></asp:ListItem>
                                                        <asp:ListItem Value="7" Text="7 hr"></asp:ListItem>
                                                        <asp:ListItem Value="8" Text="8 hr"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>--%>
                                        </table>
                                        <%-- <asp:CheckBoxList runat="server" ID="cblLimitSelection" CssClass="checkbox-list" ClientIDMode="Static" RepeatDirection="Vertical" RepeatColumns="2">
                                    <asp:ListItem Value="UpperWarningLimit" Text="Upper Warning Limit"></asp:ListItem>
                                    <asp:ListItem Value="LowerWarningLimit" Text="Lower Warning Limit"></asp:ListItem>
                                </asp:CheckBoxList>--%>
                                        <asp:Button runat="server" ID="btnOK" ClientIDMode="Static" OnClientClick="callLoader();" OnClick="btnOK_Click" CssClass="Btns" Style="margin-left: 20px" Text="OK" />
                                    </li>
                                    <li onclick="showFilterSubItems(this,'liIimeSubFilters','downuparrow')" class="main-filter">
                                        <span class="menu-text">No. of columns</span>
                                        <span id="downuparrow" style="margin-left: 20px" class="glyphicon glyphicon-menu-down main-filter-updownarrow"></span>

                                    </li>
                                    <li style="display: none" id="liIimeSubFilters" class="removeHover sub-filters">
                                        <ul class="sub-items-filtersection">
                                            <li>
                                                <table>
                                                    <tr>
                                                        <td style="padding: 0px">
                                                            <asp:TextBox runat="server" ID="txtNoOfColumns" CssClass="form-control" ClientIDMode="Static" Style="width: 90px; height: 24px;" onkeypress="if(event.keyCode<48 || event.keyCode>57)event.returnValue=false;" AutoCompleteType="Disabled"></asp:TextBox></td>
                                                        <td style="padding: 0px">&nbsp;
                                                                    <asp:Button runat="server" ID="btnNoOfColumnsOk" Text="OK" CssClass="Btns" UseSubmitBehavior="false" OnClientClick="if(!noOfcolumnValidation()){return false};" OnClick="btnNoOfColumnsOk_Click" /></td>
                                                    </tr>
                                                </table>

                                            </li>
                                        </ul>
                                    </li>
                                    <%--  <li class="main-filter">

                                    
                                     
                                    </li>--%>

                                    <li class="main-filter">


                                        <asp:CheckBox runat="server" ID="chkEnableGroup" ClientIDMode="Static" AutoPostBack="true" OnCheckedChanged="chkEnableGroup_CheckedChanged" CssClass="filter-checkbox" Text="Enable Grouping" Style="width: 16px; height: 16px; margin-right: 50px" />

                                        <span class="menu-text">Show</span>

                                        <div style="margin-left: 176px">
                                            <div style="display: inline-block; height: 20px; width: 20px; text-align: center; margin-right: 5px; background-color: red">
                                                <asp:CheckBox runat="server" ID="cbRed" ClientIDMode="Static" AutoPostBack="true" OnCheckedChanged="cbRed_CheckedChanged" CssClass="rgb-filter" Style="width: 16px; height: 16px" />
                                            </div>

                                            <div style="display: inline-block; height: 20px; width: 20px; text-align: center; margin-right: 5px; background-color: yellow">
                                                <asp:CheckBox runat="server" ID="cbYellow" ClientIDMode="Static" AutoPostBack="true" OnCheckedChanged="cbYellow_CheckedChanged" CssClass="rgb-filter" Style="width: 16px; height: 16px" />
                                            </div>

                                            <div style="display: inline-block; height: 20px; width: 20px; text-align: center; margin-right: 5px; background-color: #2db32d">
                                                <asp:CheckBox runat="server" ID="cbGreen" ClientIDMode="Static" AutoPostBack="true" OnCheckedChanged="cbGreen_CheckedChanged" CssClass="rgb-filter" Style="width: 16px; height: 16px" />
                                            </div>
                                        </div>


                                    </li>

                                    <li class="main-filter">

                                        <%--   <asp:UpdatePanel runat="server">
                                            <ContentTemplate>--%>


                                        <asp:CheckBox runat="server" ID="cbSortRYG" ClientIDMode="Static" AutoPostBack="true" OnCheckedChanged="cbSortRYG_CheckedChanged" CssClass="filter-checkbox" Text="Sort RYG" Style="width: 16px; height: 16px; margin-right: 90px" />

                                        <asp:CheckBox runat="server" ID="cbSortGYR" ClientIDMode="Static" AutoPostBack="true" OnCheckedChanged="cbSortGYR_CheckedChanged" CssClass="filter-checkbox" Text="Sort GYR" Style="width: 16px; height: 16px" />

                                        <%--   </ContentTemplate>
                                        </asp:UpdatePanel>--%>
                                    </li>
                                    <%--  <li class="main-filter">

                                      
                                     

                                    </li>--%>
                                </ul>


                            </div>
                        </div>
                    </div>


                    <%--</ContentTemplate>--%>
                    <%-- <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="cbSortGYR" EventName="CheckedChanged" />
                            <asp:AsyncPostBackTrigger ControlID="cbSortRYG" EventName="CheckedChanged" />
                            <asp:AsyncPostBackTrigger ControlID="chkEnableGroup" EventName="CheckedChanged" />
                            <asp:AsyncPostBackTrigger ControlID="cbRed" EventName="CheckedChanged" />
                            <asp:AsyncPostBackTrigger ControlID="cbYellow" EventName="CheckedChanged" />
                            <asp:AsyncPostBackTrigger ControlID="cbGreen" EventName="CheckedChanged" />
                        </Triggers>--%>
                    <%--</asp:UpdatePanel>--%>
                </td>
                <td>
                    <i class="glyphicon glyphicon-triangle-right" id="btnShow" title="Show Alarm Panel" onclick="showAlarmPanel('show');" style="font-size: 17px;"></i>
                    <i class="glyphicon glyphicon-remove" id="btnHide" title="Hide Alarm Panel" onclick="showAlarmPanel('hide');" style="font-size: 17px;"></i>
                </td>
            </tr>
        </table>

        <div style="display: inline-block; width: 100%">
            <div id="contentDiv" style="">
                <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                        <asp:HiddenField runat="server" ID="activeMenu" ClientIDMode="Static" />
                        <asp:HiddenField runat="server" ID="hdnNoOfColumns" ClientIDMode="Static" />
                        <div id="processParamTextViewContainer" style="overflow: auto; white-space: nowrap; display: none" class="listView processParamContainer">

                            <asp:ListView runat="server" ID="lvProcessParamTextView">
                                <LayoutTemplate>
                                    <div>
                                        <div runat="server" id="itemplaceholder"></div>
                                    </div>
                                </LayoutTemplate>
                                <ItemTemplate>
                                    <div style="border: 1px solid royalblue; border-radius: 10px; display: table-cell" class="machine-div">
                                        <div style="padding: 3px 20px; border-bottom: 1px solid royalblue; position: relative">
                                            <span style="font-size: 18px;"><%# Eval("MachineID") %></span>
                                            <asp:HiddenField runat="server" ID="hfmachineID" Value='<%# Eval("MachineID") %>' ClientIDMode="Static" />
                                            <asp:HiddenField runat="server" ID="hfCompanyID" Value='<%# Eval("CompanyID") %>' ClientIDMode="Static" />
                                            <asp:HiddenField runat="server" ID="hfPlantID" Value='<%# Eval("PlantID") %>' ClientIDMode="Static" />
                                            <asp:LinkButton runat="server" ID="lbTroubleshootMachine" Text="T" Style="position: absolute; top: 3px; color: white; font-size: 15px; background-color: red; padding: 2px 8px; border-radius: 12px; margin-left: 20px; font-weight: bold; text-decoration: none" OnClientClick="callLoader();" OnClick="lbTroubleshootMachine_Click"></asp:LinkButton>

                                            <asp:LinkButton runat="server" ID="lbLaunchToGraphView" Text="G" Style="position: relative; top: 0px; left: 40px; color: white; font-size: 15px; background-color: green; padding: 2px 8px; border-radius: 12px; margin-left: 20px; font-weight: bold; text-decoration: none" OnClick="lbLaunchToGraphView_Click"></asp:LinkButton>
                                        </div>

                                        <asp:ListView runat="server" ID="lvPeocessParameters" DataSource='<%# Eval("parameterDetails") %>'>
                                            <LayoutTemplate>
                                                <div style="padding: 10px;">
                                                    <div runat="server" id="itemplaceholder"></div>
                                                </div>
                                            </LayoutTemplate>
                                            <ItemTemplate>
                                                <div class="main-div" style="display: inline-block; background-color: <%# Eval("BackColor") %>; width: 300px; border-radius: 10px; margin: 5px 5px; height: 155px;">
                                                    <table class="template1" style="width: 100%; text-align: center; display: <%# Eval("Template1Visibility") %>;">
                                                        <tr>
                                                            <th colspan="4" style="border-top-left-radius: 10px; border-top-right-radius: 10px; text-align: center; position: relative">
                                                                <asp:Label runat="server" Text='<%# Eval("HeaderName") %>' Width="225px" Style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap; min-width: 225px; color: black; font-size: 16px" ToolTip='<%# Eval("HeaderName") %>'></asp:Label>
                                                                <%-- <span><%# Eval("HeaderName") %></span>--%>

                                                                <asp:HiddenField runat="server" ID="hfUpdatedTS" ClientIDMode="Static" Value='<%# Eval("UpdatedTS") %>' />
                                                                <asp:LinkButton runat="server" ID="lbTrubleshoot" ClientIDMode="Static" Visible='<%#Eval("TrubleshootIconVisibility")%>' CssClass="" Text="T" Style="position: absolute; top: 3px; right: 8px; color: white; font-size: 17px; background-color: red; padding: 2px 8px; border-radius: 12px;" OnClientClick="return showTroubleShootSolutions(this,'hdnParameterID')"></asp:LinkButton>
                                                                <asp:HiddenField runat="server" ID="hdnParameterID" Value='<%# Eval("HeaderName") %>' ClientIDMode="Static" />
                                                            </th>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="4">
                                                                <label style="background: white; padding: 1px 40px; color: black; font-size: 20px;"><%# Eval("Value") %></label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="4" style="padding: 0px">
                                                                <label style="font-size: 19px; margin: 0px; color: black"><%# Eval("ChartType") %></label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align: right; font-size: 19px; color: black">Hi</td>
                                                            <td>
                                                                <label style="background: white; padding: 1px 25px; color: black; font-size: 19px;"><%# Eval("HighValue") %></label>
                                                            </td>
                                                            <td style="text-align: right; font-size: 19px; color: black">Lo</td>
                                                            <td>
                                                                <label style="background: white; padding: 1px 25px; color: black; font-size: 19px;"><%# Eval("LowValue") %></label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <table class="template1" style="width: 100%; text-align: center; display: <%# Eval("Template2Visibility") %>;">
                                                        <tr>
                                                            <th colspan="4" style="border-top-left-radius: 10px; border-top-right-radius: 10px; text-align: center">
                                                                <%# Eval("HeaderName") %>
                                                                <asp:LinkButton runat="server" ID="LinkButton1" ClientIDMode="Static" Visible='<%#Eval("TrubleshootIconVisibility")%>' CssClass="" Text="T" Style="position: absolute; top: 3px; right: 24px; color: white; font-size: 17px; background-color: red; padding: 2px 8px; border-radius: 12px;" OnClientClick="return showTroubleShootSolutions(this,'hdnTemp2ParameterID')"></asp:LinkButton>
                                                                <asp:HiddenField runat="server" ID="hdnTemp2ParameterID" Value='<%# Eval("HeaderName") %>' ClientIDMode="Static" />
                                                            </th>
                                                        </tr>
                                                        <tr style="height: 110px">
                                                            <td colspan="4">
                                                                <label style="background: white; padding: 1px 40px; color: black; font-size: 20px;"><%# Eval("Value") %></label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div style="display: <%# Eval("NextLineVisibility") %>">
                                                </div>
                                            </ItemTemplate>
                                        </asp:ListView>
                                    </div>
                                    <br />
                                </ItemTemplate>
                            </asp:ListView>


                        </div>
                        <div id="processParamChartViewContainer" style="overflow: auto; white-space: nowrap; display: none" class="cardView processParamContainer">
                            <asp:ListView runat="server" ID="lvChartData">
                                <LayoutTemplate>
                                    <div>
                                        <div runat="server" id="itemplaceholder"></div>
                                    </div>
                                </LayoutTemplate>
                                <ItemTemplate>
                                    <div style="border: 1px solid royalblue; border-radius: 10px; display: table-cell" class="machine-div">
                                        <div style="padding: 3px 20px; border-bottom: 1px solid royalblue; position: relative">
                                            <span style="font-size: 18px;"><%# Eval("MachineID") %></span>
                                            <asp:HiddenField runat="server" ID="hfmachineID" Value='<%# Eval("MachineID") %>' ClientIDMode="Static" />
                                            <asp:HiddenField runat="server" ID="hfCompanyID" Value='<%# Eval("CompanyID") %>' ClientIDMode="Static" />
                                            <asp:HiddenField runat="server" ID="hfPlantID" Value='<%# Eval("PlantID") %>' ClientIDMode="Static" />
                                            <asp:LinkButton runat="server" ID="lbTroubleshootMachine" Text="T" Style="position: absolute; top: 3px; color: white; font-size: 15px; background-color: red; padding: 2px 8px; border-radius: 12px; margin-left: 20px; font-weight: bold; text-decoration: none" OnClientClick="callLoader();" OnClick="lbTroubleshootMachine_Click"></asp:LinkButton>
                                            <asp:LinkButton runat="server" ID="lbLaunchToGraphView" Text="G" Style="position: relative; top: 0px; left: 40px; color: white; font-size: 15px; background-color: green; padding: 2px 8px; border-radius: 12px; margin-left: 20px; font-weight: bold; text-decoration: none" OnClick="lbLaunchToGraphView_Click"></asp:LinkButton>
                                        </div>


                                        <asp:ListView runat="server" ID="lvparameterCharts" DataSource='<%# Eval("parameterDetails") %>'>
                                            <LayoutTemplate>
                                                <div id="divChartData" style="padding: 10px;">
                                                    <div runat="server" id="itemplaceholder"></div>
                                                </div>
                                            </LayoutTemplate>
                                            <ItemTemplate>
                                                <div class="main-div-table-shadow main-div" style="display: inline-block; width: 300px; border-radius: 10px; margin: 5px;">
                                                    <table class="template1" style="width: 100%; text-align: center;">
                                                        <tr>
                                                            <th colspan="4" style="border-top-left-radius: 10px; border-top-right-radius: 10px; text-align: center; position: relative">
                                                                <%-- <%# Eval("HeaderName") %>--%>
                                                                <asp:Label runat="server" Text='<%# Eval("HeaderName") %>' Width="225px" Style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap; min-width: 225px; color: black; font-size: 16px" ToolTip='<%# Eval("HeaderName") %>'></asp:Label>
                                                                <asp:HiddenField runat="server" ID="hfUpdatedTS" ClientIDMode="Static" Value='<%# Eval("UpdatedTS") %>' />
                                                                <asp:LinkButton runat="server" ID="LinkButton1" ClientIDMode="Static" Visible='<%#Eval("TrubleshootIconVisibility")%>' CssClass="" Text="T" Style="position: absolute; top: 3px; right: 8px; color: white; font-size: 17px; background-color: red; padding: 2px 8px; border-radius: 12px;" OnClientClick="return showTroubleShootSolutions(this,'hdnParameterID')"></asp:LinkButton>
                                                                <asp:HiddenField runat="server" ID="hdnParameterID" Value='<%# Eval("HeaderName") %>' ClientIDMode="Static" />
                                                            </th>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <input type="hidden" id="hdnMinValue" value='<%# Eval("LowValue") %>' />
                                                                <input type="hidden" id="hdnMaxValue" value='<%# Eval("HighValue") %>' />
                                                                <input type="hidden" id="hdnActualValue" value='<%# Eval("Value") %>' />
                                                                <input type="hidden" id="hdnChartType" value='<%# Eval("ChartType") %>' />
                                                                <div style="display: table; width: 100%; visibility: <%# Eval("GraphHighLowVisibility") %>">
                                                                    <div style="display: table-cell; font-size: 18px;" class="minmax-label">
                                                                        Min:
                                            <label style="font-size: 18px;"><%# Eval("LowValue") %></label>
                                                                    </div>
                                                                    <div style="display: table-cell; font-size: 18px;" class="minmax-label">
                                                                        Max:
                                            <label style="font-size: 18px;"><%# Eval("HighValue") %></label>
                                                                    </div>
                                                                </div>
                                                                <div id='<%# Eval("chartContainerID") %>' class="chartDiv" style="text-align: center">
                                                                </div>
                                                                <div>
                                                                    <label style="font-size: 18px;" class="minmax-label"><%# Eval("ChartType") %></label>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div style="display: <%# Eval("NextLineVisibility") %>">
                                                </div>
                                            </ItemTemplate>
                                        </asp:ListView>

                                    </div>
                                    <br />
                                </ItemTemplate>
                            </asp:ListView>

                        </div>
                    </ContentTemplate>
                    <Triggers>

                        <asp:AsyncPostBackTrigger ControlID="cbSortGYR" EventName="CheckedChanged" />
                        <asp:AsyncPostBackTrigger ControlID="cbSortRYG" EventName="CheckedChanged" />
                        <asp:AsyncPostBackTrigger ControlID="chkEnableGroup" EventName="CheckedChanged" />
                        <asp:AsyncPostBackTrigger ControlID="cbRed" EventName="CheckedChanged" />
                        <asp:AsyncPostBackTrigger ControlID="btnNoOfColumnsOk" EventName="Click" />

                        <asp:AsyncPostBackTrigger ControlID="cbYellow" EventName="CheckedChanged" />
                        <asp:AsyncPostBackTrigger ControlID="cbGreen" EventName="CheckedChanged" />
                        <asp:AsyncPostBackTrigger ControlID="btnOK" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="lbBackToLive" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="lbPrevious" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="lbNext" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnParticulatDateSelected" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnTimeClickinTimeBar" EventName="Click" />


                        <%--<asp:AsyncPostBackTrigger ControlID="cbCommonParametersOnly" EventName="CheckedChanged" />--%>
                    </Triggers>
                </asp:UpdatePanel>
            </div>

            <div id="alarmDiv" style="margin-left: 10px; border: 2px solid #227e4f; vertical-align: bottom; text-align: center; background-color: #99fcdb; border-radius: 10px; overflow: auto">
                <%--   <span style="text-align: center; font-weight: bold; font-size: 19px; color: #a30ee3">Alarm Details</span>--%>
                <%-- <a style="text-align: center; font-weight: bold; font-size: 19px; color: #a30ee3" href="Troubleshooting.aspx?machineID=&parameterName=Alarm&param=Alarm" target="_blank">Alarm Details</a>--%>
                <div style="position: sticky; top: 0px; background-color: #99fcdb; z-index: 1">
                    <a style="text-align: center; font-weight: bold; font-size: 19px; color: #a30ee3;" href="Troubleshooting.aspx?machineID=&parameterName=Alarm&param=Alarm" target="_blank">Alarm Details</a>
                </div>
                <%--              <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                        <asp:ListView runat="server" ID="lvAlarmHistoryData" ClientIDMode="Static">
                            <LayoutTemplate>
                                <table class="machine-table" style="margin: auto">
                                    <tr runat="server" id="itemplaceholder"></tr>
                                </table>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <tr>
                                    <th style="text-align: center; padding-top: 10px" class="machine-div">
                                           <asp:HiddenField runat="server" ID="hfmachineID" Value='<%# Eval("MachineID") %>' ClientIDMode="Static"/>
                                        <span style="font-size: 16px"><%# Eval("MachineID") %></span>
                                    </th>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:ListView runat="server" ID="lvAlarm" DataSource='<%# Eval("alarmDetails") %>'>
                                            <LayoutTemplate>
                                                <table class="alarm-msg-table" style="text-align: left">
                                                    <tr runat="server" id="itemplaceholder"></tr>
                                                </table>
                                            </LayoutTemplate>
                                            <ItemTemplate>
                                                <tr>
                                                    <td>
                                                        <span>
                                                            <%# Eval("AlarmMsg") %>
                                                        </span>
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:ListView>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:ListView>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="alarmInterval" EventName="Tick" />
                    </Triggers>

                </asp:UpdatePanel>--%>

                <div id="alarmDetailsDiv">
                </div>
            </div>


        </div>

        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <div id="divTimeBarContainer" runat="server" clientidmode="static" style="margin-top: 10px; display: flex; margin-left: 0%">

                    <asp:HiddenField runat="server" ID="hfStartDate" />
                    <asp:HiddenField runat="server" ID="hfLatestDateForPrev" ClientIDMode="Static" />
                    <asp:HiddenField runat="server" ID="hfLatestDateForNext" ClientIDMode="Static" />
                    <asp:HiddenField runat="server" ClientIDMode="Static" ID="hfLiveOrHistoryAlarm" />
                    <asp:HiddenField runat="server" ID="hfSeletcedDateTime" ClientIDMode="Static" />
                    <asp:HiddenField runat="server" ID="hfSelectedMachineForTroubleShoot" ClientIDMode="Static" />
                    <asp:HiddenField runat="server" ID="hfSelectedCompanyForTroubleShoot" ClientIDMode="Static" />
                    <asp:HiddenField runat="server" ID="hfSelectedPlantForTroubleShoot" ClientIDMode="Static" />
                    <div style="margin-top: 3%; padding: 10px;">
                        <asp:LinkButton runat="server" ID="lbPrevious" OnClientClick="callLoader();" OnClick="lbPrevious_Click" ToolTip="Previous" CssClass="glyphicon glyphicon-triangle-left timebar-btn"></asp:LinkButton>
                    </div>
                    <div id="timeBar" style="height: 160px; display: inline-block; width: 70%">
                    </div>
                    <div style="margin-top: 3%; padding: 10px;">
                        <asp:LinkButton runat="server" ID="lbNext" OnClientClick="callLoader();" OnClick="lbNext_Click" ToolTip="Next" CssClass="glyphicon glyphicon-triangle-right timebar-btn"></asp:LinkButton>
                    </div>
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="cbSortGYR" EventName="CheckedChanged" />
                <asp:AsyncPostBackTrigger ControlID="cbSortRYG" EventName="CheckedChanged" />
                <asp:AsyncPostBackTrigger ControlID="chkEnableGroup" EventName="CheckedChanged" />
                <asp:AsyncPostBackTrigger ControlID="cbRed" EventName="CheckedChanged" />
                <asp:AsyncPostBackTrigger ControlID="cbYellow" EventName="CheckedChanged" />
                <asp:AsyncPostBackTrigger ControlID="cbGreen" EventName="CheckedChanged" />
                <asp:AsyncPostBackTrigger ControlID="btnNoOfColumnsOk" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="btnOK" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="lbBackToLive" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="lbPrevious" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="lbNext" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="btnParticulatDateSelected" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="btnTimeClickinTimeBar" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>

        <asp:Button runat="server" ID="btnParticulatDateSelected" ClientIDMode="Static" Style="display: none" Visible="true" OnClick="btnParticulatDateSelected_Click" />
    </div>
    <asp:Button runat="server" ID="btnTimeClickinTimeBar" ClientIDMode="Static" OnClientClick="callLoader();" Style="display: none" OnClick="btnTimeClickinTimeBar_Click" />
    <div class="modal fade" id="troublrShootModal" role="dialog">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content modalContent normal-modal-content">
                <div class="modal-header modalHeader normal-modal-header">
                    <h4 class="" style="text-align: center">TroubleShoot</h4>
                </div>
                <div class="modal-body normal-modal-body">
                </div>
                <div class="modal-footer modalFooter modal-footer noraml-modal-footer">
                    <input type="button" value="OK" class="Btns" data-dismiss="modal" />
                </div>
            </div>
        </div>
    </div>


    <div class="modal fade" id="warningModal" role="dialog">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content modalContent warning-modal-content">
                <div class="modal-header modalHeader warning-modal-header">
                    <i class="glyphicon glyphicon-warning-sign modal-icons"></i>
                    <br />
                    <h4 class="warning-modal-title">Warning</h4>
                    <br />
                    <span class="warning-modal-msg" id="lblWarningMsg">Reocrd insertion failed...</span>
                </div>
                <%-- <div class="modal-body">

</div>--%>
                <div class="modal-footer modalFooter modal-footer">
                    <input type="button" value="OK" class="warning-modal-btn" data-dismiss="modal" />
                </div>
            </div>
        </div>
    </div>
    <script>
        var alarmInterval;
        var multiselctListExpand = false;
        $(document).ready(function () {
            //showViews("", "ListView");
            $('[id$=multiselectddlMachineID]').multiselect({
                includeSelectAllOption: true
            });
            $('[id$=txtFromDateTime]').datetimepicker({
                format: 'DD-MM-YYYY HH:mm:ss',
                locale: 'en-US'
            });
            $('#right-table').appendTo('#right-side-filters');
            $.unblockUI({});
            showAlarmPanel('show');

            setHightOfDivs();
            BindAlarmDetails();
            alarmInterval = setInterval(BindAlarmDetails, 10000);
        });

        function showLoader() {
            $.blockUI({ message: '<img runat="server" src="Images/Loading.gif" />' });
        }
        function printPDF(elem) {
            pdfPreview($(elem).html());

            //let printElem = document.getElementById('processParamChartViewContainer');
            // ej.base.print(printElem);

            //var chartObj = $("#processParamChartViewContainer").ejChart("instance");
            //chartObj.print("processParamChartViewContainer");


            // var mywindow = window.open('', 'PRINT', 'height=400,width=600');
            //mywindow.document.write('<html><head>');
            //mywindow.document.write("<link rel=\"stylesheet\" href=\"#PPDashboardStyle\" > <link rel=\"stylesheet\" href=\"#siteMasterStyle\" >");
            //if ($("#processParamTextViewContainer").css('display') == "block") {
            //    if ($("#mainBody").hasClass("light-mode")) {
            //        mywindow.document.write('</head><body class="light-mode" >');
            //    } else {
            //        mywindow.document.write('</head><body >');
            //    }
            //    mywindow.document.write(document.getElementById('processParamTextViewContainer').innerHTML);
            //} else {
            //    mywindow.document.write('</head><body  class="light-mode">');
            //    mywindow.document.write(document.getElementById('processParamChartViewContainer').innerHTML);
            //}
            //mywindow.document.write('</body></html>');
            //mywindow.document.close(); // necessary for IE >= 10
            //mywindow.focus(); 
            //$(mywindow).ejPrint();
            //var  obj = $(document.body).ejPrint("instance");
            // obj.print();

        }
        function pdfPreview(data) {
            // var mywindow = window.open('', 'new div', 'height=400,width=600');
            // mywindow.document.write('<html><head><title></title>');
            //// mywindow.document.write('<link rel="stylesheet" href="css/midday_receipt.css" type="text/css" />');
            // mywindow.document.write('</head><body >');
            // mywindow.document.write(data);
            // mywindow.document.write('</body></html>');
            // mywindow.document.close();
            // mywindow.focus();
            // //setTimeout(function () { mywindow.print(); }, 6000);
            // mywindow.close();
            //return true;

            var mywindow = window.open('', 'PRINT', 'height=400,width=600');

            mywindow.document.write('<html><head>');
            // mywindow.document.write("<link href=\"../lib/bootstrap/css/bootstrap.min.css\" rel=\"stylesheet\"><link href=\"../css/core.css\" rel=\"stylesheet\"><link href=\"../css/components.css\" rel=\"stylesheet\"><link href=\"../css/icons.css\" rel=\"stylesheet\">")
            //mywindow.document.write("<link href=\"../Scripts/StyleSheet1.css\" rel=\"stylesheet\">");

            mywindow.document.write("<link rel=\"stylesheet\" href=\"#PPDashboardStyle\" > <link rel=\"stylesheet\" href=\"#siteMasterStyle\" >");
            //if ($("#mainBody").hasClass("light-mode")) {
            //     mywindow.document.write('</head><body class="light-mode" >');
            //} else {
            //     mywindow.document.write('</head><body >');
            //}

            if ($("#processParamTextViewContainer").css('display') == "block") {
                if ($("#mainBody").hasClass("light-mode")) {
                    mywindow.document.write('</head><body class="light-mode" >');
                } else {
                    mywindow.document.write('</head><body >');
                }
                mywindow.document.write(document.getElementById('processParamTextViewContainer').innerHTML);
            } else {
                mywindow.document.write('</head><body  class="light-mode">');
                mywindow.document.write(document.getElementById('processParamChartViewContainer').innerHTML);
            }

            mywindow.document.write('</body></html>');

            mywindow.document.close(); // necessary for IE >= 10
            mywindow.focus(); // necessary for IE >= 10*/


            setTimeout(function () {
                mywindow.print();
                mywindow.close();
            }, 1000);
            return true;
        }
        $(".filter-checkbox").change(function () {
            debugger;
            //alert();
            //  showLoader();
            let setvalue = $(this).children().prop('checked');
            $(".filter-checkbox input").prop("checked", false);
            $(".rgb-filter input").prop("checked", false);
            //if (setvalue) {
            //    $(this).children().prop('checked', false);
            //} else{
            $(this).children().prop('checked', setvalue);
            // }
            // $(".filter-checkbox > input").css({ "background-color": "black" })
            //if ($(this).prop('checked')) {
            //    $(this).prop('chekced', tr
            //    )
            //}
        });
        $(".rgb-filter").change(function () {
            //  showLoader();
            $(".filter-checkbox input").prop("checked", false);
        });
        function showViews(element, param) {

            if (param == "MeterView") {
                $('.cardView').css('display', 'block');
                $('.listView').css('display', 'none');
                $("#hdView").val("MeterView");
            } else {
                $('.listView').css('display', 'block');
                $('.cardView').css('display', 'none');
                $("#hdView").val("ListView");
            }
        }
        function showPanelFilter(element, panelid, rightvalue, topvalue, ulid) {
            $("#divDashboardFilter").css('display', 'block');
            document.getElementById(panelid).style.visibility = "visible";
            $("#" + panelid).css({ 'right': rightvalue, 'top': topvalue });
        }
        function hidePanel(panelid) {
            document.getElementById(panelid).style.visibility = "hidden";
        }

        function showTroubleShootSolutions(element, paramID) {
            debugger;
            //  $.blockUI({ message: '<img runat="server" src="Images/Loading.gif" />' });
            var machine = $(element).closest('.machine-div').find('#hfmachineID').val();
            var parameter = $(element).closest('.main-div').find('#' + paramID + '').val();
            // location.href = "Troubleshooting.aspx?machineID=" + machine + "&parameterName=" + parameter + "&param=ProcessParameter";
            let a = document.createElement('a');
            a.target = '_blank';
            a.href = "Troubleshooting.aspx?machineID=" + machine + "&parameterName=" + parameter + "&param=ProcessParameter";
            a.click();
            // alert(machine + parameter);
            // $('[id*=troublrShootModal]').modal('show');
            return false;
        }
        function showAlarmPanel(param) {
            if (param == 'show') {
                $('#contentDiv').css({ 'width': '79%', 'display': 'inline-block' });
                $('#alarmDiv').css({ 'width': '20%', 'display': 'inline-block' });
                $("#btnShow").css({ 'display': 'none' });
                $("#btnHide").css({ 'display': 'block' });
            } else {
                $('#contentDiv').css({ 'width': 'unset', 'display': 'inline-block' });
                $('#alarmDiv').css({ 'width': '20%', 'display': 'none' });
                $("#btnShow").css({ 'display': 'block' });
                $("#btnHide").css({ 'display': 'none' });
            }
        }
        function callLoader() {
            $.blockUI({ message: '<img runat="server" src="Images/Loading.gif" />' });
            hidePanel('panelFilter');
        }

        function searchParameters() {
            let searchtxt = $("#txtSearchParameters").val();
            for (let i = 0; i < $("[id*=cbParameterList] tr td").length; i++) {
                let td = $("[id*=cbParameterList] tr td")[i];
                let labeltxt = $(td).find('label').text();
                let inputtxt = $(td).find('input').val();
                if (labeltxt.toLowerCase().includes(searchtxt.toLowerCase())) {
                    //$(td).css({ 'display': 'inline-block' });
                    $(td).css({ 'display': 'table-cell', 'vertical-align': 'inherit' });
                } else {
                    $(td).css({ 'display': 'none' });
                }
            }
        }
        function selctAllParameters() {
            if ($("#cbSelectAll").prop('checked')) {
                for (let i = 0; i < $("[id*=cbParameterList] tr input").length; i++) {
                    let checkBox = $("[id*=cbParameterList] tr input")[i];
                    $(checkBox).prop('checked', true);
                }
            } else {
                for (let i = 0; i < $("[id*=cbParameterList] tr input").length; i++) {
                    let checkBox = $("[id*=cbParameterList] tr input")[i];
                    $(checkBox).prop('checked', false);
                }
            }
        }

        function selctAllParametersWhenChange() {

            let totalCheck = 0;
            for (let i = 0; i < $("[id*=cbParameterList] tr input").length; i++) {
                let checkBox = $("[id*=cbParameterList] tr input")[i];
                if ($(checkBox).prop('checked')) {
                    totalCheck++;
                }
            }
            if (totalCheck == $("[id*=cbParameterList] tr input").length) {
                $("#cbSelectAll").prop('checked', true);;
            } else {
                $("#cbSelectAll").prop('checked', false);;
            }
        }
        function setHightOfDivs() {
            if ($('#divTimeBarContainer').length >= 1) {
                $("#processParamTextViewContainer").css('height', '70vh');
                $("#processParamChartViewContainer").css('height', '70vh');
                $("#alarmDiv").css('height', '70vh');
                $("#divTimeBarContainer").css('height', '160px');
            } else {
                $("#processParamTextViewContainer").css('height', '86vh');
                $("#processParamChartViewContainer").css('height', '86vh');
                $("#alarmDiv").css('height', '86vh');
                // $("#divTimeBarContainer").css('height', '200px');
            }
        }
        //$(".multiselect-container li").click(function () {

        //});
        function stayMultiselectedList() {
            //$(".btn-group").addClass('open');
            multiselctListExpand = true;
            //$(".multiselect").attr('aria-expanded', true);
            //   $(".multiselect-container").css({'display': 'block'});
        }
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {

            $(document).ready(function () {
                $('[id$=multiselectddlMachineID]').multiselect({
                    includeSelectAllOption: true
                });
                $('[id$=txtFromDateTime]').datetimepicker({
                    format: 'DD-MM-YYYY HH:mm:ss',
                    locale: 'en-US'
                });
                // alert($("#hdView").val());
                // showViews("", "ListView");
                showViews("", $("#hdView").val());
                //BindCharts();
                setHightOfDivs();
                //clearInterval(alarmInterval);
                //alarmInterval = setInterval(BindAlarmDetails, 10000);
                selctAllParametersWhenChange();
                if (multiselctListExpand) {
                    $(".btn-group").addClass('open');
                } else {
                    $(".btn-group").removeClass('open');
                }
                multiselctListExpand = false;
            });
            //$(".multiselect-container li").click(function () {
            //     debugger;
            //    $(".multiselect-container").css({ 'display': 'block'});
            //});
            function hidePanel(panelid) {
                document.getElementById(panelid).style.visibility = "hidden";
            }
            function showViews(element, param) {
                if (param == "MeterView") {
                    $('.cardView').css('display', 'block');
                    $('.listView').css('display', 'none');
                    $("#hdView").val("MeterView");
                } else {
                    $('.listView').css('display', 'block');
                    $('.cardView').css('display', 'none');
                    $("#hdView").val("ListView");
                }
            }
            function showPanelFilter(element, panelid, rightvalue, topvalue, ulid) {
                $("#divDashboardFilter").css('display', 'block');
                document.getElementById(panelid).style.visibility = "visible";
                $("#" + panelid).css({ 'right': rightvalue, 'top': topvalue });
            }
            $(".filter-checkbox").change(function () {
                debugger;
                //alert();
                //  showLoader();
                let setvalue = $(this).children().prop('checked');
                $(".filter-checkbox input").prop("checked", false);
                $(".rgb-filter input").prop("checked", false);
                //if (setvalue) {
                //    $(this).children().prop('checked', false);
                //} else{
                $(this).children().prop('checked', setvalue);
                //}

                //if ($(this).prop('checked')) {
                //    $(this).prop('chekced', tr
                //    )
                //}
            });
            $(".rgb-filter").change(function () {
                $(".filter-checkbox input").prop("checked", false);
            });

            function printPDF(elem) {
                pdfPreview($(elem).html());
            }
            function pdfPreview(data) {
                // var mywindow = window.open('', 'new div', 'height=400,width=600');
                // mywindow.document.write('<html><head><title></title>');
                //// mywindow.document.write('<link rel="stylesheet" href="css/midday_receipt.css" type="text/css" />');
                // mywindow.document.write('</head><body >');
                // mywindow.document.write(data);
                // mywindow.document.write('</body></html>');
                // mywindow.document.close();
                // mywindow.focus();
                // //setTimeout(function () { mywindow.print(); }, 6000);
                // mywindow.close();
                //return true;

                var mywindow = window.open('', 'PRINT', 'height=400,width=600');

                mywindow.document.write('<html><head>');
                // mywindow.document.write("<link href=\"../lib/bootstrap/css/bootstrap.min.css\" rel=\"stylesheet\"><link href=\"../css/core.css\" rel=\"stylesheet\"><link href=\"../css/components.css\" rel=\"stylesheet\"><link href=\"../css/icons.css\" rel=\"stylesheet\">")
                //mywindow.document.write("<link href=\"../Scripts/StyleSheet1.css\" rel=\"stylesheet\">");

                mywindow.document.write("<link rel=\"stylesheet\" href=\"#PPDashboardStyle\" > <link rel=\"stylesheet\" href=\"#siteMasterStyle\" >");
                //if ($("#mainBody").hasClass("light-mode")) {
                //     mywindow.document.write('</head><body class="light-mode" >');
                //} else {
                //     mywindow.document.write('</head><body >');
                //}

                if ($("#processParamTextViewContainer").css('display') == "block") {
                    if ($("#mainBody").hasClass("light-mode")) {
                        mywindow.document.write('</head><body class="light-mode" >');
                    } else {
                        mywindow.document.write('</head><body >');
                    }
                    mywindow.document.write(document.getElementById('processParamTextViewContainer').innerHTML);
                } else {
                    mywindow.document.write('</head><body  class="light-mode">');
                    mywindow.document.write(document.getElementById('processParamChartViewContainer').innerHTML);
                }

                mywindow.document.write('</body></html>');

                mywindow.document.close(); // necessary for IE >= 10
                mywindow.focus(); // necessary for IE >= 10*/


                setTimeout(function () {
                    mywindow.print();
                    mywindow.close();
                }, 1000);
                return true;
            }
            function showTroubleShootSolutions(element) {
                $('[id*=troublrShootModal]').modal('show');
                return false;
            }

            function showAlarmPanel(param) {
                if (param == 'show') {
                    $('#contentDiv').css({ 'width': '79%', 'display': 'inline-block' });
                    $('#alarmDiv').css({ 'width': '20%', 'display': 'inline-block' });
                    $("#btnShow").css({ 'display': 'none' });
                    $("#btnHide").css({ 'display': 'block' });
                } else {
                    $('#contentDiv').css({ 'width': 'unset', 'display': 'inline-block' });
                    $('#alarmDiv').css({ 'width': '20%', 'display': 'none' });
                    $("#btnShow").css({ 'display': 'block' });
                    $("#btnHide").css({ 'display': 'none' });
                }
            }
        });

        // kavya
        //function showPanelFilter(element, panelid, rightvalue, topvalue, ulid) {
        //    document.getElementById(panelid).style.visibility = "visible";
        //    $("#" + panelid).css({ 'right': rightvalue, 'top': topvalue });
        //}
        function showFilterSubItems(element, lisubitems, arrowid) {
            if ($('#' + lisubitems).css('display') == "none") {
                $(".main-filter").css({ 'border-top': 'unset', 'border-bottom': 'unset' });
                $(element).css({ 'border-top': '1px solid #dfdfdfcf', 'border-bottom': '1px solid #dfdfdfcf' });
                $(".sub-filters").css({ 'display': 'none' });
                $('#' + lisubitems).css({ 'display': 'block' });
                //$('#' + lisubitems).closest('div').find('#' + arrowid).removeClass().addClass("main-filter-updownarrow");
                //$('#' + lisubitems).closest('div').find('.main-filter-updownarrow').addClass('glyphicon glyphicon-menu-up');
                $('.main-filter-updownarrow').removeClass("glyphicon glyphicon-menu-up").addClass("glyphicon glyphicon-menu-down");
                $('#' + lisubitems).closest('div').find('#' + arrowid).addClass('glyphicon glyphicon-menu-up');
            } else {
                $(".main-filter").css({ 'border-top': 'unset', 'border-bottom': 'unset' });
                $(".sub-filters").css({ 'display': 'none' });
                $('.main-filter-updownarrow').removeClass('glyphicon glyphicon-menu-up').addClass("glyphicon glyphicon-menu-down");
                // $('.main-filter-updownarrow').addClass("glyphicon glyphicon-menu-down");
                //$('#' + lisubitems).css('display', 'none');
                //$('#' + lisubitems).closest('div').find('.main-filter-updownarrow').removeClass().addClass("main-filter-updownarrow");
                //$('#' + lisubitems).closest('div').find('.main-filter-updownarrow').addClass('glyphicon glyphicon-menu-down');
            }
        }
        function BindCharts() {
            debugger;
            //  alert("BIND");
            $("#processParamTextViewContainer").css('height', '0vh');
            $("#processParamChartViewContainer").css('height', '0vh');
            let noOfTbls = $('#processParamChartViewContainer .template1').length;
            for (let i = 0; i < noOfTbls; i++) {
                let minValue = 0, maxValue = 0, actualValue = 0;
                let chartType = "", containerID = "";
                var tbl = $('#processParamChartViewContainer .template1')[i];
                minValue = $(tbl).find('#hdnMinValue').val();
                maxValue = $(tbl).find('#hdnMaxValue').val();
                actualValue = $(tbl).find('#hdnActualValue').val();
                chartType = $(tbl).find('#hdnChartType').val().toLowerCase();
                containerID = $(tbl).find('.chartDiv').prop('id');
                if (chartType == "ampere") {
                    bindBarChart(parseFloat(minValue), parseFloat(maxValue), parseFloat(actualValue), containerID);
                }
                else if (chartType == "celsius") {

                    bindTempCharts(parseFloat(minValue), parseFloat(maxValue), parseFloat(actualValue), containerID);
                }
                else if (chartType == "liters") {

                    bindLiterCharts(parseFloat(minValue), parseFloat(maxValue), parseFloat(actualValue), containerID);
                }
                else {

                    bindGuageCharts(parseFloat(minValue), parseFloat(maxValue), parseFloat(actualValue), containerID);
                    // bindSynGauageChart(parseFloat(minValue), parseFloat(maxValue), parseFloat(actualValue), containerID);
                }
            }
            // bindTempCharts(0, 100, 40);
            // bindLiterCharts(20, 40, 30);
            // bindGuageCharts(10, 12, 11);
            // bindBarChart(2, 4, 3);
        }

        function noOfcolumnValidation() {
            debugger;
            if ($('#txtNoOfColumns').val().trim() == "") {
                // alert("Please enter number of column");
                openWarningModal("Please enter number of column");
                return false;
            }
            if ($('#txtNoOfColumns').val().trim() == "0") {
                //  alert("Please enter valid number of column");
                openWarningModal("Please enter valid number of column");
                return false;
            }
            $('#hdnNoOfColumns').val($('#txtNoOfColumns').val());
            callLoader();
            return true;
        }
        function bindBarChart(minvalue, maxvalue, actualvalue, containerid) {
            // Set up the chart
            var chart = new Highcharts.Chart({
                chart: {
                    renderTo: containerid,
                    type: 'column',
                    //backgroundColor: '#32383d',
                    //plotBackgroundColor: '#32383d',
                    //width: 320,
                    //height: 320
                    height: 200,
                    width: 280
                },
                title: {
                    text: ''
                },
                subtitle: {
                    text: ''
                },
                exporting: {
                    enabled: false
                },
                legend: {
                    enabled: false
                },
                credits: {
                    enabled: false
                },
                yAxis: {
                    //min: minvalue,
                    //max: maxvalue
                    title: {
                        text: ""
                    },
                    //labels: {
                    //    style: {
                    //        color: 'white',
                    //        fontSize: '19px'
                    //    }
                    //}
                    className: 'highchart-xyaxis-label',
                    gridLineWidth: 0,
                    plotLines: [{
                        value: minvalue,
                        color: 'red',
                        // dashStyle: 'shortdash',
                        width: 1,
                        label: {
                            text: minvalue,
                            style: {
                                color: 'red'
                            }
                        }
                    }, {
                        value: maxvalue,
                        color: 'red',
                        //  dashStyle: 'shortdash',
                        width: 1,
                        label: {
                            text: maxvalue,
                            style: {
                                color: 'red'
                            }
                        }
                    }]
                },
                xAxis: {
                    labels: {
                        enabled: false
                    },
                    lineColor: '#ede8e8'
                    // lineColor: 'blue'
                },

                plotOptions: {
                    column: {
                        depth: 25,
                        pointWidth: 50,
                        shadow: true,
                        borderRadius: 5
                    }
                },
                series: [{
                    data: [actualvalue],
                    //color: 'deeppink'
                    color: 'blue'
                }]
            });
        }
        function bindGuageCharts(minvalue, maxvalue, actualvalue, containerid) {
            $("#" + containerid).dxCircularGauge({
                size: {
                    height: 200,
                    width: 280
                },
                scale: {
                    startValue: 0,
                    endValue: 320,
                    //tickInterval: 10,
                    label: {
                        // useRangeColors: true,
                        font: { size: 19, color: '#8c8c8c' }
                    }
                },
                valueIndicator: {
                    type: "triangleNeedle", //rectangleNeedle
                    color: "blue",
                    size: 30,
                    spindleSize: 25,
                    width: 13
                },
                subvalues: [minvalue, maxvalue, actualvalue],
                //subvalueIndicator: {
                // type: "triangleMarker",
                // color: "red"
                //},
                subvalueIndicator: {
                    type: "textCloud",
                    color: "blue",
                    palette: ["red", "red", "blue"]
                },
                //rangeContainer: {
                // palette: "pastel",
                // //ranges: range
                //},
                title: {
                    text: "",
                    font: { size: 28, color: 'red' }
                },
                "export": {
                    enabled: false
                },
                value: actualvalue
            });

        }
        function bindLiterCharts(minvalue, maxvalue, actualvalue, containerid) {
            $("#" + containerid).dxLinearGauge({
                size: {
                    //height: 320,
                    //width: 320
                    height: 200,
                    width: 280
                },
                geometry: { orientation: "vertical" },
                scale: {
                    //startValue: minvalue,
                    //endValue: maxvalue,
                    //customTicks: [0, 10, 25, 50]
                    label: {
                        font: { color: '#8c8c8c', size: 19 }
                    }
                },
                valueIndicator: {
                    baseValue: 0,
                    backgroundColor: 'gray',
                    color: 'blue',
                    size: 20
                },
                title: {
                    text: "",
                    font: { size: 28 }
                },
                "export": {
                    enabled: false
                },
                value: actualvalue
            });
        }
        function bindTempCharts(minvalue, maxvalue, actualvalue, containerid) {
            // alert();
            $("#" + containerid).ejLinearGauge({
                //height: 320,
                //width: 320,
                height: 195,
                width: 280,
                labelColor: "#8c8c8c",
                //className: 'highchart-xyaxis-label',
                enableAnimation: false,
                //animationSpeed: 1000,
                //   printMode: true,
                scales: [{

                    type: "thermometer",
                    backgroundColor: "gray",
                    //minimum: minvalue,
                    //maximum: maxvalue,
                    labelColor: "red",
                    enableAnimation: false,
                    minorIntervalValue: 10,
                    // intervalValue: 20,
                    // ticksInterval: 20,
                    // tickInterval: 20,
                    majorIntervalValue: 20,
                    width: 30,
                    position: { x: 50, y: 18 },
                    length: 170,
                    border: { width: 2, color: '#206BA4' },
                    //markerPointers: [{ opacity: 0 }],
                    markerPointers: [{
                        width: 20,
                        length: 20,
                        //backgroundColor: "Grey",
                        //distanceFromScale: -12,
                        backgroundColor: "blue",
                        //distanceFromScale: 20,
                        placement: "far",
                        value: actualvalue,
                    },
                    {
                        width: 15,
                        length: 15,
                        //backgroundColor: "Grey",
                        //distanceFromScale: -12,
                        backgroundColor: "red",
                        //distanceFromScale: 20,
                        placement: "far",
                        value: minvalue,
                    },
                    {
                        width: 15,
                        length: 15,
                        //backgroundColor: "Grey",
                        //distanceFromScale: -12,
                        backgroundColor: "red",
                        //distanceFromScale: 20,
                        placement: "far",
                        value: maxvalue,
                    }
                    ],
                    barPointers: [{
                        width: 15,
                        // distanceFromScale: -0.5,
                        value: actualvalue,
                        backgroundColor: "blue"
                    }],
                    labels: [{
                        placement: "near",
                        textColor: 'gray',
                        // className: 'highchart-xyaxis-label',
                        font: {
                            size: "15px", fontStyle: 'Normal'
                        },
                        distanceFromScale: { x: -15 },
                        // color: "red"

                    }
                        //,
                        //{
                        // placement: "far",
                        // distanceFromScale: { x: 20 }
                        // }
                    ],
                    ticks: [{
                        type: "majorinterval", width: 2,
                        color: "#035da1",
                        //distanceFromScale: { x: -27, y: 0 },
                        placement: "near"
                    },
                    {
                        type: "minorinterval", width: 1, height: 6,
                        color: "#206BA4",
                        //distanceFromScale: { x: -27, y: 0 },
                        placement: "near"
                    }]
                    //drawLabels: function () {
                    //    var args = $("#"+containerid).data("ejLinearGauge");
                    //    if (args.label.index == 1) {
                    //        args.style.textValue = (args.label.value * (9 / 5)) + 32;
                    //        args.style.font = "Normal 10px Segoe UI";
                    //    }
                    //}

                }],
                // drawLabels: "DrawLabel"
                //drawCustomLabel: "DrawCustomLabel",
                //drawLabels: "DrawLabel"

            });
        }

        function bindSynGauageChart(minvalue, maxvalue, actualvalue, containerid) {
            $("#" + containerid).ejCircularGauge({
                height: 195,
                width: 280,
                backgroundColor: "#454545",
                readOnly: false,
                radius: 98,
                scales: [{
                    radius: 96,
                    showRanges: true,
                    size: 0,
                    // showIndicators: true,
                    pointerCap: {
                        radius: 8,
                        borderWidth: 0,
                        backgroundColor: "#9c9a9a",
                        borderColor: "#9c9a9a"
                    },
                    maximum: 200,
                    majorIntervalValue: 20,
                    minorIntervalValue: 5,

                    labels: [{
                        color: "#ffffff"
                    }],

                    pointers: [
                        //{
                        //    value: 140,
                        //    distanceFromScale: 60,
                        //    showBackNeedle: false,
                        //    length: 20,
                        //    type: "marker",
                        //    markerType: "triangle",
                        //    width: 10,
                        //    radius: 10,
                        //    backgroundColor: "#FF940A",
                        //    border: {
                        //        color: "#FF940A"
                        //    },
                        //},
                        // {
                        //    value: minvalue,
                        //     showBackNeedle: false,
                        //     length: 40,
                        //     width: 8,
                        //     radius: 5,
                        //     backgroundColor: "red",
                        //     border: {
                        //         color: "red"
                        //     },
                        //},
                        //{
                        //    value: maxvalue,
                        //    showBackNeedle: false,
                        //    length: 40,
                        //    width: 8,
                        //    radius: 5,
                        //    backgroundColor: "red",
                        //    border: {
                        //        color: "red"
                        //    },
                        //},
                        //{
                        //    value: actualvalue,
                        //     showBackNeedle: false,
                        //     length: 55,
                        //     width: 2,
                        //     radius: 10,
                        //     needleType: "rectangle",
                        //     backgroundColor: "blue",
                        //     border: {
                        //         color: "blue"
                        //     },
                        // },


                        {
                            value: minvalue,
                            showBackNeedle: false,
                            length: 40,
                            width: 1,
                            radius: 10,
                            needleType: "rectangle",
                            backgroundColor: "red",
                            border: {
                                color: "red"
                            },
                        },
                        {
                            value: maxvalue,
                            showBackNeedle: false,
                            length: 40,
                            width: 1,
                            radius: 10,
                            needleType: "rectangle",
                            backgroundColor: "red",
                            border: {
                                color: "red"
                            },
                        },
                        {
                            value: actualvalue,
                            showBackNeedle: false,
                            length: 67,
                            width: 14,
                            radius: 7,
                            backgroundColor: "blue",
                            border: {
                                color: "blue"
                            },
                        },

                    ],

                    ticks: [{
                        type: "major",
                        distanceFromScale: 40,
                        height: 10,
                        width: 3,
                        color: "#ffffff"
                    }, {
                        type: "minor",
                        height: 4,
                        width: 1,
                        distanceFromScale: 40,
                        color: "#ffffff"
                    }],


                    ranges: [
                        {
                            distanceFromScale: -5,
                            startValue: 0,
                            endValue: 200,
                            //backgroundColor: "#f7e700",
                            //border: {
                            //    color: "#FFFFFF"
                            //},
                            //backgroundColor: "#0277cf",
                            //    border: {
                            //        color: "#035da1"
                            //    },
                            backgroundColor: "#18c0de",
                            border: {
                                color: "#18c0de"
                            },

                        },
                        //{
                        //    distanceFromScale: 30,
                        //    startValue: 70,
                        //    endValue: 140,
                        //    backgroundColor: "#F6FF0A",
                        //    border: {
                        //        color: "#FFFFFF"
                        //    },
                        //},
                        //{
                        //    distanceFromScale: 30,
                        //    startValue: 140,
                        //    endValue: 200,
                        //    backgroundColor: "#FF1807",
                        //    border: {
                        //        color: "#FFFFFF"
                        //    },
                        //}
                    ],
                }]

                //   theme : "flatlight"
                //     maximum: 120,
                //minimum: 10,
                //value: 30,
                //   height: 500,
                //width: 500,
                //backgroundColor: "gray",
                //readOnly: false,
                // distanceFromCorner :25,
                //         interiorGradient: { colorInfo:[{colorStop : 0, color:"#FFFFFF"},{colorStop : 1, color:"#AAAAAA"}] },
                //isRadialGradient : true,
                //enableResize: true,
                //  isResponsive: true,          
                //radius: 70,
                //scales: [{
                //   // radius: 30,
                //    showRanges: true,
                //    showIndicators: true,
                //    pointerCap: {
                //        radius: 15,
                //        borderWidth: 0,
                //        backgroundColor: "#797C79",
                //        borderColor: "#797C79"
                //    },
                //    maximum: 200,
                //    majorIntervalValue: 20,
                //    minorIntervalValue: 5,

                //    labels: [{
                //        color: "#ffffff"
                //    }],
                //    pointers: [{
                //        value: 140,
                //        distanceFromScale: 60,
                //        showBackNeedle: false,
                //        length: 20,
                //        type: "marker",
                //        markerType: "triangle",
                //        width: 10,
                //        radius: 10,
                //        backgroundColor: "#FF940A",
                //        border: {
                //            color: "#FF940A"
                //        },
                //    },
                //    {
                //        value: 110,
                //        showBackNeedle: false,
                //        length: 150,
                //        width: 2,
                //        radius: 10,
                //        needleType: "rectangle",
                //        backgroundColor: "#05AFFF",
                //        border: {
                //            color: "#05AFFF"
                //        },
                //        }, {
                //            value: 67,
                //            showBackNeedle: false,
                //            length: 100,
                //            width: 15,
                //            radius: 10,
                //            backgroundColor: "#FC5D07",
                //            border: {
                //                color: "#FC5D07"
                //            },
                //        }],


                //    //ticks: [{
                //    //    type: "major",
                //    //    distanceFromScale: 70,
                //    //    height: 20,
                //    //    width: 3,
                //    //    color: "#ffffff"
                //    //}, {
                //    //    type: "minor",
                //    //    height: 12,
                //    //    width: 1,
                //    //    distanceFromScale: 70,
                //    //    color: "#ffffff"
                //    //}],

                //    //ranges: [{
                //    //    distanceFromScale: 30,
                //    //    startValue: 0,
                //    //    endValue: 70,
                //    //    backgroundColor: "#5DF243",
                //    //    border: {
                //    //        color: "#FFFFFF"
                //    //    },
                //    //}, {
                //    //    distanceFromScale: 30,
                //    //    startValue: 70,
                //    //    endValue: 140,
                //    //    backgroundColor: "#F6FF0A",
                //    //    border: {
                //    //        color: "#FFFFFF"
                //    //    },
                //    //},
                //    //{
                //    //    distanceFromScale: 30,
                //    //    startValue: 140,
                //    //    endValue: 200,
                //    //    backgroundColor: "#FF1807",
                //    //    border: {
                //    //        color: "#FFFFFF"
                //    //    },
                //    //}],


                //    //indicators: [
                //    //    {
                //    //        height: 10,
                //    //        width: 10,
                //    //        type: "circle",
                //    //        position: { x: 210, y: 300 },
                //    //        stateRanges: [{
                //    //            endValue: 70,
                //    //            startValue: 0,
                //    //            backgroundColor: "#5DF243",
                //    //            borderColor: "#5DF243",
                //    //            text: "",
                //    //            textColor: "#870505"
                //    //        }, {
                //    //            endValue: 200,
                //    //            startValue: 70,
                //    //            backgroundColor: "#145608",
                //    //            borderColor: "#145608",
                //    //            text: "",
                //    //            textColor: "#870505"
                //    //        }]
                //    //    },
                //    //    {
                //    //        height: 10,
                //    //        width: 10,
                //    //        type: "circle",
                //    //        position: { x: 255, y: 200 },
                //    //        stateRanges: [{
                //    //            endValue: 140,
                //    //            startValue: 70,
                //    //            backgroundColor: "#F6FF0A",
                //    //            borderColor: "#F6FF0A",
                //    //            text: "",
                //    //        }, {
                //    //            endValue: 70,
                //    //            startValue: 0,
                //    //            backgroundColor: "#969B0C",
                //    //            borderColor: "#969B0C",
                //    //            text: "",
                //    //        }, {
                //    //            endValue: 200,
                //    //            startValue: 140,
                //    //            backgroundColor: "#969B0C",
                //    //            borderColor: "#969B0C",
                //    //            text: "",
                //    //        }]
                //    //    }, {
                //    //        height: 10,
                //    //        width: 10,
                //    //        type: "circle",
                //    //        position: { x: 300, y: 300 },
                //    //        stateRanges: [{
                //    //            endValue: 140,
                //    //            startValue: 0,
                //    //            backgroundColor: "#890F06",
                //    //            borderColor: "#890F06",
                //    //            text: "",
                //    //        },
                //    //        {
                //    //            endValue: 200,
                //    //            startValue: 140,
                //    //            backgroundColor: "#FF1807",
                //    //            borderColor: "#FF1807",
                //    //            text: "",
                //    //        }]
                //    //    }],
                //    //customLabels: [{
                //    //    value: "Safe",
                //    //    position: { x: 200, y: 280 },
                //    //    color: "#5DF243",
                //    //    font:
                //    //    {
                //    //        size: "12px",
                //    //        fontFamily: "Arial",
                //    //        fontStyle: "Bold"
                //    //    }
                //    //}, {
                //    //    value: "Caution",
                //    //    position: { x: 253, y: 212 },
                //    //    color: "#F6FF0A",
                //    //    font:
                //    //    {
                //    //        size: "12px",
                //    //        fontFamily: "Arial",
                //    //        fontStyle: "Bold"
                //    //    }
                //    //}, {
                //    //    value: "Danger",
                //    //    position: { x: 290, y: 280 },
                //    //    color: "#FF1807",
                //    //    font:
                //    //    {
                //    //        size: "12px",
                //    //        fontFamily: "Arial",
                //    //        fontStyle: "Bold"
                //    //    }
                //    //}]
                //}]

            });
        }

        function BindTimeBar() {
            $.ajax({
                async: false,
                type: "POST",
                url: '<%= ResolveUrl("ProcessParameterDashboard.aspx/getTimeChartData") %>',
                contentType: "application/json; charset=utf-8",
                crossDomain: true,
                //  data: '',
                dataType: "json",
                success: function (response) {
                    dataitem = response.d;
                    Highcharts.stockChart('timeBar', {
                        chart: {
                        },
                        credits: {
                            enabled: false
                        },
                        navigator: {
                            height: 20
                        },
                        exporting: {
                            enabled: false
                        },
                        rangeSelector: {
                            enabled: false,
                            selected: 0,
                            inputEnabled: false,
                            buttonTheme: {
                                visibility: 'hidden'
                            },
                            labelStyle: {
                                visibility: 'hidden'
                            }
                        },

                        title: {
                        },

                        tooltip: {
                        },
                        xAxis: {
                            className: 'highchart-xyaxis-label',
                        },
                        legend: {
                        },
                        plotOptions: {
                            series: {
                                cursor: 'pointer',
                                point: {
                                    events: {
                                        click: function () {
                                            let xvalue = this.category;
                                            let yvalue = this.y;
                                            $("#hfSeletcedDateTime").val(xvalue);
                                            callLoader();
                                            __doPostBack('<%= btnTimeClickinTimeBar.UniqueID%>', '');
                                            //BindParametersForSelectedDatetime(xvalue);
                                          <%--  __doPostBack('<%= btnParticulatDateSelected.UniqueID%>', '');--%>
                                        }
                                    }
                                }
                            },
                        },
                        yAxis: {
                            gridLineWidth: 0,
                        },

                        series: [

                            {
                                name: '',
                                data: dataitem.data,
                                id: 'dataseries',
                                color: 'green'
                                // the event marker flags
                            }
                        ]
                    });
                    $("#timeBar").animate({ scrollTop: 200 }, 1000);
                },
                error: function (Result) {
                    alert("Error" + Result);
                }
            });

        }
        function BindParametersForSelectedDatetime(xvalue) {
            xvalue = $("#hfSeletcedDateTime").val();
            //   alert(xvalue);
            if (xvalue != "" && xvalue != undefined) {
                $.ajax({
                    async: false,
                    type: "POST",
                    url: '<%= ResolveUrl("ProcessParameterDashboard.aspx/getDatetime") %>',
                    contentType: "application/json; charset=utf-8",
                    crossDomain: true,
                    data: '{UpdatedTS: "' + xvalue + '"}',
                    dataType: "json",
                    success: function (response) {
                        var dataitem = response.d;
                        debugger;

                        for (let i = 0; i < $("#processParamTextViewContainer").find(".main-div").length; i++) {
                            let mainDiv = $("#processParamTextViewContainer").find(".main-div")[i];
                            let date = $(mainDiv).find("#hfUpdatedTS").val();
                            //  alert(date + "   " + dataitem);
                            if (date == dataitem) {
                                $(mainDiv).css('display', 'inline-block');
                            } else {
                                $(mainDiv).css('display', 'none');
                            }
                        }

                        for (let i = 0; i < $("#processParamChartViewContainer").find(".main-div-table-shadow").length; i++) {
                            let mainDiv = $("#processParamChartViewContainer").find(".main-div-table-shadow")[i];
                            let date = $(mainDiv).find("#hfUpdatedTS").val();
                            if (date == dataitem) {
                                $(mainDiv).css('display', 'inline-block');
                            } else {
                                $(mainDiv).css('display', 'none');
                            }
                        }
                    },
                    error: function (Result) {
                        alert("Error" + Result);
                    }
                });
            }
        }


    <%--    function BindAlarmDetails() {

            let machineNames = "";
            for (let i = 1; i < $("#multiselectddlMachineID").closest('td').find("ul li input").length; i++) {
                let machine = $("#multiselectddlMachineID").closest('td').find("ul li input")[i];
                if ($(machine).prop('checked')) {
                    if (machineNames == "") {
                        machineNames = "['" + $(machine).val() + "'";
                    } else {
                        machineNames = machineNames + ",'" + $(machine).val() + "'";
                    }
                }
            }
            if (machineNames != "") {
                machineNames += "]";
            }
            else {
                machineNames = "['']";
            }
            $.ajax({
                async: false,
                type: "POST",
                url: '<%= ResolveUrl("ProcessParameterDashboard.aspx/bindAlarmDetails") %>',
                contentType: "application/json; charset=utf-8",
                crossDomain: true,
                data: '{machineNames: "' + machineNames + '"}',
                dataType: "json",
                success: function (response) {
                    dataitem = response.d;
                    debugger;
                    $("#alarmDetailsDiv").empty();
                    var appendStr = '<table  class="machine-table" style="margin: auto">';
                    for (let i = 0; i < dataitem.length; i++) {
                        appendStr += '<tr><th  style="text-align: center; padding-top: 10px" class="machine-div">  <span style="font-size: 16px; font-weight: bold">' + dataitem[i].MachineID + '</span></th></tr>';
                        appendStr += '<tr><td>  <table class="alarm-msg-table" style="text-align: left">';
                        for (let j = 0; j < dataitem[i].alarmDetails.length; j++) {
                            appendStr += '<tr><td><span>' + dataitem[i].alarmDetails[j].AlarmMsg + ' </span></td></tr>';
                        }
                        appendStr += '</table>';
                    }
                    appendStr += '</table>';
                    $('#alarmDetailsDiv').append(appendStr);
                },
                error: function (Result) {
                    alert("Error" + Result);
                }
            });
        }--%>
        function openWarningModal(msg) {
            $('#warningModal').modal('show');
            $('#lblWarningMsg').text(msg);
        }

        function clearAlarmInterval() {
            //alert();
            clearInterval(alarmInterval);
        }
        function enableAlarmInterval() {
            BindAlarmDetails();
            alarmInterval = setInterval(BindAlarmDetails, 10000);
        }

        function BindAlarmDetails() {
            let machineNames = "";
            if ($("#hfLiveOrHistoryAlarm").val() == "History") {
                //for (let i = 0; i < $("#multiselectddlMachineID").find("option").length; i++) {
                //    let machine = $("#multiselectddlMachineID").find("option")[i];

                //    if ($(machine).prop('selected')) {
                //        if (machineNames == "") {

                //            machineNames = $(machine).val();
                //        } else {
                //            machineNames = machineNames + "," + $(machine).val();
                //        }
                //    }
                //}
                machineNames = $("#hfSelectedMachineForTroubleShoot").val();

            } else {
                //for (let i = 1; i < $("#multiselectddlMachineID").closest('td').find("ul li input").length; i++) {
                //    let machine = $("#multiselectddlMachineID").closest('td').find("ul li input")[i];
                //    if ($(machine).prop('checked')) {
                //        if (machineNames == "") {

                //            machineNames = $(machine).val();
                //        } else {
                //            machineNames = machineNames + "," + $(machine).val();
                //        }
                //    }
                //}
                if ($("#ddlMachines > option").length > 2) {
                    var firstMachine = $("#ddlMachines > option")[1]
                    machineNames = $(firstMachine).val();
                } else {
                    machineNames = $("#ddlMachines").val();
                }

            }
            let company = $("#ddlCompany").val();
            let plant = $("#ddlPlant").val();
            $.ajax({
                async: false,
                type: "POST",
                url: '<%= ResolveUrl("ProcessParameterDashboard.aspx/bindAlarmDetails") %>',
                contentType: "application/json; charset=utf-8",
                crossDomain: true,
                data: '{machineNames: "' + machineNames + '",fromDate: "' + $("#hfLatestDateForPrev").val() + '",toDate: "' + $("#hfLatestDateForNext").val() + '", liveOrhistory:"' + $("#hfLiveOrHistoryAlarm").val() + '",company: "' + company + '",plant: "' + plant + '"}',
                dataType: "json",
                success: function (response) {
                    dataitem = response.d;
                    $("#alarmDetailsDiv").empty();
                    var appendStr = '<table  class="machine-table" style="">';
                    for (let i = 0; i < dataitem.length; i++) {
                        appendStr += '<tr><th  style="text-align: center; padding-top: 10px" class="machine-div">  <span style="font-size: 16px; font-weight: bold">' + dataitem[i].MachineID + '</span></th></tr>';
                        appendStr += '<tr><td style="padding:2px 9px">  <table class="alarm-msg-table" style="text-align: left;">';
                        for (let j = 0; j < dataitem[i].alarmDetails.length; j++) {
                            appendStr += '<tr><td><span>' + dataitem[i].alarmDetails[j].AlarmMsg + ' </span></td></tr>';
                        }
                        appendStr += '</table>';
                    }
                    appendStr += '</table>';
                    $('#alarmDetailsDiv').append(appendStr);
                },
                error: function (Result) {
                    alert("Error" + Result);
                }
            });
        }

    </script>
</asp:Content>
