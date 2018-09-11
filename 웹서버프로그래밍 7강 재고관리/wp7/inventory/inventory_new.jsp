<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.*, java.util.*, java.sql.*, javax.sql.*, java.net.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
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

<script> 
    var loadImage = function(event) {
            var reader = new FileReader();
            reader.onload = function(){
                var output = document.getElementById('output');
                output.src = reader.result;
            };
            reader.readAsDataURL(event.target.files[0]);
    };

    
</script>

<script type="text/javascript">
    function CheckUploadFileSize(objFile) {
        var nMaxSize = 4 * 1024 * 1024; // 4 MB
        var nFileSize = objFile.files[0].size;
        if (nFileSize > nMaxSize) {
            alert("4MB보다 큼!!\n" + nFileSize + " byte");
            objFile.value = '';
        } else {
            //alert("4MB보다 작음!!\n" + nFileSize + " byte");
        }
    }

    //if (/(\.gif|\.jpg|\.jpeg)$/i.test(obj.value) == false) {
    
    
    function CheckuploadFileExt(objFile) {
        var strFilePath = objFile.value;
        // 정규식
        var RegExtFilter = /(\.gif|\.jpg|\.jpeg|\.cng)$/i;
        //if (strFilePath.match(RegExtFilter) == null) alert("허용하지 않는 확장자 (1)");
        if (!RegExtFilter.test(strFilePath)) {
            alert("이미지 파일만 가능합니다.");
            objFile.value = '';
        } else {
            loadImage(event);
        }
        /*
        // inArray
        var strExt = strFilePath.split('.').pop().toLowerCase();
        if ($.inArray(strExt, ["zip"]) == -1){
        alert("허용하지 않는 확장자 (3)");
        objFile.outerHTML = objFile.outerHTML;
        }
        */
    }

</script>

<script>
    // 공백만 있을 때 체크 함수
    function checkBlank(obj) {
        var obj2 = obj.replace(/ /gi, "");    // 모든 공백을 제거
        if(!(obj2 == '') && !(obj2 == null)) {
            return true;
        } else {
            alert('항목을 입력하세요.');
        }
    }

    // 상품번호 영어숫자 체크 함수
    function checkNumEng(obj) { 
        var pattern = /^[a-zA-Z0-9]*$/;
        if (pattern.test(obj)) { 
            return true;
        } else {
            alert('상품번호는 영어, 숫자만 입력하세요.');
        }
    }

    // 상품명 한글영어숫자 체크 함수
    function checkWord(obj) { 
        var pattern = /^[가-힣a-zA-Z0-9]*$/;
        if (pattern.test(obj)) { 
            return true;
        } else {
            alert('상품명은 한글, 영어, 숫자만 입력하세요.');
        }
    }

    // 재고현황 숫자 체크 함수
    function checkNum(obj) { 
        var pattern = /^[0-9]*$/;
        if (pattern.test(obj)) { 
            return true;
        } else {
            alert('재고현황은 숫자만 입력하세요.');
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

    // 파일 체크 함수
    function checkFile(){ 
    　var chk = f.photos.value;
        if(chk == '' || chk == null){ 
        　　alert('파일을 선택하세요!'); 
        } else {
            return true;
        }
    }
    
    // 상품설명 태그 막기
    function checktag(obj) {

    }

    // 제출 함수
    function submitform() {
        var id = f.id.value;
        var name = f.name.value;
        var count = f.count.value;
        var details = f.details.value;         

        if(checkBlank(id) && checkNumEng(id) && checkLength(id, 14)         //상품번호 : 공백, 영어숫자, 길이체크
            && checkBlank(name) && checkWord(name) && checkLength(id, 20)   //상품명 : 공백, 한글영어숫자, 길이체크
            && checkBlank(count) && checkNum(count) && checkLength(count, 9)//재고현황 : 공백, 숫자, 길이체크     
            && checkFile()                                                  //파일체크 : 필수
        ) { 
            f.submit(); 
        }
    }
</script>


<body>
    <%-- 날짜 받아오기 --%>
    <%
    sql = "select date_format(now(), '%Y-%m-%d %H:%i') from dual;"; 
    rs = stmt.executeQuery(sql);
    while(rs.next()) {
        date = rs.getString(1);
    }
    %>
    
    <%-- 제목 --%>
    <table border=1 width=600>
        <tr align=center>
            <td><h1>(주)트와이스 재고 현황 - 상품 등록</h1></td>
        </tr>
    </table>

    <%-- 내용 --%>
    <form name="f" method="post" action='inventory_insert.jsp' enctype="Multipart/form-data">
    <table border=1 width=600>
        <tr>
            <td width=100 align=center>상품번호</td>
            <td width=500><input name='id' type=text style='width:500; border: 1px solid #ff0000;' maxlength='14' value=''></td>
        </tr>
        <tr>
            <td width=100 align=center>상품명</td>
            <td width=500><input name='name' type=text style='width:500; border: 1px solid #ff0000;' maxlength='20' value=''></td>
        </tr>
        <tr>
            <td width=100 align=center>재고현황</td>
            <td width=500><input name='count' type=number style='width:500; border: 1px solid #ff0000;' maxlength='9' value=''></td>
        </tr>
        <tr>
            <td width=100 align=center>상품등록일</td>
            <td width=500><input name='prdate' type=text style='width:500;' value='<%=date%>' readonly></td>
        </tr>
        <tr>
            <td width=100 align=center>재고등록일</td>
            <td width=500><input name='irdate' type=text style='width:500;' value='<%=date%>' readonly></td>
        </tr>
        <tr>
            <td width=100 align=center>상품설명</td>
            <td width=500><input name='details' type=text style='width:500; border: 1px solid #ff0000;' value=''></td>
        </tr>
        <tr>
            <td width=100 align=center>상품사진</td>
            <td width=500>
                <input name='photos' type="file" onchange="CheckUploadFileSize(this); CheckuploadFileExt(this);"/>
                <img id="output" width="260" height="200">
            </td>
        </tr>
    </form>
    </table>

    <!-- 버튼 -->
    <table border=0 width=600>
        <tr align=right>
            <td colspan=2>
                <input type='button' value='목록' onclick="window.location='inventory_list.jsp?from=1&cnt=10'">
                <input type='button' value='완료' onclick='submitform()'>
            </td>
        </tr>        
    </table>
    </from>
    
    <%
    // CLOSE
    stmt.close();
    conn.close();
    %>
</body>
</html>