<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/layouts/taglib.jsp"%>

<html>
<head>

	<title>服务申请</title>
	
	<script>
		$(document).ready(function() {
			
			$("ul#navbar li#apply").addClass("active");
			
		});
		
		function myPrint(obj){
		    var newWindow=window.open("打印窗口","_blank");
		    var docStr = obj.innerHTML;
		    newWindow.document.write(docStr);
		    newWindow.document.close();
		    newWindow.print();
		    //newWindow.close();
		}
	</script>
	
</head>

<body>
	
	<style>body{background-color: #f5f5f5;}</style>

	<form id="inputForm" action="#" method="post" class="form-horizontal input-form">
	
		<input type="hidden" name="id" value="${apply.id}">
		
		<fieldset id="print">
			<legend><small>服务申请单详情</small></legend>
			
			<dl class="dl-horizontal">
			
				<dt>标题</dt>
				<dd>${apply.title}&nbsp;</dd>
				
				<dt>申请日期</dt>
				<dd><fmt:formatDate value="${apply.createTime}" pattern="yyyy年MM月dd日  HH时mm分ss秒" />&nbsp;</dd>
				
				<dt>状态</dt>
				<dd>
					<c:forEach var="map" items="${applyStatusMap }">
					 	<c:if test="${map.key == apply.status }">${map.value }</c:if>
					</c:forEach>&nbsp;
				</dd>
				
				<dt>服务标签</dt>
				<dd>${apply.serviceTag}&nbsp;</dd>
				
				<dt>优先级</dt>
				<dd>
					<c:forEach var="map" items="${priorityMap }">
					 	<c:if test="${map.key == apply.priority }">${map.value }</c:if>
					</c:forEach>&nbsp;
				</dd>
				
				<dt>服务开始时间</dt>
				<dd>${apply.serviceStart}&nbsp;</dd>
				
				<dt>服务结束时间</dt>
				<dd>${apply.serviceEnd}&nbsp;</dd>
				
				<dt>用途描述</dt>
				<dd>${apply.description}&nbsp;</dd>
				
				<!-- 实例Compute -->
				<c:if test="${not empty apply.computeItems}">
					<hr>
					<dt>ECS实例</dt>
					<c:forEach var="item" items="${apply.computeItems}">
					
						<dd><em>标识符</em>&nbsp;&nbsp;${item.identifier}</dd>
						
						<dd><em>IP地址</em>&nbsp;&nbsp;${item.innerIp}</dd>
						
						<dd><em>用途信息</em>&nbsp;&nbsp;${item.remark}</dd>
						
						<dd>
							<em>基本信息</em>
							&nbsp;&nbsp;<c:forEach var="map" items="${osTypeMap}"><c:if test="${item.osType == map.key}">${map.value}</c:if></c:forEach>
							&nbsp;&nbsp;<c:forEach var="map" items="${osBitMap}"><c:if test="${item.osBit == map.key}">${map.value}</c:if></c:forEach>
							&nbsp;&nbsp;
							<c:choose>
								<c:when test="${item.computeType == 1}"><c:forEach var="map" items="${pcsServerTypeMap}"><c:if test="${item.serverType == map.key}">${map.value}</c:if></c:forEach></c:when>
								<c:otherwise><c:forEach var="map" items="${ecsServerTypeMap}"><c:if test="${item.serverType == map.key}">${map.value}</c:if></c:forEach></c:otherwise>
							</c:choose>
						</dd>
						
						<c:if test="${not empty item.mountESG }"><dd><em>关联ESG</em>&nbsp;&nbsp;${item.mountESG}</dd></c:if>
						
						<br>
						
					</c:forEach>
				</c:if>
				
				<!-- 存储空间ES3 -->
				<c:if test="${not empty apply.storageItems}">
					<hr>
					<dt>ES3存储空间</dt>
					<c:forEach var="item" items="${apply.storageItems}">
					
						<dd><em>标识符</em>&nbsp;&nbsp;${item.identifier}</dd>
						
						<dd><em>存储类型</em>&nbsp;&nbsp;<c:forEach var="map" items="${storageTypeMap}"><c:if test="${item.storageType == map.key}">${map.value}</c:if></c:forEach></dd>
						
						<dd><em>容量空间</em>&nbsp;&nbsp;${item.space}&nbsp;GB</dd>
						
						<c:if test="${not empty item.mountComputes }"><dd><em>挂载实例</em>&nbsp;&nbsp;${item.mountComputes}</dd></c:if>
						
						<br>
						
					</c:forEach>
				</c:if>
				
				<!-- 负载均衡器ELB -->
				<c:if test="${not empty apply.networkElbItems}">
					<hr>
					<dt>负载均衡器ELB</dt>
					<c:forEach var="item" items="${apply.networkElbItems}">
					
						<dd><em>标识符</em>&nbsp;&nbsp;${item.identifier}</dd>
						
						<dd><em>负载均衡虚拟IP</em>&nbsp;&nbsp;${item.virtualIp}</dd>
						
						<dd><em>是否保持会话</em>&nbsp;<c:forEach var="map" items="${keepSessionMap}"><c:if test="${item.keepSession == map.key }">${map.value}</c:if></c:forEach></dd>
						
						<dd><em>端口映射（协议、源端口、目标端口）</em></dd>
						
						<c:forEach var="port" items="${item.elbPortItems }">
							<dd>&nbsp;&nbsp;${port.protocol}&nbsp;,&nbsp;${port.sourcePort}&nbsp;,&nbsp;${port.targetPort}</dd>
						</c:forEach>
							
						<c:if test="${not empty item.mountComputes }"><dd><em>关联实例</em>&nbsp;&nbsp;${item.mountComputes}</dd></c:if>
						
						<br>
						
					</c:forEach>
				</c:if>
				
				<!-- IP地址EIP -->
				<c:if test="${not empty apply.networkEipItems}">
				
					<hr>
					<dt>EIP</dt>
					<c:forEach var="item" items="${apply.networkEipItems}">
					
						<dd><em>标识符</em>&nbsp;&nbsp;${item.identifier}</dd>
						
						<dd><em>IP地址</em>&nbsp;&nbsp;${item.ipAddress}</dd>
						
						<dd><em>ISP运营商</em>&nbsp;&nbsp;<c:forEach var="map" items="${ispTypeMap}"><c:if test="${item.ispType == map.key }">${map.value}</c:if></c:forEach></dd>
						
						<dd>
							<c:choose>
								<c:when test="${not empty item.computeItem }"><em>关联实例</em>&nbsp;&nbsp;${item.computeItem.identifier }(${item.computeItem.remark } - ${item.computeItem.innerIp })</c:when>
								<c:when test="${not empty item.networkElbItem }"><em>关联ELB</em>&nbsp;&nbsp;${item.networkElbItem.identifier }(${item.networkElbItem.virtualIp })&nbsp;【${item.networkElbItem.mountComputes}】</c:when>
								<c:otherwise></c:otherwise>
							</c:choose>
						</dd>
						
						<dd><em>端口映射（协议、源端口、目标端口）</em></dd>
						
						<c:forEach var="port" items="${item.eipPortItems }">
							<dd>&nbsp;&nbsp;${port.protocol}&nbsp;,&nbsp;${port.sourcePort}&nbsp;,&nbsp;${port.targetPort}</dd>
						</c:forEach>
							
						<br>
						
					</c:forEach>
				
				</c:if>
				
				<!-- DNS -->
				<c:if test="${not empty apply.networkDnsItems}">
				
					<hr>
					<dt>DNS域名映射</dt>
					<c:forEach var="item" items="${apply.networkDnsItems}">
					
						<dd><em>标识符</em>&nbsp;&nbsp;${item.identifier}</dd>
						
						<dd><em>域名</em>&nbsp;&nbsp;${item.domainName }</dd>
						
						<dd><em>域名类型</em>&nbsp;&nbsp;<c:forEach var="map" items="${domainTypeMap}"><c:if test="${item.domainType == map.key }">${map.value}</c:if></c:forEach></dd>
						
						<dd>
							<c:choose>
								<c:when test="${item.domainType != 3 && not empty item.mountElbs}"><em>目标IP</em>&nbsp;&nbsp;${item.mountElbs }</c:when>
								<c:when test="${not empty item.cnameDomain }"><em>CNAME域名</em>&nbsp;&nbsp;${item.cnameDomain }</c:when>
								<c:otherwise></c:otherwise>
							</c:choose>
						</dd>
						
						<br>
						
					</c:forEach>
					
				</c:if>
				
				<!-- 监控邮件列表 -->
				<c:if test="${not empty apply.monitorMails}">
					<hr>
					<dt>监控邮件列表</dt>
					<c:forEach var="item" items="${apply.monitorMails}"><dd>${item.email }</dd></c:forEach>
				</c:if>
				
				<!-- 监控手机列表 -->
				<c:if test="${not empty apply.monitorPhones}">
					<hr>
					<dt>监控手机列表</dt>
					<c:forEach var="item" items="${apply.monitorPhones}"><dd>${item.telephone }</dd></c:forEach>
				</c:if>
				
				<!-- 服务器监控monitorCompute -->
				<c:if test="${not empty apply.monitorComputes}">
				
					<hr>
					<dt>实例监控</dt>
					<c:forEach var="item" items="${apply.monitorComputes}">
					
						<dd><em>标识符</em>&nbsp;&nbsp;${item.identifier}</dd>
						
						<dd><em>IP地址</em>&nbsp;&nbsp;${item.ipAddress}</dd>
						
						<dd><em>CPU占用率</em>
							&nbsp;&nbsp;报警阀值&nbsp;<c:forEach var="map" items="${thresholdGtMap}"><c:if test="${item.cpuWarn == map.key }"><strong>${map.value }</strong></c:if></c:forEach>
							&nbsp;&nbsp;警告阀值&nbsp;<c:forEach var="map" items="${thresholdGtMap}"><c:if test="${item.cpuCritical == map.key }"><strong>${map.value }</strong></c:if></c:forEach>
						</dd>
						
						<dd><em>内存占用率</em>
							&nbsp;&nbsp;报警阀值&nbsp;<c:forEach var="map" items="${thresholdGtMap}"><c:if test="${item.memoryWarn == map.key }"><strong>${map.value }</strong></c:if></c:forEach>
							&nbsp;&nbsp;警告阀值&nbsp;<c:forEach var="map" items="${thresholdGtMap}"><c:if test="${item.memoryCritical == map.key }"><strong>${map.value }</strong></c:if></c:forEach>
						</dd>
						
						<dd><em>网络丢包率</em>
							&nbsp;&nbsp;报警阀值&nbsp;<c:forEach var="map" items="${thresholdGtMap}"><c:if test="${item.pingLossWarn == map.key }"><strong>${map.value }</strong></c:if></c:forEach>
							&nbsp;&nbsp;警告阀值&nbsp;<c:forEach var="map" items="${thresholdGtMap}"><c:if test="${item.pingLossCritical == map.key }"><strong>${map.value }</strong></c:if></c:forEach>
						</dd>
						
						<dd><em>硬盘可用率</em>
							&nbsp;&nbsp;报警阀值&nbsp;<c:forEach var="map" items="${thresholdLtMap}"><c:if test="${item.diskWarn == map.key }"><strong>${map.value }</strong></c:if></c:forEach>
							&nbsp;&nbsp;警告阀值&nbsp;<c:forEach var="map" items="${thresholdLtMap}"><c:if test="${item.diskCritical == map.key }"><strong>${map.value }</strong></c:if></c:forEach>
						</dd>
						
						<dd><em>网络延时率</em>
							&nbsp;&nbsp;报警阀值&nbsp;<c:forEach var="map" items="${thresholdNetGtMap}"><c:if test="${item.pingDelayWarn == map.key }"><strong>${map.value }</strong></c:if></c:forEach>
							&nbsp;&nbsp;警告阀值&nbsp;<c:forEach var="map" items="${thresholdNetGtMap}"><c:if test="${item.pingDelayCritical == map.key }"><strong>${map.value }</strong></c:if></c:forEach>
						</dd>
						
						<dd><em>最大进程数</em>
							&nbsp;&nbsp;报警阀值&nbsp;<c:forEach var="map" items="${maxProcessMap}"><c:if test="${item.maxProcessWarn == map.key }"><strong>${map.value }</strong></c:if></c:forEach>
							&nbsp;&nbsp;警告阀值&nbsp;<c:forEach var="map" items="${maxProcessMap}"><c:if test="${item.maxProcessCritical == map.key }"><strong>${map.value }</strong></c:if></c:forEach>
						</dd>
						
						<dd><em>监控端口</em>&nbsp;&nbsp;${item.port}</dd>
						<dd><em>监控进程</em>&nbsp;&nbsp;${item.process}</dd>
						<dd><em>挂载路径</em>&nbsp;&nbsp;${item.mountPoint}</dd>
							
						<br>
					</c:forEach>
					
				</c:if>
				
				<!-- ELB监控monitorElb -->
				<c:if test="${not empty apply.monitorElbs}">
				
					<hr>
					<dt>ELB监控</dt>
					<c:forEach var="item" items="${apply.monitorElbs}">
					
						<dd><em>标识符</em>&nbsp;&nbsp;${item.identifier}</dd>
						
						<dd><em>监控ELB</em>&nbsp;&nbsp;${item.networkElbItem.identifier }(${item.networkElbItem.virtualIp})</dd>
						
						<br>
						
					</c:forEach>
				</c:if>
				
				<!-- MDN -->
				<c:if test="${not empty apply.mdnItems }">
					<hr>
					<dt>MDN</dt>
					<c:forEach var="item" items="${apply.mdnItems}">
					
						<dd><em>标识符</em>&nbsp;&nbsp;${item.identifier}</dd>
						
						<dd><em>重点覆盖地域</em>&nbsp;&nbsp;${item.coverArea}</dd>
						
						<dd><em>重点覆盖ISP</em>&nbsp;&nbsp;
							<c:forEach var="coverIsp" items="${fn:split(item.coverIsp,',')}">
								<c:forEach var="map" items="${ispTypeMap }">
									<c:if test="${map.key == coverIsp }">${map.value }</c:if>
								</c:forEach>
						    </c:forEach>
					 	</dd>
						
						<c:if test="${not empty item.mdnVodItems }">
							<br>
							<dt>MDN点播加速</dt>
							<c:forEach var="vod" items="${item.mdnVodItems}">
								<dd><em>服务子项ID</em>&nbsp;&nbsp;${vod.id}</dd>
								<dd><em>服务域名</em>&nbsp;&nbsp;${vod.vodDomain}</dd>
								<dd><em>加速服务带宽</em>&nbsp;&nbsp;<c:forEach var="map" items="${bandwidthMap }"><c:if test="${map.key == vod.vodBandwidth }">${map.value }</c:if></c:forEach></dd>
								<dd><em>播放协议选择</em>&nbsp;&nbsp;${vod.vodProtocol}</dd>
								<dd><em>源站出口带宽</em>&nbsp;&nbsp;${vod.sourceOutBandwidth}</dd>
								<dd><em>Streamer地址</em>&nbsp;&nbsp;${vod.sourceStreamerUrl}</dd>
								<br>
							</c:forEach>
						</c:if>
						
						<c:if test="${not empty item.mdnLiveItems }">
							<br>
							<dt>MDN直播</dt>
							<c:forEach var="live" items="${item.mdnLiveItems}">
								<dd><em>服务子项ID</em>&nbsp;&nbsp;${live.id}</dd>
								<dd><em>服务域名</em>&nbsp;&nbsp;${live.liveDomain}</dd>
								<dd><em>加速服务带宽</em>&nbsp;&nbsp;<c:forEach var="map" items="${bandwidthMap }"><c:if test="${map.key == live.liveBandwidth }">${map.value }</c:if></c:forEach></dd>
								<dd><em>播放协议选择</em>&nbsp;&nbsp;${live.liveProtocol}</dd>
								<dd><em>源站出口带宽</em>&nbsp;&nbsp;${live.bandwidth}</dd>
								<dd><em>频道名称</em>&nbsp;&nbsp;${live.name}</dd>
								<dd><em>频道GUID</em>&nbsp;&nbsp;${live.guid}</dd>
								<dd><em>直播流输出模式</em>&nbsp;&nbsp;<c:forEach var="map" items="${outputModeMap }"><c:if test="${map.key == live.streamOutMode }">${map.value }</c:if></c:forEach></dd>
								<c:if test="${live.streamOutMode == 1 }">
									<dd><em>编码器模式</em>&nbsp;&nbsp;<c:forEach var="map" items="${encoderModeMap }"><c:if test="${map.key == live.encoderMode }">${map.value }</c:if></c:forEach></dd>
								</c:if>
								<c:choose>
									<c:when test="${live.streamOutMode == 1   }">
										<c:choose>
											<c:when test="${live.encoderMode == 1 }">
												<c:if test="${not empty live.httpUrl }">
													<dd><em>拉流地址</em>&nbsp;&nbsp;${live.httpUrl}</dd>
												</c:if>
												<c:if test="${not empty live.httpBitrate }">
													<dd><em>拉流混合码率</em>&nbsp;&nbsp;${live.httpBitrate}</dd>
												</c:if>
											</c:when>
											<c:when test="${live.encoderMode == 2 }">
												<c:if test="${not empty live.hlsUrl }">
													<dd><em>推流地址</em>&nbsp;&nbsp;${live.hlsUrl}</dd>
												</c:if>
												<c:if test="${not empty live.hlsBitrate }">
													<dd><em>推流混合码率</em>&nbsp;&nbsp;${live.hlsBitrate}</dd>
												</c:if>
											</c:when>
											<c:otherwise></c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>
										<dd><em>HTTP流地址</em>&nbsp;&nbsp;${live.httpUrl}</dd>
										<dd><em>HTTP流混合码率</em>&nbsp;&nbsp;${live.httpBitrate}</dd>
										
										<dd><em>HSL流地址</em>&nbsp;&nbsp;${live.hlsUrl}</dd>
										<dd><em>HSL流混合码率</em>&nbsp;&nbsp;${live.hlsBitrate}</dd>
										
									</c:otherwise>
								</c:choose>
								<br>
							</c:forEach>
						</c:if>
						<br>
					</c:forEach>
				</c:if>
				
				<!-- CP云生产 -->
				<c:if test="${not empty apply.cpItems}">
					<hr>
					<dt>CP云生产</dt>
					<c:forEach var="item" items="${apply.cpItems}">
						<dd><em>标识符</em>&nbsp;&nbsp;${item.identifier}</dd>
						<dd><em>收录流URL</em>&nbsp;&nbsp;${item.recordStreamUrl}</dd>
						<dd><em>收录码率</em>&nbsp;&nbsp;<c:forEach var="map" items="${recordBitrateMap}"><c:if test="${map.key == item.recordBitrate }">${map.value }</c:if></c:forEach></dd>
						<dd><em>输出编码</em>&nbsp;&nbsp;
							<c:forEach var="exportEncode" items="${fn:split(item.exportEncode,',')}">
								<c:forEach var="map" items="${exportEncodeMap }">
									<c:if test="${map.key == exportEncode }"><br>${map.value }</c:if>
								</c:forEach>
						    </c:forEach>
					 	</dd>
						<dd><em>收录类型</em>&nbsp;&nbsp;<c:forEach var="map" items="${recordTypeMap}"><c:if test="${map.key == item.recordType }">${map.value }</c:if></c:forEach></dd>
						<dd><em>收录时段</em>&nbsp;&nbsp;${item.recordTime}</dd>
						<dd><em>收录时长(小时)</em>&nbsp;&nbsp;${item.recordDuration}</dd>
						<c:if test="${not empty item.publishUrl }">
							<dd><em>发布接口地址</em>&nbsp;&nbsp;${item.publishUrl}</dd>
						</c:if>
						<dd><em>是否推送内容交易平台</em>&nbsp;&nbsp;<c:forEach var="map" items="${isPushCtpMap}"><c:if test="${map.key == item.isPushCtp }">${map.value }</c:if></c:forEach></dd>
						<br>
						<dd><strong>视频配置</strong></dd>
						<dd><em>FTP上传IP</em>&nbsp;&nbsp;${item.videoFtpIp}</dd>
						<dd><em>端口</em>&nbsp;&nbsp;${item.videoFtpPort}</dd>
						<dd><em>FTP用户名</em>&nbsp;&nbsp;${item.videoFtpUsername}</dd>
						<dd><em>FTP密码</em>&nbsp;&nbsp;${item.videoFtpPassword}</dd>
						<dd><em>FTP根路径</em>&nbsp;&nbsp;${item.videoFtpRootpath}</dd>
						<dd><em>FTP上传路径</em>&nbsp;&nbsp;${item.videoFtpUploadpath}</dd>
						<dd><em>输出组类型</em>&nbsp;&nbsp;${item.videoOutputGroup}</dd>
						<dd><em>输出方式配置</em>&nbsp;&nbsp;<c:forEach var="map" items="${videoOutputWayMap}"><c:if test="${map.key == item.videoOutputWay }">${map.value }</c:if></c:forEach></dd>
						<br>
						<dd><strong>图片配置</strong></dd>
						<dd><em>FTP上传IP</em>&nbsp;&nbsp;${item.pictrueFtpIp}</dd>
						<dd><em>端口</em>&nbsp;&nbsp;${item.pictrueFtpPort}</dd>
						<dd><em>FTP用户名</em>&nbsp;&nbsp;${item.pictrueFtpUsername}</dd>
						<dd><em>FTP密码</em>&nbsp;&nbsp;${item.pictrueFtpPassword}</dd>
						<dd><em>FTP根路径</em>&nbsp;&nbsp;${item.pictrueFtpRootpath}</dd>
						<dd><em>FTP上传路径</em>&nbsp;&nbsp;${item.pictrueFtpUploadpath}</dd>
						<dd><em>输出组类型</em>&nbsp;&nbsp;${item.pictrueOutputGroup}</dd>
						<dd><em>输出媒体类型</em>&nbsp;&nbsp;${item.pictrueOutputMedia}</dd>
						
						<c:if test="${not empty item.cpProgramItems }">
							<br>
							<dd><strong>拆条节目单</strong></dd>
							<c:forEach var="program" items="${ item.cpProgramItems}">
								<dd><a>${program.name }&nbsp;&nbsp;${program.size }K</a></dd>
							</c:forEach>
						</c:if>
						
					</c:forEach>
				</c:if>
				
				<c:if test="${not empty sumCost}">
					<hr>
					<dt>资源服务费用</dt>
					<dd>${sumCost}</dd>
				</c:if>
				
			</dl>
			
		</fieldset>
		
		<div class="form-actions">
			<input class="btn" type="button" value="返回" onclick="history.back()">
			<a onclick="myPrint(document.getElementById('print'))" class="btn btn-primary">打印</a>
		</div>
			
		
	</form>
	
</body>
</html>
