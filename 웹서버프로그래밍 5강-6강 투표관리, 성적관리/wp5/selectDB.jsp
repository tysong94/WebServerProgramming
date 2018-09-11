<!-- 날짜 : 6월 26일 -->
<!-- 작성 : 송태양 -->
<!-- 제목 : 조회 -->
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.*, java.util.*, java.sql.*, javax.sql.*, java.net.*" %>
<meta charset="UTF-8"/>

<head>   
    <%        
        // DBMS 접속 객체
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/db_k08", "root", "1");
        Statement stmt = conn.createStatement();
        ResultSet rs = null;
        
        // 파라미터 받아서 데이터 가져올 변수
        int inputid = 0;    //학번 입력
        String sql = null;

        // 각 컬럼 가져올 변수
        String name = null;
        String studentid = null;
        String kor = null;
        String eng = null;
        String mat = null;
    %>
    <script>
        //숫자 체크 함수
        function checkNumber(str) {
            var regNumber = /^[0-9]*$/;
            var tf = true;
            if(!regNumber.test(str)) {
                tf = true;
            } else {
                tf = false;
            }
            return tf;
        }

        // 글자수 체크
        function checkLength(str) {
           return str.length;
        }

        // 특수문자 체크 함수
        function checkSpecial(str) {
            var string = /[~!@\#$%<>^&*\()\-=+_\’]/gi; 
            var isValid = true;
            if(string.test(str)) {
                isValid = false;
            }
            return isValid;
        }
        
        // 공백 체크 함수
        function checkSpace(str) {
           if(str.search(/\s/) != -1) {
               return true;
           } else {
               false;
           }
        }
        
        // 성적 조회 폼 실행
        function submitform2(){
            if(document.myform2.inputid.value == ""){
                alert("값을 입력하세요.");
            } else if(checkNumber(document.myform2.inputid.value) == true){
                alert("숫자만 입력하세요.")
            } else {
                myform2.submit();
            }
        }

        // 다중 submit 폼을 위한 javascript 함수
        function submitform(index){
            if(document.myform.name.value == "" || document.myform.kor.value == "" || document.myform.eng.value == "" || document.myform.mat.value == ""){
                alert("값을 입력하세요.");
            } else if(checkSpace(document.myform.name.value) == true) {
                alert("공백을 입력할 수 없습니다.");                
            } else if(checkNumber(document.myform.kor.value) == true || checkNumber(document.myform.eng.value) == true || checkNumber(document.myform.mat.value) == true) {
                alert("숫자만 입력하세요.")
            } else if(checkSpecial(document.myform.name.value) == false) {
                alert("특수문자를 입력할 수 없습니다.");
            } else if(checkLength(document.myform.name.value) > 10) {
                alert("10글자 이내로 입력해야 합니다.");
            } else if(document.myform.kor.value < 0 || document.myform.eng.value < 0 || document.myform.mat.value < 0){
                alert("성적은 0보다 크고 100보다 작아야 합니다.");
            } else if(document.myform.kor.value >100 || document.myform.eng.value >100 || document.myform.mat.value > 100){
                alert("성적은 0보다 크고 100보다 작아야 합니다.");
            } else{
                if(index == 1){
                    myform.action = "updateDB.jsp"; //해당 폼의 파라미터 전송 대상 지정
                    myform.submit();                //해당 폼의 파라미터 전송
                } else if(index == 2) {
                    myform.action = "deleteDB.jsp"; // 해당 폼의 파라미터 전송 대상 지정
                    myform.submit();                // 해당 폼의 파라미터 전송
                } 
            }
        }
    </script>     
</head>
<body>
    <%
        //////// 학번 입력 받아 데이터 조회, 가져오기 ///////////////
        inputid = Integer.parseInt(request.getParameter("inputid"));
        sql = "select * from twice_k08 where studentid =" + inputid + ";";
        rs = stmt.executeQuery(sql);

        name = "해당학번없음";
        studentid = "";
        kor = "";
        eng = "";
        mat = "";

        while(rs.next()) {
            name = rs.getString(1);
            studentid = rs.getString(2);
            kor = rs.getString(3);
            eng = rs.getString(4);
            mat = rs.getString(5);
        }
    %>
    
    
    <h1>성적 조회 후 정정/삭제</h1>
    <%-- 성적 조회하기 폼 입력란 --%>
    <form name=myform2 method=post action=selectDB.jsp>
        <table width=400 border=0>
            <tr align=center>
                <td>조회할 학번</td>
                <td><input type=number name=inputid></td>                
                <td><input type=button onclick="submitform2()" value="조회"></td>
            </tr>
        </table>
    </form>

    <%-- 성적 수정/삭제하기 폼 입력란 --%>
    <form method=post name=myform>
        <table width=400 border=1>
            <tr align=center>
                <td>이름</td>
                <td><input type=text name=name value=<%= name %>></td>
            </tr>
            <tr align=center>
                <td>학번</td>
                <td><input type=text name=studentid readonly value=<%= studentid %> ></td>
            </tr>
            <tr align=center>
                <td>국어</td>
                <td><input type=number name=kor value=<%= kor %>></td>
            </tr>
            <tr align=center>
                <td>영어</td>
                <td><input type=number name=eng value=<%= eng %>></td>
            </tr>
            <tr align=center>
                <td>수학</td>
                <td><input type=number name=mat value=<%= mat %>></td>
            </tr>            
        </table>
    </form>
    
    <%-- 성적 수정, 삭제 버튼 --%>
    <%
    if(name != "해당학번없음") {
        out.println("<table width=400 border=0>");
        out.println("<tr align=center>");
        out.println("<td colspan=2>");
        out.println("<input type=button value=수정 OnClick=submitform(1)></input></a>");
        out.println("<input type=button value=삭제 OnClick=submitform(2)></input></a>");
        out.println("</td>");
        out.println("</tr>");
    }
        stmt.close();
        conn.close();
    %>
</body>