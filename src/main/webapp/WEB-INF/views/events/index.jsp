<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="../layout/app.jsp">
    <c:param name="content">
        <h2>イベント一覧</h2>

        <c:if test="${not empty flush}">
            <div id="flush_success">
                <c:out value="${flush}" />
            </div>
        </c:if>

        <table id="event_list">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>タイトル</th>
                    <th>説明</th>
                    <th>作成者</th>
                    <th>作成日時</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="event" items="${event_list}" varStatus="status">
                    <tr class="row${status.count % 2}">
                        <td><c:out value="${event.id}" /></td>
                        <td><c:out value="${event.title}" /></td>
                        <td><c:out value="${event.description}" /></td>
                        <td><c:out value="${event.organizer.username}" /></td>
                        <td><fmt:formatDate value="${event.createdAt}" pattern="yyyy-MM-dd HH:mm" /></td>
                        <td>
                            <a href="<c:url value='?action=${actEvn}&command=${commShow}&id=${event.id}' />">詳細</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <p>
            <a href="<c:url value='?action=${actEvn}&command=${commNew}' />">新規イベントの作成</a>
        </p>
    </c:param>
</c:import>
