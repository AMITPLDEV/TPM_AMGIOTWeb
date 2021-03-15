<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AlarmHistory.aspx.cs" Inherits="NewProject.AlarmHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        progress {
            border: none;
            width: 150px;
            height: 60px;
            background: red;
            border: 2px solid #da0a0a;
            background: -webkit-linear-gradient(top, #aaa 0,#000 40%, #555 100%);
            -webkit-box-shadow: inset 0 -1em 0 0.2em rgba(0,0,0,.55);
            vertical-align: middle;
            height: 34px;
        }

        progress {
            color: green;
        }

            progress::-webkit-progress-value {
                background: -webkit-linear-gradient(top, #60eb60 0,#27cc27 40%, #08f10f 100%);
                -webkit-box-shadow: inset 0 -1em 0 0.2em rgb(20 64 27 / 55%);
            }

            progress::-moz-progress-bar {
                background: -webkit-linear-gradient(top, #f11515 0,#f91515 40%, #eb1414 100%);
                -webkit-box-shadow: inset 0 -1em 0 0.2em rgb(196 27 27 / 55%);
            }

            progress::-webkit-progress-value {
                background: -webkit-linear-gradient(top, #60eb60 0,#27cc27 40%, #08f10f 100%);
                -webkit-box-shadow: inset 0 -1em 0 0.2em rgb(20 64 27 / 55%);
            }

            progress::-webkit-progress-bar {
                background: -webkit-linear-gradient(top, #f11515 0,#f91515 40%, #eb1414 100%);
                -webkit-box-shadow: inset 0 -1em 0 0.2em rgb(196 27 27 / 55%);
            }

        .submenu-right-side tr td {
            padding: 0px 20px;
        }

        .P1Table {
            width: 99.8%;
        }

        .docDiv {
            border:1px solid silver;
        }
        .light-mode .docDiv {
            border:1px solid #a6adac;
        }

        .zoomBtn {
            font-size: 20px;
        }
        .carouselCss img{
            width:100%;
            height:100% !important;
        }
        .carouselCss .item {
            width:100%;
            height:100%;
            border:1px solid silver;
        }
       
        #zoomDocContainer .panel-body {
            background: #171e21;
            border: 1px solid silver;
            border-radius: 10px;
           
        }
        .light-mode #zoomDocContainer .panel-body {
            background: white;
            border:1px solid #171e21;
        }
        
        /*#zoomDocContainer {
            top: -50%; 
            transition: all 4s ease-in-out; 
        }
            #zoomDocContainer.show {
                visibility: visible !important;
                z-index: 200;
                opacity: 1;
                top: 50%; 
            }*/
    </style>
    <div class="themetoggle">
        <asp:HiddenField runat="server" ID="hdnCurrentDoc" ClientIDMode="Static" />
        <asp:HiddenField runat="server" ID="hdnScrollPos" ClientIDMode="Static" />
        <asp:HiddenField runat="server" ID="hdnAlarmNo" ClientIDMode="Static" />
        <table class="submenu-right-side" id="right-table" style="position: relative; top: -2px">
            <tr>
                <td>
                    <asp:DropDownList runat="server" ID="ddlCompany" CssClass="dropdown-list form-control" ClientIDMode="Static"></asp:DropDownList>
                </td>
                <td>
                    <asp:DropDownList runat="server" ID="ddlPlant" CssClass="dropdown-list form-control" ClientIDMode="Static"></asp:DropDownList>
                </td>
                <td>
                    <asp:DropDownList runat="server" ID="ddlMachine" CssClass="dropdown-list form-control" ClientIDMode="Static"></asp:DropDownList>
                </td>
            </tr>
        </table>

        <div style="" id="alarmContainer">
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <div class="navbar-collapse collapse" style="height: 42px !important;">
                        <ul class="nav navbar-nav nextPrevious submenus-style ">
                            <li><a runat="server" class="submenuData" clientidmode="static" data-toggle="tab" href="#alarmCNCMenu">CNC Alarm</a>
                                <i></i>
                            </li>
                            <li><a runat="server" class="submenuData" clientidmode="static" data-toggle="tab" href="#alarmPreventiveMenu">Preventive Alarm</a>
                                <i></i>
                            </li>

                            <li><a runat="server" class="submenuData" clientidmode="static" data-toggle="tab" href="#alarmPredictiveMenu">Predictive Alarm</a>
                                <i></i>
                            </li>
                        </ul>
                        <div style="float: right"><i class="glyphicon glyphicon-zoom-in zoomBtn" onclick="docZoomOut();" id="btnZoomOut"></i></div>
                    </div>
                 
                    <div class="tab-content themetoggle" id="processParamContainer" style="overflow: auto; width: 100%; margin: -10px auto; margin-top: 10px">
                        <div id="alarmCNCMenu" class="tab-pane fade">
                            <div class="row">
                                <div class="col-lg-5 col-md-5 col-sm-5">
                                    <div id="cncAlarmContainer" style="height: 82vh; overflow: auto">
                                    </div>
                                </div>
                                <div class="col-lg-7 col-md-7 col-sm-7">
                                    <div class="docContainer">
                                        <div class="docDiv" style="height: 60%; overflow: auto; ">
                                            <iframe id="cncIframeDoc" style="width: 100%; height: 100%; display: none"></iframe>
                                            <video id="cncVideo" autoplay='autoplay' controls style="width: 100%; height: 100%; display: none">
                                                <source />
                                            </video>
                                            <img id="cncImage" src="" style="width: 100%; height: 100%; display: none" />
                                            <%--<div id="cncMultiDoc" class="carousel slide" data-ride="carousel" style="width: 600px; height: 300px; display: none"></div>--%>
                                            <div id="cncCarousel" class="carousel slide carouselCss" data-ride="carousel" data-interval="3000" style="width: 100%; height: 100%;">
                                                <ol class="carousel-indicators" id="cncCarouselIndicators"></ol>
                                                <div class="carousel-inner" role="listbox" id="cncCarouselImages" style="width: 100%; height: 100%;">
                                                </div>

                                                <a class="left carousel-control" href="#cncCarousel" role="button" data-slide="prev">
                                                    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                                                    <span class="sr-only">Previous</span>
                                                </a>
                                                <a class="right carousel-control" href="#cncCarousel" role="button" data-slide="next">
                                                    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                                                    <span class="sr-only">Next</span>
                                                </a>
                                            </div>
                                        </div>
                                        <div id="cncAlarmSolnContainer" style="height: 40%; overflow: auto; margin-top: 10px">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div id="alarmPreventiveMenu" class="tab-pane fade">
                            <div class="row">
                                <div class="col-lg-5 col-md-5 col-sm-5">
                                    <div id="preventiveAlarmContainer" style="height: 82vh; overflow: auto">
                                    </div>
                                </div>
                                <div class="col-lg-7 col-md-7 col-sm-7">
                                    <div class="docContainer docDiv" style="overflow: auto; ">
                                        <iframe id="preventiveIframeDoc" style="width: 100%; height: 100%; display: none"></iframe>
                                        <video id="preventiveVideo" autoplay='autoplay' controls style="width: 100%; height: 100%; display: none">
                                            <source />
                                        </video>
                                        <img id="preventiveImage" src="" style="width: 100%; height: 100%; display: none" />
                                        <div id="preventiveCarousel" class="carousel slide carouselCss" data-ride="carousel" data-interval="3000" style="width: 100%; height: 100%;">
                                            <ol class="carousel-indicators" id="preventiveCarouselIndicators"></ol>
                                            <div class="carousel-inner" role="listbox" id="preventiveCarouselImages" style="width: 100%; height: 100%;">
                                            </div>

                                            <a class="left carousel-control" href="#preventiveCarousel" role="button" data-slide="prev">
                                                <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                                                <span class="sr-only">Previous</span>
                                            </a>
                                            <a class="right carousel-control" href="#preventiveCarousel" role="button" data-slide="next">
                                                <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                                                <span class="sr-only">Next</span>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div id="alarmPredictiveMenu" class="tab-pane fade">
                            <div class="row">
                                <div class="col-lg-5 col-md-5 col-sm-5">
                                    <div id="predictiveAlarmContainer" style="height: 82vh; overflow: auto">
                                    </div>
                                </div>
                                <div class="col-lg-7 col-md-7 col-sm-7">
                                    <div class="docContainer docDiv" style="overflow: auto;">
                                        <iframe id="predictiveIframeDoc" style="width: 100%; height: 100%; display: none"></iframe>
                                        <video id="predictiveVideo" autoplay='autoplay' controls style="width: 100%; height: 100%; display: none">
                                            <source />
                                        </video>
                                        <img id="predictiveImage" src="" style="width: 100%; height: 100%; display: none" />
                                        <div id="predictiveCarousel" class="carousel slide carouselCss" data-ride="carousel" data-interval="3000" style="width: 100%; height: 100%;">
                                            <ol class="carousel-indicators" id="predictiveCarouselIndicators"></ol>
                                            <div class="carousel-inner" role="listbox" id="predictiveCarouselImages" style="width: 100%; height: 100%;">
                                            </div>

                                            <a class="left carousel-control" href="#predictiveCarousel" role="button" data-slide="prev">
                                                <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                                                <span class="sr-only">Previous</span>
                                            </a>
                                            <a class="right carousel-control" href="#predictiveCarousel" role="button" data-slide="next">
                                                <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                                                <span class="sr-only">Next</span>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div class="panel-group" style="display: none" id="zoomDocContainer">
            <div class="panel panel-default">
                <div class="panel-body" style="height: 80vh">
                    <div style="text-align: right"><i class="glyphicon glyphicon-remove" id="closeZoomDoc" style="position: relative; right: 0px; margin-bottom: 10px;"></i></div>

                    <div style="height: 95%; overflow: auto">
                        <iframe id="zoomIframeDoc" style="width: 100%; height: 100%; display: none"></iframe>
                        <video id="zoomVideo" autoplay='autoplay' controls style="width: 100%; height: 100%; display: none">
                            <source />
                        </video>
                        <img id="zoomImage" src="" style="width: 100%; height: 95%; display: none" />
                        <div id="zoomCarousel" class="carousel slide carouselCss" data-ride="carousel" data-interval="3000" style="width: 100%; height: 100%;">
                            <ol class="carousel-indicators" id="zoomCarouselIndicators"></ol>
                            <div class="carousel-inner" role="listbox" id="zoomCarouselImages" style="width: 100%; height: 100%;">
                            </div>

                            <a class="left carousel-control" href="#zoomCarousel" role="button" data-slide="prev">
                                <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                                <span class="sr-only">Previous</span>
                            </a>
                            <a class="right carousel-control" href="#zoomCarousel" role="button" data-slide="next">
                                <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                                <span class="sr-only">Next</span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    

    <script>
        var CompanyID = "", PlantID = "", MachineID = "", AlarmNo = "";
        var submenu = "";
        $(document).ready(function () {
            $('#right-table').appendTo('#right-side-filters');
            if (localStorage.getItem("selectedAlarmSubMenu")) {
                debugger;
                submenu = localStorage.getItem("selectedAlarmSubMenu");
            }
            $(submenu).addClass("in active");
            $("a[href$='" + submenu + "']").removeClass("selected-menu-style").addClass("selected-Submenu");
            $("a[href$='" + submenu + "']").closest('li').find('i').addClass("arrow up selected-Submenu-ArrowUp");
            setGridHeight();
            clearDocuments();
            BindCompanyData();
            // BindCNCAlarmDetails();
        });
        function docZoomOut() {
          //  $('#zoomDocContainer panel-body').css("height", "0px");
           $('#zoomDocContainer').css("display", "block");
            $('#alarmContainer').css("display", "none");
          //    $('#zoomDocContainer panel-body').css("height", "80vh");
          //  $('#zoomDocContainer').css("transition","all 3s ease-in-out");

           // $('#zoomDocContainer').addClass("show");
        }
        $('#closeZoomDoc').click(function () {
            $('#zoomDocContainer').css("display", "none");
            $('#alarmContainer').css("display", "block");
        });
        function BindCompanyData() {
            $.ajax({
                async: false,
                type: "POST",
                url: "AlarmHistory.aspx/getCompanyDetails",
                contentType: "application/json; charset=utf-8",
                datatype: "json",
                success: function (response) {
                    var itemdata = response.d;
                    debugger;
                    $('#ddlCompany').empty();
                    if (itemdata.length > 0) {
                        var appendStr = "";
                        for (let i = 0; i < itemdata.length; i++) {
                            appendStr += '<option>' + itemdata[i] + '</option>';
                        }
                        $('#ddlCompany').append(appendStr);
                    }
                    BindPlantData();
                },
                error: function (jqXHR, textStatus, err) {
                    console.log(err);
                }
            });

        }
        function BindPlantData() {
            CompanyID = $('#ddlCompany').val();
            $.ajax({
                async: false,
                type: "POST",
                url: "AlarmHistory.aspx/getPlantDetails",
                contentType: "application/json; charset=utf-8",
                data: '{company:"' + CompanyID + '"}',
                datatype: "json",
                success: function (response) {
                    var itemdata = response.d;
                    debugger;
                    $('#ddlPlant').empty();
                    if (itemdata.length > 0) {
                        var appendStr = "";
                        for (let i = 0; i < itemdata.length; i++) {
                            appendStr += '<option>' + itemdata[i] + '</option>';
                        }
                        $('#ddlPlant').append(appendStr);
                    }
                    BindMachineData();
                },
                error: function (jqXHR, textStatus, err) {
                    console.log(err);
                }
            });
        }
        function BindMachineData() {
            PlantID = $('#ddlPlant').val();
            clearDocuments();
            $.ajax({
                async: false,
                type: "POST",
                url: "AlarmHistory.aspx/getMachineDetial",
                contentType: "application/json; charset=utf-8",
                data: '{company:"' + CompanyID + '",plant:"' + PlantID + '"}',
                datatype: "json",
                success: function (response) {
                    var itemdata = response.d;
                    debugger;
                    $('#ddlMachine').empty();
                    if (itemdata.length > 0) {
                        var appendStr = "";
                        for (let i = 0; i < itemdata.length; i++) {
                            appendStr += '<option>' + itemdata[i] + '</option>';
                        }
                        $('#ddlMachine').append(appendStr);
                    }
                    MachineID = $('#ddlMachine').val();
                    if (submenu == "#alarmPreventiveMenu") {
                        BindPreventiveAlarmDetails();
                    }
                    else if (submenu == "#alarmPredictiveMenu") {
                        BindPredictiveAlarmDetails();
                    }
                    else {
                        BindCNCAlarmDetails();
                    }
                },
                error: function (jqXHR, textStatus, err) {
                    console.log(err);
                }
            });
        }
        $('#ddlCompany').change(function () {
            BindPlantData();
        });
        $('#ddlPlant').change(function () {
            BindMachineData();
        });
        function BindCNCAlarmDetails() {
            $.ajax({
                async: false,
                type: "POST",
                url: "AlarmHistory.aspx/getCNCAlarmDetails",
                contentType: "application/json; charset=utf-8",
                data: '{company:"' + CompanyID + '",plant:"' + PlantID + '",machine:"' + MachineID + '"}',
                datatype: "json",
                success: function (response) {
                    var itemdata = response.d;
                    $('#cncAlarmContainer').empty();
                    var appendStr = "<table class='P1Table'><tr><th>Alarm No.</th><th>Message</th><th>Last Seen</th><th>No, of Occurences</th></tr>";
                    if (itemdata.length > 0) {

                        for (var i = 0; i < itemdata.length; i++) {
                            appendStr += '<tr><td>' + itemdata[i].AlarmNo + '<input type="hidden" id="hdnAlarmNo" value="' + itemdata[i].AlarmNo + '" /> </td><td>' + itemdata[i].Message + '</td><td>' + itemdata[i].LastSeen + '</td><td>' + itemdata[i].NoOfOccurences + '</td></tr>';
                        }
                    }
                    else {
                        appendStr += '<tr><td colspan="4">No Data Found.</td></tr>';
                    }
                    $('#cncAlarmContainer').append(appendStr);
                },
                error: function (jqXHR, textStatus, err) {
                    console.log(err);
                }
            });
        }
        $('#cncAlarmContainer').on('click', 'table tr', function () {
            $('#cncAlarmContainer  table tr').css("background-color", "unset");
            $(this).css("background-color", "#21ada4");
            debugger;
            var alarmNo = $(this).find("#hdnAlarmNo").val();
            //var iframeID = "cncIframeDoc"; var videoID = "cncVideo"; var imageID = "cncImage";
            //$('#' + iframeID).css("display", "none");
            //$('#' + videoID).css("display", "none");
            //$('#' + imageID).css("display", "none");
            //$('#' + videoID + ' source').attr('src', '');
            //$("#" + videoID)[0].load();
            //$('#' + imageID).attr('src', '');
            //$('#' + iframeID).attr("src", "");
            clearDocuments();
            BindCNCAlarmSoutionData(alarmNo);

        });
        function BindCNCAlarmSoutionData(alarmNo) {

            $.ajax({
                async: false,
                type: "POST",
                url: "AlarmHistory.aspx/getCNCAlarmSolutionDetails",
                contentType: "application/json; charset=utf-8",
                data: '{company:"' + CompanyID + '",plant:"' + PlantID + '",machine:"' + MachineID + '",alarmNum:"' + alarmNo + '"}',
                datatype: "json",
                success: function (response) {
                    var itemdata = response.d;
                    $('#cncAlarmSolnContainer').empty();
                    var appendStr = "<table class='P1Table'><tr><th>Sl No.</th><th>Alarm Cause</th><th>Alarm Solution</th></tr>";
                    var firstRowAlarmNum = "";
                    if (itemdata.length > 0) {
                        for (var i = 0; i < itemdata.length; i++) {
                            debugger;
                            if (i == 0) {
                                firstRowAlarmNum = itemdata[i].AlarmNo;
                            }
                            appendStr += '<tr><td>' + itemdata[i].SlNo + '<input type="hidden" id="hdnAlarmNo" value="' + itemdata[i].AlarmNo + '" /> </td><td><span id="lblCNCCause">' + itemdata[i].AlarmCause + '</span></td><td><span id="lblCNCSoln">' + itemdata[i].AlarmSolution + '</span></td></tr>';
                        }

                    }
                    else {
                        appendStr += '<tr><td colspan="3">No Data Found.</td></tr>';
                    }
                    $('#cncAlarmSolnContainer').append(appendStr);
                    if (firstRowAlarmNum != "") {
                        $('#cncAlarmSolnContainer  table tr').css("background-color", "unset");
                        var tr = $('#cncAlarmSolnContainer  table tr')[1];
                        $(tr).css("background-color", "#21ada4");
                        let cause = $(tr).find("#lblCNCCause").text();
                        let soln = $(tr).find("#lblCNCSoln").text();
                        showFileDetails(firstRowAlarmNum, "CNCAndPreventiveAlarmMaster", "cncIframeDoc", "cncVideo", "cncImage", "cncCarousel", cause, soln);
                    }
                },
                error: function (jqXHR, textStatus, err) {
                    console.log(err);
                }
            });
        }
        $('#cncAlarmSolnContainer').on('click', 'table tr', function () {
            $('#cncAlarmSolnContainer  table tr').css("background-color", "unset");
            $(this).css("background-color", "#21ada4");
            debugger;
            var alarmNo = $(this).find("#hdnAlarmNo").val();
            let cause = $(this).find("#lblCNCCause").text();
            let soln = $(this).find("#lblCNCSoln").text();
            showFileDetails(alarmNo, "CNCAndPreventiveAlarmMaster", "cncIframeDoc", "cncVideo", "cncImage", "cncCarousel", cause, soln);
        });
        function showFileDetails(alarmNumber, collectionname, iframeID, videoID, imageID, carouselID,cause,solution) {
            debugger;
            $.blockUI({ message: '<img runat="server" src="Images/Loading.gif" />' });
            $.ajax({
                async: false,
                type: "POST",
                url: "AlarmHistory.aspx/getFileInformation",
                contentType: "application/json; charset=utf-8",
                data: '{alarmNo:"' + alarmNumber + '",colName:"' + collectionname + '",machineid:"' + MachineID + '",company:"' + CompanyID + '",plant:"' + PlantID + '",cncCause:"' + cause + '",cncSolution:"' + solution + '"}',
                datatype: "json",
                success: function (response) {
                    var itemdata = response.d;
                    $('#hdnCurrentDoc').val("");
                    //$('#cncMultiDoc').css("display", "none");
                    //$('#' + iframeID).css("display", "none");
                    //$('#' + videoID).css("display", "none");
                    //$('#' + imageID).css("display", "none");
                    //$('#' + videoID + ' source').attr('src', '');
                    //$("#" + videoID)[0].load();
                    //$('#' + imageID).attr('src', '');
                    //$('#' + iframeID).attr("src", "");
                    clearDocuments();
                    if (itemdata.length == 1) {
                        var docInfo = itemdata[0];
                        if (docInfo.FileInBase64 != "") {
                            var fileType = docInfo.FileType;
                            $('#hdnCurrentDoc').val(fileType);
                            if (fileType == "video") {
                                $('#' + videoID).css("display", "block");
                                $('#' + videoID + ' source').attr('src', "data:video/mp4;base64," + docInfo.FileInBase64);
                                $("#" + videoID)[0].load();

                                $('#zoomVideo').css("display", "block");
                                $('#zoomVideo source').attr('src', "data:video/mp4;base64," + docInfo.FileInBase64);
                                // $("#" + videoID)[0].load();
                                $('#btnZoomOut').css("display", "block");
                            }
                            else if (fileType == "image") {
                                $('#' + imageID).css("display", "block");
                                $('#' + imageID).attr('src', "data:image/png;base64," + docInfo.FileInBase64);

                                $('#zoomImage').css("display", "block");
                                $('#zoomImage').attr('src', "data:image/png;base64," + docInfo.FileInBase64);
                                $('#btnZoomOut').css("display", "block");
                            }
                            else if (fileType == "pdf") {
                                $('#' + iframeID).css("display", "block");
                                var arrrayBuffer = base64ToArrayBuffer(docInfo.FileInBase64); //data is the base64 encoded string
                                var blob = new Blob([arrrayBuffer], { type: "application/pdf" });
                                var link = window.URL.createObjectURL(blob);
                                $('#' + iframeID).attr("src", link + "#toolbar=0");

                                $('#zoomIframeDoc').css("display", "block");
                                $('#zoomIframeDoc').attr("src", link + "#toolbar=0");
                                $('#btnZoomOut').css("display", "block");
                            }
                            else if (fileType == "excel") {

                                var linkSource = 'data:application/vnd.ms-excel;base64,' + docInfo.FileInBase64;
                                var downloadLink = document.createElement("a");
                                var fileName = $(evt).closest('tr').find('#hdnFileName').val();
                                downloadLink.href = linkSource;
                                downloadLink.download = fileName;
                                downloadLink.click();
                            }
                            else {
                                debugger;
                                $('#' + iframeID).css("display", "block");
                                var arrrayBuffer = base64ToArrayBuffer(docInfo.FileInBase64); //data is the base64 encoded string
                                var blob = new Blob([arrrayBuffer], { type: "application/" + docInfo.FileExtension });
                                // var blob = new Blob([arrrayBuffer], { type: "application/vnd.ms-excel" });
                                var link = window.URL.createObjectURL(blob);
                                $('#' + iframeID).attr("src", link + "#toolbar=0");

                                $('#zoomIframeDoc').css("display", "block");
                                $('#zoomIframeDoc').attr("src", link + "#toolbar=0");
                                $('#btnZoomOut').css("display", "block");
                            }
                        }
                    }
                    else if (itemdata.length > 1) {
                        $('#' + carouselID).css("display", "block");
                         $('#zoomCarousel').css("display", "block");
                        //$('#cncMultiDoc').empty();
                        //var ulString = '<ol class="carousel-indicators" style="visibility:hidden">';
                        //var divString = '<div class="carousel-inner" role="listbox">';
                        //var imageCount = 0;
                        //for (var i = 0; i < itemdata.length; i++) {
                        //    if (itemdata[i].FileType == "image") {
                        //        if (imageCount == 0) {
                        //            ulString += '<li data-target="#cncMultiDoc" data-slide-to="' + i + '" class="active"></li>';
                        //            divString += '<div class="item active"><img src="data:image/png;base64,' + itemdata[i].FileInBase64 + '"></div>';
                        //            imageCount++;
                        //        }
                        //        else {
                        //            ulString += '<li data-target="#cncMultiDoc" data-slide-to="' + i + '"></li>';
                        //            divString += '<div class="item"><img src="data:image/png;base64,' + itemdata[i].FileInBase64 + '"></div>';
                        //        }
                        //    }
                        //}
                        //debugger;
                        //ulString += '</ol>';
                        //divString += '</div>';
                        //var arrowString = '<a class="left carousel-control" href="#cncMultiDoc" data-slide="prev" role="button" ><span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span><span class="sr-only">Previous</span</a> <a class="right carousel-control" href="#cncMultiDoc" data-slide="next" role="button" ><span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span><span class="sr-only">Next</span></a>';
                        //var finalString = ulString + divString + arrowString;
                        //$('#cncMultiDoc').append(finalString);



                        //  $('#cncMultiDoc').empty();
                        $('#' + carouselID + 'Indicators').empty();
                        $('#' + carouselID + 'Images').empty();
                        $('#zoomCarouselIndicators').empty();
                        $('#zoomCarouselImages').empty();
                        var ulString = '';
                        var divString = '';
                        var imageCount = 0;
                        for (var i = 0; i < itemdata.length; i++) {
                            if (itemdata[i].FileType == "image") {
                                if (imageCount == 0) {
                                    ulString += '<li data-target="#' + carouselID + '" data-slide-to="' + i + '" class="active"></li>';
                                    divString += '<div class="item active"><img src="data:image/png;base64,' + itemdata[i].FileInBase64 + '"></div>';
                                    imageCount++;
                                }
                                else {
                                    ulString += '<li data-target="#' + carouselID + '" data-slide-to="' + i + '"></li>';
                                    divString += '<div class="item"><img src="data:image/png;base64,' + itemdata[i].FileInBase64 + '"></div>';
                                }
                            }
                        }
                        $('#' + carouselID + 'Indicators').append(ulString);
                        $('#' + carouselID + 'Images').append(divString);
                        $("#" + carouselID).carousel("cycle");
                        $('#zoomCarouselIndicators').append(ulString);
                        $('#zoomCarouselImages').append(divString);
                        $("#zoomCarousel").carousel("cycle");
                        if (imageCount > 0) {
                            $('#btnZoomOut').css("display", "block");
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
        function clearDocuments() {
            $('#btnZoomOut').css("display", "none");

            var iframeID = "cncIframeDoc"; var videoID = "cncVideo"; var imageID = "cncImage"; var carouselID = "cncCarousel";
            $('#' + carouselID).css("display", "none");
            $("#" + carouselID).carousel("pause");
            $('#' + iframeID).css("display", "none");
            $('#' + videoID).css("display", "none");
            $('#' + imageID).css("display", "none");
            $('#' + videoID + ' source').attr('src', '');
            $("#" + videoID)[0].load();
            $('#' + imageID).attr('src', '');
            $('#' + iframeID).attr("src", "");

            iframeID = "preventiveIframeDoc"; videoID = "preventiveVideo"; imageID = "preventiveImage"; carouselID = "preventiveCarousel";
            $('#' + carouselID).css("display", "none");
            $("#" + carouselID).carousel("pause");
            $('#' + iframeID).css("display", "none");
            $('#' + videoID).css("display", "none");
            $('#' + imageID).css("display", "none");
            $('#' + videoID + ' source').attr('src', '');
            $("#" + videoID)[0].load();
            $('#' + imageID).attr('src', '');
            $('#' + iframeID).attr("src", "");

            iframeID = "predictiveIframeDoc"; videoID = "predictiveVideo"; imageID = "predictiveImage"; carouselID = "predictiveCarousel";
            $('#' + carouselID).css("display", "none");
            $("#" + carouselID).carousel("pause");
            $('#' + iframeID).css("display", "none");
            $('#' + videoID).css("display", "none");
            $('#' + imageID).css("display", "none");
            $('#' + videoID + ' source').attr('src', '');
            $("#" + videoID)[0].load();
            $('#' + imageID).attr('src', '');
            $('#' + iframeID).attr("src", "");

            iframeID = "zoomIframeDoc"; videoID = "zoomVideo"; imageID = "zoomImage"; carouselID = "zoomCarousel";
            $('#' + carouselID).css("display", "none");
            $("#" + carouselID).carousel("pause");
            $('#' + iframeID).css("display", "none");
            $('#' + videoID).css("display", "none");
            $('#' + imageID).css("display", "none");
            $('#' + videoID + ' source').attr('src', '');
            $("#" + videoID)[0].load();
            $('#' + imageID).attr('src', '');
            $('#' + iframeID).attr("src", "");
        }
        function BindPreventiveAlarmDetails() {
            $.ajax({
                async: false,
                type: "POST",
                url: "AlarmHistory.aspx/getPreventiveAlarmDetails",
                contentType: "application/json; charset=utf-8",
                data: '{company:"' + CompanyID + '",plant:"' + PlantID + '",machine:"' + MachineID + '"}',
                datatype: "json",
                success: function (response) {
                    var itemdata = response.d;
                    $('#preventiveAlarmContainer').empty();
                    var appendStr = "<table class='P1Table'><tr><th>Alarm No.</th><th>Message</th><th>Last Seen</th><th>No, of Occurences</th></tr>";
                    if (itemdata.length > 0) {

                        for (var i = 0; i < itemdata.length; i++) {
                            appendStr += '<tr><td>' + itemdata[i].AlarmNo + '<input type="hidden" id="hdnAlarmNo" value="' + itemdata[i].AlarmNo + '" /> </td><td>' + itemdata[i].Message + '</td><td>' + itemdata[i].LastSeen + '</td><td>' + itemdata[i].NoOfOccurences + '</td></tr>';
                        }
                    }
                    else {
                        appendStr += '<tr><td colspan="4">No Data Found.</td></tr>';
                    }
                    $('#preventiveAlarmContainer').append(appendStr);
                },
                error: function (jqXHR, textStatus, err) {
                    console.log(err);
                }
            });
        }
        $('#preventiveAlarmContainer').on('click', 'table tr', function () {
            $('#preventiveAlarmContainer  table tr').css("background-color", "unset");
            $(this).css("background-color", "#21ada4");
            debugger;
            var alarmNo = $(this).find("#hdnAlarmNo").val();
            showFileDetails(alarmNo, "CNCAndPreventiveAlarmMaster", "preventiveIframeDoc", "preventiveVideo", "preventiveImage","preventiveCarousel","","");
        });
        function BindPredictiveAlarmDetails() {
            $.ajax({
                async: false,
                type: "POST",
                url: "AlarmHistory.aspx/getPredictiveAlarmDetails",
                contentType: "application/json; charset=utf-8",
                data: '{company:"' + CompanyID + '",plant:"' + PlantID + '",machine:"' + MachineID + '"}',
                datatype: "json",
                success: function (response) {
                    var itemdata = response.d;
                    $('#predictiveAlarmContainer').empty();
                    var appendStr = "<table class='P1Table'><tr><th>Alarm No.</th><th>Message</th><th>Duration</th><th>Hrs/Nos. Left</th><th>Time</th></tr>";
                    if (itemdata.length > 0) {

                        for (var i = 0; i < itemdata.length; i++) {
                            appendStr += '<tr><td>' + itemdata[i].AlarmNo + '<input type="hidden" id="hdnAlarmNo" value="' + itemdata[i].AlarmNo + '" /> </td><td>' + itemdata[i].Message + '</td><td>' + itemdata[i].Duration + '</td><td>' + itemdata[i].HoursLeft + '</td><td><progress id="file" value="' + itemdata[i].Time + '" max="100"> 32% </progress></td></tr>';
                        }
                    }
                    else {
                        appendStr += '<tr><td colspan="4">No Data Found.</td></tr>';
                    }
                    $('#predictiveAlarmContainer').append(appendStr);
                },
                error: function (jqXHR, textStatus, err) {
                    console.log(err);
                }
            });
        }
        $('#predictiveAlarmContainer').on('click', 'table tr', function () {
            debugger;
            $('#predictiveAlarmContainer table tr').css("background-color", "unset");
            $(this).css("background-color", "#21ada4");
            debugger;
            var alarmNo = $(this).find("#hdnAlarmNo").val();
            showFileDetails(alarmNo, "PredictiveAlarmMaster", "predictiveIframeDoc", "predictiveVideo", "predictiveImage", "predictiveCarousel", "", "");
        });
        function setActiveSubmenuValue() {
            debugger;
            localStorage.setItem("selectedAlarmSubMenu", "#alarmCNCMenu");
        }
        $(".submenuData").click(function () {
            debugger;
            clearDocuments();
            $('#cncAlarmContainer').empty();
            $('#cncAlarmSolnContainer').empty();
            $('#predictiveAlarmContainer').empty();
            $('#preventiveAlarmContainer').empty();
            $('[id*=hdnScrollPos]').val(0);
            $.blockUI({ message: '<img runat="server" src="Images/Loading.gif" />' });
            if ($("#mainBody").hasClass("light-mode")) {
                $(".submenuData").removeClass("selected-menu-style selected-Submenu").addClass("other-menu-style");
                $(".submenuData").closest('li').find('i').removeClass();
                $(this).removeClass("other-menu-style selected-Submenu").addClass("selected-menu-style");
            } else {
                //$(".submenuData").removeClass("selected-menu-style selected-Submenu").addClass("other-menu-style");
                //$(".submenuData").closest('li').find('i').removeClass();
                //$(this).removeClass("other-menu-style selected-Submenu").addClass("selected-menu-style");
                $(".submenuData").removeClass("selected-menu-style selected-Submenu").addClass("other-menu-style");
                $(".submenuData").closest('li').find('i').removeClass();
                $(this).removeClass("other-menu-style selected-Submenu").addClass("selected-Submenu");
            }
            $(this).closest('li').find('i').addClass("arrow up selected-Submenu-ArrowUp");
            submenu = $(this).attr('href');
            $("#activeMenu").val(submenu);
            $(submenu).addClass("in active");
            if (submenu == "#alarmPreventiveMenu") {
                BindPreventiveAlarmDetails();
            }
            else if (submenu == "#alarmPredictiveMenu") {
                BindPredictiveAlarmDetails();
            }
            else {
                BindCNCAlarmDetails();
            }
            localStorage.setItem("selectedAlarmSubMenu", submenu);
            setGridHeight();
            $.unblockUI({});
        });
        function setGridHeight() {
            var windowH = $(window).height();
            let docHeight = windowH - 200;
            $('.docContainer').css("height", docHeight);
        }
    </script>

</asp:Content>
