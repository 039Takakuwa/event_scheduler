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

        <h2>ユーザー新規登録</h2>

        <form method="POST"
            action="<c:url value='?action=${actUsr}&command=${commCreate}' />">
            <c:import url="_form.jsp" />
        </form>
        <a href="<c:url value='?action=${actUsr}&command=${commIdx}' />">戻る</a>
    </c:param>
</c:import>
