<%@ Page Title="Sales App - Purchase" Language="C#"  MasterPageFile="~/SalesApp.Master" AutoEventWireup="true" CodeBehind="Purchase.aspx.cs" Inherits="SalesApp.Purchase" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container mt-4">
        <h2>New Purchase</h2>
        <div class="form-group">
            <input type="text" ID="IDsearchItem" class="form-control" placeholder="Search Item by Name" runat="server" />
            <button type="button" class="btn btn-success mt-2" runat="server" onserverclick="SearchItem_Click">Search</button>
            <button type="button" class="btn btn-info mt-2" data-toggle="modal" ID="IDAddItemBtn" runat="server" data-target="#addItemModal">Add New Item</button>
        </div>

        <div class="form-group">
            <asp:DropDownList ID="ddlSearchResults" onclick="checkDropdownEmpty();"  CssClass="form-control" runat="server"></asp:DropDownList> 
            <asp:TextBox ID="txtPurchaseQuantity" CssClass="form-control mt-2" runat="server" placeholder="Quantity"></asp:TextBox>
            <asp:TextBox ID="txtPurchasePrice" CssClass="form-control mt-2" runat="server" placeholder="Price"></asp:TextBox>

            <button type="button" class="btn btn-primary mt-2" runat="server" onserverclick="AddToPurchase_Click">Add to Purchase</button>
        </div>

        <h3  id="TableHead"  runat="server">Items in Current Purchase</h3>
        <asp:GridView ID="GridViewPurchase" CssClass="table table-bordered mt-3" AutoGenerateColumns="False" OnRowDeleting="GridViewPurchase_RowDeleting" runat="server">
            <Columns>
                <asp:BoundField DataField="ItemName" HeaderText="Item Name" />
                <asp:BoundField DataField="Quantity" HeaderText="Quantity" />
                <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:C}" />
                <asp:BoundField DataField="Total" HeaderText="Total" DataFormatString="{0:C}" />

                <asp:CommandField ShowDeleteButton="True" ButtonType="Button" DeleteText="Remove" />
            </Columns>
        </asp:GridView>
        <button type="button" id="IDPurchaseBtn" onclick="checkDropdownEmpty();" class="btn btn-success mt-3" runat="server" onserverclick="CompletePurchase_Click">Complete Purchase</button>

        <!-- Modal for adding a new item -->
        <div class="modal fade" id="addItemModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Add New Item</h5>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                    <asp:TextBox ID="txtNewItemName" CssClass="form-control mt-1" runat="server" placeholder="Item Name"></asp:TextBox>
                    
                         <asp:TextBox ID="txtQuantity" CssClass="form-control mt-1" runat="server" placeholder="Quantity"></asp:TextBox>
                        <asp:TextBox ID="txtNewItemPrice" CssClass="form-control mt-1" runat="server" placeholder="Price"></asp:TextBox>
                         <asp:TextBox ID="txtSalesPrice" CssClass="form-control mt-1" runat="server" placeholder="Sales Price"></asp:TextBox>

                        <button type="button" ID="btnSubmit"  class="btn btn-primary mt-2" runat="server" onserverclick="AddNewItem_Click"  >Add Item</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
   <script type="text/javascript">
       function checkDropdownEmpty() {
           debugger
           const ddlSearchResults = document.getElementById("<%= ddlSearchResults.ClientID %>");
           if (ddlSearchResults && ddlSearchResults.options.length === 0) {
               alert("No items available! Please add from Search.");
               <%= IDsearchItem.ClientID %>.focus();
           }
       }
   </script>


</asp:Content>
