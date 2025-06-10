<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="constants.AttributeConst" %>
<%@ page import="constants.ForwardConst" %>

<c:set var="actEvn" value="${ForwardConst.ACT_EVENT.getValue()}" />
<c:set var="commIdx" value="${ForwardConst.CMD_INDEX.getValue()}" />
<c:set var="commShow" value="${ForwardConst.CMD_SHOW.getValue()}" />
<c:set var="commUpd" value="${ForwardConst.CMD_UPDATE.getValue()}" />
<c:set var="commDel" value="${ForwardConst.CMD_DESTROY.getValue()}" />

<c:import url="/WEB-INF/views/layout/app.jsp">
  <c:param name="content">

    <div class="max-w-xl mx-auto mt-10 bg-white p-8 rounded-lg shadow">
      <h2 class="text-2xl font-bold mb-6 text-center text-gray-800">
        ID: ${event.id} のイベント情報 編集
      </h2>

      <form method="POST" action="<c:url value='?action=${actEvn}&command=${commUpd}' />" class="space-y-6">
        <c:import url="_form.jsp" />
      </form>

      <div class="mt-6">
        <button onclick="confirmDestroy();"
                class="w-full text-red-600 hover:underline text-center font-medium">
          このイベントを削除する
        </button>
        <form method="POST"
              action="<c:url value='?action=${actEvn}&command=${commDel}' />"
              id="deleteForm">
          <input type="hidden" name="${AttributeConst.EVENT_ID.getValue()}" value="${event.id}" />
        </form>
      </div>

      <div class="mt-6 text-center">
        <a href="<c:url value='?action=${actEvn}&command=${commShow}&id=${event.id}' />"
           class="text-blue-600 hover:underline font-medium">
          イベント詳細に戻る
        </a>
      </div>
    </div>

    <script>
      function confirmDestroy() {
        if (confirm("本当に削除してよろしいですか？")) {
          document.getElementById("deleteForm").submit();
        }
      }
    </script>

  </c:param>
</c:import>
