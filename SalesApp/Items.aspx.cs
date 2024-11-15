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
    public partial class Items : System.Web.UI.Page
    {
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["SalesAppConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadItems();
            }
        }

        protected void AddItem_Click(object sender, EventArgs e)
        {
            try
            {
                if (txtItemName.Text.Trim() == "")
                {
                    throw new ArgumentException("Item Name cannot be empty.");
                }
                string itemName = txtItemName.Text.Trim();
                int quantity = int.Parse(txtQuantity.Text.Trim() == "" ? "0" : txtQuantity.Text.Trim());
                decimal price = decimal.Parse(txtPrice.Text.Trim() == "" ? "0" : txtPrice.Text.Trim());
                decimal salesPrice = decimal.Parse(txtSalesPrice.Text.Trim() == "" ? "0" : txtSalesPrice.Text.Trim());

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "INSERT INTO Items (ItemName, Quantity, Price, SalesPrice) VALUES (@ItemName, @Quantity, @Price, @SalesPrice)";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@ItemName", itemName);
                        cmd.Parameters.AddWithValue("@Quantity", quantity);
                        cmd.Parameters.AddWithValue("@Price", price);
                        cmd.Parameters.AddWithValue("@SalesPrice", salesPrice);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();
                    }
                }

                ClearInputs();
                LoadItems();

            }
            catch (Exception ex)
            {

                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Error: {ex.Message}');", true);

            }

        }

        private void LoadItems1()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT ItemName, Quantity, Price, SalesPrice FROM Items";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    GridViewItems.DataSource = dt;
                    GridViewItems.DataBind();
                    conn.Close();
                }
            }
        }

        private void ClearInputs()
        {
            txtItemName.Text = "";
            txtQuantity.Text = "";
            txtPrice.Text = "";
            txtSalesPrice.Text = "";
        }

        //Started adding for delete
        private void LoadItems()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "SELECT Id as ItemID, ItemName, Quantity, Price, SalesPrice FROM Items WHERE Deleted = 0";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        conn.Open();

                        // Using SqlDataAdapter to fill the DataTable
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);

                            // Check if the DataTable has rows before binding
                            if (dt.Rows.Count > 0)
                            {
                                GridViewItems.DataSource = dt;
                                GridViewItems.DataBind();
                            }
                            else
                            {
                                // Handling case when no data is found
                                dt.Rows.Add(dt.NewRow()); // Add an empty row for a better display
                                GridViewItems.DataSource = dt;
                                GridViewItems.DataBind();
                                GridViewItems.Rows[0].Cells.Clear(); // Clear the empty row
                                GridViewItems.Rows[0].Cells.Add(new TableCell());
                                GridViewItems.Rows[0].Cells[0].ColumnSpan = dt.Columns.Count;
                                GridViewItems.Rows[0].Cells[0].Text = "No items found.";
                                GridViewItems.Rows[0].Cells[0].HorizontalAlign = HorizontalAlign.Center;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the exception or display a user-friendly message
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Error: {ex.Message}');", true);
            }
        }


        protected void GridViewItems_RowEditing(object sender, GridViewEditEventArgs e)
        {
            // Set the row in edit mode
            GridViewItems.EditIndex = e.NewEditIndex;
            LoadItems(); // Reload the data
        }

        protected void GridViewItems_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            // Cancel edit mode
            GridViewItems.EditIndex = -1;
            LoadItems(); // Reload the data
        }

        protected void GridViewItems_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                // Retrieve the primary key value
                int itemId = Convert.ToInt32(GridViewItems.DataKeys[e.RowIndex]?.Value);

                // Retrieve the row being edited
                GridViewRow row = GridViewItems.Rows[e.RowIndex];

                // Use FindControl to locate the TextBox in Edit mode
                TextBox txtItemName = (TextBox)row.FindControl("txtItemName");
                TextBox txtQuantity = (TextBox)row.FindControl("txtQuantity");
                TextBox txtPrice = (TextBox)row.FindControl("txtPrice");
                TextBox txtSalesPrice = (TextBox)row.FindControl("txtSalesPrice");

                // Get values from text boxes
                string itemName = txtItemName?.Text;
                int quantity = int.TryParse(txtQuantity?.Text, out var q) ? q : 0;
                decimal price = decimal.TryParse(txtPrice?.Text, out var p) ? p : 0;
                decimal salesPrice = decimal.TryParse(txtSalesPrice?.Text, out var sp) ? sp : 0;

                // Update the item in the database
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "UPDATE Items SET ItemName = @ItemName, Quantity = @Quantity, Price = @Price, SalesPrice = @SalesPrice WHERE Id = @ItemID";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@ItemID", itemId);
                        cmd.Parameters.AddWithValue("@ItemName", itemName);
                        cmd.Parameters.AddWithValue("@Quantity", quantity);
                        cmd.Parameters.AddWithValue("@Price", price);
                        cmd.Parameters.AddWithValue("@SalesPrice", salesPrice);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                // Exit edit mode and rebind the GridView
                GridViewItems.EditIndex = -1;
                LoadItems();
            }
            catch (ArgumentOutOfRangeException ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Error: {ex.Message}');", true);

            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Error: {ex.Message}');", true);

            }
        }

        protected void GridViewItems_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int itemId = Convert.ToInt32(GridViewItems.DataKeys[e.RowIndex]?.Value);
            string statusMessage;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("SoftDeleteItem", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        // Add parameters
                        cmd.Parameters.AddWithValue("@ItemID", itemId);
                        SqlParameter outputMessageParam = new SqlParameter("@StatusMessage", SqlDbType.NVarChar, 255)
                        {
                            Direction = ParameterDirection.Output
                        };
                        cmd.Parameters.Add(outputMessageParam);

                        conn.Open();
                        cmd.ExecuteNonQuery();

                        // Retrieve the status message
                        statusMessage = outputMessageParam.Value.ToString();
                    }
                }

                // Display the result message

                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('{statusMessage}');", true);

                // Refresh the item list
                LoadItems();
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Error: {ex.Message}');", true);

            }
        }




    }
}
