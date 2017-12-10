/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.p3.qlba.entities;

import javax.persistence.Entity;
import javax.persistence.Table;

/**
 *
 * @author tucng
 */
@Entity
@Table(name = "linh_vuc_kham_chua")
public class LinhVucKhamChua {
    private int maLinhVuc;
    private String tenLinhVuc;
    private String moTa;

    // sua doi kieu dl
    public LinhVucKhamChua(int maLinhVuc, String tenLinhVuc, String moTa) {
        this.maLinhVuc = maLinhVuc;
        this.tenLinhVuc = tenLinhVuc;
        this.moTa = moTa;
    }

    public LinhVucKhamChua() {
    }

    public int getMaLinhVuc() {
        return maLinhVuc;
    }

    public void setMaLinhVuc(int maLinhVuc) {
        this.maLinhVuc = maLinhVuc;
    }

    public String getTenLinhVuc() {
        return tenLinhVuc;
    }

    public void setTenLinhVuc(String tenLinhVuc) {
        this.tenLinhVuc = tenLinhVuc;
    }

    public String getMoTa() {
        return moTa;
    }

    public void setMoTa(String moTa) {
        this.moTa = moTa;
    }
    
}
