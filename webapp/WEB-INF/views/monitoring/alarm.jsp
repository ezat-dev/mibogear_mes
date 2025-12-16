<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>알람현황</title>
<%@include file="../include/pluginpage.jsp"%>
<jsp:include page="../include/tabBar.jsp" />
<!-- <link rel="stylesheet" href="/geomet/css/monitoring/alarm.css"> -->
<style>
.main {
	width: 98%;
}

.container {
	display: flex;
    justify-content: center;
    gap: 14px;
}
#alarmTable1 {
    font-size: 13px; /* 원하는 크기 (예: 12px, 0.8em 등)로 설정 */
}
#alarmTable2 {
    font-size: 13px; /* 원하는 크기 (예: 12px, 0.8em 등)로 설정 */
}
#alarmTable3 {
    font-size: 13px; /* 원하는 크기 (예: 12px, 0.8em 등)로 설정 */
}
#alarmTable4 {
    font-size: 13px; /* 원하는 크기 (예: 12px, 0.8em 등)로 설정 */
}
.tabb {
    width: 90%;
    margin-bottom: 22px;
    margin-top: 5px;
    height: 30px;
    border-radius: 6px 6px 0px 0px;
    display: flex;
    align-items: center;
    justify-content: space-between;
}
.machine-select-button{
    height: 32px;
    padding: 0 11px;
    border: 1px solid rgb(53, 53, 53);
    border-radius: 4px;
    background-color: #ffffff;
    cursor: pointer;
    display: flex;
    align-items: center;
}
.box1 label {
    font-size: 1.1em; /* 현재보다 조금 더 키우는 크기 (예: 110% 또는 16px 등으로 조절 가능) */
    margin-right: 5px; /* 선택적으로 셀렉트 박스와의 간격을 조금 벌립니다. */
}

/* 2. 셀렉트 박스(선택 박스) 높이 조정 */
#machine_name {
    height: 30px; /* 원하는 높이로 설정 (예: 30px, 35px 등) */
    padding: 0 11px;
    border: 1px solid rgb(53, 53, 53);
    border-radius: 4px;
    font-size: 1.0em; /* 선택 박스 내부의 글씨 크기도 필요하면 조정 */
    vertical-align: middle; /* 다른 요소들과 수직 정렬을 맞춥니다. */
}
</style>
<body>
    <div class="tabb">
    <div class="box1">
         <p class="tabP" style="font-size: 20px; margin-left: 40px; color: white; font-weight: 800;"></p>

		
			
	</div>
    <div class="button-container">
            
               <div class="box1">
				    <label for="machime_select">설비 선택:</label>
				    <select id="machine_name">
				        <option value="BCF1">BCF1</option>
				        <option value="BCF2">BCF2</option>
				        <option value="BCF3">BCF3</option>
				        <option value="BCF4">BCF4</option>
				        <option value="CM">CM</option>
				        <option value="CM2">CM2</option>
				    </select>
				</div>
        <button class="machine-select-button" onclick="getAlarm1();">
            <img src="/mibogear/image/search-icon.png" alt="select" class="button-image">
           조회
        </button>
    </div>
