package com.p3.qlba.dao;

import java.util.ArrayList;

import javax.persistence.Query;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

import com.p3.qlba.util.HibernateUtil;
import com.p3.qlba.entities.BenhNhan;
import com.p3.qlba.entities.ThongSoSucKhoe;

public class ThongSoSucKhoeDAO {
	// them
	public int themThongSoSucKhoe(ThongSoSucKhoe thongSoSucKhoe) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();
			session.save(thongSoSucKhoe);
			transaction.commit();
			System.out.println("Save OK");
		} catch (Exception e) {
			e.printStackTrace();
			return 1;
		} finally {
			session.close();
			return 0;
		}
	}

	// sua
	public int suaThongSoSucKhoe(ThongSoSucKhoe thongSoSucKhoe) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();
			session.update(thongSoSucKhoe);
			transaction.commit();
			System.out.println("Save OK");
		} catch (Exception e) {
			e.printStackTrace();
			return 1;
		} finally {
			session.close();
			return 0;
		}
	}

	// xoa
	public int xoaThongSoSucKhoe(Integer maThongSoSucKhoe) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();

			ThongSoSucKhoe thongSoSucKhoe = session.get(ThongSoSucKhoe.class, maThongSoSucKhoe);
			session.delete(thongSoSucKhoe);
			transaction.commit();
			System.out.println("Delete OK");
		} catch (Exception ex) {
			ex.printStackTrace();
			return 1;
		} finally {
			session.close();
			return 0;
		}
	}

	public ThongSoSucKhoe layThongTinThongSoSucKhoe(int maThongSoSucKhoe) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		ThongSoSucKhoe thongSoSucKhoe = new ThongSoSucKhoe();
		try {
			transaction = session.beginTransaction();
			thongSoSucKhoe = session.get(ThongSoSucKhoe.class, maThongSoSucKhoe);
			System.out.println(" Get OK");
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			session.close();
		}
		return thongSoSucKhoe;
	}

	public ThongSoSucKhoe layThongSoSucKhoeCuaBenhNhan(int maBenhNhan) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		ThongSoSucKhoe thongSoSucKhoe = new ThongSoSucKhoe();
		try {
			transaction = session.beginTransaction();
			thongSoSucKhoe = (ThongSoSucKhoe) session.createCriteria(ThongSoSucKhoe.class).add(Restrictions.eq("maBenhNhan", maBenhNhan));
			System.out.println(" Get OK");
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			session.close();
		}
		return thongSoSucKhoe;
	}


	public ArrayList<ThongSoSucKhoe> layDanhSachThongSoSucKhoeTheoBenhNhan(int id) {
		// get danh sach benh an theo ma benh nhan
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		ArrayList<ThongSoSucKhoe> list = null;
		try {
			transaction = session.beginTransaction();
			String hql = "SELECT TSSK FROM ThongSoSucKhoe TSSK" + " Where  TSSK.maBenhNhan =:id";
			Query query = session.createQuery(hql);
			query.setParameter("id", id);
			list = (ArrayList<ThongSoSucKhoe>) query.getResultList();// lay phan
																		// tu
			// dau
			// cua mang
			System.out.println(" Get OK");
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}
}
