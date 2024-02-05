package com.hanul.smart;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.hanul.smart.board.BoardCommentVO;
import com.hanul.smart.board.BoardService;
import com.hanul.smart.board.BoardVO;
import com.hanul.smart.common.CommonUtility;
import com.hanul.smart.common.FileVO;
import com.hanul.smart.common.PageVO;
import com.hanul.smart.notice.NoticeVO;

@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardService service;

	@Autowired
	private CommonUtility comm;

	@RequestMapping("/list")
	public String list(HttpSession session, PageVO page, Model model) {
		session.setAttribute("category", "bo");
		model.addAttribute("page", service.list(page));
		
		return "board/list";
	}

	@RequestMapping("/info")
	public String info(PageVO page, Model model, int id) {
		model.addAttribute("page", page);
		model.addAttribute("crlf", "\r\n");
		service.read(id);
		model.addAttribute("vo", service.info(id));

		return "board/info";
	}

	@RequestMapping("/download")
	public void download(HttpSession session, HttpServletRequest req, HttpServletResponse resp, int id) {
		FileVO vo = service.fileInfo(id);
		comm.fileDownload(vo, req, resp);
	}

	@RequestMapping("insertPage")
	public String insertPage(PageVO page, Model model) {
		model.addAttribute("page", page);
		return "board/insert";
	}

	@RequestMapping("updatePage")
	public String updatePage(PageVO page, Model model, int id) {
		model.addAttribute("page", page);
		model.addAttribute("vo", service.info(id));

		return "board/update";
	}

	@RequestMapping("/update")
	public String update(PageVO page, Model model, BoardVO vo, String remove, MultipartFile[] files,
			HttpServletRequest req) {
		vo.setFileList(comm.multipleFileUpload("board", files, req));
		if (service.update(vo) > 0) {
			if (!remove.isEmpty()) {
				List<FileVO> fileList = service.removeFileList(remove);
				if (service.deleteFile(remove) > 0) {
					for (FileVO file : fileList) {
						comm.fileDelete(file.getFilepath(), req);
					}
				}
			}
		}
		model.addAttribute("id", vo.getId());
		model.addAttribute("url", "board/info");
		model.addAttribute("page", page);
		
		return "include/redirect";
	}

	@RequestMapping("insert")
	public String insert(PageVO page, Model model, BoardVO vo, MultipartFile[] files, HttpServletRequest req) {
		model.addAttribute("page", page);
		vo.setFileList(comm.multipleFileUpload("board", files, req));
		service.insert(vo);

		return "redirect:list";
	}

	@RequestMapping("/delete")
	public String delete(PageVO page, Model model, int id, HttpServletRequest req) {

		List<FileVO> list = service.fileList(id);
		if (service.delete(id) > 0) {
			for (FileVO vo : list) {
				comm.fileDelete(vo.getFilepath(), req);
			}
		}
		model.addAttribute("page", page);
		model.addAttribute("id", id);
		model.addAttribute("url", "board/list");
		return "include/redirect";
	}
	
	@ResponseBody
	@RequestMapping("/comment/insert")
	public boolean commentInsert(BoardCommentVO vo) {
		
		return service.commentInsert(vo) == 1;
	}
	
	@RequestMapping("/comment/list/{board_id}")
	public String commentList(@PathVariable int board_id, Model model) {
		model.addAttribute("list", service.commentList(board_id)) ;
		model.addAttribute("crlf", "\r\n");
		model.addAttribute("lf", "\n");
		
		return "board/comment/comment_list";
	}
	
	@ResponseBody
	@RequestMapping("/comment/update")
	public Object commentUpdate(BoardCommentVO vo, Model model) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		if(service.commentUpdate(vo) > 0) {
			map.put("result", true);
			map.put("msg", "성공");
			map.put("content", vo.getContent());
		} else {
			map.put("result", false);
			map.put("msg", "실패");
		}
		return map;
	}
	@ResponseBody
	@RequestMapping("/comment/delete")
	public Object commentDelete(int id, Model model) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		if(service.commentDelete(id) > 0) {
			map.put("result", true);
			map.put("msg", "성공");
		} else {
			map.put("result", false);
			map.put("msg", "실패");
		}
		return map;
	}
	

}
