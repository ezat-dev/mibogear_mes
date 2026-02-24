<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>통합모니터링</title>
    <link rel="stylesheet" href="/mibogear/css/login/style.css">
     <link rel="stylesheet" href="/mibogear/css/tabBar/tabBar.css">
     <link rel="stylesheet" href="/mibogear/css/overview/style.css">
    <script type="text/javascript" src="https://oss.sheetjs.com/sheetjs/xlsx.full.min.js"></script>
<%@include file="../include/pluginpage.jsp" %>     
    
    <style>
    .main {
    position: relative;
}
	.bcf-container {
	    position: absolute;
	    left: 7px;
	    top: 500px;
	    width: 1654.78px;
	}
	
	.bcf-row {
	    display: flex;
	    gap: 10px;
	    margin-bottom: 10px;
	}
	
	/* 1호기, 3호기 (전체 테이블) */
	.bcf-table-full {
	    background: #fff;
	    border: 1px solid #ddd;
	    overflow: hidden;
	    flex: 1;
	}
	
	/* 2호기, 4호기 (절반 테이블) */
	.bcf-table-half {
	    background: #fff;
	    border: 1px solid #ddd;
	    overflow: hidden;
	    flex: 0.6;
	}
	
	.bcf-header {
	    background: #4a90e2;
	    color: white;
	    padding: 6px;
	    font-weight: bold;
	    font-size: 14px;
	    text-align: center;
	}
	
	.bcf-container table {
	    width: 100%;
	    border-collapse: collapse;
	}
	
	.bcf-container th {
	    padding: 6px 4px;
	    text-align: center;
	    font-size: 11px;
	    font-weight: bold;
	    border: 1px solid #ddd;
	    background: #fff;
	    color: #333;
	}
	
	.bcf-container td {
	    padding: 6px 4px;
	    text-align: center;
	    font-size: 11px;
	    font-weight: normal;
	    border: 1px solid #ddd;
	    background: #fff;
	    color: #333;
	}
	
	/* 라벨 셀 */
	.bcf-container .label-cell {
	    background: #f5f5f5;
	    font-weight: bold;
	}
	
.cart_1, .cart_2, .cart_3, .cart_4, .cart_5, .cart_6, .cart_7, .cart_8, .cart_9, .cart_10,
.cart_11, .cart_12, .cart_13, .cart_14, .cart_15, .cart_16, .cart_17, .cart_18, .cart_19, .cart_20,
.cart_21, .cart_22, .cart_23, .cart_24, .cart_25, .cart_26,
.tong_1, .tong_2, .tong_3, .tong_4, .tong_5, .tong_6, .tong_7, .tong_8, .tong_9, .tong_10,
.tong_11, .tong_12, .tong_13, .tong_14, .tong_15, .tong_16, .tong_17, .tong_18, .tong_19, .tong_20,
.tong_21, .tong_22, .tong_23, .tong_24, .tong_25, .tong_26, .tong_27, .tong_28, .tong_29, .tong_30,
.tong_31, .tong_32, .tong_33, .tong_34, .tong_35, .tong_36, .tong_37, .tong_38, .tong_39, .tong_40,
.tong_41, .tong_42, .tong_43, .tong_44, .tong_45, .tong_46, .tong_47, .tong_48, .tong_49, .tong_50,
.tong_51, .tong_52, .tong_53, .tong_54, .tong_55, .tong_56, .tong_57, .tong_58, .tong_59, .tong_60,
.tong_61, .tong_62, .tong_63, .tong_64, .tong_65, .tong_66, .tong_67, .tong_68, .tong_69, .tong_70,
.door_1, .door_2, .door_3, .door_4,
.body_pen_1, .body_pen_2, .body_pen_3, .body_pen_4,
.onpen_1, .onpen_2, .onpen_3, .onpen_4,
.greenpen_1, .greenpen_2, .greenpen_3, .greenpen_4, .greenpen_5, .greenpen_6,
.longon_1, .longon_2, .longon_3, .longon_4, .longon_5, .longon_6, .longon_7, .longon_8,
.bluepen_1, .bluepen_2, .bluepen_3, .bluepen_4, .bluepen_5, .bluepen_6, .bluepen_7, .bluepen_8,
.up_1, .up_2, .up_3, .up_4,
.down_1, .down_2, .down_3, .down_4,
.doorOpen_1, .doorOpen_2, .doorOpen_3, .doorOpen_4, .doorOpen_5, .doorOpen_6,
.doorOpen_7, .doorOpen_8, .doorOpen_9, .doorOpen_10, .doorOpen_11, .doorOpen_12,
.doorClose_1, .doorClose_2, .doorClose_3, .doorClose_4, .doorClose_5, .doorClose_6,
.doorClose_7, .doorClose_8, .doorClose_9, .doorClose_10, .doorClose_11, .doorClose_12,
.redBox_1, .redBox_2, .redBox_3, .redBox_4, .redBox_5, .redBox_6, .redBox_7, .redBox_8,
.redBox_9, .redBox_10, .redBox_11, .redBox_12, .redBox_13, .redBox_14, .redBox_15, .redBox_16 {
    display: none;
}

@keyframes rotate {
    from { transform: rotate(0deg); }
    to { transform: rotate(360deg); }
}

.rotating {
    animation: rotate 2s linear infinite;
}

/* 기존 style 태그 안에 추가 */

