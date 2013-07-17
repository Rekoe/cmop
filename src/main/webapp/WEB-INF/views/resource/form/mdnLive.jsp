<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/layouts/taglib.jsp"%>

<html>
<head>

	<title>资源管理</title>
	
	<script>
		$(document).ready(function() {
			
			$("ul#navbar li#resource").addClass("active");
			
			$("#inputForm").validate();
			
			$("input:radio[name='streamOutMode']").click(function() {
				if ($(this).val() == 1) {
					$("#EncoderDiv").addClass("show").removeClass("hidden");
					$("#TransferDiv").addClass("hidden").removeClass("show");
				} else {
					$("#TransferDiv").addClass("show").removeClass("hidden");
					$("#EncoderDiv").addClass("hidden").removeClass("show");
				}
			});
			
			//点击编码器模式
			$("#encoderMode").change(function() {
				
				$("input.mdn-encoder").val("");
				
				if ($(this).val() == 1) {
					$("#HTTPDIV").addClass("show").removeClass("hidden");
					$("#HSLDIV").addClass("hidden").removeClass("show");
				} else if($(this).val() == 2) {
					$("#HSLDIV").addClass("show").removeClass("hidden");
					$("#HTTPDIV").addClass("hidden").removeClass("show");
				}else{
					$("#HTTPDIV").addClass("hidden").removeClass("show");
					$("#HSLDIV").addClass("hidden").removeClass("show");
				}
			});
			
		});
	</script>
</head>

