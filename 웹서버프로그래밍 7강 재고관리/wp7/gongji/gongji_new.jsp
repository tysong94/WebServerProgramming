<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.*, java.util.*, java.sql.*, javax.sql.*, java.net.*" %>

<html>
    <script>  
        // 공백만 있을 때 체크 함수
        function checkBlank(obj) {
            var obj2 = obj.replace(/ /gi, "");    // 모든 공백을 제거
            if(obj2 == '' || obj2 == null) {
                alert('제목을 입력하세요.');
            } else {
                return 1;
            }
        }

        
        // <>, ; 체크 함수
        function checkWord(obj) { 
            var pattern = /^[<|>|;]*$/;
            if (pattern.test(obj)) { 
                alert("꺽쇠(<>),세미콜론(;)은 허용되지 않습니다.");  
            } else {
                return 1;
            }
        }
            
        // 제출 함수
        function submitform() {
            var title = f.title.value;
            var content = f.content.value;

            if(checkBlank(title) == 1) { 
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
    %>
</head>
<body>
    <%
    sql = "select date(now()) from dual;"; 
    rs = stmt.executeQuery(sql);
    while(rs.next()) {
        date = rs.getString(1);
    }
    %>

    <!-- 입력란 -->
    <form name='f' method='post' action='gongji_insert.jsp'>
    <table border=1 width=700>
        <tr>
            <td width=50 align=center>번호</td>
            <td width=650>신규</td>
        </tr>
        <tr>
            <td width=50 align=center>제목</td>
            <td width=650><input name='title' type='text' style='width:650;' value='' required></td>
        </tr>
        <tr>
            <td width=50 align=center>일자</td>
            <td width=650><%= date%></td>
        </tr>
        <tr>
            <td width=50 align=center>내용</td>
            <td width=650><textarea name='content' style='width:650; height:250' row=600 value='' required></textarea></td>
        </tr>
    </table>

    <!-- 버튼란 -->
    <table border=0 width=700>
        <tr align=right>
            <td colspan=2>
                <input type='button' value='목록' onclick="window.location='gongji_list.jsp'">
                <input type='button' value='쓰기' onclick=submitform()>
            </td>
        </tr>        
    </table>
    </form>
    
</body>
</html>