package com.hanul.smart;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

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
		model.addAttribute("url", "list");
		return "include/redirect";
	}

}
