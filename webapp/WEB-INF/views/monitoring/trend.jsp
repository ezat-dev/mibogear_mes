<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>트렌드</title>
    <%@include file="../include/pluginpage.jsp" %>
    <jsp:include page="../include/tabBar.jsp"/>

    <style>
        body { overflow: hidden; }

        .main-container {
            width: 98%;
            margin: 0 auto;
            padding: 20px;
        }

        .button-container {
            display: flex;
            justify-content: flex-start;
            align-items: center;
            gap: 15px;
            padding: 2px 20px;
            background: #f4f4f4;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            flex-wrap: wrap;
        }

        .daylabel {
            font-size: 16px;
            font-weight: bold;
            color: #333;
        }

        .date_input {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .datetimeSet {
            height: 38px;
            font-size: 15px;
            padding: 0 12px;
            border-radius: 6px;
            border: 1px solid #ccc;
            background: white;
            text-align: center;
            transition: border 0.3s;
        }

        .datetimeSet:focus {
            outline: none;
            border-color: #007bff;
        }

        .mid {
            margin: 0 5px;
            font-size: 18px;
            font-weight: bold;
            color: #555;
        }

        .select-button {
            display: flex;
            align-items: center;
            gap: 6px;
            height: 38px;
            padding: 0 16px;
            border-radius: 6px;
            border: 1px solid #007bff;
            background: #007bff;
            color: white;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
            transition: all 0.2s;
        }

        .select-button:hover {
            background: #0056b3;
            border-color: #0056b3;
        }

        /* ✅ 메모 추가 버튼 */
        .insert-button {
            display: flex;
            align-items: center;
            gap: 6px;
            height: 38px;
            padding: 0 16px;
            border-radius: 6px;
            border: 1px solid #28a745;
            background: #28a745;
            color: white;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
            transition: all 0.2s;
        }

        .insert-button:hover {
            background: #1e7e34;
        }

        .print-button {
            display: flex;
            align-items: center;
            gap: 6px;
            height: 38px;
            padding: 0 16px;
            border-radius: 6px;
            border: 1px solid #6c757d;
            background: white;
            color: #333;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
            transition: all 0.2s;
        }

        .print-button:hover {
            background: #f0f0f0;
        }

        .button-image {
            width: 18px;
            height: 18px;
        }

        .select-button .button-image {
            filter: brightness(0) invert(1);
        }

        .insert-button .button-image {
            filter: brightness(0) invert(1);
        }

        .trend-option label {
            display: flex;
            align-items: center;
            gap: 6px;
            font-size: 15px;
            cursor: pointer;
            color: #333;
        }

        .trend-option input[type="checkbox"] {
            width: 18px;
            height: 18px;
            cursor: pointer;
        }

        .hogi-selector {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-left: auto;
        }

        .hogi-btn {
            min-width: 80px;
            height: 38px;
            padding: 0 16px;
            border: 2px solid #007bff;
            background: white;
            color: #007bff;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
            transition: all 0.2s;
        }

        .hogi-btn:hover {
            background: #e3f2fd;
            transform: translateY(-1px);
            box-shadow: 0 2px 6px rgba(0,123,255,0.3);
        }

        .hogi-btn.active {
            background: #007bff;
            color: white;
            box-shadow: 0 2px 8px rgba(0,123,255,0.4);
        }

        #container {
            width: 100%;
            height: 600px;
            margin-top: 10px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            background: white;
            padding: 10px;
        }

        /* ✅ 모달 */
        .modal {
            display: none;
            position: fixed;
            left: 0; top: 0;
            width: 100%; height: 100%;
            background-color: rgba(0,0,0,0.5);
            z-index: 20010;
            overflow: auto;
        }

        .modal-content {
            background: white;
            width: 360px;
            max-height: 800px;
            overflow-y: auto;
            margin: 5% auto;
            padding: 24px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.3);
            position: relative;
            transform: scale(0.8);
            opacity: 0;
            transition: transform 0.3s ease, opacity 0.3s ease;
        }

        .modal.show { display: block; }

        .modal.show .modal-content {
            transform: scale(1);
            opacity: 1;
        }

        .close {
            position: absolute;
            right: 15px; top: 10px;
            font-size: 24px;
            font-weight: bold;
            cursor: pointer;
            background: none;
            border: none;
        }

        .modal-content form {
            display: flex;
            flex-direction: column;
        }

        .modal-content label {
            font-weight: bold;
            margin: 10px 0 5px;
        }

        .modal-content input {
            width: 93%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }

        .modal-content button {
            background-color: #d3d3d3;
            color: black;
            padding: 10px;
            border: none;
            border-radius: 5px;
            margin-top: 10px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .modal-content button:hover { background-color: #a9a9a9; }
    </style>
</head>
<body>

<!-- ✅ 트렌드 메모 모달 -->
<div id="modalContainer" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>트렌드 메모 등록</h2>
        <form id="corrForm" autocomplete="off">
            <input type="hidden" name="user_code">
            <label>작업자</label>
            <input type="text" name="writer" readonly>
            <label>등록시간</label>
            <input type="text" name="date">
            <label>등록내용</label>
            <input type="text" name="memo">
            <label>비고</label>
            <input type="text" name="note">
            <hr/>
            <button type="submit" id="saveCorrStatus">저장</button>
            <button type="button" id="closeModal">닫기</button>
        </form>
    </div>
</div>

<div class="main-container">
    <div class="button-container">

        <label class="daylabel">검색 날짜 :</label>
        <div class="date_input">
            <input type="text" autocomplete="off" class="datetimeSet" id="startDate">
            <span class="mid"> ~ </span>
            <input type="text" autocomplete="off" class="datetimeSet" id="endDate">
        </div>

        <button class="select-button" id="btnSearch">
            <img src="/mibogear/image/search-icon.png" alt="조회" class="button-image">조회
        </button>

        <!-- ✅ 메모 추가 버튼 -->
        <button class="insert-button" id="btnInsert">
            📝 메모 추가
        </button>

        <button class="print-button" id="printBtn">🖨️ 인쇄</button>

        <div class="trend-option">
            <label>
                <input type="checkbox" id="toggleMarker">포인트 표시
            </label>
        </div>

        <div class="hogi-selector">
            <button class="hogi-btn active" data-hogi="bcf1">BCF1</button>
            <button class="hogi-btn" data-hogi="bcf2">BCF2</button>
            <button class="hogi-btn" data-hogi="bcf3">BCF3</button>
            <button class="hogi-btn" data-hogi="bcf4">BCF4</button>
        </div>
    </div>

    <div id="container"></div>
</div>

<script>
/* ===================== 전역 변수 ===================== */
let chart = null;
let markerEnabled = false;
let hogi = "bcf1";
let trendInterval = null;

/* ===================== 날짜 유틸 ===================== */
function pad(n){ return n < 10 ? "0"+n : n; }

function nowStr(){
    const d = new Date();
    return d.getFullYear()+"-"+pad(d.getMonth()+1)+"-"+pad(d.getDate())
          +" "+pad(d.getHours())+":"+pad(d.getMinutes());
}

function before8Hours(){
    const d = new Date();
    d.setHours(d.getHours()-8);
    return d.getFullYear()+"-"+pad(d.getMonth()+1)+"-"+pad(d.getDate())
          +" "+pad(d.getHours())+":"+pad(d.getMinutes());
}

/* ===================== 범례 저장/복원 ===================== */
function saveLegendState(){
    if(!chart) return;
    const state = {};
    chart.series.forEach(s => { state[s.name] = s.visible; });
    localStorage.setItem('trendLegendState_' + hogi, JSON.stringify(state));
}

function loadLegendState(){
    const saved = localStorage.getItem('trendLegendState_' + hogi);
    return saved ? JSON.parse(saved) : null;
}

/* ===================== X축 최적 설정 ===================== */
function getOptimalSettings(rangeMillis){
    const rangeHours = rangeMillis / (60*60*1000);
    const rangeDays  = rangeHours / 24;

    if(rangeDays > 30)        return { tickInterval: 24*60*60*1000, labelFmt: "%m-%d" };
    else if(rangeDays > 14)   return { tickInterval: 12*60*60*1000, labelFmt: "%m-%d<br>%H:%M" };
    else if(rangeDays > 7)    return { tickInterval:  6*60*60*1000, labelFmt: "%m-%d<br>%H:%M" };
    else if(rangeDays > 3)    return { tickInterval:  3*60*60*1000, labelFmt: "%m-%d<br>%H:%M" };
    else if(rangeDays > 1)    return { tickInterval:  2*60*60*1000, labelFmt: "%m-%d<br>%H:%M" };
    else if(rangeHours >= 6)  return { tickInterval:    60*60*1000, labelFmt: "%m-%d<br>%H:%M" };
    else if(rangeHours > 3)   return { tickInterval:  15*60*1000,   labelFmt: "%H:%M" };
    else if(rangeHours > 1)   return { tickInterval:  10*60*1000,   labelFmt: "%H:%M" };
    else                      return { tickInterval:   5*60*1000,   labelFmt: "%H:%M" };
}

/* ===================== 마우스 휠 줌 ===================== */
function enableMouseWheelZoom(){
    $('#container').off('wheel').on('wheel', function(e){
        if(!chart) return;
        e.preventDefault();
        const xAxis   = chart.xAxis[0];
        const ext     = xAxis.getExtremes();
        const range   = ext.max - ext.min;
        const factor  = e.originalEvent.deltaY > 0 ? 1.1 : 0.9;
        const newRange = range * factor;

        if(newRange > (ext.dataMax - ext.dataMin)){
            xAxis.setExtremes(ext.dataMin, ext.dataMax);
            return;
        }
        if(newRange < 60000) return;

        const ratio  = e.originalEvent.offsetX / chart.chartWidth;
        const center = ext.min + range * ratio;
        const newMin = Math.max(ext.dataMin, center - newRange * ratio);
        const newMax = Math.min(ext.dataMax, center + newRange * (1-ratio));
        xAxis.setExtremes(newMin, newMax);

        const s = getOptimalSettings(newMax - newMin);
        chart.xAxis[0].update({ tickInterval: s.tickInterval, labels:{ formatter: function(){ return Highcharts.dateFormat(s.labelFmt, this.value); } } });
    });
}

/* ===================== 시리즈 구성 ===================== */
function buildSeries(result, targetHogi){
    const cfArr=[], oilArr=[], cpArr=[], tempArr=[];
    const memo = []; // ✅ 메모 배열 추가

    result.forEach(function(r){
        const t = new Date(r.date).getTime();
        if(targetHogi === "bcf1"){
            cfArr.push([t, +r.bcf1_chim]);
            oilArr.push([t, +r.bcf1_oil]);
            cpArr.push([t, +r.bcf1_cp]);
            tempArr.push([t, +r.bcf1_tempering]);
        } else if(targetHogi === "bcf2"){
            cfArr.push([t, +r.bcf2_chim]);
            oilArr.push([t, +r.bcf2_oil]);
            cpArr.push([t, +r.bcf2_cp]);
        } else if(targetHogi === "bcf3"){
            cfArr.push([t, +r.bcf3_chim]);
            oilArr.push([t, +r.bcf3_oil]);
            cpArr.push([t, +r.bcf3_cp]);
            tempArr.push([t, +r.bcf3_tempering]);
        } else if(targetHogi === "bcf4"){
            cfArr.push([t, +r.bcf4_chim]);
            oilArr.push([t, +r.bcf4_oil]);
            cpArr.push([t, +r.bcf4_cp]);
        }

        // ✅ 메모 처리
        if((r.memo && r.memo.trim() && r.memo !== '0') ||
           (r.note && r.note.trim() && r.note !== '0')){
            const parts = [];
            if(r.memo && r.memo.trim() && r.memo !== '0') parts.push("메모: " + r.memo);
            if(r.note && r.note.trim() && r.note !== '0') parts.push("비고: " + r.note);
            if(r.writer) parts.push("작성자: " + r.writer);
            memo.push({ x: t, y: 950, desc: parts.join("<br/>") });
        }
    });

    const label = { bcf1:"1호기", bcf2:"2호기", bcf3:"3호기", bcf4:"4호기" }[targetHogi];
    const hasTempering = (targetHogi === "bcf1" || targetHogi === "bcf3");

    const series = [
        { name: label+" 침탄", data: cfArr,  color:"red",    yAxis:0 },
        { name: label+" 유조", data: oilArr, color:"orange", yAxis:0 },
        { name: label+" CP",   data: cpArr,  color:"blue",   yAxis:1 }
    ];

    if(hasTempering){
        series.push({ name: label+" 소려", data: tempArr, color:"purple", yAxis:0 });
    }

    // ✅ 메모 시리즈 추가
    series.push({
        name: "메모",
        type: "scatter",
        data: memo,
        yAxis: 0,
        enableMouseTracking: true,
        marker: { symbol: "circle", radius: 6, fillColor: "#ff9900" },
        dataLabels: {
            enabled: true,
            useHTML: true,
            formatter: function(){ return "<span style='font-size:14px;'>📝</span>"; }
        },
        tooltip: {
            pointFormatter: function(){
                return '<span style="color:#ff9900">\u25CF</span> '
                      + (this.desc || "") + '<br/>';
            }
        }
    });

    return series;
}

/* ===================== 차트 생성 ===================== */
function createChart(series, dataRange){
    const legendState = loadLegendState();
    if(legendState){
        series.forEach(s => {
            if(legendState.hasOwnProperty(s.name)) s.visible = legendState[s.name];
        });
    }

    const s = getOptimalSettings(dataRange);

    if(chart){
        chart.destroy();
        chart = null;
    }

    chart = Highcharts.chart('container', {
        chart:{
            type: "line",
            zoomType: "x",
            panning: true,
            panKey: "shift",
            height: 600,
            events:{
                selection: function(event){
                    if(event.xAxis){
                        const range = event.xAxis[0].max - event.xAxis[0].min;
                        const opt = getOptimalSettings(range);
                        const self = this;
                        setTimeout(function(){
                            self.xAxis[0].update({
                                tickInterval: opt.tickInterval,
                                labels:{ formatter: function(){ return Highcharts.dateFormat(opt.labelFmt, this.value); } }
                            });
                        }, 100);
                    }
                }
            }
        },
        title:{ text: { bcf1:"1호기", bcf2:"2호기", bcf3:"3호기", bcf4:"4호기" }[hogi] + " 트렌드" },
        xAxis:{
            type: "datetime",
            tickInterval: s.tickInterval,
            labels:{ formatter: function(){ return Highcharts.dateFormat(s.labelFmt, this.value); } }
        },
        yAxis:[
            {
                title:{ text:"온도(℃)" },
                min:0, max:1000,
                tickInterval: 100,
                endOnTick: false
            },
            {
                title:{ text:"CP" },
                opposite: true,
                min:0, max:2.5,
                tickInterval: 0.25,
                gridLineWidth: 0,
                endOnTick: false,
                labels:{
                    formatter: function(){ return this.value.toFixed(2); }
                }
            }
        ],
        tooltip:{
            shared: true,
            crosshairs: true,
            xDateFormat: "%Y-%m-%d %H:%M",
            pointFormatter: function(){
                // ✅ 메모 시리즈는 별도 포맷
                if(this.series.name === "메모"){
                    return this.desc
                        ? '<span style="color:#ff9900">\u25CF</span> ' + this.desc + '<br/>'
                        : '';
                }
                const val = this.series.name.includes("CP")
                    ? this.y.toFixed(3)
                    : Math.round(this.y);
                return '<span style="color:'+this.color+'">\u25CF</span> '
                      + this.series.name + ': <b>' + val + '</b><br/>';
            }
        },
        plotOptions:{
            series:{
                marker:{ enabled: markerEnabled },
                events:{
                    legendItemClick: function(){ setTimeout(saveLegendState, 100); }
                }
            },
            // ✅ scatter는 marker 항상 표시
            scatter:{
                marker:{ enabled: true }
            }
        },
        legend:{ enabled:true, align:"center", verticalAlign:"bottom" },
        exporting:{
            enabled: true,
            buttons:{
                contextButton:{
                    menuItems:[
                        {
                            text: "PNG 다운로드",
                            onclick: function(){
                                this.exportChart({ type:"image/png", filename: getFilename("png") });
                            }
                        },
                        {
                            text: "CSV 다운로드",
                            onclick: function(){ downloadCSV(this); }
                        }
                    ]
                }
            }
        },
        series: series
    });

    enableMouseWheelZoom();
}

/* ===================== 파일명 / CSV ===================== */
function getFilename(ext){
    const d = new Date();
    return d.getFullYear()+pad(d.getMonth()+1)+pad(d.getDate())
          +pad(d.getHours())+pad(d.getMinutes())+pad(d.getSeconds())
          +"_"+hogi+"_트렌드."+ext;
}

function downloadCSV(targetChart){
    const csv = targetChart.getCSV();
    if(!csv || !csv.trim()){ alert('CSV 데이터가 없습니다.'); return; }
    const blob = new Blob([csv], { type:"text/csv;charset=utf-8;" });
    const link = document.createElement("a");
    link.href = URL.createObjectURL(blob);
    link.download = getFilename("csv");
    link.style.visibility = "hidden";
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
}

/* ===================== 데이터 조회 ===================== */
function fetchData(){
    const startDate = $("#startDate").val();
    const endDate   = $("#endDate").val();
    const machine   = hogi;

    $.ajax({
        type: "POST",
        url: "/mibogear/monitoring/getTempList",
        data: { startDate, endDate, machine },
        success: function(result){
            if(!result || result.length === 0){
                alert("조회된 데이터가 없습니다.");
                return;
            }

            const times   = result.map(r => new Date(r.date).getTime());
            const dataMin = Math.min(...times);
            const dataMax = Math.max(...times);
            const range   = dataMax - dataMin;

            const series = buildSeries(result, hogi);
            createChart(series, range);
        },
        error: function(xhr, status, error){
            console.error("에러:", error);
            alert("데이터 조회 중 오류가 발생했습니다.");
        }
    });
}

/* ===================== 인쇄 ===================== */
$("#printBtn").on("click", function(){
    const style = document.createElement("style");
    style.innerHTML = `
        @page { size:A4 landscape; margin:10mm; }
        @media print { body { zoom:67%; } #container { width:1700px !important; height:660px !important; } }
    `;
    document.head.appendChild(style);
    if(chart) chart.reflow();
    window.print();
    setTimeout(() => document.head.removeChild(style), 1000);
});

/* ===================== 메모 모달 ===================== */
$(".close, #closeModal").click(function(){
    $("#corrForm")[0].reset();
    $("#modalContainer").removeClass("show").hide();
});

// ✅ 메모 추가 버튼
$("#btnInsert").on("click", function(){
    $("input[name='user_code']").val("${loginUser.user_code}");
    $("input[name='writer']").val("${loginUser.user_name}");
    $("input[name='date']").val(nowStr());
    $("#modalContainer").show().addClass("show");
});

// ✅ 메모 저장
$("#saveCorrStatus").click(function(e){
    e.preventDefault();
    const formData = new FormData($("#corrForm")[0]);
    $.ajax({
        url: "/mibogear/monitoring/trendMemoInsert",
        type: "POST",
        data: formData,
        processData: false,
        contentType: false,
        success: function(result){
            if(result === true){
                alert("저장되었습니다!");
                $("#modalContainer").removeClass("show").hide();
                $("#corrForm")[0].reset();
                fetchData();
            } else {
                alert("저장에 실패했습니다.");
            }
        },
        error: function(){ alert("저장 중 오류가 발생했습니다."); }
    });
});

/* ===================== 호기 버튼 ===================== */
$(".hogi-btn").on("click", function(){
    $(".hogi-btn").removeClass("active");
    $(this).addClass("active");
    hogi = $(this).data("hogi");
    fetchData();
});

/* ===================== 포인트 표시 ===================== */
$("#toggleMarker").on("change", function(){
    markerEnabled = this.checked;
    if(chart){
        chart.update({ plotOptions:{ series:{ marker:{ enabled:markerEnabled } } } });
    }
});

/* ===================== 초기화 ===================== */
$(document).ready(function(){
    Highcharts.setOptions({ time:{ useUTC: false } });

    $(".datetimeSet").datepicker({
        language: "ko",
        timepicker: true,
        dateFormat: "yyyy-mm-dd",
        timeFormat: "hh:ii",
        autoClose: true
    });

    $("#startDate").val(before8Hours());
    $("#endDate").val(nowStr());

    fetchData();

    $("#btnSearch").on("click", fetchData);
});
</script>

</body>
</html>