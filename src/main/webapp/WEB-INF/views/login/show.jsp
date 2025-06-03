<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="../layout/app.jsp">
    <c:param name="content">
        <h2>ログイン</h2>

        <c:if test="${not empty error}">
            <p style="color: red;">
                <c:out value="${error}" />
            </p>
        </c:if>

        <form action="?action=Log&command=login" method="post">
            <label>ユーザー名：<input type="text" name="username" /></label><br>
            <label>パスワード：<input type="password" name="password" /></label><br>
            <input type="submit" value="ログイン" />
        </form>
    </c:param>
</c:import>