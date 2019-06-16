package com.company.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.company.domain.BoardVO;
import com.company.domain.Criteria;

public interface BoardMapper {
	
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	public void insert(BoardVO board);

	public Integer insertSelectKey(BoardVO board);
	
	public BoardVO read(Long bno);
	
	// 정상적으로 삭제되면 1이 반환(그 외는 0 반환)
	public int delete(Long bno);
	
	// 정상적으로 수정되면 1이 반환(그 외는 0 반환)
	public int update(BoardVO board);
	
	public int getTotalCount(Criteria cri);
	
	// @Param : MyBatis에서 2개 이상의 데이터를 전달하기 위함
	// amount: 댓글의 증감 (댓글이 등록되면 1 증가, 삭제되면 1 감소)
	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);

	public void updateViewCnt(@Param("bno") Long bno, @Param("amount") int amount);
}
