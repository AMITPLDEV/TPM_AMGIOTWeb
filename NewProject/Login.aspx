<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="NewProject.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
      <style>
        body {
            /*background-color: #615f5d;*/
            width: 100vw;
            height: 100vh;
            font-family: sans-serif;
            /*background-image: url("Images/acnc login grey.jpg");*/
            /*background-image: url("Images/acnc login red.jpg");*/
            /*background-image: url("Images/LoginBackgroundImg.PNG");*/
            background-repeat: no-repeat;
            background-size: cover;
            margin: 0px;
        }

        .loginContainer {
            width: 310px;
            /*position: absolute;
            top: 25%;
            left: 20%;*/
            /*transform: translate(-50%,-50%);*/
            background-color: white;
            padding: 2% 2% 2% 2%;
            border-radius: 8px;
            margin: auto;
        }

            .loginContainer h2 {
                margin: 10px 0px 10% 0px;
                text-align: center;
                font-weight: bold;
                color: #100e0e;
            }

            .loginContainer input {
                margin-bottom: 50px;
                padding: 10px 0px;
                width: 100%;
                outline: none;
                border: none;
                /*border-bottom: 2px solid #ed8139;*/
                border-bottom: 2px solid black;
            }

        #loginBtn {
            width: 100%;
            border: 1px solid black;
            color: white;
            background-color: black;
            font-size: 20px;
            box-shadow: 5px 5px 5px rgba(1,1,1,0.2);
            border-radius: 20px;
            padding: 15px 10px;
            outline: none;
        }
         #btnLogin {
            width: 100%;
            border: 1px solid black;
            color: white;
            background-color: black;
            font-size: 20px;
            box-shadow: 5px 5px 5px rgba(1,1,1,0.2);
            border-radius: 20px;
            padding: 15px 10px;
            outline: none;
        }
          #btnLogin:hover {
                background-color: black;
                color: white;
                box-shadow: 3px 5px 10px rgba(1,1,1,0.3);
                font-size: 20px;
            }

            #loginBtn:hover {
                background-color: black;
                color: white;
                box-shadow: 3px 5px 10px rgba(1,1,1,0.3);
                font-size: 20px;
            }

        .loginContainer div {
            position: relative;
        }

            .loginContainer div label {
                position: absolute;
                top: 10px;
                left: 0px;
                pointer-events: none;
                color: #a1978d;
                transition: .5s;
                font-size: 15px;
                font-family: sans-serif;
                font-weight: 600;
            }

        .loginContainer input:focus ~ label, .loginContainer input:valid ~ label {
            top: -12px;
            left: 0px;
            font-size: 13px;
            color: #100e0e;
            font-family: sans-serif;
            font-weight: 600;
        }

        .loginContainer input:focus, .loginContainer input:valid {
            border-bottom: 2px solid black;
        }

        .userImage {
            position: relative;
            left: 42%;
            font-size: 50px;
            background-color: gray;
            border-radius: 30px;
            padding: 7px;
            margin-bottom: 5px;
        }

            .userImage i {
                color: white;
            }

        .HeaderImage {
            flex: 1;
            float: left;
        }

        .slanted {
            position: relative;
            height: 100vh;
            background: #333333;
            float: left;
            float: left;
            
        }
            .slanted:after,
            .slanted:before {
                content: "";
                position: absolute;
                top: 0;
                width: 0;
                height: 0;
            }

            .slanted.slanted-left {
                width: 90%;
            }
        .slanted-left.slant-to-left:after {
            right: 0;
            /*border-left: 380px solid #000000;*/
              border-left: 250px solid white;
            border-bottom: 100vh solid #828282;
        }
          .loginContainer {
              position: absolute;
              right: 8%;
              bottom: 20%;
              border: 1px solid black;
          }
    </style>
</head>
<body>
    <%-- style="background-image:url('Images/LoginScreenLogo.PNG'); background-repeat:no-repeat;background-size:cover;width:90vw;height:90vh;background-size:60vw 100vh"--%>
    <form id="form1" runat="server">
         <div style="display: flex">
            <div style="background-color: white; display: table;background-image:url('Images/LoginScreenLogo.PNG'); background-repeat:no-repeat;background-size:contain" class="slanted slanted-left slant-to-left">
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
                            <input type="text" id="txtUsername" runat="server" autocomplete="off" required="required" />
                            <label>User ID</label>
                        </div>
                        <div>
                            <input type="password" id="txtPassword" runat="server" required="required" />
                            <label>Password</label>
                        </div>
                     <%--   <button type="button" id="loginBtn" onclick="window.location.href='ProductionOEEDashboard.aspx'" runat="server">Login</button>--%>
                        <asp:Button runat="server" ID="btnLogin" OnClick="btnLogin_Click" Text="Login"/>
                        <br />
                        <br />
                        <div style="text-align: center; height: 30px">
                            <span id="lblErrorMsg" runat="server" visible="false" style="color: #bf0808; font-weight: 500;">Invalid username or password.</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
         
     <%--   <div class="loginContainer">
                        <h2>Sign in</h2>
                        <div style="margin-top: 50px">
                            <input type="text" id="txtUsername" runat="server" autocomplete="off" required="required" />
                            <label>User ID</label>
                        </div>
                        <div>
                            <input type="password" id="txtPassword" runat="server" required="required" />
                            <label>Password</label>
                        </div>
                        <button type="button" id="loginBtn" onclick="window.location.href='ProductionOEEDashboard.aspx'" runat="server">Login</button>
                        
                        <br />
                        <br />
                        <div style="text-align: center; height: 30px">
                            <span id="errorMsg" runat="server" visible="false" style="color: #bf0808; font-weight: 500;">Invalid username or password.</span>
                        </div>
                    </div>--%>
            
    </form>
     <script>
            localStorage.removeItem("selectedMenu");
            localStorage.removeItem("selectedMenuID");
            localStorage.removeItem("selectedSubMenu");
    </script>
</body></html>
