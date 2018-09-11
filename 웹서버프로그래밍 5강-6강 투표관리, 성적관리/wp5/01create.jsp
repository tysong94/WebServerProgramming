<!-- 날짜 : 7월 19일 -->
<!-- 작성 : 송태양 -->
<!-- 제목 : 테이블 만들기 -->
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.*, java.util.*, java.sql.*, javax.sql.*" %>
<meta charset="UTF-8"/>

<head>
    <h1>테이블 만들기 OK</h1>
    <%
        // DBMS 사용 객체
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/db_k08", "root", "1");
        Statement stmt = conn.createStatement();

        // 테이블 생성 sql 실행
        stmt.execute("create table twice_k08(" +
            "name varchar(20), " +
            "studentid int not null primary key, " +
            "kor int, " +
            "eng int, " +
            "mat int) " +
            "default charset=utf8;");
    %>
</head>
<body>
</body>
</html>