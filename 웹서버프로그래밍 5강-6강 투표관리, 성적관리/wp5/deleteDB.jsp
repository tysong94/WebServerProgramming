<!-- 날짜 : 7월 19일 -->
<!-- 작성 : 송태양 -->
<!-- 제목 : 데이터 삭제 -->
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.*, java.util.*, java.sql.*, javax.sql.*, java.net.*" %>
<meta charset="UTF-8"/>

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
        int studentid = 0;
    %>
</head>
<body>
    <%-- delete 하기 --%>
    <%
        // 데이터 삭제하기
        studentid = Integer.parseInt(request.getParameter("studentid"));
        sql = "delete from twice_k08 where studentid = " + studentid + ";";
        stmt.execute(sql);
    %>

    <%-- delete 후 전체 데이터 조회하기 --%>
    <h1>레코드 삭제</h1>
    <table cellspacing=1 width=600 border=1> 
        <tr align=center>
            <td>이름</td><td>학번</td><td>국어</td><td>영어</td><td>수학</td><td>총점</td><td>평균</td><td>등수</td>
        </tr>
        <tr align=center>
            <%
            sql = "select name, studentid, kor, eng, mat, kor+eng+mat as sum, (kor+eng+mat)/3 as avg, (select count(*) + 1 from twice_k08 where kor+eng+mat > b.kor+b.eng+b.mat) as rank from twice_k08 as b;";
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                out.println("<tr align=center>");
                out.println("<td><a href=05oneselect.jsp?key=" + rs.getString(1) + ">" + rs.getString(1) + "</a></td>");
                out.println("<td>" + rs.getString(2) + "</td>");
                out.println("<td>" + rs.getString(3) + "</td>");
                out.println("<td>" + rs.getString(4) + "</td>");
                out.println("<td>" + rs.getString(5) + "</td>");
                out.println("<td>" + rs.getString(6) + "</td>");
                out.println("<td>" + rs.getString(7) + "</td>");
                out.println("<td>" + rs.getString(8) + "</td>");
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