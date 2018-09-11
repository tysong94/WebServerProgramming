<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.*, java.util.*, java.sql.*, javax.sql.*, java.net.*" %>

<html>
<head>
    <h1>후보삭제</h1>
    <%        
        // DBMS 사용 변수
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/db_k08", "root", "1");
        Statement stmt = conn.createStatement();
        ResultSet rs = null;
        String sql = null;
        
        // 기호 받아오기
        int pid = 0; 
    %>
</head>
<body>
    <%-- 상단바 --%>
    <table cellspacing=0 width=500 border=1> 
            <tr align=center>
                <td bgcolor = #ffff00 width=50 style="word-break:break-all"><a href="a_01.jsp">후보등록</td>
                <td width=50 style="word-break:break-all"><a href="b_01.jsp">투표</a></td>
                <td width=50 style="word-break:break-all"><a href="c_01.jsp">개표결과</td>
            </tr>
    </table>

    <%-- 하단 내용 --%>
    <%
        pid = Integer.parseInt(request.getParameter("id")); 

        sql = "delete from hubo where id = " + pid;
        stmt.execute(sql);
        sql = "delete from tupyo where id =" + pid;
        stmt.execute(sql);

        sql = "select * from hubo where id = " + pid;
        rs = stmt.executeQuery(sql);

        if(rs.next() == true) {
            out.println("" + pid + "번 후보 삭제가 실패하였습니다.");
        } else{
            out.println("" + pid + "번 후보가 삭제되었습니다.");
        }
        rs.close();
        stmt.close();
        conn.close();
    %>
</body>
</html>