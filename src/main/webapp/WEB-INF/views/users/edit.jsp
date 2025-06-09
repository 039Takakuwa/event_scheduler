<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="constants.AttributeConst" %>
<%@ page import="constants.ForwardConst" %>

<c:set var="actUsr" value="${ForwardConst.ACT_USR.getValue()}" />
<c:set var="commIdx" value="${ForwardConst.CMD_INDEX.getValue()}" />
<c:set var="commUpd" value="${ForwardConst.CMD_UPDATE.getValue()}" />
<c:set var="commDel" value="${ForwardConst.CMD_DESTROY.getValue()}" />

<c:import url="/WEB-INF/views/layout/app.jsp">
  <c:param name="content">

    <div class="max-w-xl mx-auto mt-10 bg-white p-8 rounded-lg shadow">
      <h2 class="text-2xl font-bold mb-4 text-center text-gray-800">
        ID: ${user.id} の従業員情報 編集
      </h2>
      <p class="text-sm text-gray-500 text-center mb-6">
        ※ パスワードは変更する場合のみ入力してください
      </p>

      <form method="POST" action="<c:url value='?action=${actUsr}&command=${commUpd}' />" class="space-y-6">
        <c:import url="_form.jsp" />
        <div class="flex justify-center">
          <input type="submit" value="更新" class="bg-blue-500 hover:bg-blue-600 text-white font-semibold py-2 px-6 rounded transition">
        </div>
      </form>

      <div class="mt-8 flex flex-col sm:flex-row justify-between gap-4">
        <a href="#" onclick="confirmDestroy();"
           class="w-full sm:w-auto text-center bg-red-500 hover:bg-red-600 text-white font-semibold py-2 px-4 rounded transition">
          この従業員情報を削除する
        </a>

        <form method="POST" action="<c:url value='?action=${actUsr}&command=${commDel}' />">
          <input type="hidden" name="${AttributeConst.USER_ID.getValue()}" value="${user.id}" />
        </form>

        <a href="<c:url value='?action=${actUsr}&command=${commIdx}' />"
           class="w-full sm:w-auto text-center bg-gray-300 hover:bg-gray-400 text-gray-800 font-semibold py-2 px-4 rounded transition">
          一覧に戻る
        </a>
      </div>
    </div>

    <script>
      function confirmDestroy() {
        if (confirm("本当に削除してよろしいですか？")) {
          document.forms[1].submit();
        }
      }
    </script>

  </c:param>
</c:import>
