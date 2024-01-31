package com.hanul.smart.board;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hanul.smart.common.CommonUtility;
import com.hanul.smart.common.FileVO;
import com.hanul.smart.common.PageVO;

@Service
public class BoardService {

	@Autowired
	@Qualifier("hanul")
	private SqlSession sql;
	@Autowired
	private CommonUtility comm;
	

	public PageVO list(PageVO page) {
		page.setTotalData(sql.selectOne("bo.totalList", page));
		page.setList(sql.selectList("bo.list", page)); 
		
		return page;
	}
	public List<FileVO> fileList(int id) {
		return sql.selectList("bo.fileList",id);
	}

	public BoardVO info(int id) {
		BoardVO vo = sql.selectOne("bo.info", id);
		vo.setFileList(sql.selectList("bo.fileList", id));
		return vo;
	}
	
	public FileVO fileInfo(int id) {
		return sql.selectOne("bo.fileInfo", id);
	}
	
	public int read(int id) {
		return sql.update("bo.read", id);
	}

	public int insert(BoardVO vo) {
		int dml = sql.insert("bo.insert", vo);
		if(dml>0) {
			if(vo.getFileList() != null) {
				sql.insert("bo.fileInsert", vo);
				
			}
		}
			
		return dml;
	}

	public int update(BoardVO vo) {

		return 0;
	}

	public int delete(int id) {

		return sql.delete("bo.delete", id);
	}
	


}
