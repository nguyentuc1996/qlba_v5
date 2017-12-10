package com.p3.qlba.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

import com.p3.qlba.util.HibernateUtil;
import com.p3.qlba.entities.TuVan;
import com.p3.qlba.entities.TuVan;


public class TuVanDAO {
	public int taoCuocTuVan(String maBenhNhan, String maBacSi, String cauhoi,String nguoiGui){
		Session session = HibernateUtil.getSessionFactory().openSession();
		TuVan tuVan=new TuVan(Integer.parseInt(nguoiGui),Integer.parseInt(maBacSi),Integer.parseInt(maBenhNhan),cauhoi);
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();
			session.save(tuVan);
			transaction.commit();
			System.out.println("Save OK");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return 0;
	}
	public ArrayList<TuVan> getCuocTuVan(int maBacSi,int maBenhNhan){
		Session session=HibernateUtil.getSessionFactory().openSession();
		Transaction transaction= null;
		ArrayList<TuVan> list =null;
		transaction= session.beginTransaction();//get theo thoi gian
		System.out.println(maBacSi);
		System.out.println(maBenhNhan);
		list = (ArrayList<TuVan>) session.createCriteria(TuVan.class).add(Restrictions.eq("maBacSi", maBacSi))
				.add(Restrictions.eq("maBenhNhan", maBenhNhan)).setMaxResults(10).list();
		System.out.println("Get list OK");
		System.out.println(list.size());
		session.close();
		return list;
//		return tuVan;
	}
	public int updateCuocTuVan(String maBenhNhan, String maBacSi, String message){
		Session session = HibernateUtil.getSessionFactory().openSession();
		TuVan tuVan=new TuVan(Integer.parseInt(null),Integer.parseInt(maBacSi),Integer.parseInt(maBenhNhan),message);
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();
			session.save(tuVan);
			transaction.commit();
			System.out.println("Save OK");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return 0;
	}
	public List<TuVan> getNewer(String maBacSi, String maBenhNhan,Date thoiGian) {
		// TODO Auto-generated method stub
		Session session=HibernateUtil.getSessionFactory().openSession();
		Transaction transaction= null;
		ArrayList<TuVan> list =null;
		transaction= session.beginTransaction();
		list = (ArrayList<TuVan>) session.createCriteria(TuVan.class).add(Restrictions.gt("thoiGian", thoiGian))
				.list();
		System.out.println("Get list OK");
		session.close();
		return list;
	}
	public List<TuVan> getOlder(String maBacSi, String maBenhNhan, Date thoiGian) {
		// TODO Auto-generated method stub
		// TODO Auto-generated method stub
				Session session=HibernateUtil.getSessionFactory().openSession();
				Transaction transaction= null;
				ArrayList<TuVan> list =null;
				transaction= session.beginTransaction();
				list = (ArrayList<TuVan>) session.createCriteria(TuVan.class).add(Restrictions.lt("thoiGian", thoiGian))
						.list();
				System.out.println("Get list OK");
				session.close();
				return list;
	}
	public int taoTuVan(TuVan tuVan){
		Session session = HibernateUtil.getSessionFactory().openSession();
//		TuVan tuVan=new TuVan(Integer.parseInt(maBacSi),Integer.parseInt(maBenhNhan),cauhoi,"");
		Transaction transaction = null;
		try {
			transaction = session.beginTransaction();
			session.save(tuVan);
			transaction.commit();
			System.out.println("Save OK");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return 0;
	}

}
