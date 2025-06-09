<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="constants.ForwardConst" %>
<%@ page import="constants.AttributeConst" %>

<c:set var="actUsr" value="${ForwardConst.ACT_USR.getValue()}" />
<c:set var="commIdx" value="${ForwardConst.CMD_INDEX.getValue()}" />
<c:set var="commEdit" value="${ForwardConst.CMD_EDIT.getValue()}" />

<c:import url="/WEB-INF/views/layout/app.jsp">
  <c:param name="content">

    <div class="max-w-xl mx-auto mt-10 bg-white p-8 rounded-lg shadow">
      <h2 class="text-2xl font-bold mb-6 text-center text-gray-800">
        ID: ${user.id} のユーザ情報 詳細
      </h2>

      <div class="space-y-4">
        <div class="flex justify-between">
          <span class="font-medium text-gray-700">氏名</span>
          <span class="text-gray-900"><c:out value="${user.username}" /></span>
        </div>
        <div class="flex justify-between">
          <span class="font-medium text-gray-700">メールアドレス</span>
          <span class="text-gray-900"><c:out value="${user.email}" /></span>
        </div>
        <div class="flex justify-between">
          <span class="font-medium text-gray-700">登録日時</span>
          <span class="text-gray-900">
            <fmt:formatDate value="${user.createdAt}" pattern="yyyy-MM-dd HH:mm" />
          </span>
        </div>
      </div>

      <div class="mt-8 flex flex-col sm:flex-row justify-between gap-4">
        <a href="<c:url value='?action=${actUsr}&command=${commEdit}&id=${user.id}' />"
           class="w-full sm:w-auto text-center bg-yellow-500 hover:bg-yellow-600 text-white font-semibold py-2 px-4 rounded transition">
          このユーザ情報を編集する
        </a>

        <a href="<c:url value='?action=${actUsr}&command=${commIdx}' />"
           class="w-full sm:w-auto text-center bg-gray-300 hover:bg-gray-400 text-gray-800 font-semibold py-2 px-4 rounded transition">
          一覧に戻る
        </a>
      </div>
    </div>

  </c:param>
</c:import>
