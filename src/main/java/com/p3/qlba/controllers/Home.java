package com.p3.qlba.controllers;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.p3.qlba.*;
import com.p3.qlba.dao.AdminDAO;
import com.p3.qlba.dao.BacSiDAO;
import com.p3.qlba.dao.BenhNhanDAO;
import com.p3.qlba.entities.Admin;
import com.p3.qlba.entities.BacSi;
import com.p3.qlba.entities.BenhNhan;


@Controller
@RequestMapping(value = "/home")
public class Home {

	BenhNhanDAO benhNhanDAO = new BenhNhanDAO();
	BacSiDAO bacSiDAO = new BacSiDAO();
	AdminDAO adminDAO = new AdminDAO();

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(HttpServletRequest request, HttpServletResponse response,ModelMap mm) throws IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		String vaiTro = (String) session.getAttribute("vaitro");
		if (vaiTro != null) {
			if (vaiTro.equalsIgnoreCase("benhnhan")) {
				mm.put("bn", (BenhNhan)session.getAttribute("bn"));
				response.sendRedirect(request.getContextPath() + "/benhnhan/trang_chu.html");
				return "benhnhan/BN";//3 bs2 bn1
			} else if (vaiTro.equalsIgnoreCase("bacsi")) {
				mm.put("bs", (BacSi)session.getAttribute("bs"));
				response.sendRedirect(request.getContextPath() + "/bacsi/home_bac_si.html");
				return "bacsi/BS";
			} else if (vaiTro.equalsIgnoreCase("admin")) {
				mm.put("ad", (Admin) session.getAttribute("ad"));
				response.sendRedirect(request.getContextPath() + "/admin/home_admin.html");
				System.out.println("OKK in home");
				return "admin/linh_vuc_kham_chua";
			}
		}
		return "login";
	}

	@RequestMapping(value = "/loginprocess", method = RequestMethod.POST)
	public String LoginProcess(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
			throws IOException {
		String taiKhoan = request.getParameter("taiKhoan");
		String matKhau = request.getParameter("matKhau");
		String vaiTro = request.getParameter("vaiTro");
		HttpSession session = request.getSession();
		session.setMaxInactiveInterval(900);// max thoi gian session la 900
		if (vaiTro.equalsIgnoreCase("admin")) {
			Admin admin = adminDAO.dangNhap(taiKhoan, matKhau);
			if (admin == null) {// sai tai khoan mat khau
				return "login";
			} else {
				session.setAttribute("ad", admin);
				session.setAttribute("vaitro", "admin");
				response.sendRedirect(request.getContextPath() + "/admin/home_admin.html");
				System.out.println("OKK in home");
				return "admin/linh_vuc_kham_chua";
//				return "benhnhan/test";
			}
		} else if (vaiTro.equalsIgnoreCase("bacSi")) {
			BacSi bacSi = bacSiDAO.dangNhap(taiKhoan, matKhau);
			if (bacSi == null) {
				return "login";
			} else {
				session.setAttribute("bs", bacSi);
				session.setAttribute("vaitro", "bacsi");
				response.sendRedirect(request.getContextPath() + "/bacsi/home_bac_si.html");
				return "bacsi/BS";
			}
		} else {
			// benhNhan
			BenhNhan benhNhan = benhNhanDAO.dangNhap(taiKhoan, matKhau);
			if (benhNhan == null) {
				return "login";
			} else {
				session.setAttribute("bn", benhNhan);
				session.setAttribute("vaitro", "benhnhan");
				response.sendRedirect(request.getContextPath() + "/benhnhan/trang_chu?action=TC");
				return "benhnhan/BN";
			}
		}
	}

	// dang ky
	@RequestMapping(value = "/dangky", method = RequestMethod.GET)
	public String dangKy(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		return "dangKy";
	}

	@RequestMapping(value = "/xylydangky", method = RequestMethod.POST)
	public String xuLyDangKy(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
			throws ParseException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");

		String taiKhoan = request.getParameter("taiKhoan");
		String hoTen = request.getParameter("hoTen");
		String email = request.getParameter("email");
		String matKhau = request.getParameter("matKhau");
		String matKhauXacNhan = request.getParameter("matKhauXacNhan");
		
		BenhNhan benhNhan = new BenhNhan();
		benhNhan.setTaiKhoan(taiKhoan);
		benhNhan.setHoTen(hoTen);
		benhNhan.setEmail(email);
		benhNhan.setMatKhau(matKhau);
		int result=benhNhanDAO.themBenhNhan(benhNhan);
//		HttpSession session = request.getSession(false);
		HttpSession session = request.getSession();
		if(result==0){
			session.setAttribute("them_xoa_sua", "thanhcong");
		}else{
			session.setAttribute("them_xoa_sua", "thatbai");
		}
		
		session.setMaxInactiveInterval(900);// max thoi gian session la 900
		session.setAttribute("bn", benhNhan);
		response.sendRedirect(request.getContextPath() + "/benhnhan/home_benh_nhan.html");
		return "benhnhan/BN";
	}

	// dang xuat
	@RequestMapping(value = "/dangxuat", method = RequestMethod.GET)
	public String dangXuat(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		session.invalidate();
		return "login";
	}

}