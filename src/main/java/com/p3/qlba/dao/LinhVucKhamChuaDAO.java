package com.p3.qlba.dao;

import java.util.ArrayList;

import org.hibernate.Session;
import org.hibernate.Transaction;
import com.p3.qlba.util.HibernateUtil;
import com.p3.qlba.entities.BacSi;
import com.p3.qlba.entities.LinhVucKhamChua;
import com.p3.qlba.entities.ThongSoSucKhoe;
// lvkc
public class LinhVucKhamChuaDAO {
	// them
	public int themLinhVucKhamChua(LinhVucKhamChua linhVucKhamChua) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();
			session.save(linhVucKhamChua);
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
	public int suaLinhVucKhamChua(LinhVucKhamChua linhVucKhamChua) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();
			session.update(linhVucKhamChua);
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
	public int xoaLinhVucKhamChua(Integer maLinhVuc) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();
			LinhVucKhamChua linhVucKhamChua = session.get(LinhVucKhamChua.class, maLinhVuc);
			session.delete(linhVucKhamChua);
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

	public LinhVucKhamChua chiTietLinhVucKhamChua(int maLinhVuc) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		LinhVucKhamChua linhVucKhamChua = new LinhVucKhamChua();
		try {
			transaction = session.beginTransaction();
			linhVucKhamChua = session.get(LinhVucKhamChua.class, maLinhVuc);
			System.out.println(" Get OK");
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			session.close();
		}
		return linhVucKhamChua;
	}

	// get danh sach thong so suc khoe
	public ArrayList<LinhVucKhamChua> layDanhSachLinhVucKhamChua() {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		ArrayList<LinhVucKhamChua> list = null;
		transaction = session.beginTransaction();
		list = (ArrayList<LinhVucKhamChua>) session.createCriteria(LinhVucKhamChua.class).list();
		System.out.println("Get list OK");
		session.close();
		return list;
	}

	public void setQueryUnCheck() {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();
			session.createNativeQuery("SET FOREIGN_KEY_CHECKS = 0").executeUpdate();
			transaction.commit();

		} catch (Exception ex) {
			System.out.println(ex.toString());
		} finally {
			session.close();
		}
	}

	public void setQueryCheck() {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();
			session.createNativeQuery("SET FOREIGN_KEY_CHECKS = 1").executeUpdate();
			transaction.commit();

		} catch (Exception ex) {
			System.out.println(ex.toString());
		} finally {
			session.close();
		}
	}

	public int xoaLVKC(int id) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		BacSi bacSi = null;
		try {
			transaction = session.beginTransaction();
			LinhVucKhamChua linhVucKhamChua = session.get(LinhVucKhamChua.class, id);
			session.delete(linhVucKhamChua);
			transaction.commit();
			System.out.println("Delete OK");
		} catch (Exception ex) {
			System.out.println(ex.toString());
			return 1;
		} finally {
			session.close();
		}
		return 0;
	}
}
