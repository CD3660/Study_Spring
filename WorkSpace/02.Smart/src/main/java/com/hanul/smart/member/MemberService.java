package com.hanul.smart.member;

import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.hanul.smart.common.CommonUtility;

@Service
public class MemberService {

	@Autowired
	@Qualifier("hanul")
	SqlSession sql;

	@Autowired
	private CommonUtility comm;

	@Autowired
	private BCryptPasswordEncoder pwEncoder;


	public boolean find(MemberVO vo) {
		if (sql.selectOne("member.find", vo) == null) {
			return false;
		} else {
			return true;
		}
	}

	public String resetPw(MemberVO vo) {
		StringBuilder sb = new StringBuilder();
		sb.append("<script>");
		if (find(vo)) {
			String pw = UUID.randomUUID().toString();
			pw = pw.substring(pw.lastIndexOf("-") + 1);
			System.out.println(pw);

			vo.setUser_pw(pwEncoder.encode(pw));
			if (sql.update("member.resetPw", vo) == 1 && comm.sendPw(vo, pw)) {
				sb.append("alert('임시 비밀번호가 발급되었습니다. \\n이메일을 확인하세요');");
				sb.append("location='loginPage'");
			} else {
				sb.append("alert('임시 비밀번호 발급 실패 \\n다시 시도하세요.'); history.go(-1);");
			}

		} else {
			sb.append("alert('아이디 혹은 이메일이 일치하지 않습니다. \\n다시 확인하세요'); history.go(-1);");
		}
		sb.append("</script>");
		return sb.toString();
	}

	public int member_join(MemberVO vo) {
		
		return sql.insert("member.insert", vo);
	}

	public List<MemberVO> member_list() {
		return null;
	}

	public MemberVO member_info(String user_id) {
		return sql.selectOne("member.info", user_id);
	}

	public int member_update(MemberVO vo) {
		
		return sql.update("member.update", vo);
	}

	public int member_delete(String user_id) {
		return 0;
	}

}
