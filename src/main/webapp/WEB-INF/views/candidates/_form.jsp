<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="constants.AttributeConst"%>
<%@ page import="constants.ForwardConst"%>

<c:set var="actCnd" value="${ForwardConst.ACT_CANDIDATE.getValue()}" />
<c:set var="commCreate" value="${ForwardConst.CMD_CREATE.getValue()}" />

<c:if test="${errors != null}">
  <div class="mb-4 p-4 bg-red-100 text-red-800 border border-red-300 rounded">
    <p class="font-semibold mb-2">入力内容にエラーがあります：</p>
    <ul class="list-disc pl-5">
      <c:forEach var="error" items="${errors}">
        <li><c:out value="${error}" /></li>
      </c:forEach>
    </ul>
  </div>
</c:if>

<div class="space-y-4">
  <div>
    <label class="block text-gray-700 font-medium mb-1">日付</label>
    <input type="date" name="candidate_date"
           value="${candidate.date != null ? candidate.date : ''}"
           class="w-full border-gray-300 rounded px-3 py-2 shadow-sm focus:outline-none focus:ring focus:border-blue-300" />
  </div>

  <div>
    <label class="block text-gray-700 font-medium mb-1">開始時刻</label>
    <input type="time" id="startTime" name="candidate_start_time"
           value="${candidate.startTime != null ? candidate.startTime : ''}"
           class="w-full border-gray-300 rounded px-3 py-2 shadow-sm focus:outline-none focus:ring focus:border-blue-300" />
  </div>

  <div>
    <label class="block text-gray-700 font-medium mb-1">終了時刻</label>
    <input type="time" id="endTime" name="candidate_end_time"
           value="${candidate.endTime != null ? candidate.endTime : ''}"
           class="w-full border-gray-300 rounded px-3 py-2 shadow-sm focus:outline-none focus:ring focus:border-blue-300" />
  </div>
</div>

<div class="mt-6">
  <input type="submit" value="登録"
         class="w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-2 px-4 rounded transition" />
</div>

<input type="hidden" name="${AttributeConst.EVENT_ID.getValue()}" value="${event.id}" />
<input type="hidden" name="${AttributeConst.TOKEN.getValue()}" value="${_token}" />
