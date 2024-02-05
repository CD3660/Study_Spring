/**
 * 
 */



function paging(totalData, nowPage) {
	$(".pagination").closest("nav").remove();
	
	page.nowPage = nowPage
	page.totalData = totalData;
	page.totalPage = Math.ceil(page.totalData / page.dataPerPage);
	page.totalBlock = Math.ceil(page.totalPage / page.pagePerBlock);
	page.nowBlock = Math.ceil(page.nowPage / page.pagePerBlock);
	page.endPage = page.nowBlock * page.pagePerBlock;
	page.beginPage = page.endPage - page.pagePerBlock + 1;
	if (page.totalPage < page.endPage) page.endPage = page.totalPage;

	var prev = page.nowBlock > 1 ? "" : "d-none";
	var next = page.nowBlock < page.totalBlock ? "" : "d-none";

	var pages = ""
	for (var no = page.beginPage; no <= page.endPage; no++) {
		if (no == page.nowPage) {
			pages += `<li class="page-item"><a class="page-link active" href="#">${no}</a></li>`;
		} else {
			pages += `<li class="page-item"><a class="page-link" data-page="${no}">${no}</a></li>`;
		}
	}
	var nav =
		`
	<nav aria-label="Page navigation">
		<ul class="pagination justify-content-center">
			<li class="page-item ${prev}"><a class="page-link" data-page="1"><i class="fa-solid fa-angles-left"></i></a></li>
			<li class="page-item ${prev}"><a class="page-link" data-page="${page.beginPage - page.pagePerBlock}">
				<i class="fa-solid fa-angle-left"></i></a></li>
			${pages}			
			<li class="page-item ${next}"><a class="page-link" data-page="${page.endPage + 1}"><i
						class="fa-solid fa-angle-right"></i></a></li>
			<li class="page-item ${next}"><a class="page-link" data-page="${page.totalPage}"><i
						class="fa-solid fa-angles-right"></i></a></li>
		</ul>
	</nav>
	`;
	
	$("#data-list").after(nav);
}

$(function() {
	if ($(".date").length > 0) {
		var today = new Date();
		var range = (today.getFullYear() - 100) + " : " + today.getFullYear();

		$.datepicker.setDefaults({
			dateFormat: "yy-mm-dd",
			changeYear: true,
			changeMonth: true,
			showMonthAfterYear: true,
			dayNamesMin: ["일", "월", "화", "수", "목", "금", "토"],
			monthNamesShort: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
			maxDate: today,
			yearRange: range
		})
	}
	$(".date").datepicker();
	$(".date").attr("readonly", true);

	$(".date").change(function() {
		$(this).next(".date-remover").css("display", "inline");
	});
	$(".date-remover").click(function() {
		$(this).css("display", "none");
		$(this).prev(".date").val("");

	});

	$(".remover").click(function() {
		$(this).closest(".file-info").find("input[type=file]").val("");
		$(this).closest(".file-info").find(".file-preview").empty();
		$(this).closest(".file-info").find(".file-name").empty();
		$(this).addClass("d-none");
	});

	$("input#file-single").change(function remove() {
		var _remover = $(this).closest(".file-info").find(".remover");
		var _preview = $(this).closest(".file-info").find(".file-preview");
		var _name = $(this).closest(".file-info").find(".file-name");

		var attached = this.files[0];
		if (attached) {
			if (rejectFile(attached, $(this))) return;
			_name.text(attached.name);
			_remover.removeClass("d-none");

			if ($(this).hasClass("img-only") && isImg(attached.name)) {
				if (_preview.length > 0) {
					_preview.html("<img/>");
					var reader = new FileReader();
					reader.readAsDataURL(attached);
					reader.onload = function(e) {
						_preview.children("img").attr("src", this.result);
					}
				}
			} else {
				if ($(this).hasClass("img-only")) {
					_preview.empty();
					_remover.addClass("d-none");
					$(this).val("");
				}
			}
		}
	}
	);

	$(".file-drag").on("dragover dragleave drop", function(e) {
		e.preventDefault();//드롭 허용을 위해 기본 동작 취소

		//드래그 오버시 입력 태그에 커서 있을 때 처럼 적용
		if (e.type == "dragover") $(this).addClass("drag-over");
		else $(this).removeClass("drag-over");

	})
		.on("drop", function(e) {
			var files = filterFolder(e.originalEvent.dataTransfer);
			$(files).each(function() {
				fileList.setFile(this);
			});
			console.log("fileList>", fileList)
			fileList.showFile();
		});

	$("body").on("dragover dragleave drop", function(e) {
		e.preventDefault();//드롭 허용을 위해 기본 동작 취소
	});

	$("#file-multiple").on("change", function() {
		var files = this.files;
		$(files).each(function() {
			fileList.setFile(this);
		});
		fileList.showFile();
	});


});

