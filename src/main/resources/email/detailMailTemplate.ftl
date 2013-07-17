<html>
<head>
<style type="text/css">
.text-error{color:#b94a48;}
</style>
</head>
<body>

	<p><#if operateUrl?exists>${operateUrl}<#elseif operateDoneStr?exists>${operateDoneStr}<#else>你好,请审批以下内容.</#if></p>
	
	<ul>
		
		<!--服务申请Apply -->
		<#if apply?exists >
			<li>
				<strong>服务申请单基本信息</strong>
				<ul> 
					<li><em>申请人</em>&nbsp;: ${apply.user.name} </li>
					<li><em>申请标题</em>&nbsp;: ${apply.title}</li>
					<li><em>服务标签</em>&nbsp;: ${apply.serviceTag}</li>
					<li><em>申请时间</em>&nbsp;: ${apply.createTime}</li>
					
					<li><em>优先级</em>&nbsp;: 
						<#list priorityMap?keys as k >
							<#if apply.priority?string == k>${priorityMap[k]}</#if>
						</#list>
					</li>
					
					<li><em>服务起止日期</em>&nbsp;: ${apply.serviceStart} <em>至</em>&nbsp; ${apply.serviceEnd}</li>
					<li><em>用途描述</em>&nbsp;: ${apply.description}</li>
				</ul>	
			</li> 
		</#if> <!--服务申请Apply End -->
		
		<!-- 故障申报 Failure -->
		<#if failure?exists >
			<li>
				<strong>故障申报基本信息</strong>
				<ul> 
					<li><em>申报人</em>&nbsp;: ${failure.user.name} </li>
					<li><em>申报标题</em>&nbsp;: ${failure.title}</li>
					<li><em>申报时间</em>&nbsp;: ${failure.createTime?string('yyyy-MM-dd HH:mm:ss')}</li>
					
					<li><em>故障类型</em>&nbsp;: 
						<#list applyServiceTypeMap?keys as k >
							<#if failure.faultType?string == k>
								${applyServiceTypeMap[k]}
							</#if>
						</#list>
					</li>
					
					<li><em>优先级</em>&nbsp;: 
						<#list priorityMap?keys as k >
							<#if failure.level?string == k>
								${priorityMap[k]}
							</#if>
						</#list>
					</li>
					
					<li><em>故障现象及描述</em>&nbsp;: ${failure.description}</li>
					
				</ul>	
			</li>
		</#if> <!-- 故障申报 failure End -->
		
		
		<!-- 服务标签 ServiceTag -->
		<#if serviceTag?exists >
			<li>
				<strong>服务标签基本信息</strong>
				<ul> 
					<li><em>申请人</em>&nbsp;: ${serviceTag.user.name} </li>
					<li><em>标签名</em>&nbsp;: ${serviceTag.name}</li>
					<li><em>申请时间</em>&nbsp;: ${serviceTag.createTime}</li>
					
					<li><em>优先级</em>&nbsp;: 
						<#list priorityMap?keys as k >
							<#if serviceTag.priority?string == k>
								${priorityMap[k]}
							</#if>
						</#list>
					</li>
					
					<li><em>服务起止日期</em>&nbsp;: ${serviceTag.serviceStart} <em>至</em>&nbsp; ${serviceTag.serviceEnd}</li>
					<li><em>用途描述</em>&nbsp;: ${serviceTag.description}</li>
				</ul>	
			</li>
		</#if> <!-- 服务标签 ServiceTag End -->
		
		<li>
			<!-- 实例Compute -->
			<#if (computes?exists) && (computes?size > 0) >
				<strong>计算资源(PCS & ECS)</strong>
				
				<#list computes as compute>
					<ul>
						<li><em>标识符</em>&nbsp;:${compute.identifier}</li>
						<li><em>IP地址</em>&nbsp;:${compute.innerIp}</li>
						<li><em>用途信息</em>&nbsp;:${compute.remark}</li>
						<li><em>基本信息</em>&nbsp;:
						
							<#list osTypeMap?keys as k ><#if compute.osType?string == k>${osTypeMap[k]}</#if></#list>
						
							<#list osBitMap?keys as k ><#if compute.osBit?string == k>${osBitMap[k]}</#if></#list>
						
							<!-- 规格 1.PCS 2.ECS -->
							<#if compute.computeType == 1 >
								<#list pcsServerTypeMap?keys as k ><#if compute.serverType?string == k>${pcsServerTypeMap[k]}</#if></#list>
							<#else>
								<#list ecsServerTypeMap?keys as k ><#if compute.serverType?string == k>${ecsServerTypeMap[k]}</#if></#list>
							</#if>
						
					  	</li>
					  	
					  	<#if compute.mountESG?exists>
							<li><em>关联ESG</em>&nbsp;:${compute.mountESG}</li>
						</#if>
						
						<br>
					</ul>
				</#list>
				
			</#if><!-- 实例Compute End-->
		
			<!-- 存储 storage  -->
			<#if (storages?exists) && (storages?size > 0) >
				<strong>ES3存储空间</strong>
				
				<#list storages as storage>
					<ul>
						<li><em>标识符</em>&nbsp;:${storage.identifier}</li>
						<li><em>存储类型</em>&nbsp;:
							<#list storageTypeMap?keys as k ><#if storage.storageType?string == k>${storageTypeMap[k]}</#if></#list>
						</li>
						<li><em>容量空间</em>&nbsp;:${storage.space}GB</li>
						<#if storage.mountComputes?exists>
							<li><em>挂载实例</em>&nbsp;:${storage.mountComputes}</li>
						</#if>
						<br>
					</ul>
				</#list>
				
			</#if><!-- 存储 storage End-->
			
			<!-- 负载均衡器ELB -->
			<#if (elbs?exists) && (elbs?size > 0) >
				<strong>负载均衡器ELB</strong>
				
				<#list elbs as elb>
					<ul>
						<li><em>标识符</em>&nbsp;:${elb.identifier}</li>
						<li><em>负载均衡虚拟IP</em>&nbsp;:${elb.virtualIp}</li>
						<li><em>是否保持会话</em>&nbsp;:
							<#list KeepSessionMap?keys as k ><#if elb.keepSession?string == k>${KeepSessionMap[k]}</#if></#list>
						</li>
						<#if elb.mountComputes?exists>
							<li><em>关联实例</em>&nbsp;:${elb.mountComputes}</li>
						</#if>
						<li><em>端口映射(协议、源端口、目标端口)</em></li>
						
						<#list elb.elbPortItems as port>
							<ul>
								<li>&nbsp;&nbsp;${port.protocol}&nbsp;,&nbsp;${port.sourcePort}&nbsp;,&nbsp;${port.targetPort}</li>
							</ul>
						</#list>
						
						<br>
					</ul>
				</#list>
				
			</#if><!-- 负载均衡器ELB End -->
			
			<!-- EIP -->
			<#if (eips?exists) && (eips?size > 0) >
				<strong>EIP</strong>
				
				<#list eips as eip>
					<ul>
						<li><em>标识符</em>&nbsp;:${eip.identifier}</li>
						
						<li><em>IP地址</em>&nbsp;:${eip.ipAddress}</li>
						
						<li><em>ISP运营商</em>&nbsp;:
							<#list ispTypeMap?keys as k ><#if eip.ispType?string == k>${ispTypeMap[k]}</#if></#list>
						</li>
						<li>
							<#if eip.computeItem?exists>
								<em>关联实例</em>&nbsp;:${eip.computeItem.identifier}(${eip.computeItem.remark} - ${eip.computeItem.innerIp})
							</#if>
							<#if eip.networkElbItem?exists>
								<em>关联ELB</em>&nbsp;:${eip.networkElbItem.identifier}(${eip.networkElbItem.virtualIp})【${eip.networkElbItem.mountComputes}】
							</#if>
						</li>
						
						<li><em>端口映射(协议、源端口、目标端口)</em></li>
						
						<#list eip.eipPortItems as port>
							<ul>
								<li>&nbsp;&nbsp;${port.protocol}&nbsp;,&nbsp;${port.sourcePort}&nbsp;,&nbsp;${port.targetPort}</li>
							</ul>
						</#list>
						
						<br>
					</ul>
				</#list>
				
			</#if><!-- EIP End -->
			
			<!-- DNS域名映射 -->
			<#if (dnses?exists) && (dnses?size > 0) >
				<strong>DNS域名映射</strong>
				
				<#list dnses as dns>
					<ul>
						<li><em>标识符</em>&nbsp;:${dns.identifier}</li>
						
						<li><em>域名</em>&nbsp;:${dns.domainName}</li>
						
						<li><em>域名类型</em>&nbsp;:
							<#list domainTypeMap?keys as k ><#if dns.domainType?string == k>${domainTypeMap[k]}</#if></#list>
						</li>
					
						<#if dns.cnameDomain?exists && dns.domainType != 3 >
							<li><em>目标IP</em>&nbsp;:${dns.mountElbs}</li>
						<#elseif dns.cnameDomain?exists>
							<li><em>CNAME域名</em>&nbsp;:${dns.cnameDomain}</li>
						</#if>
						
						<br>
					</ul>
				</#list>
				
			</#if><!-- DNS域名映射 End -->
			
			<!-- 监控邮件列表 -->
			<#if (monitorMails?exists) && (monitorMails?size > 0) >
				<strong>监控邮件列表</strong>
				
				 <#list monitorMails as monitorMail>
					<ul>
						<li>${monitorMail.email}</li>
					</ul>
				</#list>
			
			</#if><!-- 监控邮件列表 End -->
			
			<!-- 监控手机列表 -->
			<#if (monitorPhones?exists) && (monitorPhones?size > 0) >
				<strong>监控手机列表</strong>
				
				 <#list monitorPhones as monitorPhone>
					<ul>
						<li>${monitorPhone.telephone}</li>
					</ul>
				</#list>
			
			</#if><!-- 监控手机列表 End -->
			
			<!-- ELB监控 -->
			<#if (monitorElbs?exists) && (monitorElbs?size > 0) >
				<strong>ELB监控</strong>
				
				 <#list monitorElbs as monitorElb>
				 	<ul>
					 	<li><em>标识符</em>&nbsp;:${monitorElb.identifier}</li>
						<li><em>监控ELB</em>&nbsp;:${monitorElb.networkElbItem.identifier}<#if monitorElb.networkElbItem.virtualIp?exists>(${monitorElb.networkElbItem.virtualIp})</#if></li>
						<br>
						
					</ul>
				</#list>
			
			</#if><!-- ELB监控 End -->
			
			<!-- 实例监控 -->
			<#if (monitorComputes?exists) && (monitorComputes?size > 0) >
				<strong>实例监控</strong>
				
				 <#list monitorComputes as monitorCompute>
				 	<ul>
					 	<li><em>标识符</em>&nbsp;:${monitorCompute.identifier}</li>
						<li><em>IP地址</em>&nbsp;:<#if monitorCompute.ipAddress?exists >${monitorCompute.ipAddress}</#if></li>
						
						<li><em>CPU占用率</em>&nbsp;:
						报警阀值&nbsp;<#list thresholdGtMap?keys as k ><#if monitorCompute.cpuWarn?string == k>${thresholdGtMap[k]}</#if></#list>
						&nbsp;&nbsp;
						警告阀值&nbsp;<#list thresholdGtMap?keys as k ><#if monitorCompute.cpuCritical?string == k>${thresholdGtMap[k]}</#if></#list>
						</li>
						
						<li><em>内存占用率</em>&nbsp;:
						报警阀值&nbsp;<#list thresholdGtMap?keys as k ><#if monitorCompute.memoryWarn?string == k>${thresholdGtMap[k]}</#if></#list>
						&nbsp;&nbsp;
						警告阀值&nbsp;<#list thresholdGtMap?keys as k ><#if monitorCompute.memoryCritical?string == k>${thresholdGtMap[k]}</#if></#list>
						</li>
						
						<li><em>网络丢包率</em>&nbsp;:
						报警阀值&nbsp;<#list thresholdGtMap?keys as k ><#if monitorCompute.pingLossWarn?string == k>${thresholdGtMap[k]}</#if></#list>
						&nbsp;&nbsp;
						警告阀值&nbsp;<#list thresholdGtMap?keys as k ><#if monitorCompute.pingLossCritical?string == k>${thresholdGtMap[k]}</#if></#list>
						</li>
						
						<li><em>硬盘可用率</em>&nbsp;:
						报警阀值&nbsp;<#list thresholdLtMap?keys as k ><#if monitorCompute.diskWarn?string == k>${thresholdLtMap[k]}</#if></#list>
						&nbsp;&nbsp;
						警告阀值&nbsp;<#list thresholdLtMap?keys as k ><#if monitorCompute.diskCritical?string == k>${thresholdLtMap[k]}</#if></#list>
						</li>
						
						<li><em>网络延时率</em>&nbsp;:
						报警阀值&nbsp;<#list thresholdNetGtMap?keys as k ><#if monitorCompute.pingDelayWarn?string == k>${thresholdNetGtMap[k]}</#if></#list>
						&nbsp;&nbsp;
						警告阀值&nbsp;<#list thresholdNetGtMap?keys as k ><#if monitorCompute.pingDelayCritical?string == k>${thresholdNetGtMap[k]}</#if></#list>
						</li>
						
						<li><em>最大进程数</em>&nbsp;:
						报警阀值&nbsp;<#list maxProcessMap?keys as k ><#if monitorCompute.maxProcessWarn?string == k>${maxProcessMap[k]}</#if></#list>
						&nbsp;&nbsp;
						警告阀值&nbsp;<#list maxProcessMap?keys as k ><#if monitorCompute.maxProcessCritical?string == k>${maxProcessMap[k]}</#if></#list>
						</li>
						
						<li><em>监控端口</em>&nbsp;:${monitorCompute.port}</li>
						<li><em>监控进程</em>&nbsp;:${monitorCompute.process}</li>
						<li><em>挂载路径</em>&nbsp;:${monitorCompute.mountPoint}</li>
						
						<br>
					</ul>
				</#list>
			
			</#if><!-- 实例监控 End -->
			
			<!-- MDN -->
			<#if (mdns?exists) && (mdns?size > 0) >
				<strong>MDN</strong>
			
				<#list mdns as mdn>
					<ul>
						<li><em>标识符</em>&nbsp;:${mdn.identifier}</li>
						<li><em>重点覆盖地域</em>&nbsp;:${mdn.coverArea}</li>
						<li><em>重点覆盖ISP</em>&nbsp;:
							 <#list mdn.coverIsp?split(",") as coverIsp>
								<#list ispTypeMap?keys as k ><#if coverIsp?string == k>${ispTypeMap[k]}</#if></#list>
							</#list>
						</li>
						<li><em>加速服务带宽(M)</em>&nbsp;:${mdn.bandwidth}</li>
						
						<#if (mdn.mdnVodItems?exists) && (mdn.mdnVodItems?size > 0) >
							<br>
							<ul>
								<strong>MDN点播加速</strong>
								<#list mdn.mdnVodItems as vod>
									<li><em>服务子项ID</em>&nbsp;:${vod.id}</li>
									<li><em>服务域名</em>&nbsp;:${vod.vodDomain}</li>
									<li><em>播放协议选择</em>&nbsp;:${vod.vodProtocol}</li>
									<li><em>源站出口带宽</em>&nbsp;:${vod.sourceOutBandwidth}</li>
									<li><em>Streamer地址</em>&nbsp;:${vod.sourceStreamerUrl}</li>
									<br>
								</#list>
							</ul>
						</#if>
						
						<#if (mdn.mdnLiveItems?exists) && (mdn.mdnLiveItems?size > 0) >
							<br>
							<ul>
								<strong>MDN直播加速</strong>
								<#list mdn.mdnLiveItems as live>
									<li><em>服务子项ID</em>&nbsp;:${live.id}</li>
									<li><em>服务域名</em>&nbsp;:${live.liveDomain}</li>
									<li><em>播放协议选择</em>&nbsp;:${live.liveProtocol}</li>
									<li><em>源站出口带宽</em>&nbsp;:${live.bandwidth}</li>
									<li><em>频道名称</em>&nbsp;:${live.name}</li>
									<li><em>频道GUID</em>&nbsp;:${live.guid}</li>
									<li><em>直播流输出模式</em>&nbsp;:<#list outputModeMap?keys as k ><#if live.streamOutMode?string == k>${outputModeMap[k]}</#if></#list></li>
									<#if live.streamOutMode == 1 >
										<li><em>编码器模式</em>&nbsp;:<#list encoderModeMap?keys as k ><#if live.encoderMode?string == k>${encoderModeMap[k]}</#if></#list></li>
									</#if>
									<#if live.streamOutMode == 1 >
										<#if live.encoderMode == 1>
											<#if live.httpUrl?exists>
												<li><em>拉流地址</em>&nbsp;:${live.httpUrl}</li>
											</#if>
											<#if live.httpBitrate?exists>
												<li><em>拉流混合码率</em>&nbsp;:${live.httpBitrate}</li>
											</#if>
										<#elseif live.encoderMode == 2>
											<#if live.hlsUrl?exists>
												<li><em>推流地址</em>&nbsp;:${live.hlsUrl}</li>
											</#if>
											<#if live.hlsBitrate?exists>
												<li><em>推流混合码率</em>&nbsp;:${live.hlsBitrate}</li>
											</#if>
										</#if>
									<#else>
									
										<li><em>HTTP流地址</em>&nbsp;:${live.httpUrl}</li>
										<li><em>HTTP流混合码率</em>&nbsp;:${live.httpBitrate}</li>
										
										<li><em>HSL流地址</em>&nbsp;:${live.hlsUrl}</li>
										<li><em>HSL流混合码率</em>&nbsp;:${live.hlsBitrate}</li>
									
									</#if>
									<br>
								</#list>
							</ul>
						</#if>
						<br>
					</ul>
				</#list>
			</#if><!-- MDN End -->
			
			<!-- CP云生产 -->
			<#if (cps?exists) && (cps?size > 0) >
				<strong>CP云生产</strong>
				
				<#list cps as cp>
					<ul>
						<li><em>标识符</em>&nbsp;:${cp.identifier}</li>
						<li><em>收录流URL</em>&nbsp;:${cp.recordStreamUrl}</li>
						<li><em>收录码率</em>&nbsp;:<#list recordBitrateMap?keys as k ><#if cp.recordBitrate?string == k>${recordBitrateMap[k]}</#if></#list></li>
						<li><em>输出编码</em>&nbsp;:
							 <#list cp.exportEncode?split(",") as exportEncode>
								<#list exportEncodeMap?keys as k ><#if exportEncode?string == k><br>${exportEncodeMap[k]}</#if></#list>
							</#list>
						</li>
						<li><em>收录类型</em>&nbsp;:<#list recordTypeMap?keys as k ><#if cp.recordType?string == k>${recordTypeMap[k]}</#if></#list></li>
						<li><em>收录时段</em>&nbsp;:${cp.recordTime}</li>
						<li><em>收录时长(小时)</em>&nbsp;:${cp.recordDuration}</li>
						<#if cp.publishUrl?exists><li><em>发布接口地址</em>&nbsp;:${cp.publishUrl}</li></#if>
						<li><em>是否推送内容交易平台</em>&nbsp;:<#list isPushCtpMap?keys as k ><#if cp.isPushCtp?string == k>${isPushCtpMap[k]}</#if></#list></li>
						<br>
						<li><strong>视频配置</strong></li>
						<li><em>FTP上传IP</em>&nbsp;:${cp.videoFtpIp}</li>
						<li><em>端口</em>&nbsp;:${cp.videoFtpPort}</li>
						<li><em>FTP用户名</em>&nbsp;:${cp.videoFtpUsername}</li>
						<li><em>FTP密码</em>&nbsp;:${cp.videoFtpPassword}</li>
						<li><em>FTP根路径</em>&nbsp;:${cp.videoFtpRootpath}</li>
						<li><em>FTP上传路径</em>&nbsp;:${cp.videoFtpUploadpath}</li>
						<li><em>输出组类型</em>&nbsp;:${cp.videoOutputGroup}</li>
						<li><em>输出方式配置</em>&nbsp;:<#list videoOutputWayMap?keys as k ><#if cp.videoOutputWay?string == k>${videoOutputWayMap[k]}</#if></#list></li>
						<br>
						<li><strong>图片配置</strong></li>
						<li><em>FTP上传IP</em>&nbsp;:${cp.pictrueFtpIp}</li>
						<li><em>端口</em>&nbsp;:${cp.pictrueFtpPort}</li>
						<li><em>FTP用户名</em>&nbsp;:${cp.pictrueFtpUsername}</li>
						<li><em>FTP密码</em>&nbsp;:${cp.pictrueFtpPassword}</li>
						<li><em>FTP根路径</em>&nbsp;:${cp.pictrueFtpRootpath}</li>
						<li><em>FTP上传路径</em>&nbsp;:${cp.pictrueFtpUploadpath}</li>
						<li><em>输出组类型</em>&nbsp;:${cp.pictrueOutputGroup}</li>
						<li><em>输出媒体类型</em>&nbsp;:${cp.pictrueOutputMedia}</li>
						<br>
					</ul>
				</#list>
				
			</#if><!--  CP云生产 End -->
		</li>
		
		<!-- 成本核算 -->
		<#if sumCost?exists>
			<li>
				<strong>资源服务费用</strong>
				<ul>
					<li>${sumCost}</li>
				</ul>
			</li>
		</#if><!-- 成本核算 End -->
		
		<#if passUrl?exists>
			<li>
				<strong>审批操作</strong>
				<ul>
					<li><a href="${passUrl}">1.同意</a></li>
					<li><a href="${disagreeContinueUrl}">2.不通过但继续</a></li>
					<li><a href="${disagreeReturnUrl}">3.不通过且退回</a></li>
				</ul>
			</li>
		</#if>
	</ul>

</body>
</html>


