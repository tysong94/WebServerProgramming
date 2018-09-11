<!-- 날짜 : 6월 5일 -->
<!-- 작성자 : 송태양 -->
<!-- 제목 : JSP 문자함수1 -->
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <%! 
        String str = "koposw08송태양";
        int str_len = str.length();         // 문자열 길이
        String str_sub = str.substring(5);  // 해당 인덱스부터 문자열 추출
        int str_ind = str.indexOf("송태");  // 해당 문자열 시작 인덱스
        String str_toL = str.toLowerCase(); // 문자열 소문자로
        String str_toU = str.toUpperCase(); // 문자열 대문자로
    %>
</head>
<body>
    str : <%= str %><br>
    str_len : <%= str_len %><br>
    str_sub : <%= str_sub %><br>
    str_ind : <%= str_ind %><br>
    str_toL : <%= str_toL %><br>
    str_toU : <%= str_toU %><br>
    Good...
</body>
</html>
