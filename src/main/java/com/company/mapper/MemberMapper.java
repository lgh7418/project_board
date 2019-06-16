package com.company.mapper;

import com.company.domain.MemberVO;

public interface MemberMapper {

	public MemberVO login(MemberVO vo);
	
	public String readUserid(String userid);
	
	public void insert(MemberVO vo);
}
