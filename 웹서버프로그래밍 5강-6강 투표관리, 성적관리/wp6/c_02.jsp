<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.*, java.util.*, java.sql.*, javax.sql.*, java.net.*" %>

<html>
<head>
    <h1>성향분석</h1>
    <%
        // DBMS 사용 변수
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/db_k08", "root", "1");
        Statement stmt = conn.createStatement();
        ResultSet rs = null;
        String sql = null;

        // 기호, 후보명 파라미터
        int pid = 0;
        String pname = null;
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

    <table cellspacing=0 width=500 border=1>
    <%   
        // 기호, 후보명 파라미터 받아오기
        pid = Integer.parseInt(request.getParameter("key1"));
        pname = request.getParameter("key2");

        // 데이터 조회, 가져오기
        sql = "select 10s, 20s, 30s, 40s, 50s, 60s, 70s, 80s, 90s, if(sum=0, 1, sum)\r\n"
            +"from\r\n" 
            +"   (select\r\n"
            +"        (select count(*) from tupyo where id = "+pid+" and age = 10) as 10s,\r\n" 
            +"        (select count(*) from tupyo where id = "+pid+" and age = 20) as 20s,\r\n"
            +"        (select count(*) from tupyo where id = "+pid+" and age = 30) as 30s,\r\n"
            +"        (select count(*) from tupyo where id = "+pid+" and age = 40) as 40s,\r\n"
            +"        (select count(*) from tupyo where id = "+pid+" and age = 50) as 50s,\r\n"
            +"        (select count(*) from tupyo where id = "+pid+" and age = 60) as 60s,\r\n"
            +"        (select count(*) from tupyo where id = "+pid+" and age = 70) as 70s,\r\n"
            +"        (select count(*) from tupyo where id = "+pid+" and age = 80) as 80s,\r\n"
            +"        (select count(*) from tupyo where id = "+pid+" and age = 90) as 90s,\r\n"
            +"        (select count(*) from tupyo where id = "+pid+" and age = 10)+\r\n"
            +"        (select count(*) from tupyo where id = "+pid+" and age = 20)+\r\n"
            +"        (select count(*) from tupyo where id = "+pid+" and age = 30)+\r\n"
            +"        (select count(*) from tupyo where id = "+pid+" and age = 40)+\r\n"
            +"        (select count(*) from tupyo where id = "+pid+" and age = 50)+\r\n"
            +"        (select count(*) from tupyo where id = "+pid+" and age = 60)+\r\n" 
            +"        (select count(*) from tupyo where id = "+pid+" and age = 70)+\r\n" 
            +"        (select count(*) from tupyo where id = "+pid+" and age = 80)+\r\n" 
            +"        (select count(*) from tupyo where id = "+pid+" and age = 90) as sum\r\n"
            +"        from dual) a;";
        rs = stmt.executeQuery(sql);
        
        out.println("<tr>"+pid+"번 "+pname+"후보 득표성향 분석</tr>");
        while(rs.next()){
            // 데이터 변수로 받기
            double a10 = rs.getDouble(1);
            double a20 = rs.getDouble(2);
            double a30 = rs.getDouble(3);
            double a40 = rs.getDouble(4);
            double a50 = rs.getDouble(5);
            double a60 = rs.getDouble(6);
            double a70 = rs.getDouble(7);
            double a80 = rs.getDouble(8);
            double a90 = rs.getDouble(9);
            double sum = rs.getDouble(10);

            
            for(int i=1; i<=9; i++) {
                out.println("<tr align=center>");
                    out.println("<td>"+i+"0대</td>");
                    out.println("<td align=left><img src=bar.jpg height=20 width="+300*(rs.getDouble(i)/sum)+">"+(int)rs.getDouble(i)+"표("+(int)(100*(rs.getDouble(i)/sum))+"%)</td>");
                out.println("</tr>");
            }
            
            /*
            //1o대
            out.println("<tr align=center>");
                out.println("<td>10대</td>");
                out.println("<td align=left><img src=bar.jpg height=20 width="+300*(a10/sum)+">"+(int)a10+"표("+(int)(100*(a10/sum))+"%)</td>");
            out.println("</tr>");
            //2o대
            out.println("<tr align=center>");
                out.println("<td>20대</td>");
                out.println("<td align=left><img src=bar.jpg height=20 width="+300*(a20/sum)+">"+(int)a20+"표("+(int)(100*(a20/sum))+"%)</td>");
            out.println("</tr>");
            //30대
            out.println("<tr align=center>");
                out.println("<td>30대</td>");
                out.println("<td align=left><img src=bar.jpg height=20 width="+300*(a30/sum)+">"+(int)a30+"표("+(int)(100*(a30/sum))+"%)</td>");
            out.println("</tr>");
            //4o대
            out.println("<tr align=center>");
                out.println("<td>40대</td>");
                out.println("<td align=left><img src=bar.jpg height=20 width="+300*(a40/sum)+">"+(int)a40+"표("+(int)(100*(a40/sum))+"%)</td>");
            out.println("</tr>");
            //5o대
            out.println("<tr align=center>");
                out.println("<td>50대</td>");
                out.println("<td align=left><img src=bar.jpg height=20 width="+300*(a50/sum)+">"+(int)a50+"표("+(int)(100*(a50/sum))+"%)</td>");
            out.println("</tr>");
            //6o대
            out.println("<tr align=center>");
                out.println("<td>60대</td>");
                out.println("<td align=left><img src=bar.jpg height=20 width="+300*(a60/sum)+">"+(int)a60+"표("+(int)(100*(a60/sum))+"%)</td>");
            out.println("</tr>");
            //7o대
            out.println("<tr align=center>");
                out.println("<td>70대</td>");
                out.println("<td align=left><img src=bar.jpg height=20 width="+300*(a70/sum)+">"+(int)a70+"표("+(int)(100*(a70/sum))+"%)</td>");
            out.println("</tr>");
            //8o대
            out.println("<tr align=center>");
                out.println("<td>80대</td>");
                out.println("<td align=left><img src=bar.jpg height=20 width="+300*(a80/sum)+">"+(int)a80+"표("+(int)(100*(a80/sum))+"%)</td>");
            out.println("</tr>");
            //90대
            out.println("<tr align=center>");
                out.println("<td>90대</td>");
                out.println("<td align=left><img src=bar.jpg height=20 width="+300*(a90/sum)+">"+(int)a90+"표("+(int)(100*(a90/sum))+"%)</td>");
            out.println("</tr>");
         */   
        }

        rs.close();
        stmt.close();
        conn.close();
    %>
    </table>
</body>
</html>