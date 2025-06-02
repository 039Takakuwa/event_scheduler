<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="constants.AttributeConst"%>
<%@ page import="constants.ForwardConst"%>

<c:set var="action" value="${ForwardConst.ACT_USR.getValue()}" />
<c:set var="commIdx" value="${ForwardConst.CMD_INDEX.getValue()}" />

<c:if test="${errors != null}">
    <div id="flush_error">
        入力内容にエラーがあります。<br />
        <c:forEach var="error" items="${errors}">
            ・<c:out value="${error}" />
            <br />
        </c:forEach>

    </div>
</c:if>
<form method="POST"
    action="<c:url value='?action=${actUsr}&command=${commCreate}' />">
    <table>
        <tr>
            <th>ユーザー名</th>
            <td><input type="text" name="username"
                value="${user.username != null ? user.username : ''}" /></td>
        </tr>
        <tr>
            <th>メールアドレス</th>
            <td><input type="email" name="email"
                value="${user.email != null ? user.email : ''}" /></td>
        </tr>
        <tr>
            <th>パスワード</th>
            <td><input type="password" name="password" /></td>
        </tr>
    </table>

    <p>
        <input type="submit" value="登録" />
    </p>
    <input type="hidden" name="${AttributeConst.USER_ID.getValue()}"
        value="${user.id}" />
</form>