<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProcessParameterListOfValues.aspx.cs" Inherits="NewProject.ProcessParameterListOfValues" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="Scripts/DateTimePickerFor331/moment.js"></script>
    <script src="Scripts/DateTimePickerFor331/bootstrap-datetimepicker.min.js"></script>
    <link href="Scripts/DateTimePickerFor331/bootstrap-datetimepicker.min.css" rel="stylesheet" />

    <link href="Scripts/MultiSelectDropdown/bootstrap-multiselect.css" rel="stylesheet" />
    <script src="Scripts/MultiSelectDropdown/bootstrap-multiselect.js"></script>
    <style>
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
         .multiselect-native-select > .btn-group > button{
            border-radius: 10px;
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

        .P1Table tr th {
            z-index: 3;
        }
    </style>
    <div class="themetoggle" style="width: 99vw; margin-left: 0px">
        <table class="submenu-right-side" id="right-table">
            <tr>
                <td style="padding-top: 4px">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <asp:DropDownList runat="server" ID="ddlCompany" CssClass="form-control dropdown-list" AutoPostBack="true" OnSelectedIndexChanged="ddlCompany_SelectedIndexChanged" Style="display: inline-block; width: 150px;" ClientIDMode="Static"></asp:DropDownList>
                            <asp:DropDownList runat="server" ID="ddlPlant" CssClass="form-control dropdown-list" AutoPostBack="true" OnSelectedIndexChanged="ddlPlant_SelectedIndexChanged" Style="display: inline-block; width: 150px;" ClientIDMode="Static"></asp:DropDownList>
                            <asp:ListBox ID="multiselectddlMachineID" runat="server" SelectionMode="Multiple" AutoPostBack="true" OnSelectedIndexChanged="multiselectddlMachineID_SelectedIndexChanged" CssClass="dropdown-list" ClientIDMode="Static" Style="width: 150px; display: inline-block"></asp:ListBox>
                        </ContentTemplate>
                         <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="ddlCompany" EventName="SelectedIndexChanged" />
                                            <asp:AsyncPostBackTrigger ControlID="ddlPlant" EventName="SelectedIndexChanged" />
                                        </Triggers>
                    </asp:UpdatePanel>

                </td>
                <td onmouseover="showPanelsTopRight(this,'panelExport','5px','40px');" onmouseout="hidePanels(this,'panelExport')">
                    <i class="glyphicon glyphicon-save" style="font-size: 17px;"></i>
                    <div class="panel panel-default panel-subitems" id="panelExport" onmouseover="showPanelsTopRight(this,'panelExport','5px','40px');" onmouseout="hidePanels(this,'panelExport')">
                        <div class="panel-body">
                            <ul class="outer-ul">
                                <li>
                                    <asp:Button runat="server" ID="btnExportToExcel" Text="Export To Excel" CssClass="btn-to-span-looks" OnClick="btnExportToExcel_Click" />
                                </li>
                                <%--<li>
                                    <span>Export as PDF</span>
                                </li>--%>
                            </ul>
                        </div>
                    </div>
                </td>
                <%--   <td onmouseover="showPanelsTopRight(this,'panelView','5px','40px');" onmouseout="hidePanels(this,'panelView')">
                    <i class="glyphicon glyphicon-th" style="font-size: 17px;"></i>
                    <div class="panel panel-default panel-subitems" id="panelView" onmouseover="showPanelsTopRight(this,'panelView','5px','40px');" onmouseout="hidePanels(this,'panelView')" style="width: 200px;">
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
                </td>--%>
                <td>
                    <%--onmouseout="hidePanels(this,'panelFilter')"--%>
                    <i class="glyphicon glyphicon-filter" style="font-size: 17px;" onclick="showPanelFilter(this,'panelFilter','5px','40px', 'ulFilter');"></i>
                    <%--onmouseover="showPanelFilter(this,'panelFilter','5px','40px', 'ulFilter');" onmouseout="hidePanels(this,'panelFilter')"--%>
                    <div class="panel panel-default panel-subitems" id="panelFilter" style="width: 24%">
                        <%--style="width: 20%;"--%>
                        <div class="panel-body">
                            <i class="glyphicon glyphicon-remove" style="float: right" onclick="hidePanel('panelFilter')"></i>
                            <div id="divgraph6Filter">

                                <div style="border: 1px solid red; padding: 8px 5px 5px 5px; margin-top: 30px">
                                    <asp:TextBox runat="server" ID="txtSearchParameters" ClientIDMode="Static" placeholder="Search Parameters" onkeyup="searchParameters();" AutoCompleteType="Disabled" CssClass="form-control" Style="margin-left: 5px"></asp:TextBox>
                                    <asp:CheckBox runat="server" ID="cbCommonParametersOnly" ClientIDMode="Static" Font-Bold="false" Text="Common Parameters Only" AutoPostBack="true" CssClass="checkbox-text-fontweightset" OnCheckedChanged="cbCommonParametersOnly_CheckedChanged" />
                                    <asp:CheckBox runat="server" ID="cbSelectAll" ClientIDMode="Static" onchange="selctAllParameters();" Font-Bold="false" Text="Select All" CssClass="checkbox-text-fontweightset" Style="margin-left: 10px" />
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <div style="height: 250px; overflow: auto;">
                                                <asp:CheckBoxList runat="server" ID="cbParameterList" CssClass="checkbox-list" ClientIDMode="Static" RepeatDirection="Vertical" RepeatColumns="2" onchange="selctAllParametersWhenChange();"></asp:CheckBoxList>
                                            </div>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="ddlCompany" EventName="SelectedIndexChanged" />
                                            <asp:AsyncPostBackTrigger ControlID="ddlPlant" EventName="SelectedIndexChanged" />
                                            <asp:AsyncPostBackTrigger ControlID="multiselectddlMachineID" EventName="SelectedIndexChanged" />
                                            <asp:AsyncPostBackTrigger ControlID="cbCommonParametersOnly" EventName="CheckedChanged" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </div>
                                <table>
                                    <tr>
                                        <td>From Date:
                                        </td>
                                        <td class="input-group" style="min-width: 150px; border: 0">
                                            <asp:TextBox ID="txtFromDateTime" runat="server" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control datetime-txtstyle" placeholder="From Date" Style="display: inline; margin-bottom: 8px;"></asp:TextBox>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Select Hour:
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
                                    </tr>
                                </table>
                                <%-- <asp:CheckBoxList runat="server" ID="cblLimitSelection" CssClass="checkbox-list" ClientIDMode="Static" RepeatDirection="Vertical" RepeatColumns="2">
                                    <asp:ListItem Value="UpperWarningLimit" Text="Upper Warning Limit"></asp:ListItem>
                                    <asp:ListItem Value="LowerWarningLimit" Text="Lower Warning Limit"></asp:ListItem>
                                </asp:CheckBoxList>--%>
                                <asp:Button runat="server" ID="btnOK" ClientIDMode="Static" OnClientClick="callLoader();" OnClick="btnOK_Click" CssClass="Btns" Style="margin-left: 20px" Text="OK" />
                            </div>
                        </div>
                    </div>
                </td>

                <%-- <td>
                    <i class="glyphicon glyphicon-triangle-right" id="btnnext" onclick="shownextprev('next');" style="font-size: 17px;"></i>
                    <i class="glyphicon glyphicon-triangle-left" id="btnprev" onclick="shownextprev('prev');" style="font-size: 17px;"></i>
                </td>--%>
            </tr>
        </table>

        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <div class="grid-container" style="overflow: scroll; width: 98%; margin: auto">

                    <asp:GridView ID="gvListOfValues" ClientIDMode="Static" runat="server" AutoGenerateColumns="False" ShowHeaderWhenEmpty="True"
                        CssClass="P1Table">
                        <EmptyDataTemplate>
                            <div style="text-align: center; font-weight: bold; font-size: 18px">No Data Found</div>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnOK" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>


    </div>
    <script>

        $(document).ready(function () {
            $('[id$=txtFromDateTime]').datetimepicker({
                format: 'DD-MM-YYYY HH:mm:ss',
                locale: 'en-US'
            });
            $('[id$=txtToDateTime]').datetimepicker({
                format: 'DD-MM-YYYY HH:mm:ss',
                locale: 'en-US'
            });
            $('[id$=multiselectddlMachineID]').multiselect({
                includeSelectAllOption: true
            });
            $('#right-table').appendTo('#right-side-filters');
            setGridHeight();
        });
        function setGridHeight() {
            var Height = $(window).height() - 100;
            $(".grid-container").css('height', Height);
        }
        $(window).resize(function () {            setGridHeight();        });
        function searchParameters() {
            let searchtxt = $("#txtSearchParameters").val();
            for (let i = 0; i < $("[id*=cbParameterList] tr td").length; i++) {
                let td = $("[id*=cbParameterList] tr td")[i];
                let labeltxt = $(td).find('label').text();
                let inputtxt = $(td).find('input').val();
                if (labeltxt.toLowerCase().includes(searchtxt.toLowerCase())) {
                    $(td).css({ 'display': 'inline-block' });
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
        function sucessMsg(msg, title, type) {
            toastr.options = {
                "closeButton": false,
                "debug": false,
                "newestOnTop": false,
                "progressBar": true,
                "positionClass": "toast-top-right",
                "preventDuplicates": true,
                "onclick": null,
                "showDuration": "3000",
                "hideDuration": "10000",
                "timeOut": "2000",
                "extendedTimeOut": "1000",
                "showEasing": "swing",
                "hideEasing": "linear",
                "showMethod": "fadeIn",
                "hideMethod": "fadeOut"
            }
            var d = Date();
            if (type == "warning") {
                toastr.warning(msg, title);
            } else if (type == "error") {
                toastr.error(msg, title);
            } else {
                toastr.success(msg, title);
            }

            return false;
        }
        function showPanelFilter(element, panelid, rightvalue, topvalue, ulid) {
            $("#divgraph6Filter").css('display', 'block');
            document.getElementById(panelid).style.visibility = "visible";
            $("#" + panelid).css({ 'right': rightvalue, 'top': topvalue });
        }
        function hidePanel(panelid) {
            document.getElementById(panelid).style.visibility = "hidden";
        }
        function callLoader() {
            $.blockUI({ message: '<img runat="server" src="Images/Loading.gif" />' });
            hidePanel('panelFilter');
        }
          var multiselctListExpand = false;
        function stayMultiselectedList() {
            multiselctListExpand = true;
        }
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
            $(document).ready(function () {
                $('[id$=txtFromDateTime]').datetimepicker({
                    format: 'DD-MM-YYYY HH:mm:ss',
                    locale: 'en-US'
                });
                $('[id$=txtToDateTime]').datetimepicker({
                    format: 'DD-MM-YYYY HH:mm:ss',
                    locale: 'en-US'
                });
                $('[id$=multiselectddlMachineID]').multiselect({
                    includeSelectAllOption: true
                });
                $('#right-table').appendTo('#right-side-filters');
                setGridHeight();
                    if (multiselctListExpand) {
                    $(".btn-group").addClass('open');
                } else {
                    $(".btn-group").removeClass('open');
                }
                multiselctListExpand = false;
            });
            function setGridHeight() {
                var Height = $(window).height() - 100;
                $(".grid-container").css('height', Height);
            }
            $(window).resize(function () {                setGridHeight();            });

            function sucessMsg(msg, title, type) {
                toastr.options = {
                    "closeButton": false,
                    "debug": false,
                    "newestOnTop": false,
                    "progressBar": true,
                    "positionClass": "toast-top-right",
                    "preventDuplicates": true,
                    "onclick": null,
                    "showDuration": "3000",
                    "hideDuration": "10000",
                    "timeOut": "2000",
                    "extendedTimeOut": "1000",
                    "showEasing": "swing",
                    "hideEasing": "linear",
                    "showMethod": "fadeIn",
                    "hideMethod": "fadeOut"
                }
                var d = Date();
                if (type == "warning") {
                    toastr.warning(msg, title);
                } else if (type == "error") {
                    toastr.error(msg, title);
                } else {
                    toastr.success(msg, title);
                }

                return false;
            }
            function showPanelFilter(element, panelid, rightvalue, topvalue, ulid) {
                $("#divgraph6Filter").css('display', 'block');
                document.getElementById(panelid).style.visibility = "visible";
                $("#" + panelid).css({ 'right': rightvalue, 'top': topvalue });
            }
            function hidePanel(panelid) {
                document.getElementById(panelid).style.visibility = "hidden";
            }
        });
    </script>
</asp:Content>
