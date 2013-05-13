if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Manage_User]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Manage_User]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[OrderList]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[OrderList]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[RegUser]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[RegUser]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[RegUser_Log_Money]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[RegUser_Log_Money]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ShopList]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ShopList]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[admin]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[admin]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[buy]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[buy]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[category]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[category]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[commodity_modify]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[commodity_modify]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[commodity_sort]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[commodity_sort]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[crm_customer_browse_history]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[crm_customer_browse_history]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[crm_customer_remark]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[crm_customer_remark]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[goods_id_creater]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[goods_id_creater]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[history_delete]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[history_delete]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[history_login]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[history_login]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[jxc_buy_brand]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[jxc_buy_brand]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[make_order]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[make_order]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[make_shoplist]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[make_shoplist]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[orderbook]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[orderbook]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[postage]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[postage]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[pround]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[pround]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[record_total_num]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[record_total_num]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[quehuo]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[quehuo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[returned]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[returned]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[seat]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[seat]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[seat_transfer]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[seat_transfer]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sold]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[sold]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[stock]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[stock]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[stock_modify]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[stock_modify]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tdl_tasklist]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tdl_tasklist]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tips]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tips]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[type]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[type]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[user_sql]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[user_sql]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[jifen]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[jifen]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[index_pic]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[index_pic]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[email]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[email]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[discount]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[discount]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[customer_image]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[customer_image]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[book]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[book]
GO

