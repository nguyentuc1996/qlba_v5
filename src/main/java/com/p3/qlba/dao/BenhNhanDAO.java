package com.p3.qlba.dao;

import java.util.ArrayList;

import javax.persistence.Query;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.p3.qlba.util.HibernateUtil;
import com.p3.qlba.entities.BacSi;
import com.p3.qlba.entities.BenhNhan;

public class BenhNhanDAO {
	// them benh nhan
	public int themBenhNhan(BenhNhan benhNhan) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();
			session.save(benhNhan);
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

	// sua benh nhan
	public int suaBenhNhan(BenhNhan benhNhan) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();
			session.update(benhNhan);
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

	// xoa benh nhan
	public int xoaBenhNhan(Integer maBenhNhan) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();

			BenhNhan benhNhan = session.get(BenhNhan.class, maBenhNhan);
			session.delete(benhNhan);
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

	public BenhNhan layThongTinBenhNhan(int maBenhNhan) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		BenhNhan benhNhan = new BenhNhan();
		try {
			transaction = session.beginTransaction();
			benhNhan = session.get(BenhNhan.class, maBenhNhan);
			System.out.println(" Get OK");
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			session.close();
		}
		return benhNhan;
	}

	// get danh sach benh nhan

	public ArrayList<BenhNhan> layDanhSachBenhNhan() {
		Session session=HibernateUtil.getSessionFactory().openSession();
		Transaction transaction= null;
		ArrayList<BenhNhan> list =null;
		transaction= session.beginTransaction();
		list = (ArrayList<BenhNhan>) session.createCriteria(BenhNhan.class).list();
		System.out.println("Get list OK");
		session.close();
		return list;
	}

	// dang nhap
	public BenhNhan dangNhap(String taiKhoan, String matKhau){
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		BenhNhan benhNhan= null;
		try {
			transaction = session.beginTransaction();
			String hql = "SELECT BN FROM BenhNhan AS BN" + " Where  BN.taiKhoan =:taiKhoan"
					+ " AND BN.matKhau=:matKhau";

			Query query = session.createQuery(hql);
			query.setParameter("taiKhoan", taiKhoan);
			query.setParameter("matKhau", matKhau);
			benhNhan = (BenhNhan) query.getResultList().get(0);// lay phan tu dau cua														// mang
			System.out.println(" Get OK");
		} catch (Exception ex) {
			System.out.println(ex.toString());
		} finally {
			session.close();
		}
		return benhNhan;
	}


//	public static void main(String[] args){
////		BenhNhanDAO benhNhanDAO= new BenhNhanDAO();
////		System.out.println(benhNhanDAO.dangNhap("account", "password").getHoTen());
//	}

}
