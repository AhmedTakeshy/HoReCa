BEGIN TRY

BEGIN TRAN;

-- CreateTable
CREATE TABLE [dbo].[AuthActionForCustomerDescriptions] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [AuthActionForCustomerId] BIGINT NOT NULL,
    [LanguageId] BIGINT NOT NULL,
    [Description] NVARCHAR(500) NOT NULL,
    CONSTRAINT [PK_AuthActionForCustomerDescriptions] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[AuthActionForCustomers] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Code] NVARCHAR(80) NOT NULL,
    [OrderNumber] INT NOT NULL,
    [DetailedDescription] NVARCHAR(500),
    CONSTRAINT [PK_AuthActionForCustomers] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[AuthActionForUserDescriptions] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [AuthActionForUserId] BIGINT NOT NULL,
    [LanguageId] BIGINT NOT NULL,
    [Description] NVARCHAR(500) NOT NULL,
    CONSTRAINT [PK_AuthActionForUserDescriptions] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[AuthActionForUsers] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Code] NVARCHAR(80) NOT NULL,
    [OrderNumber] INT NOT NULL,
    [GroupCode] NVARCHAR(20) NOT NULL,
    CONSTRAINT [PK_AuthActionForUsers] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[BulkOperationLines] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Status] TINYINT NOT NULL,
    [StatusResult] NVARCHAR(2000),
    [BulkOperationId] BIGINT NOT NULL,
    [Entegre_ProductECommerceId] BIGINT,
    [ProductId] BIGINT,
    [FormulaText] NVARCHAR(250),
    CONSTRAINT [PK_BulkOperationLines] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[BulkOperations] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [OperationType] TINYINT NOT NULL,
    [CreatedDate] DATETIME NOT NULL,
    [StartDate] DATETIME,
    [EndDate] DATETIME,
    [ParamValue] NVARCHAR(250),
    [OperationSourceValue] NVARCHAR(2500),
    [OperationSourceType] TINYINT,
    [CustomerId] BIGINT NOT NULL,
    [Status] TINYINT NOT NULL,
    [ProductId] BIGINT,
    CONSTRAINT [PK_BulkOperations] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[CampaignCustomers] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [IpAddress] NVARCHAR(50) NOT NULL,
    [RegisterDate] DATETIME NOT NULL,
    [RegisterGuid] UNIQUEIDENTIFIER NOT NULL,
    [PurchaseDate] DATETIME,
    [CampaignId] UNIQUEIDENTIFIER NOT NULL,
    [CustomerId] BIGINT,
    [PackagesId] BIGINT,
    CONSTRAINT [PK_CampaignCustomers] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Campaigns] (
    [Id] UNIQUEIDENTIFIER NOT NULL,
    [CampaignCode] NVARCHAR(50),
    [CampaignDescription] NVARCHAR(300),
    [RegisterDate] DATETIME NOT NULL,
    [CustomerRepresentativeId] BIGINT,
    CONSTRAINT [PK_Campaigns] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Categories] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Name] NVARCHAR(100) NOT NULL,
    [Deepest] BIT NOT NULL,
    [ParentId] BIGINT,
    [DefaultVatRateId] INT,
    [BreadCrumb] NVARCHAR(500) NOT NULL,
    [CustomerId] BIGINT NOT NULL,
    CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Cities] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Name] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_Cities] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[ClaimItemReasons] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [ClaimItemId] BIGINT NOT NULL,
    [ClaimReason] NVARCHAR(350) NOT NULL,
    CONSTRAINT [PK_ClaimItemReasons] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[ClaimItems] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [ClaimId] BIGINT NOT NULL,
    [ProductId] BIGINT,
    [ProductVariantGroupId] BIGINT,
    [ProductStockCode] NVARCHAR(50) NOT NULL,
    [EntegreProductId] NVARCHAR(50),
    [EntegreLineItemId] NVARCHAR(50),
    [Quantity] DECIMAL(20,8) NOT NULL,
    [VatRateId] INT NOT NULL,
    [CurrencyId] INT NOT NULL,
    [UnitTypeId] INT NOT NULL,
    [ClaimItemStatus] TINYINT NOT NULL,
    [UnitPrice] DECIMAL(12,2) NOT NULL,
    [ShipmentCompanyCampaignNumber] NVARCHAR(80),
    [ShipmentCompanyECommerceCodeId] NVARCHAR(80),
    [ProductName] NVARCHAR(250) NOT NULL,
    [OrderLineId] BIGINT,
    [EntegreProductSlug] NVARCHAR(250),
    [RequestedEntegreLineItemIdCode] NVARCHAR(50),
    [StockMultiplier] DECIMAL(16,8) NOT NULL CONSTRAINT [DF_CI_StockMultplier] DEFAULT 1,
    [UnitDiscountAmount] DECIMAL(12,2) NOT NULL CONSTRAINT [DF__ClaimItem__UnitD__1E05700A] DEFAULT 0,
    CONSTRAINT [PK_ClaimItems] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Claims] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [EntegreClaimNumber] NVARCHAR(50) NOT NULL,
    [EntegreClaimId] NVARCHAR(50),
    [CustomerFullName] NVARCHAR(300) NOT NULL,
    [ClaimDate] DATETIME NOT NULL,
    [IntegratedECommerceCode] NVARCHAR(10) NOT NULL,
    [CustomerId] BIGINT NOT NULL,
    [CustomerECommerceKeyId] BIGINT NOT NULL,
    [PackageBarcode] NVARCHAR(250),
    [ClaimStatus] TINYINT NOT NULL,
    [InvoicePrinted] BIT NOT NULL CONSTRAINT [DF__Claims__InvoiceP__1EF99443] DEFAULT 0,
    [OrderInvoiceNumber] NVARCHAR(50),
    [ClaimInvoiceNumber] NVARCHAR(50),
    CONSTRAINT [PK_Claims] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[ConnectedCustomers] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [ConnectionId] NVARCHAR(50) NOT NULL,
    [IpAddress] NVARCHAR(40),
    [ConnectedOn] DATETIME NOT NULL,
    [CustomerId] BIGINT NOT NULL,
    [AccountingApp] NVARCHAR(20),
    [Transport] NVARCHAR(100),
    [CustomerErpId] BIGINT NOT NULL,
    CONSTRAINT [PK_ConnectedCustomers] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[ConnectedUsers] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [ConnectionId] NVARCHAR(50) NOT NULL,
    [ConnectedOn] DATETIME NOT NULL,
    [UserAgent] NVARCHAR(1000),
    [UserId] BIGINT NOT NULL,
    [CustomerId] BIGINT NOT NULL,
    [IpAddress] NVARCHAR(40),
    [Transport] NVARCHAR(100),
    CONSTRAINT [PK_ConnectedUsers] PRIMARY KEY CLUSTERED ([Id]),
    CONSTRAINT [UNQ_ConnectedUsers_ConnectionId] UNIQUE NONCLUSTERED ([ConnectionId])
);

-- CreateTable
CREATE TABLE [dbo].[Countries] (
    [Iso2] NVARCHAR(2) NOT NULL,
    [Iso3] NVARCHAR(3),
    [PhoneCode] SMALLINT,
    [Name] NVARCHAR(80) NOT NULL,
    CONSTRAINT [PK_Countries] PRIMARY KEY CLUSTERED ([Iso2])
);

-- CreateTable
CREATE TABLE [dbo].[CouponAllowedPackages] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [CouponId] BIGINT NOT NULL,
    [PackagesId] BIGINT NOT NULL,
    CONSTRAINT [PK_CouponAllowedPackages] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[CouponCustomerAuthActions] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [CouponId] BIGINT NOT NULL,
    [AuthActionForCustomerId] BIGINT NOT NULL,
    CONSTRAINT [PK_CouponCustomerAuthActions] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[CouponGiftPackages] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [CouponId] BIGINT NOT NULL,
    [PackagesId] BIGINT NOT NULL,
    [Price] DECIMAL(12,2) NOT NULL,
    CONSTRAINT [PK_CouponGiftPackages] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[CouponPackageExtras] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [CompetitionAnalysisCount] INT NOT NULL,
    [ErpCount] INT NOT NULL,
    [ProductLimit] INT NOT NULL,
    [SubUserCount] INT NOT NULL,
    [StoreCount] INT NOT NULL,
    [CouponId] BIGINT NOT NULL,
    CONSTRAINT [PK_CouponPackageExtras] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Coupons] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Name] NVARCHAR(100) NOT NULL,
    [Code] NVARCHAR(25) NOT NULL,
    [Limit] INT NOT NULL,
    [StartDate] DATETIME NOT NULL,
    [EndDate] DATETIME,
    [NewCustomerOnly] BIT NOT NULL,
    CONSTRAINT [PK_Coupons] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[CouponUsages] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [CustomerId] BIGINT NOT NULL,
    [CustomerSubscriptionId] BIGINT NOT NULL,
    [Date] DATETIME NOT NULL,
    [CouponId] BIGINT NOT NULL,
    CONSTRAINT [PK_CouponUsages] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Currencies] (
    [Id] INT NOT NULL IDENTITY(1,1),
    [Code] NVARCHAR(4) NOT NULL,
    [Name] NVARCHAR(20) NOT NULL,
    [IsDefault] BIT NOT NULL,
    CONSTRAINT [PK_Currencies] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[CurrencyExchanges] (
    [Id] INT NOT NULL IDENTITY(1,1),
    [Selling] DECIMAL(28,20) NOT NULL,
    [Buying] DECIMAL(28,20) NOT NULL,
    [CurrencyId] INT NOT NULL,
    [LastUpdate] DATETIME NOT NULL,
    CONSTRAINT [PK_CurrencyExchanges] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[CustomerAuthActionForCustomers] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [CustomerId] BIGINT NOT NULL,
    [AuthActionForCustomerId] BIGINT NOT NULL,
    CONSTRAINT [PK_CustomerAuthActionForCustomers] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[CustomerAuthActionForPackages] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [PackagesId] BIGINT NOT NULL,
    [AuthActionForCustomerId] BIGINT NOT NULL,
    CONSTRAINT [PK_CustomerAuthActionForPackages] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[CustomerBrands] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Name] NVARCHAR(100) NOT NULL,
    [CustomerId] BIGINT NOT NULL,
    CONSTRAINT [PK_CustomerBrands] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[CustomerCreditTransactions] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [TransactionDate] DATETIME NOT NULL,
    [TransactionType] TINYINT NOT NULL,
    [TransactionAmount] DECIMAL(12,2) NOT NULL,
    [StoreName] NVARCHAR(50),
    [ReferenceNumber] NVARCHAR(50),
    [Description] NVARCHAR(300),
    [IntegratedECommerceCode] NVARCHAR(10),
    [CustomerECommerceKeyId] BIGINT,
    [CustomerId] BIGINT NOT NULL,
    [OrderId] BIGINT,
    CONSTRAINT [PK_CustomerCreditTransactions] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[CustomerDefaultCargoSettings] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [SettingModel] NVARCHAR(4000) NOT NULL,
    [CustomerECommerceKeyId] BIGINT NOT NULL,
    CONSTRAINT [PK_CustomerDefaultCargoSettings] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[CustomerECommerceDefaultSettings] (
    [CustomerId] BIGINT NOT NULL,
    [IntegratedECommerceCode] NVARCHAR(10) NOT NULL,
    [ComissionRate] DECIMAL(4,2),
    [DefaultProductDescription] NVARCHAR(max),
    [Entegre_GG_CustomerDefaultSettingId] BIGINT,
    [Entegre_N11_CustomerDefaultSettingId] BIGINT,
    [Entegre_SP_CustomerDefaultSettingId] BIGINT,
    [OrderAutoSendToAccounting] BIT NOT NULL CONSTRAINT [DF__CustomerE__Order__1FEDB87C] DEFAULT 1,
    [Entegre_AMZ_CustomerDefaultSettingId] BIGINT,
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [CustomerECommerceKeyId] BIGINT NOT NULL,
    [OrderAutoApprove] BIT NOT NULL CONSTRAINT [DF__CustomerE__Order__20E1DCB5] DEFAULT 0,
    [CustomerErpId] BIGINT,
    [Entegre_IC_CustomerDefaultSettingId] BIGINT,
    [DefaultEInvoiceNote] NVARCHAR(300),
    [OrderAutoApproveType] TINYINT,
    [Entegre_Etsy_CustomerDefaultSettingId] BIGINT,
    [Entegre_AE_CustomerDefaultSettingId] BIGINT,
    [Entegre_Ebay_CustomerDefaultSettingId] BIGINT,
    [Entegre_Allegro_CustomerDefaultSettingId] BIGINT,
    [Entegre_N11Pro_CustomerDefaultSettingId] BIGINT,
    CONSTRAINT [PK_CustomerECommerceDefaultSettingss] PRIMARY KEY CLUSTERED ([Id]),
    CONSTRAINT [uq_CustomerECommerceDefaultSettingCustomerECommerceKey] UNIQUE NONCLUSTERED ([CustomerECommerceKeyId],[CustomerId],[IntegratedECommerceCode])
);

-- CreateTable
CREATE TABLE [dbo].[CustomerECommerceKeyPriceFormulas] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [CustomerId] BIGINT NOT NULL,
    [CustomerECommerceKeyId] BIGINT NOT NULL,
    [FormulaString] NVARCHAR(200) NOT NULL,
    [MinCostPrice] DECIMAL(12,2) NOT NULL,
    [MaxCostPrice] DECIMAL(12,2) NOT NULL,
    CONSTRAINT [PK_CustomerECommerceKeyPriceFormulas] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[CustomerECommerceKeys] (
    [CustomerId] BIGINT NOT NULL,
    [IntegratedECommerceCode] NVARCHAR(10) NOT NULL,
    [ApiKey] NVARCHAR(200),
    [ApiSecret] NVARCHAR(200),
    [UserName] NVARCHAR(200),
    [Password] NVARCHAR(200),
    [ShopId] NVARCHAR(50),
    [Active] BIT NOT NULL,
    [PraPazarAuthorized] BIT NOT NULL CONSTRAINT [DF__CustomerE__PraPa__21D600EE] DEFAULT 0,
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [StoreName] NVARCHAR(50) NOT NULL CONSTRAINT [DF__CustomerE__Store__22CA2527] DEFAULT 'N''Mağaza İsmi''',
    [BaseUrlApi] NVARCHAR(200),
    [BaseUrlProduct] NVARCHAR(200),
    [ShipmentCompanyECommerceCodeId] NVARCHAR(80),
    [UseForDailyStockUpdate] BIT NOT NULL CONSTRAINT [DF__CustomerE__UseFo__23BE4960] DEFAULT 0,
    [UsedForXmlOutput] BIT NOT NULL CONSTRAINT [DF__CustomerE__UsedF__24B26D99] DEFAULT 0,
    [RefreshToken] NVARCHAR(2500),
    [RefreshTokenExpiryDate] DATETIME,
    [AccessToken] NVARCHAR(2500),
    [AccessTokenExpiryDate] DATETIME,
    [OutOfStockOnCriticalInventory] BIT NOT NULL CONSTRAINT [DF__CustomerE__OutOf__25A691D2] DEFAULT 0,
    [AutoAssignOrderPackageUserId] BIGINT,
    [ECommercePriceFromCostPriceFormula] NVARCHAR(200),
    [UseVirtualStockAmount] BIT NOT NULL CONSTRAINT [DF__CustomerE__UseVi__269AB60B] DEFAULT 0,
    CONSTRAINT [PK_CustomerECommerceKeys] PRIMARY KEY CLUSTERED ([Id]),
    CONSTRAINT [uq_CustomerECommerceKeyStoreName] UNIQUE NONCLUSTERED ([CustomerId],[IntegratedECommerceCode],[StoreName])
);

-- CreateTable
CREATE TABLE [dbo].[CustomerECommerceMessageTemplates] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Title] NVARCHAR(50) NOT NULL,
    [Description] NVARCHAR(2000) NOT NULL,
    [CustomerId] BIGINT NOT NULL,
    CONSTRAINT [PK_CustomerECommerceMessageTemplates] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[CustomerECommerceProductInsertLogs] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Entegre_ECommerceProductId] BIGINT NOT NULL,
    [CustomerId] BIGINT NOT NULL,
    [InsertDate] DATETIME NOT NULL,
    CONSTRAINT [PK_CustomerECommerceProductInsertLogs] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[CustomerErps] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Name] NVARCHAR(50) NOT NULL,
    [IsDefault] BIT NOT NULL,
    [UseForStockUpdate] BIT NOT NULL,
    [CustomerId] BIGINT NOT NULL,
    [Code] NVARCHAR(100),
    CONSTRAINT [PK_CustomerErps] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[CustomerInvoiceInformations] (
    [CustomerId] BIGINT NOT NULL,
    [Name] NVARCHAR(250) NOT NULL,
    [TaxNumber] NVARCHAR(20) NOT NULL,
    [TaxOffice] NVARCHAR(20),
    [Email] NVARCHAR(250) NOT NULL,
    [PhoneNumber] NVARCHAR(15) NOT NULL,
    [CityId] BIGINT NOT NULL,
    [DistrictId] BIGINT NOT NULL,
    [DefaultNote] NVARCHAR(300),
    [CustomerECommerceKeyId] BIGINT NOT NULL,
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Address] NVARCHAR(250),
    [InvoiceProfileId] NVARCHAR(100),
    [IbanNumber] NVARCHAR(30),
    [TaxExemptionCode] NVARCHAR(5),
    [ExportTaxExemptionCode] NVARCHAR(5),
    CONSTRAINT [PK_CustomerInvoiceInformations] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[CustomerInvoiceSettings] (
    [CustomerId] BIGINT NOT NULL,
    [UseProductNameForInvoice] BIT NOT NULL,
    [AskForInvoiceNumberOnPrintInvoice] BIT NOT NULL,
    [UseStockMultiplierForAccounting] BIT NOT NULL CONSTRAINT [DF__CustomerI__UseSt__278EDA44] DEFAULT 0,
    [UseStockMultiplierForInvoice] BIT NOT NULL CONSTRAINT [DF__CustomerI__UseSt__2882FE7D] DEFAULT 0,
    [UseStockMultiplierForCargoBarcode] BIT NOT NULL CONSTRAINT [DF__CustomerI__UseSt__297722B6] DEFAULT 0,
    [UseBundleProductForInvoice] BIT NOT NULL CONSTRAINT [DF__CustomerI__UseBu__797DF6D1] DEFAULT 0,
    CONSTRAINT [PK_CustomerInvoiceSettings] PRIMARY KEY CLUSTERED ([CustomerId])
);

-- CreateTable
CREATE TABLE [dbo].[CustomerNotifications] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [CustomerId] BIGINT NOT NULL,
    [NotificationType] TINYINT NOT NULL,
    [RefNo] NVARCHAR(50) NOT NULL,
    [NotificationDescription] NVARCHAR(500) NOT NULL,
    [NotificationDate] DATETIME NOT NULL,
    [IntegratedECommerceCode] NVARCHAR(10)
);

-- CreateTable
CREATE TABLE [dbo].[CustomerNotificationSettings] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [StartDate] TIME NOT NULL,
    [EndDate] TIME NOT NULL,
    [Active] BIT NOT NULL,
    [Destination] NVARCHAR(250) NOT NULL,
    [CustomerId] BIGINT NOT NULL,
    [CustomerNotificationSettingTypesId] BIGINT NOT NULL,
    CONSTRAINT [PK_CustomerNotificationSettings] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[CustomerNotificationSettingTypes] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [CustomerNotificationType] TINYINT NOT NULL,
    [Description] NVARCHAR(100) NOT NULL,
    [Code] NVARCHAR(50) NOT NULL,
    CONSTRAINT [PK_CustomerNotificationSettingTypes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[CustomerOrderColorTags] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [CustomerId] BIGINT NOT NULL,
    [Name] NVARCHAR(150) NOT NULL,
    [ColorTag] SMALLINT NOT NULL,
    CONSTRAINT [PK_CustomerOrderColorTags] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[CustomerPosPayments] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [PaymentDate] DATETIME NOT NULL,
    [CreditCardMaskedNumber] NVARCHAR(20) NOT NULL,
    [ExpireYear] SMALLINT NOT NULL,
    [ExpireMonth] TINYINT NOT NULL,
    [ClientIp] NVARCHAR(50) NOT NULL,
    [PaymentAmount] DECIMAL(12,2) NOT NULL,
    [PaymentResult] TINYINT NOT NULL,
    [ResultMessage] NVARCHAR(max),
    [TransactionId] NVARCHAR(80) NOT NULL,
    [CustomerId] BIGINT NOT NULL,
    [CustomerCreditTransactionId] BIGINT,
    [CustomerSMSTransactionsId] BIGINT,
    [PaymentFor] TINYINT NOT NULL,
    [CustomerSubscriptionId] BIGINT,
    [BankName] NVARCHAR(20),
    CONSTRAINT [PK_CustomerPosPayments] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[CustomerReports] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [CustomerId] BIGINT NOT NULL,
    [CreationDate] DATETIME NOT NULL,
    [StartDate] DATETIME,
    [EndDate] DATETIME,
    [ReportSourceValue] NVARCHAR(2500),
    [Status] TINYINT NOT NULL,
    [ReportFileName] NVARCHAR(50),
    [ReportMessage] NVARCHAR(1000),
    CONSTRAINT [PK_CustomerReports] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[CustomerReportTemplates] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [ReportType] NVARCHAR(20) NOT NULL,
    [TemplateName] NVARCHAR(50) NOT NULL,
    [Template] NVARCHAR(max) NOT NULL,
    [CustomerId] BIGINT NOT NULL,
    [IsDefault] BIT NOT NULL,
    CONSTRAINT [PK_CustomerReportTemplates] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[CustomerRepresentatives] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Name] NVARCHAR(80) NOT NULL,
    [PhoneNumber] NVARCHAR(10),
    [CustomerUserId] BIGINT,
    [IsDealer] BIT NOT NULL CONSTRAINT [DF__CustomerR__IsDea__2A6B46EF] DEFAULT 1,
    CONSTRAINT [PK_CustomerRepresentatives] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Customers] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Name] NVARCHAR(250) NOT NULL,
    [IsMainCompany] BIT NOT NULL,
    [CitizenShipId] NVARCHAR(20),
    [TaxNumber] NVARCHAR(20),
    [TaxOffice] NVARCHAR(20),
    [Active] BIT NOT NULL,
    [ApiSecret] NVARCHAR(32),
    [ApiKey] NVARCHAR(100),
    [PhoneNumber] NVARCHAR(15),
    [GsmNumber] NVARCHAR(15),
    [Email] NVARCHAR(250) NOT NULL,
    [CityId] BIGINT,
    [DistrictId] BIGINT,
    [LastActivity] DATETIME,
    [CustomerRepresentativeId] BIGINT,
    [HasApprovedContract] BIT NOT NULL CONSTRAINT [DF__Customers__HasAp__2B5F6B28] DEFAULT 0,
    [ContractApprovedDate] DATETIME,
    [ContractApprovedIpAddress] NVARCHAR(50),
    [ContractUserAgent] NVARCHAR(1000),
    [InvoiceAdress] NVARCHAR(800),
    [InvoiceCityId] BIGINT,
    [InvoiceDistrictId] BIGINT,
    [InvoiceName] NVARCHAR(250),
    [InvoiceTaxNumber] NVARCHAR(20),
    [InvoiceTaxOffice] NVARCHAR(20),
    [InvoiceCitizenShipId] NVARCHAR(20),
    [ProfileImage] NVARCHAR(80),
    [CountryIso2] NVARCHAR(2) NOT NULL CONSTRAINT [DF__Customers__Count__2C538F61] DEFAULT 'TR',
    [ReferenceCode] NVARCHAR(50) NOT NULL CONSTRAINT [DF__Customers__Refer__2D47B39A] DEFAULT 'newid()',
    [ReferenceCustomerId] BIGINT,
    CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED ([Id]),
    CONSTRAINT [UNQ_Customers_EMail] UNIQUE NONCLUSTERED ([Email])
);

-- CreateTable
CREATE TABLE [dbo].[CustomerSettings] (
    [CustomerId] BIGINT NOT NULL,
    [IncreaseStockOnCancelOrder] BIT NOT NULL,
    [CancelCargoOnCancelOrder] BIT NOT NULL CONSTRAINT [DF__CustomerS__Cance__2E3BD7D3] DEFAULT 0,
    [UseProductNameForCargoBarcode] BIT NOT NULL CONSTRAINT [DF__CustomerS__UsePr__2F2FFC0C] DEFAULT 0,
    [IncreaseStockOnClaimApprove] BIT NOT NULL CONSTRAINT [DF__CustomerS__Incre__30242045] DEFAULT 1,
    [CalculateCargoCountFromQuantity] BIT NOT NULL CONSTRAINT [DF__CustomerS__Calcu__3118447E] DEFAULT 0,
    [UseBundleNameForCargoBarcode] BIT NOT NULL CONSTRAINT [DF__CustomerS__UseBu__320C68B7] DEFAULT 0,
    [PostInvoiceToECommerce] BIT NOT NULL CONSTRAINT [DF__CustomerS__PostI__33008CF0] DEFAULT 0,
    [VatRateId] INT NOT NULL CONSTRAINT [DF__CustomerS__VatRa__33F4B129] DEFAULT 4,
    [PostInvoiceLinkToECommerce] BIT NOT NULL CONSTRAINT [DF__CustomerS__PostI__4DD47EBD] DEFAULT 0,
    CONSTRAINT [PK_CustomerSettings] PRIMARY KEY CLUSTERED ([CustomerId])
);

-- CreateTable
CREATE TABLE [dbo].[CustomerShipmentPriceForOrderAmounts] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [CustomerId] BIGINT NOT NULL,
    [CustomerECommerceKeyId] BIGINT NOT NULL,
    [ShipmentPrice] DECIMAL(10,2) NOT NULL,
    [ShipmentPriceCurrencyId] INT NOT NULL,
    [MinOrderAmount] DECIMAL(10,2) NOT NULL,
    [MaxOrderAmount] DECIMAL(10,2) NOT NULL,
    [OrderAmountCurrencyId] INT NOT NULL,
    CONSTRAINT [PK_CustomerShipmentPriceForOrderAmounts] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[CustomerShipmentPrices] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [CustomerId] BIGINT NOT NULL,
    [VolumetricWeight] SMALLINT NOT NULL,
    [DomesticPrice] DECIMAL(10,2) NOT NULL,
    [DomesticCurrencyId] INT NOT NULL,
    [InternationalPrice] DECIMAL(10,2),
    [InternationalCurrencyId] INT,
    CONSTRAINT [PK_CustomerShipmentPrices] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[CustomerSMSTransactions] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [TransactionAmount] DECIMAL(12,2) NOT NULL,
    [PhoneNumber] NVARCHAR(15),
    [MessageId] NVARCHAR(15),
    [TransactionDate] DATETIME NOT NULL,
    [CustomerId] BIGINT NOT NULL,
    CONSTRAINT [PK_CustomerSMSTransactions] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[CustomerSubscriptionCustomerAuths] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [CustomerSubscriptionId] BIGINT NOT NULL,
    [AuthActionForCustomerId] BIGINT NOT NULL,
    CONSTRAINT [PK_CustomerSubscriptionCustomerAuths] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[CustomerSubscriptions] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [StartDate] DATETIME NOT NULL,
    [EndDate] DATETIME NOT NULL,
    [SubscriptionType] TINYINT NOT NULL,
    [CustomerId] BIGINT NOT NULL,
    [PackageName] NVARCHAR(20) NOT NULL CONSTRAINT [DF__CustomerS__Packa__34E8D562] DEFAULT 'N''PACKAGE''',
    [MaxStoreCount] SMALLINT NOT NULL CONSTRAINT [DF__CustomerS__MaxSt__35DCF99B] DEFAULT 10,
    [MaxSubUserCount] SMALLINT NOT NULL CONSTRAINT [DF__CustomerS__MaxSu__36D11DD4] DEFAULT 0,
    [Price] DECIMAL(12,2) NOT NULL CONSTRAINT [DF__CustomerS__Price__37C5420D] DEFAULT 0,
    [Description] NVARCHAR(500),
    [MaxCompetitionAnalysisCount] INT NOT NULL CONSTRAINT [DF__CustomerS__MaxCo__38B96646] DEFAULT 0,
    [DiscountPrice] DECIMAL(12,2) NOT NULL CONSTRAINT [DF__CustomerS__Disco__39AD8A7F] DEFAULT 0,
    [MinimumMonthlyCreditUsageAmount] DECIMAL(12,2),
    [DailyNewECommerceProductLimit] INT,
    [PackagesId] BIGINT,
    [MaximumErpCount] SMALLINT NOT NULL CONSTRAINT [DF__CustomerS__Maxim__3AA1AEB8] DEFAULT 0,
    [MaxProductLimit] INT,
    [MaxOrderLimit] INT,
    [OrderLimitFirstNotificationSended] BIT NOT NULL CONSTRAINT [DF__CustomerS__Order__0C90CB45] DEFAULT 0,
    [OrderLimitSecondNotificationSended] BIT NOT NULL CONSTRAINT [DF__CustomerS__Order__0D84EF7E] DEFAULT 0,
    [OrderLimitReachedNotificationSended] BIT NOT NULL CONSTRAINT [DF__CustomerS__Order__0E7913B7] DEFAULT 0,
    [HasApprovedContract] BIT NOT NULL CONSTRAINT [DF__CustomerS__HasAp__0F6D37F0] DEFAULT 0,
    [ContractApprovedDate] DATETIME,
    [ContractApprovedIpAddress] NVARCHAR(50),
    [ContractUserAgent] NVARCHAR(1000),
    CONSTRAINT [PK_CustomerSubscriptions] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[CustomerUserAuthActionForUsers] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [CustomerUserId] BIGINT NOT NULL,
    [AuthActionForUserId] BIGINT NOT NULL,
    CONSTRAINT [PK_CustomerUserAuthActionForUsers] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[CustomerUserNotificationTypes] (
    [Id] INT NOT NULL IDENTITY(1,1),
    [Enabled] BIT NOT NULL,
    [NotificationTypeId] INT NOT NULL,
    [CustomerUserId] BIGINT NOT NULL,
    CONSTRAINT [PK_CustomerUserNotificationTypes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[CustomerUsers] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Active] BIT NOT NULL,
    [IsMainUser] BIT NOT NULL,
    [UserId] BIGINT NOT NULL,
    [CustomerId] BIGINT NOT NULL,
    [LastActivity] DATETIME,
    CONSTRAINT [PK_CustomerUsers] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[DescriptionTemplates] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Description] NVARCHAR(4000) NOT NULL,
    [CustomerId] BIGINT NOT NULL,
    [Name] NVARCHAR(30) NOT NULL,
    CONSTRAINT [PK_DescriptionTemplates] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Districts] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Name] NVARCHAR(100) NOT NULL,
    [CityId] BIGINT NOT NULL,
    CONSTRAINT [PK_Districts] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[ECommerceMessagesECommerceKeys] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [CustomerECommerceKeyId] BIGINT NOT NULL,
    [CustomerECommerceMessageTemplateId] BIGINT NOT NULL,
    CONSTRAINT [PK_ECommerceMessagesECommerceKeys] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[ECommerceProductBatchDatas] (
    [BatchId] NVARCHAR(50) NOT NULL,
    [BatchData] NVARCHAR(max),
    [ResultData] NVARCHAR(max),
    CONSTRAINT [PK_ECommerceProductBatchDatas] PRIMARY KEY CLUSTERED ([BatchId])
);

