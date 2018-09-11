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
            if (!pattern.test(obj)) { 
                alert("꺽쇠(<>),세미콜론(;)은 허용되지 않습니다.");  
            } else {
                return 1;
            }
        }

        // 제출 함수
        function submitform(mode) {
            var title = f.title.value;
            var content = f.content.value;

            if(mode == 'u' && checkBlank(title) == 1) {
                f.action='gongji_update.jsp';
                f.submit();
            } else if(mode == 'd') {
                f.action='gongji_delete.jsp';
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

    // key 변수
    int key = 0;
    
    // 번호, 제목, 일자, 내용 변수
    int id = 0;
    String title = null;
    String date = null;
    String content = null;
    %>
</head>
<body>
    <%-- 데이터 받아오기 --%>
    <%
    //키 받아오기
    key = Integer.parseInt(request.getParameter("key"));

    //키로 데이터 받아오기
    sql = "select * from gongji where id = "+key;
    rs = stmt.executeQuery(sql);
    
    while(rs.next()) {
        id = rs.getInt(1);
        title = rs.getString(2);
        date = rs.getString(3);
        content = rs.getString(4);
    }
    %>

    <!-- 글 수정란 -->
    <form name='f' method='post'>
    <table border=1 width=700>
        <tr>
            <td width=50 align=center>번호</td>
            <td width=650><input name='id' type=number style='width:650;' value='<%=id%>' readonly></td>
        </tr>
        <tr>
            <td width=50 align=center>제목</td>
            <td width=650><input name='title' type='text' style='width:650;' value='<%=title%>' required></td>
        </tr>
        <tr>
            <td width=50 align=center>일자</td>
            <td width=650><%=date%></td>
        </tr>
        <tr>
            <td width=50 align=center>내용</td>
            <td width=650><textarea name='content' style='width:650; height:250' row=600 required><%=content%></textarea></td>
        </tr>
    </table>

    <!-- 버튼란 -->
    <table border=0 width=700>
        <tr align=right>
            <td colspan=2>
                내용을 수정합니다.
                <input type='button' value='취소' onclick="location.href='gongji_view.jsp?key=<%=id%>'">
                <input type='button' value='쓰기' onclick="submitform('u')">
                <input type='button' value='삭제' onclick="location.href='gongji_delete.jsp?key=<%=id%>'">
            </td>
        </tr>        
    </table>
    </form>
</body>
</html>    