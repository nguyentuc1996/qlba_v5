
<%@page import="com.p3.qlba.entities.BenhAn"%>
<%@page import="java.util.Date"%>
<%@page import="com.p3.qlba.entities.LinhVucKhamChua"%>
<%@page import="com.p3.qlba.entities.BenhNhan"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="new-health-report">
	<h3>Thêm bệnh án mới</h3>
	<div class="row">
		<div class="panel-group" id="accordion">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h4 class="panel-title">
						<legend>
							<a data-toggle="collapse" data-parent="#accordion"
								href="#add-health-record">Thêm bệnh án</a>
						</legend>
					</h4>
				</div>
				<div class="panel-collapse collapse in" id="add-health-record">
					<div class="panel-body">
						<div class="row well well-sm" style="float: center;">
							<form action="${pageContext.request.contextPath}/bacsi/them_benh_an" method="POST" class="form" role="form">
								<div class="row">
									<!-- 					                <div class="col-xs-6 col-md-6"> -->
									<!-- 					                    <label>Mã bác sĩ:</label> -->
									<!-- 					                    <select class="form-control" name="maNguoiTao">  -->
									<!-- 					                    	<option value="1">hongtt</option> -->
									<!-- 					                    	<option value="2">tucnguyen</option> -->
									<!-- 					    				</select> -->
									<!-- 					                </div> -->
									<div class="col-xs-6 col-md-6">
										<label>Chọn bệnh nhân:</label>
										<%
											ArrayList<BenhNhan> danhSachBenhNhan = (ArrayList<BenhNhan>) request.getAttribute("danhSachBenhNhan");
										%>
										<select class="form-control" name="maBenhNhan">
										
											<%	
												if(danhSachBenhNhan !=null){
												for (BenhNhan benhNhan : danhSachBenhNhan) {
											%>
											<option value="<%=benhNhan.getMaBenhNhan()%>"><%=benhNhan.getMaBenhNhan()%>
												-
												<%=benhNhan.getHoTen()%></option>
											<%
												}}
											%>
										</select>
									</div>
								</div>
								<div class="row">
									<div class="col-xs-6 col-md-6">
										<label>Lĩnh vực khám chữa:</label> 
										<%
											ArrayList<LinhVucKhamChua> danhSachLinhVucKhamChua = (ArrayList<LinhVucKhamChua>) request.getAttribute("danhSachLinhVucKhamChua");
										%>
										<select class="form-control" name="maLinhVuc">
										<% if(danhSachLinhVucKhamChua != null){
										for (LinhVucKhamChua lv:danhSachLinhVucKhamChua){ %>
											<option value="<%=lv.getMaLinhVuc() %>"><%=lv.getMaLinhVuc() %> - <%=lv.getTenLinhVuc() %></option>
										<%}} %>
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
								
								<button class="button button-block" type="submit">Thêm
									bệnh án</button>
							</form>

						</div>
					</div>
				</div>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading">
					<h4 class="panel-title">
						<legend>
							<a data-toggle="collapse" data-parent="#accordion"
								href="#chan-doan">Viết chẩn đoán bệnh</a>
						</legend>
					</h4>
				</div>
				<div class="panel-collapse collapse" id="chan-doan">
					<div class="panel-body">
						<div class="row well well-sm" style="float: center;">
							<form action="${pageContext.request.contextPath}/bacsi/viet_chan_doan" method="POST" class="form" role="form">
								<div class="row">
									<div class="col-xs-6 col-md-6">
										<label>Bệnh án:</label> 
										<%
											ArrayList<BenhAn> danhSachBenhAn = (ArrayList<BenhAn>) request.getAttribute("danhSachBenhAn");
										%>
										<select class="form-control" name="maBenhAn">
										<% if(danhSachBenhAn != null){
										for (BenhAn benhAn:danhSachBenhAn){ %>
											<option value="<%=benhAn.getMaBenhAn()%>"> Mã BA: <%=benhAn.getMaBenhAn() %></option>
										<%}} %>
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
								<button class="button button-block" type="submit">Viết chẩn
									đoán</button>

							</form>
						</div>
					</div>
				</div>

			</div>
			<div class="panel panel-default">
				<div class="panel-heading">
					<h4 class="panel-title">
						<legend>
							<a data-toggle="collapse" data-parent="#accordion"
								href="#tao-phac-do">Viết phác đồ điều trị</a>
						</legend>
					</h4>
				</div>
				<div class="panel-collapse collapse" id="tao-phac-do">
					<div class="panel-body">
						<div class="row well well-sm" style="float: center;">
							<form action="/" method="POST" class="form" role="form">
								<div class="row">
									<div class="col-xs-6 col-md-6">
										<label>Mã bệnh án:</label> <input class="form-control"
											name="maBenhAn" type="text"
											placeholder="load ma benh an ra day" disabled></input>
									</div>
									<div class="col-xs-6 col-md-6">
										<label>Thời gian:</label> <input class="form-control"
											name="ngayChanDoan" placeholder="Ngày chẩn đoán" type="date"
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
								<label>Nhắc nhở:</label> </br> <label class="radio-inline"> <input
									type="radio" name="nhacNho" id="inlineCheckbox1" value="1" />
									Có
								</label> <label class="radio-inline"> <input type="radio"
									name="nhacNho" id="inlineCheckbox2" value="0" /> Không
								</label> </br> </br>
								<button class="button button-block" type="submit">Tạo
									phác đồ điều trị</button>

							</form>
						</div>
					</div>
				</div>
			</div>

		</div>

