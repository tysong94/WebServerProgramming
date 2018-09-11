<!-- 날짜 : 6월 5일 -->
<!-- 작성자 : 송태양 -->
<!-- 제목 : JSP 예외 처리2 -->
<%@ page contentType="text/html; charset=UTF-8" %>
<%-- 에러가 날 때 열 페이지 --%>
<%@ page errorPage="07error.jsp" %> 
<html>
<head>
    <%! 
    String[] arr = new String[]{"111", "222", "333"}; 
    %>
</head>
<body>
    <%
        out.println(arr[3] + "<br>");
    %>
</body>
</html>