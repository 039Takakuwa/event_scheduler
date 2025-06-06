<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="constants.ForwardConst" %>
<%@ page import="constants.AttributeConst" %>

<c:import url="/WEB-INF/views/layout/app.jsp">
  <c:param name="content">
  
    <h2>出欠確認フォーム</h2>

    <p>候補日: <c:out value="${candidate.date}" />（<c:out value="${candidate.startTime}" /> ～ <c:out value="${candidate.endTime}" />）</p>

    <form method="POST" action="<c:url value='?action=${ForwardConst.ACT_ATTENDANCE.getValue()}&command=${ForwardConst.CMD_CREATE.getValue()}' />">
      <input type="hidden" name="${AttributeConst.TOKEN.getValue()}" value="${_token}" />
      <input type="hidden" name="${AttributeConst.CANDIDATE_ID.getValue()}" value="${candidate.id}" />

      <p>出欠の選択：</p>
      <label><input type="radio" name="${AttributeConst.ATTENDANCE_STATUS.getValue()}" value="0" /> 出席</label><br />
      <label><input type="radio" name="${AttributeConst.ATTENDANCE_STATUS.getValue()}" value="1" /> 欠席</label><br />
      <label><input type="radio" name="${AttributeConst.ATTENDANCE_STATUS.getValue()}" value="2" /> 未定</label><br />

      <p><button type="submit">回答する</button></p>
    </form>

    <p><a href="<c:url value='?action=${ForwardConst.ACT_EVENT.getValue()}&command=${ForwardConst.CMD_SHOW.getValue()}&id=${candidate.event.id}' />">イベント詳細へ戻る</a></p>

  </c:param>
</c:import>
