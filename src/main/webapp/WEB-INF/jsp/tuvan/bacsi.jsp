<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.p3.qlba.entities.*"%>
<%@ page import="java.util.*"%>
<html lang="en">
<head>
	<title>Tư vấn </title>
	<link rel="stylesheet" type="text/css" href="/style.css">
	<script src="/webjars/jquery/jquery.min.js"></script>
    <script src="/webjars/sockjs-client/sockjs.min.js"></script>
    <script src="/webjars/stomp-websocket/stomp.min.js"></script>
	<title>Tư vấn</title>
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
<!-- <script type="text/javascript" src="code.js"> -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
<%-- <script type="text/javascript" src="<c:url value='code.js'/>"></script> --%>
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
            <div class="col-xs-8 col-md-8">
                <div class="box box-primary">
                    <div class="box-header ui-sortable-handle" style="cursor: move;">
                        <i class="fa fa-comments-o"></i>

                        <h3 class="box-title">Chat</h3>
                        <input id="bacsi" type="hidden" value=<%=session.getAttribute("bacsi") %> disabled="disabled">
                        <input id="benhnhan" type="hidden" value=<%=session.getAttribute("benhnhan") %> disabled="disabled">
                        <input id="nguoigui" type="hidden" value=<%=session.getAttribute("nguoigui") %> disabled="disabled">
							
                    </div>
                    <div class="slimScrollDiv" style="position: relative; overflow: hidden; width: auto; height: 250px;">
                        <div class="box-body chat" id="chat-box" style="overflow: scroll; width: auto; height: 250px;">
							
                    
                    <table id="conversation" class="table table-striped">
                    <tbody>
                    			          <%ArrayList<TuVan> tv = (ArrayList<TuVan>) request.getAttribute("cuocTuVan");
                    			          BenhNhan bnn=(BenhNhan) request.getAttribute("benhnhan");
                    			          if (tv != null) {
								for (TuVan tuVan : tv) {
									if(tuVan.getNguoiGui()==0){
										%>
										<tr>
										<td>Bệnh nhân <%=bnn.getHoTen() %> :</td>
										<td><%=tuVan.getTraLoi() %></td>
										</tr>
										
								<%}else{ %>	
										<tr>
										<td>Tôi:  </td>
										<td><%=tuVan.getTraLoi() %></td>
										</tr>
									<%}
							%>
									
                             <%}} %>  
                    </tbody></table>

                    <table id="conversation" class="table table-striped">
			          <tbody id="messages">
			          </tbody>
			        </table>
                        </div>

                    </div>
                <!-- /.chat -->
                    <div class="box-footer">
                        <div class="input-group">
                            <input class="form-control" id="text" placeholder="Type message..."  required>
                            <button id="record-btn1"><em class="fa fa-microphone"></em></button>
                            <div class="input-group-btn">
                            <button id="send" type="submit" class="btn" style="height:30px;background:#00BCD4;color:white;"><i class="fa fa-plus" ></i></button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xs-4 col-md-4">
                <div class="box box-primary">
                    <div class="box-header with-border">
                    <h3 class="box-title">Recently Online doctor</h3>

                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                        </button>
                        <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                    </div>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <ul class="doctors-list doctor-list-in-box">
                            
                            <!-- /.item -->
                            <%
								ArrayList<BenhNhan> ds = (ArrayList<BenhNhan>) request.getAttribute("dsBenhNhan");
								
                            if (ds != null) {
								for (BenhNhan benhNhan : ds) {
							%>
                                <li>
                                    <div><%=benhNhan.getMaBenhNhan() %></div>
                                    <div><%=benhNhan.getTaiKhoan() %></div>
                                    <div><%=benhNhan.getHoTen() %></div>
                                    <div><%=benhNhan.getEmail() %></div>
                                    <div><%=benhNhan.getSoDienThoai()%></div>
                                    <div>
        
                                    <a id= "disconnect" class="btn " href="<%=request.getContextPath()%>/tuvan?target=<%=benhNhan.getMaBenhNhan()%>"><em class="fa fa-trash"></em></a>
                                    </div>
                                </li>
                             <%}} %>  
                            <!-- /.item -->
                            
                            
                        </ul>
                    </div>
                    <!-- /.box-body -->
                    <div class="box-footer text-center">
                    <a href="javascript:void(0)" class="uppercase">View All Products</a>
                    </div>
                    <!-- /.box-footer -->
                </div>
            </div>
        </div>
        
    </div>
<script language="JavaScript" type="text/javascript" src="${pageContext.request.contextPath}/resources/js/chat_bs.js"></script>

</body>
</html>
