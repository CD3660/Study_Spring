/**
 * 
 */

var member = {
	tagStatus: function(tag, input) {
		if (tag.is("[name=user_pw]")) return this.user_pwStatus(tag.val(), input);
		else if (tag.is("[name=checkPw]")) return this.checkPwStatus(tag.val(), input);
	},
	common: {
		empty: { is: false, desc: "입력하세요" },
		min: { is: false, desc: "8자 이상 입력하세요" },
		max: { is: false, desc: "16자 이내로 입력하세요" },
		space: { is: false, desc: "공백 없이 입력하세요" }
	},
	user_pw: {
		valid: { is: true, desc: "사용가능합니다." },
		lack: { is: false, desc: "영문 대/소문자, 숫자를 모두 포함해야 합니다." },
		invalid: { is: false, desc: "영문 대/소문자, 숫자만 입력하세요." },
		equal: { is: true, desc: "비밀번호가 일치합니다" },
		notEqual: { is: false, desc: "비밀번호가 일치하지 않습니다." }
	},
	space: /\s/g,
	checkPwStatus: function(checkPw){
		if(checkPw == $("[name=user_pw]").val()) return this.user_pw.equal
		else return this.user_pw.notEqual;
	},
	showStatus: function(tag) {
		var status = this.tagStatus(tag, true);
		tag.closest(".input-check")
			.find(".desc")
			.text(tag.attr("title") + " " + status.desc)
			.removeClass("text-success text-danger")
			.addClass(status.is ? "text-success" : "text-danger")
	},
	user_pwStatus: function(user_pw, input) {
		if(input){
			$("[name=checkPw]").val("");
			$("[name=checkPw]").closest(".input-check").find("")
								.removeClass("text-success text-danger")
								.text("");
		}
		
		var upper = /[A-Z]/g, lower = /[a-z]/g, digit = /[0-9]/g, reg = /[^A-Za-z0-9]/g;
		if (user_pw == "") return this.common.empty;
		else if (user_pw.match(this.space)) return this.common.space;
		else if (reg.test(user_pw)) return this.user_pw.invalid;
		else if (user_pw.length < 8) return this.common.min;
		else if (user_pw.length > 16) return this.common.max;
		else if (!upper.test(user_pw) || !lower.test(user_pw) || !digit.test(user_pw)) return this.user_pw.lack;
		else return this.user_pw.valid;
	}
}