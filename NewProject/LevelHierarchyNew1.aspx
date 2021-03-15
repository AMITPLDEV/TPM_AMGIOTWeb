<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LevelHierarchyNew.aspx.cs" Inherits="NewProject.LevelHierarchyNew" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .divs {
            width: 225px;
            height: 71px;
            border: 1px solid #1f1d1d;
            box-shadow: 2px 2px 5px 2px #1b1b1bed;
            margin: auto;
            text-align: center;
            padding-top: 20px;
            color: #dadada;
            font-weight: bold;
        }

        .line-style {
            stroke: white;
        }

        .check-box > input {
            width: 23px;
            height: 17px;
            vertical-align: sub;
        }

        .level-heirarchy-lines {
            width: 2px;
            height: 80px;
            background-color: #616161;
            position: absolute;
            border-bottom-color: #44fff4;
            border-bottom-style: groove;
            border-bottom-width: 11.1px;
        }

        #groupcompanyline {
            top: 7.2%;
            left: 50%;
            height: 81px;
        }

        #companymachineline {
            top: 22.5%;
            left: 50%;
            height: 81px;
        }

        #companydivisionline {
            top: 3%;
            left: 61%;
            height: 465px;
            transform: rotate( 120deg );
            -webkit-transform: rotate( -80deg );
            -ms-transform: rotate(120deg);
        }

        #companyplantline {
            top: 3%;
            left: 39%;
            height: 465px;
            transform: rotate( 120deg );
            -webkit-transform: rotate( 80deg );
            -ms-transform: rotate(120deg);
        }

        #plantcellline {
            top: 27%;
            left: 32.2%;
            height: 297px;
            transform: rotate( 120deg );
            -webkit-transform: rotate( -74deg );
            -ms-transform: rotate(120deg);
        }

        #plantshopline {
            top: 26%;
            left: 18%;
            height: 318px;
            transform: rotate( 120deg );
            -webkit-transform: rotate( 75deg );
            -ms-transform: rotate(120deg);
        }

        #shop_shopcellline {
            top: 53.5%;
            left: 10%;
            height: 81px;
        }

        #shopcell_shopgroupline {
            top: 69%;
            left: 10%;
            height: 81px;
        }

        #shopgroup_shopcellgroupline {
            top: 84.5%;
            left: 10%;
            height: 81px;
        }

        #cell_cellgroupline {
            top: 54%;
            left: 10%;
        }

        #shopcell_shopgroupline {
            top: 69%;
            left: 10%;
        }

        #line6 {
            top: 63%;
            left: 33%;
            height: 275px;
            transform: rotate( 120deg );
            -webkit-transform: rotate( 73deg );
            -ms-transform: rotate(120deg);
        }

        #line7 {
            top: 63%;
            left: 21%;
            height: 277px;
            transform: rotate( 120deg );
            -webkit-transform: rotate( -73deg );
            -ms-transform: rotate(120deg);
        }

        .navigation-icon {
            color: #08ffff;
            padding-left: 22px;
        }

            .navigation-icon:hover {
                color: #08ffff;
            }

        #levelContainer .iconvisible {
            visibility: visible;
        }

        #levelContainer .iconhidden {
            visibility: hidden;
        }
        .glyphicon-chevron-right, .glyphicon-chevron-down,.glyphicon-chevron-right:hover, .glyphicon-chevron-down:hover{
            color: red;
        }
        #tblCompany tr td{
            padding-top: 9px;
        }
        #lnkPlant {
            color: #00b8ff;
            text-decoration: revert;
        }
        .light-mode #lnkPlant {
            color: #0719f3 !important;
        }
    </style>
    <div class="themetoggle">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>

                <asp:HiddenField runat="server" ID="hfLevelType" ClientIDMode="Static" />
                <div class="heirarchy-container" style="margin-top: 10px">
                    <asp:Button runat="server" ID="btnSave" ClientIDMode="Static" Text="Save" CssClass="Btns" OnClick="btnSave_Click" />
                    <div style="margin-top: 15px; " >
                        <div id="levelContainer" style="display: inline-block; vertical-align: top;width: 15%;    background-color: #164951;height: 80vh;padding: 10px; border-radius: 10px;overflow: auto;    box-shadow: 2px 2px 4px 2px #031f23;">
                            <asp:ListView runat="server" ID="lvData">
                                <LayoutTemplate>
                                    <table>
                                        <tr runat="server" id="itemplaceholder"></tr>
                                    </table>
                                </LayoutTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td style="padding-top: 20px">
                                            <span runat="server" class='<%# Eval("IconVisibility") %>'>
                                                <asp:LinkButton runat="server" ID="lnkGroup" CssClass="glyphicon glyphicon-chevron-right drilldown-icon" OnClick="lnkGroup_Click"></asp:LinkButton>
                                            </span>
                                            &nbsp;&nbsp;
                                            <asp:Label runat="server" ID="lblGroup" Text='<%# Eval("Group") %>'></asp:Label>
                                            <div>
                                                <asp:ListView runat="server" ID="lvCompany" DataSource='<%# Eval("CompanyList") %>' Visible="false">
                                                    <LayoutTemplate>
                                                        <table runat="server" id="tblCompany" clientidmode="static">
                                                            <tr runat="server" id="itemplaceholder"></tr>
                                                        </table>
                                                    </LayoutTemplate>
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td>&nbsp;&nbsp; &nbsp;  <span runat="server" class='<%# Eval("IconVisibility") %>'>
                                                                <asp:LinkButton runat="server" ID="lnkCompany" CssClass="glyphicon glyphicon-chevron-right drilldown-icon" OnClick="lnkCompany_Click"></asp:LinkButton></span>
                                                                &nbsp;&nbsp;<asp:Label runat="server" ID="lblCompany" Text='<%# Eval("Company") %>'></asp:Label>
                                                                <div>
                                                                    <asp:ListView runat="server" ID="lvPlant" DataSource='<%# Eval("PlantList") %>' Visible="false">
                                                                        <LayoutTemplate>
                                                                            <table id="tblPlant" runat="server">
                                                                                <tr runat="server" id="itemplaceholder"></tr>
                                                                            </table>
                                                                        </LayoutTemplate>
                                                                        <ItemTemplate>
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:HiddenField runat="server" ID="hdnGroup" Value='<%# Eval("Group") %>' />
                                                                                    <asp:HiddenField runat="server" ID="hdnCompany" Value='<%# Eval("Company") %>' />
                                                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                    <asp:LinkButton runat="server" ID="lnkPlant" ClientIDMode="Static" Text='<%# Eval("Plant") %>' OnClick="lnkPlant_Click"></asp:LinkButton>
                                                                                </td>
                                                                            </tr>
                                                                        </ItemTemplate>
                                                                    </asp:ListView>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:ListView>
                                            </div>

                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:ListView>
                        </div>

                        <div style="position: relative; display: inline-block; width: 75%; padding-left: 32px">
                            <asp:HiddenField runat="server" ID="hfEffectiveFromDate" ClientIDMode="Static" />
                            <asp:HiddenField runat="server" ID="hfEffectiveToDate" ClientIDMode="Static" />


                            <div style="width: 100%; margin: auto;">
                                <div style="display: inline-block; padding: 7px; border: 4px solid #ff4700; background-color: #fdfbf2">
                                    <div class="divs" style="background-color: blueviolet; margin-bottom: 80px">
                                        <asp:CheckBox runat="server" ID="cbShop" CssClass="check-box plant-level-heirarchy" ClientIDMode="Static" />
                                        Shop
                                    <asp:LinkButton runat="server" ID="lbShop" CssClass="glyphicon glyphicon-share-alt navigation-icon" OnClick="lbShop_Click" OnClientClick="return setLevelType('Shop')" ToolTip="Navigate To Plant Hierarchy"></asp:LinkButton>
                                    </div>
                                    <div style="width: 100%; display: inline-flex">
                                        <div class="divs" style="display: inline-block; background-color: darkgreen">
                                            <asp:CheckBox runat="server" ID="cbShopCell" CssClass="check-box shop-checkbox shop-level-heirarchy" ClientIDMode="Static" />
                                            Shop Cell
                                          <asp:LinkButton runat="server" ID="lbShopCell" CssClass="glyphicon glyphicon-share-alt navigation-icon" OnClick="lbShop_Click" OnClientClick="return setLevelType('Shop')" ToolTip="Navigate To Plant Hierarchy"></asp:LinkButton>
                                        </div>
                                        <div class="divs" style="display: inline-block; background-color: darkgreen; margin-left: 6%">
                                            <asp:CheckBox runat="server" ID="cbShopGroup" CssClass="check-box shop-checkbox shop-level-heirarchy" ClientIDMode="Static" />
                                            Shop Group
                                          <asp:LinkButton runat="server" ID="lbShopGroup" CssClass="glyphicon glyphicon-share-alt navigation-icon" OnClick="lbShop_Click" OnClientClick="return setLevelType('Shop')" ToolTip="Navigate To Plant Hierarchy"></asp:LinkButton>
                                        </div>
                                    </div>
                                    <div style="width: 100%; margin-top: 80px">
                                        <div class="divs" style="display: inline-block; background-color: darkblue">
                                            <asp:CheckBox runat="server" ID="cbShopCellGroup" CssClass="check-box shop-checkbox" ClientIDMode="Static" />
                                            Shop Cell Group
                                          <asp:LinkButton runat="server" ID="lbShopCellGroup" CssClass="glyphicon glyphicon-share-alt navigation-icon" OnClick="lbShop_Click" OnClientClick="return setLevelType('Shop')" ToolTip="Navigate To Plant Hierarchy"></asp:LinkButton>
                                        </div>

                                    </div>
                                </div>
                                <div style="display: inline-block; vertical-align: top; padding: 7px; margin-left: 4.5%; border: 4px solid #ff4700; background-color: #fdfbf2">

                                    <div class="divs" style="display: inline-block; background-color: blueviolet; margin-bottom: 80px">
                                        <asp:CheckBox runat="server" ID="cbCell" CssClass="check-box plant-level-heirarchy" ClientIDMode="Static" />
                                        Cell
                                     <asp:LinkButton runat="server" ID="lbCell" CssClass="glyphicon glyphicon-share-alt navigation-icon" OnClick="lbShop_Click" OnClientClick="return setLevelType('Cell')" ToolTip="Navigate To Plant Hierarchy"></asp:LinkButton>
                                    </div>
                                    <div style="width: 100%;">
                                        <div class="divs" style="display: inline-block; background-color: darkgreen;">
                                            <asp:CheckBox runat="server" ID="cbCellGroup" CssClass="check-box cell-checkbox" ClientIDMode="Static" />
                                            Cell Group
                                         <asp:LinkButton runat="server" ID="lbCellGroup" CssClass="glyphicon glyphicon-share-alt navigation-icon" OnClick="lbShop_Click" OnClientClick="return setLevelType('Cell')" ToolTip="Navigate To Plant Hierarchy"></asp:LinkButton>
                                        </div>
                                    </div>

                                </div>
                                <div style="display: inline-block; vertical-align: top; margin-left: 4.5%; padding: 5px; border: 4px solid #ff4700; background-color: #fdfbf2">
                                    <div class="divs" style="display: inline-block; background-color: blueviolet">
                                        <asp:CheckBox runat="server" ID="cbPlantGroup" CssClass="check-box" ClientIDMode="Static" />
                                        Group
                                     <asp:LinkButton runat="server" ID="lbGroup" CssClass="glyphicon glyphicon-share-alt navigation-icon" OnClick="lbShop_Click" OnClientClick="return setLevelType('Group')" ToolTip="Navigate To Plant Hierarchy"></asp:LinkButton>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>

            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
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
    <script>
        $(".plant-level-heirarchy").click(function () {
            if ($(this).find('input').prop('checked')) {
                $(".plant-level-heirarchy input").prop('checked', false);
                $(this).find('input').prop('checked', true);
            }
            if ($("#cbCell").prop('checked')) {
                $(".shop-checkbox input").prop('checked', false);
            } else {
                $(".cell-checkbox input").prop('checked', false);
            }
            if ($("#cbShop").prop('checked')) {
                $(".cell-checkbox input").prop('checked', false);
            } else {
                $(".shop-checkbox input").prop('checked', false);
            }
            if ($("#cbPlantGroup").prop('checked')) {
                $(".shop-checkbox input").prop('checked', false);
                $(".cell-checkbox input").prop('checked', false);
            }
        });
        $(".shop-level-heirarchy").click(function () {
            if ($(this).find('input').prop('checked')) {
                $(".shop-level-heirarchy input").prop('checked', false);
                $(this).find('input').prop('checked', true);
            }
        });
        $(".shop-checkbox").click(function () {
            if (!$("#cbShop").prop('checked')) {
                return false;
            }
            if ($("#cbCell").prop('checked')) {
                return false;
            }
            if (!$("#cbShopCell").prop('checked')) {
                $("#cbShopCellGroup").prop('checked', false);
            }
        });
        $(".cell-checkbox").click(function () {
            if (!$("#cbCell").prop('checked')) {
                return false;
            }
            if ($("#cbShop").prop('checked')) {
                return false;
            }
        });
        $("#cbShopCellGroup").click(function () {
            if (!$("#cbShop").prop('checked')) {
                return false;
            }
            if (!$("#cbShopCell").prop('checked')) {
                return false;
            }
            if ($("#cbCell").prop('checked')) {
                return false;
            }
        });
        function setLevelType(type) {
            $("#hfLevelType").val(type);
            return true;
        }

        function openWarningModal(msg) {
            $("#lblWarningMsg").text(msg);
            $("#warningModal").modal('show');
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
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
            $(".plant-level-heirarchy").click(function () {
                if ($(this).find('input').prop('checked')) {
                    $(".plant-level-heirarchy input").prop('checked', false);
                    $(this).find('input').prop('checked', true);
                }
                if ($("#cbCell").prop('checked')) {
                    $(".shop-checkbox input").prop('checked', false);
                }
                if ($("#cbShop").prop('checked')) {
                    $(".cell-checkbox input").prop('checked', false);
                }
                if ($("#cbPlantGroup").prop('checked')) {
                    $(".shop-checkbox input").prop('checked', false);
                    $(".cell-checkbox input").prop('checked', false);
                }
            });
            $(".shop-level-heirarchy").click(function () {
                if ($(this).find('input').prop('checked')) {
                    $(".shop-level-heirarchy input").prop('checked', false);
                    $(this).find('input').prop('checked', true);
                }
            });
            $(".shop-checkbox").click(function () {
                if (!$("#cbShop").prop('checked')) {
                    return false;
                }
                if ($("#cbCell").prop('checked')) {
                    return false;
                }
            });
            $(".cell-checkbox").click(function () {
                if (!$("#cbCell").prop('checked')) {
                    return false;
                }
                if ($("#cbShop").prop('checked')) {
                    return false;
                }
            });
            $("#cbShopCellGroup").click(function () {
                if (!$("#cbShop").prop('checked')) {
                    return false;
                }
                if (!$("#cbShopCell").prop('checked')) {
                    return false;
                }
                if ($("#cbCell").prop('checked')) {
                    return false;
                }
            });
            function setLevelType(type) {
                $("#hfLevelType").val(type);
                return true;
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
        });
    </script>
</asp:Content>
