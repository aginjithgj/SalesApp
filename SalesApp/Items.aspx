<%@ Page Title="" Language="C#" MasterPageFile="~/SalesApp.Master" AutoEventWireup="true" CodeBehind="Items.aspx.cs" Inherits="SalesApp.Items" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container mt-4">
        <h2>Add New Item</h2>
        <div class="form-group">
            <asp:TextBox ID="txtItemName" CssClass="form-control" runat="server" placeholder="Item Name"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:TextBox ID="txtQuantity" CssClass="form-control" runat="server" placeholder="Quantity"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:TextBox ID="txtPrice" CssClass="form-control" runat="server" placeholder="Price"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:TextBox ID="txtSalesPrice" CssClass="form-control" runat="server" placeholder="Sales Price"></asp:TextBox>
        </div>
        <button type="button" class="btn btn-primary" runat="server" onserverclick="AddItem_Click">Add Item</button>

        <h3 class="mt-4">Items List</h3>
        <asp:Label
            ID="lblErrorMessage"
            runat="server"
            CssClass="text-danger"
            Visible="False"></asp:Label>


        <asp:GridView 
    ID="GridViewItems" 
    CssClass="table table-bordered mt-3" 
    AutoGenerateColumns="False" 
    runat="server" 
    DataKeyNames="ItemID"
    OnRowEditing="GridViewItems_RowEditing"
    OnRowUpdating="GridViewItems_RowUpdating"
    OnRowDeleting="GridViewItems_RowDeleting"
    OnRowCancelingEdit="GridViewItems_RowCancelingEdit">
    
    <Columns>
        <asp:TemplateField HeaderText="Item Name">
            <EditItemTemplate>
                <asp:TextBox ID="txtItemName" runat="server" Text='<%# Bind("ItemName") %>' />
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="lblItemName" runat="server" Text='<%# Eval("ItemName") %>' />
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Quantity">
            <EditItemTemplate>
                <asp:TextBox ID="txtQuantity" runat="server" Text='<%# Bind("Quantity") %>' />
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="lblQuantity" runat="server" Text='<%# Eval("Quantity") %>' />
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Price">
            <EditItemTemplate>
                <asp:TextBox ID="txtPrice" runat="server" Text='<%# Bind("Price") %>' />
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="lblPrice" runat="server" Text='<%# Eval("Price") %>' />
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Sales Price">
            <EditItemTemplate>
                <asp:TextBox ID="txtSalesPrice" runat="server" Text='<%# Bind("SalesPrice") %>' />
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="lblSalesPrice" runat="server" Text='<%# Eval("SalesPrice") %>' />
            </ItemTemplate>
        </asp:TemplateField>

        <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" ButtonType="Button" />

    </Columns>
</asp:GridView>




    </div>
</asp:Content>
