using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace SalesApp
{
    public partial class Stock : System.Web.UI.Page
    {
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["SalesAppConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadStockData(string.Empty);
            }
        }


        // Function to load stock data with optional search filter
        private void LoadStockData(string searchQuery)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT i.ItemName, s.Quantity, i.Price, i.SalesPrice " +
                               "FROM Stock s " +
                               "INNER JOIN Items i ON s.ItemId = i.Id " +
                               "WHERE (@SearchQuery = '' OR i.ItemName LIKE '%' + @SearchQuery + '%')" +
                               "ORDER BY i.ItemName";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@SearchQuery", searchQuery);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    GridViewStock.DataSource = dt;
                    GridViewStock.DataBind();
                }
            }
        }

        // Search button click event
        protected void SearchStock_Click(object sender, EventArgs e)
        {
            string searchQuery = txtSearch.Value.Trim();
            LoadStockData(searchQuery);
        }

        // Pagination for GridView
        protected void GridViewStock_PageIndexChanging(object sender, System.Web.UI.WebControls.GridViewPageEventArgs e)
        {
            GridViewStock.PageIndex = e.NewPageIndex;
            LoadStockData(txtSearch.Value.Trim());  // Maintain search filter during pagination
        }
    }
}