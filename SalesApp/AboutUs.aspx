<%@ Page Title="About Us" Language="C#" MasterPageFile="~/SalesApp.Master" AutoEventWireup="true" CodeBehind="AboutUs.aspx.cs" Inherits="SalesApp.AboutUs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>About Us - SalesApp</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="container mt-5">
        <div class="card">
            <div class="card-header text-center bg-primary text-white">
                <h2>About Us</h2>
            </div>
            <div class="card-body">
                <h4>Welcome to SalesApp</h4>
                <p>
                    SalesApp is an open-source project aimed at providing a robust and efficient solution for sales and inventory management.
                    This application helps businesses track inventory, manage purchases, and monitor sales transactions seamlessly.
                    Designed for versatility, SalesApp caters to various industries by simplifying sales operations and providing valuable insights.
                </p>

                <h4>Our Mission</h4>
                <p>
                    Our mission is to deliver an accessible, open-source platform that empowers businesses of all sizes to efficiently manage their sales processes.
                    We believe in community-driven development and strive to provide an adaptable and user-friendly experience.
                </p>

                <h4>Key Features</h4>
                <ul>
                    <li>Real-time Inventory Tracking</li>
                    <li>Comprehensive Sales Management</li>
                    <li>Customizable Purchase Order Handling</li>
                    <li>Detailed Reporting and Analytics</li>
                    <li>Intuitive User Interface</li>
                </ul>

                <h4>Open-Source License</h4>
                <p>
                    SalesApp is released under the <strong>MIT License</strong>, a permissive open-source license that allows anyone to use, modify, and distribute the software.
                    We encourage contributions from the community to help enhance the project. You can find the source code on our <a href="https://github.com/your-repo/salesapp" target="_blank">GitHub repository</a>.
                </p>

                <h4>About the Creator</h4>
                <p>
                    SalesApp was developed by <strong>Aginjith G J</strong>. With a focus on creating impactful solutions, Aginjith is dedicated to making SalesApp a valuable tool for businesses worldwide.
                    © 2024 Aginjith G J. All rights reserved.
                </p>

                <h4>Contact Us</h4>
                <p>
                    We value your feedback and are always ready to help. For any queries or contributions, feel free to reach out:
                </p>
                <p>
                    <strong>Email:</strong> support@salesapp.com<br />
                    <strong>GitHub:</strong> <a href="https://github.com/your-repo/salesapp" target="_blank">https://github.com/your-repo/salesapp</a><br />
                    <strong>License:</strong> <a href="https://opensource.org/licenses/MIT" target="_blank">MIT License</a>
                </p>
            </div>
            <div class="card-footer text-center">
                <small>&copy; 2024 Aginjith G J. Released under the MIT License.</small>
            </div>
        </div>
    </div>
</asp:Content>
