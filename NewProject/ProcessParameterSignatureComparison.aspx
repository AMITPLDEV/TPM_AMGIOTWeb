<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProcessParameterSignatureComparison.aspx.cs" Inherits="NewProject.ProcessParameterSignatureComparison" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <%--     <script src="Scripts/DateTimePicker/bootstrap-datepicker.en-IE.min.js"></script>
    <script src="Scripts/DateTimePicker/bootstrap-datepicker.zh-CN.min.js"></script>--%>



  <%--    <script src="https://code.highcharts.com/stock/highstock.js"></script>
    <script src="https://code.highcharts.com/stock/modules/data.js"></script>
    <script src="https://code.highcharts.com/stock/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/stock/modules/export-data.js"></script>

    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/highcharts-3d.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/modules/export-data.js"></script>
    <script src="https://code.highcharts.com/modules/accessibility.js"></script>--%>

    <script src="Scripts/HighStock9.0.0/highstock.js"></script>
    <script src="Scripts/HighStock9.0.0/data.js"></script>
    <script src="Scripts/HighStock9.0.0/exporting.js"></script>
    <script src="Scripts/HighStock9.0.0/export-data.js"></script>

    <script src="Scripts/HighChart9.0.0/highcharts.js"></script>
    <script src="Scripts/HighChart9.0.0/highcharts-3d.js"></script>
    <script src="Scripts/HighChart9.0.0/exporting.js"></script>
    <script src="Scripts/HighChart9.0.0/export-data.js"></script>
    <script src="Scripts/HighChart9.0.0/accessibility.js"></script>



   <%--  <script src="Scripts/Highcharts/highstock.js"></script>

    <script src="Scripts/Highcharts/highcharts.js"></script>
    <script src="Scripts/Highcharts/exporting.js"></script>
    <script src="Scripts/Highcharts/export-data.js"></script>

    <script src="Scripts/Highcharts/stock-data.js"></script>
    <script src="Scripts/Highcharts/stock-exporting.js"></script>
    <script src="Scripts/Highcharts/stock-export-data.js"></script>

    <script src="Scripts/Highcharts/accessibility.js"></script>--%>
       

    <%--    <script type="text/javascript" src="https://www.highcharts.com/samples/data/usdeur.js"></script>--%>


    <%--<script src="Scripts/DateTimePicker/jquery-2.1.1.min.js"></script>
    <link href="Scripts/DateTimePicker/bootstrap-datetimepicker.css" rel="stylesheet" />
    <script src="Scripts/DateTimePicker/moment-with-locales.js"></script>
    <script src="Scripts/DateTimePicker/bootstrap-datetimepicker.js"></script>--%>

    <script src="Scripts/DateTimePickerFor331/moment.js"></script>
    <script src="Scripts/DateTimePickerFor331/bootstrap-datetimepicker.min.js"></script>
    <link href="Scripts/DateTimePickerFor331/bootstrap-datetimepicker.min.css" rel="stylesheet" />

    <link href="Scripts/MultiSelectDropdown/bootstrap-multiselect.css" rel="stylesheet" />
    <script src="Scripts/MultiSelectDropdown/bootstrap-multiselect.js"></script>

    <script src="Scripts/Toaster/toastr.min.js"></script>
    <link href="Scripts/Toaster/toastr.min.css" rel="stylesheet" />

    <%: Scripts.Render("~/bundles/decompress") %>

    <%--    <script src="Scripts/lz-string.js"></script>

    <script src="Scripts/base64-string.js"></script>--%>

    <style>
        .outer-ul .removeHover:hover {
            background-color: unset;
        }

        /*.main-svg{
            background-color: black;
        }*/
        .graph-section {
            width: 100%;
            padding-bottom: 36px;
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

        .light-mode .graph-div {
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

        .outer-ul .removeHover:hover {
            background-color: unset;
        }

        .modal-body {
            background-color: #171e21;
        }

        .light-mode .modal-body {
            background-color: #fff !important
        }

        #ddlMachineID {
            height: 28px;
            padding: 2px 12px;
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

        .multiselect-native-select > .btn-group > button {
            border-radius: 10px;
        }

        .light-mode .multiselect-container label {
            color: black !important;
        }

        .light-mode .multiselect span {
            color: black !important;
        }
        /*.graph-div{
            height: 300px;
        }*/

        .ajax-loader {
            display: none;
            background-color: rgba(0, 0, 0, 0.6);
            position: absolute;
            z-index: +100 !important;
            width: 100%;
            height: 100%;
            margin-left: -15px;
            margin-top: -16px;
        }

        #load-div {
            position: fixed;
            padding-right: 100px;
            width: 30%;
            top: 40%;
            left: 35%;
            text-align: center;
            border: 3px solid rgb(170, 170, 170);
            background-color: rgb(255, 255, 255);
            cursor: wait;
        }

        .ajax-loader img {
            position: relative;
            left: 50%;
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
    </style>
    <div class="themetoggle" style="width: 99vw; margin-left: 0px">
        <table class="submenu-right-side" id="right-table">
            <tr>
                <td style="padding-top: 4px">
                    <%--          <asp:DropDownList runat="server" ID="ddlMachineID" ClientIDMode="Static" CssClass="form-control dropdown-list"></asp:DropDownList>--%>
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
                <%--       <td onmouseover="showPanelsTopRight(this,'panelExport','5px','40px');" onmouseout="hidePanels(this,'panelExport')">
                    <i class="glyphicon glyphicon-save" style="font-size: 17px;"></i>
                    <div class="panel panel-default panel-subitems" id="panelExport" onmouseover="showPanelsTopRight(this,'panelExport','5px','40px');" onmouseout="hidePanels(this,'panelExport')" style="width: 200px;">
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
                </td>--%>
                <%--    <td onmouseover="showPanelsTopRight(this,'panelView','5px','40px');" onmouseout="hidePanels(this,'panelView')">
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
                            <%--onmouseout="$('#panelFilter').css('visibility', 'hidden');"--%>
                            <i class="glyphicon glyphicon-remove" style="float: right" onclick="hidePanel('panelFilter')"></i>
                            <div id="divgraph6Filter">
                                <div style="border: 1px solid red; padding: 8px 5px 5px 5px; margin-top: 30px">
                                    <asp:TextBox runat="server" ID="txtSearchParameters" ClientIDMode="Static" placeholder="Search Parameters" onkeyup="searchParameters();" AutoCompleteType="Disabled" CssClass="form-control" Style="margin-left: 5px"></asp:TextBox>
                                    <asp:CheckBox runat="server" ID="cbCommonParametersOnly" ClientIDMode="Static" Font-Bold="false" Text="Common Parameters Only" AutoPostBack="true" CssClass="checkbox-text-fontweightset" OnCheckedChanged="cbCommonParametersOnly_CheckedChanged" />
                                    <%--<asp:CheckBox runat="server" ID="cbSelectAll" ClientIDMode="Static" onchange="selctAllParameters();" Font-Bold="false" Text="Select All" CssClass="checkbox-text-fontweightset" style="margin-left: 10px" />--%>
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <div style="height: 250px; overflow: auto;">
                                                <asp:CheckBoxList runat="server" ID="cbParameterList" CssClass="checkbox-list" ClientIDMode="Static" RepeatDirection="Vertical" RepeatColumns="2" onchange="selctAllParametersWhenChange();">
                                                </asp:CheckBoxList>
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

                                            <%--    <div class="input-group-addon">
                                        <i class="glyphicon glyphicon-calendar"></i>
                                    </div>--%>
                                            <asp:TextBox ID="txtFromDateTime" runat="server" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control datetime-txtstyle" placeholder="From Date" Style="display: inline; margin-bottom: 8px;"></asp:TextBox>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Select Hour:
                                        </td>
                                        <td class="input-group" style="min-width: 150px; border: 0">
                                            <%-- <asp:TextBox ID="txtToDateTime" runat="server" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control datetime-txtstyle" placeholder="To Date" Style="display: inline; margin-bottom: 10px;"></asp:TextBox>--%>
                                            <asp:DropDownList runat="server" ID="ddlSelectHour" ClientIDMode="Static" CssClass="form-control dropdown-list">
                                                <asp:ListItem Value="0.5" Text="0.5 hr"></asp:ListItem>
                                                <asp:ListItem Value="1" Text="1 hr"></asp:ListItem>
                                                <asp:ListItem Value="2" Text="2 hr"></asp:ListItem>
                                                <asp:ListItem Value="3" Text="3 hr"></asp:ListItem>
                                                <asp:ListItem Value="4" Text="4 hr"></asp:ListItem>
                                                <%--  <asp:ListItem Value="5" Text="5 hr"></asp:ListItem>
                                                <asp:ListItem Value="6" Text="6 hr"></asp:ListItem>
                                                <asp:ListItem Value="7" Text="7 hr"></asp:ListItem>
                                                <asp:ListItem Value="8" Text="8 hr"></asp:ListItem>--%>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                </table>
                                <asp:CheckBoxList runat="server" ID="cblLimitSelection" CssClass="checkbox-list" ClientIDMode="Static" RepeatDirection="Vertical" RepeatColumns="2">
                                    <asp:ListItem Value="UpperWarningLimit" Text="Upper Warning Limit"></asp:ListItem>
                                    <asp:ListItem Value="LowerWarningLimit" Text="Lower Warning Limit"></asp:ListItem>
                                </asp:CheckBoxList>
                                <asp:Button runat="server" ID="btnGraphSixOK" ClientIDMode="Static" OnClientClick="return bindGraphViewCharts();" CssClass="Btns" Style="margin-left: 20px" Text="OK" />
                            </div>
                        </div>
                    </div>
                </td>

                <td>
                    <i class="glyphicon glyphicon-triangle-right" id="btnnext" onclick="shownextprev('next');" style="font-size: 17px;"></i>
                    <i class="glyphicon glyphicon-triangle-left" id="btnprev" onclick="shownextprev('prev');" style="font-size: 17px;"></i>
                </td>
            </tr>
        </table>

        <div class="ajax-loader">
            <div id="load-div">
                <img runat="server" src="Images/Loading.gif" class="img-responsive" />
            </div>
        </div>
        <div class="div-show-nodatafound-message" style="display: none">
            <asp:Label runat="server" ID="lblMessage" CssClass="lbl-nondatafound">No Data Found</asp:Label>
        </div>
        <div class="graph-section" id="graphsix">
        </div>
        <div id="commonZoomBar" class="graph-section" style="position: fixed; bottom: 0px; height: 40px; overflow: hidden">
        </div>
        <%-- <div class="panel panel-default panel-subitems" id="actualChartPanel" style="width: 1100px; top: 150px; left: 200px; box-shadow: rgba(85, 85, 85, 0.93) 3px 3px 8px 4px; border: 3px solid rgb(109, 109, 109)">
            <div class="panel-body">
                <i class="glyphicon glyphicon-remove" style="float: right" onmouseout="$('#actualChartPanel').css('visibility', 'hidden');"></i>
                <button type="button" class="Btns" style="margin-bottom: 20px">Save</button>
                <div id="actualChartContainer"></div>
            </div>
        </div>--%>
        <div class="modal fade" id="actualChartPanel" role="dialog">
            <div class="modal-dialog  modal-dialog-centered" style="min-width: 1100px; box-shadow: rgba(85, 85, 85, 0.93) 3px 3px 8px 4px; border: 3px solid rgb(109, 109, 109)">
                <div class="modal-content">
                    <%-- <div class="modal-header" style="background-color: #0c0922; padding: 8px">

                        <h4 class="modal-title" style="color: white;">Confirmation!</h4>
                    </div>--%>
                    <div class="modal-body">
                        <i class="glyphicon glyphicon-remove" style="float: right" onmouseout="$('[id*=actualChartPanel]').modal('hide');"></i>
                        <button type="button" class="Btns" style="margin-bottom: 20px">Save</button>
                        <div id="actualChartContainer"></div>
                    </div>
                    <%--<div class="modal-footer" style="padding: 5px; border-top: 1px solid #0c0922">
                        <asp:Button runat="server" Text="Yes" ID="btnDeleteRecordsYes" Style="width: 80px;" OnClick="btnDeleteRecordsYes_Click" />
                        <input type="button" style="width: 80px;" value="No" onclick="closeDeletePopup();" />
                    </div>--%>
                </div>
            </div>
        </div>
        <div class="modal fade" id="zoomChartPanel" role="dialog">
            <div class="modal-dialog modal-dialog-centered" style="min-width: 1100px; box-shadow: rgba(85, 85, 85, 0.93) 3px 3px 8px 4px; border: 3px solid rgb(109, 109, 109); width: 80vw">
                <div class="modal-content">
                    <div class="modal-body">
                        <i class="glyphicon glyphicon-remove" onclick="$('[id*=zoomChartPanel]').modal('hide')" style="float: right"></i>
                        <br />
                        <div>
                            <div style="text-align: center; margin-bottom: 10px">
                                <span style="font-weight: bold; font-size: 20px; color: #17d017">Signature Comparison Chart</span>
                            </div>
                            <table style="margin-left: 10px; font-size: 18px;">
                                <tr>
                                    <td>&nbsp;&nbsp;&nbsp;<span style="font-weight: 600">Company ID: </span><span id="zoomChartCompanyID"></span></td>
                                    <td>&nbsp;&nbsp;&nbsp;<span style="font-weight: 600">Plant ID: </span><span id="zoomChartPlantID"></span></td>
                                    <td>&nbsp;&nbsp;&nbsp;<span style="font-weight: 600">Machine ID: </span><span id="zoomChartMachineID"></span></td>
                                    <td>&nbsp;&nbsp;&nbsp;<span style="font-weight: 600">Parameter ID: </span><span id="zoomChartParameterID"></span></td>
                                    <td>&nbsp;&nbsp;&nbsp;<span style="font-weight: 600">Cycle Start: </span><span id="zoomChartCycleStart"></span></td>
                                    <td style="display: none">&nbsp;&nbsp;<span style="font-weight: 600">Cycle End: </span><span id="zoomChartCycleEnd"></span></td>
                                    <%-- </tr>
                                <tr>--%>
                                    <td>&nbsp;&nbsp;&nbsp;<span style="font-weight: 600">Select SignatureID: </span>
                                    </td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="ddlSignatureID" ClientIDMode="Static" Style="margin-left: 2px" CssClass="form-control dropdown-list"></asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:Button runat="server" ID="btnSaveDataForReference" Text="Save" ClientIDMode="Static" OnClientClick="return saveDataForReference();" CssClass="Btns" Style="margin-left: 15px" />
                                    </td>
                                </tr>
                            </table>

                        </div>
                        <div id="zoomChartContainer" style="height: 60vh"></div>
                    </div>
                </div>
            </div>
        </div>
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

        var graphDetails, clickedXValue, clickedYValue;
        var data = [];
        var limitPlotlinesForZoomChart = [];
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
            // let selectFirstMachine = $("#multiselectddlMachineID").closest('td').find("ul li input")[1];
            //$(selectFirstMachine).prop('checked', true);
            //let selectFirstParameter = $("[id*=cbParameterList] input")[0];
            //$(selectFirstParameter).prop('checked', true);
            // $.blockUI({ message: '<img runat="server" src="Images/Loading.gif" />' });
            bindGraphViewCharts();


        });
        function hidePanel(panelid) {
            document.getElementById(panelid).style.visibility = "hidden";
        }

        //$("#multiselectddlMachineID").change(function () {
        //    debugger;
        //    alert();
        //    if ($(this).prop('checked')) {
        //        alert();
        //    }

        //});
        function bindActualSeries(actualSeriesData) {
            //document.getElementById('actualChartPanel').style.visibility = "visible";
            window.$('[id*=actualChartPanel]').modal();
            Highcharts.chart('actualChartContainer', {
                chart: {
                    zoomType: 'x'
                },
                credits: {
                    enabled: false
                },
                title: {
                    text: '',
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
                        return `<span class="span-legend-active">${this.name}</span>`;
                    }
                },

                plotOptions: {
                    series: {
                        label: {
                            connectorAllowed: false
                        },
                        pointStart: 2010,

                    }
                },

                series: [
                    {
                        name: 'Actual',
                        data: actualSeriesData,
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
        $("#ddlSignatureID").change(function () {
            chartForSelectedReference();
        });
        function chartForSelectedReference() {
            var actualData = [];
            var referenceData = [];
            // alert($("#zoomChartCycleStart").text());
            $.ajax({
                async: false,
                type: "POST",
                url: '<%= ResolveUrl("ProcessParameterSignatureComparison.aspx/getzoomChartData") %>',
                contentType: "application/json; charset=utf-8",
                crossDomain: true,
                data: '{xvalue: "' + clickedXValue + '",yvalue: "' + clickedYValue + '",machineid:"' + $('#zoomChartMachineID').text() + '",parameterid:"' + $('#zoomChartParameterID').text() + '",signatureid:"' + $("#ddlSignatureID").val() + '",cycleStart:"' + $("#zoomChartCycleStart").text() + '",cycleEnd:"' + $('#zoomChartCycleEnd').text() + '", companyid:"' + $('#zoomChartCompanyID').text() + '",plantid:"' + $('#zoomChartPlantID').text() + '" }',
                dataType: "json",
                success: function (response) {
                    dataitem = response.d;
                    console.log(dataitem);
                    if (dataitem.length > 0) {
                        referenceData = dataitem[0].referenceData;
                        actualData = dataitem[0].actualData;
                    }

                    // debugger;
                    //for (var i = 0; i < referenceData.length; i++) {
                    //    var serie = new Array(referenceData[i][0], data[i][1]);
                    //    actualData.push(serie);
                    //}
                },
                error: function (Result) {
                    alert("Error" + Result);
                }
            });
            console.log("AD" + actualData);
            $('[id*=zoomChartPanel]').modal('show');
            let uwlegendenable = false, lwlegendenable = false;
            let limitValues = getSelectedLimits();
            if (limitValues.includes("UpperWarningLimit") && limitValues.includes("LowerWarningLimit")) {
                uwlegendenable = true;
                lwlegendenable = true;
            } else if (limitValues.includes("UpperWarningLimit")) {
                uwlegendenable = true;
            } else if (limitValues.includes("LowerWarningLimit")) {
                lwlegendenable = true;
            }

            Highcharts.stockChart('zoomChartContainer', {
                chart: {

                },
                credits: {
                    enabled: false
                },
                navigator: {
                    enabled: true
                },
                rangeSelector: {
                    enabled: false,
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
                    // plotLines: dataitem.plotLines
                },

                yAxis: {
                    opposite: false,

                    title: {
                        text: 'Value'
                    },
                    className: 'highchart-xyaxis-label',
                    plotLines: limitPlotlinesForZoomChart,
                    gridLineWidth: 0
                },
                //   series:dataitem[0]
                legend: {
                    enabled: true,
                    //align: 'right',
                    backgroundColor: '#d6d6d6',
                    //borderColor: 'black',
                    //borderWidth: 2,
                    //layout: 'vertical',
                    //verticalAlign: 'top',
                    //y: -68,
                    //x: -30

                    //shadow: true
                },
                series: [
                    {
                        name: 'Actual',
                        data: actualData,
                        id: 'Actual',
                        color: 'green'
                    },
                    {
                        name: 'Reference',
                        data: referenceData,
                        id: 'Reference',
                        color: '#10afe8'
                    },
                    {
                        // Series that mimics the plot line
                        color: 'red',
                        name: 'Upper Error Limit',
                        marker: {
                            enabled: false
                        }
                    },
                    {
                        // Series that mimics the plot line
                        color: 'red',
                        name: 'Lower Error Limit',
                        marker: {
                            enabled: false
                        }
                    },
                    {
                        color: 'yellow',
                        name: 'Upper Warning Limit',
                        dashStyle: 'shortdash',
                        marker: {
                            enabled: false
                        },
                        showInLegend: uwlegendenable
                    },
                    {
                        // Series that mimics the plot line
                        color: 'yellow',
                        name: 'Lower Warning Limit',
                        dashStyle: 'shortdash',
                        marker: {
                            enabled: false
                        },
                        showInLegend: lwlegendenable
                    }

                ]
            });
        }
        function zoomOutChart(xvalue, yvalue, indexValue1, indexValue2) {
            var dataitem;

            var cycleInformation = graphDetails[indexValue1].signatureComparisionChartMachineDetails[indexValue2].CycleData;
            var cycleStart = "", cycleEnd = "";
            // alert(graphDetails[indexValue1].signatureComparisionChartMachineDetails[indexValue2].MachineID)
            data = graphDetails[indexValue1].signatureComparisionChartMachineDetails[indexValue2].data;
            debugger;
            for (var i = 0; i < data.length; i++) {
                if (data[i][0] == xvalue && data[i][1] == yvalue) {
                    debugger;
                    cycleStart = cycleInformation[i].CycleStart;
                    cycleEnd = cycleInformation[i].CycleEnd;
                    //data = cycleInformation[i].CycleData;
                    break;
                }
            }
            // debugger;
            var selectedMachine = graphDetails[indexValue1].signatureComparisionChartMachineDetails[indexValue2].MachineID;
            var selectedCompany = graphDetails[indexValue1].signatureComparisionChartMachineDetails[indexValue2].CompanyID;
            var selectedPlant = graphDetails[indexValue1].signatureComparisionChartMachineDetails[indexValue2].PlantID;
            var selectedParameter = graphDetails[indexValue1].ParameterID;
            var selectedSignatureID = "S1";
            $('#zoomChartCompanyID').text(selectedCompany);
            $('#zoomChartPlantID').text(selectedPlant);
            $('#zoomChartMachineID').text(selectedMachine);
            $('#zoomChartParameterID').text(selectedParameter);
            $('#zoomChartCycleStart').text(cycleStart);
            $('#zoomChartCycleEnd').text(cycleEnd);
            $.ajax({
                async: false,
                type: "POST",
                url: '<%= ResolveUrl("ProcessParameterSignatureComparison.aspx/getSignatureIDs") %>',
                contentType: "application/json; charset=utf-8",
                crossDomain: true,
                data: '{MachineID: "' + selectedMachine + '", ParameterID:"' + selectedParameter + '", CompanyID:"' + selectedCompany + '", PlantID:"' + selectedPlant + '"}',
                dataType: "json",
                success: function (response) {
                    dataitem = response.d;
                    $("#ddlSignatureID").empty();
                    for (let i = 0; i < dataitem.length; i++) {
                        if (dataitem[i] == null || dataitem[i] == "") {

                        } else {
                            $("#ddlSignatureID").append($("<option></option>").val(dataitem[i]).html(dataitem[i]));
                        }
                    }
                },
                error: function (Result) {
                    alert("Error" + Result);
                }
            });
            limitPlotlinesForZoomChart = getLimitPlotlines(selectedMachine, selectedParameter, getSelectedLimits(), selectedCompany, selectedPlant);
            chartForSelectedReference();
        }
        function shownextprev(param) {
            let selectedMachinesCount = 0;
            let seletedMachines = "";
            for (let i = 1; i < $("#multiselectddlMachineID").closest('td').find("ul li input").length; i++) {
                let machine = $("#multiselectddlMachineID").closest('td').find("ul li input")[i];
                if ($(machine).prop('checked')) {
                    if (selectedMachinesCount < 3) {
                        if (seletedMachines == "") {
                            seletedMachines = $(machine).val();
                        } else {
                            seletedMachines = seletedMachines + ',' + $(machine).val();
                        }
                        selectedMachinesCount++;
                    }

                }
            }

            if (selectedMachinesCount >= 3) {
                let inedx = 0;
                if (param == 'next') {
                    inedx = 0;
                    for (let l = 0; l < $("#graphsix").find('.graph-div').length; l = l + 3) {
                        let div = $("#graphsix").find('.graph-div')[l];
                        $(div).css({ 'display': 'none', 'transition': 'all 500ms linear' });
                        div = $("#graphsix").find('.graph-div')[l + 2];
                        setTimeout(function () {
                            $(div).css({ 'display': 'inline-block', 'transition': 'all 500ms linear' });
                        }, 20);

                    }
                    //for (let l = 2; l < $("#graphsix").find('.graph-div').length; l = l + 3) {
                    //    let div = $("#graphsix").find('.graph-div')[l];
                    //    $(div).css({ 'display': 'inline-block' });
                    //}
                    $("#btnnext").css({ 'display': 'none' });
                    $("#btnprev").css({ 'display': 'block' });
                } else {
                    inedx = 2;
                    for (let l = 2; l < $("#graphsix").find('.graph-div').length; l = l + 3) {
                        let div = $("#graphsix").find('.graph-div')[l];
                        $(div).css({ 'display': 'none', 'transition': 'all 500ms linear' });
                        div = $("#graphsix").find('.graph-div')[l - 2];
                        $(div).css({ 'display': 'inline-block', 'transition': 'all 500ms linear' });
                    }
                    //for (let l = 0; l < $("#graphsix").find('.graph-div').length; l = l + 3) {
                    //    let div = $("#graphsix").find('.graph-div')[l];
                    //    $(div).css({ 'display': 'inline-block' });
                    //}
                    $("#btnnext").css({ 'display': 'block' });
                    $("#btnprev").css({ 'display': 'none' });
                }
            } else {
                $("#btnnext").css({ 'display': 'none' });
                $("#btnprev").css({ 'display': 'none' });
            }
        }
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
        function getLimitPlotlines(machineId, parameterName, limitSelcted, company, plant) {
            let limitPlotlines = []
            $.ajax({
                async: false,
                type: "POST",
                url: '<%= ResolveUrl("ProcessParameterSignatureComparison.aspx/getMasterData") %>',
                contentType: "application/json; charset=utf-8",
                crossDomain: true,
                data: '{MachineID: "' + machineId + '", ParameterID:"' + parameterName + '", LimitSelected: "' + limitSelcted + '",CompanyID:"' + company + '", PlantID:"' + plant + '" }',
                dataType: "json",
                success: function (response) {
                    var dataitem1 = response.d;
                    console.log(dataitem1);
                    limitPlotlines = dataitem1;
                    //console.log(limitPlotlines);
                    // alert(dataitem.length);
                    //if (dataitem.length > 0 && dataitem != null) {
                    //console.log(dataitem1.UpperErrorLimit);
                    //upperError = parseFloat(dataitem1.UpperErrorLimit);
                    //upperWarning = parseFloat(dataitem1.UpperWarningLimit);
                    //lowerWarning = parseFloat(dataitem1.LowerWarningLimit);
                    //lowerError = parseFloat(dataitem1.LowerErrorLimit);
                    //}
                },
                error: function (Result) {
                    alert("Error" + Result);
                }
            });
            return limitPlotlines;
        }
        function getSelectedLimits() {
            let limitSelected = $("[id*=cblLimitSelection] input:checked");
            let limitValues = "";
            limitSelected.each(function () {
                if (limitValues == "") {
                    limitValues = $(this).val();
                } else {
                    limitValues = limitValues + ',' + $(this).val();
                }
            });
            return limitValues;
        }
        $("[id*=cbParameterList] input").change(function () {
            let selectedMachinesCount = 0;
            for (let i = 1; i < $("#multiselectddlMachineID").closest('td').find("ul li input").length; i++) {
                let machine = $("#multiselectddlMachineID").closest('td').find("ul li input")[i];
                if ($(machine).prop('checked')) {
                    selectedMachinesCount++;
                    if (selectedMachinesCount > 1) {
                        break;
                    }
                }
            }
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
            if (selectedMachinesCount > 1) {
                if ($("[id*=cbParameterList] input:checked").length > 4) {
                    var d = Date();
                    toastr.warning("For more than 1 machine only 4 parameters can select.", "");
                    $(this).prop('checked', false);
                }
            } else {
                if ($("[id*=cbParameterList] input:checked").length > 8) {
                    var d = Date();
                    toastr.warning("For 1 machine only 8 parameters can select.", "");
                    $(this).prop('checked', false);
                }
            }

        });
        //$("#multiselectddlMachineID").closest('td').find("ul li input").change(function () {
        //    alert();
        //    debugger;
        //});
        //$(".multiselect-container input").change(function () {

        //    alert();

        //}).change();
        //$(".multiselect-container li").on('click', function (e) {

        //    alert();

        //});
        //$("#multiselectddlMachineID").change(function () {
        //    return;
        //    debugger;
        //});
        function bindGraphViewCharts() {
            //  $.blockUI({ message: '<div style=""><img src="Images/Loading.gif"  style="display: inline-block;"/>&nbsp;&nbsp;<h3 style="display: inline-block;color:#524b4b;margin:20px 0px;">Please wait.....</h3></div>' });
            // $('.ajax-loader').show(); 
            $.blockUI({ message: '<img runat="server" src="Images/Loading.gif" />' });

            $('#panelFilter').css("visibility", "hidden");
            var checked_checkboxes = $("[id*=cbParameterList] input:checked");

            let selectedCompany = $("#ddlCompany").val();
            let selectedPlant = $("#ddlPlant").val();
            let seletedMachines = "";
            let selectedMachinesCount = 0;
            for (let i = 1; i < $("#multiselectddlMachineID").closest('td').find("ul li input").length; i++) {
                let machine = $("#multiselectddlMachineID").closest('td').find("ul li input")[i];
                if ($(machine).prop('checked')) {
                    if (selectedMachinesCount < 3) {
                        if (seletedMachines == "") {
                            seletedMachines = $(machine).val();
                        } else {
                            seletedMachines = seletedMachines + ',' + $(machine).val();
                        }
                        selectedMachinesCount++;
                    }

                }
            }
            let parameterLimit = 1;
            if (selectedMachinesCount == 1) {
                parameterLimit = 8;
            } else {
                parameterLimit = 4;
            }
            let chstr1 = "";
            let selectedParameterCount = 0;
            checked_checkboxes.each(function () {
                if (selectedParameterCount < parameterLimit) {
                    if (chstr1 == "") {
                        //  debugger;
                        chstr1 = $(this).val();
                    } else {
                        chstr1 = chstr1 + ',' + $(this).val();
                    }
                }
                selectedParameterCount++;
            });
            let limitValues = getSelectedLimits();
            // var dataitem;


            var dataForZoomBar = [];
            var variablesName = [];
            for (let d = 0; d < (selectedMachinesCount * selectedParameterCount); d++) {
                variablesName[d] = "zoomChart" + d;
            }
            console.log("VN" + variablesName);

            $.ajax({
                // async: false,
                type: "POST",
                url: '<%= ResolveUrl("ProcessParameterSignatureComparison.aspx/getDataForGraph") %>',
                contentType: "application/json; charset=utf-8",
                crossDomain: true,
                data: '{MachineID: "' + seletedMachines + '", Parameters:"' + chstr1 + '", FromDate:"' + $("#txtFromDateTime").val() + '",ToDate:"' + $("#ddlSelectHour").val() + '", Company:"' + selectedCompany + '", Plant:"' + selectedPlant + '"}',
                dataType: "json",
                //beforeSend: function (jqXhr) {
                //    jqXhr.setRequestHeader('Accept-Encoding', 'deflate');
                //},
                success: function (response) {
                    //debugger;
                    console.log("get response  : " + new Date().format("dd-MM-yyyy HH:mm:ss"));
                    //  dataitem = response.d;
                    //debugger;
                    //  dataitem = LZString.decompress(response.d);
                    //debugger;
                    //var base64Data = response.d;

                    //var compressData = atob(base64Data);
                    //var compressdata = compressData.split('').map(function (e) {
                    //    return e.charCodeAt(0);
                    //});

                    //var inflate = new Zlib.Inflate(compressdata);
                    //dataitem = inflate.decompress();
                    //var result = bin2String(dataitem);
                    currentDate = new Date();
                    console.log("Before parse  : " + currentDate.format("dd-MM-yyyy HH:mm:ss"));
                    // debugger;
                    //var binData = response.d;
                    //var dataitem = JSON.parse(pako.inflateRaw(binData, { to: 'string' }));

                    var dataitem = JSON.parse(response.d);
                    console.log("After parse  : " + new Date().format("dd-MM-yyyy HH:mm:ss"));
                    currentDate = new Date();
                    console.log("start : " + currentDate.format("dd-MM-yyyy HH:mm:ss"));
                    graphDetails = dataitem;
                    console.log(dataitem);
                    $("#graphsix").empty();
                    let appstr = "";
                    let i = 0;
                    console.log("before chart : " + new Date().format("dd-MM-yyyy HH:mm:ss"));

                    let noOfRowsToDisplay = 2;
                    for (let k = 0; k < dataitem.length; k++) {

                        let parameterName = dataitem[k].ParameterID;
                        //let heightForGraph = ($(window).height() - 120) / 2;
                        let heightForGraph;
                        if (noOfRowsToDisplay == 2) {
                            //for 2 rows
                            heightForGraph = ($(window).height() - 150) / 2;
                        } else {
                            //for 3 rows
                            heightForGraph = ($(window).height() - 440) / 2;
                        }
                        if (selectedMachinesCount == 1 && selectedParameterCount == 1) {
                            heightForGraph = $(window).height() - 150;
                        }

                        for (let j = 0; j < dataitem[k].signatureComparisionChartMachineDetails.length; j++) {

                            //var data = [];
                            //var type, plotLines;
                            //var graphTitle = "";
                            //data = dataitem[i].data;
                            ////  type = dataitem.type;
                            //plotLines = dataitem[i].plotLines;
                            //graphTitle = dataitem[i].ParameterID;
                            //let machineID=dataitem[k].signatureComparisionChartMachineDetails[j].MachineID;

                            //for getting y axis lines
                            let upperError, upperWarning, lowerWarning, lowerError;
                            var limitPlotlines = [];
                            limitPlotlines = getLimitPlotlines(dataitem[k].signatureComparisionChartMachineDetails[j].MachineID, parameterName, limitValues, dataitem[k].signatureComparisionChartMachineDetails[j].CompanyID, dataitem[k].signatureComparisionChartMachineDetails[j].PlantID);


                            appstr = '<div class=" graph-div"><div id="msgraph' + i + '"></div></div>';
                            $("#graphsix").append(appstr);


                            //normal
                            //if (selectedMachinesCount == 1) {
                            //    $("#msgraph" + i).parent().css({ 'width': '100%', 'display': 'block', 'height': heightForGraph });

                            //}
                            //else
                            //if (selectedMachinesCount >= 2) {

                            //    $("#msgraph" + i).parent().css({ 'width': '49%', 'display': 'inline-block', 'height': heightForGraph });
                            //}
                            ////else if (selectedMachinesCount == 3) {

                            ////    $("#msgraph" + i).parent().css({ 'width': '32%', 'display': 'inline-block', 'height': heightForGraph });
                            ////}


                            //  for 1 machine  
                            if (selectedMachinesCount == 1) {
                                if (selectedParameterCount > noOfRowsToDisplay) {
                                    $("#msgraph" + i).parent().css({ 'width': '49%', 'display': 'inline-block', 'height': heightForGraph, 'min-height': '370px' });
                                } else {
                                    $("#msgraph" + i).parent().css({ 'width': '100%', 'display': 'block', 'height': heightForGraph, 'min-height': '370px' });
                                }


                            }
                            else
                                if (selectedMachinesCount >= 2) {

                                    $("#msgraph" + i).parent().css({ 'width': '49%', 'display': 'inline-block', 'height': heightForGraph, 'min-height': '370px' });
                                }


                            $("#msgraph" + i).css({ 'height': heightForGraph, 'min-height': '370px' });


                            var indexValue1 = k;
                            var indexValue2 = j;
                            let uwlegendenable = false, lwlegendenable = false;
                            if (limitValues.includes("UpperWarningLimit") && limitValues.includes("LowerWarningLimit")) {
                                uwlegendenable = true;
                                lwlegendenable = true;
                            } else if (limitValues.includes("UpperWarningLimit")) {
                                uwlegendenable = true;
                            } else if (limitValues.includes("LowerWarningLimit")) {
                                lwlegendenable = true;
                            }


                            variablesName[i] = new Highcharts.stockChart('msgraph' + i, {

                                chart: {

                                },
                                credits: {
                                    enabled: false
                                },
                                navigator: {
                                    height: 20
                                    //enabled: true,
                                    //height: 50,
                                    //margin: 5,
                                    //adaptToUpdatedData: true,
                                    //xAxis: {
                                    //    labels: {
                                    //        rotation: 0,
                                    //        style: {
                                    //            fontSize: "9px",
                                    //            textOverflow: "string",
                                    //            lineHeight: "9px",
                                    //            whiteSpace: "nowrap",
                                    //            paddingBottom: "5px"
                                    //        }
                                    //    }
                                    //},
                                    //minRange: 1
                                },

                                rangeSelector: {
                                    enabled: false,

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
                                    useHTML: true,
                                    text: parameterName + "-" + dataitem[k].signatureComparisionChartMachineDetails[j].MachineID,
                                    style: {
                                        color: '#02bb3a',
                                        fontSize: '19px'
                                    },
                                    align: 'left',
                                    x: 10,
                                    y: 10
                                },

                                tooltip: {
                                    style: {
                                        width: '200px'
                                    },
                                    valueDecimals: 4,
                                    shared: true
                                },
                                xAxis: {
                                    useHTML: true,
                                    accessibility: {
                                        // rangeDescription: 'Range: 2010 to 2017'
                                    },
                                    className: 'highchart-xyaxis-label',
                                    //labels: {
                                    //    style: {
                                    //        //fontSize: '18px',
                                    //        //color: 'green',
                                    //        fontWeight: 'unset'
                                    //    }
                                    //}
                                    // plotLines: dataitem[k].signatureComparisionChartMachineDetails[j].plotLines
                                },
                                legend: {
                                    enabled: true,
                                    align: 'right',
                                    backgroundColor: '#d6d6d6',
                                    //borderColor: 'black',
                                    //borderWidth: 2,
                                    //layout: 'vertical',
                                    verticalAlign: 'top',
                                    //y: -80,
                                    //x: -30
                                       y: -45,
                                    x: -30
                                      //  y: -40,
                                    //x: -60

                                    //shadow: true
                                },
                                plotOptions: {
                                    line: {
                                        gapUnit: 'value',
                                        gapSize: 3600000,
                                        softThreshold: false,
                                        dataGrouping: {
                                            enabled: false,
                                            approximation: "average",
                                            groupPixelWidth: 4
                                        },
                                        point: {
                                            events: {

                                            }
                                        }
                                    },
                                    series: {
                                        cursor: 'pointer',
                                        point: {
                                            events: {
                                                click: function () {
                                                    let xvalue = this.category;
                                                    let yvalue = this.y;
                                                    let p1 = this.series.options.indexValue1;
                                                    let p2 = this.series.options.indexValue2;
                                                    clickedXValue = xvalue;
                                                    clickedYValue = yvalue;
                                                    //alert(this.CycleStart);
                                                    zoomOutChart(xvalue, yvalue, p1, p2);
                                                }
                                            }
                                        }
                                    },
                                    //getExtremesFromAll: true,
                                    //   connectNulls: true,
                                },
                                yAxis: {
                                    title: {
                                        text: 'Value'
                                    },
                                    opposite: false,
                                    className: 'highchart-xyaxis-label',
                                    plotLines: limitPlotlines,
                                    gridLineWidth: 0,

                                },

                                series: [

                                    {
                                        name: 'Actual',
                                        data: dataitem[k].signatureComparisionChartMachineDetails[j].data,
                                        id: 'dataseries',
                                        color: 'green',
                                        indexValue1: indexValue1,
                                        indexValue2: indexValue2
                                        // the event marker flags
                                    },
                                    {
                                        // Series that mimics the plot line
                                        color: 'red',
                                        name: 'Upper Error Limit',
                                        marker: {
                                            enabled: false
                                        }
                                    },
                                    {
                                        // Series that mimics the plot line
                                        color: 'red',
                                        name: 'Lower Error Limit',
                                        marker: {
                                            enabled: false
                                        }
                                    },
                                    {
                                        color: 'yellow',
                                        name: 'Upper Warning Limit',
                                        dashStyle: 'shortdash',
                                        marker: {
                                            enabled: false
                                        },
                                        showInLegend: uwlegendenable
                                    },
                                    {
                                        // Series that mimics the plot line
                                        color: 'yellow',
                                        name: 'Lower Warning Limit',
                                        dashStyle: 'shortdash',
                                        marker: {
                                            enabled: false
                                        },
                                        showInLegend: lwlegendenable
                                    },

                                    {
                                        type: 'flags',
                                        data: dataitem[k].signatureComparisionChartMachineDetails[j].type,
                                        onSeries: 'dataseries',
                                        shape: 'circlepin',
                                        width: 8,
                                        style: {
                                            useHTML: true,
                                            //color: 'red',
                                            fontSize: '8px'
                                        },
                                        showInLegend: false
                                        //shape: 'squarepin',
                                        //width: 100
                                    }
                                ]
                            });

                            if (k == 0 && j == 0) {
                                //dataForZoomBar = dataitem[k].signatureComparisionChartMachineDetails[j].data;
                                debugger;
                                for (let dk = 0; dk < dataitem[k].signatureComparisionChartMachineDetails[j].data.length; dk++) {
                                    var serie = new Array(dataitem[k].signatureComparisionChartMachineDetails[j].data[dk][0], 10);
                                    dataForZoomBar.push(serie);
                                }
                            }

                            i++;
                        }
                    }
                    //debugger;

                    console.log("After chart  : " + new Date().format("dd-MM-yyyy HH:mm:ss"));


                    if (dataForZoomBar.length > 0) {
                        appstr = '<div class=" graph-div"><div id="commonZoomBarChart"></div></div>';
                        $("#commonZoomBar").append(appstr);
                        $("#commonZoomBarChart").parent().css({ 'width': '100%', 'display': 'block' });
                        // $("#msgraph" + i).css({ 'height': heightForGraph });

                        Highcharts.stockChart('commonZoomBarChart', {

                            chart: {

                            },
                            credits: {
                                enabled: false
                            },
                            navigator: {
                                height: 50

                            },

                            rangeSelector: {
                                 enabled: false,
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
                                useHTML: true,
                                text: "",
                                style: {
                                    color: '#02bb3a',
                                    fontSize: '19px'
                                },
                                align: 'left',
                                x: 50,
                                y: 20
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
                                },
                                className: 'highchart-xyaxis-label',
                                events: {
                                    afterSetExtremes: function (event) {
                                        var xMin = event.min;
                                        var xMax = event.max;
                                        var ex = [];

                                        for (let i = 0; i < variablesName.length; i++) {
                                            ex[i] = variablesName[i].xAxis[0].getExtremes();
                                            if (ex[i].min != xMin || ex[i].max != xMax) variablesName[i].xAxis[0].setExtremes(xMin, xMax, true, false);
                                        }

                                    }
                                }
                            },
                            legend: {
                                enabled: false,

                            },
                            yAxis: {
                                title: {
                                    text: 'Value'
                                },
                                opposite: false,
                                className: 'highchart-xyaxis-label',
                                gridLineWidth: 0,

                            },

                            series: [
                                {
                                    name: 'Actual',
                                    data: dataForZoomBar,
                                    id: 'dataseries',
                                    color: 'blue',
                                }
                            ]
                        });
                        //window.onload = function () {                        $("#commonZoomBar").animate({ scrollTop: 330 }, 1000);                        $("#commonZoomBar").css({ 'overflow': 'hidden' });                        //}
                    }
                    console.log("After Zoom chart  : " + new Date().format("dd-MM-yyyy HH:mm:ss"));
                    currentDate = new Date();
                    console.log("End : " + new Date().format("dd-MM-yyyy HH:mm:ss"));
                    shownextprev('prev');
                    $.unblockUI({});
                    hidePanel('panelFilter');
                },
                error: function (Result) {
                    alert("Error" + Result);
                    $.unblockUI({});
                }
            });
            // $.unblockUI({});
            //alert();
            //if (dataitem[0].signatureComparisionChartMachineDetails[0].data.length<=0) {
            //    $("#graphsix").empty();
            //    //  $('#warningModal').modal('show');
            //    $(".div-show-nodatafound-message").css({ 'display': 'block'});
            //    return false;
            //} else {
            //      $(".div-show-nodatafound-message").css({ 'display': 'none'});
            //}
            //shownextprev('prev');

            //$.unblockUI({});
            // $('.ajax-loader').hide(); 
            return false;
        }

        function showPanelFilter(element, panelid, rightvalue, topvalue, ulid) {
            $("#divgraph6Filter").css('display', 'block');
            document.getElementById(panelid).style.visibility = "visible";
            $("#" + panelid).css({ 'right': rightvalue, 'top': topvalue });
        }
        var multiselctListExpand = false;
        function stayMultiselectedList() {
            multiselctListExpand = true;
        }
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
            $(document).ready(function () {
                //bindGraphViewCharts();
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
                if (multiselctListExpand) {
                    $(".btn-group").addClass('open');
                } else {
                    $(".btn-group").removeClass('open');
                }
                multiselctListExpand = false;
            });

            function showPanelFilter(element, panelid, rightvalue, topvalue, ulid) {
                $("#divgraph6Filter").css('display', 'block');
                document.getElementById(panelid).style.visibility = "visible";
                $("#" + panelid).css({ 'right': rightvalue, 'top': topvalue });
            }

            function bindActualSeries(actualSeriesData) {
                document.getElementById('actualChartPanel').style.visibility = "visible";
                Highcharts.chart('actualChartContainer', {
                    chart: {
                        zoomType: 'x'
                    },
                    credits: {
                        enabled: false
                    },
                    title: {
                        text: '',
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
                            return `<span class="span-legend-active">${this.name}</span>`;
                        }
                    },

                    plotOptions: {
                        series: {
                            label: {
                                connectorAllowed: false
                            },
                            pointStart: 2010,

                        }
                    },

                    series: [
                        {
                            name: 'Actual',
                            data: actualSeriesData,
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

            function shownextprev(param) {
                let selectedMachinesCount = 0;
                let seletedMachines = "";
                for (let i = 1; i < $("#multiselectddlMachineID").closest('td').find("ul li input").length; i++) {
                    let machine = $("#multiselectddlMachineID").closest('td').find("ul li input")[i];
                    if ($(machine).prop('checked')) {
                        if (selectedMachinesCount < 3) {
                            if (seletedMachines == "") {
                                seletedMachines = $(machine).val();
                            } else {
                                seletedMachines = seletedMachines + ',' + $(machine).val();
                            }
                            selectedMachinesCount++;
                        }

                    }
                }

                if (selectedMachinesCount >= 3) {
                    let inedx = 0;
                    if (param == 'next') {
                        inedx = 0;
                        for (let l = 0; l < $("#graphsix").find('.graph-div').length; l = l + 3) {
                            let div = $("#graphsix").find('.graph-div')[l];
                            $(div).css({ 'display': 'none', 'transition': 'all 500ms linear' });
                            div = $("#graphsix").find('.graph-div')[l + 2];
                            setTimeout(function () {
                                $(div).css({ 'display': 'inline-block', 'transition': 'all 500ms linear' });
                            }, 20);

                        }
                        //for (let l = 2; l < $("#graphsix").find('.graph-div').length; l = l + 3) {
                        //    let div = $("#graphsix").find('.graph-div')[l];
                        //    $(div).css({ 'display': 'inline-block' });
                        //}
                        $("#btnnext").css({ 'display': 'none' });
                        $("#btnprev").css({ 'display': 'block' });
                    } else {
                        inedx = 2;
                        for (let l = 2; l < $("#graphsix").find('.graph-div').length; l = l + 3) {
                            let div = $("#graphsix").find('.graph-div')[l];
                            $(div).css({ 'display': 'none', 'transition': 'all 500ms linear' });
                            div = $("#graphsix").find('.graph-div')[l - 2];
                            $(div).css({ 'display': 'inline-block', 'transition': 'all 500ms linear' });
                        }
                        //for (let l = 0; l < $("#graphsix").find('.graph-div').length; l = l + 3) {
                        //    let div = $("#graphsix").find('.graph-div')[l];
                        //    $(div).css({ 'display': 'inline-block' });
                        //}
                        $("#btnnext").css({ 'display': 'block' });
                        $("#btnprev").css({ 'display': 'none' });
                    }
                } else {
                    $("#btnnext").css({ 'display': 'none' });
                    $("#btnprev").css({ 'display': 'none' });
                }
            }

            function zoomOutChart(xvalue, yvalue, indexValue1, indexValue2) {
                var dataitem;

                var cycleInformation = graphDetails[indexValue1].signatureComparisionChartMachineDetails[indexValue2].CycleData;
                var cycleStart = "", cycleEnd = "";
                // alert(graphDetails[indexValue1].signatureComparisionChartMachineDetails[indexValue2].MachineID)
                data = graphDetails[indexValue1].signatureComparisionChartMachineDetails[indexValue2].data;
                debugger;
                for (var i = 0; i < data.length; i++) {
                    if (data[i][0] == xvalue && data[i][1] == yvalue) {
                        debugger;
                        cycleStart = cycleInformation[i].CycleStart;
                        cycleEnd = cycleInformation[i].CycleEnd;
                        //data = cycleInformation[i].CycleData;
                        break;
                    }
                }
                // debugger;
                var selectedMachine = graphDetails[indexValue1].signatureComparisionChartMachineDetails[indexValue2].MachineID;
                var selectedCompany = graphDetails[indexValue1].signatureComparisionChartMachineDetails[indexValue2].CompanyID;
                var selectedPlant = graphDetails[indexValue1].signatureComparisionChartMachineDetails[indexValue2].PlantID;
                var selectedParameter = graphDetails[indexValue1].ParameterID;
                var selectedSignatureID = "S1";
                $('#zoomChartCompanyID').text(selectedCompany);
                $('#zoomChartPlantID').text(selectedPlant);
                $('#zoomChartMachineID').text(selectedMachine);
                $('#zoomChartParameterID').text(selectedParameter);
                $('#zoomChartCycleStart').text(cycleStart);
                $('#zoomChartCycleEnd').text(cycleEnd);
                $.ajax({
                    async: false,
                    type: "POST",
                    url: '<%= ResolveUrl("ProcessParameterSignatureComparison.aspx/getSignatureIDs") %>',
                    contentType: "application/json; charset=utf-8",
                    crossDomain: true,
                    data: '{MachineID: "' + selectedMachine + '", ParameterID:"' + selectedParameter + '", CompanyID:"' + selectedCompany + '", PlantID:"' + selectedPlant + '"}',
                    dataType: "json",
                    success: function (response) {
                        dataitem = response.d;
                        $("#ddlSignatureID").empty();
                        for (let i = 0; i < dataitem.length; i++) {
                            if (dataitem[i] == null || dataitem[i] == "") {

                            } else {
                                $("#ddlSignatureID").append($("<option></option>").val(dataitem[i]).html(dataitem[i]));
                            }
                        }
                    },
                    error: function (Result) {
                        alert("Error" + Result);
                    }
                });
                limitPlotlinesForZoomChart = getLimitPlotlines(selectedMachine, selectedParameter, getSelectedLimits(), selectedCompany, selectedPlant);
                chartForSelectedReference();
            }
            $("[id*=cbParameterList] input").change(function () {
                let selectedMachinesCount = 0;
                for (let i = 1; i < $("#multiselectddlMachineID").closest('td').find("ul li input").length; i++) {
                    let machine = $("#multiselectddlMachineID").closest('td').find("ul li input")[i];
                    if ($(machine).prop('checked')) {
                        selectedMachinesCount++;
                        if (selectedMachinesCount > 1) {
                            break;
                        }
                    }
                }
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
                if (selectedMachinesCount > 1) {
                    if ($("[id*=cbParameterList] input:checked").length > 4) {
                        var d = Date();
                        toastr.warning("For more than 1 machine only 4 parameters can select.", "");
                        $(this).prop('checked', false);
                    }
                } else {
                    if ($("[id*=cbParameterList] input:checked").length > 8) {
                        var d = Date();
                        toastr.warning("For 1 machine only 8 parameters can select.", "");
                        $(this).prop('checked', false);
                    }
                }

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

        function string2Bin(str) {
            var result = [];
            for (var i = 0; i < str.length; i++) {
                result.push(str.charCodeAt(i).toString(2));
            }
            return result;
        }
        function bin2String(array) {
            return String.fromCharCode.apply(String, array);
        }

        function saveDataForReference() {
            $.ajax({
                async: false,
                type: "POST",
                url: '<%= ResolveUrl("ProcessParameterSignatureComparison.aspx/saveDataForReference") %>',
                contentType: "application/json; charset=utf-8",
                crossDomain: true,
                data: '{machineid:"' + $('#zoomChartMachineID').text() + '",parameterid:"' + $('#zoomChartParameterID').text() + '",cycleStart:"' + $("#zoomChartCycleStart").text() + '",cycleEnd:"' + $('#zoomChartCycleEnd').text() + '", companyid:"' + $('#zoomChartCompanyID').text() + '",plantid:"' + $('#zoomChartPlantID').text() + '"}',
                dataType: "json",
                success: function (response) {
                    dataitem = response.d;
                    console.log(dataitem);
                    if (dataitem == "CycleEndEmpty") {
                        openWarningModal("Cycle End is null not able to save the data.")
                    } else if (dataitem == "Inserted") {
                        $.ajax({
                            async: false,
                            type: "POST",
                            url: '<%= ResolveUrl("ProcessParameterSignatureComparison.aspx/getSignatureIDs") %>',
                            contentType: "application/json; charset=utf-8",
                            crossDomain: true,
                            data: '{MachineID: "' + $('#zoomChartMachineID').text() + '", ParameterID:"' + $('#zoomChartParameterID').text() + '", CompanyID:"' + $('#zoomChartCompanyID').text() + '", PlantID:"' + $('#zoomChartPlantID').text() + '"}',
                            dataType: "json",
                            success: function (response) {
                                dataitem = response.d;
                                $("#ddlSignatureID").empty();
                                for (let i = 0; i < dataitem.length; i++) {
                                    if (dataitem[i] == null || dataitem[i] == "") {

                                    } else {
                                        $("#ddlSignatureID").append($("<option></option>").val(dataitem[i]).html(dataitem[i]));
                                    }
                                }
                                chartForSelectedReference();
                            },
                            error: function (Result) {
                                alert("Error" + Result);
                            }
                        });

                        showSuccessMsg("Data saved Successfully.", "");
                    } else {
                        openErrorModal(dataitem);
                    }
                },
                error: function (Result) {
                    alert("Error" + Result);
                }
            });
            return false;
        }
        function openWarningModal(msg) {
            $('#warningModal').modal('show');
            $('#lblWarningMsg').text(msg);
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
    </script>
</asp:Content>
