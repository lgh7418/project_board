package com.company.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {

	private String userid;
	private String userpw;
	private String username;

	private Date regDate;
	private Date updateDate;

}
