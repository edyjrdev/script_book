#!/usr/bin/env pwsh

# requirements: * module SQLServer (Install-Module SQLServer)
#               * SQL Server with database 'mydb' and table 'employees'
#               
# CREATE TABLE employees(
#   id INT IDENTITY(1, 1) PRIMARY KEY,
#   FirstName TEXT NOT NULL,
#   LastName TEXT NOT NULL,
#   DateOfBirth DATE,
#   Street TEXT,
#   City TEXT,
#   State CHAR(2),
#   Gender CHAR(1),
#   Email TEXT,
#   Job TEXT,
#   Salary FLOAT);

# import the SQLServer module
Import-Module SQLServer

# connection string to SQL Server, use your own names!
$connectionString = "Server=.\sqlexpress01;Database=mydb;Trusted_Connection=true;Encrypt=false"

# table and column names
$tableName = "employees"
$columns = "FirstName", "LastName", "DateOfBirth", "Street", 
           "City", "State", "Gender", "Email", "Job", "Salary"

# setup SQL statements
$sql = "INSERT INTO $tablename (" +  ($columns -Join ", ") + ") "
$sqlcmds = ""

# read the JSON file, convert it to PowerShell objects
$jsonFilePath = "employees.json"
$json = Get-Content $jsonFilePath | ConvertFrom-Json

# iterate through the array of records and build all INSERT commands
foreach ($record in $json) {
    $values = ""
    # loop over columns
    foreach ($column in $columns) {
        if ($values) {
            $values += ", "
        }
        $values += "'" + $record.$column + "'"
    }
    $sqlcmds += $sql + "`nVALUES(" + $values + ");`n"
}

# execute the insert statements
Write-Output $sqlcmds
Invoke-Sqlcmd  -ConnectionString $connectionString -Query $sqlcmds
