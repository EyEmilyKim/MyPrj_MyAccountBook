<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateCategory.jsp</title>
</head>
<body>
<div>
	<p>카테고리 수정 화면입니다.</p>
	<form action="updateCategory.do" name="fmC" onSubmit="return check()">
		<input type="hidden" name="CCODE" value="${C.cate_code }">
		<input type="hidden" name="CNAME" value="${C.cate_name }">
		<table>
		<tr><td>
			<input type="hidden" value="${C.inex }" name="INEX">
			<c:if test="${C.inex == 'IN' }">
			<input type="button" value="수입" onClick="guideInex()" id="btn_in"></c:if>
			<c:if test="${C.inex == 'In' }">
			<input type="button" value="수입" onClick="guideInex()" id="btn_in"></c:if>
			<c:if test="${C.inex == 'EX' }">
			<input type="button" value="지출" onClick="guideInex()" id="btn_ex"></c:if>
			</td></tr>
		<tr><td>현재 카테고리명 : ${C.cate_name }</td></tr>
		<tr><td><input type="text" placeholder="변경할 카테고리명" name="N_CNAME"></td></tr>
		<tr><td><span id="guide"></span></td></tr>
		<tr><td>
			<input type="submit" value="저장">
			<input type="reset" value="취소" onClick="backToList()"></td></tr>		
		</table>
	</form>
	</div>
</body>
<script type="text/javascript">
function guideInex(){
	alert("guideInex()호출됨");
	let guideInex = "수입/지출 구분은 수정할 수 없습니다. 목록에서 삭제 후 다시 등록해주세요.";
	document.getElementById("guide").innerHTML = guideInex;
}
function check(){
	alert("check()호출됨");
	document.getElementById("guide").innerHTML = "";
	let inex = document.fmC.INEX.value;
	let s_inex = ""; if(inex == "EX") s_inex = "지출"; else s_inex = "수입";
	let cname = document.fmC.CNAME.value;
	let n_cname = document.fmC.N_CNAME.value;
	let guideConf = "기존에 이 카테고리를 사용해 입력한 가계부 기록에도 변경된 카테고리명이 반영됩니다.";
	let detailConf = "구분 : "+s_inex+"\n수정 전 : "+cname+"\n수정 후 : "+n_cname;
	alert("let OK");
	if(n_cname == ''){ alert("카테고리명을 입력해주세요."); return false }
	if(! confirm( guideConf+"\n\n저장하시겠습니까?\n\n---\n"+detailConf ) ) return false;
	if(! confirm("수정될 cate_code : "+document.fmC.CCODE.value) ) return false;
}
function backToList(){
	if(confirm("취소하고 목록으로 돌아가시겠습니까?")){
		opener.location.reload();
		window.close();
	}
}
</script>
</html>