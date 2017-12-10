package com.p3.qlba.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
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

import com.p3.qlba.dao.BenhAnDAO;
import com.p3.qlba.dao.BenhNhanDAO;
import com.p3.qlba.dao.ChanDoanDAO;
import com.p3.qlba.dao.PhacDoDieuTriDAO;
import com.p3.qlba.dao.ThongSoSucKhoeDAO;
import com.p3.qlba.entities.Admin;
import com.p3.qlba.entities.BacSi;
import com.p3.qlba.entities.BenhAn;
import com.p3.qlba.entities.BenhNhan;
import com.p3.qlba.entities.ChanDoan;
import com.p3.qlba.entities.PhacDoDieuTri;
import com.p3.qlba.entities.ThongSoSucKhoe;


@Controller
@RequestMapping(value = "/benhnhan")
public class BenhNhanController {
	private BenhNhanDAO benhNhanDAO = new BenhNhanDAO();
	private ThongSoSucKhoeDAO thongSoSucKhoeDAO = new ThongSoSucKhoeDAO();
	private BenhAnDAO benhAnDAO = new BenhAnDAO();
	private ChanDoanDAO chanDoanDAO = new ChanDoanDAO();
	private PhacDoDieuTriDAO phacDoDieuTriDAO = new PhacDoDieuTriDAO();

