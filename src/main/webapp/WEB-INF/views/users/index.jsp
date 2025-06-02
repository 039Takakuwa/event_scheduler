<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="constants.AttributeConst"%>
<%@ page import="constants.ForwardConst"%>

<%
System.out.println("【DEBUG】index.jsp に入りました");
%>

<c:set var="actUsr" value="${ForwardConst.ACT_USR.getValue()}" />
<c:set var="commShow" value="${ForwardConst.CMD_SHOW.getValue()}" />
<c:set var="commNew" value="${ForwardConst.CMD_NEW.getValue()}" />
<c:set var="commIdx" value="${ForwardConst.CMD_INDEX.getValue()}" />
<c:set var="actLog" value="${ForwardConst.ACT_LOG.getValue()}" />
<c:set var="commLogout" value="${ForwardConst.CMD_LOGOUT.getValue()}" />

<c:import url="../layout/app.jsp">
    <c:param name="content">

        <!-- ログイン中ユーザーの表示 -->
        <c:if test="${not empty sessionScope.login_user}">
            <div id="login_info">
                <c:out value="${sessionScope.login_user.username}" />
                さんでログイン中 <a
                    href="<c:url value='?action=${actLog}&command=${commLogout}' />">[ログアウト]</a>
            </div>
        </c:if>

        <c:if test="${flush != null}">
            <div id="flush_success">
                <c:out value="${flush}"></c:out>
            </div>
        </c:if>

        <h2>ユーザー一覧</h2>

        <table id="user_list">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>ユーザー名</th>
                    <th>メールアドレス</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="user" items="${user_list}" varStatus="status">
                    <tr class="row${status.count % 2}">
                        <td><c:out value="${user.id}" /></td>
                        <td><c:out value="${user.username}" /></td>
                        <td><c:out value="${user.email}" /></td>
                        <td><a
                            href="<c:url value='?action=${actUsr}&command=${commShow}&id=${user.id}' />">詳細を見る</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <p>
            <a href="<c:url value='?action=${actUsr}&command=${commNew}' />">新規ユーザーの登録</a>
        </p>
    </c:param>
</c:import>
