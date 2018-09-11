<!-- 날짜 : 6월 26일 -->
<!-- 작성 : 송태양 -->
<!-- 제목 : 조회 -->
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.*, java.util.*, java.sql.*, javax.sql.*, java.net.*" %>
<meta charset="UTF-8"/>

<head>
    <%-- 객체, 변수 선언부 --%>
    <%        
        // DBMS 사용 
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/db_k08", "root", "1");
        Statement stmt = conn.createStatement();
        ResultSet rs = null;

        String temp = null;
        String name = null;
        int studentid = 0;
        int kor = 0;
        int eng = 0;
        int mat = 0;
    %>
</head>
<body>
    <%
        // 파라미터 받아오기 ////////////////////////////////////
        // 이름 가져와서 한글 처리하기
        temp = request.getParameter("name");
        name = new String(temp.getBytes("8859_1"), "utf-8");
        
        // studentid 계산해서 넣어주기
        //rs = stmt.executeQuery("select max(studentid) from twice_k08");
        rs = stmt.executeQuery("select count(*) from twice_k08 where studentid = 209901");
        while(rs.next()){
            studentid = rs.getInt(1);
        }
        
        if(studentid == 0){
                studentid = 209901;
        }else{
            rs = stmt.executeQuery("SELECT min(studentid+1) FROM twice_k08 WHERE (studentid+1) NOT IN (SELECT studentid FROM twice_k08);");
            while(rs.next()){
            studentid = rs.getInt(1);
            }
        }
        
        // 국어, 영어, 수학 점수 가져오기
        kor = Integer.parseInt(request.getParameter("kor"));
        eng = Integer.parseInt(request.getParameter("eng"));
        mat = Integer.parseInt(request.getParameter("mat")); 

        // 새 학생 INSERT ////////////////////////////////////////
        stmt.execute("insert into twice_k08(name, studentid, kor, eng, mat) values('"
        + name + "', "
        + studentid + ", "
        + kor + ", "
        + eng + ", "
        + mat + ");");

        // INSERT 학생 조회하기
        rs = stmt.executeQuery("select * from twice_k08 where studentid = " + studentid);
        while(rs.next()) {
            name = rs.getString(1);
            studentid = rs.getInt(2);
            kor = rs.getInt(3);
            eng = rs.getInt(4);
            mat = rs.getInt(5);
        }
    %>
        
    <h1>성적 입력 추가 완료</h1>
    <table width=300 border=1>
        <tr align=center>
            <td>이름</td>
            <td><%= name %></td>
        </tr>
        <tr align=center>
            <td>학번</td>
            <td><%= studentid %></td>
        </tr>
        <tr align=center>
            <td>국어</td>
            <td><%= kor %></td>
        </tr>
        <tr align=center>
            <td>영어</td>
            <td><%= eng %></td>
        </tr>
        <tr align=center>
            <td>수학</td>
            <td><%= mat %></td>
        </tr>            
    </table>
    <table width=300 border=0>
        <tr align=center>
            <td colspan=2><a href="insertform.html"><input type=submit value=뒤로가기></input></a></td>
        </tr>
    </table>
    <%
        stmt.close();
        conn.close();
    %>
</body>
</html>