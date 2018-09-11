<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.*, java.util.*, java.sql.*, javax.sql.*, java.net.*" %>

<html>
    <script>
        // 공백만 있을 때 체크 함수
        function checkBlank(obj) {
            var obj2 = obj.replace(/ /gi, "");    // 모든 공백을 제거
            if(obj2 == '' || obj2 == null) {
                alert('수량을 입력하세요.');
            } else {
                return 1;
            }
        }

        //숫자체크 함수
        function checkWord(obj) { 
            var pattern = /^[0-9]*$/;
            if (pattern.test(obj)) { 
                return true;
            } else {
                alert('재고는 숫자만 입력하세요.');
            }
        }

        // 길이 체크 함수
        function checkLength(obj, leng) {
            if(obj.length <= leng) {
                return true;
            } else {
                alert('최대 '+leng+'글자만 입력 가능합니다.');
            }
        }

        // 제출 함수
        function submitform() {
            var count = f.count.value;

            if(checkBlank(count) == 1 && checkWord(count) && checkLength(count, 9)) {
                f.submit(); 
            }
        }
    </script>
<head>
    <%
    // DBMS 사용 변수
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/db_k08", "root", "1");
    Statement stmt = conn.createStatement();
    ResultSet rs = null;
    String sql = null;

    // 날짜 변수
    String date = null;

    // 파라미터 변수
    String p_id = null;             // 상품번호
    String p_name = null;     // 상품명
    String p_count = null;          // 재고현황
    String p_irdate = null;   // 상품등록일
    String p_prdate = null;   // 재고등록일
    String p_details = null;  // 상품설명
    String p_photos = null;   // 상품사진
    %>
</head>
<body>
    <%-- 날짜 받아오기 --%>
    <%
    sql = "select date_format(now(), '%Y-%m-%d %H:%i') from dual;";
    rs = stmt.executeQuery(sql);
    while(rs.next()) {
        date = rs.getString(1);
    }
    %>
    
    <%-- 파라미터 받아오기 --%>
    <%
    request.setCharacterEncoding("UTF-8");
    p_id = request.getParameter("id");              // 상품번호
    p_name = request.getParameter("name");;         // 상품명
    p_count = request.getParameter("count").replace(",", "");       // 재고현황
    p_irdate = request.getParameter("irdate");;     // 상품등록일
    p_prdate = request.getParameter("prdate");;     // 재고등록일
    p_details = request.getParameter("details");;   // 상품설명
    p_photos = request.getParameter("photos");;     // 상품사진
    %>

    <%-- 제목 --%>
    <table border=1 width=600>
        <tr align=center>
            <td><h1>(주)트와이스 재고 현황 - 재고 수정</h1></td>
        </tr>
    </table>

    <%-- 내용  --%>
    <form name='f' method='post' action='inventory_update.jsp'>
    <table border=1 width=600>
        <tr>
            <td width=100 align=center>상품번호</td>
            <td width=500><input name='id' type=text style='width:500;' value='<%=p_id%>' readonly></td>
        </tr>
        
        <tr>
            <td width=100 align=center>상품명</td>
            <td width=500><input name='name' type=text style='width:500;' value='<%=p_name%>' readonly></td>
        </tr>
        <tr>
            <td width=100 align=center>재고현황</td>
            <td width=500><input name='count' type=number style='width:500; border: 1px solid #ff0000;' maxlength='9' value='<%=p_count%>'></td>
        </tr>
        <tr>
            <td width=100 align=center>상품등록일</td>
            <td width=500><input name='prdate' type=text style='width:500;' value='<%=p_prdate%>' readonly></td>
        </tr>
        <tr>
            <td width=100 align=center>재고등록일</td>
            <td width=500><input name='irdate' type=text style='width:500;' value='<%=date%>' readonly></td>
        </tr>
        <tr>
            <td width=100 align=center>상품설명</td>
            <td width=500><input name='details' type=text style='width:500;' value='<%=p_details%>' readonly></td>
        </tr>
        <tr>
            <td width=100 align=center>상품사진</td>
            <td width=500>
                <img src='http://192.168.23.106:8080/upload/<%=p_photos%>' width="300" >
            </td>
        </tr>
    </table>

    <!-- 버튼란 -->
    <table border=0 width=600>
        <tr align=right>
            <td colspan=2>
                재고를 수정합니다.
                <input type='button' value='취소' onclick="location.href='inventory_view.jsp?key=<%=p_id%>'">
                <input type='button' value='확인' onclick="submitform()">
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