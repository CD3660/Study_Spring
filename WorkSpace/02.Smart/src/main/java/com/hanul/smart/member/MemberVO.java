package com.hanul.smart.member;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class MemberVO {
	private String user_id, user_pw, name, email,  phone, address, post, socail, admin, role, gender, profile;
	private Date birth;
}
