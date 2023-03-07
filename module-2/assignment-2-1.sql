USE master
GO
IF NOT EXISTS (
   SELECT name
   FROM sys.databases
   WHERE name = N'ramr2012'
)
CREATE DATABASE [ramr2012]
GO