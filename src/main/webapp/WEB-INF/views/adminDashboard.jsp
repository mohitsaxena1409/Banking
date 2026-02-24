<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bank Operations Desk | Aashray Bank</title>

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family: "Segoe UI", Arial, sans-serif;
}

body{
    background:#eef3f9;
}

/* ===== HEADER ===== */
.header{
    background:#002855;
    color:white;
    padding:18px 30px;
    display:flex;
    justify-content:space-between;
    align-items:center;
}

.header h2{
    font-size:22px;
}

.header span{
    font-size:13px;
    opacity:0.85;
}

.logout{
    background:#c0392b;
    color:white;
    padding:6px 14px;
    text-decoration:none;
    border-radius:4px;
}

/* ===== MAIN ===== */
.main{
    padding:30px;
}

/* ===== SECTION ===== */
.section{
    background:white;
    padding:25px;
    border-radius:12px;
    margin-bottom:30px;
    box-shadow:0 6px 18px rgba(0,0,0,0.08);
}

.section h3{
    color:#002855;
    margin-bottom:15px;
    border-bottom:2px solid #eef3f9;
    padding-bottom:10px;
}

/* ===== TABLE ===== */
table{
    width:100%;
    border-collapse:collapse;
}

th, td{
    padding:12px;
    border-bottom:1px solid #eee;
    text-align:left;
}

th{
    background:#f5f9ff;
    color:#002855;
}

/* ===== ACTION ROW ===== */
.actions{
    display:flex;
    gap:15px;
    flex-wrap:wrap;
}

.action-btn{
    padding:12px 20px;
    border-radius:6px;
    border:1px solid #002855;
    color:#002855;
    background:white;
    cursor:pointer;
    transition:0.3s;
}

.action-btn:hover{
    background:#002855;
    color:white;
}

/* ===== ALERT ===== */
.alert{
    background:#fff3cd;
    border-left:5px solid #ff9800;
    padding:15px;
    border-radius:6px;
    color:#856404;
}
.user-box{
    display:flex;
    align-items:center;
    gap:15px;
}

.user-info{
    text-align:right;
    font-size:13px;
}

.user-info .name{
    font-weight:600;
    font-size:15px;
}

.user-info .email{
    opacity:0.85;
}

.user-info .role{
    font-size:12px;
    background:#0d6efd;
    padding:2px 8px;
    border-radius:12px;
    display:inline-block;
    margin-top:3px;
}

.user-pic{
    width:48px;
    height:48px;
    border-radius:50%;
    object-fit:cover;
    border:2px solid white;
}
/* ===== HEADER ANIMATION ===== */
.header-animate{
    animation: slideDown 0.6s ease;
}

@keyframes slideDown{
    from{
        opacity:0;
        transform:translateY(-15px);
    }
    to{
        opacity:1;
        transform:translateY(0);
    }
}

/* ===== LOGOUT BUTTON ===== */
.logout-btn{
    background:#0d6efd;
    color:white;
    padding:7px 16px;
    border-radius:8px;
    text-decoration:none;
    font-size:13px;
    font-weight:600;
    transition:all 0.25s ease;
}

.logout-btn:hover{
    background:#084298;
    box-shadow:0 6px 14px rgba(13,110,253,0.35);
    transform:translateY(-2px);
}

/* ===== SECTION ANIMATION ===== */
.section{
    animation: fadeUp 0.7s ease;
}

@keyframes fadeUp{
    from{
        opacity:0;
        transform:translateY(12px);
    }
    to{
        opacity:1;
        transform:translateY(0);
    }
}

/* ===== MOBILE HEADER ===== */
@media(max-width:768px){
    .header{
        flex-direction:column;
        gap:12px;
        text-align:center;
    }
    .user-box{
        justify-content:center;
    }
}

</style>
</head>

<body>
<%
    String username = (String) session.getAttribute("username");
    String email = (String) session.getAttribute("email");
    String role = (String) session.getAttribute("role");
    String photo = (String) session.getAttribute("photo");
%>
<!-- ===== HEADER ===== -->
<div class="header header-animate">

    <!-- Left -->
    <div>
        <h2>Aashray Bank – Operations Desk</h2>
        <span>Internal Administrative Access</span>
    </div>

    <!-- Right : User Info -->
    <div class="user-box">
        <div class="user-info">
            <div class="name"><%= username %></div>
            <div class="email"><%= email %></div>
            <div class="role"><%= role %></div>
        </div>

        <img src="users/<%= photo %>" alt="Profile" class="user-pic">

        <a href="logout" class="logout-btn">Logout</a>
    </div>

</div>



<div class="main">

    <!-- ===== TODAY OPS ===== -->
    <div class="section">
        <h3>Today's Operations</h3>
        <table>
            <tr>
                <th>Operation</th>
                <th>Count</th>
                <th>Status</th>
            </tr>
            <tr>
                <td>Account Openings</td>
                <td>18</td>
                <td>Completed</td>
            </tr>
            <tr>
                <td>Cash Deposits</td>
                <td>126</td>
                <td>Ongoing</td>
            </tr>
            <tr>
                <td>Cash Withdrawals</td>
                <td>94</td>
                <td>Completed</td>
            </tr>
        </table>
    </div>

    <!-- ===== QUICK ACTIONS ===== -->
    <div class="actions">

    <div class="action-btn" onclick="location.href='open-account'">
        Open New Account
    </div>

    <div class="action-btn" onclick="location.href='verify-transactions'">
        Verify Transactions
    </div>

    <div class="action-btn" onclick="location.href='customer-lookup'">
        Customer Lookup
    </div>

    <div class="action-btn" onclick="location.href='generate-report'">
        Generate Report
    </div>

    <!-- 🔥 NEW -->
    <a href="requestPanel"><div class="action-btn">
        Account Requests
    </div></a>

</div>


    <!-- ===== RISK ALERT ===== -->
    <div class="section">
        <h3>Risk & Alerts</h3>
        <div class="alert">
            ⚠ 3 high-value transactions require manual verification.
        </div>
    </div>

</div>

</body>
</html>
