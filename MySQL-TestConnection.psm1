<#	
  .Synopsis
   Connection to MySQL database.

  .Description
   The module provides assistance in testing the connection to the MySQL database.
   The installation of MySQL Connector/NET is required for operation, which can be downloaded from the link below.
   https://dev.mysql.com/downloads/connector/net/

  .Parameter Username
   Username required to connect to the database.

  .Parameter Password
   The password required to connect to the database.

  .Parameter Server
   The database server address.

  .Parameter DBName
   The name of the database.

  .Parameter Query
   The script/query to be run on the database.

  .Parameter Security
   Setting up an encrypted connection for the database connection.
   True/False setting. Default setting is False.

  .Example
   MySQL-Connection -Username "root" -Password "P@ssw0rd" -Server "mysql-srv" -DBName "SQLDB" -Security $false
#>

function MySQL-TestConnection
{
	param (
		$Username = "",
		$Password = "",
		$Server = "",
		$DBName = "",
		$Query = "",
		[bool]$Security = $false
	)
	$ErrorActionPreference = 'Stop'
	try
	{
		[void][System.Reflection.Assembly]::LoadWithPartialName("MySql.Data")
		$Connection = New-Object MySql.Data.MySqlClient.MySqlConnection
		$Connection.ConnectionString = "Server = $Server; Database = $DBName; User ID= $Username; Password= $Password; Integrated Security = $Security"
		$Connection.Open()
		$true
	}
	catch
	{
		$false
	}
	finally
	{
		$Connection.Close()
	}
}

# Export-ModuleMember MySQL-TestConnection





