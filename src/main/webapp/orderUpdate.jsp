<%@ page import="uz.pdp.task_2_collab.repo.UserRepo" %>
<%@ page import="uz.pdp.task_2_collab.entity.User" %>
<%@ page import="java.util.List" %>
<%@ page import="uz.pdp.task_2_collab.entity.Order" %>
<%@ page import="uz.pdp.task_2_collab.repo.OrderRepo" %>
<%@ page import="uz.pdp.task_2_collab.entity.Status" %>
<%@ page import="java.util.ArrayList" %><%--
    Created by IntelliJ IDEA.
    User: muhammad
    Date: 19/04/24
    Time: 11:26 PM
    To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Update Order</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<%
    UserRepo userRepo = new UserRepo();
    OrderRepo orderRepo = new OrderRepo();

    List<User> users = userRepo.findAll();
    int orderId = Integer.parseInt(request.getParameter("orderId"));
    Order order = orderRepo.findById(orderId);
    List<Status> statuses = new ArrayList<>(List.of(
            Status.OPEN,
            Status.IN_PROGRESS,
            Status.COMPLETED
    ));
%>
<div class="container mt-5">
    <h2>Create Order</h2>
    <form action="order/servlet?orderId=<%=order.getId()%>" method="post">
        <input type="hidden" name="cameFrom" value="/orderUpdate.jsp">
        <div class="form-group">
            <select class="form-control" id="userSelect" name="userId">
                <%for (User user : users) { %>
                <option <%if (order.getUserId().getId().equals(user.getId()))%> selected<%%>
                                                                                value="<%=user.getId()%>"><%=user.getName()%>
                </option>
                <% } %>
            </select>
        </div>
        <div class="form-group">
            <select class="form-control" id="statusSelect" name="statusName">
                <%for (Status status : statuses) { %>
                <option <%if (order.getStatus().name().equals(status.name())) %> selected<%%>
                                                                                 value="<%=status.name()%>"><%=status.name()%>
                </option>
                <% } %>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">Update Order</button>
    </form>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
