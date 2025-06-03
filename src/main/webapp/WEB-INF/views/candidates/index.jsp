<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="eventId" value="${event.id}" />

<c:import url="../layout/app.jsp">
    <c:param name="content">
        <h2>イベントid${event.id}のイベント候補日一覧</h2>

        <c:if test="${not empty flush}">
            <div id="flush_success">
                <c:out value="${flush}" />
            </div>
        </c:if>

        <table id="candidate_list">
            <thead>
                <tr>
                    <th>日付</th>
                    <th>開始時刻</th>
                    <th>終了時刻</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="candidate" items="${candidate_list}" varStatus="status">
                    <tr class="row${status.count % 2}">
                        <td><c:out value="${candidate.date}" /></td>
                        <td><c:out value="${candidate.startTime}" /></td>
                        <td><fmt:formatDate value="${candidate.endTime}" pattern="yyyy-MM-dd HH:mm" /></td>
                        <td>
                            <a href="<c:url value='?action=${actCnd}&command=${commShow}&id=${candidate.id}' />">詳細</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <p>
            <a href="<c:url value='?action=${actCnd}&command=${commNew}&event_id=${eventId}' />">新規候補日を作成する</a><br>
            <a href="<c:url value='?action=Event&command=${commIdx}' />">イベント一覧に戻る</a><br>
            <a href="<c:url value='?action=User&command=${commIdx}' />">ユーザー一覧に戻る</a>
        </p>
    </c:param>
</c:import>
