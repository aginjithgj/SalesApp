<%@ Page Title="Sales App - New Sale" Language="C#" MasterPageFile="~/SalesApp.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SalesApp.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   
        <div class="container mt-4">
        <h2>Add a New Sale</h2>
        <div class="form-group">
            <asp:DropDownList ID="ddlItemsInStock" CssClass="form-control" runat="server"></asp:DropDownList>
            <asp:TextBox ID="txtSaleQuantity" CssClass="form-control mt-2" runat="server" placeholder="Quantity"></asp:TextBox>
            <asp:TextBox ID="txtSalePrice" CssClass="form-control mt-2" runat="server" placeholder="Price"></asp:TextBox>

            <button type="button" class="btn btn-primary mt-2" runat="server" onserverclick="AddToSale_Click">Add to Sale</button>
        </div>

        <h3 id="IdTableHead" runat="server">Items in Current Sale</h3>
        <asp:GridView ID="GridViewSales" CssClass="table table-bordered mt-3" AutoGenerateColumns="False" OnRowDeleting="GridViewSales_RowDeleting" runat="server">
            <Columns>
                <asp:BoundField DataField="ItemName" HeaderText="Item Name" />
                <asp:BoundField DataField="Quantity" HeaderText="Quantity" />
                <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:C}" />
                <asp:BoundField DataField="Total" HeaderText="Total" DataFormatString="{0:C}" />
                <asp:CommandField ShowDeleteButton="True" ButtonType="Button" DeleteText="Remove" />

            </Columns>
        </asp:GridView>
        <button type="button" id="IdSalesButton" class="btn btn-success mt-3" runat="server" onserverclick="CompleteSale_Click">Complete Sale</button>
    </div>


   
</asp:Content>
