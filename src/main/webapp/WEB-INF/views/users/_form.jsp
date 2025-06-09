<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="constants.AttributeConst"%>
<%@ page import="constants.ForwardConst"%>

<c:set var="actUsr" value="${ForwardConst.ACT_USR.getValue()}" />

<c:if test="${errors != null}">
  <div class="mb-6 bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded">
    <p class="font-semibold mb-2">入力内容にエラーがあります。</p>
    <ul class="list-disc list-inside text-sm">
      <c:forEach var="error" items="${errors}">
        <li><c:out value="${error}" /></li>
      </c:forEach>
    </ul>
  </div>
</c:if>

<div class="space-y-4">
  <div>
    <label for="username" class="block text-sm font-medium text-gray-700">ユーザー名</label>
    <input type="text" name="username" id="username"
           value="${user.username != null ? user.username : ''}"
           class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500" />
  </div>

  <div>
    <label for="email" class="block text-sm font-medium text-gray-700">メールアドレス</label>
    <input type="email" name="email" id="email"
           value="${user.email != null ? user.email : ''}"
           class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500" />
  </div>

  <div>
    <label for="password" class="block text-sm font-medium text-gray-700">パスワード</label>
    <input type="password" name="password" id="password"
           class="mt-1 block w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500" />
  </div>

  <input type="hidden" name="${AttributeConst.USER_ID.getValue()}" value="${user.id}" />

  <div class="pt-4">
    <button type="submit"
            class="w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-2 px-4 rounded shadow-md transition duration-300">
      登録
    </button>
  </div>
</div>
