<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/layouts/taglib.jsp"%>
<html>
<head>

	<title>基础数据-Excel导入</title>
	
	<script>
		$(document).ready(function() {
			
			$("ul#navbar li#basicdata, li#excel").addClass("active");
			
			$("#inputForm").validate();
			
		});
	</script>

</script>
</head>

<body>

	<%@ include file="/WEB-INF/layouts/basicdataTab.jsp"%>
	
	<form id="inputForm" action="${ctx}/basicdata/import/save" method="post" enctype="multipart/form-data" class="form-horizontal input-form">
	
		<div class="control-group">
			<label class="control-label" for="file">选择导入的Excel</label>
			<div class="controls">
				<input type="file" id="file" name="file"  class="required">
			</div>
		</div>
		
		<div class="control-group">
			<div class="controls">
				<input class="btn btn-primary" type="submit" value="提交">
			</div>
		</div>
		
	</form>

</body>
</html>
