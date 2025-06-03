<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="constants.ForwardConst" %>
<%@ page import="constants.AttributeConst" %>

<c:set var="actEvn" value="${ForwardConst.ACT_EVENT.getValue()}" />
<c:set var="commIdx" value="${ForwardConst.CMD_INDEX.getValue()}" />
<c:set var="commEdit" value="${ForwardConst.CMD_EDIT.getValue()}" />

<c:import url="/WEB-INF/views/layout/app.jsp">
    <c:param name="content">

        <h2>id : ${event.id} のイベント情報 詳細ページ</h2>

        <table>
            <tbody>
                <tr>
                    <th>タイトル</th>
                    <td><c:out value="${event.title}" /></td>
                </tr>
                <tr>
                    <th>詳細</th>
                    <td><c:out value="${event.description}" /></td>
                </tr>
                <tr>
                    <th>作成者</th>
                    <td><c:out value="${event.organizer.username}" /></td>
                </tr>
                <tr>
                    <th>登録日時</th>
                    <td><fmt:formatDate value="${event.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                </tr>
            </tbody>
        </table>

        <p>
            <a href="<c:url value='?action=${actEvn}&command=${commEdit}&id=${event.id}' />">このイベント情報を編集する</a>
        </p>

        <p>
            <a href="<c:url value='?action=${actEvn}&command=${commIdx}' />">一覧に戻る</a>
        </p>
    </c:param>
</c:import>