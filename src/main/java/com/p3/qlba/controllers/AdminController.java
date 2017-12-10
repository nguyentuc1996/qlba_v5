package com.p3.qlba.controllers;

//package controller;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.p3.qlba.dao.AdminDAO;
import com.p3.qlba.dao.BacSiDAO;
import com.p3.qlba.dao.BenhNhanDAO;
import com.p3.qlba.dao.LinhVucKhamChuaDAO;
import com.p3.qlba.entities.Admin;
import com.p3.qlba.entities.BacSi;
import com.p3.qlba.entities.BenhNhan;
import com.p3.qlba.entities.LinhVucKhamChua;

@Controller
@RequestMapping(value = "/admin")
public class AdminController {

	private BacSiDAO bacSiDAO = new BacSiDAO();
	private AdminDAO adminDAO = new AdminDAO();
	private BenhNhanDAO benhNhanDAO = new BenhNhanDAO();
	private LinhVucKhamChuaDAO linhVucKhamChuaDAO = new LinhVucKhamChuaDAO();

	private boolean isAdmin(HttpServletRequest request, HttpServletResponse response, ModelMap mm) throws IOException {
		HttpSession session = request.getSession();
		Admin admin = (Admin) session.getAttribute("ad");
		if (admin == null) {
			response.sendRedirect(request.getContextPath() + "/home/login.html");
			return false;
		} else {
			mm.put("ad", admin);
			return true;
		}
	}