</div>
    <main class="main">
		<div class="container">
			<div id="alarmTable1" class="tabulator"></div>
			<div id="alarmTable2" class="tabulator"></div>
			<div id="alarmTable3" class="tabulator"></div>
			<div id="alarmTable4" class="tabulator"></div>
		</div>
	</main>
	<!-- <main class="main">
	<div class="alarm-big-box-1"></div>
    <div class="alarm-1">소입로 1존 FAN 이상</div>
    <div class="alarm-2">소입로 2존 FAN 이상</div>
    <div class="alarm-3">소입로 3존 FAN 이상</div>
    <div class="alarm-4">소입로 4존 FAN 이상</div>
    <div class="alarm-5">유조냉각 펌프#1 이상</div>
    <div class="alarm-6">유조냉각 펌프#2 이상</div>
    <div class="alarm-7">유조제트펌프 이상</div>
    <div class="alarm-8">유조콘베어 건조블로워 이상</div>
    <div class="alarm-9">소려로 1존 FAN 이상</div>
    <div class="alarm-10">소려로 2존 FAN 이상</div>
    <div class="alarm-11">소려로 3존 FAN 이상</div>
    <div class="alarm-12">소려로 4존 FAN 이상</div>
    <div class="alarm-13">소려로 5존 FAN 이상</div>
    <div class="alarm-14">소입로 1존 온도이상</div>
    <div class="alarm-15">소입로 2존 온도이상</div>
    <div class="alarm-16">소입로 3존 온도이상</div>
    <div class="alarm-17">소입로 4존 온도이상</div>
    <div class="alarm-18">소입로 5존 온도이상</div>
    <div class="alarm-19">중간세정기 온도이상</div>
    <div class="alarm-20">전세정기 온도이상</div>
    <div class="alarm-21">소입유조 온도이상</div>
    <div class="alarm-22">소려로 1존 온도이상</div>
    <div class="alarm-23">소려로 2존 온도이상</div>
    <div class="alarm-24">소려로 3존 온도이상</div>
    <div class="alarm-25">소려로 4존 온도이상</div>
    <div class="alarm-26">소려로 5존 온도이상</div>
    <div class="alarm-27">냉각조 온도이상</div>
    <div class="alarm-28">소입로 1존 SCR 이상</div>
    <div class="alarm-29">소입로 2존 SCR 이상</div>
    <div class="alarm-30">소입로 3존 SCR 이상</div>
    <div class="alarm-31">소입로 4존 SCR 이상</div>
    <div class="alarm-32">소입로 5존 SCR 이상</div>
    <div class="alarm-33">전세정기 인버터 이상</div>
    <div class="alarm-34">소입로 인버터 이상</div>
    <div class="alarm-35">아지테이터 인버터 이상</div>
    <div class="alarm-36">소입유조 인버터 이상</div>
    <div class="alarm-37">중간세정기 인버터 이상</div>
    <div class="alarm-38">소려로 인버터 이상</div>
    <div class="alarm-39">전세정기 스프레이펌프 이상</div>
    <div class="alarm-40">전세정기 FAN 이상</div>
    <div class="alarm-41">전세정기 오일스키머 이상</div>
    <div class="alarm-42">중간세정기 스프레이펌프 이상</div>
    <div class="alarm-43">중간세정기 FAN 이상</div>
    <div class="alarm-44">중간세정기 유수분리기 이상</div>
    <div class="alarm-45">냉각조 순환펌프 이상</div>
    <div class="alarm-46">냉각조 콘베이어 이상</div>
    <div class="alarm-47">소입로 처리품 과다</div>
    <div class="alarm-48">소려로 처리품 과다</div>
    <div class="alarm-49">전세정기 액면이상</div>
    <div class="alarm-50">중간세정기 액면이상</div>
    <div class="alarm-51">소입로 구동 이상</div>
    <div class="alarm-52">AIR 압력 이상</div>
    <div class="alarm-53">LPG 압력 이상</div>
    <div class="alarm-54">소입유조 액면이상</div>
    <div class="alarm-55">소입유조 액면 하한</div>
    <div class="alarm-56">냉각조 액면이상</div>
    <div class="alarm-57">CP 콘트롤 이상</div>
    <div class="alarm-58">소입로 CP 측정온도 도달,펌프기동요청</div>
    <div class="alarm-59">중간세정기 물보충 요청경보</div>
    <div class="alarm-60">유조 온도 상한, 냉각수 동작요청</div>
    <div class="alarm-61">중간세정기 오일스키머 기동 요청</div>
    <div class="alarm-62"></div>
    <div class="alarm-63">유조 구동모터 이상</div>
    <div class="alarm-64">소려로 구동모터 이상</div>
    <div class="alarm-65"></div>
    <div class="alarm-66">중간세정기 구동 콘베어 이상</div>
    <div class="alarm-67">방청조 구동 콘베어 이상</div>
    <div class="alarm-68">소입유조 냉각수 점검필요, 온도이상</div>
    <div class="alarm-69">소입유조 히터 점검필요, 온도이상</div>
    <div class="alarm-70">소려로 히터,조절계 점검필요</div>
    <div class="alarm-71">방청조 냉각수 점검필요</div>
    <div class="alarm-72">전세정기 온도조절계 점검필요</div>
    <div class="alarm-73">중간세정기 온도조절계 점검필요</div>
    <div class="alarm-74">소입로 FAN-1 동작 감지 이상</div>
    <div class="alarm-75">소입로 FAN-2 동작 감지 이상</div>
    <div class="alarm-76">소입로 FAN-3 동작 감지 이상</div>
    <div class="alarm-77">소입로 FAN-4 동작 감지 이상</div>
    <div class="alarm-78">아지테이터 동작 감지 이상</div>
    <div class="alarm-79">소려로 FAN-1 동작 감지 이상</div>
    <div class="alarm-80">소려로 FAN-2 동작 감지 이상</div>
    <div class="alarm-81">소려로 FAN-3 동작 감지 이상</div>
    <div class="alarm-82">소려로 FAN-4 동작 감지 이상</div>
    <div class="alarm-83">소려로 FAN-5 동작 감지 이상</div>
    <div class="alarm-84">전세정기 물보충 요청경보</div>
    <div class="alarm-85">소입로 구동롤러 구동요청(온도높음)</div>
    <div class="alarm-86">유조 펌프구동요청(소입로 온도높음)</div>
    <div class="alarm-87">내부전지 전압</div>
    <div class="alarm-88"></div>
    <div class="alarm-89"></div>
    <div class="alarm-90"></div>
    <div class="alarm-91"></div>
    <div class="alarm-92"></div>
    <div class="bcf-1">열처리 1호기</div>
	</main> -->


	<script>
	let now_page_code = "a02";
