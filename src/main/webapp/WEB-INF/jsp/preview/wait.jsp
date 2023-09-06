<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="/resources/js/swiper.min.css">
	<script type="text/javascript" src="/resources/js/swiper.min.js"></script>
<script>
	$(function() {
		var _param = JSON.parse('${data}');
		$.pb.ajaxCallHandler('/admin/selectWaitPreview.do', { funeralNo:_param.funeralNo }, function(data) {
			var _list = data.list;
			
			if(data.list.length == 0) {
				$('.wait-warp').css('background', '#000');
			}else {
				// 0:�̻��, 1:���� �����̵�, 2:������
				if(_list[0].SCREEN_TYPE == 0) {
					$('.wait-warp').css('background', '#000');
				}else if(_list[0].SCREEN_TYPE == 1) {
					var _slideContainer = $('<div class="swiper-container" style="width:100%; height:100%;">');
					var _slideWrap = $('<div class="swiper-wrapper">');

					$.each(_list, function(idx) {
						var _div = $('<div class="swiper-slide">');
						_div.css('background-image', 'url("'+this.FILE+'")');
						_slideWrap.append(_div);
					})
					_slideContainer.append(_slideWrap);
					$('.wait-warp').append(_slideContainer);
					
					if($('.swiper-slide').length > 1) {
						var swiper = new Swiper('.swiper-container',{
							effect : 'slide',
							width : $('.wait-warp').width(),
							centeredSlides: true,
						      	autoplay: {
						      		disableOnInteraction : false, //���콺 Ŭ���ص� �����̵� ���
						        	delay: _list[0].SLIDE_SEC*1000
						      	},
							loop: true
						});
					}
				}else {
					// �������� ��� ���ϴٿ�ε� �ɼ� �ֵ��� ����
					$('.wait-warp').css('background', '#000');
					$.pb.ajaxCallHandler('/admin/selectWaitVideo.do', { raspberryConnectionNo:_param.raspberryConnectionNo, funeralNo:_param.funeralNo }, function(data) { })
					
				}
			}
			
		})
	})
</script>
</head>
<style>
	html { width:1920px;height:1080px; min-width:0px; }
	body { background:#fff; width:100%; height:100%; margin: 0px; overflow: hidden; }
	.swiper-slide { background-repeat: no-repeat; background-size: 100% 100%; }
</style>
<body>
	<div class="wait-warp" style="width:100%;height:100%"></div>
</body>
</html>