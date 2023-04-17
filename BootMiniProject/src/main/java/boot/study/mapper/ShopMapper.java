package boot.study.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ShopMapper {
    public int getTotalCount();
}
