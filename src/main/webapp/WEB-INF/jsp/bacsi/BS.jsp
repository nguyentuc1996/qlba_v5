<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Trang chủ bác sĩ</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/modal.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/doctor.css">
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
            </div><!--/.nav-collapse -->
        </div>
    </header>
    <div class="container mtb">
        <div class="row">
            <div class="col-xs-3 col-md-3">
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <h3 class="box-title">Thông tin cá nhân</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <strong><i class="fa fa-book margin-r-5"></i>&nbsp;Thông tin tài khoản</strong>
                        <p class="text-muted">
                            Tên tài khoản: ${bs.taiKhoan}
                        </p>
                        <p class="text-muted">
                            Họ và tên: ${bs.hoTen}
                        </p>
                        <p class="text-muted">
                            Giới tính: ${bs.gioiTinh}
                        </p>
                        <p class="text-muted">
                            Ngày sinh: ${bs.ngaySinh}
                        </p>

                        <hr>

                        <strong><i class="fa fa-map-marker margin-r-5"></i>&nbsp;Liên lạc</strong>
                        <p class="text-muted">Quốc tịch: ${bs.quocTich}</p>
                        <p class="text-muted">Nơi ở hiện tại: ${bs.noiOHienTai}</p>
                        <p class="text-muted">Quê quán: ${bs.queQuan}</p>
                        <p class="text-muted">Điện thoại: ${bs.soDienThoai}</p>
                        <p class="text-muted">Email: ${bs.email}</p>
                        <hr>

                        <strong><i class="fa fa-pencil margin-r-5"></i>&nbsp;Kinh nghiệm</strong>

                        <p class="text-muted">Năm kinh nghiệm: ${bs.namKinhNghiem}</p>

                        <hr>

                        <strong><i class="fa fa-file-text-o margin-r-5"></i>&nbsp;BK HUST</strong>

                        <p>Phòng khám đa khoa Hà Nội.</p>
                        <p>Số 1 Đại Cồ Việt.</p>
                    </div>
                    <!-- /.box-body -->
                </div>
            </div>
            <div class="col-xs-8 col-md-8">
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <h3 class="box-title">Cập nhật tài khoản</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <form action="${pageContext.request.contextPath}/bacsi/sua_thong_tin_bac_si" method="POST" class="form" role="form">
                            <div class="row">
                            <div class="col-xs-6 col-md-6">
                                    <label>Tài khoản:</label>
                                    <input class="form-control" value="${bs.taiKhoan}" name="taiKhoan" placeholder="Tên tài khoản" type="text" required autofocus/>
                                </div>
                            	<div class="col-xs-6 col-md-6">
<!--                                     <label>Id:</label> -->
                                    <input class="form-control" value="${bs.maBacSi}" name="maBacSi" placeholder="Mã tài khoản" type="hidden" required autofocus/>
                                </div>
                                
<!--                                 <div class="col-xs-6 col-md-6"> -->
<!--                                     <label>Mật khẩu:</label> -->
<%--                                     <input class="form-control" value="${bs.matKhau}"name="matKhau" placeholder="Mật khẩu" type="password" required /> --%>
<!--                                 </div> -->
                            </div>

                            <label>Họ và tên:</label>
                            <input class="form-control" value="${bs.hoTen}" name="hoTen" placeholder="Họ và tên" type="text" required/>

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
                            <input class="form-control" value="${bs.ngaySinh}" name="ngaySinh" placeholder="Ngày sinh" type="date" required/>

                            </br>

                            <div class="row">
                                <div class="col-xs-6 col-md-6">
                                    <label>Email</label>
                                    <input class="form-control" value="${bs.email}" name="email" placeholder="Địa chỉ email" type="email" required/>
                                </div>
                                <div class="col-xs-6 col-md-6">
                                    <label>ĐTDĐ:</label>
                                    <input class="form-control" value="${bs.soDienThoai}" name="soDienThoai" placeholder="Điện thoại" type="text" required />
                                </div>
                            </div>
                            </br>

                            <label>Quốc tịch:</label>
                            <input class="form-control" value="${bs.quocTich}" name="quocTich" placeholder="Quốc tịch" type="text" required/>

                            </br>

                            <label>Nơi ở hiện tại:</label>
                            <textarea class="form-control" name="noiOHienTai" placeholder="Nơi ở hiện tại" required>${bs.noiOHienTai}</textarea>

                            </br>

                            <label>Quê quán:</label>
                            <textarea class="form-control" name="queQuan" placeholder="Quê quán" required>${bs.queQuan}</textarea>

                            </br>

                            <label>Số CMND:</label>
                            <input class="form-control" value="${bs.soCMND}" name="soCMND" placeholder="Số CMND" type="text" required/>

                            </br>

                            <label>Năm kinh nghiệm:</label>
                            <input class="form-control" value="${bs.namKinhNghiem}" name="namKinhNghiem" placeholder="Năm kinh nghiệm" type="text" required/>


                            <button class="button button-block" type="submit">
                                Cập nhật mới</button>

                        </form>
                    </div>
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
</body>
</html>
