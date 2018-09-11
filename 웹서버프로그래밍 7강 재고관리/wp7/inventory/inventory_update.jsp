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

    // 파라미터 변수
    String p_id = null;
    int p_count = 0;
    String p_irdate = null;
    %>
</head>
<body>
    <%
    // 파라미터 받아오기
    p_id = request.getParameter("id");
    p_count = Integer.parseInt(request.getParameter("count"));
    p_irdate = request.getParameter("irdate");
    
    // 데이터 update하기
    sql = "update inventory set count='"+p_count+"', irdate = '"+p_irdate+"' where id='"+p_id+"';";
    stmt.execute(sql);
    %>

    <%-- 제목 --%>
    <table border=1 width=600>
        <tr align=center>
            <td><h1>(주)트와이스 재고 현황 - 재고 수정</h1></td>
        </tr>
    </table>

    <%-- 내용 --%>
    <table border=1 width=600>
        <tr align=center>
            <td>
                재고가 수정되었습니다.
                <input type=button value='목록' onclick="location.href='inventory_list.jsp'">
            </td>
        </tr>
    </table>    

    <%
    // CLOSE
    stmt.close();
    conn.close();
    %>
</body>
</html>