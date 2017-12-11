<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.p3.qlba.entities.*"%>
<%@ page import="java.util.*"%>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Chứng chỉ bác sĩ</title>
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
                    <li ><a href="<%=request.getContextPath()%>/bacsi/home_bac_si">Trang chủ</a></li>
                    <li ><a href="<%=request.getContextPath()%>/bacsi/trang_chu?action=BA">Bệnh án</a></li>
                    <li class="active"><a href="<%=request.getContextPath()%>/bacsi/trang_chu?action=QLCC">Quản lý chứng chỉ</a></li>
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
    	<div id="qlba-modal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <span class="close" id="close-add">&times;</span>
                    <h2>Thêm chứng chỉ mới</h2>
                </div>
                <div class="modal-body">
                    <form action="<%=request.getContextPath()%>/bacsi/them_chung_chi" method="POST" class="form" role="form">
                        <input class="form-control" name="tenChungChi" placeholder="tên chứng chỉ " type="text" required/>
                        <div class="row">
                            <div class="col-xs-6 col-md-6">
                                <input class="form-control" name="ngayNhan" placeholder="Ngày nhận" type="date" required/>
                            </div>
                            <div class="col-xs-6 col-md-6">
                                <input class="form-control" name="ngayHetHan" placeholder="Ngày hết hạn" type="date"/>
                            </div>
                        </div>
                        <textarea class="form-control" name="moTa" placeholder="Mô tả" required></textarea>
                        <button class="button button-block" type="submit">
                            Thêm</button>    

                    </form>
                </div>
                <div class="modal-footer">
                
                </div>
                
            </div>
           </div>
    
    <div class="row">
            <div class="col-lg-10 col-lg-offset-1 centered">
                <div class="panel panel-default panel-table">
                    <div class="panel-heading">
                        <div class="row">
                            
                            <div class="col-xs-6 col-md-6">
                                <legend> Danh sách chứng chỉ bác sĩ</legend>
                            </div>
                            <div class="col-xs-6 col-md-6">
                                <button class="button button-block" id="btn-modal-add">Thêm chứng chỉ</button>
                            </div>
                           
                            <input type="text" id="search_text" onkeyup="search()" placeholder="Gõ mã chứng chỉ để tìm kiếm">  
                            
                        </div>
                    </div>
                    <div class="panel-body">
                
                        <table class="table table-striped table-bordered table-list" id="search-table">
                            <thead>
                                <tr>
                                	<th style="text-align: center;">Mã chứng chỉ</th>
                                    <th style="text-align: center;" class="hidden-xs">Tên chứng chỉ</th>
                                    <th style="text-align: center;" >Ngày nhận</th>
                                    <th style="text-align: center;" >Ngày hết hạn</th>
                                    <th style="text-align: center;">Mô tả</th>
                                    <th style="text-align:center;"></th>
                                </tr> 
                            </thead>
                        
                            <tbody>
                                
                                <%ArrayList<ChungChi> tv = (ArrayList<ChungChi>) request.getAttribute("danhSachChungChi");
								if (tv != null) {
								for (ChungChi chungChi : tv) {
							%>
									<tr>
									<td style="text-align:center;" ><%=chungChi.getMaChungChi() %></td>
                                    <td style="text-align:center;" ><%=chungChi.getTenChungChi() %></td>
                                    <td style="text-align:center;" ><%=chungChi.getNgayNhan() %></td>
                                    
                                    <td style="text-align:center;"><%=chungChi.getNgayHetHan() %></td>
                                    <td style="text-align:center;"><%=chungChi.getMoTa() %></td>
                                    <td style="text-align:center;">
                                        <a class="btn btn-danger" href="<%=request.getContextPath()%>/bacsi/xoa_chung_chi?maChungChi=<%=chungChi.getMaChungChi() %>"><em class="fa fa-trash"></em></a>
                                        <a class="btn btn-primary" href="#qlcc_modal_update_<%=chungChi.getMaChungChi()%>" data-toggle="modal" data-backdrop="false">
                                        <em class="fa fa-pencil"></em></a> <!--truyen gia tri id vao day qlba_modal_update_{}-->
										<div style="text-align: left;"
											id="qlcc_modal_update_<%=chungChi.getMaChungChi()%>"
											class="modal fade" role="dialog"
											aria-labelledby="myModalLabel" aria-hidden="true">

											<div class="modal-content">
												<div class="modal-header">
													<span class="close" data-dismiss="modal">&times;</span>
													<h2>Chứng chỉ xem chi tiết</h2>
												</div>
												
												<div class="modal-body">
                                                    <div class="row">
                                                        <div class="col-md-6 well">
                                                            <strong><i class="fa fa-book margin-r-5"></i>Thông tin chứng chỉ</strong>
                                                            <br>
                                                            <p class="text-muted">
                                                                Tên chứng chỉ: <%=chungChi.getTenChungChi() %>
                                                            </p>
                                                            <p class="text-muted">
                                                                Thời gian: <%= chungChi.getNgayNhan()%> - <%=chungChi.getNgayHetHan() %>
                                                            </p>
                                                            <p class="text-muted">
                                                                Mô tả:
                                                                <p><%= chungChi.getMoTa()%></p>
                                                            </p>
                                                            <a data-toggle="collapse" data-target="#update_ccbs_<%=chungChi.getMaChungChi()%>">Thay đổi thông tin chứng chỉ</a>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div id="update_ccbs_<%=chungChi.getMaChungChi() %>" class="collapse">
                                                                <form action="<%=request.getContextPath()%>/bacsi/sua_chung_chi?maChungChi=<%=chungChi.getMaChungChi()%>" method="POST" class="form" role="form">
                                                                    <input class="form-control" name="tenChungChi" value="<%=chungChi.getTenChungChi()%>" type="text" required/>
                                                                    <div class="row">
                                                                        <div class="col-xs-6 col-md-6">
                                                                            <input class="form-control" name="ngayNhan" value="<%=chungChi.getNgayNhan()%>" type="date" required/>
                                                                        </div>
                                                                        <div class="col-xs-6 col-md-6">
                                                                            <input class="form-control" name="ngayHetHan" value="<%=chungChi.getNgayHetHan()%>" type="date"/>
                                                                        </div>
                                                                    </div>
                                                                    <textarea class="form-control" name="moTa" placeholder="Mô tả" required><%=chungChi.getMoTa()%></textarea>
                                                                    <button class="button button-block" type="submit">
                                                                        Thêm</button>    

                                                                </form>
                                                                </div>
														</div>
														
											</div>
											<div class="modal-footer"></div>
										

										</div></td>
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
    <script src="${pageContext.request.contextPath}/resources/js/pddt-update.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/modal-add.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/search.js"></script>  
    <script src="${pageContext.request.contextPath}/resources/js/tab-daily-health.js"></script>
</body>
</html>