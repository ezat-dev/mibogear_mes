<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">

<!-- 제이쿼리홈페이지 js -->
<script type="text/javascript" src="/mibogear/js/jquery-3.7.1.min.js"></script>

<!-- Tabulator 테이블 -->
<script type="text/javascript" src="/mibogear/js/tabulator/tabulator.js"></script>
<link rel="stylesheet" href="/mibogear/css/tabulator/tabulator_simple.css">

<!-- moment -->
<script type="text/javascript" src="/mibogear/js/moment/moment.min.js"></script>

<!-- 화면캡쳐용 -->
<script type="text/javascript" src="/mibogear/js/html2canvas.js"></script>


<!-- 하이차트 -->
<script type="text/javascript" src="/mibogear/js/highchart/highcharts.js"></script>
<script type="text/javascript" src="/mibogear/js/highchart/exporting.js"></script>
<script type="text/javascript" src="/mibogear/js/highchart/export-data.js"></script>
<script type="text/javascript" src="/mibogear/js/highchart/data.js"></script>


<!-- Air Datepicker -->
<script type="text/javascript" src="/mibogear/js/airdatepicker/datepicker.min.js"></script>
<script type="text/javascript" src="/mibogear/js/airdatepicker/datepicker.ko.js"></script>
<link rel="stylesheet" href="/mibogear/css/airdatepicker/datepicker.min.css"> 


<style>


</style>
<script>

$(function(){


	rpImagePopup();






	

	//airDatePicker 설정
	//날짜 : 일
	 $(".daySet").datepicker({
    	language: 'ko',
    	autoClose: true,
    }); 


	 $(".datetimeSet").datepicker({
		    language: 'ko',
		    timepicker: true,            // 시분 선택 가능
		    dateFormat: 'yyyy-mm-dd',
		    timeFormat: 'hh:ii',         // 시:분 형식
		    autoClose: true
		});
	    
	//날짜 : 월
   $(".monthSet").datepicker({
	    language: 'ko',           // 한국어 설정
	    view: 'months',           // 월만 표시
	    minView: 'months',        // 월만 선택 가능
	    dateFormat: 'yyyy-mm',    // 연도-월 형식 지정
	    autoClose: true,          // 월 선택 후 자동 닫힘
	});
   

    //날짜 : 년
	 $(".yearSet").datepicker({
	  language: 'ko',
      view: 'years',          // 연도만 표시
      minView: 'years',       // 연도만 표시하여 날짜 선택 비활성화
      dateFormat: 'yyyy',     // 연도 형식 지정
      autoClose: true,        // 연도 선택 후 자동 닫힘
      language: 'ko'          // 한국어 설정
  });

	 $(".monthDaySet").datepicker({
		    language: 'ko',
		    autoClose: true,
		    dateFormat: 'mm-dd',     // 📌 "월-일" 형식만 표시
		    view: 'days',            // 기본 day 뷰 사용
		    minView: 'days',         // day까지만 표시
		    onShow: function(inst, animationCompleted){
		        // 연도, 월 선택 영역 숨김 (디자인적으로)
		        $('.datepicker--nav-title i, .datepicker--nav-title span').hide();
		    }
		});

/*
   // AirDatepicker 초기화
   new AirDatepicker('.datepicker', {
       autoClose: true,
       dateFormat: 'yyyy-MM-dd',
       locale: {
           days: ['일', '월', '화', '수', '목', '금', '토'],
           daysShort: ['일', '월', '화', '수', '목', '금', '토'],
           daysMin: ['일', '월', '화', '수', '목', '금', '토'],
           months: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
           monthsShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
           today: '오늘',
           clear: '초기화',
           firstDay: 0
       },
       // 일, 월, 년을 선택할 수 있게 하기 위한 설정
       view: 'days',  // 일, 월, 년 선택을 가능하게 함
       minView: 'days', // 날짜만 선택 가능
   });
*/
		
});

//오늘날짜 년-월-일
function todayDate(){
	var now = new Date();
	var y = now.getFullYear();
	var m = paddingZero(now.getMonth()+1);
	var d = paddingZero(now.getDate());
		
	return y+"-"+m+"-"+d; 
}

//어제날짜 년-월-일
function yesterDate(){
	var now = new Date();
	var y = now.getFullYear();
	var m = paddingZero(now.getMonth()+1);
	var d = paddingZero(now.getDate()-1);
		
	return y+"-"+m+"-"+d; 	
}

//왼쪽 0채우기
function paddingZero(value){
	var rtn = "";

	if(value < 10){
		rtn = "0"+value;
	}else{
		rtn = value;
	}

	return rtn;
}

function rpImagePopup() {
    var img = document.createElement("img");
//    console.log(img);
    
    // $(img).attr("src", "imgs/noimage_01.gif");
    $(img).css("width", "600");
    $(img).css("height", "500");
    
    var div = document.createElement("div");
    $(div).css("position", "absolute");
    $(div).css("display", "none");
    $(div).css("z-index", "24999");
    $(div).append(img);
    $(div).hide();
    $("body").append(div);

    $(document).on("mouseover", ".rp-img-popup > img", function(){
            $(img).attr("src", $(this).attr("src"));
            $(div).show();
            var iHeight = (document.body.clientHeight / 2) - $(img).height() / 2 + document.body.scrollTop;   // 화면중앙
            var iWidth = (document.body.clientWidth / 2) - $(img).width() / 2 + document.body.scrollLeft;
            $(div).css("left", iWidth);
            $(div).css("top", 100);
        })
        .on("mouseout", ".rp-img-popup > img", function(){
            $(div).hide();
        });
    
    $(document).on("mouseover", ".rp-img-popup", function(){
        $(img).attr("src", $(this).attr("src"));
        $(div).show();
        var iHeight = (document.body.clientHeight / 2) - $(img).height() / 2 + document.body.scrollTop;   // 화면중앙
        var iWidth = (document.body.clientWidth / 2) - $(img).width() / 2 + document.body.scrollLeft;
        $(div).css("left", iWidth);
        $(div).css("top", 100);
    })
    .on("mouseout", ".rp-img-popup", function(){
        $(div).hide();
    });
}