-- CreateTable
CREATE TABLE [dbo].[ECommerceProductBatches] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [CustomerId] BIGINT NOT NULL,
    [BatchType] TINYINT NOT NULL,
    [BatchDate] DATETIME NOT NULL,
    [Entegre_ProductECommerceId] BIGINT,
    [ResultType] TINYINT NOT NULL,
    [BatchId] NVARCHAR(50) NOT NULL,
    [IntegratedECommerceCode] NVARCHAR(10) NOT NULL,
    [CustomerECommerceKeyId] BIGINT NOT NULL,
    CONSTRAINT [PK_ECommerceProductBatches] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[ECommerceSynchronizations] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [StartDateTime] DATETIME NOT NULL,
    [EndDateTime] DATETIME,
    [SynchronizationStatus] TINYINT NOT NULL,
    [SynchronizationType] TINYINT NOT NULL,
    [IntegratedECommerceCode] NVARCHAR(10) NOT NULL,
    [CustomerId] BIGINT NOT NULL,
    [JobId] NVARCHAR(20),
    [Description] NVARCHAR(2000),
    [ExtraParamValue] NVARCHAR(50),
    CONSTRAINT [PK_ECommerceSynchronizations] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[eInvoices] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Uuid] NVARCHAR(80) NOT NULL,
    [DocumentNumber] NVARCHAR(80) NOT NULL,
    [eInvoiceType] TINYINT NOT NULL,
    [Note] NVARCHAR(500),
    [IntegratedECommerceCode] NVARCHAR(10) NOT NULL,
    [CustomerECommerceKeyId] BIGINT NOT NULL,
    [SendDate] DATETIME NOT NULL,
    CONSTRAINT [PK_eInvoices] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[EInvoiceUsers] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [TaxNumber] NVARCHAR(11) NOT NULL,
    [Alias] NVARCHAR(250) NOT NULL,
    CONSTRAINT [PK_EInvoiceUsers] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_AE_AttributeAttributeValues] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Entegre_AE_AttributeId] BIGINT NOT NULL,
    [Entegre_AE_AttributeValueId] BIGINT NOT NULL,
    [Entegre_AE_CategoryId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_AE_AttributeAttributeValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_AE_Attributes] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_Entegre_AE_Attributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_AE_AttributeValues] (
    [Id] BIGINT NOT NULL,
    [AttributeValue] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_Entegre_AE_AttributeValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_AE_Categories] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    [Deepest] BIT NOT NULL,
    [BreadCrumb] NVARCHAR(500) NOT NULL,
    [ParentId] BIGINT,
    CONSTRAINT [PK_Entegre_AE_Categories] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_AE_CategoryAttributes] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Required] BIT NOT NULL,
    [Varianter] BIT NOT NULL,
    [Entegre_AE_AttributeId] BIGINT NOT NULL,
    [Entegre_AE_CategoryId] BIGINT NOT NULL,
    [IsAttribute] BIT NOT NULL,
    [AttributeType] NVARCHAR(10) NOT NULL,
    CONSTRAINT [PK_Entegre_AE_CategoryAttributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_AE_CustomerDefaultSettings] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [ShipmentTemplateId] BIGINT NOT NULL,
    [LanguageCode] NVARCHAR(5) NOT NULL,
    [ShippingDays] INT NOT NULL,
    CONSTRAINT [PK_Entegre_AE_CustomerDefaultSettings] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_AERU_AttributeAttributeValues] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Entegre_AERU_AttributeId] BIGINT NOT NULL,
    [Entegre_AERU_AttributeValueId] BIGINT NOT NULL,
    [Entegre_AERU_CategoryId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_AERU_AttributeAttributeValue] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_AERU_Attributes] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_Entegre_AERU_Attribute] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_AERU_AttributeValues] (
    [Id] BIGINT NOT NULL,
    [AttributeValue] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_Entegre_AERU_AttributeValue] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_AERU_Categories] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    [Deepest] BIT NOT NULL,
    [BreadCrumb] NVARCHAR(500) NOT NULL,
    [ParentId] BIGINT,
    CONSTRAINT [PK_Entegre_AERU_Category] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_AERU_CategoryAttributes] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Required] BIT NOT NULL,
    [Varianter] BIT NOT NULL,
    [IsAttribute] BIT NOT NULL,
    [AttributeType] NVARCHAR(10) NOT NULL,
    [Entegre_AERU_AttributeId] BIGINT NOT NULL,
    [Entegre_AERU_CategoryId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_AERU_CategoryAttribute] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Allegro_AttributeAttributeValues] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Entegre_Allegro_CategoryId] NVARCHAR(50) NOT NULL,
    [Entegre_Allegro_AttributeId] NVARCHAR(50) NOT NULL,
    [Entegre_Allegro_AttributeValueId] NVARCHAR(50) NOT NULL,
    CONSTRAINT [PK_Entegre_Allegro_AttributeAttributeValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Allegro_Attributes] (
    [Id] NVARCHAR(50) NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    [Type] NVARCHAR(10) NOT NULL,
    CONSTRAINT [PK_Entegre_Allegro_Attributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Allegro_AttributeValues] (
    [Id] NVARCHAR(50) NOT NULL,
    [Name] NVARCHAR(200) NOT NULL,
    CONSTRAINT [PK_Entegre_Allegro_AttributeValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Allegro_Categories] (
    [Id] NVARCHAR(50) NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    [Deepest] BIT NOT NULL,
    [BreadCrumb] NVARCHAR(600) NOT NULL,
    [ParentId] NVARCHAR(max),
    CONSTRAINT [PK_Entegre_Allegro_Categories] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Allegro_CategoryAttributes] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Required] BIT NOT NULL,
    [Varianter] BIT NOT NULL,
    [Entegre_Allegro_CategoryId] NVARCHAR(50) NOT NULL,
    [Entegre_Allegro_AttributeId] NVARCHAR(50) NOT NULL,
    CONSTRAINT [PK_Entegre_Allegro_CategoryAttributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Allegro_CustomerDefaultSettings] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [ShippingRateId] NVARCHAR(50) NOT NULL,
    [ImpliedWarrantyId] NVARCHAR(50) NOT NULL,
    [ReturnPolicyId] NVARCHAR(50) NOT NULL,
    CONSTRAINT [PK_Entegre_Allegro_CustomerDefaultSettings] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_AMZ_CustomerDefaultSettings] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [ShipmentTemplateName] NVARCHAR(100),
    [ShippingDays] TINYINT,
    [ShipmentCompanyId] BIGINT,
    CONSTRAINT [PK_Entegre_AMZ_CustomerDefaultSettings] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_BD_Attributes] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Name] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_Entegre_BD_Attributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_BD_AttributeValues] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Name] NVARCHAR(100) NOT NULL,
    [Entegre_BD_AttributeId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_BD_AttributeValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_BD_Categories] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    [ParentId] BIGINT,
    [Deepest] BIT NOT NULL,
    [BreadCrumb] NVARCHAR(500) NOT NULL,
    CONSTRAINT [PK_Entegre_BD_Categories] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_BD_CategoryAttributes] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Entegre_BD_CategoryId] BIGINT NOT NULL,
    [Entegre_BD_AttributeId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_BD_CategoryAttributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_CS_AttributeAttributeValues] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Entegre_CS_AttributeValueId] BIGINT NOT NULL,
    [Entegre_CS_AttributeId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_CS_AttributeAttributeValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_CS_Attributes] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_Entegre_CS_Attributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_CS_AttributeValues] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_Entegre_CS_AttributeValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_CS_Categories] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    [Deepest] BIT NOT NULL,
    [BreadCrumb] NVARCHAR(500) NOT NULL,
    [ParentId] BIGINT,
    CONSTRAINT [PK_Entegre_CS_Categories] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_CS_CategoryAttributes] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Varianter] BIT NOT NULL,
    [Required] BIT NOT NULL,
    [Entegre_CS_AttributeId] BIGINT NOT NULL,
    [Entegre_CS_CategoryId] BIGINT NOT NULL,
    [IsDynamic] BIT NOT NULL CONSTRAINT [DF__Entegre_C__IsDyn__3B95D2F1] DEFAULT 0,
    CONSTRAINT [PK_Entegre_CS_CategoryAttributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_CS_Questions] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [QuestionDate] DATETIME NOT NULL,
    [QuestionId] NVARCHAR(50) NOT NULL,
    [Question] NVARCHAR(2000) NOT NULL,
    [EntegreProductName] NVARCHAR(100) NOT NULL,
    [AnswerDate] DATETIME,
    [Answer] NVARCHAR(4000),
    [QuestionExposed] BIT NOT NULL,
    [ProductWebUrl] NVARCHAR(250),
    [ProductImageUrl] NVARCHAR(250),
    [CustomerId] BIGINT NOT NULL,
    [CustomerECommerceKeyId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_CS_Questions] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Ebay_AttributeAttributeValues] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Entegre_Ebay_AttributeId] BIGINT NOT NULL,
    [Entegre_Ebay_AttributeValueId] BIGINT NOT NULL,
    [Entegre_Ebay_CategoryId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_Ebay_AttributeAttributeValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Ebay_Attributes] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Name] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_Entegre_Ebay_Attributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Ebay_AttributeValues] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Name] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_Entegre_Ebay_AttributeValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Ebay_Categories] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    [Deepest] BIT NOT NULL,
    [BreadCrumb] NVARCHAR(500) NOT NULL,
    [ParentId] BIGINT,
    CONSTRAINT [PK_Entegre_Ebay_Categories] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Ebay_CategoryAttributes] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Varianter] BIT NOT NULL,
    [Required] BIT NOT NULL,
    [Entegre_Ebay_CategoryId] BIGINT NOT NULL,
    [Entegre_Ebay_AttributeId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_Ebay_CategoryAttributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Ebay_CustomerDefaultSettings] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [ProductFormatType] NVARCHAR(100) NOT NULL,
    [ShippingWhereType] NVARCHAR(100) NOT NULL,
    [FulfillmentPolicyId] NVARCHAR(100) NOT NULL,
    [PaymentPolicyId] NVARCHAR(100) NOT NULL,
    [ReturnPolicyId] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_Entegre_Ebay_CustomerDefaultSettings] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_EPttAvm_Categories] (
    [Id] INT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    [Deepest] BIT NOT NULL,
    [ParentId] INT,
    [BreadCrumb] NVARCHAR(500),
    CONSTRAINT [PK_Entegre_EPttAvm_Categories] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Etsy_AttributeAttributeScales] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Entegre_Etsy_AttributeId] BIGINT NOT NULL,
    [Entegre_Etsy_AttributeScaleId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_Etsy_AttributeAttributeScales] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Etsy_AttributeAttributeValues] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Entegre_Etsy_AttributeId] BIGINT NOT NULL,
    [Entegre_Etsy_AttributeValueId] BIGINT NOT NULL,
    [Entegre_Etsy_CategoryId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_Etsy_AttributeAttributeValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Etsy_Attributes] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_Entegre_Etsy_Attributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Etsy_AttributeScales] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(80) NOT NULL,
    CONSTRAINT [PK_Entegre_Etsy_AttributeScales] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Etsy_AttributeValues] (
    [Id] BIGINT NOT NULL,
    [AttributeValue] NVARCHAR(120) NOT NULL,
    CONSTRAINT [PK_Entegre_Etsy_AttributeValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Etsy_Categories] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    [Deepest] BIT NOT NULL,
    [BreadCrumb] NVARCHAR(500) NOT NULL,
    [ParentId] BIGINT,
    CONSTRAINT [PK_Entegre_Etsy_Categories] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Etsy_CategoryAttributes] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Entegre_Etsy_CategoryId] BIGINT NOT NULL,
    [Entegre_Etsy_AttributeId] BIGINT NOT NULL,
    [Varianter] BIT NOT NULL,
    [IsAttribute] BIT NOT NULL,
    [Required] BIT NOT NULL,
    CONSTRAINT [PK_Entegre_Etsy_CategoryAttributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Etsy_CustomerDefaultSettings] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [WhoMade] NVARCHAR(20) NOT NULL,
    [IsSupply] NVARCHAR(10) NOT NULL,
    [WhenMade] NVARCHAR(20) NOT NULL,
    [ShipmentTemplateId] BIGINT,
    CONSTRAINT [PK_Entegre_Etsy_CustomerDefaultSettings] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Flo_AttributeAttributeValues] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Entegre_Flo_AttributeId] BIGINT NOT NULL,
    [Entegre_Flo_AttributeValueId] BIGINT NOT NULL,
    [Entegre_Flo_CategoryId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_Flo_AttributeAttributeValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Flo_Attributes] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_Entegre_Flo_Attributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Flo_AttributeValues] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(120) NOT NULL,
    CONSTRAINT [PK_Entegre_Flo_AttributeValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Flo_Brands] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_Entegre_Flo_Brands] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Flo_Categories] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    [Deepest] BIT NOT NULL,
    [BreadCrumb] NVARCHAR(500),
    [ParentId] BIGINT,
    CONSTRAINT [PK_Entegre_Flo_Categories] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Flo_CategoryAttributes] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Entegre_Flo_CategoryId] BIGINT NOT NULL,
    [Required] BIT NOT NULL,
    [AllowCustom] BIT NOT NULL,
    [Varianter] BIT NOT NULL,
    [Entegre_Flo_AttributeId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_Flo_CategoryAttributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Fruugo_Categories] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    [Deepest] BIT NOT NULL,
    [BreadCrumb] NVARCHAR(600) NOT NULL,
    [ParentId] BIGINT,
    CONSTRAINT [PK_Entegre_Fruugo_Categories] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Getir_AccessTokens] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [UserName] NVARCHAR(50) NOT NULL,
    [Password] NVARCHAR(50) NOT NULL,
    [PasswordExpiryDate] DATETIME NOT NULL,
    [AccessToken] NVARCHAR(350) NOT NULL,
    [AccessTokenExpiryDate] DATETIME NOT NULL,
    CONSTRAINT [PK_Entegre_Getir_AccessTokens] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_GG_Categories] (
    [Code] NVARCHAR(10) NOT NULL,
    [Name] NVARCHAR(150) NOT NULL,
    [Deepest] BIT NOT NULL,
    [HasCatalog] BIT NOT NULL,
    [BreadCrumb] NVARCHAR(800) NOT NULL,
    CONSTRAINT [PK_Entegre_GG_Categories] PRIMARY KEY CLUSTERED ([Code])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_GG_CategorySpecs] (
    [Id] INT NOT NULL IDENTITY(1,1),
    [Entegre_GG_CategoryCode] NVARCHAR(10) NOT NULL,
    [Required] BIT NOT NULL,
    [Entegre_GG_SpecId] INT NOT NULL,
    CONSTRAINT [PK_Entegre_GG_CategorySpecs] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_GG_CategoryVariants] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Base] BIT NOT NULL,
    [OrderNumber] INT NOT NULL,
    [Entegre_GG_CategoryCode] NVARCHAR(10) NOT NULL,
    [Entegre_GG_VariantId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_GG_CategoryVariants] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_GG_Cities] (
    [TrCode] INT NOT NULL,
    [CityName] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_Entegre_GG_Cities] PRIMARY KEY CLUSTERED ([TrCode])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_GG_CustomerDefaultSettings] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [PageTemplateId] TINYINT,
    [ProductFormatType] NVARCHAR(1),
    [ListingDays] INT,
    [ShippingWhereType] NVARCHAR(10),
    [ShippingPaymentType] NVARCHAR(1),
    [CargoCompanies] NVARCHAR(50),
    [CargoDescription] NVARCHAR(500),
    [AffiliateOption] BIT NOT NULL,
    [BoldOption] BIT NOT NULL,
    [CatalogOption] BIT NOT NULL,
    [VitrineOption] BIT NOT NULL,
    [ShippingCity] INT,
    [ShippingPrice] DECIMAL(5,2),
    [ShippingDays] NVARCHAR(10),
    [ShippingSameDayTime] TIME,
    [AutoMergeOrders] BIT NOT NULL CONSTRAINT [DF__Entegre_G__AutoM__3C89F72A] DEFAULT 0,
    [PayInBasket] BIT,
    CONSTRAINT [PK_Entegre_GG_CustomerDefaultSettings] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_GG_Messages] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [MessageType] TINYINT NOT NULL,
    [Title] NVARCHAR(300) NOT NULL,
    [MessageContent] NVARCHAR(max) NOT NULL,
    [MessageDate] DATETIME NOT NULL,
    [FromUser] NVARCHAR(50) NOT NULL,
    [ToUser] NVARCHAR(50) NOT NULL,
    [IsRead] BIT NOT NULL,
    [CustomerId] BIGINT NOT NULL,
    [MessageId] INT NOT NULL,
    [CustomerECommerceKeyId] BIGINT NOT NULL,
    [OrderNumber] NVARCHAR(50),
    [EntegreProductId] NVARCHAR(50),
    [ConversationId] NVARCHAR(40) NOT NULL,
    CONSTRAINT [PK_Entegre_GG_Messages] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_GG_Specs] (
    [Id] INT NOT NULL,
    [Name] NVARCHAR(200) NOT NULL,
    [SpecType] NVARCHAR(50) NOT NULL,
    [ChildSpecId] INT,
    CONSTRAINT [PK_Entegre_GG_Specs] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_GG_SpecSpecValues] (
    [Id] INT NOT NULL IDENTITY(1,1),
    [Entegre_GG_SpecId] INT NOT NULL,
    [Entegre_GG_SpecValueId] INT NOT NULL,
    CONSTRAINT [PK_Entegre_GG_SpecSpecValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_GG_SpecValues] (
    [Id] INT NOT NULL,
    [SpecValue] NVARCHAR(300) NOT NULL,
    [ParentSpecValueId] INT,
    CONSTRAINT [PK_Entegre_GG_SpecValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_GG_Variants] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(200) NOT NULL,
    [VariantType] NVARCHAR(50) NOT NULL,
    CONSTRAINT [PK_Entegre_GG_Variants] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_GG_VariantValues] (
    [Id] BIGINT NOT NULL,
    [VariantValue] NVARCHAR(200) NOT NULL,
    [OrderNumber] INT NOT NULL,
    CONSTRAINT [PK_Entegre_GG_VariantValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_GG_VariantVariantValues] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Entegre_GG_VariantId] BIGINT NOT NULL,
    [Entegre_GG_VariantValueId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_GG_VariantVariantValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Google_Categories] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    [Deepest] BIT NOT NULL,
    [BreadCrumb] NVARCHAR(600),
    [ParentId] BIGINT,
    CONSTRAINT [PK_Entegre_Google_Categories] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_HB_AccessTokens] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [AccessTokenExpiryDate] DATETIME,
    [AccessToken] NVARCHAR(500),
    CONSTRAINT [PK_Entegre_HB_AccessTokens] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_HB_AttributeAttributeValues] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Entegre_HB_AttributeId] NVARCHAR(100) NOT NULL,
    [Entegre_HB_AttributeValueId] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_Entegre_HB_AttributeAttributeValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_HB_Attributes] (
    [Id] NVARCHAR(100) NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_Entegre_HB_Attributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_HB_AttributeValues] (
    [Id] NVARCHAR(100) NOT NULL,
    [Name] NVARCHAR(300) NOT NULL,
    CONSTRAINT [PK_Entegre_HB_AttributeValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_HB_Categories] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(150) NOT NULL,
    [Deepest] BIT NOT NULL,
    [BreadCrumb] NVARCHAR(800) NOT NULL,
    [IsActive] BIT NOT NULL,
    [ParentId] BIGINT,
    CONSTRAINT [PK_Entegre_HB_Categories] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_HB_CategoryAttributes] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [AttributeType] NVARCHAR(50) NOT NULL,
    [Required] BIT NOT NULL,
    [MultiValue] BIT NOT NULL,
    [Entegre_HB_CategoryId] BIGINT NOT NULL,
    [Entegre_HB_AttributeId] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_Entegre_HB_CategoryAttributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_HB_CategoryVariants] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [AttributeType] NVARCHAR(50) NOT NULL,
    [Required] BIT NOT NULL,
    [MultiValue] BIT NOT NULL,
    [Entegre_HB_VariantId] NVARCHAR(100) NOT NULL,
    [Entegre_HB_CategoryId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_HB_CategoryVariants] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_HB_Question_Conversations] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [MessageDate] DATETIME NOT NULL,
    [Message] NVARCHAR(2000) NOT NULL,
    [MessageType] NVARCHAR(1) NOT NULL,
    [Entegre_HB_QuestionId] BIGINT NOT NULL,
    [EntegreMessageId] NVARCHAR(50) NOT NULL,
    CONSTRAINT [PK_Entegre_HB_Question_Conversations] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_HB_Questions] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [QuestionDate] DATETIME NOT NULL,
    [Status] TINYINT NOT NULL,
    [EntegreProductName] NVARCHAR(150) NOT NULL,
    [ProductHepsiBuradaSku] NVARCHAR(50) NOT NULL,
    [QuestionCustomerId] NVARCHAR(50) NOT NULL,
    [ProductImageUrl] NVARCHAR(200) NOT NULL,
    [CustomerId] BIGINT NOT NULL,
    [CustomerECommerceKeyId] BIGINT NOT NULL,
    [IssueNumber] BIGINT NOT NULL,
    [Subject] NVARCHAR(100) NOT NULL,
    [OrderNumber] NVARCHAR(50),
    CONSTRAINT [PK_Entegre_HB_Questions] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_HB_Variants] (
    [Id] NVARCHAR(100) NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_Entegre_HB_Variants] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_HB_VariantValues] (
    [Id] NVARCHAR(100) NOT NULL,
    [Name] NVARCHAR(300) NOT NULL,
    CONSTRAINT [PK_Entegre_HB_VariantValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_HB_VariantVariantValues] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Entegre_HB_VariantId] NVARCHAR(100) NOT NULL,
    [Entegre_HB_VariantValueId] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_Entegre_HB_VariantVariantValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_HG_Attributes] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(max) NOT NULL,
    CONSTRAINT [PK_Entegre_HG_Attributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_HG_Categories] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(150) NOT NULL,
    [Deepest] BIT NOT NULL,
    [BreadCrumb] NVARCHAR(850) NOT NULL,
    [ParentId] BIGINT,
    CONSTRAINT [PK_Entegre_HG_Categories] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_HG_CategoryAttributes] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Required] BIT NOT NULL,
    [IsVariant] BIT NOT NULL,
    [Entegre_HG_CategoryId] BIGINT,
    [Entegre_HG_AttributeId] BIGINT,
    CONSTRAINT [PK_Entegre_HG_CategoryAttributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_IC_AccessTokens] (
    [ServerCode] NVARCHAR(20) NOT NULL,
    [ApiKey] NVARCHAR(200),
    [ApiSecret] NVARCHAR(200),
    [AccessTokenExpiryDate] DATETIME,
    [AccessToken] NVARCHAR(500),
    CONSTRAINT [PK_Entegre_IC_AccessTokens] PRIMARY KEY CLUSTERED ([ServerCode])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_IC_AttributeAttributeValues] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Entegre_IC_AttributeId] NVARCHAR(50) NOT NULL,
    [Entegre_IC_AttributeValueId] NVARCHAR(50) NOT NULL,
    CONSTRAINT [PK_Entegre_IC_AttributeAttributeValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_IC_Attributes] (
    [Id] NVARCHAR(50) NOT NULL,
    [Name] NVARCHAR(150) NOT NULL,
    CONSTRAINT [PK_Entegre_IC_Attributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_IC_AttributeValues] (
    [Id] NVARCHAR(50) NOT NULL,
    [Name] NVARCHAR(150) NOT NULL,
    CONSTRAINT [PK_Entegre_IC_AttributeValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_IC_BrandBrandModels] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Entegre_IC_BrandId] NVARCHAR(50) NOT NULL,
    [Entegre_IC_BrandModelId] NVARCHAR(50) NOT NULL,
    CONSTRAINT [PK_Entegre_IC_BrandBrandModels] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_IC_BrandModels] (
    [Id] NVARCHAR(50) NOT NULL,
    [Name] NVARCHAR(150) NOT NULL,
    CONSTRAINT [PK_Entegre_IC_BrandModels] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_IC_Brands] (
    [Id] NVARCHAR(50) NOT NULL,
    [Name] NVARCHAR(150) NOT NULL,
    CONSTRAINT [PK_Entegre_IC_Brands] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_IC_Categories] (
    [Id] NVARCHAR(50) NOT NULL,
    [Name] NVARCHAR(150) NOT NULL,
    [Deepest] BIT NOT NULL,
    [BreadCrumb] NVARCHAR(500) NOT NULL,
    [ParentId] NVARCHAR(50),
    CONSTRAINT [PK_Entegre_IC_Categories] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_IC_CategoryAttributes] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Entegre_IC_CategoryId] NVARCHAR(50) NOT NULL,
    [Entegre_IC_AttributeId] NVARCHAR(50) NOT NULL,
    CONSTRAINT [PK_Entegre_IC_CategoryAttributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_IC_CategoryBrands] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Entegre_IC_BrandId] NVARCHAR(50) NOT NULL,
    [Entegre_IC_CategoryId] NVARCHAR(50) NOT NULL,
    CONSTRAINT [PK_Entegre_IC_CategoryBrands] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_IC_CustomerDefaultSettings] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [ShippingTemplateId] NVARCHAR(50),
    [WarrantyType] TINYINT,
    CONSTRAINT [PK_Entegre_IC_CustomerDefaultSettings] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Idefix_AttributeAttributeValues] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Entegre_Idefix_CategoryId] BIGINT NOT NULL,
    [Entegre_Idefix_AttributeId] BIGINT NOT NULL,
    [Entegre_Idefix_AttributeValueId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_Idefix_AttributeAttributeValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Idefix_Attributes] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_Entegre_Idefix_Attributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Idefix_AttributeValues] (
    [Id] BIGINT NOT NULL,
    [AttributeValue] NVARCHAR(120) NOT NULL,
    CONSTRAINT [PK_Entegre_Idefix_AttributeValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Idefix_Brands] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(150) NOT NULL,
    CONSTRAINT [PK_Entegre_Idefix_Brands] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Idefix_Categories] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    [Deepest] BIT NOT NULL,
    [BreadCrumb] NVARCHAR(500),
    [ParentId] BIGINT,
    CONSTRAINT [PK_Entegre_Idefix_Categories] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Idefix_CategoryAttributes] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Required] BIT NOT NULL,
    [AllowCustom] BIT NOT NULL,
    [Varianter] BIT NOT NULL,
    [Entegre_Idefix_CategoryId] BIGINT NOT NULL,
    [Entegre_Idefix_AttributeId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_Idefix_CategoryAttributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Joom_Categories] (
    [Id] NVARCHAR(50) NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    [Deepest] BIT NOT NULL,
    [ParentId] NVARCHAR(50),
    [BreadCrumb] NVARCHAR(500) NOT NULL,
    CONSTRAINT [PK_Entegre_Joom_Categories] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_LB_AttributeAttributeValues] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Entegre_LB_AttributeId] BIGINT NOT NULL,
    [Entegre_LB_AttributeValueId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_LB_AttributeAttributeValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_LB_Attributes] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_Entegre_LB_Attributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_LB_AttributeValues] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_Entegre_LB_AttributeValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_LB_Categories] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    [Deepest] BIT NOT NULL,
    [BreadCrumb] NVARCHAR(500) NOT NULL,
    [ParentId] BIGINT,
    CONSTRAINT [PK_Entegre_LB_Categories] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_LB_CategoryAttributes] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Entegre_LB_AttributeId] BIGINT NOT NULL,
    [Entegre_LB_CategoryId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_LB_CategoryAttributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_MoNi_AttributeAttributeValues] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Entegre_MoNi_AttributeId] BIGINT NOT NULL,
    [Entegre_MoNi_AttributeValueId] BIGINT NOT NULL,
    [Entegre_MoNi_CategoryId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_MoNi_AttributeAttributeValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_MoNi_Attributes] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_Entegre_MoNi_Attributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_MoNi_AttributeValues] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(300) NOT NULL,
    CONSTRAINT [PK_Entegre_MoNi_AttributeValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_MoNi_Brands] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(150) NOT NULL
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_MoNi_Categories] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    [Deepest] BIT NOT NULL,
    [BreadCrumb] NVARCHAR(500) NOT NULL,
    [ParentId] BIGINT,
    [FabricRequired] BIT NOT NULL,
    CONSTRAINT [PK_Entegre_MoNi_Categories] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_MoNi_CategoryAttributes] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Required] BIT NOT NULL,
    [Entegre_MoNi_AttributeId] BIGINT NOT NULL,
    [Entegre_MoNi_CategoryId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_MoNi_CategoryAttributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_MoNi_CategoryVariants] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Required] BIT NOT NULL,
    [Entegre_MoNi_VariantId] BIGINT NOT NULL,
    [Entegre_MoNi_CategoryId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_MoNi_CategoryVariants] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_MoNi_Variants] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_Entegre_MoNi_Variants] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_MoNi_VariantValues] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(300) NOT NULL,
    CONSTRAINT [PK_Entegre_MoNi_VariantValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_MoNi_VariantVariantValues] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Entegre_MoNi_VariantId] BIGINT NOT NULL,
    [Entegre_MoNi_VariantValueId] BIGINT NOT NULL,
    [Entegre_MoNi_CategoryId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_MoNi_VariantVariantValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_N11_Attributes] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(150),
    [Multiselect] BIT NOT NULL,
    CONSTRAINT [PK_Entegre_N11_Attributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_N11_AttributeValues] (
    [Entegre_N11_AttributeId] BIGINT NOT NULL,
    [AttributeValue] NVARCHAR(250),
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [AttributeValueId] BIGINT,
    CONSTRAINT [PK_Entegre_N11_AttributeValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_N11_Categories] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    [Deepest] BIT NOT NULL,
    [ParentId] BIGINT,
    [BreadCrumb] NVARCHAR(500),
    CONSTRAINT [PK_Entegre_N11_Categories] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_N11_CategoryAttributes] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Required] BIT NOT NULL,
    [Entegre_N11_CategoryId] BIGINT NOT NULL,
    [Entegre_N11_AttributeId] BIGINT NOT NULL,
    [Varianter] BIT NOT NULL,
    CONSTRAINT [PK_Entegre_N11_CategoryAttributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_N11_CustomerDefaultSettings] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [ShipmentTemplateName] NVARCHAR(150),
    [ProductPreparingDays] TINYINT,
    CONSTRAINT [PK_Entegre_N11_CustomerDefaultSettings] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_N11_Questions] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [BuyerEMail] NVARCHAR(200) NOT NULL,
    [BuyerFullName] NVARCHAR(300),
    [EntegreProductName] NVARCHAR(150) NOT NULL,
    [EntegreProductId] NVARCHAR(50) NOT NULL,
    [QuestionId] BIGINT NOT NULL,
    [QuestionDate] DATETIME NOT NULL,
    [QuestionSubject] NVARCHAR(150) NOT NULL,
    [Question] NVARCHAR(1000) NOT NULL,
    [QuestionExposed] BIT NOT NULL,
    [AnswerDate] DATETIME,
    [Answer] NVARCHAR(4000),
    [Entegre_ProductECommerceId] BIGINT,
    [CustomerId] BIGINT NOT NULL,
    [CustomerECommerceKeyId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_N11_Questions] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_N11Pro_Attributes] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_Entegre_N11Pro_Attributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_N11Pro_Categories] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    [ParentId] BIGINT,
    [Deepest] BIT NOT NULL,
    [BreadCrumb] NVARCHAR(500) NOT NULL,
    CONSTRAINT [PK_Entegre_N11Pro_Categories] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_N11Pro_CategoryAttributes] (
    [Id] INT NOT NULL IDENTITY(1,1),
    [Required] BIT NOT NULL,
    [Entegre_N11Pro_AttributeId] BIGINT,
    [Entegre_N11Pro_CategoryId] BIGINT,
    CONSTRAINT [PK_Entegre_N11Pro_CategoryAttributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_N11Pro_CustomerDefaultSettings] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [ShipmentTemplateId] NVARCHAR(50),
    [ProductPreparingDays] INT,
    CONSTRAINT [PK_Entegre_N11Pro_CustomerDefaultSettings] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_OnBuy_AttributeAttributeValues] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Entegre_OnBuy_CategoryId] BIGINT NOT NULL,
    [Entegre_OnBuy_AttributeId] BIGINT NOT NULL,
    [Entegre_OnBuy_AttributeValueId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_OnBuy_AttributeAttributeValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_OnBuy_Attributes] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_Entegre_OnBuy_Attributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_OnBuy_AttributeValues] (
    [Id] BIGINT NOT NULL,
    [AttributeValue] NVARCHAR(120) NOT NULL,
    CONSTRAINT [PK_Entegre_OnBuy_AttributeValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_OnBuy_Brands] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_Entegre_OnBuy_Brands] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_OnBuy_Categories] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    [Deepest] BIT NOT NULL,
    [BreadCrumb] NVARCHAR(500),
    [ParentId] BIGINT,
    CONSTRAINT [PK_Entegre_OnBuy_Categories] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_OnBuy_CategoryAttributes] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Required] BIT NOT NULL,
    [Entegre_OnBuy_CategoryId] BIGINT NOT NULL,
    [Entegre_OnBuy_AttributeId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_OnBuy_CategoryAttributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_OnBuy_CategoryVariants] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Required] BIT NOT NULL,
    [Entegre_OnBuy_VariantId] BIGINT NOT NULL,
    [Entegre_OnBuy_CategoryId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_OnBuy_CategoryVariants] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_OnBuy_Variants] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_Entegre_OnBuy_Variants] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_OnBuy_VariantValues] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(300) NOT NULL,
    CONSTRAINT [PK_Entegre_OnBuy_VariantValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_OnBuy_VariantVariantValues] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Entegre_OnBuy_VariantId] BIGINT NOT NULL,
    [Entegre_OnBuy_VariantValueId] BIGINT NOT NULL,
    [Entegre_OnBuy_CategoryId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_OnBuy_VariantVariantValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Ozon_AttributeAttributeValues] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Entegre_Ozon_CategoryId] BIGINT NOT NULL,
    [Entegre_Ozon_AttributeId] BIGINT NOT NULL,
    [Entegre_Ozon_AttributeValueId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_Ozon_AttributeAttributeValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Ozon_Attributes] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    [Type] NVARCHAR(50) NOT NULL,
    CONSTRAINT [PK_Entegre_Ozon_Attributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Ozon_AttributeValues] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_Entegre_Ozon_AttributeValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Ozon_Categories] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    [ParentId] BIGINT,
    [Deepest] BIT NOT NULL,
    [BreadCrumb] NVARCHAR(2000) NOT NULL,
    CONSTRAINT [PK_Entegre_Ozon_Categories] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Ozon_CategoryAttributes] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Required] BIT NOT NULL,
    [IsCollection] BIT NOT NULL,
    [Entegre_Ozon_CategoryId] BIGINT NOT NULL,
    [Entegre_Ozon_AttributeId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_Ozon_CategoryAttributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Ozon_Messages] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [ChatId] NVARCHAR(50) NOT NULL,
    [MessageType] TINYINT NOT NULL,
    [MessageContent] NVARCHAR(max) NOT NULL,
    [MessageDate] DATETIME NOT NULL,
    [MessageId] BIGINT NOT NULL,
    [ChatStatus] TINYINT NOT NULL,
    [IsRead] BIT NOT NULL,
    [FromUser] NVARCHAR(50) NOT NULL,
    [ToUser] NVARCHAR(50),
    [OrderNumber] NVARCHAR(100),
    [OzonProductSku] NVARCHAR(100) NOT NULL,
    [CustomerId] BIGINT NOT NULL,
    [CustomerECommerceKeyId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_Ozon_Messages] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Pazarama_AttributeAttributeValues] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Entegre_Pazarama_CategoryId] NVARCHAR(40) NOT NULL,
    [Entegre_Pazarama_AttributeValueId] NVARCHAR(40) NOT NULL,
    [Entegre_Pazarama_AttributeId] NVARCHAR(40) NOT NULL,
    CONSTRAINT [PK_Entegre_Pazarama_AttributeAttributeValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Pazarama_Attributes] (
    [Id] NVARCHAR(40) NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_Entegre_Pazarama_Attributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Pazarama_AttributeValues] (
    [Id] NVARCHAR(40) NOT NULL,
    [AttributeValue] NVARCHAR(120) NOT NULL,
    CONSTRAINT [PK_Entegre_Pazarama_AttributeValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Pazarama_Brands] (
    [Id] NVARCHAR(40) NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_Entegre_Pazarama_Brands] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Pazarama_Categories] (
    [Id] NVARCHAR(40) NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    [Deepest] BIT NOT NULL,
    [BreadCrumb] NVARCHAR(500),
    [ParentId] NVARCHAR(40),
    CONSTRAINT [PK_Entegre_Pazarama_Categories] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Pazarama_CategoryAttributes] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Required] BIT NOT NULL,
    [AllowCustom] BIT NOT NULL,
    [Varianter] BIT NOT NULL,
    [Entegre_Pazarama_CategoryId] NVARCHAR(40) NOT NULL,
    [Entegre_Pazarama_AttributeId] NVARCHAR(40) NOT NULL,
    CONSTRAINT [PK_Entegre_Pazarama_CategoryAttributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_PraStore_Categories] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Name] NVARCHAR(150) NOT NULL,
    [CustomerECommerceKeyId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_PraStore_Categories] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_ProductECommerce_Attributes] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [AttributeName] NVARCHAR(100) NOT NULL,
    [AttributeId] BIGINT,
    [AttributeValue] NVARCHAR(120) NOT NULL,
    [AttributeValueId] BIGINT,
    [Entegre_ProductECommerceId] BIGINT NOT NULL,
    [DynamicTextLength] INT,
    CONSTRAINT [PK_Entegre_ProductECommerce_Attributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_ProductECommerce_CompetitionAnalyses] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [MinPriceInclusiveVat] DECIMAL(10,2) NOT NULL,
    [MaxPriceInclusiveVat] DECIMAL(10,2),
    [PriceStep] DECIMAL(5,2) NOT NULL,
    [Entegre_ProductECommerceId] BIGINT NOT NULL,
    [CustomerId] BIGINT NOT NULL,
    [MinStorePoint] TINYINT,
    [Active] BIT NOT NULL CONSTRAINT [DF__Entegre_P__Activ__3D7E1B63] DEFAULT 1,
    [IgnoreStoreIds] NVARCHAR(200),
    [UseBuybox] BIT,
    [BuyboxPriceStepSetting] BIT,
    CONSTRAINT [PK_Entegre_ProductECommerce_CompetitionAnalyses] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_ProductECommerce_DescriptionTemplates] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [SortOrder] TINYINT NOT NULL,
    [DescriptionTemplateId] BIGINT NOT NULL,
    [Entegre_ProductECommerceId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_ProductECommerce_DescriptionTemplates] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_ProductECommerce_Histories] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [EntegreProductId] BIGINT NOT NULL,
    [ProductId] BIGINT NOT NULL,
    [IntegratedECommerceCode] NVARCHAR(10) NOT NULL,
    CONSTRAINT [PK_Entegre_ProductECommerce_Histories] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_ProductECommerce_Images] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [SortOrder] TINYINT NOT NULL,
    [ProductImageId] BIGINT NOT NULL,
    [Entegre_ProductECommerceId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_ProductECommerce_Images] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_ProductECommerce_Jobs] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [CreatedOn] DATETIME NOT NULL,
    [JobType] TINYINT NOT NULL,
    [Entegre_ProductECommerceId] BIGINT NOT NULL,
    [IntegratedECommerceCode] NVARCHAR(10) NOT NULL,
    [CustomerId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_ProductECommerce_Jobs] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_ProductECommerce_ShipmentCompanies] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [ShipmentCompanyId] BIGINT NOT NULL,
    [Entegre_ProductECommerceId] BIGINT NOT NULL,
    [SortOrder] TINYINT NOT NULL CONSTRAINT [DF__Entegre_P__SortO__3E723F9C] DEFAULT 1,
    CONSTRAINT [PK_Entegre_ProductECommerce_ShipmentCompanies] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_ProductECommerce_Variant_Details] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [VariantName] NVARCHAR(100) NOT NULL,
    [VariantId] BIGINT,
    [VariantValue] NVARCHAR(120) NOT NULL,
    [VariantValueId] BIGINT,
    [Entegre_ProductECommerce_VariantId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_ProductECommerce_Variant_Details] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_ProductECommerce_Variant_Images] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [SortOrder] TINYINT NOT NULL,
    [Entegre_ProductECommerce_VariantId] BIGINT NOT NULL,
    [ProductImageId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_ProductECommerce_Variant_Images] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_ProductECommerce_Variants] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [StockCode] NVARCHAR(50) NOT NULL,
    [PriceInclusiveVat] DECIMAL(20,8),
    [VariantStockItemId] NVARCHAR(50),
    [StockItemVersion] BIGINT,
    [Entegre_ProductECommerceId] BIGINT NOT NULL,
    [ProductVariantGroupId] BIGINT,
    [VariantStockItemCode] NVARCHAR(50),
    [SourcePriceInclusiveVat] DECIMAL(20,8),
    CONSTRAINT [PK_Entegre_ProductECommerce_Variants] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_ProductECommerces] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Code] NVARCHAR(50),
    [Name] NVARCHAR(150),
    [SubHeader] NVARCHAR(100),
    [PriceInclusiveVat] DECIMAL(20,8),
    [MarketPriceInclusiveVat] DECIMAL(20,8),
    [DiscountType] TINYINT NOT NULL,
    [StockAmount] DECIMAL(20,8),
    [EntegreCategoryId] NVARCHAR(50),
    [EntegreStoreCategoryId] BIGINT,
    [EntegreStockItemVersion] BIGINT,
    [EntegreProductId] NVARCHAR(50),
    [EntegreProductCode] NVARCHAR(50),
    [EntegreStockItemId] NVARCHAR(50),
    [ProductId] BIGINT NOT NULL,
    [IntegratedECommerceCode] NVARCHAR(10) NOT NULL,
    [ProductECommerceStatus] TINYINT NOT NULL,
    [UpdateDateTime] DATETIME,
    [SaleEndDate] DATETIME,
    [ShippingPaymentType] TINYINT NOT NULL,
    [PaymentRequiredForECommerce] BIT NOT NULL,
    [CurrencyId] INT NOT NULL,
    [SoldCount] INT,
    [EntegreDispatchTime] NVARCHAR(10),
    [EntegreMaximumPurchasableQuantity] INT,
    [CustomerId] BIGINT NOT NULL CONSTRAINT [DF__Entegre_P__Custo__3F6663D5] DEFAULT 1,
    [ShippingTemplateName] NVARCHAR(100),
    [CustomerECommerceKeyId] BIGINT NOT NULL,
    [EntegreProductSlug] NVARCHAR(250),
    [ShipmentPrice] DECIMAL(6,2),
    [ShipmentAddressIdCode] NVARCHAR(50),
    [InvoiceAddressIdCode] NVARCHAR(50),
    [ReturningAddressIdCode] NVARCHAR(50),
    [BatchId] NVARCHAR(80),
    [EntegreBrandId] NVARCHAR(40),
    [StockMultiplier] DECIMAL(16,8) NOT NULL CONSTRAINT [DF_EP_StockMultplier] DEFAULT 1,
    [ProductDescriptionId] BIGINT,
    [CreatedOn] DATETIME NOT NULL CONSTRAINT [DF__Entegre_P__Creat__414EAC47] DEFAULT CURRENT_TIMESTAMP,
    [LanguageCode] NVARCHAR(5),
    [IsWareHouseListing] BIT NOT NULL CONSTRAINT [DF__Entegre_P__IsWar__4242D080] DEFAULT 0,
    [SourceCurrencyId] INT,
    [SourcePriceInclusiveVat] DECIMAL(20,8),
    [PriceFormula] NVARCHAR(200),
    CONSTRAINT [PK_Entegre_ProductECommerces] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_ProductECommerces_CampaignStocks] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Entegre_ProductECommerceId] BIGINT NOT NULL,
    [Entegre_ProductECommerce_VariantId] BIGINT,
    [StockAmount] DECIMAL(10,2) NOT NULL,
    [CampaignStartDate] DATETIME NOT NULL,
    [CampaignEndDate] DATETIME,
    [SoldCount] DECIMAL(10,2) NOT NULL,
    CONSTRAINT [PK_Entegre_ProductECommerces_CampaignStocks] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_ShipmentCompanies] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [EntegreShipmentCompanyCode] NVARCHAR(50),
    [IntegratedECommerceCode] NVARCHAR(10) NOT NULL,
    [ShipmentCompanyId] BIGINT NOT NULL,
    [EntegreShipmentCompanyId] NVARCHAR(30),
    CONSTRAINT [PK_Entegre_ShipmentCompanies] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_SP_AttributeAttributeValues] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Entegre_SP_AttributeId] BIGINT NOT NULL,
    [Entegre_SP_AttributeValueId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_SP_AttributeAttributeValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_SP_Attributes] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_Entegre_SP_Attributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_SP_AttributeValues] (
    [Id] BIGINT NOT NULL,
    [AttributeValue] NVARCHAR(120) NOT NULL,
    CONSTRAINT [PK_Entegre_SP_AttributeValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_SP_Categories] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    [Deepest] BIT NOT NULL,
    [ParentId] BIGINT,
    [BreadCrumb] NVARCHAR(500),
    CONSTRAINT [PK_Entegre_SP_Categories] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_SP_CategoryAttributes] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Required] BIT NOT NULL,
    [Entegre_SP_CategoryId] BIGINT NOT NULL,
    [Entegre_SP_AttributeId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_SP_CategoryAttributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_SP_CategoryVariants] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Entegre_SP_CategoryId] BIGINT NOT NULL,
    [Entegre_SP_VariantId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_SP_CategoryVariants] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_SP_CustomerDefaultSettings] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [ListingDays] INT,
    [ShippingCity] INT,
    [BoldOption] BIT NOT NULL,
    [CargoCompanies] NVARCHAR(50),
    [ShippingPaymentType] NVARCHAR(6),
    [ShippingDays] TINYINT,
    CONSTRAINT [PK_Entegre_SP_CustomerDefaultSettings] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_SP_Variants] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(50) NOT NULL,
    CONSTRAINT [PK_Entegre_SP_Variants] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_SP_VariantValues] (
    [Id] BIGINT NOT NULL,
    [VariantValue] NVARCHAR(80) NOT NULL,
    CONSTRAINT [PK_Entegre_SP_VariantValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_SP_VariantVariantValues] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Entegre_SP_VariantId] BIGINT NOT NULL,
    [Entegre_SP_VariantValueId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_SP_VariantVariantValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_Teknosa_Categories] (
    [Id] NVARCHAR(50) NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    [Deepest] BIT NOT NULL,
    [BreadCrumb] NVARCHAR(500) NOT NULL,
    [ParentId] NVARCHAR(50),
    CONSTRAINT [PK_Entegre_Teknosa_Categories] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_TO_AttributeAttributeValues] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Entegre_TO_AttributeId] BIGINT NOT NULL,
    [Entegre_TO_AttributeValueId] BIGINT NOT NULL,
    [Entegre_TO_CategoryId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_TO_AttributeAttributeValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_TO_Attributes] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_Entegre_TO_Attributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_TO_AttributeValues] (
    [Id] BIGINT NOT NULL,
    [AttributeValue] NVARCHAR(120) NOT NULL,
    CONSTRAINT [PK_Entegre_TO_AttributeValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_TO_Brands] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_Entegre_TO_Brands] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_TO_Categories] (
    [Id] BIGINT NOT NULL,
    [Code] NVARCHAR(10),
    [Name] NVARCHAR(100) NOT NULL,
    [Deepest] BIT NOT NULL,
    [BreadCrumb] NVARCHAR(500),
    [ParentId] BIGINT,
    CONSTRAINT [PK_Entegre_TO_Categories] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_TO_CategoryAttributes] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Required] BIT NOT NULL,
    [AllowCustom] BIT NOT NULL,
    [Varianter] BIT NOT NULL,
    [Entegre_TO_AttributeId] BIGINT NOT NULL,
    [Entegre_TO_CategoryId] BIGINT NOT NULL,
    CONSTRAINT [PK_Entegre_TO_CategoryAttributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_TO_Questions] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [QuestionDate] DATETIME NOT NULL,
    [Status] TINYINT NOT NULL,
    [BuyerFullName] NVARCHAR(300),
    [QuestionId] BIGINT NOT NULL,
    [Question] NVARCHAR(2000) NOT NULL,
    [EntegreProductName] NVARCHAR(100) NOT NULL,
    [AnswerDate] DATETIME,
    [Answer] NVARCHAR(4000),
    [MessageCustomerId] BIGINT NOT NULL,
    [CustomerId] BIGINT NOT NULL,
    [CustomerECommerceKeyId] BIGINT NOT NULL,
    [QuestionExposed] BIT NOT NULL,
    [ProductWebUrl] NVARCHAR(250),
    [ProductImageUrl] NVARCHAR(250),
    CONSTRAINT [PK_Entegre_TO_Questions] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_VFM_AttributeAttributeValues] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Entegre_VFM_AttributeId] NVARCHAR(50) NOT NULL,
    [Entegre_VFM_AttributeValueId] BIGINT NOT NULL,
    [Entegre_VFM_CategoryId] NVARCHAR(50) NOT NULL,
    CONSTRAINT [PK_Entegre_VFM_AttributeAttributeValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_VFM_Attributes] (
    [Id] NVARCHAR(50) NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_Entegre_VFM_Attributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_VFM_AttributeValues] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Name] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_Entegre_VFM_AttributeValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_VFM_Brands] (
    [Id] NVARCHAR(50) NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_Entegre_VFM_Brands] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_VFM_Categories] (
    [Id] NVARCHAR(50) NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    [ParentId] NVARCHAR(50),
    [Deepest] BIT NOT NULL,
    [BreadCrumb] NVARCHAR(500) NOT NULL,
    CONSTRAINT [PK_Entegre_VFM_Categories] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_VFM_CategoryAttributes] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Required] BIT NOT NULL,
    [AllowCustom] BIT NOT NULL,
    [Varianter] BIT NOT NULL,
    [Entegre_VFM_CategoryId] NVARCHAR(50) NOT NULL,
    [Entegre_VFM_AttributeId] NVARCHAR(50) NOT NULL,
    CONSTRAINT [PK_Entegre_VFM_CategoryAttributes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Entegre_WOO_Cities] (
    [TrCode] NVARCHAR(10) NOT NULL,
    [CityName] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_Entegre_WOO_Cities] PRIMARY KEY CLUSTERED ([TrCode])
);

