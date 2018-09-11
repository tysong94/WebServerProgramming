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
    function submitform() {
        f.content.value = $('#summernote').summernote('code');
        var title = f.title.value;

        if(checkBlank(title) == 1) {
            f.action='gongji_2_update.jsp';
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
    
<head>
    <%
    // DBMS 사용 변수
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/db_k08", "root", "1");
    Statement stmt = conn.createStatement();
    ResultSet rs = null;
    String sql = null;

    // 파라미터 변수
    String id = null;
    String title = null;
    String viewcnt = null;
    String date = null;
    String content = null;
    String filename = null;
    String filepath = null;
    String rootid = null;
    String relevel = null;
    String recnt = null;
    %>
</head>
<body>
    <%-- 데이터 받아오기 --%>
    <%
    //키 받아오기
    request.setCharacterEncoding("utf-8");
    id = request.getParameter("id");
    date = request.getParameter("date");
    viewcnt = request.getParameter("viewcnt");
    title = request.getParameter("title");

    //content = request.getParameter("content");
    sql="select content from gongji where id = '"+id+"';";
    rs = stmt.executeQuery(sql);
    while(rs.next()) {
        content = rs.getString("content");
    }

    filename = request.getParameter("filename");
    filepath = request.getParameter("filepath");
    rootid = request.getParameter("rootid");
    relevel = request.getParameter("relevel");
    recnt = request.getParameter("recnt");
    %>

    <!-- 글 수정란 -->
    <form name='f' method='post'>
    <table border=1 width=700>
        <tr>
            <td width=100 align=center>번호</td>
            <td width=600><input name='id' type='text' style='width:600;' value='<%=id%>' readonly></td>
        </tr>
        <tr>
            <td width=100 align=center>제목</td>
            <td width=600><input name='title' type='text' style='width:600;' value='<%=title%>' required></td>
        </tr>
        <tr>
            <td width=100 align=center>조회수</td>
            <td width=600><input name='viewcnt' type='text' style='width:600;' value='<%=viewcnt%>' readonly></td>
        </tr>
        <tr>
            <td width=100 align=center>일자</td>
            <td width=600><input name='date' type='text' style='width:600;' value='<%=date%>' readonly></td>
        </tr>
        <tr>
            <td width=100 align=center>내용</td>
            <td width=600>
                <div id='summernote'><%=content%></div>
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

        </tr>
         <tr>
            <td width=100 align=center>첨부파일</td>
            <%
            if(filename == null) {
                %><td width=600>첨부파일 없음</td><%
            } else {
                %><input name='filename' type='hidden' value='<%=filename%>' readonly><%
                %><td width=600><a href='http://192.168.23.106:8080/upload/<%=filename%>'><%=filename%></a></td><%
            }
            %>
        </tr>
        <tr>
            <td width=100 align=center>원글</td>
            <td width=600><input name='rootid' type=text style='width:600;' value='<%=rootid%>' readonly></td>
        </tr>
        <tr>
            <td width=100 align=center>댓글수준</td>
            <td width=600><input name='relevel' type=text style='width:600;' value='<%=relevel%>' readonly></td>
        </tr>
        <tr>
            <td width=100 align=center>댓글순서</td>
            <td width=600><input name='recnt' type=text style='width:600;' value='<%=recnt%>' readonly></td>
        </tr>
    </table>

    <!-- 버튼란 -->
    <table border=0 width=700>
        <tr align=right>
            <td colspan=2>
                내용을 수정합니다.
                <input type='button' value='취소' onclick="location.href='gongji_1_view.jsp?id=<%=id%>'">
                <input type='button' value='쓰기' onclick="submitform()">
                <input type='button' value='삭제' onclick="location.href='gongji_2_delete.jsp?id=<%=id%>&rootid=<%=rootid%>&recnt=<%=recnt%>&relevel=<%=relevel%>'">
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