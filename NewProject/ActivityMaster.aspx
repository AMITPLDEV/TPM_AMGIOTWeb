<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ActivityMaster.aspx.cs" Inherits="NewProject.ActivityMaster" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
       <script src="Scripts/Toaster/toastr.min.js"></script>
    <link href="Scripts/Toaster/toastr.min.css" rel="stylesheet" />

    <script src="Scripts/DateTimePickerFor331/moment.js"></script>
    <script src="Scripts/DateTimePickerFor331/bootstrap-datetimepicker.min.js"></script>
    <link href="Scripts/DateTimePickerFor331/bootstrap-datetimepicker.min.css" rel="stylesheet" />
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
    </style>
    <div class="themetoggle">
        <asp:HiddenField runat="server" ID="hdnScrollPos" ClientIDMode="Static" />
        <div style="float: left; margin-top: 5px">
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <div class="navbar-collapse collapse" style="height: 42px !important;">
                        <ul class="nav navbar-nav nextPrevious submenus-style ">
                            <li><a runat="server" class="submenuData" id="A15" clientidmode="static" data-toggle="tab" href="#activityMenu0">Group</a>
                                <i></i>
                            </li>
                            <li><a runat="server" class="submenuData" id="A14" clientidmode="static" data-toggle="tab" href="#activityMenu1">Company</a>
                                <i></i>
                            </li>
                        </ul>
                    </div>
                    <div style="display: none">
                        <asp:Button runat="server" ID="btnActivityMaster" OnClick="btnActivityMaster_Click" />
                        <asp:Button runat="server" ID="btnActivityTimingMaster" OnClick="btnActivityTimingMaster_Click" />
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="tab-content themetoggle" id="masterContainer" style="overflow: auto; width: 100%; margin: -10px auto;">
                <div id="activityMenu0" class="tab-pane fade">
                    <div>
                        <fieldset class="field-set" style="display: inline-block;">
                            <legend>&nbsp;<b>Filter By</b></legend>
                            <table class="filterTbl filter-field-table">
                                <tr>
                                    <td>
                                        Frequency
                                    </td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="ddlFrequency_ForActivityMasterView" CssClass="form-control dropdown-list" ClientIDMode="Static"></asp:DropDownList>
                                    </td>
                                    <td>&nbsp;&nbsp;<asp:Button runat="server" ID="btnActivityMasterView" ClientIDMode="Static" Text="View" CssClass="Btns" OnClick="btnActivityMasterView_Click" />
                                        &nbsp;&nbsp;<asp:Button runat="server" ID="btnNewEditActivityMaster" ClientIDMode="Static" Text="New Activity" CssClass="Btns" OnClientClick="return btnNewEditActivityMasterClick(this,'New');" />
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </div>
                    <div class="gridContainer" style="margin-top: 10px; width: 95vw; overflow: auto">
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                        <table class="P1Table">
                            <tr>
                                <th>Sl. No.</th>
                                <th>Activity</th>
                                <th>Frequency</th>
                            </tr>
                            <tr>
                                <td>1.</td>
                                <td>Activity 1</td>
                                <td>Day</td>
                            </tr>
                        </table>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnActivityMaster" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnActivityTimingMaster" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
                <div id="activityMenu1" class="tab-pane fade">
                    <div>
                        <fieldset class="field-set" style="display: inline-block;">
                            <legend>&nbsp;<b>Filter By</b></legend>
                            <table class="filterTbl filter-field-table">
                                <tr>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtCompanySearch" CssClass="form-control" placeholder="Search"></asp:TextBox>
                                    </td>
                                    <td>&nbsp;&nbsp;<asp:Button runat="server" ID="btnViewCompany" ClientIDMode="Static" Text="View" CssClass="Btns" OnClick="btnViewCompany_Click" />
                                        &nbsp;&nbsp;<asp:Button runat="server" ID="btnNewEditCompany" ClientIDMode="Static" Text="New Company" CssClass="Btns" OnClientClick="return btnNewEditCompanyClick(this,'New');" />
                                        &nbsp;&nbsp;<asp:Button runat="server" ID="btnExportCompany" ClientIDMode="Static" Text="Export" CssClass="Btns" />
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </div>
                    <div id="gvCompanyConatiner" class="gridContainer" style="margin-top: 10px; width: 95vw; overflow: auto">
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                              
                            </ContentTemplate>
                            <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="btnActivityMaster" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnActivityTimingMaster" EventName="Click" />
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

        <!------------------------------Activity Master Details--------------------------------->

    <div class="modal fade" id="companyDeleteConfirmModal" role="dialog">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content modalContent confirm-modal-content">
                <div class="modal-header modalHeader confirm-modal-header">
                    <i class="glyphicon glyphicon glyphicon glyphicon-question-sign modal-icons"></i>
                    <br />
                    <h4 class="confirm-modal-title">Confirmation!</h4>
                    <br />
                    <span class="confirm-modal-msg">Are you sure you want to delete Record?</span>
                </div>
                <div class="modal-footer modalFooter modal-footer">
                    <asp:Button runat="server" Text="Yes" ID="btnDeleteCompanyConfirm" CssClass="confirm-modal-btn" OnClick="btnDeleteCompanyConfirm_Click" ClientIDMode="Static" />
                    <input type="button" value="No" data-dismiss="modal" class="confirm-modal-btn" />
                </div>
            </div>
        </div>
    </div>

    <div class="modal infoModal" id="neweditActivityModal" role="dialog" style="min-width: 300px;" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modal-dialog-centered " style="width: 38%">
            <div class="modal-content modalThemeCss">
                <div class="modal-header">
                    <h4 class="modal-title"></h4>
                    <asp:HiddenField runat="server" ID="hfActivityMasterNewEdit" ClientIDMode="Static" />
                </div>
                <div class="modal-body" style="padding-left: 0px; padding-right: 0px">
                    <span style="color: red; margin-left: 20px;" class="mandatory-message"></span>
                            <div style="padding-left: 15px; padding-right: 15px; padding-bottom: 8px;" class="div-border-style">
                                <table style="width: 100%; margin: auto" class="modal-tbl">
                                    <tr>
                                        <td>Frequency *</td>
                                        <td>
                                        <%--    <asp:DropDownList runat="server" ID="ddlGroup_ForCompany" ClientIDMode="Static" CssClass="form-control dropdown-list txtstyle"></asp:DropDownList>--%>
                                            <asp:Label runat="server" ID="lblFrequency_ForActivityMasterNewEdit" ClientIDMode="Static"></asp:Label>
                                        </td>
                                        <td></td>
                                        <td style="width: 230px"></td>
                                    </tr>
                                </table>
                            </div>
                    <div style="padding-left: 15px; padding-right: 15px; padding-bottom: 8px; padding-top: 8px;" class="div-border-style">
                        <table id="tblNewCompany" style="width: 100%; margin: auto" class="modal-tbl">
                            <tr>
                                <td>Activity Name</td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtActivityName" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Effective From Date *</td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtActivityMasterEffFromDate" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle" Style="position: relative" placeholder="DD-MM-YYYY HH:mm:ss"></asp:TextBox>
                                </td>
                                <td>Effective To Date *</td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtActivityMasterEffToDate" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle" Style="position: relative" placeholder="DD-MM-YYYY HH:mm:ss"></asp:TextBox>
                                </td>
                            </tr>

                        </table>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" ID="btnNewEditCompanySave" Text="Save" CssClass="Btns" OnClientClick="return btnNewEditCompanySaveClick();" OnClick="btnNewEditCompanySave_Click" />
                    <button type="button" data-dismiss="modal" class="Btns">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!------------------------------End Activity Master Details------------------------------->
      <script>
        var submenu = "";
        $(document).ready(function () {
            debugger;
            if (localStorage.getItem("activitySelectedMenu")) {
                debugger;
                submenu = localStorage.getItem("activitySelectedMenu");
            }
            $(submenu).addClass("in active");
            $("a[href$='" + submenu + "']").removeClass("selected-menu-style").addClass("selected-Submenu");
            $("a[href$='" + submenu + "']").closest('li').find('i').addClass("arrow up selected-Submenu-ArrowUp");
            // setGridHeight();
            setDateTimePicker();
        });
        function setDateTimePicker() {
            $('[id$=txtActivityMasterEffFromDate]').datetimepicker({
                format: 'DD-MM-YYYY HH:mm:ss',
                locale: 'en-US'
            });
             $('[id$=txtActivityMasterEffToDate]').datetimepicker({
                format: 'DD-MM-YYYY HH:mm:ss',
                locale: 'en-US'
            });
        
        }
        function setActiveSubmenuValue() {
            debugger;
            localStorage.setItem("activitySelectedMenu", "#activityMenu0");
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
            if (submenu == "#activityMenu0") {
                __doPostBack('<%= btnActivityMaster.UniqueID%>', '');
            }
            else {
                __doPostBack('<%= btnActivityTimingMaster.UniqueID%>', '');
            }
            localStorage.setItem("activitySelectedMenu", submenu);
        });

        //------------------------Activity Master Details-----------------------------------
        function btnNewEditActivityMaster(element, param) {
            if (param == "New") {
                $("#lblFrequency_ForActivityMasterNewEdit").val($("#ddlFrequency_ForActivityMasterView").val());
                $("#neweditActivityModal  .modal-title").text("Add Activity");
                $("#hfActivityMasterNewEdit").val("New");
            } else {
                $("#ddlGroup_ForCompany").prop('disabled', true);
                $("#neweditActivityModal  .modal-title").text("Edit Activity");
                $("#hfActivityMasterNewEdit").val("Edit");
            }
            $(".mandatory-message").text("");
            $("#neweditActivityModal").modal('show');
            return false;
        }
        function btnNewEditCompanySaveClick() {
            if ($("#txtCompanyID").val() == "") {
                $(".mandatory-message").text("Company ID is required.");
                return false;
            } else if ($("#txtCompanyName").val() == "") {
                $(".mandatory-message").text("Company Name is required.");
                return false;
            } else if ($("#txtCompanyEffFromDate").val() == "") {
                $(".mandatory-message").text("Effective From Date is required.");
                return false;
            } else if ($("#txtCompanyEffToDate").val() == "") {
                $(".mandatory-message").text("Effective To Date is required.");
                return false;
            } else if ($("#txtCompanyUserId").val() == "") {
                $(".mandatory-message").text("Company admin is required.");
                return false;
            } else if ($("#txtCompanyUserPassword").val() == "") {
                $(".mandatory-message").text("Password is required.");
                return false;
            }
            return true;
        }
        function openCompanyDeleteConfirmModal() {
            $("#companyDeleteConfirmModal").modal('show');
        }
        //------------------------End Activity Master Details-----------------------------------

      
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
                if (localStorage.getItem("activitySelectedMenu")) {
                    debugger;
                    submenu = localStorage.getItem("activitySelectedMenu");
                }
                $(submenu).addClass("in active");
                $("a[href$='" + submenu + "']").removeClass("selected-menu-style").addClass("selected-Submenu");
                $("a[href$='" + submenu + "']").closest('li').find('i').addClass("arrow up selected-Submenu-ArrowUp");

                // setGridHeight();
                setDateTimePicker();
                $.unblockUI({});
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
                if (submenu == "#activityMenu0") {
                    __doPostBack('<%= btnActivityMaster.UniqueID%>', '');
                }
                else {
                    __doPostBack('<%= btnActivityTimingMaster.UniqueID%>', '');
                }
                localStorage.setItem("activitySelectedMenu", submenu);
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
