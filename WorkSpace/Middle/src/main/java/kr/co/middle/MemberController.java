package kr.co.middle;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

import kr.co.middle.member.MemberService;
import kr.co.middle.member.MemberVO;

@RestController
@RequestMapping(value = "/member", produces = "text/plain; charset=utf-8")
public class MemberController {

	@Autowired
	private MemberService service;

	@Autowired
	private Common comm;

	@Autowired
	private BCryptPasswordEncoder pwEncoder;

	@RequestMapping("/login")
	public String login(String user_id, String user_pw) {
		MemberVO vo = service.info(user_id);
		boolean match = false;
		if (vo != null) {
			match = pwEncoder.matches(user_pw, vo.getUser_pw());
		}
		return new Gson().toJson(match ? vo : null);
	}

	@RequestMapping("/join")
	public String join(String vo, MultipartFile andFile, HttpServletRequest req) {
		MemberVO mem = new Gson().fromJson(vo, MemberVO.class);
		mem.setUser_pw(pwEncoder.encode(mem.getUser_pw()));

		if (!andFile.isEmpty()) {
			mem.setProfile(comm.fileUpload("profile", andFile, req));
		}

		return service.join(mem) + "";
	}
}
