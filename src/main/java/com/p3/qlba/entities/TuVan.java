/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.p3.qlba.entities;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;

/**
 *
 * @author tucng
 */
@Entity
@Table(name = "tu_van")
public class TuVan {
		private int maTuVan;
    private int nguoiGui;
    private String traLoi;
    private Date thoiGian = new Date();
    private int maBenhNhan;
    private int maBacSi;
    public TuVan(){}

    public TuVan(int nguoiGui, String traLoi,  int maBenhNhan, int maBacSi) {
        this.nguoiGui = nguoiGui;

        this.traLoi = traLoi;

        this.maBenhNhan = maBenhNhan;
        this.maBacSi = maBacSi;
    }

    public TuVan(int maBacSi, int maBenhNhan, int nguoiGui,
            String traLoi) {
    	this.nguoiGui=nguoiGui;
        this.traLoi = traLoi;
        this.maBenhNhan = maBenhNhan;
        this.maBacSi = maBacSi;
        // TODO Auto-generated constructor stub
    }



    public int getNguoiGui() {
        return nguoiGui;
    }

    public void setNguoiGui(int nguoiGui) {
        this.nguoiGui = nguoiGui;
    }
    public int getMaTuVan() {
        return maTuVan;
    }

    public void setMaTuVan(int maTuVan) {
        this.maTuVan = maTuVan;
    }


    public String getTraLoi() {
        return traLoi;
    }

    public void setTraLoi(String traLoi) {
        this.traLoi = traLoi;
    }


    public int getMaBenhNhan() {
        return maBenhNhan;
    }

    public void setMaBenhNhan(int maBenhNhan) {
        this.maBenhNhan = maBenhNhan;
    }

    public int getMaBacSi() {
        return maBacSi;
    }

    public void setMaBacSi(int maBacSi) {
        this.maBacSi = maBacSi;
    }
    public Date getThoiGian(){
    	return thoiGian;
    }
    public void setThoiGian(Date thoiGian){
    	this.thoiGian=thoiGian;
    }


}