	@RequestMapping(value = "/home_admin")
	public String home_benh_nhan(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
			throws IOException {
		if (isAdmin(request, response, mm)) {
			mm.put("dSLinhVucKhamChua", linhVucKhamChuaDAO.layDanhSachLinhVucKhamChua());
		}
		return "admin/linh_vuc_kham_chua";
	}

	@RequestMapping(value = "/trang_chu", method = RequestMethod.GET)
	public String trangChu(HttpServletRequest request, HttpServletResponse response, ModelMap mm) throws IOException {
		String action = request.getParameter("action");
		if (action.equals("QLLVKC")) {
			if (isAdmin(request, response, mm)) {
				mm.put("dSLinhVucKhamChua", linhVucKhamChuaDAO.layDanhSachLinhVucKhamChua());
			}
			return "admin/linh_vuc_kham_chua";

		} else if (action.equals("QLBS")) {
			if (isAdmin(request, response, mm)) {
				mm.put("dSBacSi", bacSiDAO.layDanhSachBacSi());
			}
			return "admin/bac_si";

		} else if (action.equals("QLBN")) {
			if (isAdmin(request, response, mm)) {
				mm.put("dSBenhNhan", benhNhanDAO.layDanhSachBenhNhan());
			}
			return "admin/benh_nhan";

		} else if (action.equals("DMK")) {
			if (isAdmin(request, response, mm)) {

			}
			return "doi_mat_khau";

		} else {
			return "error";
		}

	}

	// quan ly linh vuc kham chua
	@RequestMapping(value = "/them_linh_vuc_kham_chua", method = RequestMethod.POST)
	public void themLinhVucKhamChua(ModelMap mm, HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		if (isAdmin(request, response, mm)) {
			String tenLinhVuc = request.getParameter("tenLinhVuc");
			String moTa = request.getParameter("moTa");
			LinhVucKhamChua linhVucKhamChua = new LinhVucKhamChua();
			linhVucKhamChua.setTenLinhVuc(tenLinhVuc);
			linhVucKhamChua.setMoTa(moTa);
			int result = linhVucKhamChuaDAO.themLinhVucKhamChua(linhVucKhamChua);
			HttpSession session = request.getSession(false);
			if (result == 0) {
				session.setAttribute("them_xoa_sua", "thanhcong");
			} else {
				session.setAttribute("them_xoa_sua", "thatbai");
			}
			response.sendRedirect(request.getContextPath() + "/admin/trang_chu.html?action=QLLVKC");
		}
	}

	@RequestMapping(value = "sua_linh_vuc_kham_chua", method = RequestMethod.POST)
	public void suaLinhVucKhamChua(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
			throws ParseException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		if (isAdmin(request, response, mm)) {
			String maLinhVuc = request.getParameter("maLinhVuc");
			String tenLinhVuc = request.getParameter("tenLinhVuc");
			String moTa = request.getParameter("moTa");
			LinhVucKhamChua linhVucKhamChua = linhVucKhamChuaDAO.chiTietLinhVucKhamChua(Integer.parseInt(maLinhVuc));
			linhVucKhamChua.setTenLinhVuc(tenLinhVuc);
			linhVucKhamChua.setMoTa(moTa);
			int result = linhVucKhamChuaDAO.suaLinhVucKhamChua(linhVucKhamChua);
			HttpSession session = request.getSession(false);
			if (result == 0) {
				session.setAttribute("them_xoa_sua", "thanhcong");
			} else {
				session.setAttribute("them_xoa_sua", "thatbai");
			}
			response.sendRedirect(request.getContextPath() + "/admin/trang_chu.html?action=QLLVKC");
		}
	}

	@RequestMapping(value = "/xoa_linh_vuc_kham_chua", method = RequestMethod.GET)
	public void xoaLinhVucKhamChua(ModelMap mm, HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		if (isAdmin(request, response, mm)) {
			String id = request.getParameter("id");
			linhVucKhamChuaDAO.setQueryUnCheck();
			int result = linhVucKhamChuaDAO.xoaLinhVucKhamChua(Integer.parseInt(id));
			linhVucKhamChuaDAO.setQueryCheck();
			HttpSession session = request.getSession(false);
			if (result == 0) {
				session.setAttribute("them_xoa_sua", "thanhcong");
			} else {
				session.setAttribute("them_xoa_sua", "thatbai");
			}
			response.sendRedirect(request.getContextPath() + "/admin/trang_chu.html?action=QLLVKC");
		}

	}

	// quan ly bac si
	@RequestMapping(value = "/tao_tai_khoan_bac_si", method = RequestMethod.POST)
	public void taoTaiKhoanBacSi(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
			throws IOException, ParseException {
		// check if is admin
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		if (isAdmin(request, response, mm)) {
			String taiKhoan = request.getParameter("taiKhoan");
			String hoTen = request.getParameter("hoTen");
			String ngaySinhStr = request.getParameter("ngaySinh");
			String gioiTinh = request.getParameter("gioiTinh");
			String quocTich = request.getParameter("quocTich");
			String noiOHienTai = request.getParameter("noiOHienTai");
			String email = request.getParameter("email");
			String soDienThoai = request.getParameter("soDienThoai");
			String soCMND = request.getParameter("soCMND");
			String queQuan = request.getParameter("queQuan");
			String namKinhNghiem = request.getParameter("namKinhNghiem");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

			Date ngaySinh = sdf.parse(ngaySinhStr);
			BacSi bacSi = new BacSi(0, taiKhoan, soCMND, hoTen, ngaySinh, gioiTinh, quocTich, noiOHienTai, email,
					soDienThoai, soCMND, queQuan, Integer.parseInt(namKinhNghiem));
			int result = bacSiDAO.themBacSi(bacSi);
			HttpSession session = request.getSession(false);
			if (result == 0) {
				session.setAttribute("them_xoa_sua", "thanhcong");
			} else {
				session.setAttribute("them_xoa_sua", "thatbai");
			}
			response.sendRedirect(request.getContextPath() + "/admin/trang_chu.html?action=QLBS");
		}
	}

	// sua thong tin bac si
	@RequestMapping(value = "/sua_thong_tin_bac_si", method = RequestMethod.POST)
	public void suaThongTinBacSi(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
			throws IOException, ParseException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		if (isAdmin(request, response, mm)) {
			String maBacSi = request.getParameter("maBacSi");
			String taiKhoan = request.getParameter("taiKhoan");
			String hoTen = request.getParameter("hoTen");
			String ngaySinhStr = request.getParameter("ngaySinh");
			String gioiTinh = request.getParameter("gioiTinh");
			String quocTich = request.getParameter("quocTich");
			String noiOHienTai = request.getParameter("noiOHienTai");
			String email = request.getParameter("email");
			String soDienThoai = request.getParameter("soDienThoai");
			String soCMND = request.getParameter("soCMND");
			String queQuan = request.getParameter("queQuan");
			String namKinhNghiem = request.getParameter("namKinhNghiem");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

			Date ngaySinh = sdf.parse(ngaySinhStr);
			BacSi bs = bacSiDAO.layThongTinBacSi(Integer.parseInt(maBacSi));
			BacSi bacSi = new BacSi(Integer.parseInt(maBacSi), taiKhoan, bs.getMatKhau(), hoTen, ngaySinh, gioiTinh,
					quocTich, noiOHienTai, email, soDienThoai, soCMND, queQuan, Integer.parseInt(namKinhNghiem));
			//
			int result = bacSiDAO.suaBacSi(bacSi);
			HttpSession session = request.getSession(false);
			if (result == 0) {
				session.setAttribute("them_xoa_sua", "thanhcong");
			} else {
				session.setAttribute("them_xoa_sua", "thatbai");
			}
			// HttpSession session = request.getSession();
			session.setAttribute("bs", bacSiDAO.layThongTinBacSi(Integer.parseInt(maBacSi)));
			response.sendRedirect(request.getContextPath() + "/admin/trang_chu.html?action=QLBS");
		}
	}

	@RequestMapping(value = "/xoa_tai_khoan_bac_si", method = RequestMethod.GET)
	public void xoaTaiKhoanBacSi(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
			throws IOException, ParseException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		String maTaiKhoan = request.getParameter("maTaiKhoan");
		if (isAdmin(request, response, mm)) {
			linhVucKhamChuaDAO.setQueryUnCheck();
			int result = bacSiDAO.xoaBacSi(Integer.parseInt(maTaiKhoan));
			linhVucKhamChuaDAO.setQueryCheck();
			HttpSession session = request.getSession(false);
			if (result == 0) {
				session.setAttribute("them_xoa_sua", "thanhcong");
			} else {
				session.setAttribute("them_xoa_sua", "thatbai");
			}
			response.sendRedirect(request.getContextPath() + "/admin/trang_chu.html?action=QLBS");
		}
	}

	@RequestMapping(value = "/xem_thong_tin_bac_si", method = RequestMethod.GET)
	public String xemThongTinBacSi(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
			throws IOException, ParseException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		String maTaiKhoan = request.getParameter("maTaiKhoan");
		if (isAdmin(request, response, mm)) {
			BacSi bacSi = bacSiDAO.layThongTinBacSi(Integer.parseInt(maTaiKhoan));
			mm.put("bacSi", bacSi);
		}

		return "bacsi/thongtinbacsi";

	}

	// quan ly benh nhan
	@RequestMapping(value = "/xoa_tai_khoan_benh_nhan", method = RequestMethod.GET)
	public void xoaTaiKhoanBenhNhan(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
			throws IOException, ParseException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		String maTaiKhoan = request.getParameter("maTaiKhoan");
		if (isAdmin(request, response, mm)) {
			linhVucKhamChuaDAO.setQueryUnCheck();
			int result = benhNhanDAO.xoaBenhNhan(Integer.parseInt(maTaiKhoan));
			linhVucKhamChuaDAO.setQueryCheck();
			HttpSession session = request.getSession(false);
			if (result == 0) {
				session.setAttribute("them_xoa_sua", "thanhcong");
			} else {
				session.setAttribute("them_xoa_sua", "thatbai");
			}
			response.sendRedirect(request.getContextPath() + "/admin/trang_chu.html?action=QLBN");
		}
	}

	@RequestMapping(value = "/xem_thong_tin_benh_nhan", method = RequestMethod.GET)
	public String xemThongTinBenhNhan(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
			throws IOException, ParseException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		String maTaiKhoan = request.getParameter("maTaiKhoan");
		if (isAdmin(request, response, mm)) {
			BenhNhan benhNhan = benhNhanDAO.layThongTinBenhNhan(Integer.parseInt(maTaiKhoan));
			mm.put("benhNhan", benhNhan);
		}
		return "benhnhan/thongtinbenhnhan";
	}

	// mới bổ xung
	@RequestMapping(value = "/doi_mat_khau", method = RequestMethod.GET)
	public String doiMatKhau(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
			throws IOException, ParseException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		if (isAdmin(request, response, mm)) {

		}
		return "admin/doi_mat_khau";

	}

	@RequestMapping(value = "/xu_ly_doi_mat_khau", method = RequestMethod.POST)
	public void doiMatKhauAdmin(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
			throws IOException, ParseException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		String matKhauCu = request.getParameter("matKhauCu");
		String matKhauMoi1 = request.getParameter("matKhauMoi1");
		String matKhauMoi2 = request.getParameter("matKhauMoi2");
		if (isAdmin(request, response, mm)) {
			HttpSession session = request.getSession();
			Admin admin = (Admin) session.getAttribute("ad");
			if (matKhauCu.equals(admin.getMatKhau())) {
					admin.setMatKhau(matKhauMoi1);
					adminDAO.suaAdmin(admin);
					session.setAttribute("ad", admin);
					response.sendRedirect(request.getContextPath() + "/admin/home_admin");
			}else{
				response.sendRedirect(request.getContextPath() + "/admin/doi_mat_khau");
			}
		}
	}
}