function multipleFileUpload() {
	//FileList 객체의 files를 input 태그 내부로 옮기는 작업
	var transfer = new DataTransfer();
	var files = fileList.getFile();
	if (files.length > 0) {
		for (i = 0; i < files.length; i++) {
			if (fileList.info.upload[i]) transfer.items.add(files[i]);
		}
	}
	console.log(transfer.files);
	$('#file-multiple').prop("files", transfer.files);
}

//파일 관련 처리
function FileList() {
	this.files = [];
	this.info = { upload: [], id: [], remove: [] };//업로드 여부, 업로드 되어있는 파일 id, 삭제할 파일 id
	this.setFile = function(file, id) {
		this.info.upload.push(typeof id == "undefined");
		if (typeof id != "undefined") this.info.id.push(id);
		this.files.push(file);
	}
	this.getFile = function() {
		return this.files;
	}
	//해당 파일 항목 삭제
	//slice(시작,끝) : 시작 위치에서 끝-1까지 반환, 끝 생략 시 마지막까지, 원본 유지
	//splice(시작, 갯수) : 시작 위치에서 개수만큼 제거, 원래 데이터 바뀜
	this.removeFile = function(i) {
		this.files.splice(i, 1);
		this.info.upload.splice(i, 1);
		if (typeof this.info.id[i] != "undefined") {
			this.info.remove.push(this.info.id[i]);
			this.info.id.splice(i, 1);
		}
	}
	this.showFile = function() {
		var tag = "";
		if (this.files.length > 0) {//파일 목록에 파일이 있는 경우
			for (i = 0; i < this.files.length; i++) {
				tag += `
					<div class="file-item d-flex gap-2 my-1">
						<button type="button" class="btn-close small" data-index="${i}"></button>
						<span>${this.files[i].name}</span>
					</div>
				`;
			}
		} else {//파일 목록에 파일이 없는 경우
			tag += `<div class="py-3 text-center">첨부할 파일을 마우스로 끌어오세요</div>`;
		}
		$(".file-drag").html(tag);
		console.log("fileList>", this.files);
		console.log("info>", this.info);
	}
}

function filterFolder(transfer) {
	var files = [], folder = false;
	for (i = 0; i < transfer.items.length; i++) {
		var entry = transfer.items[i].webkitGetAsEntry();
		/*console.log("idx>",i,entry);*/
		if (entry.isFile) files.push(transfer.files[i])
		else folder = true;
	}
	if (folder) {
		alert("폴더는 첨부할 수 없습니다.");
	}
	return files;
}

$(document).on("click", ".file-item .btn-close", function() {
	fileList.removeFile($(this).data("index"));
	fileList.showFile();
});


function rejectFile(fileInfo, tag) {
	if (fileInfo.size > 1024 * 1024 * 5) {
		tag.val("");
		$(tag).closest(".file-info").find(".file-preview").empty();
		$(tag).closest(".file-info").find(".img-remover").addClass("d-none");
		alert("5MB 이하의 파일을 선택하세요.");

		return true;
	}
	return false;
}

function isImg(filename) {
	var imgs = ["png", "jpg", "jpeg", "gif", "bmp", "webp"];
	var ext = filename.substr(filename.lastIndexOf(".") + 1);
	return imgs.indexOf(ext) == -1 ? false : true;

}

function notEmpty() {
	var ok = true;
	$(".check-empty").each(function() {
		if ($(this).val() == "") {
			alert($(this).attr("title") + "을 입력해주세요");
			$(this).focus();
			ok = false;
			return ok;
		}
	})
	return ok;
}

