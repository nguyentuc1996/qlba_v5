<!DOCTYPE html>
<%@page import="com.p3.qlba.dao.LinhVucKhamChuaDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.p3.qlba.entities.*"%>
<%@ page import="java.util.*"%>
<html lang="en">
<head>
<% String thongBao= (String)request.getAttribute("result");
	if(thongBao != null){
%>
	<script type="text/javascript">
  		alert(thongBao); 
	</script>
<%} %>

<meta charset="utf-8">
<title>Chi tiết bệnh án</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/footer.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/modal.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/doctor.css">
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
					<li><a href="<%=request.getContextPath()%>/bacsi/home_bac_si">Trang
							chủ</a></li>
					<li class="active"><a
						href="<%=request.getContextPath()%>/bacsi/trang_chu?action=BA">Bệnh
							án</a></li>
					<li><a
						href="<%=request.getContextPath()%>/bacsi/trang_chu?action=QLCC">Quản
							lý chứng chỉ</a></li>
					<li><a href="<%=request.getContextPath()%>/tuvan">Tư vấn
							sức khỏe</a></li>
					<li class="username dropdown"><a href="#"
						class="dropdown-toggle" data-toggle="dropdown"><span
							class="hidden-xs">${bs.getTaiKhoan()}</span><b class="caret"></b></a>
						<ul class="dropdown-menu">
							<li><a href="<%=request.getContextPath()%>/home/dangxuat">Đăng
									xuất</a></li>
							<li><a
								href="<%=request.getContextPath()%>/bacsi/doi_mat_khau">Đổi
									mật khẩu</a></li>
						</ul></li>
				</ul>
			</div>
			<!--/.nav-collapse -->
		</div>
	</header>

	<%
		BenhNhan benhNhan = (BenhNhan) request.getAttribute("benhNhan");
	%>

	<%
		BenhAn benhAn = (BenhAn) request.getAttribute("benhAn");
	%>
	<div class="container mtb">
		<div id="qlba_modal_update" class="modal">
			<div class="modal-content">
				<div class="modal-header">
					<span class="close" id="close-update">&times;</span>
					<h2>Sửa bệnh án</h2>
				</div>
				<div class="modal-body">
					<%
						if (benhAn != null) {
					%>

					<form
						action="<%=request.getContextPath()%>/bacsi/sua_benh_an?maBenhAn=<%=benhAn.getMaBenhAn()%>"
						method="POST" class="form" role="form">
						<div class="row">

							<div class="col-xs-6 col-md-6">
								<label>Mã bệnh nhân:</label> <input class="form-control"
									name="maBenhNhan" value="<%=benhAn.getMaBenhNhan()%>" disabled />
							</div>
						</div>
						<div class="row">
							<div class="col-xs-6 col-md-6">
								<label>Lĩnh vực:</label>
								<%
									String tenLinhVuc = "Lĩnh vực đã xóa";
										LinhVucKhamChuaDAO linhVucKhamChuaDAO = new LinhVucKhamChuaDAO();
										LinhVucKhamChua linhVucKhamChua = linhVucKhamChuaDAO.chiTietLinhVucKhamChua(benhAn.getMaLinhVuc());
										if (linhVucKhamChua != null) {
											tenLinhVuc = linhVucKhamChua.getTenLinhVuc();
										}
								%>
								<input class="form-control" name="maBenhNhan"
									value="<%=tenLinhVuc%>" disabled />

							</div>

							<div class="col-xs-6 col-md-6">
								<label>Ngày khám:</label> <input class="form-control"
									name="ngayKham" value="<%=benhAn.getNgayKham()%>"
									placeholder="Ngày khám bệnh" type="date" />
							</div>
						</div>
						<label>Lý do khám bệnh:</label>
						<textarea class="form-control" name="lyDoKham" required><%=benhAn.getLyDoKham()%></textarea>

						<label>Quá trình bệnh lý:</label>
						<textarea class="form-control" name="quaTrinhBenhLy" required><%=benhAn.getQuaTrinhBenhLy()%></textarea>

						<label>Tiền sử bệnh:</label>
						<textarea class="form-control" name="tienSuLienQuan" required><%=benhAn.getTienSuLienQuan()%></textarea>

						<label>Hướng điều trị:</label>
						<textarea class="form-control" name="huongDieuTri" required><%=benhAn.getHuongDieuTri()%></textarea>

						</br> <label>Tóm tắt bệnh án:</label>
						<textarea class="form-control" name="tomTatBenhAn" required><%=benhAn.getTomTatBenhAn()%></textarea>

						</br> <label>Khác:</label>
						<textarea class="form-control" name="khac"><%=benhAn.getKhac()%></textarea>

						</br>
						<button class="button button-block" type="submit">Sửa
							bệnh án</button>

					</form>

					<%
						}
					%>



				</div>
				<div class="modal-footer"></div>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<div class="box box-primary">
					<div class="box-header with-border">
						<h3 class="box-title">Chi tiết bệnh án</h3>
					</div>
					<!-- /.box-header -->
					<div class="box-body">
						<p class="text-muted">
							Bệnh nhân:
							<%
							String benhNhanText = benhAn.getMaBenhNhan() + " - " + benhNhan.getHoTen();
						%>
							<%=benhNhanText%>
						</p>
						<p class="text-muted">
							Mã lĩnh vực:
							<%=benhAn.getMaLinhVuc()%>
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
						<button class="button button-block" id="btn-modal-update">Sửa
							bệnh án</button>
					</div>
					<!-- /.box-body -->
				</div>
			</div>
			<div class="col-xs-3 col-md-3">
				<div class="box box-primary">
					<div class="box-header with-border">
						<div class="row">
							<div class="col-xs-9 col-md-9">
								<h3 style="text-align: center;" class="box-title">Danh sách
									chẩn đoán</h3>
							</div>
							<div class="col-xs-3 col-md-3">
								<button type="button" class="btn btn-primary box-title"
									style="float: right;" data-backdrop="false" data-toggle="modal"
									href="#add-chd">
									<em class="fa fa-plus"></em>
								</button>
								<div style="text-align: left;" id="add-chd" class="modal fade"
									role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

									<div class="modal-content">
										<div class="modal-header">
											<span class="close" data-dismiss="modal">&times;</span>
											<h2>Thêm chẩn đoán</h2>
										</div>

										<div class="modal-body">
											<form
												action="${pageContext.request.contextPath}/bacsi/viet_chan_doan?maBenhAn=<%=benhAn.getMaBenhAn() %>"
												method="POST" class="form" role="form">
												<div class="row">
													<!-- 															<div class="col-xs-6 col-md-6"> -->
													<!-- 																<label>Bệnh án:</label> -->
													<%-- 																<input class="form-control" type="text" name="maBenhAn" value="<%=benhAn.getMaBenhAn() %>" /> --%>
													<!-- 															</div> -->
													<div class="col-xs-6 col-md-6">
														<label>Ngày chẩn đoán:</label> <input class="form-control"
															name="ngayChanDoan" placeholder="Ngày chẩn đoán"
															type="date" required />
													</div>
												</div>
												<label>Bệnh chính</label>
												<textarea class="form-control" name="benhChinh"
													placeholder="Bệnh chính"></textarea>
												<label>Bệnh kèm theo</label>
												<textarea class="form-control" name="benhKemTheo"
													placeholder="Bệnh kèm theo"></textarea>
												<button class="button button-block" type="submit">Viết
													chẩn đoán</button>

											</form>
										</div>

										<div class="modal-footer"></div>


									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- /.box-header -->
					<%
						ArrayList<ChanDoan> danhSachChanDoan = (ArrayList<ChanDoan>) request.getAttribute("chanDoan");
						if (danhSachChanDoan != null) {
							for (ChanDoan chanDoan : danhSachChanDoan) {
					%>
					<div class="box-body">
						<ul class="ba-list ba-list-in-box">
							<!-- /.item -->
							<li class="item">
								<div class="list-info">
									<p><%=chanDoan.getNgayChanDoan()%>
										<span class="label label-danger pull-right"> <a
											href="${pageContext.request.contextPath}/bacsi/xoa_chan_doan?maChanDoan=<%=chanDoan.getMaChanDoan() %>"><em
												class="fa fa-trash"></em></a></span> <span
											class="label label-info pull-right"
											onclick="openTask(event, 'update-chd-<%=chanDoan.getMaChanDoan()%>')"><em
											class="fa fa-pencil"></em></span> <span
											class="label label-primary pull-right"
											onclick="openTask(event, 'view-chd-<%=chanDoan.getMaChanDoan()%>')"><em
											class="fa fa-book"></em></span>
									</p>
								</div>
							</li>


						</ul>
						<div id="content-pddt" class="well well-sm">
							<div id="update-chd-<%=chanDoan.getMaChanDoan()%>" class="pddt">
								<form
									action="${pageContext.request.contextPath}/bacsi/sua_chan_doan?maChanDoan=<%=chanDoan.getMaChanDoan() %>"
									method="POST" class="form" role="form">
									<label>Bệnh án:</label> <input class="form-control"
										name="maBenhAn" type="text"
										value="BA <%=chanDoan.getMaBenhAn()%>" placeholder="BA0001"
										disabled /> <label>Ngày chẩn đoán:</label> <input
										class="form-control" value="<%=chanDoan.getNgayChanDoan()%>"
										name="ngayChanDoan" placeholder="Ngày chẩn đoán" type="date"
										required disabled /> <label>Bệnh chính</label>
									<textarea class="form-control" name="benhChinh"
										placeholder="Bệnh chính"><%=chanDoan.getBenhChinh()%></textarea>
									<label>Bệnh kèm theo</label>
									<textarea class="form-control" name="benhKemTheo"
										placeholder="Bệnh kèm theo"><%=chanDoan.getBenhKemTheo()%></textarea>
									<button class="btn btn-primary" type="submit">Sửa</button>
									<button type="button" class="btn btn-primary"
										style="float: right;"
										onclick="document.getElementById('update-chd-<%=chanDoan.getMaChanDoan()%>').style.display='none'">
										<em class="fa fa-caret-up"></em>
									</button>
								</form>
							</div>
							<div id="view-chd-<%=chanDoan.getMaChanDoan()%>" class="pddt">
								<label>Mã bệnh án:</label>
								<p><%=chanDoan.getMaBenhAn()%></p>
								<label>Ngày chẩn đoán:</label>
								<p><%=chanDoan.getNgayChanDoan()%></p>
								<label>Bệnh chính:</label>
								<p><%=chanDoan.getBenhChinh()%></p>
								<label>Bệnh kèm theo:</label>
								<p><%=chanDoan.getBenhKemTheo()%></p>
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
			<!-- /.box-body -->


			<div class="col-xs-3 col-md-3">
				<div class="box box-primary">
					<div class="box-header with-border">
						<div class="row">
							<div class="col-xs-9 col-md-9">
								<h3 style="text-align: center;" class="box-title">Danh sách
									phác đồ điều trị</h3>
							</div>
							<div class="col-xs-3 col-md-3">
								<button type="button" class="btn btn-primary box-title"
									style="float: right;" data-toggle="modal" data-backdrop="false"
									href="#add-pddt">
									<em class="fa fa-plus"></em>
								</button>
								<div style="text-align: left;" id="add-pddt" class="modal fade"
									role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

									<div class="modal-content">
										<div class="modal-header">
											<span class="close" data-dismiss="modal">&times;</span>
											<h2>Thêm pháp đồ điều trị</h2>
										</div>

										<div class="modal-body">
											<form
												action="${pageContext.request.contextPath}/bacsi/viet_phac_do?maBenhAn=<%=benhAn.getMaBenhAn() %>"
												method="POST" class="form" role="form">
												<div class="row">
													<!-- 															<div class="col-xs-6 col-md-6"> -->
													<!-- 																<label>Bệnh án:</label> -->
													<%-- 																<input class="form-control" name="maBenhAn" type="text" value="<%=benhAn.getMaBenhAn()%>" /> --%>
													<!-- 															</div> -->
													<div class="col-xs-6 col-md-6">
														<label>Thời gian:</label> <input class="form-control"
															name="thoiGian" placeholder="Ngày chẩn đoán" type="date"
															required />
													</div>
													<!-- 															<div class="col-xs-6 col-md-6"> -->
													<!-- 																<label>Ngày tạo:</label> <input class="form-control" -->
													<!-- 																	name="ngayTao" placeholder="Ngày tạo phác đồ" type="date" -->
													<!-- 																	required /> -->
													<!-- 															</div> -->
												</div>
												<!-- 														<div class="row"> -->
												<!-- 															<div class="col-xs-6 col-md-6"> -->
												<label>Tiêu đề:</label> <input class="form-control"
													name="tieuDe" placeholder="Tiêu đề" type="text">
												<!-- 															</div> -->

												<!-- 														</div> -->
												<label>Nội dung:</label>
												<textarea class="form-control" name="noiDung"
													placeholder="Nội dung phác đồ"></textarea>
												</br>
												<button class="button button-block" type="submit">Tạo
													phác đồ điều trị</button>

											</form>
										</div>

										<div class="modal-footer"></div>


									</div>
								</div>
							</div>
						</div>
						<!-- /.box-header -->
						<%
							ArrayList<PhacDoDieuTri> danhSachPhacDo = (ArrayList<PhacDoDieuTri>) request.getAttribute("phacDo");
							if (danhSachPhacDo != null) {
								for (PhacDoDieuTri phacDoDieuTri : danhSachPhacDo) {
						%>

						<div class="box-body">
							<ul class="ba-list ba-list-in-box">
								<!-- /.item -->
								<li class="item">
									<div class="list-info">
										<p><%=phacDoDieuTri.getNgayTao()%>
											<span class="label label-danger pull-right"> <a
												href="<%=request.getContextPath()%>/bacsi/xoa_phac_do?maPhacDo=<%=phacDoDieuTri.getMaPhacDo()%>">
													<em class="fa fa-trash"></em>
											</a></span> <span class="label label-info pull-right"
												onclick="openTask(event, 'update-pddt-<%=phacDoDieuTri.getMaPhacDo()%>')"><em
												class="fa fa-pencil"></em></span> <span
												class="label label-primary pull-right"
												onclick="openTask(event, 'view-pddt-<%=phacDoDieuTri.getMaPhacDo()%>')"><em
												class="fa fa-book"></em></span>
										</p>
									</div>
								</li>

							</ul>
							<div id="content-pddt" class="well well-sm">
								<div id="update-pddt-<%=phacDoDieuTri.getMaPhacDo()%>"
									class="pddt">
									<form
										action="<%=request.getContextPath()%>/bacsi/sua_phac_do?maPhacDo=<%=phacDoDieuTri.getMaPhacDo()%>"
										method="POST" class="form" role="form">
										<label>Mã bệnh án:</label> <input class="form-control"
											name="maBenhAn" type="text"
											value="<%=phacDoDieuTri.getMaBenhAn()%>" disabled></input> <label>Thời
											gian:</label> <input class="form-control" name="thoiGian"
											value="<%=phacDoDieuTri.getThoiGian()%>"
											placeholder="Ngày chẩn đoán" type="date" required /> <label>Tiêu
											đề:</label> <input class="form-control"
											value="<%=phacDoDieuTri.getTieuDe()%>" name="tieuDe"
											placeholder="Tiêu đề" type="text"> <label>Ngày
											tạo:</label> <input class="form-control"
											value="<%=phacDoDieuTri.getNgayTao()%>" name="ngayTao"
											placeholder="Ngày tạo phác đồ" type="date" required /> <label>Nội
											dung:</label>
										<textarea class="form-control" name="noiDung"
											placeholder="Nội dung phác đồ"><%=phacDoDieuTri.getNoiDung()%></textarea>

										</br> </br>
										<button class="btn btn-primary" type="submit">Sửa</button>
										<button type="button" class="btn btn-primary"
											style="float: right;"
											onclick="document.getElementById('update-pddt-<%=phacDoDieuTri.getMaPhacDo()%>').style.display='none'">
											<em class="fa fa-caret-up"></em>
										</button>
									</form>
								</div>
								<div id="view-pddt-<%=phacDoDieuTri.getMaPhacDo()%>"
									class="pddt">
									<label>Mã bệnh án:</label>
									<p><%=phacDoDieuTri.getMaBenhAn()%></p>
									<label>Thời gian:</label>
									<p><%=phacDoDieuTri.getThoiGian()%></p>
									<label>Tiêu đề:</label>
									<p><%=phacDoDieuTri.getTieuDe()%></p>
									<label>Ngày tạo:</label>
									<p><%=phacDoDieuTri.getNgayTao()%></p>
									<label>Nội dung:</label>
									<p><%=phacDoDieuTri.getNoiDung()%></p>
									<button type="button" class="btn btn-primary"
										style="float: right;"
										onclick="document.getElementById('view-pddt-<%=phacDoDieuTri.getMaPhacDo()%>').style.display='none'">
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
	</div>
	<div id="footerwrap">
		<div class="container">
			<div class="row">
				<div class="col-lg-4">
					<h4>Về chúng tôi</h4>
					<div class="hline-w"></div>
					<p>Trang web quản lý bệnh án điện tử - Đề tài Project 3 đồ án
						Hệ thống thông tin</p>
				</div>
				<div class="col-lg-4">
					<h4>Liên lạc</h4>
					<div class="hline-w"></div>
					<p>
						<a href="#"><i class="fa fa-dribbble"></i></a> <a href="#"><i
							class="fa fa-facebook"></i></a> <a href="#"><i
							class="fa fa-twitter"></i></a> <a href="#"><i
							class="fa fa-instagram"></i></a> <a href="#"><i
							class="fa fa-tumblr"></i></a>
					</p>
				</div>
				<div class="col-lg-4">
					<h4>Địa chỉ</h4>
					<div class="hline-w"></div>
					<p>
						Số 1<br /> Đại Cồ Việt, Hà Nội<br /> Đại học Bách Khoa Hà Nội<br />
					</p>
				</div>

			</div>
		</div>
	</div>
	<script
		src="${pageContext.request.contextPath}/resources/js/pddt-update.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/modal-update.js"></script>

</body>
</html>
