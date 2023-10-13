<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pbfw.common.url.UrlType" %>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="/resources/js/swiper.min.css">
	<script type="text/javascript" src="/resources/js/swiper.min.js"></script>
	<title>빈소현황</title>
<script>
	function binsoInit(_eventNo,_funeralNo,_raspberryConnectionNo, _raspberryId, syIpFlag) {
		
		/* SSL TEST */ 
		//var imgUrl = "http://211.251.237.150:7080";
		var imgUrl = '${UrlType.HTTP}';
		﻿var currentUrl = ﻿document.location.href;
		if(currentUrl.indexOf("https://") > -1) {
			imgUrl = '${UrlType.HTTPS}';
		}
		
		// 빈소 음원 전달
		$.pb.ajaxCallHandler('/admin/selectEventDetail.do', { order:'EXPOSURE ASC, APPELLATION ASC, ENTRANCE_ROOM_DT', statusPlate:'true', eventAliveFlag:1, funeralNo:_funeralNo , raspberryConnectionNo:_raspberryConnectionNo, eventNo:_eventNo, raspberryId:_raspberryId }, function(data) {
			// 공용 변수 선언 //
			var evtInfo = data.eventInfo[0];
			var style = data.raspberryStatusPlate;
			var fam = data.eventFamilyInfo;
			var evtCarInfo = data.eventCarInfo;
// 			var obituary = data.obituary;
			var music = data.music;
			
			if(evtInfo) {
				if(_funeralNo == 1207) { //삼육일 경우 입관화면이 빈소모드 세로형으로 고정되어야 함
					$('html').width('1080px');
					$('html').height('1920px');
					$('.main').pageConnectionHandler('/preview/binsoMode/portrait', { }, function() { setData(); });
					
					// 삼육 입관일 경우 입관 마감시간 조정
					if(syIpFlag) {
						var isPause = false;
						var timer = setInterval(function() {
							if(isPause == false && new Date() > new Date(evtInfo.ENTRANCE_ROOM_END_DT)) {
								isPause = true;
								location.reload();
							}
							if(isPause) clearInterval(timer);
						}, 10000);
					}
				
				
				}
				
				/**
				* HYH - 착한전문병원 장례식장 개발:1365 , 운영:1366
				* 대동병원 장례식장 : 597
				* 자굴산 장례식장 : 309
				* 양산장례식장 운영 : 300
				* 양산부산대학교병원 : 298
				* 동래봉생병원장례식장 : 599
				*/
				else if(_funeralNo == 1366 || _funeralNo == 597 || _funeralNo == 309 || _funeralNo == 300 || _funeralNo == 298 || _funeralNo == 599)  {	
				//else if(_funeralNo == 1366 || _funeralNo == 597 || _funeralNo == 309 || _funeralNo == 300 ) {
					$('html').width('1080px');
					$('html').height('1920px');
					$('.main').pageConnectionHandler('/preview/binsoMode/portrait_marquee', { }, function() { setData(); });
				}
				/* 
				else if(_funeralNo == 597){	//HYH - 대동병원 장례식장 개발 : 597, 운영 : 597
					$('html').width('1080px');
					$('html').height('1920px');
					$('.main').pageConnectionHandler('/preview/binsoMode/portrait_daedong', { }, function() { setData(); });
				}else if(_funeralNo == 309){	//HYH - 자굴산 장례식장 개발 : 597, 운영 : 597
					$('html').width('1080px');
					$('html').height('1920px');
					$('.main').pageConnectionHandler('/preview/binsoMode/portrait_daedong', { }, function() { setData(); });
				}
				 */
				
				
				else {
					if(style) {
						$('.control-warp').css('font-family', style.FONT_TYPE);
						// ** 화면 분기 ** //
						if(style.SCREEN_MODE == 1) { // 빈소 가로형 시작 //
							$('.main').pageConnectionHandler('/preview/binsoMode/landscape', { }, function() { setData(); });
						}else { // 빈소 세로형 시작 //
							$('html').width('1080px');
							$('html').height('1920px');
							$('.main').pageConnectionHandler('/preview/binsoMode/portrait', { }, function() { setData(); });				
						}
					}else $('.main').pageConnectionHandler('/preview/binsoMode/landscape', { }, function() { setData(); })
				}
				
				
				
				$.pb.ajaxCallHandler('/admin/selectPreviewMusic.do', { raspberryConnectionNo:_raspberryConnectionNo }, function(data) { })
				var carryingDt = (new Date(evtInfo.CARRYING_DT)).format('MM월dd일 HH시mm분');
				var entranceRoomStartDt = (new Date(evtInfo.ENTRANCE_ROOM_START_DT)).format('MM월dd일 HH시mm분');
				
				// 공용 변수 준비, 연산 필요 데이터 연산 //
				function setData(){
					if(!style) {
						style = {
								SCREEN_MODE : 1
						}
					}
					
					if(style.SCREEN_MODE == 1) {
						
						var goinString = '故 '+ evtInfo.DM_NAME + " " + (evtInfo.DM_POSITION ? evtInfo.DM_POSITION : "");
// 						if(style && style.SCREEN_MODE == 2) goinString += '<br>'
						
						/* if( evtInfo.DM_GENDER==1 || evtInfo.DM_GENDER == 3 ){
							if(evtInfo.DM_AGE != '') { goinString += ' (남,'+evtInfo.DM_AGE+'세)'; }
							else { goinString += ' (남)'; }
						}else{
							if(evtInfo.DM_AGE != '') { goinString += ' (여,'+evtInfo.DM_AGE+'세)'; }
							else { goinString += ' (여)'; }
						}	 */
						
						if(evtInfo.DM_GENDER==0){
							if(evtInfo.DM_AGE != ''){
								goinString += ' ('+ evtInfo.DM_AGE+'세)';
							}
						}else if(evtInfo.DM_GENDER==1){
							if(evtInfo.DM_AGE != ''){
								goinString += ' (남, '+ evtInfo.DM_AGE+'세)';
							}else{
								goinString += ' (남)';
							}
						}else if(evtInfo.DM_GENDER==2){
							if(evtInfo.DM_AGE != ''){
								goinString += ' (여, '+ evtInfo.DM_AGE+'세)';
							}else{
								goinString += ' (여)';
							}
						}else if(evtInfo.DM_GENDER==3){
							if(evtInfo.DM_AGE != ''){
								goinString += ' (男, '+ evtInfo.DM_AGE+'세)';
							}else{
								goinString += ' (男)';
							}
						}else if(evtInfo.DM_GENDER==4){
							if(evtInfo.DM_AGE != ''){
								goinString += ' (女, '+ evtInfo.DM_AGE+'세)';
							}else{
								goinString += ' (女)';
							}
						}
						
						$( '.goin-name-input' ).html( goinString );
					
					
					
					}else {
						$('.goin-name-input').text('故 '+ evtInfo.DM_NAME);
						$('.goin-po-input').text(evtInfo.DM_POSITION);
						
						var age = ''
						
						/* if( evtInfo.DM_GENDER==1 || evtInfo.DM_GENDER == 3 ){
							if(evtInfo.DM_AGE != '') { age += ' (남,'+evtInfo.DM_AGE+'세)'; }
							else { age += ' (남)'; }
						}else{
							if(evtInfo.DM_AGE != '') { age += ' (여,'+evtInfo.DM_AGE+'세)'; }
							else { age += ' (여)'; }
						} */	
						
							if(evtInfo.DM_GENDER==0){
								if(evtInfo.DM_AGE != ''){
									age += ' ('+ evtInfo.DM_AGE+'세)';
								}
							}else if(evtInfo.DM_GENDER==1){
								if(evtInfo.DM_AGE != ''){
									age += ' (남, '+ evtInfo.DM_AGE+'세)';
								}else{
									age += ' (남)';
								}
							}else if(evtInfo.DM_GENDER==2){
								if(evtInfo.DM_AGE != ''){
									age += ' (여, '+ evtInfo.DM_AGE+'세)';
								}else{
									age += ' (여)';
								}
							}else if(evtInfo.DM_GENDER==3){
								if(evtInfo.DM_AGE != ''){
									age += ' (男, '+ evtInfo.DM_AGE+'세)';
								}else{
									age += ' (男)';
								}
							}else if(evtInfo.DM_GENDER==4){
								if(evtInfo.DM_AGE != ''){
									age += ' (女, '+ evtInfo.DM_AGE+'세)';
								}else{
									age += ' (女)';
								}
							}
						
						
						$('.goin-age-input').text(age);
						$('.goin-name').css('flex-direction', 'column');
					}
					
					/* ============================ */
					console.log("evtInfo.appellation : ", evtInfo.APPELLATION);
					
					//대동병원 597, 양산부산대학교 장례식장 298, 동래봉생병원 장례식장 599
					if(_funeralNo == 298 || _funeralNo == 597 || _funeralNo == 599 ){
						var binsoNm=evtInfo.APPELLATION;
						
						binsoNm=binsoNm.replace('(', '<br>(');
						console.log(binsoNm);
						$( '.hosil-input' ).html( binsoNm );				
						
					}else{
						$( '.hosil-input' ).html( evtInfo.APPELLATION );
					}									
					/* ============================ */
					
					
					// 공용 데이터 UI 적용 //
					//$( '.hosil-input' ).html( evtInfo.APPELLATION );
					$( '.photo' ).attr( "src" , evtInfo.DM_PHOTO );
					// 종교이미지 설정 //
					if(evtInfo.STATUS_PLATE_BG ? $( '.religion' ).attr("src",evtInfo.STATUS_PLATE_BG) : $( '.religion' ).css("display" , "none") )
					if( evtInfo.BURIAL_PLOT_NAME == '' ? $( '.burial-plot-input' ).html( '미정' ) : $( '.burial-plot-input' ).html( evtInfo.BURIAL_PLOT_NAME ) )
					
					//발인 미정
					if(evtInfo.CARRYING_YN == 1) $( '.carrying-date' ).html( carryingDt );
					else $( '.carrying-date' ).html('-');
					 					
					//HYH - 입관 미정
					//$( '.enter-date' ).html( entranceRoomStartDt );
					if(evtInfo.IPGWAN_YN == 1){
						$( '.enter-date' ).html( entranceRoomStartDt );	
					}else{
						$( '.enter-date' ).html('-');
					}
					// ./HYH - 입관 미정

					// 스타일 관련//
					if(_funeralNo == 1207) { //삼육일경우 스타일분리
						$.pb.ajaxCallHandler('/admin/selectPreviewSYIPStyle.do', { raspberryConnectionNo:_raspberryConnectionNo }, function(result) {
							var data = result.list[0];
							$( '.backgrond-image-wrap' ).css({"background":"url("+(data ? data.FILE : imgUrl+"/dsfiles/style/style_sample_01_vertical.svg")+")"} );
							$( '.hosil-input' ).css({"color":(data ? data.STATUS : '#FFF')});
							$( '.goin-name-input' ).css({"color":(data ? data.NAME : '#FFF')});
							$( '.goin-po-input' ).css({"color":(data ? data.NAME : '#FFF')});
							$( '.goin-age-input' ).css({"color":(data ? data.NAME : '#FFF')});
							$( '.enter-date-name' ).css({"color":(data ? data.ER_START : '#FFF')});
							$( '.enter-date' ).css({"color":(data ? data.ER_START_TIME : '#000')});
							$( '.carrying-date-name' ).css({"color":(data ? data.CARRING_START : '#FFF')});
							$( '.carrying-date' ).css({"color":(data ? data.CARRING_START_TIME : '#000')});
							$( '.burial-plot-name' ).css({"color":(data ? data.BURIAL_PLOT : '#FFF')});
							$( '.burial-plot-input' ).css({"color":(data ? data.BURIAL_PLOT_NAME : '#000')});
						})
					}else {
						$( '.backgrond-image-wrap' ).css({"background":"url("+(style.STATUS_PLATE_STYLE_FILE ? style.STATUS_PLATE_STYLE_FILE : imgUrl+"/dsfiles/style/style_sample_01_horizontal.svg")+")"} );
						$( '.hosil-input' ).css({"color":(style.STATUS ? style.STATUS : '#FFF')});
						$( '.goin-name-input' ).css({"color":(style.NAME ? style.NAME : '#FFF')});
						$( '.enter-date-name' ).css({"color":(style.ER_START ? style.ER_START : '#FFF')});
						$( '.enter-date' ).css({"color":(style.ER_START_TIME ? style.ER_START_TIME : '#000')});
						$( '.carrying-date-name' ).css({"color":(style.CARRING_START ? style.CARRING_START : '#FFF')});
						$( '.carrying-date' ).css({"color":(style.CARRING_START_TIME ? style.CARRING_START_TIME : '#000')});
						$( '.burial-plot-name' ).css({"color":(style.BURIAL_PLOT ? style.BURIAL_PLOT : '#FFF')});
						$( '.burial-plot-input' ).css({"color":(style.BURIAL_PLOT_NAME ? style.BURIAL_PLOT_NAME : '#000')});
					}
					
					// 추모의 글 영역 세팅 //
					/* $.pb.ajaxCallHandler('https://choomo.app/api/v1/event/obituary-comment', { eventNo : evtInfo.EVENT_NO }, function(data) {
						try{
							var choomoWrap = $( '.choomo-wrap' );
							$.each(data, function(i){
								choomoWrap.find('.condolence').addClass('slide');
								var _comment = $("<div class='swiper-slide'><img src='/resources/img/icon_obi_0"+data[i].USER_FLAG+".png'><div class='comment'><div>'"+data[i].COMMENT_NO+"' "+data[i].NAME+"</div></div></div>");
								choomoWrap.find('.condolence .swiper-wrapper').append(_comment);
							});
						}finally{
							choomoInit();
						}
					}); */
					
					/* HYH - 추모의 글 영역 착한전문장례 슬라이드 구분 */
					/**
				* HYH - 착한전문병원 장례식장 개발:1365 , 운영:1366
				* 대동병원 장례식장 : 597
				* 자굴산 장례식장 : 309
				* 양산장례식장 운영 : 300
				* 양산부산대학교병원 : 298
				* 동래봉생병원장례식장 : 599
				*/
				
					// const apiURL = 'https://choomo.app/api/v1/event/obituary-comment';
					const apiURL = 'https://cnemoment.com/api/v1/event/obituary-comment';
					
					if(_funeralNo == 1366 || _funeralNo == 597 || _funeralNo == 309 || _funeralNo == 300 || _funeralNo == 298 || _funeralNo == 599){//HYH - 추모의 글 영역 가로로 텍스트 전부 나오게 운영 -1366
					//if(_funeralNo == 1366 || _funeralNo == 597 || _funeralNo == 309 || _funeralNo == 300){//HYH - 추모의 글 영역 가로로 텍스트 전부 나오게 운영 -1366	
						$.pb.ajaxCallHandler(apiURL, { eventNo : evtInfo.EVENT_NO }, function(data) {
							
							var choomoWrap = $( '.choomo-wrap' );
							var listL="<div class='swiper-slide-per'>";
							$.each(data, function(i){
								
								listL += "<img class='choomoImg' src='/resources/img/icon_obi_0"+data[i].USER_FLAG+".png'><div class='comment'>"
								+data[i].COMMENT_NO+" "
								+data[i].NAME+"</div>";									
							});
							listL+="</div>"
							console.log(listL);
							choomoWrap.find('.condolence .swiper-wrapper').append(listL);
							
						});					
					}else{
						$.pb.ajaxCallHandler(apiURL, { eventNo : evtInfo.EVENT_NO }, function(data) {
							try{
								var choomoWrap = $( '.choomo-wrap' );
								
								$.each(data, function(i){							
									choomoWrap.find('.condolence').addClass('slide');
									
									var _comment = $("<div class='swiper-slide'><img src='/resources/img/icon_obi_0"+data[i].USER_FLAG+".png'><div class='comment'><div>'"
											+data[i].COMMENT_NO+"' "
											+data[i].NAME+"</div></div></div>");
									choomoWrap.find('.condolence .swiper-wrapper').append(_comment);
									console.log(_comment.width());
								});
							}finally{
								choomoInit();
							}
						});
					 }
		
					


					
					//글자 크기 변경
					autoFontSize($('.hosil-input'), $('.hosil'));
					
					if(style.SCREEN_MODE == 1) {
						// 고인명
						if($('.goin-name-input').height() > $('.goin-name').height())
							autoFontSize( $('.goin-name-input'), $('.goin-name'));
					}else {
						if($('.goin-name-input').height() > $('.goin-name-box').height())
							autoFontSize( $('.goin-name-input'), $('.goin-name-box'));
						if($('.goin-po-input').height() > $('.goin-po-box').height());
							autoFontSize( $('.goin-po-input'), $('.goin-po-box'));
					}
					
					autoFontSize($('.burial-plot-input'), $('.burial-plot'));
					$('.chief-mourner').previewFnBinsoFamily(evtInfo.EVENT_NO, fam);
					
					// 글자크기 변경 - 폰트 받아오는 시간 오래걸려서 작성
			 		var timer = setInterval(function() {
						// 호실
						if($('.hosil-input').height() > $('.hosil').height())
							autoFontSize( $('.hosil-input'), $('.hosil'));
						
						if(style.SCREEN_MODE == 1) {
							// 고인명
							if($('.goin-name-input').height() > $('.goin-name').height())
								autoFontSize( $('.goin-name-input'), $('.goin-name'));
						}else {
							if($('.goin-name-input').height() > $('.goin-name-box').height())
								autoFontSize( $('.goin-name-input'), $('.goin-name-box'));
							if($('.goin-po-input').height() > $('.goin-po-box').height());
								autoFontSize( $('.goin-po-input'), $('.goin-po-box'));
						}
						// 장지
						if($('.burial-plot-input').height() > $('.burial-plot').height())
							autoFontSize( $('.burial-plot-input'), $('.burial-plot'));
						// 상주
						if($('.family.chief-mourner.sangjuRoot').height() < $('.sangjuContainer').height())
							$('.chief-mourner').previewFnBinsoFamily(evtInfo.EVENT_NO, fam);
					}, 1000);
					
					// 60초후 setInterval 종료
					setTimeout(function() { clearInterval(timer) }, 60000);
				}
			}else
				$('.control-warp').pageConnectionHandler('/preview/wait', { raspberryConnectionNo: _raspberryConnectionNo, funeralNo:_funeralNo }, function() { });
			
		});
		// 가로모드, 세로모드 공용 함수 //
		function choomoInit(){
			if(swiper != null) swiper.destroy(true, true);
			if($('.swiper-wrapper').find('.swiper-slide').length > 1){
				var swiper = new Swiper('.swiper-container', {
					direction: 'vertical',
					width : $('.swiper-container').width(),
					height : $('.swiper-container').height(),
					centeredSlides: true,
			      	autoplay: {
			      		disableOnInteraction : false, //마우스 클릭해도 슬라이드 재생
			        	delay: 3000
			      	},
					loop: true
				});
			}
		}
			
	}
</script>
</head>
<style>
html { width:1920px;height:1080px;min-width:0px; }
</style>
<body>
	<div class="main" style="width:100%;height:100%"></div>
</body>
</html>