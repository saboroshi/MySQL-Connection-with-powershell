<#	
  .Synopsis
   Connection to MySQL database.

  .Description
   The module helps you connect to a MySQL database and run arbitrary queries.
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
   MySQL-Connection -Username "root" -Password "P@ssw0rd" -Server "mysql-srv" -DBName "SQLDB" -Security $false -Query "SELECT * FROM SQLTABLE"
#>

function MySQL-Connection
{
	param
	(
		$Username = "",
		$Password = "",
		$Server = "",
		$DBName = "",
		$Query = "",
		[bool]$Security = $False
	)
	[void][System.Reflection.Assembly]::LoadWithPartialName("MySql.Data")
	$Connection = New-Object MySql.Data.MySqlClient.MySqlConnection
	$Connection.ConnectionString = "Server = $Server; Database = $DBName; User ID= $Username; Password= $Password; Integrated Security = $Security"
	$Cmd = New-Object MySql.Data.MySqlClient.MySqlCommand
	$Cmd.CommandText = $Query
	$Cmd.Connection = $Connection
	$Adapter = New-Object MySql.Data.MySqlClient.MySqlDataAdapter
	$Adapter.SelectCommand = $Cmd
	$DataSet = New-Object System.Data.DataSet
	$Adapter.Fill($DataSet)
	$DataSet.Tables[0]
	$Connection.Close()
}

# Export-ModuleMember MySQL-Connection