function pageObject(paramKey){
	//console.log("받은 키값 : "+paramKey);
	var obj = {
			//모니터링
			"a01":["/mibogear/monitoring/overView","통합 모니터링"],
			"a02":["/mibogear/monitoring/alarm","알람현황"],
			"a03":["/mibogear/monitoring/alarmHistory","알람이력"],
			"a04":["/mibogear/monitoring/alarmRanking","알람랭킹"],
			"a05":["/mibogear/monitoring/trend","트렌드"],
			"a06":"",
			"a07":"",
			//생산관리
			"b01":["/mibogear/productionManagement/lotReport","LOT보고서"],
			"b02":["/mibogear/productionManagement/integrationProduction","종합생산현황"],
			"b03":["/mibogear/productionManagement/workDailyReport","작업일보"],
			"b04":"",
			"b05":"",
			"b06":"",
			"b07":"",
			//조건관리
			"c01":["/mibogear/condition/thermocoupleChange","열전대교체이력"],
			"c02":["/mibogear/condition/tempCorrection","온도조절계보정현황"],
			"c03":["/mibogear/condition/heatTreatingOil","열처리유성상분석"],
			"c04":["/mibogear/condition/dailyCheck","일상점검일지"],
			"c05":"",
			"c06":"",
			"c07":"",
			//설비보존관리
			"d01":["/mibogear/preservation/sparePart","Spare부품관리"],
			//"d02":["/mibogear/preservation/begaInsert","설비비가동등록"],
			"d03":["/mibogear/preservation/suriHistory","설비수리이력관리"],
			"d04":["/mibogear/preservation/yearCheck","연간점검"],
			"d05":"",
			"d06":"",
			"d07":"",
			//품질관리
			"e01":["/mibogear/quality/tempUniformity","온도균일성 조사보고서"],
			"e02":["/mibogear/quality/fProof","F/PROOF"],
			//"e03":["/mibogear/quality/cpk","Cpk"],
			//"e04":["/mibogear/quality/ppk","Ppk"],
			"e05":"",
			"e06":"",
			"e07":"",
			"e08":"",
			"e09":"",
			"e10":"",
			"e11":"",

			//기준관리
			"f01":["/mibogear/standardManagement/productInsert","제품등록"],
			"f02":["/mibogear/standardManagement/facInsert","설비등록"],
			"f03":["/mibogear/standardManagement/cutumInsert","거래처등록"],
			"f04":["/mibogear/standardManagement/standard","작업표준등록"],
			"f05":["/mibogear/user/userInsert","사용자등록"],
			"f06":["/mibogear/user/userPermission","사용자권한부여"],
			"f07":["/mibogear/standardManagement/measurement","측정기기관리"],


			//제품관리
			"g01":["/mibogear/productionManagement/ipgo","입고관리"],
			"g02":["/mibogear/productionManagement/chulgo","출고관리"],
			"g03":["/mibogear/productionManagement/ipChulgoStatus","입출고관리현황"],
			"g04":"",
			"g05":"",
			"g06":"",
			"g07":"",

			
	};
	
/*	
	console.log(obj);
	console.log(obj[paramKey][0]);*/
	
	return obj[paramKey];
}

let userPermissions = {};

function userInfoList(now_page_code) {
    $.ajax({
        url: '/mibogear/user/info',
        type: 'POST',
        contentType: 'application/json',
        dataType: 'json',
        success: function(response) {
            const loginUserPage = response.loginUserPage;
            userPermissions = loginUserPage || {};
            controlButtonPermissions(now_page_code);
        },
        error: function(xhr, status, error) {
            console.error("데이터 가져오기 실패:", error);
        }
    });
}

function controlButtonPermissions(now_page_code) {
    const permission = userPermissions?.[now_page_code];
    console.log("현재 페이지 권한(permission):", permission);

    const canRead = permission === "R" || permission === "C" || permission === "D";
    const canCreate = permission === "C" || permission === "D";
    const canDelete = permission === "D";

    if (!canRead) {
        $(".select-button").css("pointer-events", "none").css("background-color", "#ced4da");
    }

    if (!canCreate) {
        $(".insert-button").css("pointer-events", "none").css("background-color", "#ced4da");
        $("#corrForm").prop("disabled", true);
    }

    if (!canDelete) {
        $(".delete-button").css("pointer-events", "none").css("background-color", "#ced4da");
    }

    $(".select-button").on("click", function (e) {
        if (!canRead) {
            alert("당신의 권한이 없습니다. (조회)");
            e.preventDefault();
            e.stopImmediatePropagation();
        }
    });

    $(".insert-button").on("click", function (e) {
        if (!canCreate) {
            alert("당신의 권한이 없습니다. (추가)");
            e.preventDefault();
            e.stopImmediatePropagation();
        }
    });

    $(".delete-button").on("click", function (e) {
        if (!canDelete) {
            alert("당신의 권한이 없습니다. (삭제)");
            e.preventDefault();
            e.stopImmediatePropagation();
        }
    });
}


$(document).ready(function() {
    userInfoList(now_page_code);
    console.log("나우페이지코드",now_page_code)
});



</script>
