package com.p3.qlba.dao;

import java.util.ArrayList;

import javax.persistence.Query;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.p3.qlba.entities.PhacDoDieuTri;
import com.p3.qlba.util.HibernateUtil;


public class PhacDoDieuTriDAO {
	// them
	public int themPhacDoDieuTri(PhacDoDieuTri phacDoDieuTri) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();
			session.save(phacDoDieuTri);
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
	public int suaPhacDoDieuTri(PhacDoDieuTri phacDoDieuTri) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();
			session.update(phacDoDieuTri);
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
	public int xoaPhacDoDieuTri(int maPhacDo) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();

			PhacDoDieuTri phacDoDieuTri = session.get(PhacDoDieuTri.class, maPhacDo);
			session.delete(phacDoDieuTri);
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

	// get
	public PhacDoDieuTri layThongTinPhacDo(int maPhacDo) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		PhacDoDieuTri phacDoDieuTri = new PhacDoDieuTri();
		try {
			transaction = session.beginTransaction();
			phacDoDieuTri = session.get(PhacDoDieuTri.class, maPhacDo);
			System.out.println(" Get OK");
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			session.close();
		}
		return phacDoDieuTri;
	}

	// get danh sach phac do cua 1 benh an
	public ArrayList<PhacDoDieuTri> layDanhSachPhacDoTheoBenhAn(int maBenhAn) {
		// get danh sach benh an theo ma benh nhan
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		ArrayList<PhacDoDieuTri> list = null;
		try {
			transaction = session.beginTransaction();
			String hql = "SELECT PD FROM PhacDoDieuTri PD" + " Where  PD.maBenhAn =:id";
			Query query = session.createQuery(hql);
			query.setParameter("id", maBenhAn);
			list = (ArrayList<PhacDoDieuTri>) query.getResultList();// lay phan tu
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