<body>
	
	<style>body{background-color: #f5f5f5;}</style>
	
	<form id="inputForm" action="${ctx}/resources/update/${resources.id}/live/${mdnLive.id}" method="post" class="input-form form-horizontal" >
		
		<input type="hidden" name="id" value="${resources.id }">
		
		<fieldset>
			<legend><small>变更MDN直播加速</small></legend>
			
			<div class="control-group">
				<label class="control-label" for="changeDescription">变更描述</label>
				<div class="controls">
					<textarea rows="3" id="changeDescription" name="changeDescription" placeholder="...变更描述"
						maxlength="200" class="required">${change.description}</textarea>
				</div>
			</div>
			
			<hr>
			
			<div class="control-group">
				<label class="control-label" for="title">所属服务申请</label>
				<div class="controls">
					<p class="help-inline plain-text">${mdnLive.mdnItem.apply.title}</p>
				</div>
			</div>
			
			<div class="control-group">
				<label class="control-label" for="liveDomain">服务域名</label>
				<div class="controls">
					<input type="text" id="liveDomain" name="liveDomain" value="${mdnLive.liveDomain }" class="required" maxlength="45" placeholder="...服务域名">
				</div>
			</div>
			
			<div class="control-group">
				<label class="control-label" for="liveProtocol">播放协议选择</label>
				<div class="controls">
					<c:forEach var="map" items="${palyProtocolMap}">
				 		<label class="checkbox inline">
				 			<input type="checkbox" id="liveProtocol" name="liveProtocol" value="${map.key}" 
								<c:forEach var="protocol" items="${fn:split(mdnLive.liveProtocol,',')}">
									<c:if test="${map.key == protocol }"> checked="checked" </c:if>
						    	</c:forEach>
							class="required">
							<span class="checkboxText">${map.value }</span>
						</label>	
					</c:forEach>
				</div>
			</div>
			
			<div class="control-group">
				<label class="control-label" for="bandwidth">源站出口带宽</label>
				<div class="controls">
					<input type="text" id="bandwidth" name="bandwidth" value="${mdnLive.bandwidth }" class="required" maxlength="45" placeholder="...源站出口带宽">
				</div>
			</div>
				
			<div class="control-group">
				<label class="control-label" for="name">频道名称</label>
				<div class="controls">
					<input type="text" id="name" name="name" value="${mdnLive.name }" class="required" maxlength="45" placeholder="...频道名称">
				</div>
			</div>
			
			<div class="control-group">
				<label class="control-label" for="guid">频道GUID</label>
				<div class="controls">
					<input type="text" id="guid" name="guid" value="${mdnLive.guid }" class="required" maxlength="45" placeholder="...频道GUID">
				</div>
			</div>
			
			<div class="control-group">
				<label class="control-label" for="streamOutMode">直播流输出模式</label>
				<div class="controls">
					<c:forEach var="map" items="${outputModeMap }">
						<label class="radio inline">
							<input type="radio" id="streamOutMode" name="streamOutMode" value="${map.key }"
								 <c:if test="${map.key == mdnLive.streamOutMode }">checked="checked" </c:if>
								><span class="radioText">${map.value }</span>
						</label>
					</c:forEach>
				</div>
			</div>
			
			<!-- 选择Encoder -->
			<div id="EncoderDiv" 
				<c:choose>
				<c:when test="${ mdnLive.streamOutMode == 1}">class="show"</c:when>
				<c:otherwise>class="hidden control-group"</c:otherwise>
				</c:choose>
			 >
				<div class="control-group">
					<label class="control-label" for="encoderMode">编码器模式</label>
					<div class="controls">
						<select id="encoderMode" name="encoderMode" class="required">
							<c:forEach var="map" items="${encoderModeMap}"> 
								<option <c:if test="${map.key == mdnLive.encoderMode }"> selected="selected"  </c:if>
									 value="${map.key }">${map.value }</option>
							</c:forEach>
						</select>
					</div>
				</div>
				
				<!-- HTTP拉流模式  -->
				<div id="HTTPDIV" 
					<c:choose>
					<c:when test="${ mdnLive.encoderMode == 1}">class="show"</c:when>
					<c:otherwise>class="hidden control-group"</c:otherwise>
					</c:choose>
				 >
					<div class="control-group">
						<label class="control-label" for="httpUrlEncoder">流地址</label>
						<div class="controls">
							<input type="text" id="httpUrlEncoder" name="httpUrlEncoder" value="${mdnLive.httpUrl }" class="required mdn-encoder"  maxlength="45" placeholder="...拉流地址">
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="httpBitrateEncoder">混合码率</label>
						<div class="controls">
							<input type="text" id="httpBitrateEncoder" name="httpBitrateEncoder" value="${mdnLive.httpBitrate }" class="required mdn-encoder" maxlength="45" placeholder="...拉流混合码率">
						</div>
					</div>
				</div><!-- HTTP拉流模式 End -->
				
				<!-- HSLDIV推流模式  -->
				<div id="HSLDIV" 
					<c:choose>
					<c:when test="${ mdnLive.encoderMode == 2}">class="show"</c:when>
					<c:otherwise>class="hidden control-group"</c:otherwise>
					</c:choose>
				 >
					<div class="control-group">
						<label class="control-label" for="hlsUrlEncoder">流地址</label>
						<div class="controls">
							<input type="text" id="hlsUrlEncoder" name="hlsUrlEncoder" value="${mdnLive.hlsUrl }" class="mdn-encoder" maxlength="45" placeholder="...推流地址">
						</div>
					</div>
					
					<div class="control-group">
						<label class="control-label" for="hlsBitrateEncoder">混合码率</label>
						<div class="controls">
							<input type="text" id="hlsBitrateEncoder" name="hlsBitrateEncoder" value="${mdnLive.hlsBitrate }" class="mdn-encoder" maxlength="45" placeholder="...推流混合码率">
						</div>
					</div>
				</div><!-- HSLDIV推流模式 End -->
			
			</div><!-- 选择Encoder End -->
			
			<!-- 选择 Transfer -->
			<div id="TransferDiv" 
				<c:choose>
				<c:when test="${ mdnLive.streamOutMode == 2}">class="show"</c:when>
				<c:otherwise>class="hidden control-group"</c:otherwise>
				</c:choose>
			 >
				
				<div class="control-group">
					<label class="control-label" for="httpUrl">HTTP流地址</label>
					<div class="controls">
						<input type="text" id="httpUrl" name="httpUrl" value="${mdnLive.httpUrl }" class="required" maxlength="45" placeholder="...HTTP流地址">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="httpBitrate">HTTP流混合码率</label>
					<div class="controls">
						<input type="text" id="httpBitrate" name="httpBitrate" value="${mdnLive.httpBitrate }" class="required" maxlength="45" placeholder="...HTTP流混合码率">
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label" for="hlsUrl">HSL流地址</label>
					<div class="controls">
						<input type="text" id="hlsUrl" name="hlsUrl" value="${mdnLive.hlsUrl }" class="required" maxlength="45" placeholder="...HSL流地址">
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label" for="hlsBitrate">HSL混合码率</label>
					<div class="controls">
						<input type="text" id="hlsBitrate" name="hlsBitrate" value="${mdnLive.hlsBitrate }" class="required" maxlength="45" placeholder="...HSL流混合码率">
					</div>
				</div>
				
			</div><!-- 选择Transfer End -->
			
			<div class="form-actions">
				<a href="${ctx}/resources/update/${resources.id}/" class="btn">返回</a>
				<input class="btn btn-primary" type="submit" value="提交">
			</div>
			
		</fieldset>
		
	</form>
	
</body>
</html>
