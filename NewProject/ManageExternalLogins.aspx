<%@ Page Title="Manage External Logins" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageExternalLogins.aspx.cs" Inherits="NewProject.ManageExternalLogins" %>

<%@ Register Src="~/OpenAuthProviders.ascx" TagPrefix="extLogins" TagName="OpenAuthProviders" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Manage your external logins.</h2>
    <asp:PlaceHolder runat="server" ID="successMessage" Visible="false" ViewStateMode="Disabled">
        <p class="text-success"><%: SuccessMessage %></p>
    </asp:PlaceHolder>
    <div>
        <section id="externalLoginsForm">
            <asp:ListView runat="server"
                ItemType="Microsoft.AspNet.Identity.UserLoginInfo"
                SelectMethod="GetLogins" DeleteMethod="RemoveLogin" DataKeyNames="LoginProvider,ProviderKey">

                <LayoutTemplate>
                    <h4>Registered Logins</h4>
                    <table class="table">
                        <tbody>
                            <tr runat="server" id="itemPlaceholder"></tr>
                        </tbody>
                    </table>

                </LayoutTemplate>
                <ItemTemplate>
                    <tr>
                        <td><%#: Item.LoginProvider %></td>
                        <td>
                            <asp:Button runat="server" Text="Remove" CommandName="Delete" CausesValidation="false"
                                ToolTip='<%# "Remove this " + Item.LoginProvider + " login from your account" %>'
                                Visible="<%# CanRemoveExternalLogins %>" CssClass="btn btn-default" />
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:ListView>
        </section>
    </div>
    <div>
        <extLogins:OpenAuthProviders runat="server" ReturnUrl="~/ManageExternalLogins" />
    </div>
</asp:Content>
