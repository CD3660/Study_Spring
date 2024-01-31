package com.hanul.smart.notice;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class NoticeVO {

	private int id, readcnt, no, root, step, indent, rid;
	private String title, writer, content, filepath, filename, name;
	private Date writedate;
}
