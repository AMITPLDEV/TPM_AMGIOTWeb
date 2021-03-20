<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginInitial.aspx.cs" Inherits="NewProject.LoginInitial" %>

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
                        <h2>Sign in</h2>
                        <div style="margin-top: 50px">
                            <input type="text" id="txtCorporateID" runat="server" autocomplete="off" required="required" />
                            <label>Corporate ID</label>
                        </div>
                        <div>
                            <input type="text" id="txtUserName" runat="server" autocomplete="off" required="required" />
                            <label>UserName</label>
                        </div>
                        <asp:Button runat="server" ID="btnLogin" OnClick="btnLogin_Click" Text="Next" />
                        <br />
                        <br />
                        <div style="text-align: center; height: 30px">
                            <span id="lblErrorMsg" runat="server" visible="false" style="color: #bf0808; font-weight: 500;">Invalid username or password.</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script>
        localStorage.removeItem("selectedMenu");
        localStorage.removeItem("selectedMenuID");
        localStorage.removeItem("selectedSubMenu");
    </script>
</body>
</html>
