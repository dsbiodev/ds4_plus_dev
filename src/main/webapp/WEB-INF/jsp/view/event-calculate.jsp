<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<!DOCTYPE html>
<script>
	$(function() {
		if(!'${sessionScope.loginProcess}') $(location).attr('href', '/');
		var _param = JSON.parse('${data}');

		$('.pay-box .discount-price').targetMoney();
		$('.pay-box .pay-price').targetMoney();
		$('.receipt-box .receipt-price').targetMoney();
		
		if (self.name != 'reload'){
		    self.name = 'reload';
		    self.location.reload(true);
		}else self.name = '';		
		
		//$(document).off().on('click', '.event-info-top > .right-wrap > .btn.order', function() {
		$(document).off().on('click', '.event-info-top > .right-wrap > .order', function() {			
			
			//20220321 �ʱ�ȭ �߰�
			$('.order-list-table').find('tbody').empty();
			
			$('.pb-right-popup-wrap.order').openLayerPopup({}, function(_thisLayer) {
				$('body').css('overflow', 'hidden');
				$.pb.ajaxCallHandler('/adminSec/selectEventOrderList.do', {	eventNo : _param.pk, order : 'CREATE_DT DESC' }, function(data) {
					$.each(data.list, function(idx) {
						var _tr = $('<tr>');
						_tr.data(this);
						_tr.append('<td>'+this.FLAG+'</td>');
						_tr.append('<td>'+this.ITEM_NAME+'</td>');
						_tr.append('<td>'+(this.FLAG == '�ֹ�' ? '' : '-')+this.CNT+'</td>');
						_tr.append('<td>'+this.UNIT+'</td>');
						_tr.append('<td class="r">'+$.pb.targetMoney(this.PRICE)+'</td>');
						_tr.append('<td class="r">'+$.pb.targetMoney(this.ORDER_PRICE)+'</td>');
						_tr.append('<td>'+this.CREATE_DT+'</td>');
						$('.order-list-table').find('tbody').append(_tr);
					});
				});
			});
		});
		
		
		var createTable = function() {
			$.pb.ajaxCallHandler('/adminSec/selectEventCalculateList.do', {	eventNo : _param.pk, funeralNo : '${sessionScope.loginProcess.FUNERAL_NO}'}, function(data) {
				
				console.log(data)
				
				$('.company-price-table tbody').html("");
				$('.calculate-history-table tbody').html("");
				$('.receipt-history-table tbody').html("");

				$('.discount').html("");
				$('.discount').append('<option>����</option>');
				$.each(data.calculateDiscountList, function(idx) {
					var _option = $('<option value='+this.DISCOUNT_NO+'>'+this.NAME+" - "+this.DISCOUNT_INFO+'['+this.DISCOUNT_RATE+'%]'+'</option>');
					_option.data(this);
					$('.discount').append(_option);
				});
				$('.discount').on('change', function(){ changeDiscount(); });
				
				var changeDiscount = function(){
					$('.company-price-table tbody').html("");
					
					var _totalPrice = 0, _cashPrice = 0, _cardPrice = 0, _realTotalPrice = 0;
					$.each(data.partnerCalculateList, function(idx) {
						var _tr = $('<tr>');
						_tr.data(this);
						_tr.append('<td>'+this.PARTNER_NAME+'</td>');
						_tr.append('<td class="r"><button type="button" class="btn-print-cost">�μ�</button></td>');
						_tr.find('.btn-print-cost').on('click', function() {
							if(_tr.data('ORDER_PRICE') == 0) return alert("�ֹ��� ������ �����ϴ�.")
							else {
// 								window.open('/290904/'+_param.pk+"&"+_tr.data('PARTNER_NO'), "printName", "");
					 			window.open('/290904/'+_param.pk+"&"+_tr.data('PARTNER_NO'), "printName", "width=1000, height=800, scrolbars=yes");
							}
						});
						
						_tr.append('<td class="r"><button type="button" class="btn-print-tb">�μ�</button></td>');
						_tr.find('.btn-print-tb').on('click', function() {
							if(_tr.data('ORDER_PRICE') == 0) return alert("��ǰ�� ������ �����ϴ�.")
							else {
// 								window.open('/290905/'+_param.pk+"&"+_tr.data('PARTNER_NO'), "printName", "");
					 			window.open('/290905/'+_param.pk+"&"+_tr.data('PARTNER_NO'), "printName", "width=1000, height=800, scrolbars=yes");
							}

						});
						
						_tr.append('<td class="r">'+$.pb.targetMoney(this.ORDER_PRICE)+'</td>');
						_tr.append('<td class="r">'+$.pb.targetMoney(this.TAKE_BACK_PRICE)+'</td>');
						_tr.append('<td class="r">'+$.pb.targetMoney(this.TOTAL_PRICE)+'</td>');

						_totalPrice += this.TOTAL_PRICE
						_cashPrice += this.CASH_PRICE;
						_cardPrice += this.CARD_PRICE;
						_realTotalPrice += this.REAL_TOTAL_PRICE;
						
// 						_tr.append('<td class="r">'+$.pb.targetMoney(this.CASH_PRICE)+'</td>');
// 						_tr.append('<td class="r">'+$.pb.targetMoney(this.CARD_PRICE)+'</td>');
// 						_tr.append('<td class="r">'+$.pb.targetMoney(this.REAL_TOTAL_PRICE)+'</td>');
// 						_tr.append('<td><button type="button" class="btn-pay">�����ϱ�</button></td>');
// 						_tr.find('.btn-pay').on('click', function(){
// 							$('.pb-right-popup-wrap').openLayerPopup({}, function(_thisLayer) {
// 								$('.pb-right-popup-wrap .pb-popup-title').text("����");
// 								$('.pb-right-popup-wrap .popup-body-top .top-title').text("��������");
// 								$('.pb-right-popup-wrap .pay-box').show();
// 								$('.pb-right-popup-wrap .receipt-box').hide();
// 								$('.pay-box .partner').val(_tr.data('PARTNER_NAME')+(_tr.data('BUS_NO') ? "("+$.pb.busNoFomatter(_tr.data('BUS_NO'))+")" : ''));
// 								$('.pay-box .total-price').val($.pb.targetMoney(_tr.data('TOTAL_PRICE')));
// 								$('.pay-box .remaining-price').val($.pb.targetMoney(_tr.data('REAL_TOTAL_PRICE')));
// 								$('.pay-box .discount-remaining-price').val($.pb.targetMoney(_tr.data('REAL_TOTAL_PRICE')));
// 								$('.pay-box .pay-flag').removeClass('ac');
// 								$('.pay-box .discount-price').val(0);
// 								$('.pay-box .pay-price').val(0);
// 								$('.pay-remarks').val("");
// 								$('.pay-box .btn-pay').data(_tr.data());
								
// 								$('.pay-box .pay-flag').on('click', function(){
// 									$(this).addClass('ac').siblings('.pay-flag').removeClass('ac');
// 								});
// 								var _data = _tr.data();
								
// 								$('.pay-box .discount-price').on('focusin', function(){
// 			 						$('.pay-price').val(0);
// 			 						$('.discount-remaining-price').val($.pb.targetMoney(_data.REAL_TOTAL_PRICE));
// 			 					});
// 			 					$('.pay-box .discount-price').on('keyup', function(){
// 			 						if($(this).val().length == 0){
// 			 							$('.pay-price').val($.pb.targetMoney(_data.REAL_TOTAL_PRICE));
// 			 							$('.discount-remaining-price').val($.pb.targetMoney(_data.REAL_TOTAL_PRICE));
// 			 						}else{
// 			 							$('.discount-remaining-price').val($.pb.targetMoney(_data.REAL_TOTAL_PRICE - $(this).val().replace(/,/gi, '')));
// 			 							$('.pay-price').val($.pb.targetMoney(_data.REAL_TOTAL_PRICE - $(this).val().replace(/,/gi, '')));
// 			 	 						$('.pay-price').keyup();	
// 			 						}
// 			 					});
// 								$('.pay-box .discount-price').on('focusout', function(){
// 									if($(this).val().length < 1) $(this).val(0);
// 								});
// 								$('.pay-box .pay-price').on('focusout', function(){
// 									if($(this).val().length < 1) $(this).val(0);
// 								});
// 								layerInit(_thisLayer);
// 							});
// 						});
// 						_tr.append('<td><button type="button" class="btn-receipt">�����ϱ�</button></td>');
// 						_tr.find('.btn-receipt').on('click', function(){
// 							$('.pb-right-popup-wrap').openLayerPopup({}, function(_thisLayer) {
// 								$('.pb-right-popup-wrap .pb-popup-title').text("���ݿ�����");
// 								$('.pb-right-popup-wrap .popup-body-top .top-title').text("����з�");
// 								$('.receipt-remarks').val("");
// 								$('.pb-right-popup-wrap .pay-box').hide();
// 								$('.pb-right-popup-wrap .receipt-box').show();
// 								$('.receipt-box .partner').val(_tr.data('PARTNER_NAME')+(_tr.data('BUS_NO') ? "("+$.pb.busNoFomatter(_tr.data('BUS_NO'))+")" : ''));
// 								$('.receipt-box .receipt-flag').on('click', function(){
// 									$(this).addClass('ac').siblings('.receipt-flag').removeClass('ac');
// 									if($('.receipt-flag.ac').data('value') == "03") $('.receipt-box .issue-no').val("0100001234").attr('disabled', true);
// 									else $('.receipt-box .issue-no').val("").attr('disabled', false);
// 								});
// 								$('.receipt-box .btn-receipt').data(_tr.data());
// 								$('.receipt-box .receipt-flag').removeClass('ac');
// 								$('.receipt-box .issue-no').val("").attr('disabled', false);
// 								$('.receipt-box .receipt-price').val(0);
// 								layerInit(_thisLayer);
// 							});
// 						});
						
						$('.company-price-table tbody').append(_tr);
					});
					
					$('.company-price-table tbody tr:eq(0)').append('<td rowspan='+data.partnerCalculateList.length+' class="r">'+$.pb.targetMoney(_cashPrice)+'</td>');
					$('.company-price-table tbody tr:eq(0)').append('<td rowspan='+data.partnerCalculateList.length+' class="r">'+$.pb.targetMoney(_cardPrice)+'</td>');
					$('.company-price-table tbody tr:eq(0)').append('<td rowspan='+data.partnerCalculateList.length+' class="r">'+$.pb.targetMoney(_realTotalPrice)+'</td>');
					$('.company-price-table tbody tr:eq(0)').append('<td rowspan='+data.partnerCalculateList.length+'><button type="button" class="btn-pay">�����ϱ�</button></td>');
					$('.company-price-table tbody tr:eq(0)').find('.btn-pay').on('click', function() { 
						var _data = $('.company-price-table tbody tr:eq(0)').data();
						$('.pb-right-popup-wrap.cal').openLayerPopup({}, function(_thisLayer) {
							$('body').css('overflow', 'hidden');
							$('.pb-right-popup-wrap.cal .pb-popup-title').text("����");
							$('.pb-right-popup-wrap.cal .popup-body-top .top-title').text("��������");
							$('.pb-right-popup-wrap.cal .pay-box').show();
							$('.pb-right-popup-wrap.cal .receipt-box').hide();
// 							$('.pay-box .partner').val(_tr.data('PARTNER_NAME')+(_tr.data('BUS_NO') ? "("+$.pb.busNoFomatter(_tr.data('BUS_NO'))+")" : ''));
							$('.pay-box .total-price').val($.pb.targetMoney(_totalPrice));
							$('.pay-box .remaining-price').val($.pb.targetMoney(_realTotalPrice));
							$('.pay-box .discount-remaining-price').val($.pb.targetMoney(_realTotalPrice));
							$('.pay-box .pay-flag').removeClass('ac');
							$('.pay-box .discount-price').val(0);
							
							//20220318 �ּ�
							//$('.pay-box .pay-price').val(0);
							$('.pay-box .pay-price').val($.pb.targetMoney(_realTotalPrice));
							$('.pay-remarks').val("");
							$('.pay-box .btn-pay').data(_data);
						
							$('.pay-box .pay-flag').on('click', function(){
								$(this).addClass('ac').siblings('.pay-flag').removeClass('ac');
							});
							
							$('.pay-box .discount-price').on('focusin', function(){
		 						//20220318 �ּ�ó��
								//$('.pay-price').val(0);
		 						$('.discount-remaining-price').val($.pb.targetMoney(_realTotalPrice));
		 					});
		 					$('.pay-box .discount-price').on('keyup', function(){
		 						if($(this).val().length == 0){
		 							$('.pay-price').val($.pb.targetMoney(_realTotalPrice));
		 							$('.discount-remaining-price').val($.pb.targetMoney(_realTotalPrice));
		 						}else{
		 							$('.discount-remaining-price').val($.pb.targetMoney(_realTotalPrice - $(this).val().replace(/,/gi, '')));
		 							$('.pay-price').val($.pb.targetMoney(_realTotalPrice - $(this).val().replace(/,/gi, '')));
		 	 						$('.pay-price').keyup();	
		 						}
		 					});
							$('.pay-box .discount-price').on('focusout', function(){
								if($(this).val().length < 1) $(this).val(0);
							});
							$('.pay-box .pay-price').on('focusout', function(){
								if($(this).val().length < 1) $(this).val(0);
							});
							layerInit(_thisLayer);
						});
					});
	
					$('.company-price-table tbody tr:eq(0)').append('<td rowspan='+data.partnerCalculateList.length+'><button type="button" class="btn-receipt">�����ϱ�</button></td>');
					$('.company-price-table tbody tr:eq(0)').find('.btn-receipt').on('click', function() { 
						var _data = $('.company-price-table tbody tr:eq(0)').data();
						$('.pb-right-popup-wrap.cal').openLayerPopup({}, function(_thisLayer) {
							$('body').css('overflow', 'hidden');
							$('.pb-right-popup-wrap.cal .pb-popup-title').text("���ݿ�����");
							$('.pb-right-popup-wrap.cal .popup-body-top .top-title').text("����з�");
							$('.receipt-remarks').val("");
							$('.pb-right-popup-wrap.cal .pay-box').hide();
							$('.pb-right-popup-wrap.cal .receipt-box').show();
							$('.receipt-box .partner').val(_data.PARTNER_NAME+(_data.BUS_NO ? "("+$.pb.busNoFomatter(_data.BUS_NO)+")" : ''));
							$('.receipt-box .receipt-flag').on('click', function(){
								$(this).addClass('ac').siblings('.receipt-flag').removeClass('ac');
								if($('.receipt-flag.ac').data('value') == "03") $('.receipt-box .issue-no').val("0100001234").attr('disabled', true);
								else $('.receipt-box .issue-no').val("").attr('disabled', false);
							});
							$('.receipt-box .btn-receipt').data(_data);
							$('.receipt-box .receipt-flag').removeClass('ac');
							$('.receipt-box .issue-no').val("").attr('disabled', false);
							$('.receipt-box .receipt-price').val(0);
							layerInit(_thisLayer);
						});
					});
	
	
				};changeDiscount();
				
				$.each(data.calculateHistoryList, function(idx) {
					var _tr = $('<tr>');
					_tr.data(this);
					_tr.append('<td>'+(this.UPDATE_DT ? this.UPDATE_DT : this.CREATE_DT)+'</td>');
					_tr.append('<td>'+this.PARTNER_NAME+'</td>');
					_tr.append('<td>'+this.PAY_FLAG_NAME+'</td>');
					_tr.append('<td class="r">'+$.pb.targetMoney(this.PAY_PRICE)+'</td>');
					_tr.append('<td class="r">'+$.pb.targetMoney(this.DISCOUNT_PRICE)+'</td>');
					_tr.append('<td class="r">'+$.pb.targetMoney(this.REAL_PAY_PRICE)+'</td>');
					_tr.append('<td>'+(this.REMARKS ? this.REMARKS : '-')+'</td>');
					_tr.append('<td>'+(this.PAY_FLAG != 3 ? '<button type="button" class="btn-pay-cancel">�������</button>' : '-')+'</td>');
					_tr.find('.btn-pay-cancel').on('click', function() {
						var _formData = new FormData();
 						_formData.append('calculateNo', _tr.data('CALCULATE_NO'));
 						_formData.append('payFlag', _tr.data('PAY_FLAG'));
 						_formData.append('updateUserNo', '${sessionScope.loginProcess.USER_NO}');
 						
						//ī��
						if(_tr.data('PAY_FLAG') == 1){
							$('form[name=payForm] > object').remove();
							var _payObj = $('<object>');
							_payObj.attr('classid', 'CLSID:C74CC3D6-6C88-4F02-8636-3A54928EDDD8');
							_payObj.attr('codebase', '/resources/js/PosToCatReq.ocx#version=2,0,0,3');
							_payObj.attr('id', 'm_PosToCat');
							_payObj.attr('width', '0');
							_payObj.attr('height', '0');
							_payObj.attr('idborder', '0');
							$('form[name=payForm]').append(_payObj);
							if(confirm("�ſ�ī�� ���� ��Ҹ� �����ϰڽ��ϴ�.")) {
								console.log("11111111")
								$('.ajax-loading').show();
								var result = cancelCard(_tr.data('quota'), _tr.data('amount'), _tr.data('appNo'), _tr.data('appDate'), _tr.data('catId'));
								if(result){
									_formData.append('result', result);
									$.pb.ajaxUploadForm('/adminSec/updateCalCulate.do', _formData, function(result) {
					 					if(result == "1") {
					 						createTable();
					 						$('.ajax-loading').hide();
					 						$('.pb-popup-close').click();
					 					} else alert(decodeURIComponent(result));
					 				}, '${sessionScope.loginProcess}');
								}
							}else $('form[name=payForm] > object').remove();
						}else{ //����
							if(confirm("���� ���� ��Ҹ� �����ϰڽ��ϴ�.")){
								$.pb.ajaxUploadForm('/adminSec/updateCalCulate.do', _formData, function(result) {
		 							createTable();
		 						}, '${sessionScope.loginProcess}');	
							}
						}
					});
					$('.calculate-history-table tbody').append(_tr);
				});
				
				$.each(data.receiptHistoryList, function(idx) {
					var _tr = $('<tr>');
					_tr.data(this);
					_tr.append('<td>'+(this.UPDATE_DT ? this.UPDATE_DT : this.CREATE_DT)+'</td>');
					_tr.append('<td>'+this.PARTNER_NAME+'</td>');
					_tr.append('<td>'+this.ISSUE_NO+'</td>');
					_tr.append('<td class="r">'+$.pb.targetMoney(this.RECEIPT_PRICE)+'</td>');
					_tr.append('<td>'+(this.REMARKS ? this.REMARKS : '-')+'</td>');
					_tr.append('<td>'+(this.FLAG != 2 ? '<button type="button" class="btn-receipt-cancel">�������</button>' : '-')+'</td>');
					_tr.find('.btn-receipt-cancel').on('click', function() {
						var _formData = new FormData();
 						_formData.append('receiptNo', _tr.data('RECEIPT_NO'));
 						_formData.append('updateUserNo', '${sessionScope.loginProcess.USER_NO}');
 						
						$('form[name=payForm] > object').remove();
						var _payObj = $('<object>');
						_payObj.attr('classid', 'CLSID:C74CC3D6-6C88-4F02-8636-3A54928EDDD8');
						_payObj.attr('codebase', '/resources/js/PosToCatReq.ocx#version=2,0,0,3');
						_payObj.attr('id', 'm_PosToCat');
						_payObj.attr('width', '0');
						_payObj.attr('height', '0');
						_payObj.attr('idborder', '0');
						$('form[name=payForm]').append(_payObj);
						if(confirm("���ݿ����� ���� ��Ҹ� �����ϰڽ��ϴ�.")) {
							$('.ajax-loading').show();
							var result = cancelReceipt(_tr.data('type'), _tr.data('ISSUE_NO'), _tr.data('amount'), _tr.data('appDate'), _tr.data('appNo'), _tr.data('catId'));
							if(result){
								_formData.append('result', result);
								$.pb.ajaxUploadForm('/adminSec/updateReceipt.do', _formData, function(result) {
				 					if(result == "1") {
				 						createTable();
										$('.ajax-loading').hide();
				 						$('.pb-popup-close').click();
				 					} else alert(decodeURIComponent(result));
				 				}, '${sessionScope.loginProcess}');
							}
						}else $('form[name=payForm] > object').remove();
					});
					$('.receipt-history-table tbody').append(_tr);
				});
			});
		};createTable();
		
		$('.pb-popup-close, .popup-mask').on('click', function() {
			$('body').css('overflow', 'auto');
			closeLayerPopup();
		});
		
		// �����ϱ� ���
		$('.div-pay .btn-pay').on('click', function(){
								
			var agent = navigator.userAgent.toLowerCase();
			if((navigator.appName == 'Netscape' && agent.indexOf('trident') == -1) && (agent.indexOf("msie") == -1)) return alert("���ͳ��ͽ��÷η� �������� ������ �ּ���.");
			
			if(!$('.pay-box .pay-flag.ac').data('value')) return alert("���������� ������ �ּ���.");
			if(!$('.pay-box .pay-price').val()) return alert("�����ݾ��� �Է��� �ּ���.");
			if($('.discount-remaining-price').val().replace(/,/gi, '')*1 < $('.pay-price').val().replace(/,/gi, '')*1) return alert("�����ݾ��� ���� �� �ݾ׺��� Ŭ �� �����ϴ�.");
				
			var _formData = new FormData();
			_formData.append('eventNo', _param.pk);
			_formData.append('partnerNo', $(this).data('PARTNER_NO'));
			_formData.append('discountPrice', $('.pay-box .discount-price').val().replace(/,/gi, ''));
			_formData.append('payPrice', $('.pay-box .pay-price').val().replace(/,/gi, ''));
			_formData.append('payFlag', $('.pay-box .pay-flag.ac').data('value'));
			_formData.append('remarks', $('.pay-box .pay-remarks').val());
			_formData.append('createUserNo', '${sessionScope.loginProcess.USER_NO}');
			if($('.pay-box .pay-flag.ac').data('value') == 1){ // ī�����
				$('form[name=payForm] > object').remove();
				var _payObj = $('<object>');
				_payObj.attr('classid', 'CLSID:C74CC3D6-6C88-4F02-8636-3A54928EDDD8');
				_payObj.attr('codebase', '/resources/js/PosToCatReq.ocx#version=2,0,0,3');
				_payObj.attr('id', 'm_PosToCat');
				_payObj.attr('width', '0');
				_payObj.attr('height', '0');
				_payObj.attr('idborder', '0');
				$('form[name=payForm]').append(_payObj);
				if(confirm("�ſ�ī�� ������ �����ϰڽ��ϴ�.")) {
					$('.ajax-loading').show();
					var result = reqcard(1, $('.pay-box .pay-price').val().replace(/,/gi, ''), 00, $(this).data('NICE_CAT_ID'));
					if(result){
						_formData.append('result', result);
						$.pb.ajaxUploadForm('/adminSec/insertCalCulate.do', _formData, function(result) {
		 					if(result == "1") {
		 						createTable();
								$('.ajax-loading').hide();
		 						$('.pb-popup-close').click();
		 					} else alert(decodeURIComponent(result));
		 				}, '${sessionScope.loginProcess}');
					}
				}else $('form[name=payForm] > object').remove();
			}else{ //���ݰ���
				if(confirm("���� ������ �����ϰڽ��ϴ�.")){
					$.pb.ajaxUploadForm('/adminSec/insertCalCulate.do', _formData, function(result) {
						if(result != 0) {
							createTable();
							$('.pb-popup-close').click();
						} else alert('���� ���� �����ڿ��� �����ϼ���');
					}, '${sessionScope.loginProcess}');
				}
			}
		});
		
		// ���ݿ����� ���
		$('.div-receipt .btn-receipt').on('click', function(){
			var agent = navigator.userAgent.toLowerCase();
			if((navigator.appName == 'Netscape' && agent.indexOf('trident') == -1) && (agent.indexOf("msie") == -1)) return alert("���ͳ��ͽ��÷η� �������� ������ �ּ���.");
			
			if(!$('.receipt-box .receipt-flag.ac').data('value')) return alert("����з��� ������ �ּ���.");
			if(!$('.receipt-box .issue-no').val()) return alert("�����ȣ�� �Է��� �ּ���.");
			if(!$('.receipt-box .receipt-price').val()) return alert("����ݾ��� �Է��� �ּ���.");
			var _formData = new FormData();
			_formData.append('eventNo', _param.pk);
			_formData.append('partnerNo', $(this).data('PARTNER_NO'));
			_formData.append('issueNo', $('.receipt-box .issue-no').val().replace(/,/gi, ''));
			_formData.append('receiptPrice', $('.receipt-box .receipt-price').val().replace(/,/gi, ''));
			_formData.append('remarks', $('.receipt-box .receipt-remarks').val());
			_formData.append('createUserNo', '${sessionScope.loginProcess.USER_NO}');
			
			$('form[name=payForm] > object').remove();
			var _payObj = $('<object>');
			_payObj.attr('classid', 'CLSID:C74CC3D6-6C88-4F02-8636-3A54928EDDD8');
			_payObj.attr('codebase', '/resources/js/PosToCatReq.ocx#version=2,0,0,3');
			_payObj.attr('id', 'm_PosToCat');
			_payObj.attr('width', '0');
			_payObj.attr('height', '0');
			_payObj.attr('idborder', '0');
			$('form[name=payForm]').append(_payObj);
			if(confirm("���ݿ����� ������ �����ϰڽ��ϴ�.")){
				$('.ajax-loading').show();
	 			var result = taxPoint($('.receipt-box .receipt-flag').data('value'), $('.receipt-box .issue-no').val(), $('.receipt-box .receipt-price').val().replace(/,/gi, ''), $(this).data('NICE_CAT_ID'));
				if(result){
					_formData.append('result', result);
					$.pb.ajaxUploadForm('/adminSec/insertReceipt.do', _formData, function(result) {
	 					if(result == "1") {
	 						createTable();
							$('.ajax-loading').hide();
	 						$('.pb-popup-close').click();
	 					} else alert(decodeURIComponent(result));
	 				}, '${sessionScope.loginProcess}');
				}
			}else $('form[name=payForm] > object').remove();

		});
		
		//ī������� �Լ�
		var FS = "\x1C";
		var	STX = "\x02";
		var	ETX = "\x03";
		function reqcard(cat_port, goods_amt, quota_interest, catId) { //�ſ���� ��û
			// catid ���߻���ڽÿ� �ʿ�
			var _result = "";
// 			var s_buf = "D1" + FS + FS + FS + quota_interest + FS + FS + FS + goods_amt + FS + FS + FS + "DJ"+ catId + FS + FS;
			var s_buf = "D1" + FS + FS + FS + quota_interest + FS + FS + FS + goods_amt + FS + FS + FS + FS + FS;
			ret = self.document.payForm.m_PosToCat.ReqToCat(cat_port, 9600, s_buf); //��Ʈ, ��żӵ�, ������
			if(ret == 1) {
				_result = self.document.payForm.m_PosToCat.GetData();
// 				alert("���䵥���� : " + self.document.payForm.m_PosToCat.GetData());
			}else if(ret == -2) reqcard(cat_port, goods_amt, quota_interest);
			$('form[name=payForm] > object').remove();
			$('.ajax-loading').hide();
			return _result;
		}

		//���ݿ�����
		function taxPoint(flag, issueNo, amt, catId) {
			var _result = "";
			var s_buf = "D3" + FS + flag + FS  + "@" + FS + issueNo + FS + FS + FS + amt + FS + FS + FS + FS + "DJ" + catId + FS;
// 			var s_buf = "D3" + FS + flag + FS  + "@" + FS + issueNo + FS + FS + FS + amt + FS + FS + FS + FS + FS;
			ret = self.document.payForm.m_PosToCat.ReqToCat(1, 9600, s_buf); //��Ʈ, ��żӵ�, ������
			if(ret == 1)  {
				_result = self.document.payForm.m_PosToCat.GetData();
// 				alert("���䵥���� : " + self.document.payForm.m_PosToCat.GetData());
			} else  {
				// ���ݿ������� �ܸ��⿡�� �����ư ���� �ٷ� ���� �Ǿ ��û���н� ���û
				if(ret == -2) taxPoint(issue_no, amt);
			}
			$('form[name=payForm] > object').remove();
			$('.ajax-loading').hide();
			return _result;
		}
		
		
		//�ſ�ī�� ���� ���
		function cancelCard(quota, amount, appNo, appDate, catId) {
			var _result = "";
// 			var s_buf = "D2" + FS + FS + FS + quota + FS + FS + FS + amount + FS + appNo + FS + appDate + FS +"DJ"+ catId + FS + FS;
			var s_buf = "D2" + FS + FS + FS + quota + FS + FS + FS + amount + FS + appNo + FS + appDate + FS + catId + FS + FS;
			ret = self.document.payForm.m_PosToCat.ReqToCat(1, 9600, s_buf); //��Ʈ, ��żӵ�, ������
			
			console.log(ret)
			if(ret == 1) _result = self.document.payForm.m_PosToCat.GetData();
			else if(ret == -2) ret = self.document.payForm.m_PosToCat.ReqToCat(1, 9600, s_buf); //��Ʈ, ��żӵ�, ������
			$('form[name=payForm] > object').remove();
			$('.ajax-loading').hide();
			return _result;
		}

		//���ݿ����� ���
		function cancelReceipt(type, issueNo, amount, appDate, appNo, catId) {
			var _result = "";
// 			var s_buf = "D4" + FS + type + FS + "@" + FS + issueNo + FS + FS + FS + amount + FS + "1" + FS + appDate + FS + appNo + FS + "DJ" + catId + FS;
			var s_buf = "D4" + FS + type + FS + "@" + FS + issueNo + FS + FS + FS + amount + FS + "1" + FS + appDate + FS + appNo + FS + FS;
			ret = self.document.payForm.m_PosToCat.ReqToCat(1, 9600, s_buf); //��Ʈ, ��żӵ�, ������
			if(ret == 1) _result = self.document.payForm.m_PosToCat.GetData();
			else if(ret == -2) ret = self.document.payForm.m_PosToCat.ReqToCat(1, 9600, s_buf); //��Ʈ, ��żӵ�, ������
			$('form[name=payForm] > object').remove();
			$('.ajax-loading').hide();
			return _result;
		}
	});
