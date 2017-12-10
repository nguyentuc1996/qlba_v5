<!DOCTYPE html>
<%@page import="java.util.Date"%>
<html lang="en">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.p3.qlba.entities.*"%>
<head>
    <meta charset="utf-8">
    <title>Home patient</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/modal.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/patient.css">
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
                    <li class="active"><a href="${pageContext.request.contextPath}/benhnhan/trang_chu?action=BCSK">Báo cáo sức khỏe</a></li>
                    <li><a href="${pageContext.request.contextPath}/benhnhan/trang_chu?action=BA">Bệnh án</a></li>
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
	<% 
	BenhNhan bn= (BenhNhan)request.getAttribute("benhNhan");
	if (bn != null) { 
 			
	%>
    <div class="container mtb">
        <div class="row">
            <div class="col-xs-3 col-md-3">
                <div class="box box-primary">
                    <div class="box-header with-border">
                        <h3 class="box-title">About Me</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <strong><i class="fa fa-book margin-r-5"></i>Thông tin tài khoản</strong>
                        <p class="text-muted">
                            Tên tài khoản: <%= bn.getTaiKhoan() %>
                        </p>
                        <p class="text-muted">
                            Họ và tên: <%=bn.getHoTen() %>
                        </p>
                        <p class="text-muted">
                            Giới tính: <%=bn.getGioiTinh() %>
                        </p>
                        <p class="text-muted">
                            Ngày sinh: <%=(Date)bn.getNgaySinh() %>
                        </p>

                        <hr>

                        <strong><i class="fa fa-map-marker margin-r-5"></i>Liên lạc</strong>
                        <p class="text-muted">Quốc tịch: <%=bn.getQuocTich() %></p>
                        <p class="text-muted">Nơi ở hiện tại: <%=bn.getNoiOHienTai() %></p>
                        <p class="text-muted">Quê quán: <%=bn.getQueQuan() %></p>
                        <p class="text-muted">Điện thoại: <%=bn.getSoDienThoai() %></p>
                        <p class="text-muted">Email: <%=bn.getEmail() %></p>
                        <hr>

                        <strong><i class="fa fa-pencil margin-r-5"></i> Nghề nghiệp</strong>

                        <p class="text-muted">Nghề nghiêp: <%=bn.getNgheNghiep() %></p>

                        <hr>

                        <strong><i class="fa fa-file-text-o margin-r-5"></i> Notes</strong>

                        <p>Phòng khám bách khoa - Phường Hai Bà Trưng - Hà Nội</p>
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
                        <form action="${pageContext.request.contextPath}/benhnhan/sua_thong_tin" method="POST" class="form" role="form">

                            <label>Họ và tên:</label>
                            <input class="form-control" value="<%=bn.getHoTen() %>" name="hoTen" placeholder="Họ và tên" type="text" required/>
                            
                            </br>
							
							<label>Ngày sinh:</label>
                            <input class="form-control" value="<%=(Date)bn.getNgaySinh() %>" name="ngaySinh" placeholder="Ngày sinh" type="date" required/>
                            
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
							 <label>Quốc tịch:</label>
                            <input class="form-control" value="<%=bn.getQuocTich() %>" name="quocTich" placeholder="Quốc tịch" type="text" required/>
                            
                            </br>
                            

                            <label>Nơi ở hiện tại:</label>
                            <textarea class="form-control" name="noiOHienTai" placeholder="Nơi ở hiện tại" required><%=bn.getNoiOHienTai() %></textarea>
                            
                            </br>
                            <div class="row">
                                <div class="col-xs-6 col-md-6">
                                    <label>Email:</label>
                                    <input class="form-control" value="<%=bn.getEmail() %>" name="email" placeholder="Địa chỉ email" type="email" required/> 
                                </div>
                                <div class="col-xs-6 col-md-6">
                                    <label>ĐTDĐ:</label>
                                    <input class="form-control" value="<%=bn.getSoDienThoai() %>" name="soDienThoai" placeholder="Điện thoại" type="text" required /> 
                                </div>
                            </div>
                            </br>


                            <label>Quê quán:</label>
                            <textarea class="form-control" name="queQuan" placeholder="Quê quán" required><%=bn.getQueQuan() %></textarea>
                            
                            </br>

                            <label>Số CMND:</label> 
							<input class="form-control"
								value="<%=bn.getSoCMND() %>" name="soCMND" placeholder="Số CMND"
								type="text" required /> 
								</br>
								 
							<label>Số thẻ Bảo hiểm y tế:</label> 
							<input class="form-control" value="<%=bn.getSoTheBHYT() %>"
								name="soTheBHYT" placeholder="Số thẻ BHYT" type="text"
								required /> </br> 
							<label>Nghề nghiệp:</label> 
							<input class="form-control" value="<%=bn.getNgheNghiep() %>" name="ngheNghiep" placeholder="Nghề nghiệp" type="text" required />
							<button class="button button-block" type="submit">
										Cập nhật mới</button>

                        </form>
                    </div>
                    <!-- /.box-body -->
                </div>
            </div>
        </div>
    </div>
    <%} %>
</body>
</html>