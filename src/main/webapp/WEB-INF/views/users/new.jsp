<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="constants.AttributeConst"%>
<%@ page import="constants.ForwardConst"%>

<c:set var="actUsr" value="${ForwardConst.ACT_USR.getValue()}" />
<c:set var="commCreate" value="${ForwardConst.CMD_CREATE.getValue()}" />
<c:set var="commIdx" value="${ForwardConst.CMD_INDEX.getValue()}" />

<c:import url="../layout/app.jsp">
  <c:param name="content">

    <div class="max-w-xl mx-auto bg-white p-8 rounded-lg shadow-md mt-8">
      <h2 class="text-2xl font-bold mb-6 text-center text-gray-800">ユーザー新規登録</h2>

      <form method="POST"
            action="<c:url value='?action=${actUsr}&command=${commCreate}' />">
        <c:import url="_form.jsp" />
      </form>

      <div class="text-center mt-6">
        <a href="<c:url value='?action=${actUsr}&command=${commIdx}' />"
           class="inline-block text-sm text-gray-600 hover:text-blue-600 underline">
           戻る
        </a>
      </div>
    </div>

  </c:param>
</c:import>
