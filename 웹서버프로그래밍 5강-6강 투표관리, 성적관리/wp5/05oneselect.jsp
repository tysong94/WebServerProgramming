<!-- 날짜 : 7월 19일, 송태양, 제목 : 데이터 하나 조회 -->
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.*, java.util.*, java.sql.*, javax.sql.*" %>
<meta charset="UTF-8"/>

<head>
    <%-- DBMS 사용 객체 --%>
    <%
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/db_k08", "root", "1");
        Statement stmt = conn.createStatement();
        String ckey = request.getParameter("key");
        ResultSet rs = stmt.executeQuery("select * from twice_k08 where name = \"" + ckey + "\";");
    %>
</head>
<body>
    <%-- 각 데이터 조회 --%>
    <h1>[<%= ckey %>]조회</h1>
    <table cellspacing=1 width=600 border=1> 
        <tr align=center>
            <td>이름</td><td>학번</td><td>국어</td><td>영어</td><td>수학</td>
        </tr>
        <tr align=center>
            <%
            while (rs.next()) {
                out.println("<tr align=center>");
                out.println("<td>" + rs.getString(1) + "</td>");
                out.println("<td>" + rs.getString(2) + "</td>");
                out.println("<td>" + rs.getString(3) + "</td>");
                out.println("<td>" + rs.getString(4) + "</td>");
                out.println("<td>" + rs.getString(5) + "</td>");
                out.println("</tr>");
            }
            rs.close();
            stmt.close();
            conn.close();
            %>
        </tr>
    </table>
</body>
</html>