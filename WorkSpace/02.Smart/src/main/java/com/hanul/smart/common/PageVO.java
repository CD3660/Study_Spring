package com.hanul.smart.common;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PageVO {
	private int dataPerPage = 10, pagePerBlock = 10, totalData, totalPage, totalBlock;
	private int beginData, endData;
	private int beginPage, endPage;
	private int nowBlock =1, nowPage =1;
	private List<Object> list;
		
	public void setTotalData(int totalData) {
		this.totalData = totalData;
		this.totalPage = (totalData-1) / dataPerPage + 1;
		this.totalBlock = (totalPage-1) / pagePerBlock + 1;
		endData = totalData - (nowPage-1) * dataPerPage;
		beginData = endData - dataPerPage + 1;
		nowBlock = (nowPage - 1) / pagePerBlock + 1;
		endPage = nowBlock * pagePerBlock;
		beginPage = endPage - pagePerBlock + 1;
		if(totalPage < endPage) endPage = totalPage;
	}
}