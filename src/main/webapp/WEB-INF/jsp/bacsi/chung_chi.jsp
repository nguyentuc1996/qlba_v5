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
    <div id="qlba_modal_update" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <span class="close" id="close-add">&times;</span>
                    <h2>Thêm chứng chỉ</h2>
                </div>
                <div class="modal-body">
                    <div class="tab">
                        <button class="tablinks" onclick="openField(event, 'benhAn')" id="defaultOpen">Bệnh án</button>
<!--                         <button class="tablinks" onclick="openField(event, 'chanDoan')">Chẩn đoán bệnh</button> -->
<!--                         <button class="tablinks" onclick="openField(event, 'phapDo')">Phác đồ điều trị</button> -->
                    </div>

                    <div id="benhAn" class="tabcontent">
                        <form action="<%=request.getContextPath()%>/bacsi/them_chung_chi" method="POST" class="form" role="form">
                            <div class="row">
                            <div class="col-xs-6 col-md-6">
                                    <label>Tên chứng chỉ:</label>
                                    <input class="form-control" name="tenChungChi" >
                                </div>
                            </div>
                            <label>Ngày nhận:</label>
                            <input class="form-control" name="ngayNhan" placeholder="Ngày nhận" type="date" required />
                            </br>
                            <label>Ngày hết hạn:</label>
                            <input class="form-control" name="ngayHetHan" placeholder="Ngày hết hạn" type="date" required />
                            </br>
                            <label>Mô tả:</label>
                            <textarea class="form-control" name="moTa" placeholder="Khác" ></textarea>                               
                            
                            
                            <button class="button button-block" type="submit">
                                Thêm chứng chỉ</button>

                        </form>
                    </div>

                    


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
                                <button class="button button-block" id="btn-modal-update">Thêm chứng chỉ</button>
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
    <script src="${pageContext.request.contextPath}/resources/js/pddt-update.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/modal-update.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/search.js"></script>  
    <script src="${pageContext.request.contextPath}/resources/js/tab-daily-health.js"></script>
</body>
</html>