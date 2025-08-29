USE [master]
GO
/****** Object:  Database [Depositor_7_4]    Script Date: 29/08/2025 15:51:38 ******/
CREATE DATABASE [Depositor_7_4]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DepositorProduction', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Depositor_7_4.mdf' , SIZE = 852992KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'DepositorProduction_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Depositor_7_4_log.ldf' , SIZE = 1785856KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Depositor_7_4] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Depositor_7_4].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Depositor_7_4] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Depositor_7_4] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Depositor_7_4] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Depositor_7_4] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Depositor_7_4] SET ARITHABORT OFF 
GO
ALTER DATABASE [Depositor_7_4] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Depositor_7_4] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Depositor_7_4] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Depositor_7_4] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Depositor_7_4] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Depositor_7_4] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Depositor_7_4] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Depositor_7_4] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Depositor_7_4] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Depositor_7_4] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Depositor_7_4] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Depositor_7_4] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Depositor_7_4] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Depositor_7_4] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Depositor_7_4] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Depositor_7_4] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Depositor_7_4] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Depositor_7_4] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Depositor_7_4] SET  MULTI_USER 
GO
ALTER DATABASE [Depositor_7_4] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Depositor_7_4] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Depositor_7_4] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Depositor_7_4] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Depositor_7_4] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Depositor_7_4] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Depositor_7_4', N'ON'
GO
ALTER DATABASE [Depositor_7_4] SET QUERY_STORE = OFF
GO
USE [Depositor_7_4]
GO
/****** Object:  User [DeveloperLogin]    Script Date: 29/08/2025 15:51:39 ******/
CREATE USER [DeveloperLogin] FOR LOGIN [DeveloperLogin] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [DeveloperLogin]
GO
/****** Object:  Schema [exp]    Script Date: 29/08/2025 15:51:39 ******/
CREATE SCHEMA [exp]
GO
/****** Object:  Schema [xlns]    Script Date: 29/08/2025 15:51:39 ******/
CREATE SCHEMA [xlns]
GO
/****** Object:  Table [dbo].[Device]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Device](
	[id] [uniqueidentifier] NOT NULL,
	[device_number] [nvarchar](50) NOT NULL,
	[device_location] [nvarchar](50) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[machine_name] [nvarchar](128) NULL,
	[branch_id] [uniqueidentifier] NOT NULL,
	[description] [nvarchar](255) NULL,
	[type_id] [int] NOT NULL,
	[enabled] [bit] NOT NULL,
	[config_group] [int] NOT NULL,
	[user_group] [int] NULL,
	[GUIScreen_list] [int] NOT NULL,
	[language_list] [int] NULL,
	[currency_list] [int] NOT NULL,
	[transaction_type_list] [int] NOT NULL,
	[login_cycles] [int] NOT NULL,
	[login_attempts] [int] NOT NULL,
	[mac_address] [char](17) NULL,
	[app_id] [uniqueidentifier] NOT NULL,
	[app_key] [binary](32) NOT NULL,
 CONSTRAINT [PK_DeviceList] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ThisDevice]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ThisDevice]
AS
SELECT        id, device_number, device_location, name, machine_name, branch_id, description, type_id, enabled, config_group, user_group, GUIScreen_list, language_list, currency_list, transaction_type_list, login_cycles, 
                         login_attempts
FROM            dbo.Device
WHERE        (machine_name = CONVERT(nvarchar(128), SERVERPROPERTY('MachineName')))

GO
/****** Object:  Table [dbo].[DeviceConfig]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeviceConfig](
	[id] [uniqueidentifier] NOT NULL,
	[group_id] [int] NOT NULL,
	[config_id] [nvarchar](50) NOT NULL,
	[config_value] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_DeviceConfig_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UX_DeviceConfig] UNIQUE NONCLUSTERED 
(
	[config_id] ASC,
	[group_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[viewConfig]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[viewConfig]
AS
SELECT        config_id, config_value
FROM            dbo.DeviceConfig
WHERE        (group_id =
                             (SELECT        config_group
                               FROM            dbo.ThisDevice))

GO
/****** Object:  Table [dbo].[Activity]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Activity](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](255) NULL,
 CONSTRAINT [PK_Activity] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Permission]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Permission](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[role_id] [uniqueidentifier] NOT NULL,
	[activity_id] [uniqueidentifier] NOT NULL,
	[standalone_allowed] [bit] NOT NULL,
	[standalone_authentication_required] [bit] NOT NULL,
	[standalone_can_Authenticate] [bit] NOT NULL,
 CONSTRAINT [PK_Permission] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UX_Permission] UNIQUE NONCLUSTERED 
(
	[role_id] ASC,
	[activity_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](512) NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[viewPermissions]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[viewPermissions]
AS
SELECT        dbo.Role.name AS role, dbo.Activity.name AS activity, dbo.Permission.standalone_allowed, dbo.Permission.standalone_authentication_required, dbo.Permission.standalone_can_Authenticate
FROM            dbo.Permission INNER JOIN
                         dbo.Activity ON dbo.Permission.activity_id = dbo.Activity.id INNER JOIN
                         dbo.Role ON dbo.Permission.role_id = dbo.Role.id

GO
/****** Object:  Table [dbo].[AlertAttachmentType]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AlertAttachmentType](
	[code] [nvarchar](6) NOT NULL,
	[name] [nvarchar](50) NULL,
	[description] [nvarchar](255) NULL,
	[alert_type_id] [int] NULL,
	[enabled] [bit] NOT NULL,
	[mime_type] [nvarchar](100) NULL,
	[mime_subtype] [nvarchar](100) NULL,
 CONSTRAINT [PK_AlertAttachmentType] PRIMARY KEY CLUSTERED 
(
	[code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AlertEmail]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AlertEmail](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[created] [datetime2](7) NOT NULL,
	[from] [nvarchar](100) NULL,
	[to] [nvarchar](max) NULL,
	[subject] [nvarchar](100) NOT NULL,
	[html_message] [nvarchar](max) NULL,
	[raw_text_message] [nvarchar](max) NULL,
	[sent] [bit] NOT NULL,
	[send_date] [datetime2](7) NULL,
	[alert_event_id] [uniqueidentifier] NOT NULL,
	[send_error] [bit] NOT NULL,
	[send_error_message] [nvarchar](255) NULL,
 CONSTRAINT [PK_Email] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AlertEmailAttachment]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AlertEmailAttachment](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[alert_email_id] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[path] [nvarchar](255) NOT NULL,
	[type] [nchar](6) NOT NULL,
	[data] [varbinary](max) NOT NULL,
	[hash] [binary](64) NOT NULL,
	[mime_type] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_AlertEmailAttachment] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AlertEvent]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AlertEvent](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[device_id] [uniqueidentifier] NOT NULL,
	[created] [datetime2](7) NOT NULL,
	[alert_type_id] [int] NOT NULL,
	[date_detected] [datetime2](7) NOT NULL,
	[date_resolved] [datetime2](7) NULL,
	[is_resolved] [bit] NOT NULL,
	[is_processed] [bit] NOT NULL,
	[alert_event_id] [uniqueidentifier] NULL,
	[is_processing] [bit] NOT NULL,
	[machine_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_EmailEvent] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AlertMessageRegistry]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AlertMessageRegistry](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[alert_type_id] [int] NOT NULL,
	[role_id] [uniqueidentifier] NOT NULL,
	[email_enabled] [bit] NOT NULL,
	[phone_enabled] [bit] NOT NULL,
 CONSTRAINT [PK_AlertMessageRegistry_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UX_AlertMessageRegistry] UNIQUE NONCLUSTERED 
(
	[alert_type_id] ASC,
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AlertMessageType]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AlertMessageType](
	[id] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](255) NULL,
	[title] [nvarchar](255) NULL,
	[email_content_template] [nvarchar](max) NULL,
	[raw_email_content_template] [nvarchar](max) NULL,
	[phone_content_template] [nvarchar](255) NULL,
	[enabled] [bit] NOT NULL,
 CONSTRAINT [PK_AlertMessageType_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AlertSMS]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AlertSMS](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[created] [datetime2](7) NOT NULL,
	[from] [nvarchar](100) NULL,
	[to] [nvarchar](max) NULL,
	[message] [nvarchar](max) NULL,
	[sent] [bit] NOT NULL,
	[send_date] [datetime2](7) NULL,
	[alert_event_id] [uniqueidentifier] NOT NULL,
	[send_error] [bit] NOT NULL,
	[send_error_message] [nvarchar](255) NULL,
 CONSTRAINT [PK_AlertSMS_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ApplicationLog]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ApplicationLog](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[session_id] [uniqueidentifier] NULL,
	[device_id] [uniqueidentifier] NOT NULL,
	[log_date] [datetime2](7) NOT NULL,
	[event_name] [varchar](50) NOT NULL,
	[event_detail] [nvarchar](max) NOT NULL,
	[event_type] [varchar](50) NOT NULL,
	[component] [varchar](50) NOT NULL,
	[log_level] [int] NOT NULL,
	[machine_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ApplicationLog] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ApplicationUser]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ApplicationUser](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[username] [nvarchar](255) NOT NULL,
	[password] [char](71) NOT NULL,
	[fname] [nvarchar](50) NOT NULL,
	[lname] [nvarchar](50) NOT NULL,
	[role_id] [uniqueidentifier] NOT NULL,
	[email] [nvarchar](50) NULL,
	[email_enabled] [bit] NOT NULL,
	[phone] [nvarchar](50) NULL,
	[phone_enabled] [bit] NOT NULL,
	[password_reset_required] [bit] NOT NULL,
	[login_attempts] [int] NOT NULL,
	[user_group] [int] NOT NULL,
	[depositor_enabled] [bit] NULL,
	[UserDeleted] [bit] NULL,
	[IsActive] [bit] NULL,
	[ApplicationUserLoginDetail] [uniqueidentifier] NULL,
	[is_ad_user] [bit] NOT NULL,
 CONSTRAINT [PK_ApplicationUser_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UX_ApplicationUser_Username] UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bank]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bank](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[bank_code] [nvarchar](50) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](255) NULL,
	[country_code] [char](2) NOT NULL,
 CONSTRAINT [PK_Bank_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Branch]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Branch](
	[id] [uniqueidentifier] NOT NULL,
	[branch_code] [nvarchar](50) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](255) NULL,
	[bank_id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Branch_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CIT]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CIT](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[device_id] [uniqueidentifier] NOT NULL,
	[cit_date] [datetime2](7) NOT NULL,
	[cit_complete_date] [datetime2](7) NULL,
	[start_user] [uniqueidentifier] NOT NULL,
	[auth_user] [uniqueidentifier] NULL,
	[fromDate] [datetime2](7) NULL,
	[toDate] [datetime2](7) NOT NULL,
	[old_bag_number] [nvarchar](50) NULL,
	[new_bag_number] [nvarchar](50) NULL,
	[seal_number] [nvarchar](50) NULL,
	[complete] [bit] NOT NULL,
	[cit_error] [int] NOT NULL,
	[cit_error_message] [nvarchar](255) NULL,
 CONSTRAINT [PK_CIT] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CITDenominations]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CITDenominations](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[cit_id] [uniqueidentifier] NOT NULL,
	[datetime] [datetime2](7) NULL,
	[currency_id] [char](3) NOT NULL,
	[denom] [int] NOT NULL,
	[count] [bigint] NOT NULL,
	[subtotal] [bigint] NOT NULL,
 CONSTRAINT [PK_CITDenominations] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CITPrintout]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CITPrintout](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[datetime] [datetime2](7) NOT NULL,
	[cit_id] [uniqueidentifier] NOT NULL,
	[print_guid] [uniqueidentifier] NOT NULL,
	[print_content] [nvarchar](max) NULL,
	[is_copy] [bit] NOT NULL,
 CONSTRAINT [PK_CITPrintout] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Config]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Config](
	[name] [nvarchar](50) NOT NULL,
	[default_value] [nvarchar](max) NULL,
	[description] [nvarchar](255) NULL,
	[category_id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Config] PRIMARY KEY CLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ConfigCategory]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConfigCategory](
	[id] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](255) NULL,
 CONSTRAINT [PK_ConfigCategory] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ConfigGroup]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConfigGroup](
	[id] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](512) NULL,
	[parent_group] [int] NULL,
 CONSTRAINT [PK_ConfigGroup] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Country]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Country](
	[country_code] [char](2) NOT NULL,
	[country_name] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[country_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Currency]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Currency](
	[code] [char](3) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[minor] [int] NOT NULL,
	[flag] [char](2) NOT NULL,
	[enabled] [bit] NOT NULL,
	[ISO_3_Numeric_Code] [char](3) NULL,
 CONSTRAINT [PK_Currency] PRIMARY KEY CLUSTERED 
(
	[code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CurrencyList]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CurrencyList](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](255) NOT NULL,
	[default_currency] [char](3) NOT NULL,
 CONSTRAINT [PK_CurrencyList] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CurrencyList_Currency]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CurrencyList_Currency](
	[id] [uniqueidentifier] NOT NULL,
	[currency_list] [int] NOT NULL,
	[currency_item] [char](3) NOT NULL,
	[currency_order] [int] NOT NULL,
	[max_value] [bigint] NOT NULL,
	[max_count] [int] NOT NULL,
 CONSTRAINT [PK_Currency_CurrencyList] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UX_Currency_CurrencyList_Order] UNIQUE NONCLUSTERED 
(
	[currency_list] ASC,
	[currency_order] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UX_CurrencyList_Currency_CurrencyItem] UNIQUE NONCLUSTERED 
(
	[currency_list] ASC,
	[currency_item] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DenominationDetail]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DenominationDetail](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[tx_id] [uniqueidentifier] NOT NULL,
	[denom] [int] NOT NULL,
	[count] [bigint] NOT NULL,
	[subtotal] [bigint] NOT NULL,
	[datetime] [datetime2](7) NULL,
 CONSTRAINT [PK_DenominationDetail] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DepositorSession]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DepositorSession](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[device_id] [uniqueidentifier] NOT NULL,
	[session_start] [datetime2](7) NOT NULL,
	[session_end] [datetime2](7) NULL,
	[language_code] [char](5) NULL,
	[complete] [bit] NOT NULL,
	[complete_success] [bit] NOT NULL,
	[error_code] [int] NULL,
	[error_message] [nvarchar](255) NULL,
	[terms_accepted] [bit] NOT NULL,
	[account_verified] [bit] NOT NULL,
	[reference_account_verified] [bit] NOT NULL,
	[salt] [varchar](64) NULL,
 CONSTRAINT [PK_DepositorSession] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeviceLock]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeviceLock](
	[id] [uniqueidentifier] NOT NULL,
	[device_id] [uniqueidentifier] NOT NULL,
	[lock_date] [datetime2](7) NOT NULL,
	[locked] [bit] NOT NULL,
	[locking_user] [uniqueidentifier] NULL,
	[web_locking_user] [nvarchar](50) NULL,
	[locked_by_device] [bit] NOT NULL,
 CONSTRAINT [PK_DeviceLock_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeviceLogin]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeviceLogin](
	[id] [uniqueidentifier] NOT NULL,
	[LoginDate] [datetime2](7) NOT NULL,
	[LogoutDate] [datetime2](7) NULL,
	[User] [uniqueidentifier] NOT NULL,
	[Success] [bit] NULL,
	[DepositorEnabled] [bit] NULL,
	[ChangePassword] [bit] NULL,
	[Message] [nvarchar](200) NULL,
	[ForcedLogout] [bit] NULL,
	[device_id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_DeviceLogin] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DevicePrinter]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DevicePrinter](
	[id] [uniqueidentifier] NOT NULL,
	[device_id] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](255) NULL,
	[is_infront] [bit] NOT NULL,
	[port] [nvarchar](5) NOT NULL,
	[make] [nvarchar](50) NULL,
	[model] [nvarchar](50) NULL,
	[serial] [nvarchar](50) NULL,
 CONSTRAINT [PK_DevicePrinter_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeviceStatus]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeviceStatus](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[device_id] [uniqueidentifier] NOT NULL,
	[controller_state] [nvarchar](20) NOT NULL,
	[ba_type] [nvarchar](20) NOT NULL,
	[ba_status] [nvarchar](20) NOT NULL,
	[ba_currency] [char](3) NOT NULL,
	[bag_number] [nvarchar](50) NOT NULL,
	[bag_status] [nvarchar](20) NOT NULL,
	[bag_note_level] [int] NOT NULL,
	[bag_note_capacity] [nchar](10) NOT NULL,
	[bag_value_level] [bigint] NULL,
	[bag_value_capacity] [bigint] NULL,
	[bag_percent_full] [int] NOT NULL,
	[sensors_type] [nvarchar](20) NOT NULL,
	[sensors_status] [nvarchar](20) NOT NULL,
	[sensors_value] [int] NOT NULL,
	[sensors_door] [nvarchar](20) NOT NULL,
	[sensors_bag] [nvarchar](20) NOT NULL,
	[escrow_type] [nvarchar](20) NOT NULL,
	[escrow_status] [nvarchar](20) NOT NULL,
	[escrow_position] [nvarchar](20) NOT NULL,
	[transaction_status] [nvarchar](20) NULL,
	[transaction_type] [nvarchar](20) NULL,
	[machine_datetime] [datetime2](7) NULL,
	[current_status] [int] NOT NULL,
	[modified] [datetime2](7) NULL,
	[machine_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_DeviceStatus] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeviceSuspenseAccount]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeviceSuspenseAccount](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[device_id] [uniqueidentifier] NOT NULL,
	[currency_code] [char](3) NOT NULL,
	[account_number] [nvarchar](50) NOT NULL,
	[account_name] [nvarchar](100) NULL,
	[enabled] [bit] NOT NULL,
	[account] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Device_SuspenseAccount] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UX_Device_SuspenseAccount] UNIQUE NONCLUSTERED 
(
	[device_id] ASC,
	[currency_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeviceType]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeviceType](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](255) NOT NULL,
	[note_in] [bit] NOT NULL,
	[note_out] [bit] NOT NULL,
	[note_escrow] [bit] NOT NULL,
	[coin_in] [bit] NOT NULL,
	[coin_out] [bit] NOT NULL,
	[coin_escrow] [bit] NOT NULL,
 CONSTRAINT [PK_DeviceType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GUIPrepopItem]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GUIPrepopItem](
	[id] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](100) NULL,
	[value] [uniqueidentifier] NOT NULL,
	[enabled] [bit] NOT NULL,
 CONSTRAINT [PK_GUIPrepopItem] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GUIPrepopList]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GUIPrepopList](
	[id] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](100) NULL,
	[enabled] [bit] NOT NULL,
	[AllowFreeText] [bit] NOT NULL,
	[DefaultIndex] [int] NOT NULL,
	[UseDefault] [bit] NOT NULL,
 CONSTRAINT [PK_GUIPrepopList] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GUIPrepopList_Item]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GUIPrepopList_Item](
	[id] [uniqueidentifier] NOT NULL,
	[List] [uniqueidentifier] NOT NULL,
	[Item] [uniqueidentifier] NOT NULL,
	[List_Order] [int] NOT NULL,
 CONSTRAINT [PK_GUIPrepopList_Item] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UX_GUIPrepopList_Item] UNIQUE NONCLUSTERED 
(
	[Item] ASC,
	[List] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GUIScreen]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GUIScreen](
	[id] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](255) NULL,
	[type] [int] NOT NULL,
	[enabled] [bit] NOT NULL,
	[keyboard] [int] NULL,
	[is_masked] [bit] NULL,
	[prefill_text] [nvarchar](50) NULL,
	[input_mask] [varchar](50) NULL,
	[gui_text] [uniqueidentifier] NULL,
 CONSTRAINT [PK_GUIScreen] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GUIScreenList]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GUIScreenList](
	[id] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](255) NULL,
	[enabled] [bit] NOT NULL,
 CONSTRAINT [PK_GUIScreenList] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GuiScreenList_Screen]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GuiScreenList_Screen](
	[id] [uniqueidentifier] NOT NULL,
	[screen] [int] NOT NULL,
	[gui_screen_list] [int] NOT NULL,
	[screen_order] [int] NOT NULL,
	[required] [bit] NOT NULL,
	[validation_list_id] [uniqueidentifier] NULL,
	[guiprepoplist_id] [uniqueidentifier] NULL,
	[enabled] [bit] NOT NULL,
 CONSTRAINT [PK_GuiScreenList_Screen] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UX_GuiScreenList_Screen_Order] UNIQUE NONCLUSTERED 
(
	[gui_screen_list] ASC,
	[screen_order] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UX_GuiScreenList_Screen_ScreenItem] UNIQUE NONCLUSTERED 
(
	[gui_screen_list] ASC,
	[screen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GUIScreenText]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GUIScreenText](
	[id] [uniqueidentifier] NOT NULL,
	[guiscreen_id] [int] NOT NULL,
	[screen_title] [uniqueidentifier] NOT NULL,
	[screen_title_instruction] [uniqueidentifier] NULL,
	[full_instructions] [uniqueidentifier] NULL,
	[btn_accept_caption] [uniqueidentifier] NULL,
	[btn_back_caption] [uniqueidentifier] NULL,
	[btn_cancel_caption] [uniqueidentifier] NULL,
 CONSTRAINT [PK_GUIScreenText] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UX_GUIScreenText_gui_screen_id] UNIQUE NONCLUSTERED 
(
	[guiscreen_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GUIScreenType]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GUIScreenType](
	[id] [int] NOT NULL,
	[code] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](255) NULL,
	[enabled] [bit] NOT NULL,
 CONSTRAINT [PK_GUIScreenType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Language]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Language](
	[code] [char](5) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[flag] [nvarchar](255) NOT NULL,
	[enabled] [bit] NOT NULL,
 CONSTRAINT [PK_Languages] PRIMARY KEY CLUSTERED 
(
	[code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LanguageList]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LanguageList](
	[id] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](100) NULL,
	[enabled] [bit] NOT NULL,
	[default_language] [char](5) NOT NULL,
 CONSTRAINT [PK_LanguageList] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LanguageList_Language]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LanguageList_Language](
	[id] [uniqueidentifier] NOT NULL,
	[language_list] [int] NOT NULL,
	[language_item] [char](5) NOT NULL,
	[language_order] [int] NOT NULL,
 CONSTRAINT [PK_LanguageList_Language] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UX_LanguageList_Language_LanguageItem] UNIQUE NONCLUSTERED 
(
	[language_item] ASC,
	[language_list] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UX_LanguageList_Language_Order] UNIQUE NONCLUSTERED 
(
	[language_list] ASC,
	[language_order] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PasswordHistory]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PasswordHistory](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[LogDate] [datetime] NULL,
	[User] [uniqueidentifier] NULL,
	[Password] [nvarchar](71) NULL,
 CONSTRAINT [PK_PasswordHistory] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PasswordPolicy]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PasswordPolicy](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[min_length] [int] NOT NULL,
	[min_lowercase] [int] NOT NULL,
	[min_digits] [int] NOT NULL,
	[min_uppercase] [int] NOT NULL,
	[min_special] [int] NOT NULL,
	[allowed_special] [nvarchar](100) NOT NULL,
	[expiry_days] [int] NOT NULL,
	[history_size] [int] NOT NULL,
	[use_history] [bit] NOT NULL,
 CONSTRAINT [PK_PasswordPolicy] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PrinterStatus]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PrinterStatus](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[printer_id] [uniqueidentifier] NOT NULL,
	[is_error] [bit] NOT NULL,
	[has_paper] [bit] NOT NULL,
	[cover_open] [bit] NOT NULL,
	[error_code] [int] NOT NULL,
	[error_name] [nvarchar](50) NOT NULL,
	[error_message] [nvarchar](50) NULL,
	[modified] [datetime2](7) NOT NULL,
	[machine_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_PrinterStatus_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Printout]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Printout](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[datetime] [datetime2](7) NOT NULL,
	[tx_id] [uniqueidentifier] NOT NULL,
	[print_guid] [uniqueidentifier] NOT NULL,
	[print_content] [nvarchar](max) NULL,
	[is_copy] [bit] NOT NULL,
 CONSTRAINT [PK_Printout] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transaction]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transaction](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[tx_type] [int] NULL,
	[session_id] [uniqueidentifier] NOT NULL,
	[tx_random_number] [int] NULL,
	[device_id] [uniqueidentifier] NOT NULL,
	[tx_start_date] [datetime2](7) NOT NULL,
	[tx_end_date] [datetime2](7) NULL,
	[tx_completed] [bit] NOT NULL,
	[tx_currency] [char](3) NULL,
	[tx_amount] [bigint] NULL,
	[tx_account_number] [nvarchar](50) NULL,
	[cb_account_name] [nvarchar](100) NULL,
	[tx_ref_account] [nvarchar](50) NULL,
	[cb_ref_account_name] [nvarchar](100) NULL,
	[tx_narration] [nvarchar](50) NULL,
	[tx_depositor_name] [nvarchar](50) NULL,
	[tx_id_number] [nvarchar](50) NULL,
	[tx_phone] [nvarchar](50) NULL,
	[funds_source] [nvarchar](255) NULL,
	[tx_result] [int] NOT NULL,
	[tx_error_code] [int] NOT NULL,
	[tx_error_message] [nvarchar](255) NULL,
	[cb_tx_number] [nvarchar](50) NULL,
	[cb_date] [datetime2](7) NULL,
	[cb_tx_status] [nvarchar](50) NULL,
	[cb_status_detail] [nvarchar](max) NULL,
	[notes_rejected] [bit] NOT NULL,
	[jam_detected] [bit] NOT NULL,
	[cit_id] [uniqueidentifier] NULL,
	[escrow_jam] [bit] NOT NULL,
	[tx_suspense_account] [nvarchar](50) NULL,
	[init_user] [uniqueidentifier] NULL,
	[auth_user] [uniqueidentifier] NULL,
	[purpose_of_payment] [nvarchar](255) NULL,
	[version] [timestamp] NOT NULL,
 CONSTRAINT [PK_Transaction] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransactionLimitList]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransactionLimitList](
	[id] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](255) NULL,
 CONSTRAINT [PK_TransactionLimitList] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransactionLimitListItem]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransactionLimitListItem](
	[id] [uniqueidentifier] NOT NULL,
	[transactionitemlist_id] [uniqueidentifier] NOT NULL,
	[currency_code] [char](3) NOT NULL,
	[show_funds_source] [bit] NOT NULL,
	[show_funds_form] [uniqueidentifier] NULL,
	[funds_source_amount] [bigint] NOT NULL,
	[prevent_overdeposit] [bit] NOT NULL,
	[overdeposit_amount] [bigint] NOT NULL,
	[prevent_underdeposit] [bit] NOT NULL,
	[underdeposit_amount] [bigint] NOT NULL,
	[prevent_overcount] [bit] NOT NULL,
	[overcount_amount] [int] NOT NULL,
 CONSTRAINT [PK_TransactionLimitListItem] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UX_TransactionLimitListItem] UNIQUE NONCLUSTERED 
(
	[transactionitemlist_id] ASC,
	[currency_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransactionText]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransactionText](
	[id] [uniqueidentifier] NOT NULL,
	[tx_item] [int] NOT NULL,
	[disclaimer] [uniqueidentifier] NULL,
	[terms] [uniqueidentifier] NULL,
	[full_instructions] [uniqueidentifier] NULL,
	[listItem_caption] [uniqueidentifier] NULL,
	[account_number_caption] [uniqueidentifier] NULL,
	[account_name_caption] [uniqueidentifier] NULL,
	[reference_account_number_caption] [uniqueidentifier] NULL,
	[reference_account_name_caption] [uniqueidentifier] NULL,
	[narration_caption] [uniqueidentifier] NULL,
	[alias_account_number_caption] [uniqueidentifier] NULL,
	[alias_account_name_caption] [uniqueidentifier] NULL,
	[depositor_name_caption] [uniqueidentifier] NULL,
	[phone_number_caption] [uniqueidentifier] NULL,
	[id_number_caption] [uniqueidentifier] NULL,
	[receipt_template] [uniqueidentifier] NULL,
	[FundsSource_caption] [uniqueidentifier] NULL,
 CONSTRAINT [PK_TransactionText] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UX_TransactionText_tx_item] UNIQUE NONCLUSTERED 
(
	[tx_item] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransactionType]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransactionType](
	[id] [int] NOT NULL,
	[code] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](255) NULL,
	[enabled] [bit] NOT NULL,
 CONSTRAINT [PK_TransactionType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransactionTypeList]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransactionTypeList](
	[id] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](255) NULL,
	[enabled] [bit] NOT NULL,
 CONSTRAINT [PK_TransactionTypeList] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransactionTypeList_TransactionTypeListItem]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransactionTypeList_TransactionTypeListItem](
	[id] [uniqueidentifier] NOT NULL,
	[txtype_list_item] [int] NOT NULL,
	[txtype_list] [int] NOT NULL,
	[list_order] [int] NOT NULL,
 CONSTRAINT [PK_TransactionTypeList_TransactionTypeListItem] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UX_TransactionTypeList_TransactionTypeListItem_Item] UNIQUE NONCLUSTERED 
(
	[txtype_list] ASC,
	[txtype_list_item] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UX_TransactionTypeList_TransactionTypeListItem_Order] UNIQUE NONCLUSTERED 
(
	[txtype_list] ASC,
	[list_order] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransactionTypeListItem]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransactionTypeListItem](
	[id] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](255) NULL,
	[validate_reference_account] [bit] NOT NULL,
	[default_account] [nvarchar](50) NULL,
	[default_account_name] [nvarchar](50) NULL,
	[default_account_currency] [char](3) NOT NULL,
	[validate_default_account] [bit] NOT NULL,
	[enabled] [bit] NOT NULL,
	[tx_type] [int] NOT NULL,
	[tx_type_guiscreenlist] [int] NOT NULL,
	[cb_tx_type] [nvarchar](50) NULL,
	[username] [nvarchar](50) NULL,
	[password] [nvarchar](max) NULL,
	[Icon] [varbinary](max) NULL,
	[tx_limit_list] [uniqueidentifier] NULL,
	[tx_text] [uniqueidentifier] NULL,
	[account_permission] [uniqueidentifier] NULL,
	[init_user_required] [bit] NOT NULL,
	[auth_user_required] [bit] NOT NULL,
 CONSTRAINT [PK_TransactionListItem] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UptimeComponentState]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UptimeComponentState](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[device] [uniqueidentifier] NOT NULL,
	[created] [datetime2](7) NOT NULL,
	[start_date] [datetime2](7) NOT NULL,
	[end_date] [datetime2](7) NULL,
	[component_state] [int] NOT NULL,
 CONSTRAINT [PK_UptimeComponentState] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UptimeMode]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UptimeMode](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[device] [uniqueidentifier] NOT NULL,
	[created] [datetime2](7) NOT NULL,
	[start_date] [datetime2](7) NOT NULL,
	[end_date] [datetime2](7) NULL,
	[device_mode] [int] NOT NULL,
 CONSTRAINT [PK_UptimeMode] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserGroup]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserGroup](
	[id] [int] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](512) NULL,
	[parent_group] [int] NULL,
 CONSTRAINT [PK_UserGroup] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserLock]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserLock](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[LogDate] [datetime] NULL,
	[ApplicationUserLoginDetail] [uniqueidentifier] NULL,
	[LockType] [int] NULL,
	[WebPortalInitiated] [bit] NULL,
	[InitiatingUser] [uniqueidentifier] NULL,
 CONSTRAINT [PK_UserLock] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ValidationItem]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ValidationItem](
	[id] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[category] [nvarchar](10) NULL,
	[description] [nvarchar](255) NULL,
	[type_id] [uniqueidentifier] NOT NULL,
	[enabled] [bit] NOT NULL,
	[error_code] [int] NULL,
	[validation_text_id] [uniqueidentifier] NULL,
 CONSTRAINT [PK_ValidationItem] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ValidationItemValue]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ValidationItemValue](
	[id] [uniqueidentifier] NOT NULL,
	[validation_item_id] [uniqueidentifier] NOT NULL,
	[value] [nvarchar](255) NOT NULL,
	[order] [int] NOT NULL,
 CONSTRAINT [PK_ValidationItemValue] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UX_ValidationItemValue] UNIQUE NONCLUSTERED 
(
	[validation_item_id] ASC,
	[order] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ValidationList]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ValidationList](
	[id] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](255) NULL,
	[category] [nvarchar](25) NULL,
	[enabled] [bit] NOT NULL,
 CONSTRAINT [PK_ValidationList] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ValidationList_ValidationItem]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ValidationList_ValidationItem](
	[id] [uniqueidentifier] NOT NULL,
	[validation_list_id] [uniqueidentifier] NOT NULL,
	[validation_item_id] [uniqueidentifier] NOT NULL,
	[order] [int] NOT NULL,
	[enabled] [bit] NOT NULL,
 CONSTRAINT [PK_ValidationList_ValidationItem] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UX_ValidationList_ValidationItem_UniqueItem] UNIQUE NONCLUSTERED 
(
	[validation_item_id] ASC,
	[validation_list_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UX_ValidationList_ValidationItem_UniqueOrder] UNIQUE NONCLUSTERED 
(
	[validation_list_id] ASC,
	[order] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ValidationText]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ValidationText](
	[id] [uniqueidentifier] NOT NULL,
	[validation_item_id] [uniqueidentifier] NOT NULL,
	[error_message] [uniqueidentifier] NULL,
	[success_message] [uniqueidentifier] NULL,
 CONSTRAINT [PK_ValidationText] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ValidationType]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ValidationType](
	[id] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](255) NULL,
	[enabled] [bit] NOT NULL,
 CONSTRAINT [PK_ValidationType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [exp].[ApplicationException]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [exp].[ApplicationException](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[device_id] [uniqueidentifier] NOT NULL,
	[datetime] [datetime2](7) NOT NULL,
	[code] [int] NOT NULL,
	[name] [nvarchar](50) NULL,
	[level] [int] NOT NULL,
	[message] [nvarchar](255) NULL,
	[additional_info] [nvarchar](255) NULL,
	[stack] [nvarchar](max) NULL,
	[machine_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ApplicationException] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [exp].[CrashEvent]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [exp].[CrashEvent](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[device_id] [uniqueidentifier] NOT NULL,
	[datetime] [datetime2](7) NOT NULL,
	[date_detected] [datetime2](7) NOT NULL,
	[content] [nvarchar](max) NOT NULL,
	[machine_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_CrashEvent] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [exp].[EscrowJam]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [exp].[EscrowJam](
	[id] [uniqueidentifier] NOT NULL,
	[transaction_id] [uniqueidentifier] NOT NULL,
	[date_detected] [datetime2](7) NOT NULL,
	[dropped_amount] [bigint] NOT NULL,
	[escrow_amount] [bigint] NOT NULL,
	[posted_amount] [bigint] NOT NULL,
	[retreived_amount] [bigint] NOT NULL,
	[recovery_date] [datetime2](7) NULL,
	[initialising_user] [uniqueidentifier] NULL,
	[authorising_user] [uniqueidentifier] NULL,
	[additional_info] [nvarchar](100) NULL,
 CONSTRAINT [PK__EscrowJa__3213E83FDD2D9CA2] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [exp].[SessionException]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [exp].[SessionException](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[datetime] [datetime2](7) NOT NULL,
	[session_id] [uniqueidentifier] NOT NULL,
	[code] [int] NOT NULL,
	[name] [nvarchar](50) NULL,
	[level] [int] NOT NULL,
	[message] [nvarchar](255) NULL,
	[additional_info] [nvarchar](255) NULL,
	[stack] [nvarchar](max) NULL,
	[machine_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_SessionException] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [exp].[TransactionException]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [exp].[TransactionException](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[datetime] [datetime2](7) NOT NULL,
	[transaction_id] [uniqueidentifier] NOT NULL,
	[code] [int] NOT NULL,
	[level] [int] NOT NULL,
	[additional_info] [nvarchar](255) NULL,
	[message] [nvarchar](255) NULL,
	[machine_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_TransactionException] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [xlns].[sysTextItem]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [xlns].[sysTextItem](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Token] [nvarchar](100) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Description] [nvarchar](255) NULL,
	[DefaultTranslation] [nvarchar](max) NOT NULL,
	[Category] [uniqueidentifier] NOT NULL,
	[TextItemTypeID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_SysTextItem] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UX_SysTextItem_name] UNIQUE NONCLUSTERED 
(
	[Token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [xlns].[sysTextItemCategory]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [xlns].[sysTextItemCategory](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](255) NULL,
	[Parent] [uniqueidentifier] NULL,
 CONSTRAINT [PK_TextItemCategory] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UX_TextItemCategory_name] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [xlns].[sysTextItemType]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [xlns].[sysTextItemType](
	[id] [uniqueidentifier] NOT NULL,
	[token] [nvarchar](100) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](255) NULL,
 CONSTRAINT [PK_sysTextItemType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [xlns].[sysTextTranslation]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [xlns].[sysTextTranslation](
	[id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[SysTextItemID] [uniqueidentifier] NOT NULL,
	[LanguageCode] [char](5) NOT NULL,
	[TranslationSysText] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Translation] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UX_Translation_Language_Pair] UNIQUE NONCLUSTERED 
(
	[LanguageCode] ASC,
	[SysTextItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [xlns].[TextItem]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [xlns].[TextItem](
	[id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[DefaultTranslation] [nvarchar](max) NOT NULL,
	[Category] [uniqueidentifier] NOT NULL,
	[TextItemTypeID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_UI_TextItem] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UX_UI_TextItem_name] UNIQUE NONCLUSTERED 
(
	[Name] ASC,
	[Category] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [xlns].[TextItemCategory]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [xlns].[TextItemCategory](
	[id] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](255) NULL,
	[Parent] [uniqueidentifier] NULL,
 CONSTRAINT [PK_UI_TextItemCategory] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UX_UI_TextItemCategory_name] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [xlns].[TextItemType]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [xlns].[TextItemType](
	[id] [uniqueidentifier] NOT NULL,
	[token] [nvarchar](100) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](255) NULL,
 CONSTRAINT [PK_UI_TextItemType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UX_UI_TextItemType] UNIQUE NONCLUSTERED 
(
	[token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [xlns].[TextTranslation]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [xlns].[TextTranslation](
	[id] [uniqueidentifier] NOT NULL,
	[TextItemID] [uniqueidentifier] NOT NULL,
	[LanguageCode] [char](5) NOT NULL,
	[TranslationText] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_UI_Translation] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UX_UI_Translation_Language_Pair] UNIQUE NONCLUSTERED 
(
	[LanguageCode] ASC,
	[TextItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Index [ialert_type_id_AlertMessageRegistry]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [ialert_type_id_AlertMessageRegistry] ON [dbo].[AlertMessageRegistry]
(
	[alert_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [irole_id_AlertMessageRegistry]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [irole_id_AlertMessageRegistry] ON [dbo].[AlertMessageRegistry]
(
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [iApplicationUserLoginDetail_ApplicationUser]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iApplicationUserLoginDetail_ApplicationUser] ON [dbo].[ApplicationUser]
(
	[ApplicationUserLoginDetail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [irole_id_ApplicationUser]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [irole_id_ApplicationUser] ON [dbo].[ApplicationUser]
(
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [iuser_group_ApplicationUser]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iuser_group_ApplicationUser] ON [dbo].[ApplicationUser]
(
	[user_group] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [icountry_code_Bank]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [icountry_code_Bank] ON [dbo].[Bank]
(
	[country_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [ibank_id_Branch]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [ibank_id_Branch] ON [dbo].[Branch]
(
	[bank_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [iauth_user_CIT]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iauth_user_CIT] ON [dbo].[CIT]
(
	[auth_user] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idevice_id_CIT]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [idevice_id_CIT] ON [dbo].[CIT]
(
	[device_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [istart_user_CIT]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [istart_user_CIT] ON [dbo].[CIT]
(
	[start_user] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [icit_id_CITDenominations]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [icit_id_CITDenominations] ON [dbo].[CITDenominations]
(
	[cit_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [icurrency_id_CITDenominations]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [icurrency_id_CITDenominations] ON [dbo].[CITDenominations]
(
	[currency_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [icit_id_CITPrintout]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [icit_id_CITPrintout] ON [dbo].[CITPrintout]
(
	[cit_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [icategory_id_Config]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [icategory_id_Config] ON [dbo].[Config]
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [iparent_group_ConfigGroup]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iparent_group_ConfigGroup] ON [dbo].[ConfigGroup]
(
	[parent_group] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idefault_currency_CurrencyList]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [idefault_currency_CurrencyList] ON [dbo].[CurrencyList]
(
	[default_currency] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [icurrency_item_CurrencyList_Currency]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [icurrency_item_CurrencyList_Currency] ON [dbo].[CurrencyList_Currency]
(
	[currency_item] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [icurrency_list_CurrencyList_Currency]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [icurrency_list_CurrencyList_Currency] ON [dbo].[CurrencyList_Currency]
(
	[currency_list] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [itx_id_DenominationDetail]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [itx_id_DenominationDetail] ON [dbo].[DenominationDetail]
(
	[tx_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idevice_id_DepositorSession]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [idevice_id_DepositorSession] ON [dbo].[DepositorSession]
(
	[device_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ilanguage_code_DepositorSession]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [ilanguage_code_DepositorSession] ON [dbo].[DepositorSession]
(
	[language_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [ibranch_id_DeviceList]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [ibranch_id_DeviceList] ON [dbo].[Device]
(
	[branch_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [iconfig_group_DeviceList]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iconfig_group_DeviceList] ON [dbo].[Device]
(
	[config_group] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [icurrency_list_DeviceList]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [icurrency_list_DeviceList] ON [dbo].[Device]
(
	[currency_list] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [iGUIScreen_list_DeviceList]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iGUIScreen_list_DeviceList] ON [dbo].[Device]
(
	[GUIScreen_list] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [ilanguage_list_Device]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [ilanguage_list_Device] ON [dbo].[Device]
(
	[language_list] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [itransaction_type_list_DeviceList]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [itransaction_type_list_DeviceList] ON [dbo].[Device]
(
	[transaction_type_list] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [itype_id_DeviceList]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [itype_id_DeviceList] ON [dbo].[Device]
(
	[type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [iuser_group_DeviceList]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iuser_group_DeviceList] ON [dbo].[Device]
(
	[user_group] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [iconfig_id_DeviceConfig]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iconfig_id_DeviceConfig] ON [dbo].[DeviceConfig]
(
	[config_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [igroup_id_DeviceConfig]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [igroup_id_DeviceConfig] ON [dbo].[DeviceConfig]
(
	[group_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idevice_DeviceLock]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [idevice_DeviceLock] ON [dbo].[DeviceLock]
(
	[device_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [ilocking_user_DeviceLock]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [ilocking_user_DeviceLock] ON [dbo].[DeviceLock]
(
	[locking_user] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [iUser_DeviceLogin]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iUser_DeviceLogin] ON [dbo].[DeviceLogin]
(
	[User] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idevice_id_DevicePrinter]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [idevice_id_DevicePrinter] ON [dbo].[DevicePrinter]
(
	[device_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idevice_id_DeviceStatus]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [idevice_id_DeviceStatus] ON [dbo].[DeviceStatus]
(
	[device_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [icurrency_code_DeviceSuspenseAccount]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [icurrency_code_DeviceSuspenseAccount] ON [dbo].[DeviceSuspenseAccount]
(
	[currency_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idevice_id_DeviceSuspenseAccount]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [idevice_id_DeviceSuspenseAccount] ON [dbo].[DeviceSuspenseAccount]
(
	[device_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [iValue_GUIPrepopItem]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iValue_GUIPrepopItem] ON [dbo].[GUIPrepopItem]
(
	[value] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [iItem_GUIPrepopList_Item]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iItem_GUIPrepopList_Item] ON [dbo].[GUIPrepopList_Item]
(
	[Item] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [iList_GUIPrepopList_Item]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iList_GUIPrepopList_Item] ON [dbo].[GUIPrepopList_Item]
(
	[List] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UX_GUIPrepopList_ListOrder]    Script Date: 29/08/2025 15:51:39 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UX_GUIPrepopList_ListOrder] ON [dbo].[GUIPrepopList_Item]
(
	[List_Order] ASC,
	[List] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [itype_GUIScreen]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [itype_GUIScreen] ON [dbo].[GUIScreen]
(
	[type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [igui_screen_list_GuiScreenList_Screen]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [igui_screen_list_GuiScreenList_Screen] ON [dbo].[GuiScreenList_Screen]
(
	[gui_screen_list] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [iguiprepoplist_id_GuiScreenList_Screen]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iguiprepoplist_id_GuiScreenList_Screen] ON [dbo].[GuiScreenList_Screen]
(
	[guiprepoplist_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [iscreen_GuiScreenList_Screen]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iscreen_GuiScreenList_Screen] ON [dbo].[GuiScreenList_Screen]
(
	[screen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [ivalidation_list_id_GuiScreenList_Screen]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [ivalidation_list_id_GuiScreenList_Screen] ON [dbo].[GuiScreenList_Screen]
(
	[validation_list_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [ibtn_accept_caption_GUIScreenText]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [ibtn_accept_caption_GUIScreenText] ON [dbo].[GUIScreenText]
(
	[btn_accept_caption] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [ibtn_back_caption_GUIScreenText]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [ibtn_back_caption_GUIScreenText] ON [dbo].[GUIScreenText]
(
	[btn_back_caption] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [ibtn_cancel_caption_GUIScreenText]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [ibtn_cancel_caption_GUIScreenText] ON [dbo].[GUIScreenText]
(
	[btn_cancel_caption] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [ifull_instructions_GUIScreenText]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [ifull_instructions_GUIScreenText] ON [dbo].[GUIScreenText]
(
	[full_instructions] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [iguiscreen_id_GUIScreenText]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iguiscreen_id_GUIScreenText] ON [dbo].[GUIScreenText]
(
	[guiscreen_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [iscreen_title_GUIScreenText]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iscreen_title_GUIScreenText] ON [dbo].[GUIScreenText]
(
	[screen_title] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [iscreen_title_instruction_GUIScreenText]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iscreen_title_instruction_GUIScreenText] ON [dbo].[GUIScreenText]
(
	[screen_title_instruction] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idefault_language_LanguageList]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [idefault_language_LanguageList] ON [dbo].[LanguageList]
(
	[default_language] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ilanguage_item_LanguageList_Language]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [ilanguage_item_LanguageList_Language] ON [dbo].[LanguageList_Language]
(
	[language_item] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [ilanguage_list_LanguageList_Language]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [ilanguage_list_LanguageList_Language] ON [dbo].[LanguageList_Language]
(
	[language_list] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [iUser_PasswordHistory]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iUser_PasswordHistory] ON [dbo].[PasswordHistory]
(
	[User] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [iactivity_id_Permission]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iactivity_id_Permission] ON [dbo].[Permission]
(
	[activity_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [irole_id_Permission]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [irole_id_Permission] ON [dbo].[Permission]
(
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [iprinter_id_PrinterStatus]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iprinter_id_PrinterStatus] ON [dbo].[PrinterStatus]
(
	[printer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [itx_id_Printout]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [itx_id_Printout] ON [dbo].[Printout]
(
	[tx_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [iauth_user_Transaction]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iauth_user_Transaction] ON [dbo].[Transaction]
(
	[auth_user] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [icit_id_Transaction]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [icit_id_Transaction] ON [dbo].[Transaction]
(
	[cit_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idevice_Transaction]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [idevice_Transaction] ON [dbo].[Transaction]
(
	[device_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [iinit_user_Transaction]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iinit_user_Transaction] ON [dbo].[Transaction]
(
	[init_user] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [isession_id_Transaction]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [isession_id_Transaction] ON [dbo].[Transaction]
(
	[session_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [itx_currency_Transaction]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [itx_currency_Transaction] ON [dbo].[Transaction]
(
	[tx_currency] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [itx_type_Transaction]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [itx_type_Transaction] ON [dbo].[Transaction]
(
	[tx_type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [icurrency_code_TransactionLimitListItem]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [icurrency_code_TransactionLimitListItem] ON [dbo].[TransactionLimitListItem]
(
	[currency_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [itransactionitemlist_id_TransactionLimitListItem]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [itransactionitemlist_id_TransactionLimitListItem] ON [dbo].[TransactionLimitListItem]
(
	[transactionitemlist_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [iaccount_name_caption_TransactionText]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iaccount_name_caption_TransactionText] ON [dbo].[TransactionText]
(
	[account_name_caption] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [iaccount_number_caption_TransactionText]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iaccount_number_caption_TransactionText] ON [dbo].[TransactionText]
(
	[account_number_caption] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [ialias_account_name_caption_TransactionText]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [ialias_account_name_caption_TransactionText] ON [dbo].[TransactionText]
(
	[alias_account_name_caption] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [ialias_account_number_caption_TransactionText]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [ialias_account_number_caption_TransactionText] ON [dbo].[TransactionText]
(
	[alias_account_number_caption] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idepositor_name_caption_TransactionText]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [idepositor_name_caption_TransactionText] ON [dbo].[TransactionText]
(
	[depositor_name_caption] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idisclaimer_TransactionText]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [idisclaimer_TransactionText] ON [dbo].[TransactionText]
(
	[disclaimer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [ifull_instructions_TransactionText]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [ifull_instructions_TransactionText] ON [dbo].[TransactionText]
(
	[full_instructions] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [iFundsSource_caption_TransactionText]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iFundsSource_caption_TransactionText] ON [dbo].[TransactionText]
(
	[FundsSource_caption] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [iid_number_caption_TransactionText]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iid_number_caption_TransactionText] ON [dbo].[TransactionText]
(
	[id_number_caption] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [ilistItem_caption_TransactionText]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [ilistItem_caption_TransactionText] ON [dbo].[TransactionText]
(
	[listItem_caption] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [inarration_caption_TransactionText]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [inarration_caption_TransactionText] ON [dbo].[TransactionText]
(
	[narration_caption] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [iphone_number_caption_TransactionText]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iphone_number_caption_TransactionText] ON [dbo].[TransactionText]
(
	[phone_number_caption] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [ireceipt_template_TransactionText]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [ireceipt_template_TransactionText] ON [dbo].[TransactionText]
(
	[receipt_template] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [ireference_account_name_caption_TransactionText]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [ireference_account_name_caption_TransactionText] ON [dbo].[TransactionText]
(
	[reference_account_name_caption] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [ireference_account_number_caption_TransactionText]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [ireference_account_number_caption_TransactionText] ON [dbo].[TransactionText]
(
	[reference_account_number_caption] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [iterms_TransactionText]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iterms_TransactionText] ON [dbo].[TransactionText]
(
	[terms] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [itx_item_TransactionText]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [itx_item_TransactionText] ON [dbo].[TransactionText]
(
	[tx_item] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [itxtype_list_item_TransactionTypeList_TransactionTypeListItem]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [itxtype_list_item_TransactionTypeList_TransactionTypeListItem] ON [dbo].[TransactionTypeList_TransactionTypeListItem]
(
	[txtype_list_item] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [itxtype_list_TransactionTypeList_TransactionTypeListItem]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [itxtype_list_TransactionTypeList_TransactionTypeListItem] ON [dbo].[TransactionTypeList_TransactionTypeListItem]
(
	[txtype_list] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [iaccount_permission_TransactionTypeListItem]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iaccount_permission_TransactionTypeListItem] ON [dbo].[TransactionTypeListItem]
(
	[account_permission] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idefault_account_currency_TransactionTypeListItem]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [idefault_account_currency_TransactionTypeListItem] ON [dbo].[TransactionTypeListItem]
(
	[default_account_currency] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [itx_limit_list_TransactionTypeListItem]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [itx_limit_list_TransactionTypeListItem] ON [dbo].[TransactionTypeListItem]
(
	[tx_limit_list] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [itx_text_TransactionTypeListItem]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [itx_text_TransactionTypeListItem] ON [dbo].[TransactionTypeListItem]
(
	[tx_text] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [itx_type_guiscreenlist_TransactionTypeListItem]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [itx_type_guiscreenlist_TransactionTypeListItem] ON [dbo].[TransactionTypeListItem]
(
	[tx_type_guiscreenlist] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [itx_type_TransactionTypeListItem]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [itx_type_TransactionTypeListItem] ON [dbo].[TransactionTypeListItem]
(
	[tx_type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [iparent_group_UserGroup]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iparent_group_UserGroup] ON [dbo].[UserGroup]
(
	[parent_group] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [iApplicationUserLoginDetail_UserLock]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iApplicationUserLoginDetail_UserLock] ON [dbo].[UserLock]
(
	[ApplicationUserLoginDetail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [iInitiatingUser_UserLock]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iInitiatingUser_UserLock] ON [dbo].[UserLock]
(
	[InitiatingUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [itype_id_ValidationItem]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [itype_id_ValidationItem] ON [dbo].[ValidationItem]
(
	[type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [ivalidation_text_id_ValidationItem]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [ivalidation_text_id_ValidationItem] ON [dbo].[ValidationItem]
(
	[validation_text_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [ivalidation_item_id_ValidationItemValue]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [ivalidation_item_id_ValidationItemValue] ON [dbo].[ValidationItemValue]
(
	[validation_item_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [ivalidation_item_id_ValidationList_ValidationItem]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [ivalidation_item_id_ValidationList_ValidationItem] ON [dbo].[ValidationList_ValidationItem]
(
	[validation_item_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [ivalidation_list_id_ValidationList_ValidationItem]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [ivalidation_list_id_ValidationList_ValidationItem] ON [dbo].[ValidationList_ValidationItem]
(
	[validation_list_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [ierror_message_ValidationText]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [ierror_message_ValidationText] ON [dbo].[ValidationText]
(
	[error_message] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [isuccess_message_ValidationText]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [isuccess_message_ValidationText] ON [dbo].[ValidationText]
(
	[success_message] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [ivalidation_item_id_ValidationText]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [ivalidation_item_id_ValidationText] ON [dbo].[ValidationText]
(
	[validation_item_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [iauthorising_user_exp_EscrowJam_EB67F9DC]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iauthorising_user_exp_EscrowJam_EB67F9DC] ON [exp].[EscrowJam]
(
	[authorising_user] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [iinitialising_user_exp_EscrowJam_39209E1C]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iinitialising_user_exp_EscrowJam_39209E1C] ON [exp].[EscrowJam]
(
	[initialising_user] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [itransaction_id_exp_EscrowJam_A9BA55BC]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [itransaction_id_exp_EscrowJam_A9BA55BC] ON [exp].[EscrowJam]
(
	[transaction_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [iCategory_xlns_sysTextItem_A264365A]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iCategory_xlns_sysTextItem_A264365A] ON [xlns].[sysTextItem]
(
	[Category] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [iTextItemTypeID_xlns_sysTextItem_BD18CE82]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iTextItemTypeID_xlns_sysTextItem_BD18CE82] ON [xlns].[sysTextItem]
(
	[TextItemTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [iParent_xlns_sysTextItemCategory_51488F7B]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iParent_xlns_sysTextItemCategory_51488F7B] ON [xlns].[sysTextItemCategory]
(
	[Parent] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [iLanguageCode_xlns_sysTextTranslation_03BB080F]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iLanguageCode_xlns_sysTextTranslation_03BB080F] ON [xlns].[sysTextTranslation]
(
	[LanguageCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [iSysTextItemID_xlns_sysTextTranslation_7FDC4652]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iSysTextItemID_xlns_sysTextTranslation_7FDC4652] ON [xlns].[sysTextTranslation]
(
	[SysTextItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [iCategory_xlns_TextItem_CDE8C5ED]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iCategory_xlns_TextItem_CDE8C5ED] ON [xlns].[TextItem]
(
	[Category] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [iTextItemTypeID_xlns_TextItem_2A2E0516]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iTextItemTypeID_xlns_TextItem_2A2E0516] ON [xlns].[TextItem]
(
	[TextItemTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [iParent_xlns_TextItemCategory_051D04A6]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iParent_xlns_TextItemCategory_051D04A6] ON [xlns].[TextItemCategory]
(
	[Parent] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [iLanguageCode_xlns_TextTranslation_0EDE47B6]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iLanguageCode_xlns_TextTranslation_0EDE47B6] ON [xlns].[TextTranslation]
(
	[LanguageCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [iTextItemID_xlns_TextTranslation_00B6C5AC]    Script Date: 29/08/2025 15:51:39 ******/
