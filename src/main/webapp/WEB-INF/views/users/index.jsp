<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="constants.AttributeConst"%>
<%@ page import="constants.ForwardConst"%>

<%
// セッションからフラッシュメッセージを取得して表示後は削除
String flush = (String) session.getAttribute("flush");
if (flush != null) {
    session.removeAttribute("flush");
    request.setAttribute("flush", flush);
}
%>

<c:set var="actUsr" value="${ForwardConst.ACT_USR.getValue()}" />
<c:set var="commShow" value="${ForwardConst.CMD_SHOW.getValue()}" />
<c:set var="commNew" value="${ForwardConst.CMD_NEW.getValue()}" />
<c:set var="commIdx" value="${ForwardConst.CMD_INDEX.getValue()}" />
<c:set var="actLog" value="${ForwardConst.ACT_LOG.getValue()}" />
<c:set var="commLogout" value="${ForwardConst.CMD_LOGOUT.getValue()}" />
<c:set var="actEvn" value="${ForwardConst.ACT_EVENT.getValue()}" />

<c:import url="../layout/app.jsp">
    <c:param name="content">
        <div class="mb-6 flex justify-between items-center">
            <h2 class="text-2xl font-bold text-gray-800">ユーザー一覧</h2>
            <c:if test="${not empty sessionScope.login_user}">
                <div class="text-sm text-gray-600">
                    <span class="mr-2 font-medium"><c:out
                            value="${sessionScope.login_user.username}" /></span> さんでログイン中 <a
                        href="<c:url value='?action=${actLog}&command=${commLogout}' />"
                        class="ml-2 text-blue-600 hover:underline">[ログアウト]</a>
                </div>
            </c:if>
        </div>

        <!-- フラッシュメッセージ -->
        <c:if test="${not empty flush}">
            <div id="flash-message"
                class="fixed top-5 left-1/2 transform -translate-x-1/2 z-50 
            bg-green-500 text-white px-6 py-3 rounded shadow-md 
            transition-opacity duration-1500 ease-out">
                <c:out value="${flush}" />
            </div>

        </c:if>

        <div class="overflow-x-auto">
            <table
                class="min-w-full bg-white rounded-lg shadow-lg overflow-hidden">
                <thead
                    class="bg-gradient-to-r from-blue-600 to-indigo-600 text-white">
                    <tr>
                        <th class="text-left px-8 py-4 font-semibold tracking-wide">ID</th>
                        <th class="text-left px-8 py-4 font-semibold tracking-wide">ユーザー名</th>
                        <th class="text-left px-8 py-4 font-semibold tracking-wide">メールアドレス</th>
                        <th class="text-left px-8 py-4 font-semibold tracking-wide">操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${user_list}" varStatus="status">
                        <tr
                            class="${status.count % 2 == 0 ? 'bg-gray-50' : 'bg-white'} 
                   hover:bg-gradient-to-r hover:from-blue-100 hover:to-indigo-100
                   transition duration-300 ease-in-out cursor-pointer">
                            <td class="px-8 py-5 font-mono text-gray-800 whitespace-nowrap"><c:out
                                    value="${user.id}" /></td>
                            <td class="px-8 py-5 text-gray-900"><c:out
                                    value="${user.username}" /></td>
                            <td class="px-8 py-5 text-gray-900"><c:out
                                    value="${user.email}" /></td>
                            <td class="px-8 py-5"><a
                                href="<c:url value='?action=${actUsr}&command=${commShow}&id=${user.id}' />"
                                class="inline-block bg-indigo-500 hover:bg-indigo-600 text-white font-semibold px-4 py-2 rounded-lg shadow-md
                      transition duration-300">詳細を見る</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="mt-6 space-y-2">
            <a href="<c:url value='?action=${actUsr}&command=${commNew}' />"
                class="inline-block bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 transition">新規ユーザーの登録</a><br>
            <a href="<c:url value='?action=${actEvn}&command=${commNew}' />"
                class="inline-block bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700 transition">新規イベントの登録</a><br>
            <a href="<c:url value='?action=${actEvn}&command=${commIdx}' />"
                class="inline-block bg-gray-600 text-white px-4 py-2 rounded hover:bg-gray-700 transition">イベント一覧</a>
        </div>

        <!-- JavaScriptで3秒後にフラッシュを非表示 -->
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
