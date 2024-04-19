<%@ page import="uz.pdp.task_2_collab.entity.Order" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="uz.pdp.task_2_collab.entity.Status" %>
<%@ page import="uz.pdp.task_2_collab.entity.User" %>
<%@ page import="java.util.Optional" %>
<%@ page import="uz.pdp.task_2_collab.repo.UserRepo" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Second Task</title>
    <link rel="stylesheet" href="static/bootstrap.min.css">
</head>
<style>

    .dropdown-content {
        display: none;
        position: absolute;
        background-color: #f1f1f1;
        min-width: 160px;
        box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
        z-index: 1;
    }

    .dropdown-content a {
        color: black;
        padding: 12px 16px;
        text-decoration: none;
        display: block;
    }

    .dropdown:hover .dropdown-content {
        display: block;
    }
</style>
<body>

<%

    UserRepo userRepo = new UserRepo();

    List<Order> orders = new ArrayList<>();
    Object objectFilteredOrders = request.getAttribute("filteredOrders");
    if (objectFilteredOrders != null) {
        orders = (List<Order>) objectFilteredOrders;
    }

    User currentUser = null;

    if (session.getAttribute("currentUser") != null) {
        currentUser = (User) session.getAttribute("currentUser");
    }


    Optional<User> optionalUser = userRepo.getUserByCookie(request);
    if (optionalUser.isPresent()) {
        currentUser = optionalUser.get();
    }
%>
<a class="btn-lg btn-dark" href="http://localhost:8080/">HomePage</a>
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="btn-group d-flex">
                <div>
                    <a class="btn-dark btn-lg" href="/order/servlet?status=<%=Status.OPEN.name()%>">Open Orders</a>
                </div>
                <div><a class="btn-dark btn-lg" href="/order/servlet?status=<%=Status.IN_PROGRESS.name()%>">Processing
                    Orders</a></div>
                <div><a class="btn-dark btn-lg" href="/order/servlet?status=<%=Status.COMPLETED.name()%>">Completed
                    Orders</a>
                </div>
            </div>
        </div>
        <%if (currentUser == null) {%>
        <div class="col-md-6 text-right">
            <a class="btn-dark btn-lg" href="login.jsp">Login</a>
        </div>
        <% } else { %>
        <div class="dropdown float-right">
            <button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown">
                <%= currentUser.getName() %>
            </button>
            <div class="dropdown-content">
                <a href="logOutServlet">Log Out</a>
                <a href="admin.jsp">Admin Panel</a>
            </div>
        </div>
        <% } %>

    </div>
    <div id="ordersDiv" class="row justify-content-center mt-5">
        <div class="col-md-8">
            <% if (!orders.isEmpty()) { %>
            <table class="table table-striped">
                <thead>
                <tr>
                    <th>Order Id</th>
                    <th>User</th>
                    <th>Status</th>
                </tr>
                </thead>
                <tbody>
                <% for (Order order : orders) { %>
                <tr>
                    <td><%= order.getId() %>
                    </td>
                    <td><%= order.getUserId().getName()%>
                    </td>
                    <td><%= order.getStatus().name()%>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
            <% } %>
        </div>
    </div>
</div>
</body>
</html>
