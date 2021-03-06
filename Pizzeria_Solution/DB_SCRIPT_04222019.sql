USE [Pizzeria]
GO
/****** Object:  StoredProcedure [dbo].[USP_GetDropdownList]    Script Date: 4/22/2019 1:17:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Krunal Rohit
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[USP_GetDropdownList]
	@Mode INT = NULL
AS
BEGIN
	IF @Mode = 1
	BEGIN
		SELECT SizeId AS [Value], SizeName AS [Name]
		FROM Size
	END

	ELSE IF @Mode = 2
	BEGIN
		SELECT CategoryId AS [Value], Title AS [Name]
		FROM Category
	END
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetPizzaList]    Script Date: 4/22/2019 1:17:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Krunal Rohit
-- Description:	<Description,,>
-- [USP_GetPizzaList] '', '', '', 1, 1000, NULL
-- =============================================
CREATE PROCEDURE [dbo].[USP_GetPizzaList]
	@searchExpression NVARCHAR(MAX) = NULL,
	@sortExpression NVARCHAR(MAX) = NULL,
	@sortDirection NVARCHAR(MAX) = NULL,
	@startIndex BIGINT = NULL,
	@pageSize BIGINT = NULL,
	@totalRecords BIGINT OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;

	DECLARE @SqlQuery NVARCHAR(MAX)
	DECLARE @CountQuery NVARCHAR(MAX)
	DECLARE @Joins NVARCHAR(MAX)
	DECLARE @ParmDefinition NVARCHAR(500)
	SET @ParmDefinition = N'@totalRecords BIGINT OUTPUT'
	
	IF (@sortExpression IS NULL) OR (LEN(@sortExpression)=0)
	BEGIN
		SET @sortExpression = 'P.Title'
	END
	
	IF (@sortDirection IS NULL) OR (LEN(@sortDirection)=0)
	BEGIN
		SET @sortDirection = 'DESC'
	END

	SET @Joins = ' JOIN Category C ON C.CategoryId=P.CategoryId'
	SET @Joins = @Joins + ' LEFT JOIN PizzaSize PS ON PS.PizzaId=P.PizzaId'
	
	SET @SqlQuery = 'SELECT DISTINCT
	 P.PizzaId,
	 P.Title,
	 P.Description,
	 P.CategoryId,
	 C.Title AS CategoryName,
	 ISNULL(STUFF((SELECT DISTINCT '', '' + S.Abbreviation
         FROM PizzaSize ps1
		 JOIN Size S ON S.SizeId=ps1.SizeId
         WHERE PS.PizzaId = ps1.PizzaId
            FOR XML PATH(''''), TYPE
            ).value(''.'', ''NVARCHAR(MAX)'')
        ,1,1,''''), ''M'') AS Sizes,
	 ISNULL((SELECT MIN(Price) FROM PizzaSize WHERE PizzaId=P.PizzaId), 0) AS Price,
	 P.FilePath,
	 P.CreatedDate
	 FROM Pizza P' + @Joins
					
	SET @CountQuery = 'SELECT @totalRecords = COUNT(*) FROM Pizza P' + @Joins
	

	IF (@searchExpression IS NOT NULL) AND (LEN(@searchExpression)>0)
	BEGIN
		SET @SqlQuery = @SqlQuery + ' WHERE ' + @searchExpression
		SET @CountQuery = @CountQuery + ' WHERE ' + @searchExpression
	END	
	
	SET @SqlQuery = @SqlQuery + ' ORDER BY ' + @sortExpression + ' ' + @sortDirection
	SET @SqlQuery = @SqlQuery + ' OFFSET ' + CAST((@pageSize * (@startIndex - 1)) AS NVARCHAR(10)) + 
					' ROWS FETCH NEXT ' + CAST(@pageSize AS NVARCHAR(10)) + ' ROWS ONLY'
	
	SET @SqlQuery = @SqlQuery + '; ' + @CountQuery
	
	PRINT @SqlQuery
		
	EXECUTE SP_EXECUTESQL @SqlQuery, @ParmDefinition, @totalRecords OUTPUT	

	PRINT @totalRecords


	--SELECT
	--SizeId,
	--SizeName,
	--Abbreviation
	--FROM Size

END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetSizeList]    Script Date: 4/22/2019 1:17:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Krunal Rohit
-- Description:	<Description,,>
-- [USP_GetSizeList] '', '', '', 1, 1000, NULL
-- =============================================
CREATE PROCEDURE [dbo].[USP_GetSizeList]
	@searchExpression NVARCHAR(MAX) = NULL,
	@sortExpression NVARCHAR(MAX) = NULL,
	@sortDirection NVARCHAR(MAX) = NULL,
	@startIndex BIGINT = NULL,
	@pageSize BIGINT = NULL,
	@totalRecords BIGINT OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;

	DECLARE @SqlQuery NVARCHAR(MAX)
	DECLARE @CountQuery NVARCHAR(MAX)
	DECLARE @Joins NVARCHAR(MAX)
	DECLARE @ParmDefinition NVARCHAR(500)
	SET @ParmDefinition = N'@totalRecords BIGINT OUTPUT'
	
	IF (@sortExpression IS NULL) OR (LEN(@sortExpression)=0)
	BEGIN
		SET @sortExpression = 'CreatedDate'
	END
	
	IF (@sortDirection IS NULL) OR (LEN(@sortDirection)=0)
	BEGIN
		SET @sortDirection = 'DESC'
	END

	SET @Joins = ' '
	
	SET @SqlQuery = 'SELECT
	 SizeId,
	 SizeName,
	 Abbreviation
	 FROM Size' + @Joins
					
	SET @CountQuery = 'SELECT @totalRecords = COUNT(*) FROM Size' + @Joins
	

	IF (@searchExpression IS NOT NULL) AND (LEN(@searchExpression)>0)
	BEGIN
		SET @SqlQuery = @SqlQuery + ' WHERE ' + @searchExpression
		SET @CountQuery = @CountQuery + ' WHERE ' + @searchExpression
	END	
	
	SET @SqlQuery = @SqlQuery + ' ORDER BY ' + @sortExpression + ' ' + @sortDirection
	SET @SqlQuery = @SqlQuery + ' OFFSET ' + CAST((@pageSize * (@startIndex - 1)) AS NVARCHAR(10)) + 
					' ROWS FETCH NEXT ' + CAST(@pageSize AS NVARCHAR(10)) + ' ROWS ONLY'
	
	SET @SqlQuery = @SqlQuery + '; ' + @CountQuery
	
	PRINT @SqlQuery
		
	EXECUTE SP_EXECUTESQL @SqlQuery, @ParmDefinition, @totalRecords OUTPUT	

	PRINT @totalRecords


	--SELECT
	--SizeId,
	--SizeName,
	--Abbreviation
	--FROM Size

END

GO
/****** Object:  StoredProcedure [dbo].[USP_ManagePizza]    Script Date: 4/22/2019 1:17:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Krunal Rohit
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[USP_ManagePizza]
	@Mode CHAR(5) = NULL,
	@PizzaId INT = NULL,
	@Title NVARCHAR(100) = NULL,
	@Description NVARCHAR(500) = NULL,
	@CategoryId INT = NULL,
	@FilePath NVARCHAR(MAX) = NULL

AS
BEGIN
	
	IF @Mode = 'C'
	BEGIN
		INSERT INTO Pizza(Title, Description, CategoryId, FilePath)
		VALUES(@Title, @Description, @CategoryId, @FilePath)

		SELECT SCOPE_IDENTITY()
	END

	ELSE IF @Mode = 'U'
	BEGIN
		UPDATE Pizza SET
		Title = @Title,
		Description = @Description,
		CategoryId = @CategoryId,
		FilePath = @FilePath,
		ModifiedDate = GETDATE()
		WHERE PizzaId = @PizzaId

		SELECT @PizzaId
	END

END

GO
/****** Object:  StoredProcedure [dbo].[USP_ManageSize]    Script Date: 4/22/2019 1:17:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Krunal Rohit
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[USP_ManageSize]
	@Mode CHAR(4) = NULL,
	@SizeId INT = NULL,
	@SizeName NVARCHAR(50),
	@Abbreviation NVARCHAR(10)

AS
BEGIN
	
	IF @Mode = 'C'
	BEGIN
		INSERT INTO Size (SizeName, Abbreviation)
		VALUES (@SizeName, @Abbreviation)
	END

	ELSE IF @Mode = 'U'
	BEGIN
		UPDATE Size SET
		SizeName = @SizeName,
		Abbreviation = @Abbreviation,
		ModifiedDate = GETDATE()
		WHERE SizeId=@SizeId
	END

END

GO
/****** Object:  Table [dbo].[AspNetRoleClaims]    Script Date: 4/22/2019 1:17:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoleClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 4/22/2019 1:17:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](256) NULL,
	[NormalizedName] [nvarchar](256) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 4/22/2019 1:17:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 4/22/2019 1:17:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[ProviderDisplayName] [nvarchar](max) NULL,
	[UserId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 4/22/2019 1:17:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](450) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 4/22/2019 1:17:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](450) NOT NULL,
	[UserName] [nvarchar](256) NULL,
	[NormalizedUserName] [nvarchar](256) NULL,
	[Email] [nvarchar](256) NULL,
	[NormalizedEmail] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserTokens]    Script Date: 4/22/2019 1:17:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserTokens](
	[UserId] [nvarchar](450) NOT NULL,
	[LoginProvider] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[LoginProvider] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Category]    Script Date: 4/22/2019 1:17:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Order]    Script Date: 4/22/2019 1:17:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [uniqueidentifier] NULL,
	[CustomerName] [nvarchar](50) NULL,
	[CustomerContact] [nvarchar](10) NULL,
	[DeliveryPickUpDate] [datetime] NULL,
	[StoreId] [int] NULL,
	[StatusId] [int] NULL,
	[TotalAmount] [money] NULL,
	[AdditionalInstructions] [nvarchar](100) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderPizza]    Script Date: 4/22/2019 1:17:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderPizza](
	[OrderPizzaId] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NULL,
	[PizzaId] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_OrderPizza] PRIMARY KEY CLUSTERED 
(
	[OrderPizzaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Pizza]    Script Date: 4/22/2019 1:17:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pizza](
	[PizzaId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](100) NULL,
	[Description] [nvarchar](500) NULL,
	[CategoryId] [int] NULL,
	[FilePath] [nvarchar](max) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_Pizza] PRIMARY KEY CLUSTERED 
(
	[PizzaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PizzaSize]    Script Date: 4/22/2019 1:17:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PizzaSize](
	[PizzaSizeId] [int] IDENTITY(1,1) NOT NULL,
	[PizzaId] [int] NULL,
	[SizeId] [int] NULL,
	[Price] [money] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_PizzaSize_1] PRIMARY KEY CLUSTERED 
(
	[PizzaSizeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Size]    Script Date: 4/22/2019 1:17:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Size](
	[SizeId] [int] IDENTITY(1,1) NOT NULL,
	[SizeName] [nvarchar](50) NULL,
	[Abbreviation] [nvarchar](10) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_PizzaSize] PRIMARY KEY CLUSTERED 
(
	[SizeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Store]    Script Date: 4/22/2019 1:17:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Store](
	[StoreId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Address] [nvarchar](500) NULL,
	[Zipcode] [nvarchar](10) NULL,
	[Contact] [nvarchar](20) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_Store] PRIMARY KEY CLUSTERED 
(
	[StoreId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'751bb8d9-0518-49b6-a994-84ac1bd6efa2', N'testuser1@pizzeria.com', N'TESTUSER1@PIZZERIA.COM', N'testuser1@pizzeria.com', N'TESTUSER1@PIZZERIA.COM', 0, N'AQAAAAEAACcQAAAAELX3TWAmgHhmk15EJtNl2rAJcQT/1W5r7aBuqFs2GokTBqTfrV/vZ9+5z9p5CzO/IQ==', N'7ROAY7IE46KMX6ARWKRT2VJ7KKPLP7WP', N'585172aa-b201-4287-a8da-503284112a73', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'fa7faedd-fa72-4030-80b8-15740a95cb68', N'admin@pizzeria.com', N'ADMIN@PIZZERIA.COM', N'admin@pizzeria.com', N'ADMIN@PIZZERIA.COM', 0, N'AQAAAAEAACcQAAAAELXPN/A7q6afIOsfdsMzWj/MgQXDM7tMjf7k1vS8INEjQIXq9yM5NnDB4R0aK2W45w==', N'INFYVPWTTARLHS2X2SLQ3Q22YSW7NFNR', N'b054ccd6-baa7-4386-b627-817414ae26c5', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUserTokens] ([UserId], [LoginProvider], [Name], [Value]) VALUES (N'fa7faedd-fa72-4030-80b8-15740a95cb68', N'[AspNetUserStore]', N'AuthenticatorKey', N'PIMGTPXBWIQ7ZLG4WARGYVLO6O5UYRJS')
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([CategoryId], [Title], [CreatedDate], [ModifiedDate]) VALUES (1, N'Vegeterian', CAST(0x0000AA32016761DA AS DateTime), CAST(0x0000AA32016761DA AS DateTime))
INSERT [dbo].[Category] ([CategoryId], [Title], [CreatedDate], [ModifiedDate]) VALUES (2, N'Non-Vegeterian', CAST(0x0000AA32016767E1 AS DateTime), CAST(0x0000AA32016767E1 AS DateTime))
SET IDENTITY_INSERT [dbo].[Category] OFF
SET IDENTITY_INSERT [dbo].[Pizza] ON 

INSERT [dbo].[Pizza] ([PizzaId], [Title], [Description], [CategoryId], [FilePath], [CreatedDate], [ModifiedDate]) VALUES (1, N'Cheese Burst Non-Veg', N'Cheese Burst Non-Veg', 2, N'images\pizzas\2004201912074507.png', CAST(0x0000AA35000231C0 AS DateTime), CAST(0x0000AA35000231C0 AS DateTime))
INSERT [dbo].[Pizza] ([PizzaId], [Title], [Description], [CategoryId], [FilePath], [CreatedDate], [ModifiedDate]) VALUES (2, N'Extravaganza', N'Extravaganza', 1, N'images\pizzas\2004201912451166.png', CAST(0x0000AA35000C69D4 AS DateTime), CAST(0x0000AA35000C69D4 AS DateTime))
INSERT [dbo].[Pizza] ([PizzaId], [Title], [Description], [CategoryId], [FilePath], [CreatedDate], [ModifiedDate]) VALUES (3, N'American Veggies', N'American Veggies', 1, N'images\pizzas\2004201912530731.png', CAST(0x0000AA35000E9724 AS DateTime), CAST(0x0000AA35000E9724 AS DateTime))
INSERT [dbo].[Pizza] ([PizzaId], [Title], [Description], [CategoryId], [FilePath], [CreatedDate], [ModifiedDate]) VALUES (4, N'Veggie Supreme', N'Veggie Supreme', 1, N'images\pizzas\2004201912074507.png', CAST(0x0000AA35000231C0 AS DateTime), CAST(0x0000AA35000231C0 AS DateTime))
INSERT [dbo].[Pizza] ([PizzaId], [Title], [Description], [CategoryId], [FilePath], [CreatedDate], [ModifiedDate]) VALUES (5, N'Mexican Passion', N'Mexican Passion', 2, N'images\pizzas\2004201912451166.png', CAST(0x0000AA35000C69D4 AS DateTime), CAST(0x0000AA35000C69D4 AS DateTime))
INSERT [dbo].[Pizza] ([PizzaId], [Title], [Description], [CategoryId], [FilePath], [CreatedDate], [ModifiedDate]) VALUES (6, N'Italian Veggies', N'Italian Veggies', 1, N'images\pizzas\2004201912530731.png', CAST(0x0000AA35000E9724 AS DateTime), CAST(0x0000AA35000E9724 AS DateTime))
INSERT [dbo].[Pizza] ([PizzaId], [Title], [Description], [CategoryId], [FilePath], [CreatedDate], [ModifiedDate]) VALUES (7, N'Texas Combo', N'Texas Combo', 2, N'images\pizzas\2004201912074507.png', CAST(0x0000AA35000231C0 AS DateTime), CAST(0x0000AA35000231C0 AS DateTime))
INSERT [dbo].[Pizza] ([PizzaId], [Title], [Description], [CategoryId], [FilePath], [CreatedDate], [ModifiedDate]) VALUES (8, N'Meator', N'Meator', 1, N'images\pizzas\2004201912451166.png', CAST(0x0000AA35000C69D4 AS DateTime), CAST(0x0000AA35000C69D4 AS DateTime))
INSERT [dbo].[Pizza] ([PizzaId], [Title], [Description], [CategoryId], [FilePath], [CreatedDate], [ModifiedDate]) VALUES (9, N'Pepperoni Plus', N'Pepperoni Plus', 1, N'images\pizzas\2004201912530731.png', CAST(0x0000AA35000E9724 AS DateTime), CAST(0x0000AA35000E9724 AS DateTime))
INSERT [dbo].[Pizza] ([PizzaId], [Title], [Description], [CategoryId], [FilePath], [CreatedDate], [ModifiedDate]) VALUES (10, N'Tandoori Chicken', N'Tandoori Chicken', 2, N'images\pizzas\2004201912074507.png', CAST(0x0000AA35000231C0 AS DateTime), CAST(0x0000AA35000231C0 AS DateTime))
INSERT [dbo].[Pizza] ([PizzaId], [Title], [Description], [CategoryId], [FilePath], [CreatedDate], [ModifiedDate]) VALUES (11, N'Garlic Breads', N'Garlic Breads', 1, N'images\pizzas\2004201912451166.png', CAST(0x0000AA35000C69D4 AS DateTime), CAST(0x0000AA35000C69D4 AS DateTime))
INSERT [dbo].[Pizza] ([PizzaId], [Title], [Description], [CategoryId], [FilePath], [CreatedDate], [ModifiedDate]) VALUES (12, N'Mushroom Riot', N'Mushroom Riot', 1, N'images\pizzas\2004201912530731.png', CAST(0x0000AA35000E9724 AS DateTime), CAST(0x0000AA35000E9724 AS DateTime))
INSERT [dbo].[Pizza] ([PizzaId], [Title], [Description], [CategoryId], [FilePath], [CreatedDate], [ModifiedDate]) VALUES (13, N'Spicy Treat', N'Spicy Treat', 2, N'images\pizzas\2004201912074507.png', CAST(0x0000AA35000231C0 AS DateTime), CAST(0x0000AA35000231C0 AS DateTime))
INSERT [dbo].[Pizza] ([PizzaId], [Title], [Description], [CategoryId], [FilePath], [CreatedDate], [ModifiedDate]) VALUES (14, N'American Heat', N'American Heat', 1, N'images\pizzas\2004201912451166.png', CAST(0x0000AA35000C69D4 AS DateTime), CAST(0x0000AA35000C69D4 AS DateTime))
INSERT [dbo].[Pizza] ([PizzaId], [Title], [Description], [CategoryId], [FilePath], [CreatedDate], [ModifiedDate]) VALUES (15, N'Hawaiian Fantasy', N'Hawaiian Fantasy', 1, N'images\pizzas\2004201912530731.png', CAST(0x0000AA35000E9724 AS DateTime), CAST(0x0000AA35000E9724 AS DateTime))
SET IDENTITY_INSERT [dbo].[Pizza] OFF
SET IDENTITY_INSERT [dbo].[PizzaSize] ON 

INSERT [dbo].[PizzaSize] ([PizzaSizeId], [PizzaId], [SizeId], [Price], [CreatedDate], [ModifiedDate]) VALUES (1, 1, 1, 10.0000, CAST(0x0000AA3501646A9E AS DateTime), CAST(0x0000AA3501646A9E AS DateTime))
INSERT [dbo].[PizzaSize] ([PizzaSizeId], [PizzaId], [SizeId], [Price], [CreatedDate], [ModifiedDate]) VALUES (2, 1, 2, 12.0000, CAST(0x0000AA3501646EF3 AS DateTime), CAST(0x0000AA3501646EF3 AS DateTime))
INSERT [dbo].[PizzaSize] ([PizzaSizeId], [PizzaId], [SizeId], [Price], [CreatedDate], [ModifiedDate]) VALUES (3, 1, 3, 15.0000, CAST(0x0000AA3501647414 AS DateTime), CAST(0x0000AA3501647414 AS DateTime))
INSERT [dbo].[PizzaSize] ([PizzaSizeId], [PizzaId], [SizeId], [Price], [CreatedDate], [ModifiedDate]) VALUES (4, 2, 1, 11.0000, CAST(0x0000AA3501647C95 AS DateTime), CAST(0x0000AA3501647C95 AS DateTime))
INSERT [dbo].[PizzaSize] ([PizzaSizeId], [PizzaId], [SizeId], [Price], [CreatedDate], [ModifiedDate]) VALUES (5, 2, 2, 14.0000, CAST(0x0000AA3501647F70 AS DateTime), CAST(0x0000AA3501647F70 AS DateTime))
INSERT [dbo].[PizzaSize] ([PizzaSizeId], [PizzaId], [SizeId], [Price], [CreatedDate], [ModifiedDate]) VALUES (6, 2, 3, 17.0000, CAST(0x0000AA35016481FE AS DateTime), CAST(0x0000AA35016481FE AS DateTime))
INSERT [dbo].[PizzaSize] ([PizzaSizeId], [PizzaId], [SizeId], [Price], [CreatedDate], [ModifiedDate]) VALUES (7, 2, 4, 20.0000, CAST(0x0000AA35016484FC AS DateTime), CAST(0x0000AA35016484FC AS DateTime))
INSERT [dbo].[PizzaSize] ([PizzaSizeId], [PizzaId], [SizeId], [Price], [CreatedDate], [ModifiedDate]) VALUES (8, 2, 5, 30.0000, CAST(0x0000AA3501648F08 AS DateTime), CAST(0x0000AA3501648F08 AS DateTime))
INSERT [dbo].[PizzaSize] ([PizzaSizeId], [PizzaId], [SizeId], [Price], [CreatedDate], [ModifiedDate]) VALUES (9, 3, 1, 12.0000, CAST(0x0000AA350164923C AS DateTime), CAST(0x0000AA350164923C AS DateTime))
INSERT [dbo].[PizzaSize] ([PizzaSizeId], [PizzaId], [SizeId], [Price], [CreatedDate], [ModifiedDate]) VALUES (10, 3, 4, 18.0000, CAST(0x0000AA3501649864 AS DateTime), CAST(0x0000AA3501649864 AS DateTime))
INSERT [dbo].[PizzaSize] ([PizzaSizeId], [PizzaId], [SizeId], [Price], [CreatedDate], [ModifiedDate]) VALUES (11, 4, 1, 10.0000, CAST(0x0000AA3501646A9E AS DateTime), CAST(0x0000AA3501646A9E AS DateTime))
INSERT [dbo].[PizzaSize] ([PizzaSizeId], [PizzaId], [SizeId], [Price], [CreatedDate], [ModifiedDate]) VALUES (12, 4, 2, 12.0000, CAST(0x0000AA3501646EF3 AS DateTime), CAST(0x0000AA3501646EF3 AS DateTime))
INSERT [dbo].[PizzaSize] ([PizzaSizeId], [PizzaId], [SizeId], [Price], [CreatedDate], [ModifiedDate]) VALUES (13, 4, 3, 15.0000, CAST(0x0000AA3501647414 AS DateTime), CAST(0x0000AA3501647414 AS DateTime))
INSERT [dbo].[PizzaSize] ([PizzaSizeId], [PizzaId], [SizeId], [Price], [CreatedDate], [ModifiedDate]) VALUES (14, 5, 1, 11.0000, CAST(0x0000AA3501647C95 AS DateTime), CAST(0x0000AA3501647C95 AS DateTime))
INSERT [dbo].[PizzaSize] ([PizzaSizeId], [PizzaId], [SizeId], [Price], [CreatedDate], [ModifiedDate]) VALUES (15, 5, 2, 14.0000, CAST(0x0000AA3501647F70 AS DateTime), CAST(0x0000AA3501647F70 AS DateTime))
INSERT [dbo].[PizzaSize] ([PizzaSizeId], [PizzaId], [SizeId], [Price], [CreatedDate], [ModifiedDate]) VALUES (16, 5, 3, 17.0000, CAST(0x0000AA35016481FE AS DateTime), CAST(0x0000AA35016481FE AS DateTime))
INSERT [dbo].[PizzaSize] ([PizzaSizeId], [PizzaId], [SizeId], [Price], [CreatedDate], [ModifiedDate]) VALUES (17, 6, 4, 20.0000, CAST(0x0000AA35016484FC AS DateTime), CAST(0x0000AA35016484FC AS DateTime))
INSERT [dbo].[PizzaSize] ([PizzaSizeId], [PizzaId], [SizeId], [Price], [CreatedDate], [ModifiedDate]) VALUES (18, 6, 5, 30.0000, CAST(0x0000AA3501648F08 AS DateTime), CAST(0x0000AA3501648F08 AS DateTime))
INSERT [dbo].[PizzaSize] ([PizzaSizeId], [PizzaId], [SizeId], [Price], [CreatedDate], [ModifiedDate]) VALUES (19, 6, 1, 12.0000, CAST(0x0000AA350164923C AS DateTime), CAST(0x0000AA350164923C AS DateTime))
INSERT [dbo].[PizzaSize] ([PizzaSizeId], [PizzaId], [SizeId], [Price], [CreatedDate], [ModifiedDate]) VALUES (20, 6, 4, 18.0000, CAST(0x0000AA3501649864 AS DateTime), CAST(0x0000AA3501649864 AS DateTime))
INSERT [dbo].[PizzaSize] ([PizzaSizeId], [PizzaId], [SizeId], [Price], [CreatedDate], [ModifiedDate]) VALUES (21, 7, 1, 10.0000, CAST(0x0000AA3501646A9E AS DateTime), CAST(0x0000AA3501646A9E AS DateTime))
INSERT [dbo].[PizzaSize] ([PizzaSizeId], [PizzaId], [SizeId], [Price], [CreatedDate], [ModifiedDate]) VALUES (22, 7, 2, 12.0000, CAST(0x0000AA3501646EF3 AS DateTime), CAST(0x0000AA3501646EF3 AS DateTime))
INSERT [dbo].[PizzaSize] ([PizzaSizeId], [PizzaId], [SizeId], [Price], [CreatedDate], [ModifiedDate]) VALUES (23, 7, 3, 15.0000, CAST(0x0000AA3501647414 AS DateTime), CAST(0x0000AA3501647414 AS DateTime))
INSERT [dbo].[PizzaSize] ([PizzaSizeId], [PizzaId], [SizeId], [Price], [CreatedDate], [ModifiedDate]) VALUES (24, 7, 1, 11.0000, CAST(0x0000AA3501647C95 AS DateTime), CAST(0x0000AA3501647C95 AS DateTime))
INSERT [dbo].[PizzaSize] ([PizzaSizeId], [PizzaId], [SizeId], [Price], [CreatedDate], [ModifiedDate]) VALUES (25, 8, 2, 14.0000, CAST(0x0000AA3501647F70 AS DateTime), CAST(0x0000AA3501647F70 AS DateTime))
INSERT [dbo].[PizzaSize] ([PizzaSizeId], [PizzaId], [SizeId], [Price], [CreatedDate], [ModifiedDate]) VALUES (26, 9, 3, 17.0000, CAST(0x0000AA35016481FE AS DateTime), CAST(0x0000AA35016481FE AS DateTime))
INSERT [dbo].[PizzaSize] ([PizzaSizeId], [PizzaId], [SizeId], [Price], [CreatedDate], [ModifiedDate]) VALUES (27, 9, 4, 20.0000, CAST(0x0000AA35016484FC AS DateTime), CAST(0x0000AA35016484FC AS DateTime))
INSERT [dbo].[PizzaSize] ([PizzaSizeId], [PizzaId], [SizeId], [Price], [CreatedDate], [ModifiedDate]) VALUES (28, 9, 5, 30.0000, CAST(0x0000AA3501648F08 AS DateTime), CAST(0x0000AA3501648F08 AS DateTime))
INSERT [dbo].[PizzaSize] ([PizzaSizeId], [PizzaId], [SizeId], [Price], [CreatedDate], [ModifiedDate]) VALUES (29, 9, 1, 12.0000, CAST(0x0000AA350164923C AS DateTime), CAST(0x0000AA350164923C AS DateTime))
INSERT [dbo].[PizzaSize] ([PizzaSizeId], [PizzaId], [SizeId], [Price], [CreatedDate], [ModifiedDate]) VALUES (30, 9, 4, 18.0000, CAST(0x0000AA3501649864 AS DateTime), CAST(0x0000AA3501649864 AS DateTime))
SET IDENTITY_INSERT [dbo].[PizzaSize] OFF
SET IDENTITY_INSERT [dbo].[Size] ON 

INSERT [dbo].[Size] ([SizeId], [SizeName], [Abbreviation], [CreatedDate], [ModifiedDate]) VALUES (1, N'Small', N'S', CAST(0x0000AA320167184F AS DateTime), CAST(0x0000AA320167184F AS DateTime))
INSERT [dbo].[Size] ([SizeId], [SizeName], [Abbreviation], [CreatedDate], [ModifiedDate]) VALUES (2, N'Medium', N'M', CAST(0x0000AA3201671BA3 AS DateTime), CAST(0x0000AA3201671BA3 AS DateTime))
INSERT [dbo].[Size] ([SizeId], [SizeName], [Abbreviation], [CreatedDate], [ModifiedDate]) VALUES (3, N'Large', N'L', CAST(0x0000AA3201671D7E AS DateTime), CAST(0x0000AA3201671D7E AS DateTime))
INSERT [dbo].[Size] ([SizeId], [SizeName], [Abbreviation], [CreatedDate], [ModifiedDate]) VALUES (4, N'Extra Large', N'XL', CAST(0x0000AA340003DBCC AS DateTime), CAST(0x0000AA340003DBCC AS DateTime))
INSERT [dbo].[Size] ([SizeId], [SizeName], [Abbreviation], [CreatedDate], [ModifiedDate]) VALUES (5, N'Monster', N'MR', CAST(0x0000AA3400047F28 AS DateTime), CAST(0x0000AA3400047F28 AS DateTime))
SET IDENTITY_INSERT [dbo].[Size] OFF
ALTER TABLE [dbo].[Category] ADD  CONSTRAINT [DF_Category_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Category] ADD  CONSTRAINT [DF_Category_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [dbo].[Order] ADD  CONSTRAINT [DF_Order_TotalAmount]  DEFAULT ((0)) FOR [TotalAmount]
GO
ALTER TABLE [dbo].[Order] ADD  CONSTRAINT [DF_Order_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Order] ADD  CONSTRAINT [DF_Order_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [dbo].[OrderPizza] ADD  CONSTRAINT [DF_OrderPizza_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[OrderPizza] ADD  CONSTRAINT [DF_OrderPizza_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [dbo].[Pizza] ADD  CONSTRAINT [DF_Pizza_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Pizza] ADD  CONSTRAINT [DF_Pizza_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [dbo].[PizzaSize] ADD  CONSTRAINT [DF_PizzaSize_CreatedDate_1]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[PizzaSize] ADD  CONSTRAINT [DF_PizzaSize_ModifiedDate_1]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [dbo].[Size] ADD  CONSTRAINT [DF_PizzaSize_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Size] ADD  CONSTRAINT [DF_PizzaSize_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [dbo].[Store] ADD  CONSTRAINT [DF_Store_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Store] ADD  CONSTRAINT [DF_Store_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [dbo].[AspNetRoleClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetRoleClaims] CHECK CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserTokens]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserTokens] CHECK CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[OrderPizza]  WITH CHECK ADD  CONSTRAINT [FK_OrderPizza_Order] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Order] ([OrderId])
GO
ALTER TABLE [dbo].[OrderPizza] CHECK CONSTRAINT [FK_OrderPizza_Order]
GO
ALTER TABLE [dbo].[OrderPizza]  WITH CHECK ADD  CONSTRAINT [FK_OrderPizza_Pizza] FOREIGN KEY([PizzaId])
REFERENCES [dbo].[Pizza] ([PizzaId])
GO
ALTER TABLE [dbo].[OrderPizza] CHECK CONSTRAINT [FK_OrderPizza_Pizza]
GO
ALTER TABLE [dbo].[Pizza]  WITH CHECK ADD  CONSTRAINT [FK_Pizza_Category] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([CategoryId])
GO
ALTER TABLE [dbo].[Pizza] CHECK CONSTRAINT [FK_Pizza_Category]
GO
ALTER TABLE [dbo].[PizzaSize]  WITH CHECK ADD  CONSTRAINT [FK_PizzaSize_Pizza] FOREIGN KEY([PizzaId])
REFERENCES [dbo].[Pizza] ([PizzaId])
GO
ALTER TABLE [dbo].[PizzaSize] CHECK CONSTRAINT [FK_PizzaSize_Pizza]
GO
ALTER TABLE [dbo].[PizzaSize]  WITH CHECK ADD  CONSTRAINT [FK_PizzaSize_Size] FOREIGN KEY([SizeId])
REFERENCES [dbo].[Size] ([SizeId])
GO
ALTER TABLE [dbo].[PizzaSize] CHECK CONSTRAINT [FK_PizzaSize_Size]
GO
