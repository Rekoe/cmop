<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/layouts/taglib.jsp"%>

<html>
<head>

	<title>服务申请</title>

	<script>
		$(document).ready(function() {
			
			$("ul#navbar li#apply").addClass("active");
		
			$("input[name=osBit2]:first").attr('disabled','');	//Windows2008R2 没有32bit,只有64bit		
			
			$("#inputForm").validate();
			
			//注意该变量是全局变量!!!
			var esgHTML;
			/* ajax获得esgList*/ 
			$.ajax({
				type: "GET",
				url: "${ctx}/ajax/getEsgList",
				dataType: "json",
				success: function(data) {
					for (var i = 0; i < data.length; i++) {
						esgHTML += '<option value="' + data[i].id + '">' + data[i].identifier+'('+data[i].description+')' + '</option>';
					}
				}
			});
			
			
			/*点击选择规格时,将选中的操作系统,位数等保存在临时隐藏域中..*/
			$(".serverTypeBtn").click(function() {
				var $parent = $(this).parent().parent();
				var osId = $parent.find("#osId").val(); //操作系统ID
				var osNAME = $parent.find("span.osName").text(); //操作系统名
				var osBitId = $parent.find("input[name='osBit" + osId + "']:checked").val(); //选中的位数Id
				var osBitText = $.trim($parent.find("input[name='osBit" + osId + "']:checked").parent().find("span.radioText").text()); //选中的位数文本.
				//装入临时隐藏域
				$("#osIdTmp").val(osId);
				$("#osNameTmp").val(osNAME);
				$("#bitValueTemp").val(osBitId);
				$("#bitTextTmp").val(osBitText);
			});
			
			
			 /*点击弹出窗口保存时.*/
			$("#modalSave").click(function() {
				
				$("input[id^='inputCount']").each(function() { 
					
					var $this = $(this);
					
					var nCount = $this.val();//数量输入框值
					
					//数量输入框不为空时
					if (nCount != "") {
						
						//输入框的ID是有字符串"inputCount"+规格ID组成的. 所以获得字符串"inputCount"的长度,用于截取规格的ID
						var nLen = "inputCount".length;
						var serverTypeId = this.id.substring(nLen);
						var serverTypeText = $.trim($this.parent().parent().find("td:first").text()); //规格名
						
						//从隐藏域中取出之前选择的操作系统和位数.
						var osId = $("#osIdTmp").val();
						var osNAME = $("#osNameTmp").val();
						var osBitId = $("#bitValueTemp").val();
						var osBitText = $("#bitTextTmp").val();
						var instanceCount = $("#resourcesDIV div.resources").size();//页面已生成的实例个数.
						
						for (var i = 0; i < nCount; i++) {
							
							//获得页面已有的alert数量,再加上i.用于区别不同的remark,以便检验.
							var loopId = instanceCount+ i; 
							var html = '<div class="resources alert alert-block alert-info fade in">';
							html += '<button type="button" class="close" data-dismiss="alert">×</button>';
							html += '<dd><em>基本信息</em>&nbsp;&nbsp;<strong>' + osNAME + ' &nbsp;' + osBitText + '</strong></dd>';
							html += '<dd><em>规格</em>&nbsp;&nbsp;<strong>' + serverTypeText + '</strong></dd>';
							html += '<dd><em>用途信息</em>&nbsp;&nbsp;<input type="text" placeholder="...用途信息" maxlength="45" class="required" name="remarks" id="remarks' + loopId + '"></dd>';
							html += '<dd><em>关联ESG</em>&nbsp;&nbsp;<select id="esgIds'+loopId+'" multiple class=" multipleESG">' + esgHTML + '</select></dd>';
							html += '<input type="hidden" name="esgIds">';
							html += '<input type="hidden" name="osTypes" value="' + osId + '">';
							html += '<input type="hidden" name="osBits" value="' + osBitId + '">';
							html += '<input type="hidden" name="serverTypes" value="' + serverTypeId + '">';
							html += '</div>';
							
							$("#resourcesDIV dl").append(html);
						}
						
						//初始化select2插件
						$("select.multipleESG").select2();
						
						//为每个select.multipleESG元素绑定一个事件:每次变更select中的值,最近的隐藏域值也改变.
						$("select.multipleESG").on("change",function(){
							$(this).parent().parent().find("input[name='esgIds']").val($(this).val());
						});
						
					}
					
					$this.val('');//清空数量框
					
				});
			});
			 
			
			
		});
		
		
		
	</script>
	
