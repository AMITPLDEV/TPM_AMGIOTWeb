<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MachineInformationMaster.aspx.cs" Inherits="NewProject.MachineInformationMaster" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        #MainContent_dgMachineInfo tr th, #MainContent_dgMachineInfo tr td {
            text-align: center;
            /*border: 0.5px solid #BEBEBE;*/
            border-left: unset;
        }
    </style>
    <div class="themetoggle">
           <div class="container-fluid" style="overflow-x: auto; overflow-y: auto;">
                        <asp:GridView runat="server" ID="dgMachineInfo" AutoGenerateColumns="false" CssClass="P1Table P1Table-footer-style" ShowHeaderWhenEmpty="true" ShowFooter="true">
                            <%--<AlternatingRowStyle BackColor="#212528" />--%>
                            <EmptyDataTemplate>
                                No machine information available.
                            </EmptyDataTemplate>
                           <%-- <HeaderStyle BackColor="#6C7884" ForeColor="White" HorizontalAlign="Center" Height="40" Font-Size="14px" Font-Names="sans-serif" />
                            <RowStyle BackColor="#212528" Font-Size="Medium" ForeColor="White" HorizontalAlign="Center" Height="35" BorderColor="#7D7D7D" />--%>
                           <%-- <FooterStyle BackColor="#6C7884" ForeColor="Black" HorizontalAlign="Center" Height="40" Font-Size="14px" Font-Names="sans-serif" />--%>
                            <Columns>
                                <asp:TemplateField HeaderText="Machine ID" ControlStyle-Width="150">
                                    <ItemTemplate>
                                        <asp:Label ID="lblMachineID" runat="server" Text='<%#Bind("MachineID") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtMachineID" runat="server" Text='<%#Bind("MachineID") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txtAddMachineID" runat="server" Width="130"></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Machine Display Name" ControlStyle-Width="200">
                                    <ItemTemplate>
                                        <asp:Label ID="lblMacDisplayName" runat="server" Text='<%#Bind("MachineDisplayName") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtMacDisplayName" runat="server" Text='<%#Bind("MachineDisplayName") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txtAddMacDisplayName" runat="server" Width="180"></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Machine Type" ControlStyle-Width="150">
                                    <ItemTemplate>
                                        <asp:Label ID="lblMachineType" runat="server" Text='<%#Bind("MachineType") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="ddlMachineType" runat="server" SelectedValue='<%#Bind("MachineType") %>'></asp:DropDownList>
                                    </EditItemTemplate>
                                    <FooterTemplate>
                                        <asp:DropDownList ID="ddlAddMachineType" runat="server" Width="130">
                                            <asp:ListItem>IOT</asp:ListItem>
                                            <asp:ListItem>PROD</asp:ListItem>
                                            <asp:ListItem>TEST</asp:ListItem>
                                            <asp:ListItem>FOCAS</asp:ListItem>
                                        </asp:DropDownList>
                                    </FooterTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Machine Model" ControlStyle-Width="120">
                                    <ItemTemplate>
                                        <asp:Label ID="lblMachineModel" runat="server" Text='<%#Bind("MachineModel") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtMachineModel" runat="server" Text='<%#Bind("MachineModel") %>' TextMode="Number"></asp:TextBox>
                                    </EditItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txtAddMachineModel" runat="server" TextMode="Number" Width="100"></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="MTB" ControlStyle-Width="80">
                                    <ItemTemplate>
                                        <asp:Label ID="lblMTB" runat="server" Text='<%#Bind("MTB") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtMTB" runat="server" Text='<%#Bind("MTB") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txtAddMTB" runat="server" Width="60"></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Controller Type" ControlStyle-Width="150">
                                    <ItemTemplate>
                                        <asp:Label ID="lblControllerType" runat="server" Text='<%#Bind("ControllerType") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtControllerType" runat="server" Text='<%#Bind("ControllerType") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txtControllerType" runat="server" Width="130"></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="CNC Paths" ControlStyle-Width="100">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCNCPaths" runat="server" Text='<%#Bind("CNCPaths") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtCNCPaths" runat="server" Text='<%#Bind("CNCPaths") %>' TextMode="Number"></asp:TextBox>
                                    </EditItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txtAddCNCPaths" runat="server" TextMode="Number" Width="80"></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Servo Axis" ControlStyle-Width="100">
                                    <ItemTemplate>
                                        <asp:Label ID="lblServoAxis" runat="server" Text='<%#Bind("ServoAxis") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtServoAxis" runat="server" Text='<%#Bind("ServoAxis") %>' TextMode="Number"></asp:TextBox>
                                    </EditItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txtAddServoAxis" runat="server" TextMode="Number" Width="80"></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Spindle Number" ControlStyle-Width="120">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSpindleNumber" runat="server" Text='<%#Bind("SpindleNumber") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtSpindleNumber" runat="server" Text='<%#Bind("SpindleNumber") %>' TextMode="Number"></asp:TextBox>
                                    </EditItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txtAddSpindleNumber" runat="server" TextMode="Number" Width="100"></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="CNC IP" ControlStyle-Width="100">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCNCIP" runat="server" Text='<%#Bind("CNCIP") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtCNCIP" runat="server" Text='<%#Bind("CNCIP") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txtAddCNCIP" runat="server" Width="80"></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="CNC Port" ControlStyle-Width="100">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCNCPortNumber" runat="server" Text='<%#Bind("CNCPortNumber") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtCNCPortNumber" runat="server" Text='<%#Bind("CNCPortNumber") %>' TextMode="Number"></asp:TextBox>
                                    </EditItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txtAddCNCPortNumber" runat="server" TextMode="Number" Width="80"></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Is Enabled" ControlStyle-Width="100">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkIsEnabled" runat="server" Checked='<%#Bind("IsEnabled") %>'></asp:CheckBox>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:CheckBox ID="chkAddIsEnabled" runat="server" Checked='<%#Bind("IsEnabled") %>' Width="80"></asp:CheckBox>
                                    </FooterTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Action" ControlStyle-Width="100">
                                    <ItemTemplate>
                                        <asp:ImageButton runat="server" ImageUrl="~/Icons/edit_icon1.png" ToolTip="Edit" Style="display: inline; width: auto;" />
                                        <asp:ImageButton runat="server" ImageUrl="~/Icons/delete_icon1.png" ToolTip="Delete" Style="display: inline; width: auto;" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:ImageButton runat="server" ImageUrl="~/Icons/update_icon1.png" ToolTip="Update" Style="display: inline; width: auto;" />
                                        <asp:ImageButton runat="server" ImageUrl="~/Icons/cancel_icon1.png" ToolTip="Cancel" Style="display: inline; width: auto;" />
                                    </EditItemTemplate>
                                    <FooterTemplate>
                                        <asp:ImageButton runat="server" ImageUrl="~/Icons/add_icon.png" ToolTip="Insert" />
                                    </FooterTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
    </div>
    
</asp:Content>
