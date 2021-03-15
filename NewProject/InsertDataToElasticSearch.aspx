<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InsertDataToElasticSearch.aspx.cs" Inherits="NewProject.InsertDataToElasticSearch" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:FileUpload ID="fileprodOrder" runat="server" Style="width: 400px; height: 40px; display: inline-block;" CssClass="form-control input-sm" />&nbsp;
			<asp:LinkButton ID="lnkbtnImportFile" CssClass="glyphicon glyphicon-import" runat="server" ToolTip="Import" Font-Size="25px" Style="display: inline-block; vertical-align: middle" OnClick="lnkbtnImportFile_Click"  Text="click"/>
        </div>
    </form>
</body>
</html>
