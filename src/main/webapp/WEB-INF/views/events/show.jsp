<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="constants.ForwardConst"%>
<%@ page import="constants.AttributeConst"%>

<%
// セッションからフラッシュメッセージを取得して表示後は削除
String flush = (String) session.getAttribute("flush");
if (flush != null) {
    session.removeAttribute("flush");
    request.setAttribute("flush", flush);
}
%>

<c:set var="actEvn" value="${ForwardConst.ACT_EVENT.getValue()}" />
<c:set var="commIdx" value="${ForwardConst.CMD_INDEX.getValue()}" />
<c:set var="commEdit" value="${ForwardConst.CMD_EDIT.getValue()}" />

<c:import url="/WEB-INF/views/layout/app.jsp">
  <c:param name="content">

    <div class="max-w-3xl mx-auto mt-10 bg-white p-8 rounded-lg shadow">
      <h2 class="text-2xl font-bold mb-6 text-center text-gray-800">
        ID: ${event.id} のイベント詳細
      </h2>

        <c:if test="${not empty flush}">
            <div id="flash-message"
                class="fixed top-5 left-1/2 transform -translate-x-1/2 z-50 
            bg-green-500 text-white px-6 py-3 rounded shadow-md 
            transition-opacity duration-1500 ease-out">
                <c:out value="${flush}" />
            </div>

        </c:if>

      <div class="space-y-4 mb-8">
        <div class="flex justify-between">
          <span class="font-medium text-gray-700">タイトル</span>
          <span class="text-gray-900"><c:out value="${event.title}" /></span>
        </div>
        <div class="flex justify-between">
          <span class="font-medium text-gray-700">詳細</span>
          <span class="text-gray-900"><c:out value="${event.description}" /></span>
        </div>
        <div class="flex justify-between">
          <span class="font-medium text-gray-700">作成者</span>
          <span class="text-gray-900"><c:out value="${event.organizer.username}" /></span>
        </div>
        <div class="flex justify-between">
          <span class="font-medium text-gray-700">登録日時</span>
          <span class="text-gray-900">
            <fmt:formatDate value="${event.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" />
          </span>
        </div>
      </div>

      <h3 class="text-xl font-semibold text-gray-700 mb-4 border-b pb-2">候補日一覧</h3>

      <c:if test="${not empty candidate_list}">
        <div class="overflow-x-auto mb-6">
          <table class="min-w-full text-sm text-left border rounded">
            <thead class="bg-gray-100 text-gray-700">
              <tr>
                <th class="px-4 py-2">日付</th>
                <th class="px-4 py-2">開始時刻</th>
                <th class="px-4 py-2">終了時刻</th>
                <th class="px-4 py-2">自分の回答</th>
                <th class="px-4 py-2">操作</th>
              </tr>
            </thead>
            <tbody class="text-gray-800">
              <c:forEach var="candidate" items="${candidate_list}" varStatus="status">
                <tr class="${status.count % 2 == 0 ? 'bg-white' : 'bg-gray-50'}">
                  <td class="px-4 py-2"><c:out value="${candidate.date}" /></td>
                  <td class="px-4 py-2"><c:out value="${candidate.startTime}" /></td>
                  <td class="px-4 py-2"><c:out value="${candidate.endTime}" /></td>
                  <td class="px-4 py-2">
                    <c:choose>
                      <c:when test="${not empty my_attendances[candidate]}">
                        <c:choose>
                          <c:when test="${my_attendances[candidate].status == 0}">出席</c:when>
                          <c:when test="${my_attendances[candidate].status == 1}">欠席</c:when>
                          <c:when test="${my_attendances[candidate].status == 2}">未定</c:when>
                          <c:otherwise>未設定</c:otherwise>
                        </c:choose>
                      </c:when>
                      <c:otherwise>未回答</c:otherwise>
                    </c:choose>
                  </td>
                  <td class="px-4 py-2 space-y-1">
                    <a href="#" onclick="confirmCandidateDelete(${candidate.id}); return false;"
                       class="text-red-600 hover:underline">削除</a><br>
                    <a href="<c:url value='?action=Attendance&command=newAttendance&id=${candidate.id}' />"
                       class="text-blue-600 hover:underline">出欠回答</a>
                    <form id="deleteForm_${candidate.id}" method="POST"
                          action="<c:url value='?action=${ForwardConst.ACT_CANDIDATE.getValue()}&command=${ForwardConst.CMD_DESTROY.getValue()}' />">
                      <input type="hidden" name="id" value="${candidate.id}" />
                      <input type="hidden" name="${AttributeConst.EVENT_ID.getValue()}" value="${event.id}" />
                    </form>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </c:if>

      <c:if test="${empty candidate_list}">
        <p class="text-gray-600 mb-6">候補日はまだ登録されていません。</p>
      </c:if>

      <!-- 操作ボタン -->
      <div class="mt-8 flex flex-col sm:flex-row gap-4">
        <a href="<c:url value='?action=${ForwardConst.ACT_CANDIDATE.getValue()}&command=${ForwardConst.CMD_NEW.getValue()}&event_id=${event.id}' />"
           class="w-full sm:w-auto text-center bg-blue-600 hover:bg-blue-700 text-white font-semibold py-2 px-4 rounded transition">
          新規候補日を追加
        </a>

        <a href="<c:url value='?action=Attendance&command=summary&event_id=${event.id}' />"
           class="w-full sm:w-auto text-center bg-purple-600 hover:bg-purple-700 text-white font-semibold py-2 px-4 rounded transition">
          出欠集計を表示
        </a>

        <a href="<c:url value='?action=${actEvn}&command=${commEdit}&id=${event.id}' />"
           class="w-full sm:w-auto text-center bg-yellow-500 hover:bg-yellow-600 text-white font-semibold py-2 px-4 rounded transition">
          このイベント情報を編集
        </a>

        <a href="<c:url value='?action=${actEvn}&command=${commIdx}' />"
           class="w-full sm:w-auto text-center bg-gray-300 hover:bg-gray-400 text-gray-800 font-semibold py-2 px-4 rounded transition">
          一覧に戻る
        </a>
      </div>
    </div>

    <script>
      function confirmCandidateDelete(id) {
        if (confirm("この候補日を本当に削除してよろしいですか？")) {
          document.getElementById("deleteForm_" + id).submit();
        }
      }
    </script>

        <script>
  window.addEventListener('DOMContentLoaded', () => {
    const flash = document.getElementById('flash-message');
    if (!flash) return;

    setTimeout(() => {
      flash.classList.add('opacity-0');  // ふわっと消える
      setTimeout(() => {
        flash.remove();  // DOMから削除
      }, 1000); // フェードアウト終了後
    }, 3000); // 表示から3秒後に開始
  });
</script>

  </c:param>
</c:import>
