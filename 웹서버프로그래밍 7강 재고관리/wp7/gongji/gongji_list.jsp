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

    // 번호, 제목, 등록일 변수
    int id = 0;
    String title = null;
    String date = null;
    %>
</head>
<body>
    <!-- 게시판 목록 -->
    <table border=1 width=700>
        <!-- 필드명 라인 -->
        <tr align=center>
            <td width=50>번호</td><td width=500>제목</td><td width=150>등록일</td>
        </tr>

        <!-- 항목들 -->
        <%
        sql = "select * from gongji order by id desc;";
        rs = stmt.executeQuery(sql);

        while(rs.next()) {
            id = rs.getInt(1);
            title = rs.getString(2);
            date = rs.getString(3);

            out.println("<tr align=center>");
            out.println("<td width=50>"+id+"</td>");
            out.println("<td width=500 align=left><a href=gongji_view.jsp?key="+id+">"+title+"</a></td>");
            out.println("<td width=150>"+date+"</td>");
            out.println("</tr>");
        }
        %>
    </table>
    
    <!-- 신규 버튼 -->
    <table border=0 width=700>
        <tr align=right>
            <td colspan=3><input type="button" value="신규" onclick="window.location='gongji_new.jsp'"></td>
        </tr>
    </table>
</body>
</html>
