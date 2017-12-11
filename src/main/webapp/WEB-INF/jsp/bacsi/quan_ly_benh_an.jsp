<!DOCTYPE html>
<%@page import="com.p3.qlba.dao.LinhVucKhamChuaDAO"%>
<%@page import="com.p3.qlba.dao.BenhNhanDAO"%>
<%@page import="com.p3.qlba.dao.BenhAnDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.p3.qlba.entities.*"%>
<%@ page import="java.util.*"%>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Bệnh án bệnh nhân</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/header.css">
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
                    <li class="active"><a href="<%=request.getContextPath()%>/bacsi/home_bac_si">Trang chủ</a></li>
                    <li ><a href="<%=request.getContextPath()%>/bacsi/trang_chu?action=BA">Bệnh án</a></li>
                    <li ><a href="<%=request.getContextPath()%>/bacsi/trang_chu?action=QLCC">Quản lý chứng chỉ</a></li>
                    <li><a href="<%=request.getContextPath()%>/tuvan">Tư vấn sức khỏe</a></li>
                    <li class="username dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="hidden-xs">${bs.getTaiKhoan()}</span><b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="<%=request.getContextPath()%>/home/dangxuat">Đăng xuất</a></li>
                            <li><a href="<%=request.getContextPath()%>/bacsi/doi_mat_khau">Đổi mật khẩu</a></li>
                        </ul>
                    </li>
                </ul>
			</div>
			<!--/.nav-collapse -->
		</div>
	</header>
	<div class="container mtb">
		<div id="qlba-modal" class="modal">
			<div class="modal-content">
				<div class="modal-header">
					<span class="close" id="close-add">&times;</span>
					<h2>Thêm bệnh án</h2>
				</div>
				<div class="modal-body">
					<div class="tab">
						<button class="tablinks" onclick="openTab(event, 'benhAn')"
							id="defaultOpen">Bệnh án</button>
						<button class="tablinks" onclick="openTab(event, 'chanDoan')">Chẩn
							đoán bệnh</button>
						<button class="tablinks" onclick="openTab(event, 'phapDo')">Phác
							đồ điều trị</button>
					</div>

					<div id="benhAn" class="tabcontent">
						<form action="<%=request.getContextPath()%>/bacsi/them_benh_an"
							method="POST" class="form" role="form">
							<div class="row">

								<div class="col-xs-6 col-md-6">
									<label>Mã bệnh nhân:</label> <select class="form-control"
										name="maBenhNhan">
										<%
											ArrayList<BenhNhan> dsBN= (ArrayList<BenhNhan>) request.getAttribute("danhSachBenhNhan");
											if(dsBN != null){
												for(BenhNhan benhNhan:dsBN){	
											
										%>
									                <option value="<%=benhNhan.getMaBenhNhan()%>">BN:<%=benhNhan.getMaBenhNhan()%> - <%=benhNhan.getHoTen() %></option>
									     <%}} %>
									     </select>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-6 col-md-6">
									<label>Mã lĩnh vực:</label> <select class="form-control"
										name="maLinhVuc">
										<%
											ArrayList<LinhVucKhamChua> lv = (ArrayList<LinhVucKhamChua>) request.getAttribute("linhVucKhamChua");
											if (lv != null) {
												for (LinhVucKhamChua lvkc : lv) {
										%>
										<option value="<%=lvkc.getMaLinhVuc()%>"><%=lvkc.getTenLinhVuc()%></option>
										<%
											}
											}
										%>
									</select>
								</div>
								<div class="col-xs-6 col-md-6">
									<label>Ngày khám:</label> <input class="form-control"
										name="ngayKham" placeholder="Ngày khám bệnh" type="date"
										required />
								</div>
							</div>
							<label>Lý do khám bệnh:</label>
							<textarea class="form-control" name="lyDoKham"
								placeholder="Lý do khám bệnh" required></textarea>

							</br> <label>Quá trình bệnh lý:</label>
							<textarea class="form-control" name="quaTrinhBenhLy"
								placeholder="Quá trình bệnh lý" required></textarea>

							</br> <label>Tiền sử bệnh:</label>
							<textarea class="form-control" name="tieuSuLienQuan"
								placeholder="Tiền sử bệnh" required></textarea>

							</br> <label>Hướng điều trị:</label>
							<textarea class="form-control" name="huongDieuTri"
								placeholder="Hướng điều trị" required></textarea>

							</br> <label>Tóm tắt bệnh án:</label>
							<textarea class="form-control" name="tomTatBenhAn"
								placeholder="Tóm tắt bệnh án" required></textarea>

							</br> <label>Khác:</label>
							<textarea class="form-control" name="khac" placeholder="Khác"></textarea>
							<label>Ngày tạo:</label> <input class="form-control"
								name="ngayTao" placeholder="Ngày tạo bệnh án" type="date"
								required /> </br>
							<button class="button button-block" type="submit">Thêm
								bệnh án</button>

						</form>
					</div>

					<div id="chanDoan" class="tabcontent">
						<form
							action="${pageContext.request.contextPath}/bacsi/viet_chan_doan"
							method="POST" class="form" role="form">
							<div class="row">
								<div class="col-xs-6 col-md-6">
									<label>Bệnh án:</label>
									<%
										ArrayList<BenhAn> danhSachBenhAn = (ArrayList<BenhAn>) request.getAttribute("danhSachBenhAn");
									%>
									<select class="form-control" name="maBenhAn">
										<%
											if (danhSachBenhAn != null) {
												for (BenhAn benhAn : danhSachBenhAn) {
										%>
										<option value="<%=benhAn.getMaBenhAn()%>">Mã BA:
											<%=benhAn.getMaBenhAn()%></option>
										<%
											}
											}
										%>
									</select>
								</div>
								<div class="col-xs-6 col-md-6">
									<label>Ngày chẩn đoán:</label> <input class="form-control"
										name="ngayChanDoan" placeholder="Ngày chẩn đoán" type="date"
										required />
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

					<div id="phapDo" class="tabcontent">
						<form
							action="${pageContext.request.contextPath}/bacsi/viet_phac_do"
							method="POST" class="form" role="form">
							<div class="row">
								<div class="col-xs-6 col-md-6">
									<label>Bệnh án:</label>
									<%
										//                                         ArrayList<BenhAn> danhSachBenhAn = (ArrayList<BenhAn>) request.getAttribute("danhSachBenhAn");
									%>
									<select class="form-control" name="maBenhAn">
										<%
											if (danhSachBenhAn != null) {
												for (BenhAn benhAn : danhSachBenhAn) {
										%>
										<option value="<%=benhAn.getMaBenhAn()%>">Mã BA:
											<%=benhAn.getMaBenhAn()%></option>
										<%
											}
											}
										%>
									</select>
								</div>
								<div class="col-xs-6 col-md-6">
									<label>Thời gian:</label> <input class="form-control"
										name="thoiGian" placeholder="Ngày chẩn đoán" type="date"
										required />
								</div>
							</div>
							<div class="row">
								<div class="col-xs-6 col-md-6">
									<label>Tiêu đề:</label> <input class="form-control"
										name="tieuDe" placeholder="Tiêu đề" type="text">
								</div>
								<div class="col-xs-6 col-md-6">
									<label>Ngày tạo:</label> <input class="form-control"
										name="ngayTao" placeholder="Ngày tạo phác đồ" type="date"
										required />
								</div>
							</div>
							<label>Nội dung:</label>
							<textarea class="form-control" name="noiDung"
								placeholder="Nội dung phác đồ"></textarea>
							</br>
							<button class="button button-block" type="submit">Tạo
								phác đồ điều trị</button>

						</form>
					</div>


				</div>
				<div class="modal-footer"></div>
			</div>
		</div>
		<div class="row">
			<div class="col-lg-10 col-lg-offset-1 centered">
				<div class="panel panel-default panel-table">
					<div class="panel-heading">
						<div class="row">

							<div class="col-xs-6 col-md-6">
								<legend> Danh sách bệnh án quản lý</legend>
							</div>
							<div class="col-xs-6 col-md-6">
								<button id="btn-modal-add" class="button button-block">Thêm
									mới bệnh án</button>
							</div>

							<input type="text" id="search_text" onkeyup="search()"
								placeholder="Gõ mã bệnh án ...">

						</div>
					</div>
					<div class="panel-body">

						<table class="table table-striped table-bordered table-list"
							id="search-table">
							<thead>
								<tr>
									<th style="text-align: center;" class="hidden-xs">Bệnh
										nhân</th>
									<th style="text-align: center;">Bệnh án</th>
									<th style="text-align: center;">Lĩnh vực</th>
									<th style="text-align: center;">Tóm tắt bệnh án</th>
									<th style="text-align: center;"></th>
								</tr>
							</thead>

							<tbody>

								<%
									ArrayList<BenhAn> ds = (ArrayList<BenhAn>) request.getAttribute("danhSachBenhAn");
									if (ds != null) {
										for (BenhAn benhAn : ds) {
								%>
								<tr>
									<td style="text-align: center;">
									<%
										String tenBenhNhan = "Bệnh nhân";
										int maBenhNhan = benhAn.getMaBenhNhan();
										BenhNhanDAO benhNhanDAO = new BenhNhanDAO();
										BenhNhan benhNhan = benhNhanDAO.layThongTinBenhNhan(maBenhNhan);
										if (benhNhan != null) {
									%> 
									<%=maBenhNhan%> - <%=benhNhan.getHoTen()%> 								
									<%} else {%>
 									<%=tenBenhNhan%> 
 									<%}%>
									</td>
									<td style="text-align: center;">
									<%=benhAn.getMaBenhAn()%>
									</td>
									<td style="text-align: center;">
									<%
							            String tenLinhVuc = "Hiện lĩnh vực không còn tồn tại";
										LinhVucKhamChuaDAO linhVucKhamChuaDAO = new LinhVucKhamChuaDAO();
										int maLinhVuc = benhAn.getMaLinhVuc();
										LinhVucKhamChua linhVucKhamChua = linhVucKhamChuaDAO.chiTietLinhVucKhamChua(maLinhVuc);
										if (linhVucKhamChua != null) {
									%>
									<%= maLinhVuc %> - <%=linhVucKhamChua.getTenLinhVuc()%>
									<%
										} else {
									%>
									<%=tenLinhVuc%>
									<%
										}
									%>
									</td>
									
									<td style="text-align: center;"><%=benhAn.getTomTatBenhAn()%></td>
									<td style="text-align: center;"><a class="btn btn-danger"
										href="<%=request.getContextPath()%>/bacsi/xoa_benh_an?id=<%=benhAn.getMaBenhAn()%>"><em
											class="fa fa-trash"></em></a> </td>
											<td style="text-align: center;"><a class="btn btn-info"
										href="<%=request.getContextPath()%>/bacsi/lay_thong_tin_benh_an?id=<%=benhAn.getMaBenhAn()%>"><em
											class="fa fa-book"></em></a></td>
								</tr>
								<%
									}
									}
								%>
							</tbody>
						</table>
					</div>
					<div class="panel-footer"></div>
				</div>
			</div>
		</div>
	</div>
	<script
		src="${pageContext.request.contextPath}/resources/js/modal-add.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/search.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/tab-report-management.js"></script>
</body>
</html>