/* 존 구간 비트 점멸 애니메이션 */
@keyframes blink-red {
    0%, 100% { background-color: #ff0000; }
    50% { background-color: #ffffff; }
}

.bit-active {
    animation: blink-red 1s infinite;
    color: white;
    font-weight: bold;
}

/* 패턴번호, 통번호 div 스타일 */
.pattern-display, .tong-display {
    position: absolute;
    background: rgba(255, 255, 255, 0.9);
    border: 2px solid #4a90e2;
    border-radius: 5px;
    padding: 5px 10px;
    font-size: 14px;
    font-weight: bold;
    color: #333;
    box-shadow: 0 2px 5px rgba(0,0,0,0.2);
}

/* 각 위치 지정 (예시 - 실제 위치는 조정 필요) */
.bcf1_pattern_number { left: 100px; top: 50px; }
.bcf2_pattern_number { left: 300px; top: 50px; }
.bcf3_pattern_number { left: 500px; top: 50px; }
.bcf4_pattern_number { left: 700px; top: 50px; }

.cm2_tong_number { left: 100px; top: 100px; }
.bcf4_tong_number { left: 250px; top: 100px; }
.bcf3_tong_number { left: 400px; top: 100px; }
.bcf2_tong_number { left: 550px; top: 100px; }
.bcf1_tong_number { left: 700px; top: 100px; }
.cm_tong_number { left: 850px; top: 100px; }
    </style>
    
    
    <body>
    
   
    
    
    <main class="main">
		<div class="group-6">
    <div class="group-5">
      <img class="rail" src="/mibogear/image/overview/rail0.png" />
      <img class="rail2" src="/mibogear/image/overview/rail1.png" />
      <img class="rail3" src="/mibogear/image/overview/rail2.png" />
      <img class="rail4" src="/mibogear/image/overview/rail3.png" />
      <img class="rail5" src="/mibogear/image/overview/rail4.png" />
      <img class="rail6" src="/mibogear/image/overview/rail5.png" />
      <img class="rail7" src="/mibogear/image/overview/rail6.png" />
      <img class="rail8" src="/mibogear/image/overview/rail7.png" />
      <img class="rail9" src="/mibogear/image/overview/rail8.png" />
      <img class="rail10" src="/mibogear/image/overview/rail9.png" />
      <img class="rail11" src="/mibogear/image/overview/rail10.png" />
      <img class="rail12" src="/mibogear/image/overview/rail11.png" />
      <img class="rail13" src="/mibogear/image/overview/rail12.png" />
      <img class="rail14" src="/mibogear/image/overview/rail13.png" />
      <img class="rail15" src="/mibogear/image/overview/rail14.png" />
      <img class="rail16" src="/mibogear/image/overview/rail15.png" />
      <img class="rail17" src="/mibogear/image/overview/rail16.png" />
      <img class="rail18" src="/mibogear/image/overview/rail17.png" />
      <img class="rail19" src="/mibogear/image/overview/rail18.png" />
      <img class="rail20" src="/mibogear/image/overview/rail19.png" />
      <img class="rail21" src="/mibogear/image/overview/rail20.png" />
      <img class="rail22" src="/mibogear/image/overview/rail21.png" />
      <img class="rail23" src="/mibogear/image/overview/rail22.png" />
      <img class="rail24" src="/mibogear/image/overview/rail23.png" />
      <img class="rail25" src="/mibogear/image/overview/rail24.png" />
      <img class="rail26" src="/mibogear/image/overview/rail25.png" />
      <img class="obj_1" src="/mibogear/image/overview/obj-10.png" />
      <img class="obj_2" src="/mibogear/image/overview/obj-20.png" />
      <img class="obj_3" src="/mibogear/image/overview/obj-30.png" />
      <img class="obj_4" src="/mibogear/image/overview/obj-40.png" />
      <img class="obj_5" src="/mibogear/image/overview/obj-50.png" />
      <img class="obj_6" src="/mibogear/image/overview/obj-60.png" />
      <img class="obj_7" src="/mibogear/image/overview/obj-70.png" />
      <img class="obj_8" src="/mibogear/image/overview/obj-80.png" />
      <img class="obj_9" src="/mibogear/image/overview/obj-90.png" />
      <img class="obj_10" src="/mibogear/image/overview/obj-100.png" />
      <img class="obj_11" src="/mibogear/image/overview/obj-110.png" />
      <img class="obj_12" src="/mibogear/image/overview/obj-120.png" />
      <img class="obj_13" src="/mibogear/image/overview/obj-130.png" />
      <img class="obj_14" src="/mibogear/image/overview/obj-140.png" />
      <img class="obj_15" src="/mibogear/image/overview/obj-150.png" />
      <img class="obj_16" src="/mibogear/image/overview/obj-160.png" />
      <img class="obj_17" src="/mibogear/image/overview/obj-170.png" />
      <img class="obj_18" src="/mibogear/image/overview/obj-180.png" />
      <img class="obj_19" src="/mibogear/image/overview/obj-190.png" />
      <img class="obj_20" src="/mibogear/image/overview/obj-200.png" />
      <img class="obj_21" src="/mibogear/image/overview/obj-210.png" />
      <img class="obj_22" src="/mibogear/image/overview/obj-220.png" />
      <img class="obj_23" src="/mibogear/image/overview/obj-230.png" />
      <img class="obj_24" src="/mibogear/image/overview/obj-240.png" />
      <img class="obj_25" src="/mibogear/image/overview/obj-250.png" />
      <img class="obj_26" src="/mibogear/image/overview/obj-260.png" />
      <img class="obj_27" src="/mibogear/image/overview/obj-270.png" />
      <img class="obj_28" src="/mibogear/image/overview/obj-280.png" />
      <img class="obj_282" src="/mibogear/image/overview/obj-281.png" />
      <img class="cart_1" src="/mibogear/image/overview/cart-10.png" />
      <img class="cart_2" src="/mibogear/image/overview/cart-20.png" />
      <img class="cart_3" src="/mibogear/image/overview/cart-30.png" />
      <img class="cart_4" src="/mibogear/image/overview/cart-40.png" />
      <img class="cart_5" src="/mibogear/image/overview/cart-50.png" />
      <img class="cart_6" src="/mibogear/image/overview/cart-60.png" />
      <img class="cart_7" src="/mibogear/image/overview/cart-70.png" />
      <img class="cart_8" src="/mibogear/image/overview/cart-80.png" />
      <img class="cart_9" src="/mibogear/image/overview/cart-90.png" />
      <img class="cart_10" src="/mibogear/image/overview/cart-100.png" />
      <img class="cart_11" src="/mibogear/image/overview/cart-110.png" />
      <img class="cart_12" src="/mibogear/image/overview/cart-120.png" />
      <img class="cart_13" src="/mibogear/image/overview/cart-130.png" />
      <img class="cart_14" src="/mibogear/image/overview/cart-140.png" />
      <img class="cart_15" src="/mibogear/image/overview/cart-150.png" />
      <img class="cart_16" src="/mibogear/image/overview/cart-160.png" />
      <img class="cart_17" src="/mibogear/image/overview/cart-170.png" />
      <img class="cart_18" src="/mibogear/image/overview/cart-180.png" />
      <img class="cart_19" src="/mibogear/image/overview/cart-190.png" />
      <img class="cart_20" src="/mibogear/image/overview/cart-200.png" />
      <img class="cart_21" src="/mibogear/image/overview/cart-210.png" />
      <img class="cart_22" src="/mibogear/image/overview/cart-220.png" />
      <img class="cart_23" src="/mibogear/image/overview/cart-230.png" />
      <img class="cart_24" src="/mibogear/image/overview/cart-240.png" />
      <img class="cart_25" src="/mibogear/image/overview/cart-250.png" />
      <img class="cart_26" src="/mibogear/image/overview/cart-260.png" />
      <img class="tong_1" src="/mibogear/image/overview/tong-10.png" />
      <img class="tong_2" src="/mibogear/image/overview/tong-20.png" />
      <img class="tong_3" src="/mibogear/image/overview/tong-30.png" />
      <img class="tong_4" src="/mibogear/image/overview/tong-40.png" />
      <img class="tong_5" src="/mibogear/image/overview/tong-50.png" />
      <img class="tong_6" src="/mibogear/image/overview/tong-60.png" />
      <img class="tong_7" src="/mibogear/image/overview/tong-70.png" />
      <img class="tong_8" src="/mibogear/image/overview/tong-80.png" />
      <img class="tong_9" src="/mibogear/image/overview/tong-90.png" />
      <img class="tong_10" src="/mibogear/image/overview/tong-100.png" />
      <img class="tong_11" src="/mibogear/image/overview/tong-110.png" />
      <img class="tong_12" src="/mibogear/image/overview/tong-120.png" />
      <img class="tong_13" src="/mibogear/image/overview/tong-130.png" />
      <img class="tong_14" src="/mibogear/image/overview/tong-140.png" />
      <img class="tong_15" src="/mibogear/image/overview/tong-150.png" />
      <img class="tong_16" src="/mibogear/image/overview/tong-160.png" />
      <img class="tong_17" src="/mibogear/image/overview/tong-170.png" />
      <img class="tong_18" src="/mibogear/image/overview/tong-180.png" />
      <img class="tong_19" src="/mibogear/image/overview/tong-190.png" />
      <img class="tong_20" src="/mibogear/image/overview/tong-200.png" />
      <img class="tong_21" src="/mibogear/image/overview/tong-210.png" />
      <img class="tong_22" src="/mibogear/image/overview/tong-220.png" />
      <img class="tong_23" src="/mibogear/image/overview/tong-230.png" />
      <img class="tong_24" src="/mibogear/image/overview/tong-240.png" />
      <img class="tong_25" src="/mibogear/image/overview/tong-250.png" />
      <img class="tong_26" src="/mibogear/image/overview/tong-260.png" />
      <img class="tong_27" src="/mibogear/image/overview/tong-270.png" />
      <img class="tong_28" src="/mibogear/image/overview/tong-280.png" />
      <img class="tong_29" src="/mibogear/image/overview/tong-290.png" />
      <img class="tong_30" src="/mibogear/image/overview/tong-300.png" />
      <img class="tong_31" src="/mibogear/image/overview/tong-310.png" />
      <img class="tong_32" src="/mibogear/image/overview/tong-320.png" />
      <img class="tong_33" src="/mibogear/image/overview/tong-330.png" />
      <img class="tong_34" src="/mibogear/image/overview/tong-340.png" />
      <img class="tong_35" src="/mibogear/image/overview/tong-350.png" />
      <img class="tong_36" src="/mibogear/image/overview/tong-360.png" />
      <img class="tong_37" src="/mibogear/image/overview/tong-370.png" />
      <img class="tong_38" src="/mibogear/image/overview/tong-380.png" />
      <img class="tong_39" src="/mibogear/image/overview/tong-390.png" />
      <img class="tong_40" src="/mibogear/image/overview/tong-400.png" />
      <img class="tong_41" src="/mibogear/image/overview/tong-410.png" />
      <img class="tong_42" src="/mibogear/image/overview/tong-420.png" />
      <img class="tong_43" src="/mibogear/image/overview/tong-430.png" />
      <img class="tong_44" src="/mibogear/image/overview/tong-440.png" />
      <img class="tong_45" src="/mibogear/image/overview/tong-450.png" />
      <img class="tong_46" src="/mibogear/image/overview/tong-460.png" />
      <img class="tong_47" src="/mibogear/image/overview/tong-470.png" />
      <img class="tong_48" src="/mibogear/image/overview/tong-480.png" />
      <img class="tong_49" src="/mibogear/image/overview/tong-490.png" />
      <img class="tong_50" src="/mibogear/image/overview/tong-500.png" />
      <img class="tong_51" src="/mibogear/image/overview/tong-510.png" />
      <img class="tong_52" src="/mibogear/image/overview/tong-520.png" />
      <img class="tong_53" src="/mibogear/image/overview/tong-530.png" />
      <img class="tong_54" src="/mibogear/image/overview/tong-540.png" />
      <img class="tong_55" src="/mibogear/image/overview/tong-550.png" />
      <img class="tong_56" src="/mibogear/image/overview/tong-560.png" />
      <img class="tong_57" src="/mibogear/image/overview/tong-570.png" />
      <img class="tong_58" src="/mibogear/image/overview/tong-580.png" />
      <img class="tong_59" src="/mibogear/image/overview/tong-590.png" />
      <img class="tong_60" src="/mibogear/image/overview/tong-600.png" />
      <img class="tong_61" src="/mibogear/image/overview/tong-610.png" />
      <img class="tong_62" src="/mibogear/image/overview/tong-620.png" />
      <img class="tong_63" src="/mibogear/image/overview/tong-630.png" />
      <img class="tong_64" src="/mibogear/image/overview/tong-640.png" />
      <img class="tong_65" src="/mibogear/image/overview/tong-650.png" />
      <img class="tong_66" src="/mibogear/image/overview/tong-660.png" />
      <img class="tong_67" src="/mibogear/image/overview/tong-670.png" />
      <img class="tong_68" src="/mibogear/image/overview/tong-680.png" />
      <img class="tong_69" src="/mibogear/image/overview/tong-690.png" />
      <img class="tong_70" src="/mibogear/image/overview/tong-700.png" />
      <img class="door_1" src="/mibogear/image/overview/door-10.png" />
      <img class="door_2" src="/mibogear/image/overview/door-20.png" />
      <img class="door_3" src="/mibogear/image/overview/door-30.png" />
      <img class="door_4" src="/mibogear/image/overview/door-40.png" />
      <img class="nobody_pen_1" src="/mibogear/image/overview/nobody-pen-10.png" />
      <img class="body_pen_1" src="/mibogear/image/overview/body-pen-10.png" />
      <img class="offpen_1" src="/mibogear/image/overview/offpen-10.png" />
      <img class="onpen_1" src="/mibogear/image/overview/onpen-10.png" />
      <img class="nobody_pen_2" src="/mibogear/image/overview/nobody-pen-20.png" />
      <img class="body_pen_2" src="/mibogear/image/overview/body-pen-20.png" />
      <img class="offpen_2" src="/mibogear/image/overview/offpen-20.png" />
      <img class="onpen_2" src="/mibogear/image/overview/onpen-20.png" />
      <img class="nobody_pen_3" src="/mibogear/image/overview/nobody-pen-30.png" />
      <img class="body_pen_3" src="/mibogear/image/overview/body-pen-30.png" />
      <img class="offpen_3" src="/mibogear/image/overview/offpen-30.png" />
      <img class="onpen_3" src="/mibogear/image/overview/onpen-30.png" />
      <img class="nobody_pen_4" src="/mibogear/image/overview/nobody-pen-40.png" />
      <img class="body_pen_4" src="/mibogear/image/overview/body-pen-40.png" />
      <img class="offpen_4" src="/mibogear/image/overview/offpen-40.png" />
      <img class="onpen_4" src="/mibogear/image/overview/onpen-40.png" />
      <img class="nomalpen_1" src="/mibogear/image/overview/nomalpen-10.png" />
      <img class="greenpen_1" src="/mibogear/image/overview/greenpen-10.png" />
      <img class="nomalpen_2" src="/mibogear/image/overview/nomalpen-20.png" />
      <img class="greenpen_2" src="/mibogear/image/overview/greenpen-20.png" />
      <img class="nomalpen_3" src="/mibogear/image/overview/nomalpen-30.png" />
      <img class="greenpen_3" src="/mibogear/image/overview/greenpen-30.png" />
      <img class="nomalpen_4" src="/mibogear/image/overview/nomalpen-40.png" />
      <img class="greenpen_4" src="/mibogear/image/overview/greenpen-40.png" />
      <img class="nomalpen_5" src="/mibogear/image/overview/nomalpen-50.png" />
      <img class="greenpen_5" src="/mibogear/image/overview/greenpen-50.png" />
      <img class="nomalpen_6" src="/mibogear/image/overview/nomalpen-60.png" />
      <img class="greenpen_6" src="/mibogear/image/overview/greenpen-60.png" />
      <img class="longoff_1" src="/mibogear/image/overview/longoff-10.png" />
      <img class="longon_1" src="/mibogear/image/overview/longon-10.png" />
      <img class="longoff_2" src="/mibogear/image/overview/longoff-20.png" />
      <img class="longon_2" src="/mibogear/image/overview/longon-20.png" />
      <img class="longoff_3" src="/mibogear/image/overview/longoff-30.png" />
      <img class="longon_3" src="/mibogear/image/overview/longon-30.png" />
      <img class="longoff_4" src="/mibogear/image/overview/longoff-40.png" />
      <img class="longon_4" src="/mibogear/image/overview/longon-40.png" />
      <img class="longoff_5" src="/mibogear/image/overview/longoff-50.png" />
      <img class="longon_5" src="/mibogear/image/overview/longon-50.png" />
      <img class="longoff_6" src="/mibogear/image/overview/longoff-60.png" />
      <img class="longon_6" src="/mibogear/image/overview/longon-60.png" />
      <img class="longoff_7" src="/mibogear/image/overview/longoff-70.png" />
      <img class="longon_7" src="/mibogear/image/overview/longon-70.png" />
      <img class="longoff_8" src="/mibogear/image/overview/longoff-80.png" />
      <img class="longon_8" src="/mibogear/image/overview/longon-80.png" />
      <img class="graypen_1" src="/mibogear/image/overview/graypen-10.png" />
      <img class="bluepen_1" src="/mibogear/image/overview/bluepen-10.png" />
      <img class="graypen_2" src="/mibogear/image/overview/graypen-20.png" />
      <img class="bluepen_2" src="/mibogear/image/overview/bluepen-20.png" />
      <img class="graypen_3" src="/mibogear/image/overview/graypen-30.png" />
      <img class="bluepen_3" src="/mibogear/image/overview/bluepen-30.png" />
      <img class="graypen_4" src="/mibogear/image/overview/graypen-40.png" />
      <img class="bluepen_4" src="/mibogear/image/overview/bluepen-40.png" />
      <img class="graypen_5" src="/mibogear/image/overview/graypen-50.png" />
      <img class="bluepen_5" src="/mibogear/image/overview/bluepen-50.png" />
      <img class="graypen_6" src="/mibogear/image/overview/graypen-60.png" />
      <img class="bluepen_6" src="/mibogear/image/overview/bluepen-60.png" />
      <img class="graypen_7" src="/mibogear/image/overview/graypen-70.png" />
      <img class="bluepen_7" src="/mibogear/image/overview/bluepen-70.png" />
      <img class="graypen_8" src="/mibogear/image/overview/graypen-80.png" />
      <img class="bluepen_8" src="/mibogear/image/overview/bluepen-80.png" />
      <img class="bignomal_1" src="/mibogear/image/overview/bignomal-10.png" />
      <img class="down_1" src="/mibogear/image/overview/down-10.png" />
      <img class="up_1" src="/mibogear/image/overview/up-10.png" />
      <img class="bignomal_2" src="/mibogear/image/overview/bignomal-20.png" />
      <img class="down_2" src="/mibogear/image/overview/down-20.png" />
      <img class="up_2" src="/mibogear/image/overview/up-20.png" />
      <img class="bignomal_3" src="/mibogear/image/overview/bignomal-30.png" />
      <img class="down_3" src="/mibogear/image/overview/down-30.png" />
      <img class="up_3" src="/mibogear/image/overview/up-30.png" />
      <img class="bignomal_4" src="/mibogear/image/overview/bignomal-40.png" />
      <img class="down_4" src="/mibogear/image/overview/down-40.png" />
      <img class="up_4" src="/mibogear/image/overview/up-40.png" />
      <img class="grayBox_1" src="/mibogear/image/overview/gray-box-10.png" />
      <img class="redBox_1" src="/mibogear/image/overview/red-box-10.png" />
      <img class="grayBox_2" src="/mibogear/image/overview/gray-box-20.png" />
      <img class="redBox_2" src="/mibogear/image/overview/red-box-20.png" />
      <img class="grayBox_3" src="/mibogear/image/overview/gray-box-30.png" />
      <img class="redBox_3" src="/mibogear/image/overview/red-box-30.png" />
      <img class="grayBox_4" src="/mibogear/image/overview/gray-box-40.png" />
      <img class="redBox_4" src="/mibogear/image/overview/red-box-40.png" />
      <img class="grayBox_5" src="/mibogear/image/overview/gray-box-50.png" />
      <img class="redBox_5" src="/mibogear/image/overview/red-box-50.png" />
      <img class="grayBox_6" src="/mibogear/image/overview/gray-box-60.png" />
      <img class="redBox_6" src="/mibogear/image/overview/red-box-60.png" />
      <img class="grayBox_7" src="/mibogear/image/overview/gray-box-70.png" />
      <img class="redBox_7" src="/mibogear/image/overview/red-box-70.png" />
      <img class="grayBox_8" src="/mibogear/image/overview/gray-box-80.png" />
      <img class="redBox_8" src="/mibogear/image/overview/red-box-80.png" />
      <img class="grayBox_9" src="/mibogear/image/overview/gray-box-90.png" />
      <img class="redBox_9" src="/mibogear/image/overview/red-box-90.png" />
      <img class="grayBox_10" src="/mibogear/image/overview/gray-box-100.png" />
      <img class="redBox_10" src="/mibogear/image/overview/red-box-100.png" />
      <img class="grayBox_11" src="/mibogear/image/overview/gray-box-110.png" />
      <img class="redBox_11" src="/mibogear/image/overview/red-box-110.png" />
      <img class="grayBox_12" src="/mibogear/image/overview/gray-box-120.png" />
      <img class="redBox_12" src="/mibogear/image/overview/red-box-120.png" />
      <img class="grayBox_13" src="/mibogear/image/overview/gray-box-130.png" />
      <img class="redBox_13" src="/mibogear/image/overview/red-box-130.png" />
      <img class="grayBox_14" src="/mibogear/image/overview/gray-box-140.png" />
      <img class="redBox_14" src="/mibogear/image/overview/red-box-140.png" />
      <img class="grayBox_15" src="/mibogear/image/overview/gray-box-150.png" />
      <img class="redBox_15" src="/mibogear/image/overview/red-box-150.png" />
      <img class="grayBox_16" src="/mibogear/image/overview/gray-box-160.png" />
      <img class="redBox_16" src="/mibogear/image/overview/red-box-160.png" />
      <img class="red_1" src="/mibogear/image/overview/red-10.png" />
      <img class="green_1" src="/mibogear/image/overview/green-10.png" />
      <img class="red_2" src="/mibogear/image/overview/red-20.png" />
      <img class="green_2" src="/mibogear/image/overview/green-20.png" />
      <img class="red_3" src="/mibogear/image/overview/red-30.png" />
      <img class="green_3" src="/mibogear/image/overview/green-30.png" />
      <img class="red_4" src="/mibogear/image/overview/red-40.png" />
      <img class="green_4" src="/mibogear/image/overview/green-40.png" />
      <img class="red_5" src="/mibogear/image/overview/red-50.png" />
      <img class="green_5" src="/mibogear/image/overview/green-50.png" />
      <img class="red_6" src="/mibogear/image/overview/red-60.png" />
      <img class="green_6" src="/mibogear/image/overview/green-60.png" />
      <img class="red_7" src="/mibogear/image/overview/red-70.png" />
      <img class="green_7" src="/mibogear/image/overview/green-70.png" />
      <img class="red_8" src="/mibogear/image/overview/red-80.png" />
      <img class="green_8" src="/mibogear/image/overview/green-80.png" />
      <img class="red_9" src="/mibogear/image/overview/red-90.png" />
      <img class="green_9" src="/mibogear/image/overview/green-90.png" />
      <img class="red_10" src="/mibogear/image/overview/red-100.png" />
      <img class="green_10" src="/mibogear/image/overview/green-100.png" />
      <img class="doorNomal_1" src="/mibogear/image/overview/door-nomal-10.png" />
      <img class="doorClose_1" src="/mibogear/image/overview/door-close-10.png" />
      <img class="doorOpen_1" src="/mibogear/image/overview/door-open-10.png" />
      <img class="doorNomal_2" src="/mibogear/image/overview/door-nomal-20.png" />
      <img class="doorClose_2" src="/mibogear/image/overview/door-close-20.png" />
      <img class="doorOpen_2" src="/mibogear/image/overview/door-open-20.png" />
      <img class="doorNomal_3" src="/mibogear/image/overview/door-nomal-30.png" />
      <img class="doorClose_3" src="/mibogear/image/overview/door-close-30.png" />
      <img class="doorOpen_3" src="/mibogear/image/overview/door-open-30.png" />
      <img class="doorNomal_4" src="/mibogear/image/overview/door-nomal-40.png" />
      <img class="doorClose_4" src="/mibogear/image/overview/door-close-40.png" />
      <img class="doorOpen_4" src="/mibogear/image/overview/door-open-40.png" />
      <img class="doorNomal_5" src="/mibogear/image/overview/door-nomal-50.png" />
      <img class="doorClose_5" src="/mibogear/image/overview/door-close-50.png" />
      <img class="doorOpen_5" src="/mibogear/image/overview/door-open-50.png" />
      <img class="doorNomal_6" src="/mibogear/image/overview/door-noaml-60.png" />
      <img class="doorClose_6" src="/mibogear/image/overview/door-close-60.png" />
      <img class="doorOpen_6" src="/mibogear/image/overview/door-open-60.png" />
      <img class="doorNomal_7" src="/mibogear/image/overview/door-nomal-70.png" />
      <img class="doorClose_7" src="/mibogear/image/overview/door-close-70.png" />
      <img class="doorOpen_7" src="/mibogear/image/overview/door-open-70.png" />
      <img class="doorNomal_8" src="/mibogear/image/overview/door-nomal-80.png" />
      <img class="doorClose_8" src="/mibogear/image/overview/door-close-80.png" />
      <img class="doorOpen_8" src="/mibogear/image/overview/door-open-80.png" />
      <img class="doorNomal_9" src="/mibogear/image/overview/door-nomal-90.png" />
      <img class="doorClose_9" src="/mibogear/image/overview/door-colse-90.png" />
      <img class="doorOpen_9" src="/mibogear/image/overview/door-open-90.png" />
      <img class="doorNomal_11" src="/mibogear/image/overview/door-nomal-110.png" />
      <img class="doorClose_11" src="/mibogear/image/overview/door-close-110.png" />
      <img class="doorOpen_11" src="/mibogear/image/overview/door-open-110.png" />
      <img class="doorNomal_10" src="/mibogear/image/overview/door-nomal-100.png" />
      <img class="doorClose_10" src="/mibogear/image/overview/door-close-100.png" />
      <img class="doorOpen_10" src="/mibogear/image/overview/door-open-100.png" />
      <img class="doorNomal_12" src="/mibogear/image/overview/door-nomal-120.png" />
      <img class="doorClose_12" src="/mibogear/image/overview/door-close-120.png" />
      <img class="doorOpen_12" src="/mibogear/image/overview/door-open-120.png" />
<!-- <div class="bcf4_pattern_number"></div>
<div class="cm2_tong_number"></div>
<div class="bcf4_tong_number"></div>
<div class="bcf3_tong_number"></div>
<div class="bcf1_tong_number"></div>
<div class="bcf2_tong_number"></div>
<div class="cm_tong_number"></div>
<div class="bcf3_pattern_number"></div>
<div class="bcf1_pattern_number"></div>
<div class="bcf2_pattern_number"></div> -->
    </div>
  </div>
  
  
		  <div class="bcf-container">
		        <!-- 1행: 1호기 + 2호기 -->
		        <div class="bcf-row">
		            <!-- 1호기 (전체) -->
		            <div class="bcf-table-full">
		                <div class="bcf-header">1호기</div>
		                <table>
		                    <thead>
		                        <tr>
		                            <th>온도(℃)</th>
		                            <th>침탄</th>
		                            <th>유조</th>
		                            <th>CP</th>
		                            <th>소려</th>
		                            <th>시간(분)</th>
		                            <th class="bcf1_seong_bit">승온</th>
		                            <th class="bcf1_chim_bit">침탄</th>
		                            <th class="bcf1_diff_bit">확산</th>
		                            <th class="bcf1_gang_bit">강온</th>
		                            <th class="bcf1_que_bit">소입</th>
		                            <th class="bcf1_drain_bit">드레인</th>
		                            <th>시간(분)</th>
		                            <th class="cm_gun_bit">건조</th>
		                            <th class="cm_tem_bit">소려</th>
		                            <th class="cm_cool_bit">냉각</th>
		                        </tr>
		                    </thead>
		                    <tbody>
		                        <tr>
		                            <td class="label-cell">설정값</td>
		                            <td class="bcf1_chim_setting"></td>
		                            <td class="bcf1_oil_setting"></td>
		                            <td class="bcf1_cp_setting"></td>
		                            <td class="bcf1_tempering_setting"></td>
		                            <td class="label-cell">설정값</td>
		                            <td class="bcf1_seong_sv"></td>
		                            <td class="bcf1_chim_sv"></td>
		                            <td class="bcf1_diff_sv"></td>
		                            <td class="bcf1_gang_sv"></td>
		                            <td class="bcf1_que_sv"></td>
		                            <td class="bcf1_drain_sv"></td>
		                            <td class="label-cell">설정값</td>
		                            <td class="bcf1_cool1_sv"></td>
		                            <td class="bcf1_tem_sv"></td>
		                            <td class="bcf1_cool2_sv"></td>
		                        </tr>
		                        <tr>
		                            <td class="label-cell">현재값</td>
		                            <td class="bcf1_chim"></td>
		                            <td class="bcf1_oil"></td>
		                            <td class="bcf1_cp"></td>
		                            <td class="bcf1_tempering"></td>
		                            <td class="label-cell">현재값</td>
		                            <td class="bcf1_seong_pv"></td>
		                            <td class="bcf1_chim_pv"></td>
		                            <td class="bcf1_diff_pv"></td>
		                            <td class="bcf1_gang_pv"></td>
		                            <td class="bcf1_que_pv"></td>
		                            <td class="bcf1_drain_pv"></td>
		                            <td class="label-cell">현재값</td>
		                            <td class="bcf1_cool1_pv"></td>
		                            <td class="bcf1_tem_pv"></td>
		                            <td class="bcf1_cool2_pv"></td>
		                        </tr>
		                    </tbody>
		                </table>
		            </div>
		            
		            <!-- 2호기 (절반) -->
		            <div class="bcf-table-half">
		                <div class="bcf-header">2호기</div>
		                <table>
		                    <thead>
		                        <tr>
		                            <th>온도(℃)</th>
		                            <th>침탄</th>
		                            <th>유조</th>
		                            <th>CP</th>
		                            <th>시간(분)</th>
		                            <th class="bcf2_seong_bit">승온</th>
		                            <th class="bcf2_chim_bit">침탄</th>
		                            <th class="bcf2_diff_bit">확산</th>
		                            <th class="bcf2_gang_bit">강온</th>
		                            <th class="bcf2_que_bit">소입</th>
		                            <th class="bcf2_drain_bit">드레인</th>
		                        </tr>
		                    </thead>
		                    <tbody>
		                        <tr>
		                            <td class="label-cell">설정값</td>
		                            <td class="bcf2_chim_setting"></td>
		                            <td class="bcf2_oil_setting"></td>
		                            <td class="bcf2_cp_setting"></td>
		                            <td class="label-cell">설정값</td>
		                            <td class="bcf2_seong_sv"></td>
		                            <td class="bcf2_chim_sv"></td>
		                            <td class="bcf2_diff_sv"></td>
		                            <td class="bcf2_gang_sv"></td>
		                            <td class="bcf2_que_sv"></td>
		                            <td class="bcf2_drain_sv"></td>
		                        </tr>
		                        <tr>
		                            <td class="label-cell">현재값</td>
		                            <td class="bcf2_chim"></td>
		                            <td class="bcf2_oil"></td>
		                            <td class="bcf2_cp"></td>
		                            <td class="label-cell">현재값</td>
		                            <td class="bcf2_seong_pv"></td>
		                            <td class="bcf2_chim_pv"></td>
		                            <td class="bcf2_diff_pv"></td>
		                            <td class="bcf2_gang_pv"></td>
		                            <td class="bcf2_que_pv"></td>
		                            <td class="bcf2_drain_pv"></td>
		                        </tr>
		                    </tbody>
		                </table>
		            </div>
		        </div>
		        
		        <!-- 2행: 3호기 + 4호기 -->
		        <div class="bcf-row">
		            <!-- 3호기 (전체) -->
		            <div class="bcf-table-full">
		                <div class="bcf-header">3호기</div>
		                <table>
		                    <thead>
		                        <tr>
		                            <th>온도(℃)</th>
		                            <th>침탄</th>
		                            <th>유조</th>
		                            <th>CP</th>
		                            <th>소려</th>
		                            <th>시간(분)</th>
		                            <th class="bcf3_seong_bit">승온</th>
		                            <th class="bcf3_chim_bit">침탄</th>
		                            <th class="bcf3_diff_bit">확산</th>
		                            <th class="bcf3_gang_bit">강온</th>
		                            <th class="bcf3_que_bit">소입</th>
		                            <th class="bcf3_drain_bit">드레인</th>
		                            <th>시간(분)</th>
		                            <th class="cm2_gun_bit">건조</th>
		                            <th class="cm2_tem_bit">소려</th>
		                            <th class="cm2_cool_bit">냉각</th>
		                        </tr>
		                    </thead>
		                    <tbody>
		                        <tr>
		                            <td class="label-cell">설정값</td>
		                            <td class="bcf3_chim_setting"></td>
		                            <td class="bcf3_oil_setting"></td>
		                            <td class="bcf3_cp_setting"></td>
		                            <td class="bcf3_tempering_setting"></td>
		                            <td class="label-cell">설정값</td>
		                            <td class="bcf3_seong_sv"></td>
		                            <td class="bcf3_chim_sv"></td>
		                            <td class="bcf3_diff_sv"></td>
		                            <td class="bcf3_gang_sv"></td>
		                            <td class="bcf3_que_sv"></td>
		                            <td class="bcf3_drain_sv"></td>
		                            <td class="label-cell">설정값</td>
		                            <td class="bcf3_cool1_sv"></td>
		                            <td class="bcf3_tem_sv"></td>
		                            <td class="bcf3_cool2_sv"></td>
		                        </tr>
		                        <tr>
		                            <td class="label-cell">현재값</td>
		                            <td class="bcf3_chim"></td>
		                            <td class="bcf3_oil"></td>
		                            <td class="bcf3_cp"></td>
		                            <td class="bcf3_tempering"></td>
		                            <td class="label-cell">현재값</td>
		                            <td class="bcf3_seong_pv"></td>
		                            <td class="bcf3_chim_pv"></td>
		                            <td class="bcf3_diff_pv"></td>
		                            <td class="bcf3_gang_pv"></td>
		                            <td class="bcf3_que_pv"></td>
		                            <td class="bcf3_drain_pv"></td>
		                            <td class="label-cell">현재값</td>
		                            <td class="bcf3_cool1_pv"></td>
		                            <td class="bcf3_tem_pv"></td>
		                            <td class="bcf3_cool2_pv"></td>
		                        </tr>
		                    </tbody>
		                </table>
		            </div>
		            
		            <!-- 4호기 (절반) -->
		            <div class="bcf-table-half">
		                <div class="bcf-header">4호기</div>
		                <table>
		                    <thead>
		                        <tr>
		                            <th>온도(℃)</th>
		                            <th>침탄</th>
		                            <th>유조</th>
		                            <th>CP</th>
		                            <th>시간(분)</th>
		                            <th class="bcf4_seong_bit">승온</th>
		                            <th class="bcf4_chim_bit">침탄</th>
		                            <th class="bcf4_diff_bit">확산</th>
		                            <th class="bcf4_gang_bit">강온</th>
		                            <th class="bcf4_que_bit">소입</th>
		                            <th class="bcf4_drain_bit">드레인</th>
		                        </tr>
		                    </thead>
		                    <tbody>
		                        <tr>
		                            <td class="label-cell">설정값</td>
		                            <td class="bcf4_chim_setting"></td>
		                            <td class="bcf4_oil_setting"></td>
		                            <td class="bcf4_cp_setting"></td>
		                            <td class="label-cell">설정값</td>
		                            <td class="bcf4_seong_sv"></td>
		                            <td class="bcf4_chim_sv"></td>
		                            <td class="bcf4_diff_sv"></td>
		                            <td class="bcf4_gang_sv"></td>
		                            <td class="bcf4_que_sv"></td>
		                            <td class="bcf4_drain_sv"></td>
		                        </tr>
		                        <tr>
		                            <td class="label-cell">현재값</td>
		                            <td class="bcf4_chim"></td>
		                            <td class="bcf4_oil"></td>
		                            <td class="bcf4_cp"></td>
		                            <td class="label-cell">현재값</td>
		                            <td class="bcf4_seong_pv"></td>
		                            <td class="bcf4_chim_pv"></td>
		                            <td class="bcf4_diff_pv"></td>
		                            <td class="bcf4_gang_pv"></td>
		                            <td class="bcf4_que_pv"></td>
		                            <td class="bcf4_drain_pv"></td>
		                        </tr>
		                    </tbody>
		                </table>
		            </div>
		        </div>
		    </div>
  
	</main>


	    
<script>
$(function(){
    // 페이지 로드 시 즉시 실행
    updateOverview();
    
    // 1초마다 갱신
    setInterval(updateOverview, 30000);
});

function updateOverview() {
    $.ajax({
        url: '/mibogear/monitoring/getOverviewData',
        type: 'POST',
        dataType: 'json',
        success: function(data) {
            // ========== 비트값 처리 (0/1에 따라 display 제어) ==========
            
            // CART (26개)
            for(let i = 1; i <= 26; i++) {
                $('.cart_' + i).css('display', data['cart_' + i] == 1 ? 'block' : 'none');
            }
            
            // TONG (70개)
            for(let i = 1; i <= 70; i++) {
                $('.tong_' + i).css('display', data['tong_' + i] == 1 ? 'block' : 'none');
            }
            
            // DOOR (4개)
            for(let i = 1; i <= 4; i++) {
                $('.door_' + i).css('display', data['door_' + i] == 1 ? 'block' : 'none');
            }
            
            // BODY_PEN (4개)
            for(let i = 1; i <= 4; i++) {
                $('.body_pen_' + i).css('display', data['body_pen_' + i] == 1 ? 'block' : 'none');
            }
            
            // ONPEN (4개)
            for(let i = 1; i <= 4; i++) {
                $('.onpen_' + i).css('display', data['onpen_' + i] == 1 ? 'block' : 'none');
            }
            
            // GREENPEN (6개) - 회전 애니메이션 추가
            for(let i = 1; i <= 6; i++) {
                if(data['greenpen_' + i] == 1) {
                    $('.greenpen_' + i).css('display', 'block').addClass('rotating');
                } else {
                    $('.greenpen_' + i).css('display', 'none').removeClass('rotating');
                }
            }
            
            // LONGON (8개)
            for(let i = 1; i <= 8; i++) {
                $('.longon_' + i).css('display', data['longon_' + i] == 1 ? 'block' : 'none');
            }
            
            // BLUEPEN (8개) - 회전 애니메이션 추가
            for(let i = 1; i <= 8; i++) {
                if(data['bluepen_' + i] == 1) {
                    $('.bluepen_' + i).css('display', 'block').addClass('rotating');
                } else {
                    $('.bluepen_' + i).css('display', 'none').removeClass('rotating');
                }
            }
            
            // UP (4개)
            for(let i = 1; i <= 4; i++) {
                $('.up_' + i).css('display', data['up_' + i] == 1 ? 'block' : 'none');
            }
            
            // DOWN (4개)
            for(let i = 1; i <= 4; i++) {
                $('.down_' + i).css('display', data['down_' + i] == 1 ? 'block' : 'none');
            }
            
            // DOOROPEN (12개)
            for(let i = 1; i <= 12; i++) {
                $('.doorOpen_' + i).css('display', data['doorOpen_' + i] == 1 ? 'block' : 'none');
            }
            
            // DOORCLOSE (12개)
            for(let i = 1; i <= 12; i++) {
                $('.doorClose_' + i).css('display', data['doorClose_' + i] == 1 ? 'block' : 'none');
            }
            
            // REDBOX (16개)
            for(let i = 1; i <= 16; i++) {
                $('.redBox_' + i).css('display', data['redBox_' + i] == 1 ? 'block' : 'none');
            }
            
            
            // ========== 존 구간 비트 처리 (th 배경색 빨간색 점멸) ==========
            
            // BCF1 존 구간 비트
            $('.bcf1_seong_bit').toggleClass('bit-active', data.bcf1_seong_bit == 1);
            $('.bcf1_chim_bit').toggleClass('bit-active', data.bcf1_chim_bit == 1);
            $('.bcf1_diff_bit').toggleClass('bit-active', data.bcf1_diff_bit == 1);
            $('.bcf1_gang_bit').toggleClass('bit-active', data.bcf1_gang_bit == 1);
            $('.bcf1_que_bit').toggleClass('bit-active', data.bcf1_que_bit == 1);
            $('.bcf1_drain_bit').toggleClass('bit-active', data.bcf1_drain_bit == 1);
            
            // BCF2 존 구간 비트
            $('.bcf2_seong_bit').toggleClass('bit-active', data.bcf2_seong_bit == 1);
            $('.bcf2_chim_bit').toggleClass('bit-active', data.bcf2_chim_bit == 1);
            $('.bcf2_diff_bit').toggleClass('bit-active', data.bcf2_diff_bit == 1);
            $('.bcf2_gang_bit').toggleClass('bit-active', data.bcf2_gang_bit == 1);
            $('.bcf2_que_bit').toggleClass('bit-active', data.bcf2_que_bit == 1);
            $('.bcf2_drain_bit').toggleClass('bit-active', data.bcf2_drain_bit == 1);
            
            // BCF3 존 구간 비트
            $('.bcf3_seong_bit').toggleClass('bit-active', data.bcf3_seong_bit == 1);
            $('.bcf3_chim_bit').toggleClass('bit-active', data.bcf3_chim_bit == 1);
            $('.bcf3_diff_bit').toggleClass('bit-active', data.bcf3_diff_bit == 1);
            $('.bcf3_gang_bit').toggleClass('bit-active', data.bcf3_gang_bit == 1);
            $('.bcf3_que_bit').toggleClass('bit-active', data.bcf3_que_bit == 1);
            $('.bcf3_drain_bit').toggleClass('bit-active', data.bcf3_drain_bit == 1);
            
            // BCF4 존 구간 비트
            $('.bcf4_seong_bit').toggleClass('bit-active', data.bcf4_seong_bit == 1);
            $('.bcf4_chim_bit').toggleClass('bit-active', data.bcf4_chim_bit == 1);
            $('.bcf4_diff_bit').toggleClass('bit-active', data.bcf4_diff_bit == 1);
            $('.bcf4_gang_bit').toggleClass('bit-active', data.bcf4_gang_bit == 1);
            $('.bcf4_que_bit').toggleClass('bit-active', data.bcf4_que_bit == 1);
            $('.bcf4_drain_bit').toggleClass('bit-active', data.bcf4_drain_bit == 1);
            
            // CM 존 구간 비트
            $('.cm_gun_bit').toggleClass('bit-active', data.cm_gun_bit == 1);
            $('.cm_tem_bit').toggleClass('bit-active', data.cm_tem_bit == 1);
            $('.cm_cool_bit').toggleClass('bit-active', data.cm_cool_bit == 1);
            
            // CM2 존 구간 비트
            $('.cm2_gun_bit').toggleClass('bit-active', data.cm2_gun_bit == 1);
            $('.cm2_tem_bit').toggleClass('bit-active', data.cm2_tem_bit == 1);
            $('.cm2_cool_bit').toggleClass('bit-active', data.cm2_cool_bit == 1);
            
            
         // ========== 패턴 번호 표시 ==========
            $('.bcf1_pattern_number').text(data.bcf1_pattern_number || '0');
            $('.bcf2_pattern_number').text(data.bcf2_pattern_number || '0');
            $('.bcf3_pattern_number').text(data.bcf3_pattern_number || '0');
            $('.bcf4_pattern_number').text(data.bcf4_pattern_number || '0');


            // ========== 통 번호 표시 ==========
            $('.cm2_tong_number').text(data.cm2_tong_number || '0');
            $('.bcf4_tong_number').text(data.bcf4_tong_number || '0');
            $('.bcf3_tong_number').text(data.bcf3_tong_number || '0');
            $('.bcf2_tong_number').text(data.bcf2_tong_number || '0');
            $('.bcf1_tong_number').text(data.bcf1_tong_number || '0');
            $('.cm_tong_number').text(data.cm_tong_number || '0');
            
            
            // ========== 아날로그값 처리 (BCF 테이블에 값 표시) ==========
            
            // 1호기
            $('.bcf1_chim_setting').text(data.bcf1_chim_setting || '0');
            $('.bcf1_oil_setting').text(data.bcf1_oil_setting || '0');
            $('.bcf1_cp_setting').text(data.bcf1_cp_setting || '0');
            $('.bcf1_tempering_setting').text(data.bcf1_tempering_setting || '0');
            $('.bcf1_seong_sv').text(data.bcf1_seong_sv || '0');
            $('.bcf1_chim_sv').text(data.bcf1_chim_sv || '0');
            $('.bcf1_diff_sv').text(data.bcf1_diff_sv || '0');
            $('.bcf1_gang_sv').text(data.bcf1_gang_sv || '0');
            $('.bcf1_que_sv').text(data.bcf1_que_sv || '0');
            $('.bcf1_drain_sv').text(data.bcf1_drain_sv || '0');
            $('.bcf1_cool1_sv').text(data.bcf1_cool1_sv || '0');
            $('.bcf1_tem_sv').text(data.bcf1_tem_sv || '0');
            $('.bcf1_cool2_sv').text(data.bcf1_cool2_sv || '0');
            
            $('.bcf1_chim').text(data.bcf1_chim || '0');
            $('.bcf1_oil').text(data.bcf1_oil || '0');
            $('.bcf1_cp').text(data.bcf1_cp || '0');
            $('.bcf1_tempering').text(data.bcf1_tempering || '0');
            $('.bcf1_seong_pv').text(data.bcf1_seong_pv || '0');
            $('.bcf1_chim_pv').text(data.bcf1_chim_pv || '0');
            $('.bcf1_diff_pv').text(data.bcf1_diff_pv || '0');
            $('.bcf1_gang_pv').text(data.bcf1_gang_pv || '0');
            $('.bcf1_que_pv').text(data.bcf1_que_pv || '0');
            $('.bcf1_drain_pv').text(data.bcf1_drain_pv || '0');
            $('.bcf1_cool1_pv').text(data.bcf1_cool1_pv || '0');
            $('.bcf1_tem_pv').text(data.bcf1_tem_pv || '0');
            $('.bcf1_cool2_pv').text(data.bcf1_cool2_pv || '0');
            
            // 2호기
            $('.bcf2_chim_setting').text(data.bcf2_chim_setting || '0');
            $('.bcf2_oil_setting').text(data.bcf2_oil_setting || '0');
            $('.bcf2_cp_setting').text(data.bcf2_cp_setting || '0');
            $('.bcf2_seong_sv').text(data.bcf2_seong_sv || '0');
            $('.bcf2_chim_sv').text(data.bcf2_chim_sv || '0');
            $('.bcf2_diff_sv').text(data.bcf2_diff_sv || '0');
            $('.bcf2_gang_sv').text(data.bcf2_gang_sv || '0');
            $('.bcf2_que_sv').text(data.bcf2_que_sv || '0');
            $('.bcf2_drain_sv').text(data.bcf2_drain_sv || '0');
            
            $('.bcf2_chim').text(data.bcf2_chim || '0');
            $('.bcf2_oil').text(data.bcf2_oil || '0');
            $('.bcf2_cp').text(data.bcf2_cp || '0');
            $('.bcf2_seong_pv').text(data.bcf2_seong_pv || '0');
            $('.bcf2_chim_pv').text(data.bcf2_chim_pv || '0');
            $('.bcf2_diff_pv').text(data.bcf2_diff_pv || '0');
            $('.bcf2_gang_pv').text(data.bcf2_gang_pv || '0');
            $('.bcf2_que_pv').text(data.bcf2_que_pv || '0');
            $('.bcf2_drain_pv').text(data.bcf2_drain_pv || '0');
            
            // 3호기
            $('.bcf3_chim_setting').text(data.bcf3_chim_setting || '0');
            $('.bcf3_oil_setting').text(data.bcf3_oil_setting || '0');
            $('.bcf3_cp_setting').text(data.bcf3_cp_setting || '0');
            $('.bcf3_tempering_setting').text(data.bcf3_tempering_setting || '0');
            $('.bcf3_seong_sv').text(data.bcf3_seong_sv || '0');
            $('.bcf3_chim_sv').text(data.bcf3_chim_sv || '0');
            $('.bcf3_diff_sv').text(data.bcf3_diff_sv || '0');
            $('.bcf3_gang_sv').text(data.bcf3_gang_sv || '0');
            $('.bcf3_que_sv').text(data.bcf3_que_sv || '0');
            $('.bcf3_drain_sv').text(data.bcf3_drain_sv || '0');
            $('.bcf3_cool1_sv').text(data.bcf3_cool1_sv || '0');
            $('.bcf3_tem_sv').text(data.bcf3_tem_sv || '0');
            $('.bcf3_cool2_sv').text(data.bcf3_cool2_sv || '0');
            
            $('.bcf3_chim').text(data.bcf3_chim || '0');
            $('.bcf3_oil').text(data.bcf3_oil || '0');
            $('.bcf3_cp').text(data.bcf3_cp || '0');
            $('.bcf3_tempering').text(data.bcf3_tempering || '0');
            $('.bcf3_seong_pv').text(data.bcf3_seong_pv || '0');
            $('.bcf3_chim_pv').text(data.bcf3_chim_pv || '0');
            $('.bcf3_diff_pv').text(data.bcf3_diff_pv || '0');
            $('.bcf3_gang_pv').text(data.bcf3_gang_pv || '0');
            $('.bcf3_que_pv').text(data.bcf3_que_pv || '0');
            $('.bcf3_drain_pv').text(data.bcf3_drain_pv || '0');
            $('.bcf3_cool1_pv').text(data.bcf3_cool1_pv || '0');
            $('.bcf3_tem_pv').text(data.bcf3_tem_pv || '0');
            $('.bcf3_cool2_pv').text(data.bcf3_cool2_pv || '0');
            
            // 4호기
            $('.bcf4_chim_setting').text(data.bcf4_chim_setting || '0');
            $('.bcf4_oil_setting').text(data.bcf4_oil_setting || '0');
            $('.bcf4_cp_setting').text(data.bcf4_cp_setting || '0');
            $('.bcf4_seong_sv').text(data.bcf4_seong_sv || '0');
            $('.bcf4_chim_sv').text(data.bcf4_chim_sv || '0');
            $('.bcf4_diff_sv').text(data.bcf4_diff_sv || '0');
            $('.bcf4_gang_sv').text(data.bcf4_gang_sv || '0');
            $('.bcf4_que_sv').text(data.bcf4_que_sv || '0');
            $('.bcf4_drain_sv').text(data.bcf4_drain_sv || '0');
            
            $('.bcf4_chim').text(data.bcf4_chim || '0');
            $('.bcf4_oil').text(data.bcf4_oil || '0');
            $('.bcf4_cp').text(data.bcf4_cp || '0');
            $('.bcf4_seong_pv').text(data.bcf4_seong_pv || '0');
            $('.bcf4_chim_pv').text(data.bcf4_chim_pv || '0');
            $('.bcf4_diff_pv').text(data.bcf4_diff_pv || '0');
            $('.bcf4_gang_pv').text(data.bcf4_gang_pv || '0');
            $('.bcf4_que_pv').text(data.bcf4_que_pv || '0');
            $('.bcf4_drain_pv').text(data.bcf4_drain_pv || '0');
        },
        error: function(xhr, status, error) {
            console.error('Overview 데이터 조회 실패:', error);
            console.error('Response:', xhr.responseText);
        }
    });
}
</script>

	</body>
</html>
