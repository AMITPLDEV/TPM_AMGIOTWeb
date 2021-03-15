<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CompanyGroupMaster.aspx.cs" Inherits="NewProject.CompanyGroupMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="Scripts/Toaster/toastr.min.js"></script>
    <link href="Scripts/Toaster/toastr.min.css" rel="stylesheet" />

    <script src="Scripts/DateTimePickerFor331/moment.js"></script>
    <script src="Scripts/DateTimePickerFor331/bootstrap-datetimepicker.min.js"></script>
    <link href="Scripts/DateTimePickerFor331/bootstrap-datetimepicker.min.css" rel="stylesheet" />

    <link href="Scripts/MultiSelectDropdown/bootstrap-multiselect.css" rel="stylesheet" />
    <script src="Scripts/MultiSelectDropdown/bootstrap-multiselect.js"></script>
    <style>
        .radio-button > tbody > tr > td {
            padding-left: 5px;
        }

            .radio-button > tbody > tr > td > input {
                width: 15px;
                height: 15px;
            }

            .radio-button > tbody > tr > td > label {
                vertical-align: inherit;
                padding-left: 2px;
            }

        .modal-tbl tr td {
            padding: 5px;
        }

            .modal-tbl tr td:nth-child(3) {
                padding-left: 20px;
            }

            .modal-tbl tr td:nth-child(1), .modal-tbl tr td:nth-child(3) {
                /*min-width: 135px;*/
                width: 152px;
            }

        .txtstyle {
            width: 200px;
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

        .navigation-icon {
            color: #08ffff;
        }

            .navigation-icon:hover {
                color: #08ffff;
            }

        .userRightsInnerTbl {
            width: 100%;
        }

            .userRightsInnerTbl tr td {
                padding: 6px 0px;
                text-align: center;
                border-bottom: 0.5px solid #363333 !important;
            }

        .templatesTbl {
            width: 100%;
        }

            .templatesTbl tr td {
                width: 100px;
            }

        .userRightsTbl > tbody > tr:first-child td, .userRightsTbl > tbody > tr:first-child td:hover {
            background-color: #6c7884;
            position: sticky;
            top: 0px;
            z-index: 2;
        }

        .light-mode .userRightsTbl > tbody > tr:first-child td, .light-mode .userRightsTbl > tbody > tr:first-child td:hover {
            background-color: #ebebeb !important;
            border: 0.5px solid gainsboro;
        }

        .tr-space-above > td {
            padding-top: 20px !important;
        }
     
    </style>
    <div class="themetoggle">
        <asp:HiddenField runat="server" ID="hdnScrollPos" ClientIDMode="Static" />
        <div style="float: left; margin-top: 5px">
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <div class="navbar-collapse collapse" style="height: 42px !important;">
                        <ul id="masterul" class="nav navbar-nav nextPrevious submenus-style ">
                            <li id="Group" runat="server"><a runat="server" class="submenuData" id="A15" clientidmode="static" data-toggle="tab" href="#GCmastermenu0">Group</a>
                                <i></i>
                            </li>
                            <li id="Company" runat="server"><a runat="server" class="submenuData" id="A14" clientidmode="static" data-toggle="tab" href="#GCmastermenu1">Company</a>
                                <i></i>
                            </li>
                            <li><a runat="server" class="submenuData" id="A2" clientidmode="static" data-toggle="tab" href="#LHmastermenu2">Role</a>
                                <i></i>
                            </li>
                            <li><a runat="server" class="submenuData" id="A1" clientidmode="static" data-toggle="tab" href="#LHmastermenu1">User</a>
                                <i></i>
                            </li>

                            <li><a runat="server" class="submenuData" id="A3" clientidmode="static" data-toggle="tab" href="#LHmastermenu3">Plant</a>
                                <i></i>
                            </li>
                            <li><a runat="server" class="submenuData" id="A4" clientidmode="static" data-toggle="tab" href="#LHmastermenu0">Machine</a>
                                <i></i>
                            </li>
                            <li runat="server" id="Li1"><a runat="server" class="submenuData" id="A10" clientidmode="static" data-toggle="tab" href="#LHmastermenu7">Assign Machine To Plant</a>
                                <i></i>
                            </li>

                            <li><a runat="server" class="submenuData" id="A5" clientidmode="static" data-toggle="tab" href="#userRoleRightsMenu0">Role Rights</a>
                                <i></i>
                            </li>
                            <li><a runat="server" class="submenuData" id="A6" clientidmode="static" data-toggle="tab" href="#userRightExceptionMenu1">User Rights Exception</a>
                                <i></i>
                            </li>
                        </ul>
                    </div>
                    <div style="display: none">
                        <asp:Button runat="server" ID="btnGroup" OnClick="btnGroup_Click" />
                        <asp:Button runat="server" ID="btnCompany" OnClick="btnCompany_Click" />
                        <asp:Button runat="server" ID="btnMachine" OnClick="btnMachine_Click" />
                        <asp:Button runat="server" ID="btnEmployee" OnClick="btnEmployee_Click" />
                        <asp:Button runat="server" ID="btnRole" OnClick="btnRole_Click" />
                        <asp:Button runat="server" ID="btnPlant" OnClick="btnPlant_Click" />
                        <asp:Button runat="server" ID="btnUserRoleRights" OnClick="btnUserRoleRights_Click" />
                        <asp:Button runat="server" ID="btnUserRightException" OnClick="btnUserRightException_Click" />
                        <asp:Button runat="server" ID="btnAssignMachineToPlant" OnClick="btnAssignMachineToPlant_Click" />
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="tab-content themetoggle" id="masterContainer" style="overflow: auto; width: 100%; margin: -10px auto;">
                <div id="GCmastermenu0" class="tab-pane fade">
                    <div>
                        <fieldset class="field-set" style="display: inline-block;">
                            <legend>&nbsp;<b>Filter By</b></legend>
                            <table class="filterTbl filter-field-table">
                                <tr>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtGroupSearch" CssClass="form-control" placeholder="Search"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Button runat="server" ID="btnViewGroup" ClientIDMode="Static" Text="View" CssClass="Btns" OnClick="btnViewGroup_Click" />
                                        <asp:Button runat="server" ID="btnNewEditGroup" ClientIDMode="Static" Text="New Group" CssClass="Btns" OnClientClick="return btnNewEditGroupClick(this,'New');" />
                                        <asp:Button runat="server" ID="btnExportGroup" ClientIDMode="Static" Text="Export" CssClass="Btns" />
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </div>
                    <div id="gvGroupConatiner" class="gridContainer" style="margin-top: 10px; width: 95vw; overflow: auto">
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvGroupDetails" runat="server" AutoGenerateColumns="false" Width="100%" EmptyDataText="No Data Found." ShowHeaderWhenEmpty="true" ShowHeader="true" ClientIDMode="Static" OnRowDataBound="gvGroupDetails_RowDataBound" CssClass="P1Table">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Group ID">
                                            <ItemTemplate>
                                                <asp:Label ID="lblGroupID" runat="server" Text='<%# Eval("GroupID") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Group Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblGroupName" runat="server" Text='<%# Eval("GroupName") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Contact Person">
                                            <ItemTemplate>
                                                <asp:Label ID="lblContactPerson" runat="server" Text='<%# Eval("ContactPerson") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Place">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPlace" runat="server" Text='<%# Eval("Place") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="State">
                                            <ItemTemplate>
                                                <asp:Label ID="lblState" runat="server" Text='<%# Eval("State") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Country">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCountry" runat="server" Text='<%# Eval("Country") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Pin">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPin" runat="server" Text='<%# Eval("Pin") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Address">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAddress" runat="server" Text='<%# Eval("Address") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Email">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEmailId" runat="server" Text='<%# Eval("Email") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Phone">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPhone" runat="server" Text='<%# Eval("Phone") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Effective From">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEffevtiveFromDate" runat="server" Text='<%# Eval("EffectiveFromDate") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Effective To">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEffevtiveToDate" runat="server" Text='<%# Eval("EffectiveToDate") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Action">
                                            <ItemTemplate>
                                                <asp:LinkButton runat="server" ID="lbEdit" CssClass="glyphicon glyphicon-pencil action-glypicon" OnClientClick="return btnNewEditGroupClick(this,'Edit')" ToolTip="Edit Group"></asp:LinkButton>
                                                <asp:LinkButton runat="server" ID="lbDeleteGroup" CssClass="glyphicon glyphicon-trash action-glypicon" OnClick="lbDeleteGroup_Click" ToolTip="Delete Group"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <%--   <asp:TemplateField HeaderText="Delete">
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
                                        </asp:TemplateField>--%>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnGroup" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnCompany" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnMachine" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnEmployee" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnRole" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnPlant" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnAssignMachineToPlant" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnUserRoleRights" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnUserRightException" EventName="Click" />

                                <asp:AsyncPostBackTrigger ControlID="btnNewEditGroupSave" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnViewGroup" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnDeleteGroupConfirm" EventName="Click" />

                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
                <div id="GCmastermenu1" class="tab-pane fade">
                    <div>
                        <fieldset class="field-set" style="display: inline-block;">
                            <legend>&nbsp;<b>Filter By</b></legend>
                            <table class="filterTbl filter-field-table">
                                <tr>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtCompanySearch" CssClass="form-control" placeholder="Search"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Button runat="server" ID="btnViewCompany" ClientIDMode="Static" Text="View" CssClass="Btns" OnClick="btnViewCompany_Click" />
                                        <asp:Button runat="server" ID="btnNewEditCompany" ClientIDMode="Static" Text="New Company" CssClass="Btns" OnClientClick="return btnNewEditCompanyClick(this,'New');" />
                                        <asp:Button runat="server" ID="btnExportCompany" ClientIDMode="Static" Text="Export" CssClass="Btns" />
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </div>
                    <div id="gvCompanyConatiner" class="gridContainer" style="margin-top: 10px; width: 95vw; overflow: auto">
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvCompanyDetails" runat="server" AutoGenerateColumns="false" Width="100%" EmptyDataText="No Data Found." ShowHeaderWhenEmpty="true" ShowHeader="true" ClientIDMode="Static" OnRowDataBound="gvCompanyDetails_RowDataBound" CssClass="P1Table">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Group ID">
                                            <ItemTemplate>
                                                <asp:Label ID="lblGroupID" runat="server" Text='<%# Eval("GroupID") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Company ID">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCompanyID" runat="server" Text='<%# Eval("CompanyID") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Company Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCompanyName" runat="server" Text='<%# Eval("CompanyName") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Contact Person">
                                            <ItemTemplate>
                                                <asp:Label ID="lblContactPerson" runat="server" Text='<%# Eval("ContactPerson") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Place">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPlace" runat="server" Text='<%# Eval("Place") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="State">
                                            <ItemTemplate>
                                                <asp:Label ID="lblState" runat="server" Text='<%# Eval("State") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Country">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCountry" runat="server" Text='<%# Eval("Country") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Pin">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPin" runat="server" Text='<%# Eval("Pin") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Address">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAddress" runat="server" Text='<%# Eval("Address") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Email">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEmailId" runat="server" Text='<%# Eval("Email") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Phone">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPhone" runat="server" Text='<%# Eval("Phone") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Company Admin">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCompanyAdmin" runat="server" Text='<%# Eval("UserID") %>' ClientIDMode="Static"></asp:Label>
                                                <asp:HiddenField runat="server" ID="hfCompanyAdminPassword" ClientIDMode="Static" Value='<%# Eval("Password") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Effective From">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEffevtiveFromDate" runat="server" Text='<%# Eval("EffectiveFromDate") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Effective To">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEffevtiveToDate" runat="server" Text='<%# Eval("EffectiveToDate") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Action">
                                            <ItemTemplate>
                                                <asp:LinkButton runat="server" ID="lbEdit" CssClass="glyphicon glyphicon-pencil action-glypicon" OnClientClick="return btnNewEditCompanyClick(this,'Edit')" ToolTip="Edit Company"></asp:LinkButton>
                                                <asp:LinkButton runat="server" ID="lbDeleteCompany" CssClass="glyphicon glyphicon-trash action-glypicon" OnClick="lbDeleteCompany_Click" ToolTip="Delete Group"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnGroup" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnCompany" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnMachine" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnEmployee" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnRole" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnPlant" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnAssignMachineToPlant" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnUserRoleRights" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnUserRightException" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnNewEditCompanySave" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnViewCompany" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnDeleteCompanyConfirm" EventName="Click" />

                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>



                <div id="LHmastermenu0" class="tab-pane fade">
                    <div>

                        <fieldset class="field-set" style="display: inline-block;">
                            <legend>&nbsp;<b>Filter By</b></legend>
                            <table class="filterTbl filter-field-table">
                                <tr>
                                    <td>
                                        <asp:Label runat="server" ID="Label5">Company </asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="lblCompany_ForMachine" CssClass="form-control"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtMachineIdSearch" CssClass="form-control" placeholder="Search MachineID" ClientIDMode="Static"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Button runat="server" ID="btnMachineView" ClientIDMode="Static" Text="View" CssClass="Btns" OnClick="btnMachineView_Click" />
                                        <asp:Button runat="server" ID="btnMachineNew" ClientIDMode="Static" Text="New Machine" CssClass="Btns" OnClick="btnMachineNew_Click" />
                                        <%--OnClientClick="if(!openMachineNEModal(this,'New')){return false};"--%> 
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </div>
                    <div class="gridContainer" style="margin-top: 10px; width: 95vw; overflow: auto">
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <div id="machineGridContainer" style="height: 75vh; overflow: auto">
                                    <asp:GridView ID="gvMachineData" runat="server" AutoGenerateColumns="false" Width="100%" EmptyDataText="No Data Found." ShowHeaderWhenEmpty="true" ShowHeader="true" ShowFooter="false" ClientIDMode="Static" CssClass="P1Table">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Company ID" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCompanyID" runat="server" Text='<%# Eval("CompanyID") %>' ClientIDMode="Static"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Machine ID">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMachineID" runat="server" Text='<%# Eval("MachineID") %>' ClientIDMode="Static"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="IoT ID">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblInterfaceID" runat="server" Text='<%# Eval("IOTID") %>' ClientIDMode="Static"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Machine Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMachineName" runat="server" Text='<%# Eval("MachineDisplayName") %>' ClientIDMode="Static"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="MTB">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMTB" runat="server" Text='<%# Eval("MachineMTB") %>' ClientIDMode="Static"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Machine Type">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMachineType" runat="server" Text='<%# Eval("MachineType") %>' ClientIDMode="Static"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Machine Model">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMachineModel" runat="server" Text='<%# Eval("MachineModel") %>' ClientIDMode="Static"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="CNC Make">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCNCMake" runat="server" Text='<%# Eval("CNCMake") %>' ClientIDMode="Static"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="CNC Model">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCNCModel" runat="server" Text='<%# Eval("CNCModel") %>' ClientIDMode="Static"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="PLC Make">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPLCMake" runat="server" Text='<%# Eval("PLCMake") %>' ClientIDMode="Static"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="PLC Model">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPLCModel" runat="server" Text='<%# Eval("PLCModel") %>' ClientIDMode="Static"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <%--  <asp:TemplateField HeaderText="IP Address">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblIPAddress" runat="server" Text='<%# Eval("IPAddress") %>' ClientIDMode="Static"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="IP Port Number">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblIPPortNo" runat="server" Text='<%# Eval("IPPortNo") %>' ClientIDMode="Static"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Mchrrate">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMchrrate" runat="server" Text='<%# Eval("Mchrrate") %>' ClientIDMode="Static"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="TPM Trak Enabled?">
                                                <ItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chkTPMTrakEnabled" ClientIDMode="Static" onclick="return false" Checked='<%# Eval("TPMTrakEnabled") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Multi Spindle Flag?">
                                                <ItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chkMultiSpindleFlag" ClientIDMode="Static" onclick="return false" Checked='<%# Eval("MultiSpindleFlag") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Device Type">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDeviceType" runat="server" Text='<%# Eval("DeviceType") %>' ClientIDMode="Static"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Machinewise Owner">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMachinewiseOwner" runat="server" Text='<%# Eval("MachinewiseOwner") %>' ClientIDMode="Static"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Critical Machine Enabled?">
                                                <ItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chkCriticalMachineEnabled" ClientIDMode="Static" onclick="return false" Checked='<%# Eval("CriticalMachineEnabled") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="DAP Enabled?">
                                                <ItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chkDAPEnabled" ClientIDMode="Static" onclick="return false" Checked='<%# Eval("DAPEnabled") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Ethernet Enabled?">
                                                <ItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chkEthernetEnabled" ClientIDMode="Static" onclick="return false" Checked='<%# Eval("EthernetEnabled") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="N to 1 Device?">
                                                <ItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chkNto1Device" ClientIDMode="Static" onclick="return false" Checked='<%# Eval("Nto1Device") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="DNC IP">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDNCIP" runat="server" Text='<%# Eval("DNCIP") %>' ClientIDMode="Static"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="DNC IP Port Number">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDNCIPPortNo" runat="server" Text='<%# Eval("DNCIPPortNo") %>' ClientIDMode="Static"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="DNC Transfer Enabled?">
                                                <ItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chkDNCTransferEnabled" ClientIDMode="Static" onclick="return false" Checked='<%# Eval("DNCTransferEnabled") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Program folder Enabled?">
                                                <ItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chkProgramFolderEnabled" ClientIDMode="Static" onclick="return false" Checked='<%# Eval("ProgramFolderEnabled") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Auto Setup Change Down">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAutoSetupChangeDown" runat="server" Text='<%# Eval("AutoSetupChangeDown") %>' ClientIDMode="Static"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="AGI Enabled?">
                                                <ItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chkAGIEnabled" ClientIDMode="Static" onclick="return false" Checked='<%# Eval("AGIEnabled") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="OPCUAURL">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblOPCUAURL" runat="server" Text='<%# Eval("OPCUAURL") %>' ClientIDMode="Static"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Controller Type">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblControllerType" runat="server" Text='<%# Eval("ControllerType") %>' ClientIDMode="Static"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>--%>
                                            <asp:TemplateField HeaderText="Serial Number">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblSerialNumber" runat="server" Text='<%# Eval("SerialNumber") %>' ClientIDMode="Static"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <%-- <asp:TemplateField HeaderText="OEE Target">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblOEETarget" runat="server" Text='<%# Eval("OEETarget") %>' ClientIDMode="Static"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Part Count By Macro Enabled?">
                                                <ItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chkEnablePartCountByMacro" ClientIDMode="Static" onclick="return false" Checked='<%# Eval("EnablePartCountByMacro") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Effective From">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblEffectiveFromDate" runat="server" Text='<%# Eval("EffectiveFromDate") %>' ClientIDMode="Static"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Effective To">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblEffectiveToDate" runat="server" Text='<%# Eval("EffectiveToDate") %>' ClientIDMode="Static"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>--%>
                                            <asp:TemplateField HeaderText="Action">
                                                <ItemTemplate>
                                                    <asp:LinkButton runat="server" ID="lbMachineEdit" CssClass="glyphicon glyphicon-pencil action-glypicon" OnClick="lbMachineEdit_Click" ToolTip="Edit Machine"></asp:LinkButton>
                                                    <asp:LinkButton runat="server" ID="lbMachineDelete" CssClass="glyphicon glyphicon-trash action-glypicon" OnClick="lbMachineDelete_Click" ToolTip="Delete Machine"></asp:LinkButton>
                                                    <%--OnClientClick="return openMachineNEModal(this,'Save');"--%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                                <%--Add and Edit Machine--%>
                                <div class="modal infoModal" id="addEditMachineInfo" role="dialog" style="min-width: 300px;" data-backdrop="static" data-keyboard="false">
                                    <div class="modal-dialog modal-dialog-centered " style="width: 80%">
                                        <div class="modal-content modalThemeCss">
                                            <div class="modal-header">
                                                <h4 class="modal-title">Add Machine</h4>
                                                <asp:HiddenField runat="server" ClientIDMode="Static" ID="hdnMachineNEStatus" />
                                            </div>
                                            <div class="modal-body" style="height: 60vh; overflow: auto">
                                                <span style="color: red" class="mandatory-message"></span>
                                                <br />
                                                <ul id="machineul" class="nav navbar-nav nextPrevious machine-menu-style ">
                                                    <li id="Li2" runat="server"><a runat="server" class="machinesubmenuData" id="A7" clientidmode="static" data-toggle="tab" href="#MachineInformation">Machine Information</a>
                                                        <i></i>
                                                    </li>
                                                    <li id="Li3" runat="server"><a runat="server" class="machinesubmenuData" id="A8" clientidmode="static" data-toggle="tab" href="#MachineCharacteristics">Characteristics</a>
                                                        <i></i>
                                                    </li>
                                                    <li><a runat="server" class="machinesubmenuData" id="A9" clientidmode="static" data-toggle="tab" href="#MachineDataSource">Data Source</a>
                                                        <i></i>
                                                    </li>
                                                </ul>

                                                <div class="tab-content themetoggle" style="overflow: auto; width: 100%; margin: -10px auto; padding-top: 20px">
                                                    <div id="MachineInformation" class="tab-pane fade">
                                                        <table style="width: 100%; margin: auto" class="modal-tbl">
                                                            <tr>
                                                                <td>Machine ID *</td>
                                                                <td>
                                                                    <asp:TextBox runat="server" ID="txtNEMachineID" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                                                </td>
                                                                <td>IoT ID *</td>
                                                                <td>
                                                                    <asp:TextBox runat="server" ID="txtNEInterfaceID" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                                                </td>
                                                                <td>Machine Name</td>
                                                                <td>
                                                                    <asp:TextBox runat="server" ID="txtNEMachineName" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>MTB</td>
                                                                <td>
                                                                    <asp:DropDownList runat="server" ID="ddlNEMTB" ClientIDMode="Static" CssClass="form-control  dropdown-list txtstyle" OnSelectedIndexChanged="ddlNEMTB_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                                                </td>
                                                                <td>Machine Type</td>
                                                                <td>
                                                                    <asp:DropDownList runat="server" ID="ddlNEMachineType" ClientIDMode="Static" CssClass="form-control  dropdown-list txtstyle" OnSelectedIndexChanged="ddlNEMachineType_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                                                </td>
                                                                <td>Machine Model</td>
                                                                <td>
                                                                    <asp:DropDownList runat="server" ID="ddlNEMachineModel" ClientIDMode="Static" CssClass="form-control  dropdown-list txtstyle"></asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>Serial Number</td>
                                                                <td>
                                                                    <asp:TextBox runat="server" ID="txtNESerialNumber" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>Controller Type</td>
                                                                <td>
                                                                    <%-- <asp:TextBox runat="server" ID="txtNEControllerType" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>--%>
                                                                    <asp:DropDownList runat="server" ID="ddlControllerType" ClientIDMode="Static" CssClass="form-control  dropdown-list txtstyle" AutoPostBack="true" OnSelectedIndexChanged="ddlControllerType_SelectedIndexChanged">
                                                                        <asp:ListItem Text="CNC" Value="CNC"></asp:ListItem>
                                                                        <asp:ListItem Text="PLC" Value="PLC"></asp:ListItem>
                                                                        <asp:ListItem Text="Others" Value="Others"></asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td>
                                                                    <asp:Label runat="server" ID="makeName"></asp:Label></td>
                                                                <td>
                                                                    <asp:DropDownList runat="server" ID="ddlNECNCMake" ClientIDMode="Static" CssClass="form-control  dropdown-list txtstyle" AutoPostBack="true" OnSelectedIndexChanged="ddlNECNCMake_SelectedIndexChanged"></asp:DropDownList>
                                                                </td>
                                                                <td>
                                                                    <asp:Label runat="server" ID="modelName"></asp:Label></td>
                                                                <td>
                                                                    <asp:DropDownList runat="server" ID="ddlNECNCModel" ClientIDMode="Static" CssClass="form-control  dropdown-list txtstyle"></asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                    <div id="MachineCharacteristics" class="tab-pane fade">
                                                        <table style="width: 100%; margin: auto" class="modal-tbl">
                                                            <tr>
                                                                <td>Machine Owner</td>
                                                                <td>
                                                                    <asp:TextBox runat="server" ID="txtNEMachineOwner" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                                                </td>
                                                                <td>Machine Hour Rate</td>
                                                                <td>
                                                                    <asp:TextBox runat="server" ID="txtNEMchrrate" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle allowDecimal"></asp:TextBox>
                                                                </td>
                                                                <td>OEE Target</td>
                                                                <td>
                                                                    <asp:TextBox runat="server" ID="txtNEOeeTarget" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle allowDecimal"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>Multi Spindle Flag?</td>
                                                                <td>
                                                                    <asp:CheckBox runat="server" ID="chkNEMultiSpindleFlag" ClientIDMode="Static" />
                                                                </td>
                                                                <td>Auto Setup Change Down</td>
                                                                <td>
                                                                    <asp:TextBox runat="server" ID="txtNEAutoSetup" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                                                </td>
                                                                <td>Critical Machine Enabled?</td>
                                                                <td>
                                                                    <asp:CheckBox runat="server" ID="chkNECriticalMachine" ClientIDMode="Static" />
                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td>Effective From *</td>
                                                                <td>
                                                                    <asp:TextBox runat="server" ID="txtNEEffFromDate" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle" Style="position: relative" placeholder="DD-MM-YYYY"></asp:TextBox>
                                                                    <%--datetime-txtstyle--%>
                                                                </td>
                                                                <td>Effective To *</td>
                                                                <td>
                                                                    <asp:TextBox runat="server" ID="txtNEEffToDate" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle" Style="position: relative" placeholder="DD-MM-YYYY"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                    <div id="MachineDataSource" class="tab-pane fade">
                                                        <asp:Button runat="server" ID="btnNewMachineDataSource" ClientIDMode="Static" Text="New DataSource" CssClass="Btns" OnClick="btnNewMachineDataSource_Click" />

                                                        <div id="machineSourceGridContainer" style="height: 100%; overflow: auto;margin-top: 10px">
                                                            <asp:GridView ID="gvMachineDataSourceDetails" runat="server" AutoGenerateColumns="false" Width="100%" EmptyDataText="No Data Found." ShowHeaderWhenEmpty="true" ShowHeader="true" ShowFooter="false" ClientIDMode="Static" CssClass="P1Table">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Company ID" Visible="false">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblCompanyID" runat="server" Text='<%# Eval("CompanyID") %>' ClientIDMode="Static"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Machine ID">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblMachineID" runat="server" Text='<%# Eval("MachineID") %>' ClientIDMode="Static"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Interface ID">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblInterfaceID" runat="server" Text='<%# Eval("InterfaceID") %>' ClientIDMode="Static"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="IP Address">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblIPAddress" runat="server" Text='<%# Eval("IPAddress") %>' ClientIDMode="Static"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>

                                                                    <asp:TemplateField HeaderText="Port Number">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblPortNumber" runat="server" Text='<%# Eval("IPPortNo") %>' ClientIDMode="Static"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                     <asp:TemplateField HeaderText="Protocol">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblIPPortNo" runat="server" Text='<%# Eval("Protocol") %>' ClientIDMode="Static"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="OEE Enabled?">
                                                                        <ItemTemplate>
                                                                            <asp:CheckBox runat="server" ID="chkOEEEnabled" ClientIDMode="Static" onclick="return false" Checked='<%# Eval("OEEEnabled") %>' />
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                      <asp:TemplateField HeaderText="CNC Param. Enabled?">
                                                                        <ItemTemplate>
                                                                            <asp:CheckBox runat="server" ID="chkCNCParamEnabled" ClientIDMode="Static" onclick="return false" Checked='<%# Eval("CNCParamEnabled") %>' />
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                      <asp:TemplateField HeaderText="Energy Enabled?">
                                                                        <ItemTemplate>
                                                                            <asp:CheckBox runat="server" ID="chkEnergyEnabled" ClientIDMode="Static" onclick="return false" Checked='<%# Eval("EneryEnabled") %>' />
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                      <asp:TemplateField HeaderText="AGI Enabled?">
                                                                        <ItemTemplate>
                                                                            <asp:CheckBox runat="server" ID="chkAGIEnabled" ClientIDMode="Static" onclick="return false" Checked='<%# Eval("AGIEnabled") %>' />
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Device Enabled?">
                                                                        <ItemTemplate>
                                                                            <asp:CheckBox runat="server" ID="chkDeviceEnabled" ClientIDMode="Static" onclick="return false" Checked='<%# Eval("DeviceEnabled") %>' />
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Action">
                                                                        <ItemTemplate>
                                                                            <asp:LinkButton runat="server" ID="lbMachineSataSourceEdit" CssClass="glyphicon glyphicon-pencil action-glypicon" OnClick="lbMachineSataSourceEdit_Click" ToolTip="Edit Machine"></asp:LinkButton>
                                                                  <%--          <asp:LinkButton runat="server" ID="lbMachineDelete" CssClass="glyphicon glyphicon-trash action-glypicon" OnClick="lbMachineDelete_Click" ToolTip="Delete Machine"></asp:LinkButton>--%>
                                                                            <%--OnClientClick="return openMachineNEModal(this,'Save');"--%>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                            <div class="modal-footer">
                                                <asp:Button runat="server" ID="btnMachineInsertUpdate" Text="Save" CssClass="Btns" OnClientClick="return machineDataInsertValidation();" ClientIDMode="Static" OnClick="btnMachineInsertUpdate_Click" />
                                                <button type="button" data-dismiss="modal" class="Btns">Close</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="modal infoModal" id="addEditMachineDataSource" role="dialog" style="min-width: 300px;" data-backdrop="static" data-keyboard="false">
                                    <div class="modal-dialog modal-dialog-centered " style="width: 60%">
                                        <div class="modal-content modalThemeCss">
                                            <div class="modal-header">
                                                <h4 class="modal-title">Add DataSource</h4>
                                                <asp:HiddenField runat="server" ClientIDMode="Static" ID="hdnMachineDataSourceStatus" />
                                            </div>
                                            <div class="modal-body" style="height: 60vh; overflow: auto">
                                                <span style="color: red" class="mandatory-message"></span>
                                                <div class="tab-pane">
                                                    <table style="width: 100%; margin: auto" class="modal-tbl">
                                                        <tr>
                                                            <td>Interface</td>
                                                            <td>
                                                                <asp:DropDownList runat="server" ID="ddlNEInterface" ClientIDMode="Static" CssClass="form-control  dropdown-list txtstyle" AutoPostBack="true" OnSelectedIndexChanged="ddlNEInterface_SelectedIndexChanged">
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td>IP Address</td>
                                                            <td>
                                                                <asp:TextBox runat="server" ID="txtNEIPAddress" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle allowDecimal"></asp:TextBox>
                                                            </td>
                                                            <td>Port Number</td>
                                                            <td>
                                                                <asp:TextBox runat="server" ID="txtNEPortNumber" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>Protocol</td>
                                                            <td>
                                                                <asp:DropDownList runat="server" ID="ddlNEProtocol" ClientIDMode="Static" CssClass="form-control  dropdown-list txtstyle"></asp:DropDownList>
                                                            </td>
                                                            <td>OEE Enabled?</td>
                                                            <td>
                                                                <asp:CheckBox runat="server" ID="chkNEOEEEnabled" ClientIDMode="Static" />
                                                            </td>
                                                            <td>AGI Enabled?</td>
                                                            <td>
                                                                <asp:CheckBox runat="server" ID="chkNEAGIEnabled" ClientIDMode="Static" />
                                                            </td>

                                                        </tr>
                                                        <tr>
                                                            <td>CNC Param Enabled?</td>
                                                            <td>
                                                                <asp:CheckBox runat="server" ID="chkNECNCParamEnabled" ClientIDMode="Static" />
                                                            </td>
                                                            <td>Energy Enabled?</td>
                                                            <td>
                                                                <asp:CheckBox runat="server" ID="chkNEEnergyEnabled" ClientIDMode="Static" />
                                                            </td>
                                                            <td>Device Enabled?</td>
                                                            <td>
                                                                <asp:CheckBox runat="server" ID="chkNEDeviceEnabled" ClientIDMode="Static" />
                                                            </td>
                                                        </tr>

                                                    </table>

                                                          
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <asp:Button runat="server" ID="btnMachineDataSourceInsertUpdate" Text="OK" CssClass="Btns" OnClientClick="return machineDataInsertValidation();" OnClick="btnMachineDataSourceInsertUpdate_Click" />
                                                <%--btnMachineInsertUpdate_Click--%>
                                                <button type="button" data-dismiss="modal" class="Btns">Close</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%--End Add and Edit Machine--%>

                                <div class="modal fade" id="machineDeleteConfirmModal" role="dialog">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content modalContent confirm-modal-content">
                                            <div class="modal-header modalHeader confirm-modal-header">
                                                <i class="glyphicon glyphicon glyphicon glyphicon-question-sign modal-icons"></i>
                                                <br />
                                                <h4 class="confirm-modal-title">Confirmation!</h4>
                                                <br />
                                                <span id="machineDeleteMsg" class="confirm-modal-msg">Are you sure you want to delete Records?</span>
                                            </div>
                                            <div class="modal-footer modalFooter modal-footer">
                                                <asp:Button runat="server" Text="Yes" ID="btnMachineDeleteConfirm" CssClass="confirm-modal-btn" OnClick="btnMachineDeleteConfirm_Click" OnClientClick="return clearTheModalScreen();" ClientIDMode="Static" />
                                                <input type="button" value="No" data-dismiss="modal" class="confirm-modal-btn" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnGroup" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnCompany" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnMachine" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnEmployee" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnRole" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnPlant" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnAssignMachineToPlant" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnUserRoleRights" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnUserRightException" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnMachineNew" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnMachineView" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
                <div id="LHmastermenu1" class="tab-pane fade">
                    <div>
                        <fieldset class="field-set" style="display: inline-block;">
                            <legend>&nbsp;<b>Filter By</b></legend>
                            <table class="filterTbl filter-field-table">
                                <tr>
                                    <td>Company
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="lblCompany_ForEmployee" ClientIDMode="Static" CssClass="form-control"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtEmployeeSearch" CssClass="form-control" placeholder="Search User ID" ClientIDMode="Static"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Button runat="server" ID="btnEmployeeView" ClientIDMode="Static" Text="View" CssClass="Btns" OnClick="btnEmployeeView_Click" />
                                        <asp:Button runat="server" ID="btnEmployeeNew" ClientIDMode="Static" Text="New User" CssClass="Btns" OnClick="btnEmployeeNew_Click" />
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </div>
                    <div class="gridContainer" style="margin-top: 10px; width: 95vw; overflow: auto">
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <div id="empoyeeGridContainer" style="height: 75vh; overflow: auto">
                                    <asp:GridView ID="gvEmployeeData" runat="server" AutoGenerateColumns="false" Width="100%" EmptyDataText="No Data Found." ShowHeaderWhenEmpty="true" ShowHeader="true" ShowFooter="false" ClientIDMode="Static" CssClass="P1Table">
                                        <Columns>
                                            <%-- <asp:TemplateField HeaderText="Company ID" Visible="false">
<ItemTemplate>
<asp:Label ID="lblCompanyID" runat="server" Text='<%# Eval("CompanyID") %>' ClientIDMode="Static"></asp:Label>
</ItemTemplate>
</asp:TemplateField>--%>
                                            <asp:TemplateField HeaderText="Corporate ID">
                                                <ItemTemplate>
                                                    <asp:HiddenField runat="server" ID="hdnEmpImageSource" ClientIDMode="Static" Value='<%# Eval("UserImageInBase64") %>' />
                                                    <asp:Label ID="lblCorporateID" runat="server" Text='<%# Eval("CorporateID") %>' ClientIDMode="Static"></asp:Label>
                                                    <asp:CheckBox runat="server" ID="chkIsGroupUser" Visible="false" Checked='<%# Eval("IsGroupUser") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="User ID">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblUserID" runat="server" Text='<%# Eval("UserID") %>' ClientIDMode="Static"></asp:Label>
                                                    <asp:HiddenField runat="server" ID="hfPassword" ClientIDMode="Static" Value='<%# Eval("Password") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Username">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblUsername" runat="server" Text='<%# Eval("Username") %>' ClientIDMode="Static"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="IoT ID">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblIOTID" runat="server" Text='<%# Eval("IOTID") %>' ClientIDMode="Static"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Address">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAddress" runat="server" Text='<%# Eval("Address") %>' ClientIDMode="Static"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Password" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPassword" runat="server" Text='<%# Eval("Password") %>' ClientIDMode="Static"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Email">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("Email") %>' ClientIDMode="Static"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Mobile No.">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMobileNo" runat="server" Text='<%# Eval("MobileNo") %>' ClientIDMode="Static"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Role">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRole" runat="server" Text='<%# Eval("Role") %>' ClientIDMode="Static"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Is Employee?">
                                                <ItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chkIsEmployee" ClientIDMode="Static" onclick="return false" Checked='<%# Eval("IsEmployee") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Employee ID">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblEmployeeID" runat="server" Text='<%# Eval("EmployeeID") %>' ClientIDMode="Static"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Effective From">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblEffectiveFromDate" runat="server" Text='<%# Eval("EffectiveFromDate") %>' ClientIDMode="Static"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Effective To">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblEffectiveToDate" runat="server" Text='<%# Eval("EffectiveToDate") %>' ClientIDMode="Static"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Action">
                                                <ItemTemplate>
                                                    <asp:LinkButton runat="server" ID="lblEmployeeEdit" CssClass="glyphicon glyphicon-pencil action-glypicon" OnClick="lblEmployeeEdit_Click" ToolTip="Edit Group"></asp:LinkButton>
                                                    <asp:LinkButton runat="server" ID="lblEmployeeDelete" CssClass="glyphicon glyphicon-trash action-glypicon" OnClick="lblEmployeeDelete_Click" ToolTip="Edit Group"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>

                                </div>
                                <%--Add and Edit Employee--%>
                                <div class="modal infoModal" id="addEditEmployeeInfo" role="dialog" style="min-width: 300px;" data-backdrop="static" data-keyboard="false">
                                    <div class="modal-dialog modal-dialog-centered " style="width: 50%">
                                        <div class="modal-content modalThemeCss">
                                            <div class="modal-header">
                                                <h4 class="modal-title">Add User</h4>
                                                <asp:HiddenField runat="server" ClientIDMode="Static" ID="hdnUserNEStatus" />
                                            </div>
                                            <div class="modal-body">
                                                <span style="color: red" class="mandatory-message"></span>
                                                <table style="width: 100%; margin: auto" class="modal-tbl addUpdateTbl">
                                                    <tr>
                                                        <td>User ID *</td>
                                                        <td>
                                                            <asp:HiddenField runat="server" ID="hdnEmpIsGroupUser" ClientIDMode="Static" />
                                                            <asp:HiddenField runat="server" ID="hdnEmpCorporateID" ClientIDMode="Static" />
                                                            <asp:TextBox runat="server" ID="txtEmpUserID" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                                        </td>
                                                        <td>User Name *</td>
                                                        <td>
                                                            <asp:TextBox runat="server" ID="txtEmpUerName" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                                        </td>

                                                    </tr>
                                                    <tr>
                                                        <td>IoT ID</td>
                                                        <td>
                                                            <asp:TextBox runat="server" ID="txtEmpIOTID" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                                        </td>
                                                        <td>Address</td>
                                                        <td>
                                                            <asp:TextBox runat="server" ID="txtEmpAddress" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle" TextMode="MultiLine" Style="resize: unset"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Password *</td>
                                                        <td>
                                                            <asp:TextBox runat="server" ID="txtEmpPassword" TextMode="Password" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                                        </td>
                                                        <td>Email</td>
                                                        <td>
                                                            <asp:TextBox runat="server" ID="txtEmpEmail" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Mobile No.</td>
                                                        <td>
                                                            <asp:TextBox runat="server" ID="txtEmpMobileNo" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle mobileNoValidation"></asp:TextBox>
                                                        </td>
                                                        <td>Role *</td>
                                                        <td>
                                                            <asp:DropDownList runat="server" ID="ddlEmpRole" ClientIDMode="Static" CssClass="form-control dropdown-list txtstyle"></asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>

                                                        <td>Is Employee?</td>
                                                        <td>
                                                            <asp:CheckBox runat="server" ID="chkEmpIsEmployee" ClientIDMode="Static" onchange="return showEmployeeIDInfo();" />
                                                        </td>
                                                        <td>Employee ID *</td>
                                                        <td>
                                                            <asp:TextBox runat="server" ID="txtEmpEmployeeID" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <%-- <tr>
<td>Image</td>
<td>
<asp:HiddenField runat="server" ID="hdnEmpImageSource" ClientIDMode="Static" />
<asp:FileUpload runat="server" ID="fuEmpImage" ClientIDMode="Static" Width="100%" onchange="showEmployeePhotoPreview()" style=" display: inline-block"/>
<i id="clearFuEmpImage" class="glyphicon glyphicon-remove" style="color: red; visibility: hidden; display: inline-block" onclick="clearEmployeeImageUploadData()"></i>
</td>
<td>
<asp:Image runat="server" ID="imgEmpImagePreview" ClientIDMode="Static" CssClass="rounded" Width="100px" Height="100px" ImageUrl="" />
</td>
<td>
<asp:Image runat="server" ID="imgEmpImage" ClientIDMode="Static" CssClass="rounded" Width="100px" Height="100px" ImageUrl="" />
</td>
</tr>--%>
                                                    <tr>
                                                        <td>Effective From *</td>
                                                        <td>
                                                            <asp:TextBox runat="server" ID="txtEmpEffectiveFromDate" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle" Style="position: relative" placeholder="DD-MM-YYYY"></asp:TextBox>
                                                        </td>
                                                        <td>Effective To *</td>
                                                        <td>
                                                            <asp:TextBox runat="server" ID="txtEmpEffectiveToDate" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle" Style="position: relative" placeholder="DD-MM-YYYY"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div class="modal-footer">
                                                <asp:Button runat="server" ID="btnEmployeeInserUpdate" Text="Save" CssClass="Btns" OnClientClick="return employeeDataInsertValidation();" OnClick="btnEmployeeInserUpdate_Click" />
                                                <button type="button" data-dismiss="modal" class="Btns">Close</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%--End Add and Edit Machine--%>

                                <div class="modal fade" id="employeeDeleteConfirmModal" role="dialog">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content modalContent confirm-modal-content">
                                            <div class="modal-header modalHeader confirm-modal-header">
                                                <i class="glyphicon glyphicon glyphicon glyphicon-question-sign modal-icons"></i>
                                                <br />
                                                <h4 class="confirm-modal-title">Confirmation!</h4>
                                                <br />
                                                <span id="userDeleteMsg" class="confirm-modal-msg">Are you sure you want to delete Records?</span>
                                            </div>
                                            <div class="modal-footer modalFooter modal-footer">
                                                <asp:Button runat="server" Text="Yes" ID="btnEmployeeDeleteConfirm" CssClass="confirm-modal-btn" OnClick="btnEmployeeDeleteConfirm_Click" OnClientClick="return clearTheModalScreen();" ClientIDMode="Static" />
                                                <input type="button" value="No" data-dismiss="modal" class="confirm-modal-btn" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnGroup" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnCompany" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnMachine" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnEmployee" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnRole" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnPlant" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnAssignMachineToPlant" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnUserRoleRights" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnUserRightException" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnEmployeeView" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnEmployeeNew" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>

                <div id="LHmastermenu2" class="tab-pane fade">
                    <div>
                        <fieldset class="field-set" style="display: inline-block;">
                            <legend>&nbsp;<b>Filter By</b></legend>
                            <table class="filterTbl filter-field-table">
                                <tr>
                                    <td>Company
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="lblCompany_ForRole" ClientIDMode="Static" CssClass="form-control"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtRoleNameSearch" AutoCompleteType="Disabled" CssClass="form-control" placeholder="Search Role Name" ClientIDMode="Static"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Button runat="server" ID="btnRoleView" ClientIDMode="Static" Text="View" CssClass="Btns" OnClick="btnRoleView_Click" />
                                        <asp:Button runat="server" ID="btnNewRole" ClientIDMode="Static" Text="New Role" CssClass="Btns" OnClientClick="return btnNewOrEditRoleClick(this,'New');" />
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </div>
                    <div class="gridContainer" style="margin-top: 10px; width: 95vw; overflow: auto">
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvRoleDetails" runat="server" AutoGenerateColumns="false" Width="53%" EmptyDataText="No Data Found." ShowHeaderWhenEmpty="true" ShowHeader="true" ClientIDMode="Static" CssClass="P1Table">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Company ID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCompanyID" runat="server" Text='<%# Eval("CompanyID") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Role ID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblRoleID" runat="server" Text='<%# Eval("RoleID") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Role Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblRoleName" runat="server" Text='<%# Eval("RoleName") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Effective From">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEffevtiveFromDate" runat="server" Text='<%# Eval("EffectiveFromDate") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Effective To">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEffevtiveToDate" runat="server" Text='<%# Eval("EffectiveToDate") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Action" Visible="false">
                                            <ItemTemplate>
                                                <asp:LinkButton runat="server" ID="lbEdit" CssClass="glyphicon glyphicon-pencil action-glypicon" OnClientClick="return btnNewOrEditRoleClick(this,'Edit')" ToolTip="Edit Role" Visible="false"></asp:LinkButton>
                                                <asp:LinkButton runat="server" ID="lbDeleteRole" CssClass="glyphicon glyphicon-trash action-glypicon" OnClick="lbDeleteRole_Click" ToolTip="Delete Role" Visible="false"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>

                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnGroup" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnCompany" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnMachine" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnEmployee" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnRole" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnPlant" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnAssignMachineToPlant" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnUserRoleRights" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnUserRightException" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnRoleView" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>

                <div id="LHmastermenu3" class="tab-pane fade">
                    <div>
                        <fieldset class="field-set" style="display: inline-block;">
                            <legend>&nbsp;<b>Filter By</b></legend>
                            <table class="filterTbl filter-field-table">
                                <tr>
                                    <td>
                                        <asp:Label runat="server" ID="Label1">Company </asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="lblCompany_ForPlant" CssClass="form-control"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtPlantSearch" CssClass="form-control" placeholder="Search PlantID" ClientIDMode="Static"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Button runat="server" ID="btnPlantView" ClientIDMode="Static" Text="View" CssClass="Btns" OnClick="btnPlantView_Click" />
                                        <asp:Button runat="server" ID="btnNewPlant" ClientIDMode="Static" Text="New Plant" CssClass="Btns" OnClientClick="return btnNewOrEditPlantClick(this,'New');" />
                                        &nbsp;&nbsp;
                                        <%--<asp:Button runat="server" ID="btnNext" ClientIDMode="Static" CssClass="glyphicon glyphicon-circle-arrow-right" OnClick="btnNext_Click" />--%>
                                        <%--    <asp:ImageButton runat="server" ID="btnNextImg" ClientIDMode="Static" OnClick="btnNextImg_Click" CssClass="glyphicon glyphicon-circle-arrow-right" />--%>
                                        <%-- <asp:LinkButton runat="server" ID="lbbtnNext" ClientIDMode="Static" OnClick="lbbtnNext_Click" CssClass="glyphicon glyphicon-circle-arrow-right" ToolTip="Next"></asp:LinkButton>--%>
                                        <asp:HiddenField runat="server" ID="hfSelectedPlant" ClientIDMode="Static" />
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </div>
                    <div class="gridContainer" style="margin-top: 10px; width: 95vw; overflow: auto">
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvPlantDetails" runat="server" AutoGenerateColumns="false" Width="100%" EmptyDataText="No Data Found." ShowHeaderWhenEmpty="true" ShowHeader="true" ClientIDMode="Static" CssClass="P1Table">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Company ID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCompanyID" runat="server" Text='<%# Eval("CompanyID") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Plant ID">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPlantID" runat="server" Text='<%# Eval("PlantID") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Plant Desc">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPlantDesc" runat="server" Text='<%# Eval("Description") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Code">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCode" runat="server" Text='<%# Eval("Code") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Address">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAddress" runat="server" Text='<%# Eval("Address") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Country">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCountry" runat="server" Text='<%# Eval("Country") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Region">
                                            <ItemTemplate>
                                                <asp:Label ID="lblRegion" runat="server" Text='<%# Eval("Region") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Geo Location">
                                            <ItemTemplate>
                                                <asp:Label ID="lblGeoLoaction" runat="server" Text='<%# Eval("GeoLocation") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="City">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCity" runat="server" Text='<%# Eval("City") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Effective From">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEffevtiveFromDate" runat="server" Text='<%# Eval("EffectiveFromDate") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Effective To">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEffevtiveToDate" runat="server" Text='<%# Eval("EffectiveToDate") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Action">
                                            <ItemTemplate>
                                                <asp:LinkButton runat="server" ID="lbEdit" CssClass="glyphicon glyphicon-pencil action-glypicon" OnClientClick="return btnNewOrEditPlantClick(this,'Edit')" ToolTip="Edit Plant"></asp:LinkButton>
                                                <asp:LinkButton runat="server" ID="lbDeletePlant" CssClass="glyphicon glyphicon-trash action-glypicon" OnClick="lbDeletePlant_Click" ToolTip="Delete Plant"></asp:LinkButton>
                                                <asp:LinkButton runat="server" ID="btnNavigateToCompanyHierarchy" CssClass="glyphicon glyphicon-share-alt navigation-icon" OnClick="btnNavigateToCompanyHierarchy_Click" ToolTip="Navigate To Company Hierarchy"></asp:LinkButton>
                                                <asp:LinkButton runat="server" ID="lbNavigateToPlantHierarchy" CssClass="glyphicon glyphicon-share-alt navigation-icon" OnClick="lbNavigateToPlantHierarchy_Click" ToolTip="Navigate To Plant Hierarchy"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnGroup" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnCompany" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnMachine" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnEmployee" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnRole" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnPlant" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnAssignMachineToPlant" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnUserRoleRights" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnUserRightException" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnPlantView" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnNewEditPlantSave" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnDeletePlantConfirm" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>


                <div id="LHmastermenu7" class="tab-pane fade">
                    <div>


                        <asp:UpdatePanel runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                            <ContentTemplate>


                                <div>
                                    <fieldset class="field-set" style="display: inline-block;">
                                        <legend>&nbsp;<b>Filter By</b></legend>
                                        <table class="filterTbl filter-field-table">
                                            <tr>
                                                <%--<td>Company</td>
                                                        <td>
                                                            <asp:Label runat="server" ID="lblCompany_ForAssignMachineToPlant" CssClass="form-control"></asp:Label>
                                                        </td>--%>
                                                <td>Company</td>
                                                <td>
                                                    <asp:Label runat="server" ID="lblCompany_ForAssignMachine" CssClass="form-control"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox runat="server" ID="txtSearchMachineID_ForAssignToPlant" CssClass="form-control" placeholder="Search MachineID" AutoCompleteType="Disabled"></asp:TextBox>
                                                </td>
                                                <td>Plant</td>
                                                <td>
                                                    <asp:ListBox ID="multiselectPlant" runat="server" SelectionMode="Multiple" CssClass="dropdown-list" ClientIDMode="Static"></asp:ListBox>
                                                </td>
                                                <td>
                                                    <asp:Button runat="server" ID="btnAssignMachineToPlantView" ClientIDMode="Static" Text="View" CssClass="Btns" OnClick="btnAssignMachineToPlantView_Click" />
                                                    <asp:Button runat="server" ID="btnAssignMachineToPlantSave" ClientIDMode="Static" Text="Save" CssClass="Btns" OnClick="btnAssignMachineToPlantSave_Click" />
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </div>
                                <div class="gridContainer" style="margin-top: 10px; width: 95vw; overflow: auto">


                                    <asp:GridView ID="gvAssignMahineToPlantDetails" runat="server" AutoGenerateColumns="false" Width="100%" EmptyDataText="No Data Found." ShowHeaderWhenEmpty="true" ShowHeader="true" ShowFooter="false" ClientIDMode="Static" CssClass="P1Table select-onecheckbox-eachrow" OnRowDataBound="gvAssignMahineToPlantDetails_RowDataBound">
                                        <Columns>
                                            <%--  <asp:TemplateField HeaderText="Company ID">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblCompanyID" runat="server" Text='<%# Eval("CompanyID") %>' ClientIDMode="Static"></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Machine ID">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblMachineID" runat="server" Text='<%# Eval("MachineID") %>' ClientIDMode="Static"></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>--%>
                                        </Columns>
                                    </asp:GridView>


                                </div>

                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnGroup" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnCompany" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnMachine" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnEmployee" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnRole" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnPlant" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnAssignMachineToPlant" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnUserRoleRights" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnUserRightException" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>

                </div>

                <div id="userRoleRightsMenu0" class="tab-pane fade">
                    <div>
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <fieldset class="field-set" style="display: inline-block;">
                                    <legend>&nbsp;<b>Filter By</b></legend>
                                    <table class="filterTbl filter-field-table">
                                        <tr>
                                            <td>Company</td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlCompany_ForUserRoleRights" CssClass="form-control dropdown-list" ClientIDMode="Static" AutoPostBack="true" OnSelectedIndexChanged="ddlCompany_ForUserRoleRights_SelectedIndexChanged"></asp:DropDownList>
                                            </td>
                                            <td>Role</td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlRole_ForUserRoleRights" CssClass="form-control dropdown-list" ClientIDMode="Static"></asp:DropDownList>
                                            </td>
                                            <td>
                                                <asp:Button runat="server" ID="btnUserRoleRightsView" Text="View" CssClass="Btns" OnClick="btnUserRoleRightsView_Click" />
                                                <asp:Button runat="server" ID="btnUserRoleRightsSave" Text="Save" CssClass="Btns" OnClick="btnUserRoleRightsSave_Click" />
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnUserRoleRights" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                    <div class="gridContainer" style="margin-top: 10px; width: 95vw; overflow: auto">
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <div id="userRoleRightsContainer" style="height: 75vh; overflow: auto">
                                    <asp:ListView runat="server" ID="lvUserRoleRightsDetails">
                                        <LayoutTemplate>
                                            <table class="P1Table userRightsTbl">
                                                <tr id="itemplaceholder" runat="server"></tr>
                                            </table>
                                        </LayoutTemplate>
                                        <ItemTemplate>
                                            <tr>
                                                <td>
                                                    <asp:Label runat="server" ID="lblCompanyID" ClientIDMode="Static" Text='<%# Eval("CompanyID") %>'></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="lblModule" ClientIDMode="Static" Text='<%# Eval("Module") %>'></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label runat="server" ID="lblScreen" ClientIDMode="Static" Text='<%# Eval("Screen") %>'></asp:Label>

                                                </td>
                                                <td style="padding: 0px">
                                                    <asp:ListView runat="server" ID="lvRoleAssignToScreenDetails" DataSource='<%# Eval("UserRightValue") %>'>
                                                        <LayoutTemplate>
                                                            <table class="userRightsInnerTbl">
                                                                <tr>
                                                                    <td id="itemplaceholder" runat="server"></td>
                                                                </tr>
                                                            </table>
                                                        </LayoutTemplate>
                                                        <ItemTemplate>
                                                            <td style="border-bottom: none; padding: 0px" class="userInfoTd">
                                                                <div style='display: <%# Eval("HeaderTemplateVisibility") %>'>
                                                                    <table class="templatesTbl radioAllBtnTbl">
                                                                        <tr>
                                                                            <td colspan="3" style="text-align: center">
                                                                                <asp:Label runat="server" ID="lblRoleID" ClientIDMode="Static" Text='<%# Eval("RoleID") %>'></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="border-bottom: none">Read
                                                                                 <asp:RadioButton GroupName="userRightAll" ID="RadioButton1" runat="server" Checked='<%# Eval("IsReadChecked") %>' onchange="return userRightExceptionRadioBtnClick(this,'All');" CssClass="rmnRadioBtns" />
                                                                            </td>
                                                                            <td style="border-bottom: none">Modify
                                                                                 <asp:RadioButton GroupName="userRightAll" ID="RadioButton2" runat="server" Checked='<%# Eval("IsModifyChcked") %>' onchange="return userRightExceptionRadioBtnClick(this,'All');" CssClass="rmnRadioBtns" />
                                                                            </td>
                                                                            <td style="border-bottom: none">None
                                                                                 <asp:RadioButton GroupName="userRightAll" ID="RadioButton3" runat="server" Checked='<%# Eval("IsNoneChacked") %>' onchange="return userRightExceptionRadioBtnClick(this,'All');" CssClass="rmnRadioBtns" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                                <div style='display: <%# Eval("DataTemplateVisibility") %>'>
                                                                    <table class="templatesTbl radioBtnTbl">
                                                                        <tr>
                                                                            <td>
                                                                                <asp:HiddenField runat="server" ID="hfRoleID" ClientIDMode="Static" Value='<%# Eval("RoleID") %>' />
                                                                                <asp:RadioButton ID="rbRead" GroupName="userRoleRight" runat="server" Checked='<%# Eval("IsReadChecked") %>' Style="border-bottom: none" CssClass="rmnRadioBtns" onchange="return userRightExceptionRadioBtnClick(this,'');" />
                                                                            </td>
                                                                            <td>
                                                                                <asp:RadioButton ID="rbModify" GroupName="userRoleRight" runat="server" Checked='<%# Eval("IsModifyChcked") %>' Style="border-bottom: none" CssClass="rmnRadioBtns" onchange="return userRightExceptionRadioBtnClick(this,'');" />
                                                                            </td>
                                                                            <td>
                                                                                <asp:RadioButton ID="rbNone" GroupName="userRoleRight" runat="server" Checked='<%# Eval("IsNoneChacked") %>' Style="border-bottom: none" CssClass="rmnRadioBtns" onchange="return userRightExceptionRadioBtnClick(this,'');" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>


                                                                </div>
                                                            </td>
                                                        </ItemTemplate>
                                                    </asp:ListView>
                                                </td>

                                            </tr>
                                        </ItemTemplate>
                                    </asp:ListView>
                                </div>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnGroup" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnCompany" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnMachine" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnEmployee" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnRole" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnPlant" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnAssignMachineToPlant" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnUserRoleRights" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnUserRightException" EventName="Click" />

                            </Triggers>
                        </asp:UpdatePanel>
                    </div>

                </div>
                <div id="userRightExceptionMenu1" class="tab-pane fade">

                    <div>
                        <fieldset class="field-set" style="display: inline-block;">
                            <legend>&nbsp;<b>Filter By</b></legend>
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <table class="filterTbl filter-field-table">
                                        <tr>
                                            <td>Company ID
                                            </td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlUserRightExptnCompany" ClientIDMode="Static" CssClass="form-control dropdown-list txtstyle" OnSelectedIndexChanged="ddlUserRightExptnCompany_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                            </td>
                                            <td>Role
                                            </td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlUserRightExptnRole" ClientIDMode="Static" CssClass="form-control dropdown-list txtstyle"></asp:DropDownList>
                                            </td>
                                            <td>
                                                <asp:Button runat="server" ID="btnUserRightExptnView" Text="View" CssClass="Btns" OnClick="btnUserRightExptnView_Click" OnClientClick="return userRightExceptionViewValidation();" />
                                                <asp:Button runat="server" ID="btnUserATRoleSave" Text="Save" CssClass="Btns" OnClick="btnUserATRoleSave_Click" />
                                            </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </fieldset>
                    </div>
                    <div class="gridContainer" style="margin-top: 10px; width: 95vw; overflow: auto">
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <div class="row" style="padding-left: 10px">


                                    <div style="width: 9%; display: inline-block">
                                        <asp:Button runat="server" ID="btnUserRightEcptnUserIdView" Text="View" CssClass="Btns" OnClick="btnUserRightEcptnUserIdView_Click" OnClientClick="return userRightExceptionUserIDViewValidation();" />
                                        <br />
                                        <br />
                                        <div id="userIDListContainer" style="height: 72vh; overflow: auto;">
                                            <asp:GridView runat="server" ID="gvUserIDList" CssClass="P1Table" EmptyDataText="No Data Found." AutoGenerateColumns="false" ShowHeaderWhenEmpty="true" ShowHeader="true" Width="100%" ClientIDMode="Static">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="User ID">
                                                        <ItemTemplate>
                                                            <asp:CheckBox runat="server" ID="chkUserIDChecked" ClientIDMode="Static" Checked="true" />&nbsp;
                                                            <asp:Label runat="server" ID="lblUserID" Text='<%# Eval("UserID") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </div>
                                    <div id="userAsignedContainer" style="height: 75vh; overflow: auto; width: 89%; display: inline-block; vertical-align: top">
                                        <asp:ListView runat="server" ID="lvUserAssignedToRole">
                                            <LayoutTemplate>
                                                <table class="P1Table userRightsTbl" id="userRightException">
                                                    <tr id="itemplaceholder" runat="server"></tr>
                                                </table>
                                            </LayoutTemplate>
                                            <ItemTemplate>
                                                <tr>
                                                    <td>
                                                        <asp:Label runat="server" ID="lblCompanyID" Text='<%# Eval("CompanyID") %>'></asp:Label></td>
                                                    <td>
                                                        <asp:Label runat="server" ID="lblModule" Text='<%# Eval("Module") %>'></asp:Label></td>
                                                    <td>
                                                        <asp:Label runat="server" ID="lblScreen" Text='<%# Eval("Screen") %>'></asp:Label></td>
                                                    <td style="padding: 0px">
                                                        <asp:ListView runat="server" ID="lvUserAssignedToRoleRights" DataSource='<%# Eval("UserRightValue") %>'>
                                                            <LayoutTemplate>
                                                                <table class="userRightsInnerTbl" id="userInfoTbl">
                                                                    <tr>
                                                                        <td id="itemplaceholder" runat="server"></td>
                                                                    </tr>
                                                                </table>
                                                            </LayoutTemplate>
                                                            <ItemTemplate>
                                                                <td style="border-bottom: none; padding: 0px" class="userInfoTd">
                                                                    <div style='display: <%# Eval("HeaderTemplateVisibility") %>'>
                                                                        <table class="templatesTbl radioAllBtnTbl">
                                                                            <tr>
                                                                                <td colspan="3" style="text-align: center">
                                                                                    <asp:Label runat="server" ID="lblUserID" ClientIDMode="Static" Text='<%# Eval("UserID") %>'></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="border-bottom: none">Read
                                                                                 <asp:RadioButton GroupName="userRightAll" ID="RadioButton1" runat="server" Checked='<%# Eval("IsReadChecked") %>' onchange="return userRightExceptionRadioBtnClick(this,'All');" CssClass="rmnRadioBtns" />
                                                                                </td>
                                                                                <td style="border-bottom: none">Modify
                                                                                 <asp:RadioButton GroupName="userRightAll" ID="RadioButton2" runat="server" Checked='<%# Eval("IsModifyChcked") %>' onchange="return userRightExceptionRadioBtnClick(this,'All');" CssClass="rmnRadioBtns" />
                                                                                </td>
                                                                                <td style="border-bottom: none">None
                                                                                <asp:RadioButton GroupName="userRightAll" ID="RadioButton3" runat="server" Checked='<%# Eval("IsNoneChacked") %>' onchange="return userRightExceptionRadioBtnClick(this,'All');" CssClass="rmnRadioBtns" />
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </div>
                                                                    <div style='display: <%# Eval("DataTemplateVisibility") %>'>
                                                                        <table class="templatesTbl radioBtnTbl">
                                                                            <tr>
                                                                                <td style="border-bottom: none">

                                                                                    <asp:RadioButton GroupName="userRight" ID="rbRead" runat="server" Checked='<%# Eval("IsReadChecked") %>' CssClass="rmnRadioBtns" onchange="return userRightExceptionRadioBtnClick(this,'');" />
                                                                                </td>
                                                                                <td style="border-bottom: none">
                                                                                    <asp:RadioButton GroupName="userRight" ID="rbModify" runat="server" Checked='<%# Eval("IsModifyChcked") %>' CssClass="rmnRadioBtns" onchange="return userRightExceptionRadioBtnClick(this,'');" />
                                                                                </td>
                                                                                <td style="border-bottom: none">
                                                                                    <asp:RadioButton GroupName="userRight" ID="rbNone" runat="server" Checked='<%# Eval("IsNoneChacked") %>' CssClass="rmnRadioBtns" onchange="return userRightExceptionRadioBtnClick(this,'');" />
                                                                                </td>
                                                                            </tr>
                                                                        </table>


                                                                    </div>
                                                                </td>
                                                            </ItemTemplate>
                                                        </asp:ListView>
                                                    </td>

                                                </tr>
                                            </ItemTemplate>
                                        </asp:ListView>
                                    </div>
                                </div>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnGroup" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnCompany" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnMachine" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnEmployee" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnRole" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnPlant" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnAssignMachineToPlant" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnUserRightExptnView" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnUserATRoleSave" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnUserRoleRights" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnUserRightException" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-------  Warning and Error Modal -------->
    <div class="modal fade" id="warningModal" role="dialog" style="z-index: 2000">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content modalContent warning-modal-content">
                <div class="modal-header modalHeader warning-modal-header">
                    <i class="glyphicon glyphicon-warning-sign modal-icons"></i>
                    <br />
                    <h4 class="warning-modal-title">Warning</h4>
                    <br />
                    <span class="warning-modal-msg" id="lblWarningMsg">...</span>
                </div>
                <div class="modal-footer modalFooter modal-footer">
                    <input type="button" value="OK" class="warning-modal-btn" data-dismiss="modal" />
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="errorModal" role="dialog" style="z-index: 2000">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content modalContent error-modal-content">
                <div class="modal-header modalHeader error-modal-header">
                    <i class="glyphicon glyphicon-remove-sign modal-icons"></i>
                    <br />
                    <h4 class="error-modal-title">Error</h4>
                    <br />
                    <span class="error-modal-msg" id="lblErrorMsg">...</span>
                </div>
                <div class="modal-footer modalFooter modal-footer">
                    <input type="button" value="OK" class="error-modal-btn" data-dismiss="modal" />
                </div>
            </div>
        </div>
    </div>

    <!------------------------------Company Details--------------------------------->

    <div class="modal fade" id="companyDeleteConfirmModal" role="dialog">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content modalContent confirm-modal-content">
                <div class="modal-header modalHeader confirm-modal-header">
                    <i class="glyphicon glyphicon glyphicon glyphicon-question-sign modal-icons"></i>
                    <br />
                    <h4 class="confirm-modal-title">Confirmation!</h4>
                    <br />
                    <span id="companyDeleteMsg" class="confirm-modal-msg"></span>
                </div>
                <div class="modal-footer modalFooter modal-footer">
                    <asp:Button runat="server" Text="Yes" ID="btnDeleteCompanyConfirm" CssClass="confirm-modal-btn" OnClick="btnDeleteCompanyConfirm_Click" ClientIDMode="Static" />
                    <input type="button" value="No" data-dismiss="modal" class="confirm-modal-btn" />
                </div>
            </div>
        </div>
    </div>

    <div class="modal infoModal" id="neweditCompanyModal" role="dialog" style="min-width: 300px;" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modal-dialog-centered " style="width: 41%">
            <div class="modal-content modalThemeCss">
                <div class="modal-header">
                    <h4 class="modal-title"></h4>
                    <asp:HiddenField runat="server" ID="hfComoanyNewEdit" ClientIDMode="Static" />
                </div>
                <div class="modal-body" style="padding-left: 0px; padding-right: 0px">
                    <span style="color: red; margin-left: 20px;" class="mandatory-message"></span>
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>


                            <div style="padding-left: 15px; padding-right: 15px; padding-bottom: 8px;" class="div-border-style">
                                <table style="width: 100%; margin: auto" class="modal-tbl">
                                    <tr>
                                        <td>Group</td>
                                        <td>
                                            <asp:DropDownList runat="server" ID="ddlGroup_ForCompany" ClientIDMode="Static" CssClass="form-control dropdown-list txtstyle"></asp:DropDownList>
                                        </td>
                                        <td></td>
                                        <td style="width: 230px"></td>
                                    </tr>
                                </table>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnCompany" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                    <div style="padding-left: 15px; padding-right: 15px; padding-bottom: 8px; padding-top: 8px;" class="div-border-style">
                        <table id="tblNewCompany" style="width: 100%; margin: auto" class="modal-tbl">
                            <tr>
                                <td>Company ID *</td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtCompanyID" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                </td>
                                <td>Company Name *</td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtCompanyName" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Contact Person</td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtCompanyContactPerson" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                </td>
                                <td>Place</td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtCompanyPlace" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Country</td>
                                <td>
                                    <asp:DropDownList runat="server" ID="ddlCompanyCountry" ClientIDMode="Static" CssClass="form-control dropdown-list txtstyle"></asp:DropDownList>
                                </td>
                                <td>State</td>
                                <td>
                                    <asp:DropDownList runat="server" ID="ddlCompanyState" ClientIDMode="Static" CssClass="form-control dropdown-list txtstyle"></asp:DropDownList>
                                </td>

                            </tr>

                            <tr>
                                <td>Pin</td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtCompanyPin" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle pin-validation"></asp:TextBox>
                                </td>
                                <td>Address</td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtCompanyAddress" TextMode="MultiLine" Style="resize: unset" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>

                                <td>Email</td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtCompanyEmail" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                </td>
                                <td>Phone</td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtCompanyPhone" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle mobileNoValidation"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Effective From *</td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtCompanyEffFromDate" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle" Style="position: relative" placeholder="DD-MM-YYYY HH:mm:ss"></asp:TextBox>
                                </td>
                                <td>Effective To *</td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtCompanyEffToDate" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle" Style="position: relative" placeholder="DD-MM-YYYY HH:mm:ss"></asp:TextBox>
                                </td>
                            </tr>

                        </table>
                    </div>
                    <div style="padding-left: 15px; padding-right: 15px; padding-top: 8px;">
                        <table style="width: 100%; margin: auto" class="modal-tbl">
                            <tr>
                                <td colspan="4">Company Admin</td>
                            </tr>
                            <tr>
                                <td>User ID *</td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtCompanyUserId" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                </td>
                                <td>Password *</td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtCompanyUserPassword" ClientIDMode="Static" TextMode="Password" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </div>

                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" ID="btnNewEditCompanySave" Text="Save" CssClass="Btns" OnClientClick="return btnNewEditCompanySaveClick();" OnClick="btnNewEditCompanySave_Click" AccessKey="S" role="dialog" />
                    <button type="button" data-dismiss="modal" class="Btns" accesskey="C">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!------------------------------End Company Details------------------------------->


    <!------------------------------Group Details------------------------------->
    <div class="modal fade" id="groupDeleteConfirmModal" role="dialog">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content modalContent confirm-modal-content">
                <div class="modal-header modalHeader confirm-modal-header">
                    <i class="glyphicon glyphicon glyphicon glyphicon-question-sign modal-icons"></i>
                    <br />
                    <h4 class="confirm-modal-title">Confirmation!</h4>
                    <br />
                    <span id="groupDeleteMsg" class="confirm-modal-msg">Are you sure you want to delete Record?</span>
                </div>
                <div class="modal-footer modalFooter modal-footer">
                    <asp:Button runat="server" Text="Yes" ID="btnDeleteGroupConfirm" CssClass="confirm-modal-btn" OnClick="btnDeleteGroupConfirm_Click" ClientIDMode="Static" />
                    <input type="button" value="No" data-dismiss="modal" class="confirm-modal-btn" />
                </div>
            </div>
        </div>
    </div>

    <div class="modal infoModal" id="neweditGroupModal" role="dialog" style="min-width: 300px;" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modal-dialog-centered " style="width: 41%">
            <div class="modal-content modalThemeCss">
                <div class="modal-header">
                    <h4 class="modal-title"></h4>
                    <asp:HiddenField runat="server" ID="hfGroupEditNew" ClientIDMode="Static" />
                </div>
                <div class="modal-body">
                    <span style="color: red" class="mandatory-message"></span>
                    <table id="tblNewGroup" style="width: 100%; margin: auto" class="modal-tbl">
                        <tr>
                            <td>Group ID *</td>
                            <td>
                                <asp:TextBox runat="server" ID="txtGroupId" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                            </td>
                            <td>Group Name *</td>
                            <td>
                                <asp:TextBox runat="server" ID="txtGroupName" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Contact Person</td>
                            <td>
                                <asp:TextBox runat="server" ID="txtGroupContactPerson" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                            </td>
                            <td>Place</td>
                            <td>
                                <asp:TextBox runat="server" ID="txtGroupPlace" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Country</td>
                            <td>
                                <%--       <asp:TextBox runat="server" ID="txtGroupCountry" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>--%>
                                <asp:DropDownList runat="server" ID="ddlGroupCountry" ClientIDMode="Static" CssClass="form-control dropdown-list txtstyle"></asp:DropDownList>
                            </td>
                            <td>State</td>
                            <td>
                                <%--  <asp:TextBox runat="server" ID="txtGroupState" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>--%>
                                <asp:DropDownList runat="server" ID="ddlGroupState" ClientIDMode="Static" CssClass="form-control dropdown-list txtstyle"></asp:DropDownList>
                            </td>

                        </tr>

                        <tr>
                            <td>Pin</td>
                            <td>
                                <asp:TextBox runat="server" ID="txtGroupPin" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle pin-validation"></asp:TextBox>
                            </td>
                            <td>Address</td>
                            <td>
                                <asp:TextBox runat="server" ID="txtGroupAddress" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle" TextMode="MultiLine" Style="resize: unset"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Email</td>
                            <td>
                                <asp:TextBox runat="server" ID="txtGroupEmail" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                            </td>
                            <td>Phone</td>
                            <td>
                                <asp:TextBox runat="server" ID="txtGroupPhone" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle mobileNoValidation"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Effective From *</td>
                            <td>
                                <asp:TextBox runat="server" ID="txtGroupEffFromDate" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle" Style="position: relative" placeholder="DD-MM-YYYY"></asp:TextBox>
                            </td>
                            <td>Effective To *</td>
                            <td>
                                <asp:TextBox runat="server" ID="txtGroupEffToDate" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle" Style="position: relative" placeholder="DD-MM-YYYY"></asp:TextBox>
                            </td>
                        </tr>
                    </table>

                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" ID="btnNewEditGroupSave" Text="Save" CssClass="Btns" OnClientClick="return btnNewEditGroupSaveClick();" OnClick="btnNewEditGroupSave_Click" AccessKey="S" />
                    <button type="button" data-dismiss="modal" class="Btns" accesskey="C">Close</button>
                </div>
            </div>
        </div>
    </div>


    <!------------------------------End Group Details------------------------------->

    <%-- ---------------------------Plant Modals----------------------------------------------- --%>
    <div class="modal infoModal" id="neweditPlantModal" role="dialog" style="min-width: 300px;" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modal-dialog-centered " style="width: 38%">
            <div class="modal-content modalThemeCss">
                <div class="modal-header">
                    <h4 class="modal-title"></h4>
                    <asp:HiddenField runat="server" ID="hfPlantEditNew" ClientIDMode="Static" />
                </div>
                <div class="modal-body" style="padding-left: 0px; padding-right: 0px">
                    <span style="color: red; margin-left: 20px;" class="mandatory-message"></span>
                    <div style="padding-left: 15px; padding-right: 15px; padding-bottom: 8px;" class="div-border-style">
                        <table style="width: 100%; margin: auto" class="modal-tbl">
                            <tr>
                                <td>Company</td>
                                <td>
                                    <%-- <asp:DropDownList runat="server" ID="ddlCompany_ForPlant" ClientIDMode="Static" CssClass="form-control dropdown-list txtstyle">
                                        </asp:DropDownList>--%>
                                    <asp:Label runat="server" ID="lblCompany_ForPlantNewEdit" CssClass="form-control"></asp:Label>
                                </td>
                                <td></td>
                                <td style="width: 35%"></td>
                            </tr>
                        </table>
                    </div>
                    <div style="padding-left: 15px; padding-right: 15px; padding-top: 8px;">
                        <table style="width: 100%; margin: auto" class="modal-tbl addUpdateTbl">
                            <tr>
                                <td>Plant ID *</td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtPlantID" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                </td>
                                <td>Plant Desc</td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtPlantDesc" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Code</td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtPlantCode" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                </td>
                                <td>Address</td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtPlantAddress" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle" TextMode="MultiLine" Style="resize: unset"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Country</td>
                                <td>
                                    <%--  <asp:TextBox runat="server" ID="txtPlantCountry" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>--%>

                                    <asp:DropDownList runat="server" ID="ddlPlantCountry" ClientIDMode="Static" CssClass="form-control dropdown-list txtstyle"></asp:DropDownList>
                                </td>
                                <td>Region</td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtPlantRegion" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                </td>

                            </tr>
                            <tr>
                                <td>Geo Location</td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtPlantGeoLocation" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                </td>
                                <td>City</td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtPlatCity" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Effective From *</td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtPlantEffFromDate" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle" Style="position: relative" placeholder="DD-MM-YYYY HH:mm:ss"></asp:TextBox>
                                </td>
                                <td>Effective To *</td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtPlantEffToDate" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle" Style="position: relative" placeholder="DD-MM-YYYY HH:mm:ss"></asp:TextBox>
                                </td>
                            </tr>

                        </table>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" ID="btnNewEditPlantSave" Text="Save" CssClass="Btns" OnClientClick="return btnNewEditPlantSaveClick();" OnClick="btnNewEditPlantSave_Click" />
                    <button type="button" data-dismiss="modal" class="Btns">Close</button>
                </div>
            </div>
        </div>
    </div>


    <div class="modal fade" id="plantDeleteConfirmModal" role="dialog">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content modalContent confirm-modal-content">
                <div class="modal-header modalHeader confirm-modal-header">
                    <i class="glyphicon glyphicon glyphicon glyphicon-question-sign modal-icons"></i>
                    <br />
                    <h4 class="confirm-modal-title">Confirmation!</h4>
                    <br />
                    <span id="plantDeleteMsg" class="confirm-modal-msg">Are you sure you want to delete Record?</span>
                </div>
                <div class="modal-footer modalFooter modal-footer">
                    <asp:Button runat="server" Text="Yes" ID="btnDeletePlantConfirm" CssClass="confirm-modal-btn" OnClick="btnDeletePlantConfirm_Click" ClientIDMode="Static" />
                    <input type="button" value="No" data-dismiss="modal" class="confirm-modal-btn" />
                </div>
            </div>
        </div>
    </div>
    <%-------------------------------------- End Plant Modals ---------------------------------- --%>


    <%-- ---------------------------Role Modals----------------------------------------------- --%>
    <div class="modal infoModal" id="neweditRoleModal" role="dialog" style="min-width: 300px;" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modal-dialog-centered " style="width: 38%">
            <div class="modal-content modalThemeCss">
                <div class="modal-header">
                    <h4 class="modal-title"></h4>
                    <asp:HiddenField runat="server" ID="hfRoleNewEdit" ClientIDMode="Static" />
                </div>
                <div class="modal-body" style="padding-left: 0px; padding-right: 0px">
                    <span style="color: red; margin-left: 20px;" class="mandatory-message"></span>
                    <div style="padding-left: 15px; padding-right: 15px; padding-bottom: 8px;" class="div-border-style">
                        <table style="width: 100%; margin: auto" class="modal-tbl">
                            <tr>
                                <td>Company *</td>
                                <td>
                                    <asp:Label runat="server" ID="lblCompany_ForRoleNewEdit" CssClass="form-control" ClientIDMode="Static"></asp:Label>
                                </td>
                                <td></td>
                                <td style="width: 267px"></td>
                            </tr>
                        </table>
                    </div>
                    <div style="padding-left: 15px; padding-right: 15px; padding-top: 8px;">
                        <table style="width: 100%; margin: auto" class="modal-tbl addUpdateTbl">
                            <tr>
                                <td>Role Name</td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtRoleName" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                </td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Effective From *</td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtRoleEffFromDate" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle" Style="position: relative" placeholder="DD-MM-YYYY HH:mm:ss"></asp:TextBox>
                                </td>
                                <td>Effective To *</td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtRoleEffToDate" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle" Style="position: relative" placeholder="DD-MM-YYYY HH:mm:ss"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" ID="btnNewEditRoleSave" Text="Save" CssClass="Btns" OnClientClick="return btnNewEditRoleSaveClick();" OnClick="btnNewEditRoleSave_Click" />
                    <button type="button" data-dismiss="modal" class="Btns">Close</button>
                </div>
            </div>
        </div>
    </div>


    <div class="modal fade" id="roleDeleteConfirmModal" role="dialog">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content modalContent confirm-modal-content">
                <div class="modal-header modalHeader confirm-modal-header">
                    <i class="glyphicon glyphicon glyphicon glyphicon-question-sign modal-icons"></i>
                    <br />
                    <h4 class="confirm-modal-title">Confirmation!</h4>
                    <br />
                    <span id="roleDeleteMsg" class="confirm-modal-msg">Are you sure you want to delete Record?</span>
                </div>
                <div class="modal-footer modalFooter modal-footer">
                    <asp:Button runat="server" Text="Yes" ID="btnDeleteRoleConfirm" CssClass="confirm-modal-btn" OnClick="btnDeleteRoleConfirm_Click" ClientIDMode="Static" />
                    <input type="button" value="No" data-dismiss="modal" class="confirm-modal-btn" />
                </div>
            </div>
        </div>
    </div>
    <%-------------------------------------- End Role Modals ---------------------------------- --%>

    <script>
        var submenu = "", machineSubMenu = "";
        $(document).ready(function () {
            debugger;
            activeSubMenu();
            // setGridHeight();
            activeMachineMenu();
            setDateTimePicker();

            //if (machineSubMenu == "#MachineDataSource") {
            //    $("#btnMachineInsertUpdate").css('display', 'none');
            //} else {
            //    $("#btnMachineInsertUpdate").css('display', 'inline-block');
            //}
        });
        function activeSubMenu() {
            //alert(localStorage.getItem("lhmselected_sub_SubMenu"));
            if (localStorage.getItem("gcselectedSubMenu")) {

                if (localStorage.getItem("gcselectedSubMenu")) {
                    debugger;
                    submenu = localStorage.getItem("gcselectedSubMenu");
                }
                $(submenu).addClass("in active");
                $("a[href$='" + submenu + "']").removeClass("selected-menu-style").addClass("selected-Submenu");
                $("a[href$='" + submenu + "']").closest('li').find('i').addClass("arrow up selected-Submenu-ArrowUp");
            } else {
                $(".sub-sub-menudiv").removeClass("in active");
            }
        }

        function activeMachineMenu() {
            if (localStorage.getItem("machineselectedSubMenu")) {
                if (localStorage.getItem("machineselectedSubMenu")) {
                    debugger;
                    submenu = localStorage.getItem("machineselectedSubMenu");
                }
                $(submenu).addClass("in active");
                $("a[href$='" + submenu + "']").removeClass("selected-menu-style").addClass("selected-machine-menu");
                $("a[href$='" + submenu + "']").closest('li').find('i').addClass("arrow up selected-Submenu-ArrowUp");
            } else {
                $(".sub-sub-menudiv").removeClass("in active");
            }
        }
        //var inputs = $element.find('select, input, textarea, button, a').filter(':visible');
        //var firstInput = inputs.first();
        //var lastInput = inputs.last();


        //firstInput.focus();

        //lastInput.on('keydown', function (e) {
        //    if ((e.which === 9 && !e.shiftKey)) {
        //        e.preventDefault();
        //        firstInput.focus();
        //    }
        //});

        //firstInput.on('keydown', function (e) {
        //    if ((e.which === 9 && e.shiftKey)) {
        //        e.preventDefault();
        //        lastInput.focus();
        //    }
        //});

        //$('#neweditGroupModal :input:first').focus();

        //$('#neweditGroupModal :input:last').on('keydown', function (e) {
        //    if ($("this:focus") && (e.which == 9)) {
        //        e.preventDefault();
        //        $('#neweditGroupModal :input:first').focus();
        //    }
        //});



        function setDateTimePicker() {
            $('[id$=txtGroupEffFromDate]').datetimepicker({
                format: 'DD-MM-YYYY HH:mm:ss',
                locale: 'en-US'
            });
            $('[id$=txtGroupEffToDate]').datetimepicker({
                format: 'DD-MM-YYYY HH:mm:ss',
                locale: 'en-US'
            });
            $('[id$=txtCompanyEffFromDate]').datetimepicker({
                format: 'DD-MM-YYYY HH:mm:ss',
                locale: 'en-US'
            });
            $('[id$=txtCompanyEffToDate]').datetimepicker({
                format: 'DD-MM-YYYY HH:mm:ss',
                locale: 'en-US'
            });
            $('[id$=txtPlantEffFromDate]').datetimepicker({
                format: 'DD-MM-YYYY HH:mm:ss',
                locale: 'en-US'
            });
            $('[id$=txtPlantEffToDate]').datetimepicker({
                format: 'DD-MM-YYYY HH:mm:ss',
                locale: 'en-US'
            });
            $('[id$=txtRoleEffFromDate]').datetimepicker({
                format: 'DD-MM-YYYY HH:mm:ss',
                locale: 'en-US'
            });
            $('[id$=txtRoleEffToDate]').datetimepicker({
                format: 'DD-MM-YYYY HH:mm:ss',
                locale: 'en-US'
            });

            $('[id$=multiselectPlant]').multiselect({
                includeSelectAllOption: true
            });

        }
        function setActiveSubmenuValue() {
            debugger;
            //localStorage.setItem("gcselectedSubMenu", "#GCmastermenu0");
            var lilist = $("#masterul li");
            for (let i = 0; i < lilist.length; i++) {
                let li = lilist[i];
                let display = $(li).css('display');
                debugger;
                if (display == "block") {
                    localStorage.setItem("gcselectedSubMenu", $(li).find('a').attr('href'));
                    activeSubMenu();
                    enterBlock = true;
                    break;
                }
            }
            localStorage.setItem("machineselectedSubMenu", "#MachineInformation");
        }

        $(".machinesubmenuData").click(function () {
            machineSubMenu;
            if ($("#mainBody").hasClass("light-mode")) {
                $(".machinesubmenuData").removeClass("selected-menu-style selected-Submenu").addClass("other-menu-style");
                $(".machinesubmenuData").closest('li').find('i').removeClass();
                $(this).removeClass("other-menu-style selected-Submenu").addClass("selected-machine-menu");
            } else {
                $(".machinesubmenuData").removeClass("selected-menu-style selected-Submenu").addClass("other-menu-style");
                $(".machinesubmenuData").closest('li').find('i').removeClass();
                $(this).removeClass("other-menu-style selected-Submenu").addClass("selected-machine-menu");
            }
            $(this).closest('li').find('i').addClass("arrow up selected-Submenu-ArrowUp");
            machineSubMenu = $(this).attr('href');
            //$("#activeMenu").val(submenu);
            $(machineSubMenu).addClass("in active");
            localStorage.setItem("machineselectedSubMenu", machineSubMenu);
        });
        $(".submenuData").click(function () {
            debugger;
            //$('[id*=hdnScrollPos]').val(0);
            $.blockUI({ message: '<img runat="server" src="Images/Loading.gif" />' });
            if ($("#mainBody").hasClass("light-mode")) {
                $(".submenuData").removeClass("selected-menu-style selected-Submenu").addClass("other-menu-style");
                $(".submenuData").closest('li').find('i').removeClass();
                $(this).removeClass("other-menu-style selected-Submenu").addClass("selected-menu-style");
            } else {
                $(".submenuData").removeClass("selected-menu-style selected-Submenu").addClass("other-menu-style");
                $(".submenuData").closest('li').find('i').removeClass();
                $(this).removeClass("other-menu-style selected-Submenu").addClass("selected-menu-style");
            }

            $(this).closest('li').find('i').addClass("arrow up selected-Submenu-ArrowUp");
            submenu = $(this).attr('href');
            //$("#activeMenu").val(submenu);
            $(submenu).addClass("in active");
            if (submenu == "#GCmastermenu0") {
                __doPostBack('<%= btnGroup.UniqueID%>', '');
            }
            else if (submenu == "#GCmastermenu1") {
                __doPostBack('<%= btnCompany.UniqueID%>', '');
            } else if (submenu == "#LHmastermenu0") {
                __doPostBack('<%= btnMachine.UniqueID%>', '');
            }
            else if (submenu == "#LHmastermenu1") {
                __doPostBack('<%= btnEmployee.UniqueID%>', '');
            }
            else if (submenu == "#LHmastermenu2") {
                __doPostBack('<%= btnRole.UniqueID%>', '');
            }
            else if (submenu == "#LHmastermenu3") {
                __doPostBack('<%= btnPlant.UniqueID%>', '');
            } else if (submenu == "#LHmastermenu7") {
                __doPostBack('<%= btnAssignMachineToPlant.UniqueID%>', '');
            } else if (submenu == "#userRoleRightsMenu0") {
                __doPostBack('<%= btnUserRoleRights.UniqueID%>', '');
            }
            else if (submenu == "#userRightExceptionMenu1") {
                __doPostBack('<%= btnUserRightException.UniqueID%>', '');
            }
            localStorage.setItem("gcselectedSubMenu", submenu);
        });

        //------------------------Company Details-----------------------------------
        function btnNewEditCompanyClick(element, param) {
            if (param == "New") {
                $("#txtCompanyID").val("");
                $("#txtCompanyName").val("");
                $("#txtCompanyContactPerson").val("");
                $("#txtCompanyPlace").val("");
                //$("#txtCompanyState").val("");
                //$("#txtCompanyCountry").val("");
                $("#txtCompanyPin").val("");
                $("#txtCompanyAddress").val("");
                $("#txtCompanyEmail").val("");
                $("#txtCompanyPhone").val("");
                $("#txtCompanyEffFromDate").val("");
                $("#txtCompanyEffToDate").prop("readonly", true);
                $("#txtCompanyEffToDate").val("31-12-9999 00:00:00");
                $("#txtCompanyUserId").val("");
                $("#txtCompanyUserPassword").val("");

                $("#ddlGroup_ForCompany").prop('disabled', false);
                $("#txtCompanyID").prop("readonly", false);
                $("#txtCompanyEffFromDate").prop("readonly", false);
                $("#txtCompanyEffToDate").prop("readonly", true);
                $("#txtCompanyUserId").prop("readonly", false);
                $("#neweditCompanyModal  .modal-title").text("Add Company");
                $("#hfComoanyNewEdit").val("New");
            } else {
                $("#ddlGroup_ForCompany").val($(element).closest('tr').find("#lblGroupID").text());
                $("#txtCompanyID").val($(element).closest('tr').find("#lblCompanyID").text());
                $("#txtCompanyName").val($(element).closest('tr').find("#lblCompanyName").text());
                $("#txtCompanyContactPerson").val($(element).closest('tr').find("#lblContactPerson").text());
                $("#txtCompanyPlace").val($(element).closest('tr').find("#lblPlace").text());
                $("#ddlCompanyState").val($(element).closest('tr').find("#lblState").text());
                $("#ddlCompanyCountry").val($(element).closest('tr').find("#lblCountry").text());
                $("#txtCompanyPin").val($(element).closest('tr').find("#lblPin").text());
                $("#txtCompanyAddress").val($(element).closest('tr').find("#lblAddress").text());
                $("#txtCompanyEmail").val($(element).closest('tr').find("#lblEmailId").text());
                $("#txtCompanyPhone").val($(element).closest('tr').find("#lblPhone").text());
                $("#txtCompanyEffFromDate").val($(element).closest('tr').find("#lblEffevtiveFromDate").text());
                $("#txtCompanyEffToDate").val($(element).closest('tr').find("#lblEffevtiveToDate").text());
                $("#txtCompanyUserId").val($(element).closest('tr').find("#lblCompanyAdmin").text());
                $("#txtCompanyUserPassword").val($(element).closest('tr').find("#hfCompanyAdminPassword").val());

                $("#ddlGroup_ForCompany").prop('disabled', true);
                $("#txtCompanyID").prop("readonly", true);
                $("#txtCompanyEffFromDate").prop("readonly", true);
                $("#txtCompanyEffToDate").prop("readonly", true);
                $("#txtCompanyUserId").prop("readonly", true);
                $("#neweditCompanyModal  .modal-title").text("Edit Company");
                $("#hfComoanyNewEdit").val("Edit");
            }
            $(".mandatory-message").text("");
            $("#neweditCompanyModal").modal('show');
            return false;
        }
        function btnNewEditCompanySaveClick() {
            if ($("#txtCompanyID").val() == "") {
                $(".mandatory-message").text("Company ID is required.");
                return false;
            } else if ($("#txtCompanyName").val() == "") {
                $(".mandatory-message").text("Company Name is required.");
                return false;
            }
            else if ($("#txtCompanyPin").val() != "") {
                if ($("#txtCompanyPin").length != 6) {
                    $(".mandatory-message").text("Enter valid PIN.");
                    return false;
                }
            } else if ($("#txtCompanyPhone").val() != "") {
                if ($("#txtCompanyPhone").length != 10) {
                    $(".mandatory-message").text("Enter valid Phone.");
                    return false;
                }
            } else if ($("#txtCompanyEmail").val() != "") {
                if (!isEmail($("#txtCompanyEmail").val())) {
                    $(".mandatory-message").text("Enter valid Email.");
                    return false;
                }
            }
            else if ($("#txtCompanyUserId").val() == "") {
                $(".mandatory-message").text("Company admin is required.");
                return false;
            } else if ($("#txtCompanyUserPassword").val() == "") {
                $(".mandatory-message").text("Password is required.");
                return false;
            }
            else if ($("#txtCompanyEffFromDate").val() == "") {
                $(".mandatory-message").text("Effective From is required.");
                return false;
            } else if ($("#txtCompanyEffToDate").val() == "") {
                $(".mandatory-message").text("Effective To is required.");
                return false;
            }


            if ($('#txtCompanyUserPassword').val().trim() != "") {
                var passowrd = $('#txtCompanyUserPassword').val();
                var isPassContainCaps = false, isPassContainLoweCase = false, isPasswordContainSpecialChat = false, isPasswordContainNumber = false;
                if (passowrd.length < 8 || passowrd.length > 15) {
                    //$(".mandatory-message").text("Password must be 8 or more characters in length.");
                    $(".mandatory-message").text("Password should be greater than 7 characters and less than 16 characters.");
                    return false;
                }
                for (var i = 0; i < passowrd.length; i++) {
                    var charCode = passowrd.charCodeAt(i);
                    if (charCode >= 65 && charCode <= 90) {
                        isPassContainCaps = true;
                    }
                    else if (charCode >= 97 && charCode <= 122) {
                        isPassContainLoweCase = true;
                    }
                    else if (charCode >= 48 && charCode <= 57) {
                        isPasswordContainNumber = true;
                    }
                    else if ((charCode >= 33 && charCode <= 47) || (charCode >= 58 && charCode <= 64) || (charCode >= 91 && charCode <= 96) || (charCode >= 123 && charCode <= 126)) {
                        isPasswordContainSpecialChat = true;
                    }
                }
                if (isPassContainCaps == false) {
                    $(".mandatory-message").text("Password must contain 1 or more uppercase characters.");
                    return false;
                }
                if (isPassContainLoweCase == false) {
                    $(".mandatory-message").text("Password must contain 1 or more lowercase characters.");
                    return false;
                }
                if (isPasswordContainNumber == false) {
                    $(".mandatory-message").text("Password must contain 1 or more digit characters.");
                    return false;
                }
                if (isPasswordContainSpecialChat == false) {
                    $(".mandatory-message").text("Password must contain 1 or more special characters.");
                    return false;
                }
            }
            return true;
        }
        function openCompanyDeleteConfirmModal(msg) {
            $("#companyDeleteMsg").text(msg);
            $("#companyDeleteConfirmModal").modal('show');

        }
        //------------------------End Company Details-----------------------------------

        //------------------------Group Details-----------------------------------
        function btnNewEditGroupClick(element, param) {
            if (param == "New") {
                $("#txtGroupId").val("");
                $("#txtGroupName").val("");
                $("#txtGroupContactPerson").val("");
                $("#txtGroupPlace").val("");
                // $("#txtGroupState").val("");
                //$("#txtGroupCountry").val("");
                $("#txtGroupPin").val("");
                $("#txtGroupAddress").val("");
                $("#txtNewGroupPhone").val("");
                $("#txtGroupEmail").val("");
                $("#txtGroupPhone").val("");
                $("#txtGroupEffFromDate").val("");
                $("#txtGroupEffToDate").val("31-12-9999 00:00:00");

                $("#txtGroupId").prop("readonly", false);
                $("#txtGroupEffFromDate").prop("readonly", false);
                $("#txtGroupEffToDate").prop("readonly", true);
                $("#neweditGroupModal  .modal-title").text("Add Group");
                $("#hfGroupEditNew").val("New");
            } else {
                $("#txtGroupId").val($(element).closest('tr').find("#lblGroupID").text());
                $("#txtGroupName").val($(element).closest('tr').find("#lblGroupName").text());
                $("#txtGroupContactPerson").val($(element).closest('tr').find("#lblContactPerson").text());
                $("#txtGroupPlace").val($(element).closest('tr').find("#lblPlace").text());
                //$("#txtGroupState").val($(element).closest('tr').find("#lblState").text());
                //$("#txtGroupCountry").val($(element).closest('tr').find("#lblCountry").text());
                $("#ddlGroupCountry").val($(element).closest('tr').find("#lblCountry").text());
                $("#ddlGroupState").val($(element).closest('tr').find("#lblState").text());
                $("#txtGroupPin").val($(element).closest('tr').find("#lblPin").text());
                $("#txtGroupAddress").val($(element).closest('tr').find("#lblAddress").text());
                $("#txtGroupEmail").val($(element).closest('tr').find("#lblEmailId").text());
                $("#txtGroupPhone").val($(element).closest('tr').find("#lblPhone").text());
                $("#txtGroupEffFromDate").val($(element).closest('tr').find("#lblEffevtiveFromDate").text());
                $("#txtGroupEffToDate").val($(element).closest('tr').find("#lblEffevtiveToDate").text());

                $("#txtGroupId").prop("readonly", true);
                $("#txtGroupEffFromDate").prop("readonly", true);
                $("#txtGroupEffToDate").prop("readonly", true);
                $("#neweditGroupModal  .modal-title").text("Edit Group");
                $("#hfGroupEditNew").val("Edit");
            }
            $(".mandatory-message").text("");
            $("#neweditGroupModal").modal('show');
            return false;
        }
        function btnNewEditGroupSaveClick() {
            if ($("#txtGroupId").val() == "") {
                $(".mandatory-message").text("Group ID is required.");
                return false;
            } else if ($("#txtGroupName").val() == "") {
                $(".mandatory-message").text("Group Name is required.");
                return false;
            }
            else if ($("#txtGroupPin").val() != "") {
                if ($("#txtGroupPin").length != 6) {
                    $(".mandatory-message").text("Enter valid PIN.");
                    return false;
                }

            } else if ($("#txtGroupPhone").val() != "") {
                if ($("#txtGroupPhone").length != 10) {
                    $(".mandatory-message").text("Enter valid Phone.");
                    return false;
                }

            } else if ($("#txtGroupEmail").val() != "") {
                if (!isEmail($("#txtGroupEmail").val())) {
                    $(".mandatory-message").text("Enter valid Email.");
                    return false;
                }
            } else if ($("#txtGroupEffFromDate").val() == "") {
                $(".mandatory-message").text("Effective From is required.");
                return false;
            } else if ($("#txtGroupEffToDate").val() == "") {
                $(".mandatory-message").text("Effective To is required.");
                return false;
            }
            return true;
        }
        function openGroupDeleteConfirmModal(msg) {
            $("#groupDeleteMsg").text(msg);
            $("#groupDeleteConfirmModal").modal('show');
        }


        //------------------------End Group Details-----------------------------------

        /*  ------------------------------------------------------ Plant Details----------------------------------------------------*/
        function btnNewOrEditPlantClick(element, param) {
            if (param == "New") {
                $("#txtPlantID").val("");
                $("#txtPlantDesc").val("");
                $("#txtPlantCode").val("");
                $("#txtPlantAddress").val("");
                //$("#txtPlantCountry").val("");
                $("#txtPlantRegion").val("");
                $("#txtPlantGeoLocation").val("");
                $("#txtPlatCity").val("");
                $("#txtPlantEffFromDate").val("");
                $("#txtPlantEffToDate").val("31-12-9999 00:00:00");

                $("#ddlCompany_ForPlant").prop('disabled', false);
                $("#txtPlantID").prop('readonly', false);
                $("#txtPlantEffFromDate").prop('readonly', false);
                $("#txtPlantEffToDate").prop('readonly', true);
                $("#hfPlantEditNew").val("New");
                $("#neweditPlantModal .modal-title").text("Add Plant");
            } else {
                $("#txtPlantID").val($(element).closest('tr').find("#lblPlantID").text());
                $("#txtPlantDesc").val($(element).closest('tr').find("#lblPlantDesc").text());
                $("#txtPlantCode").val($(element).closest('tr').find("#lblCode").text());
                $("#txtPlantAddress").val($(element).closest('tr').find("#lblAddress").text());
                $("#ddlPlantCountry").val($(element).closest('tr').find("#lblCountry").text());
                $("#txtPlantRegion").val($(element).closest('tr').find("#lblRegion").text());
                $("#txtPlantGeoLocation").val($(element).closest('tr').find("#lblGeoLoaction").text());
                $("#txtPlatCity").val($(element).closest('tr').find("#lblCity").text());
                $("#txtPlantEffFromDate").val($(element).closest('tr').find("#lblEffevtiveFromDate").text());
                $("#txtPlantEffToDate").val($(element).closest('tr').find("#lblEffevtiveToDate").text());

                $("#ddlCompany_ForPlant").prop('disabled', true);
                $("#txtPlantID").prop('readonly', true);
                $("#txtPlantEffFromDate").prop('readonly', true);
                $("#txtPlantEffToDate").prop('readonly', true);
                $("#hfPlantEditNew").val("Edit");
                $("#neweditPlantModal .modal-title").text("Edit Plant");
            }
            $(".mandatory-message").text("");
            $("#neweditPlantModal").modal('show');

            return false;
        }
        function btnNewEditPlantSaveClick() {
            //check company ID
            if ($("#txtPlantID").val() == "") {
                $(".mandatory-message").text("Plant ID is required.");
                return false;
            } else if ($("#txtPlantEffFromDate").val() == "") {
                $(".mandatory-message").text("Effective From is required.");
                return false;
            } else if ($("#txtPlantEffToDate").val() == "") {
                $(".mandatory-message").text("Effective To is required.");
                return false;
            }
            return true;
        }

        function openPlantDeleteConfirmModal(msg) {
            $("#plantDeleteMsg").text(msg);
            $("#plantDeleteConfirmModal").modal('show');
        }

        //$("#gvPlantDetails tr").click(function () {
        //    $("#gvPlantDetails tr").css('background-color', 'unset');
        //    $(this).css('background-color', 'red');
        //    $("#hfSelectedPlant").val($(this).find("#lblPlantID").text());
        //});

        //function setSelectedPlantIdInGrid() {
        //    let plant = $("#hfSelectedPlant").val();
        //    for (let i = 1; i < $("#gvPlantDetails tr").length; i++) {
        //        let tr = $("#gvPlantDetails tr")[i];
        //        //alert($(tr).find("#lblPlantID").text() + "   " + plant);
        //        if ($(tr).find("#lblPlantID").text() == plant) {
        //            $(tr).css('background-color', 'red');
        //        } else {
        //            $(tr).css('background-color', 'unset');
        //        }
        //    }
        //}
        /*  ------------------------------------------------------ End Plant Details----------------------------------------------------*/


        //-------- Machine Master Data -----
        $('[id$=txtNEEffFromDate]').datetimepicker({
            format: 'DD-MM-YYYY HH:mm:ss',
            locale: 'en-US'
        });
        $('[id$=txtNEEffToDate]').datetimepicker({
            format: 'DD-MM-YYYY HH:mm:ss',
            locale: 'en-US'
        });
        function machineDataInsertValidation() {
            if ($('#txtNEMachineID').val().trim() == "") {
                $(".mandatory-message").text("Machine ID is required.");
                return false;
            }
            if ($('#txtNEInterfaceID').val().trim() == "") {
                $(".mandatory-message").text("IoT ID is required.");
                return false;
            }
            if ($("#txtNEEffFromDate").val() == "") {
                $(".mandatory-message").text("Effective From is required.");
                return false;
            }
            $(".modal-backdrop").removeClass("modal-backdrop in");
            return true;
        }

     
            function openCloseAddEditMachineInfoModal(param) {
                $('.mandatory-message').text('');
                $(".modal-backdrop").removeClass("modal-backdrop in");
                if ($("#hdnMachineNEStatus").val() == "Edit") {
                    $("#addEditMachineInfo .modal-title").text("Edit Machine");
                } else {
                    $("#addEditMachineInfo .modal-title").text("Add Machine");
                }
                $('#addEditMachineInfo').modal(param);
            }
            function openCloseAddEditMachineDataSourceModal(param) {
                $('.mandatory-message').text('');
                $(".modal-backdrop").removeClass("modal-backdrop in");
                if ($("#hdnMachineNEStatus").val() == "Edit") {
                    $("#addEditMachineInfo .modal-title").text("Edit Machine");
                } else {
                    $("#addEditMachineInfo .modal-title").text("Add Machine");
                }
                if ($("#hdnMachineDataSourceStatus").val() == "Edit") {
                    $("#addEditMachineDataSource .modal-title").text("Edit Machine DataSource");
                } else {
                    $("#addEditMachineDataSource .modal-title").text("Add Machine DataSource");
                }
                $('#addEditMachineInfo').modal(param);
                $('#addEditMachineDataSource').modal(param);
              
            }
            function closeAddEditMachineDataSourceModal(param) {
                $('.mandatory-message').text('');
                $(".modal-backdrop").removeClass("modal-backdrop in");
                if ($("#hdnMachineNEStatus").val() == "Edit") {
                    $("#addEditMachineInfo .modal-title").text("Edit Machine");
                } else {
                    $("#addEditMachineInfo .modal-title").text("Add Machine");
                }
                $('#addEditMachineInfo').modal(param);
            }
        $('.allowDecimal').keypress(function (evt) {
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
        $('.allowNumber').keypress(function (evt) {
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            var pos = evt.target.selectionStart;
            if (charCode == 48 && pos == 0) {
                return false
            } else if ((charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        });

        function openMachineDeleteConfirmModal(msg) {
            $("#machineDeleteMsg").text(msg);
            $('#machineDeleteConfirmModal').modal('show');
        }
        //-------- End Machine Master Data -----

        //------- Employee Master -------
        $('[id$=txtEmpEffectiveFromDate]').datetimepicker({
            format: 'DD-MM-YYYY HH:mm:ss',
            locale: 'en-US'
        });
        $('[id$=txtEmpEffectiveToDate]').datetimepicker({
            format: 'DD-MM-YYYY HH:mm:ss',
            locale: 'en-US'
        });
        function employeeDataInsertValidation() {
            if ($('#txtEmpUserID').val().trim() == "") {
                $(".mandatory-message").text("User ID is required.");
                return false;
            }
            if ($('#txtEmpUerName').val().trim() == "") {
                $(".mandatory-message").text("User Name is required.");
                return false;
            }
            if ($('#ddlEmpRole').val() == null || $('#ddlEmpRole').val() == "") {
                $(".mandatory-message").text("Role is required.");
                return false;
            }
            if ($("#txtEmpEffectiveFromDate").val() == "") {
                $(".mandatory-message").text("Effective From is required.");
                return false;
            }
            if ($('#chkEmpIsEmployee').prop("checked")) {
                if ($('#txtEmpEmployeeID').val() == "") {
                    $(".mandatory-message").text("Employee ID is required.");
                    return false;
                }
            }
            if ($('#txtEmpPassword').val().trim() != "") {
                var passowrd = $('#txtEmpPassword').val();
                var isPassContainCaps = false, isPassContainLoweCase = false, isPasswordContainSpecialChat = false, isPasswordContainNumber = false;
                if (passowrd.length < 8 || passowrd.length > 15) {
                    //$(".mandatory-message").text("Password must be 8 or more characters in length.");
                    $(".mandatory-message").text("Password should be greater than 7 characters and less than 16 characters.");
                    return false;
                }
                for (var i = 0; i < passowrd.length; i++) {
                    var charCode = passowrd.charCodeAt(i);
                    if (charCode >= 65 && charCode <= 90) {
                        isPassContainCaps = true;
                    }
                    else if (charCode >= 97 && charCode <= 122) {
                        isPassContainLoweCase = true;
                    }
                    else if (charCode >= 48 && charCode <= 57) {
                        isPasswordContainNumber = true;
                    }
                    else if ((charCode >= 33 && charCode <= 47) || (charCode >= 58 && charCode <= 64) || (charCode >= 91 && charCode <= 96) || (charCode >= 123 && charCode <= 126)) {
                        isPasswordContainSpecialChat = true;
                    }
                }
                if (isPassContainCaps == false) {
                    $(".mandatory-message").text("Password must contain 1 or more uppercase characters.");
                    return false;
                }
                if (isPassContainLoweCase == false) {
                    $(".mandatory-message").text("Password must contain 1 or more lowercase characters.");
                    return false;
                }
                if (isPasswordContainNumber == false) {
                    $(".mandatory-message").text("Password must contain 1 or more digit characters.");
                    return false;
                }
                if (isPasswordContainSpecialChat == false) {
                    $(".mandatory-message").text("Password must contain 1 or more special characters.");
                    return false;
                }
            } else {
                $(".mandatory-message").text("Password is required.");
                return false;
            }

            if ($("#txtEmpEmail").val() != "") {
                if (!isEmail($("#txtEmpEmail").val())) {
                    $(".mandatory-message").text("Enter valid Email.");
                    return false;
                }
            }
            $(".modal-backdrop").removeClass("modal-backdrop in");
            return true;
        }
        function showEmployeeIDInfo() {
            debugger;
            if ($('#chkEmpIsEmployee').prop("checked")) {
                $('#txtEmpEmployeeID').removeAttr("readOnly");
            }
            else {
                $('#txtEmpEmployeeID').val("");
                $('#txtEmpEmployeeID').attr("readOnly", "readOnly");
            }
        }
        $('.mobileNoValidation').keypress(function (evt) {
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            var pos = evt.target.selectionStart;
            if ((charCode < 48 || charCode > 57)) {
                return false;
            }
            if ($(this).val().length > 9) {
                return false;
            }
            return true;
        });
        function isEmail(email) {
            var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
            return regex.test(email);
        }
        function openCloseAddEditEmployeeInfoModal(param) {
            $(".modal-backdrop").removeClass("modal-backdrop in");
            if ($("#hdnUserNEStatus").val() == "Edit") {
                $("#addEditEmployeeInfo .modal-title").text("Edit User");
            } else {
                $("#addEditEmployeeInfo .modal-title").text("Add User");
            }
            $('#addEditEmployeeInfo').modal(param);
        }
        function openEmployeeDeleteConfirmModal(msg) {
            $("#userDeleteMsg").text(msg);
            $('#employeeDeleteConfirmModal').modal('show');
        }
        //-------End Employee Masterk -----



        $(".checkbox-radiobtn").click(function () {
            if ($(this).find('input').prop('checked')) {
                $(".checkbox-radiobtn input").prop('checked', false);
                $(this).find('input').prop('checked', true);
            }
        });
        //---------Not allow multiple check in each row
        $(".select-onecheckbox-eachrow tr td input").click(function () {
            var colNumber = $(this).closest('tr').find('td input').index($(this));
            let isAnyOneChecked = false;
            for (let i = 0; i < $(this).closest('tr').find('td input').length; i++) {
                let input = $(this).closest('tr').find('td input')[i];

                if (colNumber == i) {
                    continue;
                }
                if ($(input).prop('checked')) {
                    isAnyOneChecked = true;
                }
            }
            if (isAnyOneChecked) {
                return false;
            } else {
                return true;
            }
        });
        /*----------------------------------End Assign Mahines Details -------------------------------------*/

        /* ---------------------------------------------Role Details----------------------------------------------------------*/
        function btnNewOrEditRoleClick(element, param) {
            if (param == "New") {
                $("#txtRoleName").val("");
                $("#txtRoleEffFromDate").val("");
                $("#txtRoleEffToDate").val("31-12-9999 00:00:00");


                $("#txtRoleName").prop('readonly', false);
                $("#txtRoleEffFromDate").prop('readonly', false);
                $("#txtRoleEffToDate").prop('readonly', true);
                $("#hfRoleNewEdit").val("New");
                $("#neweditRoleModal .modal-title").text("Add Role");
            } else {

                $("#txtRoleName").val($(element).closest('tr').find("#lblRoleName").text());
                $("#txtRoleEffFromDate").val($(element).closest('tr').find("#lblEffevtiveFromDate").text());
                $("#txtRoleEffToDate").val($(element).closest('tr').find("#lblEffevtiveToDate").text());

                $("#txtRoleName").prop('readonly', true);
                $("#txtRoleEffFromDate").prop('readonly', true);
                $("#txtRoleEffToDate").prop('readonly', true);
                $("#hfRoleNewEdit").val("Edit");
                $("#neweditRoleModal .modal-title").text("Edit Role");
            }
            $(".mandatory-message").text("");
            $("#neweditRoleModal").modal('show');

            return false;
        }
        function btnNewEditRoleSaveClick() {
            //check company ID
            if ($("#txtRoleName").val() == "") {
                $(".mandatory-message").text("Role Name is required.");
                return false;
            }
            if ($("#txtRoleEffFromDate").val() == "") {
                $(".mandatory-message").text("Effective From is required.");
                return false;
            }
            if ($("#txtRoleEffToDate").val() == "") {
                $(".mandatory-message").text("Effective To is required.");
                return false;
            }
            return true;
        }

        function openRoleDeleteConfirmModal(msg) {
            $("#roleDeleteMsg").text(msg);
            $("#roleDeleteConfirmModal").modal('show');
        }
        /*----------------------------------------------- End Role Details-----------------------------------------------*/


        //---------------- User Rights Exception
        function userRightExceptionUserIDViewValidation() {
            var checklist = $('#gvUserIDList input[type="checkbox"]');
            var msgFlag = 0;
            for (var i = 0; i < checklist.length; i++) {
                var chk = checklist[i];
                if ($(chk).prop("checked")) {
                    msgFlag = 1;
                    break;
                }
            }
            if (msgFlag == 0) {
                openWarningModal("Please select User ID.");
                return false;
            }
            return true;
        }
        function userRightExceptionViewValidation() {
            if ($('#ddlUserRightExptnCompany').val() == null || $('#ddlUserRightExptnCompany').val() == "") {
                openWarningModal("Please select Company ID.");
                return false;
            }
            if ($('#ddlUserRightExptnRole').val() == null || $('#ddlUserRightExptnRole').val() == "") {
                openWarningModal("Please select Role.");
                return false;
            }
            return true;
        }
        $('#gvUserIDList tr td').click(function () {
            debugger;

            if ($(this).find("#chkUserIDChecked").prop("checked")) {
                $(this).find("#chkUserIDChecked").prop("checked", false);
            }
            else {
                $(this).find("#chkUserIDChecked").prop("checked", true);
            }

            if ($(this).find("#lblUserID").text() == "Select All") {
                if ($(this).find("#chkUserIDChecked").prop("checked")) {
                    for (var i = 1; i < $('#gvUserIDList tr').length; i++) {
                        var tr = $('#gvUserIDList tr')[i];
                        $(tr).find("#chkUserIDChecked").prop("checked", true);
                    }
                }
                else {
                    for (var i = 1; i < $('#gvUserIDList tr').length; i++) {
                        var tr = $('#gvUserIDList tr')[i];
                        $(tr).find("#chkUserIDChecked").prop("checked", false);
                    }
                }
            }
            else {
                var rowCount = $('#gvUserIDList tr').length - 2;

                var checkedCount = 0;
                for (var i = 2; i < $('#gvUserIDList tr').length; i++) {
                    var tr = $('#gvUserIDList tr')[i];
                    if ($(tr).find("#chkUserIDChecked").prop("checked")) {
                        checkedCount++;
                    }
                }
                if (checkedCount == rowCount) {
                    var tr = $('#gvUserIDList tr')[1];
                    $(tr).find("#chkUserIDChecked").prop("checked", true);
                }
                else {
                    var tr = $('#gvUserIDList tr')[1];
                    $(tr).find("#chkUserIDChecked").prop("checked", false);
                }
            }
        });
        function userRightExceptionRadioBtnClick(radio, param) {
            debugger;
            var checkedIndex = $(radio).closest('td').index();
            var userIDIndex = $(radio).closest('.userInfoTd').index();
            if (param == "All") {
                var tblOuter = $('.userRightsInnerTbl');
                for (var i = 1; i < tblOuter.length; i++) {
                    var tbl = tblOuter[i];
                    var td = $(tbl).find('tr td.userInfoTd')[userIDIndex];
                    tbl = $(td).find('.radioBtnTbl');
                    var tds = $(tbl).find('tr td');
                    for (var j = 0; j < tds.length; j++) {
                        let innertd = tds[j];
                        let radio = $(innertd).find('.rmnRadioBtns input');
                        $(radio).prop("checked", false);
                        if (checkedIndex == j) {
                            $(radio).prop("checked", true);
                        }
                    }

                }
            }
            else {
                var tblOuter = $('.userRightsInnerTbl');
                var index0 = 0, index1 = 0, index2 = 0;
                for (var i = 1; i < tblOuter.length; i++) {
                    var tbl = tblOuter[i];
                    var td = $(tbl).find('tr td.userInfoTd')[userIDIndex];
                    tbl = $(td).find('.radioBtnTbl');
                    var tds = $(tbl).find('tr td');
                    for (var j = 0; j < tds.length; j++) {
                        let innertd = tds[j];
                        let radio = $(innertd).find('.rmnRadioBtns input');
                        if ($(radio).prop("checked")) {
                            if (j == 0) {
                                index0++;
                            }
                            else if (j == 1) {
                                index1++;
                            }
                            else if (j == 2) {
                                index2++;
                            }
                        }
                    }
                }
                debugger;
                let rowsCount = tblOuter.length - 1;
                tbl = tblOuter[0];
                td = $(tbl).find('tr td.userInfoTd')[userIDIndex];
                tbl = $(td).find('.radioAllBtnTbl')[0];
                tds = $(tbl).find('tr td');
                for (var j = 1; j < tds.length; j++) {
                    let innertd = tds[j];
                    let radio = $(innertd).find('.rmnRadioBtns input');
                    $(radio).prop("checked", false);
                    if (j == 1) {
                        if (rowsCount == index0) {
                            $(radio).prop("checked", true);
                        }
                    }
                    if (j == 2) {
                        if (rowsCount == index1) {
                            $(radio).prop("checked", true);
                        }
                    }
                    if (j == 3) {
                        if (rowsCount == index2) {
                            $(radio).prop("checked", true);
                        }
                    }
                }
            }
        }

        //------------


        $('.mobileNoValidation').keypress(function (evt) {
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            var pos = evt.target.selectionStart;
            if ((charCode < 48 || charCode > 57)) {
                return false;
            }
            if ($(this).val().length > 9) {
                return false;
            }
            return true;
        });
        $('.pin-validation').keypress(function (evt) {
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            var pos = evt.target.selectionStart;
            if ((charCode < 48 || charCode > 57)) {
                return false;
            }
            if ($(this).val().length > 5) {
                return false;
            }
            return true;
        });
        function isEmail(email) {
            var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
            return regex.test(email);
        }
        function clearAllModalScreen() {
            //   $(".modal-backdrop").removeClass("modal-backdrop in");
            $(".modal").modal("hide");
            return true;
        }

        function openWarningModal(msg) {
            $("#lblWarningMsg").text(msg);
            $("#warningModal").modal('show');
        }
        function openErrorModal(msg) {
            $('#errorModal').modal('show');
            $('#lblErrorMsg').text(msg);
        }
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
        function allowNumberic(evt) {
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if ((charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }
        function clearTheModalScreen() {
            $(".modal-backdrop").removeClass("modal-backdrop in");
            return true;
        }

        function openMachineDataSource() {
            $("#addEditMachineDataSource").modal('show');
            return false;

        }
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
            $(document).ready(function () {
                //if (localStorage.getItem("gcselectedSubMenu")) {
                //    debugger;
                //    submenu = localStorage.getItem("gcselectedSubMenu");
                //}
                //$(submenu).addClass("in active");
                //$("a[href$='" + submenu + "']").removeClass("selected-menu-style").addClass("selected-Submenu");
                //$("a[href$='" + submenu + "']").closest('li').find('i').addClass("arrow up selected-Submenu-ArrowUp");
                activeSubMenu();
                activeMachineMenu();
                // setGridHeight();
                setDateTimePicker();
                //if (machineSubMenu == "#MachineDataSource") {
                //    $("#btnMachineInsertUpdate").css('display', 'none');
                //} else {
                //    $("#btnMachineInsertUpdate").css('display', 'inline-block');
                //}
                $.unblockUI({});
            });
            $(".machinesubmenuData").click(function () {
                machineSubMenu;
                if ($("#mainBody").hasClass("light-mode")) {
                    $(".machinesubmenuData").removeClass("selected-menu-style selected-Submenu").addClass("other-menu-style");
                    $(".machinesubmenuData").closest('li').find('i').removeClass();
                    $(this).removeClass("other-menu-style selected-Submenu").addClass("selected-machine-menu");
                } else {
                    $(".machinesubmenuData").removeClass("selected-menu-style selected-Submenu").addClass("other-menu-style");
                    $(".machinesubmenuData").closest('li').find('i').removeClass();
                    $(this).removeClass("other-menu-style selected-Submenu").addClass("selected-machine-menu");
                }
                $(this).closest('li').find('i').addClass("arrow up selected-Submenu-ArrowUp");
                machineSubMenu = $(this).attr('href');
                if (machineSubMenu == "#MachineDataSource") {
                    $("#btnMachineInsertUpdate").css('display', 'none');
                } else {
                    $("#btnMachineInsertUpdate").css('display', 'inline-block');
                }
                //$("#activeMenu").val(submenu);
                $(machineSubMenu).addClass("in active");
                localStorage.setItem("machineselectedSubMenu", machineSubMenu);
            });
            $(".submenuData").click(function () {
                debugger;
                //$('[id*=hdnScrollPos]').val(0);
                $.blockUI({ message: '<img runat="server" src="Images/Loading.gif" />' });
                if ($("#mainBody").hasClass("light-mode")) {
                    $(".submenuData").removeClass("selected-menu-style selected-Submenu").addClass("other-menu-style");
                    $(".submenuData").closest('li').find('i').removeClass();
                    $(this).removeClass("other-menu-style selected-Submenu").addClass("selected-menu-style");
                } else {
                    $(".submenuData").removeClass("selected-menu-style selected-Submenu").addClass("other-menu-style");
                    $(".submenuData").closest('li').find('i').removeClass();
                    $(this).removeClass("other-menu-style selected-Submenu").addClass("selected-menu-style");
                }

                $(this).closest('li').find('i').addClass("arrow up selected-Submenu-ArrowUp");
                submenu = $(this).attr('href');
                //$("#activeMenu").val(submenu);
                $(submenu).addClass("in active");
                if (submenu == "#GCmastermenu0") {
                    __doPostBack('<%= btnGroup.UniqueID%>', '');
                }
                else if (submenu == "#GCmastermenu1") {
                    __doPostBack('<%= btnCompany.UniqueID%>', '');
                } else if (submenu == "#LHmastermenu0") {
                    __doPostBack('<%= btnMachine.UniqueID%>', '');
                }
                else if (submenu == "#LHmastermenu1") {
                    __doPostBack('<%= btnEmployee.UniqueID%>', '');
                }
                else if (submenu == "#LHmastermenu2") {
                    __doPostBack('<%= btnRole.UniqueID%>', '');
                }
                else if (submenu == "#LHmastermenu3") {
                    __doPostBack('<%= btnPlant.UniqueID%>', '');
                } else if (submenu == "#LHmastermenu7") {
                    __doPostBack('<%= btnAssignMachineToPlant.UniqueID%>', '');
                } else if (submenu == "#userRoleRightsMenu0") {
                    __doPostBack('<%= btnUserRoleRights.UniqueID%>', '');
                }
                else if (submenu == "#userRightExceptionMenu1") {
                    __doPostBack('<%= btnUserRightException.UniqueID%>', '');
                }
                localStorage.setItem("gcselectedSubMenu", submenu);
            });


            //------------------------Company Details-----------------------------------
            function btnNewEditCompanyClick(element, param) {
                if (param == "New") {
                    $("#txtCompanyID").val("");
                    $("#txtCompanyName").val("");
                    $("#txtCompanyContactPerson").val("");
                    $("#txtCompanyPlace").val("");
                    //$("#txtCompanyState").val("");
                    //$("#txtCompanyCountry").val("");
                    $("#txtCompanyPin").val("");
                    $("#txtCompanyAddress").val("");
                    $("#txtCompanyEmail").val("");
                    $("#txtCompanyPhone").val("");
                    $("#txtCompanyEffFromDate").val("");
                    $("#txtCompanyEffToDate").prop("readonly", true);
                    $("#txtCompanyEffToDate").val("31-12-9999 00:00:00");
                    $("#txtCompanyUserId").val("");
                    $("#txtCompanyUserPassword").val("");

                    $("#ddlGroup_ForCompany").prop('disabled', false);
                    $("#txtCompanyID").prop("readonly", false);
                    $("#txtCompanyEffFromDate").prop("readonly", false);
                    $("#txtCompanyEffToDate").prop("readonly", true);
                    $("#txtCompanyUserId").prop("readonly", false);
                    $("#neweditCompanyModal  .modal-title").text("Add Company");
                    $("#hfComoanyNewEdit").val("New");
                } else {
                    $("#ddlGroup_ForCompany").val($(element).closest('tr').find("#lblGroupID").text());
                    $("#txtCompanyID").val($(element).closest('tr').find("#lblCompanyID").text());
                    $("#txtCompanyName").val($(element).closest('tr').find("#lblCompanyName").text());
                    $("#txtCompanyContactPerson").val($(element).closest('tr').find("#lblContactPerson").text());
                    $("#txtCompanyPlace").val($(element).closest('tr').find("#lblPlace").text());
                    $("#ddlCompanyState").val($(element).closest('tr').find("#lblState").text());
                    $("#ddlCompanyCountry").val($(element).closest('tr').find("#lblCountry").text());
                    $("#txtCompanyPin").val($(element).closest('tr').find("#lblPin").text());
                    $("#txtCompanyAddress").val($(element).closest('tr').find("#lblAddress").text());
                    $("#txtCompanyEmail").val($(element).closest('tr').find("#lblEmailId").text());
                    $("#txtCompanyPhone").val($(element).closest('tr').find("#lblPhone").text());
                    $("#txtCompanyEffFromDate").val($(element).closest('tr').find("#lblEffevtiveFromDate").text());
                    $("#txtCompanyEffToDate").val($(element).closest('tr').find("#lblEffevtiveToDate").text());
                    $("#txtCompanyUserId").val($(element).closest('tr').find("#lblCompanyAdmin").text());
                    $("#txtCompanyUserPassword").val($(element).closest('tr').find("#hfCompanyAdminPassword").val());

                    $("#ddlGroup_ForCompany").prop('disabled', true);
                    $("#txtCompanyID").prop("readonly", true);
                    $("#txtCompanyEffFromDate").prop("readonly", true);
                    $("#txtCompanyEffToDate").prop("readonly", true);
                    $("#txtCompanyUserId").prop("readonly", true);
                    $("#neweditCompanyModal  .modal-title").text("Edit Company");
                    $("#hfComoanyNewEdit").val("Edit");
                }
                $(".mandatory-message").text("");
                $("#neweditCompanyModal").modal('show');
                return false;
            }
            function openCompanyDeleteConfirmModal(msg) {
                $("#companyDeleteMsg").text(msg);
                $("#companyDeleteConfirmModal").modal('show');

            }
            //------------------------End Company Details-----------------------------------

            //------------------------Group Details-----------------------------------
            function btnNewEditGroupClick(element, param) {
                if (param == "New") {
                    $("#txtGroupId").val("");
                    $("#txtGroupName").val("");
                    $("#txtGroupContactPerson").val("");
                    $("#txtGroupPlace").val("");
                    //$("#txtGroupState").val("");
                    // $("#txtGroupCountry").val("");
                    $("#txtGroupPin").val("");
                    $("#txtGroupAddress").val("");
                    $("#txtNewGroupPhone").val("");
                    $("#txtGroupEmail").val("");
                    $("#txtGroupPhone").val("");
                    $("#txtGroupEffFromDate").val("");
                    $("#txtGroupEffToDate").val("31-12-9999 00:00:00");

                    $("#txtGroupId").prop("readonly", false);
                    $("#txtGroupEffFromDate").prop("readonly", false);
                    $("#txtGroupEffToDate").prop("readonly", true);
                    $("#neweditGroupModal  .modal-title").text("Add Group");
                    $("#hfGroupEditNew").val("New");
                } else {
                    $("#txtGroupId").val($(element).closest('tr').find("#lblGroupID").text());
                    $("#txtGroupName").val($(element).closest('tr').find("#lblGroupName").text());
                    $("#txtGroupContactPerson").val($(element).closest('tr').find("#lblContactPerson").text());
                    $("#txtGroupPlace").val($(element).closest('tr').find("#lblPlace").text());
                    // $("#txtGroupState").val($(element).closest('tr').find("#lblState").text());
                    //$("#txtGroupCountry").val($(element).closest('tr').find("#lblCountry").text());
                    $("#ddlGroupCountry").val($(element).closest('tr').find("#lblCountry").text());
                    $("#ddlGroupState").val($(element).closest('tr').find("#lblState").text());
                    $("#txtGroupPin").val($(element).closest('tr').find("#lblPin").text());
                    $("#txtGroupAddress").val($(element).closest('tr').find("#lblAddress").text());
                    $("#txtGroupEmail").val($(element).closest('tr').find("#lblEmailId").text());
                    $("#txtGroupPhone").val($(element).closest('tr').find("#lblPhone").text());
                    $("#txtGroupEffFromDate").val($(element).closest('tr').find("#lblEffevtiveFromDate").text());
                    $("#txtGroupEffToDate").val($(element).closest('tr').find("#lblEffevtiveToDate").text());

                    $("#txtGroupId").prop("readonly", true);
                    $("#txtGroupEffFromDate").prop("readonly", true);
                    $("#txtGroupEffToDate").prop("readonly", true);
                    $("#neweditGroupModal  .modal-title").text("Edit Group");
                    $("#hfGroupEditNew").val("Edit");
                }
                $(".mandatory-message").text("");
                $("#neweditGroupModal").modal('show');
                return false;
            }
            function openGroupDeleteConfirmModal(msg) {
                $("#groupDeleteMsg").text(msg);
                $("#groupDeleteConfirmModal").modal('show');
            }
            //------------------------End Group Details-----------------------------------

            /*  ------------------------------------------------------ Plant Details----------------------------------------------------*/
            function btnNewOrEditPlantClick(element, param) {
                if (param == "New") {
                    $("#txtPlantID").val("");
                    $("#txtPlantDesc").val("");
                    $("#txtPlantCode").val("");
                    $("#txtPlantAddress").val("");
                    //$("#txtPlantCountry").val("");
                    $("#txtPlantRegion").val("");
                    $("#txtPlantGeoLocation").val("");
                    $("#txtPlatCity").val("");
                    $("#txtPlantEffFromDate").val("");
                    $("#txtPlantEffToDate").val("31-12-9999 00:00:00");

                    $("#ddlCompany_ForPlant").prop('disabled', false);
                    $("#txtPlantID").prop('readonly', false);
                    $("#txtPlantEffFromDate").prop('readonly', false);
                    $("#txtPlantEffToDate").prop('readonly', true);
                    $("#hfPlantEditNew").val("New");
                    $("#neweditPlantModal .modal-title").text("Add Plant");
                } else {
                    $("#txtPlantID").val($(element).closest('tr').find("#lblPlantID").text());
                    $("#txtPlantDesc").val($(element).closest('tr').find("#lblPlantDesc").text());
                    $("#txtPlantCode").val($(element).closest('tr').find("#lblCode").text());
                    $("#txtPlantAddress").val($(element).closest('tr').find("#lblAddress").text());
                    $("#ddlPlantCountry").val($(element).closest('tr').find("#lblCountry").text());
                    $("#txtPlantRegion").val($(element).closest('tr').find("#lblRegion").text());
                    $("#txtPlantGeoLocation").val($(element).closest('tr').find("#lblGeoLoaction").text());
                    $("#txtPlatCity").val($(element).closest('tr').find("#lblCity").text());
                    $("#txtPlantEffFromDate").val($(element).closest('tr').find("#lblEffevtiveFromDate").text());
                    $("#txtPlantEffToDate").val($(element).closest('tr').find("#lblEffevtiveToDate").text());

                    $("#ddlCompany_ForPlant").prop('disabled', true);
                    $("#txtPlantID").prop('readonly', true);
                    $("#txtPlantEffFromDate").prop('readonly', true);
                    $("#txtPlantEffToDate").prop('readonly', true);
                    $("#hfPlantEditNew").val("Edit");
                    $("#neweditPlantModal .modal-title").text("Edit Plant");
                }
                $(".mandatory-message").text("");
                $("#neweditPlantModal").modal('show');

                return false;
            }
            function openPlantDeleteConfirmModal(msg) {
                $("#plantDeleteMsg").text(msg);
                $("#plantDeleteConfirmModal").modal('show');
            }

            //$("#gvPlantDetails tr").click(function () {
            //    $("#gvPlantDetails tr").css('background-color', 'unset');
            //    $(this).css('background-color', 'red');
            //    $("#hfSelectedPlant").val($(this).find("#lblPlantID").text());
            //});

            //function setSelectedPlantIdInGrid() {
            //    let plant = $("#hfSelectedPlant").val();
            //    for (let i = 1; i < $("#gvPlantDetails tr").length; i++) {
            //        let tr = $("#gvPlantDetails tr")[i];
            //        //alert($(tr).find("#lblPlantID").text() + "   " + plant);
            //        if ($(tr).find("#lblPlantID").text() == plant) {
            //            $(tr).css('background-color', 'red');
            //        } else {
            //            $(tr).css('background-color', 'unset');
            //        }
            //    }
            //}
            /*  ------------------------------------------------------ End Plant Details----------------------------------------------------*/

            //-------- Machine Master Data -----
            $('[id$=txtNEEffFromDate]').datetimepicker({
                format: 'DD-MM-YYYY HH:mm:ss',
                locale: 'en-US'
            });
            $('[id$=txtNEEffToDate]').datetimepicker({
                format: 'DD-MM-YYYY HH:mm:ss',
                locale: 'en-US'
            });

            function openCloseAddEditMachineInfoModal(param) {
                $('.mandatory-message').text('');
                $(".modal-backdrop").removeClass("modal-backdrop in");
                if ($("#hdnMachineNEStatus").val() == "Edit") {
                    $("#addEditMachineInfo .modal-title").text("Edit Machine");
                } else {
                    $("#addEditMachineInfo .modal-title").text("Add Machine");
                }
                $('#addEditMachineInfo').modal(param);
            }
            function openCloseAddEditMachineDataSourceModal(param) {
                $('.mandatory-message').text('');
                $(".modal-backdrop").removeClass("modal-backdrop in");
                if ($("#hdnMachineNEStatus").val() == "Edit") {
                    $("#addEditMachineInfo .modal-title").text("Edit Machine");
                } else {
                    $("#addEditMachineInfo .modal-title").text("Add Machine");
                }
                if ($("#hdnMachineDataSourceStatus").val() == "Edit") {
                    $("#addEditMachineDataSource .modal-title").text("Edit Machine DataSource");
                } else {
                    $("#addEditMachineDataSource .modal-title").text("Add Machine DataSource");
                }
                $('#addEditMachineInfo').modal(param);
                $('#addEditMachineDataSource').modal(param);
              
            }
            function closeAddEditMachineDataSourceModal(param) {
                $('.mandatory-message').text('');
                $(".modal-backdrop").removeClass("modal-backdrop in");
                if ($("#hdnMachineNEStatus").val() == "Edit") {
                    $("#addEditMachineInfo .modal-title").text("Edit Machine");
                } else {
                    $("#addEditMachineInfo .modal-title").text("Add Machine");
                }
                $('#addEditMachineInfo').modal(param);
            }
            $('.allowDecimal').keypress(function (evt) {
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
            $('.allowNumber').keypress(function (evt) {
                var charCode = (evt.which) ? evt.which : evt.keyCode;
                var pos = evt.target.selectionStart;
                if (charCode == 48 && pos == 0) {
                    return false
                } else if ((charCode < 48 || charCode > 57)) {
                    return false;
                }
                return true;
            });
            function openMachineDeleteConfirmModal(msg) {
                $("#machineDeleteMsg").text(msg);
                $('#machineDeleteConfirmModal').modal('show');
            }
            //-------- End Machine Master Data -----

            //------- Employee Master -------
            $('[id$=txtEmpEffectiveFromDate]').datetimepicker({
                format: 'DD-MM-YYYY HH:mm:ss',
                locale: 'en-US'
            });
            $('[id$=txtEmpEffectiveToDate]').datetimepicker({
                format: 'DD-MM-YYYY HH:mm:ss',
                locale: 'en-US'
            });
            $('.mobileNoValidation').keypress(function (evt) {
                var charCode = (evt.which) ? evt.which : evt.keyCode;
                var pos = evt.target.selectionStart;
                if ((charCode < 48 || charCode > 57)) {
                    return false;
                }
                if ($(this).val().length > 9) {
                    return false;
                }
                return true;
            });
            function isEmail(email) {
                var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
                return regex.test(email);
            }
            function openCloseAddEditEmployeeInfoModal(param) {
                $(".modal-backdrop").removeClass("modal-backdrop in");
                if ($("#hdnUserNEStatus").val() == "Edit") {
                    $("#addEditEmployeeInfo .modal-title").text("Edit User");
                } else {
                    $("#addEditEmployeeInfo .modal-title").text("Add User");
                }
                $('#addEditEmployeeInfo').modal(param);
            }
            function openEmployeeDeleteConfirmModal(msg) {
                $("#userDeleteMsg").text(msg);
                $('#employeeDeleteConfirmModal').modal('show');
            }
            //-------End Employee Masterk -----


            //---------Not allow multiple check in each row
            $(".select-onecheckbox-eachrow tr td input").click(function () {
                var colNumber = $(this).closest('tr').find('td input').index($(this));
                let isAnyOneChecked = false;
                for (let i = 0; i < $(this).closest('tr').find('td input').length; i++) {
                    let input = $(this).closest('tr').find('td input')[i];

                    if (colNumber == i) {
                        continue;
                    }
                    if ($(input).prop('checked')) {
                        isAnyOneChecked = true;
                    }
                }
                if (isAnyOneChecked) {
                    return false;
                } else {
                    return true;
                }
            });

            /* ---------------------------------------------Role Details----------------------------------------------------------*/
            function btnNewOrEditRoleClick(element, param) {
                if (param == "New") {
                    $("#txtRoleName").val("");
                    $("#txtRoleEffFromDate").val("");
                    $("#txtRoleEffToDate").val("31-12-9999 00:00:00");


                    $("#txtRoleName").prop('readonly', false);
                    $("#txtRoleEffFromDate").prop('readonly', false);
                    $("#txtRoleEffToDate").prop('readonly', true);
                    $("#hfRoleNewEdit").val("New");
                    $("#neweditRoleModal .modal-title").text("Add Role");
                } else {

                    $("#txtRoleName").val($(element).closest('tr').find("#lblRoleName").text());
                    $("#txtRoleEffFromDate").val($(element).closest('tr').find("#lblEffevtiveFromDate").text());
                    $("#txtRoleEffToDate").val($(element).closest('tr').find("#lblEffevtiveToDate").text());

                    $("#txtRoleName").prop('readonly', true);
                    $("#txtRoleEffFromDate").prop('readonly', true);
                    $("#txtRoleEffToDate").prop('readonly', true);
                    $("#hfRoleNewEdit").val("Edit");
                    $("#neweditRoleModal .modal-title").text("Edit Role");
                }
                $(".mandatory-message").text("");
                $("#neweditRoleModal").modal('show');

                return false;
            }

            function openRoleDeleteConfirmModal(msg) {
                $("#roleDeleteMsg").text(msg);
                $("#roleDeleteConfirmModal").modal('show');
            }
            /*----------------------------------------------- End Role Details-----------------------------------------------*/

            //---------------- User Rights Exception
            $('#gvUserIDList tr td').click(function () {
                debugger;

                if ($(this).find("#chkUserIDChecked").prop("checked")) {
                    $(this).find("#chkUserIDChecked").prop("checked", false);
                }
                else {
                    $(this).find("#chkUserIDChecked").prop("checked", true);
                }

                if ($(this).find("#lblUserID").text() == "Select All") {
                    if ($(this).find("#chkUserIDChecked").prop("checked")) {
                        for (var i = 1; i < $('#gvUserIDList tr').length; i++) {
                            var tr = $('#gvUserIDList tr')[i];
                            $(tr).find("#chkUserIDChecked").prop("checked", true);
                        }
                    }
                    else {
                        for (var i = 1; i < $('#gvUserIDList tr').length; i++) {
                            var tr = $('#gvUserIDList tr')[i];
                            $(tr).find("#chkUserIDChecked").prop("checked", false);
                        }
                    }
                }
                else {
                    var rowCount = $('#gvUserIDList tr').length - 2;

                    var checkedCount = 0;
                    for (var i = 2; i < $('#gvUserIDList tr').length; i++) {
                        var tr = $('#gvUserIDList tr')[i];
                        if ($(tr).find("#chkUserIDChecked").prop("checked")) {
                            checkedCount++;
                        }
                    }
                    if (checkedCount == rowCount) {
                        var tr = $('#gvUserIDList tr')[1];
                        $(tr).find("#chkUserIDChecked").prop("checked", true);
                    }
                    else {
                        var tr = $('#gvUserIDList tr')[1];
                        $(tr).find("#chkUserIDChecked").prop("checked", false);
                    }
                }
            });
            //----------------End User Rights Exception
            $('.mobileNoValidation').keypress(function (evt) {
                var charCode = (evt.which) ? evt.which : evt.keyCode;
                var pos = evt.target.selectionStart;
                if ((charCode < 48 || charCode > 57)) {
                    return false;
                }
                if ($(this).val().length > 9) {
                    return false;
                }
                return true;
            });
            $('.pin-validation').keypress(function (evt) {
                var charCode = (evt.which) ? evt.which : evt.keyCode;
                var pos = evt.target.selectionStart;
                if ((charCode < 48 || charCode > 57)) {
                    return false;
                }
                if ($(this).val().length > 5) {
                    return false;
                }
                return true;
            });
            function isEmail(email) {
                var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
                return regex.test(email);
            }
            function openWarningModal(msg) {
                $("#lblWarningMsg").text(msg);
                $("#warningModal").modal('show');
            }
            function openErrorModal(msg) {
                $('#errorModal').modal('show');
                $('#lblErrorMsg').text(msg);
            }
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
            function allowNumberic(evt) {
                var charCode = (evt.which) ? evt.which : evt.keyCode;
                if ((charCode < 48 || charCode > 57)) {
                    return false;
                }
                return true;
            }
        });
    </script>
</asp:Content>
