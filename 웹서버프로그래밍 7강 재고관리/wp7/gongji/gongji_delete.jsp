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
    int id = 0;
    %>
</head>
<body>
    <%
    // 파라미터 받아오기
    id = Integer.parseInt(request.getParameter("key"));
    
    // 데이터 delete하기
    sql = "delete from gongji where id="+id;
    stmt.execute(sql);
    %>

    해당 글이 삭제되었습니다.
    <input type=button value='목록' onclick="location.href='gongji_list.jsp'">
</body>
</html>
