<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.p3.qlba.entities.*"%>
<%@ page import="com.p3.qlba.dao.*"%>
<%@ page import="java.util.*"%>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Chi tiết bệnh án</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/modal.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/patient.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/footer.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/chat-advice.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css"
	rel='stylesheet' type='text/css'>

</head>
<body>
	<header class="navbar navbar-default navbar-fixed-top"
		role="navigation">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
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
			</div>
			<!--/.nav-collapse -->
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
			<div class="col-xs-6 col-md-6">
				<div class="box box-primary">
					<div class="box-header with-border">
						<h3 class="box-title">Chi tiết bệnh án</h3>
					</div>
					<!-- /.box-header -->
					<%
						BenhAn benhAn = (BenhAn) request.getAttribute("benhAn");
						if (benhAn != null) {
					%>
					<div class="box-body">
						<p class="text-muted">
							Bác sĩ:<%
							String tenBacSi = "Bác sĩ hiện không còn công tác";
								int maBacSi = benhAn.getMaNguoiTao();
								BacSiDAO bacSiDAO = new BacSiDAO();
								BacSi bacSi = bacSiDAO.layThongTinBacSi(maBacSi);
								if (bacSi != null) {
						%>
							<%=bacSi.getHoTen()%>
							<%
								} else {
							%>
							<%=tenBacSi%>
							<%
								}
							%>
						</p>

						<p class="text-muted">
							Lĩnh vực:
							<%
							String tenLinhVuc = "Hiện lĩnh vực không còn tồn tại";
								LinhVucKhamChuaDAO linhVucKhamChuaDAO = new LinhVucKhamChuaDAO();
								int maLinhVuc = benhAn.getMaLinhVuc();
								LinhVucKhamChua linhVucKhamChua = linhVucKhamChuaDAO.chiTietLinhVucKhamChua(maLinhVuc);
								if (linhVucKhamChua != null) {
						%>
							<%=linhVucKhamChua.getTenLinhVuc()%>
							<%
								} else {
							%>
							<%=tenLinhVuc%>
							<%
								}
							%>
						</p>
						<p class="text-muted">
							Ngày khám:
							<%=benhAn.getNgayKham()%>
						</p>
						<p class="text-muted">Lý do khám bệnh:
						<p><%=benhAn.getLyDoKham()%></p>
						</p>
						<p class="text-muted">Quá trình bệnh lý:
						<p><%=benhAn.getQuaTrinhBenhLy()%></p>
						</p>
						<p class="text-muted">Tiền sử bệnh:
						<p><%=benhAn.getTienSuLienQuan()%></p>
						</p>
						<p class="text-muted">Hướng điều trị
						<p><%=benhAn.getHuongDieuTri()%></p>
						</p>
						<p class="text-muted">Tóm tắt bệnh án
						<p><%=benhAn.getTomTatBenhAn()%></p>
						</p>
						<p class="text-muted">Khác:
						<p><%=benhAn.getKhac()%></p>
						</p>
						<p class="text-muted">
							Ngày tạo:
							<%=benhAn.getNgayTao()%>
						</p>
					</div>
					<%
						}
					%>
					<!-- /.box-body -->
				</div>
			</div>
			<div class="col-xs-3 col-md-3">
				<div class="box box-primary">
					<div class="box-header with-border">
						<h3 class="box-title">Danh sách chẩn đoán</h3>
					</div>
					<!-- /.box-header -->
					<%
						ArrayList<ChanDoan> ds = (ArrayList<ChanDoan>) request.getAttribute("danhSachChanDoan");
						if (ds != null) {
							for (ChanDoan chanDoan : ds) {
					%>
					<div class="box-body">
						<ul class="ba-list ba-list-in-box">
							<!-- /.item -->
							<li class="item">
								<div class="list-info">
									<p><%=chanDoan.getNgayChanDoan()%>
										<span class="label label-primary pull-right"
											onclick="openTask(event, 'view-chd-<%=chanDoan.getMaChanDoan()%>')"><em
											class="fa fa-book"></em></span>
									</p>
								</div>
							</li>
						</ul>
						<div id="content-pddt" class="well well-sm">
							<div id="view-chd-<%=chanDoan.getMaChanDoan()%>" class="pddt">
								<label>Mã bệnh án:</label>
								<p><%=chanDoan.getMaBenhAn() %></p>
								<label>Ngày chẩn đoán:</label>
								<p><%=chanDoan.getNgayChanDoan() %></p>
								<label>Bệnh chính:</label>
								<p><%=chanDoan.getBenhChinh() %></p>
								<label>Bệnh kèm theo:</label>
								<p><%=chanDoan.getBenhKemTheo() %></p>
								<button type="button" class="btn btn-primary"
									style="float: right;"
									onclick="document.getElementById('view-chd-<%=chanDoan.getMaChanDoan()%>').style.display='none'">
									<em class="fa fa-caret-up"></em>
								</button>
							</div>
						</div>
					</div>
					<%
						}
						}
					%>
					<!-- /.box-body -->

				</div>
			</div>
			<div class="col-xs-3 col-md-3">
				<div class="box box-primary">
					<div class="box-header with-border">
						<h3 class="box-title">Danh sách phác đồ điều trị</h3>
					</div>
					<!-- /.box-header -->
					<%
						ArrayList<PhacDoDieuTri> dS = (ArrayList<PhacDoDieuTri>) request.getAttribute("danhSachPhacDo");
						if (ds != null) {
							for (PhacDoDieuTri phacDo : dS) {
					%>
					<div class="box-body">
						<ul class="ba-list ba-list-in-box">
							<!-- /.item -->
							<li class="item">
								<div class="list-info">
									<p>
										01/11/2017 <span class="label label-primary pull-right"
											onclick="openTask(event, 'view-pddt-<%= phacDo.getMaPhacDo()%>')"><em
											class="fa fa-book"></em></span>
									</p>
								</div>
							</li>

						</ul>
						<div id="content-pddt" class="well well-sm">
							<div id="view-pddt-<%= phacDo.getMaPhacDo()%>" class="pddt">
								<label>Mã bệnh án:</label>
								<p><%=phacDo.getMaBenhAn() %></p>
								<label>Thời gian:</label>
								<p><%=phacDo.getThoiGian() %></p>
								<label>Tiêu đề:</label>
								<p><%=phacDo.getTieuDe() %></p>
								<label>Ngày tạo:</label>
								<p><%=phacDo.getNgayTao() %></p>
								<label>Nội dung:</label>
								<p><%=phacDo.getNoiDung() %></p>
								<button type="button" class="btn btn-primary"
									style="float: right;"
									onclick="document.getElementById('view-pddt-<%= phacDo.getMaPhacDo()%>').style.display='none'">
									<em class="fa fa-caret-up"></em>
								</button>
							</div>
						</div>

					</div>
					<%
						}
						}
					%>
					<!-- /.box-body -->
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
	<script
		src="${pageContext.request.contextPath}/resources/js/tab-report-management.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/pddt-update.js"></script>
</body>
</html>