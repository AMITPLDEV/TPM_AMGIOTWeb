<%@ Page Title="Enable Authenticator Login" Language="C#" MasterPageFile="~/Unauthenticated.Master" AutoEventWireup="true" CodeBehind="EnableAuthenticatorLogin.aspx.cs" Inherits="NewProject.EnableAuthenticatorLogin" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="jumbotron">
            <h2 class="text-info text-center">Set TOTP Authenticator</h2>
            <hr />
            <div class="row">
                <div class="col-md-12">
                    <div class="section">
                        <h3 class="text-info">Step 1: Install Any Authenticator App  
                        </h3>
                        <p>
                            Download a two-factor authenticator app like Microsoft Authenticator for
                <a href="https://go.microsoft.com/fwlink/?Linkid=825071">Windows Phone</a>,
                <a href="https://go.microsoft.com/fwlink/?Linkid=825072">Android</a> and
                <a href="https://go.microsoft.com/fwlink/?Linkid=825073">iOS</a> or
                Google Authenticator for
                <a href="https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2&amp;hl=en">Android</a> and
                <a href="https://itunes.apple.com/us/app/google-authenticator/id388497605?mt=8">iOS</a>.
                        </p>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="section">
                        <h3 class="text-info">Step 2: Link your device to your account:  
                        </h3>
                        <p>You have two options to link your device to your account:</p>
                        <p><b>Using QR Code:</b> Select<b> Scan a barcode</b>. If the Authenticator app cannot locate a barcode scanner app on your mobile device, you might be prompted to download and install one. If you want to install a barcode scanner app so you can complete the setup process, select Install, then go through the installation process. Once the app is installed, reopen TOTP Authenticator app, then point your camera at the QR code on your computer screen.</p>

                        <p>
                            <b>Using Secret Key:</b>
                            Select <b>Enter provided key</b>, then enter account name of your account in the <b>"Enter account name"</b> box. Next, enter the secret key appear on your computer screen in the <b>"Enter your key"</b> box. Make sure you've chosen to make the key Time based, then select Add.  
                        </p>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="col-md-4">
                        <asp:Image ID="imgQrCode" runat="server" />
                    </div>
                    <div class="col-md-6">
                        <div>
                            <span style="font-weight: bold; font-size: 14px;">Account Name:</span>
                        </div>
                        <div>
                            <asp:Label runat="server" ID="lblAccountName"></asp:Label>
                        </div>

                        <div>
                            <span style="font-weight: bold; font-size: 14px;">Secret Key:</span>
                        </div>
                        <div>
                            <asp:Label runat="server" ID="lblManualSetupCode"></asp:Label>
                        </div>
                        <div>
                            <asp:ValidationSummary runat="server" CssClass="text-danger" />
                        </div>
                    </div>
                </div>
                <div class="clearfix"></div>
                <div class="col-md-12" style="margin-top: 2%">
                    <div class="form-group col-md-4">
                        <asp:TextBox runat="server" CssClass="form-control" ID="txtSecurityCode" MaxLength="50" ToolTip="Please enter security code you get on your authenticator application">  
                        </asp:TextBox>
                    </div>
                    <asp:Button ID="btnValidate" OnClick="btnValidate_Click" CssClass="btn btn-primary" runat="server" Text="Validate" />
                </div>
                <h3>Result:</h3>
                <div class="alert alert-success col-md-12" runat="server" role="alert">
                    <asp:Label ID="lblResult" runat="server" Text=""></asp:Label>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

