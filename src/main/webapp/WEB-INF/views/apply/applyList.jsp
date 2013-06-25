<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/layouts/taglib.jsp"%>

<html>
<head>

	<title>服务申请</title>
	
	<script>
		$(document).ready(function() {
			
			$("ul#navbar li#apply").addClass("active");
			
		    $('#createBtn').popover({	
		    	trigger: "hover",
		    	placement: "right",
		    	title: "Note",
		    	content: "申请任何资源前,需要一个服务申请单."
		    });
			
		});
	</script>
	
</head>

<body>
	
	<p><a id="createBtn" class="btn btn-large btn-primary" href="save/">创建申请单 &raquo;</a></p>
	
	<div class="row">
		<div class="span12 quick-actions">
			
			<!-- 
			<a href="${ctx}/apply/compute/save/1/" class="btn tip-bottom" title="PCS 物理机">PCS &raquo;</a>
			 -->
			<a href="${ctx}/apply/compute/save/2/" class="btn tip-bottom" title="ECS 虚拟机">ECS &raquo;</a>
			<a href="${ctx}/apply/es3/save/" class="btn tip-bottom" title="ES3 存储卷">ES3 &raquo;</a>
			<a href="${ctx}/apply/elb/save/" class="btn tip-bottom" title="ELB 负载均衡器">ELB &raquo;</a>
			<a href="${ctx}/apply/eip/save/" class="btn tip-bottom" title="EIP 公网IP及端口映射">EIP &raquo;</a>
			<a href="${ctx}/apply/dns/save/" class="btn tip-bottom" title="DNS 域名映射">DNS &raquo;</a>
			<a href="${ctx}/apply/monitor/save/" class="btn tip-bottom" title="Monitor 实例监控 & ELB监控">Monitor &raquo;</a>
		</div>
		<div class="span12 quick-actions">
			<a href="${ctx}/apply/mdn/save/" class="btn tip-bottom" title="MDN">MDN &raquo;</a>
			<a href="${ctx}/apply/cp/save/" class="btn tip-bottom" title="CP 云生产">CP &raquo;</a>
		</div>

	</div>

	<form class="form-inline well well-small" action="#">

		<div class="row">

			<div class="span3">
				<label class="control-label search-text">标题</label> <input type="text" name="search_LIKE_title" class="span2" maxlength="45" 
					value="${param.search_LIKE_title}">
			</div>
			
			<div class="span3">
				<label class="control-label search-text">服务标签</label> <input type="text" name="search_LIKE_serviceTag" class="span2" maxlength="45" 
					value="${param.search_LIKE_serviceTag}">
			</div>
			
			<div class="span3">
				<label class="control-label search-text">状态</label> 
				<select name="search_EQ_status" class="span2">
					<option value="" selected="selected">Choose...</option>
					<c:forEach var="map" items="${applyStatusMap }">
						<option value="${map.key }" 
							<c:if test="${map.key == param.search_EQ_status && param.search_EQ_status != '' }">
								selected="selected"
							</c:if>
						>${map.value }</option>
					</c:forEach>
				</select>
			</div>
			
			<div class="span2 pull-right">
				<button class="btn tip-bottom" title="搜索" type="submit"><i class="icon-search"></i></button>
				<button class="btn tip-bottom reset" title="刷新" type="reset"><i class="icon-refresh"></i></button>
				<!-- <button class="btn tip-bottom options"  title="更多搜索条件" type="button"><i class="icon-resize-small"></i></button> -->
			</div>

		</div>
		
		<!-- 多个搜索条件的话,启用 div.options -->
		<div class="row options">
			<div class="span3">
				<label class="control-label search-text">优先级</label> 
				<select name="search_EQ_priority" class="span2">
					<option value="" selected="selected">Choose...</option>
					<c:forEach var="map" items="${priorityMap }">
						<option value="${map.key }" 
							<c:if test="${map.key == param.search_EQ_priority }">
								selected="selected"
							</c:if>
						>${map.value }</option>
					</c:forEach>
				</select>
			</div>
		</div>

	</form>
	
	<div class="row">
		<div class="span4"></div>
		<div class="pull-right"><tags:singlePage page="${page}" /></div>
	</div>
	
	<div class="singlePage">
	<table class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>标题</th>
				<th>服务标签</th>
				<th>优先级</th>
				<th>状态</th>
				<th>申请时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.content}" var="item">
				<tr>
					<td><a href="detail/${item.id}">${item.title}</a></td>
					<td>${item.serviceTag}</td>
					<td><c:forEach var="map" items="${priorityMap }"><c:if test="${map.key == item.priority }">${map.value }</c:if></c:forEach></td>
					<td>
						<c:forEach var="map" items="${applyStatusMap }">
							<c:if test="${map.key == item.status }">
								<c:choose>
									<c:when test="${item.status == 0 }">
										<span class="label">${map.value }</span>
									</c:when>
									
									<c:when test="${item.status == 1 }">
										<span class="label label-warning">${map.value }</span>
									</c:when>
									
									<c:when test="${item.status == 2 }">
										<span class="label label-important">${map.value }</span>
									</c:when>
									
									<c:when test="${item.status == 3 }">
										<span class="label label-inverse">${map.value }</span>
									</c:when>
									
									<c:when test="${item.status == 4 }">
										<span class="label status4">${map.value }</span>
									</c:when>
									
									<c:when test="${item.status == 5 }">
										<span class="label status5">${map.value }</span>
									</c:when>
									
									<c:otherwise>
										<span class="label label-success">${map.value }</span>
									</c:otherwise>
									
								</c:choose>
							</c:if>
						</c:forEach>
					</td>
					<td><fmt:formatDate value="${item.createTime}" pattern="yyyy年MM月dd日  HH时mm分ss秒" /></td>
					<td>
						<a href="${ctx}/applyReport/getpdfReport/${item.id}.pdf" target="_blank">PDF</a>
						
						<c:forEach var="allowStatus" items="${allowApplyStatus }">
						
						
							<c:if test="${ item.status == allowStatus }">
							
								<a href="update/${item.id}">修改</a>
							
								<a href="#deleteModal${item.id}" data-toggle="modal">删除</a>
								<div id="deleteModal${item.id}" class="modal hide fade" tabindex="-1" data-width="250">
									<div class="modal-header"><button type="button" class="close" data-dismiss="modal">×</button><h3>提示</h3></div>
									<div class="modal-body">是否删除?</div>
									<div class="modal-footer">
										<button class="btn" data-dismiss="modal">关闭</button>
										<a href="delete/${item.id}/" class="btn btn-primary loading">确定</a>
									</div>
								</div>
							
								<a href="#auditModal${item.id}" data-toggle="modal">提交</a>
								<div id="auditModal${item.id}" class="modal hide fade" tabindex="-1" data-width="250">
									<div class="modal-header"><button type="button" class="close" data-dismiss="modal">×</button><h3>提示</h3></div>
									<div class="modal-body">是否提交?</div>
									<div class="modal-footer">
										<button class="btn" data-dismiss="modal">关闭</button>
										<a href="audit/${item.id}/" class="btn btn-primary loading">确定</a>
									</div>
								</div>
							
							</c:if>
							
						</c:forEach>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>

</body>
</html>
