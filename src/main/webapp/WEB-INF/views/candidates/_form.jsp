<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="constants.AttributeConst"%>
<%@ page import="constants.ForwardConst"%>

<c:set var="action" value="${ForwardConst.ACT_CANDIDATE.getValue()}" />
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

<form id="candidateForm" method="POST" action="<c:url value='?action=${actCnd}&command=${commCreate}' />">
    <table>
        <tr>
            <th>日付</th>
            <td>
                <input type="date" name="candidate_date"
                    value="${candidate.date != null ? candidate.date : ''}" />
            </td>
        </tr>
        <tr>
            <th>開始時刻</th>
            <td>
                <input type="time" id="startTime" name="candidate_start_time"
                    value="${candidate.startTime != null ? candidate.startTime : ''}" />
            </td>
        </tr>
        <tr>
            <th>終了時刻</th>
            <td>
                <input type="time" id="endTime" name="candidate_end_time"
                    value="${candidate.endTime != null ? candidate.endTime : ''}" />
            </td>
        </tr>
    </table>

    <p><input type="submit" value="登録" /></p>

    <input type="hidden" name="${AttributeConst.EVENT_ID.getValue()}" value="${event.id}" />
    <input type="hidden" name="${AttributeConst.TOKEN.getValue()}" value="${_token}" />
</form>