</head>

<body>

	<style>body{background-color: #f5f5f5;}</style>

	<form id="inputForm" action="." method="post" class="input-form form-horizontal">
		
		<input type="hidden" id="computeType" name="computeType" value="${computeType}">
		
		<!-- 临时隐藏域 -->
		<input type="hidden" id="osIdTmp">
		<input type="hidden" id="osNameTmp">
		<input type="hidden" id="bitValueTemp">
		<input type="hidden" id="bitTextTmp">
		
		<fieldset>
			<legend><small>
				<c:choose>
					<c:when test="${computeType == 1 }">创建实例PCS</c:when>
					<c:otherwise>创建实例ECS</c:otherwise>
				</c:choose>
			</small></legend>
			
			<div class="control-group">
				<label class="control-label" for="applyId">所属服务申请</label>
				<div class="controls">
					<select id="applyId" name="applyId" class="required">
						<c:forEach var="item" items="${baseStationApplys}">
							<option value="${item.id }">${item.title} ( ${item.description} )</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			<hr>
			
			<c:forEach var="map" items="${osTypeMap}">
				
				 <div class="row-fluid" style="margin-top: 10px;margin-bottom: 10px">
					
					<!-- 位数Id -->
					<input type="hidden" id="osId" value="${map.key}">
					
					<!-- Logo -->
					<div class="span3">
				 		<c:choose>
							<c:when test="${map.key == 1 || map.key ==2 || map.key ==5 }">
								<img alt="windowsOS" src="${ctx}/static/common/img/logo/windows-logo.png" />
							</c:when>
							<c:otherwise>
								<img alt="windowsOS" src="${ctx}/static/common/img/logo/centos-logo.png" />
							</c:otherwise>
						</c:choose>
					</div>
					 
					<!-- 操作系统名 -->
					<div class="span4"><h4><span class="osName">${map.value}</span></h4></div>
					
					<!-- 操作系统位数 -->
					<div class="span2">
						<c:forEach var="osBitMap" items="${osBitMap}">
							<label class="radio"> 
								<input type="radio" value="${osBitMap.key}" name="osBit${map.key }" <c:if test="${osBitMap.key == 2 }">checked="checked"</c:if> 
									><span class="radioText"><c:out value="${osBitMap.value}"/></span>
							</label>
						</c:forEach>
					</div>
					
					<!-- 选择规格 -->
					<div class="span2"><a class="btn serverTypeBtn" data-toggle="modal" href="#serverTypeModal">选择规格</a></div>
					 
				</div>
				
			</c:forEach>
			 
			 <hr>
			
			<!-- 生成的资源 -->
			<div id="resourcesDIV"><dl class="dl-horizontal"></dl></div>
			
			<div class="form-actions">
				<input class="btn" type="button" value="返回" onclick="history.back()">
				<input class="btn btn-primary" type="submit" value="提交">
			</div>
			
		</fieldset>
		
	</form>
	
	<!-- 实例规格选择的Modal -->
	<form id="modalForm" action="#" >
		<div id="serverTypeModal" class="modal hide fade" tabindex="-1">
	
			<div class="modal-header"><button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button><h4>选择规格和数量</h4></div>
				
			<div class="modal-body">
				<table class="table">
					<thead><tr><th>实例规格</th><th>数量</th></tr></thead>
					<tbody>
					
						<c:choose>
							<c:when test="${computeType == 1 }">
								 <c:forEach var="map" items="${pcsServerTypeMap }">
									<tr>
										<td>${map.value }</td>
										<td><input type="text" id="inputCount${map.key}" class="input-mini digits" min="1" maxlength="2" placeholder="..1-99" ></td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								 <c:forEach var="map" items="${ecsServerTypeMap }">
									<tr>
										<td>${map.value }</td>
										<td><input type="text" id="inputCount${map.key}" class="input-mini digits" min="1" maxlength="2" placeholder="..1-99"></td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
				
			<div class="modal-footer">
				<button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
				<button id="modalSave" class="btn btn-primary" data-dismiss="modal">确定</button>
			</div>
		</div>
	</form><!-- 实例规格选择的Modal End -->
	
</body>
</html>
