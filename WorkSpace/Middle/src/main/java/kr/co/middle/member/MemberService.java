package kr.co.middle.member;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberService {
	
	@Autowired private SqlSession sql;
	
	public MemberVO login(String user_id) {
		return null;
	}
	
	public MemberVO info(String user_id) {
		return sql.selectOne("me.info",user_id);
	}
}
