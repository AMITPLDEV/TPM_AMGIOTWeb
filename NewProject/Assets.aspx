<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Assets.aspx.cs" Inherits="NewProject.Assets" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <link href="http://cdn.syncfusion.com/18.3.0.47/js/web/flat-azure/ej.web.all.min.css" rel="stylesheet" />
    <script src="http://cdn.syncfusion.com/js/assets/external/jquery-1.10.2.min.js"></script>
    <script src="http://cdn.syncfusion.com/js/assets/external/jquery.easing.1.3.min.js"></script>
    <script src="http://cdn.syncfusion.com/js/assets/external/jquery.globalize.min.js"></script>
    <script src="http://cdn.syncfusion.com/js/assets/external/jsrender.min.js"></script>
    <script src="http://cdn.syncfusion.com/18.3.0.47/js/web/ej.web.all.min.js"></script>

    <link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">
<script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
    <style>
        .modal-content {
            border: 2px solid #f34d1b;
        }

        .modal-header {
            background-color: #f34d1b;
            padding: 8px;
            color: black;
            text-align: center;
        }

        .modal-icons {
            font-size: 5pc;
        }

        .modal-title {
            color: white;
            font-weight: bold;
            font-size: 25px;
        }

        .modal-msg {
            font-size: 18px;
        }

        .modal-footer {
            padding: 25px;
            /*border-top: 1px solid #f34d1b;*/
            text-align: center;
        }

        .modal-btn {
            background-color: #f34d1b;
            color: white;
            padding: 8px 25px;
            border-radius: 8px;
        }

        .warning-modal-content {
            border: 2px solid #f7d631;
        }

        .warning-modal-header {
            background-color: #f7d631;
            padding: 8px;
            color: black;
            text-align: center;
        }

        .warning-modal-title {
            color: black;
            font-weight: bold;
            font-size: 25px;
        }

        .warning-modal-msg {
            font-size: 18px;
            color: black;
        }

        .warning-modal-btn {
            background-color: #f7d631;
            border: 1px solid #f7d631;
            color: black;
            font-weight: bold;
            padding: 8px 25px;
            border-radius: 8px;
        }




    </style>


    <div class="themetoggle">
        <table class="submenu-right-side" id="right-table">
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
                                <li onclick="showViews(this,'CardView')">
                                    <span>Card View</span>
                                </li>
                                <li onclick="showViews(this,'ListView')">
                                    <span>List View</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </td>
                <td onmouseover="showPanelFilter(this,'panelFilter','5px','54px', 'ulFilter');" onmouseout="hidePanels(this,'panelFilter')">
                    <i class="glyphicon glyphicon-filter" style="font-size: 17px;"></i>
                    <div class="panel panel-default panel-subitems" id="panelFilter" onmouseover="showPanelFilter(this,'panelFilter','5px','54px', 'ulFilter');" onmouseout="hidePanels(this,'panelFilter')" style="width: 200px;">
                        <div class="panel-body">
                            <ul class="outer-ul" id="ulFilter">
                            </ul>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
        <asp:Button runat="server" ID="btnModal1" OnClientClick="return showmodal();" Text="modal 1" />

        <div id="containerid"></div>
        <asp:Button runat="server" ID="Button1" OnClientClick="return print();" Text="Print" />


   <input type="checkbox" data-toggle="toggle" data-on="Enabled" data-off="Disabled">

        <div class="modal fade" id="errorModal" role="dialog">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content modalContent modal-content">
                    <div class="modal-header modalHeader modal-header">
                        <i class="glyphicon glyphicon-remove-sign modal-icons"></i>
                        <br />
                        <h4 class="modal-title">Error</h4>
                        <br />
                        <span class="modal-msg">Reocrd insertion failed...</span>
                    </div>
                    <%--  <div class="modal-body">

                    </div>--%>
                    <div class="modal-footer modalFooter modal-footer">
                        <input type="button" value="OK" class="modal-btn" data-dismiss="modal" />
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
                        <h4 class="warning-modal-title">Error</h4>
                        <br />
                        <span class="warning-modal-msg">Reocrd insertion failed...</span>
                    </div>
                    <%--  <div class="modal-body">

                    </div>--%>
                    <div class="modal-footer modalFooter modal-footer">
                        <input type="button" value="OK" class="warning-modal-btn" data-dismiss="modal" />
                    </div>
                </div>
            </div>
        </div>
    </div>



    <script>
        $(document).ready(function () {
            $('#right-table').appendTo('#right-side-filters');
            bindSynGauageChart();
        });
        function showmodal() {
            $('#warningModal').modal('show');
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


        function print() {
            //    let printElem = document.getElementById('processParamChartViewContainer');
            //ej.base.print(printElem);
            // $("#containerid").ejPrint();
            var chartObj = $("#containerid").ejChart("instance");
            chartObj.print("containerid");
            // e.preventDefault();
            // return false;
        }
        function bindSynGauageChart() {
            $("#containerid").ejChart({
                height: 195,
                width: 280,
                backgroundColor: "#454545",
                readOnly: false,
                radius: 98,
                scales: [{
                    radius: 96,
                    showRanges: true,
                    size: 0,
                    // showIndicators: true,
                    pointerCap: {
                        radius: 8,
                        borderWidth: 0,
                        backgroundColor: "#9c9a9a",
                        borderColor: "#9c9a9a"
                    },
                    maximum: 200,
                    majorIntervalValue: 20,
                    minorIntervalValue: 5,

                    labels: [{
                        color: "#ffffff"
                    }],

                    pointers: [
                        {
                            value: 20,
                            showBackNeedle: false,
                            length: 40,
                            width: 1,
                            radius: 10,
                            needleType: "rectangle",
                            backgroundColor: "red",
                            border: {
                                color: "red"
                            },
                        },
                        {
                            value: 80,
                            showBackNeedle: false,
                            length: 40,
                            width: 1,
                            radius: 10,
                            needleType: "rectangle",
                            backgroundColor: "red",
                            border: {
                                color: "red"
                            },
                        },
                        {
                            value: 50,
                            showBackNeedle: false,
                            length: 67,
                            width: 14,
                            radius: 7,
                            backgroundColor: "blue",
                            border: {
                                color: "blue"
                            },
                        },

                    ],

                    ticks: [{
                        type: "major",
                        distanceFromScale: 40,
                        height: 10,
                        width: 3,
                        color: "#ffffff"
                    }, {
                        type: "minor",
                        height: 4,
                        width: 1,
                        distanceFromScale: 40,
                        color: "#ffffff"
                    }],


                    ranges: [
                        {
                            distanceFromScale: -5,
                            startValue: 0,
                            endValue: 200,
                            backgroundColor: "#18c0de",
                            border: {
                                color: "#18c0de"
                            },

                        },
                    ],
                }]

            });
        }
    </script>
</asp:Content>
