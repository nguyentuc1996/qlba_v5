<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.p3.qlba.entities.*"%>
<%@ page import="java.util.*"%>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Home admin</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/modal.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/footer.css">
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
					<%-- 					<li ><a href="<%=request.getContextPath() %>/admin/home_admin">Trang chủ</a></li> --%>
					<li><a
						href="<%=request.getContextPath()%>/admin/trang_chu?action=QLLVKC">Quản
							lý lĩnh vực khám chữa</a></li>
					<li class="dropdown"><a class="active" href="#"
						class="dropdown-toggle" data-toggle="dropdown">Quản lý người
							dùng<b class="caret"></b>
					</a>
						<ul class="dropdown-menu">
							<li class="active"><a
								href="<%=request.getContextPath()%>/admin/trang_chu?action=QLBS">Bác
									sĩ</a></li>
							<li><a
								href="<%=request.getContextPath()%>/admin/trang_chu?action=QLBN">Bệnh
									nhân</a></li>
						</ul></li>


					<li class="username dropdown"><a href="#"
						class="dropdown-toggle" data-toggle="dropdown"><span
							class="hidden-xs">Admin</span><b class="caret"></b></a>
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
		<div id="qlba-modal" class="modal">
			<div class="modal-content">
				<div class="modal-header">
					<span class="close" id="close-add">&times;</span>
					<h2>Thêm tài khoản bác sĩ</h2>
				</div>
				<div class="modal-body">
					<form
						action="${pageContext.request.contextPath}/admin/tao_tai_khoan_bac_si"
						method="POST" class="form" role="form">
						<input class="form-control" name="taiKhoan"
							placeholder="Tên tài khoản" type="text" required /> <input
							class="form-control" name="hoTen" placeholder="Họ và tên"
							type="text" required /> <label class="radio-inline"> <input
							type="radio" name="gioiTinh" id="inlineCheckbox1" value="Nam" />
							Nam
						</label> <label class="radio-inline"> <input type="radio"
							name="gioiTinh" id="inlineCheckbox2" value="Nữ" /> Nữ
						</label> </br> </br> <input class="form-control" name="ngaySinh"
							placeholder="Ngày sinh" type="date" required />

						<div class="row">
							<div class="col-xs-6 col-md-6">
								<input class="form-control" name="email"
									placeholder="Địa chỉ email" type="email" required />
							</div>
							<div class="col-xs-6 col-md-6">
								<input class="form-control" name="soDienThoai"
									placeholder="Điện thoại" type="text" required />
							</div>
						</div>
						<input class="form-control" name="quocTich"
							placeholder="Quốc tịch" type="text" required />
						<textarea class="form-control" name="noiOHienTai"
							placeholder="Nơi ở hiện tại" required></textarea>
						<textarea class="form-control" name="queQuan"
							placeholder="Quê quán" required></textarea>
						<input class="form-control" name="soCMND" placeholder="Số CMND"
							type="text" required /> <input class="form-control"
							name="namKinhNghiem" placeholder="Năm kinh nghiệm" type="text"
							required />
						<button class="button button-block" type="submit">Tạo tài
							khoản</button>

					</form>
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
								<legend> Danh sách tài khoản bác sĩ</legend>
							</div>
							<div class="col-xs-6 col-md-6">
								<button id="btn-modal-add" class="button button-block">Tạo
									tài khoản bác sĩ</button>
							</div>

							<input type="text" id="search_text" onkeyup="search()"
								placeholder="Gõ mã bác sĩ để tìm kiếm">

						</div>
					</div>
					<div class="panel-body">

						<table class="table table-striped table-bordered table-list"
							id="search-table">
							<thead>
								<tr>
									<th class="hidden-xs" style="text-align: center;">Mã bác
										sĩ</th>
									<th style="text-align: center;">Tài khoản</th>
									<th style="text-align: center;">Họ và tên</th>
									<th style="text-align: center;"></th>
								</tr>
							</thead>

							<tbody>
								<%
									ArrayList<BacSi> ds = (ArrayList<BacSi>) request.getAttribute("dSBacSi");
									if (ds != null) {
										for (BacSi bacSi : ds) {
								%>
								<tr>
									<td class="hidden-xs" style="text-align: center;"><%=bacSi.getMaBacSi()%></td>
									<td style="text-align: center;"><%=bacSi.getTaiKhoan()%></td>
									<td style="text-align: center;"><%=bacSi.getHoTen()%></td>
									<td style="text-align: center;"><a class="btn btn-danger"
										href="<%=request.getContextPath()%>/admin/xoa_tai_khoan_bac_si?maTaiKhoan=<%=bacSi.getMaBacSi()%>">
											<em class="fa fa-trash"></em>
									</a></td>

									<!--  sua thong tin bac si -->
									<td style="text-align: center;"><a class="btn btn-primary" href="#qlbs_modal_update_<%=bacSi.getMaBacSi() %>" data-toggle="modal" data-backdrop="false"><em class="fa fa-pencil"></em></a>
                                        <div style="text-align:left;" id="qlbs_modal_update_<%=bacSi.getMaBacSi() %>" class="modal fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <span class="close" data-dismiss="modal">&times;</span>
                                                    <h2>Thông tin tài khoản bác sĩ</h2>
                                                </div>
                                                <div class="modal-body">
                                                    <form action="${pageContext.request.contextPath}/admin/sua_thong_tin_bac_si?maBacSi=<%=bacSi.getMaBacSi() %>" method="POST" class="form" role="form">
                                                        <div class="row"> 
                                                            <div class="col-xs-6 col-md-6">
                                                                <label>Tài khoản:</label>
                                                                <input class="form-control" value="<%=bacSi.getTaiKhoan() %>" name="taiKhoan" placeholder="Tên tài khoản" type="text" required autofocus/> 
                                                            </div>
<!--                                                             <div class="col-xs-6 col-md-6"> -->
<!--                                                                 <label>Mật khẩu:</label>  -->
<%--                                                                 <input class="form-control" value="${bs.matKhau}"name="matKhau" placeholder="Mật khẩu" type="text" required /> --%>
<!--                                                             </div> -->
                                                        </div>

                                                        <label>Họ và tên:</label>
                                                        <input class="form-control" value="<%=bacSi.getHoTen() %>" name="hoTen" placeholder="Họ và tên" type="text" required/>
                                                        
                                                        </br>

                                                        <label>Giới tính:</label>
                                                        </br>
                                                        <label class="radio-inline">
                                                            <input type="radio" name="gioiTinh" id="inlineCheckbox1" value="Nam" />
                                                            Nam
                                                        </label>
                                                        <label class="radio-inline">
                                                            <input type="radio" name="gioiTinh" id="inlineCheckbox2" value="Nữ" />
                                                            Nữ
                                                        </label>
                                                        </br>
                                                        </br>

                                                        <label>Ngày sinh:</label>
                                                        <input class="form-control" value="<%=bacSi.getNgaySinh() %>" name="ngaySinh" placeholder="Ngày sinh" type="date" required/>
                                                        
                                                        </br>

                                                        <div class="row">
                                                            <div class="col-xs-6 col-md-6">
                                                                <label>Email</label>
                                                                <input class="form-control" value="<%=bacSi.getEmail() %>" name="email" placeholder="Địa chỉ email" type="email" required/> 
                                                            </div>
                                                            <div class="col-xs-6 col-md-6">
                                                                <label>ĐTDĐ:</label>
                                                                <input class="form-control" value="<%=bacSi.getSoDienThoai() %>" name="soDienThoai" placeholder="Điện thoại" type="text" required /> 
                                                            </div>
                                                        </div>
                                                        </br>

                                                        <label>Quốc tịch:</label>
                                                        <input class="form-control" value="<%=bacSi.getQuocTich() %>" name="quocTich" placeholder="Quốc tịch" type="text" required/>
                                                        
                                                        </br>

                                                        <label>Nơi ở hiện tại:</label>
                                                        <textarea class="form-control"  name="noiOHienTai" placeholder="Nơi ở hiện tại" required><%=bacSi.getNoiOHienTai()%></textarea>
                                                        
                                                        </br>

                                                        <label>Quê quán:</label>
                                                        <textarea class="form-control"  name="queQuan" placeholder="Quê quán" required><%=bacSi.getQueQuan() %></textarea>
                                                        
                                                        </br>

                                                        <label>Số CMND:</label>
                                                        <input class="form-control" value="<%=bacSi.getSoCMND() %>" name="soCMND" placeholder="Số CMND" type="text" required/>
                                                        
                                                        </br>

                                                        <label>Năm kinh nghiệm:</label>
                                                        <input class="form-control" value="<%= bacSi.getNamKinhNghiem()%>" name="namKinhNghiem" placeholder="Năm kinh nghiệm" type="text" required/>
                                                                                            
                                                        
                                                        <button class="button button-block" type="submit">
                                                            Cập nhật mới</button>    

                                                    </form>
                                                </div>
                                                <div class="modal-footer">
                                                
                                                </div>
                                                
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
		src="${pageContext.request.contextPath}/resources/js/modal-add.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/modal-update.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/search.js"></script>
</body>
</html>
