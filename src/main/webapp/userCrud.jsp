<%@ page import="java.util.List" %>
<%@ page import="uz.pdp.task_2_collab.repo.UserRepo" %>
<%@ page import="uz.pdp.task_2_collab.entity.User" %>
<%@ page import="uz.pdp.task_2_collab.repo.OrderRepo" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User</title>
    <link rel="stylesheet" href="static/bootstrap.min.css">
    <style>
        .main-content {
            padding-top: 20px;
        }

    </style>
</head>
<body>
<%
    UserRepo userRepo = new UserRepo();
    OrderRepo orderRepo = new OrderRepo();
    List<User> users = userRepo.findAll();
%>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-10 main-content">
            <h1>User</h1>
            <div style="font-size: larger"><a href="http://localhost:8080/admin.jsp">HOMEPAGE</a>
                <a class="offset-1" style="font-size: large" href="userCreate.jsp">Create</a>
                <a class="offset-1" style="font-size: large" href="userDelete.jsp">Delete</a>
            </div>
            <table class="table table-striped">
                <thead>
                <tr>
                    <th>Id</th>
                    <th>Name</th>
                    <th>The Number Of Orders</th>
                    <th>#</th>
                </tr>
                </thead>
                <tbody>
                <%
                    for (User user : users) {%>
                <tr>
                    <td><%=user.getId()%>
                    </td>
                    <td>
                        <%=user.getName()%>
                    </td>
                    <td>
                        <%=orderRepo.findAll().stream().filter(order -> order.getUserId().getId().equals(user.getId())).toList().size()%>
                    </td>
                    <td>
                        <a href="userUpdate.jsp?userId=<%=user.getId()%>">
                            Update🔄
                        </a>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