let alarmTable1;
let alarmTable2;
let alarmTable3;
let alarmTable4;
	//로드
	$(function(){

		alarmTable1 = new Tabulator("#alarmTable1", {
	        height: "750px",
	        layout: "fitColumns",
	        headerHozAlign: "center",
	        data: [], // 초기 데이터를 빈 배열로 설정
	        placeholder: "조회된 데이터가 없습니다.",
	        columns: [
	            {title: "idx", field: "idx", hozAlign: "center", visible:false},
	            {title: "NO", field: "r_num", hozAlign: "center", width: 30, headerSort:false},
	            {title:"호기", field:"alarm_hogi", sorter:"string", width:60, hozAlign:"center", headerSort:false, visible: false},
	            {title:"주소", field:"addr", sorter:"string", width:70,hozAlign:"center", headerSort:false},
	            {title:"알람 내용", field:"comment", sorter:"string", width:280,headerSort:false},
	            {title:"값", field:"value", width:80,hozAlign:"center", headerSort:false, visible:false}
	        ],
	        rowFormatter:function(row){
	            var data = row.getData();
	            
	            row.getElement().style.fontWeight = "700";
	            row.getElement().style.backgroundColor = "#FFFFFF"; // 기본 배경색 (흰색)
	            
	            if (data.value == 1) { 
	                row.getElement().style.backgroundColor = "#FFDDDD"; // 연한 붉은색
	            }
	        },
	    });

		alarmTable2 = new Tabulator("#alarmTable2", {
	        height: "750px",
	        layout: "fitColumns",
	        headerHozAlign: "center",
	        data: [], // 초기 데이터를 빈 배열로 설정
	        placeholder: "조회된 데이터가 없습니다.",
	        columns: [
	            {title: "idx", field: "idx", hozAlign: "center", visible:false},
	            {title: "NO", field: "r_num", hozAlign: "center", width: 30, headerSort:false},
	            {title:"호기", field:"alarm_hogi", sorter:"string", width:60, hozAlign:"center", headerSort:false, visible: false},
	            {title:"주소", field:"addr", sorter:"string", width:70,hozAlign:"center", headerSort:false},
	            {title:"알람 내용", field:"comment", sorter:"string", width:280,headerSort:false},
	            {title:"값", field:"value", width:80,hozAlign:"center", headerSort:false, visible:false}
	        ],
	        rowFormatter:function(row){
	            var data = row.getData();
	            
	            row.getElement().style.fontWeight = "700";
	            row.getElement().style.backgroundColor = "#FFFFFF"; // 기본 배경색 (흰색)
	            
	            if (data.value == 1) { 
	                row.getElement().style.backgroundColor = "#FFDDDD"; // 연한 붉은색
	            }
	        },
	    });

		alarmTable3 = new Tabulator("#alarmTable3", {
	        height: "750px",
	        layout: "fitColumns",
	        headerHozAlign: "center",
	        data: [], // 초기 데이터를 빈 배열로 설정
	        placeholder: "조회된 데이터가 없습니다.",
	        columns: [
	            {title: "idx", field: "idx", hozAlign: "center", visible:false},
	            {title: "NO", field: "r_num", hozAlign: "center", width: 30, headerSort:false},
	            {title:"호기", field:"alarm_hogi", sorter:"string", width:60, hozAlign:"center", headerSort:false, visible: false},
	            {title:"주소", field:"addr", sorter:"string", width:70,hozAlign:"center", headerSort:false},
	            {title:"알람 내용", field:"comment", sorter:"string", width:280,headerSort:false},
	            {title:"값", field:"value", width:80,hozAlign:"center", headerSort:false, visible:false}
	        ],
	        rowFormatter:function(row){
	            var data = row.getData();
	            
	            row.getElement().style.fontWeight = "700";
	            row.getElement().style.backgroundColor = "#FFFFFF"; // 기본 배경색 (흰색)
	            
	            if (data.value == 1) { 
	                row.getElement().style.backgroundColor = "#FFDDDD"; // 연한 붉은색
	            }
	        },
	    });

		alarmTable4 = new Tabulator("#alarmTable4", {
	        height: "750px",
	        layout: "fitColumns",
	        headerHozAlign: "center",
	        data: [], // 초기 데이터를 빈 배열로 설정
	        placeholder: "조회된 데이터가 없습니다.",
	        columns: [
	            {title: "idx", field: "idx", hozAlign: "center", visible:false},
	            {title: "NO", field: "r_num", hozAlign: "center", width: 30, headerSort:false},
	            {title:"호기", field:"alarm_hogi", sorter:"string", width:60, hozAlign:"center", headerSort:false, visible: false},
	            {title:"주소", field:"addr", sorter:"string", width:70,hozAlign:"center", headerSort:false},
	            {title:"알람 내용", field:"comment", sorter:"string", width:280,headerSort:false},
	            {title:"값", field:"value", width:80,hozAlign:"center", headerSort:false, visible:false}
	        ],
	        rowFormatter:function(row){
	            var data = row.getData();
	            
	            row.getElement().style.fontWeight = "700";
	            row.getElement().style.backgroundColor = "#FFFFFF"; // 기본 배경색 (흰색)
	            
	            if (data.value == 1) { 
	                row.getElement().style.backgroundColor = "#FFDDDD"; // 연한 붉은색
	            }
	        },
	    });

	    getAlarm1();
		
	});

	const alarmInterval = setInterval(getAlarm1, 10000);
	
	function getAlarm1(){
		console.log("getAlarm1 함수 실행");
		var machine_name = $("#machine_name").val();
		
		$.ajax({
	        url: "/mibogear/monitoring/getAlarm1",
	        type: "POST",
	        dataType: "json",
	        contentType: "application/json;charset=UTF-8",
	        data: JSON.stringify({ machine_name: machine_name }), 
	        
	        success: function(allData) {
	            var data1 = allData.slice(0, 25); 
	            var data2 = allData.slice(25, 50);
	            var data3 = allData.slice(50, 75);
	            var data4 = allData.slice(75, 100);
	            
	            if(alarmTable1) {
	                alarmTable1.setData(data1); 
	            }
	            if(alarmTable2) { 
	                alarmTable2.setData(data2);
	            }
	            if(alarmTable3) { 
	                alarmTable3.setData(data3);
	            }
	            if(alarmTable4) { 
	                alarmTable4.setData(data4);
	            }
	            
	            console.log("Tabulator에 데이터 로드 완료");
	        },
	        error: function(xhr, status, error) {
	            console.error("데이터 조회 오류:", error);
	            // 에러 발생 시 테이블을 비워주는 것이 좋습니다.
	            if(alarmTable1) alarmTable1.clearData();
	            if(alarmTable2) alarmTable2.clearData();
	            alert("데이터를 불러오는데 실패했습니다.");
	        }
	    });
	}


	/* //OPC값 알람 조회
    function getAlarm1(){
		$.ajax({
			url:"/tkheat/monitoring/getAlarm1",
			type:"post",
			dataType:"json",
			success:function(result){				
				var data = result.multiValues;
				
	            for(let key in data){
	            	for(let keys in data[key]){
	            		var d = data[key];
						
						if(d[keys].action == "c"){
							c(keys, d[keys].value)	
						}
	            	}                    	
	            }
			}
		});
	}
	
	function c(keys, value){
//		$("."+keys).text(value);
		
		if(value == true){
			$("."+keys).css("background-color","red");
			$("."+keys).css("color","white");
		}else{
			$("."+keys).css("background-color","#f1f1f1");
			$("."+keys).css("color","black");
		}
		
	} */

	

	

    </script>

</body>
</html>
