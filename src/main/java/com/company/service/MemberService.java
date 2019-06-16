package com.company.service;

import com.company.domain.MemberVO;

public interface MemberService {
	public MemberVO login(MemberVO vo);
	
	public String idCheck(String userid);
	
	public void join(MemberVO vo);
}
