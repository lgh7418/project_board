package com.company.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.company.domain.MemberVO;
import com.company.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class MemberServiceImpl implements MemberService {
	
	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	@Override
	public MemberVO login(MemberVO vo) {
		log.info("login......" + vo);
		return mapper.login(vo);
	}

	@Override
	public String idCheck(String userid) {
		log.info("아이디 중복 체크");
		return mapper.readUserid(userid);
	}

	@Override
	public void join(MemberVO vo) {
		log.info("join......." + vo);
		mapper.insert(vo);
	}

}
