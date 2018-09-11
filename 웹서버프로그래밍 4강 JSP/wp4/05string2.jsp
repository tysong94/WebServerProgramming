<!-- 날짜 : 6월 5일 -->
<!-- 작성자 : 송태양 -->
<!-- 제목 : JSP 문자함수2 -->
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <%! 
    // 배열 만들기
    String arr[] = new String[]{ "k08", "송태양", "koposw" };
    String str = "abc, efg, hij";
    // string ,구분자로 split -> 배열에 넣기.
    String str_arr[] = str.split(",");
    %>
</head>
<body>
    arr[0] : <%= arr[0] %><br>    
    arr[1] : <%= arr[1] %><br>    
    arr[2] : <%= arr[2] %><br>    
    str_arr[0] : <%= str_arr[0] %><br>    
    str_arr[1] : <%= str_arr[1] %><br>    
    str_arr[2] : <%= str_arr[2] %><br>    
    Good...
</body>
</html>
