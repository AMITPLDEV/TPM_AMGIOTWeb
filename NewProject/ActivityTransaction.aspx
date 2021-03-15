<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ActivityTransaction.aspx.cs" Inherits="NewProject.ActivityTransaction" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="themetoggle" style="">
        <div>
            <fieldset class="field-set" style="display: inline-block;">
                <legend>&nbsp;<b>Filter By</b></legend>
                <table class="filterTbl filter-field-table">
                    <tr>
                        <td>Machine ID</td>
                        <td>
                            <asp:DropDownList runat="server" ID="ddlMachineID" CssClass="form-control dropdown-list" ClientIDMode="Static"></asp:DropDownList>
                        </td>
                        <td>Frequency</td>
                        <td>
                            <asp:DropDownList runat="server" ID="ddlFrequency" CssClass="form-control dropdown-list" ClientIDMode="Static"></asp:DropDownList>
                        </td>
                        <td>&nbsp;&nbsp;<asp:Button runat="server" ID="btnActivityTransactionView" ClientIDMode="Static" Text="View" CssClass="Btns" />
                         <%--   &nbsp;&nbsp;<asp:Button runat="server" ID="btnActivityTransactionSave" ClientIDMode="Static" Text="Save" CssClass="Btns" />--%>
                            &nbsp;&nbsp;<asp:Button runat="server" ID="btnActivityTransactionExport" ClientIDMode="Static" Text="Export" CssClass="Btns" />

                        </td>
                    </tr>
                </table>
            </fieldset>
             <div>
                <input type="button" value="Activity Completed" class="btn" style="background-color: red" />
            </div>
        </div>
        <div id="gvGroupConatiner" class="gridContainer" style="margin-top: 10px; width: 95vw; overflow: auto">
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <asp:GridView ID="gvActivityTransactionDetails" runat="server" AutoGenerateColumns="false" Width="100%" EmptyDataText="No Data Found." ShowHeaderWhenEmpty="true" ShowHeader="true" ShowFooter="false" ClientIDMode="Static" CssClass="P1Table select-onecheckbox-eachrow" OnRowDataBound="gvActivityTransactionDetails_RowDataBound">
                        <Columns>
                            <asp:TemplateField HeaderText="Sl. No." meta:resourcekey="TemplateFieldResource2">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblSlNo" Text='<%#Eval("Sl No")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Activity" meta:resourcekey="TemplateFieldResource2">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblActivity" Text='<%#Eval("Activity")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Frequency" meta:resourcekey="TemplateFieldResource2">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblFrequency" Text='<%#Eval("Frequency")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Last Update" meta:resourcekey="TemplateFieldResource2">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lblLastUpdate" Text='<%#Eval("LastUpdate")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
                <Triggers>
                    <%--<asp:AsyncPostBackTrigger ControlID="btnLoginConfirmation" EventName="Click" />--%>
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>

    <div class="modal infoModal" id="loginConfirmationModal" role="dialog" style="min-width: 300px;" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modal-dialog-centered " style="width: 22%">
            <div class="modal-content modalThemeCss">
                <div class="modal-header">
                    <h4 class="modal-title">Credentials Required</h4>
                </div>
                <div class="modal-body" style="padding-left: 0px; padding-right: 0px">
                    <span style="color: red; margin-left: 20px;" class="mandatory-message"></span>
                    <div style="padding-left: 15px; padding-right: 15px; padding-bottom: 8px;">
                        <table style="width: 100%; margin: auto">
                            <tr>
                                <td>User ID *</td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtUserid" CssClass="form-control" AutoCompleteType="Disabled" ClientIDMode="Static"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-top: 32px">Password *</td>
                                <td style="padding-top: 32px">
                                    <asp:TextBox runat="server" ID="txtPassword" CssClass="form-control" TextMode="Password" AutoCompleteType="Disabled" ClientIDMode="Static"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </div>
            </div>
            <div class="modal-footer">
                <asp:Button runat="server" ID="btnLoginConfirmation" Text="Login" CssClass="Btns" OnClientClick="return btnLoginConfirmationClick();" />
                <button type="button" data-dismiss="modal" class="Btns">Close</button>
                <asp:Button runat="server" ID="btnActivityTransactionSave" ClientIDMode="Static" Text="Save" CssClass="Btns" OnClientClick="return btnActivityTransactionSaveClick();" />
            </div>
        </div>
    </div>
    </div>
    <script>
        var activity = "", machineid="",frequency="",monthyearheader="";
        $("#gvActivityTransactionDetails tr td").click(function () {
            let tdValue = $(this).text();
            if (tdValue.trim() == "P") {
                let tdindex = $("#gvActivityTransactionDetails tr td").index($(this));
                let header = $("#gvActivityTransactionDetails tr th")[tdindex];
                activity = $(this).closest('tr').find("#lblActivity").text();
                frequency = $(this).closest('tr').find("#lblFrequency").text();
                monthyearheader = $(header).text();
                machineid = $("#ddlMachineID").val();
                $(".mandatory-message").text("");
                $("#txtUserid").val("");
                $("#txtPassword").val("");
                $("#btnActivityTransactionSave").css("display", "none");
                $("#loginConfirmationModal").modal('show');
            }
        });

        function btnLoginConfirmationClick() {
            //what to check
            let userid = $("#txtUserid").val();
            let password = $("#txtPassword").val();
            if (userid == "") {
                $(".mandatory-message").text("User ID required.");
                return false;
            }
            if (password == "") {
                $(".mandatory-message").text("Password required.");
                return false;
            }
            if (userid == "pct" && password == "pct") {
                $(".mandatory-message").text("Successful.");
                $(".mandatory-message").css("color", "green");
                $("#btnActivityTransactionSave").css("display", "inline-block");
            } else {
                 $(".mandatory-message").text("Un Successful.");
                $(".mandatory-message").css("color", "red");
                $("#btnActivityTransactionSave").css("display", "none");
            }
            return false;
        }
        function btnActivityTransactionSaveClick() {

            return false;
        }
    </script>
</asp:Content>
