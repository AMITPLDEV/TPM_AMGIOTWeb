<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Maintenance.aspx.cs" Inherits="NewProject.Maintenance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
      
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
    </div>

    <script>
        $(document).ready(function () {
               $('#right-table').appendTo('#right-side-filters');
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

    </script>
</asp:Content>
