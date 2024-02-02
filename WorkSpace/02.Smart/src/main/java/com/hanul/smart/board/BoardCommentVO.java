package com.hanul.smart.board;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardCommentVO {
	private int board_id, id;
	private String content, writer, name, profile;
	private String writedate;
}
