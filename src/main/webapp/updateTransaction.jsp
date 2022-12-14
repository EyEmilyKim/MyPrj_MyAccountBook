<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateTransaction.jsp</title>
<style type="text/css">
	.contMain { min-width:500px; min-height:300px; background-color: white; align:center; padding:20px; border-radius: 15px;}  
	#slct_in, #slct_ex, #row_meth, #slct_mn, #slct_crd { display:none; } 
	#guide { color:red; }  h3{ margin: 10px 0 20px; color:var(--hoverMenu-color); }
	#ccode, #mcode { border:orange solid 1px;  display:none; }
	.hidden { display:; } .test {border:red solid 1px; color:orange; }
</style>
</head>
<body onLoad="preset()">
<!-- <div class="home"> -->
<!-- 	<a href="index.jsp">My 가계부</a> -->
<!-- </div> -->
<div class="contMain" align="center">
	<h3>가계부 수정 화면입니다.</h3>
	
	<c:set value="${TRANS }" var="t"/>
	
	<form class="hidden" name="preset">
		<input type="text" name="PRE_INEX" value="${t.inex }">
		<input type="text" name="PRE_CCODE" value="${t.cate_code }">
		<input type="text" name="PRE_MCODE" value="${t.meth_code }">
	</form>
	
	<form action="updateTransaction.do" method = "post" name="fm" onSubmit="return catchSub()">
<!-- 0.일련번호(hidden)-->
		<input type="hidden" name="SEQNO" value="${t.seqno }">
		<table>
<!-- 1.수입or지출 구분 -->
		<tr><td><input type="hidden" name="INEX" id="inex" value="${t.inex }">
			<input type="button" value="수입" onClick="doIN()" id="btn_in">
			<input type="button" value="지출" onClick="doEX()" id="btn_ex">
			</td></tr>
<!-- 2.거래날짜 -->
		<tr><td><input type="date" name="DATE" id="date" value="${t.trans_date }"></td></tr>
<!--  버려둔 버튼	<input type="button" value="오늘" onClick="setToday()"></td></tr> -->
<!-- 3.카테고리 -->
	<!-- 드롭다운 : 초기화면 -->
		<tr><td><input type="text" name="CCODE" id="ccode" placeholder="ccode 자동수신" value="${t.cate_code }">
				<select name="SLCT_NN" id="slct_nn">
					<option value="">--카테고리(미지정)--</option>
				</select>
	<!-- 드롭다운 : 수입 -->
				<select name="SLCT_IN" id="slct_in" onChange="setCCODE(this)">
					<option value="">--카테고리(수입)--</option>
				<c:forEach items="${CATELIST }" var="c">
				<c:set var="cate_code" value="${c.cate_code }"/>
				<c:set var="cate_name" value="${c.cate_name }"/>
				<c:if test="${ fn:startsWith(cate_code,'IN') }">
					<option value="${c.cate_code }">${c.cate_name }</option>
				</c:if>		
				</c:forEach></select>
	<!-- 드롭다운 : 지출 -->
				<select name="SLCT_EX" id="slct_ex" onChange="setCCODE(this)">
					<option value="">--카테고리(지출)--</option>
				<c:forEach items="${CATELIST }" var="c">
				<c:set var="cate_code" value="${c.cate_code }"/>
				<c:set var="cate_name" value="${c.cate_name }"/>
				<c:if test="${ fn:startsWith(cate_code,'EX') }">
					<option value="${c.cate_code }">${c.cate_name }</option>
				</c:if>		
				</c:forEach></select>
			</td></tr>	
<!-- 4.거래내용 -->
		<tr><td><textarea name="ITEM" placeholder="내용을 입력하세요"
		 			cols="40" rows="5">${t.item }</textarea></td></tr>
<!-- 5.거래금액 -->
		<tr><td>
			<input type="text" placeholder="금액을 입력하세요" name="AMOUNT" value="${t.amount }"></td></tr>
