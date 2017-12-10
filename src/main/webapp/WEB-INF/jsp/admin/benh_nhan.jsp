<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.p3.qlba.entities.*"%>
<%@ page import="java.util.*"%>

<html lang="en">
<head>
<meta charset="utf-8">
<title>Quản lý bệnh nhân</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/modal.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin.css">
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
			<div class="navbar navbar-default navbar-fixed-top" role="navigation">
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
							<li><a
								href="<%=request.getContextPath()%>/admin/trang_chu?action=QLLVKC">Quản
									lý lĩnh vực khám chữa</a></li>
							<li class="dropdown active"><a href="#"
								class="dropdown-toggle" data-toggle="dropdown">Quản lý người
									dùng<b class="caret"></b>
							</a>
								<ul class="dropdown-menu">
									<li><a
										href="<%=request.getContextPath()%>/admin/trang_chu?action=QLBS">Bác
											sĩ</a></li>
									<li class="active"><a
										href="<%=request.getContextPath()%>/admin/trang_chu?action=QLBN">Bệnh
											nhân</a></li>
								</ul></li>
							<li class="username dropdown"><a href="#"
								class="dropdown-toggle" data-toggle="dropdown">Admin<b
									class="caret"></b></a>
								<ul class="dropdown-menu">
									<li><a href="<%=request.getContextPath()%>/home/dangxuat">Đăng
											xuất</a></li>
									<li><a href="<%=request.getContextPath()%>/admin/doi_mat_khau">Đổi mật khẩu</a></li>
								</ul></li>
						</ul>
					</div>
					<!--/.nav-collapse -->
				</div>
	</header>

	<div class="container mtb">
		<div class="row">
			<div class="col-lg-10 col-lg-offset-1 centered">
				<div class="panel panel-default panel-table">
					<div class="panel-heading">
						<div class="row">

							<div class="col-xs-6 col-md-6">
								<legend> Danh sách tài khoản bệnh nhân</legend>
							</div>
							<input type="text" id="search_text" onkeyup="search()"
								placeholder="Gõ mã bệnh nhân để tìm kiếm">

						</div>
					</div>
					<div class="panel-body">

						<table class="table table-striped table-bordered table-list"
							id="search-table">
							<thead>
								<tr>
									<th class="hidden-xs" style="text-align: center;">ID</th>
									<th style="text-align: center;">Tài khoản</th>
									<th style="text-align: center;">Họ và tên</th>
									<th style="text-align: center;">Email</th>
									<th style="text-align: center;"></th>
								</tr>
							</thead>
							<tbody>
								<%
									ArrayList<BenhNhan> ds = (ArrayList<BenhNhan>) request.getAttribute("dSBenhNhan");
									if (ds != null) {
										for (BenhNhan benhNhan : ds) {
								%>
								<tr>
									<td class="hidden-xs" style="text-align: center;"><%=benhNhan.getMaBenhNhan()%></td>
									<td style="text-align: center;"><%=benhNhan.getTaiKhoan()%></td>
									<td style="text-align: center;"><%=benhNhan.getHoTen()%></td>
									<td style="text-align: center;"><%=benhNhan.getEmail()%></td>

									<td style="text-align: center;"><a class="btn btn-danger"
										href="<%=request.getContextPath()%>/admin/xoa_tai_khoan_benh_nhan?maTaiKhoan=<%=benhNhan.getMaBenhNhan()%>">
											<em class="fa fa-trash"></em>
									</a></td>


									<td style="text-align: center;"><a class="btn btn-primary"
										href="#qlbn_modal_update_<%=benhNhan.getMaBenhNhan()%>"
										data-toggle="modal" data-backdrop="false"><em
											class="fa fa-pencil"></em></a>
										<div style="text-align: left;"
											id="qlbn_modal_update_<%=benhNhan.getMaBenhNhan()%>"
											class="modal fade" role="dialog"
											aria-labelledby="myModalLabel" aria-hidden="true">
											<div class="modal-content">
												<div class="modal-header">
													<span class="close" data-dismiss="modal">&times;</span>
													<h2>Hồ sơ người dùng bệnh nhân</h2>
												</div>
												<div class="modal-body">
													<div class="box box-primary">

														<!-- /.box-header -->
														<div class="box-body">
															<strong><i class="fa fa-book margin-r-5"></i>Thông
																tin tài khoản</strong>
															<p class="text-muted">
																Tên tài khoản:
																<%=benhNhan.getTaiKhoan()%>
															</p>
															<p class="text-muted">
																Họ và tên:
																<%=benhNhan.getHoTen()%>
															</p>
															<p class="text-muted">
																Giới tính:
																<%=benhNhan.getGioiTinh()%>
															</p>
															<p class="text-muted">
																Ngày sinh:
																<%=benhNhan.getNgaySinh()%>
															</p>

															<hr>

															<strong><i class="fa fa-map-marker margin-r-5"></i>Liên
																lạc</strong>
															<p class="text-muted">
																Quốc tịch:
																<%=benhNhan.getQuocTich()%></p>
															<p class="text-muted">
																Nơi ở hiện tại:
																<%=benhNhan.getNoiOHienTai()%></p>
															<p class="text-muted">
																Quê quán:
																<%=benhNhan.getQueQuan()%></p>
															<p class="text-muted">
																Điện thoại:
																<%=benhNhan.getSoDienThoai()%></p>
															<p class="text-muted">
																Email:
																<%=benhNhan.getEmail()%></p>
															<hr>

															<strong><i class="fa fa-pencil margin-r-5"></i>
																Nghề nghiệp</strong>

															<p class="text-muted">
																Năm kinh nghiệm:
																<%=benhNhan.getNgheNghiep()%></p>

															<hr>

															<strong><i class="fa fa-file-text-o margin-r-5"></i>
																Notes</strong>

															<p>Phòng khám bách khoa hà nội - Phường Hai Bà Trưng</p>
														</div>
														<!-- /.box-body -->
													</div>
												</div>
												<div class="modal-footer"></div>

											</div>
										</div></td>
								</tr>
								<%
									}
									}
								%>
							</tbody>

						</table>
					</div>
					<!-- 					<div class="panel-footer"> -->
					<!-- 						<div class="row"> -->
					<!-- 							<div class="col col-xs-4">Page 1 of 5</div> -->
					<!-- 							<div class="col col-xs-8"> -->
					<!-- 								<ul class="pagination hidden-xs pull-right"> -->
					<!-- 									<li><a href="#">1</a></li> -->
					<!-- 									<li><a href="#">2</a></li> -->
					<!-- 									<li><a href="#">3</a></li> -->
					<!-- 									<li><a href="#">4</a></li> -->
					<!-- 									<li><a href="#">5</a></li> -->
					<!-- 								</ul> -->
					<!-- 								<ul class="pagination visible-xs pull-right"> -->
					<!-- 									<li><a href="#">«</a></li> -->
					<!-- 									<li><a href="#">»</a></li> -->
					<!-- 								</ul> -->
					<!-- 							</div> -->
					<!-- 						</div> -->


					<!-- 					</div> -->
				</div>
			</div>
		</div>
	</div>
	<script src="${pageContext.request.contextPath}/resources/js/search.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/modal-update.js"></script>
</body>
</html>
