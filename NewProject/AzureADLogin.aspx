<%@ Page Title="Azure AD Login" Language="C#" MasterPageFile="~/Unauthenticated.Master" AutoEventWireup="true" CodeBehind="AzureADLogin.aspx.cs" Inherits="NewProject.AzureADLogin" %>
<%@ Register Src="~/OpenAuthProviders.ascx" TagPrefix="extLogins" TagName="OpenAuthProviders" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Microsoft Login Required</h2>
    <br />
    <h4>As per your account settings, You are required to sign in with your microsoft account.</h4>
    <h4>Click on the button below to sign in with your Microsoft account.</h4>
    <br />
    <br />
    <div>
        <extLogins:OpenAuthProviders runat="server" ID="OpenAuthLogin" />   
    </div>
</asp:Content>
