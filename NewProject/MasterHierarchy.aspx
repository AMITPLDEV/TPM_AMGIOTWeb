<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MasterHierarchy.aspx.cs" Inherits="NewProject.MasterHierarchy" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .gridContainer {
            margin-top: 10px;
        }
    </style>
    <div class="themetoggle">
        <div id="divPlantContainer" runat="server" visible="true">
            <div>
                <div>

                    <table class="filterTbl filter-field-table">
                        <tr>
                            <td>&nbsp;&nbsp;
                                                 <asp:Button runat="server" ID="Button8" ClientIDMode="Static" Text="Save" CssClass="Btns" />
                                &nbsp;&nbsp;
                                                 <asp:Button runat="server" ID="Button9" ClientIDMode="Static" Text="New" CssClass="Btns" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="gridContainer">
                    <asp:GridView runat="server" ID="gvPlantData" AutoGenerateColumns="false" OnRowDataBound="gvPlantData_RowDataBound" OnSelectedIndexChanged="gvPlantData_SelectedIndexChanged" ClientIDMode="Static" EmptyDataText="No Data Found" CssClass="P1Table">
                        <Columns>
                            <asp:BoundField DataField="Plant" HeaderText="Plant" />
                            <asp:BoundField DataField="PlantDesc" HeaderText="Plant Desc" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
        <div id="divPlantHierarchyContainer" runat="server">
            <div style="float: left; margin-top: 5px">
                <div class="navbar-collapse collapse" style="height: 42px !important;">
                    <ul class="nav navbar-nav nextPrevious submenus-style ">
                        <%-- <li><a runat="server" class="submenuData" id="liPlantMenu" clientidmode="static" data-toggle="tab" href="#plantMenu">Plant</a>
                                    <i></i>
                                </li>--%>
                        <li><a runat="server" class="submenuData" id="liShopMenu" clientidmode="static" data-toggle="tab" href="#shopMenu">Shop</a>
                            <i></i>
                        </li>
                        <li><a runat="server" class="submenuData" id="liCellMenu" clientidmode="static" data-toggle="tab" href="#cellMenu">Cell</a>
                            <i></i>
                        </li>
                        <li><a runat="server" class="submenuData" id="liGroupMenu" clientidmode="static" data-toggle="tab" href="#groupMenu">Group</a>
                            <i></i>
                        </li>
                    </ul>
                </div>
                <div style="display: none">
                    <asp:Button runat="server" ID="btnPlant" />
                    <asp:Button runat="server" ID="btnShop" />
                    <asp:Button runat="server" ID="btnCell" />
                    <asp:Button runat="server" ID="btnGroup" />
                </div>
            </div>
            <div>   
                <asp:LinkButton runat="server" ID="backBtn" OnClick="backBtn_Click" CssClass="glyphicon glyphicon-share-alt" Style="transform: rotate(180deg); font-size: 20px; margin-top: 7px;"></asp:LinkButton>
            </div>
            <div class="tab-content themetoggle" id="hierarchyContainer" style="overflow: auto; width: 100%; margin: -10px auto;">
                <%--   <div id="plantMenu" class="tab-pane fade">
                    <div class="gridContainer">
                        <table class="P1Table">
                            <tr>
                                <th>Plant</th>
                                <th>Plant Desc</th>
                            </tr>
                            <tr>
                                <td>Plant-01
                                </td>
                                <td>Plant-01 Desc
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>--%>
                <div id="shopMenu" class="tab-pane fade">
                    <div>
                        <%-- <fieldset class="field-set">
                                    <legend>&nbsp;<b>Filter By</b></legend>
                                    <table class="filterTbl filter-field-table">
                                        <tr>
                                         <td>Plant&nbsp;</td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="ddlPlantShopLvl" CssClass="form-control" AutoPostBack="true"></asp:DropDownList>
                                            </td>
                                            <td>
                                               &nbsp;&nbsp;
                                                 <asp:Button runat="server" ID="btnViewShopLvl" ClientIDMode="Static" Text="View" CssClass="Btns" />
                                                &nbsp;&nbsp;
                                                
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>--%>
                        <table>
                            <tr>
                                <td>
                                    <asp:Button runat="server" ID="btnSaveShopLvl" ClientIDMode="Static" Text="Save" CssClass="Btns" />
                                    &nbsp;&nbsp;
                                                 <asp:Button runat="server" ID="btnNewShopLvl" ClientIDMode="Static" Text="New" CssClass="Btns" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="gridContainer">
                        <table class="P1Table">
                            <tr>
                                <th>Shop</th>
                                <th>Shop Desc</th>
                            </tr>
                            <tr>
                                <td>Shop-01
                                </td>
                                <td>Shop-01 Desc
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div id="cellMenu" class="tab-pane fade">
                    <div>
                        <%-- <fieldset class="field-set">
                            <legend>&nbsp;<b>Filter By</b></legend>--%>
                        <table class="filterTbl filter-field-table">
                            <tr>
                                <%--    <td>Plant&nbsp;</td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="DropDownList1" CssClass="form-control" AutoPostBack="true"></asp:DropDownList>
                                            </td>--%>
                                <td>&nbsp;&nbsp;
                                                 <asp:Button runat="server" ID="Button1" ClientIDMode="Static" Text="View" CssClass="Btns" />&nbsp;&nbsp;
                                                 <asp:Button runat="server" ID="Button2" ClientIDMode="Static" Text="Save" CssClass="Btns" />
                                    &nbsp;&nbsp;
                                                 <asp:Button runat="server" ID="Button3" ClientIDMode="Static" Text="New" CssClass="Btns" />
                                </td>
                            </tr>
                        </table>
                        <%-- </fieldset>--%>
                    </div>
                    <div class="gridContainer">
                        <table class="P1Table">
                            <tr>
                                <th>Cell</th>
                                <th>Cell Desc</th>
                            </tr>
                            <tr>
                                <td>Cell-01
                                </td>
                                <td>Cell-01 Desc
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div id="groupMenu" class="tab-pane fade">
                    <div>
                        <fieldset class="field-set">
                            <legend>&nbsp;<b>Filter By</b></legend>
                            <table class="filterTbl filter-field-table">
                                <tr>
                                    <%-- <td>Plant&nbsp;</td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="DropDownList2" CssClass="form-control" AutoPostBack="true"></asp:DropDownList>
                                            </td>--%>
                                    <td>
                                        <asp:Label runat="server" ID="lblSCGroupLvl"></asp:Label>
                                        &nbsp;</td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="DropDownList3" CssClass="form-control" AutoPostBack="true"></asp:DropDownList>
                                    </td>
                                    <td>&nbsp;&nbsp;
                                                 <asp:Button runat="server" ID="Button4" ClientIDMode="Static" Text="View" CssClass="Btns" />&nbsp;&nbsp;
                                                 <asp:Button runat="server" ID="Button5" ClientIDMode="Static" Text="Save" CssClass="Btns" />
                                        &nbsp;&nbsp;
                                                 <asp:Button runat="server" ID="Button6" ClientIDMode="Static" Text="New" CssClass="Btns" />
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </div>
                    <div class="gridContainer">
                        <table class="P1Table">
                            <tr>
                                <th>Group</th>
                                <th>Group Desc</th>
                            </tr>
                            <tr>
                                <td>Group-01
                                </td>
                                <td>Group-01 Desc
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        var submenu = "";
        $(document).ready(function () {
            if (localStorage.getItem("selectedPPSubMenu")) {
                debugger;
                submenu = localStorage.getItem("selectedPPSubMenu");
            }
            $(submenu).addClass("in active");
            $("a[href$='" + submenu + "']").removeClass("selected-menu-style").addClass("selected-Submenu");
            $("a[href$='" + submenu + "']").closest('li').find('i').addClass("arrow up selected-Submenu-ArrowUp");

        });
        $(".submenuData").click(function () {
            debugger;
            $('[id*=hdnScrollPos]').val(0);
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
            $("#activeMenu").val(submenu);
            $(submenu).addClass("in active");
            if (submenu == "#plantMenu") {
                __doPostBack('<%= btnPlant.UniqueID%>', '');
            }
            else if (submenu == "#shopMenu") {
                __doPostBack('<%= btnShop.UniqueID%>', '');
            }
            else if (submenu == "#cellMenu") {
                __doPostBack('<%= btnCell.UniqueID%>', '');
            }
            else if (submenu == "#groupMenu") {
                __doPostBack('<%= btnGroup.UniqueID%>', '');
            }
            else {
                __doPostBack('<%= btnPlant.UniqueID%>', '');
            }
            localStorage.setItem("selectedPPSubMenu", submenu);
            // $("#menu0").removeClass("in active");
        });
        function setActiveSubmenuValue(id) {
            debugger;
            if (id != "") {
                localStorage.setItem("selectedPPSubMenu", "#" + id);
            }
        }
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
            $(document).ready(function () {
                if (localStorage.getItem("selectedPPSubMenu")) {
                    debugger;
                    submenu = localStorage.getItem("selectedPPSubMenu");
                }
                $(submenu).addClass("in active");
                $("a[href$='" + submenu + "']").removeClass("selected-menu-style").addClass("selected-Submenu");
                $("a[href$='" + submenu + "']").closest('li').find('i').addClass("arrow up selected-Submenu-ArrowUp");
                $.unblockUI({});
            });
            $(".submenuData").click(function () {
                debugger;
                $('[id*=hdnScrollPos]').val(0);
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
                $("#activeMenu").val(submenu);
                $(submenu).addClass("in active");
                if (submenu == "#plantMenu") {
                    __doPostBack('<%= btnPlant.UniqueID%>', '');
                }
                else if (submenu == "#shopMenu") {
                    __doPostBack('<%= btnShop.UniqueID%>', '');
                }
                else if (submenu == "#cellMenu") {
                    __doPostBack('<%= btnCell.UniqueID%>', '');
                }
                else if (submenu == "#groupMenu") {
                    __doPostBack('<%= btnGroup.UniqueID%>', '');
                }
                else {
                    __doPostBack('<%= btnPlant.UniqueID%>', '');
                }
                localStorage.setItem("selectedPPSubMenu", submenu);
                // $("#menu0").removeClass("in active");
            });
        });
    </script>
</asp:Content>
