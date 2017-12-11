<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Đổi mật khẩu</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/change-pwd.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/footer.css">
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
                    <li ><a href="<%=request.getContextPath()%>/bacsi/home_bac_si">Trang chủ</a></li>
                    <li ><a href="<%=request.getContextPath()%>/bacsi/trang_chu?action=BA">Bệnh án</a></li>
                    <li ><a href="<%=request.getContextPath()%>/bacsi/trang_chu?action=QLCC">Quản lý chứng chỉ</a></li>
                    <li><a href="<%=request.getContextPath()%>/tuvan">Tư vấn sức khỏe</a></li>
                    <li class="username dropdown active">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="hidden-xs">${bs.getTaiKhoan()}</span><b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="<%=request.getContextPath()%>/home/dangxuat">Đăng xuất</a></li>
                            <li class="active"><a href="<%=request.getContextPath()%>/bacsi/doi_mat_khau">Đổi mật khẩu</a></li>
                        </ul>
                    </li>
                </ul>
                </div><!--/.nav-collapse -->
            </div>
        </header>
		<div class="container">
			<div class="row change-pwd">
				<div class="panel-heading">
	               <div class="panel-title text-center">
	               		<h1 class="title">Đổi mật khẩu</h1>
	               		<hr />
	               	</div>
	            </div> 
				<div class="change-pwd-login change-pwd-center">
                    <form action="<%=request.getContextPath()%>/bacsi/xu_ly_doi_mat_khau" class="form-horizontal" method="POST" class="form" role="form">
                        <div class="form-group">
							<div class="cols-sm-10">
                                <div class="input-group">
                                    <label for="matKhauCu" class="cols-sm-2 control-label">Mật khẩu cũ:</label>
                                    <input type="password" class="form-control" name="matKhauCu" id="matKhauCu" required/>
                                </div>
							    
							</div>
						</div>
                        <div class="form-group">
							<div class="cols-sm-10">
                                <div class="input-group">
                                    <label for="matKhauCu" class="cols-sm-2 control-label">Mật khẩu mới:</label>
                                    <input type="password" class="form-control" name="matKhauMoi1" id="password" required/>
                                </div>
							    
							</div>
                        </div>
                        <div class="form-group">
                            <div class="cols-sm-10">
                                <div class="input-group">
                                    <label for="matKhauXN" class="cols-sm-2 control-label">Xác nhận mật khẩu:</label>
                                    <input type="password" class="form-control" name="matKhauMoi2" id="confirm_password" required/>
                                    
                                </div>
                                <span id='message'></span>
							    
							</div>
						</div>
                        
                        <div class="form-group">
							<button type="submit" class="btn btn-primary btn-lg btn-block change-pwd-button" onclick="checkPW()">Đổi mật khẩu</button>
						</div>
                    </form>
	
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
	<script src="${pageContext.request.contextPath}/resources/js/change-pwd.js"></script>
	</body>
</html>