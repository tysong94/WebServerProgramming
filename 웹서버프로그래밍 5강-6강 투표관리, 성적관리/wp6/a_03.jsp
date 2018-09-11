<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.*, java.util.*, java.sql.*, javax.sql.*, java.net.*" %>

<html>
<head>
    <h1>후보추가</h1>
    <%        
        // DBMS 사용 변수
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/db_k08", "root", "1");
        Statement stmt = conn.createStatement();
        ResultSet rs = null;
        String sql = null;
        
        // 기호, 이름 파라미터 변수
        int pid = 0; 
        String pname = null;
        String temp = null;
    %>
</head>
</head>
<body>
    <table cellspacing=0 width=500 border=1> 
            <tr align=center>
                <td bgcolor = #ffff00 width=50 style="word-break:break-all"><a href="a_01.jsp">후보등록</td>
                <td width=50 style="word-break:break-all"><a href="b_01.jsp">투표</a></td>
                <td width=50 style="word-break:break-all"><a href="c_01.jsp">개표결과</td>
            </tr>
    </table>

    <%-- 하단 내용 --%>
    <%
        //기호 받아오기
        pid = Integer.parseInt(request.getParameter("id")); 
        temp = request.getParameter("name");
        pname = new String(temp.getBytes("8859_1"), "utf-8");

        // 인서트 후 셀렉트로 확인
        sql = "insert into hubo(id, name) values(" +  pid + ", '" + pname + "');";
        stmt.execute(sql);
        sql = "select * from hubo where id = " + pid;
        rs = stmt.executeQuery(sql);

        if(rs.next() == true) {
            out.println("" + pid + "번 후보 추가가 성공하였습니다.");
        } else{
            out.println("" + pid + "번 후보 추가가 실패하였습니다.");
        }
        
        rs.close();
        stmt.close();
        conn.close();
    %>
</body>
</html>