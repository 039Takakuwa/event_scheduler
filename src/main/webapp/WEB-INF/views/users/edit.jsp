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

        <h2>id : ${user.id} の従業員情報 編集ページ</h2>
        <p>（パスワードは変更する場合のみ入力してください）</p>
        <form method="POST"
            action="<c:url value='?action=${actUsr}&command=${commUpd}' />">
            <c:import url="_form.jsp" />
        </form>

        <p>
            <a href="#" onclick="confirmDestroy();">この従業員情報を削除する</a>
        </p>
        <form method="POST"
            action="<c:url value='?action=${actUsr}&command=${commDel}' />">
            <input type="hidden" name="${AttributeConst.USER_ID.getValue()}" value="${user.id}" />
        </form>
        <script>
            function confirmDestroy() {
                if (confirm("本当に削除してよろしいですか？")) {
                    document.forms[1].submit();
                }
            }
        </script>

        <p>
            <a href="<c:url value='?action=${actUsr}&command=${commIdx}' />">一覧に戻る</a>
        </p>
    </c:param>
</c:import>