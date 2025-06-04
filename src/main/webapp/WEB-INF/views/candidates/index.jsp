<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="eventId" value="${event.id}" />
<c:set var="actCnd" value="${ForwardConst.ACT_CANDIDATE.getValue()}" />
<c:set var="commDel" value="${ForwardConst.CMD_DESTROY.getValue()}" />
<c:set var="commNew" value="${ForwardConst.CMD_NEW.getValue()}" />
<c:set var="commIdx" value="${ForwardConst.CMD_INDEX.getValue()}" />

<%@ page import="constants.ForwardConst" %>
<%@ page import="constants.AttributeConst" %>

<c:import url="../layout/app.jsp">
    <c:param name="content">
        <h2>イベントid${event.id}の候補日一覧</h2>

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
                <c:forEach var="candidate" items="${candidate_list}"
                    varStatus="status">
                    <tr class="row${status.count % 2}">
                        <td><c:out value="${candidate.date}" /></td>
                        <td><c:out value="${candidate.startTime}" /></td>
                        <td><c:out value="${candidate.endTime}" /></td>
                        <td>
                            <!-- 削除リンク --> <a href="#"
                            onclick="confirmCandidateDelete(${candidate.id}); return false;">削除</a>

                            <!-- 削除用フォーム（非表示） -->
                            <form id="deleteForm_${candidate.id}" method="POST"
                                action="<c:url value='?action=${actCnd}&command=${commDel}' />">
                                <input type="hidden" name="id" value="${candidate.id}" />
                                <input type="hidden" name="${AttributeConst.EVENT_ID.getValue()}"
                                    value="${event.id}" />
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <p>
            <a
                href="<c:url value='?action=${actCnd}&command=${commNew}&event_id=${eventId}' />">新規候補日を作成する</a><br>
            <a href="<c:url value='?action=Event&command=${commIdx}' />">イベント一覧に戻る</a><br>
            <a href="<c:url value='?action=User&command=${commIdx}' />">ユーザー一覧に戻る</a>
        </p>
    </c:param>
</c:import>

<script>
function confirmCandidateDelete(id) {
    if (confirm("この候補日を本当に削除してよろしいですか？")) {
        document.getElementById("deleteForm_" + id).submit();
    }
}
</script>
