<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<h2>イベント「<c:out value='${event.title}' />」の出欠集計</h2>

<table border="1" cellpadding="5" cellspacing="0">
    <thead>
        <tr>
            <th>日付</th>
            <th>開始時刻</th>
            <th>終了時刻</th>
            <th>出席者</th>
            <th>欠席者</th>
            <th>未回答</th>
            <th>出席人数</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="entry" items="${attendance_summary}">
            <c:set var="candidate" value="${entry.key}" />
            <c:set var="statuses" value="${entry.value}" />
            <c:set var="attending" value="${statuses.attending}" />
            <c:set var="absent" value="${statuses.absent}" />
            <c:set var="notResponded" value="${statuses.not_responded}" />
            <c:set var="isMax" value="${candidate.id == maxAttendanceCandidateId}" />
            
            <tr style="<c:if test='${isMax}'>background-color: #d4f4dd;</c:if>">
                <td><c:out value="${candidate.date}" /></td>
                <td><c:out value="${candidate.startTime}" /></td>
                <td><c:out value="${candidate.endTime}" /></td>

                <td>
                    <c:forEach var="user" items="${attending}">
                        <div><c:out value="${user.username}" /></div>
                    </c:forEach>
                </td>
                <td>
                    <c:forEach var="user" items="${absent}">
                        <div><c:out value="${user.username}" /></div>
                    </c:forEach>
                </td>
                <td>
                    <c:forEach var="user" items="${notResponded}">
                        <div><c:out value="${user.username}" /></div>
                    </c:forEach>
                </td>
                <td align="center"><c:out value="${fn:length(attending)}" /></td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<p>
    <a href="<c:url value='?action=Event&command=show&id=${event.id}' />">イベント詳細に戻る</a>
</p>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
