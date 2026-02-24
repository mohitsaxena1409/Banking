	<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
	<%@ page import="java.util.List"%>
	<%@ page import="com.bank.pojo.Users"%>
	
	<%
	/* ===== SESSION & CACHE CONTROL ===== */
	response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires", 0);
	
	Users admin = (Users) session.getAttribute("loggedUser");
	if(admin == null){
	    response.sendRedirect("signIn");
	    return;
	}
	
	List<Users> usersList = (List<Users>) request.getAttribute("usersList");
	String msg = (String) session.getAttribute("msg");
	if(msg != null){
	    session.removeAttribute("msg");
	}
	%>
	
	<!DOCTYPE html>
	<html>
	<head>
	<meta charset="UTF-8">
	<title>Update Users | Admin Panel</title>
	
	<!-- Bootstrap -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- Font Awesome -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
	
	<style>
	
	/* ===== FADE IN ANIMATION (LOGIN PAGE SAME) ===== */
	.btn-outline-light:hover{
    background:#ffffff;
    color:#000;
    transform:scale(1.05);
    transition:0.3s;
}
	
	.fade-card{
	    animation: fadeIn 0.6s ease;
	}
	
	@keyframes fadeIn{
	    from{
	        opacity:0;
	        transform:translateY(12px);
	    }
	    to{
	        opacity:1;
	        transform:translateY(0);
	    }
	}
	
	
	
	body{
	    background:#f4f6f9;
	}
	.card{
	    border:none;
	}
	.table thead th{
	    vertical-align:middle;
	}
	</style>
	
	</head>
	<body>
	
	<div class="container mt-5">
	
	    <div class="card shadow-lg rounded-4 fade-card">
	
	
	        <!-- CARD HEADER -->
<div class="card-header bg-dark text-white d-flex justify-content-between align-items-center">

    <h5 class="mb-0">
        <i class="fa fa-users me-2"></i>Active Customers
    </h5>

    <div class="d-flex align-items-center gap-3">

        <span class="badge bg-success fs-6">
            Total : <%= (usersList!=null)?usersList.size():0 %>
        </span>

        <!-- HOME BUTTON -->
        <a href="admin-Dashboard"
           class="btn btn-outline-light btn-sm rounded-pill px-3">
            <i class="fa fa-home me-1"></i> Home
        </a>

    </div>
</div>
	
	        <!-- CARD BODY -->
	        <div class="card-body">
	
	            <% if(msg != null){ %>
	            <div class="alert alert-success alert-dismissible fade show">
	                <i class="fa fa-check-circle me-2"></i><%=msg%>
	                <button class="btn-close" data-bs-dismiss="alert"></button>
	            </div>
	            <% } %>
	
	            <table class="table table-bordered table-hover text-center align-middle">
	                <thead class="table-secondary">
	                <tr>
	                    <th width="50">#</th>
	                    <th>Name</th>
	                    <th>Email</th>
	                    <th>Phone</th>
	                    <th width="130">Action</th>
	                </tr>
	                </thead>
	
	                <tbody>
	                <%
	                int i = 1;
	                if(usersList != null && !usersList.isEmpty()){
	                    for(Users u : usersList){
	                %>
	                <tr>
	                    <td><%=i++%></td>
	                    <td><%=u.getFname()%> <%=u.getLname()%></td>
	                    <td><%=u.getEmail()%></td>
	                    <td><%=u.getPhone()%></td>
	                    <td>
	                        <a href="editUser?id=<%=u.getId()%>"
	                           class="btn btn-warning btn-sm rounded-pill">
	                            <i class="fa fa-edit me-1"></i>Update
	                        </a>
	                    </td>
	                </tr>
	                <% }} else { %>
	                <tr>
	                    <td colspan="5" class="text-danger fw-bold">
	                        No Active Users Found
	                    </td>
	                </tr>
	                <% } %>
	                </tbody>
	            </table>
	
	        </div>
	    </div>
	</div>
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	</body>
	</html>
