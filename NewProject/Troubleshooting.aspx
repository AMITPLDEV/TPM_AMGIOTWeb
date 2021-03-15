<%@ Page Title="Troubleshooting" Language="C#" AutoEventWireup="true" CodeBehind="Troubleshooting.aspx.cs" Inherits="NewProject.Troubleshooting" EnableEventValidation="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>


    <%-- <script src="Scripts/jquery-3.3.1.min.js"></script>--%>
    <script src="Scripts/jquery-3.3.1.js"></script>
    <script src="Scripts/bootstrap.js"></script>

    <link href="Content/bootstrap.css" rel="stylesheet" />
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/wordcloud.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/modules/export-data.js"></script>
    <script src="https://code.highcharts.com/modules/accessibility.js"></script>
    <link href="Scripts/MultiSelectDropdown/bootstrap-multiselect.css" rel="stylesheet" />
    <script src="Scripts/MultiSelectDropdown/bootstrap-multiselect.js"></script>

    <style>
        #mainBody {
            background-color: #32383d;
            width: 100vw;
            height: 98vh;
            padding: 0px;
        }

        .light-mode {
            background-color: #f1f1f1 !important;
            transition: all 1s ease-in-out;
        }

        * {
            margin: 0px;
            padding: 0px;
            font-family: sans-serif;
            font-size: 14px;
            color: white;
        }

        .light-mode * {
            color: #1a1a1af7;
        }

        .line {
            padding-bottom: 3px;
            border-bottom-style: solid;
            border-bottom-width: 3.1px;
            width: fit-content;
            border-bottom-color: #44fff4;
            font-size: 20px;
            font-weight: bold;
            font-style: italic;
        }

        .HeaderImage {
            flex: 1;
            float: left;
        }
        .form-control {
            border-radius: 10px;
        }
        .multiselect.dropdown-toggle.btn{
            border-radius: 10px;
        }
        .nav-header {
            background-color: #171e21;
            border-color: #171e21;
        }

        .light-mode .nav-header {
            background-color: #49bde9 !important;
            background-image: linear-gradient(to right, #15a5ec, #49bde9, #23c0d9) !important;
            border-color: #0f9fd5 !important;
        }

        .dropdown-list option {
            color: black;
        }

        .light-mode .dropdown-list option {
            color: black !important;
        }

        .P1Table {
            background-color: #212528 !important;
            width: 100%;
            box-shadow: 2px 2px 5px 2px #262626ed;
        }

            .P1Table tr th {
                padding: 8px 10px;
                background-color: #6c7884;
                position: sticky;
                top: -2px;
                z-index: 10;
                /*border-right: 0.5px solid #a3a3a361;*/
            }
            /*.P1Table tr th{
                position: sticky;
                top: 0px;
                background-color: #6c7884;
            }*/

            .P1Table tr td {
                padding: 8px;
                /*border-right: 0.5px solid #f1f1f1;*/
                /*border-bottom: 0.5px solid #a3a3a361;*/
                border: none;
                border-bottom: 0.5px solid #a3a3a361;
                border-right: 0.5px solid #363333 !important;
                text-align: left;
            }

            .P1Table tr:hover td {
                background-color: #a3a3a361;
            }

        .P1Table-footer-style tr:last-child td {
            background-color: #6c7884;
        }

        .light-mode .P1Table {
            background-color: white !important;
            box-shadow: 2px 2px 5px 2px #dededeed !important;
        }

            .light-mode .P1Table tr th {
                background-color: #ebebeb !important;
                border: 0.5px solid gainsboro;
            }
            /*.light-mode .P1Table tr th{
                position: sticky;
                top: 0px;
                background-color: #ebebeb    !important;
                z-index: 2;
            }*/

            .light-mode .P1Table tr td {
                border: 0.5px solid #f1f1f1 !important;
            }

            .light-mode .P1Table tr:hover td {
                background-color: #f1f1f1 !important;
            }

                .light-mode .P1Table tr:hover td.solutionCss {
                    background-color: #479d2b !important;
                }

            .light-mode .P1Table tr td a {
                color: #1a1a1af7 !important;
            }

        .light-mode .P1Table-footer-style tr:last-child td {
            background-color: #ebebeb !important;
        }

        .Btns {
            color: #fff;
            background: -webkit-linear-gradient(top, #aaa 0,#000 40%, #555 100%);
            -webkit-box-shadow: inset 0 -1em 0 0.2em rgba(0,0,0,.55);
            border: 2px solid gray;
            -webkit-border-radius: 1em;
            /* padding: .67em; */
            font-weight: 700;
            padding: 5px 20px;
            font-size: 16px;
        }

        .light-mode .Btns {
            background: -webkit-linear-gradient(top, #4ad5f5 0,#15567f 40%, #23eabc 100%) !important;
            -webkit-box-shadow: inset 0 -1em 0 0.2em rgba(0,0,0,.55) !important;
            border: 2px solid #0a9a9a !important;
        }

        .lblCss {
            /*font-size: 20px;*/
            color: #10e4e4;
        }

        .light-mode .lblCss {
            color: #1e9292 !important;
        }

        #parameterDetailsDiv span {
            /*font-size: 20px;*/
        }



        /*.multiselect-selected-text {
            padding-right: 181px;
        }*/

        /*.multiselect .dropdown-toggle {
            width: 50%;
        }*/

        .multiselect {
            /*width: 200px;
            overflow: hidden;
            display: block;*/
        }

        .multiselect-container label {
            color: black;
        }

        .multiselect span {
            color: black;
        }

        #chartFilterDiv {
            border: 1px solid silver;
            padding: 4px 10px;
            border-radius: 10px;
            width: fit-content;
            background: #5f5a5a;
        }

        .light-mode #chartFilterDiv {
            border: 1px solid #9e9999 !important;
            background: #f1efef !important;
        }

        #lbWordSearchClear {
            color: white;
        }

        .light-mode #lbWordSearchClear {
            color: black !important;
        }

        fieldset {
            border: 1px solid #7b7b88;
            padding: 0px;
            border-radius: 4px;
            width: auto;
            box-shadow: 2px 2px 8px 2px #252424;
            margin: 0 8px 0 8px;
            padding: 0 10px 5px 10px;
            margin: 0px;
        }

        legend {
            text-align: right;
            color: white;
            display: block;
            width: auto;
            padding: 0;
            margin-bottom: 5px;
            font-size: 21px;
            line-height: inherit;
            border-bottom: transparent;
            margin: 0px;
        }

        .light-mode fieldset {
            border: 1px solid #4f4e63 !important;
            box-shadow: 2px 2px 8px 2px #efe7e7 !important;
        }

        .light-mode legend {
            color: #4f4e63 !important;
        }

        .highcharts-background {
            fill: #171e21;
        }



        .highchart-xyaxis-label text {
            fill: white;
            stroke: white;
            /*font-family: 'Glyphicons Halflings';*/
            /*font-family: emoji;*/
            font-family: initial;
        }

        .highcharts-title text {
            font-size: 20px;
            fill: red;
        }

        .highcharts-legend text {
            fill: red;
        }

        .highcharts-legend-item > span > span {
            color: red;
        }

        .highcharts-legend-item-hidden > span > span {
            color: red;
        }

        .light-mode .highcharts-background {
            fill: white !important;
        }

        .light-mode .highchart-xyaxis-label text {
            fill: #1a1a1af7 !important;
            stroke: #1a1a1af7 !important;
        }

        #gvServiceDetails tr td a {
            font-size: 20px;
        }

        #tdOperatorMode input[type="checkbox"] {
            /*width: 20px;
            height: 20px;*/
        }

        #tdOperatorMode label {
            /*font-size: 15px;
            vertical-align: bottom;
            margin-left: 2px;*/
        }

        #gridContainer .paginationCss td {
            position: sticky;
            bottom: 0px;
            background: #64696f;
            padding: 1px 10px !important;
        }

        .light-mode #gridContainer .paginationCss td {
            background: #ebebeb !important;
        }

        #gridContainer .paginationCss td a {
            font-size: 23px;
            color: white;
        }

        #gridContainer .paginationCss td span {
            font-size: 20px;
            color: #0fdcf1;
        }

        .light-mode .solutionCss {
            color: white !important;
        }

            .light-mode .solutionCss:hover {
                background-color: #479d2b !important;
            }
              .panel-subitems {
            visibility: hidden;
            z-index: 10;
            position: absolute;
            box-shadow: 2px 2px 5px 2px #1e1e1eed;
            border-color: #6d6d6d;
            background-color: #171e21;
        }

        .panel-default > .panel-heading {
            background-color: #6c7884;
            color: unset;
        }

        .panel-footer {
            background-color: unset;
        }

        .light-mode .panel-subitems {
            box-shadow: 2px 2px 5px 2px #dededeed !important;
            border-color: #ddd !important;
            background-color: #fff !important;
        }

        .light-mode .panel-default > .panel-heading {
            background-color: #fff !important;
        }
        .checkbox-list input {
            margin-right: 5px;
        }
        .checkbox-list label {
            font-weight: unset;
        }
        #divColumnFilter table tr td{
            text-align:left;
        }
        #rbOperatorMode{
            margin-left:4px;
        }
         #rbOperatorMode tr td label{
             font-weight:100;
         }
        #rbOperatorMode tr td{
            padding-left:10px;
        }
        .highcharts-contextmenu {
            background-color:#32383d;
        }
            .highcharts-menu {
                box-shadow: none;
                border: 1px solid #a3a3a361;
                color: white;
                background-color: #32383d;
            }
        .light-mode .highcharts-contextmenu {
            background-color:white !important;
        }
        .light-mode .highcharts-contextmenu  ul{
            box-shadow:none !important;
            border:1px solid rgb(68 66 66);
            color:black;
             background-color: white;
        }
    </style>
</head>
<body id="mainBody" runat="server">
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server"></asp:ScriptManager>
        <div class="navbar navbar-default navbar-fixed-top nav-header" style="margin-bottom: 0px; padding: 0px 5px; flex-basis: 70px; min-height: 40px; height: 40px; text-align: center">
            <%--position: static;--%>
            <div class="HeaderImage" style="padding: 3px 3px 3px 3px;">
                <span style="color: red;" class="line">Ace</span><span style="color: #44fff4;" class="line">Micromatic</span>
                <%--  <div style="display: inline; margin-left: 19px; border: 1px solid white; padding: 6px; border-radius: 5px;">
                    <div onclick="showMenuPanels(this,'panelMenus','150px','40px')" style="display: inline">
                        <span id="menuddl" style="color: white; font-weight: bold">Menus</span>
                        <span id="menudownuparrow" style="margin-left: 85px; color: white" class="glyphicon glyphicon-menu-down"></span>
                    </div>


                </div>--%>
            </div>
            <div style="display: inline-block; margin-top: 8px; margin-left: -8%">
                <asp:Label runat="server" ID="lblShowSelectedItems" Style="color: white !important; font-weight: bold; font-size: 18px">Troubleshooting</asp:Label>
            </div>
            <div style="float: right; position: relative;top:10px;right:5px;">
                <table>
                    <tr>
                        <td onmouseover="showPanelsTopRight(this,'panelFilter','5px','28px');" onmouseout="hidePanels(this,'panelFilter')" style="padding:5px;">
                            <i class="glyphicon glyphicon-filter" style="font-size: 17px;"></i>
                            <div class="panel panel-default panel-subitems" id="panelFilter" onmouseover="showPanelsTopRight(this,'panelFilter','0px','28px');" onmouseout="hidePanels(this,'panelFilter')" style="width: 250px;">
                                <div class="panel-body">
                                    <div id="divColumnFilter">
                                        <asp:UpdatePanel runat="server">
                                            <ContentTemplate>
                                                <asp:CheckBoxList runat="server" ID="cblColumnSelector" CssClass="checkbox-list" ClientIDMode="Static"></asp:CheckBoxList>
                                                <asp:Button runat="server" ID="btnColumnSelectorOK" Text="OK" ClientIDMode="Static" Style="margin-left: 20px" CssClass="Btns"   OnClick="btnColumnSelectorOK_Click"/>
                                              <%--  OnClientClick="return setColumnName();"--%>
                                                </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>

        </div>
        <div style="width: 99%; margin: auto">
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <asp:HiddenField runat="server" ID="hdnScrollPos" ClientIDMode="Static" />
                    <asp:HiddenField runat="server" ID="hdnWordSearch" ClientIDMode="Static" />
                    <asp:HiddenField runat="server" ID="hdnWordSearchWeight" ClientIDMode="Static" />
                    <asp:HiddenField runat="server" ID="hdnWordSearchColor" ClientIDMode="Static" />
                    <div style="display: inline-block; margin-top: 50px" id="divFilter">
                        <table style="display: inline-block; "><%--vertical-align: super--%>
                            <tr>
                                <td>MTB&nbsp;</td>
                                <td>
                                    <asp:DropDownList runat="server" ID="ddlMTB" ClientIDMode="Static" AutoPostBack="true" OnSelectedIndexChanged="ddlMTB_SelectedIndexChanged" CssClass="form-control dropdown-list">
                                    </asp:DropDownList></td>
                                <td>&nbsp;&nbsp;&nbsp;Model&nbsp;</td>
                                <td>
                                    <asp:ListBox ID="lbModel" runat="server" SelectionMode="Multiple" CssClass="form-control dropdown-list" ClientIDMode="Static" Style="width: 150px;min-width:100px;"></asp:ListBox>
                                </td>
                            </tr>
                        </table>
                       <%-- <div id="parameterDetailsDiv" runat="server" style="display: inline-block;margin-left:7px;">
                            <fieldset>
                                <legend>
                                    <asp:LinkButton runat="server" ID="lnkParamDataClear" ClientIDMode="Static" OnClick="lnkParamDataClear_Click" CssClass="glyphicon glyphicon-remove" Style="font-size: 20px; color: red"></asp:LinkButton>
                                </legend>
                                <table style="position:relative;top:-4px">
                                    <tr>
                                        <td class="lblCss">&nbsp;&nbsp;Machine:&nbsp;</td>
                                        <td>
                                            <asp:Label runat="server" ID="lblMachine" ClientIDMode="Static"></asp:Label></td>
                                        <td class="lblCss">&nbsp;&nbsp;Parameter ID:&nbsp;</td>
                                        <td>
                                            <asp:Label runat="server" ID="lblParameterID" ClientIDMode="Static"></asp:Label></td>
                                        <td class="lblCss">&nbsp;&nbsp;Problem:&nbsp;</td>
                                        <td>
                                            <asp:Label runat="server" ID="lblProblem" ClientIDMode="Static"></asp:Label></td>
                                    </tr>
                                </table>

                            </fieldset>
                        </div>--%>
                        <div style="display:inline-block;margin-left:10px">
                                <table style="width: 100%">
                            <tr>
                                <td style="width: 60%">
                                    <asp:TextBox runat="server" ID="txtSearch" Style="max-width: unset; width: 100%;" CssClass="form-control"></asp:TextBox></td>
                                <td style="width: 102px" id="tdOperatorMode">
                                   
                                    <asp:RadioButtonList runat="server" ID="rbOperatorMode"  RepeatDirection="Horizontal" Font-Bold="false">
                                        <asp:ListItem Value="Or">OR</asp:ListItem>
                                         <asp:ListItem Value="And">AND</asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                                <td style="width: 100px">&nbsp;
                            <asp:Button runat="server" ID="btnView" OnClick="btnView_Click" Text="View" CssClass="Btns" OnClientClick="return showLoader();" />
                                    <asp:Button runat="server" ID="btnWordFiterView" OnClick="btnWordFiterView_Click" Text="View" CssClass="Btns" Visible="false" />
                                </td>
                                <td>
                                    <div id="chartFilterDiv" runat="server">

                                        <asp:Label runat="server" ID="lblWordSearch" ClientIDMode="Static" ></asp:Label>
                                        <asp:LinkButton runat="server" ID="lbWordSearchClear" CssClass="glyphicon glyphicon-remove" OnClick="lbWordSearchClear_Click" Style="font-size: 18px; vertical-align: sub" OnClientClick="return showLoader();"></asp:LinkButton>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        </div>

                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnWordFiterView" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnView" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <div>
                         <div id="parameterDetailsDiv" runat="server" style="display: inline-block;margin-left:7px;">
                            <fieldset>
                                <legend>
                                    <asp:LinkButton runat="server" ID="lnkParamDataClear" ClientIDMode="Static" OnClick="lnkParamDataClear_Click" CssClass="glyphicon glyphicon-remove" Style="font-size: 20px; color: red"></asp:LinkButton>
                                </legend>
                                <table style="position:relative;top:-4px">
                                    <tr>
                                        <td class="lblCss">&nbsp;&nbsp;Machine:&nbsp;</td>
                                        <td>
                                            <asp:Label runat="server" ID="lblMachine" ClientIDMode="Static"></asp:Label></td>
                                        <td class="lblCss">&nbsp;&nbsp;Parameter ID:&nbsp;</td>
                                        <td>
                                            <asp:Label runat="server" ID="lblParameterID" ClientIDMode="Static"></asp:Label></td>
                                        <td class="lblCss">&nbsp;&nbsp;Problem:&nbsp;</td>
                                        <td>
                                            <asp:Label runat="server" ID="lblProblem" ClientIDMode="Static"></asp:Label></td>
                                    </tr>
                                </table>

                            </fieldset>
                        </div>
                    <%--    <table style="width: 100%">
                            <tr>
                                <td style="width: 30%">
                                    <asp:TextBox runat="server" ID="txtSearch" Style="max-width: unset; width: 100%;" CssClass="form-control"></asp:TextBox></td>
                                <td style="width: 102px" id="tdOperatorMode">
                                   
                                    <asp:RadioButtonList runat="server" ID="rbOperatorMode"  RepeatDirection="Horizontal" Font-Bold="false">
                                        <asp:ListItem Value="Or">OR</asp:ListItem>
                                         <asp:ListItem Value="And">AND</asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                                <td style="width: 200px">&nbsp;
                            <asp:Button runat="server" ID="btnView" OnClick="btnView_Click" Text="View" CssClass="Btns" OnClientClick="return showLoader();" />
                                    <asp:Button runat="server" ID="btnWordFiterView" OnClick="btnWordFiterView_Click" Text="View" CssClass="Btns" Visible="false" />
                                </td>
                                <td>
                                    <div id="chartFilterDiv" runat="server">

                                        <asp:Label runat="server" ID="lblWordSearch" ClientIDMode="Static" Style="font-size: 18px;"></asp:Label>
                                        <asp:LinkButton runat="server" ID="lbWordSearchClear" CssClass="glyphicon glyphicon-remove" OnClick="lbWordSearchClear_Click" Style="font-size: 18px; vertical-align: sub" OnClientClick="return showLoader();"></asp:LinkButton>
                                    </div>
                                </td>
                            </tr>
                        </table>--%>
                    </div>

                    <div id="gridContainer" style="overflow: auto;  margin-top: 10px">
                        <asp:GridView runat="server" ID="gvServiceDetails" AutoGenerateColumns="false" CssClass="P1Table" AllowPaging="true" OnPageIndexChanging="gvServiceDetails_PageIndexChanging" PageSize="500" OnPreRender="gvServiceDetails_PreRender" ClientIDMode="Static" EmptyDataText="No Data Found">
                            <Columns>
                                <asp:BoundField HeaderText="Region" DataField="Region" AccessibleHeaderText="0" />
                                <asp:BoundField HeaderText="Customer" DataField="Customer" AccessibleHeaderText="1" />
                                <asp:BoundField HeaderText="Principal" DataField="Principal" AccessibleHeaderText="2" />
                                <asp:BoundField HeaderText="ModelName" DataField="ModelName" AccessibleHeaderText="3" />
                                <asp:BoundField HeaderText="SlNo" DataField="SlNo" AccessibleHeaderText="4" />
                                <asp:BoundField HeaderText="WarrantyStatus" DataField="WarrantyStatus" AccessibleHeaderText="5" />
                                <asp:BoundField HeaderText="TotalMcBDHours" DataField="TotalMcBDHours" AccessibleHeaderText="6" />
                                <asp:BoundField HeaderText="Description" DataField="Description" AccessibleHeaderText="7" />
                                <asp:BoundField HeaderText="MainAssembly" DataField="MainAssembly" AccessibleHeaderText="8" />
                                <asp:BoundField HeaderText="MainArea" DataField="MainArea" AccessibleHeaderText="9" />
                                <asp:BoundField HeaderText="SubArea" DataField="SubArea" AccessibleHeaderText="10" />
                                <asp:BoundField HeaderText="ProbableReasons" DataField="ProbableReasons" AccessibleHeaderText="11" />
                                <asp:BoundField HeaderText="Problem Observed" DataField="ProblemObserved" AccessibleHeaderText="11" />
                                <asp:BoundField HeaderText="Problem Description" DataField="ProblemDesc" AccessibleHeaderText="13" />
                                <asp:BoundField HeaderText="Solution" DataField="Solution" ItemStyle-BackColor="#479d2b" ItemStyle-CssClass="solutionCss" AccessibleHeaderText="14" />
                                <asp:BoundField HeaderText="Solution Description" DataField="SolutionDesc" ItemStyle-BackColor="#479d2b" ItemStyle-CssClass="solutionCss" AccessibleHeaderText="15" />
                            </Columns>
                            <PagerStyle CssClass="paginationCss" />
                        </asp:GridView>
                    </div>

                    <div style="margin-top: 10px">
                        <div id="chartContainer" style=" width: 50%; display: inline-block">
                            <div id="textChartContainer" style="height: 100%; width: 100%;">
                            </div>
                        </div>
                        <div id="eDocContainer" style="width: 49%; display: inline-block; float: right; overflow: auto">
                            <asp:GridView ID="gvMachineLvlData" runat="server" AutoGenerateColumns="false" Width="100%" EmptyDataText="No Data Found." ShowHeaderWhenEmpty="true" ShowHeader="true" ShowFooter="false" ClientIDMode="Static" CssClass="P1Table">
                                <Columns>
                                    <asp:TemplateField HeaderText="Machine Model">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblMachineModel" ClientIDMode="Static" Text='<%# Eval("MachineModel") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Machine Slno">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblMachineSlno" ClientIDMode="Static" Text='<%# Eval("MachineSlno") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Category">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblCategory" ClientIDMode="Static" Text='<%# Eval("Category") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Sub Category">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblSubCategory" ClientIDMode="Static" Text='<%# Eval("Subcategory") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="File Name">
                                        <ItemTemplate>
                                            <asp:HiddenField runat="server" ID="hdnMachineType" ClientIDMode="Static" Value='<%# Eval("MachineType") %>' />
                                            <asp:HiddenField runat="server" ID="hdnMachineModel" ClientIDMode="Static" Value='<%# Eval("MachineModel") %>' />
                                            <asp:HiddenField runat="server" ID="hdnMachineSlno" ClientIDMode="Static" Value='<%# Eval("MachineSlno") %>' />
                                            <asp:HiddenField runat="server" ID="hdnCollectionName" ClientIDMode="Static" Value='<%# Eval("CollectionName") %>' />
                                            <asp:HiddenField runat="server" ID="hdnFileID" ClientIDMode="Static" Value='<%# Eval("FileID") %>' />
                                            <asp:HiddenField runat="server" ID="hdnFileName" ClientIDMode="Static" Value='<%# Eval("Filename") %>' />
                                            <asp:HiddenField runat="server" ID="hdnFileType" ClientIDMode="Static" Value='<%# Eval("FileType") %>' />
                                          <asp:LinkButton runat="server" ID="lnkFilename" OnClientClick="return showFileDetails(this)" Text='<%# Eval("Filename") %>' ToolTip='<%# Eval("Filename") %>'    ></asp:LinkButton>
                                            <%--<asp:Label runat="server" ID="lblFilename" ClientIDMode="Static" Text='<%# Eval("Filename") %>'></asp:Label>--%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnWordFiterView" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnView" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
        <div class="modal infoModal" id="showDocumentModal" role="dialog" style="min-width: 300px;">
            <div class="modal-dialog modal-dialog-centered" style="width: 50%; margin-left: 0px">
                <div class="modal-content" >
                    <div class="modal-header">

                        <h4 class="modal-title">Document</h4>
                    </div>
                    <div class="modal-body">
                        <div style="height: 80vh">
                            <iframe id="iframeDocument" style="width: 100%; height: 100%"></iframe>
                            <video id="machineDocVideo" autoplay='autoplay' controls style="width: 100%; height: 100%; display: none">
                                <source />
                            </video>
                            <img id="machineDocImage" src="" style="width: 100%; height: 100%; display: none" />
                        </div>

                    </div>
                    <div class="modal-footer">

                        <input type="button" value="Close" class="Btns" data-dismiss="modal" onclick="closeLargeDocumentModal()" />
                    </div>
                </div>
            </div>
        </div>
     
        <%: Scripts.Render("~/bundles/masterjs") %>
        <script>
            $(document).ready(function () {
               // setColumnName();
                setGridHeight();
                $.unblockUI({});
            });
            $(window).resize(function () {
                setGridHeight();
            });
            function setGridHeight() {
                 var height = $(window).height() - $('#divFilter').height() -  90;
                if ($('#parameterDetailsDiv').height() != undefined) {
                    height = $(window).height() - $('#divFilter').height() - $('#parameterDetailsDiv').height() - 90;
                }
                var gridH = height / 2;
                $('#gridContainer').css("height", gridH);
                $('#chartContainer').css("height", gridH);
                $('#eDocContainer').css("height", gridH);
            }
            function setColumnName() {
                debugger;
                $.blockUI({ message: '<img runat="server" src="Images/Loading.gif" />' });
                let selectedColumnName = "";
                var checked_checkboxes = $('#cblColumnSelector input:checked');
                checked_checkboxes.each(function () {
                    if (selectedColumnName == "") {
                        selectedColumnName = "|" + $(this).val() + "|";
                    } else {
                        selectedColumnName = selectedColumnName + ',|' + $(this).val() + "|";
                    }
                });

                //List View
                for (let i = 0; i < $('#gvServiceDetails th').length; i++) {
                    let th = $('#gvServiceDetails th')[i];
                    // let td = $('#tblCompanyDashboard td')[i];
                    let name = "|" + $(th).attr("abbr") + "|";
                    if (selectedColumnName.includes(name)) {
                        $(th).css('display', 'table-cell');
                        var trCount = $('#gvServiceDetails > tbody > tr').length;
                        if (trCount >= 502) {
                            trCount = trCount-1;
                        }
                        for (let j = 1; j < trCount; j++) {
                            let trs = $('#gvServiceDetails tr');
                            let tr = $(trs)[j];
                            let innertd = $(tr).children()[i];
                            $(innertd).css('display', 'table-cell');
                        }
                    } else {
                        $(th).css('display', 'none');
                        var trCount = $('#gvServiceDetails > tbody > tr').length;
                        if (trCount >= 502) {
                            trCount = trCount-1;
                        }
                        for (let j = 1; j < trCount; j++) {
                            let trs = $('#gvServiceDetails tr');
                            let tr = $(trs)[j];
                            let innertd = $(tr).children()[i];
                            $(innertd).css('display', 'none');
                        }
                    }
                }
                $.unblockUI({});
                return false;
            }
            function showPanelsTopRight(element, panelid, rightvalue, topvalue) {
                document.getElementById(panelid).style.visibility = "visible";
                $("#" + panelid).css({ 'right': rightvalue, 'top': topvalue });
            }
            function hidePanels(element, panelid) {
                //   document.getElementById(panelid).style.visibility = "hidden";
                $('#' + panelid).css('visibility', 'hidden');
            }
            var bigDiv = document.getElementById('gridContainer');
            bigDiv.onscroll = function () {
                $('[id*=hdnScrollPos]').val(bigDiv.scrollTop);
                console.log("id scroll =" + $('[id*=hdnScrollPos]').val());
            }
            window.onload = function () {
                bigDiv.scrollTop = $('[id*=hdnScrollPos]').val();
            }
            function showLoader() {
                $.blockUI({ message: '<img runat="server" src="Images/Loading.gif" />' });
                return true;
            }
            $('[id$=lbModel]').multiselect({
                includeSelectAllOption: true
            });
            function showFileDetails(evt) {
                debugger;

                var fileidvalue = $(evt).closest('tr').find('#hdnFileID').val();
                var collectionName = $(evt).closest('tr').find('#hdnCollectionName').val();
                let type = $(evt).closest('tr').find('#hdnMachineType').val();
                let model = $(evt).closest('tr').find('#hdnMachineModel').val();
                let slno = $(evt).closest('tr').find('#hdnMachineSlno').val();
                if (type == "" && model == "" && slno == "") {
                    collectionName = "MTBLeveleDoc";
                }
                else if (slno == "") {
                    collectionName = "ModelLeveleDoc";
                } else {
                    collectionName = "MachineLeveleDoc";
                }
                var filename = $(evt).closest('tr').find('#hdnFileName').val();
                $.ajax({
                    async: false,
                    type: "POST",
                    url: "Troubleshooting.aspx/getFileNamePath",
                    contentType: "application/json; charset=utf-8",
                    data: '{fileId:"' + fileidvalue + '",filenameStr:"' + filename + '",colName:"' + collectionName + '"}',
                    datatype: "json",
                    success: function (response) {
                        var itemdata = response.d;
                        debugger;
                        //$('#iframeDocument').attr("src", "");
                        //$('#iframeDocument').attr("src", itemdata);
                        //$('#showDocumentModal').modal("show");

                        $('#iframeDocument').css("display", "none");
                        $('#machineDocVideo').css("display", "none");
                        $('#machineDocImage').css("display", "none");
                        $('#machineDocVideo source').attr('src', '');
                        $("#machineDocVideo")[0].load();
                        $('#machineDocImage').attr('src', '');
                        $('#iframeDocument').attr("src", "");
                        if (itemdata.FileInBase64 != "") {
                            var fileType = itemdata.FileType;
                            if (fileType == "video") {
                                if (itemdata.FileExtension == "gif") {
                                    $('#machineDocImage').css("display", "block");
                                    $('#machineDocImage').attr('src', "data:image/gif;base64," + itemdata.FileInBase64);
                                }
                                else {
                                    $('#machineDocVideo').css("display", "block");
                                    $('#machineDocVideo source').attr('src', "data:video/mp4;base64," + itemdata.FileInBase64);
                                    $("#machineDocVideo")[0].load();
                                }
                                $('#showDocumentModal').modal("show");
                            }
                            else if (fileType == "image") {
                                $('#machineDocImage').css("display", "block");
                                $('#machineDocImage').attr('src', "data:image/png;base64," + itemdata.FileInBase64);
                                $('#showDocumentModal').modal("show");
                            }
                            else if (fileType == "pdf") {
                                $('#iframeDocument').css("display", "block");
                                var arrrayBuffer = base64ToArrayBuffer(itemdata.FileInBase64); //data is the base64 encoded string
                                var blob = new Blob([arrrayBuffer], { type: "application/pdf" });
                                var link = window.URL.createObjectURL(blob);
                                $('#iframeDocument').attr("src", link + "#toolbar=0");
                                $('#showDocumentModal').modal("show");
                            }
                            else if (fileType == "excel") {
                                debugger;
                                // $('#iframeDocument').css("display", "block");
                                // var arrrayBuffer = base64ToArrayBuffer(itemdata.FileInBase64); //data is the base64 encoded string
                                //var blob = new Blob([arrrayBuffer], { type: "application/vnd.ms-excel" });
                                // var link = window.URL.createObjectURL(blob);
                                //$('#iframeDocument').attr("src", link + "#toolbar=0");
                                //$('#showDocumentModal').modal("hide");

                                //var link = $(evt);
                                //link.href = window.URL.createObjectURL(blob);
                                //link.download = "Dossier";
                                //link.click();

                                var linkSource = 'data:application/vnd.ms-excel;base64,' + itemdata.FileInBase64;
                                var downloadLink = document.createElement("a");
                                var fileName = filename;
                                downloadLink.href = linkSource;
                                downloadLink.download = fileName;
                                downloadLink.click();
                            }
                            else {
                                debugger;
                                $('#iframeDocument').css("display", "block");
                                var arrrayBuffer = base64ToArrayBuffer(itemdata.FileInBase64); //data is the base64 encoded string
                                var blob = new Blob([arrrayBuffer], { type: "application/" + itemdata.FileExtension });
                                // var blob = new Blob([arrrayBuffer], { type: "application/vnd.ms-excel" });
                                var link = window.URL.createObjectURL(blob);
                                $('#iframeDocument').attr("src", link + "#toolbar=0");
                                $('#showDocumentModal').modal("show");
                            }
                        }

                    },
                    error: function (jqXHR, textStatus, err) {
                        console.log(err);
                    }
                });
                return false;
            }
            function base64ToArrayBuffer(base64) {
                var binaryString = window.atob(base64);
                var binaryLen = binaryString.length;
                var bytes = new Uint8Array(binaryLen);
                for (var i = 0; i < binaryLen; i++) {
                    var ascii = binaryString.charCodeAt(i);
                    bytes[i] = ascii;
                }
                return bytes;
            }
            function closeLargeDocumentModal() {
                $('#iframeDocument').attr("src", "");
                $('#machineDocVideo source').attr('src', '');
                $("#machineDocVideo")[0].load();
                $('#machineDocImage').attr('src', '');
            }
            function BindAggregationChart() {

                var model = "";
                var dataitem;
                $.ajax({
                    async: false,
                    type: "POST",
                    url: '<%= ResolveUrl("Troubleshooting.aspx/getAggregationDetails") %>',
                    contentType: "application/json; charset=utf-8",
                    crossDomain: true,
                    //  data: '{mtb: "' + $('#ddlMTB').val() + '", model:"' + model + '"}',
                    data: '{mtb: "ACE", model:"",searchString:"noise"}',
                    dataType: "json",
                    success: function (response) {
                        dataitem = response.d;
                        debugger;
                        if ($('#chartFilterDiv')[0] != undefined) {
                            var obj = {
                                name: $('#hdnWordSearch').val(),
                                weight: $('#hdnWordSearchWeight').val(),
                                color: $('#hdnWordSearchColor').val(),
                                clickStatus: "no"
                            };
                            dataitem = [];
                            dataitem.push(obj);
                        }
                    },
                    error: function (Result) {
                        alert("Error" + Result);
                    }
                });

                Highcharts.chart('textChartContainer', {

                    title: {
                        text: ''
                    },
                    credits: {
                        enabled: false
                    },
                    exporting: {
                        enabled: true
                    },
                    //accessibility: {
                    //    screenReaderSection: {
                    //        beforeChartFormat: '<h5>{chartTitle}</h5>' +
                    //            '<div>{chartSubtitle}</div>' +
                    //            '<div>{chartLongdesc}</div>' +
                    //            '<div>{viewTableButton}</div>'
                    //    }
                    //},
                    plotOptions: {
                        cursor: 'pointer',
                        series: {
                            point: {
                                events: {
                                    click: function (e) {
                                        if (e.point.clickStatus == "click") {
                                            let parameter = e.point.name;
                                            let color = $(this.graphic.element).attr('fill');
                                            let value = e.point.weight;
                                            BindWordChartFilterData(parameter, color, value);
                                        }
                                    }
                                }
                            }
                        }
                    },
                    series: [{
                        type: 'wordcloud',
                        data: dataitem,
                        animation: false,
                        name: 'Occurrences'
                    }],

                });
            }
            function BindWordChartFilterData(parameter, color, value) {
                debugger;
                showLoader();
                $('#hdnWordSearch').val(parameter);
                $('#hdnWordSearchColor').val(color);
                $('#hdnWordSearchWeight').val(value);
                __doPostBack('<%= btnWordFiterView.UniqueID%>', '');
            }
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                var bigDiv = document.getElementById('gridContainer');
                $(document).ready(function () {
                    setGridHeight();
                    bigDiv.scrollTop = $('[id*=hdnScrollPos]').val();
                    BindAggregationChart();
                    // setColumnName();
                     $.unblockUI({});
                });
                $('[id$=lbModel]').multiselect({
                    includeSelectAllOption: true
                });

                bigDiv.onscroll = function () {
                    $('[id*=hdnScrollPos]').val(bigDiv.scrollTop);
                }
                window.onload = function () {

                    bigDiv.scrollTop = $('[id*=hdnScrollPos]').val();
                    console.log("id load =" + bigDiv.scrollTop);
                }
            });
        </script>
    </form>
</body>
</html>
