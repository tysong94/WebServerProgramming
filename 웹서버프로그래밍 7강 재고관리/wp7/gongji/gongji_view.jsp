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

    // key 변수
    int key = 0;
    
    // 번호, 제목, 일자, 내용 변수
    int id = 0;
    String title = null;
    String date = null;
    String content = null;
    %>
</head>
<body>
    <%-- 데이터 받아오기 --%>
    <%
    //키 받아오기
    key = Integer.parseInt(request.getParameter("key"));

    //키로 데이터 받아오기
    sql = "select * from gongji where id = "+key;
    rs = stmt.executeQuery(sql);
    
    while(rs.next()) {
        id = rs.getInt(1);
        title = rs.getString(2);
        date = rs.getString(3);
        content = rs.getString(4);
    }
    %>

    <!-- 글 내용란 -->
    <form name='f' method='post'>
    <table border=1 width=700>
        <tr>
            <td width=50 align=center>번호</td>
            <td width=650><input type=number style='width:650;' value='<%=id%>' readonly></td>
        </tr>
        <tr>
            <td width=50 align=center>제목</td>
            <td width=650><input type=text style='width:650;' value='<%= title %>' readonly></td>
        </tr>
        <tr>
            <td width=50 align=center>일자</td>
            <td width=650><%= date %></td>
        </tr>
        <tr>
            <td width=50 align=center>내용</td>
            <td width=650><textarea name='content' style='width:650; height:250' row=600 readonly><%= content %></textarea></td>
        </tr>
    </table>

    <!-- 버튼란 -->
    <table border=0 width=700>
        <tr align=right>
            <td colspan=2>
                <input type='button' value='목록' onclick="window.location='gongji_list.jsp'">
                <input type='button' value='수정' onclick="location.href='gongji_edit.jsp?key=<%=id%>'">
                <input type='button' value='삭제' onclick="location.href='gongji_delete.jsp?key=<%=id%>'">
            </td>
        </tr>        
    </table>
    </form>
</body>
</html>