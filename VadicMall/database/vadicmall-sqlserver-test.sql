-- Run this FIRST in SSMS to verify your SQL Server connection works.
-- If this succeeds but the main script fails, paste the error message.

SELECT @@VERSION AS SqlServerVersion;
GO

USE [master];
GO

IF DB_ID(N'VadicMall') IS NULL
BEGIN
    PRINT N'Creating database VadicMall...';
    CREATE DATABASE [VadicMall];
END
ELSE
BEGIN
    PRINT N'Database VadicMall already exists.';
END
GO

USE [VadicMall];
GO

PRINT N'Connected to VadicMall successfully. You can now run vadicmall-sqlserver.sql';
GO
