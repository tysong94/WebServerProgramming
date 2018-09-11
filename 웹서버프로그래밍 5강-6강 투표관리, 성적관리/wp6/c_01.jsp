<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.*, java.util.*, java.sql.*, javax.sql.*, java.net.*" %>

<html>
<head>
    <h1>개표결과</h1>
    <%
        // DBMS 사용 변수
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/db_k08", "root", "1");
        Statement stmt = conn.createStatement();
        ResultSet rs = null;
        String sql = null;

        // 기호, 후보, 투표, 총 투표 변수
        int id = 0;
        String name = null;
        int count = 0;
        int per = 0;

    %>
</head>
<body>
    <table cellspacing=0 width=500 border=1> 
            <tr align=center>
                <td width=50 style="word-break:break-all"><a href="a_01.jsp">후보등록</td>
                <td width=50 style="word-break:break-all"><a href="b_01.jsp">투표</a></td>
                <td bgcolor = #ffff00 width=50 style="word-break:break-all"><a href="c_01.jsp">개표결과</td>
            </tr>
    </table>
    
    <%-- 개표결과 가져오기 --%>
    <table cellspacing=0 width=500 border=1>
        <%
            sql = "select h.id, h.name, count(t.age), round(count(t.age)/(select count(age) from tupyo)*100) as per\r\n"
                    +"from tupyo t right join hubo h\r\n"
                    +"on t.id = h.id\r\n"
                    +"group by h.id, h.name;\r\n"
                    ;
            rs = stmt.executeQuery(sql);
            while(rs.next()){
                count = rs.getInt(3);
                per = rs.getInt(4);
                out.println("<tr align=center>");
                    out.println("<td><a href=c_02.jsp?key1="+rs.getInt(1)+"&key2="+rs.getString(2)+">"+rs.getInt(1)+"번 "+rs.getString(2)+"</a></td>");
                    out.println("<td align=left><img src=bar.jpg align=left width="+300*(per/100.0)+" height=20>"+count+"("+per+"%)</td>");
                out.println("</tr>");
            }

            rs.close();
            stmt.close();
            conn.close();        
        %>
    </table>
</body>
</html>