-- CreateTable
CREATE TABLE [dbo].[FedExCities] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Name] NVARCHAR(100) NOT NULL,
    [Code] NVARCHAR(2) NOT NULL,
    [FedExCountryCode] NVARCHAR(2) NOT NULL,
    CONSTRAINT [PK_FedExCities] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[FedExCountries] (
    [Code] NVARCHAR(2) NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_FedExCountries] PRIMARY KEY CLUSTERED ([Code])
);

-- CreateTable
CREATE TABLE [dbo].[IntegratedECommerces] (
    [Code] NVARCHAR(10) NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    [SortOrder] TINYINT NOT NULL,
    [IntegratedECommerceType] TINYINT NOT NULL CONSTRAINT [DF__Integrate__Integ__4336F4B9] DEFAULT 1,
    CONSTRAINT [PK_IntegratedECommerces] PRIMARY KEY CLUSTERED ([Code]),
    CONSTRAINT [UNQ_IntegratedECommerces_Code] UNIQUE NONCLUSTERED ([Code])
);

-- CreateTable
CREATE TABLE [dbo].[InvoiceAddresses] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [CustomerName] NVARCHAR(300) NOT NULL,
    [AdressLine] NVARCHAR(800) NOT NULL,
    [City] NVARCHAR(100) NOT NULL,
    [District] NVARCHAR(100),
    [Neighborhood] NVARCHAR(200),
    [ZipCode] NVARCHAR(15),
    [CustomerTaxNumber] NVARCHAR(20),
    [CustomerTaxOffice] NVARCHAR(50),
    [CustomerCitizenShipId] NVARCHAR(20),
    [CustomerGsm] NVARCHAR(15),
    [CustomerPhone] NVARCHAR(15),
    [CountryIso2] NVARCHAR(2) NOT NULL CONSTRAINT [DF__InvoiceAd__Count__442B18F2] DEFAULT 'TR',
    CONSTRAINT [PK_InvoiceAddresses] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Languages] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Name] NVARCHAR(100) NOT NULL,
    [ShortName] NVARCHAR(10) NOT NULL,
    [Code] NVARCHAR(10) NOT NULL,
    CONSTRAINT [PK_Languages] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[MainAnnouncements] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [CreatedAt] DATETIME NOT NULL,
    [Title] NVARCHAR(100) NOT NULL,
    [Description] NVARCHAR(max) NOT NULL,
    [ViewType] TINYINT NOT NULL,
    [AnnouncementType] TINYINT NOT NULL,
    CONSTRAINT [PK_MainAnnouncements] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[NotificationTypeDescriptions] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [NotificationTypeId] INT NOT NULL,
    [LanguageId] BIGINT NOT NULL,
    [Description] NVARCHAR(500) NOT NULL,
    CONSTRAINT [PK_NotificationTypeDescriptions] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[NotificationTypes] (
    [Id] INT NOT NULL IDENTITY(1,1),
    [Code] NVARCHAR(50) NOT NULL,
    CONSTRAINT [PK_NotificationTypes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[OrderLineCustomTextOptions] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [OptionName] NVARCHAR(200) NOT NULL,
    [OptionValue] NVARCHAR(350) NOT NULL,
    [OrderLineId] BIGINT NOT NULL,
    CONSTRAINT [PK_OrderLineCustomTextOptions] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[OrderLineKeyValues] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Name] NVARCHAR(20) NOT NULL,
    [Value] NVARCHAR(50) NOT NULL,
    [OrderLineId] BIGINT NOT NULL,
    CONSTRAINT [PK_OrderLineKeyValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[OrderLinePhantomLines] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [OrderLineId] BIGINT NOT NULL,
    [StockCode] NVARCHAR(50),
    [ProductName] NVARCHAR(250) NOT NULL,
    [UnitPrice] DECIMAL(12,3) NOT NULL,
    [UnitMallDiscountAmount] DECIMAL(12,2) NOT NULL,
    [Quantity] DECIMAL(20,8) NOT NULL,
    [VatRateId] INT NOT NULL,
    [ProductId] BIGINT,
    [ProductVariantGroupId] BIGINT,
    [CurrencyId] INT NOT NULL,
    [UnitTypeId] INT NOT NULL,
    CONSTRAINT [PK_OrderLinePhantomLines] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[OrderLines] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [OrderId] BIGINT NOT NULL,
    [ProductId] BIGINT,
    [ProductStockCode] NVARCHAR(50),
    [EntegreProductId] NVARCHAR(50),
    [EntegreLineItemId] NVARCHAR(50),
    [ProductName] NVARCHAR(250) NOT NULL,
    [Quantity] DECIMAL(20,8) NOT NULL,
    [VatRateId] INT NOT NULL,
    [CurrencyId] INT NOT NULL,
    [UnitTypeId] INT NOT NULL,
    [Status] TINYINT NOT NULL,
    [UnitPrice] DECIMAL(12,2) NOT NULL,
    [UnitDiscountAmount] DECIMAL(12,2) NOT NULL,
    [ComissionAmount] DECIMAL(12,2) NOT NULL,
    [InstallmentChargeWithVat] DECIMAL(12,2) NOT NULL,
    [ShipmentPaymentType] TINYINT NOT NULL,
    [ShipmentCompanyCampaignNumber] NVARCHAR(80),
    [ShipmentCompanyECommerceCodeId] NVARCHAR(80),
    [ShipmentPrice] DECIMAL(12,3),
    [EntegreProductSlug] NVARCHAR(250),
    [UnitMallDiscountAmount] DECIMAL(12,2) NOT NULL CONSTRAINT [DF__OrderLine__UnitM__451F3D2B] DEFAULT 0,
    [RequestedDeliveryDate] DATETIME,
    [PackageNumber] VARCHAR(50),
    [StockMultiplier] DECIMAL(16,8) NOT NULL CONSTRAINT [DF_OL_StockMultplier] DEFAULT 1,
    [ProductVariantGroupId] BIGINT,
    [ProductUnitCostPrice] DECIMAL(12,4),
    [ProductCurrencyRate] DECIMAL(12,5),
    [CurrencyRate] DECIMAL(12,5) NOT NULL CONSTRAINT [DF__OrderLine__Curre__4707859D] DEFAULT 1,
    [ProductCurrencyId] INT,
    [ShipmentCurrencyRate] DECIMAL(12,5),
    [ShipmentCurrencyId] INT,
    CONSTRAINT [PK_OrderLines] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[OrderLineVariants] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [VariantName] NVARCHAR(100) NOT NULL,
    [VariantValue] NVARCHAR(120) NOT NULL,
    [OrderLineId] BIGINT NOT NULL,
    CONSTRAINT [PK_OrderLineVariants] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Orders] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [OrderDate] DATETIME NOT NULL,
    [ECommerceOrderNumber] NVARCHAR(50) NOT NULL,
    [ECommerceOrderId] NVARCHAR(50),
    [OrderCustomerFullName] NVARCHAR(300) NOT NULL,
    [OrderCustomerEMail] NVARCHAR(200),
    [OrderCustomerUserNameId] NVARCHAR(80),
    [OrderCustomerTaxNumber] NVARCHAR(20),
    [OrderCustomerTaxOffice] NVARCHAR(50),
    [OrderCustomerCitizenShipId] NVARCHAR(20),
    [OrderCustomerGsm] NVARCHAR(15),
    [OrderCustomerPhone] NVARCHAR(15),
    [IntegratedECommerceCode] NVARCHAR(10) NOT NULL,
    [Status] TINYINT NOT NULL,
    [ShippingAddressId] BIGINT NOT NULL,
    [InvoiceAddressId] BIGINT,
    [CustomerId] BIGINT NOT NULL,
    [AccountingOrderNumber] NVARCHAR(120),
    [InvoiceType] TINYINT,
    [PackageBarCode] NVARCHAR(100),
    [PackageNumber] NVARCHAR(700),
    [ShipmentBarCodePrinted] BIT NOT NULL CONSTRAINT [DF__Orders__Shipment__47FBA9D6] DEFAULT 0,
    [FastShippingRequired] BIT NOT NULL CONSTRAINT [DF__Orders__FastShip__48EFCE0F] DEFAULT 0,
    [CustomerECommerceKeyId] BIGINT,
    [InvoicePrinted] BIT NOT NULL CONSTRAINT [DF__Orders__InvoiceP__49E3F248] DEFAULT 0,
    [CargoKey] NVARCHAR(50),
    [IntegratedCargoECommerceCode] NVARCHAR(10),
    [CustomerECommerceCargoKeyId] BIGINT,
    [OrderECommercePaymentMethod] NVARCHAR(80),
    [InvoiceNumber] NVARCHAR(50),
    [CustomerNote] NVARCHAR(500),
    [PickingNotification] BIT,
    [IsOrderNotePrinted] BIT NOT NULL CONSTRAINT [DF__Orders__IsOrderN__4AD81681] DEFAULT 0,
    [OrderECommercePaymentType] TINYINT NOT NULL CONSTRAINT [DF__Orders__OrderECo__4BCC3ABA] DEFAULT 1,
    [AccountingInvoiceIdCode] NVARCHAR(50),
    [IntegratedAccountingECommerceCode] NVARCHAR(10),
    [CustomerECommerceAccountingKeyId] BIGINT,
    [CargoSessionKey] NVARCHAR(150),
    [eInvoiceId] BIGINT,
    [WarehouseOrder] BIT,
    [CreatedOn] DATETIME NOT NULL CONSTRAINT [DF__Orders__CreatedO__4CC05EF3] DEFAULT CURRENT_TIMESTAMP,
    [MustBeSentWithMerchantCargo] BIT,
    [IsEInvoicePrinted] BIT NOT NULL CONSTRAINT [DF__Orders__IsEInvoi__4DB4832C] DEFAULT 0,
    [CustomerECommerceFulFillmentKeyId] BIGINT,
    [IntegratedFulFillmentECommerceCode] NVARCHAR(10),
    [EntegreFulFillmentCode] NVARCHAR(50),
    [InvoicePostedToECommerce] BIT NOT NULL CONSTRAINT [DF__Orders__InvoiceP__4EA8A765] DEFAULT 0,
    [PackageUserId] BIGINT,
    [AssignedUserId] BIGINT,
    [PackedUserId] BIGINT,
    [PackageAssignDate] DATETIME,
    [PackedDate] DATETIME,
    [ColorTag] SMALLINT,
    CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[OrderServiceItems] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Code] NVARCHAR(50),
    [Name] NVARCHAR(100),
    [Quantity] DECIMAL(20,8) NOT NULL,
    [UnitPrice] DECIMAL(12,2) NOT NULL,
    [OrderId] BIGINT NOT NULL,
    [CurrencyId] INT NOT NULL,
    [VatRateId] INT NOT NULL,
    [InstallmentChargeWithVat] DECIMAL(12,2) NOT NULL CONSTRAINT [DF__OrderServ__Insta__4F9CCB9E] DEFAULT 0,
    CONSTRAINT [PK_OrderServiceItems] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[PackageExtras] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Price] DECIMAL(12,2) NOT NULL,
    [PackagesId] BIGINT NOT NULL,
    [AuthActionForCustomerId] BIGINT NOT NULL,
    CONSTRAINT [PK_PackageExtras] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Packages] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Name] NVARCHAR(100) NOT NULL,
    [Price] DECIMAL(12,2) NOT NULL,
    [DefaultSubUserCount] SMALLINT NOT NULL,
    [DefaultStoreCount] SMALLINT NOT NULL,
    [SubscriptionType] TINYINT NOT NULL,
    [DailyNewECommerceProductLimit] INT,
    [DefaultCompetitionAnalysisCount] INT NOT NULL CONSTRAINT [DF__Packages__Defaul__5090EFD7] DEFAULT 0,
    [MinimumMonthlyCreditUsageAmount] DECIMAL(12,2),
    [StartDate] DATETIME NOT NULL CONSTRAINT [DF__Packages__StartD__51851410] DEFAULT CURRENT_TIMESTAMP,
    [EndDate] DATETIME,
    [DefaultErpCount] SMALLINT NOT NULL CONSTRAINT [DF__Packages__Defaul__52793849] DEFAULT 0,
    [MaximumPurchasableQuantity] SMALLINT,
    [IsPrivate] BIT NOT NULL CONSTRAINT [DF__Packages__IsPriv__536D5C82] DEFAULT 0,
    [MaxProductLimit] INT,
    [MaxOrderLimit] INT,
    CONSTRAINT [PK_Packages] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Point_Cities] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(50) NOT NULL,
    CONSTRAINT [PK_Point_Cities] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Point_Districts] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(max) NOT NULL,
    [Point_CityId] BIGINT NOT NULL,
    CONSTRAINT [PK_Point_Districts] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[ProductDescriptions] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Name] NVARCHAR(50) NOT NULL,
    [Description] NVARCHAR(max) NOT NULL,
    [ProductId] BIGINT NOT NULL,
    [DescriptionType] TINYINT NOT NULL CONSTRAINT [DF__ProductDe__Descr__546180BB] DEFAULT 1,
    CONSTRAINT [PK_ProductDescriptions] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[ProductImages] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [FileName] NVARCHAR(80) NOT NULL,
    [SortOrder] TINYINT NOT NULL,
    [ProductId] BIGINT NOT NULL,
    [ImageUrl] NVARCHAR(2048),
    CONSTRAINT [PK_ProductImages] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[ProductPhantomLines] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [QuantityUsed] DECIMAL(16,8) NOT NULL,
    [PricePercentage] DECIMAL(4,1) NOT NULL,
    [ProductId] BIGINT NOT NULL,
    [PhantomProductId] BIGINT NOT NULL,
    [PhantomProductVariantGroupId] BIGINT,
    CONSTRAINT [PK_ProductPhantomLines] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Products] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [PublicId] NVARCHAR(1000) NOT NULL,
    [Code] NVARCHAR(50),
    [Name] NVARCHAR(150) NOT NULL,
    [SubHeader] NVARCHAR(100),
    [Description] NVARCHAR(max),
    [Width] DECIMAL(18,7),
    [Length] DECIMAL(18,7),
    [Height] DECIMAL(18,7),
    [Weight] DECIMAL(18,7),
    [VolumetricWeight] DECIMAL(18,7),
    [Gtin] NVARCHAR(15),
    [Mpn] NVARCHAR(50),
    [CustomerId] BIGINT NOT NULL,
    [CategoryId] BIGINT,
    [UnitTypeId] INT NOT NULL,
    [VatRateId] INT,
    [CurrencyId] INT NOT NULL,
    [PriceExclusiveVat] DECIMAL(20,8) NOT NULL,
    [StockAmount] DECIMAL(20,8),
    [ProductStatus] TINYINT NOT NULL,
    [ProductType] TINYINT NOT NULL,
    [CustomerBrandId] BIGINT,
    [InvoiceName] NVARCHAR(150),
    [Rack] NVARCHAR(50),
    [WarrantyMonths] TINYINT,
    [Tags] NVARCHAR(200),
    [CreatedOn] DATETIME NOT NULL CONSTRAINT [DF__Products__Create__5555A4F4] DEFAULT CURRENT_TIMESTAMP,
    [CriticalInventoryAmount] DECIMAL(20,8),
    [SoldCount] INT NOT NULL CONSTRAINT [DF__Products__SoldCo__5649C92D] DEFAULT 0,
    [MinSalePrice] DECIMAL(14,2),
    [MinSalePriceCurrencyId] INT,
    [VirtualStockAmount] DECIMAL(20,8),
    [Gtip] NVARCHAR(50),
    CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED ([Id]),
    CONSTRAINT [Products_PublicId_key] UNIQUE NONCLUSTERED ([PublicId])
);

