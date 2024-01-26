package com.hanul.smart.notice;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hanul.smart.common.PageVO;

@Service
public class NoticeService {

	@Autowired
	@Qualifier("hanul")
	private SqlSession sql;

	public List<NoticeVO> notice_list() {
		return sql.selectList("no.list");
	}

	public PageVO notice_list(PageVO page) {
		page.setTotalData(sql.selectOne("no.listSize", page));
		page.setList(sql.selectList("no.list", page));
		return page;
	}

	public NoticeVO notice_info(int id) {
		return sql.selectOne("no.info", id);
	}

	public void notice_read(int id) {
		sql.update("no.readcnt", id);
	}

	public int notice_insert(NoticeVO vo) {

		return sql.insert("no.insert", vo);
	}

	public int notice_update(NoticeVO vo) {
		return sql.update("no.update", vo);
	}

	public int notice_delete(int id) {
		return sql.delete("no.delete", id);
	}

}
