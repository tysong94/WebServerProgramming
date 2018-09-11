<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.*, java.util.*, java.sql.*, javax.sql.*, java.net.*" %>

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

    // 파일 업로드 변수
    request.setCharacterEncoding("utf-8");
    String saveFolder = "/upload";  // 파일 업로드할 폴더 지정. 이미지 출력에 필요
    String realFolder = "";         // 웹 애플리케이션상의 절대경로 저장
    int maxSize = 5*1024*1024;      // 업로드될 파일 크기 최대 5Mb
    String encType = "utf-8";       // 인코딩 타입

    MultipartRequest mr = null;

    // 파라미터 변수
    String p_id = null;         //상품번호
    String p_name = null;       //상품명
    int p_count = 0;            //재고
    String p_details = null;    //상품설명
    String p_photos_addr = null;     //사진 경로
    String p_photos_name = null;     //사진 이름
    %>
</head>
<body>
    <%
    // 파일 업로드 경로 구하기
    ServletContext context = getServletContext(); // context = /var/lib/tomcat7/webapps/ROOT  
    realFolder = context.getRealPath(saveFolder); // realFolder = /var/lib/tomcat7/webapps/ROOT/upload
    //out.println(realFolder);
    // 파일 업로드를 수행하는 MultipartRequest 객체 생성
    mr = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
    
    // 파라미터 받아오기
    p_id = mr.getParameter("id");
    p_name = mr.getParameter("name");
    p_count = Integer.parseInt(mr.getParameter("count"));
    p_details = mr.getParameter("details");
    p_photos_addr = realFolder + "/" +mr.getFilesystemName("photos");
    p_photos_name = mr.getFilesystemName("photos");

    // 중복체크
    sql = "select count(*) from inventory where id = '"+p_id+"';";
    rs = stmt.executeQuery(sql);
    rs.next(); 
    if(rs.getInt(1) == 1) {
        %><script>alert("상품번호가 중복됩니다."); history.back();</script><%
    } else {
    // 데이터 insert하기
    sql = "insert into inventory(id, name, count, prdate, irdate, details, photos_addr, photos_name) values('"+p_id+"', '"+p_name+"', "+p_count+", now(), now(), '"+p_details+"', '"+p_photos_addr+"', '"+p_photos_name+"');";
    //out.println(sql);
    stmt.execute(sql);

    out.println("해당 상품이 등록되었습니다.");
    out.println("<input type=button value='목록' onclick=\"location.href='inventory_list.jsp?'\">");
    }
    %>

    <%
    // CLOSE
    stmt.close();
    conn.close();
    %>
    
</body>
</html>
