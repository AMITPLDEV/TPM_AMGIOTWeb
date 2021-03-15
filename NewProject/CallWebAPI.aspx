<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CallWebAPI.aspx.cs" Inherits="NewProject.CallWebAPI" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <script src="Scripts/jquery-3.3.1.js"></script>
    <link href="Content/bootstrap.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
    </form>
    <script type="text/javascript">
        $(document).ready(function () {
            callAPI();
        });
          
        function callAPI() {
            $.ajax({
                async: false,
                type: "POST",
               // url: '<%= ResolveUrl("ProcessParameterSignatureComparison.aspx/getSignatureIDs") %>',
                url: 'https://api-idap.infinite-uptime.com/login',
                contentType: "application/json; charset=utf-8",
                crossDomain: true,
                data: '{email: "demouser10@demo.com", password:"demouser10"}',
                dataType: "json",
                success: function (response) {
                    dataitem = response.d;
                    debugger;
                },
                error: function (Result) {
                    alert("Error" + Result);
                }
            });
        }
    </script>
</body>
</html>