</script>
<style>
	.pb-right-popup-wrap > .pb-popup-body { height: calc(100vh - 96px); }
    
	.contents-body-wrap .event-info-box { box-sizing:border-box; position:relative; }
	.popup-table tbody .blue { background:#a7e3fd; }
	.popup-table tbody .orange { background:#fdce0c; }
	.pb-table.order-list-table > tbody > tr:nth-child(2n) { background: #f0f0f0; }
	.pb-table.order-list-table > tbody > tr:hover { background: #ffeda0; }
	.pb-table.order-list-table td { padding: 8px 5px; color: #333333; font-size: 16px; font-weight: 500; letter-spacing: 0.8px; text-align: center; }
</style>
<div class="pb-right-popup-wrap order">
	<div class="pb-popup-title">�ֹ��� ���� POP</div>
	<span class="pb-popup-close"></span>
	<div class="pb-popup-body">
		<table class="pb-table list order-list-table">
			<colgroup>
				<col width="8%"/>
				<col width="29%"/>
				<col width="8%"/>
				<col width="8%"/>
				<col width="15%"/>
				<col width="15%"/>
				<col width="25%"/>
			</colgroup>
			<thead>
				<tr>
					<th>����</th>
					<th>�ֹ�/��ǰ ǰ��</th>
					<th>����</th>
					<th>����</th>
					<th>�ܰ�</th>
					<th>�ֹ�</th>
					<th>�ֹ��Ͻ�</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
	</div>
</div>
	
<div class="pb-right-popup-wrap cal">
	<div class="pb-popup-title">����</div>
	<span class="pb-popup-close"></span>
	<div class="pb-popup-body" style="height:auto;">
		<div class="popup-body-top">
			<div class="top-title">��������</div>
			<div class="top-button-wrap">
				<button type="button" class="top-button pb-popup-close">�ݱ�</button>
			</div>
		</div>
		
		<div class="pay-box">
			<div class="div-pay">
				<div class="pay-flag" data-value="1">ī��</div>
				<div class="pay-flag" data-value="2">����</div>
			</div>
			<div class="top-title">�����ݾ�</div>
			<div class="div-pay">
				<div class="text">���� �����</div>
				<input type="text" class="form-text price partner" style="text-align:center;" disabled>
			</div>
			<div class="div-pay">
				<div class="text">�ѱݾ�</div>
				<input type="text" class="form-text price total-price" disabled>
			</div>
			<div class="div-pay">
				<div class="text">�������� �ݾ�</div>
				<input type="text" class="form-text price remaining-price" disabled>
			</div>
			<div class="div-pay">
				<div class="text">���� �ݾ�(�����Է�)</div>
				<input type="text" class="form-text price discount-price" maxlength="12">
			</div>
			<div class="div-pay">
				<div class="text">���� �� �ݾ�</div>
				<input type="text" class="form-text price discount-remaining-price" disabled>
			</div>
			<div class="div-pay">
				<div class="text">������ �ݾ�(�����Է�)</div>
				<input type="text" class="form-text price pay-price" maxlength="12">
			</div>
			<div class="div-pay">
				<div class="text">���</div>
				<input type="text" class="form-text price pay-remarks" style="text-align:left;">
			</div>
			<div class="top-title">�����ϱ�</div>
			<div class="div-pay">
				<button type="button" class="btn-pay">�����ϱ�</button>
			</div>
		</div>
		
		<div class="receipt-box" style="display:none;">
			<div class="div-receipt">
				<div class="text" style="width:39.5%;">���� �з�</div>
				<div style="display:flex; justify-content:space-between; width:59.5%;">
					<div class="receipt-flag" data-value="01">���μҵ����</div>
					<div class="receipt-flag" data-value="02">����� ��������</div>
					<div class="receipt-flag" data-value="03">�����߱�</div>
				</div>
			</div>
			
			<div class="div-receipt">
				<div class="text" style="width:39.5%;">���� �����</div>
				<input type="text" class="form-text price partner" style="text-align:center; width:59.5%;" disabled>
			</div>
			<div class="top-title">���� �����ô� ��</div>
			<div class="div-receipt">
				<div class="text">���� ��ȣ</div>
				<input type="text" class="form-text price issue-no" onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" placeholder="�ֹ�(�����, �ڵ���)��ȣ �Է�">
			</div>
			<div class="div-receipt">
				<div class="text">���� �ݾ�</div>
				<input type="text" class="form-text price receipt-price">
			</div>
			<div class="div-receipt">
				<div class="text">���</div>
				<input type="text" class="form-text price receipt-remarks" style="text-align:left;">
				
				
			</div>
			<div class="top-title">�����ϱ�</div>
			<div class="div-receipt">
				<button type="button" class="btn-receipt">���ݿ����� ����</button>
			</div>
		</div>
	</div>	
</div>

<div class="event-info-box or">
	<div class="box-title">�ֹ�����
<!-- 		<div style="position:absolute; right:399px; background:linear-gradient(to bottom, #FFFFFF, #EBEDEE); top:29px; padding:6px 25px; border:1px solid #707070; font-size:16px; z-index:1">��������</div> -->
<!-- 		<select class="form-select discount" style="width:400px; position:absolute; right:0; height:38px; font-size:16px; font-weight:500; padding:0px 5px;"></select> -->
	</div>
	
	<div class="company-price-box">
		<table class="company-price-table">
			<colgroup>
				<col width="*"/>
				<col width="6%"/>
				<col width="6%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="8%"/>
				<col width="8%"/>
			</colgroup>
			<thead>
				<tr>
					<td>�����</td>
					
					<td>��볻����</td>
					<td>��ǰ������</td>
					
					<td>�� �ֹ��ݾ�</td>
					<td>�� ��ǰ�ݾ�</td>
					<td>�ѱݾ�</td>
					<td>���ݰ���</td>
					<td>ī�����</td>
					<td>�������� �ݾ�</td>
					<td>����/ī��</td>
					<td>���ݿ�����</td>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
	</div>
</div>

<div class="event-info-box or">
	<div class="box-title">�����̷�</div>
	<div class="calculate-history-box">
		<table class="calculate-history-table">
			<colgroup>
				<col width="10%"/>
				<col width="15%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="20%"/>
				<col width="15%"/>
			</colgroup>
			<thead>
				<tr><td>�����Ͻ�</td><td>�����</td><td>��������</td><td>�����ݾ�</td><td>���αݾ�</td><td>���������ݾ�</td><td>���</td><td>�������</td></tr>
			</thead>
			<tbody>
			</tbody>
		</table>
	</div>
</div>

<div class="event-info-box or">
	<div class="box-title">���ݿ����� �̷�</div>
	<div class="receipt-history-box">
		<table class="receipt-history-table">
			<colgroup>
				<col width="10%"/>
				<col width="15%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="15%"/>
				<col width="10%"/>
			</colgroup>
			<thead>
				<tr><td>�����Ͻ�</td><td>�����</td><td>�����ȣ</td><td>����ݾ�</td><td>���</td><td>�������</td></tr>
			</thead>
			<tbody>
			</tbody>
		</table>
	</div>
</div>

<form name="payForm" method="POST" action="/view/CATPayResult">
	<input type="hidden" name="resultData" value="">
	<input type="hidden" name="catComPort" value="1"/>
	<input type="hidden" name="reserved1" value="">
	<input type="hidden" name="reserved2" value="">
</form>
