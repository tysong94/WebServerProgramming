<%-- html, jsp 한글 처리 --%>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.*, java.util.*, java.sql.*, javax.sql.*, java.net.*" %>

<html>
<head>
    <%
    // DBMS 사용 변수
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/db_k08", "root", "1");
    Statement stmt = conn.createStatement();
    ResultSet rs = null;
    String sql = null;
    %>
</head>
<body>
    <h1>테이블, 데이터 생성</h1>
    <%
    // 테이블 삭제
    try {
        stmt.execute("drop table inventory");
        out.println("테이블 삭제 성공<br>");
    }catch(Exception e) {
        out.println("테이블 삭제 실패<br>");
        out.println(e.toString());
    }
    
    // 테이블 생성
    try {
        stmt.execute("create table inventory(\r\n"
        +"id            varchar(70) not null primary key,\r\n"
        +"name	        varchar(70),\r\n"
        +"count	        int,\r\n"
        +"prdate        datetime,\r\n"
        +"irdate        datetime,\r\n"
        +"details       text,\r\n"
        +"photos_addr   varchar(500),\r\n"
        +"photos_name   varchar(500)\r\n"
        +")default charset=utf8;\r\n"
        );
        out.println("테이블 생성 성공<br>");
    }catch(Exception e) {
        out.println("테이블 생성 실패<br>");
        out.println(e.toString());
    }
    
    // INSERT
    try {
        for(int i=1; i<=150; i++) {
            sql = "INSERT INTO inventory(id, name, count, prdate, irdate)\r\n"
                +" VALUES("+i+", '바나나', 100000000, date_add(sysdate(), interval - 24 month), date_add(sysdate(), interval - "+i+" hour));"; 
            stmt.execute(sql);    
        }
        out.println("INSERT 성공<br>");
    }catch(Exception e) {
        out.println("INSERT 실패<br>");
        out.println(e.toString());
    }    
    
    // CLOSE
    stmt.close();
    conn.close();
    %>
</body>
</html>
    
