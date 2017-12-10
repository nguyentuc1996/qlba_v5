package com.p3.qlba.dao;


import java.util.ArrayList;
import java.util.List;

import javax.persistence.Query;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

import com.p3.qlba.util.HibernateUtil;
import com.p3.qlba.entities.ChungChi;
import com.p3.qlba.entities.ThongSoSucKhoe;

public class ChungChiDAO {

	public int themChungChi(ChungChi chungChi) {
		// TODO Auto-generated method stub
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();
			session.save(chungChi);
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

	public int suaChungChi(ChungChi chungChi) {
		// TODO Auto-generated method stub
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();
			session.update(chungChi);
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
	public int xoaChungChi(int maChungChi, int maBacSi) {
		// TODO Auto-generated method stub
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();

			ChungChi chungChi = (ChungChi) session.createCriteria(ChungChi.class)
					.add(Restrictions.eq("maChungChi", maChungChi)).add(Restrictions.eq("maBacSi",maBacSi));
			session.delete(chungChi);
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

	public List<ChungChi> xemChungChi(int maBacSi) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		ArrayList<ChungChi> list = null;
		try {
			transaction = session.beginTransaction();
			list = (ArrayList<ChungChi>) session.createCriteria(ChungChi.class).add(Restrictions.eq("maBacSi",maBacSi)).list();
			System.out.println("Get List OK");
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			session.close();
		}
		return list;

	}

	// xoa
	public int xoaChungChi(int maChungChi) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();

			ChungChi chungChi = session.get(ChungChi.class, maChungChi);
			session.delete(chungChi);
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
	public ChungChi layThongTinChungChi(int maChungChi) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		ChungChi chungChi = new ChungChi();
		try {
			transaction = session.beginTransaction();
			chungChi = session.get(ChungChi.class, maChungChi);
			System.out.println(" Get OK");
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			session.close();
		}
		return chungChi;
	}
	public ArrayList<ChungChi> layDanhSachChungChiTheoBacSi(int maBacSi) {
		// get danh sach benh an theo ma benh nhan
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		ArrayList<ChungChi> list = null;
		try {
			transaction = session.beginTransaction();
			String hql = "SELECT CC FROM ChungChi CC" + " Where  CC.maBacSi =:id";
			Query query = session.createQuery(hql);
			query.setParameter("id", maBacSi);
			list = (ArrayList<ChungChi>) query.getResultList();// lay phan tu dau
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
