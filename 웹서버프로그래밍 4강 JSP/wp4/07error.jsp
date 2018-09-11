<!-- 날짜 : 6월 5일 -->
<!-- 작성자 : 송태양 -->
<!-- 제목 : JSP 예외 처리2 -->
<%@ page contentType="text/html; charset=UTF-8" %>
<%-- 에러가 날 때 나타나는 페이지임 --%>
<%@ page isErrorPage="true" %>
<html>
<head>
</head>
<body>
    에러입니다. <br>
    이 파일명은 07error.jsp <br>
    <%= exception %><br>            <%-- 오류가 난 원인 출력 --%> 
    <%= exception.getClass() %><br> <%-- 오류를 잡은 클래스 출력  --%>
    <%= exception.getMessage() %>   <%-- 오류 메세지 번호 출력 --%>
</body>
</html>