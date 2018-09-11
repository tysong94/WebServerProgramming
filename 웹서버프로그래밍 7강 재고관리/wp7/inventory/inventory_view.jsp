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

    // key 변수
    String kid = null;
    
    // 데이터 변수
    String id = null;             // 상품번호
    String name = null;     // 상품명
    String count = null;          // 재고현황
    String irdate = null;   // 상품등록일
    String prdate = null;   // 재고등록일
    String details = null;  // 상품설명
    String photos_addr = null;   // 상품사진
    String photos_name = null;   // 상품사진
    %>
</head>
<body>
    <%-- 데이터 받아오기 --%>
    <%
    //키 받아오기
    kid = request.getParameter("key");

    //데이터 받아오기
    sql = "select id, name, format(count, 0), date_format(prdate, '%Y-%m-%d %H:%i'), date_format(irdate, '%Y-%m-%d %H:%i'), details, photos_addr, photos_name from inventory where id = '"+kid+"';";
    rs = stmt.executeQuery(sql);
    
    while(rs.next()) {
        id = rs.getString(1);
        name = rs.getString(2);
        count = rs.getString(3);
        prdate = rs.getString(4);
        irdate = rs.getString(5);
        details = rs.getString(6);
        photos_addr = rs.getString(7);
        photos_name = rs.getString(8);
    }
    %>

    <%-- 제목 --%>
    <table border=1 width=600>
        <tr align=center>
            <td><h1>(주)트와이스 재고 현황 - 상품 상세</h1></td>
        </tr>
    </table>

    <%-- 내용 --%>
    <form name='f' method='post' action='inventory_edit.jsp'>
    <table border=1 width=600>
        <tr>
            <td width=100 align=center>상품번호</td>
            <td width=500><input name='id' type=text style='width:500;' value='<%=id%>' readonly></td>
        </tr>
        <tr>
            <td width=100 align=center>상품명</td>
            <td width=500><input name='name' type=text style='width:500;' value='<%=name%>' readonly></td>
        </tr>
        <tr>
            <td width=100 align=center>재고현황</td>
            <td width=500><input name='count' type=text style='width:500;' value='<%=count%>' readonly></td>
        </tr>
        <tr>
            <td width=100 align=center>상품등록일</td>
            <td width=500><input name='prdate' type=text style='width:500;' value='<%=prdate%>' readonly></td>
        </tr>
        <tr>
            <td width=100 align=center>재고등록일</td>
            <td width=500><input name='irdate' type=text style='width:500;' value='<%=irdate%>' readonly></td>
        </tr>
        <tr>
            <td width=100 align=center>상품설명</td>
            <td width=500><input name='details' type=text style='width:500;' value='<%=details%>' readonly></td>
        </tr>
        <tr>
            <td width=100 align=center>상품사진</td>
            <td width=500>
                <input type=hidden name='photos' style='width:500;' value='<%=photos_name%>' readonly>
                <img src='http://192.168.23.106:8080/upload/<%=photos_name%>' width="300" >
            </td>
        </tr>
    </table>

    <!-- 버튼 -->
    <table border=0 width=600>
        <tr align=right>
            <td colspan=2>
                <input type='button' value='목록' onclick="window.location='inventory_list.jsp?'">
                <input type='submit' value='재고수정'>
                <input type='button' value='상품삭제' onclick="location.href='inventory_delete.jsp?key=<%=kid%>&key2=<%=photos_addr%>'">
            </td>
        </tr>        
    </table>
    </form>

    <%
    // CLOSE
    stmt.close();
    conn.close();
    %>
</body>
</html>