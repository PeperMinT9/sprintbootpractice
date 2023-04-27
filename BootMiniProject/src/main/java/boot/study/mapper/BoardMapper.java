package boot.study.mapper;

import boot.study.dto.BoardDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface BoardMapper {
    public int getMaxNum();
    public int getTotalCount();
    public void updateStep(Map<String, Integer> map); // map:ref, step
    public void insertBoard(BoardDto dto);
    public List<BoardDto> getPagingList(Map<String, Integer> map); // map:start.perpage
    public void updateReadcount(int num);
    public BoardDto getData(int num);
    public int isEqualPass(Map<String, Object> map);//num,pass
    public void deleteBoard(int num);
    public void updateBoard(BoardDto dto);
}
