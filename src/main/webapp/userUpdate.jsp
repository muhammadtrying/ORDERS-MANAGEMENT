<%@ page import="java.util.List" %>
<%@ page import="uz.pdp.task_2_collab.entity.User" %>
<%@ page import="uz.pdp.task_2_collab.repo.UserRepo" %><%--
  Created by IntelliJ IDEA.
  User: muhammad
  Date: 19/04/24
  Time: 4:37 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Updating user</title>
    <link rel="stylesheet" href="static/bootstrap.min.css">
</head>
<body>
<%
    UserRepo userRepo = new UserRepo();
    User user = userRepo.findById(Integer.parseInt(request.getParameter("userId")));
%>
<div class="container">
    <h1 class="mt-4">Update User</h1>
    <form action="userServlet?userId=<%=user.getId()%>" method="post">
        <input name="cameFrom" type="hidden" value="/userUpdate.jsp">
        <div class="form-group">
            <label for="firstName">Name:</label>
            <input value="<%=user.getName()%>" type="text" class="form-control" id="firstName" name="name">
        </div>
        <button type="submit" class="btn btn-primary">Update User</button>
    </form>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
