

---

# **SalesApp**

## Overview

**SalesApp** is a sample sales and inventory management system designed to show the process of managing products, purchases, and sales for small to medium-sized businesses. This application allows users to keep track of stock levels, manage product details, and handle transactions seamlessly, all in one place.

The project is developed using **ASP.NET** with a **SQL Server** backend, making it a reliable and robust solution for sales and inventory management.

## Features

- **Product Management**:
  - Add, update, and soft-delete products with key attributes like name, quantity, price, and sales price.
  - Implement a soft delete mechanism to prevent accidental loss of data.

- **Inventory Management**:
  - Real-time updates of stock levels upon purchases and sales transactions.
  - Display available stock while excluding deleted items.

- **Sales and Purchase Management**:
  - Track sales and purchase details with an intuitive interface.
  - Generate detailed reports on sales and purchases.

- **User-Friendly Interface**:
  - Responsive design using Bootstrap for a seamless experience on desktop and mobile devices.
  - Simple and intuitive navigation for ease of use.

## Tech Stack

- **Frontend**: ASP.NET, C#, Bootstrap 4.6.2
- **Backend**: SQL Server
- **Language**: C#

## Installation

Follow these steps to set up the SalesApp project on your local machine:

### Prerequisites

- Visual Studio 2019 or later
- .NET Framework 4.8
- SQL Server (2016 or later)
- Git (for cloning the repository)

### Steps

1. **Clone the repository**:
   ```bash
   git clone https://github.com/aginjithgj/SalesApp.git
   ```
2. **Open the Project**:
   - Open `SalesApp.sln` in Visual Studio.

3. **Set Up the Database**:
   - Open SQL Server Management Studio (SSMS).
   - Run the `SalesAppDB.sql` script located in the `Database` folder to create the database and tables.

4. **Update the Connection String**:
   - In `web.config`, update the connection string to match your SQL Server instance:
     ```xml
     <connectionStrings>
       <add name="SalesAppDB"
            connectionString="Data Source=your_server_name;Initial Catalog=SalesAppDB;Integrated Security=True;"
            providerName="System.Data.SqlClient" />
     </connectionStrings>
     ```

5. **Build and Run**:
   - Build the project using Visual Studio (`Ctrl + Shift + B`).
   - Start the application (`F5` or `Ctrl + F5`).

## Usage

1. **Login**: Start the application, and log in using default credentials (admin:admin). You can update these credentials later.
2. **Manage Products**: Navigate to the "Products" section to add or update product details.
3. **Manage Purchases**: Use the "Purchases" page to add purchase details and update stock levels.
4. **Sales Management**: Add sales transactions and review sales reports.

## Soft Delete Mechanism

The project uses a **soft delete** approach, where records are not physically removed from the database. Instead, a `Deleted` column is updated to mark the record as inactive. This ensures data integrity and allows for recovery if needed.

## License

**SalesApp** is licensed under the [MIT License](LICENSE). You are free to use, modify, and distribute this software as per the license conditions.

## Contribution

We welcome contributions to enhance the functionality of SalesApp. To contribute:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/YourFeature`).
3. Commit your changes (`git commit -m 'Add a new feature'`).
4. Push to the branch (`git push origin feature/YourFeature`).
5. Open a Pull Request.

## Issues

If you encounter any issues or bugs, please create an [issue](https://github.com/aginjithgj/SalesApp/issues) on GitHub. Provide a detailed description to help us resolve the problem efficiently.

## Acknowledgements

- **Creator**: Aginjith
- **Copyright**: Aginjith © 2024. All rights reserved.

## Open Source License

This project is open-source and licensed under the **MIT License**, allowing for commercial and non-commercial use, modification, and distribution.

---

Feel free to customize the content, especially the GitHub links, license details, and contact information based on your specific requirements. This README provides a professional and comprehensive overview for potential users and contributors.
