/**
 * 
 */

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