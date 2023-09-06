<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<style>
	.sangga-container { width:100%; height:100%; display:flex; flex-direction:column; }
	.sangga-div-top { width:100%; height:80px; display:flex; flex-direction:row; background-image: url('/resources/img/bg_top_sangga.png'); background-size: 100% 100%; }
	.sangga-div-top-left { height:100%; display:flex; justify-content: left; align-items: center; flex:25; color:#fff; font-size:24px; font-family: NanumGothic; padding-left: 120px;}
	.sangga-div-top-center { height:100%; display:flex; justify-content: center; align-items: center; flex:50; color:#fff; font-size:46px; font-family: NanumGothic; word-spacing: 5vw; }
	
	.sangga-div-top-right-main {display: flex;  flex-direction: column; justify-content: flex-end; align-items: center; height: 100%; white-space: pre-wrap; }	
	.sangga-div-top-right { height:100%; display:flex; justify-content: flex-end; align-items: center; flex:25; color:#fff; font-size:24px; font-family: NanumGothic;padding-right: 120px;}
	.sangga-div-top-right-address {height:100%; display:flex; justify-content: flex-end; align-items: center; flex:30;  font-weight: bold; color:#fff; font-size:20px; font-family: NanumGothic;padding-right: 120px; }
	
	
	
	.sangga-div-center { width:100%; height:1000px; }
	.sangga-table { width:100%;height:99.8%; border-collapse: collapse;letter-spacing:1px;}
	.sangga-table-head { background-image: linear-gradient(to bottom, #868686, #000000 46%, #838383); color:#fff; }
	.sangga-table-head td { height: 40px; text-align: center; font-size:24px; font-family: NanumGothic; border: 1px solid #707070; letter-spacing: 20px; text-indent: 20px; }
	.sangga-table-body td { text-align: center; font-size:20px; font-family: NanumGothic; border: 1px solid #777777; font-weight: bold; box-sizing: border-box; }
	.sangga-table-body tr { min-height:192px; }
	
    .sangga-table-body tr:nth-child(3n+1) { border-top: 2px solid #000; }
    .sangga-table-body tr:first-child { border-top:none; }
    
	.sangga-table-body tr:nth-child(6n+1) { background:#f2f3fa; }
	.sangga-table-body tr:nth-child(6n+2) { background:#f2f3fa; }
	.sangga-table-body tr:nth-child(6n+3) { background:#f2f3fa; }
	.evt-info { width:100%; height:100%; display:flex; flex-direction:column; }
	.evt-info-row { display:flex; flex-direction:row; flex:1; justify-content: center; align-items: center; }
	.evt-info-row-name { display:flex; flex:15; justify-content: center; align-items: center; }
	.evt-info-row-date { display:flex; flex:85; justify-content: center; align-items: center; }
	
	/* ============================= */
	
	.appllation-wrap { display: flex; justify-content: center; align-items: center; height: 100%; white-space: pre-wrap; }
 	.appllation { font-size: 30px; width: 100%; text-align: center; display: flex; justify-content: center; align-items: center; }
 	
 	.bigo-wrap { display: flex; justify-content: center; align-items: center; height: 100%; white-space: pre-wrap;}
 	.bigo {  font-size: 24px; width: 100%; text-align: left; display: flex; justify-content: flex-start; align-items: center; } 	
 	
 	.bigo-tel-wrap {  width: 100%; text-align: center; display: flex; justify-content: center; align-items: center; }
 	
 	 	
 	.sangjuNm-wrap { display: flex; justify-content: center; align-items: center; height: 100%; white-space: pre-wrap; }
 	.sangjuNm { font-size: 26px; width: 100%; text-align: left; display: flex; justify-content: flex-start; align-items: center; }	
	
	.goin-wrap { display: flex; justify-content: center; align-items: center; height: 100%; white-space: pre-wrap; }
	.goin { font-size: 32px; width: 100%; text-align: center; display: flex; justify-content: center; align-items: center; }
		
	.jangji-wrap { display: flex; justify-content: center; align-items: center; height: 100%; white-space: pre-wrap; }
 	.jangji { font-size: 22px; width: 100%; text-align: left; display: flex; justify-content: center; align-items: center; }
 	
 	.sangjo-wrap { display: flex; justify-content: center; align-items: center; height: 100%; white-space: pre-wrap; }
 	.sangjo { font-size: 22px; width: 100%; text-align: left; display: flex; justify-content: center; align-items: center; }
 	
 	.place-wrap { display: flex; justify-content: center; align-items: center; height: 100%; white-space: pre-wrap; }
 	.place { font-size: 22px; width: 100%; text-align: left; display: flex; justify-content: center; align-items: center; }
 	
 	
 	
 	/* ============================== */
 	 	
 	.font-wrap { display: flex; justify-content: center; align-items: center; height: 100%; white-space: pre-wrap; }
	 	
 	
 	/* .binsoCss { font-size: 20px; } */ 
 	
 	
 		 	
</style>
<head>
<script>
	function sanggaInit(_funeralNo){
	     $.pb.ajaxCallHandler('/admin/selectSanggaList.do', { order:'EXPOSURE ASC, APPELLATION ASC', funeralNo:_funeralNo, statusPlate:true }, function(data) {
	    	 
	    	 console.log(data);
	        var table = $('.sangga-table');
	        var thead = $('.sangga-table-head');
	        var tbody = $('.sangga-table-body');
	        //thead.append('<tr><td>빈소</td><td>고인</td><td>상주정보</td><td colspan="2" style="letter-spacing:1.2px;">상례정보</td><td>장지</td><td style="letter-spacing:1.2px;">상조회사</td><td>비고</td></tr>');
	        thead.append('<tr><td>빈소</td><td>고인</td><td>상주정보</td><td colspan="2" style="letter-spacing:1.2px;">상례정보</td><td>장지</td><td style="letter-spacing:1.2px;">상조회사</td><td>비고</td></tr>');
	        
	        var _list = data.list
	        $.each(_list, function(i, oneData){
	        	
				var nameAreaStr = '';
				var sjName = '';
				var jangji = '';
				var sangjo = '';				
				var sangjuNm = '';				
				var bigo = '';
				var place='';
				var enterDt = '<td style="width:3%;">입실</td><td style="width:9%;"></td>';
				var enterSDt = '<td>입관</td><td></td>';
				var carryDt = '<td>발인</td><td></td>';
				
				
				
				var f_parlor="";
				var f_parlor_floor="";
				if(oneData.APPELLATION !=null && oneData.APPELLATION !=""){
					var tmp1=oneData.APPELLATION.split('(');
					var tmp2="("+tmp1[1]
					
					f_parlor=tmp1[0];
					f_parlor_floor=tmp2;
					
				}
				
				
	           	if(oneData.DM_NAME != null && oneData.DM_NAME != ""){
           	  		nameAreaStr = '故'+oneData.DM_NAME; 
	              	if(oneData.DM_POSITION != null){
	                 	nameAreaStr += ' ';
	                 	nameAreaStr += oneData.DM_POSITION;
	              	}
	              	if( oneData.DM_GENDER!=0 || oneData.DM_AGE!=''){
	                 	nameAreaStr += '</br>(';
	                 
                 	if(oneData.DM_GENDER!=0){
                    	if (oneData.DM_GENDER==1){
	                       nameAreaStr+= '남';
	                    }
	                    if (oneData.DM_GENDER==2){
	                       nameAreaStr+= '여';
	                    }
	                    if (oneData.DM_GENDER==3){
	                       nameAreaStr+= '男';
	                    }
	                    if (oneData.DM_GENDER==4){
	                       nameAreaStr+= '女';
	                    }
	                    if(oneData.DM_AGE!=''){
	                       nameAreaStr+= ', ';
	                       nameAreaStr+= oneData.DM_AGE;
	                       nameAreaStr+= '세';
	                    }
                 	}else{
                    	nameAreaStr+= oneData.DM_AGE;
	                    nameAreaStr+= '세';
                 	}
               		nameAreaStr += ')';
				}
	              	if(oneData.DM_RELIGION_NAME != null && oneData.DM_RELIGION_NAME != ""){
	            		nameAreaStr += "<br />"+oneData.DM_RELIGION_NAME;   
	              	}
	              	if(oneData.CM_NAME != null && oneData.CM_NAME != ""){
	                 	sjName +=oneData.CM_NAME;   
	              	}
	              	if(oneData.BURIAL_PLOT_NAME != null && oneData.BURIAL_PLOT_NAME != ""){
	                 	jangji +=oneData.BURIAL_PLOT_NAME;   
	              	}else
	              		jangji +='장지 미정';
	              	if(oneData.CARRYING_PLACE != null && oneData.CARRYING_PLACE != ""){
	                 	sangjo +=oneData.CARRYING_PLACE;   
	              	}
	              	if(oneData.BIGO != null && oneData.BIGO != ""){
	                 	bigo +=oneData.BIGO;   
	              	}
	              	
	              	//상주명 추가
	              	if(oneData.strSangju != null && oneData.strSangju != ""){
	              		
	              		var tmpStr = "("+oneData.strSangju.toString().trim()+")  ";	              		
	              		console.log(tmpStr);
	              		sangjuNm += tmpStr.replace(/\\/gi, ')<br>(');	              		
	              	}	              	
	              		              	
	              	var ipgwanYn="";
	              	if(oneData.IPGWAN_YN==1){
	              		ipgwanYn=new Date(oneData.ENTRANCE_ROOM_START_DT).format('MM월 dd일 HH:mm');
	              	}else{
	              		ipgwanYn="입관 미정";
	              	}
	              	
	              	carryDt = '발인 미정';
	              	if(oneData.CARRYING_YN == 1){
	                 	carryDt =new Date(oneData.CARRYING_DT).format('MM월 dd일 HH:mm');   
	              	}
	              	var curTime = new Date();
	              	if(curTime > new Date(oneData.ENTRANCE_ROOM_DT)){
	                 	enterDt = '<td style="width:3%;background:#fdce0c;">입실</td><td class="er-tm" data-time="'+oneData.ENTRANCE_ROOM_DT+'" style="width:9%;">'+new Date(oneData.ENTRANCE_ROOM_DT).format('MM월 dd일 HH:mm')+'</td>';
	              	}else{
	                 	enterDt = '<td style="width:3%;">입실</td><td class="er-tm" data-time="'+oneData.ENTRANCE_ROOM_DT+'" style="width:9%;">'+new Date(oneData.ENTRANCE_ROOM_DT).format('MM월 dd일 HH:mm')+'</td>';
	              	}
	              	if(curTime > new Date(oneData.ENTRANCE_ROOM_START_DT)){
	                 	enterSDt = '<td style="background:#fdce0c;">입관</td><td class="ers-tm" data-time="'+oneData.ENTRANCE_ROOM_START_DT+'">'+ipgwanYn+'</td>';
	              	}else{
	                 	enterSDt = '<td>입관</td><td class="ers-tm" data-time="'+oneData.ENTRANCE_ROOM_START_DT+'">'+ipgwanYn+'</td>';
	              	}
	              	
	              	
	              	if(oneData.CARRYING_YN == 1 && curTime > new Date(oneData.CARRYING_DT)){
	                 	carryDt = '<td style="background:#fdce0c;">발인</td><td class="c-tm" data-cYn="'+oneData.CARRYING_YN+'" data-time="'+oneData.CARRYING_DT+'">'+carryDt+'</td>';
	              	}else{
	                 	carryDt = '<td>발인</td><td class="c-tm" data-cYn="'+oneData.CARRYING_YN+'" data-time="'+oneData.CARRYING_DT+'">'+carryDt+'</td>';
	              	}	              	
	           	}
	           	
	           	var r1="070-7711-4448";
	           	var r2="070-8852-4448";
	           	var r3="070-8853-4448";
	           	var r4="070-8855-4448";
	           	
	           	var roomPhone="";
	           	
	           	if( i == 0){
	           		roomPhone=r1;
	           	}else if(i == 1){
	           		roomPhone=r2;
	           	}else if(i ==2){
	           		roomPhone=r3;
	           	}else if(i== 3){
	           		roomPhone=r4;
	           	}
	           	
	           	tbody.append('<tr>'+
	           		/* '<td rowspan="3" style="width:8%;"><div class="font-wrap"><div class="appllationH">'+oneData.APPELLATION+'</div></div></td>'+			//빈소명 */ 
	           		'<td rowspan="3" style="width:8%;"><div class="appllation-wrap"><div class="appllation">'+f_parlor+'<br>'+f_parlor_floor+'</div></div></td>'+			//빈소명
	           		'<td rowspan="3" style="width:10%;"><div class="goin-wrap"><div class="goin">'+nameAreaStr+'</div></div></td>'+			//고인명
	           		
	           		'<td rowspan="3" style="width:32%;"><div class="sangjuNm-wrap"><div class="sangjuNm">'+sangjuNm+'</div></div></td>'+	//상주관계
	           		enterDt+	//입실
		           	'<td rowspan="3" style="width:10%;"><div class="jangji-wrap"><div class="jangji">'+jangji+'</div></div></td>'+
		           	'<td rowspan="3" style="width:7%;"><div class="sangjo-wrap"><div class="sangjo">'+sangjo+'</div></div></td>'+																			//상조		           	
		           	
		           	
		           	'<td rowspan="2" style="width:12%;"><div class="bigo-wrap"><div class="bigo">'+bigo+'</div></div></td>'+		           	
		           	
		           	'<tr>'+enterSDt+'</tr>'+
		           	'<tr>'+carryDt+ '<td><div class="bigo-tel-wrap" style="font-style:italic;">TEL : '+roomPhone+'</div></td></tr>'
		           	);
        	});
	        table.append(thead);
	        table.append(tbody);
	        
	        var timer = setInterval(function() {
				$('.er-tm').each(function(i, o){
					if(new Date() > new Date($(this).data('time'))) {
						$(this).prev().css('background', '#fdce0c');
					}
					if(new Date() > new Date($('.ers-tm:eq('+i+')').data('time'))) {
						$('.ers-tm:eq('+i+')').prev().css('background', '#fdce0c');
					}
					if($('.c-tm:eq('+i+')').data('cYn') == 1 && new Date() > new Date($('.c-tm:eq('+i+')').data('time'))) {
						$('.c-tm:eq('+i+')').prev().css('background', '#fdce0c');
					}
				})
			}, 1000);
	        
	        
	        // table row height setting //
	        // 최소 5개의 데이터를 볼 수 있다. //
	        // 5개 이상인 경우 960px을 균등하게 나누어 높이값으로 설정 //
	        var dataLen = data.list.length;
	        if(dataLen <= 5){//64px
	           /* var rHeight = '64px';
	           $('.sangga-table-body .td').height(rHeight+'px'); */
	           //var rHeight = '316px';
	           var rHeight = '64px';
	           $('.sangga-table-body .td').height(rHeight+'px');	           
	           $('.sangga-table-body .goin-wrap').height(100 + 'px');		//고인(goin-wrap)
	           $('.sangga-table-body .sangjuNm-wrap').height(210 + 'px');	//상주관계:상주명(sangjuNm-wrap)
	           $('.sangga-table-body .bigo-wrap').height(120 + 'px');		//비고(bigo-wrap)
	           $('.sangga-table-body .bigo-tel-wrap').height(58 + 'px');
	           
	           
	           $('.sangga-table-body .jangji-wrap').height(60 + 'px');		//장지(jangji-wrap)
	           $('.sangga-table-body .sangjo-wrap').height(60 + 'px');		//상조(sangjo-wrap)
	           
	        }else{
	           if(dataLen > 10){
	              $('.sangga-table-body').find('td').css('font-size','15px');
	           }
	           if(dataLen > 15){
	              $('.sangga-table-body').find('td').css('font-size','12px');
	           }
	           var rHeight = ((950 / (dataLen * 4)) - 3 ) ;
	           $('.sangga-table-body').find('td').height(rHeight+'px');
	           $('.sangga-table-body .bigo-wrap').height((rHeight*3+20)+'px');
	           $('.sangga-table-body .sangjuNm-wrap').height((rHeight*3+20)+'px');
	           
	          /*  $('.sangga-table-body .font-wrap').height((rHeight*2+20)+'px');	//HYH - font-size 관련 추가
	           $('.sangga-table-body .jangji-wrap').height((rHeight*2+20)+'px');	//HYH - font-size 관련 추가 */
	           
	        }
	        
	        //$('.sangga-div-top-left').text(data.funeralInfo.FUNERAL_NAME);
	        var fName=data.funeralInfo.FUNERAL_NAME;
	        var fTel='Tel : 041-931-4447';
	        var fFax='Fax : 041-934-3444';
	        var mText=fName + '<br>' +'<div style="font-size:18px">'+ "&nbsp;&nbsp;"+fTel + '<br>' +"&nbsp;&nbsp;"+ fFax +'</div>';
	        
	        //$('.sangga-div-top-left').text(data.funeralInfo.FUNERAL_NAME);
	        $('.sangga-div-top-left').append(mText);
	        
	        
	        
	        
	     // 비고 쪽 글자 크기 줄여줌
	        $('.sangga-table-body .bigo').each(function() {
				autoFontSize( $(this), $(this).parent('.bigo-wrap'));
	        });	      
	        $('.sangga-table-body .sangjuNm').each(function() {
				autoFontSize( $(this), $(this).parent('.sangjuNm-wrap'));
	        });	        
	        $('.sangga-table-body .goin').each(function() {
				autoFontSize( $(this), $(this).parent('.goin-wrap'));
	        });	        
	        $('.sangga-table-body .jangji').each(function() {
				autoFontSize( $(this), $(this).parent('.jangji-wrap'));
	        });
	        $('.sangga-table-body .sangjo').each(function() {
				autoFontSize( $(this), $(this).parent('.sangjo-wrap'));
	        });
	        
	      
	     // 글자크기 이후 줄여줌
	        $('.sangga-table-body .bigo').css('height', '100%').css('overflow', 'hidden');
	        $('.sangga-table-body .sangjuNm').css('height', '100%').css('overflow', 'hidden');
	        $('.sangga-table-body .goin').css('height', '100%').css('overflow', 'hidden');
	        $('.sangga-table-body .jangji').css('height', '100%').css('overflow', 'hidden');
	        $('.sangga-table-body .sangjo').css('height', '100%').css('overflow', 'hidden');
	        $('.sangga-table-body .place').css('height', '100%').css('overflow', 'hidden');     	
	        
	     });
		
		var sanggaClock = setInterval(function() {
		   $('.sangga-div-top-right-main .sangga-div-top-right').html(new Date().format('MM월 dd일 HH시 mm분'));			
		}, 1000);
		
		
   }
</script>
</head>

<body>
   <div class="sangga-container">
      <div class="sangga-div-top">
         <div class="sangga-div-top-left"></div>
         <div class="sangga-div-top-center">상 가 현 황</div>
         <div class="sangga-div-top-right-main"><div class="sangga-div-top-right"></div><div class="sangga-div-top-right-address">보령시 웅천읍 충서로 1141</div></div>
         <!-- <div class="sangga-div-top-right"></div> -->
      </div>
      <div class="sangga-div-center">
         <table class="sangga-table"> 
         <thead class="sangga-table-head"></thead>
         <tbody class="sangga-table-body"></tbody>
         </table>
      </div>
   </div>
</body>

</html>