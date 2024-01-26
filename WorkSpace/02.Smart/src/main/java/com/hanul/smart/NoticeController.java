package com.hanul.smart;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.hanul.smart.common.CommonUtility;
import com.hanul.smart.common.PageVO;
import com.hanul.smart.member.MemberVO;
import com.hanul.smart.notice.NoticeService;
import com.hanul.smart.notice.NoticeVO;

@Controller
@RequestMapping("/notice")
public class NoticeController {

	@Autowired
	private NoticeService service;
	@Autowired
	private CommonUtility comm;

	@RequestMapping("/list")
	public String list(Model model, HttpSession session, PageVO page) {
		session.setAttribute("category", "no");
		model.addAttribute("page", service.notice_list(page));

		return "notice/list";
	}

	@RequestMapping("/info")
	public String info(Model model, int id, PageVO page) {
		service.notice_read(id);
		model.addAttribute("page", page);
		model.addAttribute("vo", service.notice_info(id));
		model.addAttribute("crlf", "\r\n");

		return "notice/info";
	}

	@RequestMapping("/insertPage")
	public String insertPage() {

		return "notice/insert";
	}

	@RequestMapping("/insert")
	public String insert(HttpSession session, NoticeVO vo, MultipartFile file, HttpServletRequest req) {
		MemberVO member = (MemberVO) session.getAttribute("loginInfo");
		vo.setWriter(member.getUser_id());
		if (!file.isEmpty()) {
			vo.setFilename(file.getOriginalFilename());
			vo.setFilepath(comm.fileUpload("notice", file, req));
		}

		service.notice_insert(vo);

		return "redirect:/notice/list";
	}

	@RequestMapping("/update")
	public String update(HttpSession session, NoticeVO vo, MultipartFile file, HttpServletRequest req, PageVO page) throws UnsupportedEncodingException {
		NoticeVO prev = service.notice_info(vo.getId());
		if (file.isEmpty()) {
			if (!vo.getFilename().isEmpty()) {
				vo.setFilepath(prev.getFilepath());
			}
		} else {
			vo.setFilename(file.getOriginalFilename());
			vo.setFilepath(comm.fileUpload("notice", file, req));
		}

		if (service.notice_update(vo) == 1) {
			if (file.isEmpty()) {
				if (vo.getFilename().isEmpty()) {
					comm.fileDelete(prev.getFilepath(), req);
				}
			} else {
				comm.fileDelete(prev.getFilepath(), req);
			}
		}

		return "redirect:/notice/info?id=" + vo.getId() + "&nowPage=" + page.getNowPage() + "&search="
				+ page.getSearch() + "&keyword=" + URLEncoder.encode(page.getKeyword(), "utf-8");
	}

	@RequestMapping("/updatePage")
	public String updatePage(Model model, int id, PageVO page) {
		model.addAttribute("vo", service.notice_info(id));
		model.addAttribute("page", page);
		return "notice/update";
	}

	@RequestMapping("/delete")
	public String delete(HttpSession session, HttpServletRequest req, int id, PageVO page) throws UnsupportedEncodingException {
		String filepath = service.notice_info(id).getFilepath();
		comm.fileDelete(filepath, req);
		service.notice_delete(id);
		return "redirect:/notice/list"+ "?nowPage=" + page.getNowPage() + "&search="
				+ page.getSearch() + "&keyword=" + URLEncoder.encode(page.getKeyword(), "utf-8");
	}

	@RequestMapping("/download")
	public void download(HttpSession session, HttpServletRequest req, HttpServletResponse resp, int id) {
		NoticeVO vo = service.notice_info(id);
		comm.fileDownload(vo, req, resp);
	}
}
