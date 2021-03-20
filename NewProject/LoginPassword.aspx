<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginPassword.aspx.cs" Inherits="NewProject.LoginPassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <link href="Content/Login.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div style="display: flex">
            <div style="background-color: white; display: table; background-image: url('Images/LoginScreenLogo.PNG'); background-repeat: no-repeat; background-size: contain" class="slanted slanted-left slant-to-left">
                <div style="color: white; font-size: 88px; position: absolute; top: 122px; left: 100px">
                </div>
            </div>
            <div style="display: table; height: 100vh; width: 45%; background-color: #828282;">
                <div style="display: table-cell; vertical-align: middle">
                    <div class="loginContainer">
                        <h2>Enter Password</h2>
                        <div style="margin-top: 50px">
                            <input type="password" id="txtPassword" runat="server" autocomplete="off" required="required" />
                            <label>Password</label>
                        </div>
                        <div class="checkbox" style="margin-top: 20px">
                            <asp:CheckBox runat="server" ID="RememberMe" />
                            <asp:Label runat="server" AssociatedControlID="RememberMe">Remember me?</asp:Label>
                        </div>
                        <asp:Button runat="server" ID="btnLogin" OnClick="btnLogin_Click" Text="Login" />
                        <br />
                        <br />
                        <button type="submit" runat="server" id="btnAzureADLogin" class="btn btn-default" name="provider" value="Microsoft" title="Log in using your Microsoft account." visible="false">Microsoft</button>
                        <div style="text-align: center; height: 30px">
                            <span id="lblErrorMsg" runat="server" visible="false" style="color: #bf0808; font-weight: 500;">Invalid password.</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
