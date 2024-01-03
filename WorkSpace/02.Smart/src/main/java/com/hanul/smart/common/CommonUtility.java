package com.hanul.smart.common;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;

import com.hanul.smart.member.MemberVO;

@Service
@PropertySource("classpath:dbconn/conninfo.properties")
public class CommonUtility {

	public String requestAPI(String apiURL) {
		try {
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			int responseCode = con.getResponseCode();
			BufferedReader br;
			if (responseCode == 200) { // 정상 호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream(), "utf-8"));
			} else { // 에러 발생
				br = new BufferedReader(new InputStreamReader(con.getErrorStream(), "utf-8"));
			}
			String inputLine;
			StringBuilder res = new StringBuilder();
			while ((inputLine = br.readLine()) != null) {
				res.append(inputLine);
			}
			br.close();
			if (responseCode == 200) {
				apiURL = res.toString();
			}
		} catch (Exception e) {
			// Exception 로깅
		}
		return apiURL;
	}
	public String requestAPI(String apiURL, String property) {
		try {
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("Authorization", property);
			int responseCode = con.getResponseCode();
			BufferedReader br;
			if (responseCode == 200) { // 정상 호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream(), "utf-8"));
			} else { // 에러 발생
				br = new BufferedReader(new InputStreamReader(con.getErrorStream(), "utf-8"));
			}
			String inputLine;
			StringBuilder res = new StringBuilder();
			while ((inputLine = br.readLine()) != null) {
				res.append(inputLine);
			}
			br.close();
			if (responseCode == 200) {
				apiURL = res.toString();
			}
		} catch (Exception e) {
			// Exception 로깅
		}
		return apiURL;
	}

	@Value("${naver.id}")
	private String naverId;

	@Value("${naver.pw}")
	private String naverPw;

	public String appURL(HttpServletRequest req) {
		StringBuilder url = new StringBuilder();
		url.append("http://");
		url.append(req.getServerName()).append(":");
		url.append(req.getServerPort());
		url.append(req.getContextPath());

		return url.toString();
	}

	public void connectMailServer(HtmlEmail mail) {
		mail.setDebug(true);
		mail.setCharset("utf-8");
		mail.setHostName("smtp.naver.com");// 이메일 보낼 사이트
		mail.setAuthentication(naverId, naverPw);// 사이트 로그인 정보
		mail.setSSLOnConnect(true);

	}

	public boolean sendPw(MemberVO vo, String pw) {
		boolean send = true;

		HtmlEmail mail = new HtmlEmail();
		connectMailServer(mail); // 메일 서버 연결하기
		try {
			mail.setFrom(naverId, "스마트 IoT 융합 관리자");// 메일 보내는 사람 정보
			mail.addTo(vo.getEmail(), vo.getName());// 메일 받을 사람 정보
			mail.setSubject("스마트 IoT 융합 임시 비밀번호 발급");// 메일 제목
			StringBuilder sb = new StringBuilder();
			sb.append("<h3>" + vo.getName() + "님의 임시 비밀번호가 발급되었습니다.</h3>");
			sb.append("<div>아이디:" + vo.getUser_id() + "</div>");
			sb.append("<div>임시 비밀번호: <strong>" + pw + "</strong></div>");
			sb.append("<div>임시 비밀번호로 로그인 후 새로운 비밀번호로 변경하세요.</div>");
			mail.setHtmlMsg(sb.toString());// 메일 내용 붙이기
			mail.send();// 메일 보내기
		} catch (EmailException e) {
			System.out.println(e.getMessage());
			send = false;
		}
		return send;
	}
}
