<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="constants.ForwardConst"%>

<%
String flush = (String) session.getAttribute("flush");
if (flush != null) {
    session.removeAttribute("flush");
    request.setAttribute("flush", flush);
}
%>

<c:set var="actEvn" value="${ForwardConst.ACT_EVENT.getValue()}" />
<c:set var="commShow" value="${ForwardConst.CMD_SHOW.getValue()}" />
<c:set var="commNew" value="${ForwardConst.CMD_NEW.getValue()}" />
<c:set var="commIdx" value="${ForwardConst.CMD_INDEX.getValue()}" />
<c:set var="actUsr" value="${ForwardConst.ACT_USR.getValue()}" />
<c:set var="commUsrIdx" value="${ForwardConst.CMD_INDEX.getValue()}" />

<c:import url="../layout/app.jsp">
    <c:param name="content">

        <div class="mb-6 flex justify-between items-center">
            <h2 class="text-2xl font-bold text-gray-800">イベント一覧</h2>
        </div>

        <c:if test="${not empty flush}">
            <div id="flash-message"
                class="fixed top-5 left-1/2 transform -translate-x-1/2 z-50
                bg-green-500 text-white px-6 py-3 rounded shadow-md
                transition-opacity duration-1500 ease-out">
                <c:out value="${flush}" />
            </div>
        </c:if>

        <div class="overflow-x-auto">
            <table class="min-w-full bg-white rounded-lg shadow-lg overflow-hidden">
                <thead class="bg-gradient-to-r from-green-600 to-emerald-600 text-white">
                    <tr>
                        <th class="text-left px-8 py-4 font-semibold tracking-wide">ID</th>
                        <th class="text-left px-8 py-4 font-semibold tracking-wide">タイトル</th>
                        <th class="text-left px-8 py-4 font-semibold tracking-wide">説明</th>
                        <th class="text-left px-8 py-4 font-semibold tracking-wide">作成者</th>
                        <th class="text-left px-8 py-4 font-semibold tracking-wide">作成日時</th>
                        <th class="text-left px-8 py-4 font-semibold tracking-wide">操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="event" items="${event_list}" varStatus="status">
                        <tr class="${status.count % 2 == 0 ? 'bg-gray-50' : 'bg-white'}
                                   hover:bg-gradient-to-r hover:from-green-100 hover:to-emerald-100
                                   transition duration-300 ease-in-out cursor-pointer">
                            <td class="px-8 py-4 font-mono"><c:out value="${event.id}" /></td>
                            <td class="px-8 py-4"><c:out value="${event.title}" /></td>
                            <td class="px-8 py-4"><c:out value="${event.description}" /></td>
                            <td class="px-8 py-4"><c:out value="${event.organizer.username}" /></td>
                            <td class="px-8 py-4">
                                <fmt:formatDate value="${event.createdAt}" pattern="yyyy-MM-dd HH:mm" />
                            </td>
                            <td class="px-8 py-4">
                                <a href="<c:url value='?action=${actEvn}&command=${commShow}&id=${event.id}' />"
                                   class="inline-block bg-emerald-500 hover:bg-emerald-600 text-white font-semibold px-4 py-2 rounded-lg shadow-md transition">
                                    詳細
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="mt-6 space-y-2">
            <a href="<c:url value='?action=${actEvn}&command=${commNew}' />"
               class="inline-block bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700 transition">
                新規イベントの作成
            </a><br>
            <a href="<c:url value='?action=${actUsr}&command=${commUsrIdx}' />"
               class="inline-block bg-gray-600 text-white px-4 py-2 rounded hover:bg-gray-700 transition">
                ユーザー一覧に戻る
            </a>
        </div>

        <script>
            window.addEventListener('DOMContentLoaded', () => {
                const flash = document.getElementById('flash-message');
                if (!flash) return;
                setTimeout(() => {
                    flash.classList.add('opacity-0');
                    setTimeout(() => {
                        flash.remove();
                    }, 1000);
                }, 3000);
            });
        </script>

    </c:param>
</c:import>
