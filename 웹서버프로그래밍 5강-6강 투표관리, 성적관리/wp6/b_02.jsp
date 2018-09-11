<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.*, java.util.*, java.sql.*, javax.sql.*, java.net.*" %>

<html>
<head>
    <h1>투표결과</h1>
    <%        
        // DBMS 사용 변수
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/db_k08", "root", "1");
        Statement stmt = conn.createStatement();
        ResultSet rs = null;
        String sql = null;
        
        // 후보, 연령대 파라미터 변수
        int p_id = 0;
        int p_age = 0;

        // 후보, 연령대 변수
        int id = 0;
        int age = 0;
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
</body>
    <%
        //후보, 연령대 파라미터 받아오기
        p_id = Integer.parseInt(request.getParameter("id"));
        p_age = Integer.parseInt(request.getParameter("age"));

        // 인서트 후 셀렉트로 확인
        sql = "insert into tupyo(id, age) values("+p_id+", "+p_age+")";
        stmt.execute(sql);

        sql = "select * from tupyo where id = "+p_id+" and age = "+p_age+";";
        rs = stmt.executeQuery(sql);
        
        if(rs.next()){ 
            id = rs.getInt(1);
            age = rs.getInt(2);
            out.println(""+id+"번 "+age+"대 투표하였습니다.");
        }else{
           out.println("실패하였습니다.");
        }

        rs.close();
        stmt.close();
        conn.close();
    %>
</html>