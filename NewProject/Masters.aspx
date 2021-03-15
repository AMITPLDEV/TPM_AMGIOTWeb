<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Masters.aspx.cs" Inherits="NewProject.Masters" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
         <style>
        .textboxcss {
            border: none;
            background-color: transparent;
            font-style: italic;
            color: white;
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

        .form-control {
            border-radius: 10px;
        }
        .Btns {
            color: #fff;
            background: -webkit-linear-gradient(top, #aaa 0,#000 40%, #555 100%);
            -webkit-box-shadow: inset 0 -1em 0 0.2em rgba(0,0,0,.55);
            border: 2px solid gray;
            -webkit-border-radius: 1em;
            /* padding: .67em; */
            font-weight: 700;
            padding:5px 20px;
            font-size:16px;
        }

          input[type="checkbox"] {
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
                .filterTbl tr td{
                    font-size:17px;
                }
                .P1Table select{
                    width:auto;
                }
                .P1Table tr th,  .P1Table tr td{
                    border-left: unset;
                    border-right: unset;
                }
    </style>
    <div class="container-fluid">
        <div class="row" style="color: white;">
            <div class="col-sm-12 col-lg-12 col-md-12 content-sub-menu">
                <asp:HiddenField runat="server" ID="activeMenu" ClientIDMode="Static" />
                <div style="float: left; margin-top: 5px">
                    <div class="navbar-collapse collapse">
                        <ul class="nav navbar-nav nextPrevious">
                            <li runat="server" id="liSLI" class="active"><a runat="server" id="SLI" class="menuData" data-toggle="tab" href="#menu0">Company</a>
                                <i></i>
                            </li>
                            <li runat="server" id="liAnnexureA"><a runat="server" id="annexureA" class="menuData" data-toggle="tab" href="#menu1">Plant / Shop / Cell</a>
                                <i></i>
                            </li>
                            <li><a runat="server" class="menuData" id="annexureB" data-toggle="tab" href="#menu2">Machine</a>
                                <i></i>
                            </li>
                            <li><a runat="server" class="menuData" id="formSDF" data-toggle="tab" href="#menu3">Parts</a>
                                <i></i>
                            </li>
                            <li><a runat="server" class="menuData" id="A1" data-toggle="tab" href="#menu4">Loss Codes</a>
                                <i></i>
                            </li>
                            <li><a runat="server" class="menuData" id="A2" data-toggle="tab" href="#menu5">Rejection Codes</a>
                                <i></i>
                            </li>
                            <li><a runat="server" class="menuData" id="A3" data-toggle="tab" href="#menu6">Employee</a>
                                <i></i>
                            </li>
                            <li><a runat="server" class="menuData" id="A4" data-toggle="tab" href="#menu7">Inspection Data</a>
                                <i></i>
                            </li>
                            <li><a runat="server" class="menuData" id="A5" data-toggle="tab" href="#menu7">User Roles</a>
                                <i></i>
                            </li>
                            <li><a runat="server" class="menuData" id="A6" data-toggle="tab" href="#menu8">Process Parameter</a>
                                <i></i>
                            </li>
                        </ul>
                    </div>
                </div>

                <div style="float: right">
                    <table class="submenu-right-side" style="height: 60px">
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
            </div>
            <div class="tab-content themetoggle" id="inputContainer" style="overflow: auto; height: 80vh; width: 95vw; margin: 120px auto 0px auto;">
                <div id="menu0" class="tab-pane fade">
                    <div class="listView">
                        <table class="P1Table">
                            <tr>
                                <th>Numeric</th>
                                <th>Alpha Numeric</th>
                                <th>Date</th>
                                <th>Time</th>

                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                        </table>
                    </div>
                    <div class="cardView" style="display: none">
                        <div class="outer-div">
                            <div>
                                <table class="card-table">
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <span class="card-header">P1</span>
                                        </td>
                                    </tr>
                                    <tr>

                                        <td>
                                            <span class="card-sub-header">Numeric</span>
                                        </td>
                                        <td>
                                            <span>1</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Alpha Numeric</span>
                                        </td>
                                        <td>
                                            <span>2</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Date</span>
                                        </td>
                                        <td>
                                            <span>3</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Time</span>
                                        </td>
                                        <td>
                                            <span>4</span>
                                        </td>
                                    </tr>
                                </table>


                            </div>
                        </div>

                        <div class="outer-div">
                            <div>
                                <table class="card-table">
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <span class="card-header">P1</span>
                                        </td>
                                    </tr>
                                    <tr>

                                        <td>
                                            <span class="card-sub-header">Numeric</span>
                                        </td>
                                        <td>
                                            <span>1</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Alpha Numeric</span>
                                        </td>
                                        <td>
                                            <span>2</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Date</span>
                                        </td>
                                        <td>
                                            <span>3</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Time</span>
                                        </td>
                                        <td>
                                            <span>4</span>
                                        </td>
                                    </tr>
                                </table>


                            </div>
                        </div>

                        <div class="outer-div">
                            <div>
                                <table class="card-table">
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <span class="card-header">P1</span>
                                        </td>
                                    </tr>
                                    <tr>

                                        <td>
                                            <span class="card-sub-header">Numeric</span>
                                        </td>
                                        <td>
                                            <span>1</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Alpha Numeric</span>
                                        </td>
                                        <td>
                                            <span>2</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Date</span>
                                        </td>
                                        <td>
                                            <span>3</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Time</span>
                                        </td>
                                        <td>
                                            <span>4</span>
                                        </td>
                                    </tr>
                                </table>


                            </div>
                        </div>

                        <div class="outer-div">
                            <div>
                                <table class="card-table">
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <span class="card-header">P1</span>
                                        </td>
                                    </tr>
                                    <tr>

                                        <td>
                                            <span class="card-sub-header">Numeric</span>
                                        </td>
                                        <td>
                                            <span>1</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Alpha Numeric</span>
                                        </td>
                                        <td>
                                            <span>2</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Date</span>
                                        </td>
                                        <td>
                                            <span>3</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Time</span>
                                        </td>
                                        <td>
                                            <span>4</span>
                                        </td>
                                    </tr>
                                </table>


                            </div>
                        </div>
                    </div>
                </div>
                <div id="menu1" class="tab-pane fade">
                    <div class="listView">
                        <table class="P1Table">
                            <tr>
                                <th>Column 1</th>
                                <th>Column 2</th>
                                <th>Column 3</th>
                                <th>Column 4</th>

                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                        </table>
                    </div>
                    <div class="cardView" style="display: none">
                        <div class="outer-div">
                            <div>
                                <table class="card-table">
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <span class="card-header">P2</span>
                                        </td>
                                    </tr>
                                    <tr>

                                        <td>
                                            <span class="card-sub-header">Column 1</span>
                                        </td>
                                        <td>
                                            <span>1</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 2</span>
                                        </td>
                                        <td>
                                            <span>2</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 3</span>
                                        </td>
                                        <td>
                                            <span>3</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 4</span>
                                        </td>
                                        <td>
                                            <span>4</span>
                                        </td>
                                    </tr>
                                </table>


                            </div>
                        </div>

                        <div class="outer-div">
                            <div>
                                <table class="card-table">
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <span class="card-header">P2</span>
                                        </td>
                                    </tr>
                                    <tr>

                                        <td>
                                            <span class="card-sub-header">Column 1</span>
                                        </td>
                                        <td>
                                            <span>1</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 2</span>
                                        </td>
                                        <td>
                                            <span>2</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 3</span>
                                        </td>
                                        <td>
                                            <span>3</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 4</span>
                                        </td>
                                        <td>
                                            <span>4</span>
                                        </td>
                                    </tr>
                                </table>


                            </div>
                        </div>

                        <div class="outer-div">
                            <div>
                                <table class="card-table">
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <span class="card-header">P2</span>
                                        </td>
                                    </tr>
                                    <tr>

                                        <td>
                                            <span class="card-sub-header">Column 1</span>
                                        </td>
                                        <td>
                                            <span>1</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 2</span>
                                        </td>
                                        <td>
                                            <span>2</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 3</span>
                                        </td>
                                        <td>
                                            <span>3</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 4</span>
                                        </td>
                                        <td>
                                            <span>4</span>
                                        </td>
                                    </tr>
                                </table>


                            </div>
                        </div>

                        <div class="outer-div">
                            <div>
                                <table class="card-table">
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <span class="card-header">P2</span>
                                        </td>
                                    </tr>
                                    <tr>

                                        <td>
                                            <span class="card-sub-header">Column 1</span>
                                        </td>
                                        <td>
                                            <span>1</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 2</span>
                                        </td>
                                        <td>
                                            <span>2</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 3</span>
                                        </td>
                                        <td>
                                            <span>3</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 4</span>
                                        </td>
                                        <td>
                                            <span>4</span>
                                        </td>
                                    </tr>
                                </table>


                            </div>
                        </div>
                    </div>
                </div>
                <div id="menu2" class="tab-pane fade">
                    <div class="listView">
                        <table class="P1Table">
                            <tr>
                                <th>Column 1</th>
                                <th>Column 2</th>
                                <th>Column 3</th>
                                <th>Column 4</th>

                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                        </table>
                    </div>

                    <div class="cardView" style="display: none">
                        <div class="outer-div">
                            <div>
                                <table class="card-table">
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <span class="card-header">P3</span>
                                        </td>
                                    </tr>
                                    <tr>

                                        <td>
                                            <span class="card-sub-header">Column 1</span>
                                        </td>
                                        <td>
                                            <span>1</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 2</span>
                                        </td>
                                        <td>
                                            <span>2</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 3</span>
                                        </td>
                                        <td>
                                            <span>3</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 4</span>
                                        </td>
                                        <td>
                                            <span>4</span>
                                        </td>
                                    </tr>
                                </table>


                            </div>
                        </div>

                        <div class="outer-div">
                            <div>
                                <table class="card-table">
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <span class="card-header">P3</span>
                                        </td>
                                    </tr>
                                    <tr>

                                        <td>
                                            <span class="card-sub-header">Column 1</span>
                                        </td>
                                        <td>
                                            <span>1</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 2</span>
                                        </td>
                                        <td>
                                            <span>2</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 3</span>
                                        </td>
                                        <td>
                                            <span>3</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 4</span>
                                        </td>
                                        <td>
                                            <span>4</span>
                                        </td>
                                    </tr>
                                </table>


                            </div>
                        </div>

                        <div class="outer-div">
                            <div>
                                <table class="card-table">
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <span class="card-header">P3</span>
                                        </td>
                                    </tr>
                                    <tr>

                                        <td>
                                            <span class="card-sub-header">Column 1</span>
                                        </td>
                                        <td>
                                            <span>1</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 2</span>
                                        </td>
                                        <td>
                                            <span>2</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 3</span>
                                        </td>
                                        <td>
                                            <span>3</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 4</span>
                                        </td>
                                        <td>
                                            <span>4</span>
                                        </td>
                                    </tr>
                                </table>


                            </div>
                        </div>

                        <div class="outer-div">
                            <div>
                                <table class="card-table">
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <span class="card-header">P3</span>
                                        </td>
                                    </tr>
                                    <tr>

                                        <td>
                                            <span class="card-sub-header">Column 1</span>
                                        </td>
                                        <td>
                                            <span>1</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 2</span>
                                        </td>
                                        <td>
                                            <span>2</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 3</span>
                                        </td>
                                        <td>
                                            <span>3</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 4</span>
                                        </td>
                                        <td>
                                            <span>4</span>
                                        </td>
                                    </tr>
                                </table>


                            </div>
                        </div>
                    </div>
                </div>
                <div id="menu3" class="tab-pane fade">
                    <div class="listView">
                        <table class="P1Table">
                            <tr>
                                <th>Column 1</th>
                                <th>Column 2</th>
                                <th>Column 3</th>
                                <th>Column 4</th>

                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>1</td>
                                <td>2</td>
                                <td>3</td>
                                <td>4</td>
                            </tr>
                        </table>
                    </div>
                    <div class="cardView" style="display: none">
                        <div class="outer-div">
                            <div>
                                <table class="card-table">
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <span class="card-header">P4</span>
                                        </td>
                                    </tr>
                                    <tr>

                                        <td>
                                            <span class="card-sub-header">Column 1</span>
                                        </td>
                                        <td>
                                            <span>1</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 2</span>
                                        </td>
                                        <td>
                                            <span>2</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 3</span>
                                        </td>
                                        <td>
                                            <span>3</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 4</span>
                                        </td>
                                        <td>
                                            <span>4</span>
                                        </td>
                                    </tr>
                                </table>


                            </div>
                        </div>

                        <div class="outer-div">
                            <div>
                                <table class="card-table">
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <span class="card-header">P4</span>
                                        </td>
                                    </tr>
                                    <tr>

                                        <td>
                                            <span class="card-sub-header">Column 1</span>
                                        </td>
                                        <td>
                                            <span>1</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 2</span>
                                        </td>
                                        <td>
                                            <span>2</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 3</span>
                                        </td>
                                        <td>
                                            <span>3</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 4</span>
                                        </td>
                                        <td>
                                            <span>4</span>
                                        </td>
                                    </tr>
                                </table>


                            </div>
                        </div>

                        <div class="outer-div">
                            <div>
                                <table class="card-table">
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <span class="card-header">P4</span>
                                        </td>
                                    </tr>
                                    <tr>

                                        <td>
                                            <span class="card-sub-header">Column 1</span>
                                        </td>
                                        <td>
                                            <span>1</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 2</span>
                                        </td>
                                        <td>
                                            <span>2</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 3</span>
                                        </td>
                                        <td>
                                            <span>3</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 4</span>
                                        </td>
                                        <td>
                                            <span>4</span>
                                        </td>
                                    </tr>
                                </table>


                            </div>
                        </div>

                        <div class="outer-div">
                            <div>
                                <table class="card-table">
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <span class="card-header">P4</span>
                                        </td>
                                    </tr>
                                    <tr>

                                        <td>
                                            <span class="card-sub-header">Column 1</span>
                                        </td>
                                        <td>
                                            <span>1</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 2</span>
                                        </td>
                                        <td>
                                            <span>2</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 3</span>
                                        </td>
                                        <td>
                                            <span>3</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="card-sub-header">Column 4</span>
                                        </td>
                                        <td>
                                            <span>4</span>
                                        </td>
                                    </tr>
                                </table>


                            </div>
                        </div>
                    </div>
                </div>
                <div id="menu8" class="tab-pane fade">
                    <div style="float: left; margin-top: 5px">
                        <div class="navbar-collapse collapse">
                            <ul class="nav navbar-nav nextPrevious">
                                <li><a runat="server" class="submenuData" id="A14" clientidmode="static" data-toggle="tab" href="#processParamMenu0">MTB & Model Level</a>
                                    <i></i>
                                </li>
                                <li><a runat="server" class="submenuData" id="A15" clientidmode="static" data-toggle="tab" href="#processParamMenu1">Controller Level</a>
                                    <i></i>
                                </li>
                                <li><a runat="server" class="submenuData" id="A16" clientidmode="static" data-toggle="tab" href="#processParamMenu2">Machine Level</a>
                                    <i></i>
                                </li>
                            </ul>
                        </div>
                        <div class="tab-content themetoggle" id="processParamContainer" style="overflow: auto; width: 100%; margin: 10px auto;">
                            <div id="processParamMenu0" class="tab-pane fade">
                                <div>
                                    <table class="filterTbl" >
                                        <tr>
                                            <td>MTB&nbsp;</td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlMTB" CssClass="form-control">
                                                    <asp:ListItem>MGTL</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td>&nbsp;&nbsp;Machine Model&nbsp;</td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="DropDownList1" CssClass="form-control">
                                                    <asp:ListItem>MCV 400</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td>&nbsp;&nbsp;
                                                 <asp:Button runat="server" ID="btnMTBDataView" ClientIDMode="Static" Text="View" CssClass="Btns" />&nbsp;&nbsp;
                                                 <asp:Button runat="server" ID="btnSave" ClientIDMode="Static" Text="Save" CssClass="Btns" />&nbsp;&nbsp;
                                     <asp:Button runat="server" ID="btnDelete" ClientIDMode="Static" Text="Delete" CssClass="Btns" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="gvMTBModelContainer" style="margin-top: 10px; height: 62vh; overflow: auto">
                                    <asp:GridView ID="gvMTBModeldata" runat="server" AutoGenerateColumns="false" Width="100%" EmptyDataText="No Data Found." ShowHeaderWhenEmpty="true" ShowHeader="true" ShowFooter="true" ClientIDMode="Static" OnRowDataBound="gvMTBModeldata_RowDataBound"  CssClass="P1Table">
                                        <Columns>
                                            <asp:TemplateField HeaderText="MTB">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMTB" runat="server" Text='<%# Eval("MTB") %>' ClientIDMode="Static"></asp:Label>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                      <asp:DropDownList runat="server" ID="ddlMTBNew" CssClass="form-control">
                                                    <asp:ListItem>MGTL</asp:ListItem>
                                                </asp:DropDownList>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Machine Model">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMachineModel" runat="server" Text='<%# Eval("MachineModel") %>' ClientIDMode="Static"></asp:Label>

                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:DropDownList runat="server" ID="ddlMachineModelNew" CssClass="form-control">
                                                    <asp:ListItem>MCV 400</asp:ListItem>
                                                </asp:DropDownList>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <%--   <asp:TemplateField HeaderText="Machine ID">
                                            <ItemTemplate>
                                                    <asp:Label ID="lblMachineID"  runat="server" Text='<%# Eval("TimeFrom") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>--%>
                                            <asp:TemplateField HeaderText="Parameter ID">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblParemeterID" runat="server" Text='<%# Eval("ParemeterID") %>' ClientIDMode="Static"></asp:Label>

                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox runat="server" ID="txtParameterIDNew" CssClass="form-control"></asp:TextBox>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Source Type">
                                                <ItemTemplate>
                                                    <asp:HiddenField runat="server" ID="hdnSourceType" Value='<%# Eval("SourceType") %>' ClientIDMode="Static" />
                                                    <asp:DropDownList ID="ddlSourceType" runat="server" CssClass="textboxcss select form-control">
                                                        <asp:ListItem>Focas Function</asp:ListItem>
                                                        <asp:ListItem>PMC</asp:ListItem>
                                                        <asp:ListItem>Macro</asp:ListItem>
                                                        <asp:ListItem>Dia</asp:ListItem>
                                                        <asp:ListItem>System Parameters</asp:ListItem>
                                                        <asp:ListItem>Signals</asp:ListItem>
                                                    </asp:DropDownList>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:DropDownList ID="ddlSourceTypeNew" runat="server" CssClass="form-control">
                                                        <asp:ListItem>Focas Function</asp:ListItem>
                                                        <asp:ListItem>PMC</asp:ListItem>
                                                        <asp:ListItem>Macro</asp:ListItem>
                                                        <asp:ListItem>Dia</asp:ListItem>
                                                        <asp:ListItem>System Parameters</asp:ListItem>
                                                        <asp:ListItem>Signals</asp:ListItem>
                                                    </asp:DropDownList>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Source Address1">
                                                <ItemTemplate>
                                                    <asp:TextBox runat="server" ID="txtSourceAdd1" Style="width: 80px; text-align: left" CssClass="textboxcss" Text='<%# Eval("SourceAdd1") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox runat="server" ID="txtSourceAdd1New" CssClass="form-control"></asp:TextBox>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Source Data Type1">
                                                <ItemTemplate>
                                                    <asp:TextBox runat="server" ID="txtDataType1" Style="width: 80px; text-align: left" CssClass="textboxcss" Text='<%# Eval("SourceDatatype1") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox runat="server" ID="txtDataType1New" CssClass="form-control"></asp:TextBox>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Source Address2">
                                                <ItemTemplate>
                                                    <asp:TextBox runat="server" ID="txtSourceAdd2" Style="width: 80px; text-align: left" CssClass="textboxcss" Text='<%# Eval("SourceAdd2") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox runat="server" ID="txtSourceAdd2New" CssClass="form-control"></asp:TextBox>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Source Data Type2">
                                                <ItemTemplate>
                                                    <asp:TextBox runat="server" ID="txtDataType2" Style="width: 80px; text-align: left" CssClass="textboxcss" Text='<%# Eval("SourceDatatype2") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox runat="server" ID="txtDataType2New" CssClass="form-control"></asp:TextBox>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Polling Frequency">
                                                <ItemTemplate>
                                                    <asp:HiddenField runat="server" ID="hdnPollingFrequency" Value='<%# Eval("PollingFrequency") %>' ClientIDMode="Static" />
                                                    <asp:DropDownList ID="ddlPollingFrequency" runat="server" CssClass="textboxcss select form-control">
                                                        <asp:ListItem>0.5</asp:ListItem>
                                                    </asp:DropDownList>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:DropDownList ID="ddlPollingFrequencyNew" runat="server" CssClass="form-control">
                                                        <asp:ListItem>0.5</asp:ListItem>
                                                    </asp:DropDownList>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Data Group">
                                                <ItemTemplate>
                                                    <asp:HiddenField runat="server" ID="hdnDataGroup" Value='<%# Eval("DataGroup") %>' ClientIDMode="Static" />
                                                    <asp:DropDownList ID="ddlDataGroup" runat="server" CssClass="textboxcss select form-control">
                                                        <asp:ListItem>Fixed Data</asp:ListItem>
                                                        <asp:ListItem>Custom PMC</asp:ListItem>
                                                        <asp:ListItem>Custom Macro</asp:ListItem>
                                                        <asp:ListItem>Custom Dia</asp:ListItem>
                                                        <asp:ListItem>Custom SystemParameters</asp:ListItem>
                                                        <asp:ListItem>Custom Signals</asp:ListItem>
                                                    </asp:DropDownList>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:DropDownList ID="ddlDataGroupNew" runat="server" CssClass="form-control">
                                                        <asp:ListItem>Fixed Data</asp:ListItem>
                                                        <asp:ListItem>Custom PMC</asp:ListItem>
                                                        <asp:ListItem>Custom Macro</asp:ListItem>
                                                        <asp:ListItem>Custom Dia</asp:ListItem>
                                                        <asp:ListItem>Custom SystemParameters</asp:ListItem>
                                                        <asp:ListItem>Custom Signals</asp:ListItem>
                                                    </asp:DropDownList>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Polling Type">
                                                <ItemTemplate>
                                                    <asp:HiddenField runat="server" ID="hdnPollingType" Value='<%# Eval("PollingType") %>' ClientIDMode="Static" />
                                                    <asp:DropDownList ID="ddlPollingType" runat="server" CssClass="textboxcss select form-control" style="width:100px">
                                                        <asp:ListItem>Continious Reading</asp:ListItem>
                                                        <asp:ListItem>Within Cycle Reading</asp:ListItem>
                                                        <asp:ListItem>Read Based On Custom TimePeriod</asp:ListItem>
                                                    </asp:DropDownList>
                                                </ItemTemplate>
                                                <FooterTemplate> 
                                                    <asp:DropDownList ID="ddlPollingTypeNew" runat="server" CssClass="form-control" style="width:100px">
                                                        <asp:ListItem>Continious Reading</asp:ListItem>
                                                        <asp:ListItem>Within Cycle Reading</asp:ListItem>
                                                        <asp:ListItem>Read Based On Custom TimePeriod</asp:ListItem>
                                                    </asp:DropDownList>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Cycle Frequency Time">
                                                <ItemTemplate>
                                                    <asp:HiddenField runat="server" ID="hdnCycleFreqTime" Value='<%# Eval("CycleFreqTime") %>' ClientIDMode="Static" />
                                                    <asp:DropDownList ID="ddlCycleFrequencyTime" runat="server" CssClass="textboxcss select form-control">
                                                        <asp:ListItem>60 min.</asp:ListItem>
                                                    </asp:DropDownList>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:DropDownList ID="ddlCycleFrequencyTimeNew" runat="server" CssClass="form-control">
                                                        <asp:ListItem>60 min.</asp:ListItem>
                                                    </asp:DropDownList>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="No. of Cycles">
                                                <ItemTemplate>
                                                    <asp:HiddenField runat="server" ID="hdnNoOfCycle" Value='<%# Eval("NoOfCycle") %>' ClientIDMode="Static" />
                                                    <asp:DropDownList ID="ddlNoOfCycle" runat="server" CssClass="textboxcss select form-control">
                                                        <asp:ListItem>1</asp:ListItem>
                                                        <asp:ListItem>2</asp:ListItem>
                                                        <asp:ListItem>3</asp:ListItem>
                                                        <asp:ListItem>4</asp:ListItem>
                                                        <asp:ListItem>5</asp:ListItem>
                                                        <asp:ListItem>6</asp:ListItem>
                                                        <asp:ListItem>7</asp:ListItem>
                                                        <asp:ListItem>8</asp:ListItem>
                                                        <asp:ListItem>9</asp:ListItem>
                                                        <asp:ListItem>10</asp:ListItem>
                                                    </asp:DropDownList>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:DropDownList ID="ddlNoOfCycleNew" runat="server" CssClass="form-control">
                                                        <asp:ListItem>1</asp:ListItem>
                                                        <asp:ListItem>2</asp:ListItem>
                                                        <asp:ListItem>3</asp:ListItem>
                                                        <asp:ListItem>4</asp:ListItem>
                                                        <asp:ListItem>5</asp:ListItem>
                                                        <asp:ListItem>6</asp:ListItem>
                                                        <asp:ListItem>7</asp:ListItem>
                                                        <asp:ListItem>8</asp:ListItem>
                                                        <asp:ListItem>9</asp:ListItem>
                                                        <asp:ListItem>10</asp:ListItem>
                                                    </asp:DropDownList>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="IsEnabled?">
                                                <ItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chkIsEnabled" Checked='<%# Eval("IsEnabled") %>' />
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:CheckBox runat="server" ID="chkIsEnabledNew" />
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Should Not Be Disabled?">
                                                <ItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chkShouldNotBeDisabled" Checked='<%# Eval("ShouldNotBeDisabled") %>' />
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:CheckBox runat="server" ID="chkShouldNotBeDisabledNew" />
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Select">
                                                <ItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chkDeleteSelection" />
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:Button runat="server" ID="btnInsert" Text="Add" CssClass="Btns" />
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                            <div id="processParamMenu1" class="tab-pane fade">
                                <div>
                                    <table>
                                        <tr>
                                            <td>Machine Type&nbsp;</td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlControlLvlMachineType" CssClass="form-control">
                                                    <asp:ListItem>VMC</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td>&nbsp;&nbsp;CNC Make&nbsp;</td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlControlLvlCNCMake" CssClass="form-control">
                                                    <asp:ListItem>Fanuc</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td>&nbsp;&nbsp;CNC Model&nbsp;</td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlControlLvlCNCModel" CssClass="form-control">
                                                    <asp:ListItem>OiTD</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td>&nbsp;&nbsp;
                                                 <asp:Button runat="server" ID="Button1" ClientIDMode="Static" Text="View" CssClass="Btns" />&nbsp;&nbsp;
                                                 <asp:Button runat="server" ID="Button2" ClientIDMode="Static" Text="Save" CssClass="Btns" />&nbsp;&nbsp;
                                     <asp:Button runat="server" ID="Button3" ClientIDMode="Static" Text="Delete" CssClass="Btns" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="gvControllerLvlContainer" style="margin-top: 10px; height: 62vh; overflow: auto">
                                    <asp:GridView ID="gvControllerLvlData" runat="server" AutoGenerateColumns="false" Width="100%" EmptyDataText="No Data Found." ShowHeaderWhenEmpty="true" ShowHeader="true" ShowFooter="true" ClientIDMode="Static" OnRowDataBound="gvControllerLvlData_RowDataBound" CssClass="P1Table">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Machine Type">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMachineType" runat="server" Text='<%# Eval("MachineType") %>' ClientIDMode="Static"></asp:Label>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:DropDownList runat="server" ID="ddlMachineTypeNew" CssClass="form-control">
                                                          <asp:ListItem>VMC</asp:ListItem>
                                                    </asp:DropDownList>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="CNC Make">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCNCMake" runat="server" Text='<%# Eval("CNCMake") %>' ClientIDMode="Static"></asp:Label>

                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:DropDownList runat="server" ID="ddlCNCMakeNew"  CssClass="form-control">
                                                         <asp:ListItem>Fanuc</asp:ListItem>
                                                    </asp:DropDownList>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="CNC Model">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCNCModel" runat="server" Text='<%# Eval("CNCModel") %>' ClientIDMode="Static"></asp:Label>

                                                </ItemTemplate>
                                                <FooterTemplate>
                                                     <asp:DropDownList runat="server" ID="ddlCNCModelNew" CssClass="form-control">
                                                    <asp:ListItem>OiTD</asp:ListItem>
                                                </asp:DropDownList>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <%--   <asp:TemplateField HeaderText="Machine ID">
                                            <ItemTemplate>
                                                    <asp:Label ID="lblMachineID"  runat="server" Text='<%# Eval("TimeFrom") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>--%>
                                            <asp:TemplateField HeaderText="Parameter ID">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblParemeterID" runat="server" Text='<%# Eval("ParemeterID") %>' ClientIDMode="Static"></asp:Label>

                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox runat="server" ID="txtParameterIDNew" CssClass="form-control"></asp:TextBox>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Source Type">
                                                <ItemTemplate>
                                                    <asp:HiddenField runat="server" ID="hdnSourceType" Value='<%# Eval("SourceType") %>' ClientIDMode="Static" />
                                                    <asp:DropDownList ID="ddlSourceType" runat="server" CssClass="textboxcss select form-control">
                                                        <asp:ListItem>Focas Function</asp:ListItem>
                                                        <asp:ListItem>PMC</asp:ListItem>
                                                        <asp:ListItem>Macro</asp:ListItem>
                                                        <asp:ListItem>Dia</asp:ListItem>
                                                        <asp:ListItem>System Parameters</asp:ListItem>
                                                        <asp:ListItem>Signals</asp:ListItem>
                                                        <asp:ListItem>Alarm History</asp:ListItem>
                                                        <asp:ListItem>Operation History</asp:ListItem>
                                                        <asp:ListItem>Tool Life</asp:ListItem>
                                                        <asp:ListItem>Program Download</asp:ListItem>
                                                        <asp:ListItem>OEE Macro Based</asp:ListItem>
                                                    </asp:DropDownList>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:DropDownList ID="ddlSourceTypeNew" runat="server" CssClass="form-control">
                                                        <asp:ListItem>Focas Function</asp:ListItem>
                                                        <asp:ListItem>PMC</asp:ListItem>
                                                        <asp:ListItem>Macro</asp:ListItem>
                                                        <asp:ListItem>Dia</asp:ListItem>
                                                        <asp:ListItem>System Parameters</asp:ListItem>
                                                        <asp:ListItem>Signals</asp:ListItem>
                                                        <asp:ListItem>Alarm History</asp:ListItem>
                                                        <asp:ListItem>Operation History</asp:ListItem>
                                                        <asp:ListItem>Tool Life</asp:ListItem>
                                                        <asp:ListItem>Program Download</asp:ListItem>
                                                        <asp:ListItem>OEE Macro Based</asp:ListItem>
                                                    </asp:DropDownList>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Source Address1">
                                                <ItemTemplate>
                                                    <asp:TextBox runat="server" ID="txtSourceAdd1" Style="width: 80px; text-align: left" CssClass="textboxcss" Text='<%# Eval("SourceAdd1") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox runat="server" ID="txtSourceAdd1New" CssClass="form-control"></asp:TextBox>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Source Data Type1">
                                                <ItemTemplate>
                                                    <asp:TextBox runat="server" ID="txtDataType1" Style="width: 80px; text-align: left" CssClass="textboxcss" Text='<%# Eval("SourceDatatype1") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox runat="server" ID="txtDataType1New" CssClass="form-control"></asp:TextBox>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Source Address2">
                                                <ItemTemplate>
                                                    <asp:TextBox runat="server" ID="txtSourceAdd2" Style="width: 80px; text-align: left" CssClass="textboxcss" Text='<%# Eval("SourceAdd2") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox runat="server" ID="txtSourceAdd2New" CssClass="form-control"></asp:TextBox>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Source Data Type2">
                                                <ItemTemplate>
                                                    <asp:TextBox runat="server" ID="txtDataType2" Style="width: 80px; text-align: left" CssClass="textboxcss" Text='<%# Eval("SourceDatatype2") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox runat="server" ID="txtDataType2New" CssClass="form-control"></asp:TextBox>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Polling Frequency">
                                                <ItemTemplate>
                                                    <asp:HiddenField runat="server" ID="hdnPollingFrequency" Value='<%# Eval("PollingFrequency") %>' ClientIDMode="Static" />
                                                    <asp:DropDownList ID="ddlPollingFrequency" runat="server" CssClass="textboxcss select form-control">
                                                        <asp:ListItem>500 ms</asp:ListItem>
                                                        <asp:ListItem>5 sec</asp:ListItem>
                                                        <asp:ListItem>60 sec</asp:ListItem>
                                                    </asp:DropDownList>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:DropDownList ID="ddlPollingFrequencyNew" runat="server" CssClass="form-control">
                                                        <asp:ListItem>500 ms</asp:ListItem>
                                                        <asp:ListItem>5 sec</asp:ListItem>
                                                        <asp:ListItem>60 sec</asp:ListItem>
                                                    </asp:DropDownList>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Data Group">
                                                <ItemTemplate>
                                                    <asp:HiddenField runat="server" ID="hdnDataGroup" Value='<%# Eval("DataGroup") %>' ClientIDMode="Static" />
                                                    <asp:DropDownList ID="ddlDataGroup" runat="server" CssClass="textboxcss select form-control" style="width:100px">
                                                        <asp:ListItem>Fixed Data</asp:ListItem>
                                                        <asp:ListItem>Custom PMC</asp:ListItem>
                                                        <asp:ListItem>Custom Macro</asp:ListItem>
                                                        <asp:ListItem>Custom Dia</asp:ListItem>
                                                        <asp:ListItem>Custom System Parameters</asp:ListItem>
                                                        <asp:ListItem>Custom Signals</asp:ListItem>
                                                    </asp:DropDownList>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:DropDownList ID="ddlDataGroupNew" runat="server" CssClass="form-control" style="width:100px">
                                                        <asp:ListItem>Fixed Data</asp:ListItem>
                                                        <asp:ListItem>Custom PMC</asp:ListItem>
                                                        <asp:ListItem>Custom Macro</asp:ListItem>
                                                        <asp:ListItem>Custom Dia</asp:ListItem>
                                                        <asp:ListItem>Custom System Parameters</asp:ListItem>
                                                        <asp:ListItem>Custom Signals</asp:ListItem>
                                                    </asp:DropDownList>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Polling Type">
                                                <ItemTemplate>
                                                    <asp:HiddenField runat="server" ID="hdnPollingType" Value='<%# Eval("PollingType") %>' ClientIDMode="Static" />
                                                    <asp:DropDownList ID="ddlPollingType" runat="server" CssClass="textboxcss select form-control" style="width:100px">
                                                        <asp:ListItem>Continious Reading</asp:ListItem>
                                                        <asp:ListItem>Within Cycle Reading</asp:ListItem>
                                                        <asp:ListItem>Read Based On Custom TimePeriod</asp:ListItem>
                                                    </asp:DropDownList>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:DropDownList ID="ddlPollingTypeNew" runat="server" CssClass="form-control" style="width:100px">
                                                        <asp:ListItem>Continious Reading</asp:ListItem>
                                                        <asp:ListItem>Within Cycle Reading</asp:ListItem>
                                                        <asp:ListItem>Read Based On Custom TimePeriod</asp:ListItem>
                                                    </asp:DropDownList>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Cycle Frequency Time">
                                                <ItemTemplate>
                                                    <asp:HiddenField runat="server" ID="hdnCycleFreqTime" Value='<%# Eval("CycleFreqTime") %>' ClientIDMode="Static" />
                                                    <asp:DropDownList ID="ddlCycleFrequencyTime" runat="server" CssClass="textboxcss select form-control">
                                                        <asp:ListItem>30 min.</asp:ListItem>
                                                        <asp:ListItem>60 min.</asp:ListItem>
                                                    </asp:DropDownList>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:DropDownList ID="ddlCycleFrequencyTimeNew" runat="server" CssClass="form-control">
                                                        <asp:ListItem>30 min.</asp:ListItem>
                                                        <asp:ListItem>60 min.</asp:ListItem>
                                                    </asp:DropDownList>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="No. of Cycles">
                                                <ItemTemplate>
                                                    <asp:HiddenField runat="server" ID="hdnNoOfCycle" Value='<%# Eval("NoOfCycle") %>' ClientIDMode="Static" />
                                                    <asp:DropDownList ID="ddlNoOfCycle" runat="server" CssClass="textboxcss select form-control">
                                                        <asp:ListItem>1</asp:ListItem>
                                                        <asp:ListItem>2</asp:ListItem>
                                                        <asp:ListItem>3</asp:ListItem>
                                                        <asp:ListItem>4</asp:ListItem>
                                                        <asp:ListItem>5</asp:ListItem>
                                                        <asp:ListItem>6</asp:ListItem>
                                                        <asp:ListItem>7</asp:ListItem>
                                                        <asp:ListItem>8</asp:ListItem>
                                                        <asp:ListItem>9</asp:ListItem>
                                                        <asp:ListItem>10</asp:ListItem>
                                                    </asp:DropDownList>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:DropDownList ID="ddlNoOfCycleNew" runat="server" CssClass="form-control">
                                                        <asp:ListItem>1</asp:ListItem>
                                                        <asp:ListItem>2</asp:ListItem>
                                                        <asp:ListItem>3</asp:ListItem>
                                                        <asp:ListItem>4</asp:ListItem>
                                                        <asp:ListItem>5</asp:ListItem>
                                                        <asp:ListItem>6</asp:ListItem>
                                                        <asp:ListItem>7</asp:ListItem>
                                                        <asp:ListItem>8</asp:ListItem>
                                                        <asp:ListItem>9</asp:ListItem>
                                                        <asp:ListItem>10</asp:ListItem>
                                                    </asp:DropDownList>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="IsEnabled?">
                                                <ItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chkIsEnabled" Checked='<%# Eval("IsEnabled") %>' />
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:CheckBox runat="server" ID="chkIsEnabledNew" />
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Should Not Be Disabled?">
                                                <ItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chkShouldNotBeDisabled" Checked='<%# Eval("ShouldNotBeDisabled") %>' />
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:CheckBox runat="server" ID="chkShouldNotBeDisabledNew" />
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Select">
                                                <ItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chkDeleteSelection" />
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:Button runat="server" ID="btnInsert" Text="Add" CssClass="Btns" />
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                            <div id="processParamMenu2" class="tab-pane fade">
                                <div>
                                    <table>
                                        <tr>
                                            <td>MTB&nbsp;</td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlMachineLvlMTB" CssClass="form-control">
                                                    <asp:ListItem>MGTL</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td>&nbsp;&nbsp;Machine Model&nbsp;</td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlMachineLvlMachineModel" CssClass="form-control">
                                                    <asp:ListItem>MCV 400</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td>&nbsp;&nbsp;Machine ID&nbsp;</td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlMachineLvlMachineID" CssClass="form-control">
                                                    <asp:ListItem>ACE-01</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td>&nbsp;&nbsp;
                                                 <asp:Button runat="server" ID="btnMachineLvlView" ClientIDMode="Static" Text="View" CssClass="Btns" />&nbsp;&nbsp;
                                                 <asp:Button runat="server" ID="btnMachineLvlSave" ClientIDMode="Static" Text="Save" CssClass="Btns" />&nbsp;&nbsp;
                                     <asp:Button runat="server" ID="btnMachineLvlDelete" ClientIDMode="Static" Text="Delete" CssClass="Btns" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="gvMachineLvlContainer" style="margin-top: 10px; height: 62vh; overflow: auto">
                                    <asp:GridView ID="gvMAchineLvlData" runat="server" AutoGenerateColumns="false" Width="100%" EmptyDataText="No Data Found." ShowHeaderWhenEmpty="true" ShowHeader="true" ShowFooter="true" ClientIDMode="Static" OnRowDataBound="gvMAchineLvlData_RowDataBound" CssClass="P1Table">
                                        <Columns>
                                            <asp:TemplateField HeaderText="MTB">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMTB" runat="server" Text='<%# Eval("MTB") %>' ClientIDMode="Static"></asp:Label>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:DropDownList runat="server" ID="ddlMTBNew" CssClass="form-control">
                                                          <asp:ListItem>MGTL</asp:ListItem>
                                                    </asp:DropDownList>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Machine Model">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMachineModel" runat="server" Text='<%# Eval("MachineModel") %>' ClientIDMode="Static"></asp:Label>

                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:DropDownList runat="server" ID="ddlMachineModelNew"  CssClass="form-control">
                                                         <asp:ListItem>MCV 400</asp:ListItem>
                                                    </asp:DropDownList>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Machine ID">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMachineID" runat="server" Text='<%# Eval("MachineID") %>' ClientIDMode="Static"></asp:Label>

                                                </ItemTemplate>
                                                <FooterTemplate>
                                                     <asp:DropDownList runat="server" ID="ddlMachineIDNew" CssClass="form-control">
                                                    <asp:ListItem>ACE-01</asp:ListItem>
                                                </asp:DropDownList>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <%--   <asp:TemplateField HeaderText="Machine ID">
                                            <ItemTemplate>
                                                    <asp:Label ID="lblMachineID"  runat="server" Text='<%# Eval("TimeFrom") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>--%>
                                            <asp:TemplateField HeaderText="Parameter ID">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblParemeterID" runat="server" Text='<%# Eval("ParemeterID") %>' ClientIDMode="Static"></asp:Label>

                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox runat="server" ID="txtParameterIDNew" CssClass="form-control"></asp:TextBox>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Source Type">
                                                <ItemTemplate>
                                                    <asp:HiddenField runat="server" ID="hdnSourceType" Value='<%# Eval("SourceType") %>' ClientIDMode="Static" />
                                                    <asp:DropDownList ID="ddlSourceType" runat="server" CssClass="textboxcss select form-control" style="width:110px">
                                                        <asp:ListItem>Focas Function</asp:ListItem>
                                                        <asp:ListItem>PMC</asp:ListItem>
                                                        <asp:ListItem>Macro</asp:ListItem>
                                                        <asp:ListItem>Dia</asp:ListItem>
                                                        <asp:ListItem>System Parameters</asp:ListItem>
                                                        <asp:ListItem>Signals</asp:ListItem>
                                                    </asp:DropDownList>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:DropDownList ID="ddlSourceTypeNew" runat="server" CssClass="form-control" style="width:110px">
                                                        <asp:ListItem>Focas Function</asp:ListItem>
                                                        <asp:ListItem>PMC</asp:ListItem>
                                                        <asp:ListItem>Macro</asp:ListItem>
                                                        <asp:ListItem>Dia</asp:ListItem>
                                                        <asp:ListItem>System Parameters</asp:ListItem>
                                                        <asp:ListItem>Signals</asp:ListItem>
                                                    </asp:DropDownList>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Source Address1">
                                                <ItemTemplate>
                                                    <asp:TextBox runat="server" ID="txtSourceAdd1" Style="width: 80px; text-align: left" CssClass="textboxcss" Text='<%# Eval("SourceAdd1") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox runat="server" ID="txtSourceAdd1New" CssClass="form-control"></asp:TextBox>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Source Data Type1">
                                                <ItemTemplate>
                                                    <asp:TextBox runat="server" ID="txtDataType1" Style="width: 80px; text-align: left" CssClass="textboxcss" Text='<%# Eval("SourceDatatype1") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox runat="server" ID="txtDataType1New" CssClass="form-control"></asp:TextBox>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Source Address2">
                                                <ItemTemplate>
                                                    <asp:TextBox runat="server" ID="txtSourceAdd2" Style="width: 80px; text-align: left" CssClass="textboxcss" Text='<%# Eval("SourceAdd2") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox runat="server" ID="txtSourceAdd2New" CssClass="form-control"></asp:TextBox>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Source Data Type2">
                                                <ItemTemplate>
                                                    <asp:TextBox runat="server" ID="txtDataType2" Style="width: 80px; text-align: left" CssClass="textboxcss" Text='<%# Eval("SourceDatatype2") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox runat="server" ID="txtDataType2New" CssClass="form-control"></asp:TextBox>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Polling Frequency">
                                                <ItemTemplate>
                                                    <asp:HiddenField runat="server" ID="hdnPollingFrequency" Value='<%# Eval("PollingFrequency") %>' ClientIDMode="Static" />
                                                    <asp:DropDownList ID="ddlPollingFrequency" runat="server" CssClass="textboxcss select form-control">
                                                        <asp:ListItem>0.5</asp:ListItem>
                                                    </asp:DropDownList>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:DropDownList ID="ddlPollingFrequencyNew" runat="server" CssClass="form-control">
                                                      <asp:ListItem>0.5</asp:ListItem>
                                                    </asp:DropDownList>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Data Group">
                                                <ItemTemplate>
                                                    <asp:HiddenField runat="server" ID="hdnDataGroup" Value='<%# Eval("DataGroup") %>' ClientIDMode="Static" />
                                                    <asp:DropDownList ID="ddlDataGroup" runat="server" CssClass="textboxcss select form-control" style="width:100px">
                                                        <asp:ListItem>Fixed Data</asp:ListItem>
                                                        <asp:ListItem>Custom PMC</asp:ListItem>
                                                        <asp:ListItem>Custom Macro</asp:ListItem>
                                                        <asp:ListItem>Alarm History</asp:ListItem>
                                                        <asp:ListItem>Operation History</asp:ListItem>
                                                        <asp:ListItem>Tool Life</asp:ListItem>
                                                          <asp:ListItem>Program Download</asp:ListItem>
                                                    </asp:DropDownList>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:DropDownList ID="ddlDataGroupNew" runat="server" CssClass="form-control" style="width:100px">
                                                        <asp:ListItem>Fixed Data</asp:ListItem>
                                                        <asp:ListItem>Custom PMC</asp:ListItem>
                                                        <asp:ListItem>Custom Macro</asp:ListItem>
                                                        <asp:ListItem>Alarm History</asp:ListItem>
                                                        <asp:ListItem>Operation History</asp:ListItem>
                                                        <asp:ListItem>Tool Life</asp:ListItem>
                                                          <asp:ListItem>Program Download</asp:ListItem>
                                                    </asp:DropDownList>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Polling Type">
                                                <ItemTemplate>
                                                    <asp:HiddenField runat="server" ID="hdnPollingType" Value='<%# Eval("PollingType") %>' ClientIDMode="Static" />
                                                    <asp:DropDownList ID="ddlPollingType" runat="server" CssClass="textboxcss select form-control" style="width:100px">
                                                        <asp:ListItem>Continious Reading</asp:ListItem>
                                                        <asp:ListItem>Within Cycle Reading</asp:ListItem>
                                                        <asp:ListItem>Read Based On Custom TimePeriod</asp:ListItem>
                                                    </asp:DropDownList>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:DropDownList ID="ddlPollingTypeNew" runat="server" CssClass="form-control" style="width:100px">
                                                        <asp:ListItem>Continious Reading</asp:ListItem>
                                                        <asp:ListItem>Within Cycle Reading</asp:ListItem>
                                                        <asp:ListItem>Read Based On Custom TimePeriod</asp:ListItem>
                                                    </asp:DropDownList>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Cycle Frequency Time">
                                                <ItemTemplate>
                                                    <asp:HiddenField runat="server" ID="hdnCycleFreqTime" Value='<%# Eval("CycleFreqTime") %>' ClientIDMode="Static" />
                                                    <asp:DropDownList ID="ddlCycleFrequencyTime" runat="server" CssClass="textboxcss select form-control">
                                                        <asp:ListItem>60 min.</asp:ListItem>
                                                    </asp:DropDownList>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:DropDownList ID="ddlCycleFrequencyTimeNew" runat="server" CssClass="form-control">
                                                        <asp:ListItem>60 min.</asp:ListItem>
                                                    </asp:DropDownList>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="No. of Cycles">
                                                <ItemTemplate>
                                                    <asp:HiddenField runat="server" ID="hdnNoOfCycle" Value='<%# Eval("NoOfCycle") %>' ClientIDMode="Static" />
                                                    <asp:DropDownList ID="ddlNoOfCycle" runat="server" CssClass="textboxcss select form-control">
                                                        <asp:ListItem>1</asp:ListItem>
                                                        <asp:ListItem>2</asp:ListItem>
                                                        <asp:ListItem>3</asp:ListItem>
                                                        <asp:ListItem>4</asp:ListItem>
                                                        <asp:ListItem>5</asp:ListItem>
                                                        <asp:ListItem>6</asp:ListItem>
                                                        <asp:ListItem>7</asp:ListItem>
                                                        <asp:ListItem>8</asp:ListItem>
                                                        <asp:ListItem>9</asp:ListItem>
                                                        <asp:ListItem>10</asp:ListItem>
                                                    </asp:DropDownList>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:DropDownList ID="ddlNoOfCycleNew" runat="server" CssClass="form-control">
                                                        <asp:ListItem>1</asp:ListItem>
                                                        <asp:ListItem>2</asp:ListItem>
                                                        <asp:ListItem>3</asp:ListItem>
                                                        <asp:ListItem>4</asp:ListItem>
                                                        <asp:ListItem>5</asp:ListItem>
                                                        <asp:ListItem>6</asp:ListItem>
                                                        <asp:ListItem>7</asp:ListItem>
                                                        <asp:ListItem>8</asp:ListItem>
                                                        <asp:ListItem>9</asp:ListItem>
                                                        <asp:ListItem>10</asp:ListItem>
                                                    </asp:DropDownList>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="IsEnabled?">
                                                <ItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chkIsEnabled" Checked='<%# Eval("IsEnabled") %>' />
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:CheckBox runat="server" ID="chkIsEnabledNew" />
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Should Not Be Disabled?">
                                                <ItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chkShouldNotBeDisabled" Checked='<%# Eval("ShouldNotBeDisabled") %>' />
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:CheckBox runat="server" ID="chkShouldNotBeDisabledNew" />
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                               <asp:TemplateField HeaderText="Is Enabled For Data Read?">
                                                <ItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chkIsEnabledForDataRead" Checked='<%# Eval("IsEnabledForDataRead") %>' />
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:CheckBox runat="server" ID="chkIsEnabledForDataReadNew" />
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Select">
                                                <ItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chkDeleteSelection" />
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:Button runat="server" ID="btnInsert" Text="Add" CssClass="Btns" />
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="listView">
                    </div>
                    <div class="cardView" style="display: none">
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        $(document).ready(function () {

            $("#menu0").addClass("in active");
            $("#activeMenu").val("#menu0");
            $("a[href$='#menu0']").removeClass("selected-menu-style").addClass("menu0-select");
            $("a[href$='#menu0']").closest('li').find('i').addClass("arrow up");
            $("#A14").addClass("in active");
            $("#activeMenu").val("#A14");
            $("a[href$='#A14']").removeClass("selected-menu-style").addClass("menu0-select");
            $("a[href$='#A14']").closest('li').find('i').addClass("arrow up");
        });
        $("[id$=gvMTBModeldata]").on("click", "td", function () {
            debugger;
            //$(this).closest('tr').find('input[type=hidden]').val("updated");
            var tblID = $(this).closest('table').prop('id');
            var tbl = document.getElementById(tblID);
            var tblRowCount = tbl.rows.length - 1;
            var currentTR = $(this).closest('tr');
            var currentClickRowIndex = $(currentTR).index();
            if (tblRowCount == currentClickRowIndex) {
                return;
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
        var menu = "#menu0";
        var submenu = "#A14";

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
