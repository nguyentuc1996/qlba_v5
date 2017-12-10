package com.p3.qlba.controllers;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageExceptionHandler;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.annotation.SendToUser;
//
//import org.springframework.messaging.handler.annotation.DestinationVariable;
//import org.springframework.messaging.handler.annotation.MessageMapping;
//import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.p3.qlba.dao.BacSiDAO;
import com.p3.qlba.dao.BenhNhanDAO;
import com.p3.qlba.dao.TuVanDAO;
import com.p3.qlba.entities.BacSi;
import com.p3.qlba.entities.BenhNhan;
import com.p3.qlba.entities.Message;
import com.p3.qlba.entities.OutputMessage;
import com.p3.qlba.entities.OutputTuVan;
import com.p3.qlba.entities.TuVan;

@Controller
public class TuVanController {
	BacSiDAO bacSiDAO=new BacSiDAO();
	BenhNhanDAO benhNhanDAO=new BenhNhanDAO();
	TuVanDAO tuVanDAO=new TuVanDAO();


  @RequestMapping(value="/tuvan",method=RequestMethod.GET)
  public String getCuocTuVan(HttpServletRequest request, HttpServletResponse response, ModelMap mm,Model model){
		HttpSession session = request.getSession();
		BacSi bs = (BacSi) session.getAttribute("bs");
		String target = request.getParameter("target");
		System.out.println(target);
		BenhNhan bn =(BenhNhan) session.getAttribute("bn");
			if (bn != null) {

				ArrayList<BacSi> listBacSi=bacSiDAO.layDanhSachBacSi();
				
				if(target!=null){
					ArrayList<TuVan> cuocTuVan=tuVanDAO.getCuocTuVan(Integer.parseInt(target), bn.getMaBenhNhan());
					mm.put("cuocTuVan", cuocTuVan);
					BacSi bss=bacSiDAO.layThongTinBacSi(Integer.parseInt(target));
					mm.put("bacsi", bss);
				}else{
					target="0";
				}
				
				mm.put("dsBacSi", listBacSi);
				session.setAttribute("nguoiGui", 0);
				session.setAttribute("bacsi", target);
				session.setAttribute("benhnhan", bn.getMaBenhNhan());
				return "tuvan/benhnhan";
			} else if (bs!=null){
				ArrayList<BenhNhan> listBenhNhan=benhNhanDAO.layDanhSachBenhNhan();

				if(target!=null){
					System.out.println(target.getClass().getName());
					ArrayList<TuVan> cuocTuVan=tuVanDAO.getCuocTuVan(bs.getMaBacSi(),Integer.parseInt(target));
					mm.put("cuocTuVan", cuocTuVan);
					BenhNhan bnn=benhNhanDAO.layThongTinBenhNhan(Integer.parseInt(target));
					mm.put("benhnhan", bnn);
				}else{
					target="0";
				}

				mm.put("dsBenhNhan", listBenhNhan);
				session.setAttribute("nguoigui", 1);
				session.setAttribute("benhnhan", target);
				session.setAttribute("bacsi", bs.getMaBacSi());
				return "tuvan/bacsi";
			}
			else{
				return "err";
			}
		}

  @MessageMapping("/chat/{topic}")
  @SendTo("/topic/messages/{topic}")
  public TuVan send(@DestinationVariable("topic") String topic,
			      TuVan tuVan) throws Exception
  {
	  	
	  	tuVanDAO.taoTuVan(tuVan);
      	return tuVan;

  }

  @MessageExceptionHandler
  @SendToUser("/queue/errors")
  public String handleException(Throwable exception) {
      return exception.getMessage();
  }
}
