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
    // DROP TABLE
    try {
        stmt.execute("drop table gongji");
        out.println("drop table gongji SUCCESS<br>");
    }catch(Exception e) {
        out.println("drop table gongji FAIL<br>");
        out.println(e.toString());
    }
    // CREATE TABLE
    try {
        stmt.execute("create table gongji(\r\n"
        +"id		int not null primary key auto_increment,\r\n"
        +"title	varchar(70),\r\n"
        +"date	date,\r\n"
        +"content text)\r\n"
        +"default charset=utf8\r\n"
        +";");
        out.println("create table gongji SUCCESS<br>");
    }catch(Exception e) {
        out.println("create table gongji FAIL<br>");
        out.println(e.toString());
    }
    // INSERT
    try {
        sql = "insert into gongji(title, date, content) values('공지사항1', date(now()), '공지사항내용1');"; stmt.execute(sql);
        sql = "insert into gongji(title, date, content) values('공지사항2', date(now()), '공지사항내용2');"; stmt.execute(sql);
        sql = "insert into gongji(title, date, content) values('공지사항3', date(now()), '공지사항내용3');"; stmt.execute(sql);
        sql = "insert into gongji(title, date, content) values('공지사항4', date(now()), '공지사항내용4');"; stmt.execute(sql);
        sql = "insert into gongji(title, date, content) values('공지사항5', date(now()), '공지사항내용5');"; stmt.execute(sql);
        out.println("insert data SUCCESS<br>");
    }catch(Exception e) {
        out.println("insert data FAIL<br>");
        out.println(e.toString());
    }    
    // CLOSE
    stmt.close();
    conn.close();
    %>
</body>
</html>
    
