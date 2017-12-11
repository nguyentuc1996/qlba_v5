package com.p3.qlba.controllers;

import java.io.IOException;
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

import com.p3.qlba.dao.BacSiDAO;
import com.p3.qlba.dao.BenhAnDAO;
import com.p3.qlba.dao.BenhNhanDAO;
import com.p3.qlba.dao.ChanDoanDAO;
import com.p3.qlba.dao.ChungChiDAO;
import com.p3.qlba.dao.LinhVucKhamChuaDAO;
import com.p3.qlba.dao.PhacDoDieuTriDAO;
import com.p3.qlba.entities.Admin;
import com.p3.qlba.entities.BacSi;
import com.p3.qlba.entities.BenhAn;
import com.p3.qlba.entities.BenhNhan;
import com.p3.qlba.entities.ChanDoan;
import com.p3.qlba.entities.ChungChi;
import com.p3.qlba.entities.LinhVucKhamChua;
import com.p3.qlba.entities.PhacDoDieuTri;

@Controller
@RequestMapping(value = "/bacsi")
public class BacSiController {
	private BenhAnDAO benhAnDAO = new BenhAnDAO();
	private BenhNhanDAO benhNhanDAO = new BenhNhanDAO();
	private LinhVucKhamChuaDAO linhVucKhamChuaDAO = new LinhVucKhamChuaDAO();
	private ChanDoanDAO chanDoanDAO = new ChanDoanDAO();
	private BacSiDAO bacSiDAO = new BacSiDAO();
	private ChungChiDAO chungChiDAO = new ChungChiDAO();
	private PhacDoDieuTriDAO phacDoDieuTriDAO = new PhacDoDieuTriDAO();

	private boolean isBacSi(HttpServletRequest request, HttpServletResponse response, ModelMap mm) throws IOException {
		HttpSession session = request.getSession();
		BacSi bs = (BacSi) session.getAttribute("bs");
		if (bs == null) {
			response.sendRedirect(request.getContextPath() + "/home/login.html");
			return false;
		} else {
			mm.put("bs", bs);
			return true;
		}
	}

