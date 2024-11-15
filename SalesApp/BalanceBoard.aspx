<%@ Page Title="Sales App - Balance" Language="C#" MasterPageFile="~/SalesApp.Master" AutoEventWireup="true" CodeBehind="BalanceBoard.aspx.cs" Inherits="SalesApp.BalanceBoard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">
        <h3>Total Purchases: <asp:Label ID="lblTotalPurchases" runat="server"></asp:Label></h3>
        <h3>Total Sales: <asp:Label ID="lblTotalSales" runat="server"></asp:Label></h3>
        <h3>Total Profit: <asp:Label ID="lblTotalProfit" runat="server"></asp:Label></h3>
    </div>
</asp:Content>
