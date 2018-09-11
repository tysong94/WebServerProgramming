<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.*, java.util.*, java.sql.*, javax.sql.*, java.net.*" %>
<%-- 파일 업로드 시 필요 --%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>

<html>
<head>
    <%
    // DBMS 사용 변수
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/db_k08", "root", "1");
    Statement stmt = conn.createStatement();
    ResultSet rs = null;
    String sql = null;

    // MultipartRequest 변수
    request.setCharacterEncoding("utf-8");
    String saveFolder = "/upload";  // 파일 업로드할 폴더 지정. 이미지 출력에 필요
    String realFolder = "";         // 웹 애플리케이션상의 절대경로 저장
    ServletContext context = getServletContext(); // context = /var/lib/tomcat7/webapps/ROOT  
    realFolder = context.getRealPath(saveFolder); // realFolder = /var/lib/tomcat7/webapps/ROOT/upload
    int maxSize = 5*1024*1024;      // 업로드될 파일 크기 최대 5Mb
    String encType = "utf-8";       // 인코딩 타입
    MultipartRequest mr = null;

    // 제목, 여백, 내용, 원글, 댓글수준, 댓글순서
    String title = null;
    String empty = "";
    String content = null;
    int rootid = 0;
    int relevel = 0;
    int recnt = 0;
    String filename = null;
    String filepath = null;
    %>
</head>
<body>
    <%
    request.setCharacterEncoding("UTF-8");

    // MultipartRequest 객체 생성(파일업로드 자동 수행)
    mr = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

    // 파라미터 받아오기
    title = mr.getParameter("title");
    title = title.replace("'", "''").replace("<", "&lt").replace(">", "&gt");

    content = mr.getParameter("content");
    
    rootid = Integer.parseInt(mr.getParameter("rootid"));    
    relevel = Integer.parseInt(mr.getParameter("relevel"));
    recnt = Integer.parseInt(mr.getParameter("recnt"));    
    filename = mr.getFilesystemName("file1");
    filepath = realFolder + "/" +mr.getFilesystemName("file1");

    // 댓글순서 체크 : 댓글순서 겹치면 한칸씩 미루기
    sql = "select count(*) from gongji where recnt = "+recnt+";";
    rs = stmt.executeQuery(sql); 
    if(rs.next() && rs.getInt(1) == 1) { 
        sql = "update gongji set recnt = recnt + 1 where recnt >= "+recnt+";";
        stmt.execute(sql);
    }

    // 데이터 insert하기
    if(filename == null) {
        sql = "insert into gongji(date, title, content, rootid, relevel, recnt, viewcnt)\r\n" 
            +"values(now(), '"+title+"', '"+content+"', "+rootid+", "+relevel+", "+recnt+", 0);";
        stmt.execute(sql);
    } else {
        sql = "insert into gongji(date, title, content, rootid, relevel, recnt, viewcnt, filename, filepath)\r\n" 
            +"values(now(), '"+title+"', '"+content+"', "+rootid+", "+relevel+", "+recnt+", 0, '"+filename+"', '"+filepath+"');";
        stmt.execute(sql);
    }
    %>
    

    해당 글이 작성되었습니다.
    <input type=button value='목록' onclick="location.href='gongji_list.jsp'">

    <%
    // CLOSE
    stmt.close();
    conn.close();
    %>
</body>
</html>
