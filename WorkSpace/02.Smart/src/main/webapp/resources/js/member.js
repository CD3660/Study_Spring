/**
 * 
 */

var member = {
	tagStatus: function(tag, input) {
		if (tag.is("[name=user_pw]")) return this.user_pwStatus(tag.val(), input);
		else if (tag.is("[name=checkPw]")) return this.checkPwStatus(tag.val(), input);
		else if (tag.is("[name=user_id]")) return this.user_idStatus(tag.val());
		else if (tag.is("[name=email]")) return this.emailStatus(tag.val());
	},
	common: {
		empty: { is: false, desc: "입력하세요" },
		min: { is: false, desc: "8자 이상 입력하세요" },
		max: { is: false, desc: "16자 이내로 입력하세요" },
		space: { is: false, desc: "공백 없이 입력하세요" }
	},
	user_idStatus: function(id) {
		var reg = /[^a-z0-9]/g;
		if (id == "") return this.common.empty;
		else if (reg.test(id)) return this.user_id.invalid;
		else if (id.length < 8) return this.common.min;
		else if (id.length > 16) return this.common.max;
		else return this.user_id.valid;
	},
	emailStatus: function(email) {
		var reg = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
		if (email == "") return this.common.empty;
		else if (!reg.test(email)) return this.email.invalid;
		else return this.email.valid;
	},
	email: {
		valid: { is: true, desc: "사용가능합니다." },
		invalid: { is: false, desc: "사용불가능 합니다." }
	},
	user_id: {
		valid: { is: true, desc: "아이디 중복확인 필요" },
		invalid: { is: false, desc: "영문 소문자, 숫자만 입력하세요." },
		usable: { is: true, desc: "사용가능한 아이디입니다." },
		unusable: { is: false, desc: "사용중인 아이디 입니다." }
	},
	user_pw: {
		valid: { is: true, desc: "사용가능합니다." },
		lack: { is: false, desc: "영문 대/소문자, 숫자를 모두 포함해야 합니다." },
		invalid: { is: false, desc: "영문 대/소문자, 숫자만 입력하세요." },
		equal: { is: true, desc: "비밀번호가 일치합니다" },
		notEqual: { is: false, desc: "비밀번호가 일치하지 않습니다." }
	},
	space: /\s/g,
	checkPwStatus: function(checkPw) {
		if (checkPw == $("[name=user_pw]").val()) return this.user_pw.equal
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
		if (input) {
			$("[name=checkPw]").val("");
			$("[name=checkPw]").closest(".input-check").find(".desc")
				.removeClass("text-success text-danger")
				.text("");
		}
		var upper = /[A-Z]/g, lower = /[a-z]/g, digit = /[0-9]/g, reg = /[^A-Za-z0-9]/g;
		if (user_pw == "") return this.common.empty;
		else if (reg.test(user_pw)) return this.user_pw.invalid;
		else if (user_pw.length < 8) return this.common.min;
		else if (user_pw.length > 16) return this.common.max;
		else if (!upper.test(user_pw) || !lower.test(user_pw) || !digit.test(user_pw)) return this.user_pw.lack;
		else return this.user_pw.valid;
	}
}