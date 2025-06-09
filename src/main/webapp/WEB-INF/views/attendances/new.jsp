<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="constants.ForwardConst" %>
<%@ page import="constants.AttributeConst" %>

<c:import url="/WEB-INF/views/layout/app.jsp">
  <c:param name="content">

    <div class="max-w-xl mx-auto mt-10 bg-white p-8 rounded-lg shadow">
      <h2 class="text-2xl font-bold mb-6 text-center text-gray-800">出欠確認フォーム</h2>

      <div class="mb-6">
        <p class="text-gray-700">
          候補日: 
          <span class="font-medium"><c:out value="${candidate.date}" /></span>
          （<span class="font-medium"><c:out value="${candidate.startTime}" /></span> ～ 
          <span class="font-medium"><c:out value="${candidate.endTime}" /></span>）
        </p>
      </div>

      <form method="POST" action="<c:url value='?action=${ForwardConst.ACT_ATTENDANCE.getValue()}&command=${ForwardConst.CMD_CREATE.getValue()}' />" class="space-y-6">
        <input type="hidden" name="${AttributeConst.TOKEN.getValue()}" value="${_token}" />
        <input type="hidden" name="${AttributeConst.CANDIDATE_ID.getValue()}" value="${candidate.id}" />

        <div>
          <p class="text-gray-700 font-semibold mb-2">出欠の選択：</p>
          <div class="space-y-2">
            <label class="flex items-center">
              <input type="radio" name="${AttributeConst.ATTENDANCE_STATUS.getValue()}" value="0" class="mr-2" />
              出席
            </label>
            <label class="flex items-center">
              <input type="radio" name="${AttributeConst.ATTENDANCE_STATUS.getValue()}" value="1" class="mr-2" />
              欠席
            </label>
            <label class="flex items-center">
              <input type="radio" name="${AttributeConst.ATTENDANCE_STATUS.getValue()}" value="2" class="mr-2" />
              未定
            </label>
          </div>
        </div>

        <div>
          <button type="submit"
            class="w-full bg-blue-600 text-white font-semibold py-2 px-4 rounded hover:bg-blue-700 transition">
            回答する
          </button>
        </div>
      </form>

      <div class="mt-6 text-center">
        <a href="<c:url value='?action=${ForwardConst.ACT_EVENT.getValue()}&command=${ForwardConst.CMD_SHOW.getValue()}&id=${candidate.event.id}' />"
           class="text-blue-600 hover:underline font-medium">
          イベント詳細へ戻る
        </a>
      </div>
    </div>

  </c:param>
</c:import>
