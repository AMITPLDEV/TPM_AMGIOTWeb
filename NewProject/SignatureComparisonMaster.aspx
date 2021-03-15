<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SignatureComparisonMaster.aspx.cs" Inherits="NewProject.SignatureComparisonMaster" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Scripts/MultiSelectDropdown/bootstrap-multiselect.css" rel="stylesheet" />
    <script src="Scripts/MultiSelectDropdown/bootstrap-multiselect.js"></script>
    <style>
        .modalThemeCss {
            background-color: #32383d;
        }

        .light-mode .modalThemeCss {
            background-color: white !important;
        }

        #existingSignatureDataModal table {
            width: 100%;
        }

        #changeSignatureIDModal table tr td, #changeSignatureIDModal table tr td span {
            font-size: 19px;
        }

        #copySignatureValueModal table {
            width: 100%;
            border: 0.5px solid #a3a3a361;
        }

            #copySignatureValueModal table tr td, #copySignatureValueModal table tr span {
                padding: 10px 15px;
                font-size: 19px;
            }


        .multiselect-selected-text {
            color: black;
        }

        /*.changeCss {
            background: -webkit-linear-gradient(top, #8b989e 0,#093d9c 40%, #203c4a 100%);
        }

        .light-mode .changeCss {
            background: -webkit-linear-gradient(top, #b1b4ea 0,#2f157f 40%, #2b1a71 100%) !important;
            border: 2px solid #264279 !important;
        }*/

        .themetoggle a {
            color: #339efb;
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

        .infoModalTbls{
            box-shadow: 2px 2px 5px 2px #e0dbdbed;

        }
        .infoModalTbls tr td{
            border:1px solid #dad6d6;
        }
        .infoModal .changeCss {
            background-color: white !important;
            color: #318bd8 !important;
        }
        .infoModal .changeCss:hover {
             background-color: #318bd8 !important;
            color: white !important;
        }
    </style>
    <div class="themetoggle">
        <div>
            <div>
                <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                        <asp:HiddenField runat="server" ID="hdnScrollPos" ClientIDMode="Static" />
                        <fieldset class="field-set">
                            <legend>&nbsp;<b>Filter By</b></legend>
                            <table class="filterTbl  filter-field-table filter-table-gap">
                                <tr>
                                     <td>Company&nbsp;</td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="ddlCompany" CssClass="form-control dropdown-list" AutoPostBack="true" OnSelectedIndexChanged="ddlCompany_SelectedIndexChanged"></asp:DropDownList>
                                    </td>
                                     <td>&nbsp;&nbsp;Plant&nbsp;</td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="ddlPlant" CssClass="form-control dropdown-list" AutoPostBack="true" OnSelectedIndexChanged="ddlPlant_SelectedIndexChanged"></asp:DropDownList>
                                    </td>
                                    <td>&nbsp;&nbsp;Machine&nbsp;</td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="ddlMachine" CssClass="form-control dropdown-list" AutoPostBack="true" OnSelectedIndexChanged="ddlMachine_SelectedIndexChanged"></asp:DropDownList>
                                    </td>
                                    <td>&nbsp;&nbsp;Process Parameter&nbsp;</td>
                                    <td>
                                        <asp:ListBox ID="lbProcessParameters" runat="server" SelectionMode="Multiple" AutoPostBack="true" OnSelectedIndexChanged="lbProcessParameters_SelectedIndexChanged" CssClass="dropdown-list" ClientIDMode="Static" Style="width: 150px"></asp:ListBox>
                                    </td>
                                    </tr>
                                <tr>
                                    <td>Signature ID&nbsp;</td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="ddlSignatureID" CssClass="form-control dropdown-list"></asp:DropDownList>
                                    </td>
                                    <td>&nbsp;&nbsp;Select File&nbsp;</td>
                                    <td>
                                        <asp:FileUpload runat="server" ID="fpFile" CssClass="form-control" />
                                    </td>
                                    <td colspan="4">
                          <asp:Button runat="server" ID="btnImport" ClientIDMode="Static" Text="Import" CssClass="Btns" OnClick="btnImport_Click" />
                                       
                          <asp:Button runat="server" ID="btnView" ClientIDMode="Static" Text="View" CssClass="Btns" OnClick="btnView_Click" />
                                      
                          <asp:Button runat="server" ID="btnSave" ClientIDMode="Static" Text="Save" CssClass="Btns" OnClick="btnSave_Click" />
                                        &nbsp;&nbsp;
                                    <a id="aImportFileTemplate" runat="server" onserverclick="lnlImportFileTemplate_Click" style="font-size: 22px">
                                        <i class="glyphicon glyphicon-download" style="font-size: 19px"></i>Template
                                    </a>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </ContentTemplate>
                    <Triggers>
                        <asp:PostBackTrigger ControlID="aImportFileTemplate" />
                        <asp:PostBackTrigger ControlID="btnImport" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>


            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <div id="gridContainer" style="margin-top: 10px; height: 75vh; width: 95vw; overflow: auto">
                        <asp:GridView ID="gvSignatureComparisionDetails" runat="server" AutoGenerateColumns="false" Width="100%" EmptyDataText="No Data Found." ShowHeaderWhenEmpty="true" ShowHeader="true" ClientIDMode="Static" CssClass="P1Table" OnRowDataBound="gvSignatureComparisionDetails_RowDataBound" ShowFooter="true" border="0">
                            <Columns>
                                <asp:TemplateField HeaderText="Signature ID">
                                    <ItemTemplate>
                                        <asp:HiddenField runat="server" ID="hdnID" ClientIDMode="Static" Value='<%# Eval("Id") %>' />
                                        <asp:HiddenField runat="server" ID="hdnUpdate" ClientIDMode="Static" />
                                        <asp:Label ID="lblSignatureID" runat="server" Text='<%# Eval("SignatureID") %>' ClientIDMode="Static"></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lblSignatureIDNew" runat="server" ClientIDMode="Static"></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Parameter ID">
                                    <ItemTemplate>
                                        <asp:Label ID="lblParemeterID" runat="server" Text='<%# Eval("ParameterID") %>' ClientIDMode="Static"></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lblParemeterIDNew" runat="server" ClientIDMode="Static"></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Seconds">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSeconds" runat="server" Text='<%# Eval("Frequency") %>' ClientIDMode="Static"></asp:Label>
                                        <asp:TextBox runat="server" ID="txtSeconds" Text='<%# Eval("Frequency") %>' ClientIDMode="Static" onchange="setRowAsUpdate(this);" CssClass="form-control decimalPt" AutoCompleteType="Disabled"></asp:TextBox>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox runat="server" ID="txtSecondsNew" ClientIDMode="Static" CssClass="form-control decimalPt" AutoCompleteType="Disabled"></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Signature Value">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSignatureValue" runat="server" Text='<%# Eval("ParameterValue") %>' ClientIDMode="Static"></asp:Label>
                                        <asp:TextBox runat="server" ID="txtSignatureValue" Text='<%# Eval("ParameterValue") %>' ClientIDMode="Static" onchange="setRowAsUpdate(this);" CssClass="form-control decimalPt" AutoCompleteType="Disabled"></asp:TextBox>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox runat="server" ID="txtSignatureValueNew" ClientIDMode="Static" CssClass="form-control decimalPt" AutoCompleteType="Disabled"></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Action">
                                    <ItemTemplate>
                                        <asp:LinkButton runat="server" ID="btnCopySignatureValue" CssClass="glyphicon glyphicon-file" ToolTip="Copy" OnClick="btnCopySignatureValue_Click" Font-Size="18px"></asp:LinkButton>&nbsp;&nbsp;
                                        <asp:LinkButton runat="server" ID="btnChangeSignatureID" CssClass="glyphicon glyphicon-edit" ToolTip="Change" OnClick="btnChangeSignatureID_Click" Font-Size="18px"></asp:LinkButton>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Button runat="server" ID="btnInsert" Text="Add" CssClass="Btns" OnClick="btnInsert_Click" />
                                    </FooterTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                    <div class="modal infoModal" id="copySignatureValueModal" role="dialog" style="min-width: 300px;" data-backdrop="static" data-keyboard="false">
                        <div class="modal-dialog  modal-dialog-centered" style="width: 60%">
                            <div class="modal-content">
                                <div class="modal-header">

                                    <h4 class="modal-title" style="color: white;">Copy Signature Details</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="row" style="margin: 40px 20px;">
                                        <div class="col-lg-12" style="font-size:19px;margin-bottom:20px">
                                            Company:&nbsp; <asp:Label runat="server" ID="lblSrcCopyCompany" ClientIDMode="Static" style="font-size:19px;"></asp:Label>
                                            &nbsp;&nbsp;
                                            Plant:&nbsp;
                                            <asp:Label runat="server" ID="lblSrcCopyPlant" ClientIDMode="Static" style="font-size:19px;"></asp:Label>
                                            
                                        </div>
                                        <div class="col-lg-6">
                                            <table class="infoModalTbls">
                                                <tr>
                                                    <td colspan="2" style="text-align: center">Source</td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 200px;">Machine</td>
                                                    <td>
                                                        <asp:Label runat="server" ID="lblSrcCopyMachine"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td>Signature</td>
                                                    <td>
                                                        <asp:Label runat="server" ID="lblSrcCopySignature"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td>Process Parameter</td>
                                                    <td>
                                                        <asp:Label runat="server" ID="lblSrcCopyParameter"></asp:Label></td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div class="col-lg-6">
                                            <table class="infoModalTbls">
                                                <tr>
                                                    <tr>
                                                        <td colspan="2" style="text-align: center">Destination</td>
                                                    </tr>
                                                    <td>Machine</td>
                                                    <td>
                                                        <asp:DropDownList runat="server" ID="ddlDestiCopyMachine" AutoPostBack="true" OnSelectedIndexChanged="ddlDestiCopyMachine_SelectedIndexChanged" ClientIDMode="Static" CssClass="form-control dropdown-list"></asp:DropDownList></td>
                                                </tr>
                                                <tr>
                                                    <td>Signature</td>
                                                    <td>
                                                        <asp:TextBox runat="server" ID="txtDestiCopySignature" placeholder="yyyymmssHHmmss" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control"></asp:TextBox></td>
                                                </tr>
                                                <tr>
                                                    <td>Process Parameter</td>
                                                    <td>
                                                        <asp:DropDownList runat="server" ID="ddlDestiCopyParameter" ClientIDMode="Static" CssClass="form-control dropdown-list"></asp:DropDownList></td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>

                                </div>
                                <div class="modal-footer">
                                    <asp:Button runat="server" Text="Copy" ID="btnCopy" OnClick="btnCopy_Click" CssClass="Btns" OnClientClick="return signatureCopyValidation();" />
                                    <button type="button" data-dismiss="modal" class="Btns">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal infoModal" id="changeSignatureIDModal" role="dialog" style="min-width: 300px;" data-backdrop="static" data-keyboard="false">
                        <div class="modal-dialog  modal-dialog-centered " style="width: 60%">
                            <div class="modal-content">
                                <div class="modal-header">

                                    <h4 class="modal-title" style="color: white;">Change Signature Details</h4>
                                </div>
                                <div class="modal-body">
                                    <div>
                                        <table style="width: 100%">
                                            <tr>
                                                 <td >Company: &nbsp;
                                                    <asp:Label runat="server" ID="lblChangeSignCompany" ClientIDMode="Static"></asp:Label></td>
                                                 <td >Plant: &nbsp;
                                                    <asp:Label runat="server" ID="lblChangeSignPlant" ClientIDMode="Static"></asp:Label></td>
                                                <td >Machine: &nbsp;
                                                    <asp:Label runat="server" ID="lblChangeSignMachine" ClientIDMode="Static"></asp:Label></td>
                                                <td>Process Parameter:&nbsp;<asp:Label runat="server" ID="lblChangeParameter" ClientIDMode="Static"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                        <div style="margin-top: 20px;">
                                            <fieldset class="masterFS" style="padding: 0px 20px 25px 20px;width:50%">
                                                <legend style="margin-bottom: 15px">Change Signature ID</legend>
                                                <table style="width: 100%">
                                                    <tr>
                                                        <td>From &nbsp;
                                                            <asp:Label runat="server" ID="lblChangeSignIdFrom" ClientIDMode="Static"></asp:Label>
                                                            &nbsp; To   &nbsp;
                                                            <asp:TextBox runat="server" ID="txtChangeSignatureID" placeholder="yyyymmssHHmmss" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control" Style="display: inline-block"></asp:TextBox></td>
                                                        <td>
                                                    </tr>
                                                </table>
                                            </fieldset>

                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <asp:Button runat="server" Text="Save" ID="btnChangeSignature" OnClick="btnChangeSignature_Click" CssClass="Btns" OnClientClick="return signatureChangeValidation();" />
                                    <button type="button" data-dismiss="modal" class="Btns">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal infoModal" id="existingSignatureDataModal" role="dialog" style="min-width: 300px;" data-backdrop="static" data-keyboard="false">
                        <div class="modal-dialog  modal-dialog-centered" style="width: 60%">
                            <div class="modal-content">
                                <div class="modal-header">

                                    <h4 class="modal-title" style="color: white;">Signature Details</h4>
                                </div>
                                <div class="modal-body">
                                    <div style="overflow: auto; height: 70vh">
                                        <asp:ListView runat="server" ID="lvExistingSignature" ClientIDMode="Static" OnItemDataBound="lvExistingSignature_ItemDataBound">
                                            <LayoutTemplate>
                                                <table class="P1Table" id="tblExistingSignature">
                                                    <tr>
                                                        <th>Signature ID</th>
                                                        <th>Process Parameter</th>
                                                        <th>Select</th>
                                                    </tr>
                                                    <tr id="itemplaceholder" runat="server"></tr>
                                                </table>
                                            </LayoutTemplate>
                                            <ItemTemplate>
                                                <tr>
                                                    <td>
                                                        <asp:HiddenField runat="server" ID="hdnComany" Value='<%# Eval("Company") %>' />
                                                        <asp:HiddenField runat="server" ID="hdnPlant" Value='<%# Eval("Plant") %>' />
                                                        <asp:HiddenField runat="server" ID="hdnMachine" Value='<%# Eval("MachineID") %>' />
                                                        <asp:HiddenField runat="server" ID="hdnSignatureID" Value='<%# Eval("SignatureID") %>' />
                                                        <asp:Label runat="server" ID="lblSignatureID" Text='<%# Eval("SignatureID") %>'></asp:Label>
                                                        <asp:TextBox runat="server" ID="txtSignature" CssClass="form-control" Text='<%# Eval("SignatureID") %>' ClientIDMode="Static"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:Label runat="server" ID="lblParameter" Text='<%# Eval("ParameterID") %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:CheckBox runat="server" ID="chkSelect" ClientIDMode="Static" Checked="true" />
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:ListView>
                                        <%--<asp:ListView runat="server" ID="lvExistingSignature" ClientIDMode="Static">
                                            <LayoutTemplate>
                                                <table>
                                                    <tr id="itemplaceholder" runat="server"></tr>
                                                </table>
                                            </LayoutTemplate>
                                            <ItemTemplate>
                                                <tr>
                                                    <td>
                                                        <table>
                                                            <tr>
                                                                <td>Process Parameter -
                                                                    <asp:Label runat="server" ID="lblParameter" Text='<%# Eval("ParameterID") %>'></asp:Label></td>
                                                                <td>Machine -
                                                                    <asp:Label runat="server" ID="lblMachine" Text='<%# Eval("MachineID") %>'></asp:Label>
                                                                    <asp:HiddenField runat="server" ID="hdnSignatureID" Value='<%# Eval("SignatureID") %>' />
                                                                </td>
                                                                <td>
                                                                    <asp:CheckBox runat="server" ID="chkSelect" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="3">
                                                                    <asp:GridView runat="server" AutoGenerateColumns="false" DataSource='<%# Eval("SignatureData") %>' CssClass="P1Table">
                                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="Signature ID">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox runat="server" ID="txtSignature" CssClass="form-control" Text='<%# Eval("SignatureID") %>'></asp:TextBox>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Seconds">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox runat="server" ID="txtSeconds" CssClass="form-control" Text='<%# Eval("Frequency") %>'></asp:TextBox>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Signature Value">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox runat="server" ID="txtSignatureValue" CssClass="form-control" Text='<%# Eval("ParameterValue") %>'></asp:TextBox>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                    </asp:GridView>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:ListView>--%>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <asp:Button runat="server" Text="Overwrite" ID="btnOverwrite" CssClass="Btns" OnClick="btnOverwrite_Click" OnClientClick="return overWriteValidation('tblExistingSignature');" />
                                    <asp:Button runat="server" Text="Change" ID="btnChange" CssClass="Btns" OnClick="btnChange_Click" OnClientClick="return clearModalScreen();" />
                                    <asp:Button runat="server" Text="Save" ID="btnChangeSave" CssClass="Btns changeCss" OnClick="btnChangeSave_Click" OnClientClick="return existingDataSaveValidation('tblExistingSignature');" />
                                    <asp:Button runat="server" Text="Cancel" ID="btnChangeCancel" CssClass="Btns changeCss" OnClick="btnChangeCancel_Click" OnClientClick="return clearModalScreen();" />
                                    <asp:Button runat="server" Text="Cancel" ID="btnCancel" CssClass="Btns" data-dismiss="modal" />
                                </div>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnView" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>

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
    </div>
    <script>
        $(document).ready(function () {
        });
        function openErrorModal(msg) {
            $('#errorModal').modal('show');
            $('#lblErrorMsg').text(msg);
        }
        function overWriteValidation(gridID) {
            debugger;
            if (!isCheckBoxSelectedForSaveFun(gridID)) {
                openWarningModal("Please select checkbox.");
                return false;
            }
            $(".modal-backdrop").removeClass("modal-backdrop in");
            return true;
        }
        function existingDataSaveValidation(gridID) {
            var tbl = $('#' + gridID)[0];
            var noOfRow = tbl.rows.length;
            if (noOfRow > 1) {
                var noOfCheckedCount = 0;
                for (var i = 1; i < noOfRow; i++) {
                    var tr = tbl.rows[i];
                    var chk = $(tr).find("#chkSelect")[0];
                    if ($(chk).prop("checked")) {
                        debugger;
                        noOfCheckedCount++;
                        var txtSigntureid = $(tr).find("#txtSignature")[0];
                        var company = $(tr).find("#hdnComany")[0];
                        var plant = $(tr).find("#hdnPlant")[0];
                        var machine = $(tr).find("#hdnMachine")[0];
                        var parameter = $(tr).find("#lblParameter")[0];
                        if ($(txtSigntureid).val().trim() == "") {
                            openWarningModal("Please enter Signature ID for Process Parameter " + $(parameter).text() + ".");
                            return false;
                        }
                        else {

                            if (isSignatureIDExist($(company).val(),$(plant).val(),$(machine).val(), $(parameter).text(), $(txtSigntureid).val().trim())) {
                                openWarningModal("Signature ID " + $(txtSigntureid).val() + " already assigned to Process Parameter " + $(parameter).text() + ". Please enter new Signature ID.");
                                return false;
                            }
                        }
                    }
                }
                if (noOfCheckedCount > 0) {
                    isChecked = true
                }
                else {
                    openWarningModal("Please select checkbox.");
                    return false;
                }
            }
            else {
                return false;
            }
            $(".modal-backdrop").removeClass("modal-backdrop in");
            return true;
        }
        function isCheckBoxSelectedForSaveFun(gridID) {
            var isChecked = false;
            var tbl = $('#' + gridID)[0];
            var noOfRow = tbl.rows.length;
            if (noOfRow > 1) {
                var noOfCheckedCount = 0;
                for (var i = 1; i < noOfRow; i++) {
                    var tr = tbl.rows[i];
                    var chk = $(tr).find("#chkSelect")[0];
                    if ($(chk).prop("checked")) {
                        noOfCheckedCount++;
                        break;
                    }
                }
                if (noOfCheckedCount > 0) {
                    isChecked = true
                }
            }

            return isChecked;
        }
        function setRowAsUpdate(txt) {
            debugger;
            $(txt).closest('tr').find("#hdnUpdate").val("update");
        }
        function signatureChangeValidation() {
            if ($('#txtChangeSignatureID').val() == "") {
                openWarningModal("Please enter Signature ID.");
                return false;
            }

            if (isSignatureIDExist($('#lblChangeSignCompany').text(),$('#lblChangeSignPlant').text(),$('#lblChangeSignMachine').text(), $('#lblChangeParameter').text(), $('#txtChangeSignatureID').val())) {
                openWarningModal("Signature ID already exists.");
                return false;
            }
            $(".modal-backdrop").removeClass("modal-backdrop in");
            return true;
        }
        function signatureCopyValidation() {
            if ($('#ddlDestiCopyMachine').val() == "") {
                openWarningModal("Please select Machine.");
                return false;
            }
            if ($('#txtDestiCopySignature').val() == "") {
                openWarningModal("Please enter Signature ID.");
                return false;
            }
            if ($('#ddlDestiCopyParameter').val() == "") {
                openWarningModal("Please select Process Parameter.");
                return false;
            }
            if (isSignatureIDExist($('#lblSrcCopyCompany').text(),$('#lblSrcCopyPlant').text(), $('#ddlDestiCopyMachine').val(), $('#ddlDestiCopyParameter').val(), $('#txtDestiCopySignature').val())) {
                openWarningModal("Signature already exist.");
                return false;
            }
            $(".modal-backdrop").removeClass("modal-backdrop in");
            return true;
        }
        function isSignatureIDExist(company1,plant1, machine1, parameter1, signature1) {
            var isExist = false;
            $.ajax({
                async: false,
                type: "POST",
                url: "SignatureComparisonMaster.aspx/isSignatureIDExistForValidation",
                contentType: "application/json; charset=utf-8",
                data: '{company:"' + company1 + '",plant:"' + plant1 + '",machine:"' + machine1 + '",parameter:"' + parameter1 + '",signature:"' + signature1 + '"}',
                datatype: "json",
                success: function (response) {
                    var itemdata = response.d;
                    isExist = itemdata;
                },
                error: function (jqXHR, textStatus, err) {
                    console.log(err);
                }
            });
            return isExist;
        }
        $('[id$=lbProcessParameters]').multiselect({
            includeSelectAllOption: true
        });
        function openCopySignatureValueModal() {
            $('[id*=copySignatureValueModal]').modal('hide');
            $(".modal-backdrop").removeClass("modal-backdrop in");
            $('[id*=copySignatureValueModal]').modal('show');
        }
        function openExistingSignatureDataModal() {
            //  $('[id*=existingSignatureDataModal]').modal('hide');
            //  $(".modal-backdrop").removeClass("modal-backdrop in");
            $('[id*=existingSignatureDataModal]').modal('show');
        }
        function openChangeSignatureIDModal() {
            $('[id*=changeSignatureIDModal]').modal('hide');
            $(".modal-backdrop").removeClass("modal-backdrop in");
            $('[id*=changeSignatureIDModal]').modal('show');
        }
        function openWarningModal(msg) {
            $('#lblWarningMsg').text(msg);
            $('[id*=warningModal]').modal('show');
        }
        function clearModalScreen() {
            $(".modal-backdrop").removeClass("modal-backdrop in");
            return true;
        }
        $('.decimalPt').keypress(function (evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            var pos = evt.target.selectionStart;
            if (charCode == 45 && pos != 0) {
                return false;
            } else if (charCode == 43 && pos != 0) {
                return false;
            } else if (charCode == 46 && $(this).val().indexOf('.') != -1) {
                return false;
            } else if (charCode > 31 && charCode != 46 && (charCode < 48 || charCode > 57) && charCode != 45 && charCode != 43) {
                return false;
            }
            return true;
        });
        var bigDiv = document.getElementById('gridContainer');
        bigDiv.onscroll = function () {
            $('[id*=hdnScrollPos]').val(bigDiv.scrollTop);
            console.log("id scroll =" + $('[id*=hdnScrollPos]').val());
        }
        window.onload = function () {
            bigDiv.scrollTop = $('[id*=hdnScrollPos]').val();
        }
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
            var bigDiv = document.getElementById('gridContainer');
            $(document).ready(function () {
                bigDiv.scrollTop = $('[id*=hdnScrollPos]').val();
            });
            bigDiv.onscroll = function () {
                $('[id*=hdnScrollPos]').val(bigDiv.scrollTop);
                console.log("id scroll =" + $('[id*=hdnScrollPos]').val());
            }
            window.onload = function () {
                bigDiv.scrollTop = $('[id*=hdnScrollPos]').val();
            }
            function setRowAsUpdate(txt) {
                $(txt).closest('tr').find("#hdnUpdate").val("update");
            }
            $('[id$=lbProcessParameters]').multiselect({
                includeSelectAllOption: true
            });
            $('.decimalPt').keypress(function (evt) {
                evt = (evt) ? evt : window.event;
                var charCode = (evt.which) ? evt.which : evt.keyCode;
                var pos = evt.target.selectionStart;
                if (charCode == 45 && pos != 0) {
                    return false;
                } else if (charCode == 43 && pos != 0) {
                    return false;
                } else if (charCode == 46 && $(this).val().indexOf('.') != -1) {
                    return false;
                } else if (charCode > 31 && charCode != 46 && (charCode < 48 || charCode > 57) && charCode != 45 && charCode != 43) {
                    return false;
                }
                return true;
            });
        });
    </script>
</asp:Content>