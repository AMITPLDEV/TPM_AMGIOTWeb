<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MachineDocuments.aspx.cs" Inherits="NewProject.MachineDocuments" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <%--   <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfobject/2.2.4/pdfobject.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfobject/2.2.4/pdfobject.min.js"></script>--%>

    <%--  <script src="Scripts/DateTimePicker/jquery-2.1.1.min.js"></script>--%>
    <link href="Scripts/MultiSelectDropdown/bootstrap-multiselect.css" rel="stylesheet" />
    <script src="Scripts/MultiSelectDropdown/bootstrap-multiselect.js"></script>

    <%--   <link href="Scripts/DateTimePicker/bootstrap-datetimepicker.css" rel="stylesheet" />
    <script src="Scripts/DateTimePicker/moment-with-locales.js"></script>
    <script src="Scripts/DateTimePicker/bootstrap-datetimepicker.js"></script>--%>

    <script src="Scripts/DateTimePicker/bootstrap-datepicker.js"></script>
    <link href="Scripts/DateTimePicker/bootstrap-datepicker3.css" rel="stylesheet" />

    <script src="Scripts/DateTimePicker/bootstrap-datepicker.en-IE.min.js"></script>
    <script src="Scripts/DateTimePicker/bootstrap-datepicker.zh-CN.min.js"></script>
    <style>
        .pdfobject-container {
            height: 500px;
        }

        .pdfobject {
            border: 1px solid #666;
        }

        .outer-div {
            width: 350px;
            height:unset;
        }

        .card-table tr {
            border-bottom: 0.5px solid #00669f52;
        }

            .card-table tr td:nth-child(1) {
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
            }

            .card-table tr td:nth-child(2) {
                min-width: 200px;
                max-width: 200px;
                width: 200px;
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
            }

        .link-button-style {
            color: #0588f8;
        }

        .light-mode .P1Table tr td a {
            color: #0588f8 !important;
        }

        .sub-header-linkbtn {
            color: white;
        }

        .light-mode .sub-header-linkbtn {
            color: black !important;
        }

        #docConatiner iframe, #docConatiner video, #docConatiner img {
            border: 2px solid #ada3a3;
        }

        .light-mode #docConatiner {
        }
    </style>
    <div style="margin-top: 100px">

        <table class="submenu-right-side" id="right-table">
            <tr>
                <td>
                    <i id="btnZoomIn" class="glyphicon glyphicon-zoom-in" style="font-size: 17px;" onclick="openShowLargeDocumentModal()"></i>
                </td>
                <td>
                    <%--  <i class="glyphicon glyphicon-save" style="font-size: 17px;"></i>--%>
                    <asp:LinkButton runat="server" ID="lnkDownloadFile" OnClick="btnDownloadFile_Click" ClientIDMode="Static" CssClass="glyphicon glyphicon-save sub-header-linkbtn" Style="font-size: 17px"></asp:LinkButton>
                </td>
                <td onmouseover="showPanelsTopRight(this,'panelView','5px','40px');" onmouseout="hidePanels(this,'panelView')">
                    <i class="glyphicon glyphicon-th" style="font-size: 17px;"></i>
                    <div class="panel panel-default panel-subitems" id="panelView" onmouseover="showPanelsTopRight(this,'panelView','5px','40px');" onmouseout="hidePanels(this,'panelView')" style="width: 200px;">
                        <div class="panel-body">
                            <ul class="outer-ul">
                                <li onclick="showViews('ListView')">
                                    <span>List View</span>
                                </li>
                                <li onclick="showViews('CardView')">
                                    <span>Card View</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </td>
                <td onmouseover="showPanelsTopRight(this,'panelFilter','5px','40px');" onmouseout="hidePanels(this,'panelFilter')">
                    <i class="glyphicon glyphicon-filter" style="font-size: 17px;"></i>
                    <div class="panel panel-default panel-subitems" id="panelFilter" onmouseover="showPanelsTopRight(this,'panelFilter','5px','40px');" onmouseout="hidePanels(this,'panelFilter')" style="width: 250px;">
                        <div class="panel-body">
                            <div id="divColumnFilter">
                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <asp:CheckBoxList runat="server" ID="cblColumnSelector" CssClass="checkbox-list" ClientIDMode="Static"></asp:CheckBoxList>
                                        <asp:Button runat="server" ID="btnColumnSelectorOK" Text="OK" ClientIDMode="Static" Style="margin-left: 20px" CssClass="Btns" OnClientClick="return setColumnName();" />
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
        </table>

        <div class="row">

            <div class="col-lg-8">
               

                <asp:HiddenField runat="server" ID="hdnPDfData" ClientIDMode="Static" />
                <asp:HiddenField runat="server" ID="hdnFileBase64Data" ClientIDMode="Static" />
                <asp:HiddenField runat="server" ID="hdnFileNameForDownload" ClientIDMode="Static" />
                <asp:HiddenField runat="server" ID="hdnDataView" ClientIDMode="Static" />
                <asp:HiddenField runat="server" ID="hdnFilesID" ClientIDMode="Static" />
                <div class="col-lg-12" style="margin-bottom: 10px">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                             <asp:HiddenField runat="server" ID="hdnFieldIDForPB" ClientIDMode="Static" />
                <asp:HiddenField runat="server" ID="hdnFileNameForPB" ClientIDMode="Static" />
                <asp:HiddenField runat="server" ID="hdnColNameForPB" ClientIDMode="Static" />
                            <table>
                                <tr>
                                    <td>Model&nbsp;</td>
                                    <td>
                                        <%--  <asp:DropDownList runat="server" ID="DropDownList1" CssClass="form-control">
                                        <asp:ListItem>All</asp:ListItem>
                                    </asp:DropDownList>--%>

                                        <%--    <asp:ListBox ID="lbModel" runat="server" SelectionMode="Multiple" ClientIDMode="Static" Style="width: 150px; color: black !important" CssClass="dropdown-list">
                                        <asp:ListItem>M1</asp:ListItem>
                                        <asp:ListItem>M2</asp:ListItem>
                                        <asp:ListItem>M3</asp:ListItem>
                                    </asp:ListBox>--%>
                                        <asp:DropDownList runat="server" CssClass="form-control dropdown-list" ID="ddlModel" AutoPostBack="true" OnSelectedIndexChanged="ddlModel_SelectedIndexChanged"></asp:DropDownList>

                                    </td>
                                    <td>&nbsp;&nbsp;Machine&nbsp;</td>
                                    <td>
                                        <%--  <asp:ListBox ID="lbMachineNumber" runat="server" SelectionMode="Multiple" ClientIDMode="Static" Style="width: 150px; color: black !important" CssClass="dropdown-list">
                                        <asp:ListItem>CNC</asp:ListItem>
                                    </asp:ListBox>--%>
                                        <asp:DropDownList runat="server" CssClass="form-control dropdown-list" ID="ddlMachineNumber"></asp:DropDownList>
                                    </td>
                                    <td>&nbsp;&nbsp;Category&nbsp;</td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="ddlCategory" CssClass="form-control dropdown-list">
                                            <asp:ListItem>All</asp:ListItem>
                                            <asp:ListItem>CNC Document</asp:ListItem>
                                            <asp:ListItem>Ele& Mech</asp:ListItem>
                                            <asp:ListItem>Ele-Design</asp:ListItem>
                                            <asp:ListItem>CNC</asp:ListItem>
                                            <asp:ListItem>MTB-Application</asp:ListItem>
                                        </asp:DropDownList></td>
                                    <td>&nbsp;&nbsp;Sub-Category&nbsp;</td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="ddlSubCategory" CssClass="form-control dropdown-list">
                                            <asp:ListItem>All</asp:ListItem>
                                            <asp:ListItem>Fanuc/Siemens/Mitsubishi/Control supplier manuals as applicable for Users</asp:ListItem>
                                            <asp:ListItem>Operation and Maintenance Manual</asp:ListItem>
                                            <asp:ListItem>Connection Manual</asp:ListItem>
                                            <asp:ListItem>Application Manual</asp:ListItem>
                                            <asp:ListItem>Quick Start Installation and Commissioning Guide</asp:ListItem>
                                        </asp:DropDownList></td>
                                    <%-- <td>&nbsp;&nbsp;L3&nbsp;</td>
                                <td>
                                    <asp:DropDownList runat="server" ID="ddlL3" CssClass="form-control">
                                        <asp:ListItem>840D</asp:ListItem>
                                    </asp:DropDownList></td>--%>
                                </tr>
                                <tr>
                                    <td>From&nbsp;</td>
                                    <td>
                                        <div class="filterCustomeDiv">
                                            <asp:TextBox ID="txtFromDate" runat="server" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control" placeholder="Date" Style="display: inline;"></asp:TextBox>
                                        </div>
                                    </td>
                                    <td>&nbsp;&nbsp;To&nbsp;</td>
                                    <td>
                                        <div class="filterCustomeDiv">
                                            <asp:TextBox ID="txtToDate" runat="server" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control" placeholder="Date" Style="display: inline;"></asp:TextBox>
                                        </div>
                                    </td>
                                    <td>&nbsp;&nbsp;<asp:Button runat="server" ID="btnView" Text="View" CssClass="Btns" OnClick="btnView_Click" /></td>
                                </tr>
                            </table>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="ddlModel" EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
                <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                        <div id="machineDocsContainer" style="height: 78vh; overflow: auto; padding: 4px">
                            <div class="ListView" style="display: none">
                                <asp:ListView runat="server" ID="lvMachineDocs" ClientIDMode="Static">
                                    <LayoutTemplate>
                                        <table class="P1Table" id="machineDocsTbl">
                                            <tr>
                                                <th>Machine Slno</th>
                                                <th>MTB</th>
                                                <th>Model Number</th>
                                                <%-- <th>MTB Sl.No.</th>--%>
                                                <th>Category</th>
                                                <th>Sub-Category</th>
                                                <%--  <th>L3</th>--%>
                                                <th>Version</th>
                                                <th>Updated By</th>
                                                <th>Updated TS</th>
                                                <th>Document</th>
                                            </tr>
                                            <tr runat="server" id="itemplaceholder"></tr>
                                        </table>
                                    </LayoutTemplate>
                                    <ItemTemplate>
                                        <tr>
                                            <td><%# Eval("MachineSlno") %>
                                              
                                            </td>
                                            <td><%# Eval("MTB") %></td>
                                            <%-- <td><%# Eval("MTBSeialNumber") %></td>--%>
                                            <td><%# Eval("MachineModel") %></td>

                                            <td><%# Eval("Category") %></td>

                                            <td><%# Eval("Subcategory") %></td>

                                            <%--  <td><%# Eval("L3") %></td>--%>

                                            <td><%# Eval("Version") %></td>


                                            <td><%# Eval("UpdatedBy") %></td>

                                            <td><%# Eval("UpdatedTS") %></td>

                                            <td>
                                                <asp:HiddenField runat="server" ID="hdnMachineType" Value='<%# Eval("MachineType") %>' />
                                                <asp:HiddenField runat="server" ID="hdnMachineModel" Value='<%# Eval("MachineModel") %>' />
                                                <asp:HiddenField runat="server" ID="hdnMachineSlno" Value='<%# Eval("MachineSlno") %>' />
                                                <asp:HiddenField runat="server" ID="hdnFileID" Value='<%# Eval("FileID") %>' />
                                                <%-- <asp:HiddenField runat="server" ID="hdnFileArrayString" Value='<%# Eval("FileInBase64") %>' />--%>
                                                <asp:HiddenField runat="server" ID="hdnFileName" Value='<%# Eval("Filename") %>' />
                                                <asp:LinkButton runat="server" ID="lnkFilename" CssClass="link-button-style" Text='<%# Eval("Filename") %>' OnClientClick="return showFileDetails(this);" OnClick="lnkFilename_Click" ToolTip='<%# Eval("Filename") %>'></asp:LinkButton>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:ListView>
                            </div>
                            <div class="CardView" style="display: none">
                                <asp:ListView runat="server" ID="lvMachineDocsCardView" ClientIDMode="Static">
                                    <LayoutTemplate>
                                        <div id="machineDocsCardViewContainer">
                                            <div runat="server" id="itemplaceholder"></div>
                                        </div>
                                    </LayoutTemplate>
                                    <ItemTemplate>
                                        <div class="outer-div">
                                            <table class="card-table">
                                                <tr>
                                                    <td>Machine Slno</td>
                                                    <td><%# Eval("MachineSlno") %>
                                                      
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>MTB</td>
                                                    <td><%# Eval("MTB") %></td>
                                                </tr>
                                                <tr>
                                                    <td>Model Number</td>
                                                    <td><%# Eval("MachineModel") %></td>
                                                </tr>
                                                <%--   <tr>
                                                    <td>MTB Sl.No.</td>
                                                    <td><%# Eval("ModelNumber") %></td>
                                                </tr>--%>
                                                <tr>
                                                    <td>Category</td>
                                                    <td><%# Eval("Category") %></td>
                                                </tr>
                                                <tr>
                                                    <td>Sub-Category</td>
                                                    <td><%# Eval("Subcategory") %></td>
                                                </tr>
                                                <%--   <tr>
                                                    <td>L3</td>
                                                    <td><%# Eval("L3") %></td>
                                                </tr>--%>
                                                <tr>
                                                    <td>Version</td>
                                                    <td><%# Eval("Version") %></td>
                                                </tr>
                                                <tr>
                                                    <td>Updated By</td>
                                                    <td><%# Eval("UpdatedBy") %></td>
                                                </tr>
                                                <tr>
                                                    <td>Updated TS</td>
                                                    <td><%# Eval("UpdatedTS") %></td>
                                                </tr>
                                                <tr>
                                                    <td>Document</td>
                                                    <td style="">
                                                        <asp:HiddenField runat="server" ID="hdnMachineType" Value='<%# Eval("MachineType") %>' />
                                                        <asp:HiddenField runat="server" ID="hdnMachineModel" Value='<%# Eval("MachineModel") %>' />
                                                        <asp:HiddenField runat="server" ID="hdnMachineSlno" Value='<%# Eval("MachineSlno") %>' />
                                                        <asp:HiddenField runat="server" ID="hdnFileID" Value='<%# Eval("FileID") %>' />
                                                        <%-- <asp:HiddenField runat="server" ID="hdnFileArrayString" Value='<%# Eval("FileInBase64") %>' />--%>
                                                        <asp:HiddenField runat="server" ID="hdnFileName" Value='<%# Eval("Filename") %>' />
                                                        <asp:LinkButton runat="server" ID="lnkFilename" Text='<%# Eval("Filename") %>' OnClick="lnkFilename_Click" OnClientClick="return showFileDetails(this);" ToolTip='<%# Eval("Filename") %>'></asp:LinkButton></td>
                                                </tr>
                                            </table>
                                        </div>
                                    </ItemTemplate>
                                </asp:ListView>
                            </div>
                        </div>
                    </ContentTemplate>
                    <Triggers>
                    </Triggers>
                </asp:UpdatePanel>
            </div>
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <div class="col-lg-4" style="padding-left: 0px">
                        <div style="width: 100%; height: 100%; padding: 4px" id="docConatiner">
                            <asp:Button runat="server" ID="btnDownloadFile" Text="Download" CssClass="Btns" OnClick="btnDownloadFile_Click" Visible="false" />
                            <iframe runat="server" id="iframeMachineDocs" style="width: 100%; height: 85vh; margin-top: 5px;" clientidmode="static"></iframe>
                            <video id="machineDocVideo" autoplay='autoplay' controls style="width: 100%; height: 85vh; margin-top: 5px;">
                                <source />
                            </video>
                            <img id="machineDocImage" src="" style="width: 100%; height: 85vh; margin-top: 5px;" />
                            <%--<div id="example1" ></div>--%>
                        </div>
                    </div>
                </ContentTemplate>
                <Triggers>
                </Triggers>
            </asp:UpdatePanel>
        </div>

        <div class="modal fade" id="showLargeDocumentModal" role="dialog" style="min-width: 300px;">
            <div class="modal-dialog modal-dialog-centered" style="width: 90%; margin: 10px auto">
                <div class="modal-content" style="border: 2px solid #5D7B9D">
                    <div class="modal-header" style="background-color: #5D7B9D; padding: 8px; text-align: center">

                        <h4 class="modal-title" style="color: white; font-size: 25px">Document</h4>
                    </div>
                    <div class="modal-body">
                        <div style="height: 80vh">
                            <iframe id="iframeLargeDoc" style="width: 100%; height: 100%"></iframe>
                            <video id="machineDocLargeVideo" autoplay='autoplay' controls style="width: 100%; height: 100%">
                                <source />
                            </video>
                            <img id="machineDocLargeImage" src="" style="width: 100%; height: 100%" />
                        </div>

                    </div>
                    <div class="modal-footer" style="padding: 5px; border-top: 1px solid #5D7B9D; text-align: right">

                        <input type="button" value="Close" class="Btns" data-dismiss="modal" onclick="closeLargeDocumentModal()" />
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
                    <div class="modal-footer modalFooter modal-footer">
                        <input type="button" value="OK" class="warning-modal-btn" data-dismiss="modal" />
                    </div>
                </div>
            </div>
        </div>
        <%--   <iframe src='MachineFiles/InvoiceDetails22-09-2020 15_32_55.htm' width='700' height='565' > </iframe>
        <embed src="src/Sampl.htm"  width='700' height='565'  />
   <iframe src='src/Sample3.htm' width='700' height='565' > </iframe>--%>
    </div>
    <script>

        $(document).ready(function () {
            //document.getElementById("subMenuList").style.display = "none";
            //  BindPDfFile();
            // BindPDFFileInDiv();
            // var path = "MachineFiles/Machine1.pdf";
            // $('#iframeMachineDocs').attr("src", path);
            $('#right-table').appendTo('#right-side-filters');
            setColumnName();
            setDataView();
            $('#iframeMachineDocs').css("display", "none");
            $('#machineDocVideo').css("display", "none");
            $('#machineDocImage').css("display", "none");
            $('#iframeLargeDoc').css("display", "none");
            $('#machineDocLargeVideo').css("display", "none");
            $('#machineDocLargeImage').css("display", "none");
            $('#machineDocLargeVideo source').attr('src', '');
            $("#machineDocLargeVideo")[0].load();
            $('#machineDocLargeImage').attr('src', '');
            $('#iframeLargeDoc').attr("src", "");
               $('#lnkDownloadFile').css("visibility", "hidden");
                    $('#btnZoomIn').css("visibility", "hidden");
                    $('#hdnFilesID').val("");
        });
        function openWarningModal(msg) {
            $('#warningModal').modal('show');
            $('#lblWarningMsg').text(msg);
        }
        $('[id$=txtFromDate]').datepicker({
            //format: 'DD-MM-YYYY',
            //useCurrent: true,
            //locale: 'en-US'
            //format: 'DD-MM-YYYY',
            // locale: 'en-US'

            format: 'dd-mm-yyyy',
            todayHighlight: true,
            autoclose: true,
            language: 'en-US'
        });
        $('[id$=txtToDate]').datepicker({
            format: 'dd-mm-yyyy',
            todayHighlight: true,
            autoclose: true,
            language: 'en-US'
        });
        function showFileDetails(evt) {
            debugger;
            //  $.blockUI({ message: '<img runat="server" src="Images/Loading.gif" />' });
            var fileidvalue = $(evt).closest('tr').find('#hdnFileID').val();
            $('#hdnFieldIDForPB').val(fileidvalue);
            let type = $(evt).closest('tr').find('#hdnMachineType').val();
            let model = $(evt).closest('tr').find('#hdnMachineModel').val();
            let slno = $(evt).closest('tr').find('#hdnMachineSlno').val();
            var collectionName = "";
            if (type == "" && model == "" && slno == "") {
                collectionName = "MTBLeveleDoc";
            }
            else if (slno == "") {
                collectionName = "ModelLeveleDoc";
            } else {
                collectionName = "MachineLeveleDoc";
            }
            $('#hdnFileNameForPB').val($(evt).closest('tr').find('#hdnFileName').val());
            $('#hdnColNameForPB').val(collectionName);

            $.ajax({
                async: false,
                type: "POST",
                url: "MachineDocuments.aspx/getFileNamePath",
                contentType: "application/json; charset=utf-8",
                data: '{fileId:"' + fileidvalue + '",filenameStr:"' + $(evt).closest('tr').find('#hdnFileName').val() + '",colName:"' + collectionName + '"}',
                datatype: "json",
                success: function (response) {
                    var itemdata = response.d;
                    debugger;
                    $('#iframeMachineDocs').css("display", "none");
                    $('#machineDocVideo').css("display", "none");
                    $('#machineDocImage').css("display", "none");
                    $('#iframeLargeDoc').css("display", "none");
                    $('#machineDocLargeVideo').css("display", "none");
                    $('#machineDocLargeImage').css("display", "none");
                    $('#machineDocLargeVideo source').attr('src', '');
                    $("#machineDocLargeVideo")[0].load();
                    $('#machineDocLargeImage').attr('src', '');
                    $('#iframeLargeDoc').attr("src", "");
                    if (itemdata.FileInBase64 != "") {
                        var fileType = itemdata.FileType;
                        if (fileType == "video") {
                            if (itemdata.FileExtension == "gif") {
                                $('#machineDocImage').css("display", "block");
                                $('#machineDocLargeImage').css("display", "block");
                                $('#machineDocImage').attr('src', "data:image/png;base64," + itemdata.FileInBase64);
                                $('#machineDocLargeImage').attr('src', "data:image/png;base64," + itemdata.FileInBase64);
                            }
                            else {
                                $('#machineDocVideo').css("display", "block");
                                $('#machineDocLargeVideo').css("display", "block");
                                $('#machineDocVideo source').attr('src', "data:video/mp4;base64," + itemdata.FileInBase64);
                                $("#machineDocVideo")[0].load();
                                $('#machineDocLargeVideo source').attr('src', "data:video/mp4;base64," + itemdata.FileInBase64);
                                $("#machineDocLargeVideo")[0].load();
                            }
                        }
                        else if (fileType == "image") {
                            $('#machineDocImage').css("display", "block");
                            $('#machineDocLargeImage').css("display", "block");
                            $('#machineDocImage').attr('src', "data:image/png;base64," + itemdata.FileInBase64);
                            $('#machineDocLargeImage').attr('src', "data:image/png;base64," + itemdata.FileInBase64);
                        }
                        else if (fileType == "pdf") {
                            $('#iframeMachineDocs').css("display", "block");
                            $('#iframeLargeDoc').css("display", "block");
                            var arrrayBuffer = base64ToArrayBuffer(itemdata.FileInBase64); //data is the base64 encoded string
                            var blob = new Blob([arrrayBuffer], { type: "application/pdf" });
                            var link = window.URL.createObjectURL(blob);
                            $('#iframeMachineDocs').attr("src", link + "#toolbar=0");
                            $('#iframeLargeDoc').attr("src", link + "#toolbar=0");
                        }
                        else if (fileType == "excel") {
                            var linkSource = 'data:application/vnd.ms-excel;base64,' + itemdata.FileInBase64;
                            var downloadLink = document.createElement("a");
                            var fileName = $(evt).closest('tr').find('#hdnFileName').val();
                            downloadLink.href = linkSource;
                            downloadLink.download = fileName;
                            downloadLink.click();
                        }
                        else {
                            $('#iframeMachineDocs').css("display", "block");
                            $('#iframeLargeDoc').css("display", "block");
                            var arrrayBuffer = base64ToArrayBuffer(itemdata.FileInBase64); //data is the base64 encoded string
                            var blob = new Blob([arrrayBuffer], { type: "application/" + itemdata.FileExtension });
                            var link = window.URL.createObjectURL(blob);
                            $('#iframeMachineDocs').attr("src", link + "#toolbar=0");
                            $('#iframeLargeDoc').attr("src", link + "#toolbar=0");
                        }
                        $('#lnkDownloadFile').css("visibility", "visible");
                        $('#btnZoomIn').css("visibility", "visible");
                        $('#hdnFilesID').val(fileidvalue);
                    }
                    else {
                        $('#lnkDownloadFile').css("visibility", "hidden");
                        $('#btnZoomIn').css("visibility", "hidden");
                        $('#hdnFilesID').val("");
                    }
                },
                error: function (jqXHR, textStatus, err) {
                    console.log(err);
                }
            });
            // $.unblockUI({});
            return false;
        }
        function openShowLargeDocumentModal() {
            $('#machineDocLargeVideo source').attr('src', $('#machineDocVideo source').attr('src'));
            $("#machineDocLargeVideo")[0].load();
            $('#machineDocLargeImage').attr('src', $('#machineDocImage').attr('src'));
            $('#iframeLargeDoc').attr("src", $('#iframeMachineDocs').attr("src"));
            $('#showLargeDocumentModal').modal('show');
        }
        function closeLargeDocumentModal() {
            $('#machineDocLargeVideo source').attr('src', '');
            $("#machineDocLargeVideo")[0].load();
            $('#machineDocLargeImage').attr('src', '');
            $('#iframeLargeDoc').attr("src", "");
        }
        function setDataView() {
            if ($('#hdnDataView').val() == "CardView") {
                $('.CardView').css("display", "block");
                $('.ListView').css("display", "none");
            }
            else {
                $('.CardView').css("display", "none");
                $('.ListView').css("display", "block");
            }
        }
        function showViews(param) {
            debugger;
            if (param == "CardView") {
                $('#hdnDataView').val('CardView');
            } else {
                $('#hdnDataView').val('ListView');
            }
            setDataView();
        }
        function setColumnName() {
            debugger;
            let selectedColumnName = "";
            var checked_checkboxes = $('#cblColumnSelector input:checked');
            checked_checkboxes.each(function () {
                if (selectedColumnName == "") {
                    selectedColumnName = "|" + $(this).val() + "|";
                } else {
                    selectedColumnName = selectedColumnName + ',|' + $(this).val() + "|";
                }
            });

            //List View
            for (let i = 0; i < $('#machineDocsTbl th').length; i++) {
                let th = $('#machineDocsTbl th')[i];
                // let td = $('#tblCompanyDashboard td')[i];
                let name = "|" + $(th).text() + "|";
                if (selectedColumnName.includes(name)) {
                    $(th).css('display', 'table-cell');
                    for (let j = 1; j < $('#machineDocsTbl tr').length; j++) {
                        let trs = $('#machineDocsTbl tr');
                        let tr = $(trs)[j];
                        let innertd = $(tr).children()[i];
                        $(innertd).css('display', 'table-cell');
                    }
                } else {
                    $(th).css('display', 'none');
                    for (let j = 1; j < $('#machineDocsTbl tr').length; j++) {
                        let trs = $('#machineDocsTbl tr');
                        let tr = $(trs)[j];
                        let innertd = $(tr).children()[i];
                        $(innertd).css('display', 'none');
                    }
                }
            }

            //For Card View
            for (let i = 0; i < $('#machineDocsCardViewContainer .outer-div').length; i++) {
                let div = $('#machineDocsCardViewContainer .outer-div')[i];
                // let td = $('#tblCompanyDashboard td')[i];
                var tblRow = $(div).find("table tr");
                var tblRowCount = $(div).find("table tr").length;
                for (let j = 0; j < tblRowCount; j++) {
                    var row = $(div).find("table tr")[j];
                    var name = "|" + $(row).find("td:first-child")[0].textContent + "|";
                    if (selectedColumnName.includes(name)) {
                        $(row).css('display', 'table-row');
                    }
                    else {
                        $(row).css('display', 'none');
                    }
                }
            }

            //if ($('#iframeMachineDocs').attr("src") != "" && $('#iframeMachineDocs').attr("src") != undefined && $('#iframeMachineDocs').attr("src") != null) {
            //    $('#lnkDownloadFile').css("visibility", "visible");
            //    $('#btnZoomIn').css("visibility", "visible");
            //}
            //else {
            //    $('#lnkDownloadFile').css("visibility", "hidden");
            //    $('#btnZoomIn').css("visibility", "hidden");
            //    $('#hdnFilesID').val("");
            //}
            return false;
        }
        function BindPDFFileInDiv() {
            debugger;
            var data = $('#hdnPDfData').val();
            var arrrayBuffer = base64ToArrayBuffer(data);
            PDFObject.embed(arrrayBuffer, "#example1");
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
        function BindPDfFile() {
            debugger;
            var data = $('#hdnPDfData').val();
            var arrrayBuffer = base64ToArrayBuffer(data); //data is the base64 encoded string
            var blob = new Blob([arrrayBuffer], { type: "application/pdf" });
            var link = window.URL.createObjectURL(blob);
            window.open(link, '_blank', 'height=650,width=840');
        }
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
            $(document).ready(function () {
                $('#right-table').appendTo('#right-side-filters');
                setColumnName();
                setDataView();
                BindDocuments();
            });
            function BindDocuments() {
                if ($('#hdnFieldIDForPB').val() != "" && $('#hdnFieldIDForPB').val() != undefined) {


                    var fileidvalue = $('#hdnFieldIDForPB').val();
                    var collectionName = $('#hdnColNameForPB').val();
                    $.ajax({
                        async: false,
                        type: "POST",
                        url: "MachineDocuments.aspx/getFileNamePath",
                        contentType: "application/json; charset=utf-8",
                        data: '{fileId:"' + fileidvalue + '",filenameStr:"' + $('#hdnFileNameForPB').val() + '",colName:"' + collectionName + '"}',
                        datatype: "json",
                        success: function (response) {
                            var itemdata = response.d;
                            debugger;
                            $('#iframeMachineDocs').css("display", "none");
                            $('#machineDocVideo').css("display", "none");
                            $('#machineDocImage').css("display", "none");
                            $('#iframeLargeDoc').css("display", "none");
                            $('#machineDocLargeVideo').css("display", "none");
                            $('#machineDocLargeImage').css("display", "none");
                            $('#machineDocLargeVideo source').attr('src', '');
                            $("#machineDocLargeVideo")[0].load();
                            $('#machineDocLargeImage').attr('src', '');
                            $('#iframeLargeDoc').attr("src", "");
                            if (itemdata.FileInBase64 != "") {
                                var fileType = itemdata.FileType;
                                if (fileType == "video") {
                                    if (itemdata.FileExtension == "gif") {
                                        $('#machineDocImage').css("display", "block");
                                        $('#machineDocLargeImage').css("display", "block");
                                        $('#machineDocImage').attr('src', "data:image/png;base64," + itemdata.FileInBase64);
                                        $('#machineDocLargeImage').attr('src', "data:image/png;base64," + itemdata.FileInBase64);
                                    }
                                    else {
                                        $('#machineDocVideo').css("display", "block");
                                        $('#machineDocLargeVideo').css("display", "block");
                                        $('#machineDocVideo source').attr('src', "data:video/mp4;base64," + itemdata.FileInBase64);
                                        $("#machineDocVideo")[0].load();
                                        $('#machineDocLargeVideo source').attr('src', "data:video/mp4;base64," + itemdata.FileInBase64);
                                        $("#machineDocLargeVideo")[0].load();
                                    }
                                }
                                else if (fileType == "image") {
                                    $('#machineDocImage').css("display", "block");
                                    $('#machineDocLargeImage').css("display", "block");
                                    $('#machineDocImage').attr('src', "data:image/png;base64," + itemdata.FileInBase64);
                                    $('#machineDocLargeImage').attr('src', "data:image/png;base64," + itemdata.FileInBase64);
                                }
                                else if (fileType == "pdf") {
                                    $('#iframeMachineDocs').css("display", "block");
                                    $('#iframeLargeDoc').css("display", "block");
                                    var arrrayBuffer = base64ToArrayBuffer(itemdata.FileInBase64); //data is the base64 encoded string
                                    var blob = new Blob([arrrayBuffer], { type: "application/pdf" });
                                    var link = window.URL.createObjectURL(blob);
                                    $('#iframeMachineDocs').attr("src", link + "#toolbar=0");
                                    $('#iframeLargeDoc').attr("src", link + "#toolbar=0");
                                }
                                else {
                                    $('#iframeMachineDocs').css("display", "block");
                                    $('#iframeLargeDoc').css("display", "block");
                                    var arrrayBuffer = base64ToArrayBuffer(itemdata.FileInBase64); //data is the base64 encoded string
                                    var blob = new Blob([arrrayBuffer], { type: "application/" + itemdata.FileExtension });
                                    var link = window.URL.createObjectURL(blob);
                                    $('#iframeMachineDocs').attr("src", link + "#toolbar=0");
                                    $('#iframeLargeDoc').attr("src", link + "#toolbar=0");
                                }
                                $('#lnkDownloadFile').css("visibility", "visible");
                                $('#btnZoomIn').css("visibility", "visible");
                                $('#hdnFilesID').val(fileidvalue);
                            }
                            else {
                                $('#lnkDownloadFile').css("visibility", "hidden");
                                $('#btnZoomIn').css("visibility", "hidden");
                                $('#hdnFilesID').val("");
                            }
                        },
                        error: function (jqXHR, textStatus, err) {
                            console.log(err);
                        }
                    });
                }
                else {
                    $('#iframeMachineDocs').css("display", "none");
                    $('#machineDocVideo').css("display", "none");
                    $('#machineDocImage').css("display", "none");
                    $('#iframeLargeDoc').css("display", "none");
                    $('#machineDocLargeVideo').css("display", "none");
                    $('#machineDocLargeImage').css("display", "none");
                    $('#machineDocLargeVideo source').attr('src', '');
                    $("#machineDocLargeVideo")[0].load();
                    $('#machineDocLargeImage').attr('src', '');
                    $('#iframeLargeDoc').attr("src", "");
                    $('#lnkDownloadFile').css("visibility", "hidden");
                    $('#btnZoomIn').css("visibility", "hidden");
                    $('#hdnFilesID').val("");
                }
            }

            $('[id$=txtFromDate]').datepicker({
                //format: 'DD-MM-YYYY',
                //useCurrent: true,
                //locale: 'en-US'
                //format: 'DD-MM-YYYY',
                // locale: 'en-US'

                format: 'dd-mm-yyyy',
                todayHighlight: true,
                autoclose: true,
                language: 'en-US'
            });
            $('[id$=txtToDate]').datepicker({
                format: 'dd-mm-yyyy',
                todayHighlight: true,
                autoclose: true,
                language: 'en-US'
            });
        });
    </script>
</asp:Content>
