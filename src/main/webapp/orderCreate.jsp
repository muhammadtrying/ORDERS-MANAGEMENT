<%@ page import="uz.pdp.task_2_collab.repo.UserRepo" %>
<%@ page import="uz.pdp.task_2_collab.entity.User" %>
<%@ page import="java.util.List" %><%--
    Created by IntelliJ IDEA.
    User: muhammad
    Date: 19/04/24
    Time: 11:26 PM
    To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Create Order</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<%
    UserRepo userRepo = new UserRepo();
    List<User> users = userRepo.findAll();
%>
<div class="container mt-5">
    <h2>Create Order</h2>
    <form action="order/servlet" method="post">
        <div class="form-group">
            <select class="form-control" id="userSelect" name="userId">
                <option disabled selected>Choose User</option>
                <%for (User user : users) { %>
                <option value="<%=user.getId()%>"><%=user.getName()%>
                </option>
                <% } %>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">Create Order</button>
    </form>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
