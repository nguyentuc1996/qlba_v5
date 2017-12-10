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

public class OutputTuVan {
    private int nguoiGui;

    private String traLoi;
    private Date thoiGian = new Date();
    private int maBenhNhan;
    private String topic;
    private int maBacSi;

    public OutputTuVan(){}
    public OutputTuVan(int nguoiGui, String traLoi,  int maBenhNhan, int maBacSi) {
        this.nguoiGui = nguoiGui;

        this.traLoi = traLoi;
       
        this.maBenhNhan = maBenhNhan;
        this.maBacSi = maBacSi;
    }

    public OutputTuVan(int maBacSi, int maBenhNhan, int nguoiGui, String traLoi,String topic) {
    	this.nguoiGui=nguoiGui;
        this.traLoi = traLoi;
        this.topic=topic;
        this.maBenhNhan = maBenhNhan;
        this.maBacSi = maBacSi;
        this.topic=topic;
        System.out.println("hihi");
        // TODO Auto-generated constructor stub
    }
    public String getTopic()
    {
        return topic;
    }

    public void setTopic(String topic)
    {
        this.topic = topic;
    }
    public Date getTime()
    {
        return thoiGian;
    }    

    public int getNguoiGui() {
        return nguoiGui;
    }

    public void setNguoiGui(int nguoiGui) {
        this.nguoiGui = nguoiGui;
    }



    public String getTraLoi() {
        return traLoi;
    }

    public void setTraLoi(String traLoi) {
        this.traLoi = traLoi;
    }

    public Date getThoiGian() {
        return thoiGian;
    }

    public void setThoiGian(Date thoiGian) {
        this.thoiGian = thoiGian;
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
    
    
}
