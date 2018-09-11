<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.*, java.util.*, java.sql.*, javax.sql.*, java.net.*" %>

<html>
<head>
    <h1>투표</h1>
    <%        
        // DBMS 사용 변수
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/db_k08", "root", "1");
        Statement stmt = conn.createStatement();
        ResultSet rs = null;
        String sql = null;
        
        // 기호, 후보명 변수
        int id = 0;
        String name = null;
    %>
</head>
<body>
    <table cellspacing=0 width=500 border=1> 
            <tr align=center>
                <td width=50 style="word-break:break-all"><a href="a_01.jsp">후보등록</td>
                <td bgcolor = #ffff00 width=50 style="word-break:break-all"><a href="b_01.jsp">투표</a></td>
                <td width=50 style="word-break:break-all"><a href="c_01.jsp">개표결과</td>
            </tr>
    </table>

    <form method=post action=b_02.jsp>
    <table cellspacing=0 width=500 border=1>
        <tr align=center>
            <td>
            <select name=id required>
                <%
                    sql = "select * from hubo order by id asc;";
                    rs = stmt.executeQuery(sql);
                    while(rs.next()) {
                        out.println("<option value="+rs.getInt(1)+">"+rs.getString(1)+"번 "+rs.getString(2)+"</option>");
                    }
                    rs.close();
                    stmt.close();
                    conn.close();
                %>
            </select>
            </td>
            <td>
            <select name=age>
                <option value=10>10대</option>
                <option value=20>20대</option>
                <option value=30>30대</option>
                <option value=40>40대</option>
                <option value=50>50대</option>
                <option value=60>60대</option>
                <option value=70>70대</option>
                <option value=80>80대</option>
                <option value=90>90대</option>
            </select>
            </td>
            <td>
                <input type=submit value="투표하기">
            </td>
        </tr>
    </table>
    </form>
</body>
</html>