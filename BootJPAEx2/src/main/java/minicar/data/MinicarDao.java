package minicar.data;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Repository;

@Repository
public class MinicarDao{
	
	@Autowired
	MinicarDaoInter carDao;
	
	public Long getTotalCount() {
		return carDao.count();
	}
	
	// insert
	public void insertCar(MinicarDto dto) {
		carDao.save(dto); // num 값 유무에 따라 insert 또는 update 실행
	}
	
	// list
	public List<MinicarDto> getAllCars() {
		// return carDao.findAll(); // 입력순서대로 출력
		
		// 가격이 비싼것부터 출력하고싶을경우
		return carDao.findAll(Sort.by(Sort.Direction.DESC, "carprice"));
	}
	
	// detail
	public MinicarDto getMyCar(Long num) {
		return carDao.getReferenceById(num);
	}
	
	// update
	public void updateCar(MinicarDto dto) {
		carDao.save(dto); // 이번에는 num이 포함으로 수정을 수행한다
	}
	
	// delete
	public void deleteCar(Long num) {
		carDao.deleteById(num);
	}
	
	// list
	public List<MinicarDto> getSortCars(int idx) {
		if(idx == 1)
			return carDao.findAll(Sort.by(Sort.Direction.DESC, "carprice"));
		else if(idx == 2)
			return carDao.findAll(Sort.by(Sort.Direction.ASC, "carprice"));
		else
			return carDao.findAll();
	}
}