<!-- 6.결제수단 -->	
	<!-- 현금or카드 버튼 -->
		<tr id="row_meth">
			<td><input type="hidden" name="SupMETHOD">
				<input type="text" name="MCODE" id="mcode"  placeholder="mcode 자동수신" value="${t.meth_code }">
				<input type="button" value="현금" onClick="doMN()" id="btn_mn">
				<input type="button" value="카드" onClick="doCRD()" id="btn_crd">
				</td>
	<!-- 드롭다운 : 현금 -->
			<td><select name="SLCT_MN" id="slct_mn" onChange="setMCODE(this.value)">
					<option value="">--결제수단(현금)--</option>
				<c:forEach items="${METHLIST }" var="m">
				<c:set var="meth_code" value="${m.meth_code }"/>
				<c:set var="meth_name" value="${m.meth_name }"/>
				<c:if test="${ fn:startsWith(meth_code,'MN') }">
					<option value="${m.meth_code }">${m.meth_name }</option>
				</c:if>		
				</c:forEach></select>
	<!-- 드롭다운 : 카드 -->
				<select name="SLCT_CRD" id="slct_crd" onChange="setMCODE(this.value)">
					<option value="">--결제수단(카드)--</option>
				<c:forEach items="${METHLIST }" var="m">
				<c:set var="meth_code" value="${m.meth_code }"/>
				<c:set var="meth_name" value="${m.meth_name }"/>
				<c:if test="${ fn:startsWith(meth_code,'CRD') }">
					<option value="${m.meth_code }">${m.meth_name }</option>
				</c:if>		
				</c:forEach></select>
			</td></tr>	
	<!-- (확인용 hidden) 전체 결제수단 출력-->
		<tr class="hidden test">
			<td><c:forEach items="${METHLIST }" var="m">
				<c:set var="meth_code" value="${m.meth_code }"/>
				<c:set var="meth_name" value="${m.meth_name }"/>
				<c:out value="${meth_code }"/> / <c:out value="${meth_name }"/><br>
				</c:forEach>
			</td></tr>
		<tr class="hidden test"><td><input type="text" name="TEST1"></td></tr>	
		<tr class="hidden test"><td><input type="text" name="TEST2"></td></tr>	
		<tr class="hidden test"><td><input type="text" name="TEST3"></td></tr>	
<!-- 7.안내문구 출력row -->			
		<tr><td id="guide"></td></tr>	
<!-- 8.form 등록/취소 -->			
		<tr><td><br>
			<input type="submit" value="저장">
			<input type="reset" value="취소" onClick="backToDetail(${t.seqno})"></td></tr>
		</table>
	</form>
</div>	<!-- contMain 끝 -->
</body>
<script src="makeTransaction.js">
/* 가계부 쓰기와 공통되는 기능들 ↑ 외부 js파일로 */
</script>
<script type="text/javascript">
/* 취소 버튼 클릭 시 */
function backToDetail(seqno){
// 	alert("backToDetail(seqno) 호출됨.");
	if(confirm("취소하고 상세화면으로 돌아가시겠습니까?")){
		location.href = "detailTransaction.do?SN="+seqno;
	}
	preset();
// 	alert("끝");
}
/* 수정 전 데이터에 따라 미리 html 요소 반영 */
function preset(){ 
	const pre_inex = document.preset.PRE_INEX.value;
	const pre_ccode = document.preset.PRE_CCODE.value;
	const pre_mcode = document.preset.PRE_MCODE.value;
// 	alert("preset() 호출됨");
	const pre_SupCate = pre_ccode.substring(0,2);
	const pre_SupMeth = pre_mcode.substring(0,2);
// 	alert("pre_inex : "+pre_inex+" /pre_ccode : "+pre_ccode+" /pre_mcode : "+pre_mcode
// 			+"\n=> pre_SupCate : "+pre_SupCate+" /pre_SupMeth : "+pre_SupMeth);
	switch(pre_inex){ // 수입or지출
	case "IN" : doIN(); break;
	case "EX" : doEX(); break;
	}
	switch(pre_SupCate){ //카테고리
	case "ca" : break; 
	case "IN" : document.fm.SLCT_IN.value = pre_ccode; break;
	case "EX" : document.fm.SLCT_EX.value = pre_ccode; break;
	}
	switch(pre_SupMeth){ //결제수단
	case "me" : break; 
	case "MN" : doMN(); document.fm.SLCT_MN.value = pre_mcode; break;
	case "CR" : doCRD(); document.fm.SLCT_CRD.value = pre_mcode; break;
	}
// 	alert("끝");
}
</script>
</html>