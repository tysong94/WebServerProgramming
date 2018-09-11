<!-- 날짜 : 6월 26일 -->
<!-- 작성 : 송태양 -->
<!-- 제목 : 조회 -->
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.*, java.util.*, java.sql.*, javax.sql.*, java.net.*" %>
<meta charset="UTF-8"/>

<head>   
    <%        
        // DBMS 사용 변수
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/db_k08", "root", "1");
        Statement stmt = conn.createStatement();
        ResultSet rs = null;
        String sql = null;
        
        // 파라미터 변수
        String temp = null;
        String name = null;
        int studentid = 0;
        int kor = 0;
        int eng = 0;
        int mat = 0;
    %>
</head>
<body>
    <%-- update하기 --%>
    <%
        // 파라미터 값 받아오기
        //name = request.getParameter("name");
        temp = request.getParameter("name");
        name = new String(temp.getBytes("8859_1"), "utf-8"); // 한글 파라미터 변환
        studentid = Integer.parseInt(request.getParameter("studentid"));
        kor = Integer.parseInt(request.getParameter("kor"));
        eng = Integer.parseInt(request.getParameter("eng"));
        mat = Integer.parseInt(request.getParameter("mat"));
        
        // update sql 작성, 실행
        sql = "update twice_k08 set " 
            + "name = '" + name + "', "
            + "kor = " + kor + ", "
            + "eng = " + eng + ", "
            + "mat = " + mat
            + " where studentid = " + studentid + ";";
        
        stmt.executeUpdate(sql);  
    %>

    <%-- update후 전체 데이터 조회하기 --%>
    <h1>레코드 수정</h1>
    <table cellspacing=1 width=600 border=1> 
        <tr align=center>
            <td>이름</td><td>학번</td><td>국어</td><td>영어</td><td>수학</td><td>총점</td><td>평균</td><td>등수</td>
        </tr>
        <tr align=center>
            <%
            sql = "select name, studentid, kor, eng, mat, kor+eng+mat as sum, (kor+eng+mat)/3 as avg, (select count(*) + 1 "
                    + "from twice_k08 where kor+eng+mat > b.kor+b.eng+b.mat) as rank from twice_k08 as b;";
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                if(rs.getString(2).equals(request.getParameter("studentid"))){
                    out.println("<tr align=center bgcolor=#ffff00>");
                    out.println("<td><a href=05oneselect.jsp?key=" + rs.getString(1) + ">" + rs.getString(1) + "</a></td>");
                    out.println("<td>" + rs.getString(2) + "</td>");
                    out.println("<td>" + rs.getString(3) + "</td>");
                    out.println("<td>" + rs.getString(4) + "</td>");
                    out.println("<td>" + rs.getString(5) + "</td>");
                    out.println("<td>" + rs.getString(6) + "</td>");
                    out.println("<td>" + rs.getString(7) + "</td>");
                    out.println("<td>" + rs.getString(8) + "</td>");
                    out.println("</tr>");
                } else{
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
            }
            rs.close();
            stmt.close();
            conn.close();
            %>
        </tr>
    </table>
</body>
