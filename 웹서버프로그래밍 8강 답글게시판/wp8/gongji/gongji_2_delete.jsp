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
    int p_id = 0;

    // 댓글 삭제 변수
    int rootid = 0;
    int relevel = 0;
    int recnt = 0;

    // 파일 삭제 변수
    File file = null;
    String filepath = null;
    %>
</head>
<body>
    <%-- 글 삭제하기 --%>
    <%
    rootid = Integer.parseInt(request.getParameter("rootid"));
    relevel = Integer.parseInt(request.getParameter("relevel"));
    recnt = Integer.parseInt(request.getParameter("recnt"));

    // 자기 레벨의 다음 순서 구하기
    sql = "select ifnull((select min(recnt) from gongji where rootid = "+rootid+" and relevel <= "+relevel+" and recnt > "+recnt+"),\r\n" 
                        +"(select max(recnt) + 1 from gongji where rootid = "+rootid+"))\r\n"
            +"from dual";
    rs = stmt.executeQuery(sql);
    int temp = 0;
    while(rs.next()) {
        temp = rs.getInt(1);
        out.print(temp+"<br>");
    }

    // 자신과 하위 댓글 삭제
    sql = "delete from gongji where rootid = "+rootid+" and recnt >= "+recnt+" and recnt < "+temp+";";
    stmt.execute(sql);
    
    // 댓글 삭제 후 순서 땡기기
    sql = "update gongji set recnt = recnt-"+(temp-recnt)+" where recnt >= "+temp+";";
    stmt.execute(sql);
    %>


    <%-- 파일 삭제하기 --%>
    <%
    sql = "select filepath from gongji where id = "+p_id+";";
    rs = stmt.executeQuery(sql);
    while(rs.next()) { 
        filepath = rs.getString("filepath"); 
    }
    if(filepath != null) {
        file = new File(filepath);
        if(file.exists()) {
            file.delete();
        }
    }
    %>

    해당 글이 삭제되었습니다.
    <input type=button value='목록' onclick="location.href='gongji_list.jsp'">

    <%
    // CLOSE
    stmt.close();
    conn.close();
    %>
</body>
</html>
