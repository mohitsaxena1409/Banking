<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="img/logoTITLE.png" type="image/png">
    <title>Aashray-UniTrust Bank</title>
</head>
<body>
<form action="fetchAccountForDeposit" method="post">
    <label>Account Number</label>
    <input type="text" name="accountNo" required />
    <button type="submit">Fetch Details</button>
</form>

</body>
</html>