<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProcessParameters.aspx.cs" Inherits="NewProject.ProcessParameters" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

  
    <script src="https://code.highcharts.com/stock/highstock.js"></script>
    <script src="https://code.highcharts.com/stock/modules/data.js"></script>
    <script src="https://code.highcharts.com/stock/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/stock/modules/export-data.js"></script>

    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/highcharts-3d.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/modules/export-data.js"></script>
    <script src="https://code.highcharts.com/modules/accessibility.js"></script>

<%--    <link href="Scripts/Highcharts/highcharts.css" rel="stylesheet" />--%>

     <link href="http://cdn.syncfusion.com/18.2.0.44/js/web/flat-azure/ej.web.all.min.css" rel="stylesheet" />
    <script src="http://cdn.syncfusion.com/js/assets/external/jquery-1.10.2.min.js"></script>
    <script src="http://cdn.syncfusion.com/18.2.0.44/js/web/ej.web.all.min.js"></script>


    <link rel="stylesheet" type="text/css" href="https://cdn3.devexpress.com/jslib/20.1.7/css/dx.common.css" />
    <link rel="stylesheet" type="text/css" href="https://cdn3.devexpress.com/jslib/20.1.7/css/dx.light.css" />
    <script src="https://cdn3.devexpress.com/jslib/20.1.7/js/dx.all.js"></script>

    <style>
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
        .light-mode .graph-div{
              box-shadow: 2px 2px 5px 2px #dededeed !important;
        }

        .graph-div-6-add {
            width: 48%;
            display: inline-block;
        }

        .graph-div-6-remove {
            width: 100%;
            display: block;
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
        .main-div{
            box-shadow: 0px 0px 10px #2b2828ed;
        }
        .main-div table tr th{
            background-color: #6c7884;
        }
        .main-div-table-shadow table{
                    box-shadow: 0px 0px 10px #2b2828ed;
        }
        .main-div-table-shadow table tr th{
             background-color: #6c7884;
        }
        .light-mode .main-div{
            box-shadow: 2px 2px 5px 2px #c3bfbfed !important;
        }
        .light-mode .main-div table tr th{
            background-color: #d4d4d491 !important;
        }
        .light-mode .main-div-table-shadow table{
                    box-shadow: 0px 0px 10px #c3bfbfed !important;
        }
            .light-mode .main-div-table-shadow table tr th {
                 background-color: #d4d4d491 !important;
            }

              .highchart-title{
            color: white;
        }
        .light-mode .highchart-title {
            color: #1a1a1af7 !important;
        }
    </style>
    <div class="container-fluid">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <div class="row" style="color: white;">
                    <div class="col-sm-12 col-lg-12 col-md-12 content-sub-menu">
                        <asp:HiddenField runat="server" ID="activeMenu" ClientIDMode="Static" />
                        <asp:HiddenField runat="server" ID="hdnNoOfColumns" ClientIDMode="Static" />
                        <div style="float: left; margin-top: 5px">
                            <div class="navbar-collapse collapse">
                                <ul class="nav navbar-nav nextPrevious">
                                    <li runat="server" id="liSLI" class="active"><a runat="server" id="SLI" class="menuData" data-toggle="tab" href="#menu0">Dashboard</a>
                                        <i></i>
                                    </li>
                                    <li runat="server" id="li1"><a runat="server" id="a1" class="menuData" data-toggle="tab" href="#menu1">Graph View</a>
                                        <i></i>
                                    </li>
                                    <li><a runat="server" class="menuData" id="a2" data-toggle="tab" href="#menu2">Signature Comparison</a>
                                        <i></i>
                                    </li>
                                    <li runat="server" id="liAnnexureA"><a runat="server" id="annexureA" class="menuData" data-toggle="tab" href="#menu3">List of Values</a>
                                        <i></i>
                                    </li>
                                <%--    <li><a runat="server" class="menuData" id="annexureB" data-toggle="tab" href="#menu4">Graphical View</a>
                                        <i></i>
                                    </li>--%>
                                </ul>
                            </div>
                        </div>

                        <div style="float: right">
                            <table class="submenu-right-side" style="height: 60px">
                                <tr>
                                    <td onmouseover="showPanelsTopRight(this,'panelExport','5px','54px');" onmouseout="hidePanels(this,'panelExport')">
                                        <i class="glyphicon glyphicon-save" style="font-size: 17px;"></i>
                                        <div class="panel panel-default panel-subitems" id="panelExport" onmouseover="showPanelsTopRight(this,'panelExport','5px','54px');" onmouseout="hidePanels(this,'panelExport')" style="width: 200px;">
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
                                                    <li onclick="showViews(this,'ListView')">
                                                        <span>Text View</span>
                                                    </li>
                                                    <li onclick="showViews(this,'CardView')">
                                                        <span>Meter View</span>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </td>
                                    <%--  <td onmouseover="showPanelFilter(this,'panelFilter','5px','54px', 'ulFilter');"  onmouseout="hidePanels(this,'panelFilter')">
                                <i class="glyphicon glyphicon-filter"  style="font-size: 17px;"></i>
                                <div class="panel panel-default panel-subitems" id="panelFilter" onmouseover="showPanelFilter(this,'panelFilter','5px','54px', 'ulFilter');" onmouseout="hidePanels(this,'panelFilter')" style="width: 200px;">
                                    <div class="panel-body">
                                        <ul class="outer-ul" id="ulFilter">
                                           
                                        </ul>
                                    </div>
                                </div>
                            </td>--%>
                                    <td onmouseover="showPanelFilter(this,'panelFilter','5px','54px', 'ulFilter');" onmouseout="hidePanels(this,'panelFilter')">
                                        <i class="glyphicon glyphicon-filter" style="font-size: 17px;"></i>

                                        <div class="panel panel-default panel-subitems" id="panelFilter" onmouseover="showPanelFilter(this,'panelFilter','5px','54px', 'ulFilter');" onmouseout="hidePanels(this,'panelFilter')" style="width: 250px;">
                                            <div class="panel-body">
                                                <ul class="outer-ul" id="ulFilter">
                                                </ul>
                                                <div id="divColumnFilter">
                                                    <asp:CheckBoxList runat="server" ID="cblColumnSelector" CssClass="checkbox-list" ClientIDMode="Static"></asp:CheckBoxList>
                                                    <asp:Button runat="server" ID="btnColumnSelectorOK" Text="ok" ClientIDMode="Static"  Style="margin-left: 20px" CssClass="Btns" OnClientClick="return selectColumn()" />
                                                </div>
                                                <div id="divgraphFilter">
                                                    <asp:CheckBoxList runat="server" ID="cbgraphFilter" ClientIDMode="Static" CssClass="checkbox-list">
                                                        <asp:ListItem Value="Graph1" Text="Graph 1"></asp:ListItem>
                                                        <asp:ListItem Value="Graph2" Text="Graph 2"></asp:ListItem>
                                                        <asp:ListItem Value="Graph3" Text="Graph 3"></asp:ListItem>
                                                    </asp:CheckBoxList>
                                                    <asp:Button runat="server" ID="btnGraphThreeOK" ClientIDMode="Static" OnClientClick="return bindMultiSelectGraph();" CssClass="Btns" Style="margin-left: 20px" Text="OK" />
                                                </div>

                                                <div id="divgraph6Filter">
                                                    <asp:CheckBoxList runat="server" ID="cbgraph6Filter" CssClass="checkbox-list" ClientIDMode="Static">
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
                                                <div id="divDashboardFilter">
                                                          <ul class="outer-ul" id="ulFilterForGraph">
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
                                                                    <asp:Button runat="server" ID="btnNoOfColumnsOk" Text="OK" Style="padding: 1px 8px; color: black; border: 1px solid black; background-color: white; border-radius: 3px" UseSubmitBehavior="false" OnClientClick="if(!noOfcolumnValidation()){return false};" OnClick="btnNoOfColumnsOk_Click" /></td>
                                                            </tr>
                                                        </table>

                                                    </li>
                                                </ul>
                                            </li>
                                             <li  class="main-filter">
                                                <span class="menu-text">Enable Grouping</span>
                                                 <asp:CheckBox runat="server" ID="chkEnableGroup" ClientIDMode="Static" AutoPostBack="true" OnCheckedChanged="chkEnableGroup_CheckedChanged" style="margin-left: 20px;width:16px;height:16px"/>

                                            </li>
                                        </ul>
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
                            <div id="processParamTextViewContainer" style="overflow: auto; white-space: nowrap; height: 80vh" class="listView processParamContainer">
                                <asp:ListView runat="server" ID="lvProcessParamTextView">
                                    <LayoutTemplate>
                                        <div>
                                            <div runat="server" id="itemplaceholder"></div>
                                        </div>
                                    </LayoutTemplate>
                                    <ItemTemplate>
                                        <div class="main-div" style="display: inline-block; background-color: <%# Eval("BackColor") %>; width: 300px; border-radius: 10px; margin: 5px 10px; height: 155px; ">
                                            <table class="template1" style="width: 100%; text-align: center; display: <%# Eval("Template1Visibility") %>;">
                                                <tr>
                                                    <th colspan="4" style=" border-top-left-radius: 10px; border-top-right-radius: 10px; text-align: center"><%# Eval("HeaderName") %></th>
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
                                                    <th colspan="4" style="border-top-left-radius: 10px; border-top-right-radius: 10px; text-align: center"><%# Eval("HeaderName") %></th>
                                                </tr>
                                                <tr style="height: 110px">
                                                    <td colspan="4">
                                                        <label style="background: white; padding: 1px 40px; color: black; font-size: 20px;"><%# Eval("Value") %></label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div style="display: <%# Eval("NextLineVisibility") %>">
                                            <br />
                                        </div>
                                    </ItemTemplate>
                                </asp:ListView>

                            </div>
                            <div id="processParamChartViewContainer" class="cardView processParamContainer">
                                <asp:ListView runat="server" ID="lvChartData">
                                    <LayoutTemplate>
                                        <div id="divChartData">
                                            <div runat="server" id="itemplaceholder"></div>
                                        </div>
                                    </LayoutTemplate>
                                    <ItemTemplate>
                                        <div class="main-div-table-shadow" style="display: inline-block; width: 320px; border-radius: 10px; margin: 20px;">
                                            <table class="template1" style="width: 100%; text-align: center;">
                                                <tr>
                                                    <th colspan="4" style="border-top-left-radius: 10px; border-top-right-radius: 10px; text-align: center"><%# Eval("HeaderName") %></th>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <input type="hidden" id="hdnMinValue" value='<%# Eval("LowValue") %>' />
                                                        <input type="hidden" id="hdnMaxValue" value='<%# Eval("HighValue") %>' />
                                                        <input type="hidden" id="hdnActualValue" value='<%# Eval("Value") %>' />
                                                        <input type="hidden" id="hdnChartType" value='<%# Eval("ChartType") %>' />
                                                        <div style="display:table;width:100%">
<div style="display:table-cell;font-size:18px;color:#15f3f3">Min: <label style="font-size:18px;"><%# Eval("LowValue") %></label></div>
<div style="display:table-cell;font-size:18px;color:#15f3f3">Max: <label style="font-size:18px;"><%# Eval("HighValue") %></label></div>
</div>
                                                        <div id='<%# Eval("chartContainerID") %>' class="chartDiv" style="text-align: center">
                                                        </div>
                                                        <div>
<label style="font-size:18px;color:#15f3f3"><%# Eval("ChartType") %></label>
</div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </ItemTemplate>
                                </asp:ListView>
                            </div>

                        </div>
                        <div id="menu1" class="tab-pane fade">
                            <div class="graph-section" id="graphthree" style="width: 100%; margin: auto">
                                <div id="msGraph1" style="margin-bottom: 20px;" class="box-shadow"></div>
                                <div id="msGraph2" style="margin-bottom: 20px;" class="box-shadow"></div>
                                <div id="msGraph3" style="margin-bottom: 20px;" class="box-shadow"></div>
                            </div>
                            <%--          <div class="listView">
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
            let gh3 = $("[id*=cbgraphFilter] input")[0];
            $(gh3).prop('checked', true);
            let gh6 = $("[id*=cbgraph6Filter] input")[0];
            $(gh6).prop('checked', true);
            bindMultiSelectGraph();
            bindMultiSelectGraph6();
            showViews("","ListView");
        });


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
                            zoomType: 'x'
                        },
                        credits: {
                            enabled: false
                        },
                        title: {
                            text: 'Graph 1',
                            className: 'highchart-title'
                            //style: {
                            //    color: 'white',
                            //    fontSize: '20px'
                            //}
                        },

                        //subtitle: {
                        //    text: 'Source: thesolarfoundation.com'
                        //},

                        yAxis: {
                            title: {
                                //text: 'Number of Employees'
                            },
                           className: 'highchart-xyaxis-label'
                        },

                        xAxis: {
                            accessibility: {
                                // rangeDescription: 'Range: 2010 to 2017'
                            },
                             className: 'highchart-xyaxis-label'
                        },

                        legend: {
                             
                            layout: 'vertical',
                            align: 'right',
                            verticalAlign: 'middle',
                       useHTML: true,
                            labelFormatter: function () {
                                //return `<span class="span-legend-active" style="border-color:${this.color}">${this.name}</span>`;
                                 return `<span class="span-legend-active">${this.name}</span>`;
                            }
                            //itemStyle: {
                            //    color: 'white',
                            //    // fontWeight: 'bold'
                            //}
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
                        url: '<%= ResolveUrl("ProcessParameters.aspx/getChartData") %>',
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
                            className: 'highchart-xyaxis-label'
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
                            className: 'highchart-xyaxis-label'
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
                        url: '<%= ResolveUrl("ProcessParameters.aspx/getChartData") %>',
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
                           className: 'highchart-xyaxis-label',
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
                           className: 'highchart-xyaxis-label'
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
                url: '<%= ResolveUrl("ProcessParameters.aspx/getzoomChartData") %>',
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
                   className: 'highchart-xyaxis-label',
                    plotLines: dataitem.plotLines
                },

                yAxis: {
                    title: {
                        // text: 'Exchange rate'
                    },
                   className: 'highchart-xyaxis-label'
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
            let graphdiv = $('#menu2 .graph-div > div');
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
                           className: 'highchart-xyaxis-label'
                        },

                        xAxis: {
                            accessibility: {
                                // rangeDescription: 'Range: 2010 to 2017'
                            },
                           className: 'highchart-xyaxis-label'
                        },

                        legend: {
                           
                            layout: 'vertical',
                            align: 'right',
                            verticalAlign: 'middle',
                             useHTML: true,
                            labelFormatter: function () {
                                //return `<span class="span-legend-active" style="border-color:${this.color}">${this.name}</span>`;
                                 return `<span class="span-legend-active">${this.name}</span>`;
                            }
                            //itemStyle: {
                            //    color: 'white',
                            //    // fontWeight: 'bold'
                            //}
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
                            color: '#0836ff'
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
                           className: 'highchart-xyaxis-label'
                        },

                        xAxis: {
                            accessibility: {
                                // rangeDescription: 'Range: 2010 to 2017'
                            },
                          className: 'highchart-xyaxis-label'
                        },

                        legend: {
                            layout: 'vertical',
                            align: 'right',
                            verticalAlign: 'middle',
                           useHTML: true,
                            labelFormatter: function () {
                                //return `<span class="span-legend-active" style="border-color:${this.color}">${this.name}</span>`;
                                return `<span class="span-legend-active">${this.name}</span>`;
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
                            color: '#0836ff'
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
                           className: 'highchart-xyaxis-label'
                        },

                        xAxis: {
                            accessibility: {
                                // rangeDescription: 'Range: 2010 to 2017'
                            },
                          className: 'highchart-xyaxis-label'
                        },

                        legend: {
                            layout: 'vertical',
                            align: 'right',
                            verticalAlign: 'middle',
                           useHTML: true,
                            labelFormatter: function () {
                                //return `<span class="span-legend-active" style="border-color:${this.color}">${this.name}</span>`;
                                 return `<span class="span-legend-active">${this.name}</span>`;
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
                            color: '#0836ff'
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
                            className: 'highchart-xyaxis-label'
                        },

                        xAxis: {
                            accessibility: {
                                // rangeDescription: 'Range: 2010 to 2017'
                            },
                           className: 'highchart-xyaxis-label'
                        },

                        legend: {
                            layout: 'vertical',
                            align: 'right',
                            verticalAlign: 'middle',
                            useHTML: true,
                            labelFormatter: function () {
                                //return `<span class="span-legend-active" style="border-color:${this.color}">${this.name}</span>`;
                                 return `<span class="span-legend-active">${this.name}</span>`;
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
                            color: '#0836ff'
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
                           className: 'highchart-xyaxis-label'
                        },

                        xAxis: {
                            accessibility: {
                                // rangeDescription: 'Range: 2010 to 2017'
                            },
                            className: 'highchart-xyaxis-label'
                        },

                        legend: {
                            layout: 'vertical',
                            align: 'right',
                            verticalAlign: 'middle',
                            useHTML: true,
                            labelFormatter: function () {
                                //return `<span class="span-legend-active" style="border-color:${this.color}">${this.name}</span>`;
                                 return `<span class="span-legend-active">${this.name}</span>`;
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
                            color: '#0836ff'
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
                           className: 'highchart-xyaxis-label'
                        },

                        xAxis: {
                            accessibility: {
                                // rangeDescription: 'Range: 2010 to 2017'
                            },
                           className: 'highchart-xyaxis-label'
                        },

                        legend: {
                            layout: 'vertical',
                            align: 'right',
                            verticalAlign: 'middle',
                            useHTML: true,
                            labelFormatter: function () {
                                //return `<span class="span-legend-active" style="border-color:${this.color}">${this.name}</span>`;
                                 return `<span class="span-legend-active">${this.name}</span>`;
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
                            color: '#0836ff'
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
                            className: 'highchart-xyaxis-label'
                        },

                        xAxis: {
                            accessibility: {
                                // rangeDescription: 'Range: 2010 to 2017'
                            },
                           className: 'highchart-xyaxis-label'
                        },

                        legend: {
                            layout: 'vertical',
                            align: 'right',
                            verticalAlign: 'middle',
                           useHTML: true,
                            labelFormatter: function () {
                                //return `<span class="span-legend-active" style="border-color:${this.color}">${this.name}</span>`;
                                 return `<span class="span-legend-active">${this.name}</span>`;
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
                            color: '#0836ff'
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
                          className: 'highchart-xyaxis-label'
                        },

                        xAxis: {
                            accessibility: {
                                // rangeDescription: 'Range: 2010 to 2017'
                            },
                           className: 'highchart-xyaxis-label'
                        },

                        legend: {
                            layout: 'vertical',
                            align: 'right',
                            verticalAlign: 'middle',
                            useHTML: true,
                            labelFormatter: function () {
                                //return `<span class="span-legend-active" style="border-color:${this.color}">${this.name}</span>`;
                                 return `<span class="span-legend-active">${this.name}</span>`;
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
                            color: '#0836ff'
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
                           className: 'highchart-xyaxis-label'
                        },

                        xAxis: {
                            accessibility: {
                                // rangeDescription: 'Range: 2010 to 2017'
                            },
                           className: 'highchart-xyaxis-label'
                        },

                        legend: {
                            layout: 'vertical',
                            align: 'right',
                            verticalAlign: 'middle',
                            useHTML: true,
                            labelFormatter: function () {
                                //return `<span class="span-legend-active" style="border-color:${this.color}">${this.name}</span>`;
                                 return `<span class="span-legend-active">${this.name}</span>`;
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
                            color: '#0836ff'
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
                           className: 'highchart-xyaxis-label'
                        },

                        xAxis: {
                            accessibility: {
                                // rangeDescription: 'Range: 2010 to 2017'
                            },
                           className: 'highchart-xyaxis-label'
                        },

                        legend: {
                            layout: 'vertical',
                            align: 'right',
                            verticalAlign: 'middle',
                            useHTML: true,
                            labelFormatter: function () {
                                //return `<span class="span-legend-active" style="border-color:${this.color}">${this.name}</span>`;
                                 return `<span class="span-legend-active">${this.name}</span>`;
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
                            color: '#0836ff'
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


        function showViews(element, param) {
            if (param == "CardView") {
                $('.cardView').css('display', 'block');
                $('.listView').css('display', 'none');
            } else {
                $('.listView').css('display', 'block');
                $('.cardView').css('display', 'none');
            }
        }
        var menu = "#menu0";

        function showPanelFilter(element, panelid, rightvalue, topvalue, ulid) {

            $('#' + ulid).empty();
            if ($(menu).find(".columnSelector").length > 0) {
                $("#divgraphFilter").css('display', 'none');
                $("#divgraph6Filter").css('display', 'none');
                $("#divDashboardFilter").css('display', 'none');
                $("#divColumnFilter").css('display', 'block');
                document.getElementById(panelid).style.visibility = "visible";
                $("#" + panelid).css({ 'right': rightvalue, 'top': topvalue });
                return;
            }

            if ($(menu).find("#graphthree").length > 0) {
                $("#divgraphFilter").css('display', 'block');
                $("#divgraph6Filter").css('display', 'none');
                $("#divColumnFilter").css('display', 'none');
                 $("#divDashboardFilter").css('display', 'none');

                document.getElementById(panelid).style.visibility = "visible";
                $("#" + panelid).css({ 'right': rightvalue, 'top': topvalue });
                return;
            }
            if ($(menu).find("#graphsix").length > 0) {
                $("#divgraphFilter").css('display', 'none');
                $("#divColumnFilter").css('display', 'none');
                 $("#divDashboardFilter").css('display', 'none');
                $("#divgraph6Filter").css('display', 'block');
                document.getElementById(panelid).style.visibility = "visible";
                $("#" + panelid).css({ 'right': rightvalue, 'top': topvalue });
                return;
            }

              if ($(menu).find(".processParamContainer").length > 0) {
                $("#divgraphFilter").css('display', 'none');
                $("#divColumnFilter").css('display', 'none');
                 $("#divDashboardFilter").css('display', 'block');
                $("#divgraph6Filter").css('display', 'none');
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
                 $("#divDashboardFilter").css('display', 'none');
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
                showViews("", "ListView");
                BindCharts();
            });
            function showViews(element, param) {
                if (param == "CardView") {
                    $('.cardView').css('display', 'block');
                    $('.listView').css('display', 'none');
                } else {
                    $('.listView').css('display', 'block');
                    $('.cardView').css('display', 'none');
                }
            }
           function showPanelFilter(element, panelid, rightvalue, topvalue, ulid) {

            $('#' + ulid).empty();
            if ($(menu).find(".columnSelector").length > 0) {
                $("#divgraphFilter").css('display', 'none');
                $("#divgraph6Filter").css('display', 'none');
                $("#divDashboardFilter").css('display', 'none');
                $("#divColumnFilter").css('display', 'block');
                document.getElementById(panelid).style.visibility = "visible";
                $("#" + panelid).css({ 'right': rightvalue, 'top': topvalue });
                return;
            }

            if ($(menu).find("#graphthree").length > 0) {
                $("#divgraphFilter").css('display', 'block');
                $("#divgraph6Filter").css('display', 'none');
                $("#divColumnFilter").css('display', 'none');
                 $("#divDashboardFilter").css('display', 'none');

                document.getElementById(panelid).style.visibility = "visible";
                $("#" + panelid).css({ 'right': rightvalue, 'top': topvalue });
                return;
            }
            if ($(menu).find("#graphsix").length > 0) {
                $("#divgraphFilter").css('display', 'none');
                $("#divColumnFilter").css('display', 'none');
                 $("#divDashboardFilter").css('display', 'none');
                $("#divgraph6Filter").css('display', 'block');
                document.getElementById(panelid).style.visibility = "visible";
                $("#" + panelid).css({ 'right': rightvalue, 'top': topvalue });
                return;
            }

              if ($(menu).find(".processParamContainer").length > 0) {
                $("#divgraphFilter").css('display', 'none');
                $("#divColumnFilter").css('display', 'none');
                 $("#divDashboardFilter").css('display', 'block');
                $("#divgraph6Filter").css('display', 'none');
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
                 $("#divDashboardFilter").css('display', 'none');
                document.getElementById(panelid).style.visibility = "visible";
                $("#" + panelid).css({ 'right': rightvalue, 'top': topvalue });
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
                if (chartType == "bar") {
                    bindBarChart(parseFloat(minValue), parseFloat(maxValue), parseFloat(actualValue), containerID);
                }
                else if (chartType == "temperature") {
                    bindTempCharts(parseFloat(minValue), parseFloat(maxValue), parseFloat(actualValue), containerID);
                }
                else if (chartType == "liters") {
                    bindLiterCharts(parseFloat(minValue), parseFloat(maxValue), parseFloat(actualValue), containerID);
                }
                else {
                    bindGuageCharts(parseFloat(minValue), parseFloat(maxValue), parseFloat(actualValue), containerID);
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
                alert("Please enter number of column");
                return false;
            }
            if ($('#txtNoOfColumns').val().trim() == "0") {
                alert("Please enter valid number of column");
                return false;
            }
            $('#hdnNoOfColumns').val($('#txtNoOfColumns').val());
            return true;
        }
        function bindBarChart(minvalue, maxvalue, actualvalue, containerid) {
            // Set up the chart
            var chart = new Highcharts.Chart({
                chart: {
                    renderTo: containerid,
                    type: 'column',
                    backgroundColor: '#32383d',
                    plotBackgroundColor: '#32383d',
                    width: 320,
                    height: 320
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
                    labels: {
                        style: {
                            color: 'white',
                            fontSize: '19px'
                        }
                    }
                },
                xAxis: {
                    labels: {
                        enabled: false
                    },
                    lineColor: '#ede8e8'
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
                    color: 'deeppink'
                }]
            });
        }
        function bindGuageCharts(minvalue, maxvalue, actualvalue, containerid) {
            $("#" + containerid).dxCircularGauge({
                size: {
                    height: 320,
                    width: 320
                },
                scale: {
                      startValue: 0,
                    endValue: 320,
                    //tickInterval: 10,
                    label: {
                        // useRangeColors: true,
                        font: { size: 19, color: 'white' }
                    }
                },
                valueIndicator: {
                    type: "triangleNeedle", //rectangleNeedle
                    color: "blue",
                    size: 30,
                    spindleSize: 25,
                    width: 13
                },
                subvalues: actualvalue,
                //subvalueIndicator: {
                // type: "triangleMarker",
                // color: "red"
                //},
                subvalueIndicator: {
                    type: "textCloud",
                    color: "blue"
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
                    height: 320,
                    width: 320
                },
                geometry: { orientation: "vertical" },
                scale: {
                    //startValue: minvalue,
                    //endValue: maxvalue,
                    //customTicks: [0, 10, 25, 50]
                    label: {
                        font: { color: 'white', size: 19 }
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
            $("#" + containerid).ejLinearGauge({
                height: 320,
                width: 320,
                labelColor: "#8c8c8c",
                enableAnimation: false,
                scales: [{

                    type: "thermometer",
                    backgroundColor: "gray",
                    //minimum: minvalue,
                    //maximum: maxvalue,
                    labelColor: "red",
                    enableAnimation: false,
                    // minorIntervalValue: 5,
                    width: 30,
                    position: { x: 50, y: 18 },
                    length: 290,
                    border: { width: 2, color: '#f70002' },
                    markerPointers: [{ opacity: 0 }],

                    barPointers: [{
                        width: 15,
                        // distanceFromScale: -0.5,
                        value: actualvalue,
                        backgroundColor: "#f70002"
                    }],
                    labels: [{
                        placement: "near",
                        textColor: 'white',
                        font: {
                            size: "19px", fontStyle: 'Normal'
                        },
                        distanceFromScale: { x: -15 }
                    }//,
                        //{
                        // placement: "far",
                        // distanceFromScale: { x: 10 }
                        // }
                    ],

                }],
                // drawLabels: "DrawLabel"
                //drawCustomLabel: "DrawCustomLabel",
                //drawLabels: "DrawLabel"

            });
        }
    </script>
</asp:Content>
