<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="constants.ForwardConst"%>
<%@ page import="constants.AttributeConst"%>

<c:set var="actEvn" value="${ForwardConst.ACT_EVENT.getValue()}" />
<c:set var="commIdx" value="${ForwardConst.CMD_INDEX.getValue()}" />
<c:set var="commEdit" value="${ForwardConst.CMD_EDIT.getValue()}" />

<c:import url="/WEB-INF/views/layout/app.jsp">
    <c:param name="content">

        <h2>id : ${event.id} のイベント情報 詳細ページ</h2>

        <c:if test="${not empty flush}">
            <div id="flush_success">
                <c:out value="${flush}" />
            </div>
        </c:if>

        <table>
            <tbody>
                <tr>
                    <th>タイトル</th>
                    <td><c:out value="${event.title}" /></td>
                </tr>
                <tr>
                    <th>詳細</th>
                    <td><c:out value="${event.description}" /></td>
                </tr>
                <tr>
                    <th>作成者</th>
                    <td><c:out value="${event.organizer.username}" /></td>
                </tr>
                <tr>
                    <th>登録日時</th>
                    <td><fmt:formatDate value="${event.createdAt}"
                            pattern="yyyy-MM-dd HH:mm:ss" /></td>
                </tr>
            </tbody>
        </table>

        <h2>候補日一覧</h2>
        <c:if test="${not empty candidate_list}">
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
                            <td><a href="#"
                                onclick="confirmCandidateDelete(${candidate.id}); return false;">削除</a><br>
                                <a
                                href="<c:url value='?action=Attendance&command=newAttendance&id=${candidate.id}' />">
                                    出欠回答 </a>

                                <form id="deleteForm_${candidate.id}" method="POST"
                                    action="<c:url value='?action=${ForwardConst.ACT_CANDIDATE.getValue()}&command=${ForwardConst.CMD_DESTROY.getValue()}' />">
                                    <input type="hidden" name="id" value="${candidate.id}" /> <input
                                        type="hidden" name="${AttributeConst.EVENT_ID.getValue()}"
                                        value="${event.id}" />
                                </form></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>

        <c:if test="${empty candidate_list}">
            <p>候補日はまだ登録されていません。</p>
        </c:if>

        <p>
            <a
                href="<c:url value='?action=${ForwardConst.ACT_CANDIDATE.getValue()}&command=${ForwardConst.CMD_NEW.getValue()}&event_id=${event.id}' />">
                新規候補日を追加する </a>
        </p>

        <script>
function confirmCandidateDelete(id) {
    if (confirm("この候補日を本当に削除してよろしいですか？")) {
        document.getElementById("deleteForm_" + id).submit();
    }
}
</script>

        <p>
            <a
                href="<c:url value='?action=${actEvn}&command=${commEdit}&id=${event.id}' />">このイベント情報を編集する</a>
        </p>

        <p>
            <a href="<c:url value='?action=${actEvn}&command=${commIdx}' />">一覧に戻る</a>
        </p>
    </c:param>
</c:import>