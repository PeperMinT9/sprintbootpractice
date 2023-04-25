package boot.study.service;

import boot.study.dto.BoardDto;
import boot.study.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class BoardService implements BoardServiceInter {

    @Autowired
    private BoardMapper boardMapper;

    @Override
    public int getMaxNum() {
        return boardMapper.getMaxNum();
    }

    @Override
    public int getTotalCount() {
        return boardMapper.getTotalCount();
    }

    @Override
    public void updateStep(int ref, int step) {
        Map<String, Integer> map = new HashMap<>();
        map.put("ref", ref);
        map.put("step", step);

        boardMapper.updateStep(map);
    }

    @Override
    public void insertBoard(BoardDto dto) {
        // 새글인지 답글인지 판단
        int ref = dto.getRef();
        int step = dto.getStep();
        int depth = dto.getDepth();

        if(dto.getNum() == 0) {
            // 새글인 경우
            step = 0;
            depth = 0;
            ref = boardMapper.getMaxNum() + 1; // 새그룹번호를 겹치지 않는 값으로 만들기 위해서~
        }
        else {
            // 답글인 경우
            // 전달받은 ref중에서 step보다 큰 값이 있는 경우 모두 +1한다
            this.updateStep(ref, step);
            // 그리고 나서 전달받은 step과 depth에 1을 증가한다
            step++;
            depth++;
        }

        dto.setRef(ref);
        dto.setStep(step);
        dto.setDepth(depth);

        boardMapper.insertBoard(dto);
    }

    @Override
    public List<BoardDto> getPagingList(int start, int perpage) {
        Map<String, Integer> map = new HashMap<>();
        map.put("start", start);
        map.put("perpage", perpage);

        return boardMapper.getPagingList(map);
    }

    @Override
    public void updateReadcount(int num) {
        boardMapper.updateReadcount(num);
    }

    @Override
    public BoardDto getData(int num) {
        return boardMapper.getData(num);
    }
}
