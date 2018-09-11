<!-- 날짜 : 6월 5일 -->
<!-- 작성 : 송태양 -->
<!-- 제목 : 8. 인자를 받아 처리 -->
<%@ page contentType="text/html; charset=UTF-8" %>
<meta charset="UTF-8"/>
<%
// 한글을 읽게 해줌. 
request.setCharacterEncoding("utf-8");
// request.getParameter(key) : 해당 key의 value를 가져옴. 
String name = request.getParameter("username");
String password = request.getParameter("userpasswd");
%>

<html>
<head>
    <title>로그인</title>
</head>
<body>
    이름 : <%= name %><br>
    비밀번호 : <%= password %><br>
</body>
</html>