	@RequestMapping(value = "/home_bac_si")
	public String home_bac_si(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
			throws IOException {
		if (isBacSi(request, response, mm)) {
			HttpSession session = request.getSession();
			BacSi bacSi = (BacSi) session.getAttribute("bs");
			mm.put("bs", bacSi);
		}
		return "bacsi/BS";
	}

	// trang chu
	@RequestMapping(value = "/trang_chu", method = RequestMethod.GET)
	public String trangChu(HttpServletRequest request, HttpServletResponse response, ModelMap mm) throws IOException {
		String action = request.getParameter("action");
		if (action.equals("TC")) { // trang chu
			if (isBacSi(request, response, mm)) {
				HttpSession session = request.getSession();
				BacSi bacSi = (BacSi) session.getAttribute("bs");
				mm.put("bs", bacSi);
			}
			return "bacsi/BS";

		} else if (action.equals("BA")) { // quan ly benh an
			if (isBacSi(request, response, mm)) {
				// lay benh an theo ma bac si
				HttpSession session = request.getSession();
				BacSi bacSi = (BacSi) session.getAttribute("bs");
				ArrayList<LinhVucKhamChua> linhVucKhamChua = linhVucKhamChuaDAO.layDanhSachLinhVucKhamChua();
				ArrayList<BenhNhan> danhSachBenhNhan= benhNhanDAO.layDanhSachBenhNhan();
				ArrayList<BenhAn> danhSachBenhAn = benhAnDAO.layDanhSachBenhAnTheoBacSi(bacSi.getMaBacSi());
				mm.put("linhVucKhamChua", linhVucKhamChua);
				mm.put("danhSachBenhAn", danhSachBenhAn);
				mm.put("danhSachBenhNhan", danhSachBenhNhan);
			}
			return "bacsi/quan_ly_benh_an";

		} else if (action.equals("TVSK")) {// tu van suc khoe
			if (isBacSi(request, response, mm)) {

			}
			return "";
		} else if (action.equals("QLCC")) {// quan ly chung chi
			if (isBacSi(request, response, mm)) {
				HttpSession session = request.getSession();
				BacSi bacSi = (BacSi) session.getAttribute("bs");
				ArrayList<ChungChi> danhSachChungChi = chungChiDAO.layDanhSachChungChiTheoBacSi(bacSi.getMaBacSi());
				mm.put("danhSachChungChi", danhSachChungChi);
			}
			return "bacsi/chung_chi";
		} else {
			return "";
		}
	}

	// sua thong tin bac si
	@RequestMapping(value = "/sua_thong_tin_bac_si", method = RequestMethod.POST)
	public void suaThongTinBacSi(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
			throws IOException, ParseException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		if (isBacSi(request, response, mm)) {
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
			System.out.println(maBacSi);
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
			response.sendRedirect(request.getContextPath() + "/bacsi/trang_chu.html?action=TC");
		}
	}

	// quan ly benh an
	@RequestMapping(value = "them_benh_an", method = RequestMethod.POST)
	public void themBenhAn(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
			throws ParseException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		if (isBacSi(request, response, mm)) {
			HttpSession session = request.getSession();
			BacSi bacSi = (BacSi) session.getAttribute("bs");
			// tu form them benh an
			String ma_benh_nhan = request.getParameter("maBenhNhan");
			// lay du lieu tu form
			String ma_linh_vuc = request.getParameter("maLinhVuc");
			// co the auto lay san
			String ngay_kham = request.getParameter("ngayKham");
			String ly_do_di_kham = request.getParameter("lyDoKham");
			String qua_trinh_benh_ly = request.getParameter("quaTrinhBenhLy");
			String tien_su_lien_quan = request.getParameter("tieuSuLienQuan");
			String huong_dieu_tri = request.getParameter("huongDieuTri");
			String tom_tat_benh_an = request.getParameter("tomTatBenhAn");
			String khac = request.getParameter("khac");
			// convert du lieu
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			Date ngayKham = formatter.parse(ngay_kham);

			BenhAn benhAn = new BenhAn();
			benhAn.setMaBenhNhan(Integer.parseInt(ma_benh_nhan));
			benhAn.setMaLinhVuc(Integer.parseInt(ma_linh_vuc));
			benhAn.setNgayKham(ngayKham);
			benhAn.setLyDoKham(ly_do_di_kham);
			benhAn.setQuaTrinhBenhLy(qua_trinh_benh_ly);
			benhAn.setTienSuLienQuan(tien_su_lien_quan);
			benhAn.setHuongDieuTri(huong_dieu_tri);
			benhAn.setTomTatBenhAn(tom_tat_benh_an);
			benhAn.setKhac(khac);
			benhAn.setNgayTao(new Date());
			// ma nguoi tao
			benhAn.setMaNguoiTao(bacSi.getMaBacSi());
			int result = benhAnDAO.themBenhAn(benhAn);
			// HttpSession session = request.getSession(false);
			if (result == 0) {
				session.setAttribute("them_xoa_sua", "thanhcong");
			} else {
				session.setAttribute("them_xoa_sua", "thatbai");
			}
			response.sendRedirect(request.getContextPath() + "/bacsi/trang_chu.html?action=BA");
		}
	}

	// sua benh an
	@RequestMapping(value = "sua_benh_an", method = RequestMethod.POST)
	public void suaBenhAn(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
			throws ParseException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		if (isBacSi(request, response, mm)) {
			// tu form them benh an
			String maBenhAn = request.getParameter("maBenhAn");
			// lay du lieu tu form
			// co the auto lay san
			String ngayKham = request.getParameter("ngayKham");
			String lyDoDiKham = request.getParameter("lyDoKham");
			String quaTrinhBenhLy = request.getParameter("quaTrinhBenhLy");
			String tienSuLienQuan = request.getParameter("tienSuLienQuan");
			String huongDieuTri = request.getParameter("huongDieuTri");
			String tomTatBenhAn = request.getParameter("tomTatBenhAn");
			String khac = request.getParameter("khac");
			// convert du lieu
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			Date ngayKhamD = formatter.parse(ngayKham);

			BenhAn benhAn = benhAnDAO.layThongTinBenhAn(Integer.parseInt(maBenhAn));

			benhAn.setNgayKham(ngayKhamD);
			benhAn.setLyDoKham(lyDoDiKham);
			benhAn.setQuaTrinhBenhLy(quaTrinhBenhLy);
			benhAn.setTienSuLienQuan(tienSuLienQuan);
			benhAn.setHuongDieuTri(huongDieuTri);
			benhAn.setTomTatBenhAn(tomTatBenhAn);
			benhAn.setKhac(khac);

			int result = benhAnDAO.suaBenhAn(benhAn);
			HttpSession session = request.getSession(false);
			if (result == 0) {
				session.setAttribute("them_xoa_sua", "thanhcong");
			} else {
				session.setAttribute("them_xoa_sua", "thatbai");
			}
			response.sendRedirect(request.getContextPath() + "/bacsi/trang_chu.html?action=BA");
		}
	}

	// xoa benh an
	@RequestMapping(value = "/xoa_benh_an", method = RequestMethod.GET)
	public void xoaBenhAn(ModelMap mm, HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		if (isBacSi(request, response, mm)) {
			String id = request.getParameter("id");
			linhVucKhamChuaDAO.setQueryUnCheck();
			HttpSession session = request.getSession();
			BacSi bacSi = (BacSi) session.getAttribute("bs");
			// int bsid=bacSi.getMaBacSi();
			int result = benhAnDAO.xoaBenhAn(Integer.parseInt(id), bacSi.getMaBacSi());
			linhVucKhamChuaDAO.setQueryCheck();

			if (result == 0) {
				session.setAttribute("them_xoa_sua", "thanhcong");
			} else {
				session.setAttribute("them_xoa_sua", "thatbai");
			}
			response.sendRedirect(request.getContextPath() + "/bacsi/trang_chu.html?action=BA");
		}
	}

	@RequestMapping(value = "/lay_thong_tin_benh_an", method = RequestMethod.GET)
	public String layThongTin(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
			throws IOException, ParseException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		if (isBacSi(request, response, mm)) {
			String maBenhAn = request.getParameter("id");
			int maBA = Integer.parseInt(maBenhAn);
			BenhAn benhAn = benhAnDAO.layThongTinBenhAn(Integer.parseInt(maBenhAn));
			List<ChanDoan> chanDoan = chanDoanDAO.layChanDoanTheoBenhAn(maBA);
			List<PhacDoDieuTri> phacDo = phacDoDieuTriDAO.layDanhSachPhacDoTheoBenhAn(maBA);
			BenhNhan benhNhan = benhNhanDAO.layThongTinBenhNhan(benhAn.getMaBenhNhan());
			List<LinhVucKhamChua> linhVucKhamChua = linhVucKhamChuaDAO.layDanhSachLinhVucKhamChua();

			mm.put("linhVucKhamChua", linhVucKhamChua);
			mm.put("benhNhan", benhNhan);
			mm.put("benhAn", benhAn);
			mm.put("chanDoan", chanDoan);
			mm.put("phacDo", phacDo);
		}
		return "bacsi/benh_an_chi_tiet";
	}

	// quan ly phác đồ điều trị
	@RequestMapping(value = "/home_phac_do", method = RequestMethod.GET)
	public String danhSachPhacDo(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
			throws NumberFormatException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		if (isBacSi(request, response, mm)) {
			String maBenhAn = request.getParameter("maBenhAn");
			ArrayList<PhacDoDieuTri> dSPhacDoDieuTri = (ArrayList<PhacDoDieuTri>) phacDoDieuTriDAO
					.layDanhSachPhacDoTheoBenhAn(Integer.parseInt(maBenhAn));
			mm.put("danhSachPhacDoDieuTri", dSPhacDoDieuTri);
		}
		return "bacsi/phac_do_dieu_tri";
	}

	@RequestMapping(value = "/viet_phac_do", method = RequestMethod.POST)
	public void vietPhacDo(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
			throws IOException, ParseException {
		if (isBacSi(request, response, mm)) {
			// tu form them benh an
			String maBenhAn = request.getParameter("maBenhAn");
			// lay du lieu tu form
			String tieuDe = request.getParameter("tieuDe");
			String thoiGian = request.getParameter("thoiGian");
			String noiDung = request.getParameter("noiDung");
			String ngayTao = request.getParameter("ngayTao");
			String nhacNho = request.getParameter("nhacNho");
			Boolean nhacNhoB = false;
			// if (nhacNho.equals("Co")) {
			// nhacNhoB = true;
			// }
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date thoiGianD = sdf.parse(thoiGian);
			Date ngayTaoD = sdf.parse(ngayTao);

			PhacDoDieuTri phacDoDieuTri = new PhacDoDieuTri();
			phacDoDieuTri.setMaBenhAn(Integer.parseInt(maBenhAn));
			phacDoDieuTri.setTieuDe(tieuDe);
			phacDoDieuTri.setThoiGian(thoiGianD);
			phacDoDieuTri.setNoiDung(noiDung);
			phacDoDieuTri.setNgayTao(ngayTaoD);
			phacDoDieuTri.setNhacNho(0);
			int result = phacDoDieuTriDAO.themPhacDoDieuTri(phacDoDieuTri);
			HttpSession session = request.getSession(false);
			if (result == 0) {
				session.setAttribute("them_xoa_sua", "thanhcong");
			} else {
				session.setAttribute("them_xoa_sua", "thatbai");
			}
			response.sendRedirect(request.getContextPath() + "/bacsi/home_bac_si?action=BA");
		}

	}

	@RequestMapping(value = "/quan_ly_phac_do", method = RequestMethod.GET)
	public void quanLyPhacDo(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
			throws IOException, ParseException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		String action = request.getParameter("action");
		if (action.equals("viet_phac_do")) {
			if (isBacSi(request, response, mm)) {
				// tu form them benh an
				String maBenhAn = request.getParameter("maBenhAn");
				// lay du lieu tu form
				String tieuDe = request.getParameter("tieuDe");
				String thoiGian = request.getParameter("thoiGian");// ngay va
																	// viec lam
																	// tuong ung
																	// voi ngay
																	// do
				String noiDung = request.getParameter("noiDung");
				String ngayTao = request.getParameter("ngayTao");
				String nhacNho = request.getParameter("nhacNho");
				Boolean nhacNhoB = false;
				if (nhacNho.equals("Co")) {
					nhacNhoB = true;
				}
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				Date thoiGianD = sdf.parse(thoiGian);
				Date ngayTaoD = sdf.parse(ngayTao);

				PhacDoDieuTri phacDoDieuTri = new PhacDoDieuTri();
				phacDoDieuTri.setMaBenhAn(Integer.parseInt(maBenhAn));
				phacDoDieuTri.setTieuDe(tieuDe);
				phacDoDieuTri.setThoiGian(thoiGianD);
				phacDoDieuTri.setNoiDung(noiDung);
				phacDoDieuTri.setNgayTao(ngayTaoD);
				phacDoDieuTri.setNhacNho(0);
				int result = phacDoDieuTriDAO.themPhacDoDieuTri(phacDoDieuTri);
				HttpSession session = request.getSession(false);
				if (result == 0) {
					session.setAttribute("them_xoa_sua", "thanhcong");
				} else {
					session.setAttribute("them_xoa_sua", "thatbai");
				}
				response.sendRedirect(request.getContextPath() + "/bacsi/lay_thong_tin_benh_an.html?id="
						+ phacDoDieuTri.getMaBenhAn());
			}

		} else {// xoa phac do
			// String maPhacDo = request.getParameter("maPhacDo");
			// int result =
			// phacDoDieuTriDAO.xoaPhacDoDieuTri(Integer.parseInt(maPhacDo));
			// PhacDoDieuTri phacDoDieuTri =
			// phacDoDieuTriDAO.layThongTinPhacDo(Integer.parseInt(maPhacDo));
			// HttpSession session = request.getSession(false);
			// if (result == 0) {
			// session.setAttribute("them_xoa_sua", "thanhcong");
			// } else {
			// session.setAttribute("them_xoa_sua", "thatbai");
			// }
			// response.sendRedirect(
			// request.getContextPath() +
			// "/bacsi/lay_thong_tin_benh_an.html?id=" +
			// phacDoDieuTri.getMaBenhAn());
		}
	}

	// sửa pháp đồ
	@RequestMapping(value = "/sua_phac_do", method = RequestMethod.POST)
	public void suaPhacDo(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
			throws IOException, ParseException {
		if (isBacSi(request, response, mm)) {
			String maPhacDo = request.getParameter("maPhacDo");
			String tieuDe = request.getParameter("tieuDe");
			String thoiGian = request.getParameter("thoiGian");// ngay va
																// viec lam
																// tuong ung
																// voi ngay
																// do
			String noiDung = request.getParameter("noiDung");

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date thoiGianD = sdf.parse(thoiGian);
			PhacDoDieuTri phacDoDieuTri = phacDoDieuTriDAO.layThongTinPhacDo(Integer.parseInt(maPhacDo));
			phacDoDieuTri.setTieuDe(tieuDe);
			phacDoDieuTri.setThoiGian(thoiGianD);
			phacDoDieuTri.setNoiDung(noiDung);
			int result = phacDoDieuTriDAO.suaPhacDoDieuTri(phacDoDieuTri);
			HttpSession session = request.getSession(false);
			if (result == 0) {
				session.setAttribute("them_xoa_sua", "thanhcong");
			} else {
				session.setAttribute("them_xoa_sua", "thatbai");
			}
			response.sendRedirect(
					request.getContextPath() + "/bacsi/lay_thong_tin_benh_an.html?id=" + phacDoDieuTri.getMaBenhAn());
		}

	}

	// xóa phác đồ
	@RequestMapping(value = "/xoa_phac_do", method = RequestMethod.GET)
	public void xoaPhacDo(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
			throws IOException, ParseException {
		if (isBacSi(request, response, mm)) {
			String maPhacDo = request.getParameter("maPhacDo");
			PhacDoDieuTri phacDoDieuTri = phacDoDieuTriDAO.layThongTinPhacDo(Integer.parseInt(maPhacDo));
			int result = phacDoDieuTriDAO.xoaPhacDoDieuTri(Integer.parseInt(maPhacDo));
			HttpSession session = request.getSession(false);
			if (result == 0) {
				session.setAttribute("them_xoa_sua", "thanhcong");
			} else {
				session.setAttribute("them_xoa_sua", "thatbai");
			}
			response.sendRedirect(
					request.getContextPath() + "/bacsi/lay_thong_tin_benh_an.html?id=" + phacDoDieuTri.getMaBenhAn());
		}

	}

	// quan ly chan doan
	@RequestMapping(value = "/home_chan_doan", method = RequestMethod.GET)
	public String danhSachChanDoan(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
			throws NumberFormatException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		if (isBacSi(request, response, mm)) {
			String maBenhAn = request.getParameter("maBenhAn");
			ArrayList<ChanDoan> chanDoan = chanDoanDAO.layChanDoanTheoBenhAn(Integer.parseInt(maBenhAn));
			mm.put("chandoan", chanDoan);
		}
		return "bacsi/chan_doan";
	}

	@RequestMapping(value = "/viet_chan_doan", method = RequestMethod.POST)
	public void vietChanDoan(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
			throws IOException, ParseException {
		if (isBacSi(request, response, mm)) {
			// tu form them benh an
			String maBenhAn = request.getParameter("maBenhAn");
			// lay du lieu tu form
			String ngayChanDoan = request.getParameter("ngayChanDoan");
			String benhChinh = request.getParameter("benhChinh");
			String benhKemTheo = request.getParameter("benhKemTheo");

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date ngayCD = sdf.parse(ngayChanDoan);
			ChanDoan chanDoan = new ChanDoan();
			chanDoan.setMaBenhAn(Integer.parseInt(maBenhAn));
			chanDoan.setBenhChinh(benhChinh);
			chanDoan.setBenhKemTheo(benhKemTheo);
			chanDoan.setNgayChanDoan(ngayCD);
			int result = chanDoanDAO.themChanDoan(chanDoan);
			HttpSession session = request.getSession(false);
			if (result == 0) {
				session.setAttribute("them_xoa_sua", "thanhcong");
			} else {
				session.setAttribute("them_xoa_sua", "thatbai");
			}
			response.sendRedirect(request.getContextPath() + "/bacsi/home_bac_si?action=BA");
		}
	}

	// sua chan doan
	@RequestMapping(value = "/sua_chan_doan", method = RequestMethod.POST)
	public void suaChanDoan(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
			throws IOException, ParseException {
		if (isBacSi(request, response, mm)) {
			// lay benh an theo ma bac si
			String maChanDoan = request.getParameter("maChanDoan");
			String benhChinh = request.getParameter("benhChinh");
			String benhKemTheo = request.getParameter("benhKemTheo");

			ChanDoan chanDoan = chanDoanDAO.layThongTinChanDoan(Integer.parseInt(maChanDoan));
			chanDoan.setBenhChinh(benhChinh);
			chanDoan.setBenhKemTheo(benhKemTheo);
			int result = chanDoanDAO.suaChanDoan(chanDoan);
			HttpSession session = request.getSession(false);
			if (result == 0) {
				session.setAttribute("them_xoa_sua", "thanhcong");
			} else {
				session.setAttribute("them_xoa_sua", "thatbai");
			}
			response.sendRedirect(
					request.getContextPath() + "/bacsi/lay_thong_tin_benh_an.html?id=" + chanDoan.getMaBenhAn());
		}
	}

	// xoa chan doan
	@RequestMapping(value = "/xoa_chan_doan", method = RequestMethod.GET)
	public void xoaChanDoan(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
			throws IOException, ParseException {
		if (isBacSi(request, response, mm)) {
			String maChanDoan = request.getParameter("maChanDoan");
			ChanDoan chanDoan = chanDoanDAO.layThongTinChanDoan(Integer.parseInt(maChanDoan));
			int result = chanDoanDAO.xoaChanDoan(Integer.parseInt(maChanDoan));
			HttpSession session = request.getSession(false);
			if (result == 0) {
				session.setAttribute("them_xoa_sua", "thanhcong");
			} else {
				session.setAttribute("them_xoa_sua", "thatbai");
			}
			response.sendRedirect(
					request.getContextPath() + "/bacsi/lay_thong_tin_benh_an.html?id=" + chanDoan.getMaBenhAn());
		}
	}

	@RequestMapping(value = "/quan_ly_chan_doan", method = RequestMethod.GET)
	public void quanLyChanDoan(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
			throws IOException, ParseException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		String action = request.getParameter("action");
		if (action.equals("viet_chan_doan")) {
			if (isBacSi(request, response, mm)) {
				// tu form them benh an
				String maBenhAn = request.getParameter("maBenhAn");
				// lay du lieu tu form
				String ngayChanDoan = request.getParameter("ngayChanDoan");
				String benhChinh = request.getParameter("benhChinh");
				String benhKemTheo = request.getParameter("benhKemTheo");

				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				Date ngayCD = sdf.parse(ngayChanDoan);
				ChanDoan chanDoan = new ChanDoan();
				chanDoan.setMaBenhAn(Integer.parseInt(maBenhAn));
				chanDoan.setBenhChinh(benhChinh);
				chanDoan.setBenhKemTheo(benhKemTheo);
				chanDoan.setNgayChanDoan(ngayCD);
				int result = chanDoanDAO.themChanDoan(chanDoan);
				HttpSession session = request.getSession(false);
				if (result == 0) {
					session.setAttribute("them_xoa_sua", "thanhcong");
				} else {
					session.setAttribute("them_xoa_sua", "thatbai");
				}
				response.sendRedirect(request.getContextPath() + "/bacsi/home_chan_doan.html");
			}

		} else if (action.equals("sua_chan_doan")) {// khong dung
			if (isBacSi(request, response, mm)) {
				// lay benh an theo ma bac si
				String maChanDoan = request.getParameter("maChanDoan");
				String benhChinh = request.getParameter("benhChinh");
				String benhKemTheo = request.getParameter("benhKemTheo");

				ChanDoan chanDoan = chanDoanDAO.layThongTinChanDoan(Integer.parseInt(maChanDoan));
				chanDoan.setBenhChinh(benhChinh);
				chanDoan.setBenhKemTheo(benhKemTheo);
				int result = chanDoanDAO.suaChanDoan(chanDoan);
				HttpSession session = request.getSession(false);
				if (result == 0) {
					session.setAttribute("them_xoa_sua", "thanhcong");
				} else {
					session.setAttribute("them_xoa_sua", "thatbai");
				}
				response.sendRedirect(request.getContextPath() + "/bacsi/home_chan_doan.html");
			}
		} else {// khong dung
			String maChanDoan = request.getParameter("maChanDoan");
			int result = chanDoanDAO.xoaChanDoan(Integer.parseInt(maChanDoan));
			HttpSession session = request.getSession(false);
			if (result == 0) {
				session.setAttribute("them_xoa_sua", "thanhcong");
			} else {
				session.setAttribute("them_xoa_sua", "thatbai");
			}
			response.sendRedirect(request.getContextPath() + "/bacsi/home_chan_doan.html");
		}
	}

	// quan ly chung chi
	@RequestMapping(value = "/them_chung_chi", method = RequestMethod.POST)
	public void themChungChi(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
			throws IOException, ParseException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		if (isBacSi(request, response, mm)) {
			HttpSession session = request.getSession();
			BacSi bacSi = (BacSi) session.getAttribute("bs");
			int maBacSi = bacSi.getMaBacSi();
			String tenChungChi = request.getParameter("tenChungChi");
			String ngayNhan = request.getParameter("ngayNhan");
			String ngayHetHan = request.getParameter("ngayHetHan");
			String moTa = request.getParameter("moTa");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			ChungChi chungChi = new ChungChi(maBacSi, tenChungChi, sdf.parse(ngayNhan), sdf.parse(ngayHetHan), moTa);
			int result = chungChiDAO.themChungChi(chungChi);
			// HttpSession session = request.getSession(false);
			if (result == 0) {
				session.setAttribute("them_xoa_sua", "thanhcong");
			} else {
				session.setAttribute("them_xoa_sua", "thatbai");
			}
			response.sendRedirect(request.getContextPath() + "/bacsi/trang_chu.html?action=QLCC");
		}
	}

	@RequestMapping(value = "/sua_chung_chi", method = RequestMethod.POST)
	public void suaChungChi(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
			throws IOException, NumberFormatException, ParseException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		if (isBacSi(request, response, mm)) {
			HttpSession session = request.getSession();
			BacSi bacSi = (BacSi) session.getAttribute("bs");
			String maChungChi = request.getParameter("maChungChi");
			int maBacSi = bacSi.getMaBacSi();
			String tenChungChi = request.getParameter("tenChungChi");
			String ngayNhan = request.getParameter("ngayNhan");
			String ngayHetHan = request.getParameter("ngayHetHan");
			String moTa = request.getParameter("moTa");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			ChungChi chungChi = new ChungChi(Integer.parseInt(maChungChi), maBacSi, tenChungChi, sdf.parse(ngayNhan),
					sdf.parse(ngayHetHan), moTa);
			int result = chungChiDAO.suaChungChi(chungChi);
			// HttpSession session = request.getSession(false);
			if (result == 0) {
				session.setAttribute("them_xoa_sua", "thanhcong");
			} else {
				session.setAttribute("them_xoa_sua", "thatbai");
			}
			response.sendRedirect(request.getContextPath() + "/bacsi/trang_chu.html?action=QLCC");
		}
	}

	@RequestMapping(value = "/xoa_chung_chi", method = RequestMethod.GET)
	public void xoaChungChi(HttpServletRequest request, HttpServletResponse response, ModelMap mm) throws IOException {
		if (isBacSi(request, response, mm)) {
			HttpSession session = request.getSession();
			BacSi bacSi = (BacSi) session.getAttribute("bs");
			int maBacSi = bacSi.getMaBacSi();
			String maChungChi = request.getParameter("maChungChi");
			ChungChi chungChi = chungChiDAO.layThongTinChungChi(Integer.parseInt(maChungChi));
			int result = 1;
			if (chungChi.getMaBacSi() == maBacSi) {
				result = chungChiDAO.xoaChungChi(Integer.parseInt(maChungChi));
			}
			// HttpSession session = request.getSession(false);
			if (result == 0) {
				session.setAttribute("them_xoa_sua", "thanhcong");
			} else {
				session.setAttribute("them_xoa_sua", "thatbai");
			}
			response.sendRedirect(request.getContextPath() + "/bacsi/trang_chu.html?action=QLCC");
		}
	}

	@RequestMapping(value = "/xem_chi_tiet_chung_chi", method = RequestMethod.POST)
	public String xemChungChi(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
			throws IOException {
		String maChungChi = request.getParameter("maChungChi");
		ChungChi chungChi = chungChiDAO.layThongTinChungChi(Integer.parseInt(maChungChi));
		mm.put("chungChi", chungChi);
		return "bacsi/chi_tiet_chung_chi";
	}

	// mới bổ xung
	@RequestMapping(value = "/doi_mat_khau", method = RequestMethod.GET)
	public String doiMatKhau(HttpServletRequest request, HttpServletResponse response, ModelMap mm)
			throws IOException, ParseException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		if (isBacSi(request, response, mm)) {

		}
		return "bacsi/doi_mat_khau";

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
		if (isBacSi(request, response, mm)) {
			HttpSession session = request.getSession();
			BacSi bacSi = (BacSi) session.getAttribute("bs");
			if (matKhauCu.equals(bacSi.getMatKhau())) {
					bacSi.setMatKhau(matKhauMoi1);
					bacSiDAO.suaBacSi(bacSi);
					session.setAttribute("bs", bacSi);
					response.sendRedirect(request.getContextPath() + "/bacsi/trang_chu.html?action=TC");
			}else{
				response.sendRedirect(request.getContextPath() + "/bacsi/doi_mat_khau");
			}
		}
	}
}
