package boot.study.mapper;

import boot.study.dto.ShopDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ShopMapper {
    public int getTotalCount();
    public void insertShop(ShopDto dto);
    public List<ShopDto> getAllSangpums();
    public ShopDto getOneSangpums(int num);
}
