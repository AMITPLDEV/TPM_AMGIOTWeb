<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LevelHierarchyMaster.aspx.cs" Inherits="NewProject.LevelHierarchyMaster" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="Scripts/Toaster/toastr.min.js"></script>
    <link href="Scripts/Toaster/toastr.min.css" rel="stylesheet" />
    <script src="Scripts/DateTimePickerFor331/moment.js"></script>
    <script src="Scripts/DateTimePickerFor331/bootstrap-datetimepicker.min.js"></script>
    <link href="Scripts/DateTimePickerFor331/bootstrap-datetimepicker.min.css" rel="stylesheet" />

    <link href="Scripts/MultiSelectDropdown/bootstrap-multiselect.css" rel="stylesheet" />
    <script src="Scripts/MultiSelectDropdown/bootstrap-multiselect.js"></script>
    <style>
        .modal-tbl tr td {
            padding: 5px;
        }

            .modal-tbl tr td:nth-child(3) {
                padding-left: 20px;
            }

            .modal-tbl tr td:nth-child(1), .modal-tbl tr td:nth-child(3) {
                /*min-width: 135px;*/
                width: 152px;
            }

        .txtstyle {
            width: 200px;
        }

        .assign-machine-filter-style {
            border-right: 1px solid red;
        }

        .assign-shop-machine-div {
            /*border: 1px solid #6d6d6d;
            box-shadow: 2px 2px 8px 2px #171616;*/
            padding: 5px;
            margin-left: 16px;
        }

        .light-mode .assign-shop-machine-div {
            border: 1px solid #c1c1c1 !important;
            box-shadow: 2px 2px 8px 2px #c3bfbfed !important;
        }

        .unselected-btn {
            padding: 7px 15px;
            border-radius: 5px;
            background-color: red;
            border: 1px solid red;
            margin-left: 4px;
            margin-right: 4px;
        }

        .selectedbtn {
            padding: 7px 15px;
            border-radius: 5px;
            background-color: green;
            border: 1px solid green;
            margin-left: 4px;
            margin-right: 4px;
        }

        .blinking {
            -webkit-border-radius: 5px;
            border: 1px solid green;
            padding: 7px 15px;
            /*color: black;
            font-family: Arial;
            font-size: 60px;
            padding: 20px 50px 20px 50px;
            text-align: center;
            text-decoration: none;*/
            -webkit-animation: blinking 1500ms infinite;
            animation: blinking 1500ms infinite;
        }

        @-webkit-keyframes blinking {
            0% {
                /*color:white;*/
                background-color: green;
            }

            50% {
                /*color:red;*/
                background-color: #04bd0a;
            }

            100% {
                /*color:white;*/
                background-color: green;
            }
        }

        #lbbtnNext {
            font-size: 25px;
            color: #00f3ff;
            vertical-align: sub;
        }

        .light-mode #lbbtnNext {
            color: #00939b !important;
        }

        .multiselect-selected-text {
            padding-right: 181px;
        }

        .multiselect .dropdown-toggle {
            width: 50%;
        }

        .multiselect {
            width: 200px;
            overflow: hidden;
            display: block;
        }

        .multiselect-container label {
            color: black;
        }

        .multiselect span {
            color: black;
        }

        .multiselect-native-select > .btn-group > button {
            border-radius: 10px;
        }
    </style>
    <div class="themetoggle">
        <asp:HiddenField runat="server" ID="hdnScrollPos" ClientIDMode="Static" />
          <asp:HiddenField runat="server" ID="hfActiveMenu" ClientIDMode="Static" />
        <div style="float: left; margin-top: 5px">
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <div class="navbar-collapse collapse" style="height: 42px !important;">
                        <ul class="nav navbar-nav nextPrevious submenus-style ">
                            <li runat="server" id="Shop" visible="false"><a runat="server" class="submenuData" id="A3" clientidmode="static" data-toggle="tab" href="#LHmastermenu4">Shop</a>
                                <i></i>
                            </li>
                            <li runat="server" id="Cell" visible="false"><a runat="server" class="submenuData" id="A4" clientidmode="static" data-toggle="tab" href="#LHmastermenu5">Cell</a>
                                <i></i>
                            </li>
                            <li runat="server" id="Group" visible="false"><a runat="server" class="submenuData" id="A9" clientidmode="static" data-toggle="tab" href="#LHmastermenu6">Group</a>
                                <i></i>
                            </li>
                            <li runat="server" id="Li1"><a runat="server" class="submenuData" id="aAssignMachine" clientidmode="static" data-toggle="tab" href="#LHmastermenu7">Assign Machine</a>
                                <i></i>
                            </li>
                        </ul>
                    </div>
                    <div style="display: none">
                        <asp:Button runat="server" ID="btnShop" OnClick="btnShop_Click" />
                        <asp:Button runat="server" ID="btnCell" OnClick="btnCell_Click" />
                        <asp:Button runat="server" ID="btnGroup" OnClick="btnGroup_Click" />
                        <asp:Button runat="server" ID="btnAssignMachine" OnClick="btnAssignMachine_Click" />
                        
                    </div>
                  
                </ContentTemplate>
            </asp:UpdatePanel>

            <div id="divCompanyPlant" runat="server">
                <fieldset class="field-set" style="display: inline-block;">
                    <legend>&nbsp;<b>Filter By</b></legend>
                    <table class="filterTbl filter-field-table">
                        <tr>
                            <td>
                                <asp:Label runat="server" ID="lbl">Company </asp:Label>
                            </td>
                            <td>
                                <asp:Label runat="server" ID="lblCompany" CssClass="form-control"></asp:Label>
                            </td>
                            <td>Plant
                            </td>
                            <td>
                                <asp:DropDownList runat="server" ID="ddlPlant" CssClass="form-control dropdown-list" AutoPostBack="true" OnSelectedIndexChanged="ddlPlant_SelectedIndexChanged"></asp:DropDownList>
                            </td>

                        </tr>
                    </table>
                </fieldset>
            </div>
            <div class="tab-content themetoggle" id="masterContainer" style="width: 100%; margin: -10px auto; overflow: auto">
                <div id="LHmastermenu4" class="tab-pane fade" style="margin-top: 27px">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <div>
                                <%-- <fieldset class="field-set" style="display: inline-block;">
                                    <legend>&nbsp;<b>Filter By</b></legend>
                                    <table class="filterTbl filter-field-table">
                                        <tr>
                                            <td>
                                                <asp:Label runat="server" ID="Label2">Company </asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label runat="server" ID="lblCompany_ForShop" CssClass="form-control"></asp:Label>
                                            </td>
                                            <td>Plant
                                            </td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlPlant_ShopView" CssClass="form-control dropdown-list" AutoPostBack="true" OnSelectedIndexChanged="ddlPlant_ShopView_SelectedIndexChanged"></asp:DropDownList>
                                            </td>
                                            <td>--%>
                                <asp:Button runat="server" ID="btnPlantShopView" ClientIDMode="Static" Text="View" CssClass="Btns" OnClick="btnPlantShopView_Click" Visible="false" />
                                <asp:Button runat="server" ID="btnNewPlantShop" ClientIDMode="Static" Text="New Shop" CssClass="Btns" OnClientClick="return btnNewOrEditPlantShopClick(this,'New');" />
                                <%--</td>
                                        </tr>
                                    </table>
                                </fieldset>--%>
                            </div>
                            <div class="gridContainer" style="margin-top: 10px; width: 95vw; overflow: auto">
                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <asp:GridView ID="gvShopDetails" runat="server" AutoGenerateColumns="false" Width="100%" EmptyDataText="No Data Found." ShowHeaderWhenEmpty="true" ShowHeader="true" ClientIDMode="Static" CssClass="P1Table" OnSelectedIndexChanged="gvShopDetails_SelectedIndexChanged" OnRowDataBound="gvShopDetails_RowDataBound">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Company ID" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblCompanyID" runat="server" Text='<%# Eval("CompanyID") %>' ClientIDMode="Static"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Plant ID" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblPlantID" runat="server" Text='<%# Eval("PlantID") %>' ClientIDMode="Static"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Shop ID">
                                                    <ItemTemplate>
                                                        <asp:HiddenField runat="server" ID="hfPlantID" Value='<%# Eval("PlantID") %>' ClientIDMode="Static" />
                                                        <asp:Label ID="lblShopID" runat="server" Text='<%# Eval("ShopID") %>' ClientIDMode="Static"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Shop Desc">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblShopDesc" runat="server" Text='<%# Eval("Description") %>' ClientIDMode="Static"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Geo Location">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblGeoLoaction" runat="server" Text='<%# Eval("GeoLocation") %>' ClientIDMode="Static"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Effective From">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblEffevtiveFromDate" runat="server" Text='<%# Eval("EffectiveFromDate") %>' ClientIDMode="Static"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Effective To">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblEffevtiveToDate" runat="server" Text='<%# Eval("EffectiveToDate") %>' ClientIDMode="Static"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Action">
                                                    <ItemTemplate>
                                                        <asp:LinkButton runat="server" ID="lbEdit" CssClass="glyphicon glyphicon-pencil action-glypicon" OnClientClick="return btnNewOrEditPlantShopClick(this,'Edit')" ToolTip="Edit Shop"></asp:LinkButton>
                                                        <asp:LinkButton runat="server" ID="lbDeleteShop" CssClass="glyphicon glyphicon-trash action-glypicon" OnClick="lbDeleteShop_Click" ToolTip="Delete Shop"></asp:LinkButton>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </ContentTemplate>
                                    <Triggers>


                                        <asp:AsyncPostBackTrigger ControlID="btnShop" EventName="Click" />
                                        <asp:AsyncPostBackTrigger ControlID="btnCell" EventName="Click" />
                                        <asp:AsyncPostBackTrigger ControlID="btnGroup" EventName="Click" />
                                        <asp:AsyncPostBackTrigger ControlID="btnPlantShopView" EventName="Click" />
                                        <asp:AsyncPostBackTrigger ControlID="btnNewEditPlantShop" EventName="Click" />

                                    </Triggers>
                                </asp:UpdatePanel>
                            </div>

                            <div style="margin-top: 2%; border-top: 3px dashed red; padding-top: 20px;">
                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <div class="navbar-collapse collapse" style="height: 42px !important;">
                                            <ul id="shop_submenu_ul" class="nav navbar-nav nextPrevious submenus-style ">
                                                <li id="ShopCell" runat="server" style="display: none"><a runat="server" class="sub_submenuData" id="A5" clientidmode="static" data-toggle="tab" href="#shopsubmenu0">Shop Cell</a>
                                                    <i></i>
                                                </li>
                                                <li id="ShopGroup" runat="server" style="display: none"><a runat="server" class="sub_submenuData" id="A6" clientidmode="static" data-toggle="tab" href="#shopsubmenu1">Shop Group</a>
                                                    <i></i>
                                                </li>
                                            </ul>
                                        </div>
                                        <div style="display: none">
                                            <asp:Button runat="server" ID="btnShopCell" OnClick="btnShopCell_Click" />

                                            <asp:Button runat="server" ID="btnShopGroup" OnClick="btnShopGroup_Click" />
                                        </div>
                                    </ContentTemplate>
                                    <Triggers>
                                        <%--     <asp:AsyncPostBackTrigger ControlID="ddlPlant_ShopView" EventName="SelectedIndexChanged" />--%>
                                    </Triggers>
                                </asp:UpdatePanel>

                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <div class="tab-content themetoggle" id="submasterContainer" style="overflow: auto; width: 100%; margin: -10px auto;">
                                            <div id="shopsubmenu0" class="tab-pane fade  sub-sub-menudiv">
                                                <div>
                                                    <fieldset class="field-set" style="display: inline-block;">
                                                        <legend>&nbsp;<b>Filter By</b></legend>
                                                        <table class="filterTbl filter-field-table">
                                                            <tr>
                                                                <td>Shop</td>
                                                                <td>
                                                                    <asp:DropDownList runat="server" ID="ddlShop_ForShopCellView" ClientIDMode="Static" CssClass="form-control dropdown-list" Visible="false"></asp:DropDownList>
                                                                    <asp:Label runat="server" ID="lblShop_ForShopCellView" ClientIDMode="Static" CssClass="form-control"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Button runat="server" ID="btnShopCellView" ClientIDMode="Static" Text="View" CssClass="Btns" OnClick="btnShopCellView_Click" />
                                                                    <asp:Button runat="server" ID="btnNewOrEditShopCell" ClientIDMode="Static" Text="New Shop Cell" CssClass="Btns" OnClientClick="return btnNewOrEditShopCellClick(this,'New');" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </fieldset>
                                                </div>
                                                <div class="gridContainer" style="margin-top: 10px; width: 95vw; overflow: auto">
                                                    <asp:UpdatePanel runat="server">
                                                        <ContentTemplate>

                                                            <asp:GridView ID="gvShopCellDetails" runat="server" AutoGenerateColumns="false" Width="100%" EmptyDataText="No Data Found." ShowHeaderWhenEmpty="true" ShowHeader="true" ClientIDMode="Static" CssClass="P1Table">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Company ID" Visible="false">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblCompanyID" runat="server" Text='<%# Eval("CompanyID") %>' ClientIDMode="Static"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Plant ID" Visible="false">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblPlantID" runat="server" Text='<%# Eval("PlantID") %>' ClientIDMode="Static"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Shop ID" Visible="false">
                                                                        <ItemTemplate>

                                                                            <asp:Label ID="lblShopID" runat="server" Text='<%# Eval("ShopID") %>' ClientIDMode="Static"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Cell ID">
                                                                        <ItemTemplate>
                                                                            <asp:HiddenField runat="server" ID="hfPlantID" Value='<%# Eval("PlantID") %>' ClientIDMode="Static" />
                                                                            <asp:HiddenField runat="server" ID="hfShopID" Value='<%# Eval("ShopID") %>' ClientIDMode="Static" />
                                                                            <asp:Label ID="lblCellID" runat="server" Text='<%# Eval("CellID") %>' ClientIDMode="Static"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Cell Desc">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblDesc" runat="server" Text='<%# Eval("Description") %>' ClientIDMode="Static"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Effective From">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblEffevtiveFromDate" runat="server" Text='<%# Eval("EffectiveFromDate") %>' ClientIDMode="Static"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Effective To">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblEffevtiveToDate" runat="server" Text='<%# Eval("EffectiveToDate") %>' ClientIDMode="Static"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>

                                                                    <asp:TemplateField HeaderText="Action">
                                                                        <ItemTemplate>
                                                                            <asp:LinkButton runat="server" ID="lbEdit" CssClass="glyphicon glyphicon-pencil action-glypicon" OnClientClick="return btnNewOrEditShopCellClick(this,'Edit')" ToolTip="Edit Shop Cell"></asp:LinkButton>
                                                                            <asp:LinkButton runat="server" ID="lbDeleteShopCell" CssClass="glyphicon glyphicon-trash action-glypicon" OnClick="lbDeleteShopCell_Click" ToolTip="Delete Shop Cell"></asp:LinkButton>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>

                                                        </ContentTemplate>
                                                        <Triggers>


                                                            <asp:AsyncPostBackTrigger ControlID="btnCell" EventName="Click" />
                                                            <asp:AsyncPostBackTrigger ControlID="btnShopCell" EventName="Click" />
                                                            <asp:AsyncPostBackTrigger ControlID="btnShopCellGroup" EventName="Click" />
                                                            <asp:AsyncPostBackTrigger ControlID="btnShopGroup" EventName="Click" />

                                                            <asp:AsyncPostBackTrigger ControlID="btnGroup" EventName="Click" />

                                                            <asp:AsyncPostBackTrigger ControlID="btnShopCellView" EventName="Click" />
                                                            <asp:AsyncPostBackTrigger ControlID="btnNewEditShopCellSave" EventName="Click" />
                                                        </Triggers>
                                                    </asp:UpdatePanel>
                                                </div>

                                            </div>

                                            <div id="shopsubmenu1" class="tab-pane fade  sub-sub-menudiv">
                                                <div>
                                                    <fieldset class="field-set" style="display: inline-block;">
                                                        <legend>&nbsp;<b>Filter By</b></legend>
                                                        <table class="filterTbl filter-field-table">
                                                            <tr>
                                                                <td>Shop</td>
                                                                <td>
                                                                    <asp:DropDownList runat="server" ID="ddlShop_ForShopGroupView" CssClass="form-control dropdown-list" ClientIDMode="Static" Visible="false"></asp:DropDownList>
                                                                    <asp:Label runat="server" ID="lblShop_ForShopGroupView" CssClass="form-control" ClientIDMode="Static"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Button runat="server" ID="btnShopGroupView" ClientIDMode="Static" Text="View" CssClass="Btns" OnClick="btnShopGroupView_Click" />
                                                                    <asp:Button runat="server" ID="btnNewOrEditShopGroup" ClientIDMode="Static" Text="New Shop Group" CssClass="Btns" OnClientClick="return btnNewOrEditShopGroupClick(this, 'New');" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </fieldset>
                                                </div>
                                                <div class="gridContainer" style="margin-top: 10px; width: 95vw; overflow: auto">
                                                    <asp:UpdatePanel runat="server">
                                                        <ContentTemplate>

                                                            <asp:GridView ID="gvShopGroupDetails" runat="server" AutoGenerateColumns="false" Width="100%" EmptyDataText="No Data Found." ShowHeaderWhenEmpty="true" ClientIDMode="Static" CssClass="P1Table">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Company ID" Visible="false">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblCompanyID" runat="server" Text='<%# Eval("CompanyID") %>' ClientIDMode="Static"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Plant ID" Visible="false">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblPlantID" runat="server" Text='<%# Eval("PlantID") %>' ClientIDMode="Static"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Shop ID" Visible="false">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblShopID" runat="server" Text='<%# Eval("ShopID") %>' ClientIDMode="Static"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Group ID">
                                                                        <ItemTemplate>
                                                                            <asp:HiddenField runat="server" ID="hfPlantID" Value='<%# Eval("PlantID") %>' ClientIDMode="Static" />
                                                                            <asp:HiddenField runat="server" ID="hfShopID" Value='<%# Eval("ShopID") %>' ClientIDMode="Static" />
                                                                            <asp:Label ID="lblGroupID" runat="server" Text='<%# Eval("GroupID") %>' ClientIDMode="Static"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Group Desc">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblDesc" runat="server" Text='<%# Eval("Description") %>' ClientIDMode="Static"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Effective From">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblEffevtiveFromDate" runat="server" Text='<%# Eval("EffectiveFromDate") %>' ClientIDMode="Static"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Effective To">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblEffevtiveToDate" runat="server" Text='<%# Eval("EffectiveToDate") %>' ClientIDMode="Static"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>

                                                                    <asp:TemplateField HeaderText="Action">
                                                                        <ItemTemplate>
                                                                            <asp:LinkButton runat="server" ID="lbEdit" CssClass="glyphicon glyphicon-pencil action-glypicon" OnClientClick="return btnNewOrEditShopGroupClick(this,'Edit')" ToolTip="Edit Shop Group"></asp:LinkButton>
                                                                            <asp:LinkButton runat="server" ID="lbDeleteShopGroup" CssClass="glyphicon glyphicon-trash action-glypicon" OnClick="lbDeleteShopGroup_Click" ToolTip="Delete Shop Group"></asp:LinkButton>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>

                                                        </ContentTemplate>
                                                        <Triggers>


                                                            <asp:AsyncPostBackTrigger ControlID="btnCell" EventName="Click" />

                                                            <asp:AsyncPostBackTrigger ControlID="btnShopCell" EventName="Click" />
                                                            <asp:AsyncPostBackTrigger ControlID="btnShopCellGroup" EventName="Click" />
                                                            <asp:AsyncPostBackTrigger ControlID="btnShopGroup" EventName="Click" />

                                                            <asp:AsyncPostBackTrigger ControlID="btnGroup" EventName="Click" />

                                                            <asp:AsyncPostBackTrigger ControlID="btnShopGroupView" EventName="Click" />
                                                            <asp:AsyncPostBackTrigger ControlID="btnNewEditShopGroupSave" EventName="Click" />

                                                        </Triggers>
                                                    </asp:UpdatePanel>
                                                </div>
                                            </div>




                                        </div>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="btnPlantShopView" EventName="Click" />
                                        <%--<asp:AsyncPostBackTrigger ControlID="btnShop" EventName="Click" />--%>
                                    </Triggers>
                                </asp:UpdatePanel>
                            </div>


                            <div style="margin-top: 2%; border-top: 3px dashed red; padding-top: 20px;">
                                <div class="navbar-collapse collapse" style="height: 42px !important;">
                                    <ul id="shopcell_submenu_ul" class="nav navbar-nav nextPrevious submenus-style ">
                                        <li id="ShopCellGroup" runat="server" style="display: none"><a runat="server" class="shopcell_submenuData" id="A7" clientidmode="static" data-toggle="tab" href="#shopsubmenu2">Shop Cell Group</a>
                                            <i></i>
                                        </li>
                                    </ul>
                                </div>
                                <div style="display: none">
                                    <asp:Button runat="server" ID="btnShopCellGroup" OnClick="btnShopCellGroup_Click" />
                                </div>

                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <div class="tab-content themetoggle" style="overflow: auto; width: 100%; margin: -10px auto;">
                                            <div id="shopsubmenu2" class="tab-pane fade  shopcell-sub-menudiv">
                                                <asp:UpdatePanel runat="server">
                                                    <ContentTemplate>

                                                        <div>
                                                            <fieldset class="field-set" style="display: inline-block;">
                                                                <legend>&nbsp;<b>Filter By</b></legend>
                                                                <table class="filterTbl filter-field-table">
                                                                    <tr>
                                                                        <td>Shop</td>
                                                                        <td>
                                                                            <asp:DropDownList runat="server" ID="ddlShop_ForShopCellGroupView" ClientIDMode="Static" CssClass="form-control dropdown-list" AutoPostBack="true" OnSelectedIndexChanged="ddlShop_ForShopCellGroupView_SelectedIndexChanged" Visible="false"></asp:DropDownList>
                                                                            <asp:Label runat="server" ID="lblShop_ForShopCellGroupView" CssClass="form-control" ClientIDMode="Static"></asp:Label>
                                                                        </td>
                                                                        <td>Cell</td>
                                                                        <td>
                                                                            <asp:DropDownList runat="server" ID="ddlCell_ForShopCellGroupView" ClientIDMode="Static" CssClass="form-control dropdown-list"></asp:DropDownList>
                                                                        </td>
                                                                        <td>
                                                                            <asp:Button runat="server" ID="btnShopCellGroupView" ClientIDMode="Static" Text="View" CssClass="Btns" OnClick="btnShopCellGroupView_Click" />
                                                                            <asp:Button runat="server" ID="btnNewOrEditShopCellGroup" ClientIDMode="Static" Text="New Shop Cell Group" CssClass="Btns" OnClientClick="return btnNewOrEditShopCellGroupClick(this, 'New');" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </fieldset>
                                                        </div>

                                                    </ContentTemplate>
                                                    <Triggers>
                                                        <asp:AsyncPostBackTrigger ControlID="ddlShop_ForShopCellGroupView" EventName="SelectedIndexChanged" />
                                                        <asp:AsyncPostBackTrigger ControlID="gvShopDetails" EventName="SelectedIndexChanged" />
                                                    </Triggers>
                                                </asp:UpdatePanel>
                                                <div class="gridContainer" style="margin-top: 10px; width: 95vw; overflow: auto">
                                                    <asp:UpdatePanel runat="server">
                                                        <ContentTemplate>
                                                            <asp:GridView ID="gvShopCellGroupDetails" runat="server" AutoGenerateColumns="false" Width="100%" EmptyDataText="No Data Found." ShowHeaderWhenEmpty="true" ClientIDMode="Static" CssClass="P1Table">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Company ID" Visible="false">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblCompanyID" runat="server" Text='<%# Eval("CompanyID") %>' ClientIDMode="Static"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Plant ID" Visible="false">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblPlantID" runat="server" Text='<%# Eval("PlantID") %>' ClientIDMode="Static"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Shop ID" Visible="false">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblShopID" runat="server" Text='<%# Eval("ShopID") %>' ClientIDMode="Static"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Cell ID">
                                                                        <ItemTemplate>

                                                                            <asp:Label ID="lblCellID" runat="server" Text='<%# Eval("CellID") %>' ClientIDMode="Static"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Group ID">
                                                                        <ItemTemplate>
                                                                            <asp:HiddenField runat="server" ID="hfPlantID" Value='<%# Eval("PlantID") %>' ClientIDMode="Static" />
                                                                            <asp:HiddenField runat="server" ID="hfShopID" Value='<%# Eval("ShopID") %>' ClientIDMode="Static" />
                                                                            <asp:Label ID="lblGroupID" runat="server" Text='<%# Eval("GroupID") %>' ClientIDMode="Static"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Geoup Desc">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblDesc" runat="server" Text='<%# Eval("Description") %>' ClientIDMode="Static"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Effective From">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblEffevtiveFromDate" runat="server" Text='<%# Eval("EffectiveFromDate") %>' ClientIDMode="Static"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Effective To">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblEffevtiveToDate" runat="server" Text='<%# Eval("EffectiveToDate") %>' ClientIDMode="Static"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>

                                                                    <asp:TemplateField HeaderText="Action">
                                                                        <ItemTemplate>
                                                                            <asp:LinkButton runat="server" ID="lbEdit" CssClass="glyphicon glyphicon-pencil action-glypicon" OnClientClick="return btnNewOrEditShopCellGroupClick(this,'Edit')" ToolTip="Edit Shop Cell Group"></asp:LinkButton>
                                                                            <asp:LinkButton runat="server" ID="lbDeleteShopCellGroup" CssClass="glyphicon glyphicon-trash action-glypicon" OnClick="lbDeleteShopCellGroup_Click" ToolTip="Delete Shop Cell Group"></asp:LinkButton>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </ContentTemplate>
                                                        <Triggers>

                                                            <asp:AsyncPostBackTrigger ControlID="btnCell" EventName="Click" />

                                                            <asp:AsyncPostBackTrigger ControlID="btnShopCell" EventName="Click" />
                                                            <asp:AsyncPostBackTrigger ControlID="btnShopCellGroup" EventName="Click" />
                                                            <asp:AsyncPostBackTrigger ControlID="btnShopGroup" EventName="Click" />

                                                            <asp:AsyncPostBackTrigger ControlID="btnGroup" EventName="Click" />

                                                            <asp:AsyncPostBackTrigger ControlID="btnShopCellGroupView" EventName="Click" />
                                                            <asp:AsyncPostBackTrigger ControlID="btnNewEditShopCellGroupSave" EventName="Click" />
                                                        </Triggers>
                                                    </asp:UpdatePanel>
                                                </div>
                                            </div>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>

                            </div>



                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnShop" EventName="Click" />
                            <%--<asp:AsyncPostBackTrigger ControlID="ddlPlant" EventName="SelectedIndexChanged" />--%>
                        </Triggers>
                    </asp:UpdatePanel>
                </div>

                <div id="LHmastermenu5" class="tab-pane fade" style="margin-top: 27px">
                    <div>
                        <%-- <fieldset class="field-set" style="display: inline-block;">
                            <legend>&nbsp;<b>Filter By</b></legend>
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>


                                    <table class="filterTbl filter-field-table">
                                        <tr>
                                            <td>
                                                <asp:Label runat="server" ID="Label3">Company </asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label runat="server" ID="lblCompany_ForCell" CssClass="form-control"></asp:Label>
                                            </td>
                                            <td>Plant</td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlPlantForCell" CssClass="form-control  dropdown-list" ClientIDMode="Static" AutoPostBack="true" OnSelectedIndexChanged="ddlPlantForCell_SelectedIndexChanged"></asp:DropDownList>
                                            </td>
                                            <td>--%>
                        <asp:Button runat="server" ID="btnCellView" ClientIDMode="Static" Text="View" CssClass="Btns" OnClick="btnCellView_Click" Visible="false" />
                        <asp:Button runat="server" ID="btnCellNew" ClientIDMode="Static" Text="New Cell" CssClass="Btns" OnClick="btnCellNew_Click" />
                        <%-- </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="btnCell" EventName="Click" />
                                </Triggers>

                            </asp:UpdatePanel>
                        </fieldset>--%>
                    </div>
                    <div class="gridContainer" style="margin-top: 10px; width: 95vw; overflow: auto">
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvCellData" runat="server" AutoGenerateColumns="false" Width="100%" EmptyDataText="No Data Found." ShowHeaderWhenEmpty="true" ShowHeader="true" ShowFooter="false" ClientIDMode="Static" CssClass="P1Table" OnSelectedIndexChanged="gvCellData_SelectedIndexChanged" OnRowDataBound="gvCellData_RowDataBound">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Company ID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCompanyID" runat="server" Text='<%# Eval("CompanyID") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Plant ID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPlantID" runat="server" Text='<%# Eval("PlantID") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Cell ID">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCellId" runat="server" Text='<%# Eval("CellId") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Cell Description">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCellDesc" runat="server" Text='<%# Eval("CellDesc") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Effective From">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEffectiveFromDate" runat="server" Text='<%# Eval("EffectiveFromDate") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Effective To">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEffectiveToDate" runat="server" Text='<%# Eval("EffectiveToDate") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Action">
                                            <ItemTemplate>
                                                <asp:LinkButton runat="server" ID="lblCellEdit" CssClass="glyphicon glyphicon-pencil action-glypicon" OnClick="lblCellEdit_Click" ToolTip="Edit Cell"></asp:LinkButton>
                                                <asp:LinkButton runat="server" ID="lblCellDalete" CssClass="glyphicon glyphicon-trash action-glypicon" OnClick="lblCellDalete_Click" ToolTip="Delete Cell"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>

                                <asp:AsyncPostBackTrigger ControlID="btnShop" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnCell" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnCellView" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnCellNew" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnCellInserUpdate" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnGroup" EventName="Click" />
                                     <%--<asp:AsyncPostBackTrigger ControlID="ddlPlant" EventName="SelectedIndexChanged" />--%>

                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                    <div style="margin-top: 2%; border-top: 3px dashed red; padding-top: 20px;">
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <div class="navbar-collapse collapse" style="height: 42px !important;">
                                    <ul id="cell_submenu_ul" class="nav navbar-nav nextPrevious submenus-style ">
                                        <li runat="server" id="CellGroup"><a runat="server" class="sub_submenuData" id="A8" clientidmode="static" data-toggle="tab" href="#cellsubmenu0">Cell Group</a>
                                            <i></i>
                                        </li>
                                        <%--   <li><a runat="server" class="sub_submenuData" id="A9" clientidmode="static" data-toggle="tab" href="#cellsubmenu1">Plant Group</a>
                                            <i></i>
                                        </li>--%>
                                    </ul>
                                </div>
                                <div style="display: none">
                                    <asp:Button runat="server" ID="btnCellGroup" OnClick="btnCellGroup_Click" />
                                    <%--              <asp:Button runat="server" ID="btnPlantGroup" OnClick="btnPlantGroup_Click" />--%>
                                </div>
                            </ContentTemplate>
                            <Triggers>
                                <%--  <asp:AsyncPostBackTrigger ControlID="ddlPlantForCell" EventName="SelectedIndexChanged" />--%>
                            </Triggers>
                        </asp:UpdatePanel>

                        <div class="tab-content themetoggle" id="cellsubmasterContainer" style="overflow: auto; width: 100%; margin: -10px auto;">
                            <div id="cellsubmenu0" class="tab-pane fade sub-sub-menudiv">
                                <div>
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <fieldset class="field-set" style="display: inline-block;">
                                                <legend>&nbsp;<b>Filter By</b></legend>
                                                <table class="filterTbl filter-field-table">
                                                    <tr>
                                                        <td>Cell</td>
                                                        <td>
                                                            <asp:DropDownList runat="server" ID="ddlCellIDForCellGroup" CssClass="form-control dropdown-list " Visible="false"></asp:DropDownList>
                                                            <asp:Label runat="server" ID="lblCellIDForCellGroup" CssClass="form-control"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Button runat="server" ID="btnCGView" ClientIDMode="Static" Text="View" CssClass="Btns" OnClick="btnCGView_Click" />
                                                            <asp:Button runat="server" ID="btnCGNew" ClientIDMode="Static" Text="New Cell Group" CssClass="Btns" OnClick="btnCGNew_Click" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </fieldset>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="btnCell" EventName="Click" />
                                            <asp:AsyncPostBackTrigger ControlID="btnCellGroup" EventName="Click" />
                                            <%--   <asp:AsyncPostBackTrigger ControlID="btnCGInsertUpdate" EventName="Click" />
                                  <asp:AsyncPostBackTrigger ControlID="btnCGView" EventName="Click" />
                                              <asp:AsyncPostBackTrigger ControlID="btnCGNew" EventName="Click" />--%>
                                            <asp:AsyncPostBackTrigger ControlID="gvCellData" EventName="SelectedIndexChanged" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </div>
                                <div class="gridContainer" style="margin-top: 10px; width: 95vw; overflow: auto">
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <div>
                                                <asp:GridView ID="gvCellGroupData" runat="server" AutoGenerateColumns="false" Width="100%" EmptyDataText="No Data Found." ShowHeaderWhenEmpty="true" ShowHeader="true" ShowFooter="false" ClientIDMode="Static" CssClass="P1Table">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Company ID" Visible="false">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblCompanyID" runat="server" Text='<%# Eval("CompanyID") %>' ClientIDMode="Static"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Plant ID" Visible="false">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblPlantID" runat="server" Text='<%# Eval("PlantID") %>' ClientIDMode="Static"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Cell ID" Visible="false">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblCellId" runat="server" Text='<%# Eval("CellId") %>' ClientIDMode="Static"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Group ID">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblGroupID" runat="server" Text='<%# Eval("GroupID") %>' ClientIDMode="Static"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Group Description">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblGroupDesc" runat="server" Text='<%# Eval("GroupDesc") %>' ClientIDMode="Static"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Effective From">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblEffectiveFromDate" runat="server" Text='<%# Eval("EffectiveFromDate") %>' ClientIDMode="Static"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Effective To">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblEffectiveToDate" runat="server" Text='<%# Eval("EffectiveToDate") %>' ClientIDMode="Static"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Action">
                                                            <ItemTemplate>
                                                                <asp:LinkButton runat="server" ID="lbCellGroupEdit" CssClass="glyphicon glyphicon-pencil action-glypicon" OnClick="lbCellGroupEdit_Click" ToolTip="Edit Cell Group"></asp:LinkButton>
                                                                <asp:LinkButton runat="server" ID="lblCellGroupDelete" CssClass="glyphicon glyphicon-trash action-glypicon" OnClick="lblCellGroupDelete_Click" ToolTip="Delete Cell Group"></asp:LinkButton>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                        </ContentTemplate>
                                        <Triggers>

                                            <asp:AsyncPostBackTrigger ControlID="btnShop" EventName="Click" />
                                            <asp:AsyncPostBackTrigger ControlID="btnCell" EventName="Click" />
                                            <asp:AsyncPostBackTrigger ControlID="btnGroup" EventName="Click" />

                                            <asp:AsyncPostBackTrigger ControlID="btnCellGroup" EventName="Click" />
                                            <%--   <asp:AsyncPostBackTrigger ControlID="btnPlantGroup" EventName="Click" />--%>
                                            <asp:AsyncPostBackTrigger ControlID="btnCGView" EventName="Click" />
                                            <asp:AsyncPostBackTrigger ControlID="btnCGNew" EventName="Click" />

                                                 <%--<asp:AsyncPostBackTrigger ControlID="ddlPlant" EventName="SelectedIndexChanged" />--%>
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </div>
                            </div>


                        </div>
                    </div>

                </div>

                <div id="LHmastermenu6" class="tab-pane fade" style="margin-top: 27px">
                    <div>
                       <%-- <fieldset class="field-set" style="display: inline-block;">
                            <legend>&nbsp;<b>Filter By</b></legend>--%>
                            <table class="filterTbl filter-field-table">
                                <tr>
                                    <%-- <td>
                                        <asp:Label runat="server" ID="Label4">Company</asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label runat="server" ID="lblCompany_ForPlantGroup" CssClass="form-control"></asp:Label>
                                    </td>
                                    <td>Plant</td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="ddlPlant_ForGroup" CssClass="form-control  dropdown-list" ClientIDMode="Static"></asp:DropDownList>
                                    </td>
                                    <td style="display: none">Group</td>--%>
                                    <td style="display: none">
                                        <asp:TextBox runat="server" ID="txtPlantGroupSearch" CssClass="form-control" placeholder="Search Group ID" ClientIDMode="Static"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Button runat="server" ID="btnPlantGroupView" ClientIDMode="Static" Text="View" CssClass="Btns" OnClick="btnPlantGroupView_Click" Visible="false" />
                                        <asp:Button runat="server" ID="btnPlantGroupNew" ClientIDMode="Static" Text="New Group" CssClass="Btns" OnClick="btnPlantGroupNew_Click" />
                                    </td>
                                </tr>
                            </table>
                       <%-- </fieldset>--%>
                    </div>
                    <div class="gridContainer" style="margin-top: 10px; width: 95vw; overflow: auto">
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvPlantGroupData" runat="server" AutoGenerateColumns="false" Width="100%" EmptyDataText="No Data Found." ShowHeaderWhenEmpty="true" ShowHeader="true" ShowFooter="false" ClientIDMode="Static" CssClass="P1Table">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Company ID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCompanyID" runat="server" Text='<%# Eval("CompanyID") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Plant ID" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPlantID" runat="server" Text='<%# Eval("PlantID") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Group ID">
                                            <ItemTemplate>
                                                <asp:Label ID="lblGroupID" runat="server" Text='<%# Eval("GroupID") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Group Description">
                                            <ItemTemplate>
                                                <asp:Label ID="lblGroupDesc" runat="server" Text='<%# Eval("GroupDesc") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Effective From">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEffectiveFromDate" runat="server" Text='<%# Eval("EffectiveFromDate") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Effective To">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEffectiveToDate" runat="server" Text='<%# Eval("EffectiveToDate") %>' ClientIDMode="Static"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Action">
                                            <ItemTemplate>
                                                <asp:LinkButton runat="server" ID="lbPlantGroupEdit" CssClass="glyphicon glyphicon-pencil action-glypicon" OnClick="lbPlantGroupEdit_Click" ToolTip="Edit Group"></asp:LinkButton>
                                                <asp:LinkButton runat="server" ID="lbPlantGroupDelete" CssClass="glyphicon glyphicon-trash action-glypicon" OnClick="lbPlantGroupDelete_Click" ToolTip="Delete Group"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>

                                <asp:AsyncPostBackTrigger ControlID="btnShop" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnCell" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnGroup" EventName="Click" />

                                <asp:AsyncPostBackTrigger ControlID="btnCellGroup" EventName="Click" />
                                <%--  <asp:AsyncPostBackTrigger ControlID="btnPlantGroup" EventName="Click" />--%>
                                <asp:AsyncPostBackTrigger ControlID="btnPlantGroupView" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnPlantGroupNew" EventName="Click" />
                                     <%--<asp:AsyncPostBackTrigger ControlID="ddlPlant" EventName="SelectedIndexChanged" />--%>
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>

                <div id="LHmastermenu7" class="tab-pane fade">
                    <div style="margin-top: 1%;">
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>

                                <div style="margin-left: 28px; margin-bottom: 24px">
                                    <%-- <fieldset class="field-set" style="display: inline-block;">
                                                <legend>&nbsp;<b>Filter By</b></legend>--%>
                                    <%--  <table class="filterTbl filter-field-table">
                                        <tr>
                                            <td>Company</td>
                                            <td>
                                                <asp:Label runat="server" ID="lblCompany_ForAssignMachine" CssClass="form-control"></asp:Label>
                                            </td>
                                            <td>Plant</td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlPlant_ForAssignMachine" CssClass="form-control dropdown-list " ClientIDMode="Static" AutoPostBack="true" OnSelectedIndexChanged="ddlPlant_ForAssignMachine_SelectedIndexChanged"></asp:DropDownList>
                                            </td>
                                        </tr>
                                    </table>--%>
                                    <%--</fieldset>--%>
                                </div>
                                <div class="navbar-collapse collapse" style="height: 42px !important;">
                                    <ul class="nav navbar-nav nextPrevious submenus-style ">

                                        <li runat="server" id="AssignMachineToShop"><a runat="server" class="assignMachine_menuData" id="A16" clientidmode="static" data-toggle="tab" href="#assignMachinemenu3">Machine To Shop</a>
                                            <i></i>
                                        </li>
                                        <li runat="server" id="AssignMachineToCell"><a runat="server" class="assignMachine_menuData" id="A12" clientidmode="static" data-toggle="tab" href="#assignMachinemenu1">Machine To Cell</a>
                                            <i></i>
                                        </li>
                                        <li runat="server" id="AssignMachineToGroup"><a runat="server" class="assignMachine_menuData" id="A13" clientidmode="static" data-toggle="tab" href="#assignMachinemenu2">Machine To Group</a>
                                            <i></i>
                                        </li>
                                    </ul>
                                </div>
                                <div style="display: none">
                                    <asp:Button runat="server" ID="btnAssignMachineToPlant" OnClick="btnAssignMachineToPlant_Click" />
                                    <asp:Button runat="server" ID="btnAssignMachineToCell" OnClick="btnAssignMachineToCell_Click" />
                                    <asp:Button runat="server" ID="btnAssignMachineToGroup" OnClick="btnAssignMachineToGroup_Click" />
                                    <asp:Button runat="server" ID="btnAssignMachineToShop" OnClick="btnAssignMachineToShop_Click" />

                                </div>
                            </ContentTemplate>
                            <Triggers>
                                <%--  <asp:AsyncPostBackTrigger ControlID="ddlPlantForCell" EventName="SelectedIndexChanged" />--%>
                            </Triggers>
                        </asp:UpdatePanel>

                        <asp:UpdatePanel runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                            <ContentTemplate>

                                <div class="tab-content themetoggle" style="overflow: auto; width: 100%; margin: 10px auto;">


                                    <div id="assignMachinemenu3" class="tab-pane fade assignMachine-menudiv">
                                        <div>
                                            <div>
                                                <asp:UpdatePanel runat="server">
                                                    <ContentTemplate>
                                                        <table class="filterTbl filter-field-table ">
                                                            <tr>

                                                                <td colspan="10">
                                                                    <asp:CheckBox runat="server" ID="cbassignShop" Text="Shop" CssClass="checkbox-radiobtn" AutoPostBack="true" OnCheckedChanged="cbassignShop_CheckedChanged" Visible="false" />

                                                                    <asp:CheckBox runat="server" ID="cbassignShopCell" Text="Shop Cell" CssClass="checkbox-radiobtn" AutoPostBack="true" OnCheckedChanged="cbassignShopCell_CheckedChanged" Visible="false" />


                                                                    <asp:CheckBox runat="server" ID="cbassignShopCellGroup" Text="Shop Cell Group" CssClass="checkbox-radiobtn" AutoPostBack="true" OnCheckedChanged="cbassignShopCellGroup_CheckedChanged" Visible="false" />


                                                                    <asp:CheckBox runat="server" ID="cbassignShopGroup" Text="Shop Group" CssClass="checkbox-radiobtn" AutoPostBack="true" OnCheckedChanged="cbassignShopGroup_CheckedChanged" Visible="false" />

                                                                    <asp:Button runat="server" ID="btnassignShop" Text="Shop" OnClick="btnassignShop_Click" />

                                                                    <asp:Button runat="server" ID="btnassignShopCell" Text="Shop Cell" OnClick="btnassignShopCell_Click" />

                                                                    <asp:Button runat="server" ID="btnassignShopCellGroup" Text="Shop Cell Group" OnClick="btnassignShopCellGroup_Click" />

                                                                    <asp:Button runat="server" ID="btnassignShopGroup" Text="Shop Group" OnClick="btnassignShopGroup_Click" />

                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </div>
                                            <fieldset class="field-set" style="display: inline-block;">
                                                <legend>&nbsp;<b>Filter By</b></legend>
                                                <asp:UpdatePanel runat="server">
                                                    <ContentTemplate>
                                                        <table class="filterTbl filter-field-table ">
                                                            <tr>
                                                                <%-- <td>Company</td>
                                                                <td>
                                                                    <asp:Label runat="server" ID="lblCompany_ForAssignMachineToShop" CssClass="form-control"></asp:Label>
                                                                </td>
                                                                <td>Plant</td>
                                                                <td>
                                                                    <asp:DropDownList runat="server" ID="ddlPlant_ForAssignMachineToShop" CssClass="form-control dropdown-list " ClientIDMode="Static" AutoPostBack="true" OnSelectedIndexChanged="ddlPlant_ForAssignMachineToShop_SelectedIndexChanged"></asp:DropDownList>
                                                                </td>--%>
                                                                <td>
                                                                    <asp:TextBox runat="server" ID="txtSearchMachine_ForShop" CssClass="form-control" placeholder="Search MachineID"></asp:TextBox>
                                                                </td>
                                                                <td runat="server" id="assignShop_ShopName">Shop</td>
                                                                <td runat="server" id="assignShop_ShopDLL">
                                                                    <asp:DropDownList runat="server" ID="ddlShop_ForAssignMachineToShop" CssClass="form-control dropdown-list " AutoPostBack="true" OnSelectedIndexChanged="ddlShop_ForAssignMachineToShop_SelectedIndexChanged"></asp:DropDownList>
                                                                </td>
                                                                <td id="assignShop_CellName" runat="server">Cell</td>
                                                                <td id="assignShop_CellDDL" runat="server">
                                                                    <asp:DropDownList runat="server" ID="ddlCell_ForAssignMachineToShop" CssClass="form-control dropdown-list "></asp:DropDownList>
                                                                </td>

                                                                <td>
                                                                    <asp:Label runat="server" ID="lblmultiselectShopCellGroup_ForShop"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:ListBox ID="multiselectShop_ForShop" runat="server" SelectionMode="Multiple" CssClass="dropdown-list" ClientIDMode="Static"></asp:ListBox>
                                                                </td>
                                                                <%--                                                                <td id="assignShop_GroupName" runat="server">Group</td>
                                                                <td id="assignShop_GroupDDL" runat="server">
                                                                    <asp:DropDownList runat="server" ID="ddlGroup_ForAssignMachineToShop" CssClass="form-control dropdown-list "></asp:DropDownList>
                                                                </td>--%>
                                                                <td>
                                                                    <asp:Button runat="server" ID="btnAssignMachineToShopView" ClientIDMode="Static" Text="View" CssClass="Btns" OnClick="btnAssignMachineToShopView_Click" />
                                                                    <asp:Button runat="server" ID="btnAssignMachineToShopSave" ClientIDMode="Static" Text="Save" CssClass="Btns" OnClick="btnAssignMachineToShopSave_Click" />
                                                                </td>
                                                            </tr>
                                                        </table>

                                                    </ContentTemplate>
                                                    <Triggers>
                                                        <%--    <asp:AsyncPostBackTrigger ControlID="ddlPlant_ForAssignMachineToShop" EventName="SelectedIndexChanged" />--%>
                                                        <asp:AsyncPostBackTrigger ControlID="ddlShop_ForAssignMachineToShop" EventName="SelectedIndexChanged" />
                                                        <asp:AsyncPostBackTrigger ControlID="btnassignShop" EventName="Click" />
                                                        <asp:AsyncPostBackTrigger ControlID="btnassignShopCell" EventName="Click" />
                                                        <asp:AsyncPostBackTrigger ControlID="btnassignShopCellGroup" EventName="Click" />
                                                        <asp:AsyncPostBackTrigger ControlID="btnassignShopGroup" EventName="Click" />
                                                    </Triggers>
                                                </asp:UpdatePanel>
                                            </fieldset>


                                        </div>
                                        <div class="gridContainer" style="margin-top: 10px; width: 95vw; overflow: auto">
                                            <asp:UpdatePanel runat="server">
                                                <ContentTemplate>
                                                    <div>
                                                        <asp:GridView ID="gvAssignMachineToShopDetails" runat="server" AutoGenerateColumns="false" Width="100%" EmptyDataText="No Data Found." ShowHeaderWhenEmpty="true" ShowHeader="true" ShowFooter="false" ClientIDMode="Static" CssClass="P1Table select-onecheckbox-eachrow" OnRowDataBound="gvAssignMachineToShopDetails_RowDataBound">
                                                            <Columns>
                                                            </Columns>
                                                        </asp:GridView>
                                                    </div>
                                                </ContentTemplate>
                                                <Triggers>
                                                </Triggers>
                                            </asp:UpdatePanel>
                                        </div>
                                    </div>
                                    <div id="assignMachinemenu1" class="tab-pane fade assignMachine-menudiv">
                                        <div>
                                            <div>

                                                <asp:UpdatePanel runat="server">
                                                    <ContentTemplate>
                                                        <table class="filterTbl filter-field-table ">
                                                            <tr>
                                                                <td colspan="8">
                                                                    <asp:Button runat="server" ID="btnassignCell" Text="Cell" OnClick="btnassignCell_Click" />

                                                                    <asp:Button runat="server" ID="btnassignCellGroup" Text="Cell Group" OnClick="btnassignCellGroup_Click" />
                                                                </td>
                                                            </tr>

                                                        </table>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </div>

                                            <fieldset class="field-set" style="display: inline-block;">
                                                <legend>&nbsp;<b>Filter By</b></legend>

                                                <asp:UpdatePanel runat="server">
                                                    <ContentTemplate>
                                                        <table class="filterTbl filter-field-table ">

                                                            <tr>
                                                                <%-- <td>Company</td>
                                                                <td>
                                                                    <asp:Label runat="server" ID="lblCompany_ForAssignMachineToCell" CssClass="form-control"></asp:Label>
                                                                </td>
                                                                <td>Plant</td>
                                                                <td>
                                                                    <asp:DropDownList runat="server" ID="ddlPlant_ForAssignMachineToCell" CssClass="form-control dropdown-list " ClientIDMode="Static" AutoPostBack="true" OnSelectedIndexChanged="ddlPlant_ForAssignMachineToCell_SelectedIndexChanged"></asp:DropDownList>
                                                                </td>--%>
                                                                <td>
                                                                    <asp:TextBox runat="server" ID="txtSearchMachine_ForCell" CssClass="form-control" placeholder="Search MachineID"></asp:TextBox>
                                                                </td>
                                                                <td runat="server" id="assignCell_CellName">Cell</td>
                                                                <td runat="server" id="assignCell_CellDDL">
                                                                    <asp:DropDownList runat="server" ID="ddlCell_ForAssignMachineToCell" CssClass="form-control dropdown-list "></asp:DropDownList>
                                                                    <%-- AutoPostBack="true" OnSelectedIndexChanged="ddlCell_ForAssignMachineToCell_SelectedIndexChanged"--%>
                                                                </td>
                                                                <%--  <td id="assignCell_GroupName" runat="server">Group</td>
                                                                <td id="assignCell_GroupDDL" runat="server">
                                                                    <asp:DropDownList runat="server" ID="ddlGroup_ForAssignMachineToCell" CssClass="form-control dropdown-list "></asp:DropDownList>
                                                                </td>
                                                                <td>&nbsp;&nbsp;<asp:Button runat="server" ID="Button5" ClientIDMode="Static" Text="View" CssClass="Btns" />
                                                                    &nbsp;&nbsp;<asp:Button runat="server" ID="Button6" ClientIDMode="Static" Text="Save" CssClass="Btns" />
                                                                </td>--%>
                                                                <td>
                                                                    <asp:Label runat="server" ID="lblmultiselectCell_ForCell"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:ListBox ID="multiselectCell_ForCell" runat="server" SelectionMode="Multiple" CssClass="dropdown-list" ClientIDMode="Static"></asp:ListBox>
                                                                </td>
                                                                <td>
                                                                    <asp:Button runat="server" ID="btnAssignMachineToCellView" ClientIDMode="Static" Text="View" CssClass="Btns" OnClick="btnAssignMachineToCellView_Click" />
                                                                    <asp:Button runat="server" ID="btnAssignMachineToCellSave" ClientIDMode="Static" Text="Save" CssClass="Btns" OnClick="btnAssignMachineToCellSave_Click" />
                                                                </td>
                                                            </tr>
                                                        </table>

                                                    </ContentTemplate>
                                                    <Triggers>
                                                        <asp:AsyncPostBackTrigger ControlID="btnassignCell" EventName="Click" />
                                                        <asp:AsyncPostBackTrigger ControlID="btnassignCellGroup" EventName="Click" />
                                                    </Triggers>
                                                </asp:UpdatePanel>
                                            </fieldset>
                                        </div>
                                        <div class="gridContainer" style="margin-top: 10px; width: 95vw; overflow: auto">
                                            <asp:UpdatePanel runat="server">
                                                <ContentTemplate>
                                                    <div>
                                                        <asp:GridView ID="gvAssignMachineToCellDetails" runat="server" AutoGenerateColumns="false" Width="100%" EmptyDataText="No Data Found." ShowHeaderWhenEmpty="true" ShowHeader="true" ShowFooter="false" ClientIDMode="Static" CssClass="P1Table select-onecheckbox-eachrow" OnRowDataBound="gvAssignMachineToCellDetails_RowDataBound">
                                                            <Columns>
                                                            </Columns>
                                                        </asp:GridView>
                                                    </div>
                                                </ContentTemplate>
                                                <Triggers>
                                                </Triggers>
                                            </asp:UpdatePanel>
                                        </div>
                                    </div>

                                    <div id="assignMachinemenu2" class="tab-pane fade assignMachine-menudiv">
                                        <div>
                                             <fieldset class="field-set" style="display: inline-block;">
                                                <legend>&nbsp;<b>Filter By</b></legend>
                                            <table class="filterTbl filter-field-table">
                                                <tr>
                                                    <%--        <td>Company</td>
                                                        <td>
                                                            <asp:Label runat="server" ID="lblCompany_ForAssignMachineToGroup" CssClass="form-control"></asp:Label>
                                                        </td>
                                                        <td>Plant</td>
                                                        <td>
                                                            <asp:DropDownList runat="server" ID="ddlPlant_ForAssignMachineToGroup" CssClass="form-control dropdown-list" AutoPostBack="true" OnSelectedIndexChanged="ddlPlant_ForAssignMachineToGroup_SelectedIndexChanged"></asp:DropDownList>
                                                        </td>--%>
                                                    <%--  <td>Shop</td>
                                                        <td>
                                                            <asp:DropDownList runat="server" ID="ddlShop_ForAssignMachineToGroup" CssClass="form-control dropdown-list "></asp:DropDownList>
                                                        </td>--%>
                                                    <td>
                                                        <asp:TextBox runat="server" ID="txtSearchMachine_ForGroup" CssClass="form-control" placeholder="Search MachineID"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                       Group
                                                    </td>
                                                    <td>
                                                        <asp:ListBox ID="multiselectGorup_ForGroup" runat="server" SelectionMode="Multiple" CssClass="dropdown-list" ClientIDMode="Static"></asp:ListBox>
                                                    </td>
                                                    <td>
                                                        <asp:Button runat="server" ID="btnAssignMachineToGroupView" ClientIDMode="Static" Text="View" CssClass="Btns" OnClick="btnAssignMachineToGroupView_Click" />
                                                        <asp:Button runat="server" ID="btnAssignMachineToGroupSave" ClientIDMode="Static" Text="Save" CssClass="Btns" OnClick="btnAssignMachineToGroupSave_Click" />
                                                    </td>
                                                </tr>
                                            </table>
                                                      </fieldset>
                                        </div>
                                        <div class="gridContainer" style="margin-top: 10px; width: 95vw; overflow: auto">
                                            <asp:UpdatePanel runat="server">
                                                <ContentTemplate>
                                                    <div>
                                                        <asp:GridView ID="gvAssignMachineToGroupDetails" runat="server" AutoGenerateColumns="false" Width="100%" EmptyDataText="No Data Found." ShowHeaderWhenEmpty="true" ShowHeader="true" ShowFooter="false" ClientIDMode="Static" CssClass="P1Table select-onecheckbox-eachrow" OnRowDataBound="gvAssignMachineToGroupDetails_RowDataBound">
                                                            <Columns>
                                                            </Columns>
                                                        </asp:GridView>
                                                    </div>
                                                    </div>
                                                </ContentTemplate>
                                                <Triggers>
                                                </Triggers>
                                            </asp:UpdatePanel>
                                        </div>
                                    </div>
                                </div>

                            </ContentTemplate>
                            <Triggers>

                                <asp:AsyncPostBackTrigger ControlID="btnCell" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnGroup" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnAssignMachine" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnAssignMachineToShop" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnAssignMachineToPlant" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnAssignMachineToCell" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnAssignMachineToGroup" EventName="Click" />
                                     <%--<asp:AsyncPostBackTrigger ControlID="ddlPlant" EventName="SelectedIndexChanged" />--%>
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>

                </div>


            </div>
        </div>
        <!-------  Warning and Error Modal -------->
        <div class="modal fade" id="warningModal" role="dialog" style="z-index: 2000">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content modalContent warning-modal-content">
                    <div class="modal-header modalHeader warning-modal-header">
                        <i class="glyphicon glyphicon-warning-sign modal-icons"></i>
                        <br />
                        <h4 class="warning-modal-title">Warning</h4>
                        <br />
                        <span class="warning-modal-msg" id="lblWarningMsg">...</span>
                    </div>
                    <div class="modal-footer modalFooter modal-footer">
                        <input type="button" value="OK" class="warning-modal-btn" data-dismiss="modal" />
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="errorModal" role="dialog" style="z-index: 2000">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content modalContent error-modal-content">
                    <div class="modal-header modalHeader error-modal-header">
                        <i class="glyphicon glyphicon-remove-sign modal-icons"></i>
                        <br />
                        <h4 class="error-modal-title">Error</h4>
                        <br />
                        <span class="error-modal-msg" id="lblErrorMsg">...</span>
                    </div>
                    <div class="modal-footer modalFooter modal-footer">
                        <input type="button" value="OK" class="error-modal-btn" data-dismiss="modal" />
                    </div>
                </div>
            </div>
        </div>


        <%-- ---------------------------Shop Modals----------------------------------------------- --%>
        <div class="modal infoModal" id="neweditShopModal" role="dialog" style="min-width: 300px;" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog modal-dialog-centered " style="width: 38%">
                <div class="modal-content modalThemeCss">
                    <div class="modal-header">
                        <h4 class="modal-title"></h4>
                        <asp:HiddenField runat="server" ID="hfShopEditNew" ClientIDMode="Static" />
                    </div>
                    <div class="modal-body" style="padding-left: 0px; padding-right: 0px">
                        <span style="color: red; margin-left: 20px;" class="mandatory-message"></span>
                        <%--<asp:UpdatePanel runat="server">
                            <ContentTemplate>--%>
                        <div style="padding-left: 15px; padding-right: 15px; padding-bottom: 8px;" class="div-border-style">
                            <table style="width: 100%; margin: auto" class="modal-tbl">
                                <%--   <tr>
                                <td>Plant</td>
                                <td>
                                    <asp:DropDownList runat="server" ID="ddlPlant_ForShopEditNew" CssClass="form-control dropdown-list txtstyle">
                                    </asp:DropDownList>
                                </td>
                                <td></td>
                                <td style="width: 230px"></td>
                            </tr>--%>
                                <tr>
                                    <td>Plant *</td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="ddlPlant_ForShopEditNew" CssClass="form-control dropdown-list txtstyle" ClientIDMode="Static">
                                        </asp:DropDownList>
                                    </td>
                                    <td></td>
                                    <td style="width: 230px"></td>
                                </tr>
                            </table>
                        </div>
                        <%--  </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnShop" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>--%>
                        <div style="padding-left: 15px; padding-right: 15px; padding-top: 8px;">
                            <table style="width: 100%; margin: auto" class="modal-tbl addUpdateTbl">
                                <tr>
                                    <td>Shop ID *</td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtShopID" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                    </td>
                                    <td>Shop Desc</td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtShopDesc" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Geo Location</td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtShopGeoLocation" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                    </td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>Effective From *</td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtShopEffFromDate" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle" Style="position: relative" placeholder="DD-MM-YYYY HH:mm:ss"></asp:TextBox>
                                    </td>
                                    <td>Effective To *</td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtShopEffToDate" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle" Style="position: relative" placeholder="DD-MM-YYYY HH:mm:ss"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:Button runat="server" ID="btnNewEditPlantShop" Text="Save" CssClass="Btns" OnClientClick="return btnNewEditPlantShopSaveClick();" OnClick="btnNewEditPlantShop_Click" />
                        <button type="button" data-dismiss="modal" class="Btns">Close</button>
                    </div>
                </div>
            </div>
        </div>


        <div class="modal fade" id="plantshopDeleteConfirmModal" role="dialog">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content modalContent confirm-modal-content">
                    <div class="modal-header modalHeader confirm-modal-header">
                        <i class="glyphicon glyphicon glyphicon glyphicon-question-sign modal-icons"></i>
                        <br />
                        <h4 class="confirm-modal-title">Confirmation!</h4>
                        <br />
                        <span id="shopDeleteMsg" class="confirm-modal-msg">Are you sure you want to delete Record?</span>
                    </div>
                    <div class="modal-footer modalFooter modal-footer">
                        <asp:Button runat="server" Text="Yes" ID="btnDeletePlantShopConfirm" CssClass="confirm-modal-btn" OnClick="btnDeletePlantShopConfirm_Click" ClientIDMode="Static" />
                        <input type="button" value="No" data-dismiss="modal" class="confirm-modal-btn" />
                    </div>
                </div>
            </div>
        </div>
        <%-------------------------------------- End Shop Modals ---------------------------------- --%>

        <%-- ---------------------------Shop Cell Modals----------------------------------------------- --%>


        <asp:UpdatePanel runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
            <ContentTemplate>


                <div class="modal infoModal" id="neweditShopCellModal" role="dialog" style="min-width: 300px;" data-backdrop="static" data-keyboard="false">
                    <div class="modal-dialog modal-dialog-centered " style="width: 38%">
                        <div class="modal-content modalThemeCss">
                            <div class="modal-header">
                                <h4 class="modal-title"></h4>
                                <asp:HiddenField runat="server" ID="hfShopCellEditNew" ClientIDMode="Static" />
                            </div>
                            <div class="modal-body" style="padding-left: 0px; padding-right: 0px">
                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <span style="color: red; margin-left: 20px;" class="mandatory-message"></span>
                                        <div style="padding-left: 15px; padding-right: 15px; padding-bottom: 8px;" class="div-border-style">
                                            <table style="width: 100%; margin: auto" class="modal-tbl">
                                                <%--   <tr>
                                <td>Plant</td>
                                <td>
                                    <asp:DropDownList runat="server" ID="ddlPlant_ForShopEditNew" CssClass="form-control dropdown-list txtstyle">
                                    </asp:DropDownList>
                                </td>
                                <td></td>
                                <td style="width: 230px"></td>
                            </tr>--%>
                                                <tr>
                                                    <td>Plant *</td>
                                                    <td>
                                                        <asp:DropDownList runat="server" ID="ddlPlant_ForShopCellNewEdit" CssClass="form-control dropdown-list txtstyle" ClientIDMode="Static" AutoPostBack="true" OnSelectedIndexChanged="ddlPlant_ForShopCellNewEdit_SelectedIndexChanged">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>Shop *</td>
                                                    <td>
                                                        <asp:DropDownList runat="server" ID="ddlShop_ForShopCellNewEdit" CssClass="form-control dropdown-list txtstyle" ClientIDMode="Static">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div style="padding-left: 15px; padding-right: 15px; padding-top: 8px;">
                                            <table style="width: 100%; margin: auto" class="modal-tbl addUpdateTbl">
                                                <tr>
                                                    <td>Cell ID *</td>
                                                    <td>
                                                        <asp:TextBox runat="server" ID="txtCellID" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                                    </td>
                                                    <td>Cell Desc</td>
                                                    <td>
                                                        <asp:TextBox runat="server" ID="txtCellDesc" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Effective From *</td>
                                                    <td>
                                                        <asp:TextBox runat="server" ID="txtCellEffFromDate" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle" Style="position: relative" placeholder="DD-MM-YYYY HH:mm:ss"></asp:TextBox>
                                                    </td>
                                                    <td>Effective To *</td>
                                                    <td>
                                                        <asp:TextBox runat="server" ID="txtCellEffToDate" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle" Style="position: relative" placeholder="DD-MM-YYYY HH:mm:ss"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>

                                    </ContentTemplate>
                                </asp:UpdatePanel>

                            </div>
                            <div class="modal-footer">
                                <asp:Button runat="server" ID="btnNewEditShopCellSave" Text="Save" CssClass="Btns" OnClientClick="return btnNewEditShopCellSaveClick();" OnClick="btnNewEditShopCellSave_Click" />
                                <button type="button" data-dismiss="modal" class="Btns">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnShop" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>


        <div class="modal fade" id="shopcellDeleteConfirmModal" role="dialog">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content modalContent confirm-modal-content">
                    <div class="modal-header modalHeader confirm-modal-header">
                        <i class="glyphicon glyphicon glyphicon glyphicon-question-sign modal-icons"></i>
                        <br />
                        <h4 class="confirm-modal-title">Confirmation!</h4>
                        <br />
                        <span id="shopcellDeleteMsg" class="confirm-modal-msg">Are you sure you want to delete Record?</span>
                    </div>
                    <div class="modal-footer modalFooter modal-footer">
                        <asp:Button runat="server" Text="Yes" ID="btnDeleteShopCellConfirmation" CssClass="confirm-modal-btn" OnClick="btnDeleteShopCellConfirmation_Click" ClientIDMode="Static" />
                        <input type="button" value="No" data-dismiss="modal" class="confirm-modal-btn" />
                    </div>
                </div>
            </div>
        </div>
        <%-------------------------------------- End Shop Cell Modals ---------------------------------- --%>

        <%-- ---------------------------Shop Group Modals----------------------------------------------- --%>


        <asp:UpdatePanel runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
            <ContentTemplate>


                <div class="modal infoModal" id="neweditShopGroupModal" role="dialog" style="min-width: 300px;" data-backdrop="static" data-keyboard="false">
                    <div class="modal-dialog modal-dialog-centered " style="width: 38%">
                        <div class="modal-content modalThemeCss">
                            <div class="modal-header">
                                <h4 class="modal-title"></h4>
                                <asp:HiddenField runat="server" ID="hfShopGroupEditNew" ClientIDMode="Static" />
                            </div>
                            <div class="modal-body" style="padding-left: 0px; padding-right: 0px">
                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <span style="color: red; margin-left: 20px;" class="mandatory-message"></span>
                                        <div style="padding-left: 15px; padding-right: 15px; padding-bottom: 8px;" class="div-border-style">
                                            <table style="width: 100%; margin: auto" class="modal-tbl">
                                                <%--   <tr>
                                <td>Plant</td>
                                <td>
                                    <asp:DropDownList runat="server" ID="ddlPlant_ForShopEditNew" CssClass="form-control dropdown-list txtstyle">
                                    </asp:DropDownList>
                                </td>
                                <td></td>
                                <td style="width: 230px"></td>
                            </tr>--%>
                                                <tr>
                                                    <td>Plant *</td>
                                                    <td>
                                                        <asp:DropDownList runat="server" ID="ddlPlant_ForShopGroupNewEdit" CssClass="form-control dropdown-list txtstyle" ClientIDMode="Static" AutoPostBack="true" OnSelectedIndexChanged="ddlPlant_ForShopGroupNewEdit_SelectedIndexChanged">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>Shop *</td>
                                                    <td>
                                                        <asp:DropDownList runat="server" ID="ddlShop_ForShopGroupNewEdit" CssClass="form-control dropdown-list txtstyle" ClientIDMode="Static">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div style="padding-left: 15px; padding-right: 15px; padding-top: 8px;">
                                            <table style="width: 100%; margin: auto" class="modal-tbl addUpdateTbl">
                                                <tr>
                                                    <td>Group ID *</td>
                                                    <td>
                                                        <asp:TextBox runat="server" ID="txtGroupId" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                                    </td>
                                                    <td>Group Desc</td>
                                                    <td>
                                                        <asp:TextBox runat="server" ID="txtGroupDesc" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Effective From *</td>
                                                    <td>
                                                        <asp:TextBox runat="server" ID="txtGroupEffFromDate" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle" Style="position: relative" placeholder="DD-MM-YYYY HH:mm:ss"></asp:TextBox>
                                                    </td>
                                                    <td>Effective To *</td>
                                                    <td>
                                                        <asp:TextBox runat="server" ID="txtGroupEffToDate" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle" Style="position: relative" placeholder="DD-MM-YYYY HH:mm:ss"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>

                                    </ContentTemplate>
                                </asp:UpdatePanel>

                            </div>
                            <div class="modal-footer">
                                <asp:Button runat="server" ID="btnNewEditShopGroupSave" Text="Save" CssClass="Btns" OnClientClick="return btnNewEditShopGroupSaveClick();" OnClick="btnNewEditShopGroupSave_Click" />
                                <button type="button" data-dismiss="modal" class="Btns">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>

        <div class="modal fade" id="shopgroupDeleteConfirmModal" role="dialog">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content modalContent confirm-modal-content">
                    <div class="modal-header modalHeader confirm-modal-header">
                        <i class="glyphicon glyphicon glyphicon glyphicon-question-sign modal-icons"></i>
                        <br />
                        <h4 class="confirm-modal-title">Confirmation!</h4>
                        <br />
                        <span id="shopgroupDeleteMsg" class="confirm-modal-msg">Are you sure you want to delete Record?</span>
                    </div>
                    <div class="modal-footer modalFooter modal-footer">
                        <asp:Button runat="server" Text="Yes" ID="btnDeleteShopGroupConfirmation" CssClass="confirm-modal-btn" OnClick="btnDeleteShopGroupConfirmation_Click" ClientIDMode="Static" />
                        <input type="button" value="No" data-dismiss="modal" class="confirm-modal-btn" />
                    </div>
                </div>
            </div>
        </div>
        <%-- ---------------------------End Shop Group Modals----------------------------------------------- --%>


        <%-- ---------------------------Shop Cell Group Modals----------------------------------------------- --%>


        <asp:UpdatePanel runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
            <ContentTemplate>


                <div class="modal infoModal" id="neweditShopCellGroupModal" role="dialog" style="min-width: 300px;" data-backdrop="static" data-keyboard="false">
                    <div class="modal-dialog modal-dialog-centered " style="width: 38%">
                        <div class="modal-content modalThemeCss">
                            <div class="modal-header">
                                <h4 class="modal-title"></h4>
                                <asp:HiddenField runat="server" ID="hfShopCellGroupEditNew" ClientIDMode="Static" />
                            </div>
                            <div class="modal-body" style="padding-left: 0px; padding-right: 0px">
                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <span style="color: red; margin-left: 20px;" class="mandatory-message"></span>
                                        <div style="padding-left: 15px; padding-right: 15px; padding-bottom: 8px;" class="div-border-style">
                                            <table style="width: 100%; margin: auto" class="modal-tbl">
                                                <%--   <tr>
                                <td>Plant</td>
                                <td>
                                    <asp:DropDownList runat="server" ID="ddlPlant_ForShopEditNew" CssClass="form-control dropdown-list txtstyle">
                                    </asp:DropDownList>
                                </td>
                                <td></td>
                                <td style="width: 230px"></td>
                            </tr>--%>
                                                <tr>
                                                    <td>Plant *</td>
                                                    <td>
                                                        <asp:DropDownList runat="server" ID="ddlPlant_ForShopCellGroupNewEdit" CssClass="form-control dropdown-list txtstyle" ClientIDMode="Static" AutoPostBack="true" OnSelectedIndexChanged="ddlPlant_ForShopCellGroupNewEdit_SelectedIndexChanged">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td>Shop *</td>
                                                    <td>
                                                        <asp:DropDownList runat="server" ID="ddlShop_ForShopCellGRoupNewEdit" CssClass="form-control dropdown-list txtstyle" ClientIDMode="Static" AutoPostBack="true" OnSelectedIndexChanged="ddlShop_ForShopCellGRoupNewEdit_SelectedIndexChanged">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Cell *</td>
                                                    <td>
                                                        <asp:DropDownList runat="server" ID="ddlCell_ForShopCellGroupNewEdit" ClientIDMode="Static" CssClass="form-control dropdown-list txtstyle">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td></td>
                                                    <td style="width: 230px"></td>
                                                </tr>
                                            </table>
                                        </div>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="btnShopCellGroup" EventName="Click" />
                                    </Triggers>
                                </asp:UpdatePanel>
                                <div style="padding-left: 15px; padding-right: 15px; padding-top: 8px;">
                                    <table style="width: 100%; margin: auto" class="modal-tbl addUpdateTbl">
                                        <tr>
                                            <td>Group ID *</td>
                                            <td>
                                                <asp:TextBox runat="server" ID="txtShopCellGroupID" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                            </td>
                                            <td>Group Desc</td>
                                            <td>
                                                <asp:TextBox runat="server" ID="txtShopCellGroupName" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Effective From *</td>
                                            <td>
                                                <asp:TextBox runat="server" ID="txtShopCellGroupEffFromDate" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle" Style="position: relative" placeholder="DD-MM-YYYY HH:mm:ss"></asp:TextBox>
                                            </td>
                                            <td>Effective To *</td>
                                            <td>
                                                <asp:TextBox runat="server" ID="txtShopCellGroupEffToDate" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle" Style="position: relative" placeholder="DD-MM-YYYY HH:mm:ss"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </div>



                            </div>
                            <div class="modal-footer">
                                <asp:Button runat="server" ID="btnNewEditShopCellGroupSave" Text="Save" CssClass="Btns" OnClientClick="return btnNewEditShopCellGroupSaveClick();" OnClick="btnNewEditShopCellGroupSave_Click" />
                                <button type="button" data-dismiss="modal" class="Btns">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
            <Triggers>
            </Triggers>
        </asp:UpdatePanel>

        <div class="modal fade" id="shopcellgroupDeleteConfirmModal" role="dialog">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content modalContent confirm-modal-content">
                    <div class="modal-header modalHeader confirm-modal-header">
                        <i class="glyphicon glyphicon glyphicon glyphicon-question-sign modal-icons"></i>
                        <br />
                        <h4 class="confirm-modal-title">Confirmation!</h4>
                        <br />
                        <span id="shopcellgroupDeleteMsg" class="confirm-modal-msg">Are you sure you want to delete Record?</span>
                    </div>
                    <div class="modal-footer modalFooter modal-footer">
                        <asp:Button runat="server" Text="Yes" ID="btnDeleteShopCellGroupConfirm" CssClass="confirm-modal-btn" OnClick="btnDeleteShopCellGroupConfirm_Click" ClientIDMode="Static" />
                        <input type="button" value="No" data-dismiss="modal" class="confirm-modal-btn" />
                    </div>
                </div>
            </div>
        </div>
        <%-- ---------------------------End Shop Group Modals----------------------------------------------- --%>

        <%----------- Cell Master Modal ---------------------%>
        <asp:UpdatePanel runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
            <ContentTemplate>
                <%--Add and Edit Employee--%>
                <div class="modal infoModal" id="addEditCellInfo" role="dialog" style="min-width: 300px;" data-backdrop="static" data-keyboard="false">
                    <div class="modal-dialog modal-dialog-centered " style="width: 45%">
                        <div class="modal-content modalThemeCss">
                            <div class="modal-header">
                                <h4 id="modalTitleCellInfo" runat="server" class="modal-title"></h4>
                            </div>
                            <div class="modal-body">
                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <asp:HiddenField runat="server" ID="hdnCellInserUpdateParam" ClientIDMode="Static" />
                                        <span style="color: red" class="mandatory-message"></span>
                                        <table style="width: 100%; margin: auto" class="modal-tbl addUpdateTbl">
                                            <tr>
                                                <td>Plant ID *</td>
                                                <td>
                                                    <asp:DropDownList runat="server" ID="ddlCellPlantID" CssClass="form-control  dropdown-list txtstyle" ClientIDMode="Static"></asp:DropDownList>
                                                </td>

                                            </tr>
                                            <tr>
                                                <td>Cell ID *</td>
                                                <td>
                                                    <asp:TextBox runat="server" ID="txtCellCellID" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                                </td>
                                                <td>Cell Description</td>
                                                <td>
                                                    <asp:TextBox runat="server" ID="txtCellCellDesc" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Effective From *</td>
                                                <td>
                                                    <asp:TextBox runat="server" ID="txtCellEffectiveFromDate" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle" Style="position: relative" placeholder="DD-MM-YYYY"></asp:TextBox>
                                                </td>
                                                <td>Effective To *</td>
                                                <td>
                                                    <asp:TextBox runat="server" ID="txtCellEffectiveToDate" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle" Style="position: relative" placeholder="DD-MM-YYYY"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                            <div class="modal-footer">
                                <asp:Button runat="server" ID="btnCellInserUpdate" Text="Save" CssClass="Btns" OnClientClick="return cellDataInsertValidation();" OnClick="btnCellInserUpdate_Click" />
                                <button type="button" data-dismiss="modal" class="Btns">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
                <%--End Add and Edit Machine--%>

                <div class="modal fade" id="cellDeleteConfirmModal" role="dialog">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content modalContent confirm-modal-content">
                            <div class="modal-header modalHeader confirm-modal-header">
                                <i class="glyphicon glyphicon glyphicon glyphicon-question-sign modal-icons"></i>
                                <br />
                                <h4 class="confirm-modal-title">Confirmation!</h4>
                                <br />
                                <span id="cellDeleteMsg" class="confirm-modal-msg">Are you sure you want to delete Records?</span>
                            </div>
                            <div class="modal-footer modalFooter modal-footer">
                                <asp:Button runat="server" Text="Yes" ID="btnCellDeleteConfirm" CssClass="confirm-modal-btn" OnClick="btnCellDeleteConfirm_Click" ClientIDMode="Static" />
                                <%--OnClientClick="return clearTheModalScreen();"--%>
                                <input type="button" value="No" data-dismiss="modal" class="confirm-modal-btn" />
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnCell" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="btnCellView" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="btnCellInserUpdate" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="btnCellNew" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
        <%--End Cell Master Modal--%>

        <%----------- Cell Group Master Modal ---------------------%>
        <asp:UpdatePanel runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
            <ContentTemplate>
                <%--Add and Edit Employee--%>
                <div class="modal infoModal" id="addEditCellGroupInfo" role="dialog" style="min-width: 300px;" data-backdrop="static" data-keyboard="false">
                    <div class="modal-dialog modal-dialog-centered " style="width: 40%">
                        <div class="modal-content modalThemeCss">
                            <div class="modal-header">
                                <h4 class="modal-title">Add CellGroup</h4>
                            </div>
                            <div class="modal-body">
                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <asp:HiddenField runat="server" ID="hdnCellGroupParam" ClientIDMode="Static" />
                                        <span style="color: red" class="mandatory-message"></span>
                                        <table style="width: 100%; margin: auto" class="modal-tbl addUpdateTbl">
                                            <tr>
                                                <td>Plant ID *</td>
                                                <td>

                                                    <asp:DropDownList runat="server" ID="ddlCGPlantID" CssClass="form-control  dropdown-list txtstyle" ClientIDMode="Static" AutoPostBack="true" OnSelectedIndexChanged="ddlCGPlantID_SelectedIndexChanged"></asp:DropDownList>
                                                </td>
                                                <td>Cell ID *</td>
                                                <td>
                                                    <asp:HiddenField runat="server" ID="hdnCompanyID" ClientIDMode="Static" />
                                                    <asp:DropDownList runat="server" ID="ddlCGCellID" CssClass="form-control  dropdown-list txtstyle" ClientIDMode="Static"></asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Group ID *</td>
                                                <td>
                                                    <asp:TextBox runat="server" ID="txtCGGroupID" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                                </td>
                                                <td>Group Description</td>
                                                <td>
                                                    <asp:TextBox runat="server" ID="txtCGGroupDesc" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Effective From *</td>
                                                <td>
                                                    <asp:TextBox runat="server" ID="txtCGEffectiveFromDate" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle" Style="position: relative" placeholder="DD-MM-YYYY"></asp:TextBox>
                                                </td>
                                                <td>Effective To *</td>
                                                <td>
                                                    <asp:TextBox runat="server" ID="txtCGEffectiveToDate" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle" Style="position: relative" placeholder="DD-MM-YYYY"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                            <div class="modal-footer">
                                <asp:Button runat="server" ID="btnCGInsertUpdate" Text="Save" CssClass="Btns" OnClientClick="return cellGroupDataInsertValidation();" OnClick="btnCGInsertUpdate_Click" />
                                <button type="button" data-dismiss="modal" class="Btns">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
                <%--End Add and Edit Machine--%>

                <div class="modal fade" id="cellGroupDeleteConfirmModal" role="dialog">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content modalContent confirm-modal-content">
                            <div class="modal-header modalHeader confirm-modal-header">
                                <i class="glyphicon glyphicon glyphicon glyphicon-question-sign modal-icons"></i>
                                <br />
                                <h4 class="confirm-modal-title">Confirmation!</h4>
                                <br />
                                <span id="cellgroupDeleteMsg" class="confirm-modal-msg">Are you sure you want to delete Records?</span>
                            </div>
                            <div class="modal-footer modalFooter modal-footer">
                                <asp:Button runat="server" Text="Yes" ID="btnCGDeleteConfirm" CssClass="confirm-modal-btn" OnClick="btnCGDeleteConfirm_Click" ClientIDMode="Static" />
                                <%--OnClientClick="return clearTheModalScreen();"--%>
                                <input type="button" value="No" data-dismiss="modal" class="confirm-modal-btn" />
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnCell" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="btnCellView" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="btnCellGroup" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="btnCGInsertUpdate" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="btnCGView" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="btnCGNew" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
        <%--End Cell Group Master Modal--%>

        <%----------- Plant Group Master Modal ---------------------%>
        <asp:UpdatePanel runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
            <ContentTemplate>
                <%--Add and Edit Employee--%>
                <div class="modal infoModal" id="addEditPlantGroupInfo" role="dialog" style="min-width: 300px;" data-backdrop="static" data-keyboard="false">
                    <div class="modal-dialog modal-dialog-centered " style="width: 45%">
                        <div class="modal-content modalThemeCss">
                            <div class="modal-header">
                                <h4 class="modal-title">Add Group</h4>
                            </div>
                            <div class="modal-body">
                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <asp:HiddenField runat="server" ID="hdnPlantGroupInsertUpdate" ClientIDMode="Static" />
                                        <span style="color: red" class="mandatory-message"></span>
                                        <table style="width: 100%; margin: auto" class="modal-tbl addUpdateTbl">
                                            <tr>
                                                <td>Plant ID *</td>
                                                <td>
                                                    <asp:DropDownList runat="server" ID="ddlPGPlantID" CssClass="form-control  dropdown-list txtstyle" ClientIDMode="Static"></asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Group ID *</td>
                                                <td>
                                                    <asp:TextBox runat="server" ID="txtPGGroupID" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                                </td>
                                                <td>Group Description</td>
                                                <td>
                                                    <asp:TextBox runat="server" ID="txtPGGroupDesc" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Effective From *</td>
                                                <td>
                                                    <asp:TextBox runat="server" ID="txtPGEffectiveFromDate" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle" Style="position: relative" placeholder="DD-MM-YYYY"></asp:TextBox>
                                                </td>
                                                <td>Effective To *</td>
                                                <td>
                                                    <asp:TextBox runat="server" ID="txtPGEffectiveToDate" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle" Style="position: relative" placeholder="DD-MM-YYYY"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                            <div class="modal-footer">
                                <asp:Button runat="server" ID="btnPlantGroupInsertUpdate" Text="Save" CssClass="Btns" OnClientClick="return plantGroupDataInsertValidation();" OnClick="btnPlantGroupInsertUpdate_Click" />
                                <button type="button" data-dismiss="modal" class="Btns">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
                <%--End Add and Edit Machine--%>

                <div class="modal fade" id="plantGroupDeleteConfirmModal" role="dialog">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content modalContent confirm-modal-content">
                            <div class="modal-header modalHeader confirm-modal-header">
                                <i class="glyphicon glyphicon glyphicon glyphicon-question-sign modal-icons"></i>
                                <br />
                                <h4 class="confirm-modal-title">Confirmation!</h4>
                                <br />
                                <span id="plantgroupDeleteMsg" class="confirm-modal-msg">Are you sure you want to delete Records?</span>
                            </div>
                            <div class="modal-footer modalFooter modal-footer">
                                <asp:Button runat="server" Text="Yes" ID="btnPlantGroupDeleteConfirm" CssClass="confirm-modal-btn" OnClick="btnPlantGroupDeleteConfirm_Click" ClientIDMode="Static" />
                                <%--OnClientClick="return clearTheModalScreen();"--%>
                                <input type="button" value="No" data-dismiss="modal" class="confirm-modal-btn" />
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnCell" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="btnCellView" EventName="Click" />

            </Triggers>
        </asp:UpdatePanel>
        <%--End Plant Group Master Modal--%>


        <%-- ---------------------------Role Modals----------------------------------------------- --%>
        <div class="modal infoModal" id="neweditRoleModal" role="dialog" style="min-width: 300px;" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog modal-dialog-centered " style="width: 38%">
                <div class="modal-content modalThemeCss">
                    <div class="modal-header">
                        <h4 class="modal-title"></h4>
                        <asp:HiddenField runat="server" ID="hfRoleNewEdit" ClientIDMode="Static" />
                    </div>
                    <div class="modal-body" style="padding-left: 0px; padding-right: 0px">
                        <span style="color: red; margin-left: 20px;" class="mandatory-message"></span>
                        <div style="padding-left: 15px; padding-right: 15px; padding-bottom: 8px;" class="div-border-style">
                            <table style="width: 100%; margin: auto" class="modal-tbl">
                                <tr>
                                    <td>Company *</td>
                                    <td>
                                        <asp:Label runat="server" ID="lblCompany_ForRoleNewEdit" CssClass="form-control" ClientIDMode="Static"></asp:Label>
                                    </td>
                                    <td></td>
                                    <td style="width: 267px"></td>
                                </tr>
                            </table>
                        </div>
                        <div style="padding-left: 15px; padding-right: 15px; padding-top: 8px;">
                            <table style="width: 100%; margin: auto" class="modal-tbl addUpdateTbl">
                                <tr>
                                    <td>Role Name</td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtRoleName" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle"></asp:TextBox>
                                    </td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>Effective From *</td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtRoleEffFromDate" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle" Style="position: relative" placeholder="DD-MM-YYYY HH:mm:ss"></asp:TextBox>
                                    </td>
                                    <td>Effective To *</td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtRoleEffToDate" ClientIDMode="Static" AutoCompleteType="Disabled" CssClass="form-control txtstyle" Style="position: relative" placeholder="DD-MM-YYYY HH:mm:ss"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:Button runat="server" ID="btnNewEditRoleSave" Text="Save" CssClass="Btns" OnClientClick="return btnNewEditRoleSaveClick();" OnClick="btnNewEditRoleSave_Click" />
                        <button type="button" data-dismiss="modal" class="Btns">Close</button>
                    </div>
                </div>
            </div>
        </div>


        <div class="modal fade" id="roleDeleteConfirmModal" role="dialog">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content modalContent confirm-modal-content">
                    <div class="modal-header modalHeader confirm-modal-header">
                        <i class="glyphicon glyphicon glyphicon glyphicon-question-sign modal-icons"></i>
                        <br />
                        <h4 class="confirm-modal-title">Confirmation!</h4>
                        <br />
                        <span id="roleDeleteMsg" class="confirm-modal-msg">Are you sure you want to delete Record?</span>
                    </div>
                    <div class="modal-footer modalFooter modal-footer">
                        <asp:Button runat="server" Text="Yes" ID="btnDeleteRoleConfirm" CssClass="confirm-modal-btn" OnClick="btnDeleteRoleConfirm_Click" ClientIDMode="Static" />
                        <input type="button" value="No" data-dismiss="modal" class="confirm-modal-btn" />
                    </div>
                </div>
            </div>
        </div>
        <%-------------------------------------- End Role Modals ---------------------------------- --%>
    </div>
    <script>
        var submenu = "";
        var sub_submenu = "";
        var shopcell_submenu = "";
        var assignMachine_submenu = "";
        $(document).ready(function () {
            debugger;
            //if (localStorage.getItem("lhmselectedSubMenu")) {
            //    debugger;
            //    submenu = localStorage.getItem("lhmselectedSubMenu");
            //}
            //$(submenu).addClass("in active");
            //$("a[href$='" + submenu + "']").removeClass("selected-menu-style").addClass("selected-Submenu");
            //$("a[href$='" + submenu + "']").closest('li').find('i').addClass("arrow up selected-Submenu-ArrowUp");

            activeSubMenu();

            //localStorage.setItem("lhmselected_sub_SubMenu", "#shopsubmenu0");
            //if (localStorage.getItem("lhmselected_sub_SubMenu")) {
            //    debugger;
            //    sub_submenu = localStorage.getItem("lhmselected_sub_SubMenu");
            //}
            //$(sub_submenu).addClass("in active");
            //$("a[href$='" + sub_submenu + "']").removeClass("selected-menu-style").addClass("selected-sub-Submenu");
            //$("a[href$='" + sub_submenu + "']").closest('li').find('i').addClass("arrow up selected-sub-Submenu-ArrowUp");
            activesub_SubMenu();

            activeAssignMachineSubMenu();
            setGridHeight();
            setDateTimePicker();
        });
        <%-- function showEmployeePhotoPreview() {
debugger;
var preview = document.querySelector('#<%=imgEmpImagePreview.ClientID %>');
var file = document.querySelector('#<%=fuEmpImage.ClientID %>').files[0];
var reader = new FileReader();

reader.onloadend = function () {
preview.src = reader.result;
$('#clearFuEmpImage').css("visibility", "visible");
}
if (file) {
reader.readAsDataURL(file);
} else {
preview.src = "";
$('#clearFuEmpImage').css("visibility", "hidden");
}
}
function clearEmployeeImageUploadData() {
$('#fuEmpImage').val('');
$('#clearFuEmpImage').css("visibility", "hidden");
var preview = document.querySelector('#<%=imgEmpImagePreview.ClientID %>');
preview.src = "";
}--%>
        $(window).resize(function () {
            setGridHeight();
        });
        function setGridHeight() {
            var height = $(window).height() - 150;
            $('#masterContainer').css("height", height);
        }
        function activesub_SubMenu() {
            //alert(localStorage.getItem("lhmselected_sub_SubMenu"));
            if (localStorage.getItem("lhmselected_sub_SubMenu")) {
                sub_submenu = localStorage.getItem("lhmselected_sub_SubMenu");
                $(".sub-sub-menudiv").removeClass("in active");
                $(sub_submenu).addClass("in active");
                $("a[href$='" + sub_submenu + "']").removeClass("selected-menu-style").addClass("selected-sub-Submenu");
                $("a[href$='" + sub_submenu + "']").closest('li').find('i').addClass("arrow up selected-sub-Submenu-ArrowUp");
            } else {
                $(".sub-sub-menudiv").removeClass("in active");
            }

            if (localStorage.getItem("lhmselected_shopcell_subMenu")) {
                shopcell_submenu = localStorage.getItem("lhmselected_shopcell_subMenu");
                $(".shopcell-sub-menudiv").removeClass("in active");
                $(shopcell_submenu).addClass("in active");
                $("a[href$='" + shopcell_submenu + "']").removeClass("selected-menu-style").addClass("selected-sub-Submenu");
                $("a[href$='" + shopcell_submenu + "']").closest('li').find('i').addClass("arrow up selected-sub-Submenu-ArrowUp");
            } else {
                $(".shopcell-sub-menudiv").removeClass("in active");
            }

        }

        function activeSubMenu() {
            //alert(localStorage.getItem("lhmselected_sub_SubMenu"));
            if (localStorage.getItem("lhmselectedSubMenu")) {
                
                submenu = localStorage.getItem("lhmselectedSubMenu");
                $(".submenuData").removeClass("in active");
                $(submenu).addClass("in active");
                $("a[href$='" + submenu + "']").removeClass("selected-menu-style").addClass("selected-Submenu");
                $("a[href$='" + submenu + "']").closest('li').find('i').addClass("arrow up selected-Submenu-ArrowUp");
            } else {
                $(".submenuData").removeClass("in active");
            }


        }
        function activeAssignMachineSubMenu() {
            if (localStorage.getItem("lhmselectedAssignMachineSubMenu")) {
                debugger;
                assignMachine_submenu = localStorage.getItem("lhmselectedAssignMachineSubMenu");
            }
            $(".assignMachine-menudiv").removeClass("in active");
            $(assignMachine_submenu).addClass("in active");
            $("a[href$='" + assignMachine_submenu + "']").removeClass("selected-menu-style").addClass("selected-Submenu");
            $("a[href$='" + assignMachine_submenu + "']").closest('li').find('i').addClass("arrow up selected-Submenu-ArrowUp");

        }

        function btnNewGroupClick() {
            return true;
        }


        function setDateTimePicker() {
            $('[id$=txtPlantEffFromDate]').datetimepicker({
                format: 'DD-MM-YYYY HH:mm:ss',
                locale: 'en-US'
            });
            $('[id$=txtPlantEffToDate]').datetimepicker({
                format: 'DD-MM-YYYY HH:mm:ss',
                locale: 'en-US'
            });
            $('[id$=txtShopEffFromDate]').datetimepicker({
                format: 'DD-MM-YYYY HH:mm:ss',
                locale: 'en-US'
            });
            $('[id$=txtShopEffToDate]').datetimepicker({
                format: 'DD-MM-YYYY HH:mm:ss',
                locale: 'en-US'
            });

            $('[id$=txtCellEffFromDate]').datetimepicker({
                format: 'DD-MM-YYYY HH:mm:ss',
                locale: 'en-US'
            });
            $('[id$=txtCellEffToDate]').datetimepicker({
                format: 'DD-MM-YYYY HH:mm:ss',
                locale: 'en-US'
            });

            $('[id$=txtGroupEffFromDate]').datetimepicker({
                format: 'DD-MM-YYYY HH:mm:ss',
                locale: 'en-US'
            });
            $('[id$=txtGroupEffToDate]').datetimepicker({
                format: 'DD-MM-YYYY HH:mm:ss',
                locale: 'en-US'
            });

            $('[id$=txtShopCellGroupEffFromDate]').datetimepicker({
                format: 'DD-MM-YYYY HH:mm:ss',
                locale: 'en-US'
            });
            $('[id$=txtShopCellGroupEffToDate]').datetimepicker({
                format: 'DD-MM-YYYY HH:mm:ss',
                locale: 'en-US'
            });
            $('[id$=txtRoleEffFromDate]').datetimepicker({
                format: 'DD-MM-YYYY HH:mm:ss',
                locale: 'en-US'
            });
            $('[id$=txtRoleEffToDate]').datetimepicker({
                format: 'DD-MM-YYYY HH:mm:ss',
                locale: 'en-US'
            });

            $('[id$=multiselectShop_ForShop]').multiselect({
                includeSelectAllOption: true
            });

             $('[id$=multiselectCell_ForCell]').multiselect({
                includeSelectAllOption: true
            });

            $('[id$=multiselectGorup_ForGroup]').multiselect({
                includeSelectAllOption: true
            });

            
        }
        function setActiveSubmenuValue() {
            debugger;
            localStorage.setItem("lhmselectedSubMenu", "#LHmastermenu1");
            localStorage.setItem("lhmselectedAssignMachineSubMenu", "#assignMachinemenu0");

        }
        function setPlantLevelMenu(id) {
            debugger;
            localStorage.setItem("lhmselectedSubMenu", id);
            activeSubMenu();
        }
        $(".submenuData").click(function () {
            debugger;
            //$('[id*=hdnScrollPos]').val(0);

            // localStorage.clear("lhmselected_sub_SubMenu");
            let otherMenuExceptShopCellGroupSelected = true;
            $.blockUI({ message: '<img runat="server" src="Images/Loading.gif" />' });
            if ($("#mainBody").hasClass("light-mode")) {
                $(".submenuData").removeClass("selected-menu-style selected-Submenu").addClass("other-menu-style");
                $(".submenuData").closest('li').find('i').removeClass();
                $(this).removeClass("other-menu-style selected-Submenu").addClass("selected-menu-style");
            } else {
                $(".submenuData").removeClass("selected-menu-style selected-Submenu").addClass("other-menu-style");
                $(".submenuData").closest('li').find('i').removeClass();
                $(this).removeClass("other-menu-style selected-Submenu").addClass("selected-menu-style");
            }

            $(this).closest('li').find('i').addClass("arrow up selected-Submenu-ArrowUp");
            submenu = $(this).attr('href');
            //$("#activeMenu").val(submenu);
            $(submenu).addClass("in active");

            if (submenu == "#LHmastermenu4") {
                __doPostBack('<%= btnShop.UniqueID%>', '');
                //  localStorage.clear("lhmselected_sub_SubMenu");
                //localStorage.setItem("lhmselected_sub_SubMenu", "#shopsubmenu0");
                //activesub_SubMenu();
                setSubActiveMenu('Shop');
                otherMenuExceptShopCellGroupSelected = false;
                $("#hfActiveMenu").val("Shop");
            }
            else if (submenu == "#LHmastermenu5") {
                __doPostBack('<%= btnCell.UniqueID%>', '');
                //localStorage.clear("lhmselected_sub_SubMenu");
                //localStorage.setItem("lhmselected_sub_SubMenu", "#cellsubmenu0");
                //activesub_SubMenu();
                setSubActiveMenu('Cell');
                otherMenuExceptShopCellGroupSelected = false;
                  $("#hfActiveMenu").val("Cell");
            }
            else if (submenu == "#LHmastermenu6") {
                __doPostBack('<%= btnGroup.UniqueID%>', '');
                otherMenuExceptShopCellGroupSelected = false;
                  $("#hfActiveMenu").val("Group");
            }
            else if (submenu == "#LHmastermenu7") {
                __doPostBack('<%= btnAssignMachine.UniqueID%>', '');
                  $("#hfActiveMenu").val("Machine");
            }

            if (otherMenuExceptShopCellGroupSelected) {
                $("#hfSelectedPlant").val("DisablePlantLevelMenu");
                //$("#Shop").css('display', 'none');
                //$("#Cell").css('display', 'none');
                //$("#Group").css('display', 'none');

                //localStorage.removeItem("lhmselectedSubMenu");
                //activeSubMenu();
            }
            localStorage.setItem("lhmselectedSubMenu", submenu);
        });

        $(".sub_submenuData").click(function () {
            debugger;
            //$('[id*=hdnScrollPos]').val(0);
            $.blockUI({ message: '<img runat="server" src="Images/Loading.gif" />' });
            if ($("#mainBody").hasClass("light-mode")) {
                $(".sub_submenuData").removeClass("selected-menu-style selected-sub-Submenu").addClass("other-menu-style");
                $(".sub_submenuData").closest('li').find('i').removeClass();
                $(this).removeClass("other-menu-style selected-Submenu").addClass("selected-menu-style");
            } else {
                $(".sub_submenuData").removeClass("selected-menu-style selected-sub-Submenu").addClass("other-menu-style");
                $(".sub_submenuData").closest('li').find('i').removeClass();
                $(this).removeClass("other-menu-style selected-Submenu").addClass("selected-menu-style");
            }

            $(this).closest('li').find('i').addClass("arrow up selected-sub-Submenu-ArrowUp");
            sub_submenu = $(this).attr('href');
            //$("#activeMenu").val(submenu);
            $(sub_submenu).addClass("in active");
            if (sub_submenu == "#shopsubmenu0") {
                __doPostBack('<%= btnShopCell.UniqueID%>', '');
            }
            else if (sub_submenu == "#shopsubmenu1") {
                __doPostBack('<%= btnShopGroup.UniqueID%>', '');
            }
            else if (sub_submenu == "#shopsubmenu2") {
                __doPostBack('<%= btnShopCellGroup.UniqueID%>', '');
            }
            if (sub_submenu == "#cellsubmenu0") {
                __doPostBack('<%= btnCellGroup.UniqueID%>', '');
            }
         <%--   else if (sub_submenu == "#cellsubmenu1") {
                __doPostBack('<%= btnPlantGroup.UniqueID%>', '');
            }--%>
            localStorage.setItem("lhmselected_sub_SubMenu", sub_submenu);
        });


        $(".shopcell_submenuData").click(function () {
            debugger;
            //$('[id*=hdnScrollPos]').val(0);
            $.blockUI({ message: '<img runat="server" src="Images/Loading.gif" />' });
            if ($("#mainBody").hasClass("light-mode")) {
                $(".shopcell_submenuData").removeClass("selected-menu-style selected-sub-Submenu").addClass("other-menu-style");
                $(".shopcell_submenuData").closest('li').find('i').removeClass();
                $(this).removeClass("other-menu-style selected-Submenu").addClass("selected-menu-style");
            } else {
                $(".shopcell_submenuData").removeClass("selected-menu-style selected-sub-Submenu").addClass("other-menu-style");
                $(".shopcell_submenuData").closest('li').find('i').removeClass();
                $(this).removeClass("other-menu-style selected-Submenu").addClass("selected-menu-style");
            }

            $(this).closest('li').find('i').addClass("arrow up selected-sub-Submenu-ArrowUp");
            shopcell_submenu = $(this).attr('href');
            //$("#activeMenu").val(submenu);
            $(shopcell_submenu).addClass("in active");
            if (shopcell_submenu == "#shopsubmenu2") {
                __doPostBack('<%= btnShopCellGroup.UniqueID%>', '');
            }
            localStorage.setItem("lhmselected_shopcell_subMenu", shopcell_submenu);
        });
        $(".assignMachine_menuData").click(function () {
            debugger;
            //$('[id*=hdnScrollPos]').val(0);
            $.blockUI({ message: '<img runat="server" src="Images/Loading.gif" />' });
            if ($("#mainBody").hasClass("light-mode")) {
                $(".assignMachine_menuData").removeClass("selected-menu-style selected-sub-Submenu").addClass("other-menu-style");
                $(".assignMachine_menuData").closest('li').find('i').removeClass();
                $(this).removeClass("other-menu-style selected-Submenu").addClass("selected-menu-style");
            } else {
                $(".assignMachine_menuData").removeClass("selected-menu-style selected-sub-Submenu").addClass("other-menu-style");
                $(".assignMachine_menuData").closest('li').find('i').removeClass();
                $(this).removeClass("other-menu-style selected-Submenu").addClass("selected-menu-style");
            }

            $(this).closest('li').find('i').addClass("arrow up selected-sub-Submenu-ArrowUp");
            sub_submenu = $(this).attr('href');
            //$("#activeMenu").val(submenu);
            $(sub_submenu).addClass("in active");
            if (sub_submenu == "#assignMachinemenu0") {
                __doPostBack('<%= btnAssignMachineToPlant.UniqueID%>', '');
            }
            else if (sub_submenu == "#assignMachinemenu1") {
                __doPostBack('<%= btnAssignMachineToCell.UniqueID%>', '');
            }
            else if (sub_submenu == "#assignMachinemenu2") {
                __doPostBack('<%= btnAssignMachineToGroup.UniqueID%>', '');
            }
            else if (sub_submenu == "#assignMachinemenu3") {
                __doPostBack('<%= btnAssignMachineToShop.UniqueID%>', '');
            }
            localStorage.setItem("lhmselectedAssignMachineSubMenu", sub_submenu);
        });


        function setSubActiveMenu(menu) {
            //localStorage.clear("lhmselected_sub_SubMenu");
            let enterBlock = false;
            if (menu == "Shop") {
                var lilist = $("#shop_submenu_ul li");
                for (let i = 0; i < lilist.length; i++) {
                    let li = lilist[i];
                    let display = $(li).css('display');
                    debugger;
                    if (display == "block") {
                        localStorage.setItem("lhmselected_sub_SubMenu", $(li).find('a').attr('href'));
                        activesub_SubMenu();
                        enterBlock = true;
                        break;
                    }
                }
                if ($("[id*=ShopCellGroup]").css('display') == "block") {
                    localStorage.setItem("lhmselected_shopcell_subMenu", "#shopsubmenu2");
                    activesub_SubMenu();
                } else {
                    localStorage.removeItem("lhmselected_shopcell_subMenu");
                    activesub_SubMenu();
                }
            } else {
                var lilist = $("#cell_submenu_ul li");
                for (let i = 0; i < lilist.length; i++) {
                    let li = lilist[i];
                    let display = $(li).css('display');
                    if (display == "block") {
                        localStorage.setItem("lhmselected_sub_SubMenu", $(li).find('a').attr('href'));
                        activesub_SubMenu();
                        enterBlock = true;
                        break;
                    }
                }
            }
            if (!enterBlock) {
                localStorage.removeItem("lhmselected_sub_SubMenu");
                activesub_SubMenu();
            }
        }

        function openWarningModal(msg) {
            $("#lblWarningMsg").text(msg);
            $("#warningModal").modal('show');
        }
        function openErrorModal(msg) {
            $('#errorModal').modal('show');
            $('#lblErrorMsg').text(msg);
        }
        function showSuccessMsg(msg, title) {
            debugger;
            toastr.options = {
                "closeButton": true,
                "debug": false,
                "newestOnTop": false,
                "progressBar": true,
                "positionClass": "toast-top-right",
                "preventDuplicates": true,
                "onclick": null,
                "showDuration": "4000",
                "hideDuration": "1000",
                "timeOut": "4000",
                "extendedTimeOut": "1000",
                "showEasing": "swing",
                "hideEasing": "linear",
                "showMethod": "fadeIn",
                "hideMethod": "fadeOut"
            }

            toastr['success'](msg, title);
            return false;
        }
        function clearAllModalScreen() {
            $(".modal-backdrop").removeClass("modal-backdrop in");
            $(".modal").modal("hide");
            return true;
        }
        function openModal(modalid) {
            $(".modal-backdrop").removeClass("modal-backdrop in");
            $("#" + modalid).modal('show');
        }
        /*  ------------------------------------------------------ Plant Details----------------------------------------------------*/
        function btnNewOrEditPlantClick(element, param) {
            if (param == "New") {
                $("#txtPlantID").val("");
                $("#txtPlantDesc").val("");
                $("#txtPlantCode").val("");
                $("#txtPlantAddress").val("");
                //$("#txtPlantCountry").val("");
                $("#txtPlantRegion").val("");
                $("#txtPlantGeoLocation").val("");
                $("#txtPlatCity").val("");
                $("#txtPlantEffFromDate").val("");
                $("#txtPlantEffToDate").val("31-12-9999 00:00:00");

                $("#ddlCompany_ForPlant").prop('disabled', false);
                $("#txtPlantID").prop('readonly', false);
                $("#txtPlantEffFromDate").prop('readonly', false);
                $("#txtPlantEffToDate").prop('readonly', true);
                $("#hfPlantEditNew").val("New");
                $("#neweditPlantModal .modal-title").text("Add Plant");
            } else {
                $("#txtPlantID").val($(element).closest('tr').find("#lblPlantID").text());
                $("#txtPlantDesc").val($(element).closest('tr').find("#lblPlantDesc").text());
                $("#txtPlantCode").val($(element).closest('tr').find("#lblCode").text());
                $("#txtPlantAddress").val($(element).closest('tr').find("#lblAddress").text());
                $("#ddlPlantCountry").val($(element).closest('tr').find("#lblCountry").text());
                $("#txtPlantRegion").val($(element).closest('tr').find("#lblRegion").text());
                $("#txtPlantGeoLocation").val($(element).closest('tr').find("#lblGeoLoaction").text());
                $("#txtPlatCity").val($(element).closest('tr').find("#lblCity").text());
                $("#txtPlantEffFromDate").val($(element).closest('tr').find("#lblEffevtiveFromDate").text());
                $("#txtPlantEffToDate").val($(element).closest('tr').find("#lblEffevtiveToDate").text());

                $("#ddlCompany_ForPlant").prop('disabled', true);
                $("#txtPlantID").prop('readonly', true);
                $("#txtPlantEffFromDate").prop('readonly', true);
                $("#txtPlantEffToDate").prop('readonly', true);
                $("#hfPlantEditNew").val("Edit");
                $("#neweditPlantModal .modal-title").text("Edit Plant");
            }
            $(".mandatory-message").text("");
            $("#neweditPlantModal").modal('show');

            return false;
        }
        function btnNewEditPlantSaveClick() {
            //check company ID
            if ($("#txtPlantID").val() == "") {
                $(".mandatory-message").text("Plant ID is required.");
                return false;
            } else if ($("#txtPlantEffFromDate").val() == "") {
                $(".mandatory-message").text("Effective From is required.");
                return false;
            } else if ($("#txtPlantEffToDate").val() == "") {
                $(".mandatory-message").text("Effective To is required.");
                return false;
            }
            return true;
        }

        function openPlantDeleteConfirmModal(msg) {
            $("#plantDeleteMsg").text(msg);
            $("#plantDeleteConfirmModal").modal('show');
        }

        $("#gvPlantDetails tr").click(function () {
            $("#gvPlantDetails tr").css('background-color', 'unset');
            $(this).css('background-color', 'red');
            $("#hfSelectedPlant").val($(this).find("#lblPlantID").text());
        });

        function setSelectedPlantIdInGrid() {
            let plant = $("#hfSelectedPlant").val();
            for (let i = 1; i < $("#gvPlantDetails tr").length; i++) {
                let tr = $("#gvPlantDetails tr")[i];
                //alert($(tr).find("#lblPlantID").text() + "   " + plant);
                if ($(tr).find("#lblPlantID").text() == plant) {
                    $(tr).css('background-color', 'red');
                } else {
                    $(tr).css('background-color', 'unset');
                }
            }
        }
        /*  ------------------------------------------------------ End Plant Details----------------------------------------------------*/

        /* ---------------------------------------------Shop Details----------------------------------------------------------*/
        function btnNewOrEditPlantShopClick(element, param) {
            debugger;
            if (param == "New") {
                //  $("#ddlPlant_ForShopEditNew").val($(element).closest('tr').find("#lblPlantID").text());

                $("#txtShopID").val("");
                $("#txtShopDesc").val("");
                $("#txtShopGeoLocation").val("");
                $("#txtShopEffFromDate").val("");
                $("#txtShopEffToDate").val("31-12-9999 00:00:00");

                $("#ddlPlant_ForShopEditNew").prop('disabled', true);
                $("#txtShopID").prop('readonly', false);
                $("#txtShopEffFromDate").prop('readonly', false);
                $("#txtShopEffToDate").prop('readonly', true);
                $("#hfShopEditNew").val("New");
                $("#neweditShopModal .modal-title").text("Add Shop");
            } else {
                $("#ddlPlant_ForShopEditNew").val($(element).closest('tr').find("#hfPlantID").val());
                $("#txtShopID").val($(element).closest('tr').find("#lblShopID").text());
                $("#txtShopDesc").val($(element).closest('tr').find("#lblShopDesc").text());
                $("#txtShopGeoLocation").val($(element).closest('tr').find("#lblGeoLoaction").text());
                $("#txtShopEffFromDate").val($(element).closest('tr').find("#lblEffevtiveFromDate").text());
                $("#txtShopEffToDate").val($(element).closest('tr').find("#lblEffevtiveToDate").text());

                $("#ddlPlant_ForShopEditNew").prop('disabled', true);
                $("#txtShopID").prop('readonly', true);
                $("#txtShopEffFromDate").prop('readonly', true);
                $("#txtShopEffToDate").prop('readonly', true);
                $("#hfShopEditNew").val("Edit");
                $("#neweditShopModal .modal-title").text("Edit Shop");
            }
            $(".mandatory-message").text("");
            $("#neweditShopModal").modal('show');

            return false;
        }
        function btnNewEditPlantShopSaveClick() {
            //check company ID
            if ($("#ddlPlant_ForShopEditNew").val() == "") {
                $(".mandatory-message").text("Plant ID is required.");
                return false;
            } else
                if ($("#txtShopID").val() == "") {
                    $(".mandatory-message").text("Shop ID is required.");
                    return false;
                } else if ($("#txtShopEffFromDate").val() == "") {
                    $(".mandatory-message").text("Effective From is required.");
                    return false;
                } else if ($("#txtShopEffToDate").val() == "") {
                    $(".mandatory-message").text("Effective To is required.");
                    return false;
                }
            return true;
        }

        function openPlantShopDeleteConfirmModal(msg) {
            $("#shopDeleteMsg").text(msg);
            $("#plantshopDeleteConfirmModal").modal('show');
        }
        /*----------------------------------------------- End Shop Details-----------------------------------------------*/

        /* ---------------------------------------------Shop Cell Details----------------------------------------------------------*/
        function btnNewOrEditShopCellClick(element, param) {
            if (param == "New") {
                //  $("#ddlPlant_ForShopEditNew").val($(element).closest('tr').find("#lblPlantID").text());
                // $("#ddlPlant_ForShopCellNewEdit").val("");
                $("#txtCellID").val("");
                $("#txtCellDesc").val("");
                $("#txtCellEffFromDate").val("");
                $("#txtCellEffToDate").val("31-12-9999 00:00:00");

                $("#ddlPlant_ForShopCellNewEdit").prop('disabled', true);
                $("#ddlShop_ForShopCellNewEdit").prop('disabled', false);
                $("#txtCellID").prop('readonly', false);
                $("#txtCellEffFromDate").prop('readonly', false);
                $("#txtCellEffToDate").prop('readonly', false);
                $("#hfShopCellEditNew").val("New");
                $("#neweditShopCellModal .modal-title").text("Add Shop Cell");
            } else {
                debugger;
                $("#ddlPlant_ForShopCellNewEdit").val($(element).closest('tr').find("#hfPlantID").val());
                $("#ddlShop_ForShopCellNewEdit").val($(element).closest('tr').find("#hfShopID").val());
                $("#txtCellID").val($(element).closest('tr').find("#lblCellID").text());
                $("#txtCellDesc").val($(element).closest('tr').find("#lblDesc").text());
                $("#txtCellEffFromDate").val($(element).closest('tr').find("#lblEffevtiveFromDate").text());
                $("#txtCellEffToDate").val($(element).closest('tr').find("#lblEffevtiveToDate").text());

                $("#ddlPlant_ForShopCellNewEdit").prop('disabled', true);
                $("#ddlShop_ForShopCellNewEdit").prop('disabled', true);
                $("#txtCellID").prop('readonly', true);
                $("#txtCellEffFromDate").prop('readonly', true);
                $("#txtCellEffToDate").prop('readonly', true);
                $("#hfShopCellEditNew").val("Edit");
                $("#neweditShopCellModal .modal-title").text("Edit Shop Cell");
            }
            $(".mandatory-message").text("");
            $("#neweditShopCellModal").modal('show');

            return false;
        }
        function btnNewEditShopCellSaveClick() {
            //check company ID
            if ($("#ddlPlant_ForShopCellNewEdit").val() == "" || $("#ddlPlant_ForShopCellNewEdit").val() == null) {
                $(".mandatory-message").text("Plant ID is required.");
                return false;
            } else if ($("#ddlShop_ForShopCellNewEdit").val() == "" || $("#ddlShop_ForShopCellNewEdit").val() == null) {
                $(".mandatory-message").text("Shop ID is required.");
                return false;
            } else
                if ($("#txtCellID").val() == "") {
                    $(".mandatory-message").text("Cell ID is required.");
                    return false;
                } else if ($("#txtCellEffFromDate").val() == "") {
                    $(".mandatory-message").text("Effective From is required.");
                    return false;
                } else if ($("#txtCellEffToDate").val() == "") {
                    $(".mandatory-message").text("Effective To is required.");
                    return false;
                }
            return true;
        }

        function openShopCellDeleteConfirmModal(msg) {
            $("#shopcellDeleteMsg").text(msg);
            $("#shopcellDeleteConfirmModal").modal('show');
        }
        /*----------------------------------------------- End Shop Cell Details-----------------------------------------------*/


        /* -----------------------------------------Shop Group Details----------------------------------*/

        function btnNewOrEditShopGroupClick(element, param) {
            if (param == "New") {
                //  $("#ddlPlant_ForShopEditNew").val($(element).closest('tr').find("#lblPlantID").text());

                $("#txtGroupId").val("");
                $("#txtGroupDesc").val("");
                $("#txtGroupEffFromDate").val("");
                $("#txtGroupEffToDate").val("31-12-9999 00:00:00");

                $("#ddlPlant_ForShopGroupNewEdit").prop('disabled', true);
                $("#ddlShop_ForShopGroupNewEdit").prop('disabled', false);
                $("#txtGroupId").prop('readonly', false);
                $("#txtGroupEffFromDate").prop('readonly', false);
                $("#txtGroupEffToDate").prop('readonly', false);
                $("#hfShopGroupEditNew").val("New");
                $("#neweditShopGroupModal .modal-title").text("Add Shop Group");
            } else {
                $("#ddlPlant_ForShopGroupNewEdit").val($(element).closest('tr').find("#hfPlantID").val());
                $("#ddlShop_ForShopGroupNewEdit").val($(element).closest('tr').find("#hfShopID").val());
                $("#txtGroupId").val($(element).closest('tr').find("#lblGroupID").text());
                $("#txtGroupDesc").val($(element).closest('tr').find("#lblDesc").text());
                $("#txtGroupEffFromDate").val($(element).closest('tr').find("#lblEffevtiveFromDate").text());
                $("#txtGroupEffToDate").val($(element).closest('tr').find("#lblEffevtiveToDate").text());

                $("#ddlPlant_ForShopGroupNewEdit").prop('disabled', true);
                $("#ddlShop_ForShopGroupNewEdit").prop('disabled', true);
                $("#txtGroupId").prop('readonly', true);
                $("#txtGroupEffFromDate").prop('readonly', true);
                $("#txtGroupEffToDate").prop('readonly', true);
                $("#hfShopGroupEditNew").val("Edit");
                $("#neweditShopGroupModal .modal-title").text("Edit Shop Group");
            }
            $(".mandatory-message").text("");
            $("#neweditShopGroupModal").modal('show');

            return false;
        }


        function btnNewEditShopGroupSaveClick() {
            //check company ID
            if ($("#ddlPlant_ForShopGroupNewEdit").val() == "" || $("#ddlPlant_ForShopGroupNewEdit").val() == null) {
                $(".mandatory-message").text("Plant ID is required.");
                return false;
            } else if ($("#ddlShop_ForShopGroupNewEdit").val() == "" || $("#ddlShop_ForShopGroupNewEdit").val() == null) {
                $(".mandatory-message").text("Shop ID is required.");
                return false;
            } else
                if ($("#txtGroupId").val() == "") {
                    $(".mandatory-message").text("Group ID is required.");
                    return false;
                } else if ($("#txtGroupEffFromDate").val() == "") {
                    $(".mandatory-message").text("Effective From is required.");
                    return false;
                } else if ($("#txtGroupEffToDate").val() == "") {
                    $(".mandatory-message").text("Effective To is required.");
                    return false;
                }
            return true;
        }
        function openShopGroupDeleteConfirmModal(msg) {
            $("#shopgroupDeleteMsg").text(msg);
            $("#shopgroupDeleteConfirmModal").modal('show');
        }
        /* ---------------------------------------------End Shop Group Details -----------------------------*/


        /* -----------------------------------------Shop Cell Group Details----------------------------------*/

        function btnNewOrEditShopCellGroupClick(element, param) {
            if (param == "New") {
                //  $("#ddlPlant_ForShopEditNew").val($(element).closest('tr').find("#lblPlantID").text());

                $("#txtShopCellGroupID").val("");
                $("#txtShopCellGroupName").val("");
                $("#txtShopCellGroupEffFromDate").val("");
                $("#txtShopCellGroupEffToDate").val("31-12-9999 00:00:00");

                $("#ddlPlant_ForShopCellGroupNewEdit").prop('disabled', true);
                $("#ddlShop_ForShopCellGRoupNewEdit").prop('disabled', false);
                $("#ddlCell_ForShopCellGroupNewEdit").prop('disabled', false);
                $("#txtShopCellGroupID").prop('readonly', false);
                $("#txtShopCellGroupEffFromDate").prop('readonly', false);
                $("#txtShopCellGroupEffToDate").prop('readonly', true);
                $("#hfShopCellGroupEditNew").val("New");
                $("#neweditShopCellGroupModal .modal-title").text("Add Shop Cell Group");
            } else {
                $("#ddlPlant_ForShopCellGroupNewEdit").val($(element).closest('tr').find("#hfPlantID").val());
                $("#ddlShop_ForShopCellGRoupNewEdit").val($(element).closest('tr').find("#hfShopID").val());
                $("#ddlCell_ForShopCellGroupNewEdit").val($(element).closest('tr').find("#lblCellID").text());
                $("#txtShopCellGroupID").val($(element).closest('tr').find("#lblGroupID").text());
                $("#txtShopCellGroupName").val($(element).closest('tr').find("#lblDesc").text());
                $("#txtShopCellGroupEffFromDate").val($(element).closest('tr').find("#lblEffevtiveFromDate").text());
                $("#txtShopCellGroupEffToDate").val($(element).closest('tr').find("#lblEffevtiveToDate").text());

                $("#ddlPlant_ForShopCellGroupNewEdit").prop('disabled', true);
                $("#ddlShop_ForShopCellGRoupNewEdit").prop('disabled', true);
                $("#ddlCell_ForShopCellGroupNewEdit").prop('disabled', true);
                $("#txtShopCellGroupID").prop('readonly', true);
                $("#txtShopCellGroupEffFromDate").prop('readonly', true);
                $("#txtShopCellGroupEffToDate").prop('readonly', true);
                $("#hfShopCellGroupEditNew").val("Edit");
                $("#neweditShopCellGroupModal .modal-title").text("Edit Shop Cell Group");
            }
            $(".mandatory-message").text("");
            $("#neweditShopCellGroupModal").modal('show');

            return false;
        }


        function btnNewEditShopCellGroupSaveClick() {
            //check company ID
            if ($("#ddlPlant_ForShopCellGroupNewEdit").val() == "" || $("#ddlPlant_ForShopCellGroupNewEdit").val() == null) {
                $(".mandatory-message").text("Plant ID is required.");
                return false;
            } else if ($("#ddlShop_ForShopCellGRoupNewEdit").val() == "" || $("#ddlShop_ForShopCellGRoupNewEdit").val() == null) {
                $(".mandatory-message").text("Shop ID is required.");
                return false;
            } else if ($("#ddlCell_ForShopCellGroupNewEdit").val() == "" || $("#ddlCell_ForShopCellGroupNewEdit").val() == null) {
                $(".mandatory-message").text("Cell ID is required.");
                return false;
            }
            else
                if ($("#txtShopCellGroupID").val() == "") {
                    $(".mandatory-message").text("Group ID is required.");
                    return false;
                } else if ($("#txtShopCellGroupEffFromDate").val() == "") {
                    $(".mandatory-message").text("Effective From is required.");
                    return false;
                } else if ($("#txtShopCellGroupEffToDate").val() == "") {
                    $(".mandatory-message").text("Effective To is required.");
                    return false;
                }
            return true;
        }
        function openShopCellGroupDeleteConfirmModal(msg) {
            $("#shopcellgroupDeleteMsg").text(msg);
            $("#shopcellgroupDeleteConfirmModal").modal('show');
        }
        /* ---------------------------------------------End Shop Cell Group Details -----------------------------*/

        //------ Plant Group Master------
        $('[id$=txtPGEffectiveFromDate]').datetimepicker({
            format: 'DD-MM-YYYY HH:mm:ss',
            locale: 'en-US'
        });
        $('[id$=txtPGEffectiveToDate]').datetimepicker({
            format: 'DD-MM-YYYY HH:mm:ss',
            locale: 'en-US'
        });
        function plantGroupDataInsertValidation() {
            if ($('#ddlPGPlantID').val().trim() == "") {
                $(".mandatory-message").text("Plant ID is required.");
                return false;
            }
            if ($('#txtPGGroupID').val().trim() == "") {
                $(".mandatory-message").text("Group ID is required.");
                return false;
            }
            if ($("#txtPGEffectiveFromDate").val() == "") {
                $(".mandatory-message").text("Effective From is required.");
                return false;
            }
            $(".modal-backdrop").removeClass("modal-backdrop in");
            return true;
        }
        function openAddEditPlantGroupInfo() {
            //$(".modal-backdrop").removeClass("modal-backdrop in");
            if ($("#hdnPlantGroupInsertUpdate").val() == "Edit") {
                $("#addEditPlantGroupInfo .modal-title").text("Edit Group");
            } else {
                $("#addEditPlantGroupInfo .modal-title").text("Add Group");
            }
            $('#addEditPlantGroupInfo').modal('show');
        }
        function openPlantGroupDeleteConfirmModal(msg) {
            $(".modal-backdrop").removeClass("modal-backdrop in");
            $("#plantgroupDeleteMsg").text(msg);
            $('#plantGroupDeleteConfirmModal').modal('show');
        }

        //-------- End Plant Group Master ------

        //Cell Group Master
        $('[id$=txtCGEffectiveFromDate]').datetimepicker({
            format: 'DD-MM-YYYY HH:mm:ss',
            locale: 'en-US'
        });
        $('[id$=txtCGEffectiveToDate]').datetimepicker({
            format: 'DD-MM-YYYY HH:mm:ss',
            locale: 'en-US'
        });

        function cellGroupDataInsertValidation() {
            if ($('#ddlCGCellID').val().trim() == "") {
                $(".mandatory-message").text("Cell ID is required.");
                return false;
            }
            if ($('#txtCGGroupID').val().trim() == "") {
                $(".mandatory-message").text("Group ID is required.");
                return false;
            }
            if ($("#txtCGEffectiveFromDate").val() == "") {
                $(".mandatory-message").text("Effective From is required.");
                return false;
            }
            $(".modal-backdrop").removeClass("modal-backdrop in");
            return true;
        }
        function openAddEditCellGroupInfo() {
            //$(".modal-backdrop").removeClass("modal-backdrop in");
            if ($("#hdnCellGroupParam").val() == "Edit") {
                $("#addEditCellGroupInfo .modal-title").text("Edit Cell Group");
            } else {
                $("#addEditCellGroupInfo .modal-title").text("Add Cell Group");
            }
            $('#addEditCellGroupInfo').modal('show');
        }
        function openCellGroupDeleteConfirmModal(msg) {
            $(".modal-backdrop").removeClass("modal-backdrop in");
            $("#cellgroupDeleteMsg").text(msg);
            $('#cellGroupDeleteConfirmModal').modal('show');
        }
        //End Cell Group Master


        //------ Cell Master------
        $('[id$=txtCellEffectiveFromDate]').datetimepicker({
            format: 'DD-MM-YYYY HH:mm:ss',
            locale: 'en-US'
        });
        $('[id$=txtCellEffectiveToDate]').datetimepicker({
            format: 'DD-MM-YYYY HH:mm:ss',
            locale: 'en-US'
        });
        function cellDataInsertValidation() {
            if ($('#ddlCellPlantID').val().trim() == "") {
                $(".mandatory-message").text("Plant ID is required.");
                return false;
            }
            if ($('#txtCellCellID').val().trim() == "") {
                $(".mandatory-message").text("Cell ID is required.");
                return false;
            }
            if ($("#txtCellEffectiveFromDate").val() == "") {
                $(".mandatory-message").text("Effective From is required.");
                return false;
            }

            $(".modal-backdrop").removeClass("modal-backdrop in");
            return true;
        }
        function openAddEditCellInfo() {
            //$(".modal-backdrop").removeClass("modal-backdrop in");
            if ($("#hdnCellInserUpdateParam").val() == "Edit") {
                $("#addEditCellInfo .modal-title").text("Edit Cell");
            } else {
                $("#addEditCellInfo .modal-title").text("Add Cell");
            }
            $('#addEditCellInfo').modal('show');
        }
        function openCellDeleteConfirmModal(msg) {
            $(".modal-backdrop").removeClass("modal-backdrop in");
            $("#cellDeleteMsg").text(msg);
            $('#cellDeleteConfirmModal').modal('show');
        }
        function clearTheModalScreen() {
            $(".modal-backdrop").removeClass("modal-backdrop in");
            return true;
        }
        //-------- End Cell Master ------

        //-------- Machine Master Data -----
        $('[id$=txtNEEffFromDate]').datetimepicker({
            format: 'DD-MM-YYYY HH:mm:ss',
            locale: 'en-US'
        });
        $('[id$=txtNEEffToDate]').datetimepicker({
            format: 'DD-MM-YYYY HH:mm:ss',
            locale: 'en-US'
        });
        function machineDataInsertValidation() {
            if ($('#txtNEMachineID').val().trim() == "") {
                $(".mandatory-message").text("Machine ID is required.");
                return false;
            }
            if ($('#txtNEInterfaceID').val().trim() == "") {
                $(".mandatory-message").text("Interface ID is required.");
                return false;
            }
            if ($("#txtNEEffFromDate").val() == "") {
                $(".mandatory-message").text("Effective From is required.");
                return false;
            }
            $(".modal-backdrop").removeClass("modal-backdrop in");
            return true;
        }

        function openCloseAddEditMachineInfoModal(param) {
            $('.mandatory-message').text('');
            $(".modal-backdrop").removeClass("modal-backdrop in");
            $('#addEditMachineInfo').modal(param);
        }
        $('.allowDecimal').keypress(function (evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            var pos = evt.target.selectionStart;
            debugger;
            if (charCode == 45 && pos != 0) {
                return false;
            } else if (charCode == 43 && pos != 0) {
                return false;
            } else if (charCode == 46 && $(this).val().indexOf('.') != -1) {
                return false;
            } else if (charCode > 31 && charCode != 46 && (charCode < 48 || charCode > 57) && charCode != 45 && charCode != 43) {
                return false;
            }
            var afterdecimalpt = $(this).val().split('.')[1];
            if (afterdecimalpt != undefined) {
                if (afterdecimalpt.length > 2) {
                    return false;
                }
            }
            return true;
        });
        $('.allowNumber').keypress(function (evt) {
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            var pos = evt.target.selectionStart;
            if (charCode == 48 && pos == 0) {
                return false
            } else if ((charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        });

        function openMachineDeleteConfirmModal(msg) {
            $("#machineDeleteMsg").text(msg);
            $('#machineDeleteConfirmModal').modal('show');
        }
        //-------- End Machine Master Data -----

        //------- Employee Master -------
        $('[id$=txtEmpEffectiveFromDate]').datetimepicker({
            format: 'DD-MM-YYYY HH:mm:ss',
            locale: 'en-US'
        });
        $('[id$=txtEmpEffectiveToDate]').datetimepicker({
            format: 'DD-MM-YYYY HH:mm:ss',
            locale: 'en-US'
        });
        function employeeDataInsertValidation() {
            if ($('#txtEmpUserID').val().trim() == "") {
                $(".mandatory-message").text("User ID is required.");
                return false;
            }
            if ($('#txtEmpUerName').val().trim() == "") {
                $(".mandatory-message").text("User Name is required.");
                return false;
            }
            if ($('#ddlEmpRole').val() == null || $('#ddlEmpRole').val() == "") {
                $(".mandatory-message").text("Role is required.");
                return false;
            }
            if ($("#txtEmpEffectiveFromDate").val() == "") {
                $(".mandatory-message").text("Effective From is required.");
                return false;
            }
            if ($('#chkEmpIsEmployee').prop("checked")) {
                if ($('#txtEmpEmployeeID').val() == "") {
                    $(".mandatory-message").text("Employee ID is required.");
                    return false;
                }
            }
            if ($('#txtEmpPassword').val().trim() != "") {
                var passowrd = $('#txtEmpPassword').val();
                var isPassContainCaps = false, isPassContainLoweCase = false, isPasswordContainSpecialChat = false, isPasswordContainNumber = false;
                if (passowrd.length < 8 || passowrd.length > 15) {
                    //$(".mandatory-message").text("Password must be 8 or more characters in length.");
                    $(".mandatory-message").text("Password should be greater than 7 characters and less than 16 characters.");
                    return false;
                }
                for (var i = 0; i < passowrd.length; i++) {
                    var charCode = passowrd.charCodeAt(i);
                    if (charCode >= 65 && charCode <= 90) {
                        isPassContainCaps = true;
                    }
                    else if (charCode >= 97 && charCode <= 122) {
                        isPassContainLoweCase = true;
                    }
                    else if (charCode >= 48 && charCode <= 57) {
                        isPasswordContainNumber = true;
                    }
                    else if ((charCode >= 33 && charCode <= 47) || (charCode >= 58 && charCode <= 64) || (charCode >= 91 && charCode <= 96) || (charCode >= 123 && charCode <= 126)) {
                        isPasswordContainSpecialChat = true;
                    }
                }
                if (isPassContainCaps == false) {
                    $(".mandatory-message").text("Password must contain 1 or more uppercase characters.");
                    return false;
                }
                if (isPassContainLoweCase == false) {
                    $(".mandatory-message").text("Password must contain 1 or more lowercase characters.");
                    return false;
                }
                if (isPasswordContainNumber == false) {
                    $(".mandatory-message").text("Password must contain 1 or more digit characters.");
                    return false;
                }
                if (isPasswordContainSpecialChat == false) {
                    $(".mandatory-message").text("Password must contain 1 or more special characters.");
                    return false;
                }
            }

            if ($("#txtEmpEmail").val() != "") {
                if (!isEmail($("#txtEmpEmail").val())) {
                    $(".mandatory-message").text("Enter valid Email.");
                    return false;
                }
            }
            $(".modal-backdrop").removeClass("modal-backdrop in");
            return true;
        }
        function showEmployeeIDInfo() {
            debugger;
            if ($('#chkEmpIsEmployee').prop("checked")) {
                $('#txtEmpEmployeeID').removeAttr("readOnly");
            }
            else {
                $('#txtEmpEmployeeID').val("");
                $('#txtEmpEmployeeID').attr("readOnly", "readOnly");
            }
        }
        $('.mobileNoValidation').keypress(function (evt) {
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            var pos = evt.target.selectionStart;
            if ((charCode < 48 || charCode > 57)) {
                return false;
            }
            if ($(this).val().length > 9) {
                return false;
            }
            return true;
        });
        function isEmail(email) {
            var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
            return regex.test(email);
        }
        function openCloseAddEditEmployeeInfoModal(param) {
            $(".modal-backdrop").removeClass("modal-backdrop in");
            $('#addEditEmployeeInfo').modal(param);
        }
        function openEmployeeDeleteConfirmModal(msg) {
            $("#userDeleteMsg").text(msg);
            $('#employeeDeleteConfirmModal').modal('show');
        }
        //-------End Employee Masterk -----

        $(".checkbox-radiobtn").click(function () {
            if ($(this).find('input').prop('checked')) {
                $(".checkbox-radiobtn input").prop('checked', false);
                $(this).find('input').prop('checked', true);
            }
        });
        /*----------------------------------Assign Mahines Details -------------------------------------*/
        function setActiveAssignMachineMenu(liid) {
            //localStorage.setItem("lhmselectedAssignMachineSubMenu", "#assignMachinemenu0");
            localStorage.setItem("lhmselectedAssignMachineSubMenu", liid);
            activeAssignMachineSubMenu();

        }
        //---------Not allow multiple check in each row
        $(".select-onecheckbox-eachrow tr td input").click(function () {
            var colNumber = $(this).closest('tr').find('td input').index($(this));
            let isAnyOneChecked = false;
            for (let i = 0; i < $(this).closest('tr').find('td input').length; i++) {
                let input = $(this).closest('tr').find('td input')[i];

                if (colNumber == i) {
                    continue;
                }
                if ($(input).prop('checked')) {
                    isAnyOneChecked = true;
                }
            }
            if (isAnyOneChecked) {
                return false;
            } else {
                return true;
            }
        });
        /*----------------------------------End Assign Mahines Details -------------------------------------*/

        /* ---------------------------------------------Role Details----------------------------------------------------------*/
        function btnNewOrEditRoleClick(element, param) {
            if (param == "New") {
                $("#txtRoleName").val("");
                $("#txtRoleEffFromDate").val("");
                $("#txtRoleEffToDate").val("31-12-9999 00:00:00");


                $("#txtRoleName").prop('readonly', false);
                $("#txtRoleEffFromDate").prop('readonly', false);
                $("#txtRoleEffToDate").prop('readonly', true);
                $("#hfRoleNewEdit").val("New");
                $("#neweditRoleModal .modal-title").text("Add Role");
            } else {

                $("#txtRoleName").val($(element).closest('tr').find("#lblRoleName").text());
                $("#txtRoleEffFromDate").val($(element).closest('tr').find("#lblEffevtiveFromDate").text());
                $("#txtRoleEffToDate").val($(element).closest('tr').find("#lblEffevtiveToDate").text());

                $("#txtRoleName").prop('readonly', true);
                $("#txtRoleEffFromDate").prop('readonly', true);
                $("#txtRoleEffToDate").prop('readonly', true);
                $("#hfRoleNewEdit").val("Edit");
                $("#neweditRoleModal .modal-title").text("Edit Role");
            }
            $(".mandatory-message").text("");
            $("#neweditRoleModal").modal('show');

            return false;
        }
        function btnNewEditRoleSaveClick() {
            //check company ID
            if ($("#txtRoleName").val() == "") {
                $(".mandatory-message").text("Role Name is required.");
                return false;
            }
            if ($("#txtRoleEffFromDate").val() == "") {
                $(".mandatory-message").text("Effective From is required.");
                return false;
            }
            if ($("#txtRoleEffToDate").val() == "") {
                $(".mandatory-message").text("Effective To is required.");
                return false;
            }
            return true;
        }

        function openRoleDeleteConfirmModal(msg) {
            $("#roleDeleteMsg").text(msg);
            $("#roleDeleteConfirmModal").modal('show');
        }
        /*----------------------------------------------- End Role Details-----------------------------------------------*/

        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {


            $(document).ready(function () {
                //if (localStorage.getItem("lhmselectedSubMenu")) {
                //    debugger;
                //    submenu = localStorage.getItem("lhmselectedSubMenu");
                //}
                //$(submenu).addClass("in active");
                //$("a[href$='" + submenu + "']").removeClass("selected-menu-style").addClass("selected-Submenu");
                //$("a[href$='" + submenu + "']").closest('li').find('i').addClass("arrow up selected-Submenu-ArrowUp");
                activeSubMenu();


                //if (localStorage.getItem("lhmselected_sub_SubMenu")) {
                //    debugger;
                //    sub_submenu = localStorage.getItem("lhmselected_sub_SubMenu");
                //}
                //$(sub_submenu).addClass("in active");
                //$("a[href$='" + sub_submenu + "']").removeClass("selected-menu-style").addClass("selected-sub-Submenu");
                //$("a[href$='" + sub_submenu + "']").closest('li').find('i').addClass("arrow up selected-sub-Submenu-ArrowUp");
                activesub_SubMenu();
                activeAssignMachineSubMenu();

                setGridHeight();
                setDateTimePicker();
                $.unblockUI({});
            });
            $(".checkbox-radiobtn").click(function () {
                if ($(this).find('input').prop('checked')) {
                    $(".checkbox-radiobtn input").prop('checked', false);
                    $(this).find('input').prop('checked', true);
                }
            });
            function setPlantLevelMenu(id) {
                debugger;
                localStorage.setItem("lhmselectedSubMenu", id);
                activeSubMenu();
            }
           
            $(".submenuData").click(function () {
                debugger;
                //$('[id*=hdnScrollPos]').val(0);

                // localStorage.clear("lhmselected_sub_SubMenu");
                let otherMenuExceptShopCellGroupSelected = true;
                $.blockUI({ message: '<img runat="server" src="Images/Loading.gif" />' });
                if ($("#mainBody").hasClass("light-mode")) {
                    $(".submenuData").removeClass("selected-menu-style selected-Submenu").addClass("other-menu-style");
                    $(".submenuData").closest('li').find('i').removeClass();
                    $(this).removeClass("other-menu-style selected-Submenu").addClass("selected-menu-style");
                } else {
                    $(".submenuData").removeClass("selected-menu-style selected-Submenu").addClass("other-menu-style");
                    $(".submenuData").closest('li').find('i').removeClass();
                    $(this).removeClass("other-menu-style selected-Submenu").addClass("selected-menu-style");
                }

                $(this).closest('li').find('i').addClass("arrow up selected-Submenu-ArrowUp");
                submenu = $(this).attr('href');
                //$("#activeMenu").val(submenu);
                $(submenu).addClass("in active");
                if (submenu == "#LHmastermenu4") {
                    __doPostBack('<%= btnShop.UniqueID%>', '');
                    //  localStorage.clear("lhmselected_sub_SubMenu");
                    //localStorage.setItem("lhmselected_sub_SubMenu", "#shopsubmenu0");
                    //activesub_SubMenu();
                    setSubActiveMenu('Shop');
                    otherMenuExceptShopCellGroupSelected = false;
                     $("#hfActiveMenu").val("Shop");
                }
                else if (submenu == "#LHmastermenu5") {
                    __doPostBack('<%= btnCell.UniqueID%>', '');
                    //localStorage.clear("lhmselected_sub_SubMenu");
                    //localStorage.setItem("lhmselected_sub_SubMenu", "#cellsubmenu0");
                    //activesub_SubMenu();
                    setSubActiveMenu('Cell');
                    otherMenuExceptShopCellGroupSelected = false;
                     $("#hfActiveMenu").val("Cell");
                }
                else if (submenu == "#LHmastermenu6") {
                    __doPostBack('<%= btnGroup.UniqueID%>', '');
                    otherMenuExceptShopCellGroupSelected = false;
                     $("#hfActiveMenu").val("Group");
                }
                else if (submenu == "#LHmastermenu7") {
                    __doPostBack('<%= btnAssignMachine.UniqueID%>', '');
                     $("#hfActiveMenu").val("Machine");
                }

                if (otherMenuExceptShopCellGroupSelected) {
                    $("#hfSelectedPlant").val("DisablePlantLevelMenu");
                    //  setPlantLevelMenu("");
                    //localStorage.removeItem("lhmselectedSubMenu");
                    //activeSubMenu();

                    //$("#Shop").css('display', 'none');
                    //$("#Cell").css('display', 'none');
                    //$("#Group").css('display', 'none');

                }
                localStorage.setItem("lhmselectedSubMenu", submenu);
            });

            $(".sub_submenuData").click(function () {
                debugger;
                //$('[id*=hdnScrollPos]').val(0);
                $.blockUI({ message: '<img runat="server" src="Images/Loading.gif" />' });
                if ($("#mainBody").hasClass("light-mode")) {
                    $(".sub_submenuData").removeClass("selected-menu-style selected-sub-Submenu").addClass("other-menu-style");
                    $(".sub_submenuData").closest('li').find('i').removeClass();
                    $(this).removeClass("other-menu-style selected-Submenu").addClass("selected-menu-style");
                } else {
                    $(".sub_submenuData").removeClass("selected-menu-style selected-sub-Submenu").addClass("other-menu-style");
                    $(".sub_submenuData").closest('li').find('i').removeClass();
                    $(this).removeClass("other-menu-style selected-Submenu").addClass("selected-menu-style");
                }

                $(this).closest('li').find('i').addClass("arrow up selected-sub-Submenu-ArrowUp");
                sub_submenu = $(this).attr('href');
                //$("#activeMenu").val(submenu);
                $(sub_submenu).addClass("in active");
                if (sub_submenu == "#shopsubmenu0") {
                    __doPostBack('<%= btnShopCell.UniqueID%>', '');
                }
                else if (sub_submenu == "#shopsubmenu1") {
                    __doPostBack('<%= btnShopGroup.UniqueID%>', '');
                }
                else if (sub_submenu == "#shopsubmenu2") {
                    __doPostBack('<%= btnShopCellGroup.UniqueID%>', '');
                }
                if (sub_submenu == "#cellsubmenu0") {
                    __doPostBack('<%= btnCellGroup.UniqueID%>', '');
                }
                   <%-- else if (sub_submenu == "#cellsubmenu1") {
                        __doPostBack('<%= btnPlantGroup.UniqueID%>', '');
                    }--%>
                localStorage.setItem("lhmselected_sub_SubMenu", sub_submenu);
            });


            $(".shopcell_submenuData").click(function () {
                debugger;
                //$('[id*=hdnScrollPos]').val(0);
                $.blockUI({ message: '<img runat="server" src="Images/Loading.gif" />' });
                if ($("#mainBody").hasClass("light-mode")) {
                    $(".shopcell_submenuData").removeClass("selected-menu-style selected-sub-Submenu").addClass("other-menu-style");
                    $(".shopcell_submenuData").closest('li').find('i').removeClass();
                    $(this).removeClass("other-menu-style selected-Submenu").addClass("selected-menu-style");
                } else {
                    $(".shopcell_submenuData").removeClass("selected-menu-style selected-sub-Submenu").addClass("other-menu-style");
                    $(".shopcell_submenuData").closest('li').find('i').removeClass();
                    $(this).removeClass("other-menu-style selected-Submenu").addClass("selected-menu-style");
                }

                $(this).closest('li').find('i').addClass("arrow up selected-sub-Submenu-ArrowUp");
                shopcell_submenu = $(this).attr('href');
                //$("#activeMenu").val(submenu);
                $(shopcell_submenu).addClass("in active");
                if (shopcell_submenu == "#shopsubmenu2") {
                    __doPostBack('<%= btnShopCellGroup.UniqueID%>', '');
                }
                localStorage.setItem("lhmselected_shopcell_subMenu", shopcell_submenu);
            });
            $(".assignMachine_menuData").click(function () {
                debugger;
                //$('[id*=hdnScrollPos]').val(0);
                $.blockUI({ message: '<img runat="server" src="Images/Loading.gif" />' });
                if ($("#mainBody").hasClass("light-mode")) {
                    $(".assignMachine_menuData").removeClass("selected-menu-style selected-sub-Submenu").addClass("other-menu-style");
                    $(".assignMachine_menuData").closest('li').find('i').removeClass();
                    $(this).removeClass("other-menu-style selected-Submenu").addClass("selected-menu-style");
                } else {
                    $(".assignMachine_menuData").removeClass("selected-menu-style selected-sub-Submenu").addClass("other-menu-style");
                    $(".assignMachine_menuData").closest('li').find('i').removeClass();
                    $(this).removeClass("other-menu-style selected-Submenu").addClass("selected-menu-style");
                }

                $(this).closest('li').find('i').addClass("arrow up selected-sub-Submenu-ArrowUp");
                sub_submenu = $(this).attr('href');
                //$("#activeMenu").val(submenu);
                $(sub_submenu).addClass("in active");
                if (sub_submenu == "#assignMachinemenu0") {
                    __doPostBack('<%= btnAssignMachineToPlant.UniqueID%>', '');
                }
                else if (sub_submenu == "#assignMachinemenu1") {
                    __doPostBack('<%= btnAssignMachineToCell.UniqueID%>', '');
                }
                else if (sub_submenu == "#assignMachinemenu2") {
                    __doPostBack('<%= btnAssignMachineToGroup.UniqueID%>', '');
                }
                else if (sub_submenu == "#assignMachinemenu3") {
                    __doPostBack('<%= btnAssignMachineToShop.UniqueID%>', '');
                }
                localStorage.setItem("lhmselectedAssignMachineSubMenu", sub_submenu);
            });
            function setSubActiveMenu(menu) {
                // localStorage.clear("lhmselected_sub_SubMenu");
                let enterBlock = false;
                if (menu == "Shop") {
                    var lilist = $("#shop_submenu_ul li");
                    for (let i = 0; i < lilist.length; i++) {
                        let li = lilist[i];
                        let display = $(li).css('display');
                        debugger;
                        if (display == "block") {
                            localStorage.setItem("lhmselected_sub_SubMenu", $(li).find('a').attr('href'));
                            activesub_SubMenu();
                            enterBlock = true;
                            break;
                        }
                    }

                    if ($("[id*=ShopCellGroup]").css('display') == "block") {
                        localStorage.setItem("lhmselected_shopcell_subMenu", "#shopsubmenu2");
                        activesub_SubMenu();
                    } else {
                        localStorage.removeItem("lhmselected_shopcell_subMenu");
                        activesub_SubMenu();
                    }
                } else {
                    var lilist = $("#cell_submenu_ul li");
                    for (let i = 0; i < lilist.length; i++) {
                        let li = lilist[i];
                        let display = $(li).css('display');
                        if (display == "block") {
                            localStorage.setItem("lhmselected_sub_SubMenu", $(li).find('a').attr('href'));
                            activesub_SubMenu();
                            enterBlock = true;
                            break;
                        }
                    }
                }
                if (!enterBlock) {
                    localStorage.removeItem("lhmselected_sub_SubMenu");
                    activesub_SubMenu();
                }
            }
            function openModal(modalid) {
                $("#" + modalid).modal('show');
            }

            function openWarningModal(msg) {
                $("#lblWarningMsg").text(msg);
                $("#warningModal").modal('show');
            }
            function openErrorModal(msg) {
                $('#errorModal').modal('show');
                $('#lblErrorMsg').text(msg);
            }
            function showSuccessMsg(msg, title) {
                debugger;
                toastr.options = {
                    "closeButton": true,
                    "debug": false,
                    "newestOnTop": false,
                    "progressBar": true,
                    "positionClass": "toast-top-right",
                    "preventDuplicates": true,
                    "onclick": null,
                    "showDuration": "4000",
                    "hideDuration": "1000",
                    "timeOut": "4000",
                    "extendedTimeOut": "1000",
                    "showEasing": "swing",
                    "hideEasing": "linear",
                    "showMethod": "fadeIn",
                    "hideMethod": "fadeOut"
                }

                toastr['success'](msg, title);
                return false;
            }


            /*  ------------------------------------------------------ Plant Details----------------------------------------------------*/
            function btnNewOrEditPlantClick(element, param) {
                if (param == "New") {
                    $("#txtPlantID").val("");
                    $("#txtPlantDesc").val("");
                    $("#txtPlantCode").val("");
                    $("#txtPlantAddress").val("");
                    //$("#txtPlantCountry").val("");
                    $("#txtPlantRegion").val("");
                    $("#txtPlantGeoLocation").val("");
                    $("#txtPlatCity").val("");
                    $("#txtPlantEffFromDate").val("");
                    $("#txtPlantEffToDate").val("31-12-9999 00:00:00");

                    $("#txtPlantID").prop('readonly', false);
                    $("#txtPlantEffFromDate").prop('readonly', false);
                    $("#txtPlantEffToDate").prop('readonly', true);
                    $("#hfPlantEditNew").val("New");
                    $("#neweditPlantModal .modal-title").text("Add Plant");
                } else {
                    $("#txtPlantID").val($(element).closest('tr').find("#lblPlantID").text());
                    $("#txtPlantDesc").val($(element).closest('tr').find("#lblPlantDesc").text());
                    $("#txtPlantCode").val($(element).closest('tr').find("#lblCode").text());
                    $("#txtPlantAddress").val($(element).closest('tr').find("#lblAddress").text());
                    $("#ddlPlantCountry").val($(element).closest('tr').find("#lblCountry").text());
                    $("#txtPlantRegion").val($(element).closest('tr').find("#lblRegion").text());
                    $("#txtPlantGeoLocation").val($(element).closest('tr').find("#lblGeoLoaction").text());
                    $("#txtPlatCity").val($(element).closest('tr').find("#lblCity").text());
                    $("#txtPlantEffFromDate").val($(element).closest('tr').find("#lblEffevtiveFromDate").text());
                    $("#txtPlantEffToDate").val($(element).closest('tr').find("#lblEffevtiveToDate").text());

                    $("#txtPlantID").prop('readonly', true);
                    $("#txtPlantEffFromDate").prop('readonly', true);
                    $("#txtPlantEffToDate").prop('readonly', true);
                    $("#hfPlantEditNew").val("Edit");
                    $("#neweditPlantModal .modal-title").text("Edit Plant");
                }
                $(".mandatory-message").text("");
                $("#neweditPlantModal").modal('show');

                return false;
            }
            $("#gvPlantDetails tr").click(function () {
                $("#gvPlantDetails tr").css('background-color', 'unset');
                $(this).css('background-color', 'red');
                $("#hfSelectedPlant").val($(this).find("#lblPlantID").text());
            });
            function openPlantDeleteConfirmModal(msg) {
                $("#plantDeleteMsg").text(msg);
                $("#plantDeleteConfirmModal").modal('show');
            }

            /*  ------------------------------------------------------ End Plant Details----------------------------------------------------*/

            /* ---------------------------------------------Shop Details----------------------------------------------------------*/
            function btnNewOrEditPlantShopClick(element, param) {
                if (param == "New") {
                    //  $("#ddlPlant_ForShopEditNew").val($(element).closest('tr').find("#lblPlantID").text());

                    $("#txtShopID").val("");
                    $("#txtShopDesc").val("");
                    $("#txtShopGeoLocation").val("");
                    $("#txtShopEffFromDate").val("");
                    $("#txtShopEffToDate").val("31-12-9999 00:00:00");

                    $("#ddlPlant_ForShopEditNew").prop('disabled', true);
                    $("#txtShopID").prop('readonly', false);
                    $("#txtShopEffFromDate").prop('readonly', false);
                    $("#txtShopEffToDate").prop('readonly', true);
                    $("#hfShopEditNew").val("New");
                    $("#neweditShopModal .modal-title").text("Add Shop");
                } else {
                    $("#ddlPlant_ForShopEditNew").val($(element).closest('tr').find("#hfPlantID").val());
                    $("#txtShopID").val($(element).closest('tr').find("#lblShopID").text());
                    $("#txtShopDesc").val($(element).closest('tr').find("#lblShopDesc").text());
                    $("#txtShopGeoLocation").val($(element).closest('tr').find("#lblGeoLoaction").text());
                    $("#txtShopEffFromDate").val($(element).closest('tr').find("#lblEffevtiveFromDate").text());
                    $("#txtShopEffToDate").val($(element).closest('tr').find("#lblEffevtiveToDate").text());

                    $("#ddlPlant_ForShopEditNew").prop('disabled', true);
                    $("#txtShopID").prop('readonly', true);
                    $("#txtShopEffFromDate").prop('readonly', true);
                    $("#txtShopEffToDate").prop('readonly', true);
                    $("#hfShopEditNew").val("Edit");
                    $("#neweditShopModal .modal-title").text("Edit Shop");
                }
                $(".mandatory-message").text("");
                $("#neweditShopModal").modal('show');

                return false;
            }
            function openPlantShopDeleteConfirmModal(msg) {
                $("#shopDeleteMsg").text(msg);
                $("#plantshopDeleteConfirmModal").modal('show');
            }
            /*----------------------------------------------- End Shop Details-----------------------------------------------*/

            /* ---------------------------------------------Shop Cell Details----------------------------------------------------------*/
            function btnNewOrEditShopCellClick(element, param) {
                if (param == "New") {
                    //  $("#ddlPlant_ForShopEditNew").val($(element).closest('tr').find("#lblPlantID").text());

                    $("#txtCellID").val("");
                    $("#txtCellDesc").val("");
                    $("#txtCellEffFromDate").val("");
                    $("#txtCellEffToDate").val("31-12-9999 00:00:00");

                    $("#ddlPlant_ForShopCellNewEdit").prop('disabled', true);
                    $("#ddlShop_ForShopCellNewEdit").prop('disabled', false);
                    $("#txtCellID").prop('readonly', false);
                    $("#txtCellEffFromDate").prop('readonly', false);
                    $("#txtCellEffToDate").prop('readonly', false);
                    $("#hfShopCellEditNew").val("New");
                    $("#neweditShopCellModal .modal-title").text("Add Shop Cell");
                } else {
                    $("#ddlPlant_ForShopCellNewEdit").val($(element).closest('tr').find("#hfPlantID").val());
                    $("#ddlShop_ForShopCellNewEdit").val($(element).closest('tr').find("#hfShopID").val());
                    $("#txtCellID").val($(element).closest('tr').find("#lblCellID").text());
                    $("#txtCellDesc").val($(element).closest('tr').find("#lblDesc").text());
                    $("#txtCellEffFromDate").val($(element).closest('tr').find("#lblEffevtiveFromDate").text());
                    $("#txtCellEffToDate").val($(element).closest('tr').find("#lblEffevtiveToDate").text());

                    $("#ddlPlant_ForShopCellNewEdit").prop('disabled', true);
                    $("#ddlShop_ForShopCellNewEdit").prop('disabled', true);
                    $("#txtCellID").prop('readonly', true);
                    $("#txtCellEffFromDate").prop('readonly', true);
                    $("#txtCellEffToDate").prop('readonly', true);
                    $("#hfShopCellEditNew").val("Edit");
                    $("#neweditShopCellModal .modal-title").text("Edit Shop Cell");
                }
                $(".mandatory-message").text("");
                $("#neweditShopCellModal").modal('show');

                return false;
            }
            function openShopCellDeleteConfirmModal(msg) {
                $("#shopcellDeleteMsg").text(msg);
                $("#shopcellDeleteConfirmModal").modal('show');
            }

            /*----------------------------------------------- End Shop Cell Details-----------------------------------------------*/


            /* -----------------------------------------Shop Group Details----------------------------------*/

            function btnNewOrEditShopGroupClick(element, param) {
                if (param == "New") {
                    //  $("#ddlPlant_ForShopEditNew").val($(element).closest('tr').find("#lblPlantID").text());

                    $("#txtGroupId").val("");
                    $("#txtGroupDesc").val("");
                    $("#txtGroupEffFromDate").val("");
                    $("#txtGroupEffToDate").val("31-12-9999 00:00:00");

                    $("#ddlPlant_ForShopGroupNewEdit").prop('disabled', true);
                    $("#ddlShop_ForShopGroupNewEdit").prop('disabled', false);
                    $("#txtGroupId").prop('readonly', false);
                    $("#txtGroupEffFromDate").prop('readonly', false);
                    $("#txtGroupEffToDate").prop('readonly', false);
                    $("#hfShopGroupEditNew").val("New");
                    $("#neweditShopGroupModal .modal-title").text("Add Shop Group");
                } else {
                    $("#ddlPlant_ForShopGroupNewEdit").val($(element).closest('tr').find("#hfPlantID").val());
                    $("#ddlShop_ForShopGroupNewEdit").val($(element).closest('tr').find("#hfShopID").val());
                    $("#txtGroupId").val($(element).closest('tr').find("#lblGroupID").text());
                    $("#txtGroupDesc").val($(element).closest('tr').find("#lblDesc").text());
                    $("#txtGroupEffFromDate").val($(element).closest('tr').find("#lblEffevtiveFromDate").text());
                    $("#txtGroupEffToDate").val($(element).closest('tr').find("#lblEffevtiveToDate").text());

                    $("#ddlPlant_ForShopGroupNewEdit").prop('disabled', true);
                    $("#ddlShop_ForShopGroupNewEdit").prop('disabled', true);
                    $("#txtGroupId").prop('readonly', true);
                    $("#txtGroupEffFromDate").prop('readonly', true);
                    $("#txtGroupEffToDate").prop('readonly', true);
                    $("#hfShopGroupEditNew").val("Edit");
                    $("#neweditShopGroupModal .modal-title").text("Edit Shop Group");
                }
                $(".mandatory-message").text("");
                $("#neweditShopGroupModal").modal('show');

                return false;
            }
            function openShopGroupDeleteConfirmModal(msg) {
                $("#shopgroupDeleteMsg").text(msg);
                $("#shopgroupDeleteConfirmModal").modal('show');
            }
            /* ---------------------------------------------End Shop Group Details -----------------------------*/


            /* -----------------------------------------Shop Cell Group Details----------------------------------*/

            function btnNewOrEditShopCellGroupClick(element, param) {
                if (param == "New") {
                    //  $("#ddlPlant_ForShopEditNew").val($(element).closest('tr').find("#lblPlantID").text());

                    $("#txtShopCellGroupID").val("");
                    $("#txtShopCellGroupName").val("");
                    $("#txtShopCellGroupEffFromDate").val("");
                    $("#txtShopCellGroupEffToDate").val("31-12-9999 00:00:00");

                    $("#ddlPlant_ForShopCellGroupNewEdit").prop('disabled', true);
                    $("#ddlShop_ForShopCellGRoupNewEdit").prop('disabled', false);
                    $("#ddlCell_ForShopCellGroupNewEdit").prop('disabled', false);
                    $("#txtShopCellGroupID").prop('readonly', false);
                    $("#txtShopCellGroupEffFromDate").prop('readonly', false);
                    $("#txtShopCellGroupEffToDate").prop('readonly', true);
                    $("#hfShopCellGroupEditNew").val("New");
                    $("#neweditShopCellGroupModal .modal-title").text("Add Shop Cell Group");
                } else {
                    $("#ddlPlant_ForShopCellGroupNewEdit").val($(element).closest('tr').find("#hfPlantID").val());
                    $("#ddlShop_ForShopCellGRoupNewEdit").val($(element).closest('tr').find("#hfShopID").val());
                    $("#ddlCell_ForShopCellGroupNewEdit").val($(element).closest('tr').find("#lblCellID").text());
                    $("#txtShopCellGroupID").val($(element).closest('tr').find("#lblGroupID").text());
                    $("#txtShopCellGroupName").val($(element).closest('tr').find("#lblDesc").text());
                    $("#txtShopCellGroupEffFromDate").val($(element).closest('tr').find("#lblEffevtiveFromDate").text());
                    $("#txtShopCellGroupEffToDate").val($(element).closest('tr').find("#lblEffevtiveToDate").text());

                    $("#ddlPlant_ForShopCellGroupNewEdit").prop('disabled', true);
                    $("#ddlShop_ForShopCellGRoupNewEdit").prop('disabled', true);
                    $("#ddlCell_ForShopCellGroupNewEdit").prop('disabled', true);
                    $("#txtShopCellGroupID").prop('readonly', true);
                    $("#txtShopCellGroupEffFromDate").prop('readonly', true);
                    $("#txtShopCellGroupEffToDate").prop('readonly', true);
                    $("#hfShopCellGroupEditNew").val("Edit");
                    $("#neweditShopCellGroupModal .modal-title").text("Edit Shop Cell Group");
                }
                $(".mandatory-message").text("");
                $("#neweditShopCellGroupModal").modal('show');

                return false;
            }
            function openShopCellGroupDeleteConfirmModal(msg) {
                $("#shopcellgroupDeleteMsg").text(msg);
                $("#shopcellgroupDeleteConfirmModal").modal('show');
            }
            /* ---------------------------------------------End Shop Cell Group Details -----------------------------*/

            //------ Plant Group Master------
            $('[id$=txtPGEffectiveFromDate]').datetimepicker({
                format: 'DD-MM-YYYY HH:mm:ss',
                locale: 'en-US'
            });
            $('[id$=txtPGEffectiveToDate]').datetimepicker({
                format: 'DD-MM-YYYY HH:mm:ss',
                locale: 'en-US'
            });
            function openPlantGroupDeleteConfirmModal(msg) {
                $(".modal-backdrop").removeClass("modal-backdrop in");
                $("#plantgroupDeleteMsg").text(msg);
                $('#plantGroupDeleteConfirmModal').modal('show');
            }
            //-------- End Plant Group Master ------

            //Cell Group Master
            $('[id$=txtCGEffectiveFromDate]').datetimepicker({
                format: 'DD-MM-YYYY HH:mm:ss',
                locale: 'en-US'
            });
            $('[id$=txtCGEffectiveToDate]').datetimepicker({
                format: 'DD-MM-YYYY HH:mm:ss',
                locale: 'en-US'
            });
            function openCellGroupDeleteConfirmModal(msg) {
                $(".modal-backdrop").removeClass("modal-backdrop in");
                $("#cellgroupDeleteMsg").text(msg);
                $('#cellGroupDeleteConfirmModal').modal('show');
            }
            //End Cell Group Master


            //------ Cell Master------
            $('[id$=txtCellEffectiveFromDate]').datetimepicker({
                format: 'DD-MM-YYYY HH:mm:ss',
                locale: 'en-US'
            });
            $('[id$=txtCellEffectiveToDate]').datetimepicker({
                format: 'DD-MM-YYYY HH:mm:ss',
                locale: 'en-US'
            });
            function openCellDeleteConfirmModal(msg) {
                $(".modal-backdrop").removeClass("modal-backdrop in");
                $("#cellDeleteMsg").text(msg);
                $('#cellDeleteConfirmModal').modal('show');
            }
            //-------- End Cell Master ------

            //-------- Machine Master Data -----
            $('[id$=txtNEEffFromDate]').datetimepicker({
                format: 'DD-MM-YYYY HH:mm:ss',
                locale: 'en-US'
            });
            $('[id$=txtNEEffToDate]').datetimepicker({
                format: 'DD-MM-YYYY HH:mm:ss',
                locale: 'en-US'
            });

            function openCloseAddEditMachineInfoModal(param) {
                $('.mandatory-message').text('');
                $(".modal-backdrop").removeClass("modal-backdrop in");
                $('#addEditMachineInfo').modal(param);
            }
            $('.allowDecimal').keypress(function (evt) {
                evt = (evt) ? evt : window.event;
                var charCode = (evt.which) ? evt.which : evt.keyCode;
                var pos = evt.target.selectionStart;
                debugger;
                if (charCode == 45 && pos != 0) {
                    return false;
                } else if (charCode == 43 && pos != 0) {
                    return false;
                } else if (charCode == 46 && $(this).val().indexOf('.') != -1) {
                    return false;
                } else if (charCode > 31 && charCode != 46 && (charCode < 48 || charCode > 57) && charCode != 45 && charCode != 43) {
                    return false;
                }
                var afterdecimalpt = $(this).val().split('.')[1];
                if (afterdecimalpt != undefined) {
                    if (afterdecimalpt.length > 2) {
                        return false;
                    }
                }
                return true;
            });
            $('.allowNumber').keypress(function (evt) {
                var charCode = (evt.which) ? evt.which : evt.keyCode;
                var pos = evt.target.selectionStart;
                if (charCode == 48 && pos == 0) {
                    return false
                } else if ((charCode < 48 || charCode > 57)) {
                    return false;
                }
                return true;
            });
            function openMachineDeleteConfirmModal(msg) {
                $("#machineDeleteMsg").text(msg);
                $('#machineDeleteConfirmModal').modal('show');
            }
            //-------- End Machine Master Data -----

            //------- Employee Master -------
            $('[id$=txtEmpEffectiveFromDate]').datetimepicker({
                format: 'DD-MM-YYYY HH:mm:ss',
                locale: 'en-US'
            });
            $('[id$=txtEmpEffectiveToDate]').datetimepicker({
                format: 'DD-MM-YYYY HH:mm:ss',
                locale: 'en-US'
            });
            $('.mobileNoValidation').keypress(function (evt) {
                var charCode = (evt.which) ? evt.which : evt.keyCode;
                var pos = evt.target.selectionStart;
                if ((charCode < 48 || charCode > 57)) {
                    return false;
                }
                if ($(this).val().length > 9) {
                    return false;
                }
                return true;
            });
            function isEmail(email) {
                var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
                return regex.test(email);
            }
            function openCloseAddEditEmployeeInfoModal(param) {
                $(".modal-backdrop").removeClass("modal-backdrop in");
                $('#addEditEmployeeInfo').modal(param);
            }
            function openEmployeeDeleteConfirmModal(msg) {
                $("#userDeleteMsg").text(msg);
                $('#employeeDeleteConfirmModal').modal('show');
            }
            //-------End Employee Masterk -----


            /*----------------------------------Assign Mahines Details -------------------------------------*/
            function setActiveAssignMachineMenu(liid) {
                //localStorage.setItem("lhmselectedAssignMachineSubMenu", "#assignMachinemenu0");
                localStorage.setItem("lhmselectedAssignMachineSubMenu", liid);
                activeAssignMachineSubMenu();

            }

            //---------Not allow multiple check in each row
            $(".select-onecheckbox-eachrow tr td input").click(function () {
                var colNumber = $(this).closest('tr').find('td input').index($(this));
                let isAnyOneChecked = false;
                for (let i = 0; i < $(this).closest('tr').find('td input').length; i++) {
                    let input = $(this).closest('tr').find('td input')[i];

                    if (colNumber == i) {
                        continue;
                    }
                    if ($(input).prop('checked')) {
                        isAnyOneChecked = true;
                    }
                }
                if (isAnyOneChecked) {
                    return false;
                } else {
                    return true;
                }
            });
              /*----------------------------------Enf Assign Mahines Details -------------------------------------*/

            /* ---------------------------------------------Role Details----------------------------------------------------------*/
            function btnNewOrEditRoleClick(element, param) {
                if (param == "New") {
                    $("#txtRoleName").val("");
                    $("#txtRoleEffFromDate").val("");
                    $("#txtRoleEffToDate").val("31-12-9999 00:00:00");


                    $("#txtRoleName").prop('readonly', false);
                    $("#txtRoleEffFromDate").prop('readonly', false);
                    $("#txtRoleEffToDate").prop('readonly', true);
                    $("#hfRoleNewEdit").val("New");
                    $("#neweditRoleModal .modal-title").text("Add Role");
                } else {

                    $("#txtRoleName").val($(element).closest('tr').find("#lblRoleName").text());
                    $("#txtRoleEffFromDate").val($(element).closest('tr').find("#lblEffevtiveFromDate").text());
                    $("#txtRoleEffToDate").val($(element).closest('tr').find("#lblEffevtiveToDate").text());

                    $("#txtRoleName").prop('readonly', true);
                    $("#txtRoleEffFromDate").prop('readonly', true);
                    $("#txtRoleEffToDate").prop('readonly', true);
                    $("#hfRoleNewEdit").val("Edit");
                    $("#neweditRoleModal .modal-title").text("Edit Role");
                }
                $(".mandatory-message").text("");
                $("#neweditRoleModal").modal('show');

                return false;
            }

            function openRoleDeleteConfirmModal(msg) {
                $("#roleDeleteMsg").text(msg);
                $("#roleDeleteConfirmModal").modal('show');
            }
            /*----------------------------------------------- End Role Details-----------------------------------------------*/
        });
    </script>
</asp:Content>
