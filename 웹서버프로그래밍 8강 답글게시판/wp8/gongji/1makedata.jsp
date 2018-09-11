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
        +"title	    varchar(70),\r\n"
        +"date	    datetime,\r\n"
        +"content   text,\r\n"
        +"rootid    int,\r\n"   //원글id
        +"relevel   int,\r\n"   //댓글레벨
        +"recnt     int,\r\n"   //댓
        +"viewcnt   int,\r\n"   //조회수
        +"filename  varchar(300),\r\n"
        +"filepath  varchar(300)\r\n"    
        +")default charset=utf8\r\n"
        +";");
        out.println("create table gongji SUCCESS<br>");
    }catch(Exception e) {
        out.println("create table gongji FAIL<br>");
        out.println(e.toString());
    }
    // INSERT
    try {
        // 원글
        for(int i=1; i<=10; i++) {
            sql = "insert into gongji(title, date, content, rootid, relevel, recnt, viewcnt)\r\n" 
                    +"values('공지사항"+i+"', date_add(20180101, INTERVAL "+i+" DAY), '공지사항내용"+i+"', last_insert_id()+1, 0, 0, 0);"; 
            stmt.execute(sql);
        }
        // 댓글
        for(int i=1; i<=3; i++) {
        sql = "insert into gongji(title, date, content, rootid, relevel, recnt, viewcnt)\r\n" 
                +"values('댓글', now(), '공지사항내용"+i+"', 10, "+i+", "+i+", 0);"; 
        stmt.execute(sql);
        }
        
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
    
