<!-- 날짜 : 6월 5일 -->
<!-- 작성 : 송태양 -->
<!-- 제목 : 8. 인자를 받아 처리 -->
<%@ page contentType="text/html; charset=UTF-8" %>
<meta charset="UTF-8"/>
<html>
<head>  
</head>
<body>
    <%-- form 폼을 작성 : request를 받겠다는 의미 --%>
    <%-- method="post" : post방식 사용 --%>
    <%-- action="08member.jsp" : 해당 페이지에 key와 value를 전송함 --%>
    <form method="post" action="08member.jsp">
        <%-- input : 입력창을 만듦 --%>
        <%-- name은 key, 입력값은 value --%>
        이름 : <input type="text" name="username"><br>
        비밀번호 : <input type="password" name="userpasswd"><br>
        <%-- submit : 제출버튼을 만듦 --%>
        <%-- submit을 클릭하면 전송함, value : 제출버튼의 내용 --%>
        <input type="submit" value="전송"> 
    </form>
</body>
</html>