package minicar.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import minicar.data.MinicarDao;
import minicar.data.MinicarDto;

@Controller
public class MinicarController {
	
	@Autowired
	MinicarDao minicarDao;
	
	@GetMapping("/minicarform")
	public String form() {
		return "minicarform";
	}
	
	@GetMapping("/")
	public String home(Model model) {
		// 총 갯수
		Long totalCount = minicarDao.getTotalCount();
		
		// 전체 데이터 가져오기
		List<MinicarDto> list = minicarDao.getAllCars();
		
		model.addAttribute("list", list);
		model.addAttribute("totalCount", totalCount);
		return "minicarlist";
	}
	
	@PostMapping("/addcar")
	public String insert(MinicarDto dto, MultipartFile upload, HttpServletRequest request) {
		// 업로드할 경로 구하기
		String realPath = request.getSession().getServletContext().getRealPath("/save");
		System.out.println(realPath);
		
		// 파일명 dto에 저장
		dto.setCarphoto(upload.getOriginalFilename());
		
		// 파일 업로드
		try {
			upload.transferTo(new File(realPath + "/" + upload.getOriginalFilename()));
			minicarDao.insertCar(dto);
		}
		catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		
		return "redirect:./";
	}
	
	@GetMapping("/detail")
	public String detail(Model model, Long num) {
		MinicarDto dto = minicarDao.getMyCar(num);
		model.addAttribute("dto", dto);
		return "detailcar";
	}
	
	@GetMapping("/updatecar")
	public String update(Model model, Long num) {
		MinicarDto dto = minicarDao.getMyCar(num);
		
		model.addAttribute("dto", dto);
		return "minicarupdateform";
	}
	
	@PostMapping("/update")
	public String update(MinicarDto dto, MultipartFile upload, HttpServletRequest request) {
		// 업로드할 경로 구하기
		String realPath = request.getSession().getServletContext().getRealPath("/save");
		System.out.println(realPath);
		
		// 업로드를 안할겨우 기존이름으로 넣는다
		if(upload .getOriginalFilename().equals("")) { 
			String photo = minicarDao.getMyCar(dto.getNum()).getCarphoto();
			dto.setCarphoto(photo);
		}
		else {
			// 파일명 dto에 저장
			dto.setCarphoto(upload.getOriginalFilename());
			
			// 파일 업로드
			try {
				upload.transferTo(new File(realPath + "/" + upload.getOriginalFilename()));
			}
			catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
		}
		
		// db 업데이트 
		minicarDao.updateCar(dto);
		
		return "redirect:./detail?num=" + dto.getNum();
	}
	
	@GetMapping("/deletecar")
	public String delete(Long num) {
		minicarDao.deleteCar(num);
		return "redirect:./";
	}
	
	@GetMapping("/ajaxlist")
	public String list() {
		
		return "ajaxlist";
	}
}
