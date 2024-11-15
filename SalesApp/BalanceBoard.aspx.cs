using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesApp
{
    public partial class BalanceBoard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["SalesAppConnection"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Purchases", conn);
                conn.Open();
                lblTotalPurchases.Text = cmd.ExecuteScalar().ToString();
                cmd.CommandText = "SELECT COUNT(*) FROM Sales";
                lblTotalSales.Text = cmd.ExecuteScalar().ToString();
                cmd.CommandText = "SELECT (SELECT SUM(Price) FROM SalesDetails) - (SELECT SUM(Price) FROM PurchaseDetails)";
                lblTotalProfit.Text = cmd.ExecuteScalar().ToString();
            }
        }
    }
}