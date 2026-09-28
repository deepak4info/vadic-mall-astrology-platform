USE [master]
GO
/****** Object:  Database [VadicMall]    Script Date: 09/06/2026 16:02:26 ******/
CREATE DATABASE [VadicMall]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'VadicMall', FILENAME = N'/var/opt/mssql/data/VadicMall.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'VadicMall_log', FILENAME = N'/var/opt/mssql/data/VadicMall_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [VadicMall].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [VadicMall] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [VadicMall] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [VadicMall] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [VadicMall] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [VadicMall] SET ARITHABORT OFF 
GO
ALTER DATABASE [VadicMall] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [VadicMall] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [VadicMall] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [VadicMall] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [VadicMall] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [VadicMall] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [VadicMall] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [VadicMall] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [VadicMall] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [VadicMall] SET  ENABLE_BROKER 
GO
ALTER DATABASE [VadicMall] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [VadicMall] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [VadicMall] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [VadicMall] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [VadicMall] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [VadicMall] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [VadicMall] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [VadicMall] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [VadicMall] SET  MULTI_USER 
GO
ALTER DATABASE [VadicMall] SET PAGE_VERIFY NONE  
GO
ALTER DATABASE [VadicMall] SET DB_CHAINING OFF 
GO
ALTER DATABASE [VadicMall] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [VadicMall] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [VadicMall] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [VadicMall] SET QUERY_STORE = ON
GO
ALTER DATABASE [VadicMall] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO)
GO
USE [VadicMall]
GO
ALTER DATABASE SCOPED CONFIGURATION SET ACCELERATED_PLAN_FORCING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ASYNC_STATS_UPDATE_WAIT_AT_LOW_PRIORITY = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET BATCH_MODE_ADAPTIVE_JOINS = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET BATCH_MODE_MEMORY_GRANT_FEEDBACK = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET BATCH_MODE_ON_ROWSTORE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET DEFERRED_COMPILATION_TV = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET DW_COMPATIBILITY_LEVEL = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ELEVATE_ONLINE = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ELEVATE_RESUMABLE = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET EXEC_QUERY_STATS_FOR_SCALAR_FUNCTIONS = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET FORCE_SHOWPLAN_RUNTIME_PARAMETER_COLLECTION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET GLOBAL_TEMPORARY_TABLE_AUTO_DROP = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET INTERLEAVED_EXECUTION_TVF = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ISOLATE_SECURITY_POLICY_CARDINALITY = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LAST_QUERY_PLAN_STATS = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEDGER_DIGEST_STORAGE_ENDPOINT = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LIGHTWEIGHT_QUERY_PROFILING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MEMORY_GRANT_FEEDBACK_PERCENTILE_GRANT = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MEMORY_GRANT_FEEDBACK_PERSISTENCE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET OPTIMIZE_FOR_AD_HOC_WORKLOADS = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PAUSED_RESUMABLE_INDEX_ABORT_DURATION_MINUTES = 1440;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET ROW_MODE_MEMORY_GRANT_FEEDBACK = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET TSQL_SCALAR_UDF_INLINING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET VERBOSE_TRUNCATION_WARNINGS = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET XTP_PROCEDURE_EXECUTION_STATISTICS = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET XTP_QUERY_EXECUTION_STATISTICS = OFF;
GO
USE [VadicMall]
GO
/****** Object:  Table [dbo].[Addresses]    Script Date: 09/06/2026 16:02:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Addresses](
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[FullName] [nvarchar](200) NOT NULL,
	[Phone] [nvarchar](20) NOT NULL,
	[AddressLine1] [nvarchar](300) NOT NULL,
	[AddressLine2] [nvarchar](300) NULL,
	[City] [nvarchar](100) NOT NULL,
	[State] [nvarchar](100) NOT NULL,
	[Pincode] [nvarchar](20) NOT NULL,
	[Country] [nvarchar](100) NOT NULL,
	[IsDefault] [bit] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AstrologerProfiles]    Script Date: 09/06/2026 16:02:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AstrologerProfiles](
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[Specialization] [nvarchar](200) NOT NULL,
	[Bio] [nvarchar](max) NOT NULL,
	[ExperienceYears] [int] NOT NULL,
	[ConsultationFee] [decimal](18, 2) NOT NULL,
	[Rating] [decimal](3, 1) NOT NULL,
	[ReviewCount] [int] NOT NULL,
	[IsApproved] [bit] NOT NULL,
	[IsFeatured] [bit] NOT NULL,
	[Languages] [nvarchar](200) NULL,
	[Availability] [nvarchar](500) NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AuditLogs]    Script Date: 09/06/2026 16:02:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuditLogs](
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NULL,
	[Action] [nvarchar](200) NOT NULL,
	[EntityType] [nvarchar](100) NOT NULL,
	[EntityId] [nvarchar](100) NULL,
	[BeforeState] [nvarchar](max) NULL,
	[AfterState] [nvarchar](max) NULL,
	[IpAddress] [nvarchar](50) NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BlogCategories]    Script Date: 09/06/2026 16:02:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlogCategories](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Slug] [nvarchar](200) NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BlogPosts]    Script Date: 09/06/2026 16:02:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BlogPosts](
	[Id] [uniqueidentifier] NOT NULL,
	[Title] [nvarchar](300) NOT NULL,
	[Slug] [nvarchar](300) NOT NULL,
	[Excerpt] [nvarchar](1000) NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[ImageUrl] [nvarchar](500) NULL,
	[Author] [nvarchar](200) NOT NULL,
	[CategoryId] [uniqueidentifier] NOT NULL,
	[ViewCount] [int] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CartItems]    Script Date: 09/06/2026 16:02:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CartItems](
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[ProductId] [uniqueidentifier] NOT NULL,
	[Quantity] [int] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContactQueries]    Script Date: 09/06/2026 16:02:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactQueries](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Email] [nvarchar](256) NOT NULL,
	[Phone] [nvarchar](20) NOT NULL,
	[Subject] [nvarchar](300) NOT NULL,
	[Message] [nvarchar](max) NOT NULL,
	[IsResolved] [bit] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Coupons]    Script Date: 09/06/2026 16:02:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Coupons](
	[Id] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](500) NOT NULL,
	[Type] [int] NOT NULL,
	[Value] [decimal](18, 2) NOT NULL,
	[MinOrderValue] [decimal](18, 2) NULL,
	[MaxDiscount] [decimal](18, 2) NULL,
	[UsageLimit] [int] NOT NULL,
	[UsedCount] [int] NOT NULL,
	[ValidFrom] [datetime2](7) NOT NULL,
	[ValidTo] [datetime2](7) NOT NULL,
	[FestivalTag] [nvarchar](100) NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CouponUsages]    Script Date: 09/06/2026 16:02:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CouponUsages](
	[Id] [uniqueidentifier] NOT NULL,
	[CouponId] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[OrderId] [uniqueidentifier] NULL,
	[DiscountAmount] [decimal](18, 2) NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ErrorLogs]    Script Date: 09/06/2026 16:02:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ErrorLogs](
	[Id] [uniqueidentifier] NOT NULL,
	[Message] [nvarchar](max) NOT NULL,
	[StackTrace] [nvarchar](max) NULL,
	[Source] [nvarchar](200) NULL,
	[RequestPath] [nvarchar](500) NULL,
	[UserId] [uniqueidentifier] NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Faqs]    Script Date: 09/06/2026 16:02:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Faqs](
	[Id] [uniqueidentifier] NOT NULL,
	[Question] [nvarchar](500) NOT NULL,
	[Answer] [nvarchar](max) NOT NULL,
	[Category] [nvarchar](100) NOT NULL,
	[SortOrder] [int] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiftCards]    Script Date: 09/06/2026 16:02:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiftCards](
	[Id] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[Balance] [decimal](18, 2) NOT NULL,
	[PurchasedByUserId] [uniqueidentifier] NULL,
	[RedeemedByUserId] [uniqueidentifier] NULL,
	[ExpiryDate] [datetime2](7) NULL,
	[Status] [nvarchar](50) NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KundliRequests]    Script Date: 09/06/2026 16:02:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KundliRequests](
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[DateOfBirth] [datetime2](7) NOT NULL,
	[TimeOfBirth] [nvarchar](20) NOT NULL,
	[PlaceOfBirth] [nvarchar](200) NOT NULL,
	[Gender] [nvarchar](20) NOT NULL,
	[Status] [int] NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[ReportUrl] [nvarchar](500) NULL,
	[AssignedAstrologerId] [uniqueidentifier] NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoginLogs]    Script Date: 09/06/2026 16:02:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoginLogs](
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NULL,
	[Email] [nvarchar](256) NOT NULL,
	[Success] [bit] NOT NULL,
	[IpAddress] [nvarchar](50) NULL,
	[UserAgent] [nvarchar](500) NULL,
	[FailureReason] [nvarchar](500) NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NewsletterSubscribers]    Script Date: 09/06/2026 16:02:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NewsletterSubscribers](
	[Id] [uniqueidentifier] NOT NULL,
	[Email] [nvarchar](256) NOT NULL,
	[IsConfirmed] [bit] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notifications]    Script Date: 09/06/2026 16:02:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notifications](
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[Title] [nvarchar](200) NOT NULL,
	[Message] [nvarchar](max) NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
	[IsRead] [bit] NOT NULL,
	[Link] [nvarchar](500) NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderItems]    Script Date: 09/06/2026 16:02:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderItems](
	[Id] [uniqueidentifier] NOT NULL,
	[OrderId] [uniqueidentifier] NOT NULL,
	[ProductId] [uniqueidentifier] NOT NULL,
	[Quantity] [int] NOT NULL,
	[UnitPrice] [decimal](18, 2) NOT NULL,
	[TotalPrice] [decimal](18, 2) NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 09/06/2026 16:02:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Id] [uniqueidentifier] NOT NULL,
	[OrderNumber] [nvarchar](50) NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[Status] [int] NOT NULL,
	[SubTotal] [decimal](18, 2) NOT NULL,
	[Discount] [decimal](18, 2) NOT NULL,
	[ShippingFee] [decimal](18, 2) NOT NULL,
	[Total] [decimal](18, 2) NOT NULL,
	[CouponCode] [nvarchar](50) NULL,
	[ShippingAddressId] [uniqueidentifier] NULL,
	[TrackingNumber] [nvarchar](100) NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderTracking]    Script Date: 09/06/2026 16:02:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderTracking](
	[Id] [uniqueidentifier] NOT NULL,
	[OrderId] [uniqueidentifier] NOT NULL,
	[Status] [int] NOT NULL,
	[Notes] [nvarchar](500) NULL,
	[Location] [nvarchar](200) NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payments]    Script Date: 09/06/2026 16:02:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payments](
	[Id] [uniqueidentifier] NOT NULL,
	[OrderId] [uniqueidentifier] NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[Status] [int] NOT NULL,
	[PaymentMethod] [nvarchar](50) NOT NULL,
	[TransactionId] [nvarchar](200) NULL,
	[GatewayResponse] [nvarchar](max) NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentTransactions]    Script Date: 09/06/2026 16:02:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentTransactions](
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[PaymentType] [nvarchar](50) NOT NULL,
	[ReferenceId] [uniqueidentifier] NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[Status] [int] NOT NULL,
	[PaymentMethod] [nvarchar](50) NOT NULL,
	[TransactionId] [nvarchar](200) NULL,
	[GatewayResponse] [nvarchar](max) NULL,
	[Notes] [nvarchar](500) NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Permissions]    Script Date: 09/06/2026 16:02:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Permissions](
	[Id] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](100) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Module] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PoojaBookings]    Script Date: 09/06/2026 16:02:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PoojaBookings](
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[PoojaServiceId] [uniqueidentifier] NOT NULL,
	[AstrologerId] [uniqueidentifier] NULL,
	[ScheduledDate] [datetime2](7) NOT NULL,
	[ScheduledTime] [nvarchar](20) NULL,
	[Status] [int] NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[SpecialInstructions] [nvarchar](1000) NULL,
	[Notes] [nvarchar](1000) NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PoojaServices]    Script Date: 09/06/2026 16:02:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PoojaServices](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Slug] [nvarchar](200) NOT NULL,
	[Category] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[SalePrice] [decimal](18, 2) NULL,
	[DurationMinutes] [int] NOT NULL,
	[ImageUrl] [nvarchar](500) NULL,
	[IsFeatured] [bit] NOT NULL,
	[Rating] [decimal](3, 1) NOT NULL,
	[ReviewCount] [int] NOT NULL,
	[FestivalTag] [nvarchar](100) NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductCategories]    Script Date: 09/06/2026 16:02:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCategories](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Slug] [nvarchar](200) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[ImageUrl] [nvarchar](500) NULL,
	[ParentId] [uniqueidentifier] NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductImages]    Script Date: 09/06/2026 16:02:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductImages](
	[Id] [uniqueidentifier] NOT NULL,
	[ProductId] [uniqueidentifier] NOT NULL,
	[ImageUrl] [nvarchar](500) NOT NULL,
	[IsPrimary] [bit] NOT NULL,
	[SortOrder] [int] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 09/06/2026 16:02:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Slug] [nvarchar](200) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[CategoryId] [uniqueidentifier] NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[SalePrice] [decimal](18, 2) NULL,
	[StockQuantity] [int] NOT NULL,
	[Sku] [nvarchar](50) NULL,
	[Rating] [decimal](3, 1) NOT NULL,
	[ReviewCount] [int] NOT NULL,
	[IsFeatured] [bit] NOT NULL,
	[FestivalTag] [nvarchar](100) NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reviews]    Script Date: 09/06/2026 16:02:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reviews](
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[ProductId] [uniqueidentifier] NOT NULL,
	[Rating] [int] NOT NULL,
	[Comment] [nvarchar](max) NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RolePermissions]    Script Date: 09/06/2026 16:02:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RolePermissions](
	[Id] [uniqueidentifier] NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
	[PermissionId] [uniqueidentifier] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 09/06/2026 16:02:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[IsSystem] [bit] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Settings]    Script Date: 09/06/2026 16:02:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Settings](
	[Id] [uniqueidentifier] NOT NULL,
	[Key] [nvarchar](100) NOT NULL,
	[Value] [nvarchar](max) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SubscriptionPlans]    Script Date: 09/06/2026 16:02:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubscriptionPlans](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Slug] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](500) NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[BillingCycle] [nvarchar](20) NOT NULL,
	[Features] [nvarchar](max) NOT NULL,
	[IsPopular] [bit] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserPermissions]    Script Date: 09/06/2026 16:02:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserPermissions](
	[UserId] [uniqueidentifier] NOT NULL,
	[Permission] [int] NOT NULL,
 CONSTRAINT [PK_UserPermissions] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[Permission] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 09/06/2026 16:02:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [uniqueidentifier] NOT NULL,
	[Email] [nvarchar](256) NOT NULL,
	[Phone] [nvarchar](20) NULL,
	[PasswordHash] [nvarchar](500) NOT NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[LastName] [nvarchar](100) NOT NULL,
	[AvatarUrl] [nvarchar](500) NULL,
	[Role] [int] NOT NULL,
	[RoleId] [uniqueidentifier] NULL,
	[EmailVerified] [bit] NOT NULL,
	[PhoneVerified] [bit] NOT NULL,
	[LastLoginAt] [datetime2](7) NULL,
	[RefreshToken] [nvarchar](500) NULL,
	[RefreshTokenExpiry] [datetime2](7) NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
	[IsStaffApproved] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserSubscriptions]    Script Date: 09/06/2026 16:02:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserSubscriptions](
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[SubscriptionPlanId] [uniqueidentifier] NOT NULL,
	[StartDate] [datetime2](7) NOT NULL,
	[EndDate] [datetime2](7) NOT NULL,
	[AutoRenew] [bit] NOT NULL,
	[Status] [nvarchar](50) NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WishlistItems]    Script Date: 09/06/2026 16:02:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WishlistItems](
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[ProductId] [uniqueidentifier] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Addresses] ([Id], [UserId], [FullName], [Phone], [AddressLine1], [AddressLine2], [City], [State], [Pincode], [Country], [IsDefault], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'da8e0d35-275f-4913-a9f0-90d5702bfc9e', N'fe091691-bce9-44a6-8909-0b6949c390cf', N'ljyhdsttyjrtwr', N'97866866476', N'yjsyjysjj', N'ssfgghjsjrtuurytu', N'sryhsrtrh', N'sfrtsrrthh', N'665431', N'India', 1, CAST(N'2026-09-02T07:42:45.8784360' AS DateTime2), NULL, 1)
INSERT [dbo].[Addresses] ([Id], [UserId], [FullName], [Phone], [AddressLine1], [AddressLine2], [City], [State], [Pincode], [Country], [IsDefault], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'aa5b50a5-cee0-4a48-b9dc-b3d792bf26f9', N'52b7ddbb-4791-43c4-9335-3a76e3df3209', N'Integration Test', N'9998887777', N'42 Test Lane', N'', N'Pune', N'Maharashtra', N'411001', N'India', 1, CAST(N'2026-08-31T16:17:53.3185360' AS DateTime2), NULL, 1)
INSERT [dbo].[AstrologerProfiles] ([Id], [UserId], [Specialization], [Bio], [ExperienceYears], [ConsultationFee], [Rating], [ReviewCount], [IsApproved], [IsFeatured], [Languages], [Availability], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'5bb407b1-0078-41b6-aaad-2d3deab5584c', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'vadic', N'fliueiyfglfywgyif', 6, CAST(999.00 AS Decimal(18, 2)), CAST(0.0 AS Decimal(3, 1)), 0, 0, 0, NULL, NULL, CAST(N'2026-09-02T09:16:23.6016630' AS DateTime2), CAST(N'2026-09-04T06:19:40.4889380' AS DateTime2), 1)
INSERT [dbo].[AuditLogs] ([Id], [UserId], [Action], [EntityType], [EntityId], [BeforeState], [AfterState], [IpAddress], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'a1100001-0000-0000-0000-000000000001', N'a1000001-0000-0000-0000-000000000001', N'OrderStatusUpdated', N'Order', N'n1000001-0000-0000-0000-000000000001', N'{"status":2}', N'{"status":4}', N'192.168.1.1', CAST(N'2026-08-31T13:59:39.3666667' AS DateTime2), NULL, 1)
INSERT [dbo].[AuditLogs] ([Id], [UserId], [Action], [EntityType], [EntityId], [BeforeState], [AfterState], [IpAddress], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'a1100001-0000-0000-0000-000000000002', N'a1000001-0000-0000-0000-000000000001', N'AstrologerApproved', N'AstrologerProfile', N'b2000001-0000-0000-0000-000000000001', N'{"IsApproved":false}', N'{"IsApproved":true}', N'192.168.1.1', CAST(N'2026-08-31T13:59:39.3666667' AS DateTime2), NULL, 1)
INSERT [dbo].[ContactQueries] ([Id], [Name], [Email], [Phone], [Subject], [Message], [IsResolved], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'59922e90-11a3-476b-8988-55890a22c757', N'ettyyjgdhy', N'timep6735@gmail.com', N'0-99466765645656', N'uurtrhshsrthh', N'evwrrli. uhu aehu hil.arxjyposhrn piv hiuph ivthuxt', 0, CAST(N'2026-09-02T07:44:04.2057970' AS DateTime2), NULL, 1)
INSERT [dbo].[Coupons] ([Id], [Code], [Description], [Type], [Value], [MinOrderValue], [MaxDiscount], [UsageLimit], [UsedCount], [ValidFrom], [ValidTo], [FestivalTag], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'7e3bd200-9eaa-4281-903b-eb788ea939c4', N'23456ASDF', N'arestdyfuglykftjdrhserghtdjyfg', 1, CAST(100.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(999999.00 AS Decimal(18, 2)), 100, 0, CAST(N'2026-09-04T00:00:00.0000000' AS DateTime2), CAST(N'2032-05-04T00:00:00.0000000' AS DateTime2), NULL, CAST(N'2026-09-04T06:22:11.9794570' AS DateTime2), NULL, 1)
INSERT [dbo].[ErrorLogs] ([Id], [Message], [StackTrace], [Source], [RequestPath], [UserId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'e1100001-0000-0000-0000-000000000001', N'Payment gateway timeout', N'at PaymentService.ChargeAsync line 42', N'VadicMall.Api', N'/api/payments/charge', N'a1000001-0000-0000-0000-000000000002', CAST(N'2026-08-31T13:59:39.3866667' AS DateTime2), NULL, 1)
INSERT [dbo].[GiftCards] ([Id], [Code], [Type], [Amount], [Balance], [PurchasedByUserId], [RedeemedByUserId], [ExpiryDate], [Status], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'76b646b8-252c-40b3-9653-08dd2b5391cc', N'VMGCC4FC7243', N'Pooja Gift Card', CAST(10000.00 AS Decimal(18, 2)), CAST(10000.00 AS Decimal(18, 2)), N'fe091691-bce9-44a6-8909-0b6949c390cf', NULL, CAST(N'2027-09-03T08:49:34.0850850' AS DateTime2), N'active', CAST(N'2026-09-03T08:49:34.0850840' AS DateTime2), NULL, 1)
INSERT [dbo].[GiftCards] ([Id], [Code], [Type], [Amount], [Balance], [PurchasedByUserId], [RedeemedByUserId], [ExpiryDate], [Status], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'a2136ad1-4e04-48b7-ad03-0bafaee268be', N'VMGC02AD3852', N'Pooja Gift Card', CAST(10000.00 AS Decimal(18, 2)), CAST(10000.00 AS Decimal(18, 2)), N'fe091691-bce9-44a6-8909-0b6949c390cf', NULL, CAST(N'2027-09-02T07:36:02.0273510' AS DateTime2), N'active', CAST(N'2026-09-02T07:36:02.0270590' AS DateTime2), NULL, 1)
INSERT [dbo].[GiftCards] ([Id], [Code], [Type], [Amount], [Balance], [PurchasedByUserId], [RedeemedByUserId], [ExpiryDate], [Status], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'18715fba-5ec5-49af-8e1c-25a918e3a6b2', N'VMGCEE6BBDCC', N'Pooja Gift Card', CAST(5000.00 AS Decimal(18, 2)), CAST(5000.00 AS Decimal(18, 2)), N'f8e7cb48-c411-4725-b124-971a2854ebc1', NULL, CAST(N'2027-09-02T11:12:35.7510640' AS DateTime2), N'active', CAST(N'2026-09-02T11:12:35.7508170' AS DateTime2), NULL, 1)
INSERT [dbo].[GiftCards] ([Id], [Code], [Type], [Amount], [Balance], [PurchasedByUserId], [RedeemedByUserId], [ExpiryDate], [Status], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'45422ac6-1d29-423f-a722-344b691b0ca2', N'VMGC5A25D0F9', N'Product Gift Card', CAST(10000.00 AS Decimal(18, 2)), CAST(10000.00 AS Decimal(18, 2)), N'fe091691-bce9-44a6-8909-0b6949c390cf', NULL, CAST(N'2027-09-02T07:38:01.1936720' AS DateTime2), N'active', CAST(N'2026-09-02T07:38:01.1936710' AS DateTime2), NULL, 1)
INSERT [dbo].[GiftCards] ([Id], [Code], [Type], [Amount], [Balance], [PurchasedByUserId], [RedeemedByUserId], [ExpiryDate], [Status], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'211b2528-7583-4431-93f0-5a9aaf69f5d4', N'VMGC2285F283', N'Pooja Gift Card', CAST(5000.00 AS Decimal(18, 2)), CAST(5000.00 AS Decimal(18, 2)), N'fe091691-bce9-44a6-8909-0b6949c390cf', NULL, CAST(N'2027-09-02T07:56:01.3862450' AS DateTime2), N'active', CAST(N'2026-09-02T07:56:01.3862440' AS DateTime2), NULL, 1)
INSERT [dbo].[GiftCards] ([Id], [Code], [Type], [Amount], [Balance], [PurchasedByUserId], [RedeemedByUserId], [ExpiryDate], [Status], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'77469977-5ad5-43af-9ff9-7d0a2621be76', N'VMGCDA714B91', N'Product Gift Card', CAST(10000.00 AS Decimal(18, 2)), CAST(10000.00 AS Decimal(18, 2)), N'fe091691-bce9-44a6-8909-0b6949c390cf', NULL, CAST(N'2027-09-02T07:37:38.6099600' AS DateTime2), N'active', CAST(N'2026-09-02T07:37:38.6099590' AS DateTime2), NULL, 1)
INSERT [dbo].[GiftCards] ([Id], [Code], [Type], [Amount], [Balance], [PurchasedByUserId], [RedeemedByUserId], [ExpiryDate], [Status], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'5bb31d90-611f-42bf-bf02-7e9ba94e6887', N'VMGC4975F5E7', N'Pooja Gift Card', CAST(10000.00 AS Decimal(18, 2)), CAST(10000.00 AS Decimal(18, 2)), N'f8e7cb48-c411-4725-b124-971a2854ebc1', NULL, CAST(N'2027-09-03T08:47:35.6476630' AS DateTime2), N'active', CAST(N'2026-09-03T08:47:35.6476630' AS DateTime2), NULL, 1)
INSERT [dbo].[GiftCards] ([Id], [Code], [Type], [Amount], [Balance], [PurchasedByUserId], [RedeemedByUserId], [ExpiryDate], [Status], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'06556998-dcc1-4bca-8747-88b64f109d15', N'VMGC259C9758', N'Pooja Gift Card', CAST(10000.00 AS Decimal(18, 2)), CAST(10000.00 AS Decimal(18, 2)), N'f8e7cb48-c411-4725-b124-971a2854ebc1', NULL, CAST(N'2027-09-03T08:34:14.3722510' AS DateTime2), N'active', CAST(N'2026-09-03T08:34:14.3722500' AS DateTime2), NULL, 1)
INSERT [dbo].[GiftCards] ([Id], [Code], [Type], [Amount], [Balance], [PurchasedByUserId], [RedeemedByUserId], [ExpiryDate], [Status], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'e8295efe-5470-4ff6-8311-8d7df45181e5', N'VMGCA8F896BD', N'Pooja Gift Card', CAST(10000.00 AS Decimal(18, 2)), CAST(10000.00 AS Decimal(18, 2)), N'fe091691-bce9-44a6-8909-0b6949c390cf', NULL, CAST(N'2027-09-02T07:36:16.6950780' AS DateTime2), N'active', CAST(N'2026-09-02T07:36:16.6950770' AS DateTime2), NULL, 1)
INSERT [dbo].[GiftCards] ([Id], [Code], [Type], [Amount], [Balance], [PurchasedByUserId], [RedeemedByUserId], [ExpiryDate], [Status], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'e2b24129-d16e-4e64-b492-b35b6fd857c1', N'VMGC21DB349F', N'Pooja Gift Card', CAST(10000.00 AS Decimal(18, 2)), CAST(10000.00 AS Decimal(18, 2)), N'f8e7cb48-c411-4725-b124-971a2854ebc1', NULL, CAST(N'2027-09-03T08:18:17.4919890' AS DateTime2), N'active', CAST(N'2026-09-03T08:18:17.4917120' AS DateTime2), NULL, 1)
INSERT [dbo].[GiftCards] ([Id], [Code], [Type], [Amount], [Balance], [PurchasedByUserId], [RedeemedByUserId], [ExpiryDate], [Status], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'07678c1f-e599-4c06-b91b-e9d939aaeca5', N'VMGCF9573CA6', N'Pooja Gift Card', CAST(10000.00 AS Decimal(18, 2)), CAST(10000.00 AS Decimal(18, 2)), N'fe091691-bce9-44a6-8909-0b6949c390cf', NULL, CAST(N'2027-09-02T08:41:28.0471940' AS DateTime2), N'active', CAST(N'2026-09-02T08:41:28.0471930' AS DateTime2), NULL, 1)
INSERT [dbo].[GiftCards] ([Id], [Code], [Type], [Amount], [Balance], [PurchasedByUserId], [RedeemedByUserId], [ExpiryDate], [Status], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'af54080c-d406-4ef8-9156-ec7d2d1eb2c9', N'VMGC3F260D07', N'Pooja Gift Card', CAST(5000.00 AS Decimal(18, 2)), CAST(5000.00 AS Decimal(18, 2)), N'fe091691-bce9-44a6-8909-0b6949c390cf', NULL, CAST(N'2027-09-02T07:36:10.4839840' AS DateTime2), N'active', CAST(N'2026-09-02T07:36:10.4839840' AS DateTime2), NULL, 1)
INSERT [dbo].[GiftCards] ([Id], [Code], [Type], [Amount], [Balance], [PurchasedByUserId], [RedeemedByUserId], [ExpiryDate], [Status], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'1fd6033b-9957-4000-b806-f232f6186626', N'VMGC4C2EC83C', N'Product Gift Card', CAST(1000.00 AS Decimal(18, 2)), CAST(1000.00 AS Decimal(18, 2)), N'f8e7cb48-c411-4725-b124-971a2854ebc1', NULL, CAST(N'2027-09-02T08:31:51.7645500' AS DateTime2), N'active', CAST(N'2026-09-02T08:31:51.7643020' AS DateTime2), NULL, 1)
INSERT [dbo].[GiftCards] ([Id], [Code], [Type], [Amount], [Balance], [PurchasedByUserId], [RedeemedByUserId], [ExpiryDate], [Status], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'ad4eb683-e0ad-4903-9804-fbe68d22eae6', N'VMGC1212C5F4', N'Consultation Gift Card', CAST(10000.00 AS Decimal(18, 2)), CAST(10000.00 AS Decimal(18, 2)), N'f8e7cb48-c411-4725-b124-971a2854ebc1', NULL, CAST(N'2027-09-02T09:06:41.8258650' AS DateTime2), N'active', CAST(N'2026-09-02T09:06:41.8255570' AS DateTime2), NULL, 1)
INSERT [dbo].[KundliRequests] ([Id], [UserId], [Name], [DateOfBirth], [TimeOfBirth], [PlaceOfBirth], [Gender], [Status], [Amount], [ReportUrl], [AssignedAstrologerId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'82b9af06-08c7-4600-9fd3-12d323712c0c', N'fe091691-bce9-44a6-8909-0b6949c390cf', N'wertyuio', CAST(N'2026-10-01T00:00:00.0000000' AS DateTime2), N'19:07', N'temp temp', N'male', 1, CAST(499.00 AS Decimal(18, 2)), NULL, NULL, CAST(N'2026-09-02T07:31:50.4130020' AS DateTime2), NULL, 1)
INSERT [dbo].[KundliRequests] ([Id], [UserId], [Name], [DateOfBirth], [TimeOfBirth], [PlaceOfBirth], [Gender], [Status], [Amount], [ReportUrl], [AssignedAstrologerId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'1b4e76bc-df83-41a9-98a7-717b9ad01b0d', N'fe091691-bce9-44a6-8909-0b6949c390cf', N'detail', CAST(N'2026-10-07T00:00:00.0000000' AS DateTime2), N'13:24', N'detail', N'male', 1, CAST(999.00 AS Decimal(18, 2)), NULL, NULL, CAST(N'2026-09-02T07:49:19.2620890' AS DateTime2), NULL, 1)
INSERT [dbo].[KundliRequests] ([Id], [UserId], [Name], [DateOfBirth], [TimeOfBirth], [PlaceOfBirth], [Gender], [Status], [Amount], [ReportUrl], [AssignedAstrologerId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'abe3e04f-7260-4b67-a208-8510db097293', N'fe091691-bce9-44a6-8909-0b6949c390cf', N'ruyieyiru', CAST(N'2026-09-10T00:00:00.0000000' AS DateTime2), N'17:22', N'euywrtyggyelwy', N'male', 1, CAST(999.00 AS Decimal(18, 2)), NULL, NULL, CAST(N'2026-09-02T07:48:12.1705610' AS DateTime2), NULL, 1)
INSERT [dbo].[KundliRequests] ([Id], [UserId], [Name], [DateOfBirth], [TimeOfBirth], [PlaceOfBirth], [Gender], [Status], [Amount], [ReportUrl], [AssignedAstrologerId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'c6c25af1-c2f7-462c-841f-a8e2c8f33f8a', N'fe091691-bce9-44a6-8909-0b6949c390cf', N'pro', CAST(N'2026-10-01T00:00:00.0000000' AS DateTime2), N'16:21', N'pro', N'female', 1, CAST(1999.00 AS Decimal(18, 2)), NULL, NULL, CAST(N'2026-09-02T07:49:53.1195890' AS DateTime2), NULL, 1)
INSERT [dbo].[KundliRequests] ([Id], [UserId], [Name], [DateOfBirth], [TimeOfBirth], [PlaceOfBirth], [Gender], [Status], [Amount], [ReportUrl], [AssignedAstrologerId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'5f73d779-20bd-4a98-9aca-c45086c53fef', N'fe091691-bce9-44a6-8909-0b6949c390cf', N'srtr', CAST(N'2026-09-03T00:00:00.0000000' AS DateTime2), N'19:02', N'temp temp', N'male', 1, CAST(499.00 AS Decimal(18, 2)), NULL, NULL, CAST(N'2026-09-02T07:31:08.0332420' AS DateTime2), NULL, 1)
INSERT [dbo].[KundliRequests] ([Id], [UserId], [Name], [DateOfBirth], [TimeOfBirth], [PlaceOfBirth], [Gender], [Status], [Amount], [ReportUrl], [AssignedAstrologerId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'fd967b0a-a8f9-44f1-b3da-e74c19364b79', N'fe091691-bce9-44a6-8909-0b6949c390cf', N'basic', CAST(N'2026-10-01T00:00:00.0000000' AS DateTime2), N'19:24', N'basic', N'female', 1, CAST(499.00 AS Decimal(18, 2)), NULL, NULL, CAST(N'2026-09-02T07:48:51.8618560' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'89b13978-53d0-4d7e-9772-00e58c3c3ae9', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-03T12:18:00.8683340' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'dbf9ea20-3f65-4019-95d1-014503f956f2', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'127.0.0.1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', NULL, CAST(N'2026-08-31T16:27:32.4746160' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'e39d3b9f-769b-4a20-8f5a-018595d1a3bb', NULL, N'popup.test.astro@example.com', 0, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', N'Astrologer not approved', CAST(N'2026-09-02T09:42:33.2390950' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'3deb441c-5b17-42e3-8e8a-02a7a4ca23db', NULL, N'pending.astro.test@example.com', 0, N'::1', N'curl/8.7.1', N'Account deactivated', CAST(N'2026-09-02T09:38:49.0247890' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'741fb3a7-40d1-40fb-9c68-02c29aaa51a0', NULL, N'integration.test@example.com', 0, N'127.0.0.1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', N'Invalid credentials', CAST(N'2026-08-31T16:33:34.1212660' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'92436944-abce-4d72-867d-02d596a7e8ce', N'737f7d7f-e179-4a04-943a-41a4f05bc110', N'prodmgr@test.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-04T06:16:56.0017440' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'78b9f234-5bbe-4641-b188-03004a30c8a9', NULL, N'ldjhyffldyf@gmail.comm', 0, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', N'Astrologer not approved', CAST(N'2026-09-02T09:39:43.0347730' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'98e1f2cf-a0dd-4727-af85-04d508b8a6e4', NULL, N'ldjhyffldyf@gmail.comm', 0, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', N'Your request is currently pending. You cannot log in yet because your account has not been approved by the admin. Please contact the administrator for further assistance.', CAST(N'2026-09-03T10:23:29.9818220' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'89cc83b6-50b8-4c0a-8c43-0b60bb7afaba', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-02T08:42:12.8270130' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'5977bc3e-f725-4bf0-be5d-0e5238af2f6f', N'bd264441-605c-4e63-8f14-593d3e922da7', N'test.pandit.verify@example.com', 1, N'::1', N'curl/8.7.1', NULL, CAST(N'2026-09-02T09:31:38.4151360' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'c40c0a31-8b7e-49ff-ba0d-0e976f58bfc6', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-03T11:53:09.6167670' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'5fde80d6-af18-4caf-9809-0fdb24bdcc6a', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'127.0.0.1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.0.0 Safari/537.36', NULL, CAST(N'2026-08-31T16:37:03.4746440' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'a3dd0ad8-6295-42d5-88da-103523f4958c', NULL, N'admin@vedicastro.com', 0, N'127.0.0.1', N'curl/8.7.1', N'Invalid credentials', CAST(N'2026-08-31T15:48:17.4949890' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'bef1af23-28e5-403d-9c48-117aae238ea3', NULL, N'ldjhyffldyf@gmail.comm', 0, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', N'Your request is currently pending. You cannot log in yet because your account has not been approved by the admin. Please contact the administrator for further assistance.', CAST(N'2026-09-03T08:09:23.8732530' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'bd0ac73c-0423-41de-896a-12d8a524d9dc', NULL, N'admin@vedicastro.com', 0, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', N'Invalid credentials', CAST(N'2026-08-31T15:42:41.5520090' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'3e395e79-6f44-4caf-87d5-17adb8e4242e', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'curl/8.7.1', NULL, CAST(N'2026-09-02T11:54:11.1717910' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'eff0e046-6a6e-438c-ae17-187c6f74497a', NULL, N'ldjhyffldyf@gmail.comm', 0, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', N'Your request is currently pending. You cannot log in yet because your account has not been approved by the admin. Please contact the administrator for further assistance.', CAST(N'2026-09-02T11:41:25.0920230' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'c58865de-b922-4102-a2d3-1a1b05d71275', NULL, N'ldjhyffldyf@gmail.comm', 0, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', N'Your request is currently pending. You cannot log in yet because your account has not been approved by the admin. Please contact the administrator for further assistance.', CAST(N'2026-09-02T11:12:11.4119900' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'80306fd2-7b8d-4837-b777-1a54d1a73ed5', N'bd264441-605c-4e63-8f14-593d3e922da7', N'test.pandit.verify@example.com', 1, N'::1', N'curl/8.7.1', NULL, CAST(N'2026-09-02T09:29:30.8642580' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'0e76a1f3-dde3-4891-9d67-1a9ae6cb02dc', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-03T09:28:43.6574660' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'09e51b65-d65c-486c-bb1d-1bf01a44d153', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'ldjhyffldyf@gmail.comm', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-02T11:06:39.8790750' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'81fafe3b-892a-4dda-800a-1ddfa77c0ce4', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'curl/8.7.1', NULL, CAST(N'2026-09-02T11:15:38.6779730' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'2275eae6-2736-49d8-b7f1-1eba2d5432c3', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-02T08:49:59.2722810' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'ca0490d1-d985-49d9-a659-1ed6fbc8fce7', NULL, N'ldjhyffldyf@gmail.comm', 0, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', N'Astrologer not approved', CAST(N'2026-09-02T09:39:44.6073500' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'0d689819-dabc-48b1-9f86-20eaf0270bdd', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-02T12:33:14.4885970' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'3678cead-ffef-4821-a892-233faebfe595', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-02T12:00:19.5494880' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'6107bbbc-f50f-4bdf-81b5-27886a70c1d1', NULL, N'customer@vadicmall.com', 0, N'127.0.0.1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', N'Invalid credentials', CAST(N'2026-08-31T16:33:03.4294300' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'00633c4b-f660-41b7-8d57-27b7436ece0f', N'0e2acdb6-a4e3-48e1-b83d-07078d7bed11', N'staffmember@test.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-03T11:29:44.2395600' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'c7762e6d-91cf-4d00-913f-283db7e71e13', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'127.0.0.1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.0.0 Safari/537.36', NULL, CAST(N'2026-08-31T16:36:37.3353560' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'09f3b010-80bc-409f-8a3a-28d2632c63f6', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'127.0.0.1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.0.0 Safari/537.36', NULL, CAST(N'2026-08-31T16:29:03.1490230' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'97077a8f-3c6b-43a9-819f-29c21a1f3338', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'ldjhyffldyf@gmail.comm', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-02T11:12:20.2302530' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'29587150-4560-4b58-9199-2b8d06098174', NULL, N'customer@vadicmall.com', 0, N'127.0.0.1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', N'Invalid credentials', CAST(N'2026-08-31T16:33:11.9776040' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'cc877b2a-5072-4262-9ee6-2c14749e3952', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-03T11:29:10.3796040' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'a6dd6aa7-7ec5-47e5-b599-2d3f3880af2e', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'ldjhyffldyf@gmail.comm', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-03T10:10:18.7910650' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'716eeee6-20a2-431b-9701-2e8404db8feb', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'curl/8.7.1', NULL, CAST(N'2026-09-02T09:29:09.8103350' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'534fc71b-fc95-491e-8b6f-2fc1b6044763', N'6db17a08-f47f-4cf0-86ae-b6b1c5237c1c', N'toast.test.astro@example.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-02T10:35:06.1773940' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'f352f0c1-b79e-43c3-93c0-30490471ae3c', NULL, N'ldjhyffldyf@gmail.comm', 0, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', N'Astrologer not approved', CAST(N'2026-09-02T09:39:44.2894300' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'71f7a8e7-b127-4767-a22f-30881ca42721', NULL, N'active.astro@example.com', 0, N'::1', N'curl/8.7.1', N'Your account has been deactivated by the administrator. Please contact the administrator for further assistance.', CAST(N'2026-09-02T10:03:00.5046510' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'd495c175-401d-440d-b3a3-32b653cfa4a2', N'37073ee0-5cee-4eaf-9f26-09aee0d02f60', N'rajmarothiai@gmail.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-06T08:56:33.3506050' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'cbdc8a69-c290-47d3-855a-33ba2220e804', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'curl/8.7.1', NULL, CAST(N'2026-09-02T08:31:43.7740350' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'48af4e85-8544-46e2-82a4-37f8de29f88a', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-02T11:08:27.4707520' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'bf7a2a55-37d7-4ad1-835c-38b607785e9d', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-03T11:04:18.3218260' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'07f200c9-a8c5-42d4-b80b-3975b357dbdc', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-02T11:11:33.4465590' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'668e4b22-4bc4-40b5-8657-39bb06302467', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-02T08:52:38.5974910' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'edda0afd-bfbb-42ba-9627-3c990bcb02cb', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'127.0.0.1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-02T07:07:18.3497440' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'b16b711d-784d-4b29-8c1f-3e1d99897d23', NULL, N'ldjhyffldyf@gmail.comm', 0, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', N'Astrologer not approved', CAST(N'2026-09-02T09:39:42.3736090' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'efe4dcc7-22eb-458b-8de7-41af7896744f', NULL, N'ldjhyffldyf@gmail.comm', 0, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', N'Your request is currently pending. You cannot log in yet because your account has not been approved by the admin. Please contact the administrator for further assistance.', CAST(N'2026-09-02T11:59:39.5394410' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'69e0dc06-65b2-4461-9d09-4278fa221ea9', NULL, N'admin@vedicastro.com', 0, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', N'Invalid credentials', CAST(N'2026-08-31T15:42:28.4131400' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'14c569af-24da-4496-a64f-44468109816b', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-04T05:57:04.4540090' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'3dd8caef-e4a5-4a42-89b8-4bf883337bc3', N'fe091691-bce9-44a6-8909-0b6949c390cf', N'ashok234@gmail.com', 1, N'127.0.0.1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-02T07:16:03.0557270' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'79514b1b-16b4-40f2-b345-4d0a59e67c38', NULL, N'ldjhyffldyf@gmail.comm', 0, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', N'Astrologer not approved', CAST(N'2026-09-02T09:39:43.6568540' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'314a72cf-d628-4f2a-8a33-4d4e6b1ec8e9', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'curl/8.7.1', NULL, CAST(N'2026-09-02T08:31:07.7736730' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'3242ca11-300b-47d9-981a-4e728be39046', N'8418ab30-00e9-49f0-b3b0-8850d5f08277', N'dashboard.demo@example.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-02T10:04:28.9071560' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'976a4162-95a6-4e14-9d57-4eb50ba259e7', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-03T10:22:00.7773890' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'4524f8d0-5fa5-4a3d-a49b-4f7d02d58a6f', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'ldjhyffldyf@gmail.comm', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-02T11:58:57.8361380' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'b59623a3-e980-4503-bc43-5073c959d842', NULL, N'pending.astro.test@example.com', 0, N'::1', N'curl/8.7.1', N'Astrologer not approved', CAST(N'2026-09-02T09:38:34.2986060' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'86f6abe3-357d-4c9d-9780-53260bbfa062', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'ldjhyffldyf@gmail.comm', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-02T11:41:32.1506820' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'4284653b-20bc-4b1e-9c6b-563355c90353', NULL, N'ldjhyffldyf@gmail.comm', 0, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', N'Your request is currently pending. You cannot log in yet because your account has not been approved by the admin. Please contact the administrator for further assistance.', CAST(N'2026-09-02T11:12:08.4757820' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'c169aeee-6629-4aa4-976b-565c97867d12', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-02T12:55:04.8778250' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'df7c0403-9e50-4276-8a41-565cf5f4b3e7', N'737f7d7f-e179-4a04-943a-41a4f05bc110', N'prodmgr@test.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-04T06:17:11.1495030' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'0e791999-285d-456f-a37b-580a71b1b3a6', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'127.0.0.1', N'curl/8.7.1', NULL, CAST(N'2026-08-31T15:49:22.4723940' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'fbe6da4b-0191-42be-acb8-581221f04e1f', NULL, N'aasdfghjk@gmail.com', 0, N'127.0.0.1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', N'Invalid credentials', CAST(N'2026-09-02T07:11:29.8846800' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'c9f07723-5c9a-4eeb-99ed-599e0f56128b', NULL, N'ldjhyffldyf@gmail.comm', 0, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', N'Astrologer not approved', CAST(N'2026-09-02T09:39:43.9673980' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'4bcf2ea5-f2d9-44b4-ad41-5c05e59cfc4e', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-02T09:37:46.7683640' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'b2170f66-95dd-4d2f-ba62-5ff2741b60e8', NULL, N'admin@vedicastro.com', 0, N'::1', N'Mozilla/5.0 (Linux; Android 8.0.0; SM-G955U Build/R16NW) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', N'Invalid credentials', CAST(N'2026-08-31T15:42:50.3726610' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'7eb02d42-6522-4e1a-aea3-62fe22f988fa', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'ldjhyffldyf@gmail.comm', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-02T09:37:30.8922120' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'1f82b311-8139-4eeb-84b5-630261efa8f8', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'ldjhyffldyf@gmail.comm', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-02T11:07:47.4018300' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'3f98cff5-4a9f-427e-ac3d-6485607f261d', N'737f7d7f-e179-4a04-943a-41a4f05bc110', N'prodmgr@test.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-04T06:14:57.0577400' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'ee1e9c23-983c-4150-9033-69f77f39a9ce', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'curl/8.7.1', NULL, CAST(N'2026-09-02T11:47:55.0689830' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'3d88498c-cb71-4618-9bf7-6a31c753c390', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-02T11:57:08.4948100' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'553775af-9135-429d-84a6-6bc8e1df18df', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'127.0.0.1', N'Mozilla/5.0 (Linux; Android 8.0.0; SM-G955U Build/R16NW) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', NULL, CAST(N'2026-08-31T16:29:03.3001000' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'a29d0b8b-3b5c-4777-bb2c-6c00fc21d408', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-04T05:54:24.1264770' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'd6bb01e9-94a5-4a03-8c3d-6db0f2dbfae7', N'fe091691-bce9-44a6-8909-0b6949c390cf', N'ashok234@gmail.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-03T10:29:53.6706660' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'fb9ca87c-0a80-4987-b0c1-6fe4036aa437', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'127.0.0.1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.0.0 Safari/537.36', NULL, CAST(N'2026-08-31T16:28:24.4368230' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'315a6302-a118-4d5b-9c37-732303a54dfb', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'ldjhyffldyf@gmail.comm', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-02T10:25:06.6262020' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'7bba44ec-3f79-4145-86f9-74b15d73fba6', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-02T08:50:32.1110180' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'a2808e6a-9e6e-41f9-968b-74c2011aa046', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-03T12:16:21.4364440' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'f4367878-1fa9-4998-bb6e-76ec18a6347a', NULL, N'admin@vedicastro.com', 0, N'127.0.0.1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', N'Invalid credentials', CAST(N'2026-08-31T15:49:35.0773690' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'ffedaa7a-4e45-4a63-99b1-76ff80449127', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-06T08:57:31.4882990' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'495514bd-53d1-4a96-9a2c-7718f352b360', NULL, N'ldjhyffldyf@gmail.comm', 0, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', N'Astrologer not approved', CAST(N'2026-09-02T09:39:47.5316640' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'31694ad1-2d3c-4e28-8063-7764ff85f17d', NULL, N'ldjhyffldyf@gmail.comm', 0, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', N'Your request is currently pending. You cannot log in yet because your account has not been approved by the admin. Please contact the administrator for further assistance.', CAST(N'2026-09-02T11:58:06.6247850' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'1a1dc867-2c01-4948-9b27-78219766ef0f', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-02T10:23:23.1270750' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'647050ed-0f6b-43df-ad2a-783e1a218432', NULL, N'admin@vedicastro.com', 0, N'127.0.0.1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', N'Invalid credentials', CAST(N'2026-08-31T15:47:10.1892380' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'b2876cea-9dd6-4fae-8bce-78473073016f', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-02T09:33:40.6089960' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'2ca0850f-89a1-462f-a7e8-78c6f10d2b78', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-02T11:59:48.3323430' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'0e5d2f17-dcb6-4463-8732-7a64a97fbe50', NULL, N'pending.astro.test@example.com', 0, N'::1', N'curl/8.7.1', N'Account deactivated', CAST(N'2026-09-02T09:39:00.5153970' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'bc3495e8-72ec-4774-b63f-7a7e3b91bc1c', N'fe091691-bce9-44a6-8909-0b6949c390cf', N'ashok234@gmail.com', 1, N'127.0.0.1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-02T07:22:04.4497350' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'bcb5b148-d3b1-4621-962e-7c9b1120186b', N'1862396a-90a5-434b-9239-6a9be8efff05', N'pending.astro.test@example.com', 1, N'::1', N'curl/8.7.1', NULL, CAST(N'2026-09-02T09:39:11.1257290' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'8b2f6ccc-5ced-4147-9124-7dd73aafe22e', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'127.0.0.1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-02T07:20:50.9165490' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'f92f4848-7864-4b0b-bcc0-7e8931bbf6c2', NULL, N'admin@vedicastro.com', 0, N'127.0.0.1', N'Mozilla/5.0 (Linux; Android 8.0.0; SM-G955U Build/R16NW) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Mobile Safari/537.36', N'Invalid credentials', CAST(N'2026-08-31T15:53:42.3157340' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'2a7b6b28-37c0-4943-9757-80ce7c9efc28', NULL, N'ldjhyffldyf@gmail.comm', 0, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', N'Astrologer not approved', CAST(N'2026-09-02T09:39:36.2966860' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'f2d024a5-926e-4659-8e02-811dd3dfe00d', N'b6ecea28-f831-45b9-937e-cdc3f9882b9a', N'active.astro@example.com', 1, N'::1', N'curl/8.7.1', NULL, CAST(N'2026-09-02T10:02:49.5245640' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'ef8c3e1c-9276-488b-891c-81523348274e', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-02T11:58:42.7396080' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'bde93746-23b3-4d89-ae94-82502c322e60', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-02T11:23:34.1983490' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'6643575d-5c7d-4e4e-80b8-82e32fca28f8', NULL, N'ldjhyffldyf@gmail.comm', 0, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', N'Your request is currently pending. You cannot log in yet because your account has not been approved by the admin. Please contact the administrator for further assistance.', CAST(N'2026-09-02T11:08:49.3728210' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'4dcfc7e7-217c-40d7-b34f-842071512cf5', NULL, N'ldjhyffldyf@gmail.comm', 0, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', N'Astrologer not approved', CAST(N'2026-09-02T09:39:43.3348370' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'fea92743-03dc-480e-8a55-86ff081e07bc', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-02T12:34:50.6904750' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'33114bf7-5269-4b9b-b446-872ac9b29275', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-03T08:09:09.0651000' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'5ef59d84-c12a-4534-bfcb-88bafdc5c46a', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-02T11:41:04.8333500' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'5c261383-72d2-4070-b29a-88cbfa7e0672', N'0e2acdb6-a4e3-48e1-b83d-07078d7bed11', N'staffmember@test.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-03T11:29:19.1778210' AS DateTime2), NULL, 1)
GO
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'201a94ca-efdc-4b5e-942e-8c37c046149c', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'127.0.0.1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-02T07:23:42.7009600' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'ad2cabdd-8b5b-4556-9cec-8dbdecb1d57b', NULL, N'pending.astro.test@example.com', 0, N'::1', N'curl/8.7.1', N'Astrologer not approved', CAST(N'2026-09-02T09:38:48.2975950' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'66de230b-c505-4651-87bc-8f6056f13a70', N'c6f4f66e-4f5a-48de-8875-c5039d247ac1', N'sdfghj@gmail.com', 1, N'127.0.0.1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-02T07:13:35.0241750' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'5928d8b2-e385-4356-a80e-8fc3626b8a98', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-04T06:19:30.5987590' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'cb716e13-5a07-4aea-8203-8fca31d43db9', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-04T05:57:51.8397110' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'b157151e-41e6-469e-a71c-9500f2c100ea', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-02T09:16:55.4346070' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'7507480d-e58f-4e9f-abda-95b5f926ada2', N'319f7b65-a56f-4b56-bb6b-a442bf8e946a', N'staffmember2@test.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-03T12:17:55.6209430' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'290f6ce0-1e14-4169-b1be-99482591cacc', NULL, N'customer@vadicmall.com', 0, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', N'Invalid credentials', CAST(N'2026-09-02T08:50:39.0335270' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'acb66b69-24ef-4a17-9c9d-99e9bdec978c', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-02T10:24:53.7368860' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'64012d64-e734-4b8d-9c85-9c2c8c8ed90c', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-02T12:00:25.0562100' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'9831d0f5-cfa7-4557-abb3-9ec4239fe58e', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'curl/8.7.1', NULL, CAST(N'2026-09-02T12:23:08.4625560' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'30b14d22-f1bc-4523-baf5-9f843548d81a', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-02T09:43:39.8882780' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'ca272127-810e-4e38-a71d-a23a5820f306', NULL, N'ldjhyffldyf@gmail.comm', 0, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', N'Astrologer not approved', CAST(N'2026-09-02T09:39:50.6175350' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'39f45079-5ec3-49c4-89ef-a4b8533f910e', N'4a67350d-cbe4-40e8-a68b-ff18d635b83b', N'pw-astro-1788341617855@example.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-02T09:33:47.9427290' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'8971f0d4-5400-48bd-b282-a4ca3483a483', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'ldjhyffldyf@gmail.comm', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-03T08:09:28.9313500' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'20c4c8cd-857c-403d-8763-a56716bc7258', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'ldjhyffldyf@gmail.comm', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-03T10:23:42.1015020' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'68a4964d-a359-4b70-a6a7-a876c4a5c6af', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'ldjhyffldyf@gmail.comm', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-02T09:44:06.8692700' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'a88757f8-9fd5-4dc0-b330-a8c65e90c451', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'127.0.0.1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', NULL, CAST(N'2026-08-31T15:59:07.6200980' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'aecca8c7-1800-49df-8461-a8eb8f08a22a', NULL, N'integration.test@example.com', 0, N'127.0.0.1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', N'Invalid credentials', CAST(N'2026-08-31T16:33:28.6453200' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'21b0eee4-3afb-4d63-9aad-aada1587c03e', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-06T08:55:46.0086430' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'144dcefb-fa3d-4dfe-9754-ab025c20216c', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'127.0.0.1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', NULL, CAST(N'2026-08-31T15:50:03.1433770' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'ea01c2a3-fd84-4a64-a4f7-ab273cd5b336', NULL, N'integration.test@example.com', 0, N'127.0.0.1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', N'Invalid credentials', CAST(N'2026-08-31T16:33:42.2302570' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'5860a0df-0168-4aa4-8819-ab53623da818', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'curl/8.7.1', NULL, CAST(N'2026-09-02T09:38:33.0048310' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'898f3a5d-5982-4053-a727-ac46ea2cfcf5', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-02T11:22:55.6435170' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'f7100f88-522e-417c-ab81-ac4cf25d25b3', N'e3aed431-61c0-4a2b-80a3-ba8137187b9e', N'session.test.astro@example.com', 1, N'::1', N'curl/8.7.1', NULL, CAST(N'2026-09-02T10:03:28.7854020' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'e0b208fe-6f54-46f1-9155-ad38748b62a2', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'curl/8.7.1', NULL, CAST(N'2026-09-02T10:02:48.0621190' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'98e89f84-15af-435a-b32c-ad800231da3c', N'0e2acdb6-a4e3-48e1-b83d-07078d7bed11', N'staffmember@test.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-03T11:30:10.9354820' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'aea394bc-c07d-40be-93c5-ad917164ee28', N'319f7b65-a56f-4b56-bb6b-a442bf8e946a', N'staffmember2@test.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-03T12:16:16.0841850' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'f9c5b701-923d-4cc5-ab69-aee06706b369', NULL, N'ldjhyffldyf@gmail.comm', 0, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', N'Your request is currently pending. You cannot log in yet because your account has not been approved by the admin. Please contact the administrator for further assistance.', CAST(N'2026-09-02T11:58:23.8157170' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'3f98ce52-d328-4b14-9a2a-b2471f050195', N'fe091691-bce9-44a6-8909-0b6949c390cf', N'ashok234@gmail.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-03T11:31:55.6901040' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'0a6e786c-77e5-47d0-b070-b4bb754ebac5', N'fe091691-bce9-44a6-8909-0b6949c390cf', N'ashok234@gmail.com', 1, N'127.0.0.1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-02T07:30:31.3803400' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'ba590001-dff2-4f42-bb75-b4e7d40a3d75', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'curl/8.7.1', NULL, CAST(N'2026-09-02T09:42:10.3467480' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'629c1401-85d4-4368-861e-b9aabac97dfb', N'fe091691-bce9-44a6-8909-0b6949c390cf', N'ashok234@gmail.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-04T06:06:20.3147800' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'11c34159-7ffa-437e-9c73-b9f14cf320cf', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-02T12:36:42.5286570' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'98f18540-edd2-492d-821e-c01efa18aebb', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-02T11:11:52.9937890' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'9a6b7e11-3241-45e8-bad0-c0de968aba96', N'fe091691-bce9-44a6-8909-0b6949c390cf', N'ashok234@gmail.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-03T08:47:51.4714450' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'9c91723b-bacc-4cd2-8007-c15ac496e09e', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-02T11:06:46.6557130' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'ec4c6dcc-8f94-44aa-bc9f-c2cb1b4b5293', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'127.0.0.1', N'curl/8.7.1', NULL, CAST(N'2026-08-31T16:16:34.7684910' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'9c207399-820a-4d79-92d3-c73b1d4b8086', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'ldjhyffldyf@gmail.comm', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-02T09:30:23.2247820' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'772a92c7-c755-49c0-a053-c77c8e700cb0', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-02T11:20:16.2006020' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'06fd147f-601c-47d3-848c-c8d265673477', NULL, N'ldjhyffldyf@gmail.comm', 0, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', N'Astrologer not approved', CAST(N'2026-09-02T09:39:42.6974140' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'30be2ef5-6e9c-456b-96ea-ced47cf1b967', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-02T09:11:00.7492320' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'2069141e-c44c-4de1-8824-d1891f1a4d2f', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'ldjhyffldyf@gmail.comm', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-02T09:36:59.6382640' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'21432ba4-7534-4158-a8a7-d287bf8b393b', N'737f7d7f-e179-4a04-943a-41a4f05bc110', N'prodmgr@test.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-04T06:15:18.8485820' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'064ee11a-8e77-4043-82a8-d49c1afc012b', N'1862396a-90a5-434b-9239-6a9be8efff05', N'pending.astro.test@example.com', 1, N'::1', N'curl/8.7.1', NULL, CAST(N'2026-09-02T09:38:48.7892290' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'101a2ac0-1510-4597-ac68-d4ca7fddf38a', NULL, N'ldjhyffldyf@gmail.comm', 0, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', N'Astrologer not approved', CAST(N'2026-09-02T09:39:50.9423300' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'94664199-a260-4c3d-9778-d6d6a6f4f527', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-04T06:27:25.6081500' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'b81e8b2c-3c38-443d-8549-d7583645a456', NULL, N'aasdfghjk3453@gmail.com', 0, N'127.0.0.1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', N'Invalid credentials', CAST(N'2026-09-02T07:11:39.6751980' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'f79f1420-26ec-40e5-9542-d77f2f305cc5', NULL, N'ldjhyffldyf@gmail.comm', 0, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', N'Your request is currently pending. You cannot log in yet because your account has not been approved by the admin. Please contact the administrator for further assistance.', CAST(N'2026-09-02T11:57:51.7572320' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'9e9584e7-f169-413d-b803-da33240c888b', N'fe091691-bce9-44a6-8909-0b6949c390cf', N'ashok234@gmail.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-04T06:20:01.8394120' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'a23806f6-1d74-4f05-b2d5-da4b0f0ee797', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-06T09:08:29.3485740' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'6ce9bcf5-f526-4d49-89f3-dc32fddc8995', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-04T06:14:50.4139040' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'4a40725c-c59a-4558-9056-e014894d9249', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-03T11:30:04.1615900' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'2bd08d00-1bfd-49e6-a47b-e063cc603455', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'ldjhyffldyf@gmail.comm', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-02T11:59:47.3836110' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'bf2738ed-b201-4e4f-9cb0-e552fcc74ebc', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-03T11:30:31.5037720' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'89b4682e-2c00-4fb2-aa45-e590f37d754b', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-03T11:31:50.5409790' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'e914df58-23be-4968-94c8-e66c4b1c5951', NULL, N'customer@vadicmall.com', 0, N'127.0.0.1', N'curl/8.7.1', N'Invalid credentials', CAST(N'2026-08-31T16:17:20.5483860' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'58a15428-9cba-473a-905f-ec120a039d0b', N'fe091691-bce9-44a6-8909-0b6949c390cf', N'ashok234@gmail.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-03T11:36:56.0245720' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'33069d38-5a57-4bd2-b300-eed0d246cc63', NULL, N'ldjhyffldyf@gmail.comm', 0, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', N'Astrologer not approved', CAST(N'2026-09-02T09:43:07.2444620' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'1bc6c4c6-c694-4a1b-a768-ef7913b5b703', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-04T06:06:26.9624500' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'164118de-5bc1-4ebd-9d77-f2b533843c18', N'fe091691-bce9-44a6-8909-0b6949c390cf', N'ashok234@gmail.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-04T05:57:38.1214110' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'25cb1e5b-1174-4646-b874-f2cd41c45709', NULL, N'pending.astro.test@example.com', 0, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', N'Astrologer not approved', CAST(N'2026-09-02T09:39:56.2570710' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'632f72e1-046b-40fb-bc75-f38e2f95950d', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-03T09:28:18.1985230' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'653a6c11-1f48-4031-adb8-f40a469c25cb', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-04T06:27:05.0771730' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'1dd1fd8d-999d-481a-b2fa-f449da2ed742', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'curl/8.7.1', NULL, CAST(N'2026-09-02T10:34:33.5428030' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'7fd777bd-a6c0-403d-bd36-f44f65638612', NULL, N'ldjhyffldyf@gmail.comm', 0, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', N'Your request is currently pending. You cannot log in yet because your account has not been approved by the admin. Please contact the administrator for further assistance.', CAST(N'2026-09-02T11:58:48.1645050' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'b59b2ef4-2447-406d-8c3a-f5eb847e78d3', N'319f7b65-a56f-4b56-bb6b-a442bf8e946a', N'staffmember2@test.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-04T05:54:19.1723180' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'99a4ce69-6710-427c-9781-f62ae238e0c6', NULL, N'active.astro@example.com', 0, N'::1', N'curl/8.7.1', N'Your account has been deactivated by the administrator. Please contact the administrator for further assistance.', CAST(N'2026-09-02T10:03:11.8146280' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'509b25d4-afa1-44c2-8ab9-f6a8b051be87', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/151.0.7922.34 Safari/537.36', NULL, CAST(N'2026-09-02T11:16:07.8081450' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'9864f0e1-54ea-417a-afe9-f6edfc80fe6d', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'curl/8.7.1', NULL, CAST(N'2026-09-02T08:58:44.8471690' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'be6a5cb2-4813-4952-8ab6-f9c244de9bb2', NULL, N'ldjhyffldyf@gmail.comm', 0, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', N'Astrologer not approved', CAST(N'2026-09-02T09:43:11.1013320' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'fec64482-08ab-460f-a3ef-f9fba1879451', NULL, N'ldjhyffldyf@gmail.comm', 0, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', N'Your request is currently pending. You cannot log in yet because your account has not been approved by the admin. Please contact the administrator for further assistance.', CAST(N'2026-09-02T11:58:14.2638180' AS DateTime2), NULL, 1)
INSERT [dbo].[LoginLogs] ([Id], [UserId], [Email], [Success], [IpAddress], [UserAgent], [FailureReason], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'c49a23ba-7c59-41b3-b1dd-fcfe4e8f2317', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', 1, N'::1', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36', NULL, CAST(N'2026-09-02T08:44:25.7669500' AS DateTime2), NULL, 1)
INSERT [dbo].[NewsletterSubscribers] ([Id], [Email], [IsConfirmed], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'aa91a186-558f-448d-b211-1dcd3ede60fd', N'timep6735@gmail.com', 0, CAST(N'2026-09-02T07:39:14.5379160' AS DateTime2), NULL, 1)
INSERT [dbo].[NewsletterSubscribers] ([Id], [Email], [IsConfirmed], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'ac6fb019-f632-432d-9550-8c7f057c3dd5', N'oooooooooo@gmail.com', 0, CAST(N'2026-09-02T07:53:11.4227700' AS DateTime2), NULL, 1)
INSERT [dbo].[NewsletterSubscribers] ([Id], [Email], [IsConfirmed], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'24efff8b-6c37-4e0f-8eaa-dfd2ba30dffc', N'integration.test@example.com', 0, CAST(N'2026-08-31T16:18:01.4420990' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'a8b6d490-1328-4dc3-abf9-06767774c364', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'Gift Card Purchased', N'Your Pooja Gift Card worth ₹10,000 is ready. Code: VMGC4975F5E7', N'giftcard', 1, N'/gift-cards', CAST(N'2026-09-03T08:47:35.6494080' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'76384847-a8bd-4534-9f3b-16fcdbd20295', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'Gift Card Purchased', N'Your Pooja Gift Card worth ₹10,000 is ready. Code: VMGC259C9758', N'giftcard', 1, N'/gift-cards', CAST(N'2026-09-03T08:34:14.3725130' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'a75c109e-670a-4b75-881d-1aa63f81a8ed', N'37073ee0-5cee-4eaf-9f26-09aee0d02f60', N'Order Status Updated', N'Your order VM202609062395 is now Shipped.', N'order', 1, N'/customer/orders/a24d6d6a-c6da-4e17-85a4-a65f5d433ba3', CAST(N'2026-09-06T08:56:22.9681100' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'8be18201-7d14-420e-a932-1b6171a92c83', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'Astrologer Application Approved', N'Congratulations! Your astrologer profile has been verified and is now visible to customers.', N'astrologer_approval', 0, N'/astrologers', CAST(N'2026-09-03T10:23:39.4527000' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'ab54fa2c-f046-4da9-8d6c-1ce0da58a879', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'Order Placed', N'Your order VM202609022610 has been confirmed.', N'order', 1, N'/customer/orders/44bb4027-92e8-450a-9d6a-fffec63d35c2', CAST(N'2026-09-02T08:47:32.0827070' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'f3231273-8117-45dd-9db2-2633e5057a09', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'Astrologer Application Declined', N'Your astrologer application was declined after review. Contact support for details.', N'astrologer_approval', 1, N'/astrologers', CAST(N'2026-09-02T11:06:50.7739790' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'e6a1d56b-e58c-49a2-a1d2-28bde55662e1', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'Order Placed', N'Your order VM202609031070 has been confirmed.', N'order', 1, N'/customer/orders/a3e00904-ff3d-4228-bf84-98c308adc7e8', CAST(N'2026-09-03T08:35:24.1698310' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'7f8a9403-8641-4fce-8961-2a74d9884a44', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'Astrologer Application Approved', N'Congratulations! Your astrologer profile has been verified and is now visible to customers.', N'astrologer_approval', 1, N'/astrologers', CAST(N'2026-09-03T08:09:26.6326490' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'4d1efb88-5ecc-4d07-b9c0-2c8651c628a4', N'fe091691-bce9-44a6-8909-0b6949c390cf', N'Staff Access Revoked', N'Your staff access and all assigned permissions have been revoked.', N'staff_approval', 0, N'/', CAST(N'2026-09-04T06:19:53.4398480' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'd110a1bb-0768-45aa-a548-338ca41450ad', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'New Astrologer Registration', N'Active Astro (Vedic Astrology) registered as an astrologer and needs verification.', N'astrologer_registration', 1, N'/admin?tab=users', CAST(N'2026-09-02T10:02:49.2307810' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'bbf645bb-6c1e-477b-9cda-368d2b70a0b0', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'Order Status Updated', N'Your order VM202609027469 is now Confirmed.', N'order', 1, N'/customer/orders/743e0b32-e324-43f2-a6fe-2adaa49858b8', CAST(N'2026-09-02T08:59:11.3890570' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'a181242c-320e-41b1-a0f8-3e89ba3cf722', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'Astrologer Application Declined', N'Your astrologer application was declined after review. Contact support for details.', N'astrologer_approval', 1, N'/astrologers', CAST(N'2026-09-02T11:08:43.0979350' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'c4b080fb-dc8a-45a4-b41b-4224d951a251', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'Staff Access Approved', N'You have been approved for staff access. An administrator will assign your permissions shortly.', N'staff_approval', 0, N'/', CAST(N'2026-09-03T11:32:09.0622000' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'dff86904-7696-42b9-b562-4a6d9a363c04', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'Astrologer Application Declined', N'Your astrologer application was declined after review. Contact support for details.', N'astrologer_approval', 1, N'/astrologers', CAST(N'2026-09-02T09:43:51.8296610' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'8fca15cf-e716-448d-ac9b-4c243fc50175', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'Order Status Updated', N'Your order VM202609033608 is now Processing.', N'order', 1, N'/customer/orders/a084f8d7-8e31-42f7-976c-c7fc31c160ed', CAST(N'2026-09-03T11:33:34.6589800' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'6dbce51d-f6b5-4f08-9bfc-4d837373b6cf', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'Astrologer Application Declined', N'Your astrologer application was declined after review. Contact support for details.', N'astrologer_approval', 1, N'/astrologers', CAST(N'2026-09-02T11:08:07.1969890' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'f7dccac4-2ac0-4adc-842d-4d9cf1561eaf', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'Staff Access Revoked', N'Your staff access and all assigned permissions have been revoked.', N'staff_approval', 0, N'/', CAST(N'2026-09-03T11:32:07.9847050' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'df931c57-d4ef-4d13-9a97-569dc2d2eea1', N'fe091691-bce9-44a6-8909-0b6949c390cf', N'Pooja Booking Received', N'Your booking for Durga Puja on 10 Sep 2026 has been received.', N'booking', 0, N'/customer', CAST(N'2026-09-03T11:52:14.9336120' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'a89d2765-0f18-4edc-ab7d-56fb347809ef', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'Astrologer Application Approved', N'Congratulations! Your astrologer profile has been verified and is now visible to customers.', N'astrologer_approval', 1, N'/astrologers', CAST(N'2026-09-02T11:59:44.4963370' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'd31be509-cc1a-4029-acd0-5841408f0437', N'fe091691-bce9-44a6-8909-0b6949c390cf', N'Staff Access Approved', N'You have been approved for staff access. An administrator will assign your permissions shortly.', N'staff_approval', 0, N'/', CAST(N'2026-09-04T06:20:12.4068990' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'78b929a5-50d8-4505-ad56-5d0365ad1590', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'New Astrologer Registration', N'Session Test (Vedic Astrology) registered as an astrologer and needs verification.', N'astrologer_registration', 1, N'/admin?tab=users', CAST(N'2026-09-02T10:03:28.6686770' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'60575194-9368-4dd0-bdd7-6073426c23e5', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'Astrologer Application Declined', N'Your astrologer application was declined after review. Contact support for details.', N'astrologer_approval', 0, N'/astrologers', CAST(N'2026-09-04T06:19:40.4889490' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'053204e6-b950-4c07-b10d-682c9e55d3ac', N'fe091691-bce9-44a6-8909-0b6949c390cf', N'Gift Card Purchased', N'Your Pooja Gift Card worth ₹10,000 is ready. Code: VMGCF9573CA6', N'giftcard', 1, N'/gift-cards', CAST(N'2026-09-02T08:41:28.0479450' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'4ac5157d-af6e-4498-9c6d-68cc3e21e2ac', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'Astrologer Application Declined', N'Your astrologer application was declined after review. Contact support for details.', N'astrologer_approval', 1, N'/astrologers', CAST(N'2026-09-03T08:09:19.2446910' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'8ef317c9-8dbe-4813-82a2-6b6b3c2e1318', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'Astrologer Application Approved', N'Congratulations! Your astrologer profile has been verified and is now visible to customers.', N'astrologer_approval', 1, N'/astrologers', CAST(N'2026-09-02T09:43:59.7157150' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'ea0a8eeb-03e5-42e1-8e6a-6d74a791820b', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'Astrologer Application Declined', N'Your astrologer application was declined after review. Contact support for details.', N'astrologer_approval', 0, N'/astrologers', CAST(N'2026-09-04T05:57:22.5313390' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'2478b29a-7025-467e-985a-72b3429c1bef', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'Astrologer Application Approved', N'Congratulations! Your astrologer profile has been verified and is now visible to customers.', N'astrologer_approval', 0, N'/astrologers', CAST(N'2026-09-04T06:19:36.9670840' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'de74dd16-5186-4d77-b794-73e2c6e7fae9', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'Astrologer Application Approved', N'Congratulations! Your astrologer profile has been verified and is now visible to customers.', N'astrologer_approval', 1, N'/astrologers', CAST(N'2026-09-02T11:41:28.7945610' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'395cc555-0b1e-4a29-b3d1-74efc3c4ae58', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'Astrologer Application Declined', N'Your astrologer application was declined after review. Contact support for details.', N'astrologer_approval', 1, N'/astrologers', CAST(N'2026-09-02T09:44:01.6406500' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'd5cae4d0-eb03-423a-a6fe-7ca965b7e720', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'New Astrologer Registration', N'Pending Astro (Vedic Astrology) registered as an astrologer and needs verification.', N'astrologer_registration', 1, N'/admin?tab=users', CAST(N'2026-09-02T09:38:34.1900480' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'b7216547-f085-41e2-a407-85e18baccf11', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'Astrologer Application Declined', N'Your astrologer application was declined after review. Contact support for details.', N'astrologer_approval', 1, N'/astrologers', CAST(N'2026-09-02T11:59:20.7631510' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'0de29481-37fe-4989-89b2-861641b426be', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'New Astrologer Registration', N'Color2 Test (Vedic Astrology) registered as an astrologer and needs verification.', N'astrologer_registration', 1, N'/admin?tab=users', CAST(N'2026-09-02T11:56:25.4561200' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'6edae36d-1611-4722-8baf-86411e415d23', N'fe091691-bce9-44a6-8909-0b6949c390cf', N'Gift Card Purchased', N'Your Pooja Gift Card worth ₹10,000 is ready. Code: VMGCC4FC7243', N'giftcard', 1, N'/gift-cards', CAST(N'2026-09-03T08:49:34.0860600' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'b2c3fd44-bd3f-4ec1-b95e-867baf99afd1', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'Astrologer Application Approved', N'Congratulations! Your astrologer profile has been verified and is now visible to customers.', N'astrologer_approval', 1, N'/astrologers', CAST(N'2026-09-02T11:12:14.8794760' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'71e22965-c5b0-411b-80ec-8a0a6cbf1864', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'Order Placed', N'Your order VM202609027469 has been confirmed.', N'order', 1, N'/customer/orders/743e0b32-e324-43f2-a6fe-2adaa49858b8', CAST(N'2026-09-02T08:53:13.5583190' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'fc9ebfb1-7a8a-432a-bfbc-8b6f4f605437', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'Staff Access Approved', N'You have been approved for staff access. An administrator will assign your permissions shortly.', N'staff_approval', 0, N'/', CAST(N'2026-09-03T11:32:05.9306770' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'21c756e8-9425-454a-9b85-8fb1d8e5b783', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'New Astrologer Registration', N'Toast Test (Vedic Astrology) registered as an astrologer and needs verification.', N'astrologer_registration', 1, N'/admin?tab=users', CAST(N'2026-09-02T10:34:33.9321730' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'e965facf-4714-4502-aa56-9401ad314902', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'Astrologer Application Approved', N'Congratulations! Your astrologer profile has been verified and is now visible to customers.', N'astrologer_approval', 1, N'/astrologers', CAST(N'2026-09-02T11:07:00.6359550' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'1629b629-2046-4981-a613-98a9a7fa9185', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'Gift Card Purchased', N'Your Pooja Gift Card worth ₹5,000 is ready. Code: VMGCEE6BBDCC', N'giftcard', 1, N'/gift-cards', CAST(N'2026-09-02T11:12:35.8335140' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'9eac9645-6b17-42b1-8404-9a7c9e2add14', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'Order Placed', N'Your order VM202609033608 has been confirmed.', N'order', 1, N'/customer/orders/a084f8d7-8e31-42f7-976c-c7fc31c160ed', CAST(N'2026-09-03T10:25:10.3785160' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'4ad8cdea-7528-45a6-bb14-afb722f7a07a', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'New Astrologer Registration', N'Dashboard Demo (Vedic Astrology, Numerology) registered as an astrologer and needs verification.', N'astrologer_registration', 1, N'/admin?tab=users', CAST(N'2026-09-02T10:04:02.9547070' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'cefb4cde-7430-4f48-81c8-b950170b9317', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'Astrologer Application Declined', N'Your astrologer application was declined after review. Contact support for details.', N'astrologer_approval', 1, N'/astrologers', CAST(N'2026-09-02T11:06:58.9423380' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'30bdbf60-1be0-493d-90df-bac74ccea730', N'fe091691-bce9-44a6-8909-0b6949c390cf', N'Staff Access Approved', N'You have been approved for staff access. An administrator will assign your permissions shortly.', N'staff_approval', 1, N'/', CAST(N'2026-09-03T11:32:29.6532010' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'70ec9ea2-41b5-4dde-8994-bcb9623f47b8', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'Astrologer Application Declined', N'Your astrologer application was declined after review. Contact support for details.', N'astrologer_approval', 1, N'/astrologers', CAST(N'2026-09-02T11:56:17.5837840' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'834d6682-ccd3-4e35-999b-bf1d94194d25', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'New Astrologer Registration', N'Popup Test (Vedic Astrology) registered as an astrologer and needs verification.', N'astrologer_registration', 1, N'/admin?tab=users', CAST(N'2026-09-02T09:42:11.0402570' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'b488a9cd-dbcc-4c13-816c-c1e0dffabf88', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'Gift Card Purchased', N'Your Consultation Gift Card worth ₹10,000 is ready. Code: VMGC1212C5F4', N'giftcard', 1, N'/gift-cards', CAST(N'2026-09-02T09:06:41.8546620' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'b2f8a58e-38ad-4731-9634-c24c7589e911', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'Astrologer Application Declined', N'Your astrologer application was declined after review. Contact support for details.', N'astrologer_approval', 1, N'/astrologers', CAST(N'2026-09-02T11:07:52.6957550' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'30d0435b-d85e-45f2-9b26-c43417f93776', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'Astrologer Application Declined', N'Your astrologer application was declined after review. Contact support for details.', N'astrologer_approval', 0, N'/astrologers', CAST(N'2026-09-03T10:23:22.7281960' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'600d444c-5923-401f-ac89-c5a202b69d84', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'Astrologer Application Declined', N'Your astrologer application was declined after review. Contact support for details.', N'astrologer_approval', 0, N'/astrologers', CAST(N'2026-09-03T10:23:46.3010450' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'f8b205ce-53f5-46d4-9293-c836e63add18', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'Astrologer Application Declined', N'Your astrologer application was declined after review. Contact support for details.', N'astrologer_approval', 1, N'/astrologers', CAST(N'2026-09-02T11:12:05.6193390' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'009f2c6c-ee8c-4bca-8c8e-c8c892d41d00', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'Gift Card Purchased', N'Your Pooja Gift Card worth ₹10,000 is ready. Code: VMGC21DB349F', N'giftcard', 1, N'/gift-cards', CAST(N'2026-09-03T08:18:17.5222100' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'2d3ce189-5a7f-46df-9985-ddf168ca26a7', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'Astrologer Application Declined', N'Your astrologer application was declined after review. Contact support for details.', N'astrologer_approval', 1, N'/astrologers', CAST(N'2026-09-02T11:08:46.1636910' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'5dd47490-0b84-4cf5-bdce-df1166e3f567', N'37073ee0-5cee-4eaf-9f26-09aee0d02f60', N'Order Placed', N'Your order VM202609062395 has been confirmed.', N'order', 0, N'/customer/orders/a24d6d6a-c6da-4e17-85a4-a65f5d433ba3', CAST(N'2026-09-06T08:55:00.0919110' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'e73071e6-b86b-4c8f-a45b-e8eb720f78cc', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'Astrologer Application Declined', N'Your astrologer application was declined after review. Contact support for details.', N'astrologer_approval', 1, N'/astrologers', CAST(N'2026-09-02T11:41:16.2574610' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'70ca13c0-1855-4d90-850f-ef48a7fc1d15', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'Gift Card Purchased', N'Your Product Gift Card worth ₹1,000 is ready. Code: VMGC4C2EC83C', N'giftcard', 1, N'/gift-cards', CAST(N'2026-09-02T08:31:51.7840590' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'452fe7cc-f554-4685-8c57-ef623d99f3ee', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'Astrologer Application Approved', N'Congratulations! Your astrologer profile has been verified and is now visible to customers.', N'astrologer_approval', 1, N'/astrologers', CAST(N'2026-09-02T09:44:04.0575390' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'54ece54d-e06c-4c7b-b546-f96cadcd7055', N'669ed981-df08-449d-9786-f03dbedcfa2a', N'Astrologer Application Approved', N'Congratulations! Your astrologer profile has been verified and is now visible to customers.', N'astrologer_approval', 1, N'/astrologers', CAST(N'2026-09-02T11:58:54.1631280' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'9bacda76-5b76-4d28-8e1d-fa61380d2131', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'New Astrologer Registration', N'Color Test (Vedic Astrology) registered as an astrologer and needs verification.', N'astrologer_registration', 1, N'/admin?tab=users', CAST(N'2026-09-02T11:15:39.0525230' AS DateTime2), NULL, 1)
INSERT [dbo].[Notifications] ([Id], [UserId], [Title], [Message], [Type], [IsRead], [Link], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'c3e652a5-fa69-4c45-9606-fb7c106f2b02', N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'New Astrologer Registration', N'Playwright Astro (Vedic Astrology) registered as an astrologer and needs verification.', N'astrologer_registration', 1, N'/admin?tab=users', CAST(N'2026-09-02T09:33:38.6268720' AS DateTime2), NULL, 1)
INSERT [dbo].[OrderItems] ([Id], [OrderId], [ProductId], [Quantity], [UnitPrice], [TotalPrice], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'9963fb33-6dcd-4b59-b5fa-0eaeab6ea050', N'743e0b32-e324-43f2-a6fe-2adaa49858b8', N'5386caf6-7b30-4cd3-b784-d9b1540e003f', 1, CAST(988.00 AS Decimal(18, 2)), CAST(988.00 AS Decimal(18, 2)), CAST(N'2026-09-02T08:53:13.5564150' AS DateTime2), NULL, 1)
INSERT [dbo].[OrderItems] ([Id], [OrderId], [ProductId], [Quantity], [UnitPrice], [TotalPrice], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'02640793-e14f-460a-a9aa-411d69d2b1cc', N'd88ed50d-1590-4d0e-b7e3-7356dfd515b1', N'e5000001-0000-0000-0000-000000000003', 1, CAST(960.00 AS Decimal(18, 2)), CAST(960.00 AS Decimal(18, 2)), CAST(N'2026-08-31T16:10:03.4372580' AS DateTime2), NULL, 1)
INSERT [dbo].[OrderItems] ([Id], [OrderId], [ProductId], [Quantity], [UnitPrice], [TotalPrice], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'3d8a4b9d-ac20-474e-af4b-417d5c7c3175', N'a3e00904-ff3d-4228-bf84-98c308adc7e8', N'e5000001-0000-0000-0000-000000000003', 1, CAST(960.00 AS Decimal(18, 2)), CAST(960.00 AS Decimal(18, 2)), CAST(N'2026-09-03T08:35:24.0537860' AS DateTime2), NULL, 1)
INSERT [dbo].[OrderItems] ([Id], [OrderId], [ProductId], [Quantity], [UnitPrice], [TotalPrice], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'f74adf00-63d7-4954-9ced-6932ba39e3ea', N'07e91a87-d4ec-4a7c-bb76-86e916c8b218', N'e5000001-0000-0000-0000-000000000003', 1, CAST(960.00 AS Decimal(18, 2)), CAST(960.00 AS Decimal(18, 2)), CAST(N'2026-08-31T16:18:14.2223030' AS DateTime2), NULL, 1)
INSERT [dbo].[OrderItems] ([Id], [OrderId], [ProductId], [Quantity], [UnitPrice], [TotalPrice], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'297e9922-be53-480d-9ff5-6c642f2efd34', N'92a307f9-d450-481d-a3f1-06f15ef3fdd4', N'e5000001-0000-0000-0000-000000000002', 1, CAST(45000.00 AS Decimal(18, 2)), CAST(45000.00 AS Decimal(18, 2)), CAST(N'2026-09-02T07:07:25.5356990' AS DateTime2), NULL, 1)
INSERT [dbo].[OrderItems] ([Id], [OrderId], [ProductId], [Quantity], [UnitPrice], [TotalPrice], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'fa887066-062f-4492-856d-7ccc84ac42b9', N'44bb4027-92e8-450a-9d6a-fffec63d35c2', N'e5000001-0000-0000-0000-000000000002', 3, CAST(45000.00 AS Decimal(18, 2)), CAST(135000.00 AS Decimal(18, 2)), CAST(N'2026-09-02T08:47:31.9801600' AS DateTime2), NULL, 1)
INSERT [dbo].[OrderItems] ([Id], [OrderId], [ProductId], [Quantity], [UnitPrice], [TotalPrice], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'7a07692c-1b48-40c1-a2d8-9c0d0ac8eb30', N'b3e1b042-a968-40e0-944d-1428f5367042', N'e5000001-0000-0000-0000-000000000006', 1, CAST(1199.00 AS Decimal(18, 2)), CAST(1199.00 AS Decimal(18, 2)), CAST(N'2026-09-02T07:33:22.2135450' AS DateTime2), NULL, 1)
INSERT [dbo].[OrderItems] ([Id], [OrderId], [ProductId], [Quantity], [UnitPrice], [TotalPrice], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'273169a9-d2bc-4312-8f0d-9fbfb91b04ca', N'a084f8d7-8e31-42f7-976c-c7fc31c160ed', N'e5000001-0000-0000-0000-000000000003', 1, CAST(960.00 AS Decimal(18, 2)), CAST(960.00 AS Decimal(18, 2)), CAST(N'2026-09-03T10:25:10.2885750' AS DateTime2), NULL, 1)
INSERT [dbo].[OrderItems] ([Id], [OrderId], [ProductId], [Quantity], [UnitPrice], [TotalPrice], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'b6e07cbc-e73d-41c6-8dfa-b6bc96e7bb74', N'a24d6d6a-c6da-4e17-85a4-a65f5d433ba3', N'55633889-a468-43a1-a935-c696599afe2e', 1, CAST(99.00 AS Decimal(18, 2)), CAST(99.00 AS Decimal(18, 2)), CAST(N'2026-09-06T08:54:59.9743000' AS DateTime2), NULL, 1)
INSERT [dbo].[OrderItems] ([Id], [OrderId], [ProductId], [Quantity], [UnitPrice], [TotalPrice], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'99fa930e-775e-4bc6-8984-b8d7fe74fc13', N'7a9b6d1d-f2eb-4901-ac67-572830837681', N'e5000001-0000-0000-0000-000000000012', 1, CAST(299.00 AS Decimal(18, 2)), CAST(299.00 AS Decimal(18, 2)), CAST(N'2026-09-02T07:22:25.7337610' AS DateTime2), NULL, 1)
INSERT [dbo].[OrderItems] ([Id], [OrderId], [ProductId], [Quantity], [UnitPrice], [TotalPrice], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'a519fafd-066c-4a24-8520-bf298bddb477', N'44bb4027-92e8-450a-9d6a-fffec63d35c2', N'e5000001-0000-0000-0000-000000000005', 1, CAST(280.00 AS Decimal(18, 2)), CAST(280.00 AS Decimal(18, 2)), CAST(N'2026-09-02T08:47:31.9778100' AS DateTime2), NULL, 1)
INSERT [dbo].[Orders] ([Id], [OrderNumber], [UserId], [Status], [SubTotal], [Discount], [ShippingFee], [Total], [CouponCode], [ShippingAddressId], [TrackingNumber], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'92a307f9-d450-481d-a3f1-06f15ef3fdd4', N'VM202609021304', N'f8e7cb48-c411-4725-b124-971a2854ebc1', 2, CAST(45000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(45000.00 AS Decimal(18, 2)), NULL, NULL, NULL, CAST(N'2026-09-02T07:07:25.4766660' AS DateTime2), NULL, 1)
INSERT [dbo].[Orders] ([Id], [OrderNumber], [UserId], [Status], [SubTotal], [Discount], [ShippingFee], [Total], [CouponCode], [ShippingAddressId], [TrackingNumber], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'b3e1b042-a968-40e0-944d-1428f5367042', N'VM202609028702', N'fe091691-bce9-44a6-8909-0b6949c390cf', 2, CAST(1199.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(1199.00 AS Decimal(18, 2)), NULL, NULL, NULL, CAST(N'2026-09-02T07:33:22.2113520' AS DateTime2), NULL, 1)
INSERT [dbo].[Orders] ([Id], [OrderNumber], [UserId], [Status], [SubTotal], [Discount], [ShippingFee], [Total], [CouponCode], [ShippingAddressId], [TrackingNumber], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'743e0b32-e324-43f2-a6fe-2adaa49858b8', N'VM202609027469', N'f8e7cb48-c411-4725-b124-971a2854ebc1', 2, CAST(988.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(99.00 AS Decimal(18, 2)), CAST(1087.00 AS Decimal(18, 2)), NULL, NULL, NULL, CAST(N'2026-09-02T08:53:13.5530670' AS DateTime2), CAST(N'2026-09-02T08:59:11.3729150' AS DateTime2), 1)
INSERT [dbo].[Orders] ([Id], [OrderNumber], [UserId], [Status], [SubTotal], [Discount], [ShippingFee], [Total], [CouponCode], [ShippingAddressId], [TrackingNumber], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'7a9b6d1d-f2eb-4901-ac67-572830837681', N'VM202609027549', N'fe091691-bce9-44a6-8909-0b6949c390cf', 2, CAST(299.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(99.00 AS Decimal(18, 2)), CAST(398.00 AS Decimal(18, 2)), NULL, NULL, NULL, CAST(N'2026-09-02T07:22:25.7311680' AS DateTime2), NULL, 1)
INSERT [dbo].[Orders] ([Id], [OrderNumber], [UserId], [Status], [SubTotal], [Discount], [ShippingFee], [Total], [CouponCode], [ShippingAddressId], [TrackingNumber], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'd88ed50d-1590-4d0e-b7e3-7356dfd515b1', N'VM202608314182', N'f8e7cb48-c411-4725-b124-971a2854ebc1', 2, CAST(960.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(99.00 AS Decimal(18, 2)), CAST(1059.00 AS Decimal(18, 2)), NULL, NULL, NULL, CAST(N'2026-08-31T16:10:03.3892220' AS DateTime2), NULL, 1)
INSERT [dbo].[Orders] ([Id], [OrderNumber], [UserId], [Status], [SubTotal], [Discount], [ShippingFee], [Total], [CouponCode], [ShippingAddressId], [TrackingNumber], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'07e91a87-d4ec-4a7c-bb76-86e916c8b218', N'VM202608317044', N'52b7ddbb-4791-43c4-9335-3a76e3df3209', 2, CAST(960.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(99.00 AS Decimal(18, 2)), CAST(1059.00 AS Decimal(18, 2)), NULL, NULL, NULL, CAST(N'2026-08-31T16:18:14.2179310' AS DateTime2), NULL, 1)
INSERT [dbo].[Orders] ([Id], [OrderNumber], [UserId], [Status], [SubTotal], [Discount], [ShippingFee], [Total], [CouponCode], [ShippingAddressId], [TrackingNumber], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'a3e00904-ff3d-4228-bf84-98c308adc7e8', N'VM202609031070', N'f8e7cb48-c411-4725-b124-971a2854ebc1', 2, CAST(960.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(99.00 AS Decimal(18, 2)), CAST(1059.00 AS Decimal(18, 2)), NULL, NULL, NULL, CAST(N'2026-09-03T08:35:24.0390180' AS DateTime2), NULL, 1)
INSERT [dbo].[Orders] ([Id], [OrderNumber], [UserId], [Status], [SubTotal], [Discount], [ShippingFee], [Total], [CouponCode], [ShippingAddressId], [TrackingNumber], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'a24d6d6a-c6da-4e17-85a4-a65f5d433ba3', N'VM202609062395', N'37073ee0-5cee-4eaf-9f26-09aee0d02f60', 4, CAST(99.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(99.00 AS Decimal(18, 2)), CAST(198.00 AS Decimal(18, 2)), NULL, NULL, NULL, CAST(N'2026-09-06T08:54:59.9482480' AS DateTime2), CAST(N'2026-09-06T08:56:22.9676270' AS DateTime2), 1)
INSERT [dbo].[Orders] ([Id], [OrderNumber], [UserId], [Status], [SubTotal], [Discount], [ShippingFee], [Total], [CouponCode], [ShippingAddressId], [TrackingNumber], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'a084f8d7-8e31-42f7-976c-c7fc31c160ed', N'VM202609033608', N'f8e7cb48-c411-4725-b124-971a2854ebc1', 3, CAST(960.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(99.00 AS Decimal(18, 2)), CAST(1059.00 AS Decimal(18, 2)), NULL, NULL, NULL, CAST(N'2026-09-03T10:25:10.2767670' AS DateTime2), CAST(N'2026-09-03T11:33:34.6413690' AS DateTime2), 1)
INSERT [dbo].[Orders] ([Id], [OrderNumber], [UserId], [Status], [SubTotal], [Discount], [ShippingFee], [Total], [CouponCode], [ShippingAddressId], [TrackingNumber], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'44bb4027-92e8-450a-9d6a-fffec63d35c2', N'VM202609022610', N'f8e7cb48-c411-4725-b124-971a2854ebc1', 2, CAST(135280.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(135280.00 AS Decimal(18, 2)), NULL, NULL, NULL, CAST(N'2026-09-02T08:47:31.9701090' AS DateTime2), NULL, 1)
INSERT [dbo].[OrderTracking] ([Id], [OrderId], [Status], [Notes], [Location], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'248dfda9-c708-41f2-af91-09eb58268cba', N'a084f8d7-8e31-42f7-976c-c7fc31c160ed', 3, NULL, NULL, CAST(N'2026-09-03T11:33:34.6415400' AS DateTime2), NULL, 1)
INSERT [dbo].[OrderTracking] ([Id], [OrderId], [Status], [Notes], [Location], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'fa90c5bb-1481-461c-ab92-141e94e1bc40', N'07e91a87-d4ec-4a7c-bb76-86e916c8b218', 2, N'Order confirmed and payment received', NULL, CAST(N'2026-08-31T16:18:14.2223070' AS DateTime2), NULL, 1)
INSERT [dbo].[OrderTracking] ([Id], [OrderId], [Status], [Notes], [Location], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'96b91c57-c10b-473f-bc61-3d988c518462', N'a24d6d6a-c6da-4e17-85a4-a65f5d433ba3', 4, NULL, NULL, CAST(N'2026-09-06T08:56:22.9678090' AS DateTime2), NULL, 1)
INSERT [dbo].[OrderTracking] ([Id], [OrderId], [Status], [Notes], [Location], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'2b0d1507-76ba-4d29-831b-440535565c69', N'743e0b32-e324-43f2-a6fe-2adaa49858b8', 2, N'Confirmed by admin test', NULL, CAST(N'2026-09-02T08:59:11.3730550' AS DateTime2), NULL, 1)
INSERT [dbo].[OrderTracking] ([Id], [OrderId], [Status], [Notes], [Location], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'd91e5684-c425-4e96-b92f-52384534d83a', N'a084f8d7-8e31-42f7-976c-c7fc31c160ed', 2, N'Order confirmed and payment received', NULL, CAST(N'2026-09-03T10:25:10.2889680' AS DateTime2), NULL, 1)
INSERT [dbo].[OrderTracking] ([Id], [OrderId], [Status], [Notes], [Location], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'98723799-7298-44f7-b446-7d38b0c81343', N'743e0b32-e324-43f2-a6fe-2adaa49858b8', 2, N'Order confirmed and payment received', NULL, CAST(N'2026-09-02T08:53:13.5564200' AS DateTime2), NULL, 1)
INSERT [dbo].[OrderTracking] ([Id], [OrderId], [Status], [Notes], [Location], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'd0e6139b-078c-4cf9-aa60-83c6a7494815', N'92a307f9-d450-481d-a3f1-06f15ef3fdd4', 2, N'Order confirmed and payment received', NULL, CAST(N'2026-09-02T07:07:25.5360540' AS DateTime2), NULL, 1)
INSERT [dbo].[OrderTracking] ([Id], [OrderId], [Status], [Notes], [Location], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'ebb2ca1e-ff8d-4e96-902b-84a2eb39bc91', N'7a9b6d1d-f2eb-4901-ac67-572830837681', 2, N'Order confirmed and payment received', NULL, CAST(N'2026-09-02T07:22:25.7337640' AS DateTime2), NULL, 1)
INSERT [dbo].[OrderTracking] ([Id], [OrderId], [Status], [Notes], [Location], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'd5a66a4c-a7b4-4468-be0a-ad87ca97f444', N'b3e1b042-a968-40e0-944d-1428f5367042', 2, N'Order confirmed and payment received', NULL, CAST(N'2026-09-02T07:33:22.2135470' AS DateTime2), NULL, 1)
INSERT [dbo].[OrderTracking] ([Id], [OrderId], [Status], [Notes], [Location], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'a8d3cc29-84b7-4b84-8350-c548a9811ed6', N'd88ed50d-1590-4d0e-b7e3-7356dfd515b1', 2, N'Order confirmed and payment received', NULL, CAST(N'2026-08-31T16:10:03.4385050' AS DateTime2), NULL, 1)
INSERT [dbo].[OrderTracking] ([Id], [OrderId], [Status], [Notes], [Location], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'e150d5b8-b698-466b-a3b3-d52e8b4b3db2', N'a24d6d6a-c6da-4e17-85a4-a65f5d433ba3', 2, N'Order confirmed and payment received', NULL, CAST(N'2026-09-06T08:54:59.9749130' AS DateTime2), NULL, 1)
INSERT [dbo].[OrderTracking] ([Id], [OrderId], [Status], [Notes], [Location], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'486795c4-7cbc-424d-a252-e1596c54e14e', N'a3e00904-ff3d-4228-bf84-98c308adc7e8', 2, N'Order confirmed and payment received', NULL, CAST(N'2026-09-03T08:35:24.0541340' AS DateTime2), NULL, 1)
INSERT [dbo].[OrderTracking] ([Id], [OrderId], [Status], [Notes], [Location], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'f81a204c-f44b-4a81-b18c-e4d97ec9913d', N'44bb4027-92e8-450a-9d6a-fffec63d35c2', 2, N'Order confirmed and payment received', NULL, CAST(N'2026-09-02T08:47:31.9803250' AS DateTime2), NULL, 1)
INSERT [dbo].[Payments] ([Id], [OrderId], [Amount], [Status], [PaymentMethod], [TransactionId], [GatewayResponse], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'87d406c0-9923-4ca2-8324-1f2c0c224a34', N'b3e1b042-a968-40e0-944d-1428f5367042', CAST(1199.00 AS Decimal(18, 2)), 2, N'UPI', N'TXN09F524B1863C4', NULL, CAST(N'2026-09-02T07:33:22.2135480' AS DateTime2), NULL, 1)
INSERT [dbo].[Payments] ([Id], [OrderId], [Amount], [Status], [PaymentMethod], [TransactionId], [GatewayResponse], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'2d751bbc-d44d-492b-bb70-61d0170a5569', N'd88ed50d-1590-4d0e-b7e3-7356dfd515b1', CAST(1059.00 AS Decimal(18, 2)), 2, N'UPI', N'TXNF968467CE48E4', NULL, CAST(N'2026-08-31T16:10:03.4387390' AS DateTime2), NULL, 1)
INSERT [dbo].[Payments] ([Id], [OrderId], [Amount], [Status], [PaymentMethod], [TransactionId], [GatewayResponse], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'd181dd8d-ae73-4cad-bced-623300ce1d00', N'44bb4027-92e8-450a-9d6a-fffec63d35c2', CAST(135280.00 AS Decimal(18, 2)), 2, N'UPI', N'TXN9D86E21DA2D74', NULL, CAST(N'2026-09-02T08:47:31.9807300' AS DateTime2), NULL, 1)
INSERT [dbo].[Payments] ([Id], [OrderId], [Amount], [Status], [PaymentMethod], [TransactionId], [GatewayResponse], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'34e5ced5-3409-4210-bfd5-713d77bcd612', N'7a9b6d1d-f2eb-4901-ac67-572830837681', CAST(398.00 AS Decimal(18, 2)), 2, N'COD', N'TXN1C378A02B9674', NULL, CAST(N'2026-09-02T07:22:25.7337650' AS DateTime2), NULL, 1)
INSERT [dbo].[Payments] ([Id], [OrderId], [Amount], [Status], [PaymentMethod], [TransactionId], [GatewayResponse], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'd43861ca-999c-4801-9ad1-85ce45fdb27d', N'a24d6d6a-c6da-4e17-85a4-a65f5d433ba3', CAST(198.00 AS Decimal(18, 2)), 2, N'UPI', N'TXNF9DE2E39A9DC4', NULL, CAST(N'2026-09-06T08:54:59.9751300' AS DateTime2), NULL, 1)
INSERT [dbo].[Payments] ([Id], [OrderId], [Amount], [Status], [PaymentMethod], [TransactionId], [GatewayResponse], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'a44d732b-7739-48e9-ada8-8b14c27a15e7', N'a084f8d7-8e31-42f7-976c-c7fc31c160ed', CAST(1059.00 AS Decimal(18, 2)), 2, N'UPI', N'TXN6D9DE7583A1D4', NULL, CAST(N'2026-09-03T10:25:10.2891370' AS DateTime2), NULL, 1)
INSERT [dbo].[Payments] ([Id], [OrderId], [Amount], [Status], [PaymentMethod], [TransactionId], [GatewayResponse], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'45ca623d-b64a-46b4-82ec-ac1b8fbe2c49', N'07e91a87-d4ec-4a7c-bb76-86e916c8b218', CAST(1059.00 AS Decimal(18, 2)), 2, N'UPI', N'TXN7AD8D784D59E4', NULL, CAST(N'2026-08-31T16:18:14.2223080' AS DateTime2), NULL, 1)
INSERT [dbo].[Payments] ([Id], [OrderId], [Amount], [Status], [PaymentMethod], [TransactionId], [GatewayResponse], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'98119712-4506-4ae2-b078-ad5a2ac232f2', N'92a307f9-d450-481d-a3f1-06f15ef3fdd4', CAST(45000.00 AS Decimal(18, 2)), 2, N'UPI', N'TXN72D8BBCE28C44', NULL, CAST(N'2026-09-02T07:07:25.5361990' AS DateTime2), NULL, 1)
INSERT [dbo].[Payments] ([Id], [OrderId], [Amount], [Status], [PaymentMethod], [TransactionId], [GatewayResponse], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'81cc9496-d5a0-4507-9bfa-dc74efa765dd', N'743e0b32-e324-43f2-a6fe-2adaa49858b8', CAST(1087.00 AS Decimal(18, 2)), 2, N'UPI', N'TXN6772991FF2364', NULL, CAST(N'2026-09-02T08:53:13.5564220' AS DateTime2), NULL, 1)
INSERT [dbo].[Payments] ([Id], [OrderId], [Amount], [Status], [PaymentMethod], [TransactionId], [GatewayResponse], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'1347e3a0-e927-45d0-a0c7-eccdc3879528', N'a3e00904-ff3d-4228-bf84-98c308adc7e8', CAST(1059.00 AS Decimal(18, 2)), 2, N'UPI', N'TXN8FAD83DE04C94', NULL, CAST(N'2026-09-03T08:35:24.0544030' AS DateTime2), NULL, 1)
INSERT [dbo].[Permissions] ([Id], [Code], [Name], [Module], [Description], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'128d2adb-1656-41e5-a466-0d97fae3e122', N'role.manage', N'Role - Manage', N'User', N'Manage roles and permission mapping', CAST(N'2026-08-31T14:48:36.5600000' AS DateTime2), NULL, 1)
INSERT [dbo].[Permissions] ([Id], [Code], [Name], [Module], [Description], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'130b497b-f263-4acb-980f-0de56b78b935', N'dashboard.view.all', N'Dashboard - View All', N'Dashboard', N'View full admin dashboard/stats', CAST(N'2026-08-31T14:48:36.5600000' AS DateTime2), NULL, 1)
INSERT [dbo].[Permissions] ([Id], [Code], [Name], [Module], [Description], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'c6579a62-e9ec-423d-9dcd-2bc3ac604b0b', N'product.manage', N'Product - Manage', N'Product', N'Create/update/delete products', CAST(N'2026-08-31T14:48:36.5600000' AS DateTime2), NULL, 1)
INSERT [dbo].[Permissions] ([Id], [Code], [Name], [Module], [Description], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'3daa9ce8-4d36-4630-9bf5-2e8e726d4c25', N'order.view.own', N'Order - View Own', N'Order', N'Customer views own orders', CAST(N'2026-08-31T14:48:36.5600000' AS DateTime2), NULL, 1)
INSERT [dbo].[Permissions] ([Id], [Code], [Name], [Module], [Description], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'31acbb1e-da6d-40d7-8f15-310940df8249', N'kundli.request.manage.own', N'Kundli - Manage Own', N'Kundli', N'Astrologer manages assigned kundli requests', CAST(N'2026-08-31T14:48:36.5600000' AS DateTime2), NULL, 1)
INSERT [dbo].[Permissions] ([Id], [Code], [Name], [Module], [Description], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'29a03e13-d514-4f8a-82d8-33ecc5054246', N'kundli.request.view.all', N'Kundli - View All', N'Kundli', N'View all kundli requests', CAST(N'2026-08-31T14:48:36.5600000' AS DateTime2), NULL, 1)
INSERT [dbo].[Permissions] ([Id], [Code], [Name], [Module], [Description], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'c4c921d4-3756-4707-91a4-35393d9ee5d5', N'gift.card.manage', N'Gift Card - Manage', N'GiftCard', N'Manage gift cards', CAST(N'2026-08-31T14:48:36.5600000' AS DateTime2), NULL, 1)
INSERT [dbo].[Permissions] ([Id], [Code], [Name], [Module], [Description], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'42a2cb6a-35e0-4af1-ad03-50e06376613b', N'pooja.booking.manage.own', N'Pooja Booking - Manage Own', N'Pooja', N'Astrologer manages own assigned pooja bookings', CAST(N'2026-08-31T14:48:36.5600000' AS DateTime2), NULL, 1)
INSERT [dbo].[Permissions] ([Id], [Code], [Name], [Module], [Description], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'3a76ebbb-27ed-49a3-a86b-519f74479998', N'coupon.manage', N'Coupon - Manage', N'Coupon', N'Create/update/delete coupons', CAST(N'2026-08-31T14:48:36.5600000' AS DateTime2), NULL, 1)
INSERT [dbo].[Permissions] ([Id], [Code], [Name], [Module], [Description], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'eac8a89f-eb7e-479c-983c-54e5060a8675', N'payment.create', N'Payment - Create', N'Payment', N'Customer initiates a payment', CAST(N'2026-08-31T14:48:36.5600000' AS DateTime2), NULL, 1)
INSERT [dbo].[Permissions] ([Id], [Code], [Name], [Module], [Description], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'72ec1694-a6ef-49f9-bb21-569dbcaf940b', N'order.create', N'Order - Create', N'Order', N'Customer places an order', CAST(N'2026-08-31T14:48:36.5600000' AS DateTime2), NULL, 1)
INSERT [dbo].[Permissions] ([Id], [Code], [Name], [Module], [Description], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'0bb3063a-a39d-47cd-90c4-646787942e27', N'order.cancel', N'Order - Cancel', N'Order', N'Customer cancels own orders', CAST(N'2026-08-31T14:48:36.5600000' AS DateTime2), NULL, 1)
INSERT [dbo].[Permissions] ([Id], [Code], [Name], [Module], [Description], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'cddb559b-9ef9-434e-be91-70bb2991c646', N'subscription.manage', N'Subscription - Manage', N'Subscription', N'Manage subscriptions', CAST(N'2026-08-31T14:48:36.5600000' AS DateTime2), NULL, 1)
INSERT [dbo].[Permissions] ([Id], [Code], [Name], [Module], [Description], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'144daf1d-059a-45a7-bf4c-72b763fc8159', N'pooja.service.manage', N'Pooja Service - Manage', N'Pooja', N'Create/update/delete pooja service catalog', CAST(N'2026-08-31T14:48:36.5600000' AS DateTime2), NULL, 1)
INSERT [dbo].[Permissions] ([Id], [Code], [Name], [Module], [Description], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'647eb9b1-2608-463b-8139-8b59f72525f6', N'pooja.booking.create', N'Pooja Booking - Create', N'Pooja', N'Customer creates a pooja booking', CAST(N'2026-08-31T14:48:36.5600000' AS DateTime2), NULL, 1)
INSERT [dbo].[Permissions] ([Id], [Code], [Name], [Module], [Description], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'68e712e9-0c2c-48ec-b23f-8d400f070c52', N'logs.view.all', N'Logs - View All', N'System', N'View all system logs', CAST(N'2026-08-31T14:48:36.5600000' AS DateTime2), NULL, 1)
INSERT [dbo].[Permissions] ([Id], [Code], [Name], [Module], [Description], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'e6aca605-921a-48aa-8974-92b3c1eb977e', N'kundli.request.create', N'Kundli - Create', N'Kundli', N'Customer requests a kundli', CAST(N'2026-08-31T14:48:36.5600000' AS DateTime2), NULL, 1)
INSERT [dbo].[Permissions] ([Id], [Code], [Name], [Module], [Description], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'333d38b7-da03-454e-966b-938235883fdd', N'payment.view.own', N'Payment - View Own', N'Payment', N'Customer views own payment history', CAST(N'2026-08-31T14:48:36.5600000' AS DateTime2), NULL, 1)
INSERT [dbo].[Permissions] ([Id], [Code], [Name], [Module], [Description], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'32271a88-046e-44e5-98d9-9796f6a7ecb7', N'product.view', N'Product - View', N'Product', N'View product catalog', CAST(N'2026-08-31T14:48:36.5600000' AS DateTime2), NULL, 1)
INSERT [dbo].[Permissions] ([Id], [Code], [Name], [Module], [Description], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'917e5862-4cb7-4764-8ecf-97d48c69a8c8', N'kundli.request.view.own', N'Kundli - View Own', N'Kundli', N'Customer views own kundli requests', CAST(N'2026-08-31T14:48:36.5600000' AS DateTime2), NULL, 1)
INSERT [dbo].[Permissions] ([Id], [Code], [Name], [Module], [Description], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'5dbf9feb-347b-4f16-b794-9fd1b01ac647', N'stock.view.all', N'Stock - View All', N'Product', N'View product stock movement history', CAST(N'2026-08-31T14:48:36.5600000' AS DateTime2), NULL, 1)
INSERT [dbo].[Permissions] ([Id], [Code], [Name], [Module], [Description], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'9a313137-aa9f-4059-8a7b-b96a7190100f', N'pooja.booking.view.own', N'Pooja Booking - View Own', N'Pooja', N'Customer views own bookings', CAST(N'2026-08-31T14:48:36.5600000' AS DateTime2), NULL, 1)
INSERT [dbo].[Permissions] ([Id], [Code], [Name], [Module], [Description], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'0e16ac84-7db3-4232-b19a-b9e691ace400', N'address.manage.own', N'Address - Manage Own', N'Address', N'Customer manages own addresses', CAST(N'2026-08-31T14:48:36.5600000' AS DateTime2), NULL, 1)
INSERT [dbo].[Permissions] ([Id], [Code], [Name], [Module], [Description], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'3b4e8571-4b1e-47e3-b54b-c9a21b206466', N'user.manage.all', N'User - Manage All', N'User', N'Create/update/delete/view any user', CAST(N'2026-08-31T14:48:36.5600000' AS DateTime2), NULL, 1)
INSERT [dbo].[Permissions] ([Id], [Code], [Name], [Module], [Description], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'aa8651bd-ce2a-4798-b8ae-cd64900b9d47', N'category.manage', N'Category - Manage', N'Product', N'Create/update/delete product categories', CAST(N'2026-08-31T14:48:36.5600000' AS DateTime2), NULL, 1)
INSERT [dbo].[Permissions] ([Id], [Code], [Name], [Module], [Description], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'174156b7-a1c0-47f9-a1be-d5af0e62fce0', N'payment.view.all', N'Payment - View All', N'Payment', N'View all payments (admin)', CAST(N'2026-08-31T14:48:36.5600000' AS DateTime2), NULL, 1)
INSERT [dbo].[Permissions] ([Id], [Code], [Name], [Module], [Description], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'5f8d6c9d-44e5-470d-8a1e-da93491aa194', N'pooja.booking.view.all', N'Pooja Booking - View All', N'Pooja', N'View all pooja bookings', CAST(N'2026-08-31T14:48:36.5600000' AS DateTime2), NULL, 1)
INSERT [dbo].[Permissions] ([Id], [Code], [Name], [Module], [Description], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'8c29c9c2-85b6-4957-988c-eb5a3b53ff33', N'order.view.all', N'Order - View All', N'Order', N'View all orders', CAST(N'2026-08-31T14:48:36.5600000' AS DateTime2), NULL, 1)
INSERT [dbo].[Permissions] ([Id], [Code], [Name], [Module], [Description], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'bc76a4fb-d7b5-48bf-8c00-eeb583776618', N'astrologer.approve', N'Astrologer - Approve', N'User', N'Approve/reject astrologer self-registration', CAST(N'2026-08-31T14:48:36.5600000' AS DateTime2), NULL, 1)
INSERT [dbo].[PoojaBookings] ([Id], [UserId], [PoojaServiceId], [AstrologerId], [ScheduledDate], [ScheduledTime], [Status], [Amount], [SpecialInstructions], [Notes], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'2b43ba98-7b91-4451-a7b2-2409b3e8a99d', N'fe091691-bce9-44a6-8909-0b6949c390cf', N'c3000001-0000-0000-0000-000000000006', NULL, CAST(N'2026-09-17T00:00:00.0000000' AS DateTime2), N'02:48', 1, CAST(4125.00 AS Decimal(18, 2)), N'uarvyrypitvuyaervyouerv8eep4yn89496yq349yc4nqy39x6q984ypyp98eyp9NYPX(fnyp89rwy6tn', NULL, CAST(N'2026-09-02T07:17:04.4761460' AS DateTime2), NULL, 1)
INSERT [dbo].[PoojaBookings] ([Id], [UserId], [PoojaServiceId], [AstrologerId], [ScheduledDate], [ScheduledTime], [Status], [Amount], [SpecialInstructions], [Notes], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'ba43df25-c82a-4ea5-b2c8-3947c707695f', N'fe091691-bce9-44a6-8909-0b6949c390cf', N'c3000001-0000-0000-0000-000000000006', NULL, CAST(N'2026-09-10T00:00:00.0000000' AS DateTime2), N'18:22', 1, CAST(4125.00 AS Decimal(18, 2)), N'test', NULL, CAST(N'2026-09-03T11:52:14.8775920' AS DateTime2), NULL, 1)
INSERT [dbo].[PoojaBookings] ([Id], [UserId], [PoojaServiceId], [AstrologerId], [ScheduledDate], [ScheduledTime], [Status], [Amount], [SpecialInstructions], [Notes], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'bd0cd02d-fff8-4161-95a7-4ad3f7a1b531', N'fe091691-bce9-44a6-8909-0b6949c390cf', N'c3000001-0000-0000-0000-000000000010', NULL, CAST(N'2026-09-30T00:00:00.0000000' AS DateTime2), N'18:11', 1, CAST(8500.00 AS Decimal(18, 2)), N'', NULL, CAST(N'2026-09-02T07:37:06.2404440' AS DateTime2), NULL, 1)
INSERT [dbo].[PoojaBookings] ([Id], [UserId], [PoojaServiceId], [AstrologerId], [ScheduledDate], [ScheduledTime], [Status], [Amount], [SpecialInstructions], [Notes], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'89e96d15-fdf9-4d7e-b38e-a90c7d3cbb99', N'fe091691-bce9-44a6-8909-0b6949c390cf', N'c3000001-0000-0000-0000-000000000010', NULL, CAST(N'2026-09-30T00:00:00.0000000' AS DateTime2), N'03:51', 1, CAST(8500.00 AS Decimal(18, 2)), N'oiaiucyūiayiucweeyiluweBYIIYCILCYILUYCLUIYCNUINRYACI', NULL, CAST(N'2026-09-02T07:18:46.2497680' AS DateTime2), NULL, 1)
INSERT [dbo].[PoojaBookings] ([Id], [UserId], [PoojaServiceId], [AstrologerId], [ScheduledDate], [ScheduledTime], [Status], [Amount], [SpecialInstructions], [Notes], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'62d9f803-c8eb-4306-8366-abaa74c51b33', N'fe091691-bce9-44a6-8909-0b6949c390cf', N'c3000001-0000-0000-0000-000000000007', NULL, CAST(N'2026-10-01T00:00:00.0000000' AS DateTime2), N'16:05', 1, CAST(2170.00 AS Decimal(18, 2)), N'check checkcheck checkcheck checkcheck checkcheck checkcheck checkcheck checkcheck checkcheck checkcheck checkcheck checkcheck checkcheck checkcheck checkcheck checkcheck checkcheck check', NULL, CAST(N'2026-09-02T07:32:28.3358610' AS DateTime2), NULL, 1)
INSERT [dbo].[PoojaServices] ([Id], [Name], [Slug], [Category], [Description], [Price], [SalePrice], [DurationMinutes], [ImageUrl], [IsFeatured], [Rating], [ReviewCount], [FestivalTag], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'c3000001-0000-0000-0000-000000000001', N'Ganesh Puja', N'ganesh-puja', N'Ganesh Puja', N'Remove obstacles and invite prosperity with authentic Ganesh Puja.', CAST(2100.00 AS Decimal(18, 2)), CAST(1800.00 AS Decimal(18, 2)), 90, N'/images/pooja/a2f2a072-6437-42be-84a5-f402d794cfd0.jpeg', 1, CAST(4.9 AS Decimal(3, 1)), 120, N'Ganesh Chaturthi', CAST(N'2026-08-31T13:59:39.0600000' AS DateTime2), CAST(N'2026-09-03T10:08:10.4042070' AS DateTime2), 1)
INSERT [dbo].[PoojaServices] ([Id], [Name], [Slug], [Category], [Description], [Price], [SalePrice], [DurationMinutes], [ImageUrl], [IsFeatured], [Rating], [ReviewCount], [FestivalTag], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'c3000001-0000-0000-0000-000000000002', N'Satyanarayan Puja', N'satyanarayan-puja', N'Satyanarayan Puja', N'Sacred puja for peace, prosperity and fulfillment of wishes.', CAST(3500.00 AS Decimal(18, 2)), NULL, 120, N'/images/pooja/0d6b9ae6-3071-4c0d-90a2-5bfcd83fb42e.jpeg', 1, CAST(4.5 AS Decimal(3, 1)), 85, NULL, CAST(N'2026-08-31T13:59:39.0600000' AS DateTime2), CAST(N'2026-09-03T10:08:16.5646730' AS DateTime2), 1)
INSERT [dbo].[PoojaServices] ([Id], [Name], [Slug], [Category], [Description], [Price], [SalePrice], [DurationMinutes], [ImageUrl], [IsFeatured], [Rating], [ReviewCount], [FestivalTag], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'c3000001-0000-0000-0000-000000000003', N'Griha Pravesh', N'griha-pravesh', N'Griha Pravesh', N'House warming ceremony for positive energy in your new home.', CAST(5100.00 AS Decimal(18, 2)), CAST(4590.00 AS Decimal(18, 2)), 180, N'/images/pooja/2979e579-4268-4552-ad21-24012bdeaf89.jpg', 1, CAST(4.8 AS Decimal(3, 1)), 95, NULL, CAST(N'2026-08-31T13:59:39.0600000' AS DateTime2), CAST(N'2026-09-03T10:08:23.0837270' AS DateTime2), 1)
INSERT [dbo].[PoojaServices] ([Id], [Name], [Slug], [Category], [Description], [Price], [SalePrice], [DurationMinutes], [ImageUrl], [IsFeatured], [Rating], [ReviewCount], [FestivalTag], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'c3000001-0000-0000-0000-000000000004', N'Navgraha Shanti', N'navgraha-shanti', N'Navgraha Shanti', N'Pacify all nine planets for harmony and success.', CAST(7500.00 AS Decimal(18, 2)), NULL, 240, N'/images/pooja/navgraha-shanti.jpg', 0, CAST(4.6 AS Decimal(3, 1)), 70, N'Navratri', CAST(N'2026-08-31T13:59:39.0600000' AS DateTime2), NULL, 1)
INSERT [dbo].[PoojaServices] ([Id], [Name], [Slug], [Category], [Description], [Price], [SalePrice], [DurationMinutes], [ImageUrl], [IsFeatured], [Rating], [ReviewCount], [FestivalTag], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'c3000001-0000-0000-0000-000000000005', N'Rudrabhishek', N'rudrabhishek', N'Rudrabhishek', N'Powerful Shiva worship for spiritual growth and protection.', CAST(4100.00 AS Decimal(18, 2)), CAST(3280.00 AS Decimal(18, 2)), 150, N'/images/pooja/rudrabhishek.jpg', 1, CAST(4.7 AS Decimal(3, 1)), 110, N'Maha Shivratri', CAST(N'2026-08-31T13:59:39.0600000' AS DateTime2), NULL, 1)
INSERT [dbo].[PoojaServices] ([Id], [Name], [Slug], [Category], [Description], [Price], [SalePrice], [DurationMinutes], [ImageUrl], [IsFeatured], [Rating], [ReviewCount], [FestivalTag], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'c3000001-0000-0000-0000-000000000006', N'Durga Puja', N'durga-puja', N'Durga Puja', N'Invoke Goddess Durga for strength and victory over obstacles.', CAST(5500.00 AS Decimal(18, 2)), CAST(4125.00 AS Decimal(18, 2)), 180, N'/images/pooja/durga-puja.jpg', 1, CAST(4.8 AS Decimal(3, 1)), 130, N'Navratri', CAST(N'2026-08-31T13:59:39.0600000' AS DateTime2), NULL, 1)
INSERT [dbo].[PoojaServices] ([Id], [Name], [Slug], [Category], [Description], [Price], [SalePrice], [DurationMinutes], [ImageUrl], [IsFeatured], [Rating], [ReviewCount], [FestivalTag], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'c3000001-0000-0000-0000-000000000007', N'Lakshmi Puja', N'lakshmi-puja', N'Lakshmi Puja', N'Attract wealth and abundance with sacred Lakshmi worship.', CAST(3100.00 AS Decimal(18, 2)), CAST(2170.00 AS Decimal(18, 2)), 120, N'/images/pooja/lakshmi-puja.jpg', 1, CAST(4.9 AS Decimal(3, 1)), 150, N'Diwali', CAST(N'2026-08-31T13:59:39.0600000' AS DateTime2), NULL, 1)
INSERT [dbo].[PoojaServices] ([Id], [Name], [Slug], [Category], [Description], [Price], [SalePrice], [DurationMinutes], [ImageUrl], [IsFeatured], [Rating], [ReviewCount], [FestivalTag], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'c3000001-0000-0000-0000-000000000008', N'Mundan Sanskar', N'mundan-sanskar', N'Mundan Sanskar', N'Traditional first haircut ceremony for children.', CAST(2100.00 AS Decimal(18, 2)), NULL, 60, N'/images/pooja/mundan-sanskar.jpg', 0, CAST(4.5 AS Decimal(3, 1)), 60, NULL, CAST(N'2026-08-31T13:59:39.0600000' AS DateTime2), NULL, 1)
INSERT [dbo].[PoojaServices] ([Id], [Name], [Slug], [Category], [Description], [Price], [SalePrice], [DurationMinutes], [ImageUrl], [IsFeatured], [Rating], [ReviewCount], [FestivalTag], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'c3000001-0000-0000-0000-000000000009', N'Vivah Puja', N'vivah-puja', N'Vivah Puja', N'Complete Vedic wedding ceremony with all rituals.', CAST(15000.00 AS Decimal(18, 2)), NULL, 360, N'/images/pooja/vivah-puja.jpg', 1, CAST(4.9 AS Decimal(3, 1)), 45, NULL, CAST(N'2026-08-31T13:59:39.0600000' AS DateTime2), NULL, 1)
INSERT [dbo].[PoojaServices] ([Id], [Name], [Slug], [Category], [Description], [Price], [SalePrice], [DurationMinutes], [ImageUrl], [IsFeatured], [Rating], [ReviewCount], [FestivalTag], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'c3000001-0000-0000-0000-000000000010', N'Yajna', N'yajna', N'Yajna', N'Sacred fire ritual for purification and divine blessings.', CAST(8500.00 AS Decimal(18, 2)), NULL, 300, N'/images/pooja/yajna.jpg', 0, CAST(4.6 AS Decimal(3, 1)), 55, NULL, CAST(N'2026-08-31T13:59:39.0600000' AS DateTime2), NULL, 1)
INSERT [dbo].[ProductCategories] ([Id], [Name], [Slug], [Description], [ImageUrl], [ParentId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'd4000001-0000-0000-0000-000000000001', N'Gemstones', N'gemstones', N'Authentic Gemstones for spiritual practice', NULL, NULL, CAST(N'2026-08-31T13:59:39.0833333' AS DateTime2), NULL, 1)
INSERT [dbo].[ProductCategories] ([Id], [Name], [Slug], [Description], [ImageUrl], [ParentId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'd4000001-0000-0000-0000-000000000002', N'Malas', N'malas', N'Authentic Malas for spiritual practice', NULL, NULL, CAST(N'2026-08-31T13:59:39.0833333' AS DateTime2), NULL, 1)
INSERT [dbo].[ProductCategories] ([Id], [Name], [Slug], [Description], [ImageUrl], [ParentId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'd4000001-0000-0000-0000-000000000003', N'Pooja Samagri', N'pooja-samagri', N'Authentic Pooja Samagri for spiritual practice', NULL, NULL, CAST(N'2026-08-31T13:59:39.0833333' AS DateTime2), NULL, 1)
INSERT [dbo].[ProductCategories] ([Id], [Name], [Slug], [Description], [ImageUrl], [ParentId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'd4000001-0000-0000-0000-000000000004', N'Spiritual Books', N'spiritual-books', N'Authentic Spiritual Books for spiritual practice', NULL, NULL, CAST(N'2026-08-31T13:59:39.0833333' AS DateTime2), NULL, 1)
INSERT [dbo].[ProductCategories] ([Id], [Name], [Slug], [Description], [ImageUrl], [ParentId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'd4000001-0000-0000-0000-000000000005', N'Idols & Images', N'idols', N'Authentic Idols & Images for spiritual practice', NULL, NULL, CAST(N'2026-08-31T13:59:39.0833333' AS DateTime2), NULL, 1)
INSERT [dbo].[ProductCategories] ([Id], [Name], [Slug], [Description], [ImageUrl], [ParentId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'd4000001-0000-0000-0000-000000000006', N'Yantras', N'yantras', N'Authentic Yantras for spiritual practice', NULL, NULL, CAST(N'2026-08-31T13:59:39.0833333' AS DateTime2), NULL, 1)
INSERT [dbo].[ProductCategories] ([Id], [Name], [Slug], [Description], [ImageUrl], [ParentId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'd4000001-0000-0000-0000-000000000007', N'Rudraksha', N'rudraksha', N'Authentic Rudraksha for spiritual practice', NULL, NULL, CAST(N'2026-08-31T13:59:39.0833333' AS DateTime2), NULL, 1)
INSERT [dbo].[ProductCategories] ([Id], [Name], [Slug], [Description], [ImageUrl], [ParentId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'd4000001-0000-0000-0000-000000000008', N'Home Decor', N'home-decor', N'Authentic Home Decor for spiritual practice', NULL, NULL, CAST(N'2026-08-31T13:59:39.0833333' AS DateTime2), NULL, 1)
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsPrimary], [SortOrder], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'f6000001-0000-0000-0000-000000000001', N'e5000001-0000-0000-0000-000000000001', N'/images/products/9ed971e5-190e-476e-8af9-055fb5b2bdd4.jpg', 1, 0, CAST(N'2026-08-31T13:59:39.1400000' AS DateTime2), NULL, 1)
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsPrimary], [SortOrder], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'f6000001-0000-0000-0000-000000000002', N'e5000001-0000-0000-0000-000000000002', N'/images/products/3efb4b2c-d17d-44d2-a473-7b3e9c41742d.jpeg', 1, 0, CAST(N'2026-08-31T13:59:39.1400000' AS DateTime2), NULL, 1)
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsPrimary], [SortOrder], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'f6000001-0000-0000-0000-000000000003', N'e5000001-0000-0000-0000-000000000003', N'/images/products/1d9a9dd9-df4b-4d69-adc1-0716ba234c19.png', 1, 0, CAST(N'2026-08-31T13:59:39.1400000' AS DateTime2), NULL, 1)
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsPrimary], [SortOrder], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'f6000001-0000-0000-0000-000000000004', N'e5000001-0000-0000-0000-000000000004', N'/images/products/8423b6e4-4bbf-4d6e-8f8a-6d369b550e0f.jpg', 1, 0, CAST(N'2026-08-31T13:59:39.1400000' AS DateTime2), NULL, 1)
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsPrimary], [SortOrder], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'f6000001-0000-0000-0000-000000000005', N'e5000001-0000-0000-0000-000000000005', N'/images/products/bhagavad-gita-hindi.jpg', 1, 0, CAST(N'2026-08-31T13:59:39.1400000' AS DateTime2), NULL, 1)
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsPrimary], [SortOrder], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'f6000001-0000-0000-0000-000000000006', N'e5000001-0000-0000-0000-000000000006', N'/images/products/e9c1b127-1386-4446-845a-ca496d62e21e.png', 1, 0, CAST(N'2026-08-31T13:59:39.1400000' AS DateTime2), NULL, 1)
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsPrimary], [SortOrder], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'f6000001-0000-0000-0000-000000000007', N'e5000001-0000-0000-0000-000000000007', N'/images/products/af0e0e51-9f33-4ad9-9e60-32995d263377.jpg', 1, 0, CAST(N'2026-08-31T13:59:39.1400000' AS DateTime2), NULL, 1)
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsPrimary], [SortOrder], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'f6000001-0000-0000-0000-000000000008', N'e5000001-0000-0000-0000-000000000008', N'/images/products/rudraksha-7-mukhi.jpg', 1, 0, CAST(N'2026-08-31T13:59:39.1400000' AS DateTime2), NULL, 1)
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsPrimary], [SortOrder], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'f6000001-0000-0000-0000-000000000009', N'e5000001-0000-0000-0000-000000000009', N'/images/products/incense-sticks-set.jpg', 1, 0, CAST(N'2026-08-31T13:59:39.1400000' AS DateTime2), NULL, 1)
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsPrimary], [SortOrder], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'f6000001-0000-0000-0000-000000000010', N'e5000001-0000-0000-0000-000000000010', N'/images/products/krishna-wall-hanging.jpg', 1, 0, CAST(N'2026-08-31T13:59:39.1400000' AS DateTime2), NULL, 1)
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsPrimary], [SortOrder], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'f6000001-0000-0000-0000-000000000011', N'e5000001-0000-0000-0000-000000000011', N'/images/products/yellow-sapphire.jpg', 1, 0, CAST(N'2026-08-31T13:59:39.1400000' AS DateTime2), NULL, 1)
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsPrimary], [SortOrder], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'f6000001-0000-0000-0000-000000000012', N'e5000001-0000-0000-0000-000000000012', N'/images/products/tulsi-mala.jpg', 1, 0, CAST(N'2026-08-31T13:59:39.1400000' AS DateTime2), NULL, 1)
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsPrimary], [SortOrder], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'9049a32b-62df-4f64-b74c-22c23d8e54e4', N'55633889-a468-43a1-a935-c696599afe2e', N'/images/products/f9de23eb-efb7-4552-8fc4-8bbd95490a85.png', 1, 0, CAST(N'2026-09-04T06:21:03.8702510' AS DateTime2), NULL, 1)
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsPrimary], [SortOrder], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'9abcecad-f1b7-4242-a42d-2616e6e79960', N'24cd92d0-d527-43c3-bd54-e512d9320709', N'/images/products/da0c6333-fbeb-49f0-b497-291b8df44945.png', 1, 0, CAST(N'2026-09-03T10:28:16.1429570' AS DateTime2), NULL, 1)
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsPrimary], [SortOrder], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'985d3269-8773-4948-beeb-ac3136a1111d', N'd6765c1d-b64f-4126-898c-9464100164c5', N'/images/products/fbea6689-98b6-4ad3-82fc-f7ab06c8f9cb.jpeg', 1, 0, CAST(N'2026-09-06T09:06:36.0962830' AS DateTime2), NULL, 1)
INSERT [dbo].[ProductImages] ([Id], [ProductId], [ImageUrl], [IsPrimary], [SortOrder], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'46e49350-fbbb-4a1f-956e-e20fc17e408b', N'5386caf6-7b30-4cd3-b784-d9b1540e003f', N'/images/products/d392796a-f232-439c-8b8f-fda0ac0d48d6.png', 1, 0, CAST(N'2026-09-02T08:42:43.3361160' AS DateTime2), NULL, 1)
INSERT [dbo].[Products] ([Id], [Name], [Slug], [Description], [CategoryId], [Price], [SalePrice], [StockQuantity], [Sku], [Rating], [ReviewCount], [IsFeatured], [FestivalTag], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'e5000001-0000-0000-0000-000000000001', N'Natural Ruby (Manik)', N'ruby-manik', N'Certified natural ruby for Sun planet remedies.', N'd4000001-0000-0000-0000-000000000001', CAST(25000.00 AS Decimal(18, 2)), CAST(22500.00 AS Decimal(18, 2)), 10, N'VM-RUBY-01', CAST(4.5 AS Decimal(3, 1)), 80, 1, N'Diwali', CAST(N'2026-08-31T13:59:39.1133333' AS DateTime2), CAST(N'2026-09-06T08:58:00.7902800' AS DateTime2), 1)
INSERT [dbo].[Products] ([Id], [Name], [Slug], [Description], [CategoryId], [Price], [SalePrice], [StockQuantity], [Sku], [Rating], [ReviewCount], [IsFeatured], [FestivalTag], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'e5000001-0000-0000-0000-000000000002', N'Blue Sapphire (Neelam)', N'blue-sapphire', N'Premium Ceylon blue sapphire for Saturn.', N'd4000001-0000-0000-0000-000000000001', CAST(45000.00 AS Decimal(18, 2)), NULL, 10, N'VM-BLUE-01', CAST(4.5 AS Decimal(3, 1)), 45, 1, NULL, CAST(N'2026-08-31T13:59:39.1133333' AS DateTime2), CAST(N'2026-09-03T08:18:35.8342830' AS DateTime2), 1)
INSERT [dbo].[Products] ([Id], [Name], [Slug], [Description], [CategoryId], [Price], [SalePrice], [StockQuantity], [Sku], [Rating], [ReviewCount], [IsFeatured], [FestivalTag], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'e5000001-0000-0000-0000-000000000003', N'5 Mukhi Rudraksha Mala', N'rudraksha-mala-5', N'Authentic Nepali 5 Mukhi Rudraksha mala, 108 beads.', N'd4000001-0000-0000-0000-000000000002', CAST(1200.00 AS Decimal(18, 2)), CAST(960.00 AS Decimal(18, 2)), 48, N'VM-MALA-01', CAST(4.5 AS Decimal(3, 1)), 120, 1, NULL, CAST(N'2026-08-31T13:59:39.1133333' AS DateTime2), CAST(N'2026-09-03T08:18:50.1184750' AS DateTime2), 1)
INSERT [dbo].[Products] ([Id], [Name], [Slug], [Description], [CategoryId], [Price], [SalePrice], [StockQuantity], [Sku], [Rating], [ReviewCount], [IsFeatured], [FestivalTag], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'e5000001-0000-0000-0000-000000000004', N'Puja Thali Set (Brass)', N'puja-thali-brass', N'Complete brass puja thali with diya, bell, and kalash.', N'd4000001-0000-0000-0000-000000000003', CAST(899.00 AS Decimal(18, 2)), NULL, 10, N'VM-THALI-01', CAST(4.4 AS Decimal(3, 1)), 90, 0, NULL, CAST(N'2026-08-31T13:59:39.1133333' AS DateTime2), CAST(N'2026-09-03T08:19:01.5461420' AS DateTime2), 1)
INSERT [dbo].[Products] ([Id], [Name], [Slug], [Description], [CategoryId], [Price], [SalePrice], [StockQuantity], [Sku], [Rating], [ReviewCount], [IsFeatured], [FestivalTag], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'e5000001-0000-0000-0000-000000000005', N'Bhagavad Gita (Hindi)', N'bhagavad-gita-hindi', N'Illustrated Bhagavad Gita with commentary.', N'd4000001-0000-0000-0000-000000000004', CAST(350.00 AS Decimal(18, 2)), CAST(280.00 AS Decimal(18, 2)), 199, N'VM-GITA-01', CAST(4.8 AS Decimal(3, 1)), 150, 1, NULL, CAST(N'2026-08-31T13:59:39.1133333' AS DateTime2), NULL, 1)
INSERT [dbo].[Products] ([Id], [Name], [Slug], [Description], [CategoryId], [Price], [SalePrice], [StockQuantity], [Sku], [Rating], [ReviewCount], [IsFeatured], [FestivalTag], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'e5000001-0000-0000-0000-000000000006', N'Brass Ganesha Idol', N'ganesha-idol-brass', N'Handcrafted brass Ganesha idol, 6 inches.', N'd4000001-0000-0000-0000-000000000005', CAST(1499.00 AS Decimal(18, 2)), CAST(1199.00 AS Decimal(18, 2)), 29, N'VM-GANESHA-01', CAST(4.6 AS Decimal(3, 1)), 75, 1, N'Ganesh Chaturthi', CAST(N'2026-08-31T13:59:39.1133333' AS DateTime2), CAST(N'2026-09-03T08:19:17.5143110' AS DateTime2), 1)
INSERT [dbo].[Products] ([Id], [Name], [Slug], [Description], [CategoryId], [Price], [SalePrice], [StockQuantity], [Sku], [Rating], [ReviewCount], [IsFeatured], [FestivalTag], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'e5000001-0000-0000-0000-000000000007', N'Sri Yantra (Copper)', N'sri-yantra-copper', N'Energized Sri Yantra for prosperity and success.', N'd4000001-0000-0000-0000-000000000006', CAST(2100.00 AS Decimal(18, 2)), NULL, 25, N'VM-YANTRA-01', CAST(4.7 AS Decimal(3, 1)), 60, 1, N'Diwali', CAST(N'2026-08-31T13:59:39.1133333' AS DateTime2), CAST(N'2026-09-03T08:33:21.7150470' AS DateTime2), 1)
INSERT [dbo].[Products] ([Id], [Name], [Slug], [Description], [CategoryId], [Price], [SalePrice], [StockQuantity], [Sku], [Rating], [ReviewCount], [IsFeatured], [FestivalTag], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'e5000001-0000-0000-0000-000000000008', N'7 Mukhi Rudraksha', N'rudraksha-7-mukhi', N'Rare 7 Mukhi Rudraksha from Nepal.', N'd4000001-0000-0000-0000-000000000007', CAST(3500.00 AS Decimal(18, 2)), CAST(2800.00 AS Decimal(18, 2)), 10, N'VM-RUDRA-01', CAST(4.5 AS Decimal(3, 1)), 40, 0, NULL, CAST(N'2026-08-31T13:59:39.1133333' AS DateTime2), CAST(N'2026-09-02T09:11:52.7589790' AS DateTime2), 1)
INSERT [dbo].[Products] ([Id], [Name], [Slug], [Description], [CategoryId], [Price], [SalePrice], [StockQuantity], [Sku], [Rating], [ReviewCount], [IsFeatured], [FestivalTag], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'e5000001-0000-0000-0000-000000000009', N'Incense Sticks Set', N'incense-sticks-set', N'Premium sandalwood and rose incense, 12 packs.', N'd4000001-0000-0000-0000-000000000003', CAST(499.00 AS Decimal(18, 2)), NULL, 150, N'VM-INCENSE-01', CAST(4.3 AS Decimal(3, 1)), 110, 0, NULL, CAST(N'2026-08-31T13:59:39.1133333' AS DateTime2), NULL, 1)
INSERT [dbo].[Products] ([Id], [Name], [Slug], [Description], [CategoryId], [Price], [SalePrice], [StockQuantity], [Sku], [Rating], [ReviewCount], [IsFeatured], [FestivalTag], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'e5000001-0000-0000-0000-000000000010', N'Krishna Wall Hanging', N'krishna-wall-hanging', N'Beautiful Krishna devotional wall art with frame.', N'd4000001-0000-0000-0000-000000000008', CAST(799.00 AS Decimal(18, 2)), CAST(639.00 AS Decimal(18, 2)), 40, N'VM-KRISHNA-01', CAST(4.6 AS Decimal(3, 1)), 55, 1, N'Krishna Janmashtami', CAST(N'2026-08-31T13:59:39.1133333' AS DateTime2), NULL, 1)
INSERT [dbo].[Products] ([Id], [Name], [Slug], [Description], [CategoryId], [Price], [SalePrice], [StockQuantity], [Sku], [Rating], [ReviewCount], [IsFeatured], [FestivalTag], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'e5000001-0000-0000-0000-000000000011', N'Yellow Sapphire (Pukhraj)', N'yellow-sapphire', N'Natural yellow sapphire for Jupiter blessings.', N'd4000001-0000-0000-0000-000000000001', CAST(35000.00 AS Decimal(18, 2)), CAST(31500.00 AS Decimal(18, 2)), 6, N'VM-PUKHRAJ-01', CAST(4.8 AS Decimal(3, 1)), 35, 1, NULL, CAST(N'2026-08-31T13:59:39.1133333' AS DateTime2), NULL, 1)
INSERT [dbo].[Products] ([Id], [Name], [Slug], [Description], [CategoryId], [Price], [SalePrice], [StockQuantity], [Sku], [Rating], [ReviewCount], [IsFeatured], [FestivalTag], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'e5000001-0000-0000-0000-000000000012', N'Tulsi Mala', N'tulsi-mala', N'Sacred Tulsi mala for chanting and meditation.', N'd4000001-0000-0000-0000-000000000002', CAST(299.00 AS Decimal(18, 2)), NULL, 79, N'VM-TULSI-01', CAST(4.4 AS Decimal(3, 1)), 95, 0, NULL, CAST(N'2026-08-31T13:59:39.1133333' AS DateTime2), NULL, 1)
INSERT [dbo].[Products] ([Id], [Name], [Slug], [Description], [CategoryId], [Price], [SalePrice], [StockQuantity], [Sku], [Rating], [ReviewCount], [IsFeatured], [FestivalTag], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'd6765c1d-b64f-4126-898c-9464100164c5', N'Pooja thali', N'pooja-thali', N'pooja items', N'd4000001-0000-0000-0000-000000000003', CAST(500.00 AS Decimal(18, 2)), CAST(299.00 AS Decimal(18, 2)), 10, N'VM-POOJA-THALI', CAST(0.0 AS Decimal(3, 1)), 0, 1, N'diwali items', CAST(N'2026-09-06T09:06:36.0962740' AS DateTime2), CAST(N'2026-09-06T09:08:45.1654420' AS DateTime2), 1)
INSERT [dbo].[Products] ([Id], [Name], [Slug], [Description], [CategoryId], [Price], [SalePrice], [StockQuantity], [Sku], [Rating], [ReviewCount], [IsFeatured], [FestivalTag], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'55633889-a468-43a1-a935-c696599afe2e', N'2345678', N'2345678', N'r8653q4t7aw9ryt8ry7go8gw', N'd4000001-0000-0000-0000-000000000001', CAST(9834.00 AS Decimal(18, 2)), CAST(99.00 AS Decimal(18, 2)), 788, N'VM-2345678', CAST(0.0 AS Decimal(3, 1)), 0, 1, NULL, CAST(N'2026-09-04T06:21:03.8687180' AS DateTime2), NULL, 1)
INSERT [dbo].[Products] ([Id], [Name], [Slug], [Description], [CategoryId], [Price], [SalePrice], [StockQuantity], [Sku], [Rating], [ReviewCount], [IsFeatured], [FestivalTag], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'5386caf6-7b30-4cd3-b784-d9b1540e003f', N'alfgalkljfdg', N'alfgalkljfdg', N'liyuiuya biulaffguilrgflhuirghliughuhguhguhgiuhuieegegeggg', N'd4000001-0000-0000-0000-000000000008', CAST(999.00 AS Decimal(18, 2)), CAST(988.00 AS Decimal(18, 2)), 10, N'VM-ALFGALKLJFDG', CAST(0.0 AS Decimal(3, 1)), 0, 1, NULL, CAST(N'2026-09-02T08:42:43.3361100' AS DateTime2), CAST(N'2026-09-02T09:11:37.8346180' AS DateTime2), 0)
INSERT [dbo].[Products] ([Id], [Name], [Slug], [Description], [CategoryId], [Price], [SalePrice], [StockQuantity], [Sku], [Rating], [ReviewCount], [IsFeatured], [FestivalTag], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'24cd92d0-d527-43c3-bd54-e512d9320709', N'ASDFG', N'asdfg', N'ARTYGHJK', N'd4000001-0000-0000-0000-000000000002', CAST(9999.00 AS Decimal(18, 2)), CAST(999.00 AS Decimal(18, 2)), 10, N'VM-ASDFG', CAST(0.0 AS Decimal(3, 1)), 0, 0, NULL, CAST(N'2026-09-03T10:28:16.1422900' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'a09a4a09-94a5-44a8-ba95-01bfd7f9ac09', N'11111111-1111-1111-1111-111111111111', N'eac8a89f-eb7e-479c-983c-54e5060a8675', CAST(N'2026-08-31T14:48:36.5700000' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'143d06a2-4fd6-4997-aad8-01d98ca5e50f', N'11111111-1111-1111-1111-111111111111', N'5f8d6c9d-44e5-470d-8a1e-da93491aa194', CAST(N'2026-08-31T14:48:36.5700000' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'cad8cc57-2939-4f1b-8c6b-0b24142abff6', N'11111111-1111-1111-1111-111111111111', N'c6579a62-e9ec-423d-9dcd-2bc3ac604b0b', CAST(N'2026-08-31T14:48:36.5700000' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'9a36e5b4-6d70-4883-ae50-0c64f4a71082', N'11111111-1111-1111-1111-111111111111', N'cddb559b-9ef9-434e-be91-70bb2991c646', CAST(N'2026-08-31T14:48:36.5700000' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'adf53e09-bff1-4a69-b028-148e815021f7', N'11111111-1111-1111-1111-111111111111', N'3a76ebbb-27ed-49a3-a86b-519f74479998', CAST(N'2026-08-31T14:48:36.5700000' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'70d38378-7651-477a-8a08-16c3e79424ee', N'11111111-1111-1111-1111-111111111111', N'68e712e9-0c2c-48ec-b23f-8d400f070c52', CAST(N'2026-08-31T14:48:36.5700000' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'f2c3059e-5072-4bd6-bca8-223f5911955a', N'11111111-1111-1111-1111-111111111111', N'0bb3063a-a39d-47cd-90c4-646787942e27', CAST(N'2026-08-31T14:48:36.5700000' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'ba66ba73-c782-4858-be54-25b81510a846', N'11111111-1111-1111-1111-111111111111', N'9a313137-aa9f-4059-8a7b-b96a7190100f', CAST(N'2026-08-31T14:48:36.5700000' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'ea85417a-dd76-4a7a-ab0d-2f2ea8b697e9', N'22222222-2222-2222-2222-222222222222', N'42a2cb6a-35e0-4af1-ad03-50e06376613b', CAST(N'2026-08-31T14:48:36.5833333' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'1173f867-5e5e-4363-81dc-30ebb5399429', N'11111111-1111-1111-1111-111111111111', N'174156b7-a1c0-47f9-a1be-d5af0e62fce0', CAST(N'2026-08-31T14:48:36.5700000' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'3b6b7949-b0df-4f21-9825-38be86695be1', N'11111111-1111-1111-1111-111111111111', N'3b4e8571-4b1e-47e3-b54b-c9a21b206466', CAST(N'2026-08-31T14:48:36.5700000' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'a0c899db-2a58-4943-882a-3d53c420115f', N'11111111-1111-1111-1111-111111111111', N'8c29c9c2-85b6-4957-988c-eb5a3b53ff33', CAST(N'2026-08-31T14:48:36.5700000' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'1eba5501-8b5a-4468-b32f-3ecc93c8868b', N'33333333-3333-3333-3333-333333333333', N'0bb3063a-a39d-47cd-90c4-646787942e27', CAST(N'2026-08-31T14:48:36.5900000' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'e7606c73-a0b6-489a-8c06-417b25681cff', N'22222222-2222-2222-2222-222222222222', N'333d38b7-da03-454e-966b-938235883fdd', CAST(N'2026-08-31T14:48:36.5833333' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'473c13af-124e-415d-8f40-4a79a4aa50ff', N'11111111-1111-1111-1111-111111111111', N'31acbb1e-da6d-40d7-8f15-310940df8249', CAST(N'2026-08-31T14:48:36.5700000' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'3ba8ee84-636a-488a-aef3-4db4b68f74c3', N'33333333-3333-3333-3333-333333333333', N'eac8a89f-eb7e-479c-983c-54e5060a8675', CAST(N'2026-08-31T14:48:36.5900000' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'f7591a8e-96ec-4e8c-9b57-535fd10f1798', N'22222222-2222-2222-2222-222222222222', N'31acbb1e-da6d-40d7-8f15-310940df8249', CAST(N'2026-08-31T14:48:36.5833333' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'deea4c59-e3ac-4461-b11f-5506fa9c74b9', N'33333333-3333-3333-3333-333333333333', N'72ec1694-a6ef-49f9-bb21-569dbcaf940b', CAST(N'2026-08-31T14:48:36.5900000' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'442fb246-48e1-4224-955a-5b4ecc6f06a4', N'11111111-1111-1111-1111-111111111111', N'c4c921d4-3756-4707-91a4-35393d9ee5d5', CAST(N'2026-08-31T14:48:36.5700000' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'91ca947a-4c1c-4aeb-8f90-5b89c78ad00e', N'11111111-1111-1111-1111-111111111111', N'0e16ac84-7db3-4232-b19a-b9e691ace400', CAST(N'2026-08-31T14:48:36.5700000' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'48207939-145d-4a24-954f-5dba5a367ce2', N'33333333-3333-3333-3333-333333333333', N'647eb9b1-2608-463b-8139-8b59f72525f6', CAST(N'2026-08-31T14:48:36.5900000' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'6259d6e3-c8b0-49de-b227-68317b26cfcc', N'33333333-3333-3333-3333-333333333333', N'3daa9ce8-4d36-4630-9bf5-2e8e726d4c25', CAST(N'2026-08-31T14:48:36.5900000' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'141c79bb-d02a-4860-916c-705a315f7851', N'11111111-1111-1111-1111-111111111111', N'e6aca605-921a-48aa-8974-92b3c1eb977e', CAST(N'2026-08-31T14:48:36.5700000' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'3f72e306-0f01-4de6-94f9-71eb194f078e', N'11111111-1111-1111-1111-111111111111', N'647eb9b1-2608-463b-8139-8b59f72525f6', CAST(N'2026-08-31T14:48:36.5700000' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'a3c7303a-2240-42b7-902d-752c049e9b97', N'33333333-3333-3333-3333-333333333333', N'333d38b7-da03-454e-966b-938235883fdd', CAST(N'2026-08-31T14:48:36.5900000' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'5112b721-c8d8-44a7-af33-7630677c3ab1', N'11111111-1111-1111-1111-111111111111', N'32271a88-046e-44e5-98d9-9796f6a7ecb7', CAST(N'2026-08-31T14:48:36.5700000' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'b8a5ac6a-69d9-496c-a944-80b6b049f5e3', N'11111111-1111-1111-1111-111111111111', N'42a2cb6a-35e0-4af1-ad03-50e06376613b', CAST(N'2026-08-31T14:48:36.5700000' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'b78d1991-7595-4813-8530-85295a68c5fd', N'33333333-3333-3333-3333-333333333333', N'0e16ac84-7db3-4232-b19a-b9e691ace400', CAST(N'2026-08-31T14:48:36.5900000' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'5d6e6278-befb-495a-8fe0-859d7b63da89', N'33333333-3333-3333-3333-333333333333', N'32271a88-046e-44e5-98d9-9796f6a7ecb7', CAST(N'2026-08-31T14:48:36.5900000' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'4c1c8cde-8647-416c-a8ea-87bbf82baa3b', N'33333333-3333-3333-3333-333333333333', N'917e5862-4cb7-4764-8ecf-97d48c69a8c8', CAST(N'2026-08-31T14:48:36.5900000' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'9d4e2cfc-3878-4486-bbfe-89608b1c90a7', N'11111111-1111-1111-1111-111111111111', N'3daa9ce8-4d36-4630-9bf5-2e8e726d4c25', CAST(N'2026-08-31T14:48:36.5700000' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'abaf8b21-f53f-42eb-b343-8bb070ce4999', N'11111111-1111-1111-1111-111111111111', N'72ec1694-a6ef-49f9-bb21-569dbcaf940b', CAST(N'2026-08-31T14:48:36.5700000' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'd9c35fcc-f82a-4d22-b968-9ad0905e73a4', N'11111111-1111-1111-1111-111111111111', N'29a03e13-d514-4f8a-82d8-33ecc5054246', CAST(N'2026-08-31T14:48:36.5700000' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'c527b4ab-5eaf-4f95-965e-a512e32db9fe', N'33333333-3333-3333-3333-333333333333', N'9a313137-aa9f-4059-8a7b-b96a7190100f', CAST(N'2026-08-31T14:48:36.5900000' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'fbf0f78e-a46a-470b-9ad1-a6bee50d9cc9', N'11111111-1111-1111-1111-111111111111', N'128d2adb-1656-41e5-a466-0d97fae3e122', CAST(N'2026-08-31T14:48:36.5700000' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'4fa803d5-786a-40a1-ba20-adbb260b0c18', N'22222222-2222-2222-2222-222222222222', N'32271a88-046e-44e5-98d9-9796f6a7ecb7', CAST(N'2026-08-31T14:48:36.5833333' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'03fecbb2-0d25-49af-a62f-b48a965c44fb', N'11111111-1111-1111-1111-111111111111', N'130b497b-f263-4acb-980f-0de56b78b935', CAST(N'2026-08-31T14:48:36.5700000' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'c0a70231-4600-4afa-abd2-d5047698bf5f', N'11111111-1111-1111-1111-111111111111', N'bc76a4fb-d7b5-48bf-8c00-eeb583776618', CAST(N'2026-08-31T14:48:36.5700000' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'a2f129b6-8b81-4801-86fd-d6849cce5fb4', N'11111111-1111-1111-1111-111111111111', N'144daf1d-059a-45a7-bf4c-72b763fc8159', CAST(N'2026-08-31T14:48:36.5700000' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'52af5352-ea23-48a3-a133-d7135c6310da', N'11111111-1111-1111-1111-111111111111', N'917e5862-4cb7-4764-8ecf-97d48c69a8c8', CAST(N'2026-08-31T14:48:36.5700000' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'08894be2-8c4b-459d-8e53-e2f3628c38a7', N'22222222-2222-2222-2222-222222222222', N'3daa9ce8-4d36-4630-9bf5-2e8e726d4c25', CAST(N'2026-08-31T14:48:36.5833333' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'385449ba-3d45-4122-90e9-e44238723594', N'33333333-3333-3333-3333-333333333333', N'e6aca605-921a-48aa-8974-92b3c1eb977e', CAST(N'2026-08-31T14:48:36.5900000' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'0454bead-040f-414d-b451-f5d7c6420b90', N'11111111-1111-1111-1111-111111111111', N'333d38b7-da03-454e-966b-938235883fdd', CAST(N'2026-08-31T14:48:36.5700000' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'775a9e18-75e8-4d90-b260-fcb3c63af070', N'11111111-1111-1111-1111-111111111111', N'5dbf9feb-347b-4f16-b794-9fd1b01ac647', CAST(N'2026-08-31T14:48:36.5700000' AS DateTime2), NULL, 1)
INSERT [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'9151541f-5467-4c86-ada8-fdc4709eccec', N'11111111-1111-1111-1111-111111111111', N'aa8651bd-ce2a-4798-b8ae-cd64900b9d47', CAST(N'2026-08-31T14:48:36.5700000' AS DateTime2), NULL, 1)
INSERT [dbo].[Roles] ([Id], [Name], [Code], [Description], [IsSystem], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'11111111-1111-1111-1111-111111111111', N'Super Admin', N'SuperAdmin', N'Full access - can view and manage everything including users, roles, permissions, billing, payments, orders, products, pooja services', 1, CAST(N'2026-08-31T14:44:33.3566667' AS DateTime2), NULL, 1)
INSERT [dbo].[Roles] ([Id], [Name], [Code], [Description], [IsSystem], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'22222222-2222-2222-2222-222222222222', N'Astrologer', N'Astrologer', N'Can see assigned pooja bookings, manage booking status, view customer details, manage payment status for assigned bookings', 1, CAST(N'2026-08-31T14:44:33.3566667' AS DateTime2), NULL, 1)
INSERT [dbo].[Roles] ([Id], [Name], [Code], [Description], [IsSystem], [CreatedAt], [UpdatedAt], [IsActive]) VALUES (N'33333333-3333-3333-3333-333333333333', N'Customer', N'Customer', N'Can order products, book pooja, get kundli, view own bookings, orders, product status, pooja status, assigned astrologer details', 1, CAST(N'2026-08-31T14:44:33.3566667' AS DateTime2), NULL, 1)
INSERT [dbo].[UserPermissions] ([UserId], [Permission]) VALUES (N'fe091691-bce9-44a6-8909-0b6949c390cf', 1)
INSERT [dbo].[UserPermissions] ([UserId], [Permission]) VALUES (N'fe091691-bce9-44a6-8909-0b6949c390cf', 2)
INSERT [dbo].[UserPermissions] ([UserId], [Permission]) VALUES (N'fe091691-bce9-44a6-8909-0b6949c390cf', 3)
INSERT [dbo].[UserPermissions] ([UserId], [Permission]) VALUES (N'fe091691-bce9-44a6-8909-0b6949c390cf', 4)
INSERT [dbo].[UserPermissions] ([UserId], [Permission]) VALUES (N'fe091691-bce9-44a6-8909-0b6949c390cf', 5)
INSERT [dbo].[Users] ([Id], [Email], [Phone], [PasswordHash], [FirstName], [LastName], [AvatarUrl], [Role], [RoleId], [EmailVerified], [PhoneVerified], [LastLoginAt], [RefreshToken], [RefreshTokenExpiry], [CreatedAt], [UpdatedAt], [IsActive], [IsStaffApproved]) VALUES (N'37073ee0-5cee-4eaf-9f26-09aee0d02f60', N'rajmarothiai@gmail.com', N'9812112212', N'$2a$11$DWLWZwOdB3rOAJ7vVwNXM.UVQwxvn9F64UYLMwXa1hOeQlmHXJqmu', N'rajesh', N'kumar', NULL, 3, NULL, 0, 0, CAST(N'2026-09-06T08:56:33.5064180' AS DateTime2), N'zp6+jdPBfIU4+bHioyeIbZe/gKIpdIt1CndsBK76ycoQGwWVdVL0XS7B9fowceJ70mtsAZ3X+FbIItEgGr2Lhw==', CAST(N'2026-09-13T08:56:33.5164340' AS DateTime2), CAST(N'2026-09-06T08:54:42.1978460' AS DateTime2), NULL, 1, 0)
INSERT [dbo].[Users] ([Id], [Email], [Phone], [PasswordHash], [FirstName], [LastName], [AvatarUrl], [Role], [RoleId], [EmailVerified], [PhoneVerified], [LastLoginAt], [RefreshToken], [RefreshTokenExpiry], [CreatedAt], [UpdatedAt], [IsActive], [IsStaffApproved]) VALUES (N'fe091691-bce9-44a6-8909-0b6949c390cf', N'ashok234@gmail.com', N'12456898654', N'$2a$11$kaiknOOSXrmaPqw678NCSOXwi5Hp6fO3go4viPwY324gMuzgmxula', N'Ashok', N'kumar', NULL, 3, NULL, 0, 0, CAST(N'2026-09-04T06:20:01.9931910' AS DateTime2), N'ay78XLicN9v7pxNZWPEVcV51KN30qr+6beq6VApGmP4dcJ+cBVr/CLWm7gqLEaASW1SgXRSx0Kod2SG2E5MEwg==', CAST(N'2026-09-13T08:39:01.8060320' AS DateTime2), CAST(N'2026-09-02T07:15:49.8454200' AS DateTime2), CAST(N'2026-09-04T06:20:18.7302700' AS DateTime2), 1, 1)
INSERT [dbo].[Users] ([Id], [Email], [Phone], [PasswordHash], [FirstName], [LastName], [AvatarUrl], [Role], [RoleId], [EmailVerified], [PhoneVerified], [LastLoginAt], [RefreshToken], [RefreshTokenExpiry], [CreatedAt], [UpdatedAt], [IsActive], [IsStaffApproved]) VALUES (N'52b7ddbb-4791-43c4-9335-3a76e3df3209', N'integration.test@example.com', N'9998887777', N'$2a$11$yTSRAjcwJr0HEGXtDF1IYOMEQW0F3sQ2nFPcjY5uFsdHWch50yDlG', N'Integration', N'Test', NULL, 3, NULL, 0, 0, NULL, N'6Rh/nXLWd25JnJUsv4MEWxK4WEj1djUA1Yy5Fat0qNJo4rmDejfT/upHr4xTslcTKcICSr1uxvrVsCg8SnNHNQ==', CAST(N'2026-09-07T16:18:01.8422670' AS DateTime2), CAST(N'2026-08-31T16:17:30.6585050' AS DateTime2), CAST(N'2026-08-31T16:18:01.7869530' AS DateTime2), 1, 0)
INSERT [dbo].[Users] ([Id], [Email], [Phone], [PasswordHash], [FirstName], [LastName], [AvatarUrl], [Role], [RoleId], [EmailVerified], [PhoneVerified], [LastLoginAt], [RefreshToken], [RefreshTokenExpiry], [CreatedAt], [UpdatedAt], [IsActive], [IsStaffApproved]) VALUES (N'f8e7cb48-c411-4725-b124-971a2854ebc1', N'admin@vadicmall.com', NULL, N'$2a$11$yXqGssu336kCH6Rcu.TkpO6JjYKe6v.MIBhmn/nw5OXeFvRt7kp82', N'Super', N'Admin', NULL, 1, NULL, 1, 0, CAST(N'2026-09-06T09:08:29.4960800' AS DateTime2), N'G0egC1lzco5QW0GXf8T7y1FbE3u2aCdfIgBRk3FrWdST7uc5FITgC1Gr42485C6DRKWQXCaxRzfxuJW4LQOZww==', CAST(N'2026-09-13T09:08:29.5031150' AS DateTime2), CAST(N'2026-08-31T15:49:10.3493680' AS DateTime2), NULL, 1, 0)
INSERT [dbo].[Users] ([Id], [Email], [Phone], [PasswordHash], [FirstName], [LastName], [AvatarUrl], [Role], [RoleId], [EmailVerified], [PhoneVerified], [LastLoginAt], [RefreshToken], [RefreshTokenExpiry], [CreatedAt], [UpdatedAt], [IsActive], [IsStaffApproved]) VALUES (N'c6f4f66e-4f5a-48de-8875-c5039d247ac1', N'sdfghj@gmail.com', N'9836563497', N'$2a$11$WsQE1eSMO05NTUM/iSPo0.M2aEcy7GJQsbCONY1CPlXJlzSHSJmBy', N'skhsbg', N'fv', NULL, 3, NULL, 0, 0, CAST(N'2026-09-02T07:13:35.1915760' AS DateTime2), N'Xe8oq+qb+4/vL36swAreNBHBEY2HRFRAf1G05JKS4lTQEPD5GRgFNUaZws6L6zPpdcKgsBG9L4dn/Ve63bhFfA==', CAST(N'2026-09-09T07:13:35.2033330' AS DateTime2), CAST(N'2026-09-02T07:12:30.0471840' AS DateTime2), CAST(N'2026-09-03T10:23:59.8508240' AS DateTime2), 1, 0)
INSERT [dbo].[Users] ([Id], [Email], [Phone], [PasswordHash], [FirstName], [LastName], [AvatarUrl], [Role], [RoleId], [EmailVerified], [PhoneVerified], [LastLoginAt], [RefreshToken], [RefreshTokenExpiry], [CreatedAt], [UpdatedAt], [IsActive], [IsStaffApproved]) VALUES (N'669ed981-df08-449d-9786-f03dbedcfa2a', N'ldjhyffldyf@gmail.comm', N'56456565666556', N'$2a$11$qg.3jzNEi3XGCMaDlUtijOfgxjGpCmaWR8QHwkEiWycFG.E7RezX.', N'aaaa', N'a', NULL, 2, NULL, 0, 0, CAST(N'2026-09-03T10:23:42.2499780' AS DateTime2), N'dQgkKiXSYsmK89x7/j/u/ef8oeTN+8V84T8ch8KURUoJMiwixUwrYDpvBR9HF0BCEoB/ckvcd/MVGKjR94HzHw==', CAST(N'2026-09-10T10:23:42.2574550' AS DateTime2), CAST(N'2026-09-02T09:16:23.4535250' AS DateTime2), CAST(N'2026-09-03T11:54:14.2987470' AS DateTime2), 0, 1)
/****** Object:  Index [UQ__Astrolog__1788CC4DD1D8C7C9]    Script Date: 09/06/2026 16:02:28 ******/
ALTER TABLE [dbo].[AstrologerProfiles] ADD UNIQUE NONCLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__BlogCate__BC7B5FB6B7B6EC2B]    Script Date: 09/06/2026 16:02:29 ******/
ALTER TABLE [dbo].[BlogCategories] ADD UNIQUE NONCLUSTERED 
(
	[Slug] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__BlogPost__BC7B5FB684D1E8BC]    Script Date: 09/06/2026 16:02:29 ******/
