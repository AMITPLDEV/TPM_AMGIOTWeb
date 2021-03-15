<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProcessParameterGraphView.aspx.cs" Inherits="NewProject.ProcessParameterGraphView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="https://code.highcharts.com/stock/highstock.js"></script>
    <script src="https://code.highcharts.com/stock/modules/data.js"></script>
    <script src="https://code.highcharts.com/stock/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/stock/modules/export-data.js"></script>

    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/highcharts-3d.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/modules/export-data.js"></script>
    <script src="https://code.highcharts.com/modules/accessibility.js"></script>


       <%--  <script src="Scripts/Highcharts/highstock.js"></script>
    <script src="Scripts/Highcharts/highcharts.js"></script>
    <script src="Scripts/Highcharts/exporting.js"></script>
    <script src="Scripts/Highcharts/export-data.js"></script>
    <script src="Scripts/Highcharts/accessibility.js"></script>--%>
   
     <style>
        .outer-ul .removeHover:hover {
            background-color: unset;
        }

        /*.main-svg{
            background-color: black;
        }*/
        .graph-section {
            width: 100%;
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
        .light-mode .graph-div{
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
         .modal-body{
            background-color: #171e21;
        }
        .light-mode .modal-body{
          background-color:   #fff !important
        }
    </style>
    <div class="themetoggle">
        <table class="submenu-right-side" id="right-table">
            <tr>
              <%--   <td style="padding-top: 4px">
                              <asp:DropDownList runat="server" ID="ddlMachineID" ClientIDMode="Static" CssClass="form-control dropdown-list"></asp:DropDownList>
                 
                </td>--%>
            <%--    <td onmouseover="showPanelsTopRight(this,'panelExport','5px','40px');" onmouseout="hidePanels(this,'panelExport')">
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
                </td>
                <td onmouseover="showPanelsTopRight(this,'panelView','5px','40px');" onmouseout="hidePanels(this,'panelView')">
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
                <td onmouseover="showPanelFilter(this,'panelFilter','5px','40px', 'ulFilter');" onmouseout="hidePanels(this,'panelFilter')">
                    <i class="glyphicon glyphicon-filter" style="font-size: 17px;"></i>

                    <div class="panel panel-default panel-subitems" id="panelFilter" onmouseover="showPanelFilter(this,'panelFilter','5px','40px', 'ulFilter');" onmouseout="hidePanels(this,'panelFilter')" style="width: 250px;">
                        <div class="panel-body">
                            <div id="divgraphFilter">
                                <asp:CheckBoxList runat="server" ID="cbgraphFilter" ClientIDMode="Static" CssClass="checkbox-list">
                                    <asp:ListItem Value="Graph1" Text="Graph 1"></asp:ListItem>
                                    <asp:ListItem Value="Graph2" Text="Graph 2"></asp:ListItem>
                                    <asp:ListItem Value="Graph3" Text="Graph 3"></asp:ListItem>
                                </asp:CheckBoxList>

                                <asp:Button runat="server" ID="btnGraphThreeOK" ClientIDMode="Static" OnClientClick="return bindMultiSelectGraph();" CssClass="Btns" Style="margin-left: 20px" Text="OK" />
                            </div>
                        </div>
                    </div>
                </td>
                <td>
                    <i class="glyphicon glyphicon-filter" id="nextprev" onclick="shownextprev();" ></i>
                </td>
            </tr>
        </table>
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                   <div class="graph-section" id="graphthree" style="width: 100%; margin: auto">
                                <div id="msGraph1" style="margin-bottom: 20px;" class="box-shadow"></div>
                                <div id="msGraph2" style="margin-bottom: 20px;" class="box-shadow"></div>
                                <div id="msGraph3" style="margin-bottom: 20px;" class="box-shadow"></div>
                            </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    <%--  <div class="panel panel-default panel-subitems" id="zoomChartPanel" style="width: 1100px; top: 150px; left: 200px">
            <div class="panel-body">
                <i class="glyphicon glyphicon-remove" onmouseout="$('#zoomChartPanel').css('visibility', 'hidden');"></i>
                <div id="zoomChartContainer"></div>
            </div>
        </div>--%>

           <div class="modal fade" id="zoomChartPanel" role="dialog">
            <div class="modal-dialog  modal-dialog-centered" style="min-width: 1100px;box-shadow: rgba(85, 85, 85, 0.93) 3px 3px 8px 4px; border: 3px solid rgb(109, 109, 109)">
                <div class="modal-content" >
                    <div class="modal-body"  >
                        <i class="glyphicon glyphicon-remove" onmouseout="$('[id*=zoomChartPanel]').modal('hide')"></i>
                <div id="zoomChartContainer"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
        <script>
            $(document).ready(function () {
             $('#right-table').appendTo('#right-side-filters');
            let gh3 = $("[id*=cbgraphFilter] input")[0];
            $(gh3).prop('checked', true);
            bindMultiSelectGraph();
             
        });


        function bindMultiSelectGraph() {

            var checked_checkboxes = $("[id*=cbgraphFilter] input:checked");
            $("#msGraph1").empty();
            $("#msGraph2").empty();
            $("#msGraph3").empty();
            checked_checkboxes.each(function () {

                var value = $(this).val();
                if (value == "Graph1") {
                    Highcharts.chart('msGraph1', {
                        chart: {
                            zoomType: 'x'
                        },
                        credits: {
                            enabled: false
                        },
                        title: {
                            text: 'Graph 1',
                            className: 'highchart-title',
                            style: {
                                color: '#4f00ff',
                                fontSize: '20px'
                            }
                        },

                        //subtitle: {
                        //    text: 'Source: thesolarfoundation.com'
                        //},

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
                                //return `<span class="span-legend-active" style="border-color:${this.color}">${this.name}</span>`;
                                 return `<span class="span-legend-active">${this.name}</span>`;
                            }
                            //itemStyle: {
                            //    color: 'white',
                            //    // fontWeight: 'bold'
                            //}
                        },

                        plotOptions: {
                            series: {
                                label: {
                                    connectorAllowed: false
                                },
                                pointStart: 2010
                            }
                        },

                        series: [{
                            name: 'Installation1',
                            data: [43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175, 43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175, 43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175, 43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175, 43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175, 43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175, 43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175, 43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175, 43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175, 43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175, 43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175]
                        }],

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
                if (value == "Graph2") {

                    var data = [];
                    var type;
                    $.ajax({
                        async: false,
                        type: "POST",
                        url: '<%= ResolveUrl("ProcessParameterGraphView.aspx/getChartData") %>',
                        contentType: "application/json; charset=utf-8",
                        crossDomain: true,
                        // data: '{Independentparametervalue: "' + $(val).val() + '"}',
                        dataType: "json",
                        success: function (response) {
                            var dataitem = response.d;
                            if (dataitem != null || dataitem.length > 0) {
                                data = dataitem.data;
                                type = dataitem.type;
                                console.log(data);
                                console.log(type);
                            }
                        },
                        error: function (Result) {
                            alert("Error" + Result);
                        }
                    });

                    //  Highcharts.getJSON('https://cdn.jsdelivr.net/gh/highcharts/highcharts@v7.0.0/samples/data/usdeur.json', function (data) {

                    // Create the chart
                    Highcharts.stockChart('msGraph2', {

                        chart: {
                        },
                        credits: {
                            enabled: false
                        },
                        rangeSelector: {
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
                            text: 'Graph 2',
                            style: {
                                color: '#4f00ff',
                                fontSize: '20px'
                            }
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
                            className: 'highchart-xyaxis-label'
                        },
                        plotOptions: {
                            series: {
                                cursor: 'pointer',
                                point: {
                                    events: {
                                        click: function () {
                                            //  alert('Category: ' + this.category + ', value: ' + this.y);
                                            // alert(e.data.length);
                                            //let dataForZoom = [];
                                            let xvalue = this.category;
                                            let yvalue = this.y;
                                            //for (let i = 0; i < data.length; i++) {
                                            //    // for (let j = 0; j < 2; j++) {

                                            //    if (xvalue == data[i][0] && yvalue == data[i][1]) {
                                            //        let k = 0;
                                            //        for (let j = i; j < 7; j++) {
                                            //            //dataForZoom[k,0] = data[j][0];
                                            //            //dataForZoom[k,1] = data[j][1];
                                            //            //dataForZoom.push(data[j][0], data[j][1]);
                                            //            var serie = new Array(data[j][0], data[j][1]);
                                            //            dataForZoom.push(serie);
                                            //            k++;
                                            //        }
                                            //    }
                                            //    // }
                                            //}

                                            // console.log(dataForZoom);
                                            zoomOutChart(xvalue, yvalue);
                                            //alert(data[0][0]);
                                        }
                                    }
                                }
                            }
                        },
                        yAxis: {
                            title: {
                                // text: 'Exchange rate'
                            },
                            className: 'highchart-xyaxis-label'
                        },

                        series: [{
                            name: '',
                            data: data,
                            id: 'dataseries'

                            // the event marker flags
                        }, {
                            type: 'flags',
                            data: type,
                            onSeries: 'dataseries',
                            //shape: 'circlepin',
                            //width: 16
                            shape: 'squarepin',
                            width: 100
                        }]
                    });

                    //Highcharts.stockChart('msGraph2', {

                    //    chart: {
                    //        backgroundColor: '#171e21'
                    //    },
                    //    rangeSelector: {
                    //        selected: 1
                    //    },

                    //    title: {
                    //        text: 'Spindle Load'
                    //    },
                    //    xAxis: {
                    //        accessibility: {
                    //            // rangeDescription: 'Range: 2010 to 2017'
                    //        },
                    //        labels: {
                    //            style: {
                    //                color: 'white'
                    //            }
                    //        }
                    //    },
                    //    series: [{
                    //        name: 'AAPL Stock Price',
                    //        data: [43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175,43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175,43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175,43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175,43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175,43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175,43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175,43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175,43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175,43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175,43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175],
                    //        marker: {
                    //            enabled: true,
                    //            radius: 3
                    //        },
                    //        shadow: true,
                    //        tooltip: {
                    //            valueDecimals: 2
                    //        }
                    //    }]
                    //});
                    //Highcharts.chart('msGraph2', {
                    //    chart: {
                    //        backgroundColor: '#171e21'
                    //    },
                    //    title: {
                    //        text: 'Graph 2',
                    //        style: {
                    //            color: 'white',
                    //            fontSize: '20px'
                    //        }
                    //    },

                    //    //subtitle: {
                    //    //    text: 'Source: thesolarfoundation.com'
                    //    //},

                    //    yAxis: {
                    //        title: {
                    //            //text: 'Number of Employees'
                    //        },
                    //        labels: {
                    //            style: {
                    //                color: 'white'
                    //            }
                    //        }
                    //    },

                    //    xAxis: {
                    //        accessibility: {
                    //            // rangeDescription: 'Range: 2010 to 2017'
                    //        },
                    //        labels: {
                    //            style: {
                    //                color: 'white'
                    //            }
                    //        }
                    //    },

                    //    legend: {
                    //        layout: 'vertical',
                    //        align: 'right',
                    //        verticalAlign: 'middle',
                    //        itemStyle: {
                    //            color: 'white',
                    //            // fontWeight: 'bold'
                    //        }
                    //    },

                    //    plotOptions: {
                    //        series: {
                    //            label: {
                    //                connectorAllowed: false
                    //            },
                    //            pointStart: 2010
                    //        }
                    //    },

                    //    series: [{
                    //        name: 'Installation2',
                    //        data: [43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175]
                    //    }],

                    //    responsive: {
                    //        rules: [{
                    //            condition: {
                    //                maxWidth: 500
                    //            },
                    //            chartOptions: {
                    //                legend: {
                    //                    layout: 'horizontal',
                    //                    align: 'center',
                    //                    verticalAlign: 'bottom'
                    //                }
                    //            }
                    //        }]
                    //    }

                    //});
                }
                if (value == "Graph3") {
                    var data = [];
                    var type, plotLines;
                    $.ajax({
                        async: false,
                        type: "POST",
                        url: '<%= ResolveUrl("ProcessParameterGraphView.aspx/getChartData") %>',
                        contentType: "application/json; charset=utf-8",
                        crossDomain: true,
                        // data: '{Independentparametervalue: "' + $(val).val() + '"}',
                        dataType: "json",
                        success: function (response) {
                            var dataitem = response.d;
                            if (dataitem != null || dataitem.length > 0) {
                                data = dataitem.data;
                                type = dataitem.type;
                                plotLines = dataitem.plotLines;
                                console.log(data);
                                console.log(type);
                                console.log(plotLines);
                            }
                        },
                        error: function (Result) {
                            alert("Error" + Result);
                        }
                    });

                    //  Highcharts.getJSON('https://cdn.jsdelivr.net/gh/highcharts/highcharts@v7.0.0/samples/data/usdeur.json', function (data) {

                    // Create the chart
                    Highcharts.stockChart('msGraph3', {

                        chart: {
                          
                            //events: {
                            //    drilldown: function (e) {
                            //        alert();
                            //        let datalist = [];
                            //        //for (let i = 0; i < data.drilldown.length; i++) {
                            //        //    if ("VMC-17" == data.drilldown[i].id) {
                            //        //        let k = 0;
                            //        //        for (let j = 0; j < data.drilldown[i].data.length; j++) {
                            //        //            if (data.drilldown[i].data[j].y != 0) {
                            //        //                datalist[k] = data.drilldown[i].data[j].y;
                            //        //                k++;
                            //        //            }
                            //        //        }
                            //        //    }
                            //        //}
                            //        alert(e.seriesOptions.data.length);
                            //        //let k = 0;
                            //        //for (let i = 0; i < e.seriesOptions.data.length; i++) {
                            //        //    if (e.seriesOptions.data[i].y != 0) {
                            //        //        datalist[k] = e.seriesOptions.data[i].y;
                            //        //        k++;
                            //        //    }
                            //        //}

                            //    }
                            //}
                        },
                        credits: {
                            enabled: false
                        },
                        rangeSelector: {
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
                            text: 'Graph 3',
                             style: {
                                        color: '#4f00ff',
                                        fontSize: '20px'
                                    }
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
                            plotLines: plotLines
                        },
                        plotOptions: {
                            series: {
                                cursor: 'pointer',
                                point: {
                                    events: {
                                        click: function () {
                                            let xvalue = this.category;
                                            let yvalue = this.y;
                                            zoomOutChart(xvalue, yvalue);
                                        }
                                    }
                                }
                            }
                        },
                        yAxis: {
                            title: {
                                //  text: 'Exchange rate'
                            },
                           className: 'highchart-xyaxis-label'
                        },

                        series: [{
                            name: 'Value',
                            data: data,
                            id: 'dataseries'

                            // the event marker flags
                        }
                            , {
                            type: 'flags',
                            data: type,
                            onSeries: 'dataseries',
                            shape: 'squarepin',
                            width: 100
                        }
                        ]
                    });
                    // });

                    //    Highcharts.chart('msGraph3', {
                    //        chart: {
                    //            backgroundColor: '#171e21'
                    //        },
                    //        title: {
                    //            text: 'Graph 3',
                    //            style: {
                    //                color: 'white',
                    //                fontSize: '20px'
                    //            }
                    //        },

                    //        //subtitle: {
                    //        //    text: 'Source: thesolarfoundation.com'
                    //        //},

                    //        yAxis: {
                    //            title: {
                    //                //text: 'Number of Employees'
                    //            },
                    //            labels: {
                    //                style: {
                    //                    color: 'white'
                    //                }
                    //            }
                    //        },

                    //        xAxis: {
                    //            accessibility: {
                    //                // rangeDescription: 'Range: 2010 to 2017'
                    //            },
                    //            labels: {
                    //                style: {
                    //                    color: 'white'
                    //                }
                    //            }
                    //        },

                    //        legend: {
                    //            layout: 'vertical',
                    //            align: 'right',
                    //            verticalAlign: 'middle',
                    //            itemStyle: {
                    //                color: 'white',
                    //                // fontWeight: 'bold'
                    //            }
                    //        },

                    //        plotOptions: {
                    //            series: {
                    //                label: {
                    //                    connectorAllowed: false
                    //                },
                    //                pointStart: 2010
                    //            }
                    //        },

                    //        series: [{
                    //            name: 'Installation3',
                    //            data: [43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175]
                    //        }],

                    //        responsive: {
                    //            rules: [{
                    //                condition: {
                    //                    maxWidth: 500
                    //                },
                    //                chartOptions: {
                    //                    legend: {
                    //                        layout: 'horizontal',
                    //                        align: 'center',
                    //                        verticalAlign: 'bottom'
                    //                    }
                    //                }
                    //            }]
                    //        }

                    //    });
                }
                //var text = $(this).closest("td").find("label").html();
                //message += "Text: " + text + " Value: " + value;
                //message += "\n";
            });
            return false;
        }
        function zoomOutChart(xvalue, yvalue) {
            var dataitem;
            $.ajax({
                async: false,
                type: "POST",
                url: '<%= ResolveUrl("ProcessParameterGraphView.aspx/getzoomChartData") %>',
                contentType: "application/json; charset=utf-8",
                crossDomain: true,
                data: '{xvalue: "' + xvalue + '",yvalue: "' + yvalue + '" }',
                dataType: "json",
                success: function (response) {
                    dataitem = response.d;
                    //if (dataitem != null || dataitem.length > 0) {
                    //    data = dataitem.data;
                    //    type = dataitem.type;
                    //}
                },
                error: function (Result) {
                    alert("Error" + Result);
                }
            });
           // document.getElementById('zoomChartPanel').style.visibility = "visible";
            $('[id*=zoomChartPanel]').modal('show');
            Highcharts.stockChart('zoomChartContainer', {
                chart: {
                   
                },
                credits: {
                    enabled: false
                },
                navigator: {
                    enabled: false
                },
                rangeSelector: {
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
                    plotLines: dataitem.plotLines
                },

                yAxis: {
                    title: {
                        // text: 'Exchange rate'
                    },
                   className: 'highchart-xyaxis-label'
                },

                series: [{
                    name: '',
                    data: dataitem.data,
                    id: 'dataseries'

                    // the event marker flags
                }
                    , {
                    type: 'flags',
                    data: dataitem.type,
                    onSeries: 'dataseries',
                    //shape: 'circlepin',
                    //width: 16
                    shape: 'squarepin',
                    width: 100
                }
                ]
            });
        }

        function showPanelFilter(element, panelid, rightvalue, topvalue, ulid) {
                $("#divgraphFilter").css('display', 'block');
                document.getElementById(panelid).style.visibility = "visible";
                $("#" + panelid).css({ 'right': rightvalue, 'top': topvalue });
        }
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
            $(document).ready(function () {
                bindMultiSelectGraph();
            });
          
            function showPanelFilter(element, panelid, rightvalue, topvalue, ulid) {
                $("#divgraphFilter").css('display', 'block');
                document.getElementById(panelid).style.visibility = "visible";
                $("#" + panelid).css({ 'right': rightvalue, 'top': topvalue });
            }
        });
    </script>
</asp:Content>
