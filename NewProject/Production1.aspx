<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Production1.aspx.cs" EnableEventValidation="false" Inherits="NewProject.Production1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <script src='https://cdn.plot.ly/plotly-latest.min.js'></script>

    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/highcharts-3d.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/modules/export-data.js"></script>
    <script src="https://code.highcharts.com/modules/accessibility.js"></script>

    <script src="https://code.highcharts.com/stock/highstock.js"></script>
    <script src="https://code.highcharts.com/stock/modules/data.js"></script>
    <script src="https://code.highcharts.com/stock/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/stock/modules/export-data.js"></script>






    <link href="http://cdn.syncfusion.com/18.2.0.44/js/web/flat-azure/ej.web.all.min.css" rel="stylesheet" />
    <script src="http://cdn.syncfusion.com/js/assets/external/jquery-1.10.2.min.js"></script>
    <script src="http://cdn.syncfusion.com/18.2.0.44/js/web/ej.web.all.min.js"></script>


    <link rel="stylesheet" type="text/css" href="https://cdn3.devexpress.com/jslib/20.1.7/css/dx.common.css" />
    <link rel="stylesheet" type="text/css" href="https://cdn3.devexpress.com/jslib/20.1.7/css/dx.light.css" />
    <script src="https://cdn3.devexpress.com/jslib/20.1.7/js/dx.all.js"></script>

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
        .datetime-txtstyle {
            border: unset;
            border-bottom: 2px solid red;
            background-color: unset;
        }

        .checkbox-list tr td {
            padding-bottom: 10px;
        }

        .filter-checkbox input {
            margin-right: 5px;
        }
    </style>
    <div class="container-fluid">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <div class="row" style="color: white;">
                    <div class="col-sm-12 col-lg-12 col-md-12 content-sub-menu">
                        <asp:HiddenField runat="server" ID="activeMenu" ClientIDMode="Static" />
                        <asp:HiddenField runat="server" ID="hfselectedContext" ClientIDMode="Static" />
                        <asp:HiddenField runat="server" ID="hfMainView" ClientIDMode="Static" />
                        <asp:HiddenField runat="server" ID="hfView" ClientIDMode="Static" />
                        <div style="float: left; margin-top: 5px">
                            <div class="navbar-collapse collapse">
                                <ul class="nav navbar-nav nextPrevious">

                                    <li runat="server" id="liSLI" class="active"><a runat="server" id="SLI" class="menuData" data-toggle="tab" href="#menu0">OEE Dashboard</a>
                                        <i></i>
                                    </li>
                                    <li runat="server" id="liAnnexureA"><a runat="server" id="annexureA" class="menuData" data-toggle="tab" href="#menu1">Downtime Analysis</a>
                                        <i></i>
                                    </li>
                                    <%--  <li><a runat="server" class="menuData" id="annexureB" data-toggle="tab" href="#menu2">Graphing</a>
                                        <i></i>
                                    </li>
                                    <li><a runat="server" class="menuData" id="formSDF" data-toggle="tab" href="#menu3">Signature Comparision</a>
                                        <i></i>
                                    </li>--%>
                                    <li><a runat="server" class="menuData" id="a3" data-toggle="tab" href="#menu4">Rejection Analysis</a>
                                        <i></i>
                                    </li>
                                    <li><a runat="server" class="menuData" id="A2" data-toggle="tab" href="#menu4">Workorders</a>
                                        <i></i>
                                    </li>
                                    <li><a runat="server" class="menuData" id="A1" data-toggle="tab" href="#menu4">Parts Data</a>
                                        <i></i>
                                    </li>
                                </ul>
                            </div>
                        </div>

                        <div style="float: right">
                            <table class="submenu-right-side" style="height: 60px">
                                <tr>
                                    <td>
                                        <asp:LinkButton runat="server" ID="lbBack" CssClass="glyphicon glyphicon-arrow-left" OnClick="lbBack_Click" Style="color: white; font-size: 17px" Visible="false"></asp:LinkButton>
                                    </td>
                                    <td onmouseover="showPanelFilter(this,'panelContext','100px','54px', 'ulFilter');" onmouseout="hidePanels(this,'panelContext')">
                                        <i class="" style="font-size: 17px;">Context</i>
                                        <div class="panel panel-default panel-subitems" id="panelContext" onmouseover="showPanelFilter(this,'panelContext','100px','54px', 'ulFilter');" onmouseout="hidePanels(this,'panelContext')" style="width: 200px;">
                                            <div class="panel-body">
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

                                            </div>
                                        </div>
                                    </td>
                                    <td onmouseover="showPanelsTopRight(this,'panelExport','70px','54px');" onmouseout="hidePanels(this,'panelExport')">
                                        <i class="glyphicon glyphicon-save" style="font-size: 17px;"></i>
                                        <div class="panel panel-default panel-subitems" id="panelExport" onmouseover="showPanelsTopRight(this,'panelExport','70px','54px');" onmouseout="hidePanels(this,'panelExport')" style="width: 200px;">
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
                                    <td onmouseover="showPanelsTopRight(this,'panelView','5px','54px');" onmouseout="hidePanels(this,'panelView')">
                                        <i class="glyphicon glyphicon-th" style="font-size: 17px;"></i>
                                        <div class="panel panel-default panel-subitems" id="panelView" onmouseover="showPanelsTopRight(this,'panelView','5px','54px');" onmouseout="hidePanels(this,'panelView')" style="width: 200px;">
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
                                    <td onclick="showPanelsTopRight(this,'panelTimeFilter','5px','54px');">
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
                                                                <asp:CheckBox runat="server" ID="filterCustomeDay" onchange="showhideCustomeDetails(this,'filterCustomeDay', '')" CssClass="filter-checkbox" Text="Custom Day" ClientIDMode="Static" />

                                                            </li>
                                                            <li>
                                                                <asp:CheckBox runat="server" ID="filterCurrentMonth" CssClass="filter-checkbox" onchange="showhideCustomeDetails(this,'filterCurrentMonth', '')" Text="Current Month" ClientIDMode="Static" />
                                                            </li>
                                                            <li>
                                                                <asp:CheckBox runat="server" ID="filterCustomeMonth" CssClass="filter-checkbox" onchange="showhideCustomeDetails(this,'filterCustomeMonth', 'filterCustomeMonthDiv')" Text="Custom Month" ClientIDMode="Static" />
                                                                <div id="filterCustomeMonthDiv" class="filterCustomeDiv" style="display: none">
                                                                    <asp:TextBox ID="txtMonth" runat="server" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control datetime-txtstyle" placeholder="Month" Style="width: 70px; display: inline;"></asp:TextBox>
                                                                    <asp:Button runat="server" ID="btnMonthSearch" CssClass="Btns"  Text="Search" />
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
                                                                    <asp:Button runat="server" ID="btnYearSearch" CssClass="Btns" OnClick="btnYearSearch_Click" Text="Search" />
                                                                    <%--OnClientClick="return bindColumnChart();"--%>
                                                                </div>
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
                                    <td onmouseover="showPanelFilter(this,'panelFilter','5px','54px', 'ulFilter');" onmouseout="hidePanels(this,'panelFilter')">
                                        <i class="glyphicon glyphicon-filter" style="font-size: 17px;"></i>

                                        <div class="panel panel-default panel-subitems" id="panelFilter" onmouseover="showPanelFilter(this,'panelFilter','5px','54px', 'ulFilter');" onmouseout="hidePanels(this,'panelFilter')" style="width: 250px;">
                                            <div class="panel-body">
                                                <ul class="outer-ul" id="ulFilter">
                                                </ul>
                                                <div id="divColumnFilter">
                                                    <asp:CheckBoxList runat="server" ID="cblColumnSelector" CssClass="checkbox-list" ClientIDMode="Static"></asp:CheckBoxList>
                                                    <asp:Button runat="server" ID="btnColumnSelectorOK" Text="ok" ClientIDMode="Static" Style="margin-left: 20px" CssClass="Btns" OnClientClick="return selectColumn()" />
                                                </div>
                                                <div id="divgraphFilter">
                                                    <asp:CheckBoxList runat="server" ID="cbgraphFilter" ClientIDMode="Static">
                                                        <asp:ListItem Value="Graph1" Text="Graph 1"></asp:ListItem>
                                                        <asp:ListItem Value="Graph2" Text="Graph 2"></asp:ListItem>
                                                        <asp:ListItem Value="Graph3" Text="Graph 3"></asp:ListItem>
                                                    </asp:CheckBoxList>
                                                    <asp:Button runat="server" ID="btnGraphThreeOK" ClientIDMode="Static" OnClientClick="return bindMultiSelectGraph();" CssClass="Btns" Style="margin-left: 20px" Text="OK" />
                                                </div>

                                                <div id="divgraph6Filter">
                                                    <asp:CheckBoxList runat="server" ID="cbgraph6Filter" ClientIDMode="Static">
                                                        <asp:ListItem Value="Graph1" Text="Graph 1"></asp:ListItem>
                                                        <asp:ListItem Value="Graph2" Text="Graph 2"></asp:ListItem>
                                                        <asp:ListItem Value="Graph3" Text="Graph 3"></asp:ListItem>
                                                        <asp:ListItem Value="Graph4" Text="Graph 4"></asp:ListItem>
                                                        <asp:ListItem Value="Graph5" Text="Graph 5"></asp:ListItem>
                                                        <asp:ListItem Value="Graph6" Text="Graph 6"></asp:ListItem>
                                                        <asp:ListItem Value="Graph7" Text="Graph 7"></asp:ListItem>
                                                        <asp:ListItem Value="Graph8" Text="Graph 8"></asp:ListItem>
                                                        <asp:ListItem Value="Graph9" Text="Graph 9"></asp:ListItem>
                                                        <asp:ListItem Value="Graph10" Text="Graph 10"></asp:ListItem>
                                                    </asp:CheckBoxList>
                                                    <asp:Button runat="server" ID="btnGraphSixOK" ClientIDMode="Static" OnClientClick="return bindMultiSelectGraph6();" CssClass="Btns" Style="margin-left: 20px" Text="OK" />
                                                </div>

                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div class="tab-content themetoggle" id="inputContainer" style="height: 85vh; width: 96vw; margin: 120px auto 0px auto;">
                        <div id="menu0" class="tab-pane fade">
                            <div class="listView columnSelector" style="position: relative">
                                <div runat="server" id="divCompanyView">
                                    <asp:ListView runat="server" ID="lvCompanyDashboard" ClientIDMode="Static" OnItemEditing="lvCompanyDashboard_ItemEditing">
                                        <LayoutTemplate>
                                            <table class="P1Table" id="tblCompanyDashboard" runat="server">
                                                <tr>
                                                    <th onmouseover="showPanelsTopLeft(this,'panelRowSelector','0px','40px');" onmouseout="hidePanels(this,'panelRowSelector')">Company
                                                     <i class="glyphicon glyphicon-filter" style="font-size: 15px;"></i>
                                                    </th>
                                                    <th>Company Description</th>
                                                    <th>Avg. OEE</th>
                                                    <th>Quality Rate (PPM)</th>
                                                    <th>Revenue (INR)</th>
                                                    <th>Loss (INR)</th>
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
                                            <table class="P1Table" id="tblPlantDashboard" runat="server">
                                                <tr>
                                                    <th onmouseover="showPanelsTopLeft(this,'panelRowSelector','0px','40px');" onmouseout="hidePanels(this,'panelRowSelector')">Plant
                                                        <i class="glyphicon glyphicon-filter" style="font-size: 15px;"></i>
                                                    </th>
                                                    <th>Plant Description</th>
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
                                                    <%--  <asp:Label runat="server" ID="ll" Text='<%#Eval("C1") %>'></asp:Label>--%>
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

                                    <asp:ListView runat="server" ID="lvDivDashboard" ClientIDMode="Static">
                                        <LayoutTemplate>
                                            <table class="P1Table" id="tblDivDashboard" runat="server">
                                                <tr>
                                                    <th onmouseover="showPanelsTopLeft(this,'panelRowSelector','0px','40px');" onmouseout="hidePanels(this,'panelRowSelector')">Div
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
                                            <table class="P1Table" id="tblCellDashboard" runat="server">
                                                <tr>
                                                    <th onmouseover="showPanelsTopLeft(this,'panelRowSelector','0px','40px');" onmouseout="hidePanels(this,'panelRowSelector')">Cell
                                                                                                      <i class="glyphicon glyphicon-filter" style="font-size: 15px;"></i>
                                                    </th>
                                                    <th>Cell Description</th>
                                                    <th>OEE (%)</th>
                                                    <th>AE (%)</th>
                                                    <th>PE (%)</th>
                                                    <th>QE (%)</th>
                                                </tr>
                                                <tr id="itemplaceholder" runat="server"></tr>
                                            </table>
                                        </LayoutTemplate>
                                        <ItemTemplate>
                                            <tr>
                                                <td>
                                                    <%--  <asp:Label runat="server" ID="ll" Text='<%#Eval("C1") %>'></asp:Label>--%>
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
                                            </tr>

                                        </ItemTemplate>
                                    </asp:ListView>
                                </div>

                                <div runat="server" id="divMachineView">
                                    <asp:ListView runat="server" ID="lvMachineDashboard" ClientIDMode="Static">
                                        <LayoutTemplate>
                                            <table class="P1Table" id="tblMachineDashboard" runat="server">
                                                <tr>
                                                    <th onmouseover="showPanelsTopLeft(this,'panelRowSelector','0px','40px');" onmouseout="hidePanels(this,'panelRowSelector')">Machine
                                                       <i class="glyphicon glyphicon-filter" style="font-size: 15px;"></i>
                                                    </th>
                                                    <th>Machine Description</th>
                                                    <th>OEE (%)</th>
                                                    <th>AE (%)</th>
                                                    <th>PE (%)</th>
                                                    <th>QE (%)</th>
                                                    <th>Part Count</th>
                                                    <th>Rejection</th>
                                                    <th>Loss (hh: mm)</th>
                                                </tr>
                                                <tr id="itemplaceholder" runat="server"></tr>
                                            </table>
                                        </LayoutTemplate>
                                        <ItemTemplate>
                                            <tr>
                                                <td>

                                                    <asp:Label runat="server" ID="name" Text='<%#Eval("View") %>'></asp:Label>
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
                                                    <asp:Label runat="server" ID="Label8" Text='<%#Eval("QE") %>'></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Label9" Text='<%#Eval("AE") %>'></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="Label10" Text='<%#Eval("PE") %>'></asp:Label>
                                                </td>
                                            </tr>

                                        </ItemTemplate>
                                    </asp:ListView>
                                </div>

                                <div class="panel panel-default panel-subitems" id="panelRowSelector" onmouseover="showPanelsTopLeft(this,'panelRowSelector','0px','40px');" onmouseout="hidePanels(this,'panelRowSelector')" style="width: 200px;">
                                    <div class="panel-body">
                                        <asp:CheckBoxList runat="server" ID="cblRowSelector" CssClass="checkbox-list" ClientIDMode="Static"></asp:CheckBoxList>
                                        <asp:Button runat="server" ID="btnSelectRows" Text="ok" ClientIDMode="Static" CssClass="Btns" OnClientClick="return selectRows()" />
                                    </div>
                                </div>
                                <%--<table class="P1Table">
                            <tr>
                                <th>Numeric</th>
                                <th>Alpha Numeric</th>
                                <th>Date</th>
                                <th>Time</th>

                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                        </table>--%>
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
                                                    <table id="tblCardViewCompanyDashboard" class="card-table">
                                                        <tr>
                                                            <td colspan="2" style="text-align: center">
                                                                <span class="card-header">
                                                                    <asp:LinkButton runat="server" ID="name" ClientIDMode="Static" CommandName="Edit" Text='<%#Eval("View") %>' Style="color: white"></asp:LinkButton>
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
                                                    <table id="tblCardViewPlantDashboard" class="card-table">
                                                        <tr>
                                                            <td colspan="2" style="text-align: center">
                                                                <span class="card-header">
                                                                    <asp:LinkButton runat="server" ID="name" ClientIDMode="Static" CommandName="Edit" Text='<%#Eval("View") %>' Style="color: white"></asp:LinkButton>
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
                                                                <span class="card-sub-header">Plant OEE</span>
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
                                                    <table id="tblCardViewCellDashboard" class="card-table">
                                                        <tr>
                                                            <td colspan="2" style="text-align: center">
                                                                <span class="card-header">
                                                                    <asp:LinkButton runat="server" ID="name" ClientIDMode="Static" CommandName="Edit" Text='<%#Eval("View") %>' Style="color: white"></asp:LinkButton>
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
                                                                <span class="card-sub-header">OEE (%)</span>
                                                            </td>
                                                            <td>
                                                                <asp:Label runat="server" ID="Label5" Text='<%#Eval("QE") %>'></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <span class="card-sub-header">AE (%)</span>
                                                            </td>
                                                            <td>
                                                                <asp:Label runat="server" ID="Label1" Text='<%#Eval("AE") %>'></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <span class="card-sub-header">PE (%)</span>
                                                            </td>
                                                            <td>
                                                                <asp:Label runat="server" ID="Label2" Text='<%#Eval("PE") %>'></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <span class="card-sub-header">QE (%)</span>
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
                                                    <table id="tblCardViewMachineDashboard" class="card-table">
                                                        <tr>
                                                            <td colspan="2" style="text-align: center">
                                                                <span class="card-header">
                                                                    <asp:Label runat="server" ID="name" ClientIDMode="Static" Text='<%#Eval("View") %>'></asp:Label>
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
                                                                <span class="card-sub-header">OEE (%)</span>
                                                            </td>
                                                            <td>
                                                                <asp:Label runat="server" ID="Label5" Text='<%#Eval("QE") %>'></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <span class="card-sub-header">AE (%)</span>
                                                            </td>
                                                            <td>
                                                                <asp:Label runat="server" ID="Label1" Text='<%#Eval("AE") %>'></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <span class="card-sub-header">PE (%)</span>
                                                            </td>
                                                            <td>
                                                                <asp:Label runat="server" ID="Label2" Text='<%#Eval("PE") %>'></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <span class="card-sub-header">QE (%)</span>
                                                            </td>
                                                            <td>
                                                                <asp:Label runat="server" ID="Label3" Text='<%#Eval("QE") %>'></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <span class="card-sub-header">Part Count</span>
                                                            </td>
                                                            <td>
                                                                <asp:Label runat="server" ID="Label13" Text='<%#Eval("QE") %>'></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <span class="card-sub-header">Rejection</span>
                                                            </td>
                                                            <td>
                                                                <asp:Label runat="server" ID="Label14" Text='<%#Eval("AE") %>'></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <span class="card-sub-header">Loss (hh: mm)</span>
                                                            </td>
                                                            <td>
                                                                <asp:Label runat="server" ID="Label15" Text='<%#Eval("PE") %>'></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </div>

                                        </ItemTemplate>
                                    </asp:ListView>
                                </div>


                                <%--   <div class="outer-div">
                                    <div>
                                        <table class="card-table">
                                            <tr>
                                                <td colspan="2" style="text-align: center">
                                                    <span class="card-header">P1</span>
                                                </td>
                                            </tr>
                                            <tr>

                                                <td>
                                                    <span class="card-sub-header">Numeric</span>
                                                </td>
                                                <td>
                                                    <span>1</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Alpha Numeric</span>
                                                </td>
                                                <td>
                                                    <span>2</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Date</span>
                                                </td>
                                                <td>
                                                    <span>3</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Time</span>
                                                </td>
                                                <td>
                                                    <span>4</span>
                                                </td>
                                            </tr>
                                        </table>


                                    </div>
                                </div>

                                <div class="outer-div">
                                    <div>
                                        <table class="card-table">
                                            <tr>
                                                <td colspan="2" style="text-align: center">
                                                    <span class="card-header">P1</span>
                                                </td>
                                            </tr>
                                            <tr>

                                                <td>
                                                    <span class="card-sub-header">Numeric</span>
                                                </td>
                                                <td>
                                                    <span>1</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Alpha Numeric</span>
                                                </td>
                                                <td>
                                                    <span>2</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Date</span>
                                                </td>
                                                <td>
                                                    <span>3</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Time</span>
                                                </td>
                                                <td>
                                                    <span>4</span>
                                                </td>
                                            </tr>
                                        </table>


                                    </div>
                                </div>

                                <div class="outer-div">
                                    <div>
                                        <table class="card-table">
                                            <tr>
                                                <td colspan="2" style="text-align: center">
                                                    <span class="card-header">P1</span>
                                                </td>
                                            </tr>
                                            <tr>

                                                <td>
                                                    <span class="card-sub-header">Numeric</span>
                                                </td>
                                                <td>
                                                    <span>1</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Alpha Numeric</span>
                                                </td>
                                                <td>
                                                    <span>2</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Date</span>
                                                </td>
                                                <td>
                                                    <span>3</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Time</span>
                                                </td>
                                                <td>
                                                    <span>4</span>
                                                </td>
                                            </tr>
                                        </table>


                                    </div>
                                </div>

                                <div class="outer-div">
                                    <div>
                                        <table class="card-table">
                                            <tr>
                                                <td colspan="2" style="text-align: center">
                                                    <span class="card-header">P1</span>
                                                </td>
                                            </tr>
                                            <tr>

                                                <td>
                                                    <span class="card-sub-header">Numeric</span>
                                                </td>
                                                <td>
                                                    <span>1</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Alpha Numeric</span>
                                                </td>
                                                <td>
                                                    <span>2</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Date</span>
                                                </td>
                                                <td>
                                                    <span>3</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Time</span>
                                                </td>
                                                <td>
                                                    <span>4</span>
                                                </td>
                                            </tr>
                                        </table>


                                    </div>
                                </div>--%>
                            </div>

                            <div class="graphSection box-shadow" style="margin-top: 20px;">
                                <asp:Button runat="server" ID="btnmon" ClientIDMode="Static" Text="Month" OnClientClick="return getMonthDetails()" />
                                <div id="yearChart" style="margin-top: 20px;" class="box-shadow">
                                </div>
                                <div id="monthgrid" style="display: none">

                                </div>
                                <div id="monthData" style="margin-top: 20px;" class="box-shadow">
                                </div>
                                <div id="monthChart" style="margin-top: 20px;" class="box-shadow">
                                </div>
                            </div>
                        </div>
                        <div id="menu1" class="tab-pane fade">
                            <div class="graph-section">
                                <div class=" graph-div">
                                    <div id='graph1'></div>
                                </div>
                                <div class="graph-div">
                                    <div id="graph2"></div>
                                </div>
                                <div class="col-md-6 col-lg-6 col-sm-6 graph-div">
                                    <div id="graph3"></div>
                                </div>
                                <div class="col-md-6 col-lg-6 col-sm-6 graph-div">
                                    <div id="graph4"></div>
                                </div>
                                <div class="col-md-6 col-lg-6 col-sm-6 graph-div">
                                </div>
                                <div class="col-md-6 col-lg-6 col-sm-6 graph-div">
                                </div>
                            </div>
                            <%--   <div class="listView">
                        <table class="P1Table">
                            <tr>
                                <th>Column 1</th>
                                <th>Column 2</th>
                                <th>Column 3</th>
                                <th>Column 4</th>

                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                        </table>
                    </div>
                    <div class="cardView" style="display: none">
                        <div class="outer-div">
                            <div>
                                <table class="card-table">
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <span class="card-header">P2</span>
                                        </td>
                                    </tr>
                                    <tr>

                                        <td>
                                            <span class="card-sub-header">Column 1</span>
                                        </td>
                                        <td>
                                            <span>1</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 2</span>
                                        </td>
                                        <td>
                                            <span>2</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 3</span>
                                        </td>
                                        <td>
                                            <span>3</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 4</span>
                                        </td>
                                        <td>
                                            <span>4</span>
                                        </td>
                                    </tr>
                                </table>


                            </div>
                        </div>

                        <div class="outer-div">
                            <div>
                                <table class="card-table">
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <span class="card-header">P2</span>
                                        </td>
                                    </tr>
                                    <tr>

                                        <td>
                                            <span class="card-sub-header">Column 1</span>
                                        </td>
                                        <td>
                                            <span>1</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 2</span>
                                        </td>
                                        <td>
                                            <span>2</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 3</span>
                                        </td>
                                        <td>
                                            <span>3</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 4</span>
                                        </td>
                                        <td>
                                            <span>4</span>
                                        </td>
                                    </tr>
                                </table>


                            </div>
                        </div>

                        <div class="outer-div">
                            <div>
                                <table class="card-table">
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <span class="card-header">P2</span>
                                        </td>
                                    </tr>
                                    <tr>

                                        <td>
                                            <span class="card-sub-header">Column 1</span>
                                        </td>
                                        <td>
                                            <span>1</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 2</span>
                                        </td>
                                        <td>
                                            <span>2</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 3</span>
                                        </td>
                                        <td>
                                            <span>3</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 4</span>
                                        </td>
                                        <td>
                                            <span>4</span>
                                        </td>
                                    </tr>
                                </table>


                            </div>
                        </div>

                        <div class="outer-div">
                            <div>
                                <table class="card-table">
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <span class="card-header">P2</span>
                                        </td>
                                    </tr>
                                    <tr>

                                        <td>
                                            <span class="card-sub-header">Column 1</span>
                                        </td>
                                        <td>
                                            <span>1</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 2</span>
                                        </td>
                                        <td>
                                            <span>2</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 3</span>
                                        </td>
                                        <td>
                                            <span>3</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 4</span>
                                        </td>
                                        <td>
                                            <span>4</span>
                                        </td>
                                    </tr>
                                </table>


                            </div>
                        </div>
                    </div>--%>
                        </div>
                        <div id="menu2" class="tab-pane fade">
                            <div class="graph-section" id="graphthree" style="width: 100%; margin: auto">
                                <div id="msGraph1" style="margin-bottom: 20px; box-shadow: 2px 2px 5px 2px #151617;"></div>
                                <div id="msGraph2" style="margin-bottom: 20px; box-shadow: 2px 2px 5px 2px #151617;"></div>
                                <div id="msGraph3" style="margin-bottom: 20px; box-shadow: 2px 2px 5px 2px #151617;"></div>
                            </div>
                            <%--         <div class="listView">
                      
                        <table class="P1Table">
                            <tr>
                                <th>Column 1</th>
                                <th>Column 2</th>
                                <th>Column 3</th>
                                <th>Column 4</th>

                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                        </table>
                    </div>

                    <div class="cardView" style="display: none">
                        <div class="outer-div">
                            <div>
                                <table class="card-table">
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <span class="card-header">P3</span>
                                        </td>
                                    </tr>
                                    <tr>

                                        <td>
                                            <span class="card-sub-header">Column 1</span>
                                        </td>
                                        <td>
                                            <span>1</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 2</span>
                                        </td>
                                        <td>
                                            <span>2</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 3</span>
                                        </td>
                                        <td>
                                            <span>3</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 4</span>
                                        </td>
                                        <td>
                                            <span>4</span>
                                        </td>
                                    </tr>
                                </table>


                            </div>
                        </div>

                        <div class="outer-div">
                            <div>
                                <table class="card-table">
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <span class="card-header">P3</span>
                                        </td>
                                    </tr>
                                    <tr>

                                        <td>
                                            <span class="card-sub-header">Column 1</span>
                                        </td>
                                        <td>
                                            <span>1</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 2</span>
                                        </td>
                                        <td>
                                            <span>2</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 3</span>
                                        </td>
                                        <td>
                                            <span>3</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 4</span>
                                        </td>
                                        <td>
                                            <span>4</span>
                                        </td>
                                    </tr>
                                </table>


                            </div>
                        </div>

                        <div class="outer-div">
                            <div>
                                <table class="card-table">
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <span class="card-header">P3</span>
                                        </td>
                                    </tr>
                                    <tr>

                                        <td>
                                            <span class="card-sub-header">Column 1</span>
                                        </td>
                                        <td>
                                            <span>1</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 2</span>
                                        </td>
                                        <td>
                                            <span>2</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 3</span>
                                        </td>
                                        <td>
                                            <span>3</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 4</span>
                                        </td>
                                        <td>
                                            <span>4</span>
                                        </td>
                                    </tr>
                                </table>


                            </div>
                        </div>

                        <div class="outer-div">
                            <div>
                                <table class="card-table">
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <span class="card-header">P3</span>
                                        </td>
                                    </tr>
                                    <tr>

                                        <td>
                                            <span class="card-sub-header">Column 1</span>
                                        </td>
                                        <td>
                                            <span>1</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 2</span>
                                        </td>
                                        <td>
                                            <span>2</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 3</span>
                                        </td>
                                        <td>
                                            <span>3</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 4</span>
                                        </td>
                                        <td>
                                            <span>4</span>
                                        </td>
                                    </tr>
                                </table>


                            </div>
                        </div>
                    </div>--%>
                        </div>
                        <div id="menu3" class="tab-pane fade">
                            <div class="graph-section" id="graphsix">
                                <div class=" graph-div">
                                    <div id='msgraph1'></div>
                                </div>
                                <div class="graph-div">
                                    <div id="msgraph2"></div>
                                </div>
                                <div class="graph-div">
                                    <div id="msgraph3"></div>
                                </div>
                                <div class="graph-div">
                                    <div id="msgraph4"></div>
                                </div>
                                <div class="graph-div">
                                    <div id="msgraph5"></div>
                                </div>
                                <div class="graph-div">
                                    <div id="msgraph6"></div>
                                </div>
                                <div class="graph-div">
                                    <div id="msgraph7"></div>
                                </div>
                                <div class="graph-div">
                                    <div id="msgraph8"></div>
                                </div>
                                <div class="graph-div">
                                    <div id="msgraph9"></div>
                                </div>
                                <div class="graph-div">
                                    <div id="msgraph10"></div>
                                </div>
                            </div>
                            <%--    <div class="listView">
                        <table class="P1Table">
                            <tr>
                                <th>Column 1</th>
                                <th>Column 2</th>
                                <th>Column 3</th>
                                <th>Column 4</th>

                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                        </table>
                    </div>
                    <div class="cardView" style="display: none">
                        <div class="outer-div">
                            <div>
                                <table class="card-table">
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <span class="card-header">P4</span>
                                        </td>
                                    </tr>
                                    <tr>

                                        <td>
                                            <span class="card-sub-header">Column 1</span>
                                        </td>
                                        <td>
                                            <span>1</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 2</span>
                                        </td>
                                        <td>
                                            <span>2</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 3</span>
                                        </td>
                                        <td>
                                            <span>3</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 4</span>
                                        </td>
                                        <td>
                                            <span>4</span>
                                        </td>
                                    </tr>
                                </table>


                            </div>
                        </div>

                        <div class="outer-div">
                            <div>
                                <table class="card-table">
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <span class="card-header">P4</span>
                                        </td>
                                    </tr>
                                    <tr>

                                        <td>
                                            <span class="card-sub-header">Column 1</span>
                                        </td>
                                        <td>
                                            <span>1</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 2</span>
                                        </td>
                                        <td>
                                            <span>2</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 3</span>
                                        </td>
                                        <td>
                                            <span>3</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 4</span>
                                        </td>
                                        <td>
                                            <span>4</span>
                                        </td>
                                    </tr>
                                </table>


                            </div>
                        </div>

                        <div class="outer-div">
                            <div>
                                <table class="card-table">
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <span class="card-header">P4</span>
                                        </td>
                                    </tr>
                                    <tr>

                                        <td>
                                            <span class="card-sub-header">Column 1</span>
                                        </td>
                                        <td>
                                            <span>1</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 2</span>
                                        </td>
                                        <td>
                                            <span>2</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 3</span>
                                        </td>
                                        <td>
                                            <span>3</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 4</span>
                                        </td>
                                        <td>
                                            <span>4</span>
                                        </td>
                                    </tr>
                                </table>


                            </div>
                        </div>

                        <div class="outer-div">
                            <div>
                                <table class="card-table">
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <span class="card-header">P4</span>
                                        </td>
                                    </tr>
                                    <tr>

                                        <td>
                                            <span class="card-sub-header">Column 1</span>
                                        </td>
                                        <td>
                                            <span>1</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 2</span>
                                        </td>
                                        <td>
                                            <span>2</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 3</span>
                                        </td>
                                        <td>
                                            <span>3</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 4</span>
                                        </td>
                                        <td>
                                            <span>4</span>
                                        </td>
                                    </tr>
                                </table>


                            </div>
                        </div>
                    </div>--%>
                        </div>
                        <div id="menu4" class="tab-pane fade">

                            <div class="listView">
                                <table class="P1Table">
                                    <tr>
                                        <th>Column 1</th>
                                        <th>Column 2</th>
                                        <th>Column 3</th>
                                        <th>Column 4</th>

                                    </tr>
                                    <tr>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>3</td>
                                        <td>4</td>
                                    </tr>
                                    <tr>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>3</td>
                                        <td>4</td>
                                    </tr>
                                    <tr>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>3</td>
                                        <td>4</td>
                                    </tr>
                                    <tr>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>3</td>
                                        <td>4</td>
                                    </tr>
                                    <tr>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>3</td>
                                        <td>4</td>
                                    </tr>
                                    <tr>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>3</td>
                                        <td>4</td>
                                    </tr>
                                    <tr>
                                        <td>1</td>
                                        <td>2</td>
                                        <td>3</td>
                                        <td>4</td>
                                    </tr>
                                </table>
                            </div>
                            <div class="cardView" style="display: none">
                                <div class="outer-div">
                                    <div>
                                        <table class="card-table">
                                            <tr>
                                                <td colspan="2" style="text-align: center">
                                                    <span class="card-header">P4</span>
                                                </td>
                                            </tr>
                                            <tr>

                                                <td>
                                                    <span class="card-sub-header">Column 1</span>
                                                </td>
                                                <td>
                                                    <span>1</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Column 2</span>
                                                </td>
                                                <td>
                                                    <span>2</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Column 3</span>
                                                </td>
                                                <td>
                                                    <span>3</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Column 4</span>
                                                </td>
                                                <td>
                                                    <span>4</span>
                                                </td>
                                            </tr>
                                        </table>


                                    </div>
                                </div>

                                <div class="outer-div">
                                    <div>
                                        <table class="card-table">
                                            <tr>
                                                <td colspan="2" style="text-align: center">
                                                    <span class="card-header">P4</span>
                                                </td>
                                            </tr>
                                            <tr>

                                                <td>
                                                    <span class="card-sub-header">Column 1</span>
                                                </td>
                                                <td>
                                                    <span>1</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Column 2</span>
                                                </td>
                                                <td>
                                                    <span>2</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Column 3</span>
                                                </td>
                                                <td>
                                                    <span>3</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Column 4</span>
                                                </td>
                                                <td>
                                                    <span>4</span>
                                                </td>
                                            </tr>
                                        </table>


                                    </div>
                                </div>

                                <div class="outer-div">
                                    <div>
                                        <table class="card-table">
                                            <tr>
                                                <td colspan="2" style="text-align: center">
                                                    <span class="card-header">P4</span>
                                                </td>
                                            </tr>
                                            <tr>

                                                <td>
                                                    <span class="card-sub-header">Column 1</span>
                                                </td>
                                                <td>
                                                    <span>1</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Column 2</span>
                                                </td>
                                                <td>
                                                    <span>2</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Column 3</span>
                                                </td>
                                                <td>
                                                    <span>3</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Column 4</span>
                                                </td>
                                                <td>
                                                    <span>4</span>
                                                </td>
                                            </tr>
                                        </table>


                                    </div>
                                </div>

                                <div class="outer-div">
                                    <div>
                                        <table class="card-table">
                                            <tr>
                                                <td colspan="2" style="text-align: center">
                                                    <span class="card-header">P4</span>
                                                </td>
                                            </tr>
                                            <tr>

                                                <td>
                                                    <span class="card-sub-header">Column 1</span>
                                                </td>
                                                <td>
                                                    <span>1</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Column 2</span>
                                                </td>
                                                <td>
                                                    <span>2</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Column 3</span>
                                                </td>
                                                <td>
                                                    <span>3</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="card-sub-header">Column 4</span>
                                                </td>
                                                <td>
                                                    <span>4</span>
                                                </td>
                                            </tr>
                                        </table>


                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>


                </div>


            </ContentTemplate>
        </asp:UpdatePanel>

        <div class="panel panel-default panel-subitems" id="zoomChartPanel" style="width: 1100px; top: 150px; left: 200px">
            <div class="panel-body">
                <i class="glyphicon glyphicon-remove" onmouseout="$('#zoomChartPanel').css('visibility', 'hidden');"></i>
                <div id="zoomChartContainer"></div>
            </div>
        </div>
    </div>
    <script>
        $(document).ready(function () {

            $("#menu0").addClass("in active");
            $("#activeMenu").val("#menu0");
            $("a[href$='#menu0']").removeClass("selected-menu-style").addClass("menu0-select");
            $("a[href$='#menu0']").closest('li').find('i').addClass("arrow up");
            // bindMultiSelectGraph();
            //bindMultiSelectGraph6();
        });


        //graph

        var graph1 = [
            {
                domain: { x: [0, 1], y: [0, 1] },
                value: 450,
                title: { text: "Speed" },
                type: "indicator",
                mode: "gauge+number+delta",
                delta: { reference: 380 },
                gauge: {
                    axis: { range: [null, 500] },
                    steps: [
                        { range: [0, 250], color: "lightgray" },
                        { range: [250, 400], color: "gray" }
                    ],
                    threshold: {
                        line: { color: "red", width: 4 },
                        thickness: 0.75,
                        value: 490
                    }
                }
            }
        ];
        var layout = { margin: { t: 0, b: 0 } };
        //var layout = {  paper_bgcolor: 'rgb(23,30,33)',color: 'blue', width: 600, height: 450, margin: { t: 0, b: 0 } };
        //    var layout=Layout(
        //paper_bgcolor='rgb(233,233,233)');
        Plotly.newPlot('graph1', graph1, layout);

        Highcharts.chart('graph2', {
            chart: {
                type: 'pie',
                options3d: {
                    enabled: true,
                    alpha: 10
                },
                backgroundColor: 'rgb(50, 56, 61)'
            },
            credits: {
                enabled: false
            },
            title: {
                text: 'Run Time',
                style: {
                    color: 'White'
                }
            },
            subtitle: {
                // text: '3D donut in Highcharts'
            },
            plotOptions: {
                pie: {
                    innerSize: 100,
                    depth: 45
                }
            },
            //legend: {
            //    style: {
            //        color: '#efefef'
            //    },
            //    itemStyle: {
            //        color: '#efefef'
            //    },
            //    itemHoverStyle: {
            //        color: 'grey'
            //    }
            //},
            series: [{
                name: 'Delivered amount',
                data: [
                    ['Cycle Time (min)', 80],
                    ['Load Unload (min)', 13],
                    ['Stoppage', 11],
                    ['ManagementLoss', 60],
                    ['PlannedDT', 28]
                ]
            }]
        });


        $("#graph3").ejLinearGauge({
            height: 550,
            width: 500,
            labelColor: "#8c8c8c",
            enableAnimation: false,
            scales: [{

                type: "thermometer",
                backgroundColor: "transparent",
                minimum: -10,
                maximum: 110,
                minorIntervalValue: 5,
                width: 20,
                position: { x: 50, y: 18 },
                length: 355,
                border: { width: 0.5 },
                markerPointers: [{ opacity: 0 }],

                barPointers: [{
                    width: 10,
                    distanceFromScale: -0.5,
                    value: 37,
                    backgroundColor: "#DB3738"
                }],
                labels: [{
                    placement: "near",
                    textColor: 'white',
                    font: {
                        size: "10px", fontFamily: "Segoe UI",
                        fontStyle: "Normal"
                    }
                },
                {
                    placement: "far",
                    distanceFromScale: { x: 10 }
                }],

                ticks: [{
                    type: "majorinterval",
                    height: 8,
                    width: 1,
                    color: "#8c8c8c",
                    distanceFromScale: { y: -4 }
                }, {
                    type: "minorinterval",
                    height: 4,
                    width: 1,
                    color: "#8c8c8c",
                    distanceFromScale: { y: -4 }
                }, {
                    type: "majorinterval",
                    placement: "far",
                    height: 8,
                    width: 1,
                    color: "#8c8c8c",
                    distanceFromScale: { y: -4 }
                }, {
                    type: "minorinterval",
                    placement: "far",
                    height: 4,
                    width: 1,
                    color: "#8c8c8c",
                    distanceFromScale: { y: -4 }
                }],


                //    customLabels: [{
                //    value: "(° C)",
                //    position: { x: 44, y: 78 },
                //    font: "Bold 12px Segoe UI", color: "#666666"
                //}, {
                //    value: "(° F)",
                //    position: { x: 56, y: 78 },
                //    font: "Bold 12px Segoe UI", color: "#666666"
                //},
                //{
                //    position: { x: 51, y: 90 },
                //    font: "Bold 13px Segoe UI",
                //    color: "#666666"
                //}]
                //    //Add the pointers customization code here
                //    //Add the labels customization code here
                //    //Add the ticks customization code here
                //    //Add the Custom labels customization code here
            }],
            //  drawLabels: "DrawLabel"



            //drawCustomLabel: "DrawCustomLabel",
            //drawLabels: "DrawLabel"
        });

        let range = [
            { startValue: 50, endValue: 90, thickness: 30 },
            { startValue: 90, endValue: 130 },
            { startValue: 130, endValue: 250 }
        ];

        $("#graph4").dxCircularGauge({
            scale: {
                startValue: 50,
                endValue: 250,
                tickInterval: 10,
                label: {
                    useRangeColors: true
                }
            },
            size: {
                height: 400,
                width: 750
            },
            rangeContainer: {
                palette: "pastel",
                ranges: range
            },
            //title: {
            //    text: "Temperature",
            //    font: { size: 28 }
            //},
            "export": {
                enabled: true
            },
            value: 105
        });

        function selectColumn() {
            if ($(menu).find("#tblCompanyDashboard").length > 0) {
                let chstr = "";
                let checked_checkboxes = $('#cblColumnSelector input:checked');
                checked_checkboxes.each(function () {
                    if (chstr == "") {
                        debugger;
                        chstr = $(this).val();
                    } else {
                        chstr = chstr + ',' + $(this).val();
                    }
                });
                for (let i = 0; i < $('#tblCompanyDashboard th').length; i++) {
                    let th = $('#tblCompanyDashboard th')[i];
                    let td = $('#tblCompanyDashboard td')[i];
                    let name = $(th).text();
                    if (chstr.includes(name)) {
                        $(th).css('display', 'table-cell');
                        for (let j = 1; j < $('#tblCompanyDashboard tr').length; j++) {
                            let trs = $('#tblCompanyDashboard tr');
                            let tr = $(trs)[j];
                            let innertd = $(tr).children()[i];
                            $(innertd).css('display', 'table-cell');
                        }
                    } else {
                        $(th).css('display', 'none');
                        for (let j = 1; j < $('#tblCompanyDashboard tr').length; j++) {
                            let trs = $('#tblCompanyDashboard tr');
                            let tr = $(trs)[j];
                            let innertd = $(tr).children()[i];
                            $(innertd).css('display', 'none');
                        }
                    }
                }
            }

            if ($(menu).find("#tblPlantDashboard").length > 0) {
                let chstr = "";
                let checked_checkboxes = $('#cblColumnSelector input:checked');
                checked_checkboxes.each(function () {
                    if (chstr == "") {
                        debugger;
                        chstr = $(this).val();
                    } else {
                        chstr = chstr + ',' + $(this).val();
                    }
                });
                for (let i = 0; i < $('#tblPlantDashboard th').length; i++) {
                    let th = $('#tblPlantDashboard th')[i];
                    let td = $('#tblPlantDashboard td')[i];
                    let name = $(th).text();
                    if (chstr.includes(name)) {
                        $(th).css('display', 'table-cell');
                        for (let j = 1; j < $('#tblPlantDashboard tr').length; j++) {
                            let trs = $('#tblPlantDashboard tr');
                            let tr = $(trs)[j];
                            let innertd = $(tr).children()[i];
                            $(innertd).css('display', 'table-cell');
                        }
                    } else {
                        $(th).css('display', 'none');
                        for (let j = 1; j < $('#tblPlantDashboard tr').length; j++) {
                            let trs = $('#tblPlantDashboard tr');
                            let tr = $(trs)[j];
                            let innertd = $(tr).children()[i];
                            $(innertd).css('display', 'none');
                        }
                    }
                }
            }

            if ($(menu).find("#tblCellDashboard").length > 0) {
                let chstr = "";
                let checked_checkboxes = $('#cblColumnSelector input:checked');
                checked_checkboxes.each(function () {
                    if (chstr == "") {
                        debugger;
                        chstr = $(this).val();
                    } else {
                        chstr = chstr + ',' + $(this).val();
                    }
                });
                for (let i = 0; i < $('#tblCellDashboard th').length; i++) {
                    let th = $('#tblCellDashboard th')[i];
                    let td = $('#tblCellDashboard td')[i];
                    let name = $(th).text();
                    if (chstr.includes(name)) {
                        $(th).css('display', 'table-cell');
                        for (let j = 1; j < $('#tblCellDashboard tr').length; j++) {
                            let trs = $('#tblCellDashboard tr');
                            let tr = $(trs)[j];
                            let innertd = $(tr).children()[i];
                            $(innertd).css('display', 'table-cell');
                        }
                    } else {
                        $(th).css('display', 'none');
                        for (let j = 1; j < $('#tblCellDashboard tr').length; j++) {
                            let trs = $('#tblCellDashboard tr');
                            let tr = $(trs)[j];
                            let innertd = $(tr).children()[i];
                            $(innertd).css('display', 'none');
                        }
                    }
                }
            }
            if ($(menu).find("#tblMachineDashboard").length > 0) {
                let chstr = "";
                let checked_checkboxes = $('#cblColumnSelector input:checked');
                checked_checkboxes.each(function () {
                    if (chstr == "") {
                        debugger;
                        chstr = $(this).val();
                    } else {
                        chstr = chstr + ',' + $(this).val();
                    }
                });
                for (let i = 0; i < $('#tblMachineDashboard th').length; i++) {
                    let th = $('#tblMachineDashboard th')[i];
                    let td = $('#tblMachineDashboard td')[i];
                    let name = $(th).text();
                    if (chstr.includes(name)) {
                        $(th).css('display', 'table-cell');
                        for (let j = 1; j < $('#tblMachineDashboard tr').length; j++) {
                            let trs = $('#tblMachineDashboard tr');
                            let tr = $(trs)[j];
                            let innertd = $(tr).children()[i];
                            $(innertd).css('display', 'table-cell');
                        }
                    } else {
                        $(th).css('display', 'none');
                        for (let j = 1; j < $('#tblMachineDashboard tr').length; j++) {
                            let trs = $('#tblMachineDashboard tr');
                            let tr = $(trs)[j];
                            let innertd = $(tr).children()[i];
                            $(innertd).css('display', 'none');
                        }
                    }
                }
            }

            return false;
        }
        function selectRows() {
            if ($(menu).find("#tblCompanyDashboard").length > 0) {
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
                        debugger;
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
            if ($(menu).find("#tblPlantDashboard").length > 0) {
                let chstr = "";
                let checked_checkboxes = $('#cblRowSelector input:checked');
                checked_checkboxes.each(function () {
                    if (chstr == "") {
                        debugger;
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
            if ($(menu).find("#tblCellDashboard").length > 0) {
                let chstr = "";
                let checked_checkboxes = $('#cblRowSelector input:checked');
                checked_checkboxes.each(function () {
                    if (chstr == "") {
                        debugger;
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
            if ($(menu).find("#tblMachineDashboard").length > 0) {
                let chstr = "";
                let checked_checkboxes = $('#cblRowSelector input:checked');
                checked_checkboxes.each(function () {
                    if (chstr == "") {
                        debugger;
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
            return false;
        }

        function getMonthDetails() {
            $.ajax({
                async: false,
                type: "POST",
                url: '<%= ResolveUrl("Production1.aspx/getMonthChartData") %>',
                contentType: "application/json; charset=utf-8",
                crossDomain: true,
                data: '{view: "' + $(hfMainView).val() + '"}',
                dataType: "json",
                success: function (response) {
                    dataitem = response.d;
                    $("#monthgrid").empty();
                    $("#monthData").empty();
                    let chstr = "";
                    let tableForGraph = "";
                    tableForGraph = " <table id='datatable'><tr><th></th>";
                    let checked_checkboxes = $('#cblRowSelector input:checked');
                    checked_checkboxes.each(function () {
                        if (chstr == "") {
                            chstr = $(this).val();
                        } else {
                            chstr = chstr + ',' + $(this).val();
                        }
                        tableForGraph += "<th>" + $(this).val() + "</th>";
                    });
                    let month = "";
                    let tableForGrid = "";
                    tableForGrid = "<table class='P1Table '><tr>";
                    if ($(menu).find("#tblCompanyDashboard").length > 0) {
                        for (let i = 0; i < $('#tblCompanyDashboard tr th').length; i++) {
                            let th = $('#tblCompanyDashboard tr th')[i];
                            let thname = $(th).text();
                            tableForGrid += "<th>" + thname + "</th>";
                        }
                        tableForGrid += "</tr>";
                        for (let i = 0; i < dataitem.length; i++) {
                            if (month != dataitem[i].Month) {
                                tableForGrid += "<tr><td style='color: #08c1df;border-bottom: 1px solid; font-weight: bold; text-align: center' colspan='"+$('#tblCompanyDashboard tr th').length +"'>" + dataitem[i].Month + "</td></tr>";
                                month = dataitem[i].Month;
                            }
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

                    if ($(menu).find("#tblPlantDashboard").length > 0) {
                        for (let i = 0; i < $('#tblPlantDashboard tr th').length; i++) {
                            let th = $('#tblPlantDashboard tr th')[i];
                            let thname = $(th).text();
                            tableForGrid += "<th>" + thname + "</th>";
                        }
                        tableForGrid += "</tr>";
                        for (let i = 0; i < dataitem.length; i++) {
                            if (month != dataitem[i].Month) {
                                tableForGrid += "<tr><td style='color: #08c1df;border-bottom: 1px solid; font-weight: bold; text-align: center' colspan='" + $('#tblPlantDashboard tr th').length + "'>" + dataitem[i].Month + "</td></tr>";
                                month = dataitem[i].Month;
                            }
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

                    if ($(menu).find("#tblCellDashboard").length > 0) {
                        for (let i = 0; i < $('#tblCellDashboard tr th').length; i++) {
                            let th = $('#tblCellDashboard tr th')[i];
                            let thname = $(th).text();
                            tableForGrid += "<th>" + thname + "</th>";
                        }
                        tableForGrid += "</tr>";
                        for (let i = 0; i < dataitem.length; i++) {
                            if (month != dataitem[i].Month) {
                                tableForGrid += "<tr><td style='color: #08c1df;border-bottom: 1px solid; font-weight: bold; text-align: center' colspan='" + $('#tblCellDashboard tr th').length + "'>" + dataitem[i].Month + "</td></tr>";
                                month = dataitem[i].Month;
                            }
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
                    if ($(menu).find("#tblMachineDashboard").length > 0) {
                        for (let i = 0; i < $('#tblMachineDashboard tr th').length; i++) {
                            let th = $('#tblMachineDashboard tr th')[i];
                            let thname = $(th).text();
                            tableForGrid += "<th>" + thname + "</th>";
                        }
                        tableForGrid += "</tr>";
                        for (let i = 0; i < dataitem.length; i++) {
                            if (month != dataitem[i].Month) {
                                tableForGrid += "<tr><td style='color: #08c1df;border-bottom: 1px solid; font-weight: bold; text-align: center' colspan='" + $('#tblMachineDashboard tr th').length + "'>" + dataitem[i].Month + "</td></tr>";
                                month = dataitem[i].Month;
                            }
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
                    $('#monthData').append(tableForGrid);
              

                 
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
                    $("#monthgrid").append(tableForGraph);

                  
                },
                error: function (Result) {
                    alert("Error" + Result);
                }
            });
            Highcharts.chart('monthChart', {
                data: {
                    table: 'datatable'
                },
                chart: {
                    type: 'column',
                    zoomType: 'x'
                },
                title: {
                    text: 'Month Graph',
                        style: {
                            color: 'white'
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
            return false;
        }
        function bindColumnChart() {

            var dataitem;
            var yaxis = [];
            var xaxis = [];
            $.ajax({
                async: false,
                type: "POST",
                url: '<%= ResolveUrl("Production1.aspx/getYearChartData") %>',
                contentType: "application/json; charset=utf-8",
                crossDomain: true,
                data: '{view: "' + $(hfMainView).val() + '"}',
                dataType: "json",
                success: function (response) {
                    dataitem = response.d;
                    //xaxis = dataitem.xAxis;
                    //yaxis = dataitem.yAxis;

                    let chstr = "";
                    let checked_checkboxes = $('#cblRowSelector input:checked');
                    checked_checkboxes.each(function () {
                        if (chstr == "") {
                            debugger;
                            chstr = $(this).val();
                        } else {
                            chstr = chstr + ',' + $(this).val();
                        }
                    });
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
            Highcharts.chart('yearChart', {
                chart: {
                    type: 'column',
                  
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
                    text: 'Year Graph',
                    style: {
                        color: 'White'
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
                        text: ''
                    },
                  className: 'highchart-xyaxis-label'
                },
                xAxis: {
                    allowDecimals: false,
                    categories: xaxis,
                    title: {
                        // text: dataitem.xAxis
                    },
                   className: 'highchart-xyaxis-label'
                },
                plotOptions: {
                    column: {
                        depth: 25
                    }
                },
                series: [{
                    color: '#1815e8',
                    data: yaxis,
                    showInLegend: false,
                    pointPadding: -0.3
                }]
            });


            return false;
        };

        function bindMultiSelectGraph() {

            var checked_checkboxes = $("[id*=cbgraphFilter] input:checked");
            $("#msGraph1").empty();
            $("#msGraph2").empty();
            $("#msGraph3").empty();
            checked_checkboxes.each(function () {

                var value = $(this).val();
                if (value == "Graph1") {
                    Highcharts.chart('msGraph1', {
                        chart: {
                            backgroundColor: '#171e21',
                            zoomType: 'x'
                        },
                        credits: {
                            enabled: false
                        },
                        title: {
                            text: 'Graph 1',
                            style: {
                                color: 'white',
                                fontSize: '20px'
                            }
                        },

                        //subtitle: {
                        //    text: 'Source: thesolarfoundation.com'
                        //},

                        yAxis: {
                            title: {
                                //text: 'Number of Employees'
                            },
                            labels: {
                                style: {
                                    color: 'white'
                                }
                            }
                        },

                        xAxis: {
                            accessibility: {
                                // rangeDescription: 'Range: 2010 to 2017'
                            },
                            labels: {
                                style: {
                                    color: 'white'
                                }
                            }
                        },

                        legend: {
                            layout: 'vertical',
                            align: 'right',
                            verticalAlign: 'middle',
                            itemStyle: {
                                color: 'white',
                                // fontWeight: 'bold'
                            }
                        },

                        plotOptions: {
                            series: {
                                label: {
                                    connectorAllowed: false
                                },
                                pointStart: 2010
                            }
                        },

                        series: [{
                            name: 'Installation1',
                            data: [43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175, 43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175, 43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175, 43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175, 43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175, 43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175, 43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175, 43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175, 43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175, 43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175, 43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175]
                        }],

                        responsive: {
                            rules: [{
                                condition: {
                                    maxWidth: 500
                                },
                                chartOptions: {
                                    legend: {
                                        layout: 'horizontal',
                                        align: 'center',
                                        verticalAlign: 'bottom'
                                    }
                                }
                            }]
                        }

                    });
                }
                if (value == "Graph2") {

                    var data = [];
                    var type;
                    $.ajax({
                        async: false,
                        type: "POST",
                        url: '<%= ResolveUrl("Production1.aspx/getChartData") %>',
                        contentType: "application/json; charset=utf-8",
                        crossDomain: true,
                        // data: '{Independentparametervalue: "' + $(val).val() + '"}',
                        dataType: "json",
                        success: function (response) {
                            var dataitem = response.d;
                            if (dataitem != null || dataitem.length > 0) {
                                data = dataitem.data;
                                type = dataitem.type;
                                console.log(data);
                                console.log(type);
                            }
                        },
                        error: function (Result) {
                            alert("Error" + Result);
                        }
                    });

                    //  Highcharts.getJSON('https://cdn.jsdelivr.net/gh/highcharts/highcharts@v7.0.0/samples/data/usdeur.json', function (data) {

                    // Create the chart
                    Highcharts.stockChart('msGraph2', {

                        chart: {
                            backgroundColor: '#171e21'
                        },
                        credits: {
                            enabled: false
                        },
                        rangeSelector: {
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
                            text: 'Graph 2',
                            style: {
                                color: 'white',
                                fontSize: '20px'
                            }
                        },

                        tooltip: {
                            style: {
                                width: '200px'
                            },
                            valueDecimals: 4,
                            shared: true
                        },
                        xAxis: {
                            accessibility: {
                                // rangeDescription: 'Range: 2010 to 2017'
                            },
                            labels: {
                                style: {
                                    color: 'white'
                                }
                            }
                        },
                        plotOptions: {
                            series: {
                                cursor: 'pointer',
                                point: {
                                    events: {
                                        click: function () {

                                            //  alert('Category: ' + this.category + ', value: ' + this.y);
                                            // alert(e.data.length);
                                            //let dataForZoom = [];
                                            let xvalue = this.category;
                                            let yvalue = this.y;
                                            //for (let i = 0; i < data.length; i++) {
                                            //    // for (let j = 0; j < 2; j++) {

                                            //    if (xvalue == data[i][0] && yvalue == data[i][1]) {
                                            //        let k = 0;
                                            //        for (let j = i; j < 7; j++) {
                                            //            //dataForZoom[k,0] = data[j][0];
                                            //            //dataForZoom[k,1] = data[j][1];
                                            //            //dataForZoom.push(data[j][0], data[j][1]);
                                            //            var serie = new Array(data[j][0], data[j][1]);
                                            //            dataForZoom.push(serie);
                                            //            k++;
                                            //        }
                                            //    }
                                            //    // }
                                            //}

                                            // console.log(dataForZoom);
                                            zoomOutChart(xvalue, yvalue);
                                            //alert(data[0][0]);
                                        }
                                    }
                                }
                            }
                        },
                        yAxis: {
                            title: {
                                // text: 'Exchange rate'
                            },
                            labels: {
                                style: {
                                    color: 'white'
                                }
                            }
                        },

                        series: [{
                            name: '',
                            data: data,
                            id: 'dataseries'

                            // the event marker flags
                        }, {
                            type: 'flags',
                            data: type,
                            onSeries: 'dataseries',
                            //shape: 'circlepin',
                            //width: 16
                            shape: 'squarepin',
                            width: 100
                        }]
                    });

                    //Highcharts.stockChart('msGraph2', {

                    //    chart: {
                    //        backgroundColor: '#171e21'
                    //    },
                    //    rangeSelector: {
                    //        selected: 1
                    //    },

                    //    title: {
                    //        text: 'Spindle Load'
                    //    },
                    //    xAxis: {
                    //        accessibility: {
                    //            // rangeDescription: 'Range: 2010 to 2017'
                    //        },
                    //        labels: {
                    //            style: {
                    //                color: 'white'
                    //            }
                    //        }
                    //    },
                    //    series: [{
                    //        name: 'AAPL Stock Price',
                    //        data: [43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175,43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175,43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175,43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175,43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175,43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175,43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175,43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175,43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175,43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175,43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175],
                    //        marker: {
                    //            enabled: true,
                    //            radius: 3
                    //        },
                    //        shadow: true,
                    //        tooltip: {
                    //            valueDecimals: 2
                    //        }
                    //    }]
                    //});
                    //Highcharts.chart('msGraph2', {
                    //    chart: {
                    //        backgroundColor: '#171e21'
                    //    },
                    //    title: {
                    //        text: 'Graph 2',
                    //        style: {
                    //            color: 'white',
                    //            fontSize: '20px'
                    //        }
                    //    },

                    //    //subtitle: {
                    //    //    text: 'Source: thesolarfoundation.com'
                    //    //},

                    //    yAxis: {
                    //        title: {
                    //            //text: 'Number of Employees'
                    //        },
                    //        labels: {
                    //            style: {
                    //                color: 'white'
                    //            }
                    //        }
                    //    },

                    //    xAxis: {
                    //        accessibility: {
                    //            // rangeDescription: 'Range: 2010 to 2017'
                    //        },
                    //        labels: {
                    //            style: {
                    //                color: 'white'
                    //            }
                    //        }
                    //    },

                    //    legend: {
                    //        layout: 'vertical',
                    //        align: 'right',
                    //        verticalAlign: 'middle',
                    //        itemStyle: {
                    //            color: 'white',
                    //            // fontWeight: 'bold'
                    //        }
                    //    },

                    //    plotOptions: {
                    //        series: {
                    //            label: {
                    //                connectorAllowed: false
                    //            },
                    //            pointStart: 2010
                    //        }
                    //    },

                    //    series: [{
                    //        name: 'Installation2',
                    //        data: [43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175]
                    //    }],

                    //    responsive: {
                    //        rules: [{
                    //            condition: {
                    //                maxWidth: 500
                    //            },
                    //            chartOptions: {
                    //                legend: {
                    //                    layout: 'horizontal',
                    //                    align: 'center',
                    //                    verticalAlign: 'bottom'
                    //                }
                    //            }
                    //        }]
                    //    }

                    //});
                }
                if (value == "Graph3") {
                    var data = [];
                    var type, plotLines;
                    $.ajax({
                        async: false,
                        type: "POST",
                        url: '<%= ResolveUrl("Production1.aspx/getChartData") %>',
                        contentType: "application/json; charset=utf-8",
                        crossDomain: true,
                        // data: '{Independentparametervalue: "' + $(val).val() + '"}',
                        dataType: "json",
                        success: function (response) {
                            var dataitem = response.d;
                            if (dataitem != null || dataitem.length > 0) {
                                data = dataitem.data;
                                type = dataitem.type;
                                plotLines = dataitem.plotLines;
                                console.log(data);
                                console.log(type);
                                console.log(plotLines);
                            }
                        },
                        error: function (Result) {
                            alert("Error" + Result);
                        }
                    });

                    //  Highcharts.getJSON('https://cdn.jsdelivr.net/gh/highcharts/highcharts@v7.0.0/samples/data/usdeur.json', function (data) {

                    // Create the chart
                    Highcharts.stockChart('msGraph3', {

                        chart: {
                            backgroundColor: '#171e21',
                            //events: {
                            //    drilldown: function (e) {
                            //        alert();
                            //        let datalist = [];
                            //        //for (let i = 0; i < data.drilldown.length; i++) {
                            //        //    if ("VMC-17" == data.drilldown[i].id) {
                            //        //        let k = 0;
                            //        //        for (let j = 0; j < data.drilldown[i].data.length; j++) {
                            //        //            if (data.drilldown[i].data[j].y != 0) {
                            //        //                datalist[k] = data.drilldown[i].data[j].y;
                            //        //                k++;
                            //        //            }
                            //        //        }
                            //        //    }
                            //        //}
                            //        alert(e.seriesOptions.data.length);
                            //        //let k = 0;
                            //        //for (let i = 0; i < e.seriesOptions.data.length; i++) {
                            //        //    if (e.seriesOptions.data[i].y != 0) {
                            //        //        datalist[k] = e.seriesOptions.data[i].y;
                            //        //        k++;
                            //        //    }
                            //        //}

                            //    }
                            //}
                        },
                        credits: {
                            enabled: false
                        },
                        rangeSelector: {
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
                            text: 'Graph 3',
                            style: {
                                color: 'white',
                                fontSize: '20px'
                            }
                        },

                        tooltip: {
                            style: {
                                width: '200px'
                            },
                            valueDecimals: 4,
                            shared: true
                        },
                        xAxis: {
                            accessibility: {
                                // rangeDescription: 'Range: 2010 to 2017'
                            },
                            labels: {
                                style: {
                                    color: 'white'
                                }
                            },
                            plotLines: plotLines
                        },
                        plotOptions: {
                            series: {
                                cursor: 'pointer',
                                point: {
                                    events: {
                                        click: function () {
                                            let xvalue = this.category;
                                            let yvalue = this.y;
                                            zoomOutChart(xvalue, yvalue);
                                        }
                                    }
                                }
                            }
                        },
                        yAxis: {
                            title: {
                                //  text: 'Exchange rate'
                            },
                            labels: {
                                style: {
                                    color: 'white'
                                }
                            }
                        },

                        series: [{
                            name: 'Value',
                            data: data,
                            id: 'dataseries'

                            // the event marker flags
                        }
                            , {
                            type: 'flags',
                            data: type,
                            onSeries: 'dataseries',
                            shape: 'squarepin',
                            width: 100
                        }
                        ]
                    });
                    // });

                    //    Highcharts.chart('msGraph3', {
                    //        chart: {
                    //            backgroundColor: '#171e21'
                    //        },
                    //        title: {
                    //            text: 'Graph 3',
                    //            style: {
                    //                color: 'white',
                    //                fontSize: '20px'
                    //            }
                    //        },

                    //        //subtitle: {
                    //        //    text: 'Source: thesolarfoundation.com'
                    //        //},

                    //        yAxis: {
                    //            title: {
                    //                //text: 'Number of Employees'
                    //            },
                    //            labels: {
                    //                style: {
                    //                    color: 'white'
                    //                }
                    //            }
                    //        },

                    //        xAxis: {
                    //            accessibility: {
                    //                // rangeDescription: 'Range: 2010 to 2017'
                    //            },
                    //            labels: {
                    //                style: {
                    //                    color: 'white'
                    //                }
                    //            }
                    //        },

                    //        legend: {
                    //            layout: 'vertical',
                    //            align: 'right',
                    //            verticalAlign: 'middle',
                    //            itemStyle: {
                    //                color: 'white',
                    //                // fontWeight: 'bold'
                    //            }
                    //        },

                    //        plotOptions: {
                    //            series: {
                    //                label: {
                    //                    connectorAllowed: false
                    //                },
                    //                pointStart: 2010
                    //            }
                    //        },

                    //        series: [{
                    //            name: 'Installation3',
                    //            data: [43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175]
                    //        }],

                    //        responsive: {
                    //            rules: [{
                    //                condition: {
                    //                    maxWidth: 500
                    //                },
                    //                chartOptions: {
                    //                    legend: {
                    //                        layout: 'horizontal',
                    //                        align: 'center',
                    //                        verticalAlign: 'bottom'
                    //                    }
                    //                }
                    //            }]
                    //        }

                    //    });
                }
                //var text = $(this).closest("td").find("label").html();
                //message += "Text: " + text + " Value: " + value;
                //message += "\n";
            });
            return false;
        }
        function zoomOutChart(xvalue, yvalue) {

            var dataitem;
            $.ajax({
                async: false,
                type: "POST",
                url: '<%= ResolveUrl("Production1.aspx/getzoomChartData") %>',
                contentType: "application/json; charset=utf-8",
                crossDomain: true,
                data: '{xvalue: "' + xvalue + '",yvalue: "' + yvalue + '" }',
                dataType: "json",
                success: function (response) {
                    dataitem = response.d;
                    //if (dataitem != null || dataitem.length > 0) {
                    //    data = dataitem.data;
                    //    type = dataitem.type;
                    //}
                },
                error: function (Result) {
                    alert("Error" + Result);
                }
            });
            document.getElementById('zoomChartPanel').style.visibility = "visible";
            Highcharts.stockChart('zoomChartContainer', {
                chart: {
                    backgroundColor: '#171e21'
                },
                credits: {
                    enabled: false
                },
                navigator: {
                    enabled: false
                },
                rangeSelector: {
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
                    //text: 'Zoom',
                    //style: {
                    //    color: 'white',
                    //    fontSize: '20px'
                    //}
                },

                tooltip: {
                    style: {
                        width: '200px'
                    },
                    valueDecimals: 4,
                    shared: true
                },
                xAxis: {
                    accessibility: {
                        // rangeDescription: 'Range: 2010 to 2017'
                    },
                    labels: {
                        style: {
                            color: 'white'
                        }
                    },
                    plotLines: dataitem.plotLines
                },

                yAxis: {
                    title: {
                        // text: 'Exchange rate'
                    },
                    labels: {
                        style: {
                            color: 'white'
                        }
                    }
                },

                series: [{
                    name: '',
                    data: dataitem.data,
                    id: 'dataseries'

                    // the event marker flags
                }
                    , {
                    type: 'flags',
                    data: dataitem.type,
                    onSeries: 'dataseries',
                    //shape: 'circlepin',
                    //width: 16
                    shape: 'squarepin',
                    width: 100
                }
                ]
            });
        }
        function bindMultiSelectGraph6() {


            var checked_checkboxes = $("[id*=cbgraph6Filter] input:checked");
            var totalCheckbox = $("[id*=cbgraph6Filter] input");
            $("#msgraph1").empty();
            $("#msgraph2").empty();
            $("#msgraph3").empty();
            $("#msgraph4").empty();
            $("#msgraph5").empty();
            $("#msgraph6").empty();
            $("#msgraph7").empty();
            $("#msgraph8").empty();
            $("#msgraph9").empty();
            $("#msgraph10").empty();
            if (checked_checkboxes.length <= 3) {
                $("#msgraph1").parent().css({ 'width': '100%', 'display': 'block' });
                $("#msgraph2").parent().css({ 'width': '100%', 'display': 'block' });
                $("#msgraph3").parent().css({ 'width': '100%', 'display': 'block' });
                $("#msgraph4").parent().css({ 'width': '100%', 'display': 'block' });
                $("#msgraph5").parent().css({ 'width': '100%', 'display': 'block' });
                $("#msgraph6").parent().css({ 'width': '100%', 'display': 'block' });
                $("#msgraph7").parent().css({ 'width': '100%', 'display': 'block' });
                $("#msgraph8").parent().css({ 'width': '100%', 'display': 'block' });
                $("#msgraph9").parent().css({ 'width': '100%', 'display': 'block' });
                $("#msgraph10").parent().css({ 'width': '100%', 'display': 'block' });

                // $("#msgraph1").parent().removeClass();
                //$("#msgraph2").parent().removeClass();
                //$("#msgraph3").parent().removeClass();
                //$("#msgraph4").parent().removeClass();
                //$("#msgraph5").parent().removeClass();
                //$("#msgraph6").parent().removeClass();

                //$("#msgraph1").parent().addClass('graph-div graph-div-6-remove');
                //$("#msgraph2").parent().addClass('graph-div graph-div-6-remove');
                //$("#msgraph3").parent().addClass('graph-div graph-div-6-remove');
                //$("#msgraph4").parent().addClass('graph-div graph-div-6-remove');
                //$("#msgraph5").parent().addClass('graph-div graph-div-6-remove');
                //$("#msgraph6").parent().addClass('graph-div graph-div-6-remove');
            }
            else {

                $("#msgraph1").parent().css({ 'width': '48%', 'display': 'inline-block' });
                $("#msgraph2").parent().css({ 'width': '48%', 'display': 'inline-block' });
                $("#msgraph3").parent().css({ 'width': '48%', 'display': 'inline-block' });
                $("#msgraph4").parent().css({ 'width': '48%', 'display': 'inline-block' });
                $("#msgraph5").parent().css({ 'width': '48%', 'display': 'inline-block' });
                $("#msgraph6").parent().css({ 'width': '48%', 'display': 'inline-block' });
                $("#msgraph7").parent().css({ 'width': '48%', 'display': 'inline-block' });
                $("#msgraph8").parent().css({ 'width': '48%', 'display': 'inline-block' });
                $("#msgraph9").parent().css({ 'width': '48%', 'display': 'inline-block' });
                $("#msgraph10").parent().css({ 'width': '48%', 'display': 'inline-block' });

                //$("#msgraph1").parent().removeClass();
                // $("#msgraph2").parent().removeClass();
                // $("#msgraph3").parent().removeClass();
                // $("#msgraph4").parent().removeClass();
                // $("#msgraph5").parent().removeClass();
                // $("#msgraph6").parent().removeClass();

                // $("#msgraph1").parent().addClass('graph-div graph-div-6-add');
                // $("#msgraph2").parent().addClass('graph-div graph-div-6-add');
                // $("#msgraph3").parent().addClass('graph-div graph-div-6-add');
                // $("#msgraph4").parent().addClass('graph-div graph-div-6-add');
                // $("#msgraph5").parent().addClass('graph-div graph-div-6-add');
                // $("#msgraph6").parent().addClass('graph-div graph-div-6-add');
            }
            let chstr = "";
            checked_checkboxes.each(function () {
                if (chstr == "") {
                    debugger;
                    chstr = $(this).val();
                } else {
                    chstr = chstr + ',' + $(this).val();
                }
            });
            chstr = chstr.toLowerCase();
            let graphdiv = $('#menu3 .graph-div > div');
            for (let j = 0; j < graphdiv.length; j++) {
                let div = graphdiv[j];
                let divid = $(div).attr('id').replace('ms', '');
                if (chstr.includes(divid)) {

                } else {
                    $("#" + $(div).attr('id')).parent().css({ 'display': 'none' });
                }
            }

            let i = 0;
            checked_checkboxes.each(function () {
                if (i == 6) {
                    return false;
                }
                i++;
                var value = $(this).val();
                if (value == "Graph1") {
                    Highcharts.chart('msgraph1', {
                        chart: {
                            backgroundColor: '#171e21',
                            zoomType: 'x'
                        },
                        credits: {
                            enabled: false
                        },
                        title: {
                            text: 'Graph 1',
                            style: {
                                color: 'white',
                                fontSize: '20px'
                            }
                        },
                        yAxis: {
                            title: {
                                //text: 'Number of Employees'
                            },
                            labels: {
                                style: {
                                    color: 'white'
                                }
                            }
                        },

                        xAxis: {
                            accessibility: {
                                // rangeDescription: 'Range: 2010 to 2017'
                            },
                            labels: {
                                style: {
                                    color: 'white'
                                }
                            }
                        },

                        legend: {
                            layout: 'vertical',
                            align: 'right',
                            verticalAlign: 'middle',
                            itemStyle: {
                                color: 'white',
                                // fontWeight: 'bold'
                            }
                        },

                        plotOptions: {
                            series: {
                                label: {
                                    connectorAllowed: false
                                },
                                pointStart: 2010
                            }
                        },

                        series: [{
                            name: 'Target',
                            data: [43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175],
                            color: '#3ca4f0'
                        },
                        {
                            name: 'Actual',
                            data: [24916, 24064, 29742, 29851, 32490, 30282, 38121, 40434],
                            color: 'red'
                        }
                        ],

                        responsive: {
                            rules: [{
                                condition: {
                                    maxWidth: 500
                                },
                                chartOptions: {
                                    legend: {
                                        layout: 'horizontal',
                                        align: 'center',
                                        verticalAlign: 'bottom'
                                    }
                                }
                            }]
                        }

                    });
                }
                if (value == "Graph2") {
                    Highcharts.chart('msgraph2', {
                        chart: {
                            backgroundColor: '#171e21',
                            zoomType: 'x'
                        },
                        credits: {
                            enabled: false
                        },
                        title: {
                            text: 'Graph 2',
                            style: {
                                color: 'white',
                                fontSize: '20px'
                            }
                        },

                        //subtitle: {
                        //    text: 'Source: thesolarfoundation.com'
                        //},

                        yAxis: {
                            title: {
                                //text: 'Number of Employees'
                            },
                            labels: {
                                style: {
                                    color: 'white'
                                }
                            }
                        },

                        xAxis: {
                            accessibility: {
                                // rangeDescription: 'Range: 2010 to 2017'
                            },
                            labels: {
                                style: {
                                    color: 'white'
                                }
                            }
                        },

                        legend: {
                            layout: 'vertical',
                            align: 'right',
                            verticalAlign: 'middle',
                            itemStyle: {
                                color: 'white',
                                // fontWeight: 'bold'
                            }
                        },

                        plotOptions: {
                            series: {
                                label: {
                                    connectorAllowed: false
                                },
                                pointStart: 2010
                            }
                        },

                        series: [{
                            name: 'Target',
                            data: [43934, 52503, 27177, 69658, 97031, 109931, 137133, 154175],
                            color: '#3ca4f0'
                        },
                        {
                            name: 'Actual',
                            data: [24916, 24064, 19742, 29851, 22490, 30282, 35121, 20434],
                            color: 'red'
                        }],

                        responsive: {
                            rules: [{
                                condition: {
                                    maxWidth: 500
                                },
                                chartOptions: {
                                    legend: {
                                        layout: 'horizontal',
                                        align: 'center',
                                        verticalAlign: 'bottom'
                                    }
                                }
                            }]
                        }

                    });
                }
                if (value == "Graph3") {
                    Highcharts.chart('msgraph3', {
                        chart: {
                            backgroundColor: '#171e21',
                            zoomType: 'x'
                        },
                        credits: {
                            enabled: false
                        },
                        title: {
                            text: 'Graph 3',
                            style: {
                                color: 'white',
                                fontSize: '20px'
                            }
                        },

                        //subtitle: {
                        //    text: 'Source: thesolarfoundation.com'
                        //},

                        yAxis: {
                            title: {
                                //text: 'Number of Employees'
                            },
                            labels: {
                                style: {
                                    color: 'white'
                                }
                            }
                        },

                        xAxis: {
                            accessibility: {
                                // rangeDescription: 'Range: 2010 to 2017'
                            },
                            labels: {
                                style: {
                                    color: 'white'
                                }
                            }
                        },

                        legend: {
                            layout: 'vertical',
                            align: 'right',
                            verticalAlign: 'middle',
                            itemStyle: {
                                color: 'white',
                                // fontWeight: 'bold'
                            }
                        },

                        plotOptions: {
                            series: {
                                label: {
                                    connectorAllowed: false
                                },
                                pointStart: 2010
                            }
                        },

                        series: [{
                            name: 'Target',
                            data: [43934, 62503, 77177, 69658, 87031, 119931, 127133, 354175],
                            color: '#3ca4f0'
                        },
                        {
                            name: 'Actual',
                            data: [24916, 21064, 29742, 19851, 32490, 36282, 38121, 80434],
                            color: 'red'
                        }],

                        responsive: {
                            rules: [{
                                condition: {
                                    maxWidth: 500
                                },
                                chartOptions: {
                                    legend: {
                                        layout: 'horizontal',
                                        align: 'center',
                                        verticalAlign: 'bottom'
                                    }
                                }
                            }]
                        }

                    });
                }

                if (value == "Graph4") {
                    Highcharts.chart('msgraph4', {
                        chart: {
                            backgroundColor: '#171e21',
                            zoomType: 'x'
                        },
                        credits: {
                            enabled: false
                        },
                        title: {
                            text: 'Graph 4',
                            style: {
                                color: 'white',
                                fontSize: '20px'
                            }
                        },

                        //subtitle: {
                        //    text: 'Source: thesolarfoundation.com'
                        //},

                        yAxis: {
                            title: {
                                //text: 'Number of Employees'
                            },
                            labels: {
                                style: {
                                    color: 'white'
                                }
                            }
                        },

                        xAxis: {
                            accessibility: {
                                // rangeDescription: 'Range: 2010 to 2017'
                            },
                            labels: {
                                style: {
                                    color: 'white'
                                }
                            }
                        },

                        legend: {
                            layout: 'vertical',
                            align: 'right',
                            verticalAlign: 'middle',
                            itemStyle: {
                                color: 'white',
                                // fontWeight: 'bold'
                            }
                        },

                        plotOptions: {
                            series: {
                                label: {
                                    connectorAllowed: false
                                },
                                pointStart: 2010
                            }
                        },

                        series: [{
                            name: 'Target',
                            data: [13934, 22503, 57177, 69658, 67031, 109931, 137133, 154175],
                            color: '#3ca4f0'
                        },
                        {
                            name: 'Actual',
                            data: [14916, 14064, 29742, 39851, 34490, 30282, 38121, 40434],
                            color: 'red'
                        }],

                        responsive: {
                            rules: [{
                                condition: {
                                    maxWidth: 500
                                },
                                chartOptions: {
                                    legend: {
                                        layout: 'horizontal',
                                        align: 'center',
                                        verticalAlign: 'bottom'
                                    }
                                }
                            }]
                        }

                    });
                }

                if (value == "Graph5") {
                    Highcharts.chart('msgraph5', {
                        chart: {
                            backgroundColor: '#171e21',
                            zoomType: 'x'
                        },
                        credits: {
                            enabled: false
                        },
                        title: {
                            text: 'Graph 5',
                            style: {
                                color: 'white',
                                fontSize: '20px'
                            }
                        },

                        //subtitle: {
                        //    text: 'Source: thesolarfoundation.com'
                        //},

                        yAxis: {
                            title: {
                                //text: 'Number of Employees'
                            },
                            labels: {
                                style: {
                                    color: 'white'
                                }
                            }
                        },

                        xAxis: {
                            accessibility: {
                                // rangeDescription: 'Range: 2010 to 2017'
                            },
                            labels: {
                                style: {
                                    color: 'white'
                                }
                            }
                        },

                        legend: {
                            layout: 'vertical',
                            align: 'right',
                            verticalAlign: 'middle',
                            itemStyle: {
                                color: 'white',
                                // fontWeight: 'bold'
                            }
                        },

                        plotOptions: {
                            series: {
                                label: {
                                    connectorAllowed: false
                                },
                                pointStart: 2010
                            }
                        },

                        series: [{
                            name: 'Target',
                            data: [43934, 52503, 87177, 69658, 107031, 219931, 167133, 164175],
                            color: '#3ca4f0'
                        },
                        {
                            name: 'Actual',
                            data: [24916, 27064, 24742, 29851, 36490, 30282, 32121, 43434],
                            color: 'red'
                        }],

                        responsive: {
                            rules: [{
                                condition: {
                                    maxWidth: 500
                                },
                                chartOptions: {
                                    legend: {
                                        layout: 'horizontal',
                                        align: 'center',
                                        verticalAlign: 'bottom'
                                    }
                                }
                            }]
                        }

                    });
                }

                if (value == "Graph6") {
                    Highcharts.chart('msgraph6', {
                        chart: {
                            backgroundColor: '#171e21',
                            zoomType: 'x'
                        },
                        credits: {
                            enabled: false
                        },
                        title: {
                            text: 'Graph 6',
                            style: {
                                color: 'white',
                                fontSize: '20px'
                            }
                        },

                        //subtitle: {
                        //    text: 'Source: thesolarfoundation.com'
                        //},

                        yAxis: {
                            title: {
                                //text: 'Number of Employees'
                            },
                            labels: {
                                style: {
                                    color: 'white'
                                }
                            }
                        },

                        xAxis: {
                            accessibility: {
                                // rangeDescription: 'Range: 2010 to 2017'
                            },
                            labels: {
                                style: {
                                    color: 'white'
                                }
                            }
                        },

                        legend: {
                            layout: 'vertical',
                            align: 'right',
                            verticalAlign: 'middle',
                            itemStyle: {
                                color: 'white',
                                // fontWeight: 'bold'
                            }
                        },

                        plotOptions: {
                            series: {
                                label: {
                                    connectorAllowed: false
                                },
                                pointStart: 2010
                            }
                        },

                        series: [{
                            name: 'Target',
                            data: [43934, 32503, 55177, 69658, 97031, 169931, 137133, 154175],
                            color: '#3ca4f0'
                        },
                        {
                            name: 'Actual',
                            data: [24916, 24064, 29742, 29851, 31490, 30282, 38121, 40434],
                            color: 'red'
                        }],

                        responsive: {
                            rules: [{
                                condition: {
                                    maxWidth: 500
                                },
                                chartOptions: {
                                    legend: {
                                        layout: 'horizontal',
                                        align: 'center',
                                        verticalAlign: 'bottom'
                                    }
                                }
                            }]
                        }

                    });
                }

                if (value == "Graph7") {
                    Highcharts.chart('msgraph7', {
                        chart: {
                            backgroundColor: '#171e21',
                            zoomType: 'x'
                        },
                        credits: {
                            enabled: false
                        },
                        title: {
                            text: 'Graph 7',
                            style: {
                                color: 'white',
                                fontSize: '20px'
                            }
                        },
                        yAxis: {
                            title: {
                                //text: 'Number of Employees'
                            },
                            labels: {
                                style: {
                                    color: 'white'
                                }
                            }
                        },

                        xAxis: {
                            accessibility: {
                                // rangeDescription: 'Range: 2010 to 2017'
                            },
                            labels: {
                                style: {
                                    color: 'white'
                                }
                            }
                        },

                        legend: {
                            layout: 'vertical',
                            align: 'right',
                            verticalAlign: 'middle',
                            itemStyle: {
                                color: 'white',
                                // fontWeight: 'bold'
                            }
                        },

                        plotOptions: {
                            series: {
                                label: {
                                    connectorAllowed: false
                                },
                                pointStart: 2010
                            }
                        },

                        series: [{
                            name: 'Target',
                            data: [43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175],
                            color: '#3ca4f0'
                        },
                        {
                            name: 'Actual',
                            data: [24916, 24064, 29742, 29851, 32490, 30282, 38121, 40434],
                            color: 'red'
                        }
                        ],

                        responsive: {
                            rules: [{
                                condition: {
                                    maxWidth: 500
                                },
                                chartOptions: {
                                    legend: {
                                        layout: 'horizontal',
                                        align: 'center',
                                        verticalAlign: 'bottom'
                                    }
                                }
                            }]
                        }

                    });
                }
                if (value == "Graph8") {
                    Highcharts.chart('msgraph8', {
                        chart: {
                            backgroundColor: '#171e21',
                            zoomType: 'x'
                        },
                        credits: {
                            enabled: false
                        },
                        title: {
                            text: 'Graph 8',
                            style: {
                                color: 'white',
                                fontSize: '20px'
                            }
                        },

                        //subtitle: {
                        //    text: 'Source: thesolarfoundation.com'
                        //},

                        yAxis: {
                            title: {
                                //text: 'Number of Employees'
                            },
                            labels: {
                                style: {
                                    color: 'white'
                                }
                            }
                        },

                        xAxis: {
                            accessibility: {
                                // rangeDescription: 'Range: 2010 to 2017'
                            },
                            labels: {
                                style: {
                                    color: 'white'
                                }
                            }
                        },

                        legend: {
                            layout: 'vertical',
                            align: 'right',
                            verticalAlign: 'middle',
                            itemStyle: {
                                color: 'white',
                                // fontWeight: 'bold'
                            }
                        },

                        plotOptions: {
                            series: {
                                label: {
                                    connectorAllowed: false
                                },
                                pointStart: 2010
                            }
                        },

                        series: [{
                            name: 'Target',
                            data: [43934, 52503, 27177, 69658, 97031, 109931, 137133, 154175],
                            color: '#3ca4f0'
                        },
                        {
                            name: 'Actual',
                            data: [24916, 24064, 19742, 29851, 22490, 30282, 35121, 20434],
                            color: 'red'
                        }],

                        responsive: {
                            rules: [{
                                condition: {
                                    maxWidth: 500
                                },
                                chartOptions: {
                                    legend: {
                                        layout: 'horizontal',
                                        align: 'center',
                                        verticalAlign: 'bottom'
                                    }
                                }
                            }]
                        }

                    });
                }
                if (value == "Graph9") {
                    Highcharts.chart('msgraph9', {
                        chart: {
                            backgroundColor: '#171e21',
                            zoomType: 'x'
                        },
                        credits: {
                            enabled: false
                        },
                        title: {
                            text: 'Graph 9',
                            style: {
                                color: 'white',
                                fontSize: '20px'
                            }
                        },

                        //subtitle: {
                        //    text: 'Source: thesolarfoundation.com'
                        //},

                        yAxis: {
                            title: {
                                //text: 'Number of Employees'
                            },
                            labels: {
                                style: {
                                    color: 'white'
                                }
                            }
                        },

                        xAxis: {
                            accessibility: {
                                // rangeDescription: 'Range: 2010 to 2017'
                            },
                            labels: {
                                style: {
                                    color: 'white'
                                }
                            }
                        },

                        legend: {
                            layout: 'vertical',
                            align: 'right',
                            verticalAlign: 'middle',
                            itemStyle: {
                                color: 'white',
                                // fontWeight: 'bold'
                            }
                        },

                        plotOptions: {
                            series: {
                                label: {
                                    connectorAllowed: false
                                },
                                pointStart: 2010
                            }
                        },

                        series: [{
                            name: 'Target',
                            data: [43934, 62503, 77177, 69658, 87031, 119931, 127133, 354175],
                            color: '#3ca4f0'
                        },
                        {
                            name: 'Actual',
                            data: [24916, 21064, 29742, 19851, 32490, 36282, 38121, 80434],
                            color: 'red'
                        }],

                        responsive: {
                            rules: [{
                                condition: {
                                    maxWidth: 500
                                },
                                chartOptions: {
                                    legend: {
                                        layout: 'horizontal',
                                        align: 'center',
                                        verticalAlign: 'bottom'
                                    }
                                }
                            }]
                        }

                    });
                }

                if (value == "Graph10") {
                    Highcharts.chart('msgraph10', {
                        chart: {
                            backgroundColor: '#171e21',
                            zoomType: 'x'
                        },
                        credits: {
                            enabled: false
                        },
                        title: {
                            text: 'Graph 10',
                            style: {
                                color: 'white',
                                fontSize: '20px'
                            }
                        },

                        //subtitle: {
                        //    text: 'Source: thesolarfoundation.com'
                        //},

                        yAxis: {
                            title: {
                                //text: 'Number of Employees'
                            },
                            labels: {
                                style: {
                                    color: 'white'
                                }
                            }
                        },

                        xAxis: {
                            accessibility: {
                                // rangeDescription: 'Range: 2010 to 2017'
                            },
                            labels: {
                                style: {
                                    color: 'white'
                                }
                            }
                        },

                        legend: {
                            layout: 'vertical',
                            align: 'right',
                            verticalAlign: 'middle',
                            itemStyle: {
                                color: 'white',
                                // fontWeight: 'bold'
                            }
                        },

                        plotOptions: {
                            series: {
                                label: {
                                    connectorAllowed: false
                                },
                                pointStart: 2010
                            }
                        },

                        series: [{
                            name: 'Target',
                            data: [13934, 22503, 57177, 69658, 67031, 109931, 137133, 154175],
                            color: '#3ca4f0'
                        },
                        {
                            name: 'Actual',
                            data: [14916, 14064, 29742, 39851, 34490, 30282, 38121, 40434],
                            color: 'red'
                        }],

                        responsive: {
                            rules: [{
                                condition: {
                                    maxWidth: 500
                                },
                                chartOptions: {
                                    legend: {
                                        layout: 'horizontal',
                                        align: 'center',
                                        verticalAlign: 'bottom'
                                    }
                                }
                            }]
                        }

                    });
                }
            });

            return false;
        }
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

        function showhideCustomeDetails(element, param, divid) {
            debugger;
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
        var menu = "#menu0";


        function showPanelFilter(element, panelid, rightvalue, topvalue, ulid) {

            $('#' + ulid).empty();
            if ($(menu).find(".columnSelector").length > 0) {
                $("#divgraphFilter").css('display', 'none');
                $("#divgraph6Filter").css('display', 'none');
                $("#divColumnFilter").css('display', 'block');
                document.getElementById(panelid).style.visibility = "visible";
                $("#" + panelid).css({ 'right': rightvalue, 'top': topvalue });
                return;
            }

            if ($(menu).find("#graphthree").length > 0) {
                $("#divgraphFilter").css('display', 'block');
                $("#divgraph6Filter").css('display', 'none');
                $("#divColumnFilter").css('display', 'none');

                document.getElementById(panelid).style.visibility = "visible";
                $("#" + panelid).css({ 'right': rightvalue, 'top': topvalue });
                return;
            }
            if ($(menu).find("#graphsix").length > 0) {
                $("#divgraphFilter").css('display', 'none');
                $("#divColumnFilter").css('display', 'none');
                $("#divgraph6Filter").css('display', 'block');
                document.getElementById(panelid).style.visibility = "visible";
                $("#" + panelid).css({ 'right': rightvalue, 'top': topvalue });
                return;
            }
            let tblthlen = $(menu).find('table th');

            if (tblthlen.length > 0) {
                let appendString = "";
                for (let i = 0; i < $(tblthlen).length; i++) {
                    appendString += "<li><input type='checkbox'/> " + $(tblthlen)[i].innerText + "</li>";
                }
                appendString += "<li><input type='button' id='columnFilterOK' value='OK' class='Btns' onclick='columnFilter()'/>";
                $('#' + ulid).append(appendString);
                $("#divgraphFilter").css('display', 'none');
                $("#divgraph6Filter").css('display', 'none');
                $("#divColumnFilter").css('display', 'none');
                document.getElementById(panelid).style.visibility = "visible";
                $("#" + panelid).css({ 'right': rightvalue, 'top': topvalue });
            }

        }

        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
            $(document).ready(function () {
                //alert(menu);
                //$("#menu0").addClass("in active");
                $(menu).addClass("in active");
                $("#activeMenu").val(menu);
                $("a[href$='" + menu + "']").removeClass("selected-menu-style").addClass("menu0-select");
                $("a[href$='" + menu + "']").closest('li').find('i').addClass("arrow up");
                bindMultiSelectGraph();
                bindMultiSelectGraph6();
            });
            // var menu = "#menu0";
            //$(".menuData").click(function () {

            //    $(".menuData").css("background-color", "");
            //    $(".menuData").css("color", "#000000ab");
            //    $(this).css("border-bottom", "4px solid #00669f");
            //    $(this).css("color", "#000000ab");
            //    menu = $(this).attr('href');
            //    $("#activeMenu").val(menu);
            //    $(menu).addClass("in active");
            //    //   $("#menu0").removeClass("in active");


            //});

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

            function showhideCustomeDetails(element, param, divid) {
                debugger;
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

            function showPanelFilter(element, panelid, rightvalue, topvalue, ulid) {
                debugger;
                $('#' + ulid).empty();
                if ($(menu).find("#graphthree").length > 0) {
                    $("#divgraphFilter").css('display', 'block');
                    $("#divgraph6Filter").css('display', 'none');
                    document.getElementById(panelid).style.visibility = "visible";
                    $("#" + panelid).css({ 'right': rightvalue, 'top': topvalue });
                    return;
                }
                if ($(menu).find("#graphsix").length > 0) {
                    $("#divgraphFilter").css('display', 'none');
                    $("#divgraph6Filter").css('display', 'block');
                    document.getElementById(panelid).style.visibility = "visible";
                    $("#" + panelid).css({ 'right': rightvalue, 'top': topvalue });
                    return;
                }
                let tblthlen = $(menu).find('table th');

                if (tblthlen.length > 0) {
                    let appendString = "";
                    for (let i = 0; i < $(tblthlen).length; i++) {
                        appendString += "<li>" + $(tblthlen)[i].innerText + "</li>";
                    }
                    $('#' + ulid).append(appendString);
                    $("#divgraphFilter").css('display', 'none');
                    $("#divgraph6Filter").css('display', 'none');
                    document.getElementById(panelid).style.visibility = "visible";
                    $("#" + panelid).css({ 'right': rightvalue, 'top': topvalue });
                }

            }
        });

    </script>
</asp:Content>
