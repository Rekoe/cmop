<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/layouts/taglib.jsp"%>

<html>
<head>

	<title>资源管理</title>
	
	<script>
		$(document).ready(function() {
			
			$("ul#navbar li#resource").addClass("active");
			
		});
	</script>
	
</head>

<body>
	
	<style>body{background-color: #f5f5f5;}</style>

	<form id="inputForm" action="${ctx}/summary/migrate" method="post" class="form-horizontal input-form">
	
		<input type="hidden" name="resourceId" value="${resources.id }">
		
		<fieldset>
			<legend><small>资源详情</small></legend>
			
			 <div class="control-group">
				<label class="control-label" for="title">所属服务申请</label>
				<div class="controls">
					<p class="help-inline plain-text">${elb.apply.title}</p>
				</div>
			</div>
			
			<div class="control-group">
				<label class="control-label" for="status">资源状态</label>
				<div class="controls">
					<p class="help-inline plain-text">
						<c:forEach var="map" items="${resourcesStatusMap}"><c:if test="${map.key == resources.status }">${map.value}</c:if></c:forEach>
					</p>
				</div>
			</div>
			
			<div class="control-group">
				<label class="control-label" for="identifier">标识符</label>
				<div class="controls">
					<p class="help-inline plain-text">${elb.identifier}</p>
				</div>
			</div>
			
			<div class="control-group">
				<label class="control-label" for="ipAddress">负载均衡虚拟IP</label>
				<div class="controls">
					<p class="help-inline plain-text">${resources.ipAddress}</p>
				</div>
			</div>
			
			<div class="control-group">
				<label class="control-label" for="keepSession">是否保持会话</label>
				<div class="controls">
					<p class="help-inline plain-text">
						<c:forEach var="map" items="${keepSessionMap}"><c:if test="${map.key == elb.keepSession }">${map.value}</c:if></c:forEach>
					</p>
				</div>
			</div>
			
			<div class="control-group">
				<label class="control-label" for="relationCompute">关联实例</label>
				<div class="controls">
					<p class="help-inline plain-text">
						<c:forEach var="compute" items="${elb.computeItemList }">
							${compute.identifier}(${compute.remark} - ${compute.innerIp})&nbsp;&nbsp;
						</c:forEach>
					</p>
				</div>
			</div>
			
			<div class="control-group">
				<label class="control-label" for="elbPortItem">端口映射</label>
				<div class="controls">
					<table class="table table-bordered table-condensed"  >
						<thead><tr><th>协议</th><th>源端口</th><th>目标端口</th></tr></thead>
						<tbody>
							<c:forEach var="item" items="${elb.elbPortItems}">
								<tr>
									<td>${item.protocol }</td>
									<td>${item.sourcePort }</td>
									<td>${item.targetPort }</td>
								</tr>
							</c:forEach>
		 				</tbody>
					</table>	
				</div>
			</div>
			
			<hr>
			
			<div class="control-group">
				<label class="control-label" for="serviceTagId">服务标签</label>
				<div class="controls">
					<p class="help-inline plain-text">
						<c:forEach var="item" items="${allTags}"><c:if test="${item.id == resources.serviceTag.id }">${item.name}</c:if></c:forEach>
					</p>
				</div>
			</div>
			
			<div class="control-group">
				<label class="control-label" for="changeDescription">变更描述</label>
				<div class="controls">
					<p class="help-inline plain-text">${change.description}</p>
				</div>
			</div>
			
			<div class="control-group">
				<label class="control-label" for="changeDescription">变更时间</label>
				<div class="controls">
					<p class="help-inline plain-text"><fmt:formatDate value="${change.changeTime}" pattern="yyyy年MM月dd日  HH时mm分ss秒" /></p>
				</div>
			</div>
			
		<c:if test="${not empty migrate }">
				<div class="control-group">
					<label class="control-label" for="userId">资源所属人</label>
					<div class="controls">
						<select name="userId">
							<c:forEach var="item" items="${users }">
								<option value="${item.id }" 
									<c:if test="${item.id == resources.user.id }">selected="selected"</c:if>	
								>${item.name }</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</c:if>
			
			<div class="form-actions">
				<input class="btn" type="button" value="返回" onclick="history.back()">
				<c:if test="${not empty migrate }"><input class="btn btn-primary" type="submit" value="提交"></c:if>
			</div>
		
		</fieldset>
		
	</form>
	
</body>
</html>
