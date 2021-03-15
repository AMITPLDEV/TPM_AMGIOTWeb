<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserRoleRights.aspx.cs" Inherits="NewProject.UserRoleRights" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="Scripts/Toaster/toastr.min.js"></script>
    <link href="Scripts/Toaster/toastr.min.css" rel="stylesheet" />

    <style>
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
    </style>
    <div class="themetoggle">
        <asp:HiddenField runat="server" ID="hdnScrollPos" ClientIDMode="Static" />
        <div style="float: left; margin-top: 5px">
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <div class="navbar-collapse collapse" style="height: 42px !important;">
                        <ul class="nav navbar-nav nextPrevious submenus-style ">
                            <li><a runat="server" class="submenuData" id="A15" clientidmode="static" data-toggle="tab" href="#userRoleRightsMenu0">Role Rights</a>
                                <i></i>
                            </li>
                            <li><a runat="server" class="submenuData" id="A14" clientidmode="static" data-toggle="tab" href="#userRightExceptionMenu1">User Rights Exception</a>
                                <i></i>
                            </li>
                        </ul>
                    </div>
                    <div style="display: none">
                        <asp:Button runat="server" ID="btnUserRoleRights" OnClick="btnUserRoleRights_Click" />
                        <asp:Button runat="server" ID="btnUserRightException" OnClick="btnUserRightException_Click" />
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="tab-content themetoggle" id="masterContainer" style="overflow: auto; width: 100%; margin: -10px auto;">
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
                                            <td>&nbsp;&nbsp;<asp:Button runat="server" ID="btnUserRoleRightsView" Text="View" CssClass="Btns" OnClick="btnUserRoleRightsView_Click" />
                                                &nbsp;&nbsp;<asp:Button runat="server" ID="btnUserRoleRightsSave" Text="Save" CssClass="Btns" OnClick="btnUserRoleRightsSave_Click" />
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
                    <div id="gvCompanyConatiner" class="gridContainer" style="margin-top: 10px; width: 95vw; overflow: auto">
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
                                                                                 <asp:RadioButton GroupName="userRightAll" ID="RadioButton1" runat="server"  Checked='<%# Eval("IsReadChecked") %>' onchange="return userRightExceptionRadioBtnClick(this,'All');" CssClass="rmnRadioBtns"/>
                                                                            </td>
                                                                            <td style="border-bottom: none">Modify
                                                                                 <asp:RadioButton GroupName="userRightAll" ID="RadioButton2" runat="server"  Checked='<%# Eval("IsModifyChcked") %>' onchange="return userRightExceptionRadioBtnClick(this,'All');" CssClass="rmnRadioBtns"/>
                                                                            </td>
                                                                            <td style="border-bottom: none">None
                                                                                 <asp:RadioButton GroupName="userRightAll" ID="RadioButton3" runat="server"  Checked='<%# Eval("IsNoneChacked") %>' onchange="return userRightExceptionRadioBtnClick(this,'All');" CssClass="rmnRadioBtns"/>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                                <div style='display: <%# Eval("DataTemplateVisibility") %>'>
                                                                    <table class="templatesTbl radioBtnTbl">
                                                                        <tr>
                                                                            <td>
                                                                                <asp:HiddenField runat="server" ID="hfRoleID" ClientIDMode="Static" Value='<%# Eval("RoleID") %>' />
                                                                                <asp:RadioButton ID="rbRead" GroupName="userRoleRight" runat="server" Checked='<%# Eval("IsReadChecked") %>' Style="border-bottom: none" CssClass="rmnRadioBtns"  onchange="return userRightExceptionRadioBtnClick(this,'');"/>
                                                                            </td>
                                                                            <td>
                                                                                <asp:RadioButton ID="rbModify" GroupName="userRoleRight" runat="server" Checked='<%# Eval("IsModifyChcked") %>' Style="border-bottom: none" CssClass="rmnRadioBtns" onchange="return userRightExceptionRadioBtnClick(this,'');" />
                                                                            </td>
                                                                            <td>
                                                                                <asp:RadioButton ID="rbNone" GroupName="userRoleRight" runat="server" Checked='<%# Eval("IsNoneChacked") %>' Style="border-bottom: none" CssClass="rmnRadioBtns" onchange="return userRightExceptionRadioBtnClick(this,'');"/>
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
                                                <asp:Button runat="server" ID="btnUserRightExptnView" Text="View" CssClass="Btns" OnClick="btnUserRightExptnView_Click" OnClientClick="return userRightExceptionViewValidation();" />&nbsp;&nbsp;
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


                                    <div style="width: 9%; display: inline-block" >
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
                            <div id="userAsignedContainer" style="height: 75vh; overflow: auto; width: 89%; display: inline-block; vertical-align: top" >
                                    <asp:ListView runat="server" ID="lvUserAssignedToRole">
                                        <LayoutTemplate>
                                            <table class="P1Table userRightsTbl" id="userRightException">
                                                <tr id="itemplaceholder" runat="server"></tr>
                                            </table>
                                        </LayoutTemplate>
                                        <ItemTemplate>
                                            <tr>
                                                <td><asp:Label runat="server" ID="lblCompanyID" Text='<%# Eval("CompanyID") %>'></asp:Label></td>
                                                <td><asp:Label runat="server" ID="lblModule" Text='<%# Eval("Module") %>'></asp:Label></td>
                                                <td><asp:Label runat="server" ID="lblScreen" Text='<%# Eval("Screen") %>'></asp:Label></td>
                                                <td style="padding:0px">
                                                    <asp:ListView runat="server" ID="lvUserAssignedToRoleRights" DataSource='<%# Eval("UserRightValue") %>'>
                                                        <LayoutTemplate>
                                                            <table class="userRightsInnerTbl" id="userInfoTbl">
                                                                <tr>
                                                                    <td id="itemplaceholder" runat="server"></td>
                                                                </tr>
                                                            </table>
                                                        </LayoutTemplate>
                                                        <ItemTemplate>
                                                            <td style="border-bottom:none;padding:0px" class="userInfoTd">
                                                                <div style='display: <%# Eval("HeaderTemplateVisibility") %>'>
                                                                    <table class="templatesTbl radioAllBtnTbl">
                                                                        <tr>
                                                                            <td colspan="3" style="text-align:center">
                                                                                <asp:Label runat="server" ID="lblUserID" ClientIDMode="Static" Text='<%# Eval("UserID") %>'></asp:Label>
                                                                                </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="border-bottom:none">Read
                                                                                 <asp:RadioButton GroupName="userRightAll" ID="RadioButton1" runat="server"  Checked='<%# Eval("IsReadChecked") %>' onchange="return userRightExceptionRadioBtnClick(this,'All');" CssClass="rmnRadioBtns"/>
                                                                            </td>
                                                                            <td style="border-bottom:none">Modify
                                                                                 <asp:RadioButton GroupName="userRightAll" ID="RadioButton2" runat="server"  Checked='<%# Eval("IsModifyChcked") %>' onchange="return userRightExceptionRadioBtnClick(this,'All');" CssClass="rmnRadioBtns"/>
                                                                            </td>
                                                                            <td style="border-bottom:none">None
                                                                                <asp:RadioButton GroupName="userRightAll" ID="RadioButton3" runat="server"  Checked='<%# Eval("IsNoneChacked") %>' onchange="return userRightExceptionRadioBtnClick(this,'All');" CssClass="rmnRadioBtns"/>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                                <div style='display: <%# Eval("DataTemplateVisibility") %>'>
                                                                    <table  class="templatesTbl radioBtnTbl">
                                                                        <tr>
                                                                            <td style="border-bottom:none">
                                                                               
                                                                              <asp:RadioButton GroupName="userRight" ID="rbRead" runat="server"  Checked='<%# Eval("IsReadChecked") %>'  CssClass="rmnRadioBtns" onchange="return userRightExceptionRadioBtnClick(this,'');"/>
                                                                            </td>
                                                                            <td style="border-bottom:none">
                                                                               <asp:RadioButton GroupName="userRight" ID="rbModify" runat="server"  Checked='<%# Eval("IsModifyChcked") %>' CssClass="rmnRadioBtns" onchange="return userRightExceptionRadioBtnClick(this,'');"/>
                                                                            </td>
                                                                            <td style="border-bottom:none">
                                                                               <asp:RadioButton GroupName="userRight" ID="rbNone" runat="server"  Checked='<%# Eval("IsNoneChacked") %>' CssClass="rmnRadioBtns" onchange="return userRightExceptionRadioBtnClick(this,'');"/>
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


    <script>
        var submenu = "";
        $(document).ready(function () {
            debugger;
            if (localStorage.getItem("userRoleRightSelectedMenu")) {
                debugger;
                submenu = localStorage.getItem("userRoleRightSelectedMenu");
            }
            $(submenu).addClass("in active");
            $("a[href$='" + submenu + "']").removeClass("selected-menu-style").addClass("selected-Submenu");
            $("a[href$='" + submenu + "']").closest('li').find('i').addClass("arrow up selected-Submenu-ArrowUp");
            // setGridHeight();
            setDateTimePicker();
        });
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
        function setDateTimePicker() {

        }
        function setActiveSubmenuValue() {
            debugger;
            localStorage.setItem("userRoleRightSelectedMenu", "#userRoleRightsMenu0");
        }
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
            if (submenu == "#userRoleRightsMenu0") {
                __doPostBack('<%= btnUserRoleRights.UniqueID%>', '');
            }
            else {
                __doPostBack('<%= btnUserRightException.UniqueID%>', '');
            }
            localStorage.setItem("userRoleRightSelectedMenu", submenu);
        });

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
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
            $(document).ready(function () {
                if (localStorage.getItem("userRoleRightSelectedMenu")) {
                    debugger;
                    submenu = localStorage.getItem("userRoleRightSelectedMenu");
                }
                $(submenu).addClass("in active");
                $("a[href$='" + submenu + "']").removeClass("selected-menu-style").addClass("selected-Submenu");
                $("a[href$='" + submenu + "']").closest('li').find('i').addClass("arrow up selected-Submenu-ArrowUp");

                // setGridHeight();
                setDateTimePicker();
                $.unblockUI({});
            });
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
                if (submenu == "#userRoleRightsMenu0") {
                    __doPostBack('<%= btnUserRoleRights.UniqueID%>', '');
                }
                else {
                    __doPostBack('<%= btnUserRightException.UniqueID%>', '');
                }
                localStorage.setItem("userRoleRightSelectedMenu", submenu);
            });

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
        });
    </script>
</asp:Content>
