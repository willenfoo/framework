<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/taglibs.jsp" %> 
<!DOCTYPE html PUBLIC>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/WEB-INF/views/common/common.jsp" %>
</head>
<body>
    <shiro:hasPermission name="user_delete">
         <input type="hidden" id="deleteAuth" value="Y"/>
    </shiro:hasPermission>
	<table class="easyui-datagrid" fit="true" style="height: 515px;"   <shiro:hasPermission name="user_find"> url="<c:url value="/user/find"> </c:url>" </shiro:hasPermission>  id="grid"  title="数据列表" 
	     data-options="<shiro:hasPermission name="user_update">onDblClickCell: function(index,field,value){update('user/toUpdate','修改',400,320);}</shiro:hasPermission>" 
	     singleSelect="true" rownumbers="true" pagination="true" toolbar="#toolbar">
		<thead>
			<tr>
				<th data-options="field:'userName',width:80">用户名</th>
				<th data-options="field:'fullName',width:80">用户全名</th>
				<th data-options="field:'genderText',width:60">性别</th>
				<th data-options="field:'age',width:60">年龄</th>
				<th data-options="field:'mobile',width:90">移动电话</th>
				<th data-options="field:'description',width:120">描述</th>
				<th data-options="field:'statusText',width:60">用户状态 </th>
				<th data-options="field:'createTime',width:140" formatter=dateFormatByEasyui>创建时间</th>
				<th field="action" width="80" formatter="formatterAction">操作</th>
			</tr>
		</thead>
	</table>

	<div id="toolbar" style="padding: 5px; height: auto">
		<div style="margin-bottom: 5px">
		    <shiro:hasPermission name="user_add">
		         <a href="javascript:void(0);" onclick="add('user/toAdd','添加',400,320);" class="easyui-linkbutton" iconCls="icon-add" plain="true" title="添加">添加</a>
		    </shiro:hasPermission>
			
			<shiro:hasPermission name="user_update">
		         <a href="javascript:void(0);" onclick="update('user/toUpdate','修改',400,320);" class="easyui-linkbutton" iconCls="icon-edit" plain="true" title="修改">修改</a>
		    </shiro:hasPermission>
			
			<shiro:hasPermission name="user_assign_role">
		         <a href="javascript:void(0);" class="easyui-linkbutton" onclick="assignRole();" plain="true" title="分配角色">分配角色</a>
		    </shiro:hasPermission>
			
		</div>
		<div id="searchDiv"> 
		    <shiro:hasPermission name="user_find">
		    <form id="searchForm">
		         <table>
		             <tr>
		                 <td>
		                                                         用户名:
		                 </td>
		                 <td>
		                     <input style="width: 120px" name="userName"  class="easyui-validatebox" data-options="required:false,validType:['length[0,20]']"/>  
		                 </td>
		                 <td>
		                                                         性别:
		                 </td>
		                 <td>
		                     <input class="easyui-combobox" 
					            name="gender"
					            data-options="
					                    editable:false,
					                    url:'code/findByGroupNo?groupNo=gender',
					                    method:'get',
					                    valueField:'itemKey',
					                    textField:'itemValue',
					                    panelHeight:'auto'
					            ">  
		                 </td>
		                 <td>
		                                                        年龄:
		                 </td>
		                 <td>
		                     <input style="width: 120px" name="age" class="easyui-numberbox"  data-options="min:18,max:199,required:false" />  
		                 </td>
		                 <td>
		                                                         移动电话:
		                 </td>
		                 <td>
		                     <input style="width: 120px" name="mobile"  class="easyui-validatebox" data-options="required:false,validType:['length[11,11]']" />  
		                 </td>
		                 <td>
		                 </td>
		                 <td>
		                     <a href="javascript:void(0);" onclick="searchData();" class="easyui-linkbutton" iconCls="icon-search">搜索</a>
		                 </td>
		             </tr>
		         </table>
			</form>
			</shiro:hasPermission>
		</div>
	</div>
	<script type="text/javascript">
		function formatterAction(value, row, index) {
			var deleteAuth = $("#deleteAuth").val();
			if ("Y" == deleteAuth) {
				return "<a href='javascript:void(0);' onclick='delById(\"user/delete\","+row.id+");'>删除</a>";
			}
			return "";
		}
		
		function isExistByUserName() {
			if ($("#form").find("#userName").length <= 0) {
				return false;
			}
			var flag = true;
			if ($("#form").find("#userName").validatebox("isValid")) {
				var userName = $("#form").find("#userName").val();
				var sendData = {userName: userName};
		    	ajaxPost("user/isExistByUserName",sendData, function (resultData) {
		    		if ("200" == resultData.code) {
		    			flag = false;
		    		} else {
		    			showMsg(resultData.msg);
		    			flag = true;
		    		}
				}, false);
			} 
			return flag;
		}
		
		function toSubmitForm() {
			if (!isExistByUserName()) {
				submitForm();
			}
		}
		
		function assignRole() {
			var row = getSelected();
			if (row) {
				$("#dialogDiv").dialog({
				    title: '分配角色',
				    href: 'role/toAssignRole?userId='+row.id,
				    width: 600,
				    height: 450,
				    onClose:function(){
				    	namespace = "";
			    	},
			    	onOpen:function(){
			    		namespace = "role";
			    	},
				}).dialog('open');
			}
		}
	</script>
</body>
</html>