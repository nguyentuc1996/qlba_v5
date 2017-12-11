<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.p3.qlba.entities.*"%>
<%@ page import="com.p3.qlba.dao.*"%>
<%@ page import="java.util.*"%>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Danh sách bệnh án</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/modal.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/doctor.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/chat-advice.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css" rel='stylesheet' type='text/css'>
    
</head>
<body>
    <header class="navbar navbar-default navbar-fixed-top" role="navigation">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
            </div>
            <div class="navbar-collapse collapse navbar-right">
               <ul class="nav navbar-nav">
                    <li ><a href="${pageContext.request.contextPath}/benhnhan/trang_chu?action=TC">Trang chủ</a></li>
                    <li ><a href="${pageContext.request.contextPath}/benhnhan/trang_chu?action=BCSK">Báo cáo sức khỏe</a></li>
                    <li class="active"><a href="${pageContext.request.contextPath}/benhnhan/trang_chu?action=BA">Bệnh án</a></li>
                    <li><a href="<%=request.getContextPath()%>/tuvan">Tư vấn sức khỏe</a></li>
                    <li class="username dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="hidden-xs">${bn.getTaiKhoan()}</span><b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="<%=request.getContextPath()%>/home/dangxuat">Đăng xuất</a></li>
                            <li><a href="${pageContext.request.contextPath}/benhnhan/doi_mat_khau">Đổi mật khẩu</a></li>
                        </ul>
                    </li>
                </ul>
            </div><!--/.nav-collapse -->
        </div>
    </header>
    <div class="container mtb">
    <!-- 	Thêm chỗ này vào tất cả cái trang khác -->
		<div class="row" style="text-align:center;color:#00BCD4;">
			<h4>
			<% 
			if (session.getAttribute("them_xoa_sua")!=null){
				out.println(session.getAttribute("them_xoa_sua").equals("thanhcong")?"Tác vụ được thực hiện thành công":"Tác vụ thất bại");
			}
			session.removeAttribute("them_xoa_sua");
			%>
			</h4>
		</div>
	
    
		<c:out value="${sessionScope.them_xoa_sua}" />
		<c:remove var="them_xoa_sua" scope="session" />
<!-- 	Thêm chỗ này vào tất cả cái trang khác -->
        <div class="row">
            <div class="col-lg-10 col-lg-offset-1 centered">
                <div class="panel panel-default panel-table">
                    <div class="panel-heading">
                        <div class="row">
                            
                            <div class="col-xs-6 col-md-6">
                                <legend> Danh sách bệnh án</legend>
                            </div>
                          
                           
                            <input type="text" id="search_text" onkeyup="search()" placeholder="Gõ mã bệnh án ...">  
                            
                        </div>
                    </div>
                    <div class="panel-body">
                
                        <table class="table table-striped table-bordered table-list" id="search-table">
                            <thead>
                                <tr>
                                	<th style="text-align: center;" class="hidden-xs">Mã bệnh án</th>
                                    <th  style="text-align: center;" class="hidden-xs">Bác sĩ</th>
                                    <th style="text-align: center;">Tên lĩnh vực</th>
                                    <th style="text-align: center;">Tóm tắt bệnh án</th>
                                    <th style="text-align:center;"></th>
                                </tr> 
                            </thead>
                        
                            <tbody>
                            	<%
                            		ArrayList<BenhAn> dSBA = (ArrayList<BenhAn>) request.getAttribute("danhSachBenhAn");
                            		if(dSBA != null){
                            			for(BenhAn benhAn:dSBA){	
                            		
                            	%>
                                <tr>
                                    <td class="hidden-xs" style="text-align: center;"><%=benhAn.getMaBenhAn() %></td>
                                    <td style="text-align: center;" >
                                    	<%
              
                                    		String tenBacSi="Bác sĩ hiện không còn công tác"; 
                                    		int maBacSi= benhAn.getMaNguoiTao();
                                    		BacSiDAO bacSiDAO= new BacSiDAO();
                                    		BacSi bacSi= bacSiDAO.layThongTinBacSi(maBacSi);
                                    		if(bacSi !=null){
                                    	%>
                                    	<%=benhAn.getMaNguoiTao()+" - "+ bacSi.getHoTen()%>
                                    	<%}else{ %>
                                    	<%= tenBacSi %>
                                    	<%} %>
                                    </td>
                                    <td style="text-align: center;" >
                                    <%
                                    	String tenLinhVuc="Hiện lĩnh vực không còn tồn tại";
                                    	LinhVucKhamChuaDAO linhVucKhamChuaDAO= new LinhVucKhamChuaDAO();
                                    	int maLinhVuc= benhAn.getMaLinhVuc();
                                    	LinhVucKhamChua linhVucKhamChua= linhVucKhamChuaDAO.chiTietLinhVucKhamChua(maLinhVuc);
                                    	if(linhVucKhamChua !=null){
                                    %>
                                    <%=maLinhVuc+" - "+ linhVucKhamChua.getTenLinhVuc() %>
                                    <%} else{%>
                                    <%=tenLinhVuc %>
                                    <%} %>
                                    </td>
                                    <td style="text-align: center;"><%=benhAn.getTomTatBenhAn() %></td>
                                    <td style="text-align:center;">
                                        <a class="btn btn-info" href="${pageContext.request.contextPath}/benhnhan/xem_chi_tiet_benh_an?maBenhAn=<%=benhAn.getMaBenhAn() %>"><em class="fa fa-book"></em></a>
                                    </td>
                                </tr>
                                <%}} %>
                            </tbody>
                        </table>
                    </div>
                    <div class="panel-footer">
                        
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="footerwrap">
	 	<div class="container">
		 	<div class="row">
		 		<div class="col-lg-4">
		 			<h4>Về chúng tôi</h4>
		 			<div class="hline-w"></div>
		 			<p>Trang web quản lý bệnh án điện tử - Đề tài Project 3 đồ án Hệ thống thông tin</p>
		 		</div>
		 		<div class="col-lg-4">
		 			<h4>Liên lạc</h4>
		 			<div class="hline-w"></div>
		 			<p>
		 				<a href="#"><i class="fa fa-dribbble"></i></a>
		 				<a href="#"><i class="fa fa-facebook"></i></a>
		 				<a href="#"><i class="fa fa-twitter"></i></a>
		 				<a href="#"><i class="fa fa-instagram"></i></a>
		 				<a href="#"><i class="fa fa-tumblr"></i></a>
		 			</p>
		 		</div>
		 		<div class="col-lg-4">
		 			<h4>Địa chỉ</h4>
		 			<div class="hline-w"></div>
		 			<p>
		 				Số 1<br/>
		 				Đại Cồ Việt, Hà Nội<br/>
		 				Đại học Bách Khoa Hà Nội<br/>
		 			</p>
		 		</div>
		 	
		 	</div>
	 	</div>
	 </div>
    <script src="${pageContext.request.contextPath}/resources/js/modal-add.js"></script>    
    <script src="${pageContext.request.contextPath}/resources/js/search.js"></script>  
    <script src="${pageContext.request.contextPath}/resources/js/tab-report-management.js"></script>
</body></html>