CREATE NONCLUSTERED INDEX [iTextItemID_xlns_TextTranslation_00B6C5AC] ON [xlns].[TextTranslation]
(
	[TextItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Activity] ADD  CONSTRAINT [DF_Activity_code]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[AlertEmail] ADD  CONSTRAINT [DF_Email_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[AlertEmail] ADD  CONSTRAINT [DF_Email_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[AlertEmail] ADD  CONSTRAINT [DF_Email_sent]  DEFAULT ((0)) FOR [sent]
GO
ALTER TABLE [dbo].[AlertEmail] ADD  CONSTRAINT [DF_AlertEmail_send_error]  DEFAULT ((0)) FOR [send_error]
GO
ALTER TABLE [dbo].[AlertEmailAttachment] ADD  CONSTRAINT [DF_AlertEmailAttachment_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[AlertEvent] ADD  CONSTRAINT [DF_EmailEvent_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[AlertEvent] ADD  CONSTRAINT [DF_AlertEvent_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[AlertEvent] ADD  CONSTRAINT [DF_EmailEvent_is_resolved]  DEFAULT ((0)) FOR [is_resolved]
GO
ALTER TABLE [dbo].[AlertEvent] ADD  CONSTRAINT [DF_AlertEvent_processed]  DEFAULT ((0)) FOR [is_processed]
GO
ALTER TABLE [dbo].[AlertEvent] ADD  CONSTRAINT [DF_AlertEvent_is_processing]  DEFAULT ((0)) FOR [is_processing]
GO
ALTER TABLE [dbo].[AlertMessageRegistry] ADD  CONSTRAINT [DF_AlertMessageRegistry_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[AlertMessageRegistry] ADD  CONSTRAINT [DF_AlertMessageRegistry_email_enabled]  DEFAULT ((1)) FOR [email_enabled]
GO
ALTER TABLE [dbo].[AlertMessageRegistry] ADD  CONSTRAINT [DF_AlertMessageRegistry_phone_enabled]  DEFAULT ((0)) FOR [phone_enabled]
GO
ALTER TABLE [dbo].[AlertMessageType] ADD  CONSTRAINT [DF_AlertMessageType_enabled_1]  DEFAULT ((1)) FOR [enabled]
GO
ALTER TABLE [dbo].[AlertSMS] ADD  CONSTRAINT [DF_AlertSMS_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[AlertSMS] ADD  CONSTRAINT [DF_AlertSMS_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[AlertSMS] ADD  CONSTRAINT [DF_AlertSMS_sent]  DEFAULT ((0)) FOR [sent]
GO
ALTER TABLE [dbo].[AlertSMS] ADD  CONSTRAINT [DF_AlertSMS_send_error]  DEFAULT ((0)) FOR [send_error]
GO
ALTER TABLE [dbo].[ApplicationLog] ADD  CONSTRAINT [DF_ApplicationLog_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[ApplicationUser] ADD  CONSTRAINT [DF_ApplicationUser_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[ApplicationUser] ADD  CONSTRAINT [DF_ApplicationUser_email_enabled]  DEFAULT ((1)) FOR [email_enabled]
GO
ALTER TABLE [dbo].[ApplicationUser] ADD  CONSTRAINT [DF_ApplicationUser_phone_enabled]  DEFAULT ((0)) FOR [phone_enabled]
GO
ALTER TABLE [dbo].[ApplicationUser] ADD  CONSTRAINT [DF_ApplicationUser_password_reset_required]  DEFAULT ((0)) FOR [password_reset_required]
GO
ALTER TABLE [dbo].[ApplicationUser] ADD  CONSTRAINT [DF_ApplicationUser_login_attempts]  DEFAULT ((0)) FOR [login_attempts]
GO
ALTER TABLE [dbo].[Bank] ADD  CONSTRAINT [DF_Bank_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[Branch] ADD  CONSTRAINT [DF_Branch_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[CIT] ADD  CONSTRAINT [DF_CIT_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[CIT] ADD  CONSTRAINT [DF_CIT_cit_date_1]  DEFAULT (getdate()) FOR [cit_date]
GO
ALTER TABLE [dbo].[CIT] ADD  CONSTRAINT [DF_CIT_complete]  DEFAULT ((0)) FOR [complete]
GO
ALTER TABLE [dbo].[CIT] ADD  CONSTRAINT [DF_CIT_cit_error_1]  DEFAULT ((0)) FOR [cit_error]
GO
ALTER TABLE [dbo].[CITDenominations] ADD  CONSTRAINT [DF_CITDenominations_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[CITPrintout] ADD  CONSTRAINT [DF_CITPrintout_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[CITPrintout] ADD  CONSTRAINT [DF_CITPrintout_datetime]  DEFAULT (getdate()) FOR [datetime]
GO
ALTER TABLE [dbo].[CITPrintout] ADD  CONSTRAINT [DF_CITPrintout_is_copy]  DEFAULT ((0)) FOR [is_copy]
GO
ALTER TABLE [dbo].[ConfigCategory] ADD  CONSTRAINT [DF_ConfigCategory_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[Country] ADD  CONSTRAINT [DF__Country__country__5EBF139D]  DEFAULT ('') FOR [country_code]
GO
ALTER TABLE [dbo].[Country] ADD  CONSTRAINT [DF__Country__country__5FB337D6]  DEFAULT ('') FOR [country_name]
GO
ALTER TABLE [dbo].[Currency] ADD  CONSTRAINT [DF_Currency_enabled]  DEFAULT ((0)) FOR [enabled]
GO
ALTER TABLE [dbo].[CurrencyList_Currency] ADD  CONSTRAINT [DF_CurrencyList_Currency_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[CurrencyList_Currency] ADD  CONSTRAINT [DF_CurrencyList_Currency_max_value]  DEFAULT ((0)) FOR [max_value]
GO
ALTER TABLE [dbo].[CurrencyList_Currency] ADD  CONSTRAINT [DF_CurrencyList_Currency_max_count]  DEFAULT ((0)) FOR [max_count]
GO
ALTER TABLE [dbo].[DenominationDetail] ADD  CONSTRAINT [DF_DenominationDetail_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[DepositorSession] ADD  CONSTRAINT [DF_DepositorSession_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[DepositorSession] ADD  CONSTRAINT [DF_DepositorSession_session_complete]  DEFAULT ((0)) FOR [complete]
GO
ALTER TABLE [dbo].[DepositorSession] ADD  CONSTRAINT [DF_DepositorSession_complete_success]  DEFAULT ((0)) FOR [complete_success]
GO
ALTER TABLE [dbo].[DepositorSession] ADD  CONSTRAINT [DF_DepositorSession_terms_accepted]  DEFAULT ((0)) FOR [terms_accepted]
GO
ALTER TABLE [dbo].[DepositorSession] ADD  CONSTRAINT [DF_DepositorSession_account_verified]  DEFAULT ((0)) FOR [account_verified]
GO
ALTER TABLE [dbo].[DepositorSession] ADD  CONSTRAINT [DF_DepositorSession_reference_account_verified]  DEFAULT ((0)) FOR [reference_account_verified]
GO
ALTER TABLE [dbo].[Device] ADD  CONSTRAINT [DF_DeviceList_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[Device] ADD  CONSTRAINT [DF_Device_enabled]  DEFAULT ((0)) FOR [enabled]
GO
ALTER TABLE [dbo].[Device] ADD  CONSTRAINT [DF_Device_GUIScreenList]  DEFAULT ((1)) FOR [GUIScreen_list]
GO
ALTER TABLE [dbo].[Device] ADD  CONSTRAINT [DF_DeviceList_transactionList]  DEFAULT ((1)) FOR [transaction_type_list]
GO
ALTER TABLE [dbo].[Device] ADD  CONSTRAINT [DF_DeviceList_login_cycles]  DEFAULT ((0)) FOR [login_cycles]
GO
ALTER TABLE [dbo].[Device] ADD  CONSTRAINT [DF_DeviceList_login_attempts]  DEFAULT ((0)) FOR [login_attempts]
GO
ALTER TABLE [dbo].[DeviceConfig] ADD  CONSTRAINT [DF_DeviceConfig_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[DeviceLock] ADD  CONSTRAINT [DF_DeviceLock_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[DeviceLogin] ADD  CONSTRAINT [DF_DeviceLogin_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[DevicePrinter] ADD  CONSTRAINT [DF_DevicePrinter_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[DevicePrinter] ADD  CONSTRAINT [DF_DevicePrinter_is_infront_2]  DEFAULT ((1)) FOR [is_infront]
GO
ALTER TABLE [dbo].[DeviceStatus] ADD  CONSTRAINT [DF_DeviceStatus_id_1]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[DeviceStatus] ADD  CONSTRAINT [DF_DeviceStatus_current_status_1]  DEFAULT ((0)) FOR [current_status]
GO
ALTER TABLE [dbo].[DeviceSuspenseAccount] ADD  CONSTRAINT [DF_Device_SuspenseAccount_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[DeviceSuspenseAccount] ADD  CONSTRAINT [DF_Device_SuspenseAccount_enabled]  DEFAULT ((0)) FOR [enabled]
GO
ALTER TABLE [dbo].[DeviceType] ADD  CONSTRAINT [DF_DeviceType_note_escrow]  DEFAULT ((0)) FOR [note_escrow]
GO
ALTER TABLE [dbo].[DeviceType] ADD  CONSTRAINT [DF_DeviceType_coin_escrow]  DEFAULT ((0)) FOR [coin_escrow]
GO
ALTER TABLE [dbo].[GUIPrepopItem] ADD  CONSTRAINT [DF_GUIPrepopItem_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[GUIPrepopItem] ADD  CONSTRAINT [DF_GUIPrepopItem_Enabled]  DEFAULT ((1)) FOR [enabled]
GO
ALTER TABLE [dbo].[GUIPrepopList] ADD  CONSTRAINT [DF_GUIPrepopList_ID]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[GUIPrepopList] ADD  CONSTRAINT [DF_GUIPrepopList_enabled]  DEFAULT ((1)) FOR [enabled]
GO
ALTER TABLE [dbo].[GUIPrepopList] ADD  CONSTRAINT [DF_GUIPrepopList_AllowFreeText]  DEFAULT ((0)) FOR [AllowFreeText]
GO
ALTER TABLE [dbo].[GUIPrepopList] ADD  CONSTRAINT [DF_GUIPrepopList_DefaultIndex]  DEFAULT ((0)) FOR [DefaultIndex]
GO
ALTER TABLE [dbo].[GUIPrepopList] ADD  CONSTRAINT [DF_GUIPrepopList_UseDefault]  DEFAULT ((1)) FOR [UseDefault]
GO
ALTER TABLE [dbo].[GUIPrepopList_Item] ADD  CONSTRAINT [DF_GUIPrepopList_Item_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[GuiScreenList_Screen] ADD  CONSTRAINT [DF_GuiScreenList_Screen_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[GuiScreenList_Screen] ADD  CONSTRAINT [DF_GuiScreenList_Screen_required]  DEFAULT ((0)) FOR [required]
GO
ALTER TABLE [dbo].[GUIScreenText] ADD  CONSTRAINT [DF_GUIScreenText_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[Language] ADD  CONSTRAINT [DF_Languages_enabled]  DEFAULT ((0)) FOR [enabled]
GO
ALTER TABLE [dbo].[LanguageList] ADD  CONSTRAINT [DF_LanguageList_enabled]  DEFAULT ((1)) FOR [enabled]
GO
ALTER TABLE [dbo].[LanguageList_Language] ADD  CONSTRAINT [DF_LanguageList_Language_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[PasswordHistory] ADD  CONSTRAINT [MSmerge_default_constraint_for_rowguidcol_of_1075859991]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[PasswordPolicy] ADD  CONSTRAINT [DF_PasswordPolicy_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[PasswordPolicy] ADD  CONSTRAINT [DF_PasswordPolicy_use_history]  DEFAULT ((1)) FOR [use_history]
GO
ALTER TABLE [dbo].[Permission] ADD  CONSTRAINT [DF_Permission_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[PrinterStatus] ADD  CONSTRAINT [DF_PrinterStatus_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[PrinterStatus] ADD  CONSTRAINT [DF_PrinterStatus_is_error]  DEFAULT ((0)) FOR [is_error]
GO
ALTER TABLE [dbo].[PrinterStatus] ADD  CONSTRAINT [DF_PrinterStatus_has_paper]  DEFAULT ((0)) FOR [has_paper]
GO
ALTER TABLE [dbo].[PrinterStatus] ADD  CONSTRAINT [DF_PrinterStatus_cover_open]  DEFAULT ((0)) FOR [cover_open]
GO
ALTER TABLE [dbo].[PrinterStatus] ADD  CONSTRAINT [DF_PrinterStatus_modified]  DEFAULT (getdate()) FOR [modified]
GO
ALTER TABLE [dbo].[Printout] ADD  CONSTRAINT [DF_Printout_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[Printout] ADD  CONSTRAINT [DF_Printout_datetime_1]  DEFAULT (getdate()) FOR [datetime]
GO
ALTER TABLE [dbo].[Printout] ADD  CONSTRAINT [DF_Printout_is_copy]  DEFAULT ((0)) FOR [is_copy]
GO
ALTER TABLE [dbo].[Role] ADD  CONSTRAINT [DF_Role_code]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[Transaction] ADD  CONSTRAINT [DF_Transaction_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[Transaction] ADD  CONSTRAINT [DF_Transaction_tx_completed]  DEFAULT ((0)) FOR [tx_completed]
GO
ALTER TABLE [dbo].[Transaction] ADD  CONSTRAINT [DF_Transaction_tx_result]  DEFAULT ((0)) FOR [tx_result]
GO
ALTER TABLE [dbo].[Transaction] ADD  CONSTRAINT [DF_Transaction_tx_error_code]  DEFAULT ((0)) FOR [tx_error_code]
GO
ALTER TABLE [dbo].[Transaction] ADD  CONSTRAINT [DF_Transaction_notes_rejected]  DEFAULT ((0)) FOR [notes_rejected]
GO
ALTER TABLE [dbo].[Transaction] ADD  CONSTRAINT [DF_Transaction_jam_detected_1]  DEFAULT ((0)) FOR [jam_detected]
GO
ALTER TABLE [dbo].[Transaction] ADD  CONSTRAINT [DF_Transaction_escrow_jam]  DEFAULT ((0)) FOR [escrow_jam]
GO
ALTER TABLE [dbo].[TransactionLimitList] ADD  CONSTRAINT [DF_TransactionLimitList_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[TransactionLimitListItem] ADD  CONSTRAINT [DF_TransactionLimitListItem_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[TransactionLimitListItem] ADD  CONSTRAINT [DF_TransactionLimitListItem_show_funds_source]  DEFAULT ((0)) FOR [show_funds_source]
GO
ALTER TABLE [dbo].[TransactionLimitListItem] ADD  CONSTRAINT [DF_TransactionLimitListItem_funds_source_amount]  DEFAULT ((0)) FOR [funds_source_amount]
GO
ALTER TABLE [dbo].[TransactionLimitListItem] ADD  CONSTRAINT [DF_TransactionLimitListItem_prevent_overdeposit]  DEFAULT ((0)) FOR [prevent_overdeposit]
GO
ALTER TABLE [dbo].[TransactionLimitListItem] ADD  CONSTRAINT [DF_TransactionLimitListItem_overdeposit_amount]  DEFAULT ((0)) FOR [overdeposit_amount]
GO
ALTER TABLE [dbo].[TransactionLimitListItem] ADD  CONSTRAINT [DF_TransactionLimitListItem_prevent_underdeposit]  DEFAULT ((1)) FOR [prevent_underdeposit]
GO
ALTER TABLE [dbo].[TransactionLimitListItem] ADD  CONSTRAINT [DF_TransactionLimitListItem_underdeposit_amount]  DEFAULT ((0)) FOR [underdeposit_amount]
GO
ALTER TABLE [dbo].[TransactionLimitListItem] ADD  CONSTRAINT [DF_TransactionLimitListItem_prevent_overcount]  DEFAULT ((0)) FOR [prevent_overcount]
GO
ALTER TABLE [dbo].[TransactionLimitListItem] ADD  CONSTRAINT [DF_TransactionLimitListItem_overcount_amount]  DEFAULT ((0)) FOR [overcount_amount]
GO
ALTER TABLE [dbo].[TransactionText] ADD  CONSTRAINT [DF_TransactionText_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[TransactionType] ADD  CONSTRAINT [DF_TransactionType_enabled_1]  DEFAULT ((0)) FOR [enabled]
GO
ALTER TABLE [dbo].[TransactionTypeList] ADD  CONSTRAINT [DF_TransactionTypeList_enabled]  DEFAULT ((0)) FOR [enabled]
GO
ALTER TABLE [dbo].[TransactionTypeList_TransactionTypeListItem] ADD  CONSTRAINT [DF_TransactionTypeList_TransactionTypeListItem_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[TransactionTypeListItem] ADD  CONSTRAINT [DF_TransactionTypeListItem_validate_reference_account]  DEFAULT ((0)) FOR [validate_reference_account]
GO
ALTER TABLE [dbo].[TransactionTypeListItem] ADD  CONSTRAINT [DF_TransactionTypeListItem_default_account_currency]  DEFAULT ('KES') FOR [default_account_currency]
GO
ALTER TABLE [dbo].[TransactionTypeListItem] ADD  CONSTRAINT [DF_TransactionTypeListItem_validate_default_account]  DEFAULT ((0)) FOR [validate_default_account]
GO
ALTER TABLE [dbo].[TransactionTypeListItem] ADD  CONSTRAINT [DF_TransactionListItem_enabled]  DEFAULT ((1)) FOR [enabled]
GO
ALTER TABLE [dbo].[TransactionTypeListItem] ADD  CONSTRAINT [DF_TransactionTypeListItem_tx_type_guiscreenlist]  DEFAULT ((1)) FOR [tx_type_guiscreenlist]
GO
ALTER TABLE [dbo].[TransactionTypeListItem] ADD  CONSTRAINT [DF_TransactionTypeListItem_init_user_required]  DEFAULT ((0)) FOR [init_user_required]
GO
ALTER TABLE [dbo].[TransactionTypeListItem] ADD  CONSTRAINT [DF_TransactionTypeListItem_auth_user_required]  DEFAULT ((0)) FOR [auth_user_required]
GO
ALTER TABLE [dbo].[UptimeComponentState] ADD  CONSTRAINT [DF_UptimeComponentState_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[UptimeComponentState] ADD  CONSTRAINT [DF_UptimeComponentState_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[UptimeMode] ADD  CONSTRAINT [DF_UptimeMode_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[UptimeMode] ADD  CONSTRAINT [DF_UptimeMode_created]  DEFAULT (getdate()) FOR [created]
GO
ALTER TABLE [dbo].[UserLock] ADD  CONSTRAINT [DF_UserLock_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[ValidationItem] ADD  CONSTRAINT [DF_ValidationItem_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[ValidationItem] ADD  CONSTRAINT [DF_ValidationItem_enabled]  DEFAULT ((0)) FOR [enabled]
GO
ALTER TABLE [dbo].[ValidationItemValue] ADD  CONSTRAINT [DF_ValidationItemValue_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[ValidationList] ADD  CONSTRAINT [DF_ValidationList_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[ValidationList] ADD  CONSTRAINT [DF_ValidationList_enabled]  DEFAULT ((0)) FOR [enabled]
GO
ALTER TABLE [dbo].[ValidationList_ValidationItem] ADD  CONSTRAINT [DF_ValidationList_ValidationItem_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[ValidationList_ValidationItem] ADD  CONSTRAINT [DF_ValidationList_ValidationItem_enabled]  DEFAULT ((1)) FOR [enabled]
GO
ALTER TABLE [dbo].[ValidationText] ADD  CONSTRAINT [DF_ValidationText_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[ValidationType] ADD  CONSTRAINT [DF_ValidationType_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[ValidationType] ADD  CONSTRAINT [DF_ValidationType_enabled]  DEFAULT ((0)) FOR [enabled]
GO
ALTER TABLE [exp].[ApplicationException] ADD  CONSTRAINT [DF_ApplicationException_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [exp].[CrashEvent] ADD  CONSTRAINT [DF_CrashEvent_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [exp].[EscrowJam] ADD  CONSTRAINT [DF_EscrowJam_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [exp].[SessionException] ADD  CONSTRAINT [DF_SessionException_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [exp].[TransactionException] ADD  CONSTRAINT [DF_TransactionException_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [xlns].[sysTextItem] ADD  CONSTRAINT [DF_SysTextItem_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [xlns].[sysTextItemCategory] ADD  CONSTRAINT [DF_TextItemCategory_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [xlns].[sysTextItemType] ADD  CONSTRAINT [DF_sysTextItemType_id]  DEFAULT (newid()) FOR [id]
GO
ALTER TABLE [xlns].[sysTextTranslation] ADD  CONSTRAINT [DF_Translation_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [xlns].[TextItem] ADD  CONSTRAINT [DF_UI_TextItem_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [xlns].[TextItemCategory] ADD  CONSTRAINT [DF_UI_TextItemCategory_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [xlns].[TextItemType] ADD  CONSTRAINT [DF_UI_TextItemType_id]  DEFAULT (newid()) FOR [id]
GO
ALTER TABLE [xlns].[TextTranslation] ADD  CONSTRAINT [DF_UI_Translation_id]  DEFAULT (newsequentialid()) FOR [id]
GO
ALTER TABLE [dbo].[AlertEmail]  WITH NOCHECK ADD  CONSTRAINT [FK_AlertEmail_AlertEmailEvent] FOREIGN KEY([alert_event_id])
REFERENCES [dbo].[AlertEvent] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[AlertEmail] CHECK CONSTRAINT [FK_AlertEmail_AlertEmailEvent]
GO
ALTER TABLE [dbo].[AlertEvent]  WITH NOCHECK ADD  CONSTRAINT [FK_AlertEmailEvent_AlertEmailEvent] FOREIGN KEY([alert_event_id])
REFERENCES [dbo].[AlertEvent] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[AlertEvent] CHECK CONSTRAINT [FK_AlertEmailEvent_AlertEmailEvent]
GO
ALTER TABLE [dbo].[AlertMessageRegistry]  WITH NOCHECK ADD  CONSTRAINT [FK_AlertMessageRegistry_AlertMessageType] FOREIGN KEY([alert_type_id])
REFERENCES [dbo].[AlertMessageType] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[AlertMessageRegistry] CHECK CONSTRAINT [FK_AlertMessageRegistry_AlertMessageType]
GO
ALTER TABLE [dbo].[AlertMessageRegistry]  WITH NOCHECK ADD  CONSTRAINT [FK_AlertMessageRegistry_Role] FOREIGN KEY([role_id])
REFERENCES [dbo].[Role] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[AlertMessageRegistry] CHECK CONSTRAINT [FK_AlertMessageRegistry_Role]
GO
ALTER TABLE [dbo].[AlertSMS]  WITH NOCHECK ADD  CONSTRAINT [FK_AlertSMS_AlertEvent] FOREIGN KEY([alert_event_id])
REFERENCES [dbo].[AlertEvent] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[AlertSMS] CHECK CONSTRAINT [FK_AlertSMS_AlertEvent]
GO
ALTER TABLE [dbo].[ApplicationUser]  WITH NOCHECK ADD  CONSTRAINT [FK_ApplicationUser_Role] FOREIGN KEY([role_id])
REFERENCES [dbo].[Role] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[ApplicationUser] CHECK CONSTRAINT [FK_ApplicationUser_Role]
GO
ALTER TABLE [dbo].[ApplicationUser]  WITH NOCHECK ADD  CONSTRAINT [FK_ApplicationUser_UserGroup] FOREIGN KEY([user_group])
REFERENCES [dbo].[UserGroup] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[ApplicationUser] CHECK CONSTRAINT [FK_ApplicationUser_UserGroup]
GO
ALTER TABLE [dbo].[Bank]  WITH NOCHECK ADD  CONSTRAINT [FK_Bank_Country] FOREIGN KEY([country_code])
REFERENCES [dbo].[Country] ([country_code])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[Bank] CHECK CONSTRAINT [FK_Bank_Country]
GO
ALTER TABLE [dbo].[Branch]  WITH NOCHECK ADD  CONSTRAINT [FK_Branch_Bank] FOREIGN KEY([bank_id])
REFERENCES [dbo].[Bank] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[Branch] CHECK CONSTRAINT [FK_Branch_Bank]
GO
ALTER TABLE [dbo].[CIT]  WITH NOCHECK ADD  CONSTRAINT [FK_CIT_ApplicationUser_AuthUser] FOREIGN KEY([auth_user])
REFERENCES [dbo].[ApplicationUser] ([id])
ON DELETE CASCADE
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[CIT] CHECK CONSTRAINT [FK_CIT_ApplicationUser_AuthUser]
GO
ALTER TABLE [dbo].[CIT]  WITH NOCHECK ADD  CONSTRAINT [FK_CIT_ApplicationUser_StartUser] FOREIGN KEY([start_user])
REFERENCES [dbo].[ApplicationUser] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[CIT] CHECK CONSTRAINT [FK_CIT_ApplicationUser_StartUser]
GO
ALTER TABLE [dbo].[CIT]  WITH NOCHECK ADD  CONSTRAINT [FK_CIT_DeviceList] FOREIGN KEY([device_id])
REFERENCES [dbo].[Device] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[CIT] CHECK CONSTRAINT [FK_CIT_DeviceList]
GO
ALTER TABLE [dbo].[CITDenominations]  WITH NOCHECK ADD  CONSTRAINT [FK_CITDenominations_CIT] FOREIGN KEY([cit_id])
REFERENCES [dbo].[CIT] ([id])
ON DELETE CASCADE
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[CITDenominations] CHECK CONSTRAINT [FK_CITDenominations_CIT]
GO
ALTER TABLE [dbo].[CITDenominations]  WITH NOCHECK ADD  CONSTRAINT [FK_CITDenominations_Currency] FOREIGN KEY([currency_id])
REFERENCES [dbo].[Currency] ([code])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[CITDenominations] CHECK CONSTRAINT [FK_CITDenominations_Currency]
GO
ALTER TABLE [dbo].[CITPrintout]  WITH NOCHECK ADD  CONSTRAINT [FK_CITPrintout_CIT] FOREIGN KEY([cit_id])
REFERENCES [dbo].[CIT] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[CITPrintout] CHECK CONSTRAINT [FK_CITPrintout_CIT]
GO
ALTER TABLE [dbo].[Config]  WITH NOCHECK ADD  CONSTRAINT [FK_Config_ConfigCategory] FOREIGN KEY([category_id])
REFERENCES [dbo].[ConfigCategory] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[Config] CHECK CONSTRAINT [FK_Config_ConfigCategory]
GO
ALTER TABLE [dbo].[ConfigGroup]  WITH NOCHECK ADD  CONSTRAINT [FK_ConfigGroup_ConfigGroup] FOREIGN KEY([parent_group])
REFERENCES [dbo].[ConfigGroup] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[ConfigGroup] CHECK CONSTRAINT [FK_ConfigGroup_ConfigGroup]
GO
ALTER TABLE [dbo].[CurrencyList]  WITH NOCHECK ADD  CONSTRAINT [FK_CurrencyList_Currency] FOREIGN KEY([default_currency])
REFERENCES [dbo].[Currency] ([code])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[CurrencyList] CHECK CONSTRAINT [FK_CurrencyList_Currency]
GO
ALTER TABLE [dbo].[CurrencyList_Currency]  WITH NOCHECK ADD  CONSTRAINT [FK_Currency_CurrencyList_Currency] FOREIGN KEY([currency_item])
REFERENCES [dbo].[Currency] ([code])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[CurrencyList_Currency] CHECK CONSTRAINT [FK_Currency_CurrencyList_Currency]
GO
ALTER TABLE [dbo].[CurrencyList_Currency]  WITH NOCHECK ADD  CONSTRAINT [FK_Currency_CurrencyList_CurrencyList] FOREIGN KEY([currency_list])
REFERENCES [dbo].[CurrencyList] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[CurrencyList_Currency] CHECK CONSTRAINT [FK_Currency_CurrencyList_CurrencyList]
GO
ALTER TABLE [dbo].[DenominationDetail]  WITH NOCHECK ADD  CONSTRAINT [FK_DenominationDetail_Transaction] FOREIGN KEY([tx_id])
REFERENCES [dbo].[Transaction] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[DenominationDetail] CHECK CONSTRAINT [FK_DenominationDetail_Transaction]
GO
ALTER TABLE [dbo].[DepositorSession]  WITH NOCHECK ADD  CONSTRAINT [FK_DepositorSession_DeviceList] FOREIGN KEY([device_id])
REFERENCES [dbo].[Device] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[DepositorSession] CHECK CONSTRAINT [FK_DepositorSession_DeviceList]
GO
ALTER TABLE [dbo].[DepositorSession]  WITH NOCHECK ADD  CONSTRAINT [FK_DepositorSession_Language] FOREIGN KEY([language_code])
REFERENCES [dbo].[Language] ([code])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[DepositorSession] CHECK CONSTRAINT [FK_DepositorSession_Language]
GO
ALTER TABLE [dbo].[Device]  WITH NOCHECK ADD  CONSTRAINT [FK_Device_LanguageList] FOREIGN KEY([language_list])
REFERENCES [dbo].[LanguageList] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[Device] CHECK CONSTRAINT [FK_Device_LanguageList]
GO
ALTER TABLE [dbo].[Device]  WITH NOCHECK ADD  CONSTRAINT [FK_DeviceList_Branch] FOREIGN KEY([branch_id])
REFERENCES [dbo].[Branch] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[Device] CHECK CONSTRAINT [FK_DeviceList_Branch]
GO
ALTER TABLE [dbo].[Device]  WITH NOCHECK ADD  CONSTRAINT [FK_DeviceList_ConfigGroup] FOREIGN KEY([config_group])
REFERENCES [dbo].[ConfigGroup] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[Device] CHECK CONSTRAINT [FK_DeviceList_ConfigGroup]
GO
ALTER TABLE [dbo].[Device]  WITH NOCHECK ADD  CONSTRAINT [FK_DeviceList_CurrencyList] FOREIGN KEY([currency_list])
REFERENCES [dbo].[CurrencyList] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[Device] CHECK CONSTRAINT [FK_DeviceList_CurrencyList]
GO
ALTER TABLE [dbo].[Device]  WITH NOCHECK ADD  CONSTRAINT [FK_DeviceList_DeviceType] FOREIGN KEY([type_id])
REFERENCES [dbo].[DeviceType] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[Device] CHECK CONSTRAINT [FK_DeviceList_DeviceType]
GO
ALTER TABLE [dbo].[Device]  WITH NOCHECK ADD  CONSTRAINT [FK_DeviceList_GUIScreenList] FOREIGN KEY([GUIScreen_list])
REFERENCES [dbo].[GUIScreenList] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[Device] CHECK CONSTRAINT [FK_DeviceList_GUIScreenList]
GO
ALTER TABLE [dbo].[Device]  WITH NOCHECK ADD  CONSTRAINT [FK_DeviceList_TransactionTypeList] FOREIGN KEY([transaction_type_list])
REFERENCES [dbo].[TransactionTypeList] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[Device] CHECK CONSTRAINT [FK_DeviceList_TransactionTypeList]
GO
ALTER TABLE [dbo].[Device]  WITH NOCHECK ADD  CONSTRAINT [FK_DeviceList_UserGroup] FOREIGN KEY([user_group])
REFERENCES [dbo].[UserGroup] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[Device] CHECK CONSTRAINT [FK_DeviceList_UserGroup]
GO
ALTER TABLE [dbo].[DeviceConfig]  WITH NOCHECK ADD  CONSTRAINT [FK_DeviceConfig_Config] FOREIGN KEY([config_id])
REFERENCES [dbo].[Config] ([name])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[DeviceConfig] CHECK CONSTRAINT [FK_DeviceConfig_Config]
GO
ALTER TABLE [dbo].[DeviceConfig]  WITH NOCHECK ADD  CONSTRAINT [FK_DeviceConfig_ConfigGroup] FOREIGN KEY([group_id])
REFERENCES [dbo].[ConfigGroup] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[DeviceConfig] CHECK CONSTRAINT [FK_DeviceConfig_ConfigGroup]
GO
ALTER TABLE [dbo].[DeviceLock]  WITH NOCHECK ADD  CONSTRAINT [FK_DeviceLock_ApplicationUser_locking_user] FOREIGN KEY([locking_user])
REFERENCES [dbo].[ApplicationUser] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[DeviceLock] CHECK CONSTRAINT [FK_DeviceLock_ApplicationUser_locking_user]
GO
ALTER TABLE [dbo].[DeviceLock]  WITH NOCHECK ADD  CONSTRAINT [FK_DeviceLock_Device] FOREIGN KEY([device_id])
REFERENCES [dbo].[Device] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[DeviceLock] CHECK CONSTRAINT [FK_DeviceLock_Device]
GO
ALTER TABLE [dbo].[DeviceLogin]  WITH NOCHECK ADD  CONSTRAINT [FK_DeviceLogin_ApplicationUser] FOREIGN KEY([User])
REFERENCES [dbo].[ApplicationUser] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[DeviceLogin] CHECK CONSTRAINT [FK_DeviceLogin_ApplicationUser]
GO
ALTER TABLE [dbo].[DeviceLogin]  WITH NOCHECK ADD  CONSTRAINT [FK_DeviceLogin_Device] FOREIGN KEY([device_id])
REFERENCES [dbo].[Device] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[DeviceLogin] CHECK CONSTRAINT [FK_DeviceLogin_Device]
GO
ALTER TABLE [dbo].[DevicePrinter]  WITH NOCHECK ADD  CONSTRAINT [FK_DevicePrinter_DeviceList] FOREIGN KEY([device_id])
REFERENCES [dbo].[Device] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[DevicePrinter] CHECK CONSTRAINT [FK_DevicePrinter_DeviceList]
GO
ALTER TABLE [dbo].[DeviceSuspenseAccount]  WITH NOCHECK ADD  CONSTRAINT [FK_DeviceSuspenseAccount_Currency] FOREIGN KEY([currency_code])
REFERENCES [dbo].[Currency] ([code])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[DeviceSuspenseAccount] CHECK CONSTRAINT [FK_DeviceSuspenseAccount_Currency]
GO
ALTER TABLE [dbo].[DeviceSuspenseAccount]  WITH NOCHECK ADD  CONSTRAINT [FK_DeviceSuspenseAccount_DeviceList] FOREIGN KEY([device_id])
REFERENCES [dbo].[Device] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[DeviceSuspenseAccount] CHECK CONSTRAINT [FK_DeviceSuspenseAccount_DeviceList]
GO
ALTER TABLE [dbo].[GUIPrepopItem]  WITH NOCHECK ADD  CONSTRAINT [FK_GUIPrepopItem_TextItem] FOREIGN KEY([value])
REFERENCES [xlns].[TextItem] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[GUIPrepopItem] CHECK CONSTRAINT [FK_GUIPrepopItem_TextItem]
GO
ALTER TABLE [dbo].[GUIPrepopList_Item]  WITH NOCHECK ADD  CONSTRAINT [FK_GUIPrepopList_Item_GUIPrepopItem] FOREIGN KEY([Item])
REFERENCES [dbo].[GUIPrepopItem] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[GUIPrepopList_Item] CHECK CONSTRAINT [FK_GUIPrepopList_Item_GUIPrepopItem]
GO
ALTER TABLE [dbo].[GUIPrepopList_Item]  WITH NOCHECK ADD  CONSTRAINT [FK_GUIPrepopList_Item_GUIPrepopList] FOREIGN KEY([List])
REFERENCES [dbo].[GUIPrepopList] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[GUIPrepopList_Item] CHECK CONSTRAINT [FK_GUIPrepopList_Item_GUIPrepopList]
GO
ALTER TABLE [dbo].[GUIScreen]  WITH NOCHECK ADD  CONSTRAINT [FK_GUIScreen_GUIScreenType] FOREIGN KEY([type])
REFERENCES [dbo].[GUIScreenType] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[GUIScreen] CHECK CONSTRAINT [FK_GUIScreen_GUIScreenType]
GO
ALTER TABLE [dbo].[GuiScreenList_Screen]  WITH NOCHECK ADD  CONSTRAINT [FK_GuiScreenList_Screen_GUIPrepopList] FOREIGN KEY([guiprepoplist_id])
REFERENCES [dbo].[GUIPrepopList] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[GuiScreenList_Screen] CHECK CONSTRAINT [FK_GuiScreenList_Screen_GUIPrepopList]
GO
ALTER TABLE [dbo].[GuiScreenList_Screen]  WITH NOCHECK ADD  CONSTRAINT [FK_GuiScreenList_Screen_GUIScreen] FOREIGN KEY([screen])
REFERENCES [dbo].[GUIScreen] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[GuiScreenList_Screen] CHECK CONSTRAINT [FK_GuiScreenList_Screen_GUIScreen]
GO
ALTER TABLE [dbo].[GuiScreenList_Screen]  WITH NOCHECK ADD  CONSTRAINT [FK_GuiScreenList_Screen_GUIScreenList] FOREIGN KEY([gui_screen_list])
REFERENCES [dbo].[GUIScreenList] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[GuiScreenList_Screen] CHECK CONSTRAINT [FK_GuiScreenList_Screen_GUIScreenList]
GO
ALTER TABLE [dbo].[GuiScreenList_Screen]  WITH NOCHECK ADD  CONSTRAINT [FK_GuiScreenList_Screen_ValidationList] FOREIGN KEY([validation_list_id])
REFERENCES [dbo].[ValidationList] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[GuiScreenList_Screen] CHECK CONSTRAINT [FK_GuiScreenList_Screen_ValidationList]
GO
ALTER TABLE [dbo].[GUIScreenText]  WITH NOCHECK ADD  CONSTRAINT [FK_GUIScreenText_btn_accept_caption] FOREIGN KEY([btn_accept_caption])
REFERENCES [xlns].[TextItem] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[GUIScreenText] CHECK CONSTRAINT [FK_GUIScreenText_btn_accept_caption]
GO
ALTER TABLE [dbo].[GUIScreenText]  WITH NOCHECK ADD  CONSTRAINT [FK_GUIScreenText_btn_back_caption] FOREIGN KEY([btn_back_caption])
REFERENCES [xlns].[TextItem] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[GUIScreenText] CHECK CONSTRAINT [FK_GUIScreenText_btn_back_caption]
GO
ALTER TABLE [dbo].[GUIScreenText]  WITH NOCHECK ADD  CONSTRAINT [FK_GUIScreenText_btn_cancel_caption] FOREIGN KEY([btn_cancel_caption])
REFERENCES [xlns].[TextItem] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[GUIScreenText] CHECK CONSTRAINT [FK_GUIScreenText_btn_cancel_caption]
GO
ALTER TABLE [dbo].[GUIScreenText]  WITH NOCHECK ADD  CONSTRAINT [FK_GUIScreenText_full_instructions] FOREIGN KEY([full_instructions])
REFERENCES [xlns].[TextItem] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[GUIScreenText] CHECK CONSTRAINT [FK_GUIScreenText_full_instructions]
GO
ALTER TABLE [dbo].[GUIScreenText]  WITH NOCHECK ADD  CONSTRAINT [FK_GUIScreenText_GUIScreen] FOREIGN KEY([guiscreen_id])
REFERENCES [dbo].[GUIScreen] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[GUIScreenText] CHECK CONSTRAINT [FK_GUIScreenText_GUIScreen]
GO
ALTER TABLE [dbo].[GUIScreenText]  WITH NOCHECK ADD  CONSTRAINT [FK_GUIScreenText_screen_title] FOREIGN KEY([screen_title])
REFERENCES [xlns].[TextItem] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[GUIScreenText] CHECK CONSTRAINT [FK_GUIScreenText_screen_title]
GO
ALTER TABLE [dbo].[GUIScreenText]  WITH NOCHECK ADD  CONSTRAINT [FK_GUIScreenText_screen_title_instruction] FOREIGN KEY([screen_title_instruction])
REFERENCES [xlns].[TextItem] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[GUIScreenText] CHECK CONSTRAINT [FK_GUIScreenText_screen_title_instruction]
GO
ALTER TABLE [dbo].[LanguageList]  WITH NOCHECK ADD  CONSTRAINT [FK_LanguageList_Language] FOREIGN KEY([default_language])
REFERENCES [dbo].[Language] ([code])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[LanguageList] CHECK CONSTRAINT [FK_LanguageList_Language]
GO
ALTER TABLE [dbo].[LanguageList_Language]  WITH NOCHECK ADD  CONSTRAINT [FK_LanguageList_Language_Language] FOREIGN KEY([language_item])
REFERENCES [dbo].[Language] ([code])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[LanguageList_Language] CHECK CONSTRAINT [FK_LanguageList_Language_Language]
GO
ALTER TABLE [dbo].[LanguageList_Language]  WITH NOCHECK ADD  CONSTRAINT [FK_LanguageList_Language_LanguageList] FOREIGN KEY([language_list])
REFERENCES [dbo].[LanguageList] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[LanguageList_Language] CHECK CONSTRAINT [FK_LanguageList_Language_LanguageList]
GO
ALTER TABLE [dbo].[PasswordHistory]  WITH NOCHECK ADD  CONSTRAINT [FK_PasswordHistory_User] FOREIGN KEY([User])
REFERENCES [dbo].[ApplicationUser] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[PasswordHistory] CHECK CONSTRAINT [FK_PasswordHistory_User]
GO
ALTER TABLE [dbo].[Permission]  WITH NOCHECK ADD  CONSTRAINT [FK_Permission_Activity] FOREIGN KEY([activity_id])
REFERENCES [dbo].[Activity] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[Permission] CHECK CONSTRAINT [FK_Permission_Activity]
GO
ALTER TABLE [dbo].[Permission]  WITH NOCHECK ADD  CONSTRAINT [FK_Permission_Role] FOREIGN KEY([role_id])
REFERENCES [dbo].[Role] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[Permission] CHECK CONSTRAINT [FK_Permission_Role]
GO
ALTER TABLE [dbo].[Printout]  WITH NOCHECK ADD  CONSTRAINT [FK_Printout_Transaction] FOREIGN KEY([tx_id])
REFERENCES [dbo].[Transaction] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[Printout] CHECK CONSTRAINT [FK_Printout_Transaction]
GO
ALTER TABLE [dbo].[Transaction]  WITH NOCHECK ADD  CONSTRAINT [FK_Transaction_auth_user] FOREIGN KEY([auth_user])
REFERENCES [dbo].[ApplicationUser] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[Transaction] CHECK CONSTRAINT [FK_Transaction_auth_user]
GO
ALTER TABLE [dbo].[Transaction]  WITH NOCHECK ADD  CONSTRAINT [FK_Transaction_CIT] FOREIGN KEY([cit_id])
REFERENCES [dbo].[CIT] ([id])
ON DELETE CASCADE
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[Transaction] CHECK CONSTRAINT [FK_Transaction_CIT]
GO
ALTER TABLE [dbo].[Transaction]  WITH NOCHECK ADD  CONSTRAINT [FK_Transaction_Currency_Transaction] FOREIGN KEY([tx_currency])
REFERENCES [dbo].[Currency] ([code])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[Transaction] CHECK CONSTRAINT [FK_Transaction_Currency_Transaction]
GO
ALTER TABLE [dbo].[Transaction]  WITH NOCHECK ADD  CONSTRAINT [FK_Transaction_DepositorSession] FOREIGN KEY([session_id])
REFERENCES [dbo].[DepositorSession] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[Transaction] CHECK CONSTRAINT [FK_Transaction_DepositorSession]
GO
ALTER TABLE [dbo].[Transaction]  WITH NOCHECK ADD  CONSTRAINT [FK_Transaction_DeviceList] FOREIGN KEY([device_id])
REFERENCES [dbo].[Device] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[Transaction] CHECK CONSTRAINT [FK_Transaction_DeviceList]
GO
ALTER TABLE [dbo].[Transaction]  WITH NOCHECK ADD  CONSTRAINT [FK_Transaction_init_user] FOREIGN KEY([init_user])
REFERENCES [dbo].[ApplicationUser] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[Transaction] CHECK CONSTRAINT [FK_Transaction_init_user]
GO
ALTER TABLE [dbo].[Transaction]  WITH NOCHECK ADD  CONSTRAINT [FK_Transaction_TransactionTypeListItem] FOREIGN KEY([tx_type])
REFERENCES [dbo].[TransactionTypeListItem] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[Transaction] CHECK CONSTRAINT [FK_Transaction_TransactionTypeListItem]
GO
ALTER TABLE [dbo].[TransactionLimitListItem]  WITH NOCHECK ADD  CONSTRAINT [FK_TransactionLimitListItem_Currency] FOREIGN KEY([currency_code])
REFERENCES [dbo].[Currency] ([code])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[TransactionLimitListItem] CHECK CONSTRAINT [FK_TransactionLimitListItem_Currency]
GO
ALTER TABLE [dbo].[TransactionLimitListItem]  WITH NOCHECK ADD  CONSTRAINT [FK_TransactionLimitListItem_TransactionLimitList] FOREIGN KEY([transactionitemlist_id])
REFERENCES [dbo].[TransactionLimitList] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[TransactionLimitListItem] CHECK CONSTRAINT [FK_TransactionLimitListItem_TransactionLimitList]
GO
ALTER TABLE [dbo].[TransactionText]  WITH NOCHECK ADD  CONSTRAINT [FK_TransactionText_full_instructions] FOREIGN KEY([full_instructions])
REFERENCES [xlns].[TextItem] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[TransactionText] CHECK CONSTRAINT [FK_TransactionText_full_instructions]
GO
ALTER TABLE [dbo].[TransactionText]  WITH NOCHECK ADD  CONSTRAINT [FK_TransactionText_TextItem_account_name_caption] FOREIGN KEY([account_name_caption])
REFERENCES [xlns].[TextItem] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[TransactionText] CHECK CONSTRAINT [FK_TransactionText_TextItem_account_name_caption]
GO
ALTER TABLE [dbo].[TransactionText]  WITH NOCHECK ADD  CONSTRAINT [FK_TransactionText_TextItem_account_number_caption] FOREIGN KEY([account_number_caption])
REFERENCES [xlns].[TextItem] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[TransactionText] CHECK CONSTRAINT [FK_TransactionText_TextItem_account_number_caption]
GO
ALTER TABLE [dbo].[TransactionText]  WITH NOCHECK ADD  CONSTRAINT [FK_TransactionText_TextItem_alias_account_name_caption] FOREIGN KEY([alias_account_name_caption])
REFERENCES [xlns].[TextItem] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[TransactionText] CHECK CONSTRAINT [FK_TransactionText_TextItem_alias_account_name_caption]
GO
ALTER TABLE [dbo].[TransactionText]  WITH NOCHECK ADD  CONSTRAINT [FK_TransactionText_TextItem_alias_account_number_caption] FOREIGN KEY([alias_account_number_caption])
REFERENCES [xlns].[TextItem] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[TransactionText] CHECK CONSTRAINT [FK_TransactionText_TextItem_alias_account_number_caption]
GO
ALTER TABLE [dbo].[TransactionText]  WITH NOCHECK ADD  CONSTRAINT [FK_TransactionText_TextItem_depositor_name_caption] FOREIGN KEY([depositor_name_caption])
REFERENCES [xlns].[TextItem] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[TransactionText] CHECK CONSTRAINT [FK_TransactionText_TextItem_depositor_name_caption]
GO
ALTER TABLE [dbo].[TransactionText]  WITH NOCHECK ADD  CONSTRAINT [FK_TransactionText_TextItem_disclaimer] FOREIGN KEY([disclaimer])
REFERENCES [xlns].[TextItem] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[TransactionText] CHECK CONSTRAINT [FK_TransactionText_TextItem_disclaimer]
GO
ALTER TABLE [dbo].[TransactionText]  WITH NOCHECK ADD  CONSTRAINT [FK_TransactionText_TextItem_FundsSource_caption] FOREIGN KEY([FundsSource_caption])
REFERENCES [xlns].[TextItem] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[TransactionText] CHECK CONSTRAINT [FK_TransactionText_TextItem_FundsSource_caption]
GO
ALTER TABLE [dbo].[TransactionText]  WITH NOCHECK ADD  CONSTRAINT [FK_TransactionText_TextItem_id_number_caption] FOREIGN KEY([id_number_caption])
REFERENCES [xlns].[TextItem] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[TransactionText] CHECK CONSTRAINT [FK_TransactionText_TextItem_id_number_caption]
GO
ALTER TABLE [dbo].[TransactionText]  WITH NOCHECK ADD  CONSTRAINT [FK_TransactionText_TextItem_listItem_caption] FOREIGN KEY([listItem_caption])
REFERENCES [xlns].[TextItem] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[TransactionText] CHECK CONSTRAINT [FK_TransactionText_TextItem_listItem_caption]
GO
ALTER TABLE [dbo].[TransactionText]  WITH NOCHECK ADD  CONSTRAINT [FK_TransactionText_TextItem_narration_caption] FOREIGN KEY([narration_caption])
REFERENCES [xlns].[TextItem] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[TransactionText] CHECK CONSTRAINT [FK_TransactionText_TextItem_narration_caption]
GO
ALTER TABLE [dbo].[TransactionText]  WITH NOCHECK ADD  CONSTRAINT [FK_TransactionText_TextItem_phone_number_caption] FOREIGN KEY([phone_number_caption])
REFERENCES [xlns].[TextItem] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[TransactionText] CHECK CONSTRAINT [FK_TransactionText_TextItem_phone_number_caption]
GO
ALTER TABLE [dbo].[TransactionText]  WITH NOCHECK ADD  CONSTRAINT [FK_TransactionText_TextItem_receipt_template] FOREIGN KEY([receipt_template])
REFERENCES [xlns].[TextItem] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[TransactionText] CHECK CONSTRAINT [FK_TransactionText_TextItem_receipt_template]
GO
ALTER TABLE [dbo].[TransactionText]  WITH NOCHECK ADD  CONSTRAINT [FK_TransactionText_TextItem_reference_account_name_caption] FOREIGN KEY([reference_account_name_caption])
REFERENCES [xlns].[TextItem] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[TransactionText] CHECK CONSTRAINT [FK_TransactionText_TextItem_reference_account_name_caption]
GO
ALTER TABLE [dbo].[TransactionText]  WITH NOCHECK ADD  CONSTRAINT [FK_TransactionText_TextItem_reference_account_number_caption] FOREIGN KEY([reference_account_number_caption])
REFERENCES [xlns].[TextItem] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[TransactionText] CHECK CONSTRAINT [FK_TransactionText_TextItem_reference_account_number_caption]
GO
ALTER TABLE [dbo].[TransactionText]  WITH NOCHECK ADD  CONSTRAINT [FK_TransactionText_TextItem_terms] FOREIGN KEY([terms])
REFERENCES [xlns].[TextItem] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[TransactionText] CHECK CONSTRAINT [FK_TransactionText_TextItem_terms]
GO
ALTER TABLE [dbo].[TransactionText]  WITH NOCHECK ADD  CONSTRAINT [FK_TransactionText_TransactionTypeListItem] FOREIGN KEY([tx_item])
REFERENCES [dbo].[TransactionTypeListItem] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[TransactionText] CHECK CONSTRAINT [FK_TransactionText_TransactionTypeListItem]
GO
ALTER TABLE [dbo].[TransactionTypeList_TransactionTypeListItem]  WITH NOCHECK ADD  CONSTRAINT [FK_TransactionTypeList_TransactionTypeListItem_TransactionTypeList] FOREIGN KEY([txtype_list])
REFERENCES [dbo].[TransactionTypeList] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[TransactionTypeList_TransactionTypeListItem] CHECK CONSTRAINT [FK_TransactionTypeList_TransactionTypeListItem_TransactionTypeList]
GO
ALTER TABLE [dbo].[TransactionTypeList_TransactionTypeListItem]  WITH NOCHECK ADD  CONSTRAINT [FK_TransactionTypeList_TransactionTypeListItem_TransactionTypeListItem] FOREIGN KEY([txtype_list_item])
REFERENCES [dbo].[TransactionTypeListItem] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[TransactionTypeList_TransactionTypeListItem] CHECK CONSTRAINT [FK_TransactionTypeList_TransactionTypeListItem_TransactionTypeListItem]
GO
ALTER TABLE [dbo].[TransactionTypeListItem]  WITH NOCHECK ADD  CONSTRAINT [FK_TransactionListItem_TransactionType] FOREIGN KEY([tx_type])
REFERENCES [dbo].[TransactionType] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[TransactionTypeListItem] CHECK CONSTRAINT [FK_TransactionListItem_TransactionType]
GO
ALTER TABLE [dbo].[TransactionTypeListItem]  WITH NOCHECK ADD  CONSTRAINT [FK_TransactionTypeListItem_Currency] FOREIGN KEY([default_account_currency])
REFERENCES [dbo].[Currency] ([code])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[TransactionTypeListItem] CHECK CONSTRAINT [FK_TransactionTypeListItem_Currency]
GO
ALTER TABLE [dbo].[TransactionTypeListItem]  WITH NOCHECK ADD  CONSTRAINT [FK_TransactionTypeListItem_GUIScreenList] FOREIGN KEY([tx_type_guiscreenlist])
REFERENCES [dbo].[GUIScreenList] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[TransactionTypeListItem] CHECK CONSTRAINT [FK_TransactionTypeListItem_GUIScreenList]
GO
ALTER TABLE [dbo].[TransactionTypeListItem]  WITH NOCHECK ADD  CONSTRAINT [FK_TransactionTypeListItem_TransactionLimitList] FOREIGN KEY([tx_limit_list])
REFERENCES [dbo].[TransactionLimitList] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[TransactionTypeListItem] CHECK CONSTRAINT [FK_TransactionTypeListItem_TransactionLimitList]
GO
ALTER TABLE [dbo].[TransactionTypeListItem]  WITH NOCHECK ADD  CONSTRAINT [FK_TransactionTypeListItem_TransactionText] FOREIGN KEY([tx_text])
REFERENCES [dbo].[TransactionText] ([id])
ON DELETE CASCADE
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[TransactionTypeListItem] CHECK CONSTRAINT [FK_TransactionTypeListItem_TransactionText]
GO
ALTER TABLE [dbo].[UserGroup]  WITH NOCHECK ADD  CONSTRAINT [FK_UserGroup_UserGroup] FOREIGN KEY([parent_group])
REFERENCES [dbo].[UserGroup] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[UserGroup] CHECK CONSTRAINT [FK_UserGroup_UserGroup]
GO
ALTER TABLE [dbo].[UserLock]  WITH NOCHECK ADD  CONSTRAINT [FK_UserLock_InitiatingUser] FOREIGN KEY([InitiatingUser])
REFERENCES [dbo].[ApplicationUser] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[UserLock] CHECK CONSTRAINT [FK_UserLock_InitiatingUser]
GO
ALTER TABLE [dbo].[ValidationItem]  WITH NOCHECK ADD  CONSTRAINT [FK_ValidationItem_ValidationText] FOREIGN KEY([validation_text_id])
REFERENCES [dbo].[ValidationText] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[ValidationItem] CHECK CONSTRAINT [FK_ValidationItem_ValidationText]
GO
ALTER TABLE [dbo].[ValidationItem]  WITH NOCHECK ADD  CONSTRAINT [FK_ValidationItem_ValidationType] FOREIGN KEY([type_id])
REFERENCES [dbo].[ValidationType] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[ValidationItem] CHECK CONSTRAINT [FK_ValidationItem_ValidationType]
GO
ALTER TABLE [dbo].[ValidationItemValue]  WITH NOCHECK ADD  CONSTRAINT [FK_ValidationItemValue_ValidationItem] FOREIGN KEY([validation_item_id])
REFERENCES [dbo].[ValidationItem] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[ValidationItemValue] CHECK CONSTRAINT [FK_ValidationItemValue_ValidationItem]
GO
ALTER TABLE [dbo].[ValidationList_ValidationItem]  WITH NOCHECK ADD  CONSTRAINT [FK_ValidationList_ValidationItem_ValidationItem] FOREIGN KEY([validation_item_id])
REFERENCES [dbo].[ValidationItem] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[ValidationList_ValidationItem] CHECK CONSTRAINT [FK_ValidationList_ValidationItem_ValidationItem]
GO
ALTER TABLE [dbo].[ValidationList_ValidationItem]  WITH NOCHECK ADD  CONSTRAINT [FK_ValidationList_ValidationItem_ValidationList] FOREIGN KEY([validation_list_id])
REFERENCES [dbo].[ValidationList] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[ValidationList_ValidationItem] CHECK CONSTRAINT [FK_ValidationList_ValidationItem_ValidationList]
GO
ALTER TABLE [dbo].[ValidationText]  WITH NOCHECK ADD  CONSTRAINT [FK_ValidationText_TextItem_error_message] FOREIGN KEY([error_message])
REFERENCES [xlns].[TextItem] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[ValidationText] CHECK CONSTRAINT [FK_ValidationText_TextItem_error_message]
GO
ALTER TABLE [dbo].[ValidationText]  WITH NOCHECK ADD  CONSTRAINT [FK_ValidationText_TextItem_success_message] FOREIGN KEY([success_message])
REFERENCES [xlns].[TextItem] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[ValidationText] CHECK CONSTRAINT [FK_ValidationText_TextItem_success_message]
GO
ALTER TABLE [dbo].[ValidationText]  WITH NOCHECK ADD  CONSTRAINT [FK_ValidationText_ValidationItem] FOREIGN KEY([validation_item_id])
REFERENCES [dbo].[ValidationItem] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[ValidationText] CHECK CONSTRAINT [FK_ValidationText_ValidationItem]
GO
ALTER TABLE [exp].[EscrowJam]  WITH NOCHECK ADD  CONSTRAINT [FK_EscrowJam_AppUser_Approver] FOREIGN KEY([authorising_user])
REFERENCES [dbo].[ApplicationUser] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [exp].[EscrowJam] CHECK CONSTRAINT [FK_EscrowJam_AppUser_Approver]
GO
ALTER TABLE [exp].[EscrowJam]  WITH NOCHECK ADD  CONSTRAINT [FK_EscrowJam_AppUser_Initiator] FOREIGN KEY([initialising_user])
REFERENCES [dbo].[ApplicationUser] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [exp].[EscrowJam] CHECK CONSTRAINT [FK_EscrowJam_AppUser_Initiator]
GO
ALTER TABLE [exp].[EscrowJam]  WITH NOCHECK ADD  CONSTRAINT [FK_EscrowJam_Transaction] FOREIGN KEY([transaction_id])
REFERENCES [dbo].[Transaction] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [exp].[EscrowJam] CHECK CONSTRAINT [FK_EscrowJam_Transaction]
GO
ALTER TABLE [xlns].[sysTextItem]  WITH NOCHECK ADD  CONSTRAINT [FK_SysTextItem_SysTextItemCategory] FOREIGN KEY([Category])
REFERENCES [xlns].[sysTextItemCategory] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [xlns].[sysTextItem] CHECK CONSTRAINT [FK_SysTextItem_SysTextItemCategory]
GO
ALTER TABLE [xlns].[sysTextItem]  WITH NOCHECK ADD  CONSTRAINT [FK_sysTextItem_sysTextItemType] FOREIGN KEY([TextItemTypeID])
REFERENCES [xlns].[sysTextItemType] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [xlns].[sysTextItem] CHECK CONSTRAINT [FK_sysTextItem_sysTextItemType]
GO
ALTER TABLE [xlns].[sysTextItemCategory]  WITH NOCHECK ADD  CONSTRAINT [FK_TextItemCategory_TextItemCategory] FOREIGN KEY([Parent])
REFERENCES [xlns].[sysTextItemCategory] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [xlns].[sysTextItemCategory] CHECK CONSTRAINT [FK_TextItemCategory_TextItemCategory]
GO
ALTER TABLE [xlns].[sysTextTranslation]  WITH NOCHECK ADD  CONSTRAINT [FK_sysTextTranslation_Language] FOREIGN KEY([LanguageCode])
REFERENCES [dbo].[Language] ([code])
NOT FOR REPLICATION 
GO
ALTER TABLE [xlns].[sysTextTranslation] CHECK CONSTRAINT [FK_sysTextTranslation_Language]
GO
ALTER TABLE [xlns].[sysTextTranslation]  WITH NOCHECK ADD  CONSTRAINT [FK_sysTextTranslation_sysTextItem] FOREIGN KEY([SysTextItemID])
REFERENCES [xlns].[sysTextItem] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
NOT FOR REPLICATION 
GO
ALTER TABLE [xlns].[sysTextTranslation] CHECK CONSTRAINT [FK_sysTextTranslation_sysTextItem]
GO
ALTER TABLE [xlns].[TextItem]  WITH NOCHECK ADD  CONSTRAINT [FK_UI_TextItem_TextItemCategory] FOREIGN KEY([Category])
REFERENCES [xlns].[TextItemCategory] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [xlns].[TextItem] CHECK CONSTRAINT [FK_UI_TextItem_TextItemCategory]
GO
ALTER TABLE [xlns].[TextItem]  WITH NOCHECK ADD  CONSTRAINT [FK_UI_TextItem_TextItemType] FOREIGN KEY([TextItemTypeID])
REFERENCES [xlns].[TextItemType] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
NOT FOR REPLICATION 
GO
ALTER TABLE [xlns].[TextItem] CHECK CONSTRAINT [FK_UI_TextItem_TextItemType]
GO
ALTER TABLE [xlns].[TextItemCategory]  WITH NOCHECK ADD  CONSTRAINT [FK_UI_TextItemCategory_TextItemCategory] FOREIGN KEY([Parent])
REFERENCES [xlns].[TextItemCategory] ([id])
NOT FOR REPLICATION 
GO
ALTER TABLE [xlns].[TextItemCategory] CHECK CONSTRAINT [FK_UI_TextItemCategory_TextItemCategory]
GO
ALTER TABLE [xlns].[TextTranslation]  WITH NOCHECK ADD  CONSTRAINT [FK_UI_Translation_Language] FOREIGN KEY([LanguageCode])
REFERENCES [dbo].[Language] ([code])
NOT FOR REPLICATION 
GO
ALTER TABLE [xlns].[TextTranslation] CHECK CONSTRAINT [FK_UI_Translation_Language]
GO
ALTER TABLE [xlns].[TextTranslation]  WITH NOCHECK ADD  CONSTRAINT [FK_UI_Translation_TextItem] FOREIGN KEY([TextItemID])
REFERENCES [xlns].[TextItem] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
NOT FOR REPLICATION 
GO
ALTER TABLE [xlns].[TextTranslation] CHECK CONSTRAINT [FK_UI_Translation_TextItem]
GO
ALTER TABLE [dbo].[TransactionLimitListItem]  WITH NOCHECK ADD  CONSTRAINT [CK_TransactionLimitListItem_overdeposit] CHECK NOT FOR REPLICATION (([overdeposit_amount]>=[underdeposit_amount]))
GO
ALTER TABLE [dbo].[TransactionLimitListItem] CHECK CONSTRAINT [CK_TransactionLimitListItem_overdeposit]
GO
ALTER TABLE [dbo].[TransactionLimitListItem]  WITH NOCHECK ADD  CONSTRAINT [CK_TransactionLimitListItem_show_funds_form] CHECK NOT FOR REPLICATION (([show_funds_source]=(0) OR [show_funds_form] IS NOT NULL))
GO
ALTER TABLE [dbo].[TransactionLimitListItem] CHECK CONSTRAINT [CK_TransactionLimitListItem_show_funds_form]
GO
/****** Object:  StoredProcedure [dbo].[GetCITDenominationByDates]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetCITDenominationByDates] 
	-- Add the parameters for the stored procedure here
	@startDate datetime2 = '01-01-1900',
	@endDate datetime2 = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF @startDate is null
	SET @startDate = '01-01-1900'

	IF @endDate is null
	SET @endDate = getdate()

	select t.tx_currency,denom, sum([count]) as [count], sum(subtotal) as subtotal from DenominationDetail
	INNER JOIN [Transaction] as t on t.id = tx_id
	where ([datetime] between @startDate AND @endDate) AND t.device_id = (SELECT id FROM ThisDevice as td)
	group by t.tx_currency,denom
END



GO
/****** Object:  StoredProcedure [dbo].[GetDestinationEmailsByAlertType]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetDestinationEmailsByAlertType] 
	-- Add the parameters for the stored procedure here
	@alertMessageTypeID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT u.email from ApplicationUser as u
	inner join Role as r on r.id = u.role_id
	inner join AlertMessageRegistry as mr on [mr].[role_id] = [r].id
	inner join AlertMessageType as mt on mt.id = mr.alert_type_id
	where mt.id = @alertMessageTypeID
END

GO
/****** Object:  StoredProcedure [dbo].[GetDeviceConfigByUserGroup]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetDeviceConfigByUserGroup]
	-- Add the parameters for the stored procedure here
	@ConfigGroup int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	WITH #results AS
  ( SELECT id,
           parent_group
   FROM ConfigGroup
   WHERE id = @ConfigGroup
     UNION ALL
     SELECT t.id,
            t.parent_group
     FROM ConfigGroup t
     INNER JOIN #results r ON r.parent_group = t.id )
SELECT t.id,t.group_id, t.config_id,t.config_value
FROM
  (SELECT t.*,
          row_number() over (partition BY config_id
                             ORDER BY group_id DESC) AS seqnum
   FROM
     (SELECT dc.*
      FROM #results
      INNER JOIN DeviceConfig AS dc ON dc.group_id = #results.id) AS t)t
WHERE t.seqnum = 1
ORDER BY config_id
END


GO
/****** Object:  StoredProcedure [dbo].[GetDeviceUsersByDevice]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetDeviceUsersByDevice]
	-- Add the parameters for the stored procedure here
	@Device_UserGroup int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	WITH #results AS
(
    SELECT  id, 
            parent_group 
    FROM    UserGroup 
    WHERE   id = @Device_UserGroup
    UNION ALL
    SELECT  t.id, 
            t.parent_group 
    FROM    UserGroup t
            INNER JOIN #results r ON r.parent_group = t.id
)
SELECT  au.*
FROM    #results
inner join applicationuser as au on au.user_group=#results.id
END

GO
/****** Object:  StoredProcedure [dbo].[HashTransaction]    Script Date: 29/08/2025 15:51:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[HashTransaction]( @TxString VARCHAR(MAX))
 
AS
BEGIN
 
       SET NOCOUNT ON;
 
Select Convert(VARCHAR(MAX), HASHBYTES('SHA2_512', @TxString),  1) as NewHash
 
RETURN
 
END
 
 


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The session this log entry belongs to' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplicationLog', @level2type=N'COLUMN',@level2name=N'session_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Datetime the system deems for the log entry.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplicationLog', @level2type=N'COLUMN',@level2name=N'log_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The name of the log event' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplicationLog', @level2type=N'COLUMN',@level2name=N'event_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'the details of the log message' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplicationLog', @level2type=N'COLUMN',@level2name=N'event_detail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'the type of the log event used for grouping and sorting' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplicationLog', @level2type=N'COLUMN',@level2name=N'event_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Which internal component produced the log entry e.g. GUI, APIs, DeviceController etc' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplicationLog', @level2type=N'COLUMN',@level2name=N'component'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'the LogLevel' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplicationLog', @level2type=N'COLUMN',@level2name=N'log_level'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Stores the general application log that the GUI and other local systems write to' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ApplicationLog'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'contains a crash report' , @level0type=N'SCHEMA',@level0name=N'exp', @level1type=N'TABLE',@level1name=N'CrashEvent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Exceptions encountered during execution' , @level0type=N'SCHEMA',@level0name=N'exp', @level1type=N'TABLE',@level1name=N'TransactionException'
GO
USE [master]
GO
ALTER DATABASE [Depositor_7_4] SET  READ_WRITE 
GO
