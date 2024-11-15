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
    public partial class Purchase : System.Web.UI.Page
    {
        private readonly string connectionString = ConfigurationManager.ConnectionStrings["SalesAppConnection"].ConnectionString;

        protected DataTable PurchaseTable;
        protected void Page_Load(object sender, EventArgs e)
        {


            if (!IsPostBack)
            {
                InistiatePurchaseTable();
            }
        }

        private void InistiatePurchaseTable()
        {
            PurchaseTable = new DataTable();
            PurchaseTable.Columns.Add("ItemID", typeof(int));
            PurchaseTable.Columns.Add("ItemName");
            PurchaseTable.Columns.Add("Quantity", typeof(int));
            PurchaseTable.Columns.Add("Price", typeof(decimal));
            PurchaseTable.Columns.Add("Total", typeof(decimal));
            Session["PurchaseTable"] = PurchaseTable;
            IDPurchaseBtn.Visible = false;
            TableHead.Visible = false;
        }

        protected void SearchItem_Click(object sender, EventArgs e)
        {
            string searchQuery = searchItem.Value.Trim();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT Id, ItemName FROM Items WHERE Deleted = 0 AND ItemName LIKE @Search";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Search", "%" + searchQuery + "%");
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (!reader.HasRows & searchQuery == "")
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Please add Items in the system');", true);

                    }
                    else if (!reader.HasRows)
                    {
                        ClientScript.RegisterStartupScript(GetType(), "alert", $"alert('No similar items found.');", true);
                    }

                    ddlSearchResults.Items.Clear();
                    while (reader.Read())
                    {
                        ddlSearchResults.Items.Add(new ListItem(reader["ItemName"].ToString(), reader["Id"].ToString()));
                    }
                    conn.Close();
                }
            }
        }




        protected void AddToPurchase_Click(object sender, EventArgs e)
        {
            try
            {

                DataTable dt = (DataTable)Session["PurchaseTable"];
                if (ddlSearchResults.SelectedValue=="")
                {
                    throw new ArgumentException("Pleas search Item name.");

                }
                int itemId = int.Parse(ddlSearchResults.SelectedValue);
                int quantity = int.Parse(txtPurchaseQuantity.Text.Trim() == "" ? "0" : txtPurchaseQuantity.Text.Trim());
                decimal price = int.Parse(txtPurchasePrice.Text.Trim() == "" ? "0" : txtPurchasePrice.Text.Trim()); // Fetch the item price from the database in a real scenario

                if (dt == null)
                {
                    return;
                }
                dt.Rows.Add(ddlSearchResults.SelectedItem.Value, ddlSearchResults.SelectedItem.Text, quantity, price, price * quantity);
                GridViewPurchase.DataSource = dt;
                GridViewPurchase.DataBind();
                IDPurchaseBtn.Visible = true;
                TableHead.Visible = true;

            }
            catch (Exception ex)
            {

                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Error: {ex.Message}');", true);

            }



        }


        protected void CompletePurchase_Click(object sender, EventArgs e)
        {
            string statusMessage;

            DataTable purchaseTable = (DataTable)Session["PurchaseTable"];
            if (purchaseTable == null || purchaseTable.Rows.Count == 0)
            {
                // No items to purchase
                return;
            }

            // Create a DataTable matching the PurchaseDetailsType structure
            DataTable purchaseDetails = new DataTable();
            purchaseDetails.Columns.Add("ItemId", typeof(int));
            purchaseDetails.Columns.Add("Quantity", typeof(int));
            purchaseDetails.Columns.Add("Price", typeof(decimal));

            // Fill the DataTable with data
            foreach (DataRow row in purchaseTable.Rows)
            {
                //int itemId = int.Parse(ddlSearchResults.SelectedValue);
                int itemId = (int)row["ItemId"];
                int quantity = (int)row["Quantity"];
                decimal price = (decimal)row["Price"];

                purchaseDetails.Rows.Add(itemId, quantity, price);
            }

            // Call the stored procedure
            using (SqlConnection conn = new SqlConnection(connectionString))
            {

                using (SqlCommand cmd = new SqlCommand("sp_RecordPurchase", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@PurchaseDate", DateTime.Now);
                    SqlParameter detailsParam = cmd.Parameters.AddWithValue("@PurchaseDetails", purchaseDetails);
                    detailsParam.SqlDbType = SqlDbType.Structured;

                    SqlParameter outputMessageParam = new SqlParameter("@StatusMessage", SqlDbType.NVarChar, 255)
                    {
                        Direction = ParameterDirection.Output
                    };
                    cmd.Parameters.Add(outputMessageParam);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    statusMessage = outputMessageParam.Value.ToString();

                    conn.Close();
                }
            }

            ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('{statusMessage}');", true);

            // Clear the session and GridView
            Session["PurchaseTable"] = null;
            InistiatePurchaseTable();
            GridViewPurchase.DataSource = null;
            GridViewPurchase.DataBind();
        }

        protected void AddNewItem_Click(object sender, EventArgs e)
        {
            try
            {
                string itemName = txtNewItemName.Text.Trim();
                if (string.IsNullOrEmpty(itemName))
                {
                    txtNewItemName.Text = "";
                    throw new ArgumentException("Item Name cannot be empty.");
                }
                decimal price = decimal.Parse(txtNewItemPrice.Text.Trim() == "" ? "0" : txtNewItemPrice.Text.Trim());
                int quantity = int.Parse(txtQuantity.Text.Trim() == "" ? "0" : txtQuantity.Text.Trim());
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

                ClearNewItemDetails();

            }
            catch (Exception ex)
            {

                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Error: {ex.Message}');", true);

            }
        }

        private void ClearNewItemDetails()
        {
            txtNewItemName.Text = "";
            txtQuantity.Text = "";
            txtNewItemPrice.Text = "";
            txtSalesPrice.Text = "";
        }

        protected void GridViewPurchase_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                // Retrieve the DataTable from session
                DataTable dt = (DataTable)Session["PurchaseTable"];

                // Get the row index of the item to be deleted
                int rowIndex = e.RowIndex;

                // Check if the DataTable is not null
                if (dt != null && dt.Rows.Count > rowIndex)
                {
                    // Remove the row from the DataTable
                    dt.Rows.RemoveAt(rowIndex);

                    // Rebind the updated DataTable to the GridView
                    GridViewPurchase.DataSource = dt;
                    GridViewPurchase.DataBind();

                    // Update session data
                    Session["PurchaseTable"] = dt;

                    // Hide the Purchase button and table head if no items left
                    if (dt.Rows.Count == 0)
                    {
                        IDPurchaseBtn.Visible = false;
                        TableHead.Visible = false;
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