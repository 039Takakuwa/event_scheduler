<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- セッションスコープからflush/flushTypeを取得し、必要なら削除してリクエストスコープに移す -->
<c:if test="${not empty sessionScope.flush}">
    <c:set var="flush" value="${sessionScope.flush}" scope="request" />
    <c:set var="flushType" value="${sessionScope.flushType}" scope="request" />
    <c:remove var="flush" scope="session" />
    <c:remove var="flushType" scope="session" />
</c:if>

<c:set var="actUsr" value="${ForwardConst.ACT_USR.getValue()}" />
<c:set var="commNew" value="${ForwardConst.CMD_NEW.getValue()}" />

<c:import url="../layout/app.jsp">
    <c:param name="content">

        <!-- フラッシュメッセージ表示 -->
        <c:if test="${not empty flush}">
            <div id="flash-message"
                class="fixed top-5 left-1/2 transform -translate-x-1/2 z-50
        px-6 py-3 rounded shadow-md transition-opacity duration-1500 ease-out
        ${flushType == 'success' ? 'bg-green-500 text-white' : 'bg-red-500 text-white'}">
                <c:out value="${flush}" />
            </div>
        </c:if>

        <!-- ログインフォーム -->
        <div class="max-w-md mx-auto mt-16 bg-white p-8 rounded-lg shadow">
            <h2 class="text-2xl font-bold text-center text-gray-800 mb-6">ログイン</h2>

            <c:if test="${not empty error}">
                <p class="text-red-600 font-semibold text-center mb-4">
                    <c:out value="${error}" />
                </p>
            </c:if>

            <form action="?action=Log&command=login" method="post" class="space-y-4">
                <div>
                    <label class="block text-gray-700 font-medium mb-1">ユーザー名</label>
                    <input type="text" name="username"
                        class="w-full border border-gray-300 px-4 py-2 rounded focus:outline-none focus:ring-2 focus:ring-blue-400" />
                </div>

                <div>
                    <label class="block text-gray-700 font-medium mb-1">パスワード</label>
                    <input type="password" name="password"
                        class="w-full border border-gray-300 px-4 py-2 rounded focus:outline-none focus:ring-2 focus:ring-blue-400" />
                </div>

                <div class="text-center">
                    <input type="submit" value="ログイン"
                        class="bg-blue-500 hover:bg-blue-600 text-white font-semibold py-2 px-6 rounded transition" />
                </div>
            </form>

            <div class="mt-6 text-center">
                <a href="?action=User&command=entryNew" class="text-sm text-blue-500 hover:underline">
                    アカウントをお持ちでない方はこちら
                </a>
            </div>
        </div>

        <!-- フラッシュメッセージの自動フェードアウト -->
        <script>
            window.addEventListener('DOMContentLoaded', () => {
                const flash = document.getElementById('flash-message');
                if (!flash) return;

                setTimeout(() => {
                    flash.classList.add('opacity-0');
                    setTimeout(() => {
                        flash.remove();
                    }, 1000);
                }, 3000);
            });
        </script>

    </c:param>
</c:import>
