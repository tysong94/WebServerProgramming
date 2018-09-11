<!-- 날짜 : 6월 7일 -->
<!-- 작성자 : 송태양 -->
<!-- 제목 : Java Script VS JSP -->
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <%-- <%! %> : 변수나 함수를 선언할 때. --%>
    <%! 
        // JSP 함수 : Java와 같이 제어자, 반환타입을 지정함.
        // JSP 변수 : Java와 같이 데이터타입을 지정함.
        private String call1() {
            String a = "k08";
            String b = "송태양";
            return (a + b);
        }

        private Integer call2() {
            Integer a = 1;
            Integer b = 2;
            return (a + b);
        }
    %>
</head>
<body>
    난 JSP<br>
    String 연산 : <%= call1() %><br>
    Integer 연산 : <%= call2() %><br>
    Good...
</body>
</html>
