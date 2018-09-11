<!-- 날짜 : 7월 19일 -->
<!-- 작성 : 송태양 -->
<!-- 제목 : 데이터 삽입 -->
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.*, java.util.*, java.sql.*, javax.sql.*" %>
<meta charset="UTF-8"/>

<head>
    <h1>실습데이터 입력</h1>
    <%
        // DBMS 사용 객체
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/db_k08", "root", "1");
        Statement stmt = conn.createStatement();
        
        // 데이터 인서트 sql 실행
        stmt.execute("insert into twice_k08 values(\"나연\", 209901, 95, 100, 95);");
        stmt.execute("insert into twice_k08 values(\"정연\", 209902, 100, 100, 100);");
        stmt.execute("insert into twice_k08 values(\"모모\", 209903, 100, 90, 100);");
        stmt.execute("insert into twice_k08 values(\"사나\", 209904, 100, 95, 90);");
        stmt.execute("insert into twice_k08 values(\"지효\", 209905, 80, 100, 70);");
        stmt.execute("insert into twice_k08 values(\"미나\", 209906, 95, 90, 95);");
        stmt.execute("insert into twice_k08 values(\"다현\", 209907, 100, 90, 100);");
        stmt.execute("insert into twice_k08 values(\"채영\", 209908, 100, 75, 90);");
        stmt.execute("insert into twice_k08 values(\"쯔위\", 209909, 100, 100, 70);");
    %>
</head>
<body>
</body>
</html>