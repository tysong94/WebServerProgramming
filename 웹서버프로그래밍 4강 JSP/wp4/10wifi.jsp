<!-- 날짜 : 6월 5일 -->
<!-- 작성 : 송태양 -->
<!-- 제목 : 9. 전국와이파이표준데이터 웹페이지 만들기 -->
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.*, java.util.*" %>
<meta charset="UTF-8"/>
<html align=center>
<head>
    <%
        // printf를 사용하기 위한 객체
        PrintWriter pw = response.getWriter();

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
        int from1 = (int)((from-1)/cnt) * cnt + 1;                  // 시작 레코드를 해당 페이지의 맨 윗 레코드로 수정.
        pw.printf("from : %d, cnt : %d, from1 : %d", from, cnt, from1);
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

			if(recCnt < from1) continue;             // 레코드 수가 from 이상일 때 수행
            if(recCnt > from1 + cnt-1) break;        // 레코드 수가 cnt 를 넘어갈 때 멈춤.
            
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
                                                
                                                
        
        int allRec = lineNum;   // 전체 레코드 수
        int recNum = cnt;   // 한 화면 레코드 수      
        int pageNum = 10;  // 한 화면 페이지 수
        int currentPage = (int)((from1-1)/cnt) + 1;       // 현재 페이지
        
        // 전체 페이지 수 구하기
        int totalPage = allRec / recNum; // 전체 페이지 수
        if(allRec % recNum > 0) {
            totalPage++;
        }

        if (totalPage < currentPage) { // 현재 페이지가 전체 페이지보다 클 경우 강제 최종 페이지.
            currentPage = totalPage;
        }
        
        // 시작 페이지, 끝 페이지 구하기
        int startPage = ((int)(currentPage - 1) / pageNum) * pageNum + 1;
        int endPage = startPage + pageNum - 1;

        if(endPage > totalPage) {
            endPage = totalPage;
        }

        // 맨 앞 페이지 구현하기 
        if(startPage > 1) {
            pw.printf("<a href=\"10wifi.jsp?from=%d&cnt=%d\" target=\"main\"> << </a>", 1, cnt);
        }
        // 이전 페이지 구현하기
        if(startPage > 1) {
            pw.printf("<a href=\"10wifi.jsp?from=%d&cnt=%d\" target=\"main\"> < </a>", ((startPage-2)*cnt)+1, cnt);
        }

        // 페이지 넘버 출력하기
        for(int iCount = startPage; iCount <= endPage; iCount++) {
            if(iCount == currentPage) {
                pw.printf("<a href=\"10wifi.jsp?from=%d&cnt=%d\" target=\"main\"> <b>%d</b> </a>", ((iCount-1)*cnt)+1, cnt, iCount);
            } else {
                pw.printf("<a href=\"10wifi.jsp?from=%d&cnt=%d\" target=\"main\"> %d </a>", ((iCount-1)*cnt)+1, cnt, iCount);
            }
        }

        // 다음 페이지 구현하기
        if(endPage != totalPage) {
            pw.printf("<a href=\"10wifi.jsp?from=%d&cnt=%d\" target=\"main\"> > </a>", ((endPage)*cnt)+1, cnt);
        }

        // 맨 뒤 페이지 구현하기
        if(endPage != totalPage) {
            pw.printf("<a href=\"10wifi.jsp?from=%d&cnt=%d\" target=\"main\"> >> </a>", ((totalPage-1)*cnt)+1, cnt);
        }
    %>
</body>
</html>
