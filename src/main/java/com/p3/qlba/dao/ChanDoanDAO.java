package com.p3.qlba.dao;

import java.util.ArrayList;

import javax.persistence.Query;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.p3.qlba.entities.ChanDoan;
import com.p3.qlba.entities.ChungChi;
import com.p3.qlba.util.HibernateUtil;

public class ChanDoanDAO {
	// them
	public int themChanDoan(ChanDoan chanDoan) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();
			session.save(chanDoan);
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
	public int suaChanDoan(ChanDoan chanDoan) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();
			session.update(chanDoan);
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
	public int xoaChanDoan(int maChanDoan) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();

			ChanDoan chanDoan = session.get(ChanDoan.class, maChanDoan);
			session.delete(chanDoan);
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

	// get 1 chan doan
	public ChanDoan layThongTinChanDoan(int maChanDoan) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		ChanDoan chanDoan = new ChanDoan();
		try {
			transaction = session.beginTransaction();
			chanDoan = session.get(ChanDoan.class, maChanDoan);
			System.out.println(" Get OK");
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			session.close();
		}
		return chanDoan;
	}

	public ArrayList<ChanDoan> layDanhSachChanDoanTheoBenhAn(int maBenhAn) {
		// get danh sach benh an theo ma benh nhan
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		ArrayList<ChanDoan> list = null;
		try {
			transaction = session.beginTransaction();
			String hql = "SELECT CD FROM ChanDoan CD" + " Where  CD.maBenhAn =:id";
			Query query = session.createQuery(hql);
			query.setParameter("id", maBenhAn);
			list = (ArrayList<ChanDoan>) query.getResultList();// lay phan tu
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

	// lay chan doan theo ma benh an
	public ArrayList<ChanDoan> layChanDoanTheoBenhAn(int maBenhAn) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		ArrayList<ChanDoan> chanDoan = null;
		try {
			transaction = session.beginTransaction();
			String hql = "SELECT CD FROM ChanDoan CD" + " Where  CD.maBenhAn =:id";
			Query query = session.createQuery(hql);
			query.setParameter("id", maBenhAn);
			// chanDoan = (ChanDoan) query.getSingleResult();// lay phan tu dau
			// // cua mang
			chanDoan = (ArrayList<ChanDoan>) query.getResultList();
			System.out.println(" Get OK");
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			session.close();
		}
		return chanDoan;
	}
	// public static void main(String[] args){
	// ChanDoanDAO chanDoanDAO = new ChanDoanDAO();
	// System.out.println(chanDoanDAO.layDanhSachChanDoanTheoBenhAn(2).size());
	// }

}
