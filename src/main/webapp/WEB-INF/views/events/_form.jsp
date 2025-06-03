<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="constants.AttributeConst"%>
<%@ page import="constants.ForwardConst"%>

<c:set var="action" value="${ForwardConst.ACT_EVENT.getValue()}" />
<c:set var="commIdx" value="${ForwardConst.CMD_INDEX.getValue()}" />

<c:if test="${errors != null}">
    <div id="flush_error">
        入力内容にエラーがあります。<br />
        <c:forEach var="error" items="${errors}">
            ・<c:out value="${error}" />
            <br />
        </c:forEach>

    </div>
</c:if>
<form method="POST"
    action="<c:url value='?action=${actEvn}&command=${commCreate}' />">
    <table>
        <tr>
            <th>タイトル</th>
            <td><input type="text" name="title"
                value="${event.title != null ? event.title : ''}" /></td>
        </tr>
        <tr>
            <th>説明</th>
            <td><input type="text" name="description"
                value="${event.description != null ? event.description : ''}" /></td>
        </tr>
    </table>

    <p>
        <input type="submit" value="登録" />
    </p>
    <input type="hidden" name="${AttributeConst.EVENT_ID.getValue()}"
        value="${event.id}" />
</form>