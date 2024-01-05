package com.hanul.smart;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.util.Scanner;

import org.apache.ibatis.session.SqlSession;
import org.junit.jupiter.api.Disabled;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.hanul.smart.member.MemberVO;

@RunWith(value = SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml" })
public class Test {

	@Autowired
	@Qualifier("hanul")
	private SqlSession sql;

	private BCryptPasswordEncoder pwEncoder = new BCryptPasswordEncoder();

	@Disabled
	@org.junit.Test
	public void login() {
		Scanner sc = new Scanner(System.in);

		
		System.out.print("아이디: ");
		String user_id = sc.nextLine();
		
		System.out.print("비밀번호: ");
		String user_pw = sc.nextLine();
		
		MemberVO vo = sql.selectOne("member.info", user_id);
		if(vo == null) {
			System.out.println("아이디 불일치");
		} else {
			if(pwEncoder.matches(user_pw, vo.getUser_pw())) {
				System.out.println("로그인 성공");
			} else {
				System.out.println("비밀번호 불일치");
			}
		}
		sc.close();
	}
	
	@org.junit.Test
	public void join() {
		Scanner sc = new Scanner(System.in);

		MemberVO vo = new MemberVO();
		System.out.print("이름: ");
		vo.setName(sc.nextLine());
		System.out.print("아이디: ");
		vo.setUser_id(sc.nextLine());
		System.out.print("비밀번호: ");
		vo.setUser_pw( pwEncoder.encode(sc.nextLine()) );
		System.out.print("이메일: ");
		vo.setEmail(sc.nextLine());
		System.out.println("관리자(Y/N)");
		vo.setRole(sc.nextLine().toLowerCase().equals("y")?"ADMIN":"USER");
		
		
		sc.close();
		
		int dml = sql.insert("member.joinTest", vo);
		assertEquals(dml, 1);
	}

	@Disabled
	@org.junit.Test
	public void query_test() {
		System.out.println("오늘:" + sql.selectOne("today"));
	}
}
