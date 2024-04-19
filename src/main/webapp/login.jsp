<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 4/19/2024
  Time: 12:42 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Log in</title>
    <link rel="stylesheet" href="static/bootstrap.min.css">
</head>
<body>

<div class="row">
    <div class="col-4 offset-4">
        <div class="card">
            <div class="card-header bg-dark text-white text-center">
                Log in
            </div>
            <div class="card-body">
                <form action="authServlet" method="post">
                    <input name="cameFrom" type="hidden" value="/login.jsp">
                    <div>
                        <input type="text" name="name" placeholder="Name..." class="form-control mt-2">
                    </div>

                    <div>
                        <input type="password" name="password" placeholder="Password..." class="form-control mt-2">
                    </div>
                    <div>
                        <label class="form-check-label mt-2">
                            <input type="checkbox" name="rememberMe" class="form-check"> Remember Me
                        </label>
                    </div>
                    <br>
                    <br>
                    <div class="card text-center">
                        <button class="btn btn-primary text-center">Login</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
