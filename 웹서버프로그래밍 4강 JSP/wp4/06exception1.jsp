<!-- 날짜 : 6월 5일 -->
<!-- 작성자 : 송태양 -->
<!-- 제목 : JSP 예외 처리 -->
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
</head>
<body>
    <%
    String arr[] = new String[]{ "111", "222", "333" };
    // try : 해당 문장을 실행
    // catch : try 문장이 에러가 날 경우 실행할 문장
    try {
        out.println(arr[4] + "<br>");
    } catch(Exception e) {
        // Exception e : 에러 내용을 나타내는 객체
        out.println("error => " + e + "<br>");
    }
    %>
    Good...
</body>
</html>