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
    String p_id = null;
    
    // 번호, 제목, 조회수, 일자, 내용, 원글, 댓글수준
    String id = null;
    String title = null;
    String viewcnt = null;
    String date = null;
    String content = null;
    String rootid = null;
    String relevel = null;
    String recnt = null;
    String filename = null;
    String filepath = null;
    %>
</head>
<body>
    <%-- 데이터 받아오기 --%>
    <%
    //키 받아오기
    p_id = request.getParameter("id");

    //키로 view 올리기
    sql = "update gongji set viewcnt = viewcnt + 1 where id = "+p_id+";";
    stmt.execute(sql);

    //키로 데이터 받아오기
    sql = "select id, title, viewcnt, date_format(date, '%Y-%m-%d %H:%i') as date, content, rootid, recnt, relevel, filename, filepath from gongji where id = "+p_id+";";
    rs = stmt.executeQuery(sql);
    
    while(rs.next()) {
        id = rs.getString("id");
        title = rs.getString("title");
        viewcnt = rs.getString("viewcnt");
        date = rs.getString("date");
        content = rs.getString("content");
        rootid = rs.getString("rootid");
        recnt = rs.getString("recnt");
        relevel = rs.getString("relevel");
        filename = rs.getString("filename");
        filepath = rs.getString("filepath");
    }
    %>

    <!-- 내용 -->
    <form name='f' method='post' action='gongji_1_edit.jsp'>
    <table border=1 width=700>
        <tr>
            <td width=100 align=center>번호</td>
            <td width=600><input name='id' type=number style='width:600;' value='<%=id%>' readonly></td>
        </tr>
        <tr>
            <td width=100 align=center>제목</td>
            <td width=600><input name='title' type=text style='width:600;' value='<%= title %>' readonly></td>
        </tr>
        <tr>
            <td width=100 align=center>조회수</td>
            <td width=600><input name='viewcnt' type=text style='width:600;' value='<%= viewcnt %>' readonly></td>
        </tr>
        <tr>
            <td width=100 align=center>일자</td>
            <td width=600><input name='date' type=text style='width:600;' value='<%= date %>' readonly></td>
        </tr>
        <tr>
            <td width=100 align=center>내용</td>
            <td width=600>
                <input name='content' type='hidden' value='<%=content%>'>
                <div style='width:600; height:250' row=600><%=content%></div>
            </td>
        </tr>
        <tr>
            <td width=100 align=center>첨부파일</td>
            <%
            if(filename == null) {
                %><td width=600>첨부파일 없음</td><%
            } else {
                %><input name='filename' type='hidden' value='<%=filename%>' readonly><%
                %><td width=600><a href='http://192.168.23.106:8080/upload/<%=filename%>'><%=filename%></a></td><%
            }
            %>
        </tr>
        <tr>
            <td width=100 align=center>원글</td>
            <td width=600><input name='rootid' type=text style='width:600;' value='<%= rootid %>' readonly></td>
        </tr>
        <tr>
            <td width=100 align=center>댓글수준</td>
            <td width=600><input name='relevel' type=text style='width:600;' value='<%= relevel %>' readonly></td>
        </tr>
        <tr>
            <td width=100 align=center>댓글순서</td>
            <td width=600><input name='recnt' type=text style='width:600;' value='<%= recnt %>' readonly></td>
        </tr>  
    </table>

    <!-- 버튼 -->
    <table border=0 width=700>
        <tr align=right>
            <td colspan=2>
                <input type='button' value='목록' onclick="window.location='gongji_list.jsp'">
                <input type='submit' value='수정'>
                <input type='button' value='삭제' onclick="location.href='gongji_2_delete.jsp?id=<%=id%>&rootid=<%=rootid%>&recnt=<%=recnt%>&relevel=<%=relevel%>'">
                <input type='button' value='댓글' onclick="location.href='gongji_re.jsp?rootid=<%=rootid%>&recnt=<%=recnt%>&relevel=<%=relevel%>'">
            </td>
        </tr>        
    </table>
    </form>

        <%
    // CLOSE
    stmt.close();
    conn.close();
    %>
</body>
</html>