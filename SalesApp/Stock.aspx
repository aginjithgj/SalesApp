<%@ Page Title="" Language="C#" MasterPageFile="~/SalesApp.Master" AutoEventWireup="true" CodeBehind="Stock.aspx.cs" Inherits="SalesApp.Stock" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <div class="container mt-4">
        <h2>Available Stock</h2>
        <div class="form-group">
            <input type="text" id="txtSearch" class="form-control" placeholder="Search by Item Name" runat="server" />
            <button type="button" class="btn btn-primary mt-2" runat="server" onserverclick="SearchStock_Click">Search</button>
        </div>

        <asp:GridView 
            ID="GridViewStock" 
            CssClass="table table-bordered mt-3" 
            AutoGenerateColumns="False" 
            AllowPaging="True" 
            PageSize="10" 
            OnPageIndexChanging="GridViewStock_PageIndexChanging"
            runat="server">
            <Columns>
                <asp:BoundField DataField="ItemName" HeaderText="Item Name" />
                <asp:BoundField DataField="Quantity" HeaderText="Available Quantity" />
                <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:C}" />
                <asp:BoundField DataField="SalesPrice" HeaderText="Sales Price" DataFormatString="{0:C}" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
