<%-- 한글 출력 시 필요 --%>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.*, java.util.*, java.sql.*, javax.sql.*, java.net.*" %>
<%-- 파일 첨부 시 필요 --%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
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

    // 파일 사이즈 체크 함수
    function CheckUploadFileSize(objFile) {
        var nMaxSize = 10 * 1024 * 1024; // 4 MB
        var nFileSize = objFile.files[0].size;
        if (nFileSize > nMaxSize) {
            alert("파일 크기는 최대 10MB까지 가능합니다.\n" + "현재 파일 크기 : " + nFileSize + " byte");
            objFile.value = '';
        } 
    }

    // 제출 함수
    function submitform() {
        var title = f.title.value;
        f.content.value = $('#summernote').summernote('code');

        if(checkBlank(title) == 1) { 
            f.submit(); 
        }
    }
    </script>

    <!-- bootstrap + jquery -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <script src="https://code.jquery.com/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    
    <!-- include summernote css/js-->
    <link href="summernote/summernote.css" rel="stylesheet">
    <script src="summernote/summernote.js"></script>
    <script src="summernote/lang/summernote-ko-KR.js"></script>

    <%
    // DBMS 사용 변수
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/db_k08", "root", "1");
    Statement stmt = conn.createStatement();
    ResultSet rs = null;
    String sql = null;

    // 변수
    String date = null;     // 날짜
    int rootid = 0;   // 원글
    %>
</head>
<body>
    <%-- 필요 데이터 받아오기  --%>
    <%
    // DB에서 날짜 받아오기
    sql = "select date_format(now(), '%Y-%m-%d %H:%i') from dual;"; 
    rs = stmt.executeQuery(sql);
    while(rs.next()) {
        date = rs.getString(1);
    }

    // DB에서원글 받아오기
    sql = "SELECT `AUTO_INCREMENT` FROM INFORMATION_SCHEMA.TABLES\r\n"
            +"WHERE TABLE_SCHEMA = 'db_k08' AND TABLE_NAME = 'gongji';"; 
    rs = stmt.executeQuery(sql);
    while(rs.next()) {
        rootid = rs.getInt(1);
    }
    %>

    <!-- 내용 -->
    <form name='f' method='post' action='gongji_newinsert.jsp' enctype="Multipart/form-data">
    <table border=1 width=700>
        <tr>
            <td width=100 align=center>번호</td>
            <td width=600><input type='text' name='id' style='width:600;' value='신규' readonly></td>
        </tr>
        <tr>
            <td width=100 align=center>제목</td>
            <td width=600><input type='text' name='title'  style='width:600;' value='' required></td>
        </tr>
        <tr>
            <td width=100 align=center>일자</td>
            <td width=600><input type='text' name='id' style='width:600;' value='<%=date%>' readonly></td>
        </tr>    
        <tr>
            <td width=100 align=center>내용</td>
            <td width=600>
                <div id='summernote'></div>
                <input type='hidden' name='content' value=''>
            </td>
        </tr>

        <%-- summernote 적용 --%>
        <script type="text/javascript">
            $(function() {
                $('#summernote').summernote({
                height: 300,          // 기본 높이값
                minHeight: null,      // 최소 높이값(null은 제한 없음)
                maxHeight: null,      // 최대 높이값(null은 제한 없음)
                focus: true,          // 페이지가 열릴때 포커스를 지정함
                lang: 'ko-KR'         // 한국어 지정(기본값은 en-US)
                });
            });

        $(document).ready(function() {
            $('#summernote').summernote();
        });
        </script>

        <tr>
            <td width=100 align=center>파일 첨부</td>
            <td width=600><input name='file1' type='file' onchange="CheckUploadFileSize(this);"/></td>
        </tr>
        <tr>
            <td width=100 align=center>원글</td>
            <td width=600><input type='text' name='rootid' style='width:600;' value='<%=rootid%>' readonly></td>
        </tr>
        <tr>
            <td width=100 align=center>댓글수준</td>
            <td width=600><input type='text' name='relevel' style='width:600;' value='0' readonly></td>
        </tr>
        <tr>
            <td width=100 align=center>댓글순서</td>
            <td width=600><input type='text' name='recnt' style='width:600;' value='0' readonly></td>
        </tr>
    </table>

    <!-- 버튼 -->
    <table border=0 width=700>
        <tr align=right>
            <td colspan=2>
                <input type='button' value='목록' onclick="window.location='gongji_list.jsp'">
                <input type='button' value='쓰기' onclick=submitform()>
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