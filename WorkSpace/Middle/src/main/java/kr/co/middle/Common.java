package kr.co.middle;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

@Service
public class Common {

	public String fileUpload(String category, MultipartFile file, HttpServletRequest req) {
		String uploadPath = "D:\\app/upload/" + category + new SimpleDateFormat("/yyyy/MM/dd/").format(new Date());

		File folder = new File(uploadPath);
		if (!folder.exists())
			folder.mkdirs();
		
		String filename = UUID.randomUUID().toString() + "."
				+ StringUtils.getFilenameExtension(file.getOriginalFilename());

		try {
			file.transferTo(new File(uploadPath, filename));
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return uploadPath.replace("D:\\app/upload/", fileURL(req)) + filename;
	}
	
	public String fileURL(HttpServletRequest req) {
		StringBuilder url = new StringBuilder();
		url.append("http://");
		url.append(req.getServerName());
		url.append(":");
		url.append(req.getServerPort());
		url.append("/file/");
		
		return url.toString();
	}
}
