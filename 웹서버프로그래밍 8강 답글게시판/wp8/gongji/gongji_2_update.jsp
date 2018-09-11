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
    String title = null;
    String content = null;
    %>
</head>
<body>
    <%
    // 파라미터 받아오기
    request.setCharacterEncoding("UTF-8");
    id = Integer.parseInt(request.getParameter("id"));
    title = request.getParameter("title");
    title = title.replace("'", "''").replace("<", "&lt").replace(">", "&gt");
    content = request.getParameter("content");
    
    // 데이터 update하기
    sql = "update gongji set title='"+title+"', date=now(), content='"+content+"' where id="+id+";";
    stmt.execute(sql);
    %>

    해당 글이 수정되었습니다.
    <input type=button value='목록' onclick="location.href='gongji_list.jsp'">
    
    <%
    // CLOSE
    stmt.close();
    conn.close();
    %>
</body>
</html>