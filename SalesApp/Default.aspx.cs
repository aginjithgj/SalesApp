using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SalesApp
{
    public partial class Default : System.Web.UI.Page
    {
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["SalesAppConnection"].ConnectionString;

        protected DataTable SalesTable;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                InistiateSales();
            }
        }

        private void InistiateSales()
        {
            LoadItemsInStock();
            SalesTable = new DataTable();
            SalesTable.Columns.Add("ItemID", typeof(int));
            SalesTable.Columns.Add("ItemName");
            SalesTable.Columns.Add("Quantity", typeof(int));
            SalesTable.Columns.Add("Price", typeof(decimal));
            SalesTable.Columns.Add("Total", typeof(decimal));
            Session["SalesTable"] = SalesTable;

            IdSalesButton.Visible = false;
            IdTableHead.Visible = false;
        }

        private void LoadItemsInStock()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "SELECT i.Id, i.ItemName FROM Items i INNER JOIN Stock s ON i.Id = s.ItemId WHERE s.Quantity > 0";
                    SqlDataAdapter da = new SqlDataAdapter(query, conn);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    ddlItemsInStock.DataSource = dt;
                    ddlItemsInStock.DataTextField = "ItemName";
                    ddlItemsInStock.DataValueField = "Id";
                    ddlItemsInStock.DataBind();
                }
            }
            catch (Exception ex)
            {

                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Error: {ex.Message}');", true);

            }
            
        }

        protected void AddToSale_Click(object sender, EventArgs e)
        {
            try
            {
                DataTable dt = (DataTable)Session["SalesTable"];
                if (ddlItemsInStock.SelectedValue== "")
                {
                    throw new ArgumentException("Please add Stock. Make a Purchase.");
                }
                int itemId = int.Parse(ddlItemsInStock.SelectedValue);
                int quantity = int.Parse(txtSaleQuantity.Text.Trim() == "" ? "0" : txtSaleQuantity.Text.Trim());
                decimal price = int.Parse(txtSalePrice.Text.Trim() == "" ? "0" : txtSalePrice.Text.Trim());

                dt.Rows.Add(itemId, ddlItemsInStock.SelectedItem.Text, quantity, price, price * quantity);
                GridViewSales.DataSource = dt;
                GridViewSales.DataBind();

                IdSalesButton.Visible = true;
                IdTableHead.Visible = true;
            }
            catch (Exception ex)
            {

                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Error: {ex.Message}');", true);

            }

        }

        protected void CompleteSale_Click(object sender, EventArgs e)
        {
            string statusMessage;

            try
            {
                DataTable dt = (DataTable)Session["SalesTable"];
                if (dt == null || dt.Rows.Count == 0)
                {
                    // No items to process
                    return;
                }

                // Create a DataTable matching the SalesDetailsType structure
                DataTable salesDetails = new DataTable();
                salesDetails.Columns.Add("ItemId", typeof(int));
                salesDetails.Columns.Add("Quantity", typeof(int));
                salesDetails.Columns.Add("Price", typeof(decimal));

                // Populate the salesDetails DataTable
                foreach (DataRow row in dt.Rows)
                {
                    int itemId = (int)row["ItemId"];
                    int quantity = (int)row["Quantity"];
                    decimal price = (decimal)row["Price"];

                    salesDetails.Rows.Add(itemId, quantity, price);
                }

                // Execute the stored procedure
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_RecordSale", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@SaleDetails", salesDetails);
                        cmd.Parameters["@SaleDetails"].SqlDbType = SqlDbType.Structured;

                        SqlParameter outputMessageParam = new SqlParameter("@StatusMessage", SqlDbType.NVarChar, 255)
                        {
                            Direction = ParameterDirection.Output
                        };
                        cmd.Parameters.Add(outputMessageParam);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                        // Retrieve the status message
                        statusMessage = outputMessageParam.Value.ToString();

                        conn.Close();
                    }
                }

                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('{statusMessage}');", true);

                // Clear session and GridView after successful sale
                Session["SalesTable"] = null;
                InistiateSales();
                GridViewSales.DataSource = null;
                GridViewSales.DataBind();
            }
            catch (Exception ex)
            {

                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Error: {ex.Message}');", true);

            }

        }

        protected void GridViewSales_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                // Retrieve the DataTable from session
                DataTable dt = (DataTable)Session["SalesTable"];

                // Get the row index of the item to be deleted
                int rowIndex = e.RowIndex;

                // Check if the DataTable is not null
                if (dt != null && dt.Rows.Count > rowIndex)
                {
                    // Remove the row from the DataTable
                    dt.Rows.RemoveAt(rowIndex);

                    // Rebind the updated DataTable to the GridView
                    GridViewSales.DataSource = dt;
                    GridViewSales.DataBind();

                    // Update session data
                    Session["SalesTable"] = dt;

                    // Hide the Purchase button and table head if no items left
                    if (dt.Rows.Count == 0)
                    {
                        IdSalesButton.Visible = false;
                        IdTableHead.Visible = false;
                    }
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Error: {ex.Message}');", true);
            }
        }



    }
}