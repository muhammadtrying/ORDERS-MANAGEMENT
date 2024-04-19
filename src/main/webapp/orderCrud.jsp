<%@ page import="java.util.List" %>
<%@ page import="uz.pdp.task_2_collab.repo.OrderRepo" %>
<%@ page import="uz.pdp.task_2_collab.entity.Order" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Order Cred</title>
    <link rel="stylesheet" href="static/bootstrap.min.css">
    <style>
        .main-content {
            padding-top: 20px;
        }
    </style>
</head>
<body>
<%
    OrderRepo orderRepo = new OrderRepo();
    List<Order> orders = orderRepo.findAll();
%>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-10 main-content">
            <h1>Orders</h1>
            <div style="font-size: larger">
                <a href="http://localhost:8080/admin.jsp">HOMEPAGE</a>
                <a class="offset-1" style="font-size: large" href="orderCreate.jsp">Create</a>
                <a class="offset-1" style="font-size: large" href="orderDelete.jsp">Delete</a>
            </div>
            <table class="table table-striped">
                <thead>
                <tr>
                    <th>Id</th>
                    <th>User</th>
                    <th>Created At</th>
                    <th>Status</th>
                    <th>#</th>
                </tr>
                </thead>
                <tbody>
                <%
                    SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
                    for (Order order : orders) {%>
                <tr>
                    <td><%=order.getId()%>
                    </td>
                    <td>
                        <%=order.getUserId().getName()%>
                    </td>
                    <td>
                        <%=dateFormat.format(order.getCreatedAt())%>
                    </td>
                    <td>
                        <%=order.getStatus().name()%>
                    </td>
                    <td>
                        <a href="orderUpdate.jsp?orderId=<%=order.getId()%>">
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
