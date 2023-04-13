package minicar.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import minicar.data.MinicarDao;
import minicar.data.MinicarDto;

@RestController
public class MinicarRestController {
	@Autowired
	MinicarDao minicarDao;
	
	@GetMapping("/list")
	public List<MinicarDto> list(int idx) {
		// idx: 1 고가순, 2 저가순, 3 등록순
		
		
		return minicarDao.getSortCars(idx);
	}
}
