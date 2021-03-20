<%@ Page Title="Manage Account" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageAccount.aspx.cs" Inherits="NewProject.ManageAccount" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        dl dt {
            width: 200px;
        }
    </style>
    <h2><%: Title %>.</h2>

    <div>
        <asp:PlaceHolder runat="server" ID="successMessage" Visible="false" ViewStateMode="Disabled">
            <p class="text-success"><%: SuccessMessage %></p>
        </asp:PlaceHolder>
    </div>

    <div class="row">
        <div class="col-md-12">
            <div class="form-horizontal">
                <h4>Change your account settings</h4>
                <hr />
                <dl class="dl-horizontal">
                    <dt>Password:</dt>
                    <dd>
                        <asp:HyperLink NavigateUrl="~/ManagePassword" Text="[Change]" Visible="false" ID="ChangePassword" runat="server" />
                        <asp:HyperLink NavigateUrl="~/ManagePassword" Text="[Create]" Visible="false" ID="CreatePassword" runat="server" />
                    </dd>
                    <dt>External Logins:</dt>
                    <dd><%: LoginsCount %>
                        <asp:HyperLink NavigateUrl="/ManageExternalLogins" Text="[Manage]" runat="server" />
                    </dd>

                    <dt>Phone Number:</dt>
                    <% if (HasPhoneNumber)
                        { %>
                    <dd>
                        <asp:HyperLink NavigateUrl="/AddPhoneNumber" runat="server" Text="[Add]" />
                    </dd>
                    <% }
                        else
                        { %>
                    <dd>
                        <asp:Label Text="" ID="PhoneNumber" runat="server" />
                        <asp:HyperLink NavigateUrl="/AddPhoneNumber" runat="server" Text="[Change]" />
                        &nbsp;|&nbsp;
                        <asp:LinkButton Text="[Remove]" OnClick="RemovePhone_Click" runat="server" />
                    </dd>
                    <% } %>


                    <dt>Two-Factor Authentication:</dt>
                    <dd>
                        <p>
                            There are no two-factor authentication providers configured.
                        </p>
                        <% if (TwoFactorEnabled)
                            { %> 
                        
                        Enabled
                        <asp:LinkButton Text="[Disable]" runat="server" CommandArgument="false" OnClick="TwoFactorDisable_Click" />

                        <% }
                            else
                            { %> 
                        
                        Disabled
                        <asp:LinkButton Text="[Enable]" CommandArgument="true" OnClick="TwoFactorEnable_Click" runat="server" />

                        <% } %>
                    </dd>

                    <dt>TOTP Authenticator : </dt>
                    <dd>
                        <% if (TotpAuthenticatorEnabled)
                            { %> 
                        
                        Enabled
                        <asp:LinkButton Text="[Disable]" runat="server" CommandArgument="false" OnClick="TotpAuthenticatorDisable_Click" />

                        <% }
                            else
                            { %> 
                        
                        Disabled
                        <asp:LinkButton Text="[Enable]" CommandArgument="true" OnClick="TotpAuthenticatorEnable_Click" runat="server" />

                        <% } %>
                    </dd>
                </dl>
            </div>
        </div>
    </div>
</asp:Content>
