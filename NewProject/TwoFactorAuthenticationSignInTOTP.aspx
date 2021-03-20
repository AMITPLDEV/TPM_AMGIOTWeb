<%@ Page Title="TOTP Authentication" Language="C#" MasterPageFile="~/Unauthenticated.Master" AutoEventWireup="true" CodeBehind="TwoFactorAuthenticationSignInTOTP.aspx.cs" Inherits="NewProject.TwoFactorAuthenticationSignInTOTP" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %>.</h2>

    <div class="form-horizontal">
        <h4>Enter Authenticator Code</h4>
        <hr />
        <asp:ValidationSummary runat="server" CssClass="text-danger" />
        <p class="text-danger">
            <asp:Literal runat="server" ID="ErrorMessage" />
        </p>
        <div class="row">
            <div class="col-md-12">
                <div class="section">
                    <p>Open Authenticator app on your smartphone and enter the Time based OTP (TOTP) code generated there. </p>
                </div>
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="AuthenticatorTOTP" CssClass="col-md-2 control-label">Verify TOTP Code : </asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="AuthenticatorTOTP" CssClass="form-control" TextMode="SingleLine" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="AuthenticatorTOTP"
                    CssClass="text-danger" ErrorMessage="The TOTP code is required." />
            </div>
        </div>
        <div class="form-group">
            <div class="col-md-offset-2 col-md-10">
                <asp:Button runat="server" OnClick="VerifyTOTP_Click" Text="Verify Code" CssClass="btn btn-default" />
            </div>
        </div>
    </div>
</asp:Content>