-- CreateTable
CREATE TABLE [dbo].[ProductStockJobs] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [ProductId] BIGINT NOT NULL,
    CONSTRAINT [PK_ProductStockJobs] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[ProductTags] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [TagId] BIGINT NOT NULL,
    [ProductId] BIGINT NOT NULL,
    CONSTRAINT [PK_ProductTags] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[ProductVariantGroupImages] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [ProductVariantGroupId] BIGINT NOT NULL,
    [ProductImageId] BIGINT NOT NULL,
    [SortOrder] TINYINT NOT NULL,
    CONSTRAINT [PK_ProductVariantGroupImages] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[ProductVariantGroupPhantomLines] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [QuantityUsed] DECIMAL(16,8) NOT NULL,
    [PricePercentage] DECIMAL(4,1) NOT NULL,
    [ProductVariantGroupId] BIGINT NOT NULL,
    [PhantomProductId] BIGINT NOT NULL,
    [PhantomProductVariantGroupId] BIGINT,
    CONSTRAINT [PK_ProductVariantGroupPhantomLines] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[ProductVariantGroups] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [StockCode] NVARCHAR(50) NOT NULL,
    [StockAmount] DECIMAL(20,8) NOT NULL,
    [ProductId] BIGINT NOT NULL,
    [Gtin] NVARCHAR(15),
    [Mpn] NVARCHAR(50),
    [PriceExclusiveVat] DECIMAL(20,8) NOT NULL CONSTRAINT [DF__ProductVa__Price__573DED66] DEFAULT 0,
    [CriticalInventoryAmount] DECIMAL(20,8),
    [VirtualStockAmount] DECIMAL(20,8),
    CONSTRAINT [PK_ProductVariantGroups] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[ProductVariants] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [ProductVariantGroupId] BIGINT NOT NULL,
    [VariantName] NVARCHAR(100) NOT NULL,
    [VariantId] BIGINT,
    [VariantValue] NVARCHAR(120) NOT NULL,
    [VariantValueId] BIGINT,
    [SortOrder] TINYINT NOT NULL,
    CONSTRAINT [PK_ProductVariants] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[SendeoCities] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_SendeoCities] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[SendeoDistricts] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    [SendeoCityId] BIGINT,
    CONSTRAINT [PK_SendeoDistricts] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[ShipmentCompanies] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Name] NVARCHAR(100) NOT NULL,
    [TrackingUrlTemplate] NVARCHAR(250),
    [CompanyName] NVARCHAR(100),
    [TaxOffice] NVARCHAR(50),
    [TaxNumber] NVARCHAR(50),
    CONSTRAINT [PK_ShipmentCompanies] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[ShipmentLines] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Quantity] DECIMAL(20,8) NOT NULL,
    [UnitTypeId] INT NOT NULL,
    [ShipmentId] BIGINT NOT NULL,
    [OrderLineId] BIGINT NOT NULL,
    CONSTRAINT [PK_ShipmentLines] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[ShipmentOrders] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [OrderId] BIGINT NOT NULL,
    [ShipmentId] BIGINT NOT NULL,
    CONSTRAINT [PK_ShipmentOrders] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Shipments] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [ShipmentCode] NVARCHAR(50) NOT NULL,
    [ShipmentCompanyId] BIGINT NOT NULL,
    [ShipmentFeeAmount] DECIMAL(12,2) NOT NULL,
    [ShipmentDate] DATETIME NOT NULL,
    [CurrencyId] INT NOT NULL,
    [ShipmentType] TINYINT NOT NULL,
    [ShippingAddressId] BIGINT NOT NULL,
    [ShipmentPaymentType] TINYINT NOT NULL,
    [CustomerId] BIGINT NOT NULL,
    [ShipmentBarCode] NVARCHAR(120),
    [IsInternational] BIT NOT NULL CONSTRAINT [DF__Shipments__IsInt__5832119F] DEFAULT 0,
    [InternationalCargoCompanyName] NVARCHAR(50),
    [InternationalCargoCode] NVARCHAR(50),
    CONSTRAINT [PK_Shipments] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[ShippingAddresses] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [CustomerName] NVARCHAR(300) NOT NULL,
    [AdressLine] NVARCHAR(800) NOT NULL,
    [City] NVARCHAR(100) NOT NULL,
    [District] NVARCHAR(100),
    [Neighborhood] NVARCHAR(200),
    [ZipCode] NVARCHAR(15),
    [CustomerTaxNumber] NVARCHAR(20),
    [CustomerTaxOffice] NVARCHAR(50),
    [CustomerCitizenShipId] NVARCHAR(20),
    [CustomerGsm] NVARCHAR(15),
    [CustomerPhone] NVARCHAR(15),
    [CountryIso2] NVARCHAR(2) NOT NULL CONSTRAINT [DF__ShippingA__Count__592635D8] DEFAULT 'TR',
    CONSTRAINT [PK_ShippingAddresses] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[ShortMessagePackages] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Name] NVARCHAR(2000) NOT NULL,
    [PackagePrice] DECIMAL(12,2) NOT NULL,
    [Credit] DECIMAL(8,2) NOT NULL,
    CONSTRAINT [PK_ShortMessagePackages] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Tags] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Name] NVARCHAR(50) NOT NULL,
    [CustomerId] BIGINT NOT NULL,
    CONSTRAINT [PK_Tags] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[UnitTypes] (
    [Id] INT NOT NULL IDENTITY(1,1),
    [Code] NVARCHAR(10) NOT NULL,
    [Name] NVARCHAR(20) NOT NULL,
    CONSTRAINT [PK_UnitTypes] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[UpsAreas] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(200) NOT NULL,
    [UpsCityId] BIGINT NOT NULL,
    CONSTRAINT [PK_UpsAreas] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[UpsCities] (
    [Id] BIGINT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    CONSTRAINT [PK_UpsCities] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[Users] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [UserName] NVARCHAR(50) NOT NULL,
    [Password] NVARCHAR(500) NOT NULL,
    [Email] NVARCHAR(250) NOT NULL,
    [FirstName] NVARCHAR(100) NOT NULL,
    [LastName] NVARCHAR(100) NOT NULL,
    [BirthDate] DATETIME,
    [Active] BIT NOT NULL,
    [SecurityStamp] UNIQUEIDENTIFIER NOT NULL,
    [ResetPasswordToken] NVARCHAR(128),
    [ResetPasswordTokenExpiredAt] DATETIME,
    [ActivationToken] NVARCHAR(128),
    [ProfileImage] NVARCHAR(80),
    [LanguageId] BIGINT NOT NULL,
    [RefreshToken] NVARCHAR(500),
    [RefreshTokenExpireDate] DATETIME,
    CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED ([Id]),
    CONSTRAINT [UNQ_Users_UserName] UNIQUE NONCLUSTERED ([UserName]),
    CONSTRAINT [UNQ_Users_Email] UNIQUE NONCLUSTERED ([Email])
);

-- CreateTable
CREATE TABLE [dbo].[Variants] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Name] NVARCHAR(100) NOT NULL,
    [VariantType] NVARCHAR(20) NOT NULL,
    [CustomerId] BIGINT,
    CONSTRAINT [PK_Variants] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[VariantValues] (
    [Id] BIGINT NOT NULL IDENTITY(1,1),
    [Value] NVARCHAR(120) NOT NULL,
    [VariantId] BIGINT NOT NULL,
    [CustomerId] BIGINT NOT NULL,
    CONSTRAINT [PK_VariantValues] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateTable
CREATE TABLE [dbo].[VatRates] (
    [Id] INT NOT NULL IDENTITY(1,1),
    [Name] NVARCHAR(20) NOT NULL,
    [Rate] DECIMAL(4,2) NOT NULL,
    CONSTRAINT [PK_VatRates] PRIMARY KEY CLUSTERED ([Id])
);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_AuthActionForCustomerDescriptionAuthActionForCustomer] ON [dbo].[AuthActionForCustomerDescriptions]([AuthActionForCustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_AuthActionForCustomerDescriptionLanguage] ON [dbo].[AuthActionForCustomerDescriptions]([LanguageId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_AuthActionForUserDescriptionAuthActionForUser] ON [dbo].[AuthActionForUserDescriptions]([AuthActionForUserId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_AuthActionForUserDescriptionLanguage] ON [dbo].[AuthActionForUserDescriptions]([LanguageId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_BulkOperationLines_BulkOperationId_Status] ON [dbo].[BulkOperationLines]([BulkOperationId], [Status]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_BulkOperationLines_ProductId_Status] ON [dbo].[BulkOperationLines]([ProductId], [Status]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_BulkOperations_CustomerId] ON [dbo].[BulkOperations]([CustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_BulkOperations_OperationType_OperationSourceType_CustomerId_CreatedDate_ParamValue_Status] ON [dbo].[BulkOperations]([OperationType], [OperationSourceType], [CustomerId], [CreatedDate], [ParamValue], [Status]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CampaignCampaignCustomers] ON [dbo].[CampaignCustomers]([CampaignId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerCampaignCustomers] ON [dbo].[CampaignCustomers]([CustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_PackagesCampaignCustomers] ON [dbo].[CampaignCustomers]([PackagesId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerRepresentativeCampaign] ON [dbo].[Campaigns]([CustomerRepresentativeId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Categories_CustomerId] ON [dbo].[Categories]([CustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Categories_Deepest_CustomerId] ON [dbo].[Categories]([Deepest], [CustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Categories_ParentId_CustomerId] ON [dbo].[Categories]([ParentId], [CustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CategoryCategory] ON [dbo].[Categories]([ParentId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_ClaimItemReasons_ClaimItemId] ON [dbo].[ClaimItemReasons]([ClaimItemId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_ClaimItemClaim] ON [dbo].[ClaimItems]([ClaimId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_ClaimItemProduct] ON [dbo].[ClaimItems]([ProductId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_ClaimItemProductVariantGroup] ON [dbo].[ClaimItems]([ProductVariantGroupId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_OrderLineId] ON [dbo].[ClaimItems]([OrderLineId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Claims_CustomerId_ClaimDate] ON [dbo].[Claims]([CustomerId], [ClaimDate]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Claims_EntegreClaimNumber_IntegratedECommerceCode_CustomerId_CustomerECommerceKeyId_ClaimStatus] ON [dbo].[Claims]([EntegreClaimNumber], [IntegratedECommerceCode], [CustomerId], [CustomerECommerceKeyId], [ClaimStatus]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Claims_IntegratedECommerceCode_CustomerId_CustomerECommerceKeyId_EntegreClaimId_ClaimDate] ON [dbo].[Claims]([IntegratedECommerceCode], [CustomerId], [CustomerECommerceKeyId], [EntegreClaimId], [ClaimDate]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Claims_IntegratedECommerceCode_CustomerId_CustomerECommerceKeyId_EntegreClaimId_ClaimStatus] ON [dbo].[Claims]([IntegratedECommerceCode], [CustomerId], [CustomerECommerceKeyId], [EntegreClaimId], [ClaimStatus]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Claims_IntegratedECommerceCode_CustomerId_CustomerECommerceKeyId_EntegreClaimNumber_ClaimDate] ON [dbo].[Claims]([IntegratedECommerceCode], [CustomerId], [CustomerECommerceKeyId], [EntegreClaimNumber], [ClaimDate]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_ClaimCustomer] ON [dbo].[Claims]([CustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerConnectedUser] ON [dbo].[ConnectedUsers]([CustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_UserConnectedUser] ON [dbo].[ConnectedUsers]([UserId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CouponAllowedPackageCoupon] ON [dbo].[CouponAllowedPackages]([CouponId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CouponAllowedPackagePackages] ON [dbo].[CouponAllowedPackages]([PackagesId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CouponCustomerAuthActionAuthActionForCustomer] ON [dbo].[CouponCustomerAuthActions]([AuthActionForCustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CouponCustomerAuthActionCoupon] ON [dbo].[CouponCustomerAuthActions]([CouponId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CouponGiftPackageCoupon] ON [dbo].[CouponGiftPackages]([CouponId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CouponGiftPackagePackages] ON [dbo].[CouponGiftPackages]([PackagesId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CouponPackageExtraCoupon] ON [dbo].[CouponPackageExtras]([CouponId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CouponUsageCoupon] ON [dbo].[CouponUsages]([CouponId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CouponUsageCustomer] ON [dbo].[CouponUsages]([CustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CouponUsageCustomerSubscription] ON [dbo].[CouponUsages]([CustomerSubscriptionId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_AuthActionForCustomerCustomerAuthActionForCustomer] ON [dbo].[CustomerAuthActionForCustomers]([AuthActionForCustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerCustomerAuthActionForCustomer] ON [dbo].[CustomerAuthActionForCustomers]([CustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_CustomerBrands_CustomerId] ON [dbo].[CustomerBrands]([CustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_CustomerCreditTransactions_CustomerId_TransactionDate] ON [dbo].[CustomerCreditTransactions]([CustomerId], [TransactionDate]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_CustomerCreditTransactions_CustomerId_TransactionType_ReferenceNumber] ON [dbo].[CustomerCreditTransactions]([CustomerId], [TransactionType], [ReferenceNumber]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerECommerceKeyId] ON [dbo].[CustomerCreditTransactions]([CustomerECommerceKeyId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_OrderId] ON [dbo].[CustomerCreditTransactions]([OrderId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerDefaultCargoSettingCustomerECommerceKey] ON [dbo].[CustomerDefaultCargoSettings]([CustomerECommerceKeyId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerECommerceKeyCustomerECommerceDefaultSetting] ON [dbo].[CustomerECommerceDefaultSettings]([CustomerECommerceKeyId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_Allegro_CustomerDefaultSettingCustomerECommerceDefaultSetting] ON [dbo].[CustomerECommerceDefaultSettings]([Entegre_Allegro_CustomerDefaultSettingId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_Ebay_CustomerDefaultSettingCustomerECommerceDefaultSetting] ON [dbo].[CustomerECommerceDefaultSettings]([Entegre_Ebay_CustomerDefaultSettingId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_N11Pro_CustomerDefaultSettingCustomerECommerceDefaultSetting] ON [dbo].[CustomerECommerceDefaultSettings]([Entegre_N11Pro_CustomerDefaultSettingId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerECommerceKeyPriceFormulaCustomer] ON [dbo].[CustomerECommerceKeyPriceFormulas]([CustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerECommerceKeyPriceFormulaCustomerECommerceKey] ON [dbo].[CustomerECommerceKeyPriceFormulas]([CustomerECommerceKeyId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_CustomerECommerceKeys_Active] ON [dbo].[CustomerECommerceKeys]([Active]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_CustomerECommerceKeys_Active_IntegratedECommerceCode] ON [dbo].[CustomerECommerceKeys]([Active], [IntegratedECommerceCode]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_CustomerECommerceKeys_CustomerId] ON [dbo].[CustomerECommerceKeys]([CustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerECommerceKeyUser] ON [dbo].[CustomerECommerceKeys]([AutoAssignOrderPackageUserId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_IntegratedECommerceCustomerECommerceKey] ON [dbo].[CustomerECommerceKeys]([IntegratedECommerceCode]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerECommerceMessageTemplateCustomer] ON [dbo].[CustomerECommerceMessageTemplates]([CustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_CustomerECommerceProductInsertLogs_CustomerId_InsertDate] ON [dbo].[CustomerECommerceProductInsertLogs]([CustomerId], [InsertDate]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerErpCustomer] ON [dbo].[CustomerErps]([CustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerInvoiceInformationCustomerECommerceKey] ON [dbo].[CustomerInvoiceInformations]([CustomerECommerceKeyId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_CustomerNotifications_CustomerId_NotificationDate] ON [dbo].[CustomerNotifications]([CustomerId], [NotificationDate]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerCustomerNotificationSettings] ON [dbo].[CustomerNotificationSettings]([CustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerOrderColorTagCustomer] ON [dbo].[CustomerOrderColorTags]([CustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_CustomerPosPayments_PaymentResult_PaymentDate] ON [dbo].[CustomerPosPayments]([PaymentResult], [PaymentDate]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_CustomerPosPayments_TransactionId] ON [dbo].[CustomerPosPayments]([TransactionId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerReportCustomer] ON [dbo].[CustomerReports]([CustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerCustomerReportTemplate] ON [dbo].[CustomerReportTemplates]([CustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerRepresentativeCustomerUser] ON [dbo].[CustomerRepresentatives]([CustomerUserId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Customers_Active_LastActivity] ON [dbo].[Customers]([Active], [LastActivity]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Customers_CustomerRepresentativeId_IsMainCompany] ON [dbo].[Customers]([CustomerRepresentativeId], [IsMainCompany]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Customers_IsMainCompany] ON [dbo].[Customers]([IsMainCompany]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Customers_ReferenceCode] ON [dbo].[Customers]([ReferenceCode]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerCountry] ON [dbo].[Customers]([CountryIso2]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerCustomer] ON [dbo].[Customers]([ReferenceCustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerRepresentativeCustomer] ON [dbo].[Customers]([CustomerRepresentativeId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_VatRateCustomerSetting] ON [dbo].[CustomerSettings]([VatRateId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerShipmentPriceForOrderAmountCurrency] ON [dbo].[CustomerShipmentPriceForOrderAmounts]([ShipmentPriceCurrencyId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerShipmentPriceForOrderAmountCurrency1] ON [dbo].[CustomerShipmentPriceForOrderAmounts]([OrderAmountCurrencyId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerShipmentPricePerECommerceKeyCustomer] ON [dbo].[CustomerShipmentPriceForOrderAmounts]([CustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerShipmentPricePerECommerceKeyCustomerECommerceKey] ON [dbo].[CustomerShipmentPriceForOrderAmounts]([CustomerECommerceKeyId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_CustomerShipmentPrices_CustomerId_VolumetricWeight] ON [dbo].[CustomerShipmentPrices]([CustomerId], [VolumetricWeight]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerShipmentPriceCurrency] ON [dbo].[CustomerShipmentPrices]([DomesticCurrencyId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerShipmentPriceCurrencyInternational] ON [dbo].[CustomerShipmentPrices]([InternationalCurrencyId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerShipmentPriceCustomer] ON [dbo].[CustomerShipmentPrices]([CustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_CustomerSMSTransactions_CustomerId] ON [dbo].[CustomerSMSTransactions]([CustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_CustomerSubscriptionCustomerAuths_AuthActionForCustomerId] ON [dbo].[CustomerSubscriptionCustomerAuths]([AuthActionForCustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerSubscriptionCustomerSubscriptionCustomerAuth] ON [dbo].[CustomerSubscriptionCustomerAuths]([CustomerSubscriptionId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_CustomerSubscriptions_CustomerId_StartDate_EndDate] ON [dbo].[CustomerSubscriptions]([CustomerId], [StartDate], [EndDate]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_CustomerSubscriptions_PackageName_StartDate] ON [dbo].[CustomerSubscriptions]([PackageName], [StartDate]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_CustomerSubscriptions_PackagesId_StartDate_EndDate] ON [dbo].[CustomerSubscriptions]([PackagesId], [StartDate], [EndDate]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_CustomerSubscriptions_StartDate_EndDate] ON [dbo].[CustomerSubscriptions]([StartDate], [EndDate]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_CustomerSubscriptions_StartDate_EndDate_SubscriptionType] ON [dbo].[CustomerSubscriptions]([StartDate], [EndDate], [SubscriptionType]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_CustomerSubscriptions_SubscriptionType] ON [dbo].[CustomerSubscriptions]([SubscriptionType]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_CustomerSubscriptions_SubscriptionType_StartDate_EndDate] ON [dbo].[CustomerSubscriptions]([SubscriptionType], [StartDate], [EndDate]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerCustomerSubscription] ON [dbo].[CustomerSubscriptions]([CustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_CustomerUserAuthActionForUsers_CustomerUserId] ON [dbo].[CustomerUserAuthActionForUsers]([CustomerUserId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerUserCustomerUserNotificationType] ON [dbo].[CustomerUserNotificationTypes]([CustomerUserId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerCustomerUser] ON [dbo].[CustomerUsers]([CustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_UserCustomerUser] ON [dbo].[CustomerUsers]([UserId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerDescriptionTemplate] ON [dbo].[DescriptionTemplates]([CustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CityDistrict] ON [dbo].[Districts]([CityId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_ECommerceMessagesECommerceKeyCustomerECommerceKey] ON [dbo].[ECommerceMessagesECommerceKeys]([CustomerECommerceKeyId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_ECommerceMessagesECommerceKeyCustomerECommerceMessageTemplate] ON [dbo].[ECommerceMessagesECommerceKeys]([CustomerECommerceMessageTemplateId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_ECommerceProductBatches_BatchId_Entegre_ProductECommerceId] ON [dbo].[ECommerceProductBatches]([BatchId], [Entegre_ProductECommerceId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_ECommerceProductBatches_CustomerId] ON [dbo].[ECommerceProductBatches]([CustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_ECommerceProductBatches_CustomerId_ResultType_IntegratedECommerceCode] ON [dbo].[ECommerceProductBatches]([CustomerId], [ResultType], [IntegratedECommerceCode]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_ECommerceProductBatches_ResultType] ON [dbo].[ECommerceProductBatches]([ResultType]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerECommerceKeyId] ON [dbo].[ECommerceProductBatches]([CustomerECommerceKeyId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_ECommerceProductBatchDataECommerceProductBatch] ON [dbo].[ECommerceProductBatches]([BatchId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_ECommerceSynchronizations_SynchronizationType_IntegratedECommerceCode_CustomerId] ON [dbo].[ECommerceSynchronizations]([SynchronizationType], [IntegratedECommerceCode], [CustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_eInvoices_CustomerECommerceKeyId_SendDate] ON [dbo].[eInvoices]([CustomerECommerceKeyId], [SendDate]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_EInvoiceUsers_TaxNumber] ON [dbo].[EInvoiceUsers]([TaxNumber]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_AE_AttributeAttributeValues_Entegre_AE_AttributeId_Entegre_AE_AttributeValueId] ON [dbo].[Entegre_AE_AttributeAttributeValues]([Entegre_AE_AttributeId], [Entegre_AE_AttributeValueId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_AE_AttributeAttributeValues_Entegre_AE_AttributeId_Entegre_AE_CategoryId] ON [dbo].[Entegre_AE_AttributeAttributeValues]([Entegre_AE_AttributeId], [Entegre_AE_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_AE_AttributeValues_AttributeValue] ON [dbo].[Entegre_AE_AttributeValues]([AttributeValue]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_AE_Categories_ParentId] ON [dbo].[Entegre_AE_Categories]([ParentId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_AE_CategoryAttributes_CategoryId_AttributeId] ON [dbo].[Entegre_AE_CategoryAttributes]([Entegre_AE_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_Allegro_AttributeEntegre_Allegro_AttributeAttributeValue] ON [dbo].[Entegre_Allegro_AttributeAttributeValues]([Entegre_Allegro_AttributeId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_Allegro_AttributeValueEntegre_Allegro_AttributeAttributeValue] ON [dbo].[Entegre_Allegro_AttributeAttributeValues]([Entegre_Allegro_AttributeValueId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_Allegro_CategoryEntegre_Allegro_AttributeAttributeValue] ON [dbo].[Entegre_Allegro_AttributeAttributeValues]([Entegre_Allegro_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_Allegro_AttributeEntegre_Allegro_CategoryAttribute] ON [dbo].[Entegre_Allegro_CategoryAttributes]([Entegre_Allegro_AttributeId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_Allegro_CategoryEntegre_Allegro_CategoryAttribute] ON [dbo].[Entegre_Allegro_CategoryAttributes]([Entegre_Allegro_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_BD_AttributeValueEntegre_BD_Attribute] ON [dbo].[Entegre_BD_AttributeValues]([Entegre_BD_AttributeId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_BD_CategoryAttributeEntegre_BD_Attribute] ON [dbo].[Entegre_BD_CategoryAttributes]([Entegre_BD_AttributeId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_BD_CategoryAttributeEntegre_BD_Category] ON [dbo].[Entegre_BD_CategoryAttributes]([Entegre_BD_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_CS_AttributeAttributeValues_Entegre_CS_AttributeId] ON [dbo].[Entegre_CS_AttributeAttributeValues]([Entegre_CS_AttributeId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_CS_AttributeEntegre_CS_AttributeAttributeValue] ON [dbo].[Entegre_CS_AttributeAttributeValues]([Entegre_CS_AttributeId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_CS_AttributeValueEntegre_CS_AttributeAttributeValue] ON [dbo].[Entegre_CS_AttributeAttributeValues]([Entegre_CS_AttributeValueId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_CS_AttributeValues_Name] ON [dbo].[Entegre_CS_AttributeValues]([Name]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_CS_Categories_Name] ON [dbo].[Entegre_CS_Categories]([Name]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_CS_Categories_ParentId] ON [dbo].[Entegre_CS_Categories]([ParentId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_CS_CategoryAttributeEntegre_CS_Attribute] ON [dbo].[Entegre_CS_CategoryAttributes]([Entegre_CS_AttributeId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_CS_CategoryAttributeEntegre_CS_Category] ON [dbo].[Entegre_CS_CategoryAttributes]([Entegre_CS_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_CS_QuestionCustomer] ON [dbo].[Entegre_CS_Questions]([CustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_CS_QuestionCustomerECommerceKey] ON [dbo].[Entegre_CS_Questions]([CustomerECommerceKeyId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_Ebay_AttributeAttributeValueEntegre_Ebay_Attribute] ON [dbo].[Entegre_Ebay_AttributeAttributeValues]([Entegre_Ebay_AttributeId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_Ebay_AttributeAttributeValueEntegre_Ebay_AttributeValue] ON [dbo].[Entegre_Ebay_AttributeAttributeValues]([Entegre_Ebay_AttributeValueId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_Ebay_AttributeAttributeValueEntegre_Ebay_Category] ON [dbo].[Entegre_Ebay_AttributeAttributeValues]([Entegre_Ebay_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_Ebay_AttributeValues_Name] ON [dbo].[Entegre_Ebay_AttributeValues]([Name]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_Ebay_CategoryAttributeEntegre_Ebay_Attribute] ON [dbo].[Entegre_Ebay_CategoryAttributes]([Entegre_Ebay_AttributeId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_Ebay_CategoryAttributeEntegre_Ebay_Category] ON [dbo].[Entegre_Ebay_CategoryAttributes]([Entegre_Ebay_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_EPttAvm_Categories_ParentId] ON [dbo].[Entegre_EPttAvm_Categories]([ParentId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_Etsy_AttributeAttributeScaleEntegre_Etsy_Attribute] ON [dbo].[Entegre_Etsy_AttributeAttributeScales]([Entegre_Etsy_AttributeId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_Etsy_AttributeAttributeScaleEntegre_Etsy_AttributeScale] ON [dbo].[Entegre_Etsy_AttributeAttributeScales]([Entegre_Etsy_AttributeScaleId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_Etsy_AttributeAttributeValues_Entegre_Etsy_AttributeId_Entegre_Etsy_AttributeValueId_Entegre_Etsy_CategoryId] ON [dbo].[Entegre_Etsy_AttributeAttributeValues]([Entegre_Etsy_AttributeId], [Entegre_Etsy_AttributeValueId], [Entegre_Etsy_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_Etsy_AttributeAttributeValues_Entegre_Etsy_AttributeId_Entegre_Etsy_CategoryId] ON [dbo].[Entegre_Etsy_AttributeAttributeValues]([Entegre_Etsy_AttributeId], [Entegre_Etsy_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_Etsy_AttributeAttributeValueEntegre_Etsy_Attribute] ON [dbo].[Entegre_Etsy_AttributeAttributeValues]([Entegre_Etsy_AttributeId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_Etsy_CategoryEntegre_Etsy_Category] ON [dbo].[Entegre_Etsy_Categories]([ParentId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_Etsy_CategoryAttributeEntegre_Etsy_Attribute] ON [dbo].[Entegre_Etsy_CategoryAttributes]([Entegre_Etsy_AttributeId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_Etsy_CategoryAttributeEntegre_Etsy_Category] ON [dbo].[Entegre_Etsy_CategoryAttributes]([Entegre_Etsy_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_Flo_AttributeAttributeValues_Entegre_Flo_AttributeId_Entegre_Flo_CategoryId] ON [dbo].[Entegre_Flo_AttributeAttributeValues]([Entegre_Flo_AttributeId], [Entegre_Flo_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_Flo_AttributeEntegre_Flo_AttributeAttributeValue] ON [dbo].[Entegre_Flo_AttributeAttributeValues]([Entegre_Flo_AttributeId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_Flo_AttributeValueEntegre_Flo_AttributeAttributeValue] ON [dbo].[Entegre_Flo_AttributeAttributeValues]([Entegre_Flo_AttributeValueId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_Flo_AttributeEntegre_Flo_CategoryAttribute] ON [dbo].[Entegre_Flo_CategoryAttributes]([Entegre_Flo_AttributeId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_Flo_CategoryAttributeEntegre_Flo_Category] ON [dbo].[Entegre_Flo_CategoryAttributes]([Entegre_Flo_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_Fruugo_CategoryEntegre_Fruugo_Category] ON [dbo].[Entegre_Fruugo_Categories]([ParentId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_GG_CategorySpecs_CategoryCode_SpecId] ON [dbo].[Entegre_GG_CategorySpecs]([Entegre_GG_CategoryCode]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_GG_CategoryEntegre_GG_CategoryVariant] ON [dbo].[Entegre_GG_CategoryVariants]([Entegre_GG_CategoryCode]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_GG_VariantEntegre_GG_CategoryVariant] ON [dbo].[Entegre_GG_CategoryVariants]([Entegre_GG_VariantId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_GG_Messages_CustomerId_CustomerECommerceKeyId_ConversationId] ON [dbo].[Entegre_GG_Messages]([CustomerId], [CustomerECommerceKeyId], [ConversationId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_GG_Messages_MessageId] ON [dbo].[Entegre_GG_Messages]([MessageId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_GG_Messages_MessageType_CustomerId_IsRead] ON [dbo].[Entegre_GG_Messages]([MessageType], [CustomerId], [IsRead]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_GG_SpecSpecValues_Entegre_GG_SpecId_Entegre_GG_SpecValueId] ON [dbo].[Entegre_GG_SpecSpecValues]([Entegre_GG_SpecId], [Entegre_GG_SpecValueId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_GG_SpecSpecValues_SpecId_SpecValueId] ON [dbo].[Entegre_GG_SpecSpecValues]([Entegre_GG_SpecId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_GG_VariantValues_VariantValue] ON [dbo].[Entegre_GG_VariantValues]([VariantValue]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_GG_VariantVariantValues_VariantId_VariantValueId] ON [dbo].[Entegre_GG_VariantVariantValues]([Entegre_GG_VariantId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_Google_CategoryEntegre_Google_Category] ON [dbo].[Entegre_Google_Categories]([ParentId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_HB_AttributeEntegre_HB_AttributeAttributeValue] ON [dbo].[Entegre_HB_AttributeAttributeValues]([Entegre_HB_AttributeId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_HB_CategoryEntegre_HB_Category] ON [dbo].[Entegre_HB_Categories]([ParentId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_HB_CategoryAttributes_CategoryId_AttributeId] ON [dbo].[Entegre_HB_CategoryAttributes]([Entegre_HB_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_HB_CategoryVariants_CategoryId_VariantId] ON [dbo].[Entegre_HB_CategoryVariants]([Entegre_HB_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_HB_Question_ConversationEntegre_HB_Question] ON [dbo].[Entegre_HB_Question_Conversations]([Entegre_HB_QuestionId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_HB_Questions_CustomerId_CustomerECommerceKeyId_IssueNumber] ON [dbo].[Entegre_HB_Questions]([CustomerId], [CustomerECommerceKeyId], [IssueNumber]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_HB_Questions_Status_CustomerId] ON [dbo].[Entegre_HB_Questions]([Status], [CustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_HB_QuestionCustomer] ON [dbo].[Entegre_HB_Questions]([CustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_HB_QuestionCustomerECommerceKey] ON [dbo].[Entegre_HB_Questions]([CustomerECommerceKeyId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_HB_VariantEntegre_HB_VariantVariantValue] ON [dbo].[Entegre_HB_VariantVariantValues]([Entegre_HB_VariantId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_HB_VariantValueEntegre_HB_VariantVariantValue] ON [dbo].[Entegre_HB_VariantVariantValues]([Entegre_HB_VariantValueId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_HG_CategoryEntegre_HG_Category] ON [dbo].[Entegre_HG_Categories]([ParentId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_HG_AttributeEntegre_HG_CategoryAttribute] ON [dbo].[Entegre_HG_CategoryAttributes]([Entegre_HG_AttributeId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_HG_CategoryEntegre_HG_CategoryAttribute] ON [dbo].[Entegre_HG_CategoryAttributes]([Entegre_HG_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_IC_AttributeAttributeValues_Entegre_IC_AttributeId] ON [dbo].[Entegre_IC_AttributeAttributeValues]([Entegre_IC_AttributeId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_IC_AttributeAttributeValues_Entegre_IC_AttributeId_Entegre_IC_AttributeValueId] ON [dbo].[Entegre_IC_AttributeAttributeValues]([Entegre_IC_AttributeId], [Entegre_IC_AttributeValueId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_IC_BrandEntegre_IC_BrandBrandModels] ON [dbo].[Entegre_IC_BrandBrandModels]([Entegre_IC_BrandId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_IC_BrandModelEntegre_IC_BrandBrandModels] ON [dbo].[Entegre_IC_BrandBrandModels]([Entegre_IC_BrandModelId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_IC_AttributeEntegre_IC_CategoryAttribute] ON [dbo].[Entegre_IC_CategoryAttributes]([Entegre_IC_AttributeId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_IC_CategoryEntegre_IC_CategoryAttribute] ON [dbo].[Entegre_IC_CategoryAttributes]([Entegre_IC_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_IC_BrandEntegre_IC_CategoryBrand] ON [dbo].[Entegre_IC_CategoryBrands]([Entegre_IC_BrandId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_IC_CategoryEntegre_IC_CategoryBrand] ON [dbo].[Entegre_IC_CategoryBrands]([Entegre_IC_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_Idefix_AttributeEntegre_Idefix_AttributeAttributeValue] ON [dbo].[Entegre_Idefix_AttributeAttributeValues]([Entegre_Idefix_AttributeId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_Idefix_AttributeValueEntegre_Idefix_AttributeAttributeValue] ON [dbo].[Entegre_Idefix_AttributeAttributeValues]([Entegre_Idefix_AttributeValueId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_Idefix_CategoryEntegre_Idefix_AttributeAttributeValue] ON [dbo].[Entegre_Idefix_AttributeAttributeValues]([Entegre_Idefix_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_Idefix_CategoryEntegre_Idefix_Category] ON [dbo].[Entegre_Idefix_Categories]([ParentId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_Idefix_AttributeEntegre_Idefix_CategoryAttribute] ON [dbo].[Entegre_Idefix_CategoryAttributes]([Entegre_Idefix_AttributeId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_Idefix_CategoryEntegre_Idefix_CategoryAttribute] ON [dbo].[Entegre_Idefix_CategoryAttributes]([Entegre_Idefix_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_Joom_Categories_ParentId] ON [dbo].[Entegre_Joom_Categories]([ParentId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_LB_AttributeAttributeValueEntegre_LB_Attribute] ON [dbo].[Entegre_LB_AttributeAttributeValues]([Entegre_LB_AttributeId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_LB_CategoryAttributes_Entegre_LB_CategoryId] ON [dbo].[Entegre_LB_CategoryAttributes]([Entegre_LB_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_LB_CategoryAttributeEntegre_LB_Attribute] ON [dbo].[Entegre_LB_CategoryAttributes]([Entegre_LB_AttributeId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_MoNi_AttributeAttributeValues_Entegre_MoNi_AttributeId_Entegre_MoNi_CategoryId] ON [dbo].[Entegre_MoNi_AttributeAttributeValues]([Entegre_MoNi_AttributeId], [Entegre_MoNi_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_MoNi_AttributeEntegre_MoNi_AttributeAttributeValue] ON [dbo].[Entegre_MoNi_AttributeAttributeValues]([Entegre_MoNi_AttributeId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_MoNi_AttributeValueEntegre_MoNi_AttributeAttributeValue] ON [dbo].[Entegre_MoNi_AttributeAttributeValues]([Entegre_MoNi_AttributeValueId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_MoNi_CategoryEntegre_MoNi_AttributeAttributeValue] ON [dbo].[Entegre_MoNi_AttributeAttributeValues]([Entegre_MoNi_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_MoNi_AttributeEntegre_MoNi_CategoryAttribute] ON [dbo].[Entegre_MoNi_CategoryAttributes]([Entegre_MoNi_AttributeId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_MoNi_CategoryEntegre_MoNi_CategoryAttribute] ON [dbo].[Entegre_MoNi_CategoryAttributes]([Entegre_MoNi_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_MoNi_CategoryEntegre_MoNi_CategoryVariant] ON [dbo].[Entegre_MoNi_CategoryVariants]([Entegre_MoNi_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_MoNi_VariantEntegre_MoNi_CategoryVariant] ON [dbo].[Entegre_MoNi_CategoryVariants]([Entegre_MoNi_VariantId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_MoNi_VariantVariantValues_Entegre_MoNi_VariantId_Entegre_MoNi_CategoryId] ON [dbo].[Entegre_MoNi_VariantVariantValues]([Entegre_MoNi_VariantId], [Entegre_MoNi_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_MoNi_CategoryEntegre_MoNi_VariantVariantValue] ON [dbo].[Entegre_MoNi_VariantVariantValues]([Entegre_MoNi_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_MoNi_VariantEntegre_MoNi_VariantVariantValue] ON [dbo].[Entegre_MoNi_VariantVariantValues]([Entegre_MoNi_VariantId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_MoNi_VariantValueEntegre_MoNi_VariantVariantValue] ON [dbo].[Entegre_MoNi_VariantVariantValues]([Entegre_MoNi_VariantValueId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_N11_AttributeValues_AttributeValue] ON [dbo].[Entegre_N11_AttributeValues]([AttributeValue]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_N11_AttributeValues_Entegre_N11_AttributeId] ON [dbo].[Entegre_N11_AttributeValues]([Entegre_N11_AttributeId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_N11_Categories_Name] ON [dbo].[Entegre_N11_Categories]([Name]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_N11_Categories_ParentId] ON [dbo].[Entegre_N11_Categories]([ParentId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_N11_AttributeEntegre_N11_CategoryAttribute] ON [dbo].[Entegre_N11_CategoryAttributes]([Entegre_N11_AttributeId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_N11_CategoryEntegre_N11_CategoryAttribute] ON [dbo].[Entegre_N11_CategoryAttributes]([Entegre_N11_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_N11_Questions_AnswerDate_CustomerId_CustomerECommerceKeyId] ON [dbo].[Entegre_N11_Questions]([AnswerDate], [CustomerId], [CustomerECommerceKeyId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_N11_Questions_CustomerECommerceKeyId] ON [dbo].[Entegre_N11_Questions]([CustomerECommerceKeyId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_N11_Questions_CustomerId] ON [dbo].[Entegre_N11_Questions]([CustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_N11_Questions_EntegreProductId_CustomerId] ON [dbo].[Entegre_N11_Questions]([EntegreProductId], [CustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_N11_Questions_QuestionId_CustomerId_CustomerECommerceKeyId] ON [dbo].[Entegre_N11_Questions]([QuestionId], [CustomerId], [CustomerECommerceKeyId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_ProductECommerceEntegre_N11_Question] ON [dbo].[Entegre_N11_Questions]([Entegre_ProductECommerceId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_N11Pro_AttributeEntegre_N11Pro_CategoryAttribute] ON [dbo].[Entegre_N11Pro_CategoryAttributes]([Entegre_N11Pro_AttributeId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_N11Pro_CategoryEntegre_N11Pro_CategoryAttribute] ON [dbo].[Entegre_N11Pro_CategoryAttributes]([Entegre_N11Pro_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_OnBuy_AttributeEntegre_OnBuy_AttributeAttributeValue] ON [dbo].[Entegre_OnBuy_AttributeAttributeValues]([Entegre_OnBuy_AttributeId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_OnBuy_AttributeValueEntegre_OnBuy_AttributeAttributeValue] ON [dbo].[Entegre_OnBuy_AttributeAttributeValues]([Entegre_OnBuy_AttributeValueId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_OnBuy_CategoryEntegre_OnBuy_AttributeAttributeValue] ON [dbo].[Entegre_OnBuy_AttributeAttributeValues]([Entegre_OnBuy_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_OnBuy_CategoryEntegre_OnBuy_Category] ON [dbo].[Entegre_OnBuy_Categories]([ParentId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_OnBuy_AttributeEntegre_OnBuy_CategoryAttribute] ON [dbo].[Entegre_OnBuy_CategoryAttributes]([Entegre_OnBuy_AttributeId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_OnBuy_CategoryEntegre_OnBuy_CategoryAttribute] ON [dbo].[Entegre_OnBuy_CategoryAttributes]([Entegre_OnBuy_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_OnBuy_CategoryEntegre_OnBuy_CategoryVariant] ON [dbo].[Entegre_OnBuy_CategoryVariants]([Entegre_OnBuy_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_OnBuy_VariantEntegre_OnBuy_CategoryVariant] ON [dbo].[Entegre_OnBuy_CategoryVariants]([Entegre_OnBuy_VariantId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_OnBuy_CategoryEntegre_OnBuy_VariantVariantValue] ON [dbo].[Entegre_OnBuy_VariantVariantValues]([Entegre_OnBuy_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_OnBuy_VariantEntegre_OnBuy_VariantVariantValue] ON [dbo].[Entegre_OnBuy_VariantVariantValues]([Entegre_OnBuy_VariantId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_OnBuy_VariantValueEntegre_OnBuy_VariantVariantValue] ON [dbo].[Entegre_OnBuy_VariantVariantValues]([Entegre_OnBuy_VariantValueId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_Ozon_AttributeEntegre_Ozon_AttributeAttributeValue] ON [dbo].[Entegre_Ozon_AttributeAttributeValues]([Entegre_Ozon_AttributeId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_Ozon_AttributeValueEntegre_Ozon_AttributeAttributeValue] ON [dbo].[Entegre_Ozon_AttributeAttributeValues]([Entegre_Ozon_AttributeValueId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_Ozon_CategoryEntegre_Ozon_AttributeAttributeValue] ON [dbo].[Entegre_Ozon_AttributeAttributeValues]([Entegre_Ozon_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_Ozon_Categories_ParentId] ON [dbo].[Entegre_Ozon_Categories]([ParentId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_Ozon_AttributeEntegre_Ozon_CategoryAttribute] ON [dbo].[Entegre_Ozon_CategoryAttributes]([Entegre_Ozon_AttributeId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_Ozon_CategoryEntegre_Ozon_CategoryAttribute] ON [dbo].[Entegre_Ozon_CategoryAttributes]([Entegre_Ozon_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_Ozon_Messages_MessageId_CustomerId_CustomerECommerceKeyId] ON [dbo].[Entegre_Ozon_Messages]([MessageId], [CustomerId], [CustomerECommerceKeyId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_Ozon_Messages_MessageType_CustomerId_IsRead] ON [dbo].[Entegre_Ozon_Messages]([MessageType], [CustomerId], [IsRead]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerECommerceKeyEntegre_Ozon_Message] ON [dbo].[Entegre_Ozon_Messages]([CustomerECommerceKeyId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerEntegre_Ozon_Message] ON [dbo].[Entegre_Ozon_Messages]([CustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_Pazarama_AttributeAttributeValues_Entegre_Pazarama_CategoryId_Entegre_Pazarama_AttributeId] ON [dbo].[Entegre_Pazarama_AttributeAttributeValues]([Entegre_Pazarama_CategoryId], [Entegre_Pazarama_AttributeId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_Pazarama_AttributeAttributeValueEntegre_Pazarama_Attribute] ON [dbo].[Entegre_Pazarama_AttributeAttributeValues]([Entegre_Pazarama_AttributeId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_Pazarama_AttributeAttributeValueEntegre_Pazarama_AttributeValue] ON [dbo].[Entegre_Pazarama_AttributeAttributeValues]([Entegre_Pazarama_AttributeValueId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_Pazarama_CategoryEntegre_Pazarama_AttributeAttributeValue] ON [dbo].[Entegre_Pazarama_AttributeAttributeValues]([Entegre_Pazarama_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_Pazarama_CategoryEntegre_Pazarama_Category] ON [dbo].[Entegre_Pazarama_Categories]([ParentId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_Pazarama_CategoryAttributeEntegre_Pazarama_Attribute] ON [dbo].[Entegre_Pazarama_CategoryAttributes]([Entegre_Pazarama_AttributeId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_Pazarama_CategoryAttributeEntegre_Pazarama_Category] ON [dbo].[Entegre_Pazarama_CategoryAttributes]([Entegre_Pazarama_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_ProductECommerceEntegre_ProductECommerce_Attribute] ON [dbo].[Entegre_ProductECommerce_Attributes]([Entegre_ProductECommerceId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_ProductECommerce_CompetitionAnalyses_Active] ON [dbo].[Entegre_ProductECommerce_CompetitionAnalyses]([Active]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_ProductECommerce_CompetitionAnalyses_CustomerId] ON [dbo].[Entegre_ProductECommerce_CompetitionAnalyses]([CustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerEntegre_ProductECommerce_CompetitionAnalysis] ON [dbo].[Entegre_ProductECommerce_CompetitionAnalyses]([CustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_ProductECommerceEntegre_ProductECommerce_CompetitionAnalysis] ON [dbo].[Entegre_ProductECommerce_CompetitionAnalyses]([Entegre_ProductECommerceId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_ProductECommerceEntegre_ProductECommerce_DescriptionTemplate] ON [dbo].[Entegre_ProductECommerce_DescriptionTemplates]([Entegre_ProductECommerceId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_ProductEntegre_ProductECommerce_History] ON [dbo].[Entegre_ProductECommerce_Histories]([ProductId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_ProductECommerce_Images_Entegre_ProductECommerceId] ON [dbo].[Entegre_ProductECommerce_Images]([Entegre_ProductECommerceId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_ProductImageEntegre_ProductECommerce_Image] ON [dbo].[Entegre_ProductECommerce_Images]([ProductImageId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_ProductECommerce_Jobs_CustomerId_CreatedOn_JobType] ON [dbo].[Entegre_ProductECommerce_Jobs]([CustomerId], [CreatedOn], [JobType]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_ProductECommerce_Jobs_IntegratedECommerceCode_CustomerId_CreatedOn_JobType] ON [dbo].[Entegre_ProductECommerce_Jobs]([IntegratedECommerceCode], [CustomerId], [CreatedOn], [JobType]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_ProductECommerce_Jobs_JobType_CreatedOn] ON [dbo].[Entegre_ProductECommerce_Jobs]([JobType], [CreatedOn]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_ProductECommerceEntegre_ProductECommerce_Job] ON [dbo].[Entegre_ProductECommerce_Jobs]([Entegre_ProductECommerceId], [JobType]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_ProductECommerceEntegre_ProductECommerce_ShipmentCompany] ON [dbo].[Entegre_ProductECommerce_ShipmentCompanies]([Entegre_ProductECommerceId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_ProductECommerce_VariantEntegre_ProductECommerce_Variant_Detail] ON [dbo].[Entegre_ProductECommerce_Variant_Details]([Entegre_ProductECommerce_VariantId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_ProductECommerce_VariantEntegre_ProductECommerce_Variant_Image] ON [dbo].[Entegre_ProductECommerce_Variant_Images]([Entegre_ProductECommerce_VariantId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_ProductImageEntegre_ProductECommerce_Variant_Image] ON [dbo].[Entegre_ProductECommerce_Variant_Images]([ProductImageId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_ProductECommerce_Variants_Entegre_ProductECommerceId] ON [dbo].[Entegre_ProductECommerce_Variants]([Entegre_ProductECommerceId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_ProductECommerce_Variants_ProductVariantGroupId] ON [dbo].[Entegre_ProductECommerce_Variants]([ProductVariantGroupId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_ProductECommerce_Variants_VariantStockItemCode] ON [dbo].[Entegre_ProductECommerce_Variants]([VariantStockItemCode]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_ProductECommerce_Variants_VariantStockItemId] ON [dbo].[Entegre_ProductECommerce_Variants]([VariantStockItemId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_ProductECommerces_CustomerId_CustomerECommerceKeyId_EntegreProductSlug] ON [dbo].[Entegre_ProductECommerces]([CustomerId], [CustomerECommerceKeyId], [EntegreProductSlug]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_ProductECommerces_CustomerId_ProductId] ON [dbo].[Entegre_ProductECommerces]([CustomerId], [ProductId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_ProductECommerces_EntegreProductCode_IntegratedECommerceCode_CustomerId_CustomerECommerceKeyId] ON [dbo].[Entegre_ProductECommerces]([EntegreProductCode], [IntegratedECommerceCode], [CustomerId], [CustomerECommerceKeyId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_ProductECommerces_EntegreProductId_CustomerECommerceKeyId] ON [dbo].[Entegre_ProductECommerces]([EntegreProductId], [CustomerECommerceKeyId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_ProductECommerces_EntegreStockItemId_IntegratedECommerceCode_CustomerId_CustomerECommerceKeyId] ON [dbo].[Entegre_ProductECommerces]([EntegreStockItemId], [IntegratedECommerceCode], [CustomerId], [CustomerECommerceKeyId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_ProductECommerces_IntegratedECommerceCode_CustomerId_CustomerECommerceKeyId] ON [dbo].[Entegre_ProductECommerces]([IntegratedECommerceCode], [CustomerId], [CustomerECommerceKeyId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_ProductECommerces_IntegratedECommerceCode_ProductECommerceStatus_CustomerId_CustomerECommerceKeyId] ON [dbo].[Entegre_ProductECommerces]([IntegratedECommerceCode], [ProductECommerceStatus], [CustomerId], [CustomerECommerceKeyId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_ProductECommerces_ProductECommerceStatus_CustomerId_CustomerECommerceKeyId] ON [dbo].[Entegre_ProductECommerces]([ProductECommerceStatus], [CustomerId], [CustomerECommerceKeyId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_ProductECommerces_ProductId] ON [dbo].[Entegre_ProductECommerces]([ProductId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CurrencyEntegre_ProductECommerce] ON [dbo].[Entegre_ProductECommerces]([CurrencyId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerECommerceKeyId] ON [dbo].[Entegre_ProductECommerces]([CustomerECommerceKeyId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_ProductECommerceCurrency] ON [dbo].[Entegre_ProductECommerces]([SourceCurrencyId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_ProductECommerces_CampaignStockEntegre_ProductECommerce] ON [dbo].[Entegre_ProductECommerces_CampaignStocks]([Entegre_ProductECommerceId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_ProductECommerces_CampaignStockEntegre_ProductECommerce_Variant] ON [dbo].[Entegre_ProductECommerces_CampaignStocks]([Entegre_ProductECommerce_VariantId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_IntegratedECommerceEntegre_ShipmentCompany] ON [dbo].[Entegre_ShipmentCompanies]([IntegratedECommerceCode]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_SP_AttributeEntegre_SP_AttributeAttributeValue] ON [dbo].[Entegre_SP_AttributeAttributeValues]([Entegre_SP_AttributeId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_SP_AttributeValueEntegre_SP_AttributeAttributeValue] ON [dbo].[Entegre_SP_AttributeAttributeValues]([Entegre_SP_AttributeValueId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_SP_CategoryEntegre_SP_Category] ON [dbo].[Entegre_SP_Categories]([ParentId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_SP_AttributeEntegre_SP_CategoryAttribute] ON [dbo].[Entegre_SP_CategoryAttributes]([Entegre_SP_AttributeId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_SP_CategoryEntegre_SP_CategoryAttribute] ON [dbo].[Entegre_SP_CategoryAttributes]([Entegre_SP_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_SP_CategoryEntegre_SP_CategoryVariant] ON [dbo].[Entegre_SP_CategoryVariants]([Entegre_SP_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_SP_VariantEntegre_SP_CategoryVariant] ON [dbo].[Entegre_SP_CategoryVariants]([Entegre_SP_VariantId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_SP_VariantEntegre_SP_VariantVariantValue] ON [dbo].[Entegre_SP_VariantVariantValues]([Entegre_SP_VariantId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_SP_VariantValueEntegre_SP_VariantVariantValue] ON [dbo].[Entegre_SP_VariantVariantValues]([Entegre_SP_VariantValueId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_TO_AttributeAttributeValues_Entegre_TO_AttributeId_Entegre_TO_AttributeValueId_Entegre_TO_CategoryId] ON [dbo].[Entegre_TO_AttributeAttributeValues]([Entegre_TO_AttributeId], [Entegre_TO_AttributeValueId], [Entegre_TO_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_TO_AttributeAttributeValues_Entegre_TO_AttributeId_Entegre_TO_CategoryId] ON [dbo].[Entegre_TO_AttributeAttributeValues]([Entegre_TO_AttributeId], [Entegre_TO_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_TO_AttributeValues_AttributeValue] ON [dbo].[Entegre_TO_AttributeValues]([AttributeValue]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_TO_Categories_Name] ON [dbo].[Entegre_TO_Categories]([Name]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_TO_CategoryEntegre_TO_Category] ON [dbo].[Entegre_TO_Categories]([ParentId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_TO_CategoryAttributes_Entegre_TO_Category_Entegre_TO_CategoryAttribute] ON [dbo].[Entegre_TO_CategoryAttributes]([Entegre_TO_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_TO_Questions_CustomerId] ON [dbo].[Entegre_TO_Questions]([CustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_TO_Questions_CustomerId_CustomerECommerceKeyId_AnswerDate] ON [dbo].[Entegre_TO_Questions]([AnswerDate], [CustomerId], [CustomerECommerceKeyId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_TO_Questions_MessageCustomerId_CustomerId_CustomerECommerceKeyId] ON [dbo].[Entegre_TO_Questions]([MessageCustomerId], [CustomerId], [CustomerECommerceKeyId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_TO_Questions_QuestionId_CustomerId_CustomerECommerceKeyId] ON [dbo].[Entegre_TO_Questions]([QuestionId], [CustomerId], [CustomerECommerceKeyId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_VFM_AttributeAttributeValues_Entegre_VFM_AttributeId_Entegre_VFM_AttributeValueId] ON [dbo].[Entegre_VFM_AttributeAttributeValues]([Entegre_VFM_AttributeId], [Entegre_VFM_AttributeValueId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_VFM_AttributeAttributeValues_Entegre_VFM_AttributeId_Entegre_VFM_CategoryId] ON [dbo].[Entegre_VFM_AttributeAttributeValues]([Entegre_VFM_AttributeId], [Entegre_VFM_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_VFM_AttributeEntegre_VFM_AttributeAttributeValue] ON [dbo].[Entegre_VFM_AttributeAttributeValues]([Entegre_VFM_AttributeId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_VFM_AttributeValueEntegre_VFM_AttributeAttributeValue] ON [dbo].[Entegre_VFM_AttributeAttributeValues]([Entegre_VFM_AttributeValueId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_VFM_CategoryEntegre_VFM_AttributeAttributeValue] ON [dbo].[Entegre_VFM_AttributeAttributeValues]([Entegre_VFM_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_VFM_AttributeValues_Name] ON [dbo].[Entegre_VFM_AttributeValues]([Name]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Entegre_VFM_Categories_ParentId] ON [dbo].[Entegre_VFM_Categories]([ParentId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_VFM_AttributeEntegre_VFM_CategoryAttribute] ON [dbo].[Entegre_VFM_CategoryAttributes]([Entegre_VFM_AttributeId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Entegre_VFM_CategoryEntegre_VFM_CategoryAttribute] ON [dbo].[Entegre_VFM_CategoryAttributes]([Entegre_VFM_CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_FedExCountryFedExCity] ON [dbo].[FedExCities]([FedExCountryCode]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_MainAnnouncements_CreatedAt] ON [dbo].[MainAnnouncements]([CreatedAt]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_NotificationTypeDescriptionLanguage] ON [dbo].[NotificationTypeDescriptions]([LanguageId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_NotificationTypeDescriptionNotificationType] ON [dbo].[NotificationTypeDescriptions]([NotificationTypeId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_OrderLineOrderLineCustomTextOption] ON [dbo].[OrderLineCustomTextOptions]([OrderLineId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_OrderLineKeyValueOrderLine] ON [dbo].[OrderLineKeyValues]([OrderLineId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_OrderLinePhantomLineOrderLine] ON [dbo].[OrderLinePhantomLines]([OrderLineId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_OrderLinePhantomLines_ProductId] ON [dbo].[OrderLinePhantomLines]([ProductId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_OrderLinePhantomLines_ProductVariantGroupId] ON [dbo].[OrderLinePhantomLines]([ProductVariantGroupId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_OrderOrderLine] ON [dbo].[OrderLines]([OrderId] DESC);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_OrderLines_EntegreProductId_ProductStockCode] ON [dbo].[OrderLines]([EntegreProductId], [ProductStockCode]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_OrderLines_EntegreProductId_Status] ON [dbo].[OrderLines]([EntegreProductId], [Status]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_OrderLines_ProductId] ON [dbo].[OrderLines]([ProductId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_OrderLines_ProductStockCode_Status] ON [dbo].[OrderLines]([ProductStockCode], [Status]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_OrderLines_ProductVariantGroupId] ON [dbo].[OrderLines]([ProductVariantGroupId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_OrderLines_Status] ON [dbo].[OrderLines]([Status]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_OrderLines_Status_OrderId] ON [dbo].[OrderLines]([Status], [OrderId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_OrderLineOrderLineVariant] ON [dbo].[OrderLineVariants]([OrderLineId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerECommerceAccountingKeyId] ON [dbo].[Orders]([CustomerECommerceAccountingKeyId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerECommerceCargoKeyOrder] ON [dbo].[Orders]([CustomerECommerceCargoKeyId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerECommerceFulFillmentKeyOrder] ON [dbo].[Orders]([CustomerECommerceFulFillmentKeyId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerECommerceKeyId] ON [dbo].[Orders]([CustomerECommerceKeyId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_eInvoiceId] ON [dbo].[Orders]([eInvoiceId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_IntegratedFulFillmentECommerce] ON [dbo].[Orders]([IntegratedFulFillmentECommerceCode]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_InvoiceAddressId] ON [dbo].[Orders]([InvoiceAddressId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_OrderUser] ON [dbo].[Orders]([PackageUserId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_OrderUser1] ON [dbo].[Orders]([AssignedUserId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_OrderUser2] ON [dbo].[Orders]([PackedUserId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_ShippingAddressId] ON [dbo].[Orders]([ShippingAddressId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Orders_CustomerId_CustomerECommerceKeyId_OrderDate_Status_eInvoiceId] ON [dbo].[Orders]([CustomerId], [CustomerECommerceKeyId], [OrderDate], [Status], [eInvoiceId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Orders_CustomerId_OrderDate] ON [dbo].[Orders]([CustomerId], [OrderDate]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Orders_CustomerId_OrderDate_Status_CargoKey] ON [dbo].[Orders]([CustomerId], [OrderDate], [Status], [CargoKey]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Orders_CustomerId_PackageNumber_CustomerECommerceKeyId] ON [dbo].[Orders]([CustomerId], [PackageNumber], [CustomerECommerceKeyId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Orders_ECommerceOrderId_CustomerId_CustomerECommerceKeyId_IntegratedECommerceCode_Status_OrderDate] ON [dbo].[Orders]([ECommerceOrderId], [CustomerId], [CustomerECommerceKeyId], [IntegratedECommerceCode], [Status], [OrderDate]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Orders_ECommerceOrderNumber_CustomerId_CustomerECommerceKeyId_IntegratedECommerceCode_Status_OrderDate] ON [dbo].[Orders]([ECommerceOrderNumber], [CustomerId], [CustomerECommerceKeyId], [IntegratedECommerceCode], [Status], [OrderDate]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Orders_eInvoiceId] ON [dbo].[Orders]([eInvoiceId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Orders_IntegratedECommerceCode_CustomerId_CustomerECommerceKeyId_OrderDate_Status] ON [dbo].[Orders]([IntegratedECommerceCode], [CustomerId], [CustomerECommerceKeyId], [OrderDate], [Status]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Orders_IntegratedECommerceCode_CustomerId_CustomerECommerceKeyId_Status] ON [dbo].[Orders]([IntegratedECommerceCode], [CustomerId], [CustomerECommerceKeyId], [Status]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Orders_OrderDate_Status] ON [dbo].[Orders]([OrderDate], [Status]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Orders_Status_CustomerId_OrderDate] ON [dbo].[Orders]([Status], [CustomerId], [OrderDate]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Orders_Status_CustomerId_ShipmentBarCodePrinted_OrderDate_CustomerECommerceKeyId] ON [dbo].[Orders]([Status], [CustomerId], [ShipmentBarCodePrinted], [OrderDate], [CustomerECommerceKeyId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_OrderOrderServiceItem] ON [dbo].[OrderServiceItems]([OrderId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_OrderServiceItems_VatRateId_OrderId] ON [dbo].[OrderServiceItems]([VatRateId], [OrderId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_Point_DistrictPoint_City] ON [dbo].[Point_Districts]([Point_CityId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_ProductDescriptionProduct] ON [dbo].[ProductDescriptions]([ProductId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_ProductImages_ProductId] ON [dbo].[ProductImages]([ProductId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_ProductPhantomLineProduct] ON [dbo].[ProductPhantomLines]([ProductId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_ProductPhantomLineProduct1] ON [dbo].[ProductPhantomLines]([PhantomProductId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_ProductPhantomLineProductVariantGroup] ON [dbo].[ProductPhantomLines]([PhantomProductVariantGroupId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_CustomerProduct] ON [dbo].[Products]([CustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Products_CategoryId] ON [dbo].[Products]([CategoryId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Products_Code_CustomerId_ProductType] ON [dbo].[Products]([Code], [CustomerId], [ProductType]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Products_CustomerBrandId] ON [dbo].[Products]([CustomerBrandId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Products_CustomerId_CategoryId_ProductStatus] ON [dbo].[Products]([CustomerId], [CategoryId], [ProductStatus]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Products_CustomerId_CreatedOn] ON [dbo].[Products]([CustomerId], [CreatedOn]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Products_CustomerId_Name] ON [dbo].[Products]([CustomerId], [Name]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Products_CustomerId_ProductStatus] ON [dbo].[Products]([CustomerId], [ProductStatus]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_ProductStockJobProduct] ON [dbo].[ProductStockJobs]([ProductId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_ProductTagProduct] ON [dbo].[ProductTags]([ProductId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_ProductTagTag] ON [dbo].[ProductTags]([TagId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_ProductImageProductVariantGroupImage] ON [dbo].[ProductVariantGroupImages]([ProductImageId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_ProductVariantGroupProductVariantGroupImage] ON [dbo].[ProductVariantGroupImages]([ProductVariantGroupId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_ProductVariantGroupPhantomLineProduct] ON [dbo].[ProductVariantGroupPhantomLines]([PhantomProductId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_ProductVariantGroupPhantomLineProductVariantGroup] ON [dbo].[ProductVariantGroupPhantomLines]([ProductVariantGroupId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_ProductVariantGroupPhantomLineProductVariantGroup1] ON [dbo].[ProductVariantGroupPhantomLines]([PhantomProductVariantGroupId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_ProductVariantGroups_ProductId] ON [dbo].[ProductVariantGroups]([ProductId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_ProductVariantGroups_StockCode_ProductId] ON [dbo].[ProductVariantGroups]([StockCode], [ProductId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_ProductVariantGroupProductVariant] ON [dbo].[ProductVariants]([ProductVariantGroupId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_ProductVariants_VariantId] ON [dbo].[ProductVariants]([VariantId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_ProductVariants_VariantValueId] ON [dbo].[ProductVariants]([VariantValueId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_SendeoCitySendeoDistrict] ON [dbo].[SendeoDistricts]([SendeoCityId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_ShipmentLines_OrderLineId] ON [dbo].[ShipmentLines]([OrderLineId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_ShipmentLines_ShipmentId] ON [dbo].[ShipmentLines]([ShipmentId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_OrderShipmentOrder] ON [dbo].[ShipmentOrders]([OrderId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_ShipmentOrders_ShipmentId] ON [dbo].[ShipmentOrders]([ShipmentId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Shipments_ShipmentCode] ON [dbo].[Shipments]([ShipmentCode]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Shipments_ShippingAddressId] ON [dbo].[Shipments]([ShippingAddressId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_TagCustomer] ON [dbo].[Tags]([CustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_UpsAreaUpsCity] ON [dbo].[UpsAreas]([UpsCityId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_UpsAreas_UpsCityId] ON [dbo].[UpsAreas]([UpsCityId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_FK_LanguageUser] ON [dbo].[Users]([LanguageId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_Variants_CustomerId] ON [dbo].[Variants]([CustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [PERF_IX_Variants_Name_CustomerId] ON [dbo].[Variants]([Name], [CustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_VariantValues_CustomerId] ON [dbo].[VariantValues]([CustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_VariantValues_Value_VariantId_CustomerId] ON [dbo].[VariantValues]([Value], [VariantId], [CustomerId]);

-- CreateIndex
CREATE NONCLUSTERED INDEX [IX_VariantValues_VariantId_CustomerId] ON [dbo].[VariantValues]([VariantId], [CustomerId]);

-- AddForeignKey
ALTER TABLE [dbo].[AuthActionForCustomerDescriptions] ADD CONSTRAINT [FK_AuthActionForCustomerDescriptionAuthActionForCustomer] FOREIGN KEY ([AuthActionForCustomerId]) REFERENCES [dbo].[AuthActionForCustomers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[AuthActionForCustomerDescriptions] ADD CONSTRAINT [FK_AuthActionForCustomerDescriptionLanguage] FOREIGN KEY ([LanguageId]) REFERENCES [dbo].[Languages]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[AuthActionForUserDescriptions] ADD CONSTRAINT [FK_AuthActionForUserDescriptionAuthActionForUser] FOREIGN KEY ([AuthActionForUserId]) REFERENCES [dbo].[AuthActionForUsers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[AuthActionForUserDescriptions] ADD CONSTRAINT [FK_AuthActionForUserDescriptionLanguage] FOREIGN KEY ([LanguageId]) REFERENCES [dbo].[Languages]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[BulkOperationLines] ADD CONSTRAINT [FK_BulkOperationBulkOperationLine] FOREIGN KEY ([BulkOperationId]) REFERENCES [dbo].[BulkOperations]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[BulkOperationLines] ADD CONSTRAINT [FK_Entegre_ProductECommerceBulkOperationLine] FOREIGN KEY ([Entegre_ProductECommerceId]) REFERENCES [dbo].[Entegre_ProductECommerces]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[BulkOperationLines] ADD CONSTRAINT [FK_ProductBulkOperationLine] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Products]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[BulkOperations] ADD CONSTRAINT [FK_CustomerBulkOperation] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[BulkOperations] ADD CONSTRAINT [FK_ProductBulkOperation] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Products]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CampaignCustomers] ADD CONSTRAINT [FK_CampaignCampaignCustomers] FOREIGN KEY ([CampaignId]) REFERENCES [dbo].[Campaigns]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CampaignCustomers] ADD CONSTRAINT [FK_CustomerCampaignCustomers] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CampaignCustomers] ADD CONSTRAINT [FK_PackagesCampaignCustomers] FOREIGN KEY ([PackagesId]) REFERENCES [dbo].[Packages]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Campaigns] ADD CONSTRAINT [FK_CustomerRepresentativeCampaign] FOREIGN KEY ([CustomerRepresentativeId]) REFERENCES [dbo].[CustomerRepresentatives]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Categories] ADD CONSTRAINT [FK_CategoryCategory] FOREIGN KEY ([ParentId]) REFERENCES [dbo].[Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Categories] ADD CONSTRAINT [FK_CategoryVatRate] FOREIGN KEY ([DefaultVatRateId]) REFERENCES [dbo].[VatRates]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Categories] ADD CONSTRAINT [FK_CustomerCategory] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ClaimItemReasons] ADD CONSTRAINT [FK_ClaimItemReasonClaimItem] FOREIGN KEY ([ClaimItemId]) REFERENCES [dbo].[ClaimItems]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Claims] ADD CONSTRAINT [FK_ClaimCustomer] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Claims] ADD CONSTRAINT [FK_ClaimCustomerECommerceKey] FOREIGN KEY ([CustomerECommerceKeyId]) REFERENCES [dbo].[CustomerECommerceKeys]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ConnectedCustomers] ADD CONSTRAINT [FK_CustomerConnectedCustomer] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ConnectedCustomers] ADD CONSTRAINT [FK_CustomerErpConnectedCustomer] FOREIGN KEY ([CustomerErpId]) REFERENCES [dbo].[CustomerErps]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ConnectedUsers] ADD CONSTRAINT [FK_CustomerConnectedUser] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ConnectedUsers] ADD CONSTRAINT [FK_UserConnectedUser] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CouponAllowedPackages] ADD CONSTRAINT [FK_CouponAllowedPackageCoupon] FOREIGN KEY ([CouponId]) REFERENCES [dbo].[Coupons]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CouponAllowedPackages] ADD CONSTRAINT [FK_CouponAllowedPackagePackages] FOREIGN KEY ([PackagesId]) REFERENCES [dbo].[Packages]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CouponCustomerAuthActions] ADD CONSTRAINT [FK_CouponCustomerAuthActionAuthActionForCustomer] FOREIGN KEY ([AuthActionForCustomerId]) REFERENCES [dbo].[AuthActionForCustomers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CouponCustomerAuthActions] ADD CONSTRAINT [FK_CouponCustomerAuthActionCoupon] FOREIGN KEY ([CouponId]) REFERENCES [dbo].[Coupons]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CouponGiftPackages] ADD CONSTRAINT [FK_CouponGiftPackageCoupon] FOREIGN KEY ([CouponId]) REFERENCES [dbo].[Coupons]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CouponGiftPackages] ADD CONSTRAINT [FK_CouponGiftPackagePackages] FOREIGN KEY ([PackagesId]) REFERENCES [dbo].[Packages]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CouponPackageExtras] ADD CONSTRAINT [FK_CouponPackageExtraCoupon] FOREIGN KEY ([CouponId]) REFERENCES [dbo].[Coupons]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CouponUsages] ADD CONSTRAINT [FK_CouponUsageCoupon] FOREIGN KEY ([CouponId]) REFERENCES [dbo].[Coupons]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CouponUsages] ADD CONSTRAINT [FK_CouponUsageCustomer] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CouponUsages] ADD CONSTRAINT [FK_CouponUsageCustomerSubscription] FOREIGN KEY ([CustomerSubscriptionId]) REFERENCES [dbo].[CustomerSubscriptions]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CurrencyExchanges] ADD CONSTRAINT [FK_CurrencyCurrencyExchange] FOREIGN KEY ([CurrencyId]) REFERENCES [dbo].[Currencies]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerAuthActionForCustomers] ADD CONSTRAINT [FK_AuthActionForCustomerCustomerAuthActionForCustomer] FOREIGN KEY ([AuthActionForCustomerId]) REFERENCES [dbo].[AuthActionForCustomers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerAuthActionForCustomers] ADD CONSTRAINT [FK_CustomerCustomerAuthActionForCustomer] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerAuthActionForPackages] ADD CONSTRAINT [FK_CustomerAuthActionForPackageAuthActionForCustomer] FOREIGN KEY ([AuthActionForCustomerId]) REFERENCES [dbo].[AuthActionForCustomers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerAuthActionForPackages] ADD CONSTRAINT [FK_CustomerAuthActionForPackagePackages] FOREIGN KEY ([PackagesId]) REFERENCES [dbo].[Packages]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerBrands] ADD CONSTRAINT [FK_CustomerCustomerBrand] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerCreditTransactions] ADD CONSTRAINT [FK_CustomerCustomerCreditTransaction] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerCreditTransactions] ADD CONSTRAINT [FK_CustomerECommerceKeyCustomerCreditTransaction] FOREIGN KEY ([CustomerECommerceKeyId]) REFERENCES [dbo].[CustomerECommerceKeys]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerCreditTransactions] ADD CONSTRAINT [FK_IntegratedECommerceCustomerCreditTransaction] FOREIGN KEY ([IntegratedECommerceCode]) REFERENCES [dbo].[IntegratedECommerces]([Code]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerCreditTransactions] ADD CONSTRAINT [FK_OrderCustomerCreditTransaction] FOREIGN KEY ([OrderId]) REFERENCES [dbo].[Orders]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerDefaultCargoSettings] ADD CONSTRAINT [FK_CustomerDefaultCargoSettingCustomerECommerceKey] FOREIGN KEY ([CustomerECommerceKeyId]) REFERENCES [dbo].[CustomerECommerceKeys]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerECommerceDefaultSettings] ADD CONSTRAINT [FK_CustomerCustomerECommerceDefaultSetting] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerECommerceDefaultSettings] ADD CONSTRAINT [FK_CustomerECommerceDefaultSettingCustomerErp] FOREIGN KEY ([CustomerErpId]) REFERENCES [dbo].[CustomerErps]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerECommerceDefaultSettings] ADD CONSTRAINT [FK_CustomerECommerceKeyCustomerECommerceDefaultSetting] FOREIGN KEY ([CustomerECommerceKeyId]) REFERENCES [dbo].[CustomerECommerceKeys]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerECommerceDefaultSettings] ADD CONSTRAINT [FK_Entegre_AE_CustomerDefaultSettingCustomerECommerceDefaultSetting] FOREIGN KEY ([Entegre_AE_CustomerDefaultSettingId]) REFERENCES [dbo].[Entegre_AE_CustomerDefaultSettings]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerECommerceDefaultSettings] ADD CONSTRAINT [FK_Entegre_Allegro_CustomerDefaultSettingCustomerECommerceDefaultSetting] FOREIGN KEY ([Entegre_Allegro_CustomerDefaultSettingId]) REFERENCES [dbo].[Entegre_Allegro_CustomerDefaultSettings]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerECommerceDefaultSettings] ADD CONSTRAINT [FK_Entegre_AMZ_CustomerDefaultSettingCustomerECommerceDefaultSetting] FOREIGN KEY ([Entegre_AMZ_CustomerDefaultSettingId]) REFERENCES [dbo].[Entegre_AMZ_CustomerDefaultSettings]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerECommerceDefaultSettings] ADD CONSTRAINT [FK_Entegre_Ebay_CustomerDefaultSettingCustomerECommerceDefaultSetting] FOREIGN KEY ([Entegre_Ebay_CustomerDefaultSettingId]) REFERENCES [dbo].[Entegre_Ebay_CustomerDefaultSettings]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerECommerceDefaultSettings] ADD CONSTRAINT [FK_Entegre_Etsy_CustomerDefaultSettingCustomerECommerceDefaultSetting] FOREIGN KEY ([Entegre_Etsy_CustomerDefaultSettingId]) REFERENCES [dbo].[Entegre_Etsy_CustomerDefaultSettings]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerECommerceDefaultSettings] ADD CONSTRAINT [FK_Entegre_GG_CustomerDefaultSettingCustomerECommerceDefaultSetting] FOREIGN KEY ([Entegre_GG_CustomerDefaultSettingId]) REFERENCES [dbo].[Entegre_GG_CustomerDefaultSettings]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerECommerceDefaultSettings] ADD CONSTRAINT [FK_Entegre_IC_CustomerDefaultSettingCustomerECommerceDefaultSetting] FOREIGN KEY ([Entegre_IC_CustomerDefaultSettingId]) REFERENCES [dbo].[Entegre_IC_CustomerDefaultSettings]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerECommerceDefaultSettings] ADD CONSTRAINT [FK_Entegre_N11_DefaultSettingCustomerECommerceDefaultSetting] FOREIGN KEY ([Entegre_N11_CustomerDefaultSettingId]) REFERENCES [dbo].[Entegre_N11_CustomerDefaultSettings]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerECommerceDefaultSettings] ADD CONSTRAINT [FK_Entegre_N11Pro_CustomerDefaultSettingCustomerECommerceDefaultSetting] FOREIGN KEY ([Entegre_N11Pro_CustomerDefaultSettingId]) REFERENCES [dbo].[Entegre_N11Pro_CustomerDefaultSettings]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerECommerceDefaultSettings] ADD CONSTRAINT [FK_Entegre_SP_CustomerDefaultSettingCustomerECommerceDefaultSetting] FOREIGN KEY ([Entegre_SP_CustomerDefaultSettingId]) REFERENCES [dbo].[Entegre_SP_CustomerDefaultSettings]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerECommerceDefaultSettings] ADD CONSTRAINT [FK_IntegratedECommerceCustomerECommerceDefaultSetting] FOREIGN KEY ([IntegratedECommerceCode]) REFERENCES [dbo].[IntegratedECommerces]([Code]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerECommerceKeyPriceFormulas] ADD CONSTRAINT [FK_CustomerECommerceKeyPriceFormulaCustomer] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerECommerceKeyPriceFormulas] ADD CONSTRAINT [FK_CustomerECommerceKeyPriceFormulaCustomerECommerceKey] FOREIGN KEY ([CustomerECommerceKeyId]) REFERENCES [dbo].[CustomerECommerceKeys]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerECommerceKeys] ADD CONSTRAINT [FK_CustomerCustomerECommerceKey] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerECommerceKeys] ADD CONSTRAINT [FK_CustomerECommerceKeyUser] FOREIGN KEY ([AutoAssignOrderPackageUserId]) REFERENCES [dbo].[Users]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerECommerceKeys] ADD CONSTRAINT [FK_IntegratedECommerceCustomerECommerceKey] FOREIGN KEY ([IntegratedECommerceCode]) REFERENCES [dbo].[IntegratedECommerces]([Code]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerECommerceMessageTemplates] ADD CONSTRAINT [FK_CustomerECommerceMessageTemplateCustomer] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerECommerceProductInsertLogs] ADD CONSTRAINT [FK_CustomerECommerceProductInsertLogCustomer] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerErps] ADD CONSTRAINT [FK_CustomerErpCustomer] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerInvoiceInformations] ADD CONSTRAINT [FK_CityCustomerInvoiceInformation] FOREIGN KEY ([CityId]) REFERENCES [dbo].[Cities]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerInvoiceInformations] ADD CONSTRAINT [FK_CustomerCustomerInvoiceInformation] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerInvoiceInformations] ADD CONSTRAINT [FK_CustomerInvoiceInformationCustomerECommerceKey] FOREIGN KEY ([CustomerECommerceKeyId]) REFERENCES [dbo].[CustomerECommerceKeys]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerInvoiceInformations] ADD CONSTRAINT [FK_DistrictCustomerInvoiceInformation] FOREIGN KEY ([DistrictId]) REFERENCES [dbo].[Districts]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerInvoiceSettings] ADD CONSTRAINT [FK_CustomerCustomerInvoiceSetting] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerNotifications] ADD CONSTRAINT [FK_CustomerNotificationCustomer] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerNotifications] ADD CONSTRAINT [FK_CustomerNotificationIntegratedECommerce] FOREIGN KEY ([IntegratedECommerceCode]) REFERENCES [dbo].[IntegratedECommerces]([Code]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerNotificationSettings] ADD CONSTRAINT [FK_CustomerCustomerNotificationSettings] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerNotificationSettings] ADD CONSTRAINT [FK_CustomerNotificationSettingTypesCustomerNotificationSettings] FOREIGN KEY ([CustomerNotificationSettingTypesId]) REFERENCES [dbo].[CustomerNotificationSettingTypes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerOrderColorTags] ADD CONSTRAINT [FK_CustomerOrderColorTagCustomer] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerPosPayments] ADD CONSTRAINT [FK_CustomerCreditTransactionCustomerPostPayment] FOREIGN KEY ([CustomerCreditTransactionId]) REFERENCES [dbo].[CustomerCreditTransactions]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerPosPayments] ADD CONSTRAINT [FK_CustomerCustomerPostPayment] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerPosPayments] ADD CONSTRAINT [FK_CustomerPosPaymentCustomerSMSTransactions] FOREIGN KEY ([CustomerSMSTransactionsId]) REFERENCES [dbo].[CustomerSMSTransactions]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerPosPayments] ADD CONSTRAINT [FK_CustomerPosPaymentCustomerSubscription] FOREIGN KEY ([CustomerSubscriptionId]) REFERENCES [dbo].[CustomerSubscriptions]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerReports] ADD CONSTRAINT [FK_CustomerReportCustomer] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerReportTemplates] ADD CONSTRAINT [FK_CustomerCustomerReportTemplate] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerRepresentatives] ADD CONSTRAINT [FK_CustomerRepresentativeCustomerUser] FOREIGN KEY ([CustomerUserId]) REFERENCES [dbo].[CustomerUsers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [FK_CityCustomer] FOREIGN KEY ([CityId]) REFERENCES [dbo].[Cities]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [FK_CustomerCountry] FOREIGN KEY ([CountryIso2]) REFERENCES [dbo].[Countries]([Iso2]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [FK_CustomerCustomer] FOREIGN KEY ([ReferenceCustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [FK_CustomerRepresentativeCustomer] FOREIGN KEY ([CustomerRepresentativeId]) REFERENCES [dbo].[CustomerRepresentatives]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [FK_DistrictCustomer] FOREIGN KEY ([DistrictId]) REFERENCES [dbo].[Districts]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerSettings] ADD CONSTRAINT [FK_CustomerSettingCustomer] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerSettings] ADD CONSTRAINT [FK_VatRateCustomerSetting] FOREIGN KEY ([VatRateId]) REFERENCES [dbo].[VatRates]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerShipmentPriceForOrderAmounts] ADD CONSTRAINT [FK_CustomerShipmentPriceForOrderAmountCurrency] FOREIGN KEY ([ShipmentPriceCurrencyId]) REFERENCES [dbo].[Currencies]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerShipmentPriceForOrderAmounts] ADD CONSTRAINT [FK_CustomerShipmentPriceForOrderAmountCurrency1] FOREIGN KEY ([OrderAmountCurrencyId]) REFERENCES [dbo].[Currencies]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerShipmentPriceForOrderAmounts] ADD CONSTRAINT [FK_CustomerShipmentPricePerECommerceKeyCustomer] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerShipmentPriceForOrderAmounts] ADD CONSTRAINT [FK_CustomerShipmentPricePerECommerceKeyCustomerECommerceKey] FOREIGN KEY ([CustomerECommerceKeyId]) REFERENCES [dbo].[CustomerECommerceKeys]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerShipmentPrices] ADD CONSTRAINT [FK_CustomerShipmentPriceCurrency] FOREIGN KEY ([DomesticCurrencyId]) REFERENCES [dbo].[Currencies]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerShipmentPrices] ADD CONSTRAINT [FK_CustomerShipmentPriceCurrencyInternational] FOREIGN KEY ([InternationalCurrencyId]) REFERENCES [dbo].[Currencies]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerShipmentPrices] ADD CONSTRAINT [FK_CustomerShipmentPriceCustomer] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerSMSTransactions] ADD CONSTRAINT [FK_CustomerCustomerSMSTransactions] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerSubscriptionCustomerAuths] ADD CONSTRAINT [FK_AuthActionForCustomerCustomerSubscriptionCustomerAuth] FOREIGN KEY ([AuthActionForCustomerId]) REFERENCES [dbo].[AuthActionForCustomers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerSubscriptionCustomerAuths] ADD CONSTRAINT [FK_CustomerSubscriptionCustomerSubscriptionCustomerAuth] FOREIGN KEY ([CustomerSubscriptionId]) REFERENCES [dbo].[CustomerSubscriptions]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerSubscriptions] ADD CONSTRAINT [FK_CustomerCustomerSubscription] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerSubscriptions] ADD CONSTRAINT [FK_CustomerSubscriptionPackages] FOREIGN KEY ([PackagesId]) REFERENCES [dbo].[Packages]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerUserAuthActionForUsers] ADD CONSTRAINT [FK_AuthActionForUserCustomerUserAuthActionForUser] FOREIGN KEY ([AuthActionForUserId]) REFERENCES [dbo].[AuthActionForUsers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerUserAuthActionForUsers] ADD CONSTRAINT [FK_CustomerUserCustomerUserAuthActionForUser] FOREIGN KEY ([CustomerUserId]) REFERENCES [dbo].[CustomerUsers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerUserNotificationTypes] ADD CONSTRAINT [FK_CustomerUserCustomerUserNotificationType] FOREIGN KEY ([CustomerUserId]) REFERENCES [dbo].[CustomerUsers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerUserNotificationTypes] ADD CONSTRAINT [FK_NotificationTypeCustomerUserNotificationType] FOREIGN KEY ([NotificationTypeId]) REFERENCES [dbo].[NotificationTypes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerUsers] ADD CONSTRAINT [FK_CustomerCustomerUser] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[CustomerUsers] ADD CONSTRAINT [FK_UserCustomerUser] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[DescriptionTemplates] ADD CONSTRAINT [FK_CustomerDescriptionTemplate] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Districts] ADD CONSTRAINT [FK_CityDistrict] FOREIGN KEY ([CityId]) REFERENCES [dbo].[Cities]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ECommerceMessagesECommerceKeys] ADD CONSTRAINT [FK_ECommerceMessagesECommerceKeyCustomerECommerceKey] FOREIGN KEY ([CustomerECommerceKeyId]) REFERENCES [dbo].[CustomerECommerceKeys]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ECommerceMessagesECommerceKeys] ADD CONSTRAINT [FK_ECommerceMessagesECommerceKeyCustomerECommerceMessageTemplate] FOREIGN KEY ([CustomerECommerceMessageTemplateId]) REFERENCES [dbo].[CustomerECommerceMessageTemplates]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ECommerceProductBatches] ADD CONSTRAINT [FK_ECommerceProductBatchCustomerECommerceKey] FOREIGN KEY ([CustomerECommerceKeyId]) REFERENCES [dbo].[CustomerECommerceKeys]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ECommerceProductBatches] ADD CONSTRAINT [FK_ECommerceProductBatchDataECommerceProductBatch] FOREIGN KEY ([BatchId]) REFERENCES [dbo].[ECommerceProductBatchDatas]([BatchId]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ECommerceProductBatches] ADD CONSTRAINT [FK_ECommerceProductBatchIntegratedECommerce] FOREIGN KEY ([IntegratedECommerceCode]) REFERENCES [dbo].[IntegratedECommerces]([Code]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ECommerceProductBatches] ADD CONSTRAINT [FK_ECommerceProductResultCustomer] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ECommerceSynchronizations] ADD CONSTRAINT [FK_CustomerECommerceSynchronization] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ECommerceSynchronizations] ADD CONSTRAINT [FK_IntegratedECommerceECommerceSynchronization] FOREIGN KEY ([IntegratedECommerceCode]) REFERENCES [dbo].[IntegratedECommerces]([Code]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[eInvoices] ADD CONSTRAINT [FK_eInvoiceCustomerECommerceKey] FOREIGN KEY ([CustomerECommerceKeyId]) REFERENCES [dbo].[CustomerECommerceKeys]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[eInvoices] ADD CONSTRAINT [FK_IntegratedECommerceeInvoice] FOREIGN KEY ([IntegratedECommerceCode]) REFERENCES [dbo].[IntegratedECommerces]([Code]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_AE_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_AE_AttributeAttributeValueEntegre_AE_Attribute] FOREIGN KEY ([Entegre_AE_AttributeId]) REFERENCES [dbo].[Entegre_AE_Attributes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_AE_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_AE_AttributeAttributeValueEntegre_AE_AttributeValue] FOREIGN KEY ([Entegre_AE_AttributeValueId]) REFERENCES [dbo].[Entegre_AE_AttributeValues]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_AE_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_AE_AttributeAttributeValueEntegre_AE_Category] FOREIGN KEY ([Entegre_AE_CategoryId]) REFERENCES [dbo].[Entegre_AE_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_AE_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_AE_CategoriAttributeEntegre_AE_Attribute] FOREIGN KEY ([Entegre_AE_AttributeId]) REFERENCES [dbo].[Entegre_AE_Attributes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_AE_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_AE_CategoriAttributeEntegre_AE_Category] FOREIGN KEY ([Entegre_AE_CategoryId]) REFERENCES [dbo].[Entegre_AE_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Allegro_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_Allegro_AttributeEntegre_Allegro_AttributeAttributeValue] FOREIGN KEY ([Entegre_Allegro_AttributeId]) REFERENCES [dbo].[Entegre_Allegro_Attributes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Allegro_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_Allegro_AttributeValueEntegre_Allegro_AttributeAttributeValue] FOREIGN KEY ([Entegre_Allegro_AttributeValueId]) REFERENCES [dbo].[Entegre_Allegro_AttributeValues]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Allegro_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_Allegro_CategoryEntegre_Allegro_AttributeAttributeValue] FOREIGN KEY ([Entegre_Allegro_CategoryId]) REFERENCES [dbo].[Entegre_Allegro_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Allegro_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_Allegro_AttributeEntegre_Allegro_CategoryAttribute] FOREIGN KEY ([Entegre_Allegro_AttributeId]) REFERENCES [dbo].[Entegre_Allegro_Attributes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Allegro_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_Allegro_CategoryEntegre_Allegro_CategoryAttribute] FOREIGN KEY ([Entegre_Allegro_CategoryId]) REFERENCES [dbo].[Entegre_Allegro_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_AMZ_CustomerDefaultSettings] ADD CONSTRAINT [FK_ShipmentCompanyEntegre_AMZ_CustomerDefaultSetting] FOREIGN KEY ([ShipmentCompanyId]) REFERENCES [dbo].[ShipmentCompanies]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_BD_AttributeValues] ADD CONSTRAINT [FK_Entegre_BD_AttributeValueEntegre_BD_Attribute] FOREIGN KEY ([Entegre_BD_AttributeId]) REFERENCES [dbo].[Entegre_BD_Attributes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_BD_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_BD_CategoryAttributeEntegre_BD_Attribute] FOREIGN KEY ([Entegre_BD_AttributeId]) REFERENCES [dbo].[Entegre_BD_Attributes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_BD_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_BD_CategoryAttributeEntegre_BD_Category] FOREIGN KEY ([Entegre_BD_CategoryId]) REFERENCES [dbo].[Entegre_BD_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_CS_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_CS_AttributeEntegre_CS_AttributeAttributeValue] FOREIGN KEY ([Entegre_CS_AttributeId]) REFERENCES [dbo].[Entegre_CS_Attributes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_CS_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_CS_AttributeValueEntegre_CS_AttributeAttributeValue] FOREIGN KEY ([Entegre_CS_AttributeValueId]) REFERENCES [dbo].[Entegre_CS_AttributeValues]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_CS_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_CS_CategoryAttributeEntegre_CS_Attribute] FOREIGN KEY ([Entegre_CS_AttributeId]) REFERENCES [dbo].[Entegre_CS_Attributes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_CS_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_CS_CategoryAttributeEntegre_CS_Category] FOREIGN KEY ([Entegre_CS_CategoryId]) REFERENCES [dbo].[Entegre_CS_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_CS_Questions] ADD CONSTRAINT [FK_Entegre_CS_QuestionCustomer] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_CS_Questions] ADD CONSTRAINT [FK_Entegre_CS_QuestionCustomerECommerceKey] FOREIGN KEY ([CustomerECommerceKeyId]) REFERENCES [dbo].[CustomerECommerceKeys]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Ebay_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_Ebay_AttributeAttributeValueEntegre_Ebay_Attribute] FOREIGN KEY ([Entegre_Ebay_AttributeId]) REFERENCES [dbo].[Entegre_Ebay_Attributes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Ebay_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_Ebay_AttributeAttributeValueEntegre_Ebay_AttributeValue] FOREIGN KEY ([Entegre_Ebay_AttributeValueId]) REFERENCES [dbo].[Entegre_Ebay_AttributeValues]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Ebay_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_Ebay_AttributeAttributeValueEntegre_Ebay_Category] FOREIGN KEY ([Entegre_Ebay_CategoryId]) REFERENCES [dbo].[Entegre_Ebay_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Ebay_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_Ebay_CategoryAttributeEntegre_Ebay_Attribute] FOREIGN KEY ([Entegre_Ebay_AttributeId]) REFERENCES [dbo].[Entegre_Ebay_Attributes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Ebay_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_Ebay_CategoryAttributeEntegre_Ebay_Category] FOREIGN KEY ([Entegre_Ebay_CategoryId]) REFERENCES [dbo].[Entegre_Ebay_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_EPttAvm_Categories] ADD CONSTRAINT [FK_Entegre_EPttAvm_CategoryEntegre_EPttAvm_Category] FOREIGN KEY ([ParentId]) REFERENCES [dbo].[Entegre_EPttAvm_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Etsy_AttributeAttributeScales] ADD CONSTRAINT [FK_Entegre_Etsy_AttributeAttributeScaleEntegre_Etsy_Attribute] FOREIGN KEY ([Entegre_Etsy_AttributeId]) REFERENCES [dbo].[Entegre_Etsy_Attributes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Etsy_AttributeAttributeScales] ADD CONSTRAINT [FK_Entegre_Etsy_AttributeAttributeScaleEntegre_Etsy_AttributeScale] FOREIGN KEY ([Entegre_Etsy_AttributeScaleId]) REFERENCES [dbo].[Entegre_Etsy_AttributeScales]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Etsy_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_Etsy_AttributeAttributeValueEntegre_Etsy_Attribute] FOREIGN KEY ([Entegre_Etsy_AttributeId]) REFERENCES [dbo].[Entegre_Etsy_Attributes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Etsy_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_Etsy_AttributeAttributeValueEntegre_Etsy_Category] FOREIGN KEY ([Entegre_Etsy_CategoryId]) REFERENCES [dbo].[Entegre_Etsy_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Etsy_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_Etsy_AttributeValueEntegre_Etsy_AttributeAttributeValue] FOREIGN KEY ([Entegre_Etsy_AttributeValueId]) REFERENCES [dbo].[Entegre_Etsy_AttributeValues]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Etsy_Categories] ADD CONSTRAINT [FK_Entegre_Etsy_CategoryEntegre_Etsy_Category] FOREIGN KEY ([ParentId]) REFERENCES [dbo].[Entegre_Etsy_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Etsy_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_Etsy_CategoryAttributeEntegre_Etsy_Attribute] FOREIGN KEY ([Entegre_Etsy_AttributeId]) REFERENCES [dbo].[Entegre_Etsy_Attributes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Etsy_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_Etsy_CategoryAttributeEntegre_Etsy_Category] FOREIGN KEY ([Entegre_Etsy_CategoryId]) REFERENCES [dbo].[Entegre_Etsy_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Flo_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_Flo_AttributeEntegre_Flo_AttributeAttributeValue] FOREIGN KEY ([Entegre_Flo_AttributeId]) REFERENCES [dbo].[Entegre_Flo_Attributes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Flo_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_Flo_AttributeValueEntegre_Flo_AttributeAttributeValue] FOREIGN KEY ([Entegre_Flo_AttributeValueId]) REFERENCES [dbo].[Entegre_Flo_AttributeValues]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Flo_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_Flo_CategoryEntegre_Flo_AttributeAttributeValue] FOREIGN KEY ([Entegre_Flo_CategoryId]) REFERENCES [dbo].[Entegre_Flo_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Flo_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_Flo_AttributeEntegre_Flo_CategoryAttribute] FOREIGN KEY ([Entegre_Flo_AttributeId]) REFERENCES [dbo].[Entegre_Flo_Attributes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Flo_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_Flo_CategoryAttributeEntegre_Flo_Category] FOREIGN KEY ([Entegre_Flo_CategoryId]) REFERENCES [dbo].[Entegre_Flo_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Fruugo_Categories] ADD CONSTRAINT [FK_Entegre_Fruugo_CategoryEntegre_Fruugo_Category] FOREIGN KEY ([ParentId]) REFERENCES [dbo].[Entegre_Fruugo_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_GG_CategorySpecs] ADD CONSTRAINT [FK_Entegre_GG_CategoryEntegre_GG_CategorySpec] FOREIGN KEY ([Entegre_GG_CategoryCode]) REFERENCES [dbo].[Entegre_GG_Categories]([Code]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_GG_CategorySpecs] ADD CONSTRAINT [FK_Entegre_GG_SpecEntegre_GG_CategorySpec] FOREIGN KEY ([Entegre_GG_SpecId]) REFERENCES [dbo].[Entegre_GG_Specs]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_GG_CategoryVariants] ADD CONSTRAINT [FK_Entegre_GG_CategoryEntegre_GG_CategoryVariant] FOREIGN KEY ([Entegre_GG_CategoryCode]) REFERENCES [dbo].[Entegre_GG_Categories]([Code]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_GG_CategoryVariants] ADD CONSTRAINT [FK_Entegre_GG_VariantEntegre_GG_CategoryVariant] FOREIGN KEY ([Entegre_GG_VariantId]) REFERENCES [dbo].[Entegre_GG_Variants]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_GG_Messages] ADD CONSTRAINT [FK_CustomerECommerceKeyEntegre_GG_Message] FOREIGN KEY ([CustomerECommerceKeyId]) REFERENCES [dbo].[CustomerECommerceKeys]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_GG_Messages] ADD CONSTRAINT [FK_CustomerEntegre_GG_Message] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_GG_SpecSpecValues] ADD CONSTRAINT [FK_Entegre_GG_SpecEntegre_GG_SpecSpecValue] FOREIGN KEY ([Entegre_GG_SpecId]) REFERENCES [dbo].[Entegre_GG_Specs]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_GG_SpecSpecValues] ADD CONSTRAINT [FK_Entegre_GG_SpecValueEntegre_GG_SpecSpecValue] FOREIGN KEY ([Entegre_GG_SpecValueId]) REFERENCES [dbo].[Entegre_GG_SpecValues]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_GG_VariantVariantValues] ADD CONSTRAINT [FK_Entegre_GG_VariantEntegre_GG_VariantVariantValue] FOREIGN KEY ([Entegre_GG_VariantId]) REFERENCES [dbo].[Entegre_GG_Variants]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_GG_VariantVariantValues] ADD CONSTRAINT [FK_Entegre_GG_VariantValueEntegre_GG_VariantVariantValue] FOREIGN KEY ([Entegre_GG_VariantValueId]) REFERENCES [dbo].[Entegre_GG_VariantValues]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Google_Categories] ADD CONSTRAINT [FK_Entegre_Google_CategoryEntegre_Google_Category] FOREIGN KEY ([ParentId]) REFERENCES [dbo].[Entegre_Google_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_HB_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_HB_AttributeEntegre_HB_AttributeAttributeValue] FOREIGN KEY ([Entegre_HB_AttributeId]) REFERENCES [dbo].[Entegre_HB_Attributes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_HB_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_HB_AttributeValueEntegre_HB_AttributeAttributeValue] FOREIGN KEY ([Entegre_HB_AttributeValueId]) REFERENCES [dbo].[Entegre_HB_AttributeValues]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_HB_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_HB_AttributeEntegre_HB_CategoryAttribute] FOREIGN KEY ([Entegre_HB_AttributeId]) REFERENCES [dbo].[Entegre_HB_Attributes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_HB_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_HB_CategoryEntegre_HB_CategoryAttribute] FOREIGN KEY ([Entegre_HB_CategoryId]) REFERENCES [dbo].[Entegre_HB_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_HB_CategoryVariants] ADD CONSTRAINT [FK_Entegre_HB_CategoryEntegre_HB_CategoryVariant] FOREIGN KEY ([Entegre_HB_CategoryId]) REFERENCES [dbo].[Entegre_HB_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_HB_CategoryVariants] ADD CONSTRAINT [FK_Entegre_HB_VariantEntegre_HB_CategoryVariant] FOREIGN KEY ([Entegre_HB_VariantId]) REFERENCES [dbo].[Entegre_HB_Variants]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_HB_Question_Conversations] ADD CONSTRAINT [FK_Entegre_HB_Question_ConversationEntegre_HB_Question] FOREIGN KEY ([Entegre_HB_QuestionId]) REFERENCES [dbo].[Entegre_HB_Questions]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_HB_Questions] ADD CONSTRAINT [FK_Entegre_HB_QuestionCustomer] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_HB_Questions] ADD CONSTRAINT [FK_Entegre_HB_QuestionCustomerECommerceKey] FOREIGN KEY ([CustomerECommerceKeyId]) REFERENCES [dbo].[CustomerECommerceKeys]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_HB_VariantVariantValues] ADD CONSTRAINT [FK_Entegre_HB_VariantEntegre_HB_VariantVariantValue] FOREIGN KEY ([Entegre_HB_VariantId]) REFERENCES [dbo].[Entegre_HB_Variants]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_HB_VariantVariantValues] ADD CONSTRAINT [FK_Entegre_HB_VariantValueEntegre_HB_VariantVariantValue] FOREIGN KEY ([Entegre_HB_VariantValueId]) REFERENCES [dbo].[Entegre_HB_VariantValues]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_HG_Categories] ADD CONSTRAINT [FK_Entegre_HG_CategoryEntegre_HG_Category] FOREIGN KEY ([ParentId]) REFERENCES [dbo].[Entegre_HG_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_HG_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_HG_AttributeEntegre_HG_CategoryAttribute] FOREIGN KEY ([Entegre_HG_AttributeId]) REFERENCES [dbo].[Entegre_HG_Attributes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_HG_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_HG_CategoryEntegre_HG_CategoryAttribute] FOREIGN KEY ([Entegre_HG_CategoryId]) REFERENCES [dbo].[Entegre_HG_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_IC_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_IC_AttributeEntegre_IC_AttributeAttributeValue] FOREIGN KEY ([Entegre_IC_AttributeId]) REFERENCES [dbo].[Entegre_IC_Attributes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_IC_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_IC_AttributeValueEntegre_IC_AttributeAttributeValue] FOREIGN KEY ([Entegre_IC_AttributeValueId]) REFERENCES [dbo].[Entegre_IC_AttributeValues]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_IC_BrandBrandModels] ADD CONSTRAINT [FK_Entegre_IC_BrandEntegre_IC_BrandBrandModels] FOREIGN KEY ([Entegre_IC_BrandId]) REFERENCES [dbo].[Entegre_IC_Brands]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_IC_BrandBrandModels] ADD CONSTRAINT [FK_Entegre_IC_BrandModelEntegre_IC_BrandBrandModels] FOREIGN KEY ([Entegre_IC_BrandModelId]) REFERENCES [dbo].[Entegre_IC_BrandModels]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_IC_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_IC_AttributeEntegre_IC_CategoryAttribute] FOREIGN KEY ([Entegre_IC_AttributeId]) REFERENCES [dbo].[Entegre_IC_Attributes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_IC_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_IC_CategoryEntegre_IC_CategoryAttribute] FOREIGN KEY ([Entegre_IC_CategoryId]) REFERENCES [dbo].[Entegre_IC_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_IC_CategoryBrands] ADD CONSTRAINT [FK_Entegre_IC_BrandEntegre_IC_CategoryBrand] FOREIGN KEY ([Entegre_IC_BrandId]) REFERENCES [dbo].[Entegre_IC_Brands]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_IC_CategoryBrands] ADD CONSTRAINT [FK_Entegre_IC_CategoryEntegre_IC_CategoryBrand] FOREIGN KEY ([Entegre_IC_CategoryId]) REFERENCES [dbo].[Entegre_IC_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Idefix_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_Idefix_AttributeEntegre_Idefix_AttributeAttributeValue] FOREIGN KEY ([Entegre_Idefix_AttributeId]) REFERENCES [dbo].[Entegre_Idefix_Attributes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Idefix_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_Idefix_AttributeValueEntegre_Idefix_AttributeAttributeValue] FOREIGN KEY ([Entegre_Idefix_AttributeValueId]) REFERENCES [dbo].[Entegre_Idefix_AttributeValues]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Idefix_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_Idefix_CategoryEntegre_Idefix_AttributeAttributeValue] FOREIGN KEY ([Entegre_Idefix_CategoryId]) REFERENCES [dbo].[Entegre_Idefix_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Idefix_Categories] ADD CONSTRAINT [FK_Entegre_Idefix_CategoryEntegre_Idefix_Category] FOREIGN KEY ([ParentId]) REFERENCES [dbo].[Entegre_Idefix_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Idefix_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_Idefix_AttributeEntegre_Idefix_CategoryAttribute] FOREIGN KEY ([Entegre_Idefix_AttributeId]) REFERENCES [dbo].[Entegre_Idefix_Attributes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Idefix_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_Idefix_CategoryEntegre_Idefix_CategoryAttribute] FOREIGN KEY ([Entegre_Idefix_CategoryId]) REFERENCES [dbo].[Entegre_Idefix_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_LB_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_LB_AttributeAttributeValueEntegre_LB_Attribute] FOREIGN KEY ([Entegre_LB_AttributeId]) REFERENCES [dbo].[Entegre_LB_Attributes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_LB_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_LB_AttributeAttributeValueEntegre_LB_AttributeValue] FOREIGN KEY ([Entegre_LB_AttributeValueId]) REFERENCES [dbo].[Entegre_LB_AttributeValues]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_LB_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_LB_CategoryAttributeEntegre_LB_Attribute] FOREIGN KEY ([Entegre_LB_AttributeId]) REFERENCES [dbo].[Entegre_LB_Attributes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_LB_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_LB_CategoryAttributeEntegre_LB_Category] FOREIGN KEY ([Entegre_LB_CategoryId]) REFERENCES [dbo].[Entegre_LB_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_MoNi_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_MoNi_AttributeEntegre_MoNi_AttributeAttributeValue] FOREIGN KEY ([Entegre_MoNi_AttributeId]) REFERENCES [dbo].[Entegre_MoNi_Attributes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_MoNi_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_MoNi_AttributeValueEntegre_MoNi_AttributeAttributeValue] FOREIGN KEY ([Entegre_MoNi_AttributeValueId]) REFERENCES [dbo].[Entegre_MoNi_AttributeValues]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_MoNi_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_MoNi_CategoryEntegre_MoNi_AttributeAttributeValue] FOREIGN KEY ([Entegre_MoNi_CategoryId]) REFERENCES [dbo].[Entegre_MoNi_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_MoNi_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_MoNi_AttributeEntegre_MoNi_CategoryAttribute] FOREIGN KEY ([Entegre_MoNi_AttributeId]) REFERENCES [dbo].[Entegre_MoNi_Attributes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_MoNi_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_MoNi_CategoryEntegre_MoNi_CategoryAttribute] FOREIGN KEY ([Entegre_MoNi_CategoryId]) REFERENCES [dbo].[Entegre_MoNi_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_MoNi_CategoryVariants] ADD CONSTRAINT [FK_Entegre_MoNi_CategoryEntegre_MoNi_CategoryVariant] FOREIGN KEY ([Entegre_MoNi_CategoryId]) REFERENCES [dbo].[Entegre_MoNi_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_MoNi_CategoryVariants] ADD CONSTRAINT [FK_Entegre_MoNi_VariantEntegre_MoNi_CategoryVariant] FOREIGN KEY ([Entegre_MoNi_VariantId]) REFERENCES [dbo].[Entegre_MoNi_Variants]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_MoNi_VariantVariantValues] ADD CONSTRAINT [FK_Entegre_MoNi_CategoryEntegre_MoNi_VariantVariantValue] FOREIGN KEY ([Entegre_MoNi_CategoryId]) REFERENCES [dbo].[Entegre_MoNi_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_MoNi_VariantVariantValues] ADD CONSTRAINT [FK_Entegre_MoNi_VariantEntegre_MoNi_VariantVariantValue] FOREIGN KEY ([Entegre_MoNi_VariantId]) REFERENCES [dbo].[Entegre_MoNi_Variants]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_MoNi_VariantVariantValues] ADD CONSTRAINT [FK_Entegre_MoNi_VariantValueEntegre_MoNi_VariantVariantValue] FOREIGN KEY ([Entegre_MoNi_VariantValueId]) REFERENCES [dbo].[Entegre_MoNi_VariantValues]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_N11_AttributeValues] ADD CONSTRAINT [FK_Entegre_N11_AttributeValueEntegre_N11_Attribute] FOREIGN KEY ([Entegre_N11_AttributeId]) REFERENCES [dbo].[Entegre_N11_Attributes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_N11_Categories] ADD CONSTRAINT [FK_N11CategoryN11Category] FOREIGN KEY ([ParentId]) REFERENCES [dbo].[Entegre_N11_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_N11_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_N11_AttributeEntegre_N11_CategoryAttribute] FOREIGN KEY ([Entegre_N11_AttributeId]) REFERENCES [dbo].[Entegre_N11_Attributes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_N11_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_N11_CategoryEntegre_N11_CategoryAttribute] FOREIGN KEY ([Entegre_N11_CategoryId]) REFERENCES [dbo].[Entegre_N11_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_N11_Questions] ADD CONSTRAINT [FK_CustomerECommerceKeyEntegre_N11_Question] FOREIGN KEY ([CustomerECommerceKeyId]) REFERENCES [dbo].[CustomerECommerceKeys]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_N11_Questions] ADD CONSTRAINT [FK_CustomerEntegre_N11_Question] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_N11_Questions] ADD CONSTRAINT [FK_Entegre_ProductECommerceEntegre_N11_Question] FOREIGN KEY ([Entegre_ProductECommerceId]) REFERENCES [dbo].[Entegre_ProductECommerces]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_N11Pro_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_N11Pro_AttributeEntegre_N11Pro_CategoryAttribute] FOREIGN KEY ([Entegre_N11Pro_AttributeId]) REFERENCES [dbo].[Entegre_N11Pro_Attributes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_N11Pro_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_N11Pro_CategoryEntegre_N11Pro_CategoryAttribute] FOREIGN KEY ([Entegre_N11Pro_CategoryId]) REFERENCES [dbo].[Entegre_N11Pro_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_OnBuy_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_OnBuy_AttributeEntegre_OnBuy_AttributeAttributeValue] FOREIGN KEY ([Entegre_OnBuy_AttributeId]) REFERENCES [dbo].[Entegre_OnBuy_Attributes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_OnBuy_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_OnBuy_AttributeValueEntegre_OnBuy_AttributeAttributeValue] FOREIGN KEY ([Entegre_OnBuy_AttributeValueId]) REFERENCES [dbo].[Entegre_OnBuy_AttributeValues]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_OnBuy_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_OnBuy_CategoryEntegre_OnBuy_AttributeAttributeValue] FOREIGN KEY ([Entegre_OnBuy_CategoryId]) REFERENCES [dbo].[Entegre_OnBuy_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_OnBuy_Categories] ADD CONSTRAINT [FK_Entegre_OnBuy_CategoryEntegre_OnBuy_Category] FOREIGN KEY ([ParentId]) REFERENCES [dbo].[Entegre_OnBuy_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_OnBuy_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_OnBuy_AttributeEntegre_OnBuy_CategoryAttribute] FOREIGN KEY ([Entegre_OnBuy_AttributeId]) REFERENCES [dbo].[Entegre_OnBuy_Attributes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_OnBuy_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_OnBuy_CategoryEntegre_OnBuy_CategoryAttribute] FOREIGN KEY ([Entegre_OnBuy_CategoryId]) REFERENCES [dbo].[Entegre_OnBuy_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_OnBuy_CategoryVariants] ADD CONSTRAINT [FK_Entegre_OnBuy_CategoryEntegre_OnBuy_CategoryVariant] FOREIGN KEY ([Entegre_OnBuy_CategoryId]) REFERENCES [dbo].[Entegre_OnBuy_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_OnBuy_CategoryVariants] ADD CONSTRAINT [FK_Entegre_OnBuy_VariantEntegre_OnBuy_CategoryVariant] FOREIGN KEY ([Entegre_OnBuy_VariantId]) REFERENCES [dbo].[Entegre_OnBuy_Variants]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_OnBuy_VariantVariantValues] ADD CONSTRAINT [FK_Entegre_OnBuy_CategoryEntegre_OnBuy_VariantVariantValue] FOREIGN KEY ([Entegre_OnBuy_CategoryId]) REFERENCES [dbo].[Entegre_OnBuy_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_OnBuy_VariantVariantValues] ADD CONSTRAINT [FK_Entegre_OnBuy_VariantEntegre_OnBuy_VariantVariantValue] FOREIGN KEY ([Entegre_OnBuy_VariantId]) REFERENCES [dbo].[Entegre_OnBuy_Variants]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_OnBuy_VariantVariantValues] ADD CONSTRAINT [FK_Entegre_OnBuy_VariantValueEntegre_OnBuy_VariantVariantValue] FOREIGN KEY ([Entegre_OnBuy_VariantValueId]) REFERENCES [dbo].[Entegre_OnBuy_VariantValues]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Ozon_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_Ozon_AttributeEntegre_Ozon_AttributeAttributeValue] FOREIGN KEY ([Entegre_Ozon_AttributeId]) REFERENCES [dbo].[Entegre_Ozon_Attributes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Ozon_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_Ozon_AttributeValueEntegre_Ozon_AttributeAttributeValue] FOREIGN KEY ([Entegre_Ozon_AttributeValueId]) REFERENCES [dbo].[Entegre_Ozon_AttributeValues]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Ozon_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_Ozon_CategoryEntegre_Ozon_AttributeAttributeValue] FOREIGN KEY ([Entegre_Ozon_CategoryId]) REFERENCES [dbo].[Entegre_Ozon_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Ozon_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_Ozon_AttributeEntegre_Ozon_CategoryAttribute] FOREIGN KEY ([Entegre_Ozon_AttributeId]) REFERENCES [dbo].[Entegre_Ozon_Attributes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Ozon_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_Ozon_CategoryEntegre_Ozon_CategoryAttribute] FOREIGN KEY ([Entegre_Ozon_CategoryId]) REFERENCES [dbo].[Entegre_Ozon_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Ozon_Messages] ADD CONSTRAINT [FK_CustomerECommerceKeyEntegre_Ozon_Message] FOREIGN KEY ([CustomerECommerceKeyId]) REFERENCES [dbo].[CustomerECommerceKeys]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Ozon_Messages] ADD CONSTRAINT [FK_CustomerEntegre_Ozon_Message] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Pazarama_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_Pazarama_AttributeAttributeValueEntegre_Pazarama_Attribute] FOREIGN KEY ([Entegre_Pazarama_AttributeId]) REFERENCES [dbo].[Entegre_Pazarama_Attributes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Pazarama_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_Pazarama_AttributeAttributeValueEntegre_Pazarama_AttributeValue] FOREIGN KEY ([Entegre_Pazarama_AttributeValueId]) REFERENCES [dbo].[Entegre_Pazarama_AttributeValues]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Pazarama_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_Pazarama_CategoryEntegre_Pazarama_AttributeAttributeValue] FOREIGN KEY ([Entegre_Pazarama_CategoryId]) REFERENCES [dbo].[Entegre_Pazarama_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Pazarama_Categories] ADD CONSTRAINT [FK_Entegre_Pazarama_CategoryEntegre_Pazarama_Category] FOREIGN KEY ([ParentId]) REFERENCES [dbo].[Entegre_Pazarama_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Pazarama_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_Pazarama_CategoryAttributeEntegre_Pazarama_Attribute] FOREIGN KEY ([Entegre_Pazarama_AttributeId]) REFERENCES [dbo].[Entegre_Pazarama_Attributes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_Pazarama_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_Pazarama_CategoryAttributeEntegre_Pazarama_Category] FOREIGN KEY ([Entegre_Pazarama_CategoryId]) REFERENCES [dbo].[Entegre_Pazarama_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_PraStore_Categories] ADD CONSTRAINT [FK_Entegre_PraStore_CategoryCustomerECommerceKey] FOREIGN KEY ([CustomerECommerceKeyId]) REFERENCES [dbo].[CustomerECommerceKeys]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_ProductECommerce_Attributes] ADD CONSTRAINT [FK_Entegre_ProductECommerceEntegre_ProductECommerce_Attribute] FOREIGN KEY ([Entegre_ProductECommerceId]) REFERENCES [dbo].[Entegre_ProductECommerces]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_ProductECommerce_CompetitionAnalyses] ADD CONSTRAINT [FK_CustomerEntegre_ProductECommerce_CompetitionAnalysis] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_ProductECommerce_CompetitionAnalyses] ADD CONSTRAINT [FK_Entegre_ProductECommerceEntegre_ProductECommerce_CompetitionAnalysis] FOREIGN KEY ([Entegre_ProductECommerceId]) REFERENCES [dbo].[Entegre_ProductECommerces]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_ProductECommerce_DescriptionTemplates] ADD CONSTRAINT [FK_DescriptionTemplateEntegre_ProductECommerce_DescriptionTemplate] FOREIGN KEY ([DescriptionTemplateId]) REFERENCES [dbo].[DescriptionTemplates]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_ProductECommerce_DescriptionTemplates] ADD CONSTRAINT [FK_Entegre_ProductECommerceEntegre_ProductECommerce_DescriptionTemplate] FOREIGN KEY ([Entegre_ProductECommerceId]) REFERENCES [dbo].[Entegre_ProductECommerces]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_ProductECommerce_Histories] ADD CONSTRAINT [FK_IntegratedECommerceEntegre_ProductECommerce_History] FOREIGN KEY ([IntegratedECommerceCode]) REFERENCES [dbo].[IntegratedECommerces]([Code]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_ProductECommerce_Histories] ADD CONSTRAINT [FK_ProductEntegre_ProductECommerce_History] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Products]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_ProductECommerce_Images] ADD CONSTRAINT [FK_Entegre_ProductECommerceEntegre_ProductECommerce_Image] FOREIGN KEY ([Entegre_ProductECommerceId]) REFERENCES [dbo].[Entegre_ProductECommerces]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_ProductECommerce_Images] ADD CONSTRAINT [FK_ProductImageEntegre_ProductECommerce_Image] FOREIGN KEY ([ProductImageId]) REFERENCES [dbo].[ProductImages]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_ProductECommerce_Jobs] ADD CONSTRAINT [FK_CustomerEntegre_ProductECommerce_Job] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_ProductECommerce_Jobs] ADD CONSTRAINT [FK_Entegre_ProductECommerceEntegre_ProductECommerce_Job] FOREIGN KEY ([Entegre_ProductECommerceId]) REFERENCES [dbo].[Entegre_ProductECommerces]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_ProductECommerce_Jobs] ADD CONSTRAINT [FK_IntegratedECommerceEntegre_ProductECommerce_Job] FOREIGN KEY ([IntegratedECommerceCode]) REFERENCES [dbo].[IntegratedECommerces]([Code]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_ProductECommerce_ShipmentCompanies] ADD CONSTRAINT [FK_Entegre_ProductECommerceEntegre_ProductECommerce_ShipmentCompany] FOREIGN KEY ([Entegre_ProductECommerceId]) REFERENCES [dbo].[Entegre_ProductECommerces]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_ProductECommerce_ShipmentCompanies] ADD CONSTRAINT [FK_ShipmentCompanyEntegre_ProductECommerce_ShipmentCompany] FOREIGN KEY ([ShipmentCompanyId]) REFERENCES [dbo].[ShipmentCompanies]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_ProductECommerce_Variant_Details] ADD CONSTRAINT [FK_Entegre_ProductECommerce_VariantEntegre_ProductECommerce_Variant_Detail] FOREIGN KEY ([Entegre_ProductECommerce_VariantId]) REFERENCES [dbo].[Entegre_ProductECommerce_Variants]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_ProductECommerce_Variant_Images] ADD CONSTRAINT [FK_Entegre_ProductECommerce_VariantEntegre_ProductECommerce_Variant_Image] FOREIGN KEY ([Entegre_ProductECommerce_VariantId]) REFERENCES [dbo].[Entegre_ProductECommerce_Variants]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_ProductECommerce_Variant_Images] ADD CONSTRAINT [FK_ProductImageEntegre_ProductECommerce_Variant_Image] FOREIGN KEY ([ProductImageId]) REFERENCES [dbo].[ProductImages]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_ProductECommerce_Variants] ADD CONSTRAINT [FK_Entegre_ProductECommerceEntegre_ProductECommerce_Variant] FOREIGN KEY ([Entegre_ProductECommerceId]) REFERENCES [dbo].[Entegre_ProductECommerces]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_ProductECommerce_Variants] ADD CONSTRAINT [FK_ProductVariantGroupEntegre_ProductECommerce_Variant] FOREIGN KEY ([ProductVariantGroupId]) REFERENCES [dbo].[ProductVariantGroups]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_ProductECommerces] ADD CONSTRAINT [FK_CurrencyEntegre_ProductECommerce] FOREIGN KEY ([CurrencyId]) REFERENCES [dbo].[Currencies]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_ProductECommerces] ADD CONSTRAINT [FK_CustomerECommerceKeyEntegre_ProductECommerce] FOREIGN KEY ([CustomerECommerceKeyId]) REFERENCES [dbo].[CustomerECommerceKeys]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_ProductECommerces] ADD CONSTRAINT [FK_CustomerEntegre_ProductECommerce] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_ProductECommerces] ADD CONSTRAINT [FK_Entegre_ProductECommerceCurrency] FOREIGN KEY ([SourceCurrencyId]) REFERENCES [dbo].[Currencies]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_ProductECommerces] ADD CONSTRAINT [FK_IntegratedECommerceEntegre_ProductECommerce] FOREIGN KEY ([IntegratedECommerceCode]) REFERENCES [dbo].[IntegratedECommerces]([Code]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_ProductECommerces] ADD CONSTRAINT [FK_ProductDescriptionEntegre_ProductECommerce] FOREIGN KEY ([ProductDescriptionId]) REFERENCES [dbo].[ProductDescriptions]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_ProductECommerces] ADD CONSTRAINT [FK_ProductEntegre_ProductECommerce] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Products]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_ProductECommerces_CampaignStocks] ADD CONSTRAINT [FK_Entegre_ProductECommerces_CampaignStockEntegre_ProductECommerce] FOREIGN KEY ([Entegre_ProductECommerceId]) REFERENCES [dbo].[Entegre_ProductECommerces]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_ProductECommerces_CampaignStocks] ADD CONSTRAINT [FK_Entegre_ProductECommerces_CampaignStockEntegre_ProductECommerce_Variant] FOREIGN KEY ([Entegre_ProductECommerce_VariantId]) REFERENCES [dbo].[Entegre_ProductECommerce_Variants]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_ShipmentCompanies] ADD CONSTRAINT [FK_IntegratedECommerceEntegre_ShipmentCompany] FOREIGN KEY ([IntegratedECommerceCode]) REFERENCES [dbo].[IntegratedECommerces]([Code]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_ShipmentCompanies] ADD CONSTRAINT [FK_ShipmentCompanyEntegre_ShipmentCompany] FOREIGN KEY ([ShipmentCompanyId]) REFERENCES [dbo].[ShipmentCompanies]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_SP_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_SP_AttributeEntegre_SP_AttributeAttributeValue] FOREIGN KEY ([Entegre_SP_AttributeId]) REFERENCES [dbo].[Entegre_SP_Attributes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_SP_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_SP_AttributeValueEntegre_SP_AttributeAttributeValue] FOREIGN KEY ([Entegre_SP_AttributeValueId]) REFERENCES [dbo].[Entegre_SP_AttributeValues]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_SP_Categories] ADD CONSTRAINT [FK_Entegre_SP_CategoryEntegre_SP_Category] FOREIGN KEY ([ParentId]) REFERENCES [dbo].[Entegre_SP_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_SP_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_SP_AttributeEntegre_SP_CategoryAttribute] FOREIGN KEY ([Entegre_SP_AttributeId]) REFERENCES [dbo].[Entegre_SP_Attributes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_SP_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_SP_CategoryEntegre_SP_CategoryAttribute] FOREIGN KEY ([Entegre_SP_CategoryId]) REFERENCES [dbo].[Entegre_SP_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_SP_CategoryVariants] ADD CONSTRAINT [FK_Entegre_SP_CategoryEntegre_SP_CategoryVariant] FOREIGN KEY ([Entegre_SP_CategoryId]) REFERENCES [dbo].[Entegre_SP_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_SP_CategoryVariants] ADD CONSTRAINT [FK_Entegre_SP_VariantEntegre_SP_CategoryVariant] FOREIGN KEY ([Entegre_SP_VariantId]) REFERENCES [dbo].[Entegre_SP_Variants]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_SP_VariantVariantValues] ADD CONSTRAINT [FK_Entegre_SP_VariantEntegre_SP_VariantVariantValue] FOREIGN KEY ([Entegre_SP_VariantId]) REFERENCES [dbo].[Entegre_SP_Variants]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_SP_VariantVariantValues] ADD CONSTRAINT [FK_Entegre_SP_VariantValueEntegre_SP_VariantVariantValue] FOREIGN KEY ([Entegre_SP_VariantValueId]) REFERENCES [dbo].[Entegre_SP_VariantValues]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_TO_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_TO_AttributeEntegre_TO_AttributeAttributeValue] FOREIGN KEY ([Entegre_TO_AttributeId]) REFERENCES [dbo].[Entegre_TO_Attributes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_TO_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_TO_AttributeValueEntegre_TO_AttributeAttributeValue] FOREIGN KEY ([Entegre_TO_AttributeValueId]) REFERENCES [dbo].[Entegre_TO_AttributeValues]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_TO_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_TO_CategoryEntegre_TO_AttributeAttributeValue] FOREIGN KEY ([Entegre_TO_CategoryId]) REFERENCES [dbo].[Entegre_TO_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_TO_Categories] ADD CONSTRAINT [FK_Entegre_TO_CategoryEntegre_TO_Category] FOREIGN KEY ([ParentId]) REFERENCES [dbo].[Entegre_TO_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_TO_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_TO_AttributeEntegre_TO_CategoryAttribute] FOREIGN KEY ([Entegre_TO_AttributeId]) REFERENCES [dbo].[Entegre_TO_Attributes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_TO_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_TO_CategoryEntegre_TO_CategoryAttribute] FOREIGN KEY ([Entegre_TO_CategoryId]) REFERENCES [dbo].[Entegre_TO_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_TO_Questions] ADD CONSTRAINT [FK_Entegre_TO_QuestionCustomer] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_TO_Questions] ADD CONSTRAINT [FK_Entegre_TO_QuestionCustomerECommerceKey] FOREIGN KEY ([CustomerECommerceKeyId]) REFERENCES [dbo].[CustomerECommerceKeys]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_VFM_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_VFM_AttributeEntegre_VFM_AttributeAttributeValue] FOREIGN KEY ([Entegre_VFM_AttributeId]) REFERENCES [dbo].[Entegre_VFM_Attributes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_VFM_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_VFM_AttributeValueEntegre_VFM_AttributeAttributeValue] FOREIGN KEY ([Entegre_VFM_AttributeValueId]) REFERENCES [dbo].[Entegre_VFM_AttributeValues]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_VFM_AttributeAttributeValues] ADD CONSTRAINT [FK_Entegre_VFM_CategoryEntegre_VFM_AttributeAttributeValue] FOREIGN KEY ([Entegre_VFM_CategoryId]) REFERENCES [dbo].[Entegre_VFM_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_VFM_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_VFM_AttributeEntegre_VFM_CategoryAttribute] FOREIGN KEY ([Entegre_VFM_AttributeId]) REFERENCES [dbo].[Entegre_VFM_Attributes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Entegre_VFM_CategoryAttributes] ADD CONSTRAINT [FK_Entegre_VFM_CategoryEntegre_VFM_CategoryAttribute] FOREIGN KEY ([Entegre_VFM_CategoryId]) REFERENCES [dbo].[Entegre_VFM_Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[FedExCities] ADD CONSTRAINT [FK_FedExCountryFedExCity] FOREIGN KEY ([FedExCountryCode]) REFERENCES [dbo].[FedExCountries]([Code]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[InvoiceAddresses] ADD CONSTRAINT [FK_InvoiceAddressCountry] FOREIGN KEY ([CountryIso2]) REFERENCES [dbo].[Countries]([Iso2]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[NotificationTypeDescriptions] ADD CONSTRAINT [FK_NotificationTypeDescriptionLanguage] FOREIGN KEY ([LanguageId]) REFERENCES [dbo].[Languages]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[NotificationTypeDescriptions] ADD CONSTRAINT [FK_NotificationTypeDescriptionNotificationType] FOREIGN KEY ([NotificationTypeId]) REFERENCES [dbo].[NotificationTypes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[OrderLineCustomTextOptions] ADD CONSTRAINT [FK_OrderLineOrderLineCustomTextOption] FOREIGN KEY ([OrderLineId]) REFERENCES [dbo].[OrderLines]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[OrderLineKeyValues] ADD CONSTRAINT [FK_OrderLineKeyValueOrderLine] FOREIGN KEY ([OrderLineId]) REFERENCES [dbo].[OrderLines]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[OrderLinePhantomLines] ADD CONSTRAINT [FK_OrderLinePhantomLineCurrency] FOREIGN KEY ([CurrencyId]) REFERENCES [dbo].[Currencies]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[OrderLinePhantomLines] ADD CONSTRAINT [FK_OrderLinePhantomLineOrderLine] FOREIGN KEY ([OrderLineId]) REFERENCES [dbo].[OrderLines]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[OrderLinePhantomLines] ADD CONSTRAINT [FK_OrderLinePhantomLineProduct] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Products]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[OrderLinePhantomLines] ADD CONSTRAINT [FK_OrderLinePhantomLineProductVariantGroup] FOREIGN KEY ([ProductVariantGroupId]) REFERENCES [dbo].[ProductVariantGroups]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[OrderLinePhantomLines] ADD CONSTRAINT [FK_OrderLinePhantomLineUnitType] FOREIGN KEY ([UnitTypeId]) REFERENCES [dbo].[UnitTypes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[OrderLinePhantomLines] ADD CONSTRAINT [FK_OrderLinePhantomLineVatRate] FOREIGN KEY ([VatRateId]) REFERENCES [dbo].[VatRates]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[OrderLines] ADD CONSTRAINT [FK_CurrencyOrderLine] FOREIGN KEY ([CurrencyId]) REFERENCES [dbo].[Currencies]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[OrderLines] ADD CONSTRAINT [FK_OrderLineCurrency] FOREIGN KEY ([ShipmentCurrencyId]) REFERENCES [dbo].[Currencies]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[OrderLines] ADD CONSTRAINT [FK_OrderLineProductVariantGroup] FOREIGN KEY ([ProductVariantGroupId]) REFERENCES [dbo].[ProductVariantGroups]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[OrderLines] ADD CONSTRAINT [FK_OrderOrderLine] FOREIGN KEY ([OrderId]) REFERENCES [dbo].[Orders]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[OrderLines] ADD CONSTRAINT [FK_ProductCurrency] FOREIGN KEY ([ProductCurrencyId]) REFERENCES [dbo].[Currencies]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[OrderLines] ADD CONSTRAINT [FK_ProductOrderLine] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Products]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[OrderLines] ADD CONSTRAINT [FK_UnitTypeOrderLine] FOREIGN KEY ([UnitTypeId]) REFERENCES [dbo].[UnitTypes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[OrderLines] ADD CONSTRAINT [FK_VatRateOrderLine] FOREIGN KEY ([VatRateId]) REFERENCES [dbo].[VatRates]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[OrderLineVariants] ADD CONSTRAINT [FK_OrderLineOrderLineVariant] FOREIGN KEY ([OrderLineId]) REFERENCES [dbo].[OrderLines]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Orders] ADD CONSTRAINT [FK_CustomerECommerceAccountingKeyId] FOREIGN KEY ([CustomerECommerceAccountingKeyId]) REFERENCES [dbo].[CustomerECommerceKeys]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Orders] ADD CONSTRAINT [FK_CustomerECommerceCargoKeyOrder] FOREIGN KEY ([CustomerECommerceCargoKeyId]) REFERENCES [dbo].[CustomerECommerceKeys]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Orders] ADD CONSTRAINT [FK_CustomerECommerceFulFillmentKeyOrder] FOREIGN KEY ([CustomerECommerceFulFillmentKeyId]) REFERENCES [dbo].[CustomerECommerceKeys]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Orders] ADD CONSTRAINT [FK_CustomerECommerceKeyOrder] FOREIGN KEY ([CustomerECommerceKeyId]) REFERENCES [dbo].[CustomerECommerceKeys]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Orders] ADD CONSTRAINT [FK_CustomerOrder] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Orders] ADD CONSTRAINT [FK_IntegratedAccountingECommerceCode] FOREIGN KEY ([IntegratedAccountingECommerceCode]) REFERENCES [dbo].[IntegratedECommerces]([Code]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Orders] ADD CONSTRAINT [FK_IntegratedECommerceCargoOrder] FOREIGN KEY ([IntegratedCargoECommerceCode]) REFERENCES [dbo].[IntegratedECommerces]([Code]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Orders] ADD CONSTRAINT [FK_IntegratedECommerceOrder] FOREIGN KEY ([IntegratedECommerceCode]) REFERENCES [dbo].[IntegratedECommerces]([Code]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Orders] ADD CONSTRAINT [FK_IntegratedFulFillmentECommerce] FOREIGN KEY ([IntegratedFulFillmentECommerceCode]) REFERENCES [dbo].[IntegratedECommerces]([Code]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Orders] ADD CONSTRAINT [FK_InvoiceAddressOrder] FOREIGN KEY ([InvoiceAddressId]) REFERENCES [dbo].[InvoiceAddresses]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Orders] ADD CONSTRAINT [FK_OrdereInvoice] FOREIGN KEY ([eInvoiceId]) REFERENCES [dbo].[eInvoices]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Orders] ADD CONSTRAINT [FK_OrderUser1] FOREIGN KEY ([AssignedUserId]) REFERENCES [dbo].[Users]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Orders] ADD CONSTRAINT [FK_OrderUser2] FOREIGN KEY ([PackedUserId]) REFERENCES [dbo].[Users]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Orders] ADD CONSTRAINT [FK_ShippingAddressOrder] FOREIGN KEY ([ShippingAddressId]) REFERENCES [dbo].[ShippingAddresses]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[OrderServiceItems] ADD CONSTRAINT [FK_CurrencyOrderServiceItem] FOREIGN KEY ([CurrencyId]) REFERENCES [dbo].[Currencies]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[OrderServiceItems] ADD CONSTRAINT [FK_OrderOrderServiceItem] FOREIGN KEY ([OrderId]) REFERENCES [dbo].[Orders]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[OrderServiceItems] ADD CONSTRAINT [FK_VatRateOrderServiceItem] FOREIGN KEY ([VatRateId]) REFERENCES [dbo].[VatRates]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[PackageExtras] ADD CONSTRAINT [FK_AuthActionForCustomerPackageExtras] FOREIGN KEY ([AuthActionForCustomerId]) REFERENCES [dbo].[AuthActionForCustomers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[PackageExtras] ADD CONSTRAINT [FK_PackagesPackageExtras] FOREIGN KEY ([PackagesId]) REFERENCES [dbo].[Packages]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Point_Districts] ADD CONSTRAINT [FK_Point_DistrictPoint_City] FOREIGN KEY ([Point_CityId]) REFERENCES [dbo].[Point_Cities]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ProductDescriptions] ADD CONSTRAINT [FK_ProductDescriptionProduct] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Products]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ProductImages] ADD CONSTRAINT [FK_ProductProductImage] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Products]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ProductPhantomLines] ADD CONSTRAINT [FK_ProductPhantomLineProduct] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Products]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ProductPhantomLines] ADD CONSTRAINT [FK_ProductPhantomLineProduct1] FOREIGN KEY ([PhantomProductId]) REFERENCES [dbo].[Products]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ProductPhantomLines] ADD CONSTRAINT [FK_ProductPhantomLineProductVariantGroup] FOREIGN KEY ([PhantomProductVariantGroupId]) REFERENCES [dbo].[ProductVariantGroups]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Products] ADD CONSTRAINT [FK_CategoryProduct] FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[Categories]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Products] ADD CONSTRAINT [FK_CurrencyProduct] FOREIGN KEY ([CurrencyId]) REFERENCES [dbo].[Currencies]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Products] ADD CONSTRAINT [FK_CustomerProduct] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Products] ADD CONSTRAINT [FK_ProductCurrency1] FOREIGN KEY ([MinSalePriceCurrencyId]) REFERENCES [dbo].[Currencies]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Products] ADD CONSTRAINT [FK_UnitTypeProduct] FOREIGN KEY ([UnitTypeId]) REFERENCES [dbo].[UnitTypes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Products] ADD CONSTRAINT [FK_VatRateProduct] FOREIGN KEY ([VatRateId]) REFERENCES [dbo].[VatRates]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ProductStockJobs] ADD CONSTRAINT [FK_ProductStockJobProduct] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Products]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ProductTags] ADD CONSTRAINT [FK_ProductTagProduct] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Products]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ProductTags] ADD CONSTRAINT [FK_ProductTagTag] FOREIGN KEY ([TagId]) REFERENCES [dbo].[Tags]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ProductVariantGroupImages] ADD CONSTRAINT [FK_ProductImageProductVariantGroupImage] FOREIGN KEY ([ProductImageId]) REFERENCES [dbo].[ProductImages]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ProductVariantGroupImages] ADD CONSTRAINT [FK_ProductVariantGroupProductVariantGroupImage] FOREIGN KEY ([ProductVariantGroupId]) REFERENCES [dbo].[ProductVariantGroups]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ProductVariantGroupPhantomLines] ADD CONSTRAINT [FK_ProductVariantGroupPhantomLineProduct] FOREIGN KEY ([PhantomProductId]) REFERENCES [dbo].[Products]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ProductVariantGroupPhantomLines] ADD CONSTRAINT [FK_ProductVariantGroupPhantomLineProductVariantGroup] FOREIGN KEY ([ProductVariantGroupId]) REFERENCES [dbo].[ProductVariantGroups]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ProductVariantGroupPhantomLines] ADD CONSTRAINT [FK_ProductVariantGroupPhantomLineProductVariantGroup1] FOREIGN KEY ([PhantomProductVariantGroupId]) REFERENCES [dbo].[ProductVariantGroups]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ProductVariantGroups] ADD CONSTRAINT [FK_ProductProductVariantGroup] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[Products]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ProductVariants] ADD CONSTRAINT [FK_ProductVariantGroupProductVariant] FOREIGN KEY ([ProductVariantGroupId]) REFERENCES [dbo].[ProductVariantGroups]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ProductVariants] ADD CONSTRAINT [FK_VariantProductVariant] FOREIGN KEY ([VariantId]) REFERENCES [dbo].[Variants]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ProductVariants] ADD CONSTRAINT [FK_VariantValueProductVariant] FOREIGN KEY ([VariantValueId]) REFERENCES [dbo].[VariantValues]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[SendeoDistricts] ADD CONSTRAINT [FK_SendeoCitySendeoDistrict] FOREIGN KEY ([SendeoCityId]) REFERENCES [dbo].[SendeoCities]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ShipmentLines] ADD CONSTRAINT [FK_OrderLineShipmentLine] FOREIGN KEY ([OrderLineId]) REFERENCES [dbo].[OrderLines]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ShipmentLines] ADD CONSTRAINT [FK_ShipmentShipmentLine] FOREIGN KEY ([ShipmentId]) REFERENCES [dbo].[Shipments]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ShipmentLines] ADD CONSTRAINT [FK_UnitTypeShipmentLine] FOREIGN KEY ([UnitTypeId]) REFERENCES [dbo].[UnitTypes]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ShipmentOrders] ADD CONSTRAINT [FK_OrderShipmentOrder] FOREIGN KEY ([OrderId]) REFERENCES [dbo].[Orders]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ShipmentOrders] ADD CONSTRAINT [FK_ShipmentShipmentOrder] FOREIGN KEY ([ShipmentId]) REFERENCES [dbo].[Shipments]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Shipments] ADD CONSTRAINT [FK_CurrencyShipment] FOREIGN KEY ([CurrencyId]) REFERENCES [dbo].[Currencies]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Shipments] ADD CONSTRAINT [FK_CustomerShipment] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Shipments] ADD CONSTRAINT [FK_ShipmentCompanyShipment] FOREIGN KEY ([ShipmentCompanyId]) REFERENCES [dbo].[ShipmentCompanies]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Shipments] ADD CONSTRAINT [FK_ShippingAddressShipment] FOREIGN KEY ([ShippingAddressId]) REFERENCES [dbo].[ShippingAddresses]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[ShippingAddresses] ADD CONSTRAINT [FK_ShippingAddressCountry] FOREIGN KEY ([CountryIso2]) REFERENCES [dbo].[Countries]([Iso2]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Tags] ADD CONSTRAINT [FK_TagCustomer] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[UpsAreas] ADD CONSTRAINT [FK_UpsAreaUpsCity] FOREIGN KEY ([UpsCityId]) REFERENCES [dbo].[UpsCities]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Users] ADD CONSTRAINT [FK_LanguageUser] FOREIGN KEY ([LanguageId]) REFERENCES [dbo].[Languages]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[Variants] ADD CONSTRAINT [FK_CustomerVariant] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[VariantValues] ADD CONSTRAINT [FK_CustomerVariantValue] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE [dbo].[VariantValues] ADD CONSTRAINT [FK_VariantVariantValue] FOREIGN KEY ([VariantId]) REFERENCES [dbo].[Variants]([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH

