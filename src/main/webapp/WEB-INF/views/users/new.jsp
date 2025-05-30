<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="constants.AttributeConst" %>
<%@ page import="constants.ForwardConst" %>

<c:set var="actUsr" value="${ForwardConst.ACT_USR.getValue()}" />
<c:set var="commCreate" value="${ForwardConst.CMD_CREATE.getValue()}" />
<c:set var="commIdx" value="${ForwardConst.CMD_INDEX.getValue()}" />

<c:import url="../layout/app.jsp">
    <c:param name="content">

        <h2>ユーザー新規登録</h2>

        <!-- バリデーションエラーの表示 -->
        <c:if test="${errors != null}">
            <ul class="error_list">
                <c:forEach var="err" items="${errors}">
                    <li><c:out value="${err}" /></li>
                </c:forEach>
            </ul>
        </c:if>

        <!-- 入力フォーム -->
        <form method="POST" action="<c:url value='?action=${actUsr}&command=${commCreate}' />">
            <table>
                <tr>
                    <th>ユーザー名</th>
                    <td><input type="text" name="username" value="${user.username != null ? user.username : ''}" /></td>
                </tr>
                <tr>
                    <th>メールアドレス</th>
                    <td><input type="email" name="email" value="${user.email != null ? user.email : ''}" /></td>
                </tr>
                <tr>
                    <th>パスワード</th>
                    <td><input type="password" name="password" /></td>
                </tr>
            </table>

            <p>
                <input type="submit" value="登録" />
                <a href="<c:url value='?action=${actUsr}&command=${commIdx}' />">戻る</a>
            </p>
        </form>

    </c:param>
</c:import>
