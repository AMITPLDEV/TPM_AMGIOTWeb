<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MachineDocumentMaster.aspx.cs" Inherits="NewProject.MachineDocumentMaster" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <link href="Scripts/MultiSelectDropdown/bootstrap-multiselect.css" rel="stylesheet" />
    <script src="Scripts/MultiSelectDropdown/bootstrap-multiselect.js"></script>
    <script src="Scripts/DateTimePicker/bootstrap-datepicker.js"></script>
    <link href="Scripts/DateTimePicker/bootstrap-datepicker3.css" rel="stylesheet" />

    <script src="Scripts/DateTimePicker/bootstrap-datepicker.en-IE.min.js"></script>
    <script src="Scripts/DateTimePicker/bootstrap-datepicker.zh-CN.min.js"></script>

    <style>
        .gridContainer {
            overflow: auto;
            margin-top: 5px;
        }

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

        .light-mode .multiselect-container label {
            color: black !important;
        }

        .light-mode .multiselect span {
            color: black !important;
        }

        .link-button-style {
            color: #0588f8;
        }

        .light-mode .P1Table tr td a {
            color: #0588f8 !important;
        }

        .P1Table select {
            width: auto;
        }

        #machineDocContainer .P1Table tr th:last-child, #machineDocContainer .P1Table tr td:last-child {
            position: sticky;
            right: 0px;
        }

        #machineDocContainer .P1Table tr td:last-child {
            background-color: #373a3c;
        }

        .light-mode #machineDocContainer .P1Table tr td:last-child {
            background-color: #f9f7f7;
        }

        #machineDocContainer .P1Table tr:hover td:last-child {
            /*opacity: 1;*/
        }

        .P1Table tr th, .light-mode .P1Table tr th {
            z-index: 10;
        }

        #machineDocContainer i {
            width: 5%;
            font-size: 18px;
        }

        #machineDocContainer input[type="file"] {
            width: 90%;
        }

        .rotateImage {
            transform: rotate(180deg);
        }

        .P1Table tr th a {
            color: white;
        }

        .P1Table tr th a {
            color: white;
        }

        .light-mode .P1Table tr th a {
            color: black;
        }
    </style>

    <div style="margin-top: 100px" class="themetoggle">
        <%--  <asp:UpdatePanel runat="server" >
            <ContentTemplate>--%>
        <asp:HiddenField runat="server" ID="hdnSubmenu" ClientIDMode="Static" />
        <div style="margin-top: 5px">
            <div class="navbar-collapse collapse" style="height: 42px !important;">
                <ul class="nav navbar-nav nextPrevious submenus-style">
                    <li><a runat="server" class="submenuData" id="A1" clientidmode="static" data-toggle="tab" href="#companyLvlMenu">MTB Level</a>
                        <i></i>
                    </li>
                    <li><a runat="server" class="submenuData" id="A15" clientidmode="static" data-toggle="tab" href="#modelLvlMenu">Model Level</a>
                        <i></i>
                    </li>
                    <li><a runat="server" class="submenuData" id="A16" clientidmode="static" data-toggle="tab" href="#machineLvlMenu">Machine Level</a>
                        <i></i>
                    </li>
                </ul>
                <div style="display: none">
                    <asp:Button runat="server" ID="btnCompanyLevel" OnClick="btnCompanyLevel_Click" />
                    <asp:Button runat="server" ID="btnModelLevel" OnClick="btnModelLevel_Click" />
                    <asp:Button runat="server" ID="btnMachineLevel" OnClick="btnMachineLevel_Click" />
                </div>
            </div>
            <div class="tab-content themetoggle" id="machineDocContainer" style="overflow: auto; width: 100%; margin: -10px auto;">
                <div id="companyLvlMenu" class="tab-pane fade">
                    <div>
                        <%-- <asp:UpdatePanel runat="server">
                            <ContentTemplate>--%>
                         <fieldset class="field-set">
                                <legend>&nbsp;<b>Filter By</b></legend>
                        <table class="filterTbl filter-field-table">
                            <tr>
                                <td>MTB&nbsp;</td>
                                <td>
                                    <asp:DropDownList runat="server" ID="ddlMTBCompanyLvl" CssClass="form-control" ClientIDMode="Static">
                                    </asp:DropDownList></td>

                                
                                <td>
                        <asp:Button runat="server" ID="btnViewCompanyLvl" Text="View" CssClass="Btns" OnClick="btnViewCompanyLvl_Click" OnClientClick="return showLoader();"/>
                        <asp:Button runat="server" ID="btnSaveCompanyLvl" Text="Save" CssClass="Btns" OnClick="btnSaveCompanyLvl_Click" OnClientClick="return showLoader();"/>
                        <asp:Button runat="server" ID="btnDeleteCompanyLvl" Text="Delete" CssClass="Btns" OnClientClick="return openDeleteConfirmModal('mtbLvlDeleteConfirmModal','gvCompanyLevel');" /></td>
                            </tr>
                        </table>
                              </fieldset>
                        <%-- </ContentTemplate>
                            <Triggers>
                                 <asp:PostBackTrigger ControlID="gvCompanyLevel"/>
                            </Triggers>
                        </asp:UpdatePanel>--%>
                    </div>
                    <div id="gvMTBModelContainer1" class="gridContainer">
                        <%-- <asp:UpdatePanel runat="server">
                            <ContentTemplate>--%>
                        <asp:GridView ID="gvCompanyLevel" runat="server" AutoGenerateColumns="false" Width="100%" EmptyDataText="No Data Found." ShowHeaderWhenEmpty="true" ShowHeader="true" ShowFooter="true" ClientIDMode="Static" CssClass="P1Table" AllowSorting="True" DataKeyNames="UpdatedTS" OnSorting="gvCompanyLevel_Sorting" CurrentSortField="UpdatedTS" CurrentSortDirection="ASC" OnRowCreated="gvCompanyLevel_RowCreated">
                            <Columns>
                                <asp:TemplateField HeaderText="CNC Make">
                                    <ItemTemplate>
                                        <asp:HiddenField runat="server" ID="hdnMTB" ClientIDMode="Static" Value='<%# Eval("MTB") %>'></asp:HiddenField>
                                        <asp:Label runat="server" ID="lblCNCMake" ClientIDMode="Static" Text='<%# Eval("CNCMake") %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:DropDownList ID="ddlCNCMakeNew" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlCNCMakeNewMTBLvl_SelectedIndexChanged" ClientIDMode="Static">
                                        </asp:DropDownList>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="CNC Model">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblCNCModel" ClientIDMode="Static" Text='<%# Eval("CNCModel") %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:DropDownList ID="ddlCNCModelNew" runat="server" CssClass="form-control" ClientIDMode="Static">
                                        </asp:DropDownList>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Category">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblCategory" ClientIDMode="Static" Text='<%# Eval("Category") %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:DropDownList ID="ddlCategoryNew" runat="server" CssClass="form-control" ClientIDMode="Static">
                                            <asp:ListItem>CNC Document</asp:ListItem>
                                            <asp:ListItem>Ele& Mech</asp:ListItem>
                                            <asp:ListItem>Ele-Design</asp:ListItem>
                                            <asp:ListItem>CNC</asp:ListItem>
                                            <asp:ListItem>MTB-Application</asp:ListItem>
                                        </asp:DropDownList>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Sub Category">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblSubCategory" ClientIDMode="Static" Text='<%# Eval("Subcategory") %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:DropDownList ID="ddlSubCategoryNew" runat="server" CssClass="form-control" ClientIDMode="Static">
                                            <asp:ListItem>Fanuc/Siemens/Mitsubishi/Control supplier manuals as applicable for Users</asp:ListItem>
                                            <asp:ListItem>Operation and Maintenance Manual</asp:ListItem>
                                            <asp:ListItem>Connection Manual</asp:ListItem>
                                            <asp:ListItem>Application Manual</asp:ListItem>
                                            <asp:ListItem>Quick Start Installation and Commissioning Guide</asp:ListItem>
                                        </asp:DropDownList>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <%--  <asp:TemplateField HeaderText="Customer Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCustomerName" runat="server" Text='<%# Eval("CustomerName") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox runat="server" ID="txtCustomerNameNew" CssClass="form-control"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>--%>
                                <%--  <asp:TemplateField HeaderText="Date of Dispatch">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDateOfDispatch" runat="server" Text='<%# Eval("DateOfDispatchInString") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox runat="server" ID="txtDateOfDispatchNew" CssClass="form-control"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>--%>
                                <asp:TemplateField HeaderText="Version">
                                    <ItemTemplate>
                                        <asp:Label ID="lblVersion" runat="server" Text='<%# Eval("Version") %>' ClientIDMode="Static"></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox runat="server" ID="txtVersionNew" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="File Name">
                                    <ItemTemplate>
                                        <asp:HiddenField runat="server" ID="hdnCollectionName" ClientIDMode="Static" Value='<%# Eval("CollectionName") %>' />
                                        <asp:HiddenField runat="server" ID="hdnFileID" ClientIDMode="Static" Value='<%# Eval("FileID") %>' />
                                        <asp:HiddenField runat="server" ID="hdnFileName" ClientIDMode="Static" Value='<%# Eval("Filename") %>' />
                                        <asp:LinkButton runat="server" ID="lnkFilename" Text='<%# Eval("Filename") %>' OnClientClick="return showFileDetails(this,'MTB');" ToolTip='<%# Eval("Filename") %>'></asp:LinkButton>
                                        <br />
                                        <asp:FileUpload runat="server" ID="fileUpload" CssClass="form-control" ClientIDMode="Static" onchange="setClearIcon(this)" Style="display: inline-block" />

                                        <i id="clearFile" class="glyphicon glyphicon-remove" style="color: red; visibility: hidden; display: inline-block" onclick="clearFileUploadData(this,'fileUpload')"></i>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:FileUpload ID="fileUploddNew" runat="server" CssClass="form-control" ClientIDMode="Static" onchange="setClearIcon(this)" Style="display: inline-block" />
                                        <i id="clearFile" class="glyphicon glyphicon-remove" style="color: red; visibility: hidden; display: inline-block" onclick="clearFileUploadData(this,'fileUploddNew')"></i>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Updated By">
                                    <ItemTemplate>
                                        <asp:Label ID="lblUpdatedBy" runat="server" Text='<%# Eval("UpdatedBy") %>' ClientIDMode="Static"></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Updated TS" SortExpression="UpdatedTS">
                                    <ItemTemplate>
                                        <asp:Label ID="lblUpdatedTS" runat="server" Text='<%# Eval("UpdatedTS") %>' ClientIDMode="Static"></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                  <%--<asp:TemplateField HeaderText="Level">
                                    <ItemTemplate>
                                        <asp:Label ID="lblLevel" runat="server" Text='<%# Eval("Level") %>' ClientIDMode="Static"></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                    </FooterTemplate>
                                </asp:TemplateField>--%>
                                <asp:TemplateField HeaderText="Delete">
                                    <ItemTemplate>
                                        <asp:CheckBox runat="server" ID="chkDeleteSelection" ClientIDMode="Static" />
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Button runat="server" ID="btnInsertCompanyLvl" Text="Add" CssClass="Btns" ClientIDMode="Static" OnClientClick="return checkModelLvlInsertValidation(this);" OnClick="btnInsertCompanyLvl_Click" />
                                    </FooterTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <%-- </ContentTemplate>
                            <Triggers>
                              <asp:PostBackTrigger ControlID="gvCompanyLevel"/>
                                <asp:AsyncPostBackTrigger ControlID="btnViewCompanyLvl" EventName="Click" />
                                   <asp:AsyncPostBackTrigger ControlID="btnSaveCompanyLvl" EventName="Click" />
                                   <asp:AsyncPostBackTrigger ControlID="btnDeleteCompanyLvl" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>--%>
                    </div>
                </div>
                <div id="modelLvlMenu" class="tab-pane fade">
                    <div>
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                     <fieldset class="field-set">
                                <legend>&nbsp;<b>Filter By</b></legend>
                                <table class="filterTbl filter-field-table">
                                    <tr>
                                        <td>MTB&nbsp;</td>
                                        <td>
                                            <asp:DropDownList runat="server" ID="ddlMTBModelLvl" CssClass="form-control" OnSelectedIndexChanged="ddlMTBModelLvl_SelectedIndexChanged" AutoPostBack="true" ClientIDMode="Static">
                                            </asp:DropDownList></td>
                                        <td>&nbsp;&nbsp;Machine Model&nbsp;</td>
                                        <td>
                                            <asp:DropDownList runat="server" ID="ddlMachineModelModelLvl" CssClass="form-control" ClientIDMode="Static">
                                            </asp:DropDownList>
                                            <%--   <asp:ListBox ID="lbMachineModelModelLvl" runat="server" SelectionMode="Multiple" ClientIDMode="Static" Style="width: 150px; color: black !important" CssClass="dropdown-list form-control">
                                                <asp:ListItem>M1</asp:ListItem>
                                                <asp:ListItem>M2</asp:ListItem>
                                                <asp:ListItem>M3</asp:ListItem>
                                                <asp:ListItem>M4</asp:ListItem>
                                                <asp:ListItem>M5</asp:ListItem>
                                                <asp:ListItem>M6</asp:ListItem>
                                            </asp:ListBox>--%>
                                        </td>

                                          <td>&nbsp;&nbsp;View&nbsp;</td>
                                        <td>
                                            <asp:DropDownList runat="server" ID="ddlModelLevelView" CssClass="form-control">
                                                 <asp:ListItem Value="All">All</asp:ListItem>
                                                 <asp:ListItem Value="MTB">MTB</asp:ListItem>
                                                <asp:ListItem Value="Model">Model</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                        <asp:Button runat="server" ID="btnViewModelLvl" Text="View" CssClass="Btns" OnClick="btnViewModelLvl_Click"  OnClientClick="return showLoader();"/>
                        <asp:Button runat="server" ID="btnSaveModelLvl" Text="Save" CssClass="Btns" OnClick="btnSaveModelLvl_Click" OnClientClick="return showLoader();"/>
                        <asp:Button runat="server" Text="Delete" CssClass="Btns" OnClientClick="return openDeleteConfirmModal('modelLvlDeleteConfirmModal','gvModelLvlData');" /></td>
                                    </tr>
                                </table>
                                          </fieldset>
                            </ContentTemplate>
                            <Triggers>
                                <asp:PostBackTrigger ControlID="btnViewModelLvl" />
                                 <asp:PostBackTrigger ControlID="btnSaveModelLvl" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>

                    <div id="gvModelLvlDataContainer" class="gridContainer">

                        <asp:GridView ID="gvModelLvlData" runat="server" AutoGenerateColumns="false" Width="100%" EmptyDataText="No Data Found." ShowHeaderWhenEmpty="true" ShowHeader="true" ShowFooter="true" ClientIDMode="Static" CssClass="P1Table" OnRowDataBound="gvModelLvlData_RowDataBound" AllowSorting="True" DataKeyNames="UpdatedTS" OnSorting="gvModelLvlData_Sorting" CurrentSortField="UpdatedTS" CurrentSortDirection="ASC" OnRowCreated="gvModelLvlData_RowCreated">
                            <Columns>
                                <asp:TemplateField HeaderText="CNC Make">
                                    <ItemTemplate>
                                        <asp:HiddenField runat="server" ID="hdnUpdate" ClientIDMode="Static" />
                                        <asp:HiddenField runat="server" ID="hdnMTB" ClientIDMode="Static" Value='<%# Eval("MTB") %>'></asp:HiddenField>
                                        <asp:Label runat="server" ID="lblCNCMake" ClientIDMode="Static" Text='<%# Eval("CNCMake") %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:HiddenField runat="server" ID="hdnSelectedCNCMake" ClientIDMode="Static" />
                                        <asp:DropDownList ID="ddlCNCMakeNew" runat="server" CssClass="form-control" ClientIDMode="Static" onchange="ddlCNCMakeChange(this,'gvModelLvlData');">
                                        </asp:DropDownList>
                                        <%--AutoPostBack="true"  OnSelectedIndexChanged="ddlCNCMakeNewModelLvl_SelectedIndexChanged"--%>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="CNC Model">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblCNCModel" ClientIDMode="Static" Text='<%# Eval("CNCModel") %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:HiddenField runat="server" ID="hdnSelectedCNCModel" ClientIDMode="Static" />
                                        <asp:DropDownList ID="ddlCNCModelNew" runat="server" CssClass="form-control" onchange="ddlCNCModelChange(this,'gvModelLvlData');" ClientIDMode="Static">
                                            <%--AutoPostBack="true" OnSelectedIndexChanged="ddlCNCModelNewModelLvl_SelectedIndexChanged"--%>
                                        </asp:DropDownList>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Machine Type">
                                    <ItemTemplate>
                                        <%-- <asp:Label runat="server" ID="lblMachineType" ClientIDMode="Static" Text='<%# Eval("MachineType") %>'></asp:Label>--%>
                                        <asp:HiddenField runat="server" ID="hdnMachineType" ClientIDMode="Static" Value='<%# Eval("MachineType") %>' />
                                        <asp:HiddenField runat="server" ID="hdnSelectedMachineType" ClientIDMode="Static" Value='<%# Eval("MachineType") %>' />
                                        <asp:DropDownList ID="ddlMachineType" runat="server" CssClass="form-control textboxcss select" onchange="ddlMachineTypeChange(this,'gvModelLvlData','update');" ClientIDMode="Static"></asp:DropDownList>
                                        <%-- OnSelectedIndexChanged="ddlMachineTypeModelLvl_SelectedIndexChanged" --%>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:HiddenField runat="server" ID="hdnSelectedMachineType" ClientIDMode="Static" />
                                        <asp:DropDownList ID="ddlMachineType" runat="server" CssClass="form-control" onchange="ddlMachineTypeChange(this,'gvModelLvlData','insert');" ClientIDMode="Static"></asp:DropDownList>
                                        <%-- AutoPostBack="true" OnSelectedIndexChanged="ddlMachineTypeNewModelLvl_SelectedIndexChanged"--%>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Machine Model">
                                    <ItemTemplate>
                                        <%--  <asp:Label runat="server" ID="lblMachineModel" ClientIDMode="Static" Text='<%# Eval("MachineModel") %>'></asp:Label>--%>
                                        <asp:HiddenField runat="server" ID="hdnMachineModel" ClientIDMode="Static" Value='<%# Eval("MachineModel") %>' />
                                        <asp:HiddenField runat="server" ID="hdnSelectedMachineModel" ClientIDMode="Static" Value='<%# Eval("MachineModel") %>' />
                                        <asp:DropDownList ID="ddlMachineModel" runat="server" CssClass="form-control textboxcss select" ClientIDMode="Static" onchange="ddlMachineModelChangeSetHdnValue(this,'gvModelLvlData','update');">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:HiddenField runat="server" ID="hdnSelectedMachineModel" ClientIDMode="Static" />
                                        <asp:DropDownList ID="ddlMachineModel" runat="server" CssClass="form-control" ClientIDMode="Static" onchange="ddlMachineModelChangeSetHdnValue(this,'gvModelLvlData','insert');">
                                        </asp:DropDownList>
                                    </FooterTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Category">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblCategory" ClientIDMode="Static" Text='<%# Eval("Category") %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:DropDownList ID="ddlCategoryNew" runat="server" CssClass="form-control" ClientIDMode="Static">
                                            <asp:ListItem>CNC Document</asp:ListItem>
                                            <asp:ListItem>Ele& Mech</asp:ListItem>
                                            <asp:ListItem>Ele-Design</asp:ListItem>
                                            <asp:ListItem>CNC</asp:ListItem>
                                            <asp:ListItem>MTB-Application</asp:ListItem>
                                        </asp:DropDownList>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Sub Category">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblSubCategory" ClientIDMode="Static" Text='<%# Eval("Subcategory") %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:DropDownList ID="ddlSubCategoryNew" runat="server" CssClass="form-control" ClientIDMode="Static">
                                            <asp:ListItem>Fanuc/Siemens/Mitsubishi/Control supplier manuals as applicable for Users</asp:ListItem>
                                            <asp:ListItem>Operation and Maintenance Manual</asp:ListItem>
                                            <asp:ListItem>Connection Manual</asp:ListItem>
                                            <asp:ListItem>Application Manual</asp:ListItem>
                                            <asp:ListItem>Quick Start Installation and Commissioning Guide</asp:ListItem>
                                        </asp:DropDownList>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <%--   <asp:TemplateField HeaderText="Customer Name">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCustomerName" runat="server" Text='<%# Eval("CustomerName") %>' ClientIDMode="Static"></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox runat="server" ID="txtCustomerNameNew" CssClass="form-control"></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>--%>
                                <%--   <asp:TemplateField HeaderText="Date of Dispatch">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDateOfDispatch" runat="server" Text='<%# Eval("DateOfDispatchInString") %>' ClientIDMode="Static"></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox runat="server" ID="txtDateOfDispatchNew" CssClass="form-control"></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>--%>
                                <asp:TemplateField HeaderText="Version">
                                    <ItemTemplate>
                                        <asp:Label ID="lblVersion" runat="server" Text='<%# Eval("Version") %>' ClientIDMode="Static"></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox runat="server" ID="txtVersionNew" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="File Name">
                                    <ItemTemplate>
                                        <asp:HiddenField runat="server" ID="hdnCollectionName" ClientIDMode="Static" Value='<%# Eval("CollectionName") %>' />
                                        <asp:HiddenField runat="server" ID="hdnFileID" ClientIDMode="Static" Value='<%# Eval("FileID") %>' />
                                        <asp:HiddenField runat="server" ID="hdnFileName" ClientIDMode="Static" Value='<%# Eval("Filename") %>' />
                                        <asp:HiddenField runat="server" ID="hdnFileType" ClientIDMode="Static" Value='<%# Eval("FileType") %>' />
                                        <asp:LinkButton runat="server" ID="lnkFilename" Text='<%# Eval("Filename") %>' OnClientClick="return showFileDetails(this,'Model');" ToolTip='<%# Eval("Filename") %>'></asp:LinkButton>
                                        <br />
                                        <asp:FileUpload runat="server" ID="fileUpload" CssClass="form-control" ClientIDMode="Static" onchange="setClearIcon(this)" Style="display: inline-block" />
                                        <i id="clearFile" class="glyphicon glyphicon-remove" style="color: red; visibility: hidden; display: inline-block" onclick="clearFileUploadData(this,'fileUpload')"></i>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:FileUpload ID="fileUploddNew" runat="server" CssClass="form-control" ClientIDMode="Static" onchange="setClearIcon(this)" Style="display: inline-block" />
                                        <i id="clearFile" class="glyphicon glyphicon-remove" style="color: red; visibility: hidden; display: inline-block" onclick="clearFileUploadData(this,'fileUploddNew')"></i>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Updated By">
                                    <ItemTemplate>
                                        <asp:Label ID="lblUpdatedBy" runat="server" Text='<%# Eval("UpdatedBy") %>' ClientIDMode="Static"></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Updated TS" SortExpression="UpdatedTS">
                                    <ItemTemplate>
                                        <asp:Label ID="lblUpdatedTS" runat="server" Text='<%# Eval("UpdatedTS") %>' ClientIDMode="Static"></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                 <asp:TemplateField HeaderText="Level">
                                    <ItemTemplate>
                                        <asp:Label ID="lblLevel" runat="server" Text='<%# Eval("Level") %>' ClientIDMode="Static"></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Delete">
                                    <ItemTemplate>
                                        <asp:CheckBox runat="server" ID="chkDeleteSelection" ClientIDMode="Static" />
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Button runat="server" ID="btnInsertModelLvl" Text="Add" CssClass="Btns" ClientIDMode="Static" OnClientClick="return checkModelLvlInsertValidation(this);" OnClick="btnInsertModelLvl_Click" />
                                    </FooterTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>

                    </div>
                </div>
                <div id="machineLvlMenu" class="tab-pane fade">
                    <div>
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                 <fieldset class="field-set">
                                <legend>&nbsp;<b>Filter By</b></legend>
                                <table class="filterTbl filter-field-table"> 
                                    <tr>
                                        <td>MTB&nbsp;</td>
                                        <td>
                                            <asp:DropDownList runat="server" ID="ddlMTBMachineLvl" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlMTBMachineLvl_SelectedIndexChanged" ClientIDMode="Static">
                                            </asp:DropDownList></td>
                                        <td>&nbsp;&nbsp;Machine Model&nbsp;</td>
                                        <td>
                                            <asp:DropDownList runat="server" ID="ddlMachineModelMachineLvl" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlMachineModelMachineLvl_SelectedIndexChanged" ClientIDMode="Static">
                                            </asp:DropDownList></td>
                                        <td>&nbsp;&nbsp;Machine Slno&nbsp;</td>
                                        <td>
                                            <asp:DropDownList runat="server" ID="ddlMachineSlnoMachineLvl" CssClass="form-control" ClientIDMode="Static">
                                            </asp:DropDownList></td>
                                         <td>&nbsp;&nbsp;View&nbsp;</td>
                                        <td>
                                            <asp:DropDownList runat="server" ID="ddlMachineLevelView" CssClass="form-control">
                                                 <asp:ListItem Value="All">All</asp:ListItem>
                                                 <asp:ListItem Value="MTB">MTB</asp:ListItem>
                                                <asp:ListItem Value="Model">Model</asp:ListItem>
                                                 <asp:ListItem Value="Machine">Machine</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                        <asp:Button runat="server" ID="btnViewMachineLvl" Text="View" CssClass="Btns" OnClick="btnViewMachineLvl_Click" OnClientClick="return showLoader();"/>
                        <asp:Button runat="server" ID="btnSaveMachineLvl" Text="Save" CssClass="Btns" OnClick="btnSaveMachineLvl_Click" OnClientClick="return showLoader();" />
                        <asp:Button runat="server" ID="btnDeleteMachineLvl" Text="Delete" CssClass="Btns" OnClientClick="return openDeleteConfirmModal('machineLvlDeleteConfirmModal','gvMachineLvlData');" /></td>
                                    </tr>
                                </table>
                                      </fieldset>
                                </ContentTemplate>
                            <Triggers>
                                <asp:PostBackTrigger ControlID="btnViewMachineLvl" />
                                  <asp:PostBackTrigger ControlID="btnSaveMachineLvl" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                    <div id="gvMachineLvlContainer" class="gridContainer">
                        <asp:GridView ID="gvMachineLvlData" runat="server" AutoGenerateColumns="false" Width="100%" EmptyDataText="No Data Found." ShowHeaderWhenEmpty="true" ShowHeader="true" ShowFooter="true" ClientIDMode="Static" CssClass="P1Table" OnRowDataBound="gvMachineLvlData_RowDataBound" AllowSorting="True" DataKeyNames="UpdatedTS" OnSorting="gvMachineLvlData_Sorting" CurrentSortField="UpdatedTS" CurrentSortDirection="ASC" OnRowCreated="gvMachineLvlData_RowCreated">
                            <Columns>
                                <asp:TemplateField HeaderText="CNC Make">
                                    <ItemTemplate>
                                        <asp:HiddenField runat="server" ID="hdnUpdate" ClientIDMode="Static" />
                                        <asp:HiddenField runat="server" ID="hdnMTB" ClientIDMode="Static" Value='<%# Eval("MTB") %>'></asp:HiddenField>
                                        <asp:Label runat="server" ID="lblCNCMake" ClientIDMode="Static" Text='<%# Eval("CNCMake") %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:HiddenField runat="server" ID="hdnSelectedCNCMake" ClientIDMode="Static" />
                                        <asp:DropDownList ID="ddlCNCMakeNew" runat="server" CssClass="form-control" ClientIDMode="Static" onchange="ddlCNCMakeChange(this,'gvMachineLvlData');">
                                            <%--AutoPostBack="true" OnSelectedIndexChanged="ddlCNCMakeNewMachineLvl_SelectedIndexChanged"--%>
                                        </asp:DropDownList>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="CNC Model">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblCNCModel" ClientIDMode="Static" Text='<%# Eval("CNCModel") %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:HiddenField runat="server" ID="hdnSelectedCNCModel" ClientIDMode="Static" />
                                        <asp:DropDownList ID="ddlCNCModelNew" runat="server" CssClass="form-control" onchange="ddlCNCModelChange(this,'gvMachineLvlData');" ClientIDMode="Static"></asp:DropDownList>
                                        <%--AutoPostBack="true" OnSelectedIndexChanged="ddlCNCModelNewMachineLvl_SelectedIndexChanged"--%>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Machine Type">
                                    <ItemTemplate>
                                        <%--  <asp:Label runat="server" ID="lblMachineType" ClientIDMode="Static" Text='<%# Eval("MachineType") %>'></asp:Label>--%>
                                        <asp:HiddenField runat="server" ID="hdnMachineType" ClientIDMode="Static" Value='<%# Eval("MachineType") %>' />
                                        <asp:HiddenField runat="server" ID="hdnSelectedMachineType" ClientIDMode="Static" Value='<%# Eval("MachineType") %>' />
                                        <asp:DropDownList ID="ddlMachineType" runat="server" CssClass="form-control textboxcss select" onchange="ddlMachineTypeChange(this,'gvMachineLvlData','update');" ClientIDMode="Static"></asp:DropDownList>
                                        <%--      AutoPostBack="true" OnSelectedIndexChanged="ddlMachineTypeMachineLvl_SelectedIndexChanged"--%>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:HiddenField runat="server" ID="hdnSelectedMachineType" ClientIDMode="Static" />
                                        <asp:DropDownList ID="ddlMachineType" runat="server" CssClass="form-control" onchange="ddlMachineTypeChange(this,'gvMachineLvlData','insert');" ClientIDMode="Static">
                                            <%--AutoPostBack="true" OnSelectedIndexChanged="ddlMachineTypeNewMachineLvl_SelectedIndexChanged"--%>
                                        </asp:DropDownList>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Machine Model">
                                    <ItemTemplate>
                                        <%-- <asp:Label runat="server" ID="lblMachineModel" ClientIDMode="Static" Text='<%# Eval("MachineModel") %>'></asp:Label>--%>
                                        <asp:HiddenField runat="server" ID="hdnMachineModel" ClientIDMode="Static" Value='<%# Eval("MachineModel") %>' />
                                        <asp:HiddenField runat="server" ID="hdnSelectedMachineModel" ClientIDMode="Static" Value='<%# Eval("MachineModel") %>' />
                                        <asp:DropDownList ID="ddlMachineModel" runat="server" CssClass="form-control textboxcss select" onchange="ddlMachineModelChange(this,'gvMachineLvlData');" ClientIDMode="Static"></asp:DropDownList>
                                        <%-- AutoPostBack="true" OnSelectedIndexChanged="ddlMachineModelMachineLvlUpdate_SelectedIndexChanged"--%>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:HiddenField runat="server" ID="hdnSelectedMachineModel" ClientIDMode="Static" />
                                        <asp:DropDownList ID="ddlMachineModel" runat="server" CssClass="form-control" onchange="ddlMachineModelChange(this,'gvMachineLvlData');" ClientIDMode="Static"></asp:DropDownList>
                                        <%--AutoPostBack="true" OnSelectedIndexChanged="ddlMachineModelNewMachineLvl_SelectedIndexChanged"--%>
                                    </FooterTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Machine Slno">
                                    <ItemTemplate>
                                        <%--  <asp:Label runat="server" ID="lblMachineSlno" ClientIDMode="Static" Text='<%# Eval("MachineSlno") %>'></asp:Label>--%>
                                        <asp:HiddenField runat="server" ID="hdnMachineSlno" ClientIDMode="Static" Value='<%# Eval("MachineSlno") %>' />
                                        <asp:HiddenField runat="server" ID="hdnSelectedMachineSlno" ClientIDMode="Static" Value='<%# Eval("MachineSlno") %>' />
                                        <asp:DropDownList ID="ddlMachineSlno" runat="server" CssClass="form-control textboxcss select" ClientIDMode="Static" onchange="ddlMachineSerialNumberChange(this,'gvMachineLvlData');"></asp:DropDownList>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:HiddenField runat="server" ID="hdnSelectedMachineSlno" ClientIDMode="Static" />
                                        <asp:DropDownList ID="ddlMachineSlno" runat="server" CssClass="form-control" ClientIDMode="Static" onchange="ddlMachineSerialNumberChange(this,'gvMachineLvlData');">
                                        </asp:DropDownList>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Category">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblCategory" ClientIDMode="Static" Text='<%# Eval("Category") %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:DropDownList ID="ddlCategoryNew" runat="server" CssClass="form-control" ClientIDMode="Static">
                                            <asp:ListItem>CNC Document</asp:ListItem>
                                            <asp:ListItem>Ele& Mech</asp:ListItem>
                                            <asp:ListItem>Ele-Design</asp:ListItem>
                                            <asp:ListItem>CNC</asp:ListItem>
                                            <asp:ListItem>MTB-Application</asp:ListItem>
                                        </asp:DropDownList>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Sub Category">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblSubCategory" ClientIDMode="Static" Text='<%# Eval("Subcategory") %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:DropDownList ID="ddlSubCategoryNew" runat="server" CssClass="form-control" ClientIDMode="Static">
                                            <asp:ListItem>Fanuc/Siemens/Mitsubishi/Control supplier manuals as applicable for Users</asp:ListItem>
                                            <asp:ListItem>Operation and Maintenance Manual</asp:ListItem>
                                            <asp:ListItem>Connection Manual</asp:ListItem>
                                            <asp:ListItem>Application Manual</asp:ListItem>
                                            <asp:ListItem>Quick Start Installation and Commissioning Guide</asp:ListItem>
                                        </asp:DropDownList>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Customer Name">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCustomerName" runat="server" Text='<%# Eval("CustomerName") %>' ClientIDMode="Static"></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox runat="server" ID="txtCustomerNameNew" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Date of Dispatch">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDateOfDispatch" runat="server" Text='<%# Eval("DateOfDispatchInString") %>' ClientIDMode="Static"></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox runat="server" ID="txtDateOfDispatchNew" CssClass="form-control"></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Version">
                                    <ItemTemplate>
                                        <asp:Label ID="lblVersion" runat="server" Text='<%# Eval("Version") %>' ClientIDMode="Static"></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox runat="server" ID="txtVersionNew" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="File Name">
                                    <ItemTemplate>
                                        <asp:HiddenField runat="server" ID="hdnCollectionName" ClientIDMode="Static" Value='<%# Eval("CollectionName") %>' />
                                        <asp:HiddenField runat="server" ID="hdnFileID" ClientIDMode="Static" Value='<%# Eval("FileID") %>' />
                                        <asp:HiddenField runat="server" ID="hdnFileName" ClientIDMode="Static" Value='<%# Eval("Filename") %>' />
                                        <asp:HiddenField runat="server" ID="hdnFileType" ClientIDMode="Static" Value='<%# Eval("FileType") %>' />
                                        <asp:LinkButton runat="server" ID="lnkFilename" Text='<%# Eval("Filename") %>' OnClientClick="return showFileDetails(this,'Machine');" ToolTip='<%# Eval("Filename") %>'></asp:LinkButton>
                                        <br />
                                        <asp:FileUpload runat="server" ID="fileUpload" CssClass="form-control" ClientIDMode="Static" onchange="setClearIcon(this)" Style="display: inline-block;" />

                                        <i id="clearFile" class="glyphicon glyphicon-remove" style="color: red; visibility: hidden; display: inline-block;" onclick="clearFileUploadData(this,'fileUpload')"></i>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:FileUpload ID="fileUploddNew" runat="server" CssClass="form-control" ClientIDMode="Static" onchange="setClearIcon(this)" Style="display: inline-block" />
                                        <i id="clearFile" class="glyphicon glyphicon-remove" style="color: red; visibility: hidden; display: inline-block" onclick="clearFileUploadData(this,'fileUploddNew')"></i>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Updated By">
                                    <ItemTemplate>
                                        <asp:Label ID="lblUpdatedBy" runat="server" Text='<%# Eval("UpdatedBy") %>' ClientIDMode="Static"></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Updated TS" SortExpression="UpdatedTS">
                                    <ItemTemplate>
                                        <asp:Label ID="lblUpdatedTS" runat="server" Text='<%# Eval("UpdatedTS") %>' ClientIDMode="Static"></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                 <asp:TemplateField HeaderText="Level">
                                    <ItemTemplate>
                                        <asp:Label ID="lblLevel" runat="server" Text='<%# Eval("Level") %>' ClientIDMode="Static"></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Delete">
                                    <ItemTemplate>
                                        <asp:CheckBox runat="server" ID="chkDeleteSelection" ClientIDMode="Static" />
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Button runat="server" ID="btnInsertMachineLvl" Text="Add" CssClass="Btns" ClientIDMode="Static" OnClientClick="return checkModelLvlInsertValidation(this);" OnClick="btnInsertMachineLvl_Click" />
                                    </FooterTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
            <div class="modal infoModal" id="showDocumentModal" role="dialog" style="min-width: 300px;">
                <div class="modal-dialog modal-dialog-centered" style="width: 90%;">
                    <div class="modal-content">
                        <div class="modal-header">

                            <h4 class="modal-title">Document</h4>
                        </div>
                        <div class="modal-body">
                            <div style="height: 70vh">
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
        </div>
        
        <div class="modal fade" id="mtbLvlDeleteConfirmModal" role="dialog">
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
                          <asp:Button runat="server" Text="Yes" ID="Button1"  CssClass="confirm-modal-btn" OnClick="btnDeleteCompanyLvl_Click" OnClientClick="return clearModalScreen();" />
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
                        <asp:Button runat="server" Text="Yes" ID="btnDeleteModelLvl" CssClass="confirm-modal-btn" OnClick="btnDeleteModelLvl_Click" OnClientClick="return clearModalScreen();" />
                        <input type="button"  value="No" data-dismiss="modal" class="confirm-modal-btn"  />
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
                        <asp:Button runat="server" Text="Yes" ID="Button2"  CssClass="confirm-modal-btn" OnClick="btnDeleteMachineLvl_Click" OnClientClick="return clearModalScreen();" />
                        <input type="button"  value="No" data-dismiss="modal" class="confirm-modal-btn" />
                    </div>
                </div>
            </div>
        </div>
        <%--    </ContentTemplate>
        </asp:UpdatePanel>--%>
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
    </div>
    <script>
        var submenu = "";

        $(document).ready(function () {
            // $("#modelLvlMenu").addClass("in active");
            //  $("#activeMenu").val("#processParamMenu0");
            debugger;
            if (localStorage.getItem("selectedeDocMasterSubMenu")) {
                debugger;
                submenu = localStorage.getItem("selectedeDocMasterSubMenu");
            }
            $(submenu).addClass("in active");
            $("a[href$='" + submenu + "']").removeClass("selected-menu-style").addClass("selected-Submenu");
            $("a[href$='" + submenu + "']").closest('li').find('i').addClass("arrow up selected-Submenu-ArrowUp");
            setGridHeight();
            $.unblockUI({});
        });
        function showLoader() {
            $.blockUI({ message: '<img runat="server" src="Images/Loading.gif" />' });
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
            }

            return false;
        }
        function clearModalScreen() {
            $(".modal-backdrop").removeClass("modal-backdrop in");
            return true;
        }
        function checkModelLvlInsertValidation(evt) {
            debugger;
            let cncMake = $(evt).closest('tr').find("#ddlCNCMakeNew").val();
            if (cncMake == "" || cncMake == null) {
                openWarningModal('Please select CNC Make.');
                return false;
            }
            let cncModel = $(evt).closest('tr').find("#ddlCNCModelNew").val();
            if (cncModel == "" || cncModel == null) {
                openWarningModal('Please select CNC Model.');
                return false;
            }
            if (submenu != "#companyLvlMenu") {
                let machineType = $(evt).closest('tr').find("#ddlMachineType").val();
                if (machineType == "" || machineType == null) {
                    openWarningModal('Please select Machine Type.');
                    return false;
                }
                let machineModel = $(evt).closest('tr').find("#ddlMachineModel").val();
                if (machineModel == "" || machineModel == null) {
                    openWarningModal('Please select Machine Model.');
                    return false;
                }
            }
            if (submenu == "#machineLvlMenu") {

                let machineSlno = $(evt).closest('tr').find("#ddlMachineSlno").val();
                if (machineSlno == "" || machineSlno == null) {
                    openWarningModal('Please select Machine Slno.');
                    return false;
                }
            }
            let category = $(evt).closest('tr').find("#ddlCategoryNew").val();
            if (category == "" || category == null) {
                openWarningModal('Please select Category.');
                return false;
            }
            let subcategory = $(evt).closest('tr').find("#ddlSubCategoryNew").val();
            if (subcategory == "" || subcategory == null) {
                openWarningModal('Please select Sub Category.');
                return false;
            }
            let customName = $(evt).closest('tr').find("#txtCustomerNameNew").val();
            if (customName == "") {
                openWarningModal('Please select Customer Name.');
                return false;
            }
            let dateofDispatch = $(evt).closest('tr').find("#txtDateOfDispatchNew").val();
            if (dateofDispatch == "") {
                openWarningModal('Please select Date of Dispatch.');
                return false;
            }
            let version = $(evt).closest('tr').find("#txtVersionNew").val();
            if (version == "") {
                openWarningModal('Please select Version.');
                return false;
            }
            let file = $(evt).closest('tr').find("#fileUploddNew").val();
            if (file == "") {
                openWarningModal('Please select File.');
                return false;
            }
            return true;
        }
        function ddlCNCMakeChange(evt, gridName) {
            let cncMake = $(evt).val();
            $(evt).closest('tr').find('#hdnSelectedCNCMake').val(cncMake);
            let rowIndex = $(evt).closest('tr')[0].rowIndex;
            BindCNCModel(cncMake, gridName, rowIndex);
        }
        function ddlCNCModelChange(evt, gridName) {
            let cncMake = $(evt).closest('tr').find("#ddlCNCMakeNew").val();
            let cncModel = $(evt).val();
            $(evt).closest('tr').find('#hdnSelectedCNCModel').val(cncModel);
            let rowIndex = $(evt).closest('tr')[0].rowIndex;
           // BindMachineType(cncMake, cncModel, gridName, rowIndex);
            if (submenu == "#machineLvlMenu") {
                let machinetype = $(evt).closest('tr').find('#hdnSelectedMachineType').val();
                let machiemodel = $(evt).closest('tr').find('#hdnSelectedMachineModel').val();
                BindMachineSerialNumber(cncMake, cncModel, machinetype, machiemodel, gridName, rowIndex);
            }
        }
        function ddlMachineTypeChange(evt, gridName, param) {
            debugger;
            let cncMake="", cnCModel="";
            if (param == "insert") {
                cncMake = $(evt).closest('tr').find("#ddlCNCMakeNew").val();
                cnCModel = $(evt).closest('tr').find("#ddlCNCModelNew").val();
            }
            else {
                cncMake = $(evt).closest('tr').find("#lblCNCMake").text();
                cnCModel = $(evt).closest('tr').find("#lblCNCModel").text();
            }
            let machineType = $(evt).closest('tr').find("#ddlMachineType").val();
            $(evt).closest('tr').find('#hdnSelectedMachineType').val(machineType);
            let rowIndex = $(evt).closest('tr')[0].rowIndex;
            BindMachineModel(cncMake, cnCModel, machineType, gridName, rowIndex);
        }
        function ddlMachineModelChange(evt, gridName) {
            debugger;
            let cncMake = $(evt).closest('tr').find("#lblCNCMake").text();
            let cnCModel = $(evt).closest('tr').find("#lblCNCModel").text();
            let machineType = $(evt).closest('tr').find("#ddlMachineType").val();
            let machineModel = $(evt).val();
            $(evt).closest('tr').find('#hdnSelectedMachineModel').val(machineModel);
            let rowIndex = $(evt).closest('tr')[0].rowIndex;
            BindMachineSerialNumber(cncMake, cnCModel, machineType, machineModel, gridName, rowIndex);
        }
        function ddlMachineSerialNumberChange(evt, gridName) {
            let machineSlno = $(evt).val();
            $(evt).closest('tr').find('#hdnSelectedMachineSlno').val(machineSlno);
        }
        function ddlMachineModelChangeSetHdnValue(evt, gridName, param) {
            let machineModel = $(evt).val();
            $(evt).closest('tr').find('#hdnSelectedMachineModel').val(machineModel);
        }
        function BindCNCModel(cncMake1, gridName, rowIndex) {
            var mtbvalue = "";
            if (submenu == "#modelLvlMenu") {
                mtbvalue = $('#ddlMTBModelLvl').val();
            }
            else {
                mtbvalue = $('#ddlMTBMachineLvl').val();
            }
            $.ajax({
                async: false,
                type: "POST",
                url: "MachineDocumentMaster.aspx/getCNCModelForDdl",
                contentType: "application/json; charset=utf-8",
                data: '{MTB:"' + mtbvalue + '",cncMake:"' + cncMake1 + '"}',
                datatype: "json",
                success: function (response) {
                    var itemdata = response.d;
                    //bind data
                    debugger;
                    var row = $('#' + gridName + ' tr')[rowIndex];
                    var ddlCNCModel = $(row).find("#ddlCNCModelNew");
                    $(ddlCNCModel).empty();
                    debugger;
                    var selectedModel = "";
                    if (itemdata.length > 0) {
                        var appendStr = "";
                        for (var i = 0; i < itemdata.length; i++) {
                            appendStr += '<option value="' + itemdata[i] + '">' + itemdata[i] + '</option>';
                        }
                        $(ddlCNCModel).append(appendStr);
                        selectedModel = $(ddlCNCModel).val();
                    }
                    $(row).find("#hdnSelectedCNCModel").val(selectedModel);
                    //BindMachineType(cncMake1, selectedModel, gridName, rowIndex);
                    if (submenu == "#machineLvlMenu") {
                        let machinetype = $(row).find('#hdnSelectedMachineType').val();
                        let machiemodel = $(row).find('#hdnSelectedMachineModel').val();
                        BindMachineSerialNumber(cncMake1, selectedModel, machinetype, machiemodel, gridName, rowIndex);
                    }
                },
                error: function (jqXHR, textStatus, err) {
                    console.log(err);
                }
            });
        }
        function BindMachineType(cncMake1, cnCModel1, gridName, rowIndex) {
            var mtbvalue = "";
            if (submenu == "#modelLvlMenu") {
                mtbvalue = $('#ddlMTBModelLvl').val();
            }
            else {
                mtbvalue = $('#ddlMTBMachineLvl').val();
            }
            $.ajax({
                async: false,
                type: "POST",
                url: "MachineDocumentMaster.aspx/getMachineTypeForDdl",
                contentType: "application/json; charset=utf-8",
                data: '{MTB:"' + mtbvalue + '",cncMake:"' + cncMake1 + '",cncModel:"' + cnCModel1 + '"}',
                datatype: "json",
                success: function (response) {
                    var itemdata = response.d;
                    //bind data
                    debugger;
                    var row = $('#' + gridName + ' tr')[rowIndex];
                    var ddlMachieModel = $(row).find("#ddlMachineType");
                    $(ddlMachieModel).empty();
                    debugger;
                    var selectedMachineType = "";
                    if (itemdata.length > 0) {
                        var appendStr = "";
                        for (var i = 0; i < itemdata.length; i++) {
                            appendStr += '<option value="' + itemdata[i] + '">' + itemdata[i] + '</option>';
                        }
                        $(ddlMachieModel).append(appendStr);
                        selectedMachineType = $(ddlMachieModel).val();
                    }
                    $(row).find("#hdnSelectedMachineType").val(selectedMachineType);
                    BindMachineModel(cncMake1, cnCModel1, selectedMachineType, gridName, rowIndex);
                },
                error: function (jqXHR, textStatus, err) {
                    console.log(err);
                }
            });
        }
        function BindMachineModel(cncMake1, cnCModel1, machineType1, gridName, rowIndex) {
            var mtbvalue = "";
            if (submenu == "#modelLvlMenu") {
                mtbvalue = $('#ddlMTBModelLvl').val();
            }
            else {
                mtbvalue = $('#ddlMTBMachineLvl').val();
            }
            $.ajax({
                async: false,
                type: "POST",
                url: "MachineDocumentMaster.aspx/getMachineModelForDdl",
                contentType: "application/json; charset=utf-8",
                data: '{MTB:"' + mtbvalue + '",cncMake:"' + cncMake1 + '",cncModel:"' + cnCModel1 + '",machineType:"' + machineType1 + '"}',
                datatype: "json",
                success: function (response) {
                    var itemdata = response.d;
                    //bind data
                    debugger;
                    var row = $('#' + gridName + ' tr')[rowIndex];
                    var ddlMachieModel = $(row).find("#ddlMachineModel");
                    $(ddlMachieModel).empty();
                    debugger;
                    var selectedMachine = "";
                    if (itemdata.length > 0) {
                        var appendStr = "";
                        for (var i = 0; i < itemdata.length; i++) {
                            appendStr += '<option value="' + itemdata[i] + '">' + itemdata[i] + '</option>';
                        }
                        $(ddlMachieModel).append(appendStr);
                        selectedMachine = $(ddlMachieModel).val();
                    }
                    $(row).find("#hdnSelectedMachineModel").val(selectedMachine);
                    if (submenu == "#machineLvlMenu") {
                        BindMachineSerialNumber(cncMake1, cnCModel1, machineType1, selectedMachine, gridName, rowIndex);
                    }
                },
                error: function (jqXHR, textStatus, err) {
                    console.log(err);
                }
            });
        }
        function BindMachineSerialNumber(cncMake1, cnCModel1, machineType1, machineModel1, gridName, rowIndex) {
            var mtbvalue = "";
            if (submenu == "#modelLvlMenu") {
                mtbvalue = $('#ddlMTBModelLvl').val();
            }
            else {
                mtbvalue = $('#ddlMTBMachineLvl').val();
            }
            $.ajax({
                async: false,
                type: "POST",
                url: "MachineDocumentMaster.aspx/getMachineSerialNumberForDdl",
                contentType: "application/json; charset=utf-8",
                data: '{MTB:"' + mtbvalue + '",cncMake:"' + cncMake1 + '",cncModel:"' + cnCModel1 + '",machineType:"' + machineType1 + '",machineModel:"' + machineModel1 + '"}',
                datatype: "json",
                success: function (response) {
                    var itemdata = response.d;
                    var row = $('#' + gridName + ' tr')[rowIndex];
                    var ddlMachieSlno = $(row).find("#ddlMachineSlno");
                    $(ddlMachieSlno).empty();
                    var selectedMachineSlno = "";
                    if (itemdata.length > 0) {
                        var appendStr = "";
                        for (var i = 0; i < itemdata.length; i++) {
                            appendStr += '<option value="' + itemdata[i] + '">' + itemdata[i] + '</option>';
                        }
                        $(ddlMachieSlno).append(appendStr);
                        selectedMachineSlno = $(ddlMachieSlno).val();
                    }
                    $(row).find("#hdnSelectedMachineSlno").val(selectedMachineSlno);
                },
                error: function (jqXHR, textStatus, err) {
                    console.log(err);
                }
            });
        }
        function setClearIcon(evt) {
            debugger;
            var selected_file_name = $(evt).val();
            var row = $(evt).closest('tr');
            var clearIcon = $(row).find("#clearFile");
            if (selected_file_name.length > 0) {
                $(clearIcon).css("visibility", "visible");
            }
            else {
                $(clearIcon).css("visibility", "hidden");
            }
        }
        function clearFileUploadData(evt, fileid) {
            debugger;
            var row = $(evt).closest('tr');
            var fileup = $(row).find("#" + fileid);
            $(fileup).val('');
            $(evt).css("visibility", "hidden");
        }
        function openWarningModal(msg) {
            $('#warningModal').modal('show');
            $('#lblWarningMsg').text(msg);
        }
        $("[id$=gvModelLvlData]").on("click", "td", function () {
            $(this).closest('tr').find('#hdnUpdate').val("updated");
            var tblID = $(this).closest('table').prop('id');
            var tbl = document.getElementById(tblID);
            var tblRowCount = tbl.rows.length - 1;
            var currentTR = $(this).closest('tr');
            var currentClickRowIndex = $(currentTR).index();
            if (tblRowCount == currentClickRowIndex) {
                return;
            }
            $("[id$=gvModelLvlData] tr:not(:last-child) td").find('input').removeClass("form-control");
            $("[id$=gvModelLvlData] tr:not(:last-child) td").find('input').addClass("textboxcss");
            $("[id$=gvModelLvlData] tr:not(:last-child) td").find('select').addClass("select");
            $("[id$=gvModelLvlData] tr:not(:last-child) td").find('select').addClass("textboxcss");
            $("[id$=gvModelLvlData] tr:not(:last-child) td").find('select').removeClass("form-control");

            $(this).closest('td').find('input').removeClass("textboxcss");
            $(this).closest('td').find('input').addClass("form-control");
            $(this).closest('td').find('select').addClass("form-control");
            $(this).closest('td').find('select').removeClass("textboxcss");
            $(this).closest('td').find('select').removeClass("select");

            $("[id$=gvModelLvlData] tr:not(:last-child) td").find('input[type="checkbox"]').removeClass("form-control");
        });
        $("[id$=gvMachineLvlData]").on("click", "td", function () {
            $(this).closest('tr').find('#hdnUpdate').val("updated");
            var tblID = $(this).closest('table').prop('id');
            var tbl = document.getElementById(tblID);
            var tblRowCount = tbl.rows.length - 1;
            var currentTR = $(this).closest('tr');
            var currentClickRowIndex = $(currentTR).index();
            if (tblRowCount == currentClickRowIndex) {
                return;
            }
            $("[id$=gvMachineLvlData] tr:not(:last-child) td").find('input').removeClass("form-control");
            $("[id$=gvMachineLvlData] tr:not(:last-child) td").find('input').addClass("textboxcss");
            $("[id$=gvMachineLvlData] tr:not(:last-child) td").find('select').addClass("select");
            $("[id$=gvMachineLvlData] tr:not(:last-child) td").find('select').addClass("textboxcss");
            $("[id$=gvMachineLvlData] tr:not(:last-child) td").find('select').removeClass("form-control");

            $(this).closest('td').find('input').removeClass("textboxcss");
            $(this).closest('td').find('input').addClass("form-control");
            $(this).closest('td').find('select').addClass("form-control");
            $(this).closest('td').find('select').removeClass("textboxcss");
            $(this).closest('td').find('select').removeClass("select");

            $("[id$=gvMachineLvlData] tr:not(:last-child) td").find('input[type="checkbox"]').removeClass("form-control");
        });

        function setActiveSubmenuValue() {
            debugger;
            localStorage.setItem("selectedeDocMasterSubMenu", "#companyLvlMenu");
        }

        $(window).resize(function () {
            setGridHeight();
        });
        function setGridHeight() {
            var height = $(window).height() - 220;
            $('.gridContainer').css("height", height);
        }
        $('[id$=txtDateOfDispatchNew]').datepicker({
            format: 'dd-mm-yyyy',
            todayHighlight: true,
            autoclose: true,
            language: 'en-US'
        });
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
        function showFileDetails(evt, level) {
            debugger;
            $.blockUI({ message: '<img runat="server" src="Images/Loading.gif" />' });
            var fileidvalue = $(evt).closest('tr').find('#hdnFileID').val();
            var collectionName = $(evt).closest('tr').find('#hdnCollectionName').val();
            if (level == "Model") {
                let type = $(evt).closest('tr').find('#hdnMachineType').val();
                let model = $(evt).closest('tr').find('#hdnMachineModel').val();
                if (type == "" && model == "") {
                    collectionName = "MTBLeveleDoc";
                }
                else {
                    collectionName = "ModelLeveleDoc";
                }
            }
            else if (level == "Machine") {
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
            }
            $.ajax({
                async: false,
                type: "POST",
                url: "MachineDocumentMaster.aspx/getFileNamePath",
                contentType: "application/json; charset=utf-8",
                data: '{fileId:"' + fileidvalue + '",filenameStr:"' + $(evt).closest('tr').find('#hdnFileName').val() + '",colName:"' + collectionName + '"}',
                datatype: "json",
                success: function (response) {
                    var itemdata = response.d;
                    debugger;
                    //$('#iframeDocument').attr("src", "");
                    //$('#iframeDocument').attr("src", itemdata);
                    //$('#showDocumentModal').modal("show");
                    var d = new Date();
                    console.log("Data return :" + d);
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
                            var fileName = $(evt).closest('tr').find('#hdnFileName').val();
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
            $.unblockUI({});
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
        $('[id$=lbModelNew]').multiselect({
            includeSelectAllOption: true
        });
        $('[id$=lbMachineModelModelLvl]').multiselect({
            includeSelectAllOption: true
        });
        $('[id$=multiselectddlMachineID]').multiselect({
            includeSelectAllOption: true
        });

        $(".submenuData").click(function () {
            debugger;
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
            if (submenu == "#companyLvlMenu") {
                __doPostBack('<%= btnCompanyLevel.UniqueID%>', '');
            }
            else if (submenu == "#modelLvlMenu") {
                __doPostBack('<%= btnModelLevel.UniqueID%>', '');
            }
            else {
                __doPostBack('<%= btnMachineLevel.UniqueID%>', '');
            }
            localStorage.setItem("selectedeDocMasterSubMenu", submenu);
            //selectedeDocMasterSubMenu.setItem("selectedSubMenu", submenu);
            // $('#hdnSubmenu').val(submenu);
            // $("#menu0").removeClass("in active");
        });
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
            $(document).ready(function () {
                // $("#modelLvlMenu").addClass("in active");
                //  $("#activeMenu").val("#processParamMenu0");
                debugger;
                //  submenu = $('#hdnSubmenu').val();
                if (localStorage.getItem("selectedeDocMasterSubMenu")) {
                    debugger;
                    submenu = localStorage.getItem("selectedeDocMasterSubMenu");
                }
                $(submenu).addClass("in active");
                $("a[href$='" + submenu + "']").removeClass("selected-menu-style").addClass("selected-Submenu");
                $("a[href$='" + submenu + "']").closest('li').find('i').addClass("arrow up selected-Submenu-ArrowUp");
                $.unblockUI({});
            });
            $('[id$=lbModelNew]').multiselect({
                includeSelectAllOption: true
            });
            $('[id$=lbMachineModelModelLvl]').multiselect({
                includeSelectAllOption: true
            });
            $('[id$=multiselectddlMachineID]').multiselect({
                includeSelectAllOption: true
            });
            $(".submenuData").click(function () {
                $.blockUI({ message: '<img runat="server" src="Images/Loading.gif" />' });
                $(document).ready(function () {
                    $("#modelLvlMenu").addClass("in active");
                    //  $("#activeMenu").val("#processParamMenu0");
                    $("a[href$='#modelLvlMenu']").removeClass("selected-menu-style").addClass("selected-Submenu");
                    $("a[href$='#modelLvlMenu']").closest('li').find('i').addClass("arrow up selected-Submenu-ArrowUp");
                });
                debugger;
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
                if (submenu == "#companyLvlMenu") {
                    __doPostBack('<%= btnCompanyLevel.UniqueID%>', '');
                }
                else if (submenu == "#modelLvlMenu") {
                    __doPostBack('<%= btnModelLevel.UniqueID%>', '');
                }
                else {
                    __doPostBack('<%= btnMachineLevel.UniqueID%>', '');
                }
                $('#hdnSubmenu').val(submenu);
                // $("#menu0").removeClass("in active");
            });
        });
    </script>
</asp:Content>
