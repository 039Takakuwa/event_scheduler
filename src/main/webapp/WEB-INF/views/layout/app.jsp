<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title><c:out value="イベント出席管理システム" /></title>
<link rel="stylesheet" href="<c:url value='/css/reset.css' />">
<link rel="stylesheet" href="<c:url value='/css/style.css' />">
<script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-100 text-gray-900">
    <header class="bg-gray-800 text-white p-4">
        <div class="container mx-auto flex justify-between">
            <h1 class="text-xl font-bold">イベント出席管理システム</h1>
        </div>
    </header>

    <main class="container mx-auto py-6 px-4">${param.content}</main>

    <footer class="text-center text-sm text-gray-500 py-6"> by Aoi
        Takakuwa. </footer>
</body>
</html>