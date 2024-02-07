<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
.popfile {
	width: 120px;
	height: 120px;
}
</style>
<c:if test="${empty list.response.body.items.item}">
	<table class="table tb-list animal empty">
		<tr>
			<th></th>
		</tr>
		<tr>
			<td>${empty list.response.header.errorMsg ? "조회 결과가 없습니다." : list.response.header.errorMsg}</td>
		</tr>
	</table>
</c:if>
<c:forEach items="${list.response.body.items.item}" var="vo">
	<table class="table tb-list animal">
		<colgroup>
			<col width="120px"></col>
			<col width="100px"></col>
			<col width="60px"></col>
			<!-- 성별 -->
			<col width="70px"></col>
			<col width="160px"></col>
			<!-- 나이 -->
			<col width="70px"></col>
			<col width="120px"></col>
			<!-- 체중 -->
			<col width="70px"></col>
			<col width="160px"></col>
			<!-- 색상 -->
			<col width="110px"></col>
			<col width="110px"></col>
			<!-- 접수일자 -->
		</colgroup>
		<tr>
			<td rowspan="3"><img class="popfile" src="${vo.popfile }" /></td>
			<th>성별</th>
			<td>${vo.sexCd }</td>
			<th>나이</th>
			<td>${vo.age }</td>
			<th>체중</th>
			<td>${vo.weight }</td>
			<th>색상</th>
			<td>${vo.colorCd }</td>
			<th>접수일자</th>
			<td>${vo.happenDt }</td>
		</tr>
		<tr>
			<th>특징</th>
			<td colspan="9">${vo.specialMark }</td>
		</tr>
		<tr>
			<th>발견장소</th>
			<td colspan="7">${vo.happenPlace }</td>
			<td colspan="2">${vo.processState }</td>
			<!-- 상태 -->
		</tr>
		<tr>
			<td colspan="2">${vo.careNm }</td>
			<!-- 보호소명 -->
			<td colspan="7">${vo.careAddr }</td>
			<!-- 보호소 주소 -->
			<td colspan="2">${vo.careTel }</td>
			<!-- 보호소 전화 -->
		</tr>
	</table>
</c:forEach>
<script>
if(${empty list.response.body.items.item}){
	var path = "";
	$(".animal-top select").each(function() {
		if($(this).val()!=""){
			var item = $(this).find("option:selected").text();
			path += `<span class="me-2">\${item}</span>`;
		}
	})
	$("table.empty th").html(path);
}

$(".popfile").click(function() {
	$("#modal-map .modal-body").html($(this).clone());
	$("#modal-map .popfile").removeClass("popfile").addClass("w-pct100");
	new bootstrap.Modal($("#modal-map")).show();
})

paging(${empty list.response.header.errorMsg ? list.response.body.totalCount : 0},${list.response.body.pageNo});
</script>