CREATE TABLE [dbo].[Manage_User] (
	[Id] [int] IDENTITY (10013, 1) NOT NULL ,
	[UserName] [nvarchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[PassWord] [nvarchar] (20) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[OrderList] (
	[Form_Id] [int] IDENTITY (36725, 1) NOT NULL ,
	[User_Id] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[Name] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[Zip] [int] NULL ,
	[Phone] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[Email] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[Address] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[shangpinzongjia] [int] NULL ,
	[yunfeizongjia] [int] NULL ,
	[yingfuzongjia] [int] NULL ,
	[youhuijiage] [int] NULL ,
	[shijizongjia] [int] NULL ,
	[pays] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[pays2] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[pays3] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[Remark] [nvarchar] (1000) COLLATE Chinese_PRC_CI_AS NULL ,
	[Flag] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[RegTime] [datetime] NULL ,
	[if_confirm] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[if_perfect_num] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[packge_id] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[send_time] [datetime] NULL ,
	[tra_price] [int] NULL ,
	[yway] [nvarchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[cuser] [nvarchar] (10) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[RegUser] (
	[Id] [int] IDENTITY (15433, 1) NOT NULL ,
	[UserId] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[PassWD] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[WtPass] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[DaPass] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[Name] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[Sex] [nvarchar] (4) COLLATE Chinese_PRC_CI_AS NULL ,
	[Email] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[Phone] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[Address] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[Zip] [int] NULL ,
	[RegTime] [datetime] NULL ,
	[baba_name] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[baba_birthday] [datetime] NULL ,
	[baba_sex] [nvarchar] (4) COLLATE Chinese_PRC_CI_AS NULL ,
	[if_weekly] [nvarchar] (4) COLLATE Chinese_PRC_CI_AS NULL ,
	[if_information] [nvarchar] (4) COLLATE Chinese_PRC_CI_AS NULL ,
	[if_vip] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[if_email] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[save] [nvarchar] (2000) COLLATE Chinese_PRC_CI_AS NULL ,
	[if_discount] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[discount_value] [int] NULL ,
	[discount_number] [nvarchar] (250) COLLATE Chinese_PRC_CI_AS NULL ,
	[discount_enable] [nvarchar] (250) COLLATE Chinese_PRC_CI_AS NULL ,
	[record] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[baoliu] [nvarchar] (2000) COLLATE Chinese_PRC_CI_AS NULL ,
	[jifen] [int] NOT NULL ,
	[if_vote] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[vip_card] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[card_sum] [int] NOT NULL ,
	[youhuiquan] [int] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[RegUser_Log_Money] (
	[id] [int] IDENTITY (13460, 1) NOT NULL ,
	[user_id] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[form_id] [int] NULL ,
	[reason] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[card_sum] [int] NULL ,
	[jifen] [int] NULL ,
	[youhuiquan] [int] NULL ,
	[card_sum_increase] [int] NULL ,
	[jifen_increase] [int] NULL ,
	[youhuiquan_increase] [int] NULL ,
	[crttime] [datetime] NOT NULL ,
	[chgtime] [datetime] NULL ,
	[flag] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[active_price] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ShopList] (
	[Id] [int] IDENTITY (170858, 1) NOT NULL ,
	[Product_Id] [int] NULL ,
	[Form_Id] [int] NULL ,
	[Product_Name] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[age_stage] [nvarchar] (100) COLLATE Chinese_PRC_CI_AS NULL ,
	[class_1] [nvarchar] (100) COLLATE Chinese_PRC_CI_AS NULL ,
	[Number] [int] NULL ,
	[P_NewPrice] [money] NULL ,
	[RegTime] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[admin] (
	[a6id] [int] IDENTITY (10002, 1) NOT NULL ,
	[a6uid] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[a6pwd] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[a6name] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[a6crttime] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[buy] (
	[a1id] [int] IDENTITY (17978, 1) NOT NULL ,
	[a1gid] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a1name] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a1code] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a1brand] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[a1seat] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[a1buy_price] [float] NULL ,
	[a1amount] [int] NULL ,
	[a1price_common] [int] NULL ,
	[a1price_vip] [int] NULL ,
	[a1price_wholesale] [int] NULL ,
	[a1mflag] [int] NULL ,
	[a1relation] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a1crttime] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[a1crtuser] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[a1chgtime] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[a1chguser] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[category] (
	[id] [int] IDENTITY (10020, 1) NOT NULL ,
	[etitle] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[title] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[commodity_modify] (
	[a12id] [int] IDENTITY (10178, 1) NOT NULL ,
	[a12gid] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a12code] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a12mflag] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a12old] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a12new] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a12reason] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a12crttime] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a12crtuser] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[commodity_sort] (
	[product_id] [int] IDENTITY (13732, 1) NOT NULL ,
	[name] [nvarchar] (250) COLLATE Chinese_PRC_CI_AS NULL ,
	[age_stage] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[brand_name] [nvarchar] (100) COLLATE Chinese_PRC_CI_AS NULL ,
	[number] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[producing_area] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[former_value] [int] NULL ,
	[discount] [float] NULL ,
	[vip_discount] [float] NULL ,
	[size] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[exquisite] [nvarchar] (4) COLLATE Chinese_PRC_CI_AS NULL ,
	[gift] [nvarchar] (4) COLLATE Chinese_PRC_CI_AS NULL ,
	[storage] [int] NULL ,
	[remind] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[material] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[washing_method] [nvarchar] (100) COLLATE Chinese_PRC_CI_AS NULL ,
	[description] [nvarchar] (4000) COLLATE Chinese_PRC_CI_AS NULL ,
	[storage_time] [datetime] NULL ,
	[class_1] [nvarchar] (100) COLLATE Chinese_PRC_CI_AS NULL ,
	[class_2] [nvarchar] (200) COLLATE Chinese_PRC_CI_AS NULL ,
	[pic_s] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[pic_m] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[pic_l] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[look_count] [int] NULL ,
	[modify_time] [datetime] NULL ,
	[weight] [float] NULL ,
	[sale_number] [int] NULL ,
	[xingbie] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[property] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[pre_order] [nvarchar] (4) COLLATE Chinese_PRC_CI_AS NULL ,
	[pic_l1] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[pic_l2] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[pic_l3] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[published_date] [nvarchar] (100) COLLATE Chinese_PRC_CI_AS NULL ,
	[publisher] [nvarchar] (100) COLLATE Chinese_PRC_CI_AS NULL ,
	[page] [int] NULL ,
	[author] [nvarchar] (100) COLLATE Chinese_PRC_CI_AS NULL ,
	[if_premium] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[video_addr] [nvarchar] (800) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[crm_customer_browse_history] (
	[a2cid] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[a2pid] [int] NOT NULL ,
	[a2product_name] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[a2crttime] [datetime] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[crm_customer_remark] (
	[a1cid] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[a1title] [nvarchar] (2000) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[a1crtuser] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[a1crttime] [datetime] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[goods_id_creater] (
	[a7id] [bigint] NOT NULL ,
	[a7reason] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[history_delete] (
	[a14id] [int] IDENTITY (10008, 1) NOT NULL ,
	[a14gid] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a14code] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a14name] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a14brand] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[a14price_common] [float] NULL ,
	[a14price_vip] [float] NULL ,
	[a14price_wholesale] [float] NULL ,
	[a14buy_money] [float] NULL ,
	[a14buy_amount] [int] NULL ,
	[a14modify_money] [float] NULL ,
	[a14modify_amount] [int] NULL ,
	[a14seat] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[a14stock_money] [float] NULL ,
	[a14stock_amount] [int] NULL ,
	[a14reason] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[a14crttime] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[a14crtuser] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[history_login] (
	[a15id] [int] IDENTITY (19068, 1) NOT NULL ,
	[a15uid] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a15name] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a15power] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a15logintime] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a15loginip] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a15loginsystemver] [nvarchar] (200) COLLATE Chinese_PRC_CI_AS NULL ,
	[a15loginnum] [int] NULL ,
	[a15work] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[jxc_buy_brand] (
	[a17id] [int] IDENTITY (10031, 1) NOT NULL ,
	[a17brand] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[a17money] [float] NOT NULL ,
	[a17remark] [nvarchar] (200) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[a17crttime] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[a17crtuser] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[make_order] (
	[number] [int] IDENTITY (23236, 1) NOT NULL ,
	[name] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[Zip] [int] NULL ,
	[Phone] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[Email] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[Address] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[shangpinzongjia] [int] NULL ,
	[yunfeizongjia] [int] NULL ,
	[youhuijiage] [int] NULL ,
	[shijizongjia] [int] NULL ,
	[Remark] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[packge_id] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[make_time] [datetime] NULL ,
	[modify_time] [datetime] NULL ,
	[send_time] [datetime] NULL ,
	[flag] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[yway] [nvarchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[cuser] [nvarchar] (10) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[make_shoplist] (
	[id] [int] IDENTITY (96487, 1) NOT NULL ,
	[form_number] [int] NULL ,
	[product_number] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[Product_Name] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[Number] [int] NULL ,
	[P_NewPrice] [money] NULL ,
	[make_time] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[orderbook] (
	[a9id] [int] IDENTITY (21711, 1) NOT NULL ,
	[a9oid] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[a9flow] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a9sub_price] [float] NULL ,
	[a9postage] [float] NULL ,
	[a9price_reduce] [float] NULL ,
	[a9status] [int] NULL ,
	[a9mflag] [int] NULL ,
	[a9relation] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a9crttime] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a9crtuser] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a9chgtime] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a9chguser] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[postage] (
	[a8id] [int] IDENTITY (10002, 1) NOT NULL ,
	[a8date] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[a8postage] [float] NULL ,
	[a8mflag] [int] NULL ,
	[a8relation] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a8crttime] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[a8crtuser] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[a8chgtime] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[a8chguser] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[pround] (
	[id] [int] IDENTITY (11357, 1) NOT NULL ,
	[product_id] [int] NULL ,
	[pround] [nvarchar] (4000) COLLATE Chinese_PRC_CI_AS NULL ,
	[said_time] [datetime] NULL ,
	[pround_name] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[pro_level] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[record_total_num] (
	[id] [int] IDENTITY (10002, 1) NOT NULL ,
	[vote_total_num] [int] NULL ,
	[total_name] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[quehuo] (
	[id] [int] IDENTITY (13364, 1) NOT NULL ,
	[name] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[phone] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[email] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[remark] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[addtime] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[returned] (
	[a3id] [int] IDENTITY (10164, 1) NOT NULL ,
	[a3gid] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a3name] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a3code] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a3brand] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a3buy_price] [int] NULL ,
	[a3price] [int] NULL ,
	[a3amount] [int] NULL ,
	[a3oid] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a3mflag] [int] NULL ,
	[a3relation] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a3crttime] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[a3crtuser] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[a3chgtime] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[a3chguser] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[a3confirmtime] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[a3confirmuser] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a3reason] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a3status] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[seat] (
	[a10id] [int] IDENTITY (13232, 1) NOT NULL ,
	[a10gid] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a10name] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a10code] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a10seat] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a10amount] [int] NULL ,
	[a10crttime] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a10crtuser] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a10chgtime] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a10chguser] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[seat_transfer] (
	[a13id] [int] IDENTITY (12822, 1) NOT NULL ,
	[a13gid] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a13code] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a13name] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a13old] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a13new] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a13amount] [int] NULL ,
	[a13crttime] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a13crtuser] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[sold] (
	[a2id] [int] IDENTITY (49273, 1) NOT NULL ,
	[a2gid] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a2name] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a2code] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a2brand] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a2buy_price] [float] NULL ,
	[a2sold_price] [int] NULL ,
	[a2amount] [int] NULL ,
	[a2oid] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a2flow] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a2status] [int] NULL ,
	[a2mflag] [int] NULL ,
	[a2relation] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a2crttime] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[a2crtuser] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[a2chgtime] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[a2chguser] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[a2buy_price_bak] [float] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[stock] (
	[a4id] [int] IDENTITY (12679, 1) NOT NULL ,
	[a4gid] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a4name] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a4code] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a4brand] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[a4seat_nouse] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[a4stock] [int] NULL ,
	[a4diff] [int] NULL ,
	[a4buy_price] [float] NULL ,
	[a4price_common] [int] NULL ,
	[a4price_vip] [int] NULL ,
	[a4price_wholesale] [int] NULL ,
	[a4total_money] [float] NULL ,
	[a4cflag] [int] NULL ,
	[a4sflag] [int] NULL ,
	[a4remark] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a4crttime] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[a4crtuser] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[a4chgtime] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[a4chguser] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[stock_modify] (
	[a11id] [int] IDENTITY (12676, 1) NOT NULL ,
	[a11gid] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a11name] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a11code] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a11brand] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a11amount_old] [int] NULL ,
	[a11amount_new] [int] NULL ,
	[a11price] [float] NULL ,
	[a11reason] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a11crttime] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[a11crtuser] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tdl_tasklist] (
	[a1id] [int] IDENTITY (10745, 1) NOT NULL ,
	[a1status] [nvarchar] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[a1priority] [int] NOT NULL ,
	[a1title] [nvarchar] (2000) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[a1creatuser] [nvarchar] (20) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[a1pointuser] [nvarchar] (20) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[a1crttime] [datetime] NOT NULL ,
	[a1chgtime] [datetime] NOT NULL ,
	[a1closetime] [datetime] NULL ,
	[a1private] [nvarchar] (10) COLLATE Chinese_PRC_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[tips] (
	[a16id] [int] IDENTITY (10040, 1) NOT NULL ,
	[a16content] [nvarchar] (200) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[type] (
	[type] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[user_sql] (
	[a5id] [int] IDENTITY (10013, 1) NOT NULL ,
	[a5uid] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[a5pwd] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[a5power] [int] NULL ,
	[a5name] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[a5crttime] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[a5crtuser] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[a5chgtime] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[a5chguser] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[a5deadline] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[jifen] (
	[id] [int] IDENTITY (19035, 1) NOT NULL ,
	[userid] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[reason] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[quantity] [int] NULL ,
	[bring_time] [datetime] NULL ,
	[addtime] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[index_pic] (
	[id] [int] IDENTITY (10008, 1) NOT NULL ,
	[pic_name] [nvarchar] (200) COLLATE Chinese_PRC_CI_AS NULL ,
	[pic_link_address] [nvarchar] (200) COLLATE Chinese_PRC_CI_AS NULL ,
	[pic_flag] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[pic_sort] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[email] (
	[number] [int] IDENTITY (16859, 1) NOT NULL ,
	[email] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[regtime] [datetime] NULL ,
	[if_email] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[discount_name] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[discount] (
	[kind] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[term] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[dis] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[customer_image] (
	[id] [int] IDENTITY (10257, 1) NOT NULL ,
	[title] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[product_id] [int] NULL ,
	[userid] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[description] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[image] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[addtime] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[book] (
	[ID] [int] IDENTITY (19060, 1) NOT NULL ,
	[name] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[email] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[Title] [nvarchar] (255) COLLATE Chinese_PRC_CI_AS NULL ,
	[content] [nvarchar] (4000) COLLATE Chinese_PRC_CI_AS NULL ,
	[time] [datetime] NULL ,
	[jibie] [nvarchar] (50) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Manage_User] WITH NOCHECK ADD 
	CONSTRAINT [PK_Manage_User] PRIMARY KEY  CLUSTERED 
	(
		[Id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[OrderList] WITH NOCHECK ADD 
	CONSTRAINT [PK_OrderList] PRIMARY KEY  CLUSTERED 
	(
		[Form_Id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[RegUser] WITH NOCHECK ADD 
	CONSTRAINT [PK_RegUser] PRIMARY KEY  CLUSTERED 
	(
		[Id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[RegUser_Log_Money] WITH NOCHECK ADD 
	CONSTRAINT [PK_RegUser_Log_Money] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[ShopList] WITH NOCHECK ADD 
	CONSTRAINT [PK_ShopList] PRIMARY KEY  CLUSTERED 
	(
		[Id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[admin] WITH NOCHECK ADD 
	CONSTRAINT [PK_admin] PRIMARY KEY  CLUSTERED 
	(
		[a6id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[buy] WITH NOCHECK ADD 
	CONSTRAINT [PK_buy] PRIMARY KEY  CLUSTERED 
	(
		[a1id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[category] WITH NOCHECK ADD 
	CONSTRAINT [PK_category] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[commodity_modify] WITH NOCHECK ADD 
	CONSTRAINT [PK_commodity_modify] PRIMARY KEY  CLUSTERED 
	(
		[a12id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[commodity_sort] WITH NOCHECK ADD 
	CONSTRAINT [PK_commodity_sort] PRIMARY KEY  CLUSTERED 
	(
		[product_id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[history_delete] WITH NOCHECK ADD 
	CONSTRAINT [PK_history_delete] PRIMARY KEY  CLUSTERED 
	(
		[a14id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[history_login] WITH NOCHECK ADD 
	CONSTRAINT [PK_history_login] PRIMARY KEY  CLUSTERED 
	(
		[a15id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[jxc_buy_brand] WITH NOCHECK ADD 
	CONSTRAINT [PK_jxc_buy_brand] PRIMARY KEY  CLUSTERED 
	(
		[a17id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[make_order] WITH NOCHECK ADD 
	CONSTRAINT [PK_make_order] PRIMARY KEY  CLUSTERED 
	(
		[number]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[make_shoplist] WITH NOCHECK ADD 
	CONSTRAINT [PK_make_shoplist] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[orderbook] WITH NOCHECK ADD 
	CONSTRAINT [PK_orderbook] PRIMARY KEY  CLUSTERED 
	(
		[a9id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[postage] WITH NOCHECK ADD 
	CONSTRAINT [PK_postage] PRIMARY KEY  CLUSTERED 
	(
		[a8id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[pround] WITH NOCHECK ADD 
	CONSTRAINT [PK_pround] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[record_total_num] WITH NOCHECK ADD 
	CONSTRAINT [PK_record_total_num] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[quehuo] WITH NOCHECK ADD 
	CONSTRAINT [PK_quehuo] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[returned] WITH NOCHECK ADD 
	CONSTRAINT [PK_returned] PRIMARY KEY  CLUSTERED 
	(
		[a3id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[seat] WITH NOCHECK ADD 
	CONSTRAINT [PK_seat] PRIMARY KEY  CLUSTERED 
	(
		[a10id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[seat_transfer] WITH NOCHECK ADD 
	CONSTRAINT [PK_seat_transfer] PRIMARY KEY  CLUSTERED 
	(
		[a13id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[sold] WITH NOCHECK ADD 
	CONSTRAINT [PK_sold] PRIMARY KEY  CLUSTERED 
	(
		[a2id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[stock] WITH NOCHECK ADD 
	CONSTRAINT [PK_stock] PRIMARY KEY  CLUSTERED 
	(
		[a4id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[stock_modify] WITH NOCHECK ADD 
	CONSTRAINT [PK_stock_modify] PRIMARY KEY  CLUSTERED 
	(
		[a11id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tdl_tasklist] WITH NOCHECK ADD 
	CONSTRAINT [PK_tdl_tasklist] PRIMARY KEY  CLUSTERED 
	(
		[a1id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[tips] WITH NOCHECK ADD 
	CONSTRAINT [PK_tips] PRIMARY KEY  CLUSTERED 
	(
		[a16id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[user_sql] WITH NOCHECK ADD 
	CONSTRAINT [PK_user_sql] PRIMARY KEY  CLUSTERED 
	(
		[a5id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[jifen] WITH NOCHECK ADD 
	CONSTRAINT [PK_jifen] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[index_pic] WITH NOCHECK ADD 
	CONSTRAINT [PK_index_pic] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[email] WITH NOCHECK ADD 
	CONSTRAINT [PK_email] PRIMARY KEY  CLUSTERED 
	(
		[number]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[customer_image] WITH NOCHECK ADD 
	CONSTRAINT [PK_customer_image] PRIMARY KEY  CLUSTERED 
	(
		[id]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[book] WITH NOCHECK ADD 
	CONSTRAINT [PK_book] PRIMARY KEY  CLUSTERED 
	(
		[ID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[OrderList] ADD 
	CONSTRAINT [DF_OrderList_Zip] DEFAULT (0) FOR [Zip],
	CONSTRAINT [DF_OrderList_shangpinzongjia] DEFAULT (0) FOR [shangpinzongjia],
	CONSTRAINT [DF_OrderList_yunfeizongjia] DEFAULT (0) FOR [yunfeizongjia],
	CONSTRAINT [DF_OrderList_yingfuzongjia] DEFAULT (0) FOR [yingfuzongjia],
	CONSTRAINT [DF_OrderList_youhuijiage] DEFAULT (0) FOR [youhuijiage],
	CONSTRAINT [DF_OrderList_shijizongjia] DEFAULT (0) FOR [shijizongjia],
	CONSTRAINT [DF_OrderList_Flag] DEFAULT ('尚未处理') FOR [Flag],
	CONSTRAINT [DF_OrderList_RegTime] DEFAULT (getdate()) FOR [RegTime],
	CONSTRAINT [DF_OrderList_if_perfect_num] DEFAULT ('0') FOR [if_perfect_num],
	CONSTRAINT [DF_OrderList_packge_id] DEFAULT ('无') FOR [packge_id],
	CONSTRAINT [DF_OrderList_tra_price] DEFAULT (0) FOR [tra_price]
GO

ALTER TABLE [dbo].[RegUser] ADD 
	CONSTRAINT [DF_RegUser_Zip] DEFAULT (0) FOR [Zip],
	CONSTRAINT [DF_RegUser_RegTime] DEFAULT (getdate()) FOR [RegTime],
	CONSTRAINT [DF_RegUser_if_vip] DEFAULT ('0') FOR [if_vip],
	CONSTRAINT [DF_RegUser_if_email] DEFAULT ('0') FOR [if_email],
	CONSTRAINT [DF_RegUser_if_discount] DEFAULT ('0') FOR [if_discount],
	CONSTRAINT [DF_RegUser_discount_value] DEFAULT (0) FOR [discount_value],
	CONSTRAINT [DF_RegUser_jifen] DEFAULT (0) FOR [jifen],
	CONSTRAINT [DF_RegUser_card_sum] DEFAULT (0) FOR [card_sum],
	CONSTRAINT [DF_RegUser_youhuiquan] DEFAULT (0) FOR [youhuiquan]
GO

ALTER TABLE [dbo].[ShopList] ADD 
	CONSTRAINT [DF_ShopList_Product_Id] DEFAULT (0) FOR [Product_Id],
	CONSTRAINT [DF_ShopList_Form_Id] DEFAULT (0) FOR [Form_Id],
	CONSTRAINT [DF_ShopList_Number] DEFAULT (0) FOR [Number],
	CONSTRAINT [DF_ShopList_P_NewPrice] DEFAULT (0) FOR [P_NewPrice],
	CONSTRAINT [DF_ShopList_RegTime] DEFAULT (getdate()) FOR [RegTime]
GO

ALTER TABLE [dbo].[commodity_sort] ADD 
	CONSTRAINT [DF_commodity_sort_former_value] DEFAULT (0) FOR [former_value],
	CONSTRAINT [DF_commodity_sort_discount] DEFAULT (0) FOR [discount],
	CONSTRAINT [DF_commodity_sort_vip_discount] DEFAULT (0) FOR [vip_discount],
	CONSTRAINT [DF_commodity_sort_storage] DEFAULT (0) FOR [storage],
	CONSTRAINT [DF_commodity_sort_storage_time] DEFAULT (getdate()) FOR [storage_time],
	CONSTRAINT [DF_commodity_sort_look_count] DEFAULT (0) FOR [look_count],
	CONSTRAINT [DF_commodity_sort_modify_time] DEFAULT (getdate()) FOR [modify_time],
	CONSTRAINT [DF_commodity_sort_weight] DEFAULT (0) FOR [weight],
	CONSTRAINT [DF_commodity_sort_sale_number] DEFAULT (0) FOR [sale_number],
	CONSTRAINT [DF_commodity_sort_pre_order] DEFAULT ('0') FOR [pre_order],
	CONSTRAINT [DF_commodity_sort_page] DEFAULT (0) FOR [page]
GO

ALTER TABLE [dbo].[crm_customer_browse_history] ADD 
	CONSTRAINT [DF_crm_customer_browse_history_a2crttime] DEFAULT (getdate()) FOR [a2crttime]
GO

ALTER TABLE [dbo].[crm_customer_remark] ADD 
	CONSTRAINT [DF_crm_customer_remark_a1crttime] DEFAULT (getdate()) FOR [a1crttime]
GO

ALTER TABLE [dbo].[make_order] ADD 
	CONSTRAINT [DF_make_order_Zip] DEFAULT (0) FOR [Zip],
	CONSTRAINT [DF_make_order_Email] DEFAULT ('无') FOR [Email],
	CONSTRAINT [DF_make_order_Address] DEFAULT ('无') FOR [Address],
	CONSTRAINT [DF_make_order_shangpinzongjia] DEFAULT (0) FOR [shangpinzongjia],
	CONSTRAINT [DF_make_order_yunfeizongjia] DEFAULT (0) FOR [yunfeizongjia],
	CONSTRAINT [DF_make_order_youhuijiage] DEFAULT (0) FOR [youhuijiage],
	CONSTRAINT [DF_make_order_shijizongjia] DEFAULT (0) FOR [shijizongjia],
	CONSTRAINT [DF_make_order_packge_id] DEFAULT ('无') FOR [packge_id],
	CONSTRAINT [DF_make_order_make_time] DEFAULT (getdate()) FOR [make_time],
	CONSTRAINT [DF_make_order_modify_time] DEFAULT (getdate()) FOR [modify_time]
GO

ALTER TABLE [dbo].[make_shoplist] ADD 
	CONSTRAINT [DF_make_shoplist_form_number] DEFAULT (0) FOR [form_number],
	CONSTRAINT [DF_make_shoplist_Number] DEFAULT (0) FOR [Number],
	CONSTRAINT [DF_make_shoplist_P_NewPrice] DEFAULT (0) FOR [P_NewPrice],
	CONSTRAINT [DF_make_shoplist_make_time] DEFAULT (getdate()) FOR [make_time]
GO

ALTER TABLE [dbo].[orderbook] ADD 
	CONSTRAINT [DF_orderbook_a9postage] DEFAULT (0) FOR [a9postage]
GO

ALTER TABLE [dbo].[pround] ADD 
	CONSTRAINT [DF_pround_product_id] DEFAULT (0) FOR [product_id],
	CONSTRAINT [DF_pround_said_time] DEFAULT (getdate()) FOR [said_time],
	CONSTRAINT [DF_pround_pround_name] DEFAULT ('无名氏') FOR [pround_name]
GO

ALTER TABLE [dbo].[record_total_num] ADD 
	CONSTRAINT [DF_record_total_num_vote_total_num] DEFAULT (0) FOR [vote_total_num]
GO

ALTER TABLE [dbo].[quehuo] ADD 
	CONSTRAINT [DF_quehuo_addtime] DEFAULT (getdate()) FOR [addtime]
GO

ALTER TABLE [dbo].[stock] ADD 
	CONSTRAINT [DF_stock_a4diff] DEFAULT (0) FOR [a4diff]
GO

ALTER TABLE [dbo].[tdl_tasklist] ADD 
	CONSTRAINT [DF_tdl_tasklist_a1status] DEFAULT (N'未完成') FOR [a1status],
	CONSTRAINT [DF_tdl_tasklist_a1priority] DEFAULT (1) FOR [a1priority],
	CONSTRAINT [DF_tdl_tasklist_a1crttime] DEFAULT (getdate()) FOR [a1crttime],
	CONSTRAINT [DF_tdl_tasklist_a1chgtime] DEFAULT (getdate()) FOR [a1chgtime],
	CONSTRAINT [DF_tdl_tasklist_a1private] DEFAULT (N'') FOR [a1private]
GO

ALTER TABLE [dbo].[jifen] ADD 
	CONSTRAINT [DF_jifen_quantity] DEFAULT (0) FOR [quantity],
	CONSTRAINT [DF_jifen_addtime] DEFAULT (getdate()) FOR [addtime]
GO

ALTER TABLE [dbo].[email] ADD 
	CONSTRAINT [DF_email_regtime] DEFAULT (getdate()) FOR [regtime],
	CONSTRAINT [DF_email_if_email] DEFAULT ('0') FOR [if_email]
GO

ALTER TABLE [dbo].[customer_image] ADD 
	CONSTRAINT [DF_customer_image_product_id] DEFAULT (0) FOR [product_id],
	CONSTRAINT [DF_customer_image_addtime] DEFAULT (getdate()) FOR [addtime]
GO

ALTER TABLE [dbo].[book] ADD 
	CONSTRAINT [DF_book_time] DEFAULT (getdate()) FOR [time],
	CONSTRAINT [DF_book_jibie] DEFAULT ('z') FOR [jibie]
GO


