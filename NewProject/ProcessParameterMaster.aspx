<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProcessParameterMaster.aspx.cs" Inherits="NewProject.ProcessParameterMaster" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <%--<%: Scripts.Render("~/bundles/toaster") %>--%>
    <script src="Scripts/Toaster/toastr.min.js"></script>
    <link href="Scripts/Toaster/toastr.min.css" rel="stylesheet" />
    <link href="Scripts/MultiSelectDropdown/bootstrap-multiselect.css" rel="stylesheet" />
    <script src="Scripts/MultiSelectDropdown/bootstrap-multiselect.js"></script>
    <style>
        .textboxcss {
            border: none;
            background-color: transparent;
            /*font-style: italic;*/
            color: white;
        }

        .light-mode .textboxcss {
            color: black;
        }

        .addtextcss {
            border: initial;
            background-color: none;
        }

        .select {
            /*border-radius: 5px;*/
            -webkit-appearance: none;
        }

        select option {
            color: black;
        }

        .P1Table tbody tr:last-child td select option {
            color: black !important;
            background-color: white !important;
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

        /*input[type="checkbox"] {
            width: 20px;
            height: 20px;
            -webkit-appearance: none;
            background-color: black;
            box-shadow: 0 1px 2px rgba(0,0,0,0.05), inset 0px -15px 10px -12px rgba(0,0,0,0.05);
            padding: 9px;
            border-radius: 3px;
            display: inline-block;
            position: relative;
            border-radius: 50%;
            border: 3px solid #e9ecee;
            outline: none;
            vertical-align: sub;
        }

        input[type="checkbox"]:active, input[type="checkbox"]:checked:active {
            box-shadow: 0 1px 2px rgba(0,0,0,0.05), inset 0px 1px 3px rgba(0,0,0,0.1);
        }

        input[type="checkbox"]:checked {
            background-color: black;
            border: 3px solid #e9ecee;
            box-shadow: 0 1px 2px rgba(0,0,0,0.05), inset 0px -15px 10px -12px rgba(0,0,0,0.05), inset 15px 10px -12px rgba(255,255,255,0.1);
            color: #e9ecee;
        }

        input[type="checkbox"]:checked:after {
            content: '\2714';
            font-size: 14px;
            position: absolute;
            top: 0px;
            left: 3px;
            color: #e9ecee;
        }
        .light-mode input[type="checkbox"] {
            width: 20px;
            height: 20px;
            -webkit-appearance: none;
            background-color: white;
            box-shadow: 0 1px 2px rgba(0,0,0,0.05), inset 0px -15px 10px -12px rgba(0,0,0,0.05);
            padding: 9px;
            border-radius: 3px;
            display: inline-block;
            position: relative;
            border-radius: 50%;
            border: 3px solid #0d6f6f;
            outline: none;
            vertical-align: sub;
        }

        .light-mode input[type="checkbox"]:active, input[type="checkbox"]:checked:active {
            box-shadow: 0 1px 2px rgba(0,0,0,0.05), inset 0px 1px 3px rgba(0,0,0,0.1);
        }

        .light-mode input[type="checkbox"]:checked {
            background-color: white;
            border: 3px solid #0d6f6f;
            box-shadow: 0 1px 2px rgba(0,0,0,0.05), inset 0px -15px 10px -12px rgba(0,0,0,0.05), inset 15px 10px -12px rgba(255,255,255,0.1);
            color: #0d6f6f;
        }

        .light-mode input[type="checkbox"]:checked:after {
            content: '\2714';
            font-size: 14px;
            position: absolute;
            top: 0px;
            left: 3px;
            color: #0d6f6f;
        }*/



        .P1Table select {
            width: auto;
        }

        .P1Table tr th, .P1Table tr td {
            border-left: unset;
            /*border-right: unset;*/
        }

        .P1Table tr td {
            height: 50px;
            padding: 0px 8px;
        }

        #processParamContainer table.P1Table > tbody > tr > th:last-child, #processParamContainer table.P1Table > tbody > tr > td:last-child {
            position: sticky;
            right: 0px;
        }

            #processParamContainer table.P1Table > tbody > tr > th:last-child > input, #processParamContainer table.P1Table > tbody > tr > td:last-child > input {
                min-width: unset;
            }

        #processParamContainer table.P1Table > tbody > tr > td:last-child {
            background-color: #373a3c;
        }

        .light-mode #processParamContainer table.P1Table > tbody > tr > td:last-child {
            background-color: #f9f7f7;
        }

        #processParamContainer .P1Table tr:hover td:last-child {
            /*opacity: 1;*/
        }

        .P1Table tr th, .light-mode .P1Table tr th {
            z-index: 10;
        }

        .P1Table tr td:first-child {
            min-width: 180px;
        }

        .gridTbl {
            width: 100%;
        }

            .gridTbl tr td, .light-mode .gridTbl tr td {
                border: none !important;
                /*width:50%;*/
                padding: 0px 8px;
            }

            .gridTbl tr th {
                /*width:50%;*/
            }

        .light-mode .gridTbl tr th {
            border: none !important;
        }

        .gridTbl tr:hover td {
            background-color: none !important;
        }

        .gridTbl .gridTblHeader {
            border-bottom: 0.5px solid #a3a3a361;
        }

        .light-mode .gridTbl .gridTblHeader {
        }

        .gridTbl .gridTblSubHeader, .light-mode .gridTbl .gridTblSubHeader {
            width: 140px;
            border-right: 0.5px solid #a3a3a361 !important;
        }

        .gridTbl tr td.gridTblFirstTd {
            min-width: 140px;
            width: 140px;
            border-right: 0.5px solid #a3a3a361 !important;
        }

        .innerTblCol {
            padding: 0px !important;
        }

        .form-control, .textboxcss, .select {
            min-width: 100px;
        }

        .multiselect-container {
            /*height: 300px;
            overflow-x: auto;*/
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

        #copyModelLvlData table tr td {
            padding: 4px 40px;
        }
    </style>
    <div class="themetoggle">


        <asp:HiddenField runat="server" ID="hdnScrollPos" ClientIDMode="Static" />
        <div style="float: left; margin-top: 5px">
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <div class="navbar-collapse collapse" style="height: 42px !important;">
                        <ul class="nav navbar-nav nextPrevious submenus-style ">
                            <li><a runat="server" class="submenuData" id="A15" clientidmode="static" data-toggle="tab" href="#processParamMenu0">Controller Level</a>
                                <i></i>
                            </li>
                            <li><a runat="server" class="submenuData" id="A14" clientidmode="static" data-toggle="tab" href="#processParamMenu1">MTB & Model Level</a>
                                <i></i>
                            </li>

                            <li><a runat="server" class="submenuData" id="A16" clientidmode="static" data-toggle="tab" href="#processParamMenu2">Machine Level</a>
                                <i></i>
                            </li>
                        </ul>
                    </div>
                    <div style="display: none">
                        <asp:Button runat="server" ID="btnControllerLvl" OnClick="btnControllerLvl_Click" />
                        <asp:Button runat="server" ID="btnModelLvl" OnClick="btnModelLvl_Click" />
                        <asp:Button runat="server" ID="btnMachineLvl" OnClick="btnMachineLvl_Click" />
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="tab-content themetoggle" id="processParamContainer" style="overflow: auto; width: 100%; margin: -10px auto;">
                <div id="processParamMenu0" class="tab-pane fade">
                    <div>
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <fieldset class="field-set">
                                    <legend>&nbsp;<b>Filter By</b></legend>
                                    <table class="filterTbl filter-field-table">
                                        <tr>
                                            <%--  <td>Machine Type&nbsp;</td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlControlLvlMachineType" CssClass="form-control">
                                                    <asp:ListItem>VMC</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>--%>
                                            <%--  <td>&nbsp;&nbsp;Company&nbsp;</td>
                                        <td>
                                            <asp:DropDownList runat="server" ID="ddlControlLvlCompany" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlControlLvlCompany_SelectedIndexChanged"></asp:DropDownList>
                                        </td>
                                        <td>&nbsp;&nbsp;Plant&nbsp;</td>
                                        <td>
                                            <asp:DropDownList runat="server" ID="ddlControlLvlPlant" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlControlLvlPlant_SelectedIndexChanged"></asp:DropDownList>
                                        </td>--%>
                                            <td>CNC Make&nbsp;</td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlControlLvlCNCMake" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlControlLvlCNCMake_SelectedIndexChanged"></asp:DropDownList>
                                            </td>
                                            <td>&nbsp;&nbsp;Series / Model&nbsp;</td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlControlLvlCNCModel" CssClass="form-control"></asp:DropDownList>
                                            </td>
                                            <td>
                                                <asp:Button runat="server" ID="btnControllerView" ClientIDMode="Static" Text="View" CssClass="Btns" OnClick="btnControllerView_Click" />
                                                <asp:Button runat="server" ID="btnControllerSave" ClientIDMode="Static" Text="Save" CssClass="Btns" OnClick="btnControllerSave_Click" />

                                                <asp:Button runat="server" ID="btnControllerExportPDF" ClientIDMode="Static" Text="Export" CssClass="Btns" OnClientClick="return true;" OnClick="btnControllerExportPDF_Click" />
                                                <%--  <asp:Button runat="server" ID="btnControllerDelete" ClientIDMode="Static" Text="Delete" CssClass="Btns" OnClick="btnControllerDelete_Click" OnClientClick="return openDeleteConfirmModal('controllerLvlDeleteConfirmModal','gvControllerLvlData');" />--%>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="ddlControlLvlCNCMake" EventName="SelectedIndexChanged" />
                                <asp:AsyncPostBackTrigger ControlID="btnControllerSave" EventName="Click" />
                                <%--  <asp:AsyncPostBackTrigger ControlID="btnControllerDelete" EventName="Click" />--%>
                                <asp:PostBackTrigger ControlID="btnControllerExportPDF" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                    <div id="gvControllerLvlContainer" class="gridContainer" style="margin-top: 10px; width: 95vw; overflow: auto">
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvControllerLvlData" runat="server" AutoGenerateColumns="false" Width="100%" EmptyDataText="No Data Found." ShowHeaderWhenEmpty="true" ShowHeader="true" ShowFooter="true" ClientIDMode="Static" OnRowDataBound="gvControllerLvlData_RowDataBound" CssClass="P1Table">
                                    <Columns>
                                        <%--  <asp:TemplateField HeaderText="Machine Type" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMachineType" runat="server" Text='<%# Eval("MachineType") %>' ClientIDMode="Static"></asp:Label>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:DropDownList runat="server" ID="ddlMachineTypeNew" CssClass="form-control">
                                                          <asp:ListItem>VMC</asp:ListItem>
                                                    </asp:DropDownList>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="CNC Make" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCNCMake" runat="server" Text='<%# Eval("CNCMake") %>' ClientIDMode="Static"></asp:Label>

                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:DropDownList runat="server" ID="ddlCNCMakeNew"  CssClass="form-control">
                                                         <asp:ListItem>Fanuc</asp:ListItem>
                                                    </asp:DropDownList>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="CNC Model" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCNCModel" runat="server" Text='<%# Eval("CNCModel") %>' ClientIDMode="Static"></asp:Label>

                                                </ItemTemplate>
                                                <FooterTemplate>
                                                     <asp:DropDownList runat="server" ID="ddlCNCModelNew" CssClass="form-control">
                                                    <asp:ListItem>OiTD</asp:ListItem>
                                                </asp:DropDownList>
                                                </FooterTemplate>
                                            </asp:TemplateField>--%>
                                        <%--   <asp:TemplateField HeaderText="Machine ID">
                                            <ItemTemplate>
                                                    <asp:Label ID="lblMachineID"  runat="server" Text='<%# Eval("TimeFrom") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>--%>
                                        <asp:TemplateField HeaderText="Parameter ID">
                                            <ItemTemplate>
                                                <asp:HiddenField runat="server" ID="hdnUpdate" ClientIDMode="Static" />
                                                <asp:HiddenField runat="server" ID="hdnCNCMake" Value='<%# Eval("CNCMake") %>' ClientIDMode="Static" />
                                                <asp:HiddenField runat="server" ID="hdnCNCModel" Value='<%# Eval("CNCModel") %>' ClientIDMode="Static" />
                                                <asp:Label ID="lblParemeterID" runat="server" Text='<%# Eval("ParemeterID") %>' ClientIDMode="Static"></asp:Label>

                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox runat="server" ID="txtParameterIDNew" CssClass="form-control parameterValidation" AutoCompleteType="Disabled"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Source Type">
                                            <ItemTemplate>
                                                <%--<asp:HiddenField runat="server" ID="hdnSourceType" Value='<%# Eval("SourceType") %>' ClientIDMode="Static" />
                                                <asp:DropDownList ID="ddlSourceType" runat="server" CssClass="textboxcss select form-control">
                                                </asp:DropDownList>--%>
                                                <asp:Label ID="lblSourceType" runat="server" Text='<%# Eval("SourceType") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:DropDownList ID="ddlSourceTypeNew" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlSourceTypeNewController_SelectedIndexChanged">
                                                </asp:DropDownList>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Source <br/> Address 1">
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" ID="txtSourceAdd1" Style="text-align: left" CssClass="textboxcss" Text='<%# Eval("SourceAdd1") %>' AutoCompleteType="Disabled"></asp:TextBox>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox runat="server" ID="txtSourceAdd1New" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Source Data Type 1">
                                            <ItemTemplate>
                                                <%-- <asp:TextBox runat="server" ID="txtDataType1" Style="width: 80px; text-align: left" CssClass="textboxcss" Text='<%# Eval("SourceDatatype1") %>'></asp:TextBox>--%>
                                                <asp:HiddenField runat="server" ID="hdnDataType1" Value='<%# Eval("SourceDatatype1") %>' />
                                                <asp:DropDownList runat="server" ID="ddlDataType1" ClientIDMode="Static" CssClass="textboxcss select form-control"></asp:DropDownList>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <%-- <asp:TextBox runat="server" ID="txtDataType1New" CssClass="form-control"></asp:TextBox>--%>
                                                <asp:DropDownList runat="server" ID="ddlDataType1New" ClientIDMode="Static" CssClass="form-control">
                                                </asp:DropDownList>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Source  <br/> Address 2">
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" ID="txtSourceAdd2" Style="text-align: left" CssClass="textboxcss" Text='<%# Eval("SourceAdd2") %>' AutoCompleteType="Disabled"></asp:TextBox>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox runat="server" ID="txtSourceAdd2New" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Source Data Type 2">
                                            <ItemTemplate>
                                                <%-- <asp:TextBox runat="server" ID="txtDataType2" Style="width: 80px; text-align: left" CssClass="textboxcss" Text='<%# Eval("SourceDatatype2") %>'></asp:TextBox>--%>
                                                <asp:HiddenField runat="server" ID="hdnDataType2" Value='<%# Eval("SourceDatatype2") %>' />
                                                <asp:DropDownList runat="server" ID="ddlDataType2" ClientIDMode="Static" CssClass="textboxcss select form-control"></asp:DropDownList>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <%-- <asp:TextBox runat="server" ID="txtDataType2New" CssClass="form-control"></asp:TextBox>--%>
                                                <asp:DropDownList runat="server" ID="ddlDataType2New" ClientIDMode="Static" CssClass="form-control"></asp:DropDownList>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderStyle-CssClass="innerTblCol" ItemStyle-CssClass="innerTblCol" FooterStyle-CssClass="innerTblCol">
                                            <HeaderTemplate>
                                                <table class="gridTbl">
                                                    <tr class="gridTblHeader">
                                                        <th colspan="2" style="text-align: center">Polling</th>
                                                    </tr>
                                                    <tr>
                                                        <th class="gridTblSubHeader">Frequency (Sec) </th>
                                                        <th>Time</th>
                                                    </tr>
                                                </table>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table class="gridTbl" border="0">
                                                    <tr>
                                                        <td class="gridTblFirstTd innerTblTd">
                                                            <asp:HiddenField runat="server" ID="hdnPollingFrequency" Value='<%# Eval("PollingFrequency") %>' ClientIDMode="Static" />
                                                            <asp:DropDownList ID="ddlPollingFrequency" runat="server" CssClass="textboxcss select form-control"></asp:DropDownList>
                                                        </td>
                                                        <td class="innerTblTd" style="padding-left: 8px">
                                                            <asp:HiddenField runat="server" ID="hdnPollingType" Value='<%# Eval("PollingType") %>' ClientIDMode="Static" />
                                                            <asp:DropDownList ID="ddlPollingType" runat="server" CssClass="textboxcss select form-control pollingTypeSelect"></asp:DropDownList>
                                                            <%--OnSelectedIndexChanged="ddlPollingTypeController_SelectedIndexChanged" AutoPostBack="true"--%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <table class="gridTbl">
                                                    <tr>
                                                        <td class="gridTblFirstTd innerTblTd">
                                                            <asp:DropDownList ID="ddlPollingFrequencyNew" runat="server" CssClass="form-control">
                                                            </asp:DropDownList></td>
                                                        <td class="innerTblTd">
                                                            <asp:DropDownList ID="ddlPollingTypeNew" runat="server" CssClass="form-control pollingTypeSelect"></asp:DropDownList>
                                                            <%--OnSelectedIndexChanged="ddlPollingTypeNewController_SelectedIndexChanged" AutoPostBack="true"--%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <%--  <asp:TemplateField HeaderText="Polling Frequency (Sec)">
                                            <ItemTemplate>
                                                <asp:HiddenField runat="server" ID="hdnPollingFrequency" Value='<%# Eval("PollingFrequency") %>' ClientIDMode="Static" />
                                                <asp:DropDownList ID="ddlPollingFrequency" runat="server" CssClass="textboxcss select form-control"></asp:DropDownList>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:DropDownList ID="ddlPollingFrequencyNew" runat="server" CssClass="form-control">
                                                </asp:DropDownList>
                                            </FooterTemplate>
                                        </asp:TemplateField>--%>
                                        <asp:TemplateField HeaderText="Data Group" Visible="false">
                                            <ItemTemplate>
                                                <asp:HiddenField runat="server" ID="hdnDataGroup" Value='<%# Eval("DataGroup") %>' ClientIDMode="Static" />
                                                <asp:DropDownList ID="ddlDataGroup" runat="server" CssClass="textboxcss select form-control"></asp:DropDownList>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:DropDownList ID="ddlDataGroupNew" runat="server" CssClass="form-control"></asp:DropDownList>
                                            </FooterTemplate>
                                        </asp:TemplateField>

                                        <%--  <asp:TemplateField HeaderText="Polling Type">
                                            <ItemTemplate>
                                                <asp:HiddenField runat="server" ID="hdnPollingType" Value='<%# Eval("PollingType") %>' ClientIDMode="Static" />
                                                <asp:DropDownList ID="ddlPollingType" runat="server" CssClass="textboxcss select form-control pollingTypeSelect" OnSelectedIndexChanged="ddlPollingTypeController_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:DropDownList ID="ddlPollingTypeNew" runat="server" CssClass="form-control pollingTypeSelect" OnSelectedIndexChanged="ddlPollingTypeNewController_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                            </FooterTemplate>
                                        </asp:TemplateField>--%>
                                        <%--  <asp:TemplateField HeaderText="Cycle Frequency Time (Hr)">
                                            <ItemTemplate>
                                                <asp:HiddenField runat="server" ID="hdnCycleFreqTime" Value='<%# Eval("CycleFreqTime") %>' ClientIDMode="Static" />
                                                <asp:DropDownList ID="ddlCycleFrequencyTime" runat="server" CssClass="textboxcss select form-control"></asp:DropDownList>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:DropDownList ID="ddlCycleFrequencyTimeNew" runat="server" CssClass="form-control"></asp:DropDownList>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="No. of Cycles">
                                            <ItemTemplate>
                                                <asp:HiddenField runat="server" ID="hdnNoOfCycle" Value='<%# Eval("NoOfCycle") %>' ClientIDMode="Static" />
                                                <asp:DropDownList ID="ddlNoOfCycle" runat="server" CssClass="textboxcss select form-control"></asp:DropDownList>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:DropDownList ID="ddlNoOfCycleNew" runat="server" CssClass="form-control"></asp:DropDownList>
                                            </FooterTemplate>
                                        </asp:TemplateField>--%>
                                        <asp:TemplateField HeaderStyle-CssClass="innerTblCol" ItemStyle-CssClass="innerTblCol" FooterStyle-CssClass="innerTblCol">
                                            <HeaderTemplate>
                                                <table class="gridTbl">
                                                    <tr class="gridTblHeader">
                                                        <th colspan="2" style="text-align: center">Cycle</th>
                                                    </tr>
                                                    <tr>
                                                        <th class="gridTblSubHeader">Frequency (Hr)</th>
                                                        <th>Number</th>
                                                    </tr>
                                                </table>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table class="gridTbl" border="0">
                                                    <tr>
                                                        <td class="gridTblFirstTd innerTblTd">
                                                            <asp:HiddenField runat="server" ID="hdnCycleFreqTime" Value='<%# Eval("CycleFreqTime") %>' ClientIDMode="Static" />
                                                            <asp:DropDownList ID="ddlCycleFrequencyTime" runat="server" CssClass="textboxcss select form-control"></asp:DropDownList>
                                                        </td>
                                                        <td class="innerTblTd" style="padding-left: 8px">
                                                            <asp:HiddenField runat="server" ID="hdnNoOfCycle" Value='<%# Eval("NoOfCycle") %>' ClientIDMode="Static" />
                                                            <asp:DropDownList ID="ddlNoOfCycle" runat="server" CssClass="textboxcss select form-control"></asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <table class="gridTbl">
                                                    <tr>
                                                        <td class="gridTblFirstTd innerTblTd">
                                                            <asp:DropDownList ID="ddlCycleFrequencyTimeNew" runat="server" CssClass="form-control"></asp:DropDownList></td>
                                                        <td class="innerTblTd">
                                                            <asp:DropDownList ID="ddlNoOfCycleNew" runat="server" CssClass="form-control"></asp:DropDownList></td>
                                                    </tr>
                                                </table>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Upper Warning <br/>  Limit">
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" ID="txtUpperWarning" Style="text-align: left" CssClass="textboxcss decimalPt" Text='<%# Eval("UpperWarning") %>' AutoCompleteType="Disabled"></asp:TextBox>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox runat="server" ID="txtUpperWarningNew" CssClass="form-control decimalPt" AutoCompleteType="Disabled"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Lower Warning <br/> Limit">
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" ID="txtLowerWarning" Style="text-align: left" CssClass="textboxcss decimalPt" Text='<%# Eval("LowerWarning") %>' AutoCompleteType="Disabled"></asp:TextBox>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox runat="server" ID="txtLowerWarningNew" CssClass="form-control decimalPt" AutoCompleteType="Disabled"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Upper Error <br/> Limit">
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" ID="txtUpperError" Style="text-align: left" CssClass="textboxcss decimalPt" Text='<%# Eval("UpperError") %>' AutoCompleteType="Disabled"></asp:TextBox>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox runat="server" ID="txtUpperErrorNew" CssClass="form-control decimalPt" AutoCompleteType="Disabled"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Lower Error <br/> Limit">
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" ID="txtLowerError" Style="text-align: left" CssClass="textboxcss decimalPt" Text='<%# Eval("LowerError") %>' AutoCompleteType="Disabled"></asp:TextBox>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox runat="server" ID="txtLowerErrorNew" CssClass="form-control decimalPt" AutoCompleteType="Disabled"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Unit">
                                            <ItemTemplate>
                                                <%--<asp:TextBox runat="server" ID="txtUnit" Style="text-align: left" CssClass="textboxcss" Text='<%# Eval("Unit") %>' AutoCompleteType="Disabled"></asp:TextBox>--%>
                                                <asp:HiddenField runat="server" ID="hdnUnit" Value='<%# Eval("Unit") %>' ClientIDMode="Static" />
                                                <asp:DropDownList ID="ddlUnit" runat="server" CssClass="textboxcss select form-control"></asp:DropDownList>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <%--<asp:TextBox runat="server" ID="txtUnitNew" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>--%>
                                                <asp:DropDownList ID="ddlUnitNew" runat="server" CssClass="form-control"></asp:DropDownList>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Is Enabled?">
                                            <ItemTemplate>
                                                <asp:CheckBox runat="server" ID="chkIsEnabled" Checked='<%# Eval("IsEnabled") %>' />
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:CheckBox runat="server" ID="chkIsEnabledNew" />
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Is Mandatory?" Visible="false">
                                            <ItemTemplate>
                                                <asp:CheckBox runat="server" ID="chkShouldNotBeDisabled" Checked='<%# Eval("ShouldNotBeDisabled") %>' />
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:CheckBox runat="server" ID="chkShouldNotBeDisabledNew" />
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Add">
                                            <HeaderTemplate>
                                                <div>
                                                    <span>Add</span>&nbsp;&nbsp;
                                                    <i class=" glyphicon glyphicon-arrow-down" onclick="scorllDown('gvControllerLvlContainer');"></i>
                                                </div>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <%-- <asp:CheckBox runat="server" ID="chkDeleteSelection" />--%>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Button runat="server" ID="btnInsertControllerLevel" Text="Add" CssClass="Btns" OnClick="btnInsertControllerLevel_Click" />
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                <div class="modal fade" id="controllerLvlDeleteConfirmModal" role="dialog">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content modalContent confirm-modal-content">
                                            <div class="modal-header modalHeader confirm-modal-header">
                                                <i class="glyphicon glyphicon glyphicon glyphicon-question-sign modal-icons"></i>
                                                <br />
                                                <h4 class="confirm-modal-title">Confirmation!</h4>
                                                <br />
                                                <span class="confirm-modal-msg">Are you sure you want to delete Records?</span>
                                            </div>
                                            <div class="modal-footer modalFooter modal-footer">
                                                <asp:Button runat="server" Text="Yes" ID="btnDeleteController" CssClass="confirm-modal-btn" OnClick="btnDeleteController_Click" OnClientClick="return clearModalScreen();" />
                                                <input type="button" value="No" data-dismiss="modal" class="confirm-modal-btn" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnControllerView" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnControllerSave" EventName="Click" />
                                <%-- <asp:AsyncPostBackTrigger ControlID="btnControllerDelete" EventName="Click" />--%>
                                <asp:AsyncPostBackTrigger ControlID="btnControllerLvl" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnModelLvl" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnMachineLvl" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
                <div id="processParamMenu1" class="tab-pane fade">
                    <div>
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <fieldset class="field-set">
                                    <legend>&nbsp;<b>Filter By</b></legend>
                                    <table class="filterTbl filter-field-table filter-table-gap">
                                        <tr>
                                            <%--<td>&nbsp;&nbsp;Company&nbsp;</td>
                                        <td>
                                            <asp:DropDownList runat="server" ID="ddlModelLvlCompany" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlModelLvlCompany_SelectedIndexChanged"></asp:DropDownList>
                                        </td>
                                        <td>&nbsp;&nbsp;Plant&nbsp;</td>
                                        <td>
                                            <asp:DropDownList runat="server" ID="ddlModelLvlPlant" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlModelLvlPlant_SelectedIndexChanged"></asp:DropDownList>
                                        </td>--%>
                                            <td>CNC Make&nbsp;</td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlModelLvlCNCMake" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlModelLvlCNCMake_SelectedIndexChanged"></asp:DropDownList>
                                            </td>
                                            <td>&nbsp;&nbsp;Series / Model&nbsp;</td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlModelLvlCNCModel" CssClass="form-control"></asp:DropDownList>
                                                <%--AutoPostBack="true" OnSelectedIndexChanged="ddlModelLvlCNCModel_SelectedIndexChanged"--%>
                                            </td>
                                            <td>&nbsp;&nbsp;MTB&nbsp;</td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlModelLvlMTB" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlModelLvlMTB_SelectedIndexChanged"></asp:DropDownList>
                                            </td>

                                            <%-- </tr>
                                    <tr>--%>
                                            <td>&nbsp;&nbsp;Machine Type&nbsp;</td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlModelLvlMachineType" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlModelLvlMachineType_SelectedIndexChanged"></asp:DropDownList>
                                            </td>
                                            <td>&nbsp;&nbsp;Machine Model&nbsp;</td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlModelLvlMachineModel" CssClass="form-control"></asp:DropDownList>
                                            </td>
                                            <td>&nbsp;&nbsp;View&nbsp;</td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlModelLevelView" CssClass="form-control">
                                                    <asp:ListItem Value="All">All</asp:ListItem>
                                                    <asp:ListItem Value="Controller">Controller</asp:ListItem>
                                                    <asp:ListItem Value="Model">Model</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>

                                            <td colspan="4">
                                                <asp:Button runat="server" ID="btnModelLvlView" ClientIDMode="Static" Text="View" CssClass="Btns" OnClick="btnModelLvlView_Click" />

                                                <asp:Button runat="server" ID="btnModelLvlSave" ClientIDMode="Static" Text="Save" CssClass="Btns" OnClick="btnModelLvlSave_Click" />

                                                <asp:Button runat="server" ID="btnModelLvlDelete" ClientIDMode="Static" Text="Delete" CssClass="Btns" OnClientClick="return openDeleteConfirmModal('modelLvlDeleteConfirmModal','gvMTBModeldata');" />

                                                <asp:Button runat="server" ID="btnModelLvlCopy" ClientIDMode="Static" Text="Copy" CssClass="Btns" OnClientClick="return true;" OnClick="btnModelLvlCopy_Click" />

                                                <asp:Button runat="server" ID="btnModelExportPDF" ClientIDMode="Static" Text="Export" CssClass="Btns" OnClientClick="return true;" OnClick="btnModelExportPDF_Click" />
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                            </ContentTemplate>
                            <Triggers>
                                <asp:PostBackTrigger ControlID="btnModelExportPDF" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                    <div id="gvMTBModelContainer" class="gridContainer" style="margin-top: 10px; width: 95vw; overflow: auto">
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvMTBModeldata" runat="server" AutoGenerateColumns="false" Width="100%" EmptyDataText="No Data Found." ShowHeaderWhenEmpty="true" ShowHeader="true" ShowFooter="true" ClientIDMode="Static" OnRowDataBound="gvMTBModeldata_RowDataBound" CssClass="P1Table">
                                    <Columns>
                                        <%--  <asp:TemplateField HeaderText="MTB" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblMTB" runat="server" Text='<%# Eval("MTB") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:DropDownList runat="server" ID="ddlMTBNew" CssClass="form-control">
                                                    <asp:ListItem>MGTL</asp:ListItem>
                                                </asp:DropDownList>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Machine Model" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblMachineModel" runat="server" Text='<%# Eval("MachineModel") %>' ClientIDMode="Static"></asp:Label>

                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:DropDownList runat="server" ID="ddlMachineModelNew" CssClass="form-control">
                                                    <asp:ListItem>MCV 400</asp:ListItem>
                                                </asp:DropDownList>
                                            </FooterTemplate>
                                        </asp:TemplateField>--%>
                                        <%--   <asp:TemplateField HeaderText="Machine ID">
                                            <ItemTemplate>
                                                    <asp:Label ID="lblMachineID"  runat="server" Text='<%# Eval("TimeFrom") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>--%>
                                        <asp:TemplateField HeaderText="Parameter ID">
                                            <ItemTemplate>
                                                <asp:HiddenField runat="server" ID="hdnDeleteFlag" ClientIDMode="Static" Value='<%# Eval("DeleteFlag") %>' />
                                                <asp:HiddenField runat="server" ID="hdnUpdate" ClientIDMode="Static" />
                                                <asp:HiddenField runat="server" ID="hdnMTB" Value='<%# Eval("MTB") %>' />
                                                <asp:HiddenField runat="server" ID="hdnMachineType" Value='<%# Eval("MachineType") %>' />
                                                <asp:HiddenField runat="server" ID="hdnMachineModel" Value='<%# Eval("MachineModel") %>' />
                                                <asp:HiddenField runat="server" ID="hdnCNCMake" Value='<%# Eval("CNCMake") %>' />
                                                <asp:HiddenField runat="server" ID="hdnCNCModel" Value='<%# Eval("CNCModel") %>' />
                                                <asp:Label ID="lblParemeterID" runat="server" Text='<%# Eval("ParemeterID") %>' ClientIDMode="Static"></asp:Label>

                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox runat="server" ID="txtParameterIDNew" CssClass="form-control parameterValidation" AutoCompleteType="Disabled"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Source Type">
                                            <ItemTemplate>
                                                <%--<asp:HiddenField runat="server" ID="hdnSourceType" Value='<%# Eval("SourceType") %>' ClientIDMode="Static" />
                                                <asp:DropDownList ID="ddlSourceType" runat="server" CssClass="textboxcss select form-control"></asp:DropDownList>--%>
                                                <asp:Label ID="lblSourceType" runat="server" Text='<%# Eval("SourceType") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:DropDownList ID="ddlSourceTypeNew" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlSourceTypeNewModel_SelectedIndexChanged"></asp:DropDownList>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Source <br/> Address 1">
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" ID="txtSourceAdd1" Style="text-align: left" CssClass="textboxcss" Text='<%# Eval("SourceAdd1") %>' AutoCompleteType="Disabled"></asp:TextBox>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox runat="server" ID="txtSourceAdd1New" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Source Data Type 1">
                                            <ItemTemplate>
                                                <asp:HiddenField runat="server" ID="hdnDataType1" Value='<%# Eval("SourceDatatype1") %>' />
                                                <asp:DropDownList runat="server" ID="ddlDataType1" ClientIDMode="Static" CssClass="textboxcss select form-control"></asp:DropDownList>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:DropDownList runat="server" ID="ddlDataType1New" ClientIDMode="Static" CssClass="form-control"></asp:DropDownList>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Source <br/> Address 2">
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" ID="txtSourceAdd2" Style="text-align: left" CssClass="textboxcss" Text='<%# Eval("SourceAdd2") %>' AutoCompleteType="Disabled"></asp:TextBox>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox runat="server" ID="txtSourceAdd2New" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Source Data Type 2">
                                            <ItemTemplate>
                                                <asp:HiddenField runat="server" ID="hdnDataType2" Value='<%# Eval("SourceDatatype2") %>' />
                                                <asp:DropDownList runat="server" ID="ddlDataType2" ClientIDMode="Static" CssClass="textboxcss select form-control">
                                                </asp:DropDownList>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <%-- <asp:TextBox runat="server" ID="txtDataType2New" CssClass="form-control"></asp:TextBox>--%>
                                                <asp:DropDownList runat="server" ID="ddlDataType2New" ClientIDMode="Static" CssClass="form-control">
                                                </asp:DropDownList>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <%--        <asp:TemplateField HeaderText="Polling Frequency (Sec)">
                                            <ItemTemplate>
                                                <asp:HiddenField runat="server" ID="hdnPollingFrequency" Value='<%# Eval("PollingFrequency") %>' ClientIDMode="Static" />
                                                <asp:DropDownList ID="ddlPollingFrequency" runat="server" CssClass="textboxcss select form-control"></asp:DropDownList>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:DropDownList ID="ddlPollingFrequencyNew" runat="server" CssClass="form-control"></asp:DropDownList>
                                            </FooterTemplate>
                                        </asp:TemplateField>--%>
                                        <asp:TemplateField HeaderText="Data Group" Visible="false">
                                            <ItemTemplate>
                                                <asp:HiddenField runat="server" ID="hdnDataGroup" Value='<%# Eval("DataGroup") %>' ClientIDMode="Static" />
                                                <asp:DropDownList ID="ddlDataGroup" runat="server" CssClass="textboxcss select form-control"></asp:DropDownList>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:DropDownList ID="ddlDataGroupNew" runat="server" CssClass="form-control"></asp:DropDownList>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <%--     <asp:TemplateField HeaderText="Polling Type">
                                            <ItemTemplate>
                                                <asp:HiddenField runat="server" ID="hdnPollingType" Value='<%# Eval("PollingType") %>' ClientIDMode="Static" />
                                                <asp:DropDownList ID="ddlPollingType" runat="server" CssClass="textboxcss select form-control pollingTypeSelect" Style="" OnSelectedIndexChanged="ddlPollingTypeModel_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:DropDownList ID="ddlPollingTypeNew" runat="server" CssClass="form-control pollingTypeSelect" Style="" OnSelectedIndexChanged="ddlPollingTypeNewModel_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                            </FooterTemplate>
                                        </asp:TemplateField>--%>
                                        <asp:TemplateField HeaderStyle-CssClass="innerTblCol" ItemStyle-CssClass="innerTblCol" FooterStyle-CssClass="innerTblCol">
                                            <HeaderTemplate>
                                                <table class="gridTbl">
                                                    <tr class="gridTblHeader">
                                                        <th colspan="2" style="text-align: center">Polling</th>
                                                    </tr>
                                                    <tr>
                                                        <th class="gridTblSubHeader">Frequency (Sec) </th>
                                                        <th>Time</th>
                                                    </tr>
                                                </table>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table class="gridTbl" border="0">
                                                    <tr>
                                                        <td class="gridTblFirstTd innerTblTd">
                                                            <asp:HiddenField runat="server" ID="hdnPollingFrequency" Value='<%# Eval("PollingFrequency") %>' ClientIDMode="Static" />
                                                            <asp:DropDownList ID="ddlPollingFrequency" runat="server" CssClass="textboxcss select form-control"></asp:DropDownList>
                                                        </td>
                                                        <td class="innerTblTd" style="padding-left: 8px">
                                                            <asp:HiddenField runat="server" ID="hdnPollingType" Value='<%# Eval("PollingType") %>' ClientIDMode="Static" />
                                                            <asp:DropDownList ID="ddlPollingType" runat="server" CssClass="textboxcss select form-control pollingTypeSelect" Style=""></asp:DropDownList>
                                                            <%--OnSelectedIndexChanged="ddlPollingTypeModel_SelectedIndexChanged" AutoPostBack="true"--%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <table class="gridTbl">
                                                    <tr>
                                                        <td class="gridTblFirstTd innerTblTd">
                                                            <asp:DropDownList ID="ddlPollingFrequencyNew" runat="server" CssClass="form-control"></asp:DropDownList></td>
                                                        <td class="innerTblTd">
                                                            <asp:DropDownList ID="ddlPollingTypeNew" runat="server" CssClass="form-control pollingTypeSelect" Style=""></asp:DropDownList>
                                                            <%--OnSelectedIndexChanged="ddlPollingTypeNewModel_SelectedIndexChanged" AutoPostBack="true"--%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderStyle-CssClass="innerTblCol" ItemStyle-CssClass="innerTblCol" FooterStyle-CssClass="innerTblCol">
                                            <HeaderTemplate>
                                                <table class="gridTbl">
                                                    <tr class="gridTblHeader">
                                                        <th colspan="2" style="text-align: center">Cycle</th>
                                                    </tr>
                                                    <tr>
                                                        <th class="gridTblSubHeader">Frequency (Hr)</th>
                                                        <th>Number</th>
                                                    </tr>
                                                </table>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table class="gridTbl" border="0">
                                                    <tr>
                                                        <td class="gridTblFirstTd innerTblTd">
                                                            <asp:HiddenField runat="server" ID="hdnCycleFreqTime" Value='<%# Eval("CycleFreqTime") %>' ClientIDMode="Static" />
                                                            <asp:DropDownList ID="ddlCycleFrequencyTime" runat="server" CssClass="textboxcss select form-control"></asp:DropDownList>
                                                        </td>
                                                        <td class="innerTblTd" style="padding-left: 8px">
                                                            <asp:HiddenField runat="server" ID="hdnNoOfCycle" Value='<%# Eval("NoOfCycle") %>' ClientIDMode="Static" />
                                                            <asp:DropDownList ID="ddlNoOfCycle" runat="server" CssClass="textboxcss select form-control"></asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <table class="gridTbl">
                                                    <tr>
                                                        <td class="gridTblFirstTd innerTblTd">
                                                            <asp:DropDownList ID="ddlCycleFrequencyTimeNew" runat="server" CssClass="form-control"></asp:DropDownList></td>
                                                        <td class="innerTblTd">
                                                            <asp:DropDownList ID="ddlNoOfCycleNew" runat="server" CssClass="form-control"></asp:DropDownList></td>
                                                    </tr>
                                                </table>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <%-- <asp:TemplateField HeaderText="Cycle Frequency Time (Hr)">
                                            <ItemTemplate>
                                                <asp:HiddenField runat="server" ID="hdnCycleFreqTime" Value='<%# Eval("CycleFreqTime") %>' ClientIDMode="Static" />
                                                <asp:DropDownList ID="ddlCycleFrequencyTime" runat="server" CssClass="textboxcss select form-control"></asp:DropDownList>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:DropDownList ID="ddlCycleFrequencyTimeNew" runat="server" CssClass="form-control"></asp:DropDownList>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="No. of Cycles">
                                            <ItemTemplate>
                                                <asp:HiddenField runat="server" ID="hdnNoOfCycle" Value='<%# Eval("NoOfCycle") %>' ClientIDMode="Static" />
                                                <asp:DropDownList ID="ddlNoOfCycle" runat="server" CssClass="textboxcss select form-control"></asp:DropDownList>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:DropDownList ID="ddlNoOfCycleNew" runat="server" CssClass="form-control"></asp:DropDownList>
                                            </FooterTemplate>
                                        </asp:TemplateField>--%>
                                        <asp:TemplateField HeaderText="Upper Warning <br/> Limit">
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" ID="txtUpperWarning" Style="text-align: left" CssClass="textboxcss decimalPt" Text='<%# Eval("UpperWarning") %>' AutoCompleteType="Disabled"></asp:TextBox>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox runat="server" ID="txtUpperWarningNew" CssClass="form-control decimalPt" AutoCompleteType="Disabled"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Lower Warning <br/> Limit">
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" ID="txtLowerWarning" Style="text-align: left" CssClass="textboxcss decimalPt" Text='<%# Eval("LowerWarning") %>' AutoCompleteType="Disabled"></asp:TextBox>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox runat="server" ID="txtLowerWarningNew" CssClass="form-control decimalPt" AutoCompleteType="Disabled"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Upper Error <br/> Limit">
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" ID="txtUpperError" Style="text-align: left" CssClass="textboxcss decimalPt" Text='<%# Eval("UpperError") %>' AutoCompleteType="Disabled"></asp:TextBox>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox runat="server" ID="txtUpperErrorNew" CssClass="form-control decimalPt" AutoCompleteType="Disabled"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Lower Error <br/> Limit">
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" ID="txtLowerError" Style="text-align: left" CssClass="textboxcss decimalPt" Text='<%# Eval("LowerError") %>' AutoCompleteType="Disabled"></asp:TextBox>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox runat="server" ID="txtLowerErrorNew" CssClass="form-control decimalPt" AutoCompleteType="Disabled"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Unit">
                                            <ItemTemplate>
                                                <%--<asp:TextBox runat="server" ID="txtUnit" Style="text-align: left" CssClass="textboxcss" Text='<%# Eval("Unit") %>' AutoCompleteType="Disabled"></asp:TextBox>--%>
                                                <asp:HiddenField runat="server" ID="hdnUnit" Value='<%# Eval("Unit") %>' ClientIDMode="Static" />
                                                <asp:DropDownList ID="ddlUnit" runat="server" CssClass="textboxcss select form-control"></asp:DropDownList>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <%--<asp:TextBox runat="server" ID="txtUnitNew" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>--%>
                                                <asp:DropDownList ID="ddlUnitNew" runat="server" CssClass="form-control"></asp:DropDownList>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Is Enabled?">
                                            <ItemTemplate>
                                                <asp:CheckBox runat="server" ID="chkIsEnabled" Checked='<%# Eval("IsEnabled") %>' />
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:CheckBox runat="server" ID="chkIsEnabledNew" />
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Is Mandatory?" Visible="false">
                                            <ItemTemplate>
                                                <asp:CheckBox runat="server" ID="chkShouldNotBeDisabled" Checked='<%# Eval("ShouldNotBeDisabled") %>' />
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:CheckBox runat="server" ID="chkShouldNotBeDisabledNew" />
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Parameter Level">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblLevel" Text='<%# Eval("ScreenName") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Delete">
                                            <HeaderTemplate>
                                                <div>
                                                    <span>Delete</span>&nbsp;&nbsp;
                                                    <i class=" glyphicon glyphicon-arrow-down" onclick="scorllDown('gvMTBModelContainer');"></i>
                                                </div>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:CheckBox runat="server" ID="chkDeleteSelection" />
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Button runat="server" ID="btnInsertModelLvl" Text="Add" CssClass="Btns" OnClick="btnInsertModelLvl_Click" />
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                <div class="modal infoModal" id="copyModelLvlData" role="dialog" style="min-width: 300px;" data-backdrop="static" data-keyboard="false">
                                    <div class="modal-dialog  modal-dialog-centered " style="width: 30%">
                                        <div class="modal-content modalThemeCss">
                                            <div class="modal-header">

                                                <h4 class="modal-title">Copy Model Data</h4>
                                            </div>
                                            <div class="modal-body">
                                                <table style="width: 100%; margin: auto">
                                                    <tr>
                                                        <td>Source</td>
                                                        <td>Destination</td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label runat="server" ID="lblModelLvlCopySrcModel"></asp:Label>
                                                        </td>
                                                        <td id="lbModelLvlCopyDistModelTd">
                                                            <asp:ListBox ID="lbModelLvlCopyDistModel" runat="server" SelectionMode="Multiple" CssClass="dropdown-list" ClientIDMode="Static" Style="width: 150px"></asp:ListBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div class="modal-footer">
                                                <asp:Button runat="server" Text="Save" ID="btnCopyModelLvl" CssClass="Btns" OnClientClick="return modelLvlCopyValidation();" />
                                                <button type="button" data-dismiss="modal" class="Btns">Close</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal fade" id="modelLvlCopyConfirmModal" role="dialog">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content modalContent confirm-modal-content">
                                            <div class="modal-header modalHeader confirm-modal-header">
                                                <i class="glyphicon glyphicon glyphicon glyphicon-question-sign modal-icons"></i>
                                                <br />
                                                <h4 class="confirm-modal-title">Confirmation!</h4>
                                                <br />
                                                <span class="confirm-modal-msg">Data will override existing data. Are you sure you want to override data?</span>
                                            </div>
                                            <div class="modal-footer modalFooter modal-footer">
                                                <asp:Button runat="server" Text="Yes" ID="btnModelLvlCopyConfirm" CssClass="confirm-modal-btn" OnClick="btnModelLvlCopyConfirm_Click" ClientIDMode="Static" OnClientClick="btnModelLvlCopyConfirmFun();" />
                                                <input type="button" value="No" data-dismiss="modal" class="confirm-modal-btn" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal fade" id="modelLvlDeleteConfirmModal" role="dialog">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content modalContent confirm-modal-content">
                                            <div class="modal-header modalHeader confirm-modal-header">
                                                <i class="glyphicon glyphicon glyphicon glyphicon-question-sign modal-icons"></i>
                                                <br />
                                                <h4 class="confirm-modal-title">Confirmation!</h4>
                                                <br />
                                                <span class="confirm-modal-msg">Are you sure you want to delete Records?</span>
                                            </div>
                                            <div class="modal-footer modalFooter modal-footer">
                                                <asp:Button runat="server" Text="Yes" ID="btnDeleteModel" CssClass="confirm-modal-btn" OnClick="btnDeleteModel_Click" OnClientClick="return clearModalScreen();" />
                                                <input type="button" value="No" data-dismiss="modal" class="confirm-modal-btn" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnModelLvlView" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnModelLvlSave" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnModelLvlDelete" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnControllerLvl" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnModelLvl" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnMachineLvl" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>

                <div id="processParamMenu2" class="tab-pane fade">
                    <div>
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <fieldset class="field-set">
                                    <legend>&nbsp;<b>Filter By</b></legend>
                                    <table class="filterTbl  filter-field-table filter-table-gap">
                                        <tr>
                                            <td>&nbsp;&nbsp;Company&nbsp;</td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlMachineLvlCompany" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlMachineLvlCompany_SelectedIndexChanged"></asp:DropDownList>
                                            </td>
                                            <td>&nbsp;&nbsp;Plant&nbsp;</td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlMachineLvlPlant" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlMachineLvlPlant_SelectedIndexChanged"></asp:DropDownList>

                                            </td>
                                            <td>&nbsp;&nbsp;CNC Make&nbsp;</td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlMachineLvlCNCMake" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlMachineLvlCNCMake_SelectedIndexChanged"></asp:DropDownList>
                                            </td>
                                            <td>&nbsp;&nbsp;Series / Model&nbsp;</td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlMachineLvlCNCModel" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlMachineLvlCNCModel_SelectedIndexChanged"></asp:DropDownList>
                                            </td>
                                            <td>&nbsp;&nbsp;MTB&nbsp;</td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlMachineLvlMTB" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlMachineLvlMTB_SelectedIndexChanged"></asp:DropDownList>
                                            </td>

                                        </tr>
                                        <tr>
                                            <td>&nbsp;&nbsp;Machine Type&nbsp;</td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlMachineLvlMachineType" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlMachineLvlMachineType_SelectedIndexChanged"></asp:DropDownList>
                                            </td>
                                            <td>&nbsp;&nbsp;Machine Model&nbsp;</td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlMachineLvlMachineModel" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlMachineLvlMachineModel_SelectedIndexChanged"></asp:DropDownList>
                                            </td>
                                            <td>&nbsp;&nbsp;Machine ID&nbsp;</td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlMachineLvlMachineID" CssClass="form-control"></asp:DropDownList>
                                            </td>
                                            <td>&nbsp;&nbsp;View&nbsp;</td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlMachineLevelView" CssClass="form-control">
                                                    <asp:ListItem Value="All">All</asp:ListItem>
                                                    <asp:ListItem Value="Controller">Controller</asp:ListItem>
                                                    <asp:ListItem Value="Model">Model</asp:ListItem>
                                                    <asp:ListItem Value="Machine">Machine</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td colspan="4">
                                                <asp:Button runat="server" ID="btnMachineLvlView" ClientIDMode="Static" Text="View" CssClass="Btns" OnClick="btnMachineLvlView_Click" />

                                                <asp:Button runat="server" ID="btnMachineLvlSave" ClientIDMode="Static" Text="Save" CssClass="Btns" OnClick="btnMachineLvlSave_Click" />

                                                <asp:Button runat="server" ID="btnMachineLvlDelete" ClientIDMode="Static" Text="Delete" CssClass="Btns" OnClientClick="return openDeleteConfirmModal('machineLvlDeleteConfirmModal','gvMAchineLvlData');" />

                                                <asp:Button runat="server" ID="btnCopyMachineLvl" ClientIDMode="Static" Text="Copy" CssClass="Btns" OnClientClick="return true;" OnClick="btnCopyMachineLvl_Click" />

                                                <asp:Button runat="server" ID="btnMachineExportPDF" ClientIDMode="Static" Text="Export" CssClass="Btns" OnClientClick="return true;" OnClick="btnMachineExportPDF_Click" />
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                            </ContentTemplate>
                            <Triggers>
                                <asp:PostBackTrigger ControlID="btnMachineExportPDF" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                    <div id="gvMachineLvlContainer" class="gridContainer" style="margin-top: 10px; width: 95vw; overflow: auto">
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvMAchineLvlData" runat="server" AutoGenerateColumns="false" Width="100%" EmptyDataText="No Data Found." ShowHeaderWhenEmpty="true" ShowHeader="true" ShowFooter="true" ClientIDMode="Static" OnRowDataBound="gvMAchineLvlData_RowDataBound" CssClass="P1Table">
                                    <Columns>
                                        <%--  <asp:TemplateField HeaderText="MTB" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblMTB" runat="server" Text='<%# Eval("MTB") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:DropDownList runat="server" ID="ddlMTBNew" CssClass="form-control">
                                                    <asp:ListItem>MGTL</asp:ListItem>
                                                </asp:DropDownList>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Machine Model" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblMachineModel" runat="server" Text='<%# Eval("MachineModel") %>' ClientIDMode="Static"></asp:Label>

                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:DropDownList runat="server" ID="ddlMachineModelNew" CssClass="form-control">
                                                    <asp:ListItem>MCV 400</asp:ListItem>
                                                </asp:DropDownList>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Machine ID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblMachineID" runat="server" Text='<%# Eval("MachineID") %>' ClientIDMode="Static"></asp:Label>

                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:DropDownList runat="server" ID="ddlMachineIDNew" CssClass="form-control">
                                                    <asp:ListItem>ACE-01</asp:ListItem>
                                                </asp:DropDownList>
                                            </FooterTemplate>
                                        </asp:TemplateField>--%>
                                        <%--   <asp:TemplateField HeaderText="Machine ID">
                                            <ItemTemplate>
                                                    <asp:Label ID="lblMachineID"  runat="server" Text='<%# Eval("TimeFrom") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>--%>
                                        <asp:TemplateField HeaderText="Parameter ID">
                                            <ItemTemplate>
                                                <asp:HiddenField runat="server" ID="hdnCompany" Value='<%# Eval("Company") %>' />
                                                <asp:HiddenField runat="server" ID="hdnPlant" Value='<%# Eval("Plant") %>' />
                                                <asp:HiddenField runat="server" ID="hdnDeleteFlag" ClientIDMode="Static" Value='<%# Eval("DeleteFlag") %>' />
                                                <asp:HiddenField runat="server" ID="hdnUpdate" ClientIDMode="Static" />
                                                <asp:HiddenField runat="server" ID="hdnMTB" Value='<%# Eval("MTB") %>' />
                                                <asp:HiddenField runat="server" ID="hdnMachineType" Value='<%# Eval("MachineType") %>' />
                                                <asp:HiddenField runat="server" ID="hdnMachineModel" Value='<%# Eval("MachineModel") %>' />
                                                <asp:HiddenField runat="server" ID="hdnCNCMake" Value='<%# Eval("CNCMake") %>' />
                                                <asp:HiddenField runat="server" ID="hdnCNCModel" Value='<%# Eval("CNCModel") %>' />
                                                <asp:HiddenField runat="server" ID="hdnMachineID" Value='<%# Eval("Machineid") %>' />
                                                <asp:Label ID="lblParemeterID" runat="server" Text='<%# Eval("ParemeterID") %>' ClientIDMode="Static"></asp:Label>

                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox runat="server" ID="txtParameterIDNew" CssClass="form-control parameterValidation" AutoCompleteType="Disabled"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Source Type">
                                            <ItemTemplate>
                                                <%-- <asp:HiddenField runat="server" ID="hdnSourceType" Value='<%# Eval("SourceType") %>' ClientIDMode="Static" />
                                                <asp:DropDownList ID="ddlSourceType" runat="server" CssClass="textboxcss select form-control"></asp:DropDownList>--%>
                                                <asp:Label ID="lblSourceType" runat="server" Text='<%# Eval("SourceType") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:DropDownList ID="ddlSourceTypeNew" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlSourceTypeNewMachine_SelectedIndexChanged"></asp:DropDownList>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Source <br/> Address 1">
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" ID="txtSourceAdd1" Style="text-align: left" CssClass="textboxcss" Text='<%# Eval("SourceAdd1") %>' AutoCompleteType="Disabled"></asp:TextBox>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox runat="server" ID="txtSourceAdd1New" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Source Data Type 1">
                                            <ItemTemplate>
                                                <%--   <asp:TextBox runat="server" ID="txtDataType1" Style="width: 80px; text-align: left" CssClass="textboxcss" Text='<%# Eval("SourceDatatype1") %>'></asp:TextBox>--%>
                                                <asp:HiddenField runat="server" ID="hdnDataType1" Value='<%# Eval("SourceDatatype1") %>' />
                                                <asp:DropDownList runat="server" ID="ddlDataType1" ClientIDMode="Static" CssClass="textboxcss select form-control"></asp:DropDownList>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <%-- <asp:TextBox runat="server" ID="txtDataType1New" CssClass="form-control"></asp:TextBox>--%>
                                                <asp:DropDownList runat="server" ID="ddlDataType1New" ClientIDMode="Static" CssClass="form-control"></asp:DropDownList>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Source <br/> Address 2">
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" ID="txtSourceAdd2" Style="text-align: left" CssClass="textboxcss" Text='<%# Eval("SourceAdd2") %>' AutoCompleteType="Disabled"></asp:TextBox>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox runat="server" ID="txtSourceAdd2New" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Source Data Type 2">
                                            <ItemTemplate>
                                                <%-- <asp:TextBox runat="server" ID="txtDataType2" Style="width: 80px; text-align: left" CssClass="textboxcss" Text='<%# Eval("SourceDatatype2") %>'></asp:TextBox>--%>
                                                <asp:HiddenField runat="server" ID="hdnDataType2" Value='<%# Eval("SourceDatatype2") %>' />
                                                <asp:DropDownList runat="server" ID="ddlDataType2" ClientIDMode="Static" CssClass="textboxcss select form-control"></asp:DropDownList>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <%--<asp:TextBox runat="server" ID="txtDataType2New" CssClass="form-control"></asp:TextBox>--%>
                                                <asp:DropDownList runat="server" ID="ddlDataType2New" ClientIDMode="Static" CssClass="form-control"></asp:DropDownList>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <%--  <asp:TemplateField HeaderText="Polling Frequency (Sec)">
                                            <ItemTemplate>
                                                <asp:HiddenField runat="server" ID="hdnPollingFrequency" Value='<%# Eval("PollingFrequency") %>' ClientIDMode="Static" />
                                                <asp:DropDownList ID="ddlPollingFrequency" runat="server" CssClass="textboxcss select form-control"></asp:DropDownList>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:DropDownList ID="ddlPollingFrequencyNew" runat="server" CssClass="form-control"></asp:DropDownList>
                                            </FooterTemplate>
                                        </asp:TemplateField>--%>
                                        <asp:TemplateField HeaderText="Data Group" Visible="false">
                                            <ItemTemplate>
                                                <asp:HiddenField runat="server" ID="hdnDataGroup" Value='<%# Eval("DataGroup") %>' ClientIDMode="Static" />
                                                <asp:DropDownList ID="ddlDataGroup" runat="server" CssClass="textboxcss select form-control"></asp:DropDownList>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:DropDownList ID="ddlDataGroupNew" runat="server" CssClass="form-control"></asp:DropDownList>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <%-- <asp:TemplateField HeaderText="Polling Type">
                                            <ItemTemplate>
                                                <asp:HiddenField runat="server" ID="hdnPollingType" Value='<%# Eval("PollingType") %>' ClientIDMode="Static" />
                                                <asp:DropDownList ID="ddlPollingType" runat="server" CssClass="textboxcss select form-control pollingTypeSelect" OnSelectedIndexChanged="ddlPollingTypeMachineLvl_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:DropDownList ID="ddlPollingTypeNew" runat="server" CssClass="form-control pollingTypeSelect" OnSelectedIndexChanged="ddlPollingTypeNewMachineLvl_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                            </FooterTemplate>
                                        </asp:TemplateField>--%>
                                        <asp:TemplateField HeaderStyle-CssClass="innerTblCol" ItemStyle-CssClass="innerTblCol" FooterStyle-CssClass="innerTblCol">
                                            <HeaderTemplate>
                                                <table class="gridTbl">
                                                    <tr class="gridTblHeader">
                                                        <th colspan="2" style="text-align: center">Polling</th>
                                                    </tr>
                                                    <tr>
                                                        <th class="gridTblSubHeader">Frequency (Sec) </th>
                                                        <th>Time</th>
                                                    </tr>
                                                </table>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table class="gridTbl" border="0">
                                                    <tr>
                                                        <td class="gridTblFirstTd innerTblTd">
                                                            <asp:HiddenField runat="server" ID="hdnPollingFrequency" Value='<%# Eval("PollingFrequency") %>' ClientIDMode="Static" />
                                                            <asp:DropDownList ID="ddlPollingFrequency" runat="server" CssClass="textboxcss select form-control"></asp:DropDownList>
                                                        </td>
                                                        <td class="innerTblTd" style="padding-left: 8px">
                                                            <asp:HiddenField runat="server" ID="hdnPollingType" Value='<%# Eval("PollingType") %>' ClientIDMode="Static" />
                                                            <asp:DropDownList ID="ddlPollingType" runat="server" CssClass="textboxcss select form-control pollingTypeSelect"></asp:DropDownList>
                                                            <%--OnSelectedIndexChanged="ddlPollingTypeMachineLvl_SelectedIndexChanged" AutoPostBack="true"--%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <table class="gridTbl">
                                                    <tr>
                                                        <td class="gridTblFirstTd innerTblTd">
                                                            <asp:DropDownList ID="ddlPollingFrequencyNew" runat="server" CssClass="form-control"></asp:DropDownList></td>
                                                        <td class="innerTblTd">
                                                            <asp:DropDownList ID="ddlPollingTypeNew" runat="server" CssClass="form-control pollingTypeSelect"></asp:DropDownList>
                                                            <%--OnSelectedIndexChanged="ddlPollingTypeNewMachineLvl_SelectedIndexChanged" AutoPostBack="true"--%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderStyle-CssClass="innerTblCol" ItemStyle-CssClass="innerTblCol" FooterStyle-CssClass="innerTblCol">
                                            <HeaderTemplate>
                                                <table class="gridTbl">
                                                    <tr class="gridTblHeader">
                                                        <th colspan="2" style="text-align: center">Cycle</th>
                                                    </tr>
                                                    <tr>
                                                        <th class="gridTblSubHeader">Frequency (Hr)</th>
                                                        <th>Number</th>
                                                    </tr>
                                                </table>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table class="gridTbl" border="0">
                                                    <tr>
                                                        <td class="gridTblFirstTd innerTblTd">
                                                            <asp:HiddenField runat="server" ID="hdnCycleFreqTime" Value='<%# Eval("CycleFreqTime") %>' ClientIDMode="Static" />
                                                            <asp:DropDownList ID="ddlCycleFrequencyTime" runat="server" CssClass="textboxcss select form-control"></asp:DropDownList>
                                                        </td>
                                                        <td class="innerTblTd" style="padding-left: 8px">
                                                            <asp:HiddenField runat="server" ID="hdnNoOfCycle" Value='<%# Eval("NoOfCycle") %>' ClientIDMode="Static" />
                                                            <asp:DropDownList ID="ddlNoOfCycle" runat="server" CssClass="textboxcss select form-control"></asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <table class="gridTbl">
                                                    <tr>
                                                        <td class="gridTblFirstTd innerTblTd">
                                                            <asp:DropDownList ID="ddlCycleFrequencyTimeNew" runat="server" CssClass="form-control"></asp:DropDownList></td>
                                                        <td class="innerTblTd">
                                                            <asp:DropDownList ID="ddlNoOfCycleNew" runat="server" CssClass="form-control"></asp:DropDownList></td>
                                                    </tr>
                                                </table>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <%--  <asp:TemplateField HeaderText="Cycle Frequency Time (Hr)">
                                            <ItemTemplate>
                                                <asp:HiddenField runat="server" ID="hdnCycleFreqTime" Value='<%# Eval("CycleFreqTime") %>' ClientIDMode="Static" />
                                                <asp:DropDownList ID="ddlCycleFrequencyTime" runat="server" CssClass="textboxcss select form-control"></asp:DropDownList>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:DropDownList ID="ddlCycleFrequencyTimeNew" runat="server" CssClass="form-control"></asp:DropDownList>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="No. of Cycles">
                                            <ItemTemplate>
                                                <asp:HiddenField runat="server" ID="hdnNoOfCycle" Value='<%# Eval("NoOfCycle") %>' ClientIDMode="Static" />
                                                <asp:DropDownList ID="ddlNoOfCycle" runat="server" CssClass="textboxcss select form-control"></asp:DropDownList>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:DropDownList ID="ddlNoOfCycleNew" runat="server" CssClass="form-control"></asp:DropDownList>
                                            </FooterTemplate>
                                        </asp:TemplateField>--%>
                                        <asp:TemplateField HeaderText="Upper Warning <br/> Limit">
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" ID="txtUpperWarning" Style="text-align: left" CssClass="textboxcss decimalPt" Text='<%# Eval("UpperWarning") %>' AutoCompleteType="Disabled"></asp:TextBox>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox runat="server" ID="txtUpperWarningNew" CssClass="form-control decimalPt" AutoCompleteType="Disabled"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Lower Warning <br/> Limit">
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" ID="txtLowerWarning" Style="text-align: left" CssClass="textboxcss decimalPt" Text='<%# Eval("LowerWarning") %>' AutoCompleteType="Disabled"></asp:TextBox>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox runat="server" ID="txtLowerWarningNew" CssClass="form-control decimalPt" AutoCompleteType="Disabled"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Upper Error <br/> Limit">
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" ID="txtUpperError" Style="text-align: left" CssClass="textboxcss decimalPt" Text='<%# Eval("UpperError") %>' AutoCompleteType="Disabled"></asp:TextBox>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox runat="server" ID="txtUpperErrorNew" CssClass="form-control decimalPt" AutoCompleteType="Disabled"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Lower Error <br/> Limit">
                                            <ItemTemplate>
                                                <asp:TextBox runat="server" ID="txtLowerError" Style="text-align: left" CssClass="textboxcss decimalPt" Text='<%# Eval("LowerError") %>' AutoCompleteType="Disabled"></asp:TextBox>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox runat="server" ID="txtLowerErrorNew" CssClass="form-control decimalPt" AutoCompleteType="Disabled"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Unit">
                                            <ItemTemplate>
                                                <%--<asp:TextBox runat="server" ID="txtUnit" Style="text-align: left" CssClass="textboxcss" Text='<%# Eval("Unit") %>' AutoCompleteType="Disabled"></asp:TextBox>--%>
                                                <asp:HiddenField runat="server" ID="hdnUnit" Value='<%# Eval("Unit") %>' ClientIDMode="Static" />
                                                <asp:DropDownList ID="ddlUnit" runat="server" CssClass="textboxcss select form-control"></asp:DropDownList>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <%--<asp:TextBox runat="server" ID="txtUnitNew" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>--%>
                                                <asp:DropDownList ID="ddlUnitNew" runat="server" CssClass="form-control"></asp:DropDownList>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Is Enabled?">
                                            <ItemTemplate>
                                                <asp:CheckBox runat="server" ID="chkIsEnabled" Checked='<%# Eval("IsEnabled") %>' />
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:CheckBox runat="server" ID="chkIsEnabledNew" />
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Is Mandatory?" Visible="false">
                                            <ItemTemplate>
                                                <asp:CheckBox runat="server" ID="chkShouldNotBeDisabled" Checked='<%# Eval("ShouldNotBeDisabled") %>' />
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:CheckBox runat="server" ID="chkShouldNotBeDisabledNew" />
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Is Enabled For Data Read?" Visible="false">
                                            <ItemTemplate>
                                                <asp:CheckBox runat="server" ID="chkIsEnabledForDataRead" Checked='<%# Eval("IsEnabledForDataRead") %>' />
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:CheckBox runat="server" ID="chkIsEnabledForDataReadNew" />
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Parameter Level">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblLevel" Text='<%# Eval("ScreenName") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Delete">
                                            <HeaderTemplate>
                                                <div>
                                                    <span>Delete</span>&nbsp;&nbsp;
                                                    <i class=" glyphicon glyphicon-arrow-down" onclick="scorllDown('gvMachineLvlContainer');"></i>
                                                </div>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:CheckBox runat="server" ID="chkDeleteSelection" />
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Button runat="server" ID="btnInsertMachineLvl" Text="Add" CssClass="Btns" OnClick="btnInsertMachineLvl_Click" />
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                <div class="modal infoModal" id="copyMachineLvlData" role="dialog" style="min-width: 300px;" data-backdrop="static" data-keyboard="false">
                                    <div class="modal-dialog  modal-dialog-centered " style="width: 30%">
                                        <div class="modal-content modalThemeCss">
                                            <div class="modal-header" style="padding: 8px">

                                                <h4 class="modal-title">Copy Machine Data</h4>
                                            </div>
                                            <div class="modal-body">
                                                <table style="width: 100%; margin: auto">
                                                    <tr>
                                                        <td>Source</td>
                                                        <td>Destination</td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label runat="server" ID="lblMachineLvlCopySrcMachineID"></asp:Label>
                                                        </td>
                                                        <td id="lblMachineLvlCopySrcMachineIDTd">
                                                            <asp:ListBox ID="lbMachineLvlCopyDistID" runat="server" SelectionMode="Multiple" CssClass="dropdown-list" ClientIDMode="Static" Style="width: 150px"></asp:ListBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div class="modal-footer">
                                                <asp:Button runat="server" Text="Save" CssClass="Btns" OnClientClick="return mahineLvlCopyValidation();" />
                                                <button type="button" data-dismiss="modal" class="Btns">Close</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal fade" id="machineLvlCopyConfirmModal" role="dialog">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content modalContent confirm-modal-content">
                                            <div class="modal-header modalHeader confirm-modal-header">
                                                <i class="glyphicon glyphicon glyphicon glyphicon-question-sign modal-icons"></i>
                                                <br />
                                                <h4 class="confirm-modal-title">Confirmation!</h4>
                                                <br />
                                                <span class="confirm-modal-msg">Data will override existing data. Are you sure you want to override data?</span>
                                            </div>
                                            <div class="modal-footer modalFooter modal-footer">
                                                <asp:Button runat="server" Text="Yes" ID="btnMachineLvlCopyConfirm" CssClass="confirm-modal-btn" OnClick="btnMachineLvlCopyConfirm_Click" ClientIDMode="Static" OnClientClick="btnMachineLvlCopyConfirmFun();" />
                                                <input type="button" value="No" data-dismiss="modal" class="confirm-modal-btn" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal fade" id="machineLvlDeleteConfirmModal" role="dialog">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content modalContent confirm-modal-content">
                                            <div class="modal-header modalHeader confirm-modal-header">
                                                <i class="glyphicon glyphicon glyphicon glyphicon-question-sign modal-icons"></i>
                                                <br />
                                                <h4 class="confirm-modal-title">Confirmation!</h4>
                                                <br />
                                                <span class="confirm-modal-msg">Are you sure you want to delete Records?</span>
                                            </div>
                                            <div class="modal-footer modalFooter modal-footer">
                                                <asp:Button runat="server" Text="Yes" ID="btnDeleteMachine" CssClass="confirm-modal-btn" OnClick="btnDeleteMachine_Click" OnClientClick="return clearModalScreen();" />
                                                <input type="button" value="No" data-dismiss="modal" class="confirm-modal-btn" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnMachineLvlView" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnMachineLvlSave" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnMachineLvlDelete" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnControllerLvl" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnModelLvl" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnMachineLvl" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>

        </div>

        <%--  </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnControllerLvl" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="btnMachineLvl" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="btnModelLvl" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>--%>
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
    <div class="modal fade" id="errorModal" role="dialog">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content modalContent error-modal-content">
                <div class="modal-header modalHeader error-modal-header">
                    <i class="glyphicon glyphicon-remove-sign modal-icons"></i>
                    <br />
                    <h4 class="error-modal-title">Error</h4>
                    <br />
                    <span class="error-modal-msg" id="lblErrorMsg">Reocrd insertion failed...</span>
                </div>
                <%-- <div class="modal-body">

</div>--%>
                <div class="modal-footer modalFooter modal-footer">
                    <input type="button" value="OK" class="error-modal-btn" data-dismiss="modal" />
                </div>
            </div>
        </div>
    </div>
    <script>
        // var submenu = "#processParamMenu0";
        var submenu = "";
        var bigControllerDiv = document.getElementById('gvControllerLvlContainer');
        var bigModelDiv = document.getElementById('gvMTBModelContainer');
        var bigMachineDiv = document.getElementById('gvMachineLvlContainer');
        $(document).ready(function () {
            //$("#processParamMenu0").addClass("in active");
            ////  $("#activeMenu").val("#processParamMenu0");
            //$("a[href$='#processParamMenu0']").removeClass("selected-menu-style").addClass("selected-Submenu");
            //$("a[href$='#processParamMenu0']").closest('li').find('i').addClass("arrow up");


            if (localStorage.getItem("selectedPPSubMenu")) {
                debugger;
                submenu = localStorage.getItem("selectedPPSubMenu");
            }
            $(submenu).addClass("in active");
            $("a[href$='" + submenu + "']").removeClass("selected-menu-style").addClass("selected-Submenu");
            $("a[href$='" + submenu + "']").closest('li').find('i').addClass("arrow up selected-Submenu-ArrowUp");

            setGridHeight();
        });
        $('.parameterValidation').keypress(function (evt) {
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode == 46 || charCode == 36) {
                return false;
            }
            return true;
        });
        function btnModelLvlCopyConfirmFun() {
            $('[id*=modelLvlCopyConfirmModal').modal('hide');
            $(".modal-backdrop").removeClass("modal-backdrop in");
            return true;
        }
        function btnMachineLvlCopyConfirmFun() {
            $('[id*=machineLvlCopyConfirmModal').modal('hide');
            $(".modal-backdrop").removeClass("modal-backdrop in");
            return true;
        }

        $('[id$=lbModelLvlCopyDistModel]').multiselect({
            includeSelectAllOption: true
        });
        $('[id$=lbMachineLvlCopyDistID]').multiselect({
            includeSelectAllOption: true
        });
        function openCopyModelLvlData() {
            $('[id*=copyModelLvlData]').modal('hide');
            $(".modal-backdrop").removeClass("modal-backdrop in");
            $('[id*=copyModelLvlData]').modal('show');
        }
        function openCopyMachineLvlData() {
            $('[id*=copyMachineLvlData]').modal('hide');
            $(".modal-backdrop").removeClass("modal-backdrop in");
            $('[id*=copyMachineLvlData]').modal('show');
        }
        function modelLvlCopyValidation() {
            debugger;
            var list = $('#lbModelLvlCopyDistModelTd ul li');
            var count = 0;
            for (var i = 0; i < list.length; i++) {
                if ($(list[i]).hasClass("active")) {
                    count++;
                }
            }
            if (count > 0) {
                $('[id*=modelLvlCopyConfirmModal').modal('show');
                return false;
            }
            else {
                openWarningModal("Plese select Machine Model.");
                return false;
            }
        }
        function mahineLvlCopyValidation() {
            debugger;
            var list = $('#lblMachineLvlCopySrcMachineIDTd ul li');
            var count = 0;
            for (var i = 0; i < list.length; i++) {
                if ($(list[i]).hasClass("active")) {
                    count++;
                }
            }
            if (count > 0) {
                $('[id*=machineLvlCopyConfirmModal').modal('show');
            }
            else {
                openWarningModal("Plese select Machine ID.");
            }
            return false;
        }
        function clearTheModalScreen() {
            $(".modal-backdrop").removeClass("modal-backdrop in");
            return true;
        }
        function scorllDown(gridDivID) {
            $("#" + gridDivID).animate({ scrollTop: $("#" + gridDivID)[0].scrollHeight }, 1000);
        }
        $('.allowStartWithChar').keypress(function (evt) {
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            var pos = evt.target.selectionStart;
            if (pos == 0) {
                if ((charCode >= 65 && charCode <= 90) || (charCode >= 97 && charCode <= 122)) {
                    return true;
                }
                else {
                    return false;
                }
            }
            else if (pos == 1) {
                if ((charCode >= 48 && charCode <= 57)) {
                    return true;
                }
                else {
                    return false;
                }
            }
            if (charCode == 46 && $(this).val().indexOf('.') != -1) {
                return false;
            }
            return true;
        });
        $('.allowNumber').keypress(function (evt) {
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            var pos = evt.target.selectionStart;
            if ((charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        });
        function showSuccessMsg(msg, title) {
            debugger;
            toastr.options = {
                "closeButton": true,
                "debug": false,
                "newestOnTop": false,
                "progressBar": true,
                "positionClass": "toast-top-right",
                "preventDuplicates": true,
                "onclick": null,
                "showDuration": "4000",
                "hideDuration": "1000",
                "timeOut": "4000",
                "extendedTimeOut": "1000",
                "showEasing": "swing",
                "hideEasing": "linear",
                "showMethod": "fadeIn",
                "hideMethod": "fadeOut"
            }

            toastr['success'](msg, title);
            return false;
        }
        function setActiveSubmenuValue() {
            debugger;
            localStorage.setItem("selectedPPSubMenu", "#processParamMenu0");
        }
        $('.decimalPt').keypress(function (evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            var pos = evt.target.selectionStart;
            debugger;
            if (charCode == 45 && pos != 0) {
                return false;
            } else if (charCode == 43 && pos != 0) {
                return false;
            } else if (charCode == 46 && $(this).val().indexOf('.') != -1) {
                return false;
            } else if (charCode > 31 && charCode != 46 && (charCode < 48 || charCode > 57) && charCode != 45 && charCode != 43) {
                return false;
            }
            var afterdecimalpt = $(this).val().split('.')[1];
            if (afterdecimalpt != undefined) {
                if (afterdecimalpt.length > 2) {
                    return false;
                }
            }
            return true;
        });
        bigControllerDiv.onscroll = function () {
            $('[id*=hdnScrollPos]').val(bigControllerDiv.scrollTop);
            console.log("id scroll =" + $('[id*=hdnScrollPos]').val());
        }
        bigModelDiv.onscroll = function () {
            $('[id*=hdnScrollPos]').val(bigModelDiv.scrollTop);
            console.log("id scroll =" + $('[id*=hdnScrollPos]').val());
        }
        bigMachineDiv.onscroll = function () {
            $('[id*=hdnScrollPos]').val(bigMachineDiv.scrollTop);
            console.log("id scroll =" + $('[id*=hdnScrollPos]').val());
        }
        window.onload = function () {
            bigControllerDiv.scrollTop = $('[id*=hdnScrollPos]').val();
            bigModelDiv.scrollTop = $('[id*=hdnScrollPos]').val();
            bigMachineDiv.scrollTop = $('[id*=hdnScrollPos]').val();
        }
        $(window).resize(function () {
            setGridHeight();
        });
        function setGridHeight() {
            var height = $(window).height() - 250;
            if (submenu == "#processParamMenu0" || submenu == "#processParamMenu1") {
                height = $(window).height() - 220;
            }
            else {
                height = $(window).height() - 260;
            }
            $('.gridContainer').css("height", height);
        }
        function clearModalScreen() {
            $(".modal-backdrop").removeClass("modal-backdrop in");
            return true;
        }
        function openDeleteConfirmModal(modalID, gridID) {
            debugger;
            var tbl = $('#' + gridID)[0];
            var noOfRow = tbl.rows.length;
            if (noOfRow > 1) {
                var noOfCheckedCount = 0;
                for (var i = 1; i < noOfRow; i++) {
                    var tr = tbl.rows[i];
                    var chk = $(tr).find("#chkDeleteSelection")[0];
                    if ($(chk).prop("checked")) {
                        noOfCheckedCount++;
                    }
                }
                if (noOfCheckedCount > 0) {
                    $('#' + modalID).modal("show");
                }
                else {
                    openWarningModal("Please select the record.");
                }
            }

            return false;
        }
        $('.pollingTypeSelect').change(function () {
            debugger;
            if ($(this).val() == "Read Based On Custom TimePeriod") {
                $(this).closest('tr').find('#ddlCycleFrequencyTimeNew').css('visibility', 'hidden');
                $(this).closest('tr').find('#ddlNoOfCycleNew').css('visibility', 'hidden');
            }
            else {
                $(this).closest('tr').find('#ddlCycleFrequencyTimeNew').css('visibility', 'visible');
                $(this).closest('tr').find('#ddlNoOfCycleNew').css('visibility', 'visible');
            }

        });
        $("[id$=gvControllerLvlData]").on("click", "td", function () {
            debugger;
            if ($(this).hasClass("innerTblTd")) {
                debugger;
                var innertbl = $(this).closest('table')
                $(innertbl).closest('tr').find('#hdnUpdate').val("updated");
                var tblID = $(innertbl).closest('table').prop('id');
                var tbl = document.getElementById("gvControllerLvlData");
                var tblRowCount = tbl.rows.length - 1;
                var currentTR = $(this).closest('tr');
                var currentClickRowIndex = $(currentTR).index();
                if (tblRowCount == currentClickRowIndex) {
                    return;
                }
            }
            else {
                $(this).closest('tr').find('#hdnUpdate').val("updated");
                var tblID = $(this).closest('table').prop('id');
                var tbl = document.getElementById(tblID);
                var tblRowCount = tbl.rows.length - 1;
                var currentTR = $(this).closest('tr');
                var currentClickRowIndex = $(currentTR).index();
                if (tblRowCount == currentClickRowIndex) {
                    return;
                }
            }

            $("[id$=gvControllerLvlData] tr:not(:last-child) td").find('input').removeClass("form-control");
            $("[id$=gvControllerLvlData] tr:not(:last-child) td").find('input').addClass("textboxcss");
            $("[id$=gvControllerLvlData] tr:not(:last-child) td").find('select').addClass("select");
            $("[id$=gvControllerLvlData] tr:not(:last-child) td").find('select').addClass("textboxcss");
            $("[id$=gvControllerLvlData] tr:not(:last-child) td").find('select').removeClass("form-control");

            $(this).closest('td').find('input').removeClass("textboxcss");
            $(this).closest('td').find('input').addClass("form-control");
            $(this).closest('td').find('select').addClass("form-control");
            $(this).closest('td').find('select').removeClass("textboxcss");
            $(this).closest('td').find('select').removeClass("select");



            $("[id$=gvControllerLvlData] tr:not(:last-child) td").find('input[type="checkbox"]').removeClass("form-control");
        });
        $("[id$=gvMTBModeldata]").on("click", "td", function () {
            debugger;
            if ($(this).hasClass("innerTblTd")) {
                debugger;
                var innertbl = $(this).closest('table')
                $(innertbl).closest('tr').find('#hdnUpdate').val("updated");
                var tblID = $(innertbl).closest('table').prop('id');
                var tbl = document.getElementById("gvMTBModeldata");
                var tblRowCount = tbl.rows.length - 1;
                var currentTR = $(this).closest('tr');
                var currentClickRowIndex = $(currentTR).index();
                if (tblRowCount == currentClickRowIndex) {
                    return;
                }
            }
            else {
                $(this).closest('tr').find('#hdnUpdate').val("updated");
                var tblID = $(this).closest('table').prop('id');
                var tbl = document.getElementById(tblID);
                var tblRowCount = tbl.rows.length - 1;
                var currentTR = $(this).closest('tr');
                var currentClickRowIndex = $(currentTR).index();
                if (tblRowCount == currentClickRowIndex) {
                    return;
                }
            }
            $("[id$=gvMTBModeldata] tr:not(:last-child) td").find('input').removeClass("form-control");
            $("[id$=gvMTBModeldata] tr:not(:last-child) td").find('input').addClass("textboxcss");
            $("[id$=gvMTBModeldata] tr:not(:last-child) td").find('select').addClass("select");
            $("[id$=gvMTBModeldata] tr:not(:last-child) td").find('select').addClass("textboxcss");
            $("[id$=gvMTBModeldata] tr:not(:last-child) td").find('select').removeClass("form-control");

            $(this).closest('td').find('input').removeClass("textboxcss");
            $(this).closest('td').find('input').addClass("form-control");
            $(this).closest('td').find('select').addClass("form-control");
            $(this).closest('td').find('select').removeClass("textboxcss");
            $(this).closest('td').find('select').removeClass("select");

            $("[id$=gvMTBModeldata] tr:not(:last-child) td").find('input[type="checkbox"]').removeClass("form-control");
        });
        $("[id$=gvMAchineLvlData]").on("click", "td", function () {
            debugger;
            if ($(this).hasClass("innerTblTd")) {
                debugger;
                var innertbl = $(this).closest('table')
                $(innertbl).closest('tr').find('#hdnUpdate').val("updated");
                var tblID = $(innertbl).closest('table').prop('id');
                var tbl = document.getElementById("gvMAchineLvlData");
                var tblRowCount = tbl.rows.length - 1;
                var currentTR = $(this).closest('tr');
                var currentClickRowIndex = $(currentTR).index();
                if (tblRowCount == currentClickRowIndex) {
                    return;
                }
            }
            else {
                $(this).closest('tr').find('#hdnUpdate').val("updated");
                var tblID = $(this).closest('table').prop('id');
                var tbl = document.getElementById(tblID);
                var tblRowCount = tbl.rows.length - 1;
                var currentTR = $(this).closest('tr');
                var currentClickRowIndex = $(currentTR).index();
                if (tblRowCount == currentClickRowIndex) {
                    return;
                }
            }
            $("[id$=gvMAchineLvlData] tr:not(:last-child) td").find('input').removeClass("form-control");
            $("[id$=gvMAchineLvlData] tr:not(:last-child) td").find('input').addClass("textboxcss");
            $("[id$=gvMAchineLvlData] tr:not(:last-child) td").find('select').addClass("select");
            $("[id$=gvMAchineLvlData] tr:not(:last-child) td").find('select').addClass("textboxcss");
            $("[id$=gvMAchineLvlData] tr:not(:last-child) td").find('select').removeClass("form-control");

            $(this).closest('td').find('input').removeClass("textboxcss");
            $(this).closest('td').find('input').addClass("form-control");
            $(this).closest('td').find('select').addClass("form-control");
            $(this).closest('td').find('select').removeClass("textboxcss");
            $(this).closest('td').find('select').removeClass("select");

            $("[id$=gvMAchineLvlData] tr:not(:last-child) td").find('input[type="checkbox"]').removeClass("form-control");
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

        $(".submenuData").click(function () {
            debugger;
            $('[id*=hdnScrollPos]').val(0);
            $.blockUI({ message: '<img runat="server" src="Images/Loading.gif" />' });
            if ($("#mainBody").hasClass("light-mode")) {
                //$(".submenuData").css("border-bottom", "unset");
                //$(".submenuData").css("color", "#000000ab");
                //$(".submenuData").closest('li').find('i').removeClass();

                //$(this).css("border-bottom", "3px solid #00669f");
                //$(this).css("background-color", "unset");
                //$(this).css("color", "#000000ab");
                $(".submenuData").removeClass("selected-menu-style selected-Submenu").addClass("other-menu-style");
                $(".submenuData").closest('li').find('i').removeClass();
                $(this).removeClass("other-menu-style selected-Submenu").addClass("selected-menu-style");
            } else {
                //$(".submenuData").css("border-bottom", "unset");
                //$(".submenuData").css("color", "white");
                //$(".submenuData").closest('li').find('i').removeClass();

                //$(this).css("border-bottom", "3px solid white");
                //$(this).css("background-color", "unset");
                //$(this).css("color", "white");
                $(".submenuData").removeClass("selected-menu-style selected-Submenu").addClass("other-menu-style");
                $(".submenuData").closest('li').find('i').removeClass();
                $(this).removeClass("other-menu-style selected-Submenu").addClass("selected-menu-style");
            }

            $(this).closest('li').find('i').addClass("arrow up selected-Submenu-ArrowUp");
            submenu = $(this).attr('href');
            $("#activeMenu").val(submenu);
            $(submenu).addClass("in active");
            if (submenu == "#processParamMenu1") {
                __doPostBack('<%= btnModelLvl.UniqueID%>', '');
            }
            else if (submenu == "#processParamMenu2") {
                __doPostBack('<%= btnMachineLvl.UniqueID%>', '');
            }
            else {
                __doPostBack('<%= btnControllerLvl.UniqueID%>', '');
            }
            localStorage.setItem("selectedPPSubMenu", submenu);
            // $("#menu0").removeClass("in active");
        });
        function showPanelFilter(element, panelid, rightvalue, topvalue, ulid) {
            let tblthlen = $(menu).find('table th');
            $('#' + ulid).empty();
            let appendString = "";
            for (let i = 0; i < $(tblthlen).length; i++) {
                appendString += "<li>" + $(tblthlen)[i].innerText + "</li>";
            }
            $('#' + ulid).append(appendString);
            document.getElementById(panelid).style.visibility = "visible";
            $("#" + panelid).css({ 'right': rightvalue, 'top': topvalue });
        }
        function openWarningModal(msg) {
            $('#warningModal').modal('show');
            $('#lblWarningMsg').text(msg);
        }
        function openErrorModal(msg) {
            $('#errorModal').modal('show');
            $('#lblErrorMsg').text(msg);
        }
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
            var bigControllerDiv = document.getElementById('gvControllerLvlContainer');
            var bigModelDiv = document.getElementById('gvMTBModelContainer');
            var bigMachineDiv = document.getElementById('gvMachineLvlContainer');
            $(document).ready(function () {
                //$(submenu).addClass("in active");
                ////  $("#activeMenu").val("#processParamMenu0");
                //// alert(submenu);
                //debugger;
                //$("a[href$='" + submenu + "']").removeClass("selected-menu-style").addClass("selected-Submenu");
                //$("a[href$='" + submenu + "']").closest('li').find('i').addClass("arrow up");
                if (localStorage.getItem("selectedPPSubMenu")) {
                    debugger;
                    submenu = localStorage.getItem("selectedPPSubMenu");
                }
                $(submenu).addClass("in active");
                $("a[href$='" + submenu + "']").removeClass("selected-menu-style").addClass("selected-Submenu");
                $("a[href$='" + submenu + "']").closest('li').find('i').addClass("arrow up selected-Submenu-ArrowUp");

                setGridHeight();
                bigControllerDiv.scrollTop = $('[id*=hdnScrollPos]').val();
                bigModelDiv.scrollTop = $('[id*=hdnScrollPos]').val();
                bigMachineDiv.scrollTop = $('[id*=hdnScrollPos]').val();
                $.unblockUI({});
            });
            $('.parameterValidation').keypress(function (evt) {
                var charCode = (evt.which) ? evt.which : evt.keyCode;
                if (charCode == 46 || charCode == 36) {
                    return false;
                }
                return true;
            });
            $('[id$=lbModelLvlCopyDistModel]').multiselect({
                includeSelectAllOption: true
            });
            $('[id$=lbMachineLvlCopyDistID]').multiselect({
                includeSelectAllOption: true
            });
            $('.allowNumber').keypress(function (evt) {
                var charCode = (evt.which) ? evt.which : evt.keyCode;
                var pos = evt.target.selectionStart;
                if ((charCode < 48 || charCode > 57)) {
                    return false;
                }
                return true;
            });
            $('.allowStartWithChar').keypress(function (evt) {
                var charCode = (evt.which) ? evt.which : evt.keyCode;
                var pos = evt.target.selectionStart;
                if (pos == 0) {
                    if ((charCode >= 65 && charCode <= 90) || (charCode >= 97 && charCode <= 122)) {
                        return true;
                    }
                    else {
                        return false;
                    }
                }
                else if (pos == 1) {
                    if ((charCode >= 48 && charCode <= 57)) {
                        return true;
                    }
                    else {
                        return false;
                    }
                }
                if (charCode == 46 && $(this).val().indexOf('.') != -1) {
                    return false;
                }
                return true;
            });
            $('.decimalPt').keypress(function (evt) {
                evt = (evt) ? evt : window.event;
                var charCode = (evt.which) ? evt.which : evt.keyCode;
                var pos = evt.target.selectionStart;
                debugger;
                if (charCode == 45 && pos != 0) {
                    return false;
                } else if (charCode == 43 && pos != 0) {
                    return false;
                } else if (charCode == 46 && $(this).val().indexOf('.') != -1) {
                    return false;
                } else if (charCode > 31 && charCode != 46 && (charCode < 48 || charCode > 57) && charCode != 45 && charCode != 43) {
                    return false;
                }
                var afterdecimalpt = $(this).val().split('.')[1];
                if (afterdecimalpt != undefined) {
                    if (afterdecimalpt.length > 2) {
                        return false;
                    }
                }
                return true;
            });
            bigControllerDiv.onscroll = function () {
                $('[id*=hdnScrollPos]').val(bigControllerDiv.scrollTop);
                console.log("id scroll =" + $('[id*=hdnScrollPos]').val());
            }
            bigModelDiv.onscroll = function () {
                $('[id*=hdnScrollPos]').val(bigModelDiv.scrollTop);
                console.log("id scroll =" + $('[id*=hdnScrollPos]').val());
            }
            bigMachineDiv.onscroll = function () {
                $('[id*=hdnScrollPos]').val(bigMachineDiv.scrollTop);
                console.log("id scroll =" + $('[id*=hdnScrollPos]').val());
            }
            window.onload = function () {
                bigControllerDiv.scrollTop = $('[id*=hdnScrollPos]').val();
                bigModelDiv.scrollTop = $('[id*=hdnScrollPos]').val();
                bigMachineDiv.scrollTop = $('[id*=hdnScrollPos]').val();
            }
            $('.pollingTypeSelect').change(function () {
                debugger;
                if ($(this).val() == "Read Based On Custom TimePeriod") {
                    $(this).closest('tr').find('#ddlCycleFrequencyTimeNew').css('visibility', 'hidden');
                    $(this).closest('tr').find('#ddlNoOfCycleNew').css('visibility', 'hidden');
                }
                else {
                    $(this).closest('tr').find('#ddlCycleFrequencyTimeNew').css('visibility', 'visible');
                    $(this).closest('tr').find('#ddlNoOfCycleNew').css('visibility', 'visible');
                }

            });
            $("[id$=gvControllerLvlData]").on("click", "td", function () {
                debugger;
                if ($(this).hasClass("innerTblTd")) {
                    debugger;
                    var innertbl = $(this).closest('table')
                    $(innertbl).closest('tr').find('#hdnUpdate').val("updated");
                    var tblID = $(innertbl).closest('table').prop('id');
                    var tbl = document.getElementById("gvControllerLvlData");
                    var tblRowCount = tbl.rows.length - 1;
                    var currentTR = $(this).closest('tr');
                    var currentClickRowIndex = $(currentTR).index();
                    if (tblRowCount == currentClickRowIndex) {
                        return;
                    }
                }
                else {
                    $(this).closest('tr').find('#hdnUpdate').val("updated");
                    var tblID = $(this).closest('table').prop('id');
                    var tbl = document.getElementById(tblID);
                    var tblRowCount = tbl.rows.length - 1;
                    var currentTR = $(this).closest('tr');
                    var currentClickRowIndex = $(currentTR).index();
                    if (tblRowCount == currentClickRowIndex) {
                        return;
                    }
                }

                $("[id$=gvControllerLvlData] tr:not(:last-child) td").find('input').removeClass("form-control");
                $("[id$=gvControllerLvlData] tr:not(:last-child) td").find('input').addClass("textboxcss");
                $("[id$=gvControllerLvlData] tr:not(:last-child) td").find('select').addClass("select");
                $("[id$=gvControllerLvlData] tr:not(:last-child) td").find('select').addClass("textboxcss");
                $("[id$=gvControllerLvlData] tr:not(:last-child) td").find('select').removeClass("form-control");

                $(this).closest('td').find('input').removeClass("textboxcss");
                $(this).closest('td').find('input').addClass("form-control");
                $(this).closest('td').find('select').addClass("form-control");
                $(this).closest('td').find('select').removeClass("textboxcss");
                $(this).closest('td').find('select').removeClass("select");

                $("[id$=gvControllerLvlData] tr:not(:last-child) td").find('input[type="checkbox"]').removeClass("form-control");
            });
            $("[id$=gvMTBModeldata]").on("click", "td", function () {
                debugger;
                if ($(this).hasClass("innerTblTd")) {
                    debugger;
                    var innertbl = $(this).closest('table')
                    $(innertbl).closest('tr').find('#hdnUpdate').val("updated");
                    var tblID = $(innertbl).closest('table').prop('id');
                    var tbl = document.getElementById("gvMTBModeldata");
                    var tblRowCount = tbl.rows.length - 1;
                    var currentTR = $(this).closest('tr');
                    var currentClickRowIndex = $(currentTR).index();
                    if (tblRowCount == currentClickRowIndex) {
                        return;
                    }
                }
                else {
                    $(this).closest('tr').find('#hdnUpdate').val("updated");
                    var tblID = $(this).closest('table').prop('id');
                    var tbl = document.getElementById(tblID);
                    var tblRowCount = tbl.rows.length - 1;
                    var currentTR = $(this).closest('tr');
                    var currentClickRowIndex = $(currentTR).index();
                    if (tblRowCount == currentClickRowIndex) {
                        return;
                    }
                }
                $("[id$=gvMTBModeldata] tr:not(:last-child) td").find('input').removeClass("form-control");
                $("[id$=gvMTBModeldata] tr:not(:last-child) td").find('input').addClass("textboxcss");
                $("[id$=gvMTBModeldata] tr:not(:last-child) td").find('select').addClass("select");
                $("[id$=gvMTBModeldata] tr:not(:last-child) td").find('select').addClass("textboxcss");
                $("[id$=gvMTBModeldata] tr:not(:last-child) td").find('select').removeClass("form-control");

                $(this).closest('td').find('input').removeClass("textboxcss");
                $(this).closest('td').find('input').addClass("form-control");
                $(this).closest('td').find('select').addClass("form-control");
                $(this).closest('td').find('select').removeClass("textboxcss");
                $(this).closest('td').find('select').removeClass("select");

                $("[id$=gvMTBModeldata] tr:not(:last-child) td").find('input[type="checkbox"]').removeClass("form-control");
            });
            $("[id$=gvMAchineLvlData]").on("click", "td", function () {
                debugger;
                if ($(this).hasClass("innerTblTd")) {
                    debugger;
                    var innertbl = $(this).closest('table')
                    $(innertbl).closest('tr').find('#hdnUpdate').val("updated");
                    var tblID = $(innertbl).closest('table').prop('id');
                    var tbl = document.getElementById("gvMAchineLvlData");
                    var tblRowCount = tbl.rows.length - 1;
                    var currentTR = $(this).closest('tr');
                    var currentClickRowIndex = $(currentTR).index();
                    if (tblRowCount == currentClickRowIndex) {
                        return;
                    }
                }
                else {
                    $(this).closest('tr').find('#hdnUpdate').val("updated");
                    var tblID = $(this).closest('table').prop('id');
                    var tbl = document.getElementById(tblID);
                    var tblRowCount = tbl.rows.length - 1;
                    var currentTR = $(this).closest('tr');
                    var currentClickRowIndex = $(currentTR).index();
                    if (tblRowCount == currentClickRowIndex) {
                        return;
                    }
                }
                $("[id$=gvMAchineLvlData] tr:not(:last-child) td").find('input').removeClass("form-control");
                $("[id$=gvMAchineLvlData] tr:not(:last-child) td").find('input').addClass("textboxcss");
                $("[id$=gvMAchineLvlData] tr:not(:last-child) td").find('select').addClass("select");
                $("[id$=gvMAchineLvlData] tr:not(:last-child) td").find('select').addClass("textboxcss");
                $("[id$=gvMAchineLvlData] tr:not(:last-child) td").find('select').removeClass("form-control");

                $(this).closest('td').find('input').removeClass("textboxcss");
                $(this).closest('td').find('input').addClass("form-control");
                $(this).closest('td').find('select').addClass("form-control");
                $(this).closest('td').find('select').removeClass("textboxcss");
                $(this).closest('td').find('select').removeClass("select");

                $("[id$=gvMAchineLvlData] tr:not(:last-child) td").find('input[type="checkbox"]').removeClass("form-control");
            });

            $(".submenuData").click(function () {
                debugger;
                $('[id*=hdnScrollPos]').val(0);
                $.blockUI({ message: '<img runat="server" src="Images/Loading.gif" />' });
                if ($("#mainBody").hasClass("light-mode")) {
                    //$(".submenuData").css("border-bottom", "unset");
                    //$(".submenuData").css("color", "#000000ab");
                    //$(".submenuData").closest('li').find('i').removeClass();

                    //$(this).css("border-bottom", "3px solid #00669f");
                    //$(this).css("background-color", "unset");
                    //$(this).css("color", "#000000ab");
                    $(".submenuData").removeClass("selected-menu-style selected-Submenu").addClass("other-menu-style");
                    $(".submenuData").closest('li').find('i').removeClass();
                    $(this).removeClass("other-menu-style selected-Submenu").addClass("selected-menu-style");
                } else {
                    //$(".submenuData").css("border-bottom", "unset");
                    //$(".submenuData").css("color", "white");
                    //$(".submenuData").closest('li').find('i').removeClass();

                    //$(this).css("border-bottom", "3px solid white");
                    //$(this).css("background-color", "unset");
                    //$(this).css("color", "white");
                    $(".submenuData").removeClass("selected-menu-style selected-Submenu").addClass("other-menu-style");
                    $(".submenuData").closest('li').find('i').removeClass();
                    $(this).removeClass("other-menu-style selected-Submenu").addClass("selected-menu-style");
                }

                $(this).closest('li').find('i').addClass("arrow up selected-Submenu-ArrowUp");
                submenu = $(this).attr('href');
                $("#activeMenu").val(submenu);
                $(submenu).addClass("in active");
                // $("#menu0").removeClass("in active");
                if (submenu == "#processParamMenu1") {
                    __doPostBack('<%= btnModelLvl.UniqueID%>', '');
                }
                else if (submenu == "#processParamMenu2") {
                    __doPostBack('<%= btnMachineLvl.UniqueID%>', '');
                }
                else {
                    __doPostBack('<%= btnControllerLvl.UniqueID%>', '');
                }
                localStorage.setItem("selectedPPSubMenu", submenu);
            });
            function openWarningModal(msg) {
                $('#warningModal').modal('show');
                $('#lblWarningMsg').text(msg);
            }
            function openErrorModal(msg) {
                $('#errorModal').modal('show');
                $('#lblErrorMsg').text(msg);
            }
        });
    </script>

</asp:Content>
