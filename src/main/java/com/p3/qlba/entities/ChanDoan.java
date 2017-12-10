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
@Table(name = "chan_doan")
public class ChanDoan {
    private int maChanDoan;
    private int maBenhAn;
    private String benhChinh;
    private String benhKemTheo;
    private Date ngayChanDoan;

    public int getMaChanDoan() {
        return maChanDoan;
    }

    public void setMaChanDoan(int maChanDoan) {
        this.maChanDoan = maChanDoan;
    }

    public int getMaBenhAn() {
        return maBenhAn;
    }

    public void setMaBenhAn(int maBenhAn) {
        this.maBenhAn = maBenhAn;
    }

    public String getBenhChinh() {
        return benhChinh;
    }

    public void setBenhChinh(String benhChinh) {
        this.benhChinh = benhChinh;
    }

    public String getBenhKemTheo() {
        return benhKemTheo;
    }

    public void setBenhKemTheo(String benhKemTheo) {
        this.benhKemTheo = benhKemTheo;
    }

    public Date getNgayChanDoan() {
        return ngayChanDoan;
    }

    public void setNgayChanDoan(Date ngayChanDoan) {
        this.ngayChanDoan = ngayChanDoan;
    }

    public ChanDoan(int maChanDoan, int maBenhNhan, String benhChinh, String benhKemTheo, Date ngayChanDoan) {
        this.maChanDoan = maChanDoan;
        this.maBenhAn = maBenhNhan;
        this.benhChinh = benhChinh;
        this.benhKemTheo = benhKemTheo;
        this.ngayChanDoan = ngayChanDoan;
    }

    public ChanDoan() {
    }


}
