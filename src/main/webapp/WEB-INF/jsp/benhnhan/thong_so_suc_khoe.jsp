<!DOCTYPE html>
<html lang="en">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.p3.qlba.entities.*"%>
<%@ page import="java.util.*" %>
<head>
    <meta charset="utf-8">
    <title>Home admin</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/footer.css">
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
    <div class="container mtb">
        <div id="qlba-modal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <span class="close" id="close-add">&times;</span>
                    <h2>Thêm báo cáo sức khỏe </h2>
                </div>
                <div class="modal-body">
                    <form action="<%=request.getContextPath()%>/benhnhan/them_thong_so_suc_khoe" method="POST" class="form" role="form">
                        <div class="col-xs-6 col-md-6">
                            <label>Mạch đập (số lần / phút): </label>
                            <input class="form-control" name="mach" value="60" type="number" min="0" max="100" required /> 
                        </div>
                        <div class="col-xs-6 col-md-6">
                            <label>Nhiệt độ cơ thể (độ C): </label>
                            <input class="form-control" name="nhietDo" value="37" type="number" min="0" max="50" required/>
                        </div>
                        <div class="col-xs-6 col-md-6">
                            <label>Huyết áp (mmHg): </label>
                            <input class="form-control" name="huyetAp" value="80" type="number" min="0" max="200" required/>
                        </div>
                        <div class="col-xs-6 col-md-6">
                            <label>Nhịp thở (số lần /phút): </label>
                            <input class="form-control" name="nhipTho" value="15" type="number" min="0" max="100" required/>
                        </div>
                        <div class="col-xs-6 col-md-6">
                            <label>Cân nặng (kg): </label>
                            <input class="form-control" name="canNang" value="40" type="number" min="0" max="400" required/>
                        </div>
                        
                        <button class="button button-block" type="submit">
                            Thêm báo cáo</button>    

                    </form>
                </div>
                <div class="modal-footer">
                
                </div>
                
            </div>
        </div>
        
        <div id="daily-report">
            <div class="row">
                <div class="col-lg-10 col-lg-offset-1 centered">
                    <div class="panel panel-default panel-table">
                        <div class="panel-heading">
                            <div class="row">
                                
                                <div class="col-xs-6 col-md-6">
                                    <legend> Báo cáo sức khỏe hằng ngày</legend>
                                </div>
                                <div class="col-xs-6 col-md-6">
                                    <button id="btn-modal-add" class="button button-block">Thêm báo cáo mới</button>
                                </div>
                            
                                <input type="text" id="search_text" onkeyup="search()" placeholder="Gõ mã bản ghi để tìm kiếm">  
                                
                            </div>
                        </div>
                        <div class="panel-body">
                    
                            <table class="table table-striped table-bordered table-list" id="search-table">
                                <thead>
                                    <tr>
                                    	<th style="text-align: center;">Mã</th>
                                        <th style="text-align: center;">Thời gian</th>
                                        <th style="text-align: center;" >Mạch</th>
                                        <th style="text-align: center;" >Nhiệt độ cơ thể</th>
                                        <th style="text-align: center;" >Huyết áp</th>
                                        <th style="text-align: center;" >Nhịp thở</th>
                                        <th style="text-align: center;" >Cân nặng</th>                                        
                                        <th style="text-align:center;"></th>
                                    </tr>
                                </thead>
                            
                                <tbody>
                                	<%
                                		ArrayList<ThongSoSucKhoe> ds= (ArrayList<ThongSoSucKhoe>)request.getAttribute("dSThongSoSucKhoe");
                                		if(ds != null){
											for(ThongSoSucKhoe tssk:ds){
                                	%>
                                    <tr>
                                    	<td style="text-align: center;" ><%= tssk.getMaBanGhi() %></td>
                                        <td style="text-align: center;" ><%= tssk.getNgay() %></td>
                                        <td style="text-align: center;" ><%= tssk.getMach() %></td>
                                        <td style="text-align: center;" ><%= tssk.getNhietDo() %></td>
                                        <td style="text-align: center;" ><%=tssk.getHuyetAp() %></td>
                                        <td style="text-align: center;" ><%= tssk.getNhipTho() %></td>
                                        <td style="text-align: center;" ><%=tssk.getCanNang() %></td>
                                        
                                        <td style="text-align: center;"><a class="btn btn-danger"
										href="<%=request.getContextPath()%>/benhnhan/xoa_thong_so_suc_khoe?maBanGhi=<%=tssk.getMaBanGhi()%>">
											<em class="fa fa-trash"></em>
									   </a></td>
									
									<td style="text-align: center;">
                                            <a class="btn btn-primary" href="#qlbc_modal_update_<%=tssk.getMaBanGhi() %>" data-toggle="modal" data-backdrop="false"><em class="fa fa-pencil"></em></a>
                                            <div id="qlbc_modal_update_<%=tssk.getMaBanGhi() %>" class="modal fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <span class="close" data-dismiss="modal">&times;</span>
                                                        <h2>Sửa báo cáo sức khỏe ngày <%=tssk.getNgay() %></h2>
                                                    </div>
                                                    <div class="modal-body">
                                                        <form action="<%=request.getContextPath()%>/benhnhan/cap_nhat_thong_so_suc_khoe?maBanGhi=<%=tssk.getMaBanGhi()%>" method="POST" class="form" role="form">
                                                            <div class="col-xs-6 col-md-6">
                                                                <label>Mạch đập (số lần / phút): </label>
                                                                <input class="form-control" name="mach" value="<%=tssk.getMach() %>" type="number" min="0" max="100" required /> 
                                                            </div>
                                                            <div class="col-xs-6 col-md-6">
                                                                <label>Nhiệt độ cơ thể (độ C): </label>
                                                                <input class="form-control" name="nhietDo" value="<%=tssk.getNhietDo()%>" type="number" min="0" max="50" required/>
                                                            </div>
                                                            <div class="col-xs-6 col-md-6">
                                                                <label>Huyết áp (mmHg): </label>
                                                                <input class="form-control" name="huyetAp" value="<%= tssk.getHuyetAp() %>" type="number" min="0" max="200" required/>
                                                            </div>
                                                            <div class="col-xs-6 col-md-6">
                                                                <label>Nhịp thở (số lần /phút): </label>
                                                                <input class="form-control" name="nhipTho" value="<%= tssk.getNhipTho() %>" type="number" min="0" max="100" required/>
                                                            </div>
                                                            <div class="col-xs-6 col-md-6">
                                                                <label>Cân nặng (kg): </label>
                                                                <input class="form-control" name="canNang" value="<%=tssk.getCanNang() %>" type="number" min="0" max="400" step=".50" required/>
                                                            </div>
                                                            
                                                            <button class="button button-block" type="submit">
                                                                Sửa</button>    

                                                        </form>
                                                    </div>
                                                    <div class="modal-footer">
                                                    
                                                    </div>
                                                    
                                                </div>
                                            </div>
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
</body>
</html>