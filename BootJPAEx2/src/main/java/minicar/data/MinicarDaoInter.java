package minicar.data;

import org.springframework.data.jpa.repository.JpaRepository;

public interface MinicarDaoInter extends JpaRepository<MinicarDto, Long>{
	
}
