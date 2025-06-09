<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="constants.AttributeConst"%>
<%@ page import="constants.ForwardConst"%>

<c:set var="actEvn" value="${ForwardConst.ACT_EVENT.getValue()}" />
<c:set var="commCreate" value="${ForwardConst.CMD_CREATE.getValue()}" />
<c:set var="commIdx" value="${ForwardConst.CMD_INDEX.getValue()}" />

<c:import url="../layout/app.jsp">
  <c:param name="content">

    <div class="max-w-xl mx-auto mt-10 bg-white p-8 rounded-lg shadow">
      <c:if test="${not empty sessionScope.login_user}">
        <div class="mb-4 text-sm text-gray-600 text-right">
          <span class="font-semibold"><c:out value="${sessionScope.login_user.username}" /></span> さんでログイン中
        </div>
      </c:if>

      <h2 class="text-2xl font-bold mb-6 text-center text-gray-800">イベント新規登録</h2>

      <form method="POST" action="<c:url value='?action=${actEvn}&command=${commCreate}' />" class="space-y-6">
        <c:import url="_form.jsp" />
      </form>

      <div class="mt-6 text-center">
        <a href="<c:url value='?action=${actEvn}&command=${commIdx}' />"
           class="text-blue-600 hover:underline font-medium">
          一覧に戻る
        </a>
      </div>
    </div>

  </c:param>
</c:import>
