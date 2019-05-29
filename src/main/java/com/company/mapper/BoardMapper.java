package com.company.mapper;

import java.util.List;

import com.company.domain.BoardVO;
import com.company.domain.Criteria;

public interface BoardMapper {
	
	public List<BoardVO> getList();
	
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	public void insert(BoardVO board);

	public Integer insertSelectKey(BoardVO board);
	
	public BoardVO read(Long bno);
	
	// 정상적으로 삭제되면 1이 반환(그 외는 0 반환)
	public int delete(Long bno);
	
	// 정상적으로 수정되면 1이 반환(그 외는 0 반환)
	public int update(BoardVO board);
	
	public int getTotalCount(Criteria cri);
}
