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

    // 파라미터 변수
    String title = null;
    String content = null;
    %>
</head>
<body>
    <%
    // 파라미터 받아오기
    request.setCharacterEncoding("UTF-8");
    title = request.getParameter("title");
    title = title.replace("'", "''").replace("<", "&lt;").replace(">", "&gt;");

    content = request.getParameter("content");
    content = content.replace("'", "''").replace("<", "&lt;").replace(">", "&gt;");

    // 데이터 insert하기
    sql = "insert into gongji(title, date, content) values('"+title+"', date(now()), '"+content+"');";
    stmt.execute(sql);
    %>

    해당 글이 작성되었습니다.
    <input type=button value='목록' onclick="location.href='gongji_list.jsp'">
</body>
</html>
