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
    String k_id = null;
    String k_photos = null;

    // 파일 삭제 변수
    File file = null;
    %>
</head>
<body>
    <%
    // 파라미터 받아오기
    k_id = request.getParameter("key");
    //out.println(k_id);

    k_photos = request.getParameter("key2");
    //out.println(k_photos);

    // 파일 삭제 변수 선언
    file = new File(k_photos);
    if(file.exists()) {
        file.delete();
        //out.println("파일이 삭제되었습니다.");
    } else {
        //out.println("파일 없음");
    }

    // 데이터 delete하기
    sql = "delete from inventory where id='"+k_id+"'";
    stmt.execute(sql);

    
    %>
    
    <%-- 제목 --%>
    <table border=1 width=600>
        <tr align=center>
            <td><h1>(주)트와이스 재고 현황 - 상품 삭제</h1></td>
        </tr>
    </table>

    <%-- 내용 --%>
    <table border=1 width=600>
        <tr align=center>
            <td>
            해당 상품이 삭제되었습니다.
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
