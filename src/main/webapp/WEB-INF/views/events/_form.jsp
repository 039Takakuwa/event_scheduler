<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="constants.AttributeConst"%>
<%@ page import="constants.ForwardConst"%>

<c:if test="${errors != null}">
  <div class="mb-6 p-4 bg-red-100 text-red-700 rounded shadow">
    <p class="font-semibold">入力内容にエラーがあります：</p>
    <ul class="list-disc list-inside">
      <c:forEach var="error" items="${errors}">
        <li><c:out value="${error}" /></li>
      </c:forEach>
    </ul>
  </div>
</c:if>

<div class="space-y-4">
  <div>
    <label class="block font-medium text-gray-700">タイトル</label>
    <input type="text" name="title"
           value="${event.title != null ? event.title : ''}"
           class="w-full border border-gray-300 rounded px-4 py-2 focus:outline-none focus:ring focus:border-blue-300" />
  </div>

  <div>
    <label class="block font-medium text-gray-700">説明</label>
    <input type="text" name="description"
           value="${event.description != null ? event.description : ''}"
           class="w-full border border-gray-300 rounded px-4 py-2 focus:outline-none focus:ring focus:border-blue-300" />
  </div>

  <input type="hidden" name="${AttributeConst.EVENT_ID.getValue()}" value="${event.id}" />

  <div class="pt-4">
    <input type="submit" value="登録"
           class="w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-2 px-4 rounded transition" />
  </div>
</div>
