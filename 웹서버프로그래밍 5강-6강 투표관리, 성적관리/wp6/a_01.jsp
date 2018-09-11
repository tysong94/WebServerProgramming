<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.*, java.util.*, java.sql.*, javax.sql.*, java.net.*" %>


<html>
<script>
    // 공백 체크 함수
    function checkEmpty(obj) {
        if(obj == '' || obj == null ){
            alert('후보명을 입력해주세요.');
        } else {
            return 1;
        }
    }

    // 한글, 영문 체크 함수
    function checkWord(obj) { 
        var pattern = /^[ㄱ-힣a-zA-Z]*$/; //한글,영문만 허용 
        if (!pattern.test(obj)) { 
            alert("한글, 영문만 허용합니다.");  
        } else {
            return 1;
        }
    }

    // 글자수 체크 함수
    function checkLength(str) {
        if(str.length > 10) {
            alert('최대 10글자만 입력 가능합니다.')
        } else {
           return 1;
        }
    }

    // 바이트 체크 함수
    function checkByte(str) {
        var byte = 0;
        for (var i=0; i<str.length; ++i) {
            // 기본 한글 2바이트 처리
            (str.charCodeAt(i) > 127) ? byte += 2 : byte++ ;
        }
        if(byte > 10) {
            alert('최대 바이트수는 10바이트 입니다.')
        } else {
            return 1;
        }
    }

    // 폼 제출 함수
    function submitform() {
        var fname = myform.name.value;
        if(checkEmpty(fname) == 1 && checkWord(fname) == 1 && checkLength(fname) == 1) { 
            myform.submit(); 
        }
    }
</script>
<head>
    <h1>후보목록</h1>
    <%        
        // DBMS 사용 변수
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/db_k08", "root", "1");
        Statement stmt = conn.createStatement();
        ResultSet rs = null;
        String sql = null;
        
        // 기호, 후보명 변수
        int id = 0;
        String temp = null;
        String name = null;
        int tmp = 0;
    %>
</head>
<body>
    <%-- 메뉴바 --%>
    <table cellspacing=0 width=500 border=1> 
            <tr align=center>
                <td bgcolor = #ffff00 width=50 style="word-break:break-all"><a href="a_01.jsp">후보등록</td>
                <td width=50 style="word-break:break-all"><a href="b_01.jsp">투표</a></td>
                <td width=50 style="word-break:break-all"><a href="c_01.jsp">개표결과</td>
            </tr>
    </table>

    <%-- 후보목록 --%>
    <table cellspacing=0 width=500 border=1> 
        <%
        sql = "select * from hubo order by id asc;";
        rs = stmt.executeQuery(sql);
        
        while (rs.next()) {
            out.println("<form method=post action=a_02.jsp>");
                out.println("<tr align=center>");
                    out.println("<td>기호번호</td>");
                    out.println("<td><input name=\"id\" readonly style=\"border: 0px; width: 100px; text-align: center;\" type=number value=" + rs.getString(1) + "></td>");
                    out.println("<td>후보명</td>");
                    out.println("<td>" + rs.getString(2) + "</td>");
                    out.println("<td><input type=submit value=삭제></input></td>");
                out.println("</tr>");
            out.println("</form>");

            tmp = rs.getInt(1);
        }

        // 기호 계산해서 넣어주기
        //rs = stmt.executeQuery("select max(id) from hubo");
        rs = stmt.executeQuery("select count(*) from hubo where id = 1");
        while(rs.next()){
            id = rs.getInt(1);
        }
        
        if(id == 0){
                id = 1;
        }else{
            rs = stmt.executeQuery("SELECT min(id+1) FROM hubo WHERE (id+1) NOT IN (SELECT id FROM hubo);");
            while(rs.next()){
                id = rs.getInt(1);
            }
        }
        %>

    <%-- 후보추가란 --%>
        <form name=myform method=post action=a_03.jsp>
            <tr align=center>
                <td>기호번호</td>
                <td><input name='id' readonly style='border: 0px; text-align: center;' type=number value='<%= id %>'></td>
                <td>후보명</td>
                <td><input name='name' pattern='^[ㄱ-힣a-zA-Z]+$' style='text-align: center;' type='text' value='' required></td>
                <%-- <td><input type=submit value=추가></input></td> --%>
                <td><input type=button value=추가 onclick=submitform()></input></td>
            </tr>
        </form>
    </table>
    
    <%-- 닫아주기 --%>
    <%
    rs.close();
    stmt.close();
    conn.close();
    %>
    
</body>
</html>