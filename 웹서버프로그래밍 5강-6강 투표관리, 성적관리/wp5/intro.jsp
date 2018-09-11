<!-- 날짜 : 7월 19일, 작성 : 송태양, 제목 : 첫화면(intro.jsp) -->
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.*, java.util.*, java.sql.*, javax.sql.*, java.net.*" %>
<meta charset="UTF-8"/>
<html>
<head>
    <h1>JSP Database 실습 1</h1>

    <%
        // 파일 읽기 변수
        FileReader fr = new FileReader("/home/cnt.txt");
        StringBuffer sb = new StringBuffer();

        // 파일 저장 변수
        String data = null;
        int cnt = 0;      
    %>
</head>
<body>
    <%
        // 파일에서 한 글자 읽어오기
        int ch = 0;
        while((ch = fr.read()) != -1){
            sb.append((char)ch);
        }
        fr.close();

        // 한 글자 -> string -> interger로 변환
        data = sb.toString().trim().replace("\n", "");
        cnt = Integer.parseInt(data);
        
        // 카운트 올리기
        cnt++;

        // integer -> string으로 변환
        data = Integer.toString(cnt);

        // 한 글자 파일로 넣기
        // ** fileWriter를 생성함과 동시에 cnt파일이 초기화 됨 -> 위에서 선언할 수 없다.
        FileWriter fw = new FileWriter("/home/cnt.txt", false);
        fw.write(data);
        fw.close();


        // 방문자수 출력
        out.println("현재 홈페이지 방문 조회수는 [" + data + "] 입니다.");        
    %>
</body>
</html>