USE [master]
GO
/****** Object:  Database [SalesAppDB]    Script Date: 15-11-2024 20:55:12 ******/
CREATE DATABASE [SalesAppDB]
 
ALTER DATABASE [SalesAppDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SalesAppDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SalesAppDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SalesAppDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SalesAppDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SalesAppDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SalesAppDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [SalesAppDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SalesAppDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SalesAppDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SalesAppDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SalesAppDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SalesAppDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SalesAppDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SalesAppDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SalesAppDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SalesAppDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SalesAppDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SalesAppDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SalesAppDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SalesAppDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SalesAppDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SalesAppDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SalesAppDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SalesAppDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SalesAppDB] SET  MULTI_USER 
GO
ALTER DATABASE [SalesAppDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SalesAppDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SalesAppDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SalesAppDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SalesAppDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SalesAppDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [SalesAppDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [SalesAppDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [SalesAppDB]
GO
/****** Object:  UserDefinedTableType [dbo].[PurchaseDetailsType]    Script Date: 15-11-2024 20:55:13 ******/
CREATE TYPE [dbo].[PurchaseDetailsType] AS TABLE(
	[ItemId] [int] NULL,
	[Quantity] [int] NULL,
	[Price] [decimal](18, 2) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[SalesDetailsType]    Script Date: 15-11-2024 20:55:13 ******/
CREATE TYPE [dbo].[SalesDetailsType] AS TABLE(
	[ItemId] [int] NULL,
	[Quantity] [int] NULL,
	[Price] [decimal](18, 2) NULL
)
GO
/****** Object:  Table [dbo].[Items]    Script Date: 15-11-2024 20:55:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Items](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ItemName] [nvarchar](100) NOT NULL,
	[Quantity] [int] NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[SalesPrice] [decimal](18, 2) NOT NULL,
	[Deleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PurchaseDetails]    Script Date: 15-11-2024 20:55:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurchaseDetails](
	[PurchaseDetailId] [int] IDENTITY(1,1) NOT NULL,
	[PurchaseId] [int] NULL,
	[ItemId] [int] NULL,
	[Quantity] [int] NULL,
	[Price] [decimal](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[PurchaseDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Purchases]    Script Date: 15-11-2024 20:55:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Purchases](
	[PurchaseId] [int] IDENTITY(1,1) NOT NULL,
	[PurchaseDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[PurchaseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sales]    Script Date: 15-11-2024 20:55:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sales](
	[SaleId] [int] IDENTITY(1,1) NOT NULL,
	[SaleDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[SaleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SalesDetails]    Script Date: 15-11-2024 20:55:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalesDetails](
	[SaleDetailId] [int] IDENTITY(1,1) NOT NULL,
	[SaleId] [int] NULL,
	[ItemId] [int] NULL,
	[Quantity] [int] NULL,
	[Price] [decimal](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[SaleDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Stock]    Script Date: 15-11-2024 20:55:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stock](
	[ItemId] [int] NOT NULL,
	[Quantity] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Items] ADD  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[Purchases] ADD  DEFAULT (getdate()) FOR [PurchaseDate]
GO
ALTER TABLE [dbo].[Sales] ADD  DEFAULT (getdate()) FOR [SaleDate]
GO
ALTER TABLE [dbo].[PurchaseDetails]  WITH CHECK ADD FOREIGN KEY([ItemId])
REFERENCES [dbo].[Items] ([Id])
GO
ALTER TABLE [dbo].[PurchaseDetails]  WITH CHECK ADD FOREIGN KEY([PurchaseId])
REFERENCES [dbo].[Purchases] ([PurchaseId])
GO
ALTER TABLE [dbo].[SalesDetails]  WITH CHECK ADD FOREIGN KEY([ItemId])
REFERENCES [dbo].[Items] ([Id])
GO
ALTER TABLE [dbo].[SalesDetails]  WITH CHECK ADD FOREIGN KEY([SaleId])
REFERENCES [dbo].[Sales] ([SaleId])
GO
ALTER TABLE [dbo].[Stock]  WITH CHECK ADD FOREIGN KEY([ItemId])
REFERENCES [dbo].[Items] ([Id])
GO
/****** Object:  StoredProcedure [dbo].[SoftDeleteItem]    Script Date: 15-11-2024 20:55:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SoftDeleteItem]
    @ItemID INT,
    @StatusMessage NVARCHAR(255) OUTPUT
AS
BEGIN
    -- Update the 'Deleted' column to 1 for the specified ItemID
    UPDATE Items
    SET Deleted = 1
    WHERE Id = @ItemID;

    -- Check if the update was successful
    IF @@ROWCOUNT > 0
    BEGIN
        SET @StatusMessage = 'Item marked as deleted successfully.';
    END
    ELSE
    BEGIN
        SET @StatusMessage = 'Item not found or could not be deleted.';
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_RecordPurchase]    Script Date: 15-11-2024 20:55:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_RecordPurchase]
    @PurchaseDate DATETIME,
    @PurchaseDetails dbo.PurchaseDetailsType READONLY,
    @StatusMessage NVARCHAR(255) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @PurchaseId INT;

    -- Insert into Purchases table
    INSERT INTO Purchases (PurchaseDate)
    VALUES (@PurchaseDate);
    SET @PurchaseId = SCOPE_IDENTITY();

    -- Insert into PurchaseDetails and update Stock
    INSERT INTO PurchaseDetails (PurchaseId, ItemId, Quantity, Price)
    SELECT @PurchaseId, ItemId, Quantity, Price
    FROM @PurchaseDetails;

	-- Step 1: Insert missing items into the Stock table with quantity 0
		INSERT INTO Stock (ItemId, Quantity)
        SELECT DISTINCT  pd.ItemId, 0
        FROM @PurchaseDetails pd
        WHERE NOT EXISTS (
            SELECT 1
            FROM Stock s 
            WHERE s.ItemId = pd.ItemId
        );

    -- Update stock table
		WITH PurchaseQuantities AS (
			SELECT pd.ItemId, SUM(pd.Quantity) AS TotalPurchasedQuantity
			FROM @PurchaseDetails pd
			GROUP BY pd.ItemId
		)
		-- Update stock table
		UPDATE s
		SET s.Quantity = s.Quantity + pq.TotalPurchasedQuantity
		FROM Stock s
		INNER JOIN PurchaseQuantities pq ON s.ItemId = pq.ItemId;

		       -- Check if the update was successful
    IF @@ROWCOUNT > 0
    BEGIN
        SET @StatusMessage = 'Purchase was successfull.';
    END
    ELSE
    BEGIN
        SET @StatusMessage = 'Purchase was not sucessfull.';
    END

    RETURN @PurchaseId;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_RecordSale]    Script Date: 15-11-2024 20:55:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_RecordSale]
    @SaleDetails dbo.SalesDetailsType READONLY,
    @StatusMessage NVARCHAR(255) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @SaleId INT;

    -- Insert into Sales table
    INSERT INTO Sales (SaleDate) VALUES (GETDATE());
    SET @SaleId = SCOPE_IDENTITY();

    -- Insert into SalesDetails table
    INSERT INTO SalesDetails (SaleId, ItemId, Quantity, Price)
    SELECT @SaleId, ItemId, Quantity, Price
    FROM @SaleDetails;

    -- Update stock table by reducing the quantity
	WITH SaleQuantities AS (
    SELECT sd.ItemId, SUM(sd.Quantity) AS TotalSoldQuantity
    FROM @SaleDetails sd
    GROUP BY sd.ItemId
	)
	UPDATE s
	SET s.Quantity = s.Quantity - sq.TotalSoldQuantity
	FROM Stock s
	INNER JOIN SaleQuantities sq ON s.ItemId = sq.ItemId;


       -- Check if the update was successful
    IF @@ROWCOUNT > 0
    BEGIN
        SET @StatusMessage = 'Sales was successfull.';
    END
    ELSE
    BEGIN
        SET @StatusMessage = 'Sales was not sucessfull.';
    END
END;
GO
USE [master]
GO
ALTER DATABASE [SalesAppDB] SET  READ_WRITE 
GO
