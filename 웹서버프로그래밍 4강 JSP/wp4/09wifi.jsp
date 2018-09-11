<!-- 날짜 : 6월 5일 -->
<!-- 작성 : 송태양 -->
<!-- 제목 : 9. 전국와이파이표준데이터 웹페이지 만들기 -->
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.*, java.util.*" %>
<meta charset="UTF-8"/>
<html align=center>
<head>
    <%
        /// 필요 객체, 변수 세팅하기 ///////////////////////
        // 파일 객체, 파일 레코드 읽기 객체, 레코드 저장 변수
        File f = new File("/var/lib/tomcat7/webapps/ROOT/wp4/wifi.txt");
        BufferedReader br = new BufferedReader(new FileReader(f));  
        String oneRec_k08;
        
        // 페이지 인자 받는 변수
        // value는 무조건 스트링으로 받음.
        // 따라서 받은 value를 계산을 위해 int로 바꾸어줌.
        int from = Integer.parseInt(request.getParameter("from"));  // 시작 레코드
        int cnt = Integer.parseInt(request.getParameter("cnt"));    // 표시할 레코드 수
  
        // printf를 사용하기 위한 객체
        PrintWriter pw = response.getWriter();
    %>
</head>
<body>
    <%
        // 출력하기 ///////////////////////////////////
        // 빈파일 여부 확인
        if((oneRec_k08 = br.readLine()) == null) {
            out.println("빈 파일입니다<br>");
            br.close();
            return;
        }     

        // 레코드에서 필요 정보 출력
        // 표에 필드명 행 넣기
        pw.printf("<h1>전국 와이파이 데이터_K08</h1>");
        pw.printf("<table border=1 width=1000 align=center>");
        pw.printf("<tr align=center>");
        pw.printf("<td>번호</td>");
        pw.printf("<td>주소</td>");	// 도로명주소
        pw.printf("<td>위도</td>");	// 해당 위도
        pw.printf("<td>경도</td>");	// 해당 경도
        pw.printf("<td>거리</td>");	// 해당 경도
        pw.printf("</tr>");
        
        // 표에 필드 행 넣기
        int recCnt = 0;
		while((oneRec_k08 = br.readLine()) != null) {
            String[] field = oneRec_k08.split("\t");    // 한 레코드 읽고 쪼갬    
            recCnt++;                               // 레코드 수를 셈.

			if(recCnt < from) continue;             // 레코드 수가 from 이상일 때 수행
            if(recCnt > from + cnt-1) break;        // 레코드 수가 cnt 를 넘어갈 때 멈춤.
            
            pw.printf("<tr align=center>");
            pw.printf("<td>%d</td>", recCnt);       // 레코드 번호
            pw.printf("<td>%s</td>", field[8]);	    // 레코드 도로명주소 필드
            pw.printf("<td>%s</td>", field[12]);	// 레코드 위도 필드
            pw.printf("<td>%s</td>", field[13]);	// 레코드 경도 필드
            
            // 융기원 위도, 경도 
            double lat = 37.3860521;
            double lng = 127.1214038;
            // 레코드 위도 경도
            double lat2 = Double.parseDouble(field[12]);
            double lng2 = Double.parseDouble(field[13]);
            // 융기원과 레코드간 거리 계산
            double dist = Math.sqrt(Math.pow(lat2 - lat, 2) + Math.pow(lng2 - lng, 2));
            
            pw.printf("<td>%f</td>", dist);
            pw.printf("</tr>");
        }
        pw.printf("</table><br>");
        br.close(); // 파일 닫기
        
        // 표 아래 페이지네이션 //////////////////////////////////////////////////////////
        // 현재 파일의 모든 레코드 수를 세주는 객체
        LineNumberReader lnr = new LineNumberReader(new FileReader(f));
        lnr.skip(Integer.MAX_VALUE);
        int lineNum = lnr.getLineNumber() - 1;  // 필드명을 제외한 모든 레코드 수를 셈.
        lnr.close();                            // 파일 닫아줌.


        // << (이전 페이지)
        // 이전 페이지의 시작레코드가 0보다 작을 때
        if((int)(from/100-1)*100+1 < 0) { 
            // 이전페이지가 첫화면을 가르키도록 함.
            pw.printf("<a href=\"09wifi.jsp?from=1&cnt=%d\" target=\"main\"> << </a>", cnt); 
        // 아닐 때
        } else { 
            // 이전 페이지를 만듦.
            pw.printf("<a href=\"09wifi.jsp?from=%d&cnt=%d\" target=\"main\"> << </a>", (int)(from/100-1)*100+1, cnt);
        }

        // 번호 페이지 목록
        // 시작 레코드에 맞춰 시작 번호를 지정해줌.
        int start = ((int)(from/100)*10+1);
        // 시작 번호에서 10 만큼 번호 페이지 목록을 만듦
        for(int i = start; i < start + 10; i++) {
            pw.printf("<a href=\"09wifi.jsp?from=%d&cnt=%d\" target=\"main\"> %d </a>", (i-1)*cnt+1, cnt, i);
            // 페이지의 레코드가 모든 레코드 수를 넘어가면 멈춤.
            if((i-1)*10+1 + cnt > lineNum) break;
        }

        // >> (다음 페이지)
        // 다음 페이지의 시작 레코드가 모든 레코드 수를 넘어갈 때
        if(((int)(from/100)+1)*100+1 > lineNum) {
            // 다음 페이지를 만들지 않음.
        // 아닐 때
        } else {
            // 다음 페이지를 만듦.
            pw.printf("<a href=\"09wifi.jsp?from=%d&cnt=%d\" target=\"main\"> >> </a>", ((int)(from/100)+1)*100+1, cnt);
        }        
    %>
</body>
</html>