ALTER TABLE [dbo].[BlogPosts] ADD UNIQUE NONCLUSTERED 
(
	[Slug] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_CartItems_UserProduct]    Script Date: 09/06/2026 16:02:29 ******/
ALTER TABLE [dbo].[CartItems] ADD  CONSTRAINT [UQ_CartItems_UserProduct] UNIQUE NONCLUSTERED 
(
	[UserId] ASC,
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Coupons__A25C5AA7BA70562D]    Script Date: 09/06/2026 16:02:29 ******/
ALTER TABLE [dbo].[Coupons] ADD UNIQUE NONCLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__GiftCard__A25C5AA7E11D3465]    Script Date: 09/06/2026 16:02:29 ******/
ALTER TABLE [dbo].[GiftCards] ADD UNIQUE NONCLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Newslett__A9D10534B39752F9]    Script Date: 09/06/2026 16:02:29 ******/
ALTER TABLE [dbo].[NewsletterSubscribers] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Orders__CAC5E7433BD5A2EB]    Script Date: 09/06/2026 16:02:29 ******/
ALTER TABLE [dbo].[Orders] ADD UNIQUE NONCLUSTERED 
(
	[OrderNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Payments__C3905BCECC53B4EF]    Script Date: 09/06/2026 16:02:29 ******/
ALTER TABLE [dbo].[Payments] ADD UNIQUE NONCLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Permissi__A25C5AA76184D19E]    Script Date: 09/06/2026 16:02:29 ******/
ALTER TABLE [dbo].[Permissions] ADD UNIQUE NONCLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__PoojaSer__BC7B5FB69952F64B]    Script Date: 09/06/2026 16:02:29 ******/
ALTER TABLE [dbo].[PoojaServices] ADD UNIQUE NONCLUSTERED 
(
	[Slug] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__ProductC__BC7B5FB635ABEAF1]    Script Date: 09/06/2026 16:02:29 ******/
ALTER TABLE [dbo].[ProductCategories] ADD UNIQUE NONCLUSTERED 
(
	[Slug] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Products__BC7B5FB6344ABEBD]    Script Date: 09/06/2026 16:02:29 ******/
ALTER TABLE [dbo].[Products] ADD UNIQUE NONCLUSTERED 
(
	[Slug] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_RolePermissions]    Script Date: 09/06/2026 16:02:29 ******/
ALTER TABLE [dbo].[RolePermissions] ADD  CONSTRAINT [UQ_RolePermissions] UNIQUE NONCLUSTERED 
(
	[RoleId] ASC,
	[PermissionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Roles__737584F6D84E4D7F]    Script Date: 09/06/2026 16:02:29 ******/
ALTER TABLE [dbo].[Roles] ADD UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Roles__A25C5AA779929BC8]    Script Date: 09/06/2026 16:02:29 ******/
ALTER TABLE [dbo].[Roles] ADD UNIQUE NONCLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Settings__C41E028913D38DAC]    Script Date: 09/06/2026 16:02:29 ******/
ALTER TABLE [dbo].[Settings] ADD UNIQUE NONCLUSTERED 
(
	[Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Subscrip__BC7B5FB60B0E5993]    Script Date: 09/06/2026 16:02:29 ******/
ALTER TABLE [dbo].[SubscriptionPlans] ADD UNIQUE NONCLUSTERED 
(
	[Slug] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__A9D10534AE4CD244]    Script Date: 09/06/2026 16:02:29 ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_WishlistItems_UserId_ProductId]    Script Date: 09/06/2026 16:02:29 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_WishlistItems_UserId_ProductId] ON [dbo].[WishlistItems]
(
	[UserId] ASC,
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Addresses] ADD  CONSTRAINT [DF_Addresses_Country]  DEFAULT (N'India') FOR [Country]
GO
ALTER TABLE [dbo].[Addresses] ADD  CONSTRAINT [DF_Addresses_IsDefault]  DEFAULT ((0)) FOR [IsDefault]
GO
ALTER TABLE [dbo].[Addresses] ADD  CONSTRAINT [DF_Addresses_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[AstrologerProfiles] ADD  CONSTRAINT [DF_AstrologerProfiles_IsApproved]  DEFAULT ((0)) FOR [IsApproved]
GO
ALTER TABLE [dbo].[AstrologerProfiles] ADD  CONSTRAINT [DF_AstrologerProfiles_IsFeatured]  DEFAULT ((0)) FOR [IsFeatured]
GO
ALTER TABLE [dbo].[AstrologerProfiles] ADD  CONSTRAINT [DF_AstrologerProfiles_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[AuditLogs] ADD  CONSTRAINT [DF_AuditLogs_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[BlogCategories] ADD  CONSTRAINT [DF_BlogCategories_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[BlogPosts] ADD  CONSTRAINT [DF_BlogPosts_ViewCount]  DEFAULT ((0)) FOR [ViewCount]
GO
ALTER TABLE [dbo].[BlogPosts] ADD  CONSTRAINT [DF_BlogPosts_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[CartItems] ADD  CONSTRAINT [DF_CartItems_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[ContactQueries] ADD  CONSTRAINT [DF_ContactQueries_IsResolved]  DEFAULT ((0)) FOR [IsResolved]
GO
ALTER TABLE [dbo].[ContactQueries] ADD  CONSTRAINT [DF_ContactQueries_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Coupons] ADD  CONSTRAINT [DF_Coupons_UsedCount]  DEFAULT ((0)) FOR [UsedCount]
GO
ALTER TABLE [dbo].[Coupons] ADD  CONSTRAINT [DF_Coupons_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[CouponUsages] ADD  CONSTRAINT [DF_CouponUsages_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[ErrorLogs] ADD  CONSTRAINT [DF_ErrorLogs_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Faqs] ADD  CONSTRAINT [DF_Faqs_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[GiftCards] ADD  CONSTRAINT [DF_GiftCards_Status]  DEFAULT (N'active') FOR [Status]
GO
ALTER TABLE [dbo].[GiftCards] ADD  CONSTRAINT [DF_GiftCards_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[KundliRequests] ADD  CONSTRAINT [DF_KundliRequests_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[KundliRequests] ADD  CONSTRAINT [DF_KundliRequests_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[LoginLogs] ADD  CONSTRAINT [DF_LoginLogs_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[NewsletterSubscribers] ADD  CONSTRAINT [DF_NewsletterSubscribers_IsConfirmed]  DEFAULT ((0)) FOR [IsConfirmed]
GO
ALTER TABLE [dbo].[NewsletterSubscribers] ADD  CONSTRAINT [DF_NewsletterSubscribers_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Notifications] ADD  CONSTRAINT [DF_Notifications_Type]  DEFAULT (N'info') FOR [Type]
GO
ALTER TABLE [dbo].[Notifications] ADD  CONSTRAINT [DF_Notifications_IsRead]  DEFAULT ((0)) FOR [IsRead]
GO
ALTER TABLE [dbo].[Notifications] ADD  CONSTRAINT [DF_Notifications_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[OrderItems] ADD  CONSTRAINT [DF_OrderItems_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF_Orders_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF_Orders_Discount]  DEFAULT ((0)) FOR [Discount]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF_Orders_ShippingFee]  DEFAULT ((0)) FOR [ShippingFee]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF_Orders_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[OrderTracking] ADD  CONSTRAINT [DF_OrderTracking_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Payments] ADD  CONSTRAINT [DF_Payments_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Payments] ADD  CONSTRAINT [DF_Payments_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[PaymentTransactions] ADD  CONSTRAINT [DF_PaymentTransactions_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[PaymentTransactions] ADD  CONSTRAINT [DF_PaymentTransactions_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Permissions] ADD  CONSTRAINT [DF_Permissions_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[PoojaBookings] ADD  CONSTRAINT [DF_PoojaBookings_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[PoojaBookings] ADD  CONSTRAINT [DF_PoojaBookings_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[PoojaServices] ADD  CONSTRAINT [DF_PoojaServices_IsFeatured]  DEFAULT ((0)) FOR [IsFeatured]
GO
ALTER TABLE [dbo].[PoojaServices] ADD  CONSTRAINT [DF_PoojaServices_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[ProductCategories] ADD  CONSTRAINT [DF_ProductCategories_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[ProductImages] ADD  CONSTRAINT [DF_ProductImages_IsPrimary]  DEFAULT ((0)) FOR [IsPrimary]
GO
ALTER TABLE [dbo].[ProductImages] ADD  CONSTRAINT [DF_ProductImages_SortOrder]  DEFAULT ((0)) FOR [SortOrder]
GO
ALTER TABLE [dbo].[ProductImages] ADD  CONSTRAINT [DF_ProductImages_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF_Products_IsFeatured]  DEFAULT ((0)) FOR [IsFeatured]
GO
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF_Products_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Reviews] ADD  CONSTRAINT [DF_Reviews_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[RolePermissions] ADD  CONSTRAINT [DF_RolePermissions_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Roles] ADD  CONSTRAINT [DF_Roles_IsSystem]  DEFAULT ((1)) FOR [IsSystem]
GO
ALTER TABLE [dbo].[Roles] ADD  CONSTRAINT [DF_Roles_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Settings] ADD  CONSTRAINT [DF_Settings_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[SubscriptionPlans] ADD  CONSTRAINT [DF_SubscriptionPlans_BillingCycle]  DEFAULT (N'monthly') FOR [BillingCycle]
GO
ALTER TABLE [dbo].[SubscriptionPlans] ADD  CONSTRAINT [DF_SubscriptionPlans_IsPopular]  DEFAULT ((0)) FOR [IsPopular]
GO
ALTER TABLE [dbo].[SubscriptionPlans] ADD  CONSTRAINT [DF_SubscriptionPlans_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_EmailVerified]  DEFAULT ((0)) FOR [EmailVerified]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_PhoneVerified]  DEFAULT ((0)) FOR [PhoneVerified]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((0)) FOR [IsStaffApproved]
GO
ALTER TABLE [dbo].[UserSubscriptions] ADD  CONSTRAINT [DF_UserSubscriptions_AutoRenew]  DEFAULT ((1)) FOR [AutoRenew]
GO
ALTER TABLE [dbo].[UserSubscriptions] ADD  CONSTRAINT [DF_UserSubscriptions_Status]  DEFAULT (N'active') FOR [Status]
GO
ALTER TABLE [dbo].[UserSubscriptions] ADD  CONSTRAINT [DF_UserSubscriptions_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[WishlistItems] ADD  CONSTRAINT [DF_WishlistItems_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Addresses]  WITH CHECK ADD  CONSTRAINT [FK_Addresses_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Addresses] CHECK CONSTRAINT [FK_Addresses_Users]
GO
ALTER TABLE [dbo].[AstrologerProfiles]  WITH CHECK ADD  CONSTRAINT [FK_AstrologerProfiles_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AstrologerProfiles] CHECK CONSTRAINT [FK_AstrologerProfiles_Users]
GO
ALTER TABLE [dbo].[BlogPosts]  WITH CHECK ADD  CONSTRAINT [FK_BlogPosts_BlogCategories] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[BlogCategories] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BlogPosts] CHECK CONSTRAINT [FK_BlogPosts_BlogCategories]
GO
ALTER TABLE [dbo].[CartItems]  WITH CHECK ADD  CONSTRAINT [FK_CartItems_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CartItems] CHECK CONSTRAINT [FK_CartItems_Products]
GO
ALTER TABLE [dbo].[CartItems]  WITH CHECK ADD  CONSTRAINT [FK_CartItems_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CartItems] CHECK CONSTRAINT [FK_CartItems_Users]
GO
ALTER TABLE [dbo].[CouponUsages]  WITH CHECK ADD  CONSTRAINT [FK_CouponUsages_Coupons] FOREIGN KEY([CouponId])
REFERENCES [dbo].[Coupons] ([Id])
GO
ALTER TABLE [dbo].[CouponUsages] CHECK CONSTRAINT [FK_CouponUsages_Coupons]
GO
ALTER TABLE [dbo].[CouponUsages]  WITH CHECK ADD  CONSTRAINT [FK_CouponUsages_Orders] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([Id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[CouponUsages] CHECK CONSTRAINT [FK_CouponUsages_Orders]
GO
ALTER TABLE [dbo].[CouponUsages]  WITH CHECK ADD  CONSTRAINT [FK_CouponUsages_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[CouponUsages] CHECK CONSTRAINT [FK_CouponUsages_Users]
GO
ALTER TABLE [dbo].[KundliRequests]  WITH CHECK ADD  CONSTRAINT [FK_KundliRequests_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[KundliRequests] CHECK CONSTRAINT [FK_KundliRequests_Users]
GO
ALTER TABLE [dbo].[Notifications]  WITH CHECK ADD  CONSTRAINT [FK_Notifications_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Notifications] CHECK CONSTRAINT [FK_Notifications_Users]
GO
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD  CONSTRAINT [FK_OrderItems_Orders] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderItems] CHECK CONSTRAINT [FK_OrderItems_Orders]
GO
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD  CONSTRAINT [FK_OrderItems_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[OrderItems] CHECK CONSTRAINT [FK_OrderItems_Products]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Addresses] FOREIGN KEY([ShippingAddressId])
REFERENCES [dbo].[Addresses] ([Id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Addresses]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Users]
GO
ALTER TABLE [dbo].[OrderTracking]  WITH CHECK ADD  CONSTRAINT [FK_OrderTracking_Orders] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderTracking] CHECK CONSTRAINT [FK_OrderTracking_Orders]
GO
ALTER TABLE [dbo].[Payments]  WITH CHECK ADD  CONSTRAINT [FK_Payments_Orders] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Payments] CHECK CONSTRAINT [FK_Payments_Orders]
GO
ALTER TABLE [dbo].[PaymentTransactions]  WITH CHECK ADD  CONSTRAINT [FK_PaymentTransactions_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[PaymentTransactions] CHECK CONSTRAINT [FK_PaymentTransactions_Users]
GO
ALTER TABLE [dbo].[PoojaBookings]  WITH CHECK ADD  CONSTRAINT [FK_PoojaBookings_Astrologers] FOREIGN KEY([AstrologerId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[PoojaBookings] CHECK CONSTRAINT [FK_PoojaBookings_Astrologers]
GO
ALTER TABLE [dbo].[PoojaBookings]  WITH CHECK ADD  CONSTRAINT [FK_PoojaBookings_PoojaServices] FOREIGN KEY([PoojaServiceId])
REFERENCES [dbo].[PoojaServices] ([Id])
GO
ALTER TABLE [dbo].[PoojaBookings] CHECK CONSTRAINT [FK_PoojaBookings_PoojaServices]
GO
ALTER TABLE [dbo].[PoojaBookings]  WITH CHECK ADD  CONSTRAINT [FK_PoojaBookings_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[PoojaBookings] CHECK CONSTRAINT [FK_PoojaBookings_Users]
GO
ALTER TABLE [dbo].[ProductImages]  WITH CHECK ADD  CONSTRAINT [FK_ProductImages_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductImages] CHECK CONSTRAINT [FK_ProductImages_Products]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_ProductCategories] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[ProductCategories] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_ProductCategories]
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD  CONSTRAINT [FK_Reviews_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Reviews] CHECK CONSTRAINT [FK_Reviews_Products]
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD  CONSTRAINT [FK_Reviews_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Reviews] CHECK CONSTRAINT [FK_Reviews_Users]
GO
ALTER TABLE [dbo].[RolePermissions]  WITH CHECK ADD  CONSTRAINT [FK_RolePermissions_Permissions] FOREIGN KEY([PermissionId])
REFERENCES [dbo].[Permissions] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RolePermissions] CHECK CONSTRAINT [FK_RolePermissions_Permissions]
GO
ALTER TABLE [dbo].[RolePermissions]  WITH CHECK ADD  CONSTRAINT [FK_RolePermissions_Roles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RolePermissions] CHECK CONSTRAINT [FK_RolePermissions_Roles]
GO
ALTER TABLE [dbo].[UserPermissions]  WITH CHECK ADD  CONSTRAINT [FK_UserPermissions_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserPermissions] CHECK CONSTRAINT [FK_UserPermissions_Users_UserId]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Roles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([Id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Roles]
GO
ALTER TABLE [dbo].[UserSubscriptions]  WITH CHECK ADD  CONSTRAINT [FK_UserSubscriptions_Plans] FOREIGN KEY([SubscriptionPlanId])
REFERENCES [dbo].[SubscriptionPlans] ([Id])
GO
ALTER TABLE [dbo].[UserSubscriptions] CHECK CONSTRAINT [FK_UserSubscriptions_Plans]
GO
ALTER TABLE [dbo].[UserSubscriptions]  WITH CHECK ADD  CONSTRAINT [FK_UserSubscriptions_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserSubscriptions] CHECK CONSTRAINT [FK_UserSubscriptions_Users]
GO
ALTER TABLE [dbo].[WishlistItems]  WITH CHECK ADD  CONSTRAINT [FK_WishlistItems_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WishlistItems] CHECK CONSTRAINT [FK_WishlistItems_Products]
GO
ALTER TABLE [dbo].[WishlistItems]  WITH CHECK ADD  CONSTRAINT [FK_WishlistItems_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WishlistItems] CHECK CONSTRAINT [FK_WishlistItems_Users]
GO
USE [master]
GO
ALTER DATABASE [VadicMall] SET  READ_WRITE 
GO
