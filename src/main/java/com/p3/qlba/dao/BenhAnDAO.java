package com.p3.qlba.dao;

import java.util.ArrayList;

import javax.persistence.Query;

import org.hibernate.Session;
import org.hibernate.Transaction;
import com.p3.qlba.util.HibernateUtil;
import com.p3.qlba.entities.BenhAn;

public class BenhAnDAO {
	// them
	public int themBenhAn(BenhAn benhAn) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();
			session.save(benhAn);
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
	public int suaBenhAn(BenhAn benhAn) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();
			session.update(benhAn);
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
	public int xoaBenhAn(Integer maBenhAn, Integer maBacSi) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();

			BenhAn benhAn = session.get(BenhAn.class, maBenhAn);
			Query query = session.createQuery("delete BenhAn where ma_nguoi_tao = :maBacSi and ma_benh_an=:maBenhAn");
			query.setParameter("maBacSi", maBacSi);
			query.setParameter("maBenhAn", maBenhAn);
			 
			int result = query.executeUpdate();
			 
			if (result > 0) {
			    System.out.println("Expensive products was removed");
			}
//			session.delete("from benh_an where ma_nguoi_tao="+maBacSi+" and maBenhAn="+maBenhAn);
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


	// get benh an
	public BenhAn layThongTinBenhAn(int maBenhAn) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		BenhAn benhAn = new BenhAn();
		try {
			transaction = session.beginTransaction();
			benhAn = session.get(BenhAn.class, maBenhAn);
			System.out.println(" Get OK");
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			session.close();
		}
		return benhAn;
	}

	// get danh sach benh an
	public ArrayList<BenhAn> layDanhSachBenhAn() {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		ArrayList<BenhAn> list = null;
		try {
			transaction = session.beginTransaction();
			list = (ArrayList<BenhAn>) session.createCriteria(BenhAn.class).list();
			System.out.println("Get List OK");
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}

	// get danh sach benh an theo ma benh nhan
	public ArrayList<BenhAn> layDanhSachBenhAnTheoBenhNhan(int maBenhNhan){
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		ArrayList<BenhAn> list = null;
		try {
			transaction = session.beginTransaction();
			String hql = "SELECT BA FROM BenhAn BA"
					+ " Where  BA.maBenhNhan =:id";
			Query query = session.createQuery(hql);
			query.setParameter("id", maBenhNhan);
			list =  (ArrayList<BenhAn>) query.getResultList();// lay phan tu dau cua mang
			System.out.println(" Get OK");
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}

	public ArrayList<BenhAn> layDanhSachBenhAnTheoBacSi(int maBacSi){
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		ArrayList<BenhAn> list = null;
		try {
			transaction = session.beginTransaction();
			String hql = "SELECT BA FROM BenhAn BA"
					+ " Where  BA.maNguoiTao =:id";
			Query query = session.createQuery(hql);
			query.setParameter("id", maBacSi);
			list =  (ArrayList<BenhAn>) query.getResultList();// lay phan tu dau cua mang
			System.out.println(" Get OK");
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}

}
