<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProductionOEEDashboard.aspx.cs" Inherits="NewProject.ProductionOEEDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

        <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/highcharts-3d.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/modules/export-data.js"></script>
    <script src="https://code.highcharts.com/modules/accessibility.js"></script>

        <script src="https://code.highcharts.com/stock/highstock.js"></script>
    <script src="https://code.highcharts.com/stock/modules/data.js"></script>
    <script src="https://code.highcharts.com/stock/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/stock/modules/export-data.js"></script>



  <%--  <script src="Scripts/Highcharts/highcharts.js"></script>
    <script src="Scripts/Highcharts/exporting.js"></script>
    <script src="Scripts/Highcharts/export-data.js"></script>
    <script src="Scripts/Highcharts/accessibility.js"></script>
    <script src="Scripts/Highcharts/highstock.js"></script>--%>



    <script src="Scripts/DateTimePicker/bootstrap-datepicker.js"></script>
    <link href="Scripts/DateTimePicker/bootstrap-datepicker3.css" rel="stylesheet" />

    <script src="Scripts/DateTimePicker/bootstrap-datepicker.en-IE.min.js"></script>
    <script src="Scripts/DateTimePicker/bootstrap-datepicker.zh-CN.min.js"></script>
    <style>
        .sub-items-filtersection li {
            padding: 10px 0px;
        }

        .outer-ul .removeHover:hover {
            background-color: unset;
        }

        .light-mode .outer-ul li a {
            color: black !important;
        }
        /*.main-svg{
            background-color: black;
        }*/
        .graph-section {
            width: 100%;
        }

        .graph-div {
            /*border: 1px solid red;*/
            overflow: auto;
            width: 48%;
            display: inline-block;
            margin-left: 10px;
            margin-top: 10px;
            vertical-align: top;
            height: 401px;
            box-shadow: 2px 2px 5px 2px #2b2828ed;
        }

        .graph-div-6-add {
            width: 48%;
            display: inline-block;
        }

        .graph-div-6-remove {
            width: 100%;
            display: block;
        }
        /*rect{
            height: 450px;
        }*/
        /*.datetime-txtstyle {
            border: unset;
            border-bottom: 2px solid red;
            background-color: unset;
        }*/

        .checkbox-list tr td {
            padding-bottom: 10px;
        }

        .filter-checkbox input {
            margin-right: 5px;
        }

        #lbBack {
            color: white !important;
        }

        .light-mode #lbBack {
            color: black !important;
        }

        .selected-chart-icon-color {
            color: #31fff6;
        }

        .light-mode .selected-chart-icon-color {
            color: #17aba4 !important;
        }

        .unselected-chart-icon-color {
            color: white;
        }

        .month-chart-icon-color, .day-chart-icon-color {
            margin-left: 5px;
        }
        .P1Table tr:not(:first-child) td:first-child span,  .P1Table tr:not(:first-child) td:first-child a{
            color: #41a5fb !important;
        }
       .light-mode   .P1Table tr:not(:first-child) td:first-child span,  .light-mode .P1Table tr:not(:first-child) td:first-child a{
            color: #013adc  !important;
        }
    </style>
    <div class="themetoggle">
        <table class="submenu-right-side" id="right-table">
            <tr>

                <td>
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <asp:LinkButton runat="server" ID="lbBack" ClientIDMode="Static" CssClass="glyphicon glyphicon-arrow-left" OnClick="lbBack_Click" Style="font-size: 17px" Visible="false"></asp:LinkButton>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                </td>
                <td>
                    <asp:CheckBox runat="server" ID="cbshowhidegraph" ClientIDMode="Static" />
                    <i class="glyphicon glyphicon-stats"></i>
                </td>
                <td onmouseover="showPanelsTopRight(this,'panelContext','100px','40px');" onmouseout="hidePanels(this,'panelContext')">
                    <i class="" style="font-size: 17px;">Context</i>
                    <div class="panel panel-default panel-subitems" id="panelContext" onmouseover="showPanelsTopRight(this,'panelContext','100px','40px');" onmouseout="hidePanels(this,'panelContext')" style="width: 200px;">
                        <div class="panel-body">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:ListView runat="server" ID="lvContext" OnItemDataBound="lvContext_ItemDataBound" OnSelectedIndexChanged="lvContext_SelectedIndexChanged" OnSelectedIndexChanging="lvContext_SelectedIndexChanging">
                                        <LayoutTemplate>
                                            <ul class="outer-ul" runat="server" clientidmode="static" id="ulContext">
                                                <li id="itemplaceholder" runat="server"></li>
                                            </ul>
                                        </LayoutTemplate>
                                        <ItemTemplate>
                                            <li>
                                                <%--<asp:Label runat="server" ID="contextName" Text='<%# Eval("Text") %>'></asp:Label>--%>
                                                <asp:HiddenField runat="server" ID="ContextNameForReference" Value='<%# Eval("Value") %>' />
                                                <asp:LinkButton runat="server" ID="ll" CommandName="Select" Style="color: white" Text='<%# Eval("Text") %>'></asp:LinkButton>
                                            </li>
                                        </ItemTemplate>
                                    </asp:ListView>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </td>
                <td onmouseover="showPanelsTopRight(this,'panelExport','70px','40px');" onmouseout="hidePanels(this,'panelExport')">
                    <i class="glyphicon glyphicon-save" style="font-size: 17px;"></i>
                    <div class="panel panel-default panel-subitems" id="panelExport" onmouseover="showPanelsTopRight(this,'panelExport','70px','40px');" onmouseout="hidePanels(this,'panelExport')" style="width: 200px;">
                        <div class="panel-body">
                            <ul class="outer-ul">
                                <li>
                                    <span>Export as Excel</span>
                                </li>
                                <li>
                                    <span>Export as PDF</span>
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
                                <li onclick="showViews('CardView')">
                                    <span>Card View</span>
                                </li>
                                <li onclick="showViews('ListView')">
                                    <span>List View</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </td>
                <%--onmouseout="hidePanels(this,'panelTimeFilter')"--%>
                <td onclick="showPanelsTopRight(this,'panelTimeFilter','5px','40px');">
                    <i class="glyphicon glyphicon-calendar" style="font-size: 17px;"></i>
                    <%--onmouseover="showPanelsTopRight(this,'panelTimeFilter','5px','54px');" onmouseout="hidePanels(this,'panelTimeFilter')"--%>
                    <div class="panel panel-default panel-subitems" id="panelTimeFilter" style="width: 250px;">
                        <div class="panel-body">
                            <ul class="outer-ul" id="ulTimeFilter">
                                <li class="main-filter" style="text-align: right">
                                    <i class="glyphicon glyphicon-remove" onmouseout="$('#panelTimeFilter').css('visibility', 'hidden');"></i>
                                </li>
                                <li onclick="showFilterSubItems(this,'liIimeSubFilters','downuparrow')" class="main-filter">
                                    <span class="menu-text">Time</span>
                                    <span id="downuparrow" style="margin-left: 130px" class="glyphicon glyphicon-menu-down main-filter-updownarrow"></span>

                                </li>
                                <li style="display: none" id="liIimeSubFilters" class="removeHover sub-filters">
                                    <ul class="sub-items-filtersection">
                                        <li>
                                            <asp:CheckBox runat="server" ID="filterToday" onchange="showhideCustomeDetails(this,'filterToday', '')" CssClass="filter-checkbox" Text="Today" ClientIDMode="Static" />
                                        </li>
                                        <li>
                                            <asp:CheckBox runat="server" ID="filterCustomeDay" onchange="showhideCustomeDetails(this,'filterCustomeDay', 'filterCustomeDayDiv')" CssClass="filter-checkbox" Text="Custom Day" ClientIDMode="Static" />
                                            <div id="filterCustomeDayDiv" class="filterCustomeDiv" style="display: none">
                                                <asp:TextBox ID="txtCustomDay" runat="server" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control datetime-txtstyle" placeholder="Day" Style="width: 70px; display: inline;"></asp:TextBox>
                                            </div>
                                        </li>
                                        <li>
                                            <asp:CheckBox runat="server" ID="filterCurrentMonth" CssClass="filter-checkbox" onchange="showhideCustomeDetails(this,'filterCurrentMonth', '')" Text="Current Month" ClientIDMode="Static" />
                                        </li>
                                        <li>
                                            <asp:CheckBox runat="server" ID="filterCustomeMonth" CssClass="filter-checkbox" onchange="showhideCustomeDetails(this,'filterCustomeMonth', 'filterCustomeMonthDiv')" Text="Custom Month" ClientIDMode="Static" />
                                            <div id="filterCustomeMonthDiv" class="filterCustomeDiv" style="display: none">
                                                <asp:TextBox ID="txtMonth" runat="server" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control datetime-txtstyle" placeholder="Month" Style="width: 70px; display: inline;"></asp:TextBox>

                                            </div>
                                        </li>
                                        <li>
                                            <asp:CheckBox runat="server" ID="filterCurrentYear" CssClass="filter-checkbox" onchange="showhideCustomeDetails(this,'filterCurrentYear', '')" Text="Current Year" ClientIDMode="Static" />
                                        </li>
                                        <li>
                                            <asp:CheckBox runat="server" ID="filterCustomeYear" CssClass="filter-checkbox" onchange="showhideCustomeDetails(this,'filterCustomeYear', 'filterCustomeYearDiv')" Text="Custom Year" ClientIDMode="Static" />
                                            <div id="filterCustomeYearDiv" class="filterCustomeDiv" style="display: none">
                                                <asp:TextBox ID="txtYear" runat="server" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control datetime-txtstyle" placeholder="Year" Style="width: 70px; display: inline;"></asp:TextBox>
                                                <%--  <input type="button" value="View" class="Btns" style="display: none; background-color: red" />--%>
                                                <%--  <asp:Button runat="server" ID="btnYearSearch" CssClass="Btns" OnClick="btnYearSearch_Click" Text="Search" />--%>
                                                <%--OnClientClick="return bindColumnChart();"--%>
                                            </div>
                                        </li>
                                        <li>
                                            <asp:Button runat="server" ID="btnTimeSearch" CssClass="Btns" Text="Search" OnClick="btnTimeSearch_Click" />
                                        </li>
                                    </ul>
                                </li>

                                <li onclick="showFilterSubItems(this,'liShiftSubFilters','downuparrow1')" class="main-filter">
                                    <span class="menu-text">Shift</span>
                                    <span id="downuparrow1" style="margin-left: 130px" class="glyphicon glyphicon-menu-down main-filter-updownarrow"></span>

                                </li>
                                <li style="display: none" id="liShiftSubFilters" class="removeHover sub-filters">
                                    <ul class="sub-items-filtersection">
                                        <li>
                                            <asp:CheckBox runat="server" ID="cbfilterShiftA" onchange="showhideCustomeDetails(this,'cbfilterShiftA', '')" CssClass="filter-checkbox" Text="Shift A" ClientIDMode="Static" />
                                        </li>
                                        <li>
                                            <asp:CheckBox runat="server" ID="cbfilterShiftB" onchange="showhideCustomeDetails(this,'cbfilterShiftB', '')" CssClass="filter-checkbox" Text="Shift B" ClientIDMode="Static" />

                                        </li>
                                        <li>
                                            <asp:CheckBox runat="server" ID="cbfilterShiftC" CssClass="filter-checkbox" onchange="showhideCustomeDetails(this,'cbfilterShiftC', '')" Text="Shift C" ClientIDMode="Static" />
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </div>
                </td>
                <td onmouseover="showPanelsTopRight(this,'panelFilter','5px','40px');" onmouseout="hidePanels(this,'panelFilter')">
                    <i class="glyphicon glyphicon-filter" style="font-size: 17px;"></i>
                    <div class="panel panel-default panel-subitems" id="panelFilter" onmouseover="showPanelsTopRight(this,'panelFilter','5px','40px');" onmouseout="hidePanels(this,'panelFilter')" style="width: 250px;">
                        <div class="panel-body">
                            <div id="divColumnFilter">
                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <asp:CheckBoxList runat="server" ID="cblColumnSelector" CssClass="checkbox-list" ClientIDMode="Static"></asp:CheckBoxList>
                                        <asp:Button runat="server" ID="btnColumnSelectorOK" Text="OK" ClientIDMode="Static" Style="margin-left: 20px" CssClass="Btns" OnClientClick="return selectColumn()" />
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
        <asp:UpdatePanel runat="server">
            <ContentTemplate>

                <asp:HiddenField runat="server" ID="activeMenu" ClientIDMode="Static" />
                <asp:HiddenField runat="server" ID="hfselectedContext" ClientIDMode="Static" />
                <asp:HiddenField runat="server" ID="hfMainView" ClientIDMode="Static" />
                <asp:HiddenField runat="server" ID="hfView" ClientIDMode="Static" />
                <div style="position: relative;">
                <div class="listView columnSelector" style="overflow: auto">

                    <div runat="server" id="divCompanyView">
                        <asp:ListView runat="server" ID="lvCompanyDashboard" ClientIDMode="Static" OnItemEditing="lvCompanyDashboard_ItemEditing">
                            <LayoutTemplate>
                                <table class="P1Table draw-year-graph setColumnTbl" id="tblCompanyDashboard" runat="server">
                                    <tr>
                                        <th onmouseover="showPanelsTopLeft(this,'panelRowSelector','0px','35px');" onmouseout="hidePanels(this,'panelRowSelector')">
                                            <span class="header-name">Company</span>
                                            <i class="glyphicon glyphicon-filter " style="font-size: 15px;"></i>
                                        </th>
                                        <th>
                                            <span class="header-name">Company Description</span>
                                        </th>
                                        <th>
                                            <span class="header-name">OEE (%)</span>
                                            <i class="glyphicon glyphicon-stats chart-icon-color" id="cmpnyAvgOEE" style="font-size: 15px;"></i>
                                            <span class="param-for-graph" style="display: none">AvgOEE</span>
                                        </th>
                                        <th>
                                            <span class="header-name">QE (%)</span>
                                            <i class="glyphicon glyphicon-stats chart-icon-color" id="cmpnyQualityRate" style="font-size: 15px;"></i>
                                            <span class="param-for-graph" style="display: none">QualityRate</span>
                                        </th>
                                        <th>
                                            <span class="header-name">Part Count</span>
                                            <i class="glyphicon glyphicon-stats chart-icon-color" id="cmpnyRevenue" style="font-size: 15px;"></i>
                                            <span class="param-for-graph" style="display: none">Revenue</span>
                                        </th>
                                        <th>
                                            <span class="header-name">Down Time (hh:mm)</span>
                                            <i class="glyphicon glyphicon-stats chart-icon-color" id="cmpnyLossINR" style="font-size: 15px;"></i>
                                            <span class="param-for-graph" style="display: none">LossINR</span>
                                        </th>
                                    </tr>
                                    <tr id="itemplaceholder" runat="server"></tr>
                                </table>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <tr>
                                    <%--  <td>
                                                <asp:CheckBox runat="server" ID="cbSelectRows" ClientIDMode="Static" />
                                            </td>--%>
                                    <td>
                                        <%--  <asp:Label runat="server" ID="ll" Text='<%#Eval("C1") %>'></asp:Label>--%>
                                        <asp:LinkButton runat="server" ID="name" ClientIDMode="Static" Text='<%#Eval("View") %>' CommandName="Edit" Style="color: white"></asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="Label4" Text='<%#Eval("View") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="Label5" Text='<%#Eval("QE") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="Label1" Text='<%#Eval("AE") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="Label2" Text='<%#Eval("PE") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="Label3" Text='<%#Eval("QE") %>'></asp:Label>
                                    </td>
                                </tr>

                            </ItemTemplate>
                        </asp:ListView>
                    </div>


                    <div runat="server" id="divPlantView">
                        <asp:ListView runat="server" ID="lvPlantDashboard" ClientIDMode="Static" OnItemEditing="lvPlantDashboard_ItemEditing">
                            <LayoutTemplate>
                                <table class="P1Table draw-year-graph setColumnTbl" id="tblPlantDashboard" runat="server">
                                    <tr>
                                        <th onmouseover="showPanelsTopLeft(this,'panelRowSelector','0px','35px');" onmouseout="hidePanels(this,'panelRowSelector')">
                                            <span class="header-name">Plant</span>
                                            <i class="glyphicon glyphicon-filter" style="font-size: 15px;"></i>
                                        </th>
                                        <th>
                                            <span class="header-name">Plant Description</span>
                                        </th>
                                        <th>
                                            <span class="header-name">OEE (%)</span>
                                            <i class="glyphicon glyphicon-stats chart-icon-color bar-chart" id="plantAvgOEE" style="font-size: 15px;"></i>
                                             <i class="glyphicon glyphicon-random chart-icon-color line-chart" style="font-size: 15px;"></i>
                                            <span class="param-for-graph" style="display: none">AvgOEE</span>

                                        </th>
                                        <th>
                                            <span class="header-name">QE (%)</span>
                                            <i class="glyphicon glyphicon-stats chart-icon-color bar-chart" id="plantQualityRate" style="font-size: 15px;"></i>
                                              <i class="glyphicon glyphicon-random chart-icon-color line-chart" style="font-size: 15px;"></i>
                                            <span class="param-for-graph" style="display: none">QualityRate</span>
                                        </th>
                                        <th>
                                            <span class="header-name">Part Count</span>
                                            <i class="glyphicon glyphicon-stats chart-icon-color bar-chart" id="plantRevenue" style="font-size: 15px;"></i>
                                            <i class="glyphicon glyphicon-random chart-icon-color line-chart" style="font-size: 15px;"></i>
                                            <span class="param-for-graph" style="display: none">Revenue</span>
                                        </th>
                                        <th>
                                            <span class="header-name">Down Time (hh:mm)</span>
                                            <i class="glyphicon glyphicon-stats chart-icon-color bar-chart" id="plantLossINR" style="font-size: 15px;"></i>
                                            <i class="glyphicon glyphicon-random chart-icon-color line-chart" style="font-size: 15px;"></i>
                                            <span class="param-for-graph" style="display: none">LossINR</span>
                                        </th>
                                        <th>
                                            <span class="header-name">Attendance (%)</span>
                                            <i class="glyphicon glyphicon-stats chart-icon-color bar-chart" id="plantAttendance" style="font-size: 15px;"></i>
                                            <i class="glyphicon glyphicon-random chart-icon-color line-chart" style="font-size: 15px;"></i>
                                            <span class="param-for-graph" style="display: none">Attendance</span>
                                        </th>
                                        <th>
                                            <span class="header-name">Safety KPI (%)</span>
                                            <i class="glyphicon glyphicon-stats chart-icon-color bar-chart" id="plantSafetyKPI" style="font-size: 15px;"></i>
                                            <i class="glyphicon glyphicon-random chart-icon-color line-chart" style="font-size: 15px;"></i>
                                            <span class="param-for-graph" style="display: none">SafetyKPI</span>
                                        </th>
                                    </tr>
                                    <tr id="itemplaceholder" runat="server"></tr>
                                </table>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <%--  <asp:Label runat="server" ID="ll" Text='<%#Eval("C1") %>'></asp:Label>--%>
                                        <asp:HiddenField runat="server" ID="hdnCompanyName" Value='<%#Eval("CompanyName") %>' />
                                        <asp:LinkButton runat="server" ID="name" Text='<%#Eval("PlantName") %>' CommandName="Edit" Style="color: white"></asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="Label4" Text='<%#Eval("Description") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="Label5" Text='<%#Eval("OEE") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="Label1" Text='<%#Eval("QualityRate") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="Label2" Text='<%#Eval("Revenue") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="Label3" Text='<%#Eval("LossINR") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="Label6" Text='<%#Eval("Attendance") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="Label7" Text='<%#Eval("SafetyKPI") %>'></asp:Label>
                                    </td>
                                </tr>

                            </ItemTemplate>
                        </asp:ListView>

                        <asp:ListView runat="server" ID="lvDivDashboard" ClientIDMode="Static">
                            <LayoutTemplate>
                                <table class="P1Table draw-year-graph" id="tblDivDashboard" runat="server">
                                    <tr>
                                        <th onmouseover="showPanelsTopLeft(this,'panelRowSelector','0px','35px');" onmouseout="hidePanels(this,'panelRowSelector')">Div
                                                        <i class="glyphicon glyphicon-filter" style="font-size: 15px;"></i>
                                        </th>
                                        <th>Div Description</th>
                                        <th>Plant OEE</th>
                                        <th>Quality Rate</th>
                                        <th>Revenue</th>
                                        <th>Loss (INR)</th>
                                        <th>Attendance</th>
                                        <th>Safety KPI</th>
                                    </tr>
                                    <tr id="itemplaceholder" runat="server"></tr>
                                </table>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <%--<asp:Label runat="server" ID="ll" Text='<%#Eval("C1") %>'></asp:Label>--%>
                                        <asp:LinkButton runat="server" ID="name" Text='<%#Eval("View") %>' CommandName="Edit" Style="color: white"></asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="Label4" Text='<%#Eval("View") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="Label5" Text='<%#Eval("QE") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="Label1" Text='<%#Eval("AE") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="Label2" Text='<%#Eval("PE") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="Label3" Text='<%#Eval("QE") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="Label6" Text='<%#Eval("QE") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="Label7" Text='<%#Eval("AE") %>'></asp:Label>
                                    </td>
                                </tr>

                            </ItemTemplate>
                        </asp:ListView>

                    </div>

                    <div runat="server" id="divCellView">
                        <asp:ListView runat="server" ID="lvCellDashboard" ClientIDMode="Static" OnItemEditing="lvCellDashboard_ItemEditing">
                            <LayoutTemplate>
                                <table class="P1Table draw-year-graph setColumnTbl" id="tblCellDashboard" runat="server">
                                    <tr>
                                        <th onmouseover="showPanelsTopLeft(this,'panelRowSelector','0px','35px');" onmouseout="hidePanels(this,'panelRowSelector')">
                                            <span class="header-name">Cell</span>
                                              <i class="glyphicon glyphicon-filter" style="font-size: 15px;"></i>
                                        </th>
                                        <th>
                                                 <span class="header-name">Cell Description</span>
                                        </th>
                                        <th>
                                            <span class="header-name">OEE (%)</span>
                                            <i class="glyphicon glyphicon-stats chart-icon-color bar-chart" id="cellOEE" style="font-size: 15px;"></i>
                                                <i class="glyphicon glyphicon-random chart-icon-color line-chart" style="font-size: 15px;"></i>
                                            <span class="param-for-graph" style="display: none">AvgOEE</span>
                                        </th>
                                        <th>
                                            <span class="header-name">AE (%)</span>
                                            <i class="glyphicon glyphicon-stats chart-icon-color bar-chart" id="cellAE" style="font-size: 15px;"></i>
                                                <i class="glyphicon glyphicon-random chart-icon-color line-chart" style="font-size: 15px;"></i>
                                            <span class="param-for-graph" style="display: none">AEEfficiency</span>
                                        </th>
                                        <th>
                                            <span class="header-name">PE (%)</span>
                                            <i class="glyphicon glyphicon-stats chart-icon-color bar-chart" id="cellPE" style="font-size: 15px;"></i>
                                                <i class="glyphicon glyphicon-random chart-icon-color line-chart" style="font-size: 15px;"></i>
                                            <span class="param-for-graph" style="display: none">PEEfficiency</span>
                                        </th>
                                        <th>
                                            <span class="header-name">QE (%)</span>
                                            <i class="glyphicon glyphicon-stats chart-icon-color bar-chart" id="cellQE" style="font-size: 15px;"></i>
                                                <i class="glyphicon glyphicon-random chart-icon-color line-chart" style="font-size: 15px;"></i>
                                            <span class="param-for-graph" style="display: none">QEEfficiency</span>
                                        </th>
                                    </tr>
                                    <tr id="itemplaceholder" runat="server"></tr>
                                </table>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <%--  <asp:Label runat="server" ID="ll" Text='<%#Eval("C1") %>'></asp:Label>--%>
                                        <asp:HiddenField runat="server" ID="hdnCompanyName" ClientIDMode="Static" Value='<%#Eval("CompanyName") %>' />
                                        <asp:HiddenField runat="server" ID="hdnPlantName" ClientIDMode="Static" Value='<%#Eval("PlantName") %>' />
                                        <asp:LinkButton runat="server" ID="name" Text='<%#Eval("CellName") %>' CommandName="Edit" Style="color: white"></asp:LinkButton>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="Label4" Text='<%#Eval("Description") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="Label5" Text='<%#Eval("OEE") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="Label1" Text='<%#Eval("AEffy") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="Label2" Text='<%#Eval("PEffy") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="Label3" Text='<%#Eval("QEffy") %>'></asp:Label>
                                    </td>
                                </tr>

                            </ItemTemplate>
                        </asp:ListView>
                    </div>

                    <div runat="server" id="divMachineView">
                        <asp:ListView runat="server" ID="lvMachineDashboard" ClientIDMode="Static">
                            <LayoutTemplate>
                                <table class="P1Table draw-year-graph setColumnTbl" id="tblMachineDashboard" runat="server">
                                    <tr>
                                        <th onmouseover="showPanelsTopLeft(this,'panelRowSelector','0px','35px');" onmouseout="hidePanels(this,'panelRowSelector')">
                                             <span class="header-name">Machine</span>
                                                       <i class="glyphicon glyphicon-filter" style="font-size: 15px;"></i>
                                        </th>
                                        <th>
                                             <span class="header-name">Machine Description</span>
                                        </th>
                                        <th>
                                            <span class="header-name">OEE (%)</span>
                                            <i class="glyphicon glyphicon-stats chart-icon-color bar-chart" id="mahineOEE" style="font-size: 15px;"></i>
                                               <i class="glyphicon glyphicon-random chart-icon-color line-chart" style="font-size: 15px;"></i>
                                            <span class="param-for-graph" style="display: none">AvgOEE</span>
                                        </th>
                                        <th>
                                            <span class="header-name">AE (%)</span>
                                            <i class="glyphicon glyphicon-stats chart-icon-color bar-chart" id="machineAE" style="font-size: 15px;"></i>
                                               <i class="glyphicon glyphicon-random chart-icon-color line-chart" style="font-size: 15px;"></i>
                                            <span class="param-for-graph" style="display: none">AEEfficiency</span>
                                        </th>
                                        <th>
                                            <span class="header-name">PE (%)</span>
                                            <i class="glyphicon glyphicon-stats chart-icon-color bar-chart" id="machinePE" style="font-size: 15px;"></i>
                                               <i class="glyphicon glyphicon-random chart-icon-color line-chart" style="font-size: 15px;"></i>
                                            <span class="param-for-graph" style="display: none">PEEfficiency</span>
                                        </th>
                                        <th>
                                            <span class="header-name">QE (%)</span>
                                            <i class="glyphicon glyphicon-stats chart-icon-color bar-chart" id="machineQE" style="font-size: 15px;"></i>
                                               <i class="glyphicon glyphicon-random chart-icon-color line-chart" style="font-size: 15px;"></i>
                                            <span class="param-for-graph" style="display: none">QEEfficiency</span>
                                        </th>
                                        <th>
                                            <span class="header-name">Part Count</span>
                                            <i class="glyphicon glyphicon-stats chart-icon-color bar-chart" id="machinePartCount" style="font-size: 15px;"></i>
                                               <i class="glyphicon glyphicon-random chart-icon-color line-chart" style="font-size: 15px;"></i>
                                            <span class="param-for-graph" style="display: none">PartCount</span>
                                        </th>
                                        <th>
                                            <span class="header-name">Rejection</span>
                                            <i class="glyphicon glyphicon-stats chart-icon-color bar-chart" id="machineRejection" style="font-size: 15px;"></i>
                                               <i class="glyphicon glyphicon-random chart-icon-color line-chart" style="font-size: 15px;"></i>
                                            <span class="param-for-graph" style="display: none">Rejection</span>
                                        </th>
                                        <th>
                                            <span class="header-name">Down Time (hh:mm)</span>
                                            <i class="glyphicon glyphicon-stats chart-icon-color bar-chart" id="machineLossINR" style="font-size: 15px;"></i>
                                               <i class="glyphicon glyphicon-random chart-icon-color line-chart" style="font-size: 15px;"></i>
                                            <span class="param-for-graph" style="display: none">LossINR</span>
                                        </th>
                                    </tr>
                                    <tr id="itemplaceholder" runat="server"></tr>
                                </table>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <asp:HiddenField runat="server" ID="hdnCompanyName" ClientIDMode="Static" Value='<%#Eval("CompanyName") %>' />
                                        <asp:HiddenField runat="server" ID="hdnPlantName" ClientIDMode="Static" Value='<%#Eval("PlantName") %>' />
                                        <asp:HiddenField runat="server" ID="hdnCellName" ClientIDMode="Static" Value='<%#Eval("CellName") %>' />
                                        <asp:Label runat="server" ID="name" Text='<%#Eval("MachineName") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="Label4" Text='<%#Eval("Description") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="Label5" Text='<%#Eval("OEE") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="Label1" Text='<%#Eval("AEffy") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="Label2" Text='<%#Eval("PEffy") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="Label3" Text='<%#Eval("QEffy") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="Label8" Text='<%#Eval("AcceptedPart") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="Label9" Text='<%#Eval("RejectCount") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="Label10" Text='<%#Eval("LossINR") %>'></asp:Label>
                                    </td>
                                </tr>

                            </ItemTemplate>
                        </asp:ListView>
                    </div>

                    <div class="panel panel-default panel-subitems" id="panelRowSelector" onmouseover="showPanelsTopLeft(this,'panelRowSelector','0px','35px');" onmouseout="hidePanels(this,'panelRowSelector')" >
                        <div class="panel-body">
                            <div style="height:250px;overflow:auto;margin-bottom:7px;">
                            <asp:CheckBoxList runat="server" ID="cblRowSelector" CssClass="checkbox-list filterPanel" ClientIDMode="Static" onchange="select"></asp:CheckBoxList>
                                 </div>
                            <asp:Button runat="server" ID="btnSelectRows" Text="OK" ClientIDMode="Static" CssClass="Btns" OnClientClick="return selectRows()" />
                               
                        </div>
                    </div>

                </div>
                    </div>
                <div class="cardView" style="display: none">

                    <div runat="server" id="divCardViewCompany">
                        <asp:ListView runat="server" ID="lvCardViewCompanyDashboard" ClientIDMode="Static" OnItemEditing="lvCardViewCompanyDashboard_ItemEditing">
                            <LayoutTemplate>
                                <div>
                                    <div runat="server" id="itemplaceholder"></div>
                                </div>
                            </LayoutTemplate>
                            <ItemTemplate>

                                <div class="outer-div">
                                    <div>
                                        <table id="tblCardViewCompanyDashboard" class="card-table setColumnTbl">
                                            <tr>

                                                <td colspan="2" style="text-align: center">
                                                    <asp:HiddenField runat="server" ClientIDMode="Static" ID="hdnHeaderName" Value="Company" />
                                                    <span class="card-header">
                                                        <asp:LinkButton runat="server" ID="name" ClientIDMode="Static" CommandName="Edit" Text='<%#Eval("View") %>' Style="color: white"></asp:LinkButton>
                                                    </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Company Description</span>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Label4" Text='<%#Eval("View") %>'></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Avg. OEE</span>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Label5" Text='<%#Eval("QE") %>'></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Quality Rate (PPM)</span>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Label1" Text='<%#Eval("AE") %>'></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Revenue (INR)</span>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Label2" Text='<%#Eval("PE") %>'></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Loss (INR)</span>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Label3" Text='<%#Eval("QE") %>'></asp:Label>
                                                </td>
                                            </tr>

                                        </table>
                                    </div>
                                </div>

                            </ItemTemplate>
                        </asp:ListView>
                    </div>

                    <div runat="server" id="divCardViewPlant">
                        <asp:ListView runat="server" ID="lvCardViewPlantDashboard" ClientIDMode="Static" OnItemEditing="lvCardViewPlantDashboard_ItemEditing">
                            <LayoutTemplate>
                                <div>
                                    <div runat="server" id="itemplaceholder"></div>
                                </div>
                            </LayoutTemplate>
                            <ItemTemplate>

                                <div class="outer-div">
                                    <div>
                                        <table id="tblCardViewPlantDashboard" class="card-table setColumnTbl">
                                            <tr>
                                                <td colspan="2" style="text-align: center">
                                                    <asp:HiddenField runat="server" ClientIDMode="Static" ID="hdnHeaderName" Value="Plant" />
                                                    <span class="card-header">
                                                        <asp:HiddenField runat="server" ID="hdnCompanyName" Value='<%#Eval("CompanyName") %>' />
                                                        <asp:LinkButton runat="server" ID="name" ClientIDMode="Static" CommandName="Edit" Text='<%#Eval("PlantName") %>' Style="color: white"></asp:LinkButton>
                                                    </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Plant Description</span>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Label4" Text='<%#Eval("Description") %>'></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Plant OEE</span>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Label5" Text='<%#Eval("OEE") %>'></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Quality Rate</span>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Label1" Text='<%#Eval("QualityRate") %>'></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Revenue</span>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Label2" Text='<%#Eval("Revenue") %>'></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Loss (INR)</span>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Label3" Text='<%#Eval("LossINR") %>'></asp:Label>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Attendance</span>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Label11" Text='<%#Eval("Attendance") %>'></asp:Label>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Safety KPI</span>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Label12" Text='<%#Eval("SafetyKPI") %>'></asp:Label>
                                                </td>
                                            </tr>

                                        </table>
                                    </div>
                                </div>

                            </ItemTemplate>
                        </asp:ListView>

                        <asp:ListView runat="server" ID="lvCardViewDivDashboard" ClientIDMode="Static">
                            <LayoutTemplate>
                                <div>
                                    <div runat="server" id="itemplaceholder"></div>
                                </div>
                            </LayoutTemplate>
                            <ItemTemplate>

                                <div class="outer-div">
                                    <div>
                                        <table id="tblCardViewPlantDashboard" class="card-table">
                                            <tr>
                                                <td colspan="2" style="text-align: center">
                                                    <span class="card-header">
                                                        <asp:LinkButton runat="server" ID="name" ClientIDMode="Static" Text='<%#Eval("View") %>' Style="color: white"></asp:LinkButton>
                                                    </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Description</span>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Label4" Text='<%#Eval("View") %>'></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Div OEE</span>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Label5" Text='<%#Eval("QE") %>'></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Quality Rate</span>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Label1" Text='<%#Eval("AE") %>'></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Revenue</span>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Label2" Text='<%#Eval("PE") %>'></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Loss (INR)</span>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Label3" Text='<%#Eval("QE") %>'></asp:Label>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Attendance</span>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Label11" Text='<%#Eval("QE") %>'></asp:Label>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Safety KPI</span>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Label12" Text='<%#Eval("AE") %>'></asp:Label>
                                                </td>
                                            </tr>

                                        </table>
                                    </div>
                                </div>

                            </ItemTemplate>
                        </asp:ListView>
                    </div>

                    <div runat="server" id="divCardViewCell">
                        <asp:ListView runat="server" ID="lvCardViewCellDashboard" ClientIDMode="Static" OnItemEditing="lvCardViewCellDashboard_ItemEditing">
                            <LayoutTemplate>
                                <div>
                                    <div runat="server" id="itemplaceholder"></div>
                                </div>
                            </LayoutTemplate>
                            <ItemTemplate>

                                <div class="outer-div">
                                    <div>
                                        <table id="tblCardViewCellDashboard" class="card-table setColumnTbl">
                                            <tr>
                                                <td colspan="2" style="text-align: center">
                                                    <asp:HiddenField runat="server" ClientIDMode="Static" ID="hdnHeaderName" Value="Cell" />
                                                    <span class="card-header">
                                                        <asp:HiddenField runat="server" ID="hdnCompanyName" ClientIDMode="Static" Value='<%#Eval("CompanyName") %>' />
                                                        <asp:HiddenField runat="server" ID="hdnPlantName" ClientIDMode="Static" Value='<%#Eval("PlantName") %>' />
                                                        <asp:LinkButton runat="server" ID="name" ClientIDMode="Static" CommandName="Edit" Text='<%#Eval("CellName") %>' Style="color: white"></asp:LinkButton>
                                                    </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Cell Description</span>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Label4" Text='<%#Eval("Description") %>'></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">OEE (%)</span>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Label5" Text='<%#Eval("OEE") %>'></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">AE (%)</span>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Label1" Text='<%#Eval("AEffy") %>'></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">PE (%)</span>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Label2" Text='<%#Eval("PEffy") %>'></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">QE (%)</span>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Label3" Text='<%#Eval("QEffy") %>'></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>

                            </ItemTemplate>
                        </asp:ListView>
                    </div>


                    <div runat="server" id="divCardViewMachine">
                        <asp:ListView runat="server" ID="lvCardViewMachineDashboard" ClientIDMode="Static" OnItemEditing="lvCardViewCellDashboard_ItemEditing">
                            <LayoutTemplate>
                                <div>
                                    <div runat="server" id="itemplaceholder"></div>
                                </div>
                            </LayoutTemplate>
                            <ItemTemplate>

                                <div class="outer-div">
                                    <div>
                                        <table id="tblCardViewMachineDashboard" class="card-table setColumnTbl">
                                            <tr>
                                                <td colspan="2" style="text-align: center">
                                                    <asp:HiddenField runat="server" ClientIDMode="Static" ID="hdnHeaderName" Value="Machine" />
                                                    <span class="card-header">
                                                        <asp:HiddenField runat="server" ID="hdnCompanyName" ClientIDMode="Static" Value='<%#Eval("CompanyName") %>' />
                                                        <asp:HiddenField runat="server" ID="hdnPlantName" ClientIDMode="Static" Value='<%#Eval("PlantName") %>' />
                                                        <asp:HiddenField runat="server" ID="hdnCellName" ClientIDMode="Static" Value='<%#Eval("CellName") %>' />
                                                        <asp:Label runat="server" ID="name" ClientIDMode="Static" Text='<%#Eval("MachineName") %>'></asp:Label>
                                                    </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Machine Description</span>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Label4" Text='<%#Eval("Description") %>'></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">OEE (%)</span>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Label5" Text='<%#Eval("OEE") %>'></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">AE (%)</span>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Label1" Text='<%#Eval("AEffy") %>'></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">PE (%)</span>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Label2" Text='<%#Eval("PEffy") %>'></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">QE (%)</span>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Label3" Text='<%#Eval("QEffy") %>'></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Part Count</span>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Label13" Text='<%#Eval("AcceptedPart") %>'></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Rejection</span>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Label14" Text='<%#Eval("LossINR") %>'></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Loss (hh: mm)</span>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Label15" Text='<%#Eval("RejectCount") %>'></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>

                            </ItemTemplate>
                        </asp:ListView>
                    </div>
                </div>

                <div class="graphSection box-shadow" style="margin-top: 20px;">
                    <div style="text-align: center">
                        <span style="color: #02bb3a; font-size: 18px; font-weight: bold; margin-right: 5px">Year View</span>
                        <i class="glyphicon glyphicon-arrow-down" title="Drilldown For Month View" onclick="return bindMonthGridData('firtClick')"></i>
                        <div id="yearChart" style="margin-top: 20px; height: 300px" class="box-shadow">
                        </div>
                    </div>

                    <div id="monthchartdatadetails" style="text-align: center; display: none; margin-top: 13px;">
                        <span style="color: #02bb3a; font-size: 18px; font-weight: bold; margin-right: 5px">Month View</span>
                        <i class="glyphicon glyphicon-arrow-down" title="Drilldown For Day View" onclick="return bindDayGridData('firstClick')"></i>
                        <i class="glyphicon glyphicon-remove" title="Close Month View" onclick="$('#monthchartdatadetails').css('display', 'none');"></i>
                        <div style="margin-top: 5px">
                            <div class="navbar-collapse collapse" style="height: 40px !important;">
                                <ul class="nav navbar-nav" id="ulMonthsForYear">
                                    <li>
                                        <a runat="server" class="submenuData" id="jan" title="01" clientidmode="static" data-toggle="tab" href="#monthDataAndChartContainer">Jan</a>
                                        <i></i>
                                    </li>
                                    <li>
                                        <a runat="server" class="submenuData" id="feb" title="02" clientidmode="static" data-toggle="tab" href="#monthDataAndChartContainer">Feb</a>
                                        <i></i>
                                    </li>
                                    <li>
                                        <a runat="server" class="submenuData" id="mar" title="03" clientidmode="static" data-toggle="tab" href="#monthDataAndChartContainer">Mar</a>
                                        <i></i>
                                    </li>
                                    <li>
                                        <a runat="server" class="submenuData" id="apr" title="04" clientidmode="static" data-toggle="tab" href="#monthDataAndChartContainer">Apr</a>
                                        <i></i>
                                    </li>
                                    <li>
                                        <a runat="server" class="submenuData" id="may" title="05" clientidmode="static" data-toggle="tab" href="#monthDataAndChartContainer">May</a>
                                        <i></i>
                                    </li>
                                    <li>
                                        <a runat="server" class="submenuData" id="jun" title="06" clientidmode="static" data-toggle="tab" href="#monthDataAndChartContainer">Jun</a>
                                        <i></i>
                                    </li>
                                    <li>
                                        <a runat="server" class="submenuData" id="jul" title="07" clientidmode="static" data-toggle="tab" href="#monthDataAndChartContainer">Jul</a>
                                        <i></i>
                                    </li>
                                    <li>
                                        <a runat="server" class="submenuData" id="aug" title="08" clientidmode="static" data-toggle="tab" href="#monthDataAndChartContainer">Aug</a>
                                        <i></i>
                                    </li>
                                    <li>
                                        <a runat="server" class="submenuData" id="sep" title="09" clientidmode="static" data-toggle="tab" href="#monthDataAndChartContainer">Sep</a>
                                        <i></i>
                                    </li>
                                    <li>
                                        <a runat="server" class="submenuData" id="oct" title="10" clientidmode="static" data-toggle="tab" href="#monthDataAndChartContainer">Oct</a>
                                        <i></i>
                                    </li>
                                    <li>
                                        <a runat="server" class="submenuData" id="nov" title="11" clientidmode="static" data-toggle="tab" href="#monthDataAndChartContainer">Nov</a>
                                        <i></i>
                                    </li>
                                    <li>
                                        <a runat="server" class="submenuData" id="dec" title="12" clientidmode="static" data-toggle="tab" href="#monthDataAndChartContainer">Dec</a>
                                        <i></i>
                                    </li>
                                </ul>
                            </div>
                            <div class="tab-content themetoggle" id="processParamContainer" style="overflow: auto; width: 100%; height: unset; margin: 3px auto;">
                                <div id="monthDataAndChartContainer" class="tab-pane fade">
                                    <div id="monthgrid" style="display: none">
                                    </div>
                                    <div id="monthData" class="box-shadow" style="overflow: auto">
                                    </div>
                                    <div id="monthChart" style="margin-top: 10px; height: 300px" class="box-shadow">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="daychartdatadetails" style="text-align: center; display: none; margin-top: 13px">
                        <span style="color: #02bb3a; font-size: 18px; font-weight: bold; margin-right: 5px">Day View</span>
                        <i class="glyphicon glyphicon-remove" title="Close Day View" onclick="$('#daychartdatadetails').css('display', 'none');"></i>
                        <div style="margin-top: 5px">
                            <div class="navbar-collapse collapse" style="height: 40px !important;">
                                <ul class="nav navbar-nav" id="ulDaysForMonth">
                                </ul>
                            </div>
                            <div class="tab-content themetoggle" style="overflow: auto; width: 100%; height: unset; margin: 3px auto;">
                                <div id="dayDataAndChartContainer" class="tab-pane fade">
                                    <div id="daygrid" style="display: none">
                                    </div>
                                    <div id="dayData" class="box-shadow" style="overflow: auto">
                                    </div>
                                    <div id="dayChart" style="margin-top: 10px; height: 300px" class="box-shadow">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnTimeSearch" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="btnColumnSelectorOK" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
    </div>

    <script>
        $(document).ready(function () {
            $('#right-table').appendTo('#right-side-filters');
            var Height = $(window).height() - 100;
            $('.listView').css('height', Height);
            $('.graphSection').css('display', 'none');

            $("#monthData").css('height', ($(window).height() - 480));
            $("#dayData").css('height', ($(window).height() - 480));
        });
        $('#cblRowSelector tr td').click(function () {
            debugger;
            var CHK = document.getElementById("cblRowSelector");
            var checkbox = CHK.getElementsByTagName("input");
            var label = CHK.getElementsByTagName("label");
            var counter = 0;
            if ($(this).children()[1].innerHTML == "Select All") {
                if (checkbox[0].checked == true) {
                    for (var i = 1; i < checkbox.length; i++) {
                        checkbox[i].checked = true;
                    }
                }
                else {
                    for (var i = 1; i < checkbox.length; i++) {
                        checkbox[i].checked = false;
                    }
                }
            }
            else {
                if ($(this).children()[0].checked == false) {
                    checkbox[0].checked = false;
                }
                else {
                    var checkedCount = 0;
                    for (var i = 1; i < checkbox.length; i++) {
                        if (checkbox[i].checked) {
                            checkedCount++;
                        }
                    }
                    if (checkedCount == checkbox.length - 1) {
                        checkbox[0].checked = true;
                    }
                    else {
                        checkbox[0].checked = false;
                    }
                }
            }
        });
        $(window).resize(function () {            $("#monthData").css('height', ($(window).height() - 480));
            $("#dayData").css('height', ($(window).height() - 480));        });

        var selectedChartTypeforView = "";
        var barorlinecharts = "column";
        $(".chart-icon-color").click(function () {
            let selectedChartID = $(this).attr('id');
            let selectedGraph = $(this).closest('th').find(".param-for-graph").text();
            $(".chart-icon-color").removeClass("selected-chart-icon-color");
          
            selectedChartTypeforView = $(this).closest('th').find(".header-name").text();
            if ($(this).hasClass("line-chart")) {
                barorlinecharts = "line";
                 $(this).closest("th").find(".line-chart").addClass("selected-chart-icon-color");
            } else {
                barorlinecharts = "column";
                  $(this).closest("th").find(".bar-chart").addClass("selected-chart-icon-color");
            }
            bindColumnChart(selectedGraph);
        });

        function monthChartTypeClicked(element) {
                debugger;
            let selectedChartID = $(element).attr('id');
            let selectedGraph = $(element).closest('th').find(".param-for-graph").text();
            $(".month-chart-icon-color").removeClass("selected-chart-icon-color");
           
            monthChartType = selectedGraph;
            if ($(element).hasClass("line-chart")) {
                barorlinecharts = "line";
                $(element).closest('th').find(".line-chart").addClass("selected-chart-icon-color");
            } else {
                barorlinecharts = "column";
                $(element).closest('th').find(".bar-chart").addClass("selected-chart-icon-color");
            }
            bindMonthChartData(selectedGraph);
        }
        function dayChartTypeClicked(element) {
            let selectedChartID = $(element).attr('id');
            let selectedGraph = $(element).closest('th').find(".param-for-graph").text();
            $(".day-chart-icon-color").removeClass("selected-chart-icon-color");
            //$(element).closest('th').find("i").addClass("selected-chart-icon-color");
            dayChartType = selectedGraph;
            if ($(element).hasClass("line-chart")) {
                barorlinecharts = "line";
                $(element).closest('th').find(".line-chart").addClass("selected-chart-icon-color");
            } else {
                barorlinecharts = "column";
                $(element).closest('th').find(".bar-chart").addClass("selected-chart-icon-color");
            }
            bindDayChartData(selectedGraph);
        }

        $("#cbshowhidegraph").change(function () {
            showhidegraph();
        });
        function daysForMonth() {
            $("#ulDaysForMonth").empty();
            let appstr = "";
            //alert(getDaysInMonth(2, 2020));
            //alert("janfebmaraprmayjunjulaugsepoctnovdec".indexOf(submenuid) / 3 + 1);
            for (let i = 1; i <= getDaysInMonth(("janfebmaraprmayjunjulaugsepoctnovdec".indexOf(submenuid) / 3 + 1), 2020); i++) {
                let day=i;
                if (i < 10) {
                    day = "0" + i;
                } 
                appstr += "<li><a id='D" + i + "' title='"+day+"' class='daySubMenu' onclick='setDayMenus(this)'  data-toggle='tab' href='#dayDataAndChartContainer'>D" + i + "</a><i></i></li>";
            }
            $("#ulDaysForMonth").append(appstr);

        }
        var getDaysInMonth = function (month, year) {
            // Here January is 1 based
            //Day 0 is the last day in the previous month
            return new Date(year, month, 0).getDate();
            // Here January is 0 based
            // return new Date(year, month+1, 0).getDate();
        };
        var submenu = "#monthDataAndChartContainer";
        var submenuid = "jan";
        var selectedMonthMenu = "01";
        var selectedMonthMenuForView = "Jan";
        $(".submenuData").click(function () {
            if ($("#mainBody").hasClass("light-mode")) {
                $(".submenuData").removeClass("selected-menu-style menu0-select").addClass("other-menu-style");
                $(".submenuData").closest('li').find('i').removeClass();
                $(this).removeClass("other-menu-style menu0-select").addClass("selected-menu-style");
            } else {
                $(".submenuData").removeClass("selected-menu-style menu0-select").addClass("other-menu-style");
                $(".submenuData").closest('li').find('i').removeClass();
                $(this).removeClass("other-menu-style menu0-select").addClass("selected-menu-style");
            }

            $(this).closest('li').find('i').addClass("arrow up");

            submenu = $(this).attr('href');
            submenuid = $(this).attr('id');
            selectedMonthMenu = $(this).attr('title');
            selectedMonthMenuForView = $(this).text();
            $("#activeMenu").val(submenu);
            $(submenu).addClass("in active");
            //  daysForMonth();
            //  getMonthDetails('', '');
            $(".selected-chart-icon-color").addClass("selected-chart-icon-color");
            bindMonthGridData('');
        });
        var daymenu = "#dayDataAndChartContainer";
        var daymenuid = "D1";
         var selectedDayMenu = "01";
        function setDayMenus(element) {

            if ($("#mainBody").hasClass("light-mode")) {
                $(".daySubMenu").removeClass("selected-menu-style menu0-select").addClass("other-menu-style");
                $(".daySubMenu").closest('li').find('i').removeClass();
                $(element).removeClass("other-menu-style menu0-select").addClass("selected-menu-style");
            } else {
                $(".daySubMenu").removeClass("selected-menu-style menu0-select").addClass("other-menu-style");
                $(".daySubMenu").closest('li').find('i').removeClass();
                $(element).removeClass("other-menu-style menu0-select").addClass("selected-menu-style");
            }

            $(element).closest('li').find('i').addClass("arrow up");

            daymenu = $(element).attr('href');
            daymenuid = $(element).attr('id');
            selectedDayMenu=$(element).attr('title');
            $(daymenu).addClass("in active");
            //getDayDetails('');
            bindDayGridData('');
        }


        function showhidegraph() {
            if ($("#cbshowhidegraph").prop('checked')) {
                $('.graphSection').css('display', 'block');
                var Height = ($(window).height() * 1) / 2;
                $('.listView').css('height', Height);
                $('.chart-icon-color').css('display', 'inline-block');
                $('.day-chart-icon-color').css('display', 'inline-block');
                $('.month-chart-icon-color').css('display', 'inline-block');
            } else {
                var Height = $(window).height() - 100;
                $('.listView').css('height', Height);
                $('.graphSection').css('display', 'none');
                $('.chart-icon-color').css('display', 'none');
                $('.day-chart-icon-color').css('display', 'none');
                $('.month-chart-icon-color').css('display', 'none');
            }
        }
        function selectColumn() {
            let selectedColumnName = "";
            let checked_checkboxes = $('#cblColumnSelector input:checked');
            checked_checkboxes.each(function () {
                if (selectedColumnName == "") {
                    selectedColumnName = "|" + $(this).val().trim() + "|";
                } else {
                    selectedColumnName = selectedColumnName + ',|' + $(this).val().trim() + "|";
                }
            });
            if ($(".listView").find(".setColumnTbl").length > 0) {
                for (var tblCount = 0; tblCount < $(".listView").find(".setColumnTbl").length; tblCount++) {
                    var tbl = $(".listView").find(".setColumnTbl")[tblCount];
                    for (let i = 1; i < $(tbl).find('th').length; i++) {
                        let th = $(tbl).find('th')[i];
                        let name = "";
                        if ($(th).find('span')[0] == undefined || $(th).find('span')[0] == null) {
                            name = "|" + th.textContent.trim() + "|";
                        }
                        else {
                            name = "|" + $(th).find('span')[0].textContent + "|";
                        }
                        if (selectedColumnName.includes(name)) {
                            $(th).css('display', 'table-cell');
                            for (let j = 1; j < $(tbl).find('tr').length; j++) {
                                let tr = $(tbl).find('tr')[j];
                                let innertd = $(tr).children()[i];
                                $(innertd).css('display', 'table-cell');
                            }
                        } else {
                            $(th).css('display', 'none');
                            for (let j = 1; j < $(tbl).find('tr').length; j++) {
                                let tr = $(tbl).find('tr')[j];
                                let innertd = $(tr).children()[i];
                                $(innertd).css('display', 'none');
                            }
                        }
                    }
                }
            }
            if ($(".cardView").find(".setColumnTbl").length > 0) {
                for (var tblCount = 0; tblCount < $(".cardView").find(".setColumnTbl").length; tblCount++) {
                    var tbl = $(".cardView").find(".setColumnTbl")[tblCount];
                    for (let i = 0; i < $(tbl).find('tr').length; i++) {
                        let tr = $(tbl).find('tr')[i];
                        let name = "";
                        if (i == 0) {
                            name = "|" + $(tr).find('#hdnHeaderName').val().trim() + "|";
                        }
                        else {
                            var td = $(tr).find('td:first-child')[0];
                            if ($(td).find('span')[0] == undefined || $(td).find('span')[0] == null) {
                                name = "|" + $(tr).find('td:first-child')[0].textContent.trim() + "|";
                            }
                            else {
                                name = "|" + $(td).find('span')[0].textContent.trim() + "|";
                            }
                        }
                        if (selectedColumnName.includes(name)) {
                            $(tr).css('display', 'table-row');
                        } else {
                            $(tr).css('display', 'none');
                        }
                    }
                }
            }
            return false;
        }
        function selectRows() {
            if ($(".listView").find("#tblCompanyDashboard").length > 0) {
                //for (let i = 1; i < $('#tblCompanyDashboard tr').length; i++) {
                //    let tr = $('#tblCompanyDashboard tr')[i];
                //    let chkbox = $(tr).find("#cbSelectRows");
                //    if ($(chkbox).prop('checked')) {
                //        $(tr).css('display', 'none');
                //    } else {
                //          $(tr).css('display', 'inline-block');
                //    }
                //}
                let chstr = "";
                let checked_checkboxes = $('#cblRowSelector input:checked');
                checked_checkboxes.each(function () {
                    if (chstr == "") {
                        chstr = $(this).val();
                    } else {
                        chstr = chstr + ',' + $(this).val();
                    }
                });
                for (let i = 1; i < $('#tblCompanyDashboard tr').length; i++) {
                    let tr = $('#tblCompanyDashboard tr')[i];
                    let name = $(tr).find("#name").text();
                    if (chstr.includes(name)) {
                        $(tr).css('display', 'table-row');
                    } else {
                        $(tr).css('display', 'none');
                        // $(tr).css('display', 'inline-block');
                    }
                }
            }
            if ($(".listView").find("#tblPlantDashboard").length > 0) {
                let chstr = "";
                let checked_checkboxes = $('#cblRowSelector input:checked');
                checked_checkboxes.each(function () {
                    if (chstr == "") {
                        chstr = $(this).val();
                    } else {
                        chstr = chstr + ',' + $(this).val();
                    }
                });
                for (let i = 1; i < $('#tblPlantDashboard tr').length; i++) {
                    let tr = $('#tblPlantDashboard tr')[i];
                    let name = $(tr).find("#name").text();
                    if (chstr.includes(name)) {
                        $(tr).css('display', 'table-row');
                    } else {
                        $(tr).css('display', 'none');
                        // $(tr).css('display', 'inline-block');
                    }
                }
            }
            if ($(".listView").find("#tblCellDashboard").length > 0) {
                let chstr = "";
                let checked_checkboxes = $('#cblRowSelector input:checked');
                checked_checkboxes.each(function () {
                    if (chstr == "") {
                        chstr = $(this).val();
                    } else {
                        chstr = chstr + ',' + $(this).val();
                    }
                });
                for (let i = 1; i < $('#tblCellDashboard tr').length; i++) {
                    let tr = $('#tblCellDashboard tr')[i];
                    let name = $(tr).find("#name").text();
                    if (chstr.includes(name)) {
                        $(tr).css('display', 'table-row');
                    } else {
                        $(tr).css('display', 'none');
                        // $(tr).css('display', 'inline-block');
                    }
                }
            }
            if ($(".listView").find("#tblMachineDashboard").length > 0) {
                let chstr = "";
                let checked_checkboxes = $('#cblRowSelector input:checked');
                checked_checkboxes.each(function () {
                    if (chstr == "") {
                        chstr = $(this).val();
                    } else {
                        chstr = chstr + ',' + $(this).val();
                    }
                });
                for (let i = 1; i < $('#tblMachineDashboard tr').length; i++) {
                    let tr = $('#tblMachineDashboard tr')[i];
                    let name = $(tr).find("#name").text();
                    if (chstr.includes(name)) {
                        $(tr).css('display', 'table-row');
                    } else {
                        $(tr).css('display', 'none');
                        // $(tr).css('display', 'inline-block');
                    }
                }
            }
            bindColumnChart();
            //getMonthDetails('');
            //getDayDetails('');
            $('#daychartdatadetails').css('display', 'none');
            $('#monthchartdatadetails').css('display', 'none');
            return false;
        };
        function getDayDetails(param) {
            $('#daychartdatadetails').css('display', 'block');
            if (param == "firstClick") {
                daysForMonth();
                daymenuid = 'D1';
                selectedDayMenu = "01";
            }
            $.ajax({
                async: false,
                type: "POST",
                url: '<%= ResolveUrl("ProductionOEEDashboard.aspx/getDayChartData") %>',
                contentType: "application/json; charset=utf-8",
                crossDomain: true,
                data: '{view: "' + $(hfMainView).val() + '", month:"' + submenuid + '", day:"' + daymenuid + '"}',
                dataType: "json",
                success: function (response) {
                    dataitem = response.d;
                    $("#daygrid").empty();
                    $("#dayData").empty();
                    let chstr = "";
                    let tableForGraph = "";
                    tableForGraph = " <table id='daydatatable'><tr><th></th>";
                    let firsttds = $(".draw-year-graph tr td:first-child");
                    for (let j = 0; j < $(".draw-year-graph tr").length; j++) {
                        let tr = $(".draw-year-graph tr")[j];
                        if ($(tr).css('display') != "none") {
                            let td = $(firsttds)[j - 1];
                            if (chstr == "") {
                                chstr = $(td).text().trim();
                            } else {
                                chstr = chstr + ',' + $(td).text().trim();
                            }
                            tableForGraph += "<th>" + $(td).text().trim() + "</th>";
                        }
                    }
                    let month = "";
                    let tableForGrid = "";
                    tableForGrid = "<table class='P1Table '><tr>";
                    if ($(".listView").find("#tblCompanyDashboard").length > 0) {
                        for (let i = 0; i < $('#tblCompanyDashboard tr th').length; i++) {
                            let th = $('#tblCompanyDashboard tr th')[i];
                            let thname = $(th).text();
                            tableForGrid += "<th>" + thname + "</th>";
                        }
                        tableForGrid += "</tr>";
                        for (let i = 0; i < dataitem.length; i++) {
                            if (chstr.includes(dataitem[i].View)) {
                                tableForGrid += "<tr><td>" + dataitem[i].View + "</td>";
                                tableForGrid += "<td>" + dataitem[i].View + "</td>";
                                tableForGrid += "<td>" + dataitem[i].QE + "</td>";
                                tableForGrid += "<td>" + dataitem[i].AE + "</td>";
                                tableForGrid += "<td>" + dataitem[i].PE + "</td>";
                                tableForGrid += "<td>" + dataitem[i].QE + "</td></tr>";
                            }
                        }
                    }

                    if ($(".listView").find("#tblPlantDashboard").length > 0) {
                        for (let i = 0; i < $('#tblPlantDashboard tr th').length; i++) {
                            let th = $('#tblPlantDashboard tr th')[i];
                            let thname = $(th).text();
                            tableForGrid += "<th>" + thname + "</th>";
                        }
                        tableForGrid += "</tr>";
                        for (let i = 0; i < dataitem.length; i++) {

                            if (chstr.includes(dataitem[i].View)) {
                                tableForGrid += "<tr><td>" + dataitem[i].View + "</td>";
                                tableForGrid += "<td>" + dataitem[i].View + "</td>";
                                tableForGrid += "<td>" + dataitem[i].QE + "</td>";
                                tableForGrid += "<td>" + dataitem[i].AE + "</td>";
                                tableForGrid += "<td>" + dataitem[i].PE + "</td>";
                                tableForGrid += "<td>" + dataitem[i].QE + "</td>";
                                tableForGrid += "<td>" + dataitem[i].QE + "</td>";
                                tableForGrid += "<td>" + dataitem[i].AE + "</td></tr>";
                            }
                        }
                    }

                    if ($(".listView").find("#tblCellDashboard").length > 0) {
                        for (let i = 0; i < $('#tblCellDashboard tr th').length; i++) {
                            let th = $('#tblCellDashboard tr th')[i];
                            let thname = $(th).text();
                            tableForGrid += "<th>" + thname + "</th>";
                        }
                        tableForGrid += "</tr>";
                        for (let i = 0; i < dataitem.length; i++) {

                            if (chstr.includes(dataitem[i].View)) {
                                tableForGrid += "<tr><td>" + dataitem[i].View + "</td>";
                                tableForGrid += "<td>" + dataitem[i].View + "</td>";
                                tableForGrid += "<td>" + dataitem[i].QE + "</td>";
                                tableForGrid += "<td>" + dataitem[i].AE + "</td>";
                                tableForGrid += "<td>" + dataitem[i].PE + "</td>";
                                tableForGrid += "<td>" + dataitem[i].QE + "</td></tr>";
                            }
                        }
                    }
                    if ($(".listView").find("#tblMachineDashboard").length > 0) {
                        for (let i = 0; i < $('#tblMachineDashboard tr th').length; i++) {
                            let th = $('#tblMachineDashboard tr th')[i];
                            let thname = $(th).text();
                            tableForGrid += "<th>" + thname + "</th>";
                        }
                        tableForGrid += "</tr>";
                        for (let i = 0; i < dataitem.length; i++) {

                            if (chstr.includes(dataitem[i].View)) {
                                tableForGrid += "<tr><td>" + dataitem[i].View + "</td>";
                                tableForGrid += "<td>" + dataitem[i].View + "</td>";
                                tableForGrid += "<td>" + dataitem[i].QE + "</td>";
                                tableForGrid += "<td>" + dataitem[i].AE + "</td>";
                                tableForGrid += "<td>" + dataitem[i].PE + "</td>";
                                tableForGrid += "<td>" + dataitem[i].QE + "</td>";
                                tableForGrid += "<td>" + dataitem[i].QE + "</td>";
                                tableForGrid += "<td>" + dataitem[i].AE + "</td>";
                                tableForGrid += "<td>" + dataitem[i].PE + "</td></tr>";
                            }
                        }
                    }
                    tableForGrid += "</table>";
                    $('#dayData').append(tableForGrid);



                    month = "";
                    for (let i = 0; i < dataitem.length; i++) {
                        if (month != dataitem[i].Month) {
                            tableForGraph += "</tr><tr><th>" + dataitem[i].Month + "</th>";
                            month = dataitem[i].Month;
                        }
                        if (chstr.includes(dataitem[i].View)) {
                            tableForGraph += "<td>" + dataitem[i].AE + "</td>";
                        }
                    }
                    tableForGraph += "</tr></table>";
                    $("#daygrid").append(tableForGraph);


                },
                error: function (Result) {
                    alert("Error" + Result);
                }
            });
            Highcharts.chart('dayChart', {
                data: {
                    table: 'daydatatable'
                },
                chart: {
                    type: 'column',
                    zoomType: 'x',
                    events: {
                        render: function () {
                            var color;
                            if ($("#mainBody").hasClass("light-mode")) {
                                color = 'red';
                            } else {
                                color = 'red';
                            }
                            this.title.css({
                                color: color
                            });
                        }
                    }
                },
                credits: {
                    enabled: false
                },
                title: {
                   // text: 'Day Graph',
                    //style: {
                    //    color: 'white'
                    //}
                },
                legend: {
                    useHTML: true,
                    labelFormatter: function () {
                        //return `<span class="span-legend-active" style="border-color:${this.color}">${this.name}</span>`;
                        return `<span class="span-legend-active">${this.name}</span>`;
                    }
                },
                yAxis: {
                    allowDecimals: false,
                    title: {
                        text: ''
                    },
                    className: 'highchart-xyaxis-label'
                },
                xAxis: {
                    title: {
                        // text: dataitem.xAxis
                    },
                    className: 'highchart-xyaxis-label'
                },
                //tooltip: {
                //    formatter: function () {
                //        return '<b>' + this.series.name + '</b><br/>' +
                //            this.point.y + ' ' + this.point.name.toLowerCase();
                //    }
                //}
            });
            if (param == "firstClick") {
                let li = $('#ulDaysForMonth li')[0];
                let daymenu = $(li).find('a').attr('id');
                if ($("#mainBody").hasClass("light-mode")) {
                    $(".daySubMenu").removeClass("selected-menu-style menu0-select").addClass("other-menu-style");
                    $(".daySubMenu").closest('li').find('i').removeClass();
                    $("#" + daymenu).removeClass("other-menu-style menu0-select").addClass("selected-menu-style");
                } else {
                    $(".daySubMenu").removeClass("selected-menu-style menu0-select").addClass("other-menu-style");
                    $(".daySubMenu").closest('li').find('i').removeClass();
                    $("#" + daymenu).removeClass("other-menu-style menu0-select").addClass("selected-menu-style");
                }
                $("#" + daymenu).closest('li').find('i').addClass("arrow up");
                $("#dayDataAndChartContainer").addClass("in active");
                $("#daychartdatadetails").css('height', $("#daychartdatadetails").css('height'));
                var elmnt = document.getElementById("daychartdatadetails");
                elmnt.scrollIntoView();
            }
            return false;
        }
        function getSelectedRows() {
            let chstr = "";
            let firsttds = $(".draw-year-graph tr td:first-child");
            for (let j = 0; j < $(".draw-year-graph tr").length; j++) {
                let tr = $(".draw-year-graph tr")[j];
                if ($(tr).css('display') != "none") {
                    let td = $(firsttds)[j - 1];
                    if (chstr == "") {
                        chstr = $(td).text().trim();
                    } else {
                        chstr = chstr + ',' + $(td).text().trim();
                    }
                }
            }
            return chstr;
        }
        function getDateForDay(month, day) {
                var currentDate = new Date(Date.now());
                var date = (currentDate.getFullYear() - 1) + "-" + month + "-01";;
                if ($("#filterToday").prop('checked') || $("#filterCustomeDay").prop('checked') || $("#filterCurrentMonth").prop('checked') || $("#filterCustomeMonth").prop('checked')) {
                    date = (currentDate.getFullYear() - 1) + "-" + month + "-" + day + "T00:00:00";
                }
                else if ($("#filterCurrentYear").prop('checked')) {

                    date = (currentDate.getFullYear() - 1) + "-" + month + "-" + day + "T00:00:00";
                }
                else if ($("#filterCustomeYear").prop('checked')) {
                    date = $("#txtYear").val() + "-" + month + "-" + day + "T00:00:00";
                }
                return date;
            }
        var dayChartType = "AvgOEE";
        function bindDayGridData(param) {
            $('#daychartdatadetails').css('display', 'block');
            if (param == "firstClick") {
                daysForMonth();
                daymenuid = 'D1';
                dayChartType = "AvgOEE";
                  selectedDayMenu="01";
            }
            $.ajax({
                async: false,
                type: "POST",
                url: '<%= ResolveUrl("ProductionOEEDashboard.aspx/getDayChartData") %>',
                contentType: "application/json; charset=utf-8",
                crossDomain: true,
                data: '{view: "' + $(hfMainView).val() + '", month:"' + submenuid + '", selectedDayMenu:"' + selectedDayMenu + '", selectedMonth:"' + selectedMonthMenu + '", dateforday:"' + getDateForDay(selectedMonthMenu, selectedDayMenu) + '"}',
                dataType: "json",
                success: function (response) {
                    dataitem = response.d;
                    $("#dayData").empty();
                    let chstr = getSelectedRows();
                    let month = "";
                    let tableForGrid = "";
                    tableForGrid = "<table class='P1Table '><tr>";
                    if ($(".listView").find("#tblCompanyDashboard").length > 0) {
                        for (let i = 0; i < $('#tblCompanyDashboard tr th').length; i++) {
                            let th = $('#tblCompanyDashboard tr th')[i];
                            let thname = $(th).find(".header-name").text();
                            let paramforGraph = $(th).find(".param-for-graph").text();
                            if (i >= 2) {
                                tableForGrid += "<th><span class='day-header-name'>" + thname + "</span><i class='glyphicon glyphicon-stats day-chart-icon-color' onclick='dayChartTypeClicked(this)' style='font-size: 15px;'></i><span class='param-for-graph' style='display: none'>" + paramforGraph + "</span></th>";

                            } else {
                                tableForGrid += "<th><span class='day-header-name'>" + thname + "</span></th>";
                            }

                        }
                        tableForGrid += "</tr>";
                        for (let i = 0; i < dataitem.length; i++) {
                            if (chstr.includes(dataitem[i].View)) {
                                tableForGrid += "<tr><td>" + dataitem[i].View + "</td>";
                                tableForGrid += "<td>" + dataitem[i].View + "</td>";
                                tableForGrid += "<td>" + dataitem[i].QE + "</td>";
                                tableForGrid += "<td>" + dataitem[i].AE + "</td>";
                                tableForGrid += "<td>" + dataitem[i].PE + "</td>";
                                tableForGrid += "<td>" + dataitem[i].QE + "</td></tr>";
                            }
                        }
                    }

                   if ($(".listView").find("#tblPlantDashboard").length > 0) {
                        for (let i = 0; i < $('#tblPlantDashboard tr th').length; i++) {
                            let th = $('#tblPlantDashboard tr th')[i];
                            let thname = $(th).find(".header-name").text();
                            let paramforGraph = $(th).find(".param-for-graph").text();
                            if (i >= 2) {
                                 tableForGrid += "<th><span class='day-header-name'>" + thname + "</span><i class='glyphicon glyphicon-stats day-chart-icon-color bar-chart' onclick='dayChartTypeClicked(this)' style='font-size: 15px;'></i><i class='glyphicon glyphicon-random day-chart-icon-color line-chart' onclick='dayChartTypeClicked(this)' style='font-size: 15px;'></i><span class='param-for-graph' style='display: none'>" + paramforGraph + "</span></th>";

                            } else {
                                tableForGrid += "<th><span class='day-header-name'>" + thname + "</span></th>";
                            }
                        }
                        tableForGrid += "</tr>";
                        for (let i = 0; i < dataitem.length; i++) {
                            if (chstr.includes(dataitem[i].Description)) {
                                tableForGrid += "<tr><td>" + dataitem[i].Description + "</td>";
                                tableForGrid += "<td>" + dataitem[i].Description + "</td>";
                                tableForGrid += "<td>" + dataitem[i].OEE + "</td>";
                                tableForGrid += "<td>" + dataitem[i].QualityRate + "</td>";
                                tableForGrid += "<td>" + dataitem[i].Revenue + "</td>";
                                tableForGrid += "<td>" + dataitem[i].LossINR + "</td>";
                                tableForGrid += "<td>" + dataitem[i].Attendance + "</td>";
                                tableForGrid += "<td>" + dataitem[i].SafetyKPI + "</td></tr>";
                            }
                        }
                    }

                    if ($(".listView").find("#tblCellDashboard").length > 0) {
                        for (let i = 0; i < $('#tblCellDashboard tr th').length; i++) {
                            let th = $('#tblCellDashboard tr th')[i];
                            let thname = $(th).find(".header-name").text();
                            let paramforGraph = $(th).find(".param-for-graph").text();
                            if (i >= 2) {
                                tableForGrid += "<th><span class='day-header-name'>" + thname + "</span><i class='glyphicon glyphicon-stats day-chart-icon-color bar-chart' onclick='dayChartTypeClicked(this)' style='font-size: 15px;'></i><i class='glyphicon glyphicon-random day-chart-icon-color line-chart' onclick='dayChartTypeClicked(this)' style='font-size: 15px;'></i><span class='param-for-graph' style='display: none'>" + paramforGraph + "</span></th>";
                            } else {
                                tableForGrid += "<th><span class='day-header-name'>" + thname + "</span></th>";
                            }
                        }
                        tableForGrid += "</tr>";
                        for (let i = 0; i < dataitem.length; i++) {
                            if (chstr.includes(dataitem[i].Description)) {
                                tableForGrid += "<tr><td>" + dataitem[i].Description + "</td>";
                                tableForGrid += "<td>" + dataitem[i].Description + "</td>";
                                tableForGrid += "<td>" + dataitem[i].OEE + "</td>";
                                tableForGrid += "<td>" + dataitem[i].AEffy + "</td>";
                                tableForGrid += "<td>" + dataitem[i].PEffy + "</td>";
                                tableForGrid += "<td>" + dataitem[i].QEffy + "</td></tr>";
                            }
                        }
                    }
                    if ($(".listView").find("#tblMachineDashboard").length > 0) {
                        for (let i = 0; i < $('#tblMachineDashboard tr th').length; i++) {
                            let th = $('#tblMachineDashboard tr th')[i];
                            let thname = $(th).find(".header-name").text();
                            let paramforGraph = $(th).find(".param-for-graph").text();
                            if (i >= 2) {
                                tableForGrid += "<th><span class='day-header-name'>" + thname + "</span><i class='glyphicon glyphicon-stats day-chart-icon-color bar-chart' onclick='dayChartTypeClicked(this)' style='font-size: 15px;'></i><i class='glyphicon glyphicon-random day-chart-icon-color line-chart' onclick='dayChartTypeClicked(this)' style='font-size: 15px;'></i><span class='param-for-graph' style='display: none'>" + paramforGraph + "</span></th>";

                            } else {
                                tableForGrid += "<th><span class='day-header-name'>" + thname + "</span></th>";
                            }
                        }
                        tableForGrid += "</tr>";
                        for (let i = 0; i < dataitem.length; i++) {
                            if (chstr.includes(dataitem[i].Description)) {
                                tableForGrid += "<tr><td>" + dataitem[i].Description + "</td>";
                                tableForGrid += "<td>" + dataitem[i].Description + "</td>";
                                     tableForGrid += "<td>" + dataitem[i].OEE + "</td>";
                                tableForGrid += "<td>" + dataitem[i].AEffy + "</td>";
                                tableForGrid += "<td>" + dataitem[i].PEffy + "</td>";
                                tableForGrid += "<td>" + dataitem[i].QEffy + "</td>";
                                tableForGrid += "<td>" + dataitem[i].AcceptedPart + "</td>";
                                tableForGrid += "<td>" + dataitem[i].RejectCount + "</td>";
                                tableForGrid += "<td>" + dataitem[i].LossINR + "</td></tr>";
                            }
                        }
                    }

                    tableForGrid += "</table>";
                    $('#dayData').append(tableForGrid);

                },
                error: function (Result) {
                    alert("Error" + Result);
                }
            });

            bindDayChartData(dayChartType);

            if (param == "firstClick") {
                let li = $('#ulDaysForMonth li')[0];
                let daymenu = $(li).find('a').attr('id');
                if ($("#mainBody").hasClass("light-mode")) {
                    $(".daySubMenu").removeClass("selected-menu-style menu0-select").addClass("other-menu-style");
                    $(".daySubMenu").closest('li').find('i').removeClass();
                    $("#" + daymenu).removeClass("other-menu-style menu0-select").addClass("selected-menu-style");
                } else {
                    $(".daySubMenu").removeClass("selected-menu-style menu0-select").addClass("other-menu-style");
                    $(".daySubMenu").closest('li').find('i').removeClass();
                    $("#" + daymenu).removeClass("other-menu-style menu0-select").addClass("selected-menu-style");
                }
                $("#" + daymenu).closest('li').find('i').addClass("arrow up");
                $("#dayDataAndChartContainer").addClass("in active");

                //$("#daychartdatadetails").css('height', $("#daychartdatadetails").css('height'));
                // var elmnt = document.getElementById("daychartdatadetails");
                //elmnt.scrollIntoView();
                $('html, body').animate({
                    scrollTop: $("#daychartdatadetails").offset().top - 80
                }, 1250);
            }
            return false;
        }
        function bindDayChartData(param) {

           <%-- let selectedRow = getSelectedRows();
            $.ajax({
                async: false,
                type: "POST",
                url: '<%= ResolveUrl("ProductionOEEDashboard.aspx/getDayChartDetails") %>',
                contentType: "application/json; charset=utf-8",
                crossDomain: true,
                data: '{view: "' + $(hfMainView).val() + '", month:"' + submenuid + '", day:"' + daymenuid + '",param:"' + param + '", selectedRows:"' + selectedRow + '"}',
                dataType: "json",
                success: function (response) {
                    dataitem = response.d;
                    $("#daygrid").empty();
                    $("#daygrid").append(dataitem);
                },
                error: function (Result) {
                    alert("Error" + Result);
                }
            });--%>
            let thIndex;
            let yAxisName = "";
            var yaxis = [];
            var xaxis = [];
            let k = 0;
            for (let i = 0; i < $('#dayData').find('table tr th').length; i++) {
                let th = $('#dayData').find('table tr th')[i];
                let thparam = $(th).find(".param-for-graph").text();
                if (thparam == param) {
                    thIndex = i;
                    yAxisName = $(th).find(".day-header-name").text();
                }
            }

            let datatable = "";
            let headerRow = "<table id='daydatatable'><tr><th></th>";
            let valueRow = "<tr><th>" + daymenuid + "</th>";
            for (let j = 1; j < $('#dayData').find('table tr').length; j++) {
                let tr = $('#dayData').find('table tr')[j];
                let name = $(tr).children()[0];
                let value = $(tr).children()[thIndex];
                headerRow += "<th>" + $(name).text() + "</th>";
                xaxis[k] = $(name).text();
                if (param == "LossINR") {
                    let values = [];
                    values = $(value).text().split(":");
                    let valueInMinute = ((parseInt(values[0]) * 60) + parseInt(values[1]));
                    valueRow += "<td>" + valueInMinute + "</td>";
                    yaxis[k] = valueInMinute;
                } else {
                    valueRow += "<td>" + parseFloat($(value).text().replace(/\,/g, '')) + "</td>";
                    yaxis[k] = parseFloat($(value).text().replace(/\,/g, ''));
                }
                k++;
            }
            headerRow += "</tr>";
            valueRow += "</tr>";
            datatable = headerRow + valueRow + "</table>";
            console.log(datatable);
            $("#daygrid").empty();
            $("#daygrid").append(datatable);

            if (barorlinecharts == "column") {
                let maxvalue;
                if (param == "AvgOEE" || param == "AEEfficiency" || param == "PEEfficiency" || param == "QEEfficiency" || param == "QualityRate") {
                    maxvalue = 90;
                }
                Highcharts.chart('dayChart', {
                    data: {
                        table: 'daydatatable'
                    },
                    chart: {
                        type: 'column',
                        zoomType: 'x',
                        events: {
                            render: function () {
                                var color;
                                if ($("#mainBody").hasClass("light-mode")) {
                                    color = 'red';
                                } else {
                                    color = 'red';
                                }
                                this.title.css({
                                    color: color
                                });
                            }
                        }
                    },
                    credits: {
                        enabled: false
                    },
                    title: {
                        text: '',
                        //style: {
                        //    color: 'white'
                        //}
                    },
                    legend: {
                        useHTML: true,
                        labelFormatter: function () {
                            //return `<span class="span-legend-active" style="border-color:${this.color}">${this.name}</span>`;
                            return `<span class="span-legend-active">${this.name}</span>`;
                        }
                    },
                    yAxis: {
                        allowDecimals: false,
                        max: maxvalue,
                        title: {
                            text: yAxisName
                        },
                        className: 'highchart-xyaxis-label'
                    },
                    xAxis: {
                        title: {
                            // text: dataitem.xAxis
                        },
                        className: 'highchart-xyaxis-label'
                    },
                    //tooltip: {
                    //    formatter: function () {
                    //        return '<b>' + this.series.name + '</b><br/>' +
                    //            this.point.y + ' ' + this.point.name.toLowerCase();
                    //    }
                    //}
                });
            } else {
                Highcharts.chart('dayChart', {
                    chart: {
                        type: 'line',
                        zoomType: 'x'
                    },
                    credits: {
                        enabled: false
                    },
                    title: {
                        text: '',
                        style: {
                            color: 'red'
                        }
                    },
                    legend: {
                        useHTML: true,
                        labelFormatter: function () {
                            //return `<span class="span-legend-active" style="border-color:${this.color}">${this.name}</span>`;
                            return `<span class="span-legend-active">${this.name}</span>`;
                        }
                    },
                    yAxis: {
                        allowDecimals: true,

                        title: {
                            text: yAxisName
                        },
                        className: 'highchart-xyaxis-label'
                    },
                    xAxis: {
                        allowDecimals: false,
                        categories: xaxis,
                        title: {
                            //  text: param
                        },
                        className: 'highchart-xyaxis-label'
                    },
                    plotOptions: {
                        column: {
                            depth: 25,
                            maxPointWidth: 30
                        },

                    },
                    series: [{
                        color: '#1815e8',
                        data: yaxis,
                        showInLegend: false,
                        pointPadding: -0.3
                    }]
                });
            }

            for (let i = 0; i < $('#dayData tr th .param-for-graph').length; i++) {
                let chartTypeValue = $('#dayData tr th .param-for-graph')[i];
                if ($(chartTypeValue).text() == dayChartType) {
                    if (barorlinecharts == "column") {
                        $(chartTypeValue).closest('th').find('.bar-chart').addClass("selected-chart-icon-color");
                    } else {
                        $(chartTypeValue).closest('th').find('.line-chart').addClass("selected-chart-icon-color");
                    }

                }
            }
        }
        function getDateForMonth(month) {
            var currentDate = new Date(Date.now());
            var date = (currentDate.getFullYear() - 1) + "-" + month + "-01";;
            if ($("#filterToday").prop('checked') || $("#filterCustomeDay").prop('checked') || $("#filterCurrentMonth").prop('checked') || $("#filterCustomeMonth").prop('checked')) {
                date = (currentDate.getFullYear() - 1) + "-" + month + "-01";
            }
            else if ($("#filterCurrentYear").prop('checked')) {

                date = (currentDate.getFullYear() - 1) + "-" + month + "-01";
            }
            else if ($("#filterCustomeYear").prop('checked')) {
                date =  $("#txtYear").val() + "-" + month + "-01";
            }
            return date;
        }
        var monthChartType = "AvgOEE";
        function bindMonthGridData(param) {
            $('#monthchartdatadetails').css('display', 'block');
            if (param == "firtClick") {
                submenuid = "jan";
                monthChartType = "AvgOEE";
                selectedMonthMenu = "01";
                selectedMonthMenuForView = "Jan";
            }
            $.ajax({
                async: false,
                type: "POST",
                url: '<%= ResolveUrl("ProductionOEEDashboard.aspx/getMonthChartData") %>',
                contentType: "application/json; charset=utf-8",
                crossDomain: true,
               // data: '{view: "' + $(hfMainView).val() + '", month:"' + submenuid + '", selectedMonth:"'+selectedMonthMenu+'"}',
                  data: '{view: "' + $(hfMainView).val() + '", month:"' + submenuid + '", selectedMonth:"' + selectedMonthMenu + '", dateformonth:"'+getDateForMonth(selectedMonthMenu)+'"}',
                dataType: "json",
                success: function (response) {
                    dataitem = response.d;
                    $("#monthgrid").empty();
                    $("#monthData").empty();
                    let chstr = "";
                    let firsttds = $(".draw-year-graph tr td:first-child");
                    for (let j = 0; j < $(".draw-year-graph tr").length; j++) {
                        let tr = $(".draw-year-graph tr")[j];
                        if ($(tr).css('display') != "none") {
                            let td = $(firsttds)[j - 1];
                            if (chstr == "") {
                                chstr = $(td).text().trim();
                            } else {
                                chstr = chstr + ',' + $(td).text().trim();
                            }
                        }
                    }
                    let tableForGrid = "";
                    tableForGrid = "<table class='P1Table '><tr>";
                    if ($(".listView").find("#tblCompanyDashboard").length > 0) {
                        for (let i = 0; i < $('#tblCompanyDashboard tr th').length; i++) {
                            let th = $('#tblCompanyDashboard tr th')[i];
                            let thname = $(th).find(".header-name").text();
                            let paramforGraph = $(th).find(".param-for-graph").text();
                            if (i >= 2) {
                                tableForGrid += "<th><span class='month-header-name'>" + thname + "</span><i class='glyphicon glyphicon-stats month-chart-icon-color' onclick='monthChartTypeClicked(this)' style='font-size: 15px;'></i><span class='param-for-graph' style='display: none'>" + paramforGraph + "</span></th>";

                            } else {
                                tableForGrid += "<th><span class='month-header-name'>" + thname + "</span></th>";
                            }

                        }
                        tableForGrid += "</tr>";
                        for (let i = 0; i < dataitem.length; i++) {

                            if (chstr.includes(dataitem[i].View)) {
                                tableForGrid += "<tr><td>" + dataitem[i].View + "</td>";
                                tableForGrid += "<td>" + dataitem[i].View + "</td>";
                                tableForGrid += "<td>" + dataitem[i].QE + "</td>";
                                tableForGrid += "<td>" + dataitem[i].AE + "</td>";
                                tableForGrid += "<td>" + dataitem[i].PE + "</td>";
                                tableForGrid += "<td>" + dataitem[i].QE + "</td></tr>";
                            }
                        }
                    }

                    if ($(".listView").find("#tblPlantDashboard").length > 0) {
                        for (let i = 0; i < $('#tblPlantDashboard tr th').length; i++) {
                            let th = $('#tblPlantDashboard tr th')[i];
                            let thname = $(th).find(".header-name").text();
                            let paramforGraph = $(th).find(".param-for-graph").text();
                            if (i >= 2) {
                                tableForGrid += "<th><span class='month-header-name'>" + thname + "</span><i class='glyphicon glyphicon-stats month-chart-icon-color bar-chart' onclick='monthChartTypeClicked(this)' style='font-size: 15px;'></i><i class='glyphicon glyphicon-random month-chart-icon-color line-chart' onclick='monthChartTypeClicked(this)' style='font-size: 15px;'></i><span class='param-for-graph' style='display: none'>" + paramforGraph + "</span></th>";

                            } else {
                                tableForGrid += "<th><span class='month-header-name'>" + thname + "</span></th>";
                            }
                        }
                        tableForGrid += "</tr>";
                        for (let i = 0; i < dataitem.length; i++) {
                            if (chstr.includes(dataitem[i].Description)) {
                                tableForGrid += "<tr><td>" + dataitem[i].Description + "</td>";
                                tableForGrid += "<td>" + dataitem[i].Description + "</td>";
                                tableForGrid += "<td>" + dataitem[i].OEE + "</td>";
                                tableForGrid += "<td>" + dataitem[i].QualityRate + "</td>";
                                tableForGrid += "<td>" + dataitem[i].Revenue + "</td>";
                                tableForGrid += "<td>" + dataitem[i].LossINR + "</td>";
                                tableForGrid += "<td>" + dataitem[i].Attendance + "</td>";
                                tableForGrid += "<td>" + dataitem[i].SafetyKPI + "</td></tr>";
                            }
                        }
                    }

                    if ($(".listView").find("#tblCellDashboard").length > 0) {
                        for (let i = 0; i < $('#tblCellDashboard tr th').length; i++) {
                            let th = $('#tblCellDashboard tr th')[i];
                            let thname = $(th).find(".header-name").text();
                            let paramforGraph = $(th).find(".param-for-graph").text();
                            if (i >= 2) {
                                tableForGrid += "<th><span class='month-header-name'>" + thname + "</span><i class='glyphicon glyphicon-stats month-chart-icon-color bar-chart' onclick='monthChartTypeClicked(this)' style='font-size: 15px;'></i><i class='glyphicon glyphicon-random month-chart-icon-color line-chart' onclick='monthChartTypeClicked(this)' style='font-size: 15px;'></i><span class='param-for-graph' style='display: none'>" + paramforGraph + "</span></th>";

                            } else {
                                tableForGrid += "<th><span class='month-header-name'>" + thname + "</span></th>";
                            }
                        }
                        tableForGrid += "</tr>";
                        for (let i = 0; i < dataitem.length; i++) {
                            if (chstr.includes(dataitem[i].Description)) {
                                tableForGrid += "<tr><td>" + dataitem[i].Description + "</td>";
                                tableForGrid += "<td>" + dataitem[i].Description + "</td>";
                                tableForGrid += "<td>" + dataitem[i].OEE + "</td>";
                                tableForGrid += "<td>" + dataitem[i].AEffy + "</td>";
                                tableForGrid += "<td>" + dataitem[i].PEffy + "</td>";
                                tableForGrid += "<td>" + dataitem[i].QEffy + "</td></tr>";
                            }
                        }
                    }
                    if ($(".listView").find("#tblMachineDashboard").length > 0) {
                        for (let i = 0; i < $('#tblMachineDashboard tr th').length; i++) {
                            let th = $('#tblMachineDashboard tr th')[i];
                            let thname = $(th).find(".header-name").text();
                            let paramforGraph = $(th).find(".param-for-graph").text();
                            if (i >= 2) {
                                tableForGrid += "<th><span class='month-header-name'>" + thname + "</span><i class='glyphicon glyphicon-stats month-chart-icon-color bar-chart' onclick='monthChartTypeClicked(this)' style='font-size: 15px;'></i><i class='glyphicon glyphicon-random month-chart-icon-color line-chart' onclick='monthChartTypeClicked(this)' style='font-size: 15px;'></i><span class='param-for-graph' style='display: none'>" + paramforGraph + "</span></th>";

                            } else {
                                tableForGrid += "<th><span class='month-header-name'>" + thname + "</span></th>";
                            }
                        }
                        tableForGrid += "</tr>";
                        for (let i = 0; i < dataitem.length; i++) {
                            if (chstr.includes(dataitem[i].Description)) {
                                tableForGrid += "<tr><td>" + dataitem[i].Description + "</td>";
                                tableForGrid += "<td>" + dataitem[i].Description + "</td>";
                                     tableForGrid += "<td>" + dataitem[i].OEE + "</td>";
                                tableForGrid += "<td>" + dataitem[i].AEffy + "</td>";
                                tableForGrid += "<td>" + dataitem[i].PEffy + "</td>";
                                tableForGrid += "<td>" + dataitem[i].QEffy + "</td>";
                                tableForGrid += "<td>" + dataitem[i].AcceptedPart + "</td>";
                                tableForGrid += "<td>" + dataitem[i].RejectCount + "</td>";
                                tableForGrid += "<td>" + dataitem[i].LossINR + "</td></tr>";
                            }
                        }
                    }
                    tableForGrid += "</table>";
                    $('#monthData').append(tableForGrid);

                },
                error: function (Result) {
                    alert("Error" + Result);
                }
            });
            bindMonthChartData(monthChartType);
            if (param == "firtClick") {
                let li = $('#ulMonthsForYear li')[0];
                let daymenu = $(li).find('a').attr('id');
                if ($("#mainBody").hasClass("light-mode")) {
                    $(".submenuData").removeClass("selected-menu-style menu0-select").addClass("other-menu-style");
                    $(".submenuData").closest('li').find('i').removeClass();
                    $("#" + daymenu).removeClass("other-menu-style menu0-select").addClass("selected-menu-style");
                } else {
                    $(".submenuData").removeClass("selected-menu-style menu0-select").addClass("other-menu-style");
                    $(".submenuData").closest('li').find('i').removeClass();
                    $("#" + daymenu).removeClass("other-menu-style menu0-select").addClass("selected-menu-style");
                }
                $("#" + daymenu).closest('li').find('i').addClass("arrow up");
                $("#monthDataAndChartContainer").addClass("in active");

                //$("#monthchartdatadetails").css('height', $("#monthchartdatadetails").css('height'));
                //var elmnt = document.getElementById("monthchartdatadetails");
                //elmnt.scrollIntoView();

                $('html, body').animate({
                    scrollTop: $("#monthchartdatadetails").offset().top - 80
                }, 1250);

                daysForMonth();
            }

            return false;
        }

        function bindMonthChartData(param) {
            //let selectedRow = getSelectedRows();
            //let table = $('#monthData').find('table');
            let thIndex;
            let yAxisName = "";
            var yaxis = [];
            var xaxis = [];
            let k = 0;
            //for (let i = 0; i < dataitem.xAxis.length; i++) {
            //    if (chstr.includes(dataitem.xAxis[i])) {
            //        xaxis[k] = dataitem.xAxis[i];
            //        yaxis[k] = dataitem.yAxis[i];
            //        k++;
            //    }
            //}
            for (let i = 0; i < $('#monthData').find('table tr th').length; i++) {
                let th = $('#monthData').find('table tr th')[i];
                let thparam = $(th).find(".param-for-graph").text();
                if (thparam == param) {
                    thIndex = i;
                    yAxisName = $(th).find(".month-header-name").text();
                }
            }

            let datatable = "";
            let headerRow = "<table id='datatable'><tr><th></th>";
            let valueRow = "<tr><th>" + selectedMonthMenuForView + "</th>";
            for (let j = 1; j < $('#monthData').find('table tr').length; j++) {
                let tr = $('#monthData').find('table tr')[j];
                let name = $(tr).children()[0];
                let value = $(tr).children()[thIndex];
                headerRow += "<th>" + $(name).text() + "</th>";
                xaxis[k] = $(name).text();
                if (param == "LossINR") {
                    let values = [];
                    values = $(value).text().split(":");
                    let valueInMinute = ((parseInt(values[0]) * 60) + parseInt(values[1]));
                    valueRow += "<td>" + valueInMinute + "</td>";
                    yaxis[k] = valueInMinute;
                } else {
                   
                    valueRow += "<td>" + parseFloat($(value).text().replace(/\,/g, '')) + "</td>";
                      yaxis[k] =  parseFloat($(value).text().replace(/\,/g, ''));
                }
                k++;
            }
            headerRow += "</tr>";
            valueRow += "</tr>";
            datatable = headerRow + valueRow + "</table>";
            console.log(datatable);
            $("#monthgrid").empty();
            $("#monthgrid").append(datatable);
           
            if (barorlinecharts == "column") {
                 let maxvalue;
                if (param == "AvgOEE" || param == "AEEfficiency" || param == "PEEfficiency" || param == "QEEfficiency" || param == "QualityRate") {
                    maxvalue = 110;
                }
                Highcharts.chart('monthChart', {
                    data: {
                        table: 'datatable'
                    },
                    chart: {
                        type: barorlinecharts,
                        zoomType: 'x',
                        events: {
                            render: function () {
                                var color;
                                if ($("#mainBody").hasClass("light-mode")) {
                                    color = 'red';
                                } else {
                                    color = 'red';
                                }
                                this.title.css({
                                    color: color
                                });
                            }
                        }
                    },
                    credits: {
                        enabled: false
                    },
                    title: {
                        text: '',
                        //style: {
                        //    color: 'white'
                        //}
                    },
                    legend: {
                        useHTML: true,
                        labelFormatter: function () {
                            //return `<span class="span-legend-active" style="border-color:${this.color}">${this.name}</span>`;
                            return `<span class="span-legend-active">${this.name}</span>`;
                        }
                    },
                    yAxis: {
                        allowDecimals: false,
                        max: maxvalue,
                        title: {
                            text: yAxisName
                        },
                        className: 'highchart-xyaxis-label'
                    },
                    xAxis: {
                        title: {
                            // text: dataitem.xAxis
                        },
                        className: 'highchart-xyaxis-label'
                    },
                });
            } else {
                   Highcharts.chart('monthChart', {
                    chart: {
                        type: 'line',
                        zoomType: 'x'
                    },
                    credits: {
                        enabled: false
                    },
                    title: {
                        text: '',
                        style: {
                            color: 'red'
                        }
                    },
                    legend: {
                        useHTML: true,
                        labelFormatter: function () {
                            //return `<span class="span-legend-active" style="border-color:${this.color}">${this.name}</span>`;
                            return `<span class="span-legend-active">${this.name}</span>`;
                        }
                    },
                    yAxis: {
                        allowDecimals: true,
                      
                        title: {
                            text: yAxisName
                        },
                        className: 'highchart-xyaxis-label'
                    },
                    xAxis: {
                        allowDecimals: false,
                        categories: xaxis,
                        title: {
                            //  text: param
                        },
                        className: 'highchart-xyaxis-label'
                    },
                    plotOptions: {
                        column: {
                            depth: 25,
                            maxPointWidth: 30
                        },

                    },
                    series: [{
                        color: '#1815e8',
                        data: yaxis,
                        showInLegend: false,
                        pointPadding: -0.3
                    }]
                });
            }
       
            for (let i = 0; i < $('#monthData tr th .param-for-graph').length; i++) {
                let chartTypeValue = $('#monthData tr th .param-for-graph')[i];
                if ($(chartTypeValue).text() == monthChartType) {
                    if (barorlinecharts == "column") {
                        $(chartTypeValue).closest('th').find('.bar-chart').addClass("selected-chart-icon-color");
                    } else {
                          $(chartTypeValue).closest('th').find('.line-chart').addClass("selected-chart-icon-color");
                    }
                }
            }
        }
        function getDateForYear() {
            var currentDate = new Date(Date.now());
            var date = (currentDate.getFullYear() - 1) + "-01-01";;
            if ($("#filterToday").prop('checked') || $("#filterCustomeDay").prop('checked') || $("#filterCurrentMonth").prop('checked') || $("#filterCustomeMonth").prop('checked')) {
                date = (currentDate.getFullYear() - 1) + "-01-01";
            }
            else if ($("#filterCurrentYear").prop('checked')) {

                date = (currentDate.getFullYear() - 1) + "-01-01";
            }
            else if ($("#filterCustomeYear").prop('checked')) {
                date =  $("#txtYear").val() + "-01-01";
            }
            return date;
        }

        function passParamForYearGraph() {
            var th = $(".P1Table tr:first-child th").children()[3];
            selectedChartTypeforView = $(th).closest('th').find(".header-name").text();
            if (barorlinecharts == "line") {
                barorlinecharts = "line";
                $(th).closest("th").find(".line-chart").addClass("selected-chart-icon-color");
            } else {
                barorlinecharts = "column";
                $(th).closest("th").find(".bar-chart").addClass("selected-chart-icon-color");
            }
            bindColumnChart($(th).closest('th').find(".param-for-graph").text());
        }
        function bindColumnChart(param) {
            var dataitem;
            var yaxis = [];
            var xaxis = [];
            $.ajax({
                async: false,
                type: "POST",
                url: '<%= ResolveUrl("ProductionOEEDashboard.aspx/getYearChartData") %>',
                contentType: "application/json; charset=utf-8",
                crossDomain: true,
                data: '{view: "' + $(hfMainView).val() + '", param:"' + param + '",dateforYear :"'+getDateForYear()+'"}',
                dataType: "json",
                success: function (response) {
                    dataitem = response.d;
                    //xaxis = dataitem.xAxis;
                    //yaxis = dataitem.yAxis;
                    let chstr = "";
                    //let checked_checkboxes = $('#cblRowSelector input:checked');
                    //checked_checkboxes.each(function () {
                    //    if (chstr == "") {
                    //        debugger;
                    //        chstr = $(this).val();
                    //    } else {
                    //        chstr = chstr + ',' + $(this).val();
                    //    }
                    //});
                    let firsttds = $(".draw-year-graph tr td:first-child");
                    for (let j = 0; j < $(".draw-year-graph tr").length; j++) {
                        let tr = $(".draw-year-graph tr")[j];
                        if ($(tr).css('display') != "none") {
                            let td = $(firsttds)[j - 1];
                            if (chstr == "") {
                                chstr = $(td).text().trim();
                            } else {
                                chstr = chstr + ',' + $(td).text().trim();
                            }
                        }
                    }
                    let k = 0;
                    for (let i = 0; i < dataitem.xAxis.length; i++) {
                        if (chstr.includes(dataitem.xAxis[i])) {
                            xaxis[k] = dataitem.xAxis[i];
                            yaxis[k] = dataitem.yAxis[i];
                            k++;
                        }
                    }
                },
                error: function (Result) {
                    alert("Error" + Result);
                }
            });
            console.log(xaxis);
            console.log(yaxis);
            let maxvalue;
            if (barorlinecharts == "column") {
                if (param == "AvgOEE" || param == "AEEfficiency" || param == "PEEfficiency" || param == "QEEfficiency" || param == "QualityRate") {
                    maxvalue = 110;
                }
            }
            Highcharts.chart('yearChart', {
                chart: {
                    type: barorlinecharts,

                    zoomType: 'x'
                    //options3d: {
                    //    enabled: true,
                    //    alpha: 15,
                    //    beta: 15,
                    //    depth: 50,
                    //    viewDistance: 25
                    //}
                },
                credits: {
                    enabled: false
                },
                title: {
                    text: '',
                    style: {
                        color: 'red'
                    }
                },
                legend: {
                    useHTML: true,
                    labelFormatter: function () {
                        //return `<span class="span-legend-active" style="border-color:${this.color}">${this.name}</span>`;
                        return `<span class="span-legend-active">${this.name}</span>`;
                    }
                },
                yAxis: {
                    allowDecimals: true,
                    max: maxvalue,
                    title: {
                        text: selectedChartTypeforView
                    },
                    className: 'highchart-xyaxis-label'
                },
                xAxis: {
                    allowDecimals: false,
                    categories: xaxis,
                    title: {
                        //  text: param
                    },
                    className: 'highchart-xyaxis-label'
                },
                plotOptions: {
                    column: {
                        depth: 25,
                        maxPointWidth: 30
                    },

                },
                series: [{
                    color: '#1815e8',
                    data: yaxis,
                    showInLegend: false,
                    pointPadding: -0.3
                }]
            });

            showhidegraph();
            //for (let i = 0; i < $('.draw-year-graph tr th .param-for-graph').length; i++) {
            //    let chartTypeValue = $('.draw-year-graph tr th .param-for-graph')[i];
            //    if ($(chartTypeValue).text() == dayChartType) {
            //        $(chartTypeValue).closest('th').find('.chart-icon-color').addClass("selected-chart-icon-color");
            //    }
            //}

            return false;
        };



        $('[id$=txtMonth]').datepicker({
            viewMode: "months",
            minViewMode: "months",
            format: 'mm',
            todayHighlight: true,
            autoclose: true,
            language: 'en-US',
        });
        $('[id$=txtDay]').datepicker({
            viewMode: "days",
            minViewMode: "days",
            format: 'dd',
            todayHighlight: true,
            autoclose: true,
            language: 'en-US',
        });
        $('[id$=txtYear]').datepicker({
            minViewMode: 2,
            format: 'yyyy',
            todayHighlight: true,
            autoclose: true,
            language: 'en-US',
        });
        $('[id$=txtCustomDay]').datepicker({
            viewMode: "days",
            minViewMode: "days",
            format: 'dd',
            todayHighlight: true,
            autoclose: true,
            language: 'en-US',
        });
        function showhideCustomeDetails(element, param, divid) {
            if (divid != "") {
                if ($("#" + param).prop('checked')) {
                    $(".filter-checkbox input").prop('checked', false);
                    $("#" + param).prop('checked', true);
                    $(".filterCustomeDiv").css("display", "none");
                    $("#" + divid).css("display", "block");
                } else {
                    $("#" + divid).css("display", "none");
                }

            }
            else {
                if ($("#" + param).prop('checked')) {
                    $(".filter-checkbox input").prop('checked', false);
                    $("#" + param).prop('checked', true);
                }
                $(".filterCustomeDiv").css("display", "none");
            }


        }
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
        function showViews(param) {
            if (param == "CardView") {
                $('.cardView').css('display', 'block');
                $('.listView').css('display', 'none');
                $('.graphSection').css('display', 'none');
                $('#hfView').val('CardView');
            } else {
                $('.listView').css('display', 'block');
                $('.cardView').css('display', 'none');
                $('.graphSection').css('display', 'block');
                $('#hfView').val('ListView');
                showhidegraph();
            }
        }


        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
            $(document).ready(function () {
                $(submenu).addClass("in active");
                $(submenu).removeClass("selected-menu-style").addClass("menu0-select");
                $(submenu).closest('li').find('i').addClass("arrow up");

                $("#monthData").css('height', ($(window).height() - 480));
                $("#dayData").css('height', ($(window).height() - 480));
            });
            $('#cblRowSelector tr td').click(function () {
                debugger;
                var CHK = document.getElementById("cblRowSelector");
                var checkbox = CHK.getElementsByTagName("input");
                var label = CHK.getElementsByTagName("label");
                var counter = 0;
                if ($(this).children()[1].innerHTML == "Select All") {
                    if (checkbox[0].checked == true) {
                        for (var i = 1; i < checkbox.length; i++) {
                            checkbox[i].checked = true;
                        }
                    }
                    else {
                        for (var i = 1; i < checkbox.length; i++) {
                            checkbox[i].checked = false;
                        }
                    }
                }
                else {
                    if ($(this).children()[0].checked == false) {
                        checkbox[0].checked = false;
                    }
                    else {
                        var checkedCount = 0;
                        for (var i = 1; i < checkbox.length; i++) {
                            if (checkbox[i].checked) {
                                checkedCount++;
                            }
                        }
                        if (checkedCount == checkbox.length - 1) {
                            checkbox[0].checked = true;
                        }
                        else {
                            checkbox[0].checked = false;
                        }
                    }
                }
            });
            $(window).resize(function () {                $("#monthData").css('height', ($(window).height() - 480));
                $("#dayData").css('height', ($(window).height() - 480));            });
            $(".chart-icon-color").click(function () {
                debugger;
                let selectedChartID = $(this).attr('id');
                let selectedGraph = $(this).closest('th').find(".param-for-graph").text();
                $(".chart-icon-color").removeClass("selected-chart-icon-color");
             
                selectedChartTypeforView = $(this).closest('th').find(".header-name").text();
                if ($(this).hasClass("line-chart")) {
                    barorlinecharts = "line";
                    $(this).closest("th").find(".line-chart").addClass("selected-chart-icon-color");
                } else {
                    barorlinecharts = "column";
                    $(this).closest("th").find(".bar-chart").addClass("selected-chart-icon-color");
                }
                bindColumnChart(selectedGraph);
            });

            function monthChartTypeClicked(element) {
                debugger;
                let selectedChartID = $(element).attr('id');
                let selectedGraph = $(element).closest('th').find(".param-for-graph").text();
                $(".month-chart-icon-color").removeClass("selected-chart-icon-color");
               // $(element).closest('th').find("i").addClass("selected-chart-icon-color");
                monthChartType = selectedGraph;
                if ($(element).hasClass("line-chart")) {
                    barorlinecharts = "line";
                    $(element).closest('th').find(".line-chart").addClass("selected-chart-icon-color");
                } else {
                    barorlinecharts = "column";
                    $(element).closest('th').find(".bar-chart").addClass("selected-chart-icon-color");
                }
                bindMonthChartData(selectedGraph);
            }
            function dayChartTypeClicked(element) {
                let selectedChartID = $(element).attr('id');
                let selectedGraph = $(element).closest('th').find(".param-for-graph").text();
                $(".day-chart-icon-color").removeClass("selected-chart-icon-color");
                //$(element).closest('th').find("i").addClass("selected-chart-icon-color");
                dayChartType = selectedGraph;
                if ($(element).hasClass("line-chart")) {
                    barorlinecharts = "line";
                    $(element).closest('th').find(".line-chart").addClass("selected-chart-icon-color");
                } else {
                    barorlinecharts = "column";
                    $(element).closest('th').find(".bar-chart").addClass("selected-chart-icon-color");
                }
                bindDayChartData(selectedGraph);
            }

            $("#cbshowhidegraph").change(function () {
                //if ($("#cbshowhidegraph").prop('checked')) {
                //    $('.graphSection').css('display', 'block');
                //    var Height = $(window).height() - (600);
                //    $('.listView').css('height', Height);
                //        $('.chart-icon-color').css('display', 'inline-block');
                //    $('.day-chart-icon-color').css('display', 'inline-block');
                //    $('.month-chart-icon-color').css('display', 'inline-block');
                //} else {
                //    var Height = $(window).height()-100;
                //    $('.listView').css('height', Height);
                //    $('.graphSection').css('display', 'none');
                //       $('.chart-icon-color').css('display', 'none');
                //$('.day-chart-icon-color').css('display', 'none');
                //$('.month-chart-icon-color').css('display', 'none');
                //}
                showhidegraph();
            });
            $('[id$=txtMonth]').datepicker({
                viewMode: "months",
                minViewMode: "months",
                format: 'mm',
                todayHighlight: true,
                autoclose: true,
                language: 'en-US',
            });
            $('[id$=txtDay]').datepicker({
                viewMode: "days",
                minViewMode: "days",
                format: 'dd',
                todayHighlight: true,
                autoclose: true,
                language: 'en-US',
            });
            $('[id$=txtYear]').datepicker({
                minViewMode: 2,
                format: 'yyyy',
                todayHighlight: true,
                autoclose: true,
                language: 'en-US',
            });
            $('[id$=txtCustomDay]').datepicker({
                viewMode: "days",
                minViewMode: "days",
                format: 'dd',
                todayHighlight: true,
                autoclose: true,
                language: 'en-US',
            });
            function showhideCustomeDetails(element, param, divid) {
                if (divid != "") {
                    if ($("#" + param).prop('checked')) {
                        $(".filter-checkbox input").prop('checked', false);
                        $("#" + param).prop('checked', true);
                        $(".filterCustomeDiv").css("display", "none");
                        $("#" + divid).css("display", "block");
                    } else {
                        $("#" + divid).css("display", "none");
                    }

                }
                else {
                    if ($("#" + param).prop('checked')) {
                        $(".filter-checkbox input").prop('checked', false);
                        $("#" + param).prop('checked', true);
                    }
                    $(".filterCustomeDiv").css("display", "none");
                }


            }
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
            function showViews(param) {
                if (param == "CardView") {
                    $('.cardView').css('display', 'block');
                    $('.listView').css('display', 'none');
                    $('#hfView').val('CardView');
                } else {
                    $('.listView').css('display', 'block');
                    $('.cardView').css('display', 'none');
                    $('#hfView').val('ListView');
                }
            }

            $(".submenuData").click(function () {
                if ($("#mainBody").hasClass("light-mode")) {
                    $(".submenuData").removeClass("selected-menu-style menu0-select").addClass("other-menu-style");
                    $(".submenuData").closest('li').find('i').removeClass();
                    $(this).removeClass("other-menu-style menu0-select").addClass("selected-menu-style");
                } else {
                    $(".submenuData").removeClass("selected-menu-style menu0-select").addClass("other-menu-style");
                    $(".submenuData").closest('li').find('i').removeClass();
                    $(this).removeClass("other-menu-style menu0-select").addClass("selected-menu-style");
                }

                $(this).closest('li').find('i').addClass("arrow up");

                submenu = $(this).attr('href');
                submenuid = $(this).attr('id');
                selectedMonthMenu = $(this).attr('title');
                selectedMonthMenuForView = $(this).text();
                $("#activeMenu").val(submenu);
                $(submenu).addClass("in active");
                //  daysForMonth();
                //  getMonthDetails('', '');
                bindMonthGridData('');
            });
            function setDayMenus(element) {

                if ($("#mainBody").hasClass("light-mode")) {
                    $(".daySubMenu").removeClass("selected-menu-style menu0-select").addClass("other-menu-style");
                    $(".daySubMenu").closest('li').find('i').removeClass();
                    $(element).removeClass("other-menu-style menu0-select").addClass("selected-menu-style");
                } else {
                    $(".daySubMenu").removeClass("selected-menu-style menu0-select").addClass("other-menu-style");
                    $(".daySubMenu").closest('li').find('i').removeClass();
                    $(element).removeClass("other-menu-style menu0-select").addClass("selected-menu-style");
                }

                $(element).closest('li').find('i').addClass("arrow up");

                daymenu = $(element).attr('href');
                daymenuid = $(element).attr('id');
                debugger;
                selectedDayMenu = $(element).attr('title');
                $(daymenu).addClass("in active");
                bindDayGridData('');
            }

            function getDateForDay(month, day) {
                var currentDate = new Date(Date.now());
                var date = (currentDate.getFullYear() - 1) + "-" + month + "-01";;
                if ($("#filterToday").prop('checked') || $("#filterCustomeDay").prop('checked') || $("#filterCurrentMonth").prop('checked') || $("#filterCustomeMonth").prop('checked')) {
                    date = (currentDate.getFullYear() - 1) + "-" + month + "-" + day + "T00:00:00";
                }
                else if ($("#filterCurrentYear").prop('checked')) {

                    date = (currentDate.getFullYear() - 1) + "-" + month + "-" + day + "T00:00:00";
                }
                else if ($("#filterCustomeYear").prop('checked')) {
                    date =  $("#txtYear").val() + "-" + month + "-" + day + "T00:00:00";
                }
                return date;
            }
          function bindDayGridData(param) {
            $('#daychartdatadetails').css('display', 'block');
            if (param == "firstClick") {
                daysForMonth();
                daymenuid = 'D1';
                dayChartType = "AvgOEE";
                  selectedDayMenu="01";
            }
            $.ajax({
                async: false,
                type: "POST",
                url: '<%= ResolveUrl("ProductionOEEDashboard.aspx/getDayChartData") %>',
                contentType: "application/json; charset=utf-8",
                crossDomain: true,
                data: '{view: "' + $(hfMainView).val() + '", month:"' + submenuid + '", selectedDayMenu:"' + selectedDayMenu + '", selectedMonth:"' + selectedMonthMenu + '", dateforday:"' + getDateForDay(selectedMonthMenu, selectedDayMenu) + '"}',
                dataType: "json",
                success: function (response) {
                    dataitem = response.d;
                    $("#dayData").empty();
                    let chstr = getSelectedRows();
                    let month = "";
                    let tableForGrid = "";
                    tableForGrid = "<table class='P1Table '><tr>";
                    if ($(".listView").find("#tblCompanyDashboard").length > 0) {
                        for (let i = 0; i < $('#tblCompanyDashboard tr th').length; i++) {
                            let th = $('#tblCompanyDashboard tr th')[i];
                            let thname = $(th).find(".header-name").text();
                            let paramforGraph = $(th).find(".param-for-graph").text();
                            if (i >= 2) {
                                tableForGrid += "<th><span class='day-header-name'>" + thname + "</span><i class='glyphicon glyphicon-stats day-chart-icon-color' onclick='dayChartTypeClicked(this)' style='font-size: 15px;'></i><span class='param-for-graph' style='display: none'>" + paramforGraph + "</span></th>";

                            } else {
                                tableForGrid += "<th><span class='day-header-name'>" + thname + "</span></th>";
                            }

                        }
                        tableForGrid += "</tr>";
                        for (let i = 0; i < dataitem.length; i++) {
                            if (chstr.includes(dataitem[i].View)) {
                                tableForGrid += "<tr><td>" + dataitem[i].View + "</td>";
                                tableForGrid += "<td>" + dataitem[i].View + "</td>";
                                tableForGrid += "<td>" + dataitem[i].QE + "</td>";
                                tableForGrid += "<td>" + dataitem[i].AE + "</td>";
                                tableForGrid += "<td>" + dataitem[i].PE + "</td>";
                                tableForGrid += "<td>" + dataitem[i].QE + "</td></tr>";
                            }
                        }
                    }

                   if ($(".listView").find("#tblPlantDashboard").length > 0) {
                        for (let i = 0; i < $('#tblPlantDashboard tr th').length; i++) {
                            let th = $('#tblPlantDashboard tr th')[i];
                            let thname = $(th).find(".header-name").text();
                            let paramforGraph = $(th).find(".param-for-graph").text();
                            if (i >= 2) {
                                 tableForGrid += "<th><span class='day-header-name'>" + thname + "</span><i class='glyphicon glyphicon-stats day-chart-icon-color bar-chart' onclick='dayChartTypeClicked(this)' style='font-size: 15px;'></i><i class='glyphicon glyphicon-random day-chart-icon-color line-chart' onclick='dayChartTypeClicked(this)' style='font-size: 15px;'></i></i><span class='param-for-graph' style='display: none'>" + paramforGraph + "</span></th>";

                            } else {
                                tableForGrid += "<th><span class='day-header-name'>" + thname + "</span></th>";
                            }
                        }
                        tableForGrid += "</tr>";
                        for (let i = 0; i < dataitem.length; i++) {
                            if (chstr.includes(dataitem[i].Description)) {
                                tableForGrid += "<tr><td>" + dataitem[i].Description + "</td>";
                                tableForGrid += "<td>" + dataitem[i].Description + "</td>";
                                tableForGrid += "<td>" + dataitem[i].OEE + "</td>";
                                tableForGrid += "<td>" + dataitem[i].QualityRate + "</td>";
                                tableForGrid += "<td>" + dataitem[i].Revenue + "</td>";
                                tableForGrid += "<td>" + dataitem[i].LossINR + "</td>";
                                tableForGrid += "<td>" + dataitem[i].Attendance + "</td>";
                                tableForGrid += "<td>" + dataitem[i].SafetyKPI + "</td></tr>";
                            }
                        }
                    }

                    if ($(".listView").find("#tblCellDashboard").length > 0) {
                        for (let i = 0; i < $('#tblCellDashboard tr th').length; i++) {
                            let th = $('#tblCellDashboard tr th')[i];
                            let thname = $(th).find(".header-name").text();
                            let paramforGraph = $(th).find(".param-for-graph").text();
                            if (i >= 2) {
                                tableForGrid += "<th><span class='day-header-name'>" + thname + "</span><i class='glyphicon glyphicon-stats day-chart-icon-color bar-chart' onclick='dayChartTypeClicked(this)' style='font-size: 15px;'></i><i class='glyphicon glyphicon-random day-chart-icon-color line-chart' onclick='dayChartTypeClicked(this)' style='font-size: 15px;'></i><span class='param-for-graph' style='display: none'>" + paramforGraph + "</span></th>";
                            } else {
                                tableForGrid += "<th><span class='day-header-name'>" + thname + "</span></th>";
                            }
                        }
                        tableForGrid += "</tr>";
                        for (let i = 0; i < dataitem.length; i++) {
                            if (chstr.includes(dataitem[i].Description)) {
                                tableForGrid += "<tr><td>" + dataitem[i].Description + "</td>";
                                tableForGrid += "<td>" + dataitem[i].Description + "</td>";
                                tableForGrid += "<td>" + dataitem[i].OEE + "</td>";
                                tableForGrid += "<td>" + dataitem[i].AEffy + "</td>";
                                tableForGrid += "<td>" + dataitem[i].PEffy + "</td>";
                                tableForGrid += "<td>" + dataitem[i].QEffy + "</td></tr>";
                            }
                        }
                    }
                    if ($(".listView").find("#tblMachineDashboard").length > 0) {
                        for (let i = 0; i < $('#tblMachineDashboard tr th').length; i++) {
                            let th = $('#tblMachineDashboard tr th')[i];
                            let thname = $(th).find(".header-name").text();
                            let paramforGraph = $(th).find(".param-for-graph").text();
                            if (i >= 2) {
                                tableForGrid += "<th><span class='day-header-name'>" + thname + "</span><i class='glyphicon glyphicon-stats day-chart-icon-color bar-chart' onclick='dayChartTypeClicked(this)' style='font-size: 15px;'></i><i class='glyphicon glyphicon-random day-chart-icon-color line-chart' onclick='dayChartTypeClicked(this)' style='font-size: 15px;'></i><span class='param-for-graph' style='display: none'>" + paramforGraph + "</span></th>";

                            } else {
                                tableForGrid += "<th><span class='day-header-name'>" + thname + "</span></th>";
                            }
                        }
                        tableForGrid += "</tr>";
                        for (let i = 0; i < dataitem.length; i++) {
                            if (chstr.includes(dataitem[i].Description)) {
                                tableForGrid += "<tr><td>" + dataitem[i].Description + "</td>";
                                tableForGrid += "<td>" + dataitem[i].Description + "</td>";
                                     tableForGrid += "<td>" + dataitem[i].OEE + "</td>";
                                tableForGrid += "<td>" + dataitem[i].AEffy + "</td>";
                                tableForGrid += "<td>" + dataitem[i].PEffy + "</td>";
                                tableForGrid += "<td>" + dataitem[i].QEffy + "</td>";
                                tableForGrid += "<td>" + dataitem[i].AcceptedPart + "</td>";
                                tableForGrid += "<td>" + dataitem[i].RejectCount + "</td>";
                                tableForGrid += "<td>" + dataitem[i].LossINR + "</td></tr>";
                            }
                        }
                    }

                    tableForGrid += "</table>";
                    $('#dayData').append(tableForGrid);

                },
                error: function (Result) {
                    alert("Error" + Result);
                }
            });

            bindDayChartData(dayChartType);

            if (param == "firstClick") {
                let li = $('#ulDaysForMonth li')[0];
                let daymenu = $(li).find('a').attr('id');
                if ($("#mainBody").hasClass("light-mode")) {
                    $(".daySubMenu").removeClass("selected-menu-style menu0-select").addClass("other-menu-style");
                    $(".daySubMenu").closest('li').find('i').removeClass();
                    $("#" + daymenu).removeClass("other-menu-style menu0-select").addClass("selected-menu-style");
                } else {
                    $(".daySubMenu").removeClass("selected-menu-style menu0-select").addClass("other-menu-style");
                    $(".daySubMenu").closest('li').find('i').removeClass();
                    $("#" + daymenu).removeClass("other-menu-style menu0-select").addClass("selected-menu-style");
                }
                $("#" + daymenu).closest('li').find('i').addClass("arrow up");
                $("#dayDataAndChartContainer").addClass("in active");

                //$("#daychartdatadetails").css('height', $("#daychartdatadetails").css('height'));
                // var elmnt = document.getElementById("daychartdatadetails");
                //elmnt.scrollIntoView();
                $('html, body').animate({
                    scrollTop: $("#daychartdatadetails").offset().top - 80
                }, 1250);
            }
            return false;
        }
            function bindDayChartData(param) {

           <%-- let selectedRow = getSelectedRows();
            $.ajax({
                async: false,
                type: "POST",
                url: '<%= ResolveUrl("ProductionOEEDashboard.aspx/getDayChartDetails") %>',
                contentType: "application/json; charset=utf-8",
                crossDomain: true,
                data: '{view: "' + $(hfMainView).val() + '", month:"' + submenuid + '", day:"' + daymenuid + '",param:"' + param + '", selectedRows:"' + selectedRow + '"}',
                dataType: "json",
                success: function (response) {
                    dataitem = response.d;
                    $("#daygrid").empty();
                    $("#daygrid").append(dataitem);
                },
                error: function (Result) {
                    alert("Error" + Result);
                }
            });--%>
                let thIndex;
                let yAxisName = "";
                var yaxis = [];
                var xaxis = [];
                let k = 0;
                for (let i = 0; i < $('#dayData').find('table tr th').length; i++) {
                    let th = $('#dayData').find('table tr th')[i];
                    let thparam = $(th).find(".param-for-graph").text();
                    if (thparam == param) {
                        thIndex = i;
                        yAxisName = $(th).find(".day-header-name").text();
                    }
                }

                let datatable = "";
                let headerRow = "<table id='daydatatable'><tr><th></th>";
                let valueRow = "<tr><th>" + daymenuid + "</th>";
                for (let j = 1; j < $('#dayData').find('table tr').length; j++) {
                    let tr = $('#dayData').find('table tr')[j];
                    let name = $(tr).children()[0];
                    let value = $(tr).children()[thIndex];
                    headerRow += "<th>" + $(name).text() + "</th>";
                    xaxis[k] = $(name).text();
                    if (param == "LossINR") {
                        let values = [];
                        values = $(value).text().split(":");
                        let valueInMinute = ((parseInt(values[0]) * 60) + parseInt(values[1]));
                        valueRow += "<td>" + valueInMinute + "</td>";
                        yaxis[k] = valueInMinute;
                    } else {
                        valueRow += "<td>" + parseFloat($(value).text().replace(/\,/g, '')) + "</td>";
                        yaxis[k] = parseFloat($(value).text().replace(/\,/g, ''));
                    }
                    k++;
                }
                headerRow += "</tr>";
                valueRow += "</tr>";
                datatable = headerRow + valueRow + "</table>";
                console.log(datatable);
                $("#daygrid").empty();
                $("#daygrid").append(datatable);

                if (barorlinecharts == "column") {
                    let maxvalue;
                    if (param == "AvgOEE" || param == "AEEfficiency" || param == "PEEfficiency" || param == "QEEfficiency" || param == "QualityRate") {
                        maxvalue = 90;
                    }
                    Highcharts.chart('dayChart', {
                        data: {
                            table: 'daydatatable'
                        },
                        chart: {
                            type: 'column',
                            zoomType: 'x',
                            events: {
                                render: function () {
                                    var color;
                                    if ($("#mainBody").hasClass("light-mode")) {
                                        color = 'red';
                                    } else {
                                        color = 'red';
                                    }
                                    this.title.css({
                                        color: color
                                    });
                                }
                            }
                        },
                        credits: {
                            enabled: false
                        },
                        title: {
                            text: '',
                            //style: {
                            //    color: 'white'
                            //}
                        },
                        legend: {
                            useHTML: true,
                            labelFormatter: function () {
                                //return `<span class="span-legend-active" style="border-color:${this.color}">${this.name}</span>`;
                                return `<span class="span-legend-active">${this.name}</span>`;
                            }
                        },
                        yAxis: {
                            allowDecimals: false,
                            max: maxvalue,
                            title: {
                                text: yAxisName
                            },
                            className: 'highchart-xyaxis-label'
                        },
                        xAxis: {
                            title: {
                                // text: dataitem.xAxis
                            },
                            className: 'highchart-xyaxis-label'
                        },
                        //tooltip: {
                        //    formatter: function () {
                        //        return '<b>' + this.series.name + '</b><br/>' +
                        //            this.point.y + ' ' + this.point.name.toLowerCase();
                        //    }
                        //}
                    });
                } else {
                    Highcharts.chart('dayChart', {
                        chart: {
                            type: 'line',
                            zoomType: 'x'
                        },
                        credits: {
                            enabled: false
                        },
                        title: {
                            text: '',
                            style: {
                                color: 'red'
                            }
                        },
                        legend: {
                            useHTML: true,
                            labelFormatter: function () {
                                //return `<span class="span-legend-active" style="border-color:${this.color}">${this.name}</span>`;
                                return `<span class="span-legend-active">${this.name}</span>`;
                            }
                        },
                        yAxis: {
                            allowDecimals: true,

                            title: {
                                text: yAxisName
                            },
                            className: 'highchart-xyaxis-label'
                        },
                        xAxis: {
                            allowDecimals: false,
                            categories: xaxis,
                            title: {
                                //  text: param
                            },
                            className: 'highchart-xyaxis-label'
                        },
                        plotOptions: {
                            column: {
                                depth: 25,
                                maxPointWidth: 30
                            },

                        },
                        series: [{
                            color: '#1815e8',
                            data: yaxis,
                            showInLegend: false,
                            pointPadding: -0.3
                        }]
                    });
                }

                for (let i = 0; i < $('#dayData tr th .param-for-graph').length; i++) {
                    let chartTypeValue = $('#dayData tr th .param-for-graph')[i];
                    if ($(chartTypeValue).text() == dayChartType) {
                        if (barorlinecharts == "column") {
                            $(chartTypeValue).closest('th').find('.bar-chart').addClass("selected-chart-icon-color");
                        } else {
                            $(chartTypeValue).closest('th').find('.line-chart').addClass("selected-chart-icon-color");
                        }

                    }
                }
            }
            function getDateForMonth(month) {
                var currentDate = new Date(Date.now());
                var date = (currentDate.getFullYear() - 1) + "-" + month + "-01";;
                if ($("#filterToday").prop('checked') || $("#filterCustomeDay").prop('checked') || $("#filterCurrentMonth").prop('checked') || $("#filterCustomeMonth").prop('checked'))
                {
                    date = (currentDate.getFullYear() - 1) + "-" + month + "-01";
                }
                else if ($("#filterCurrentYear").prop('checked'))
                {
                   
                    date =(currentDate.getFullYear()-1) + "-" + month + "-01";
                }
                else if ($("#filterCustomeYear").prop('checked'))
                {
                    date = $("#txtYear").val() + "-" + month + "-01";
                }
                return date;
            }
            function bindMonthGridData(param) {
                $('#monthchartdatadetails').css('display', 'block');
                if (param == "firtClick") {
                    submenuid = "jan";
                    monthChartType = "AvgOEE";
                    selectedMonthMenu = "01";
                    selectedMonthMenuForView = "Jan";
                }
                
                $.ajax({
                    async: false,
                    type: "POST",
                    url: '<%= ResolveUrl("ProductionOEEDashboard.aspx/getMonthChartData") %>',
                    contentType: "application/json; charset=utf-8",
                    crossDomain: true,
                    data: '{view: "' + $(hfMainView).val() + '", month:"' + submenuid + '", selectedMonth:"' + selectedMonthMenu + '", dateformonth:"'+getDateForMonth(selectedMonthMenu)+'"}',
                    dataType: "json",
                    success: function (response) {
                        dataitem = response.d;
                        $("#monthgrid").empty();
                        $("#monthData").empty();
                        let chstr = "";
                        let firsttds = $(".draw-year-graph tr td:first-child");
                        for (let j = 0; j < $(".draw-year-graph tr").length; j++) {
                            let tr = $(".draw-year-graph tr")[j];
                            if ($(tr).css('display') != "none") {
                                let td = $(firsttds)[j - 1];
                                if (chstr == "") {
                                    chstr = $(td).text().trim();
                                } else {
                                    chstr = chstr + ',' + $(td).text().trim();
                                }
                            }
                        }
                        let tableForGrid = "";
                        tableForGrid = "<table class='P1Table '><tr>";
                        if ($(".listView").find("#tblCompanyDashboard").length > 0) {
                            for (let i = 0; i < $('#tblCompanyDashboard tr th').length; i++) {
                                let th = $('#tblCompanyDashboard tr th')[i];
                                let thname = $(th).find(".header-name").text();
                                let paramforGraph = $(th).find(".param-for-graph").text();
                                if (i >= 2) {
                                    tableForGrid += "<th><span  class='month-header-name'>" + thname + "</span><i class='glyphicon glyphicon-stats month-chart-icon-color' onclick='monthChartTypeClicked(this)' style='font-size: 15px;'></i><span class='param-for-graph' style='display: none'>" + paramforGraph + "</span></th>";

                                } else {
                                    tableForGrid += "<th><span class='month-header-name'>" + thname + "</span></th>";
                                }

                            }
                            tableForGrid += "</tr>";
                            for (let i = 0; i < dataitem.length; i++) {

                                if (chstr.includes(dataitem[i].View)) {
                                    tableForGrid += "<tr><td>" + dataitem[i].View + "</td>";
                                    tableForGrid += "<td>" + dataitem[i].View + "</td>";
                                    tableForGrid += "<td>" + dataitem[i].QE + "</td>";
                                    tableForGrid += "<td>" + dataitem[i].AE + "</td>";
                                    tableForGrid += "<td>" + dataitem[i].PE + "</td>";
                                    tableForGrid += "<td>" + dataitem[i].QE + "</td></tr>";
                                }
                            }
                        }

                        if ($(".listView").find("#tblPlantDashboard").length > 0) {
                            for (let i = 0; i < $('#tblPlantDashboard tr th').length; i++) {
                                let th = $('#tblPlantDashboard tr th')[i];
                                let thname = $(th).find(".header-name").text();
                                let paramforGraph = $(th).find(".param-for-graph").text();
                                if (i >= 2) {
                                    tableForGrid += "<th><span class='month-header-name'>" + thname + "</span><i class='glyphicon glyphicon-stats month-chart-icon-color bar-chart' onclick='monthChartTypeClicked(this)' style='font-size: 15px;'></i><i class='glyphicon glyphicon-random month-chart-icon-color line-chart' onclick='monthChartTypeClicked(this)' style='font-size: 15px;'></i><span class='param-for-graph' style='display: none'>" + paramforGraph + "</span></th>";

                                } else {
                                    tableForGrid += "<th><span class='month-header-name'>" + thname + "</span></th>";
                                }
                            }
                            tableForGrid += "</tr>";
                            for (let i = 0; i < dataitem.length; i++) {
                                if (chstr.includes(dataitem[i].Description)) {
                                    tableForGrid += "<tr><td>" + dataitem[i].Description + "</td>";
                                    tableForGrid += "<td>" + dataitem[i].Description + "</td>";
                                    tableForGrid += "<td>" + dataitem[i].OEE + "</td>";
                                    tableForGrid += "<td>" + dataitem[i].QualityRate + "</td>";
                                    tableForGrid += "<td>" + dataitem[i].Revenue + "</td>";
                                    tableForGrid += "<td>" + dataitem[i].LossINR + "</td>";
                                    tableForGrid += "<td>" + dataitem[i].Attendance + "</td>";
                                    tableForGrid += "<td>" + dataitem[i].SafetyKPI + "</td></tr>";
                                }
                            }
                        }

                        if ($(".listView").find("#tblCellDashboard").length > 0) {
                            for (let i = 0; i < $('#tblCellDashboard tr th').length; i++) {
                                let th = $('#tblCellDashboard tr th')[i];
                                let thname = $(th).find(".header-name").text();
                                let paramforGraph = $(th).find(".param-for-graph").text();
                                if (i >= 2) {
                                    tableForGrid += "<th><span  class='month-header-name'>" + thname + "</span><i class='glyphicon glyphicon-stats month-chart-icon-color bar-chart' onclick='monthChartTypeClicked(this)' style='font-size: 15px;'></i><i class='glyphicon glyphicon-random month-chart-icon-color line-chart' onclick='monthChartTypeClicked(this)' style='font-size: 15px;'></i><span class='param-for-graph' style='display: none'>" + paramforGraph + "</span></th>";

                                } else {
                                    tableForGrid += "<th><span class='month-header-name'>" + thname + "</span></th>";
                                }
                            }
                            tableForGrid += "</tr>";
                            for (let i = 0; i < dataitem.length; i++) {
                                if (chstr.includes(dataitem[i].Description)) {
                                    tableForGrid += "<tr><td>" + dataitem[i].Description + "</td>";
                                    tableForGrid += "<td>" + dataitem[i].Description + "</td>";
                                    tableForGrid += "<td>" + dataitem[i].OEE + "</td>";
                                    tableForGrid += "<td>" + dataitem[i].AEffy + "</td>";
                                    tableForGrid += "<td>" + dataitem[i].PEffy + "</td>";
                                    tableForGrid += "<td>" + dataitem[i].QEffy + "</td></tr>";
                                }
                            }
                        }
                        if ($(".listView").find("#tblMachineDashboard").length > 0) {
                            for (let i = 0; i < $('#tblMachineDashboard tr th').length; i++) {
                                let th = $('#tblMachineDashboard tr th')[i];
                                let thname = $(th).find(".header-name").text();
                                let paramforGraph = $(th).find(".param-for-graph").text();
                                if (i >= 2) {
                                    tableForGrid += "<th><span  class='month-header-name'>" + thname + "</span><i class='glyphicon glyphicon-stats month-chart-icon-color bar-chart' onclick='monthChartTypeClicked(this)' style='font-size: 15px;'></i><i class='glyphicon glyphicon-random month-chart-icon-color line-chart' onclick='monthChartTypeClicked(this)' style='font-size: 15px;'></i><span class='param-for-graph' style='display: none'>" + paramforGraph + "</span></th>";

                                } else {
                                    tableForGrid += "<th><span class='month-header-name'>" + thname + "</span></th>";
                                }
                            }
                            tableForGrid += "</tr>";
                            for (let i = 0; i < dataitem.length; i++) {
                                if (chstr.includes(dataitem[i].Description)) {
                                    tableForGrid += "<tr><td>" + dataitem[i].Description + "</td>";
                                    tableForGrid += "<td>" + dataitem[i].Description + "</td>";
                                    tableForGrid += "<td>" + dataitem[i].OEE + "</td>";
                                    tableForGrid += "<td>" + dataitem[i].AEffy + "</td>";
                                    tableForGrid += "<td>" + dataitem[i].PEffy + "</td>";
                                    tableForGrid += "<td>" + dataitem[i].QEffy + "</td>";
                                    tableForGrid += "<td>" + dataitem[i].AcceptedPart + "</td>";
                                    tableForGrid += "<td>" + dataitem[i].RejectCount + "</td>";
                                    tableForGrid += "<td>" + dataitem[i].LossINR + "</td></tr>";
                                }
                            }
                        }
                        tableForGrid += "</table>";
                        $('#monthData').append(tableForGrid);

                    },
                    error: function (Result) {
                        alert("Error" + Result);
                    }
                });
                bindMonthChartData(monthChartType);
                if (param == "firtClick") {
                    let li = $('#ulMonthsForYear li')[0];
                    let daymenu = $(li).find('a').attr('id');
                    if ($("#mainBody").hasClass("light-mode")) {
                        $(".submenuData").removeClass("selected-menu-style menu0-select").addClass("other-menu-style");
                        $(".submenuData").closest('li').find('i').removeClass();
                        $("#" + daymenu).removeClass("other-menu-style menu0-select").addClass("selected-menu-style");
                    } else {
                        $(".submenuData").removeClass("selected-menu-style menu0-select").addClass("other-menu-style");
                        $(".submenuData").closest('li').find('i').removeClass();
                        $("#" + daymenu).removeClass("other-menu-style menu0-select").addClass("selected-menu-style");
                    }
                    $("#" + daymenu).closest('li').find('i').addClass("arrow up");
                    $("#monthDataAndChartContainer").addClass("in active");

                    //$("#monthchartdatadetails").css('height', $("#monthchartdatadetails").css('height'));
                    //var elmnt = document.getElementById("monthchartdatadetails");
                    //elmnt.scrollIntoView();

                    $('html, body').animate({
                        scrollTop: $("#monthchartdatadetails").offset().top - 80
                    }, 1250);

                    daysForMonth();
                }

                return false;
            }

            function bindMonthChartData(param) {
                //let selectedRow = getSelectedRows();
                //let table = $('#monthData').find('table');
                let thIndex;
                let yAxisName = "";
                var yaxis = [];
                var xaxis = [];
                let k = 0;
                //for (let i = 0; i < dataitem.xAxis.length; i++) {
                //    if (chstr.includes(dataitem.xAxis[i])) {
                //        xaxis[k] = dataitem.xAxis[i];
                //        yaxis[k] = dataitem.yAxis[i];
                //        k++;
                //    }
                //}
                for (let i = 0; i < $('#monthData').find('table tr th').length; i++) {
                    let th = $('#monthData').find('table tr th')[i];
                    let thparam = $(th).find(".param-for-graph").text();
                    if (thparam == param) {
                        thIndex = i;
                        yAxisName = $(th).find(".month-header-name").text();
                    }
                }

                let datatable = "";
                let headerRow = "<table id='datatable'><tr><th></th>";
                let valueRow = "<tr><th>" + selectedMonthMenuForView + "</th>";
                for (let j = 1; j < $('#monthData').find('table tr').length; j++) {
                    let tr = $('#monthData').find('table tr')[j];
                    let name = $(tr).children()[0];
                    let value = $(tr).children()[thIndex];
                    headerRow += "<th>" + $(name).text() + "</th>";
                    xaxis[k] = $(name).text();
                    if (param == "LossINR") {
                        let values = [];
                        values = $(value).text().split(":");
                        let valueInMinute = ((parseInt(values[0]) * 60) + parseInt(values[1]));
                        valueRow += "<td>" + valueInMinute + "</td>";
                        yaxis[k] = valueInMinute;
                    } else {

                        valueRow += "<td>" + parseFloat($(value).text().replace(/\,/g, '')) + "</td>";
                        yaxis[k] = parseFloat($(value).text().replace(/\,/g, ''));
                    }
                     k++;
                }
                headerRow += "</tr>";
                valueRow += "</tr>";
                datatable = headerRow + valueRow + "</table>";
                console.log(datatable);
                $("#monthgrid").empty();
                $("#monthgrid").append(datatable);

                if (barorlinecharts == "column") {
                    let maxvalue;
                    if (param == "AvgOEE" || param == "AEEfficiency" || param == "PEEfficiency" || param == "QEEfficiency" || param == "QualityRate") {
                        maxvalue = 110;
                    }
                    Highcharts.chart('monthChart', {
                        data: {
                            table: 'datatable'
                        },
                        chart: {
                            type: barorlinecharts,
                            zoomType: 'x',
                            events: {
                                render: function () {
                                    var color;
                                    if ($("#mainBody").hasClass("light-mode")) {
                                        color = 'red';
                                    } else {
                                        color = 'red';
                                    }
                                    this.title.css({
                                        color: color
                                    });
                                }
                            }
                        },
                        credits: {
                            enabled: false
                        },
                        title: {
                            text: '',
                            //style: {
                            //    color: 'white'
                            //}
                        },
                        legend: {
                            useHTML: true,
                            labelFormatter: function () {
                                //return `<span class="span-legend-active" style="border-color:${this.color}">${this.name}</span>`;
                                return `<span class="span-legend-active">${this.name}</span>`;
                            }
                        },
                        yAxis: {
                            allowDecimals: false,
                            max: maxvalue,
                            title: {
                                text: yAxisName
                            },
                            className: 'highchart-xyaxis-label'
                        },
                        xAxis: {
                            title: {
                                // text: dataitem.xAxis
                            },
                            className: 'highchart-xyaxis-label'
                        },
                    });
                } else {
                    Highcharts.chart('monthChart', {
                        chart: {
                            type: 'line',
                            zoomType: 'x'
                        },
                        credits: {
                            enabled: false
                        },
                        title: {
                            text: '',
                            style: {
                                color: 'red'
                            }
                        },
                        legend: {
                            useHTML: true,
                            labelFormatter: function () {
                                //return `<span class="span-legend-active" style="border-color:${this.color}">${this.name}</span>`;
                                return `<span class="span-legend-active">${this.name}</span>`;
                            }
                        },
                        yAxis: {
                            allowDecimals: true,
                            title: {
                                text: yAxisName
                            },
                            className: 'highchart-xyaxis-label'
                        },
                        xAxis: {
                            allowDecimals: false,
                            categories: xaxis,
                            title: {
                                //  text: param
                            },
                            className: 'highchart-xyaxis-label'
                        },
                        plotOptions: {
                            column: {
                                depth: 25,
                                maxPointWidth: 30
                            },

                        },
                        series: [{
                            color: '#1815e8',
                            data: yaxis,
                            showInLegend: false,
                            pointPadding: -0.3
                        }]
                    });
                }

                for (let i = 0; i < $('#monthData tr th .param-for-graph').length; i++) {
                    let chartTypeValue = $('#monthData tr th .param-for-graph')[i];
                    if ($(chartTypeValue).text() == monthChartType) {
                        if (barorlinecharts == "column") {
                            $(chartTypeValue).closest('th').find('.bar-chart').addClass("selected-chart-icon-color");
                        } else {
                            $(chartTypeValue).closest('th').find('.line-chart').addClass("selected-chart-icon-color");
                        }
                    }
                }
            }
            function bindColumnChart(param) {
                var dataitem;
                var yaxis = [];
                var xaxis = [];
                $.ajax({
                    async: false,
                    type: "POST",
                    url: '<%= ResolveUrl("ProductionOEEDashboard.aspx/getYearChartData") %>',
                    contentType: "application/json; charset=utf-8",
                    crossDomain: true,
                    data: '{view: "' + $(hfMainView).val() + '", param:"' + param + '",dateforYear :"' + getDateForYear() + '"}',
                    dataType: "json",
                    success: function (response) {
                        dataitem = response.d;
                        //xaxis = dataitem.xAxis;
                        //yaxis = dataitem.yAxis;
                        let chstr = "";
                        //let checked_checkboxes = $('#cblRowSelector input:checked');
                        //checked_checkboxes.each(function () {
                        //    if (chstr == "") {
                        //        debugger;
                        //        chstr = $(this).val();
                        //    } else {
                        //        chstr = chstr + ',' + $(this).val();
                        //    }
                        //});
                        let firsttds = $(".draw-year-graph tr td:first-child");
                        for (let j = 0; j < $(".draw-year-graph tr").length; j++) {
                            let tr = $(".draw-year-graph tr")[j];
                            if ($(tr).css('display') != "none") {
                                let td = $(firsttds)[j - 1];
                                if (chstr == "") {
                                    chstr = $(td).text().trim();
                                } else {
                                    chstr = chstr + ',' + $(td).text().trim();
                                }
                            }
                        }
                        let k = 0;
                        for (let i = 0; i < dataitem.xAxis.length; i++) {
                            if (chstr.includes(dataitem.xAxis[i])) {
                                xaxis[k] = dataitem.xAxis[i];
                                yaxis[k] = dataitem.yAxis[i];
                                k++;
                            }
                        }
                    },
                    error: function (Result) {
                        alert("Error" + Result);
                    }
                });
                console.log(xaxis);
                console.log(yaxis);
                let maxvalue;
                if (barorlinecharts == "column") {
                    if (param == "AvgOEE" || param == "AEEfficiency" || param == "PEEfficiency" || param == "QEEfficiency" || param == "QualityRate") {
                        maxvalue = 110;
                    }
                }
              
                Highcharts.chart('yearChart', {
                    chart: {
                        type: barorlinecharts,

                        zoomType: 'x'
                        //options3d: {
                        //    enabled: true,
                        //    alpha: 15,
                        //    beta: 15,
                        //    depth: 50,
                        //    viewDistance: 25
                        //}
                    },
                    credits: {
                        enabled: false
                    },
                    title: {
                        text: '',
                        style: {
                            color: 'red'
                        }
                    },
                    legend: {
                        useHTML: true,
                        labelFormatter: function () {
                            //return `<span class="span-legend-active" style="border-color:${this.color}">${this.name}</span>`;
                            return `<span class="span-legend-active">${this.name}</span>`;
                        }
                    },
                    yAxis: {
                        allowDecimals: true,
                        max: maxvalue,
                        title: {
                            text: selectedChartTypeforView
                        },
                        className: 'highchart-xyaxis-label'
                    },
                    xAxis: {
                        allowDecimals: false,
                        categories: xaxis,
                        title: {
                            //  text: param
                        },
                        className: 'highchart-xyaxis-label'
                    },
                    plotOptions: {
                        column: {
                            depth: 25,
                            maxPointWidth: 30
                        },

                    },
                    series: [{
                        color: '#1815e8',
                        data: yaxis,
                        showInLegend: false,
                        pointPadding: -0.3
                    }]
                });

                showhidegraph();
                //for (let i = 0; i < $('.draw-year-graph tr th .param-for-graph').length; i++) {
                //    let chartTypeValue = $('.draw-year-graph tr th .param-for-graph')[i];
                //    if ($(chartTypeValue).text() == dayChartType) {
                //        $(chartTypeValue).closest('th').find('.chart-icon-color').addClass("selected-chart-icon-color");
                //    }
                //}

                return false;
            };


        });

    </script>
</asp:Content>