	private boolean isBenhNhan(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
			throws IOException {
		HttpSession session = request.getSession();
		BenhNhan bn = (BenhNhan) session.getAttribute("bn");
		if (bn == null) {
			response.sendRedirect(request.getContextPath() + "/home/login.html");
			return false;
		} else {
			// mm.put("bn", admin);
			return true;
		}
	}

	@RequestMapping(value = "/trang_chu", method = RequestMethod.GET)
	public String trangChu(HttpServletRequest request, HttpServletResponse response, ModelMap mm) throws IOException {
		String action = request.getParameter("action");
		if (action.equals("TC")) {// trang chủ
			if (isBenhNhan(request, response, mm)) {
				HttpSession session = request.getSession();
				BenhNhan benhNhan = (BenhNhan) session.getAttribute("bn");
				mm.put("benhNhan", benhNhan);
			}
			return "benhnhan/BN";

		} else if (action.equals("BCSK")) {// báo cáo sức khỏe
			if (isBenhNhan(request, response, mm)) {
				HttpSession session = request.getSession();
				BenhNhan benhNhan = (BenhNhan) session.getAttribute("bn");
				ArrayList<ThongSoSucKhoe> danhSachThongSoSucKhoe = thongSoSucKhoeDAO
						.layDanhSachThongSoSucKhoeTheoBenhNhan(benhNhan.getMaBenhNhan());
				mm.put("dSThongSoSucKhoe", danhSachThongSoSucKhoe);
			}
			return "benhnhan/thong_so_suc_khoe";

		} else if (action.equals("BA")) {// bênh án
			if (isBenhNhan(request, response, mm)) {
				HttpSession session = request.getSession();
				BenhNhan benhNhan = (BenhNhan) session.getAttribute("bn");
				ArrayList<BenhAn> dSBenhAn = benhAnDAO.layDanhSachBenhAnTheoBenhNhan(benhNhan.getMaBenhNhan());
				mm.put("danhSachBenhAn", dSBenhAn);
			}
			return "benhnhan/benh_an";
		} else if (action.equals("TVSK")) {// tu van suc khoe
			if (isBenhNhan(request, response, mm)) {

			}
			return "";
		} else if(action.equals("DMK")){
			if (isBenhNhan(request, response, mm)) {

			}
			return "doi_mat_khau";
		}else{
			return "error";
		}
	}

	@RequestMapping(value = "/sua_thong_tin", method = RequestMethod.POST)
	public void suaThongTin(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
			throws IOException, ParseException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		if (isBenhNhan(request, response, mm)) {
			HttpSession session = request.getSession();
			BenhNhan benhNhan = (BenhNhan) session.getAttribute("bn");

			String hoTen = request.getParameter("hoTen");
			String ngaySinhStr = request.getParameter("ngaySinh");
			String gioiTinh = request.getParameter("gioiTinh");
			String quocTich = request.getParameter("quocTich");
			String noiOHienTai = request.getParameter("noiOHienTai");
			String email = request.getParameter("email");
			String soDienThoai = request.getParameter("soDienThoai");
			String soCMND = request.getParameter("soCMND");
			String soTheBHYT = request.getParameter("soTheBHYT");
			String queQuan = request.getParameter("queQuan");
			String ngheNghiep = request.getParameter("ngheNghiep");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			// surround below line with try catch block as below code throws
			// checked
			// exception
			Date ngaySinh = sdf.parse(ngaySinhStr);
			BenhNhan bn = benhNhanDAO.layThongTinBenhNhan(benhNhan.getMaBenhNhan());
			bn.setHoTen(hoTen);
			bn.setNgaySinh(ngaySinh);
			bn.setGioiTinh(gioiTinh);
			bn.setQuocTich(quocTich);
			bn.setNoiOHienTai(noiOHienTai);
			bn.setEmail(email);
			bn.setSoDienThoai(soDienThoai);
			bn.setSoCMND(soCMND);
			bn.setSoTheBHYT(soTheBHYT);
			bn.setQueQuan(queQuan);
			bn.setNgheNghiep(ngheNghiep);
			int result =benhNhanDAO.suaBenhNhan(bn);
//			HttpSession session = request.getSession(false);
			if(result==0){
				session.setAttribute("them_xoa_sua", "thanhcong");
			}else{
				session.setAttribute("them_xoa_sua", "thatbai");
			}
			// System.out.println(gioiTinh);
			session.setAttribute("bn", bn);
			response.sendRedirect(request.getContextPath() + "/benhnhan/trang_chu?action=TC");
		}
	}

	// quan ly thong so suc khoe
	@RequestMapping(value = "/them_thong_so_suc_khoe", method = RequestMethod.POST)
	public void themThongSoSucKhoe(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
			throws IOException, ParseException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		if (isBenhNhan(request, response, mm)) {
			HttpSession session = request.getSession();
			BenhNhan benhNhan = (BenhNhan) session.getAttribute("bn");

			String mach = request.getParameter("mach");
			String nhietDo = request.getParameter("nhietDo");
			String huyetAp = request.getParameter("huyetAp");
			String nhipTho = request.getParameter("nhipTho");
			String canNang = request.getParameter("canNang");
			// surround below line with try catch block as below code throws
			// checked
			// exception
			ThongSoSucKhoe thongSoSucKhoe = new ThongSoSucKhoe();
			thongSoSucKhoe.setMaBenhNhan(benhNhan.getMaBenhNhan());
			thongSoSucKhoe.setMach(Integer.parseInt(mach));
			thongSoSucKhoe.setNhietDo(Integer.parseInt(nhietDo));
			thongSoSucKhoe.setHuyetAp(Integer.parseInt(huyetAp));
			thongSoSucKhoe.setNhipTho(Integer.parseInt(nhipTho));
			thongSoSucKhoe.setCanNang(Integer.parseInt(canNang));
			thongSoSucKhoe.setNgay(new Date());
			int result=thongSoSucKhoeDAO.themThongSoSucKhoe(thongSoSucKhoe);
//			HttpSession session = request.getSession(false);
			if(result==0){
				session.setAttribute("them_xoa_sua", "thanhcong");
			}else{
				session.setAttribute("them_xoa_sua", "thatbai");
			}
			response.sendRedirect(request.getContextPath() + "/benhnhan/trang_chu?action=BCSK");
		}
	}

	@RequestMapping(value = "xem_chi_tiet_thong_so_suc_khoe", method = RequestMethod.GET)
	public String xemThongSo(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
			throws IOException, ParseException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		if (isBenhNhan(request, response, mm)) {
			HttpSession session = request.getSession();
			BenhNhan benhNhan = (BenhNhan) session.getAttribute("bn");
			ThongSoSucKhoe thongSoSucKhoe = thongSoSucKhoeDAO.layThongSoSucKhoeCuaBenhNhan(benhNhan.getMaBenhNhan());
		}
		return "benhnhan/chi_tiet_thong_so_suc_khoe";
	}

	@RequestMapping(value = "cap_nhat_thong_so_suc_khoe", method = RequestMethod.POST)
	public void capNhatThongSoSucKhoe(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
			throws IOException, ParseException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		if (isBenhNhan(request, response, mm)) {
			String maBanGhi = request.getParameter("maBanGhi");// truyen tu
																// parameter
																// tren
																// duong link

			String mach = request.getParameter("mach");
			String nhietDo = request.getParameter("nhietDo");
			String huyetAp = request.getParameter("huyetAp");
			String nhipTho = request.getParameter("nhipTho");
			String canNang = request.getParameter("canNang");
//			String ngay = request.getParameter("ngay");
//			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			// surround below line with try catch block as below code throws
			// checked
			// exception
//			Date ngayD = sdf.parse(ngay);

			ThongSoSucKhoe thongSoSucKhoe = thongSoSucKhoeDAO.layThongTinThongSoSucKhoe(Integer.parseInt(maBanGhi));
			thongSoSucKhoe.setMach(Integer.parseInt(mach));
			thongSoSucKhoe.setNhietDo(Integer.parseInt(nhietDo));
			thongSoSucKhoe.setHuyetAp(Integer.parseInt(huyetAp));
			thongSoSucKhoe.setNhipTho(Integer.parseInt(nhipTho));
			thongSoSucKhoe.setCanNang(Integer.parseInt(canNang));
//			thongSoSucKhoe.setNgay(ngayD);
			int result=thongSoSucKhoeDAO.suaThongSoSucKhoe(thongSoSucKhoe);
			HttpSession session = request.getSession(false);
			if(result==0){
				session.setAttribute("them_xoa_sua", "thanhcong");
			}else{
				session.setAttribute("them_xoa_sua", "thatbai");
			}
		}
		response.sendRedirect(request.getContextPath() + "/benhnhan/trang_chu?action=BCSK");
	}

	@RequestMapping(value = "xoa_thong_so_suc_khoe", method = RequestMethod.GET)
	public void xoaThongSoSucKhoe(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
			throws NumberFormatException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		if (isBenhNhan(request, response, mm)) {
			String maBanGhi = request.getParameter("maBanGhi");
			int result=thongSoSucKhoeDAO.xoaThongSoSucKhoe(Integer.parseInt(maBanGhi));
			HttpSession session = request.getSession(false);
			if(result==0){
				session.setAttribute("them_xoa_sua", "thanhcong");
			}else{
				session.setAttribute("them_xoa_sua", "thatbai");
			}
			response.sendRedirect(request.getContextPath() + "/benhnhan/trang_chu?action=BCSK");
		}
	}

	// xem benh an
	@RequestMapping(value = "xem_chi_tiet_benh_an", method = RequestMethod.GET)
	public String xemChiTietBenhAn(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
			throws IOException, ParseException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		if (isBenhNhan(request, response, mm)) {
			String maBenhAn = request.getParameter("maBenhAn");
			BenhAn benhAn = benhAnDAO.layThongTinBenhAn(Integer.parseInt(maBenhAn));
			ArrayList<ChanDoan> danhSachChanDoan= chanDoanDAO.layDanhSachChanDoanTheoBenhAn(Integer.parseInt(maBenhAn));
			ArrayList<PhacDoDieuTri> danhSachPhacDo= phacDoDieuTriDAO.layDanhSachPhacDoTheoBenhAn(Integer.parseInt(maBenhAn));
			mm.put("benhAn", benhAn);
			mm.put("danhSachChanDoan", danhSachChanDoan);
			mm.put("danhSachPhacDo", danhSachPhacDo);
		}
		return "benhnhan/chi_tiet_benh_an";
	}

	// xem chan doan
	@RequestMapping(value = "xem_chi_tiet_chan_doan", method = RequestMethod.GET)
	public String xemChiTietChanDoan(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
			throws IOException, ParseException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		if (isBenhNhan(request, response, mm)) {
			String maChanDoan = request.getParameter("maChanDoan");
			ChanDoan chanDoan = chanDoanDAO.layThongTinChanDoan(Integer.parseInt(maChanDoan));
			mm.put("chanDoan", chanDoan);
		}
		return "benhnhan/chan_doan";
	}

	// xem phac do dieu tri
	@RequestMapping(value = "xem_chi_tiet_phac_do", method = RequestMethod.GET)
	public String xemChiTietPhacDo(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
			throws IOException, ParseException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		if (isBenhNhan(request, response, mm)) {
			String maPhacDo = request.getParameter("maPhacDo");
			PhacDoDieuTri phacDoDieuTri = phacDoDieuTriDAO.layThongTinPhacDo(Integer.parseInt(maPhacDo));
			mm.put("phacDoDieuTri", phacDoDieuTri);
		}
		return "benhnhan/phac_do";
	}
	

	// mới bổ xung
		@RequestMapping(value = "/doi_mat_khau", method = RequestMethod.GET)
		public String doiMatKhau(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
				throws IOException, ParseException {
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			if (isBenhNhan(request, response, mm)) {

			}
			return "benhnhan/doi_mat_khau";

		}

		// xu ly doi mat khau
		@RequestMapping(value = "/xu_ly_doi_mat_khau", method = RequestMethod.POST)
		public void doiMatKhauAdmin(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
				throws IOException, ParseException {
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			String matKhauCu = request.getParameter("matKhauCu");
			String matKhauMoi1 = request.getParameter("matKhauMoi1");
			String matKhauMoi2 = request.getParameter("matKhauMoi2");
			if (isBenhNhan(request, response, mm)) {
				HttpSession session = request.getSession();
				BenhNhan benhNhan = (BenhNhan) session.getAttribute("bn");
				if (matKhauCu.equals(benhNhan.getMatKhau())) {
						benhNhan.setMatKhau(matKhauMoi1);
						benhNhanDAO.suaBenhNhan(benhNhan);
						session.setAttribute("bn", benhNhan);
						response.sendRedirect(request.getContextPath() + "/benhnhan/trang_chu?action=TC");
				}else{
					response.sendRedirect(request.getContextPath() + "/benhnhan/doi_mat_khau");
				}
			}
		}
}
