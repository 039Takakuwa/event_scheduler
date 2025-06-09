<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:import url="/WEB-INF/views/layout/app.jsp">
  <c:param name="content">
    <div class="max-w-7xl mx-auto p-6 bg-white rounded-lg shadow-md mt-10">
      <h2 class="text-3xl font-extrabold text-indigo-700 mb-8 border-b-4 border-indigo-300 pb-2">
        イベント「<c:out value='${event.title}' />」の出欠集計
      </h2>

      <div class="overflow-x-auto rounded-lg border border-gray-200 shadow-lg">
        <table class="min-w-full text-left text-gray-700">
          <thead class="bg-purple-700 text-white">
            <tr>
              <th class="px-6 py-3 uppercase tracking-wider font-semibold">日付</th>
              <th class="px-6 py-3 uppercase tracking-wider font-semibold">開始時刻</th>
              <th class="px-6 py-3 uppercase tracking-wider font-semibold">終了時刻</th>
              <th class="px-6 py-3 uppercase tracking-wider font-semibold">出席者</th>
              <th class="px-6 py-3 uppercase tracking-wider font-semibold">欠席者</th>
              <th class="px-6 py-3 uppercase tracking-wider font-semibold">未回答</th>
              <th class="px-6 py-3 uppercase tracking-wider font-semibold text-center">出席人数</th>
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

              <tr class="transition-colors duration-300
                <c:if test='${isMax}'>bg-indigo-100 font-semibold</c:if>
                hover:bg-indigo-50">
                <td class="px-6 py-4 border-b border-gray-200"><c:out value="${candidate.date}" /></td>
                <td class="px-6 py-4 border-b border-gray-200"><c:out value="${candidate.startTime}" /></td>
                <td class="px-6 py-4 border-b border-gray-200"><c:out value="${candidate.endTime}" /></td>

                <td class="px-6 py-4 border-b border-gray-200 space-y-1">
                  <c:forEach var="user" items="${attending}">
                    <span class="inline-block bg-green-200 text-green-800 px-2 py-0.5 rounded-full text-xs font-medium">
                      <c:out value="${user.username}" />
                    </span>
                  </c:forEach>
                </td>

                <td class="px-6 py-4 border-b border-gray-200 space-y-1">
                  <c:forEach var="user" items="${absent}">
                    <span class="inline-block bg-red-200 text-red-800 px-2 py-0.5 rounded-full text-xs font-medium">
                      <c:out value="${user.username}" />
                    </span>
                  </c:forEach>
                </td>

                <td class="px-6 py-4 border-b border-gray-200 space-y-1">
                  <c:forEach var="user" items="${notResponded}">
                    <span class="inline-block bg-yellow-200 text-yellow-800 px-2 py-0.5 rounded-full text-xs font-medium">
                      <c:out value="${user.username}" />
                    </span>
                  </c:forEach>
                </td>

                <td class="px-6 py-4 border-b border-gray-200 text-center text-indigo-700 font-bold text-lg">
                  <c:out value="${fn:length(attending)}" />
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>

      <div class="mt-8">
        <a href="<c:url value='?action=Event&command=show&id=${event.id}' />" 
           class="inline-block bg-indigo-600 hover:bg-indigo-700 text-white px-6 py-2 rounded-md font-semibold shadow-md transition-colors duration-200">
          イベント詳細に戻る
        </a>
      </div>
    </div>
  </c:param>
</c:import>
