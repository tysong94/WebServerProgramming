<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.*, java.util.*, java.sql.*, javax.sql.*, java.net.*" %>

<html>
<head>
    <%
    // DBMS 사용 변수
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/db_k08", "root", "1");
    Statement stmt = conn.createStatement();
    ResultSet rs = null;
    String sql = null;

    // 상품번호, 상품명, 현재 재고수, 상품등록일, 재고파악일
    String id = null;
    String name = null;
    String count = null;
    String hdate = null;
    String rdate = null;

    // 페이지 인자 받는 변수
    // value는 무조건 스트링으로 받음.
    // 따라서 받은 value를 계산을 위해 int로 바꾸어줌.
    int from = 0;
    int cnt = 0;
    if(request.getParameter("from") == null) {
        from = 1;
        cnt = 10;
    } else {
        from = Integer.parseInt(request.getParameter("from"));  // 시작 레코드
        cnt = Integer.parseInt(request.getParameter("cnt"));    // 표시할 레코드 수
    }

    int from1 = (int)((from-1)/cnt) * cnt + 1;                  // 시작 레코드를 해당 페이지의 맨 윗 레코드로 수정.
    //out.println("from : "+from+", cnt : "+cnt+", from1 : "+from1);
    %>
</head>
<body>
    <%-- 제목 --%>
    <table border=1 width=800>
        <tr align=center>
            <td><h1>(주)트와이스 재고 현황 - 전체 현황</h1></td>
        </tr>
    </table>

    <!-- 게시판 목록 -->
    <table border=1 width=800>
        <!-- 필드명 라인 -->
        <tr align=center>
            <td width=100>상품번호</td>
            <td width=200>상품명</td>
            <td width=100>재고수</td>
            <td width=200>상품등록일</td>
            <td width=200>재고파악일</td>
        </tr>

        <!-- 항목들 -->
        <%
        sql = "select id, name, format(count, 0), date_format(prdate, '%Y-%m-%d %H:%i'), date_format(irdate, '%Y-%m-%d %H:%i')\r\n" 
                +"from inventory\r\n" 
                +"order by irdate desc;\r\n";
        rs = stmt.executeQuery(sql);

        int recCnt = 0;
        while(rs.next()) {
            recCnt++;                               // 레코드 수를 셈.

			if(recCnt < from1) continue;             // 레코드 수가 from 이상일 때 수행
            if(recCnt > from1 + cnt-1) break;        // 레코드 수가 cnt 를 넘어갈 때 멈춤.

            id = rs.getString(1);
            name = rs.getString(2);
            count = rs.getString(3);
            hdate = rs.getString(4);
            rdate = rs.getString(5);
 
            out.println("<tr align=center>");
            out.println(    "<td width=100><a href=inventory_view.jsp?key="+id+">"+id+"</a></td>");
            out.println(    "<td width=200><a href=inventory_view.jsp?key="+id+">"+name+"</a></td>");
            out.println(    "<td width=100 align=right>"+count+"</td>");
            out.println(    "<td width=200>"+hdate+"</td>");
            out.println(    "<td width=200>"+rdate+"</td>");
            out.println("</tr>");
        }
        %>
    </table>
    
    <!-- 신규 버튼 -->
    <table border=0 width=800>
        <tr align=right>
            <td colspan=5><input type="button" value="신규" onclick="window.location='inventory_new.jsp'"></td>
        </tr>
    </table>
    

    <table border=0 width=800>
        <tr align=center>
            <td>
    <%-- 페이지 --%>
    <%

    // 모든 데이터 개수 세기
    sql = "select count(*) from inventory";
    rs = stmt.executeQuery(sql);
    rs.next();
    
    int allRowNum = rs.getInt(1);   // 전체 레코드 수
    int pageRecNum = cnt;           // 한 화면 레코드 수      
    int pageNum = 10;               // 한 화면 페이지 수
    int currentPage = (int)((from1-1)/cnt) + 1;       // 현재 페이지
    
    // 전체 페이지 수 구하기
    int totalPage = allRowNum / pageRecNum; // 전체 페이지 수
    if(allRowNum % pageRecNum > 0) {
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
        out.print("<a href='inventory_list.jsp?from=1&cnt="+cnt+"'> << </a>");
    }
    // 이전 페이지 구현하기
    if(startPage > 1) {
        out.print("<a href='inventory_list.jsp?from="+((startPage-2)*cnt+1)+"&cnt="+cnt+"'> < </a>");
    }

    // 페이지 넘버 출력하기
    for(int iCount = startPage; iCount <= endPage; iCount++) {
        if(iCount == currentPage) {
            out.print("<a href=\"inventory_list.jsp?from="+((iCount-1)*cnt+1)+"&cnt="+cnt+"\"> <b>"+iCount+"</b> </a>");
        } else {
            out.print("<a href=\"inventory_list.jsp?from="+((iCount-1)*cnt+1)+"&cnt="+cnt+"\"> "+iCount+" </a>");
        }
    }

    // 다음 페이지 구현하기
    if(endPage != totalPage) {
        out.print("<a href=\"inventory_list.jsp?from="+((endPage*cnt)+1)+"&cnt="+cnt+"\"> > </a>");
    }

    // 맨 뒤 페이지 구현하기
    if(endPage != totalPage) {
        out.print("<a href=\"inventory_list.jsp?from="+((totalPage-1)*cnt+1)+"&cnt="+cnt+"\"> >> </a>");
    }
    %>
            </td>
        </tr>
    </table>

    <%
    // CLOSE
    stmt.close();
    conn.close();
    %>
</body>
</html>
