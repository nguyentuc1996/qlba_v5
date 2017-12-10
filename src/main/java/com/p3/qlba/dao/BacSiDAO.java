package com.p3.qlba.dao;

import java.util.ArrayList;

import javax.persistence.Query;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.p3.qlba.util.HibernateUtil;
import com.p3.qlba.entities.BacSi;
import com.p3.qlba.entities.BenhNhan;
import com.p3.qlba.entities.ThongSoSucKhoe;

public class BacSiDAO {
	// them
	public int themBacSi(BacSi bacSi) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();
			session.save(bacSi);
			transaction.commit();
			System.out.println("Save OK");
		} catch (Exception e) {
			e.printStackTrace();
			return 1;
		} finally {
			session.close();
		}
		return 0;
	}

	// sua
	public int suaBacSi(BacSi bacSi) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();
			session.update(bacSi);
			transaction.commit();
			System.out.println("Save OK");
		} catch (Exception e) {
			e.printStackTrace();
			return 1;
		} finally {
			session.close();
		}
		return 0;
	}

	// xoa
	public int xoaBacSi(Integer maBacSi) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();

			BacSi bacSi = session.get(BacSi.class, maBacSi);
			session.delete(bacSi);
			transaction.commit();
			System.out.println("Delete OK");
		} catch (Exception ex) {
			ex.printStackTrace();
			return 1;
		} finally {
			session.close();
		}
		return 0;
	}

	// get 1 bac si
	public BacSi layThongTinBacSi(int maBacSi) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		BacSi bacSi = new BacSi();
		try {
			transaction = session.beginTransaction();
			bacSi = session.get(BacSi.class, maBacSi);
			System.out.println(" Get OK");
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			session.close();
		}
		return bacSi;
	}

	// get danh sach bac si
	public ArrayList<BacSi> layDanhSachBacSi() {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		ArrayList<BacSi> list = null;
		try {
			transaction = session.beginTransaction();
			list = (ArrayList<BacSi>) session.createCriteria(BacSi.class).list();
			System.out.println("Get List OK");
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}

	// dang nhap
	public BacSi dangNhap(String taiKhoan, String matKhau) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		BacSi bacSi= null;
		try {
			transaction = session.beginTransaction();
			String hql = "SELECT BS FROM BacSi AS BS" + " Where  BS.taiKhoan =:taiKhoan"
					+ " AND BS.matKhau=:matKhau";

			Query query = session.createQuery(hql);
			query.setParameter("taiKhoan", taiKhoan);
			query.setParameter("matKhau", matKhau);
			bacSi = (BacSi) query.getResultList().get(0);// lay phan tu
																// dau cua //
																// mang
			System.out.println(" Get OK");
		} catch (Exception ex) {
			System.out.println(ex.toString());
		} finally {
			session.close();
		}
		return bacSi;
	}

//	public static void main(String[] args) {
//		BacSiDAO bacSiDAO = new BacSiDAO();
//		// BacSi bacSi= new BacSi();
//		// bacSi.setTaiKhoan("tucnguyen");
//		// bacSi.setMatKhau("B");
//		// bacSi.setHoTen("Nguyễn Văn Túc");
//		// bacSi.setGioiTinh(1);
//		// bacSiDAO.themBacSi(bacSi);
//		// System.out.println(bacSiDAO.layDanhSachThongSoSucKhoe());
//	}

}
