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

    // 번호, 제목, 조회수, 등록일, 댓글레벨 변수
    int id = 0;
    String title = null;
    String viewcnt = null;
    String date = null;
    int relevel = 0;
    
    %>
</head>
<body>
    <%-- 게시판 --%>
    <table border=1 width=700>
        <!-- 필드명 -->
        <tr align=center>
            <td width=100>번호</td>
            <td width=300>제목</td>
            <td width=150>조회수</td>
            <td width=150>등록일</td>
        </tr>

        <!-- 내용 -->
        <%
        sql = "select id, title, viewcnt, date(date) as date, relevel from gongji order by rootid desc, recnt asc, relevel asc;";
        rs = stmt.executeQuery(sql);
        while(rs.next()) {
            id = rs.getInt("id");
            title = rs.getString("title");
            viewcnt = rs.getString("viewcnt");
            date = rs.getString("date");
            relevel = rs.getInt("relevel");
            
            // 댓글 제목 수정하기 : 댓글표시 달기
            if(relevel > 0) {
                String blank = "";
                for(int i=1; i<=relevel; i++) {
                    blank = blank + "==";
                }
                title = blank + ">[RE]" + title;
            }

            // 댓글 제목 수정하기 : 새글표시 달기
            String temp_sql = "select datediff(now(), date) from gongji where id = "+id+";";
            Statement temp_stmt = conn.createStatement();
            ResultSet temp_rs = temp_stmt.executeQuery(temp_sql);
            if(temp_rs.next() && temp_rs.getInt(1) < 1) { title = title + "<font color='red'>[새글]</font>"; }

            %>
            <tr align=center>
                <td width=100><%=id%></td>
                <td width=300 align=left><a href='gongji_1_view.jsp?id=<%=id%>'><%=title%></a></td>
                <td width=150><%=viewcnt%></td>
                <td width=150><%=date%></td>
            </tr>
            <%
        }
        %>
    </table>
    
    <!-- 신규 버튼 -->
    <table border=0 width=700>
        <tr align=right>
            <td colspan=3><input type="button" value="신규" onclick="window.location='gongji_new.jsp'"></td>
        </tr>
    </table>

    <%-- CLOSE --%>
    <%
    stmt.close();
    conn.close();
    %>
</body>
</html>
