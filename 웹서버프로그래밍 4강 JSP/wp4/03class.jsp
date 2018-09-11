<!-- 날짜 : 6월 7일 -->
<!-- 작성자 : 송태양 -->
<!-- 제목 : JSP Class -->
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <%! 
    // 클래스 정의하기 : Java와 같이 정의함.
    private class AA {
        private int Sum(int i, int j) {
            return i + j;
        }
    }
    %>
</head>
<body>
    <% 
    // 객체 생성, 인스턴스화
    AA aa = new AA(); 
    // 출력 : Java와 달리 System.이 없음.
    // 객체의 메소드 사용 : Java와 동일.
    out.println("2 + 3 = " + aa.Sum(2, 3)); 
    %><br> 
</body>
</html>
