<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!-- 
	不以/开始的相对路径找资源，以当前资源的路径为基准，经常容易出问题
	以/开始的相对路径找资源，以当前资源的路径为基准，以服务器的路径为标准（http://localhost:3306),需要加上项目名
	http://localhost:3306/crud
 -->
<script type="text/javascript" src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
<link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
	<!-- 员工添加的模糊框 -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
	    <div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        	<h4 class="modal-title" id="myModalLabel">员工添加</h4>
	      	</div>
			<div class="modal-body">
				<form class="form-horizontal">
					<div class="form-group">
			    		<label class="col-sm-2 control-label">empName</label>
			    		<div class="col-sm-10">
			      			<input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
			    		</div>
			  		</div>
			  		<div class="form-group">
			    		<label class="col-sm-2 control-label">email</label>
			    		<div class="col-sm-10">
			      			<input type="text" name="email" class="form-control" id="email_add_input" placeholder="xxx@qq.com">
			    		</div>
			  		</div>
			  		<div class="form-group">
			    		<label class="col-sm-2 control-label">gender</label>
			    		<div class="col-sm-10">
			      			<label class="radio-inline">
								<input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
							</label>
							<label class="radio-inline">
								<input type="radio" name="gender" id="gender2_add_input" value="F"> 女
							</label>
			    		</div>
			  		</div>
			  		<div class="form-group">
			    		<label class="col-sm-2 control-label">deptName</label>
			    		<div class="col-sm-4">
			      			<select class="form-control" name="dId" id="dept_select">
			      				<!-- 部门提交id即可 -->
			      			</select>
			    		</div>
			  		</div>
				</form>
			</div>
			<div class="modal-footer">
	        	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        	<button type="button" class="btn btn-primary" id="emp_save_btn">确定</button>
			</div>
		</div>
		</div>
	</div>

	<!-- 员工修改的模糊框 -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
	    <div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        	<h4 class="modal-title" id="myModalLabel">员工修改</h4>
	      	</div>
			<div class="modal-body">
				<form class="form-horizontal">
					<div class="form-group">
			    		<label class="col-sm-2 control-label">empName</label>
			    		<div class="col-sm-10">
			      			<p class="form-control-static" id="empName_update_static">email@example.com</p>
			    		</div>
			  		</div>
			  		<div class="form-group">
			    		<label class="col-sm-2 control-label">email</label>
			    		<div class="col-sm-10">
			      			<input type="text" name="email" class="form-control" id="email_update_input" placeholder="xxx@qq.com">
			    		</div>
			  		</div>
			  		<div class="form-group">
			    		<label class="col-sm-2 control-label">gender</label>
			    		<div class="col-sm-10">
			      			<label class="radio-inline">
								<input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
							</label>
							<label class="radio-inline">
								<input type="radio" name="gender" id="gender2_update_input" value="F"> 女
							</label>
			    		</div>
			  		</div>
			  		<div class="form-group">
			    		<label class="col-sm-2 control-label">deptName</label>
			    		<div class="col-sm-4">
			      			<select class="form-control" name="dId" id="dept_select">
			      				<!-- 部门提交id即可 -->
			      			</select>
			    		</div>
			  		</div>
				</form>
			</div>
			<div class="modal-footer">
	        	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        	<button type="button" class="btn btn-primary" id="emp_update_btn">修改</button>
			</div>
		</div>
		</div>
	</div>
	
	<!-- 搭建显示页面 -->
	<div class="container">
		<!-- 标题 -->
		<div class="row"></div>
			<div class="col-md-12">
				<h1>SSM</h1>
			</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
							
					</tbody>
				</table>
				
			</div>
		</div>
		<!-- 显示分页信息 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6" id="page_info_area">
				
			</div>
			<!-- 分页条信息 -->
			<div class="col-md-6" id="page_nav_area">
				
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
		var totalRecord;
		//1.页面加载完成以后，直接去发送一个ajax请求
		$(function(){
			toPage(1);
		});
		
		function toPage(pn){
			$.ajax({
				url:"${APP_PATH}/emps",
				data:"pn=" + pn,
				type:"get",
				success:function(result){
					//console.log(result);
					//1.解析并显示员工数据
					build_emps_table(result);
					//2.解析并显示分页信息
					build_page_info(result);
					//3.解析并显示分页条
					build_page_nav(result);
				}
			});
		}
		
		//解析并显示员工数据
		function build_emps_table(result){
			$("#emps_table tbody").empty();
			var emps = result.extend.pageInfo.list;
			$.each(emps,function(index,item){
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName)
				var genderTd = $("<td></td>").append(item.gender=="M"?"男":"女");
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>").append(item.dpartment.deptName);
				/**
				<button class="btn btn-primary btn-sm">
									<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
									编辑
								</button>
				**/
				/**
				<button class="btn btn-danger btn-sm">
									<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
									删除
								</button>
				**/
				var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
								.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
				//添加一个id属性方便后面获取
				editBtn.attr("edit-id",item.empId);
				var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
								.append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
				//append方法执行完成以后还是返回原来的元素
				$("<tr></tr>").append(empIdTd)
					.append(empNameTd)
					.append(genderTd)
					.append(emailTd)
					.append(deptNameTd)
					.append(editBtn)
					.append(delBtn)
					.appendTo("#emps_table tbody");
					
			});
		}
		//解析显示分页信息
		function build_page_info(result){
			$("#page_info_area").empty();
			$("#page_info_area").append(
					"当前" + result.extend.pageInfo.pageNum + "页,总" + 
					result.extend.pageInfo.pages + "页,总" + 
					result.extend.pageInfo.total + "条记录"); 
			totalRecord = result.extend.pageInfo.total;
		}
		
		//解析显示分页条,点击后去往下一页
		function build_page_nav(result){
			$("#page_nav_area").empty();
			//page_nav_area
			var ul = $("<ul></ul>").addClass("pagination")
			var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
			var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
			
			if (result.extend.pageInfo.hasPreviousPage == false) {
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			} else {
				//构建点击事件
				firstPageLi.click(function(){
					toPage(1);
				});
				prePageLi.click(function(){
					toPage(result.extend.pageInfo.pageNum - 1);
				});
			}
			var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
			var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
			
			if (result.extend.pageInfo.hasNextPage == false) {
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			} else {
				//构建点击事件
				nextPageLi.click(function(){
					toPage(result.extend.pageInfo.pageNum + 1);
				});
				lastPageLi.click(function(){
					toPage(result.extend.pageInfo.pages);
				});
			}
			//添加首页和前一页的按钮
			ul.append(firstPageLi).append(prePageLi);
			//1,2,3遍历提供提示
			$.each(result.extend.pageInfo.navigatepageNums, function(index,item){
				var numLi = $("<li></li>").append($("<a></a>").append(item));
				if (result.extend.pageInfo.pageNum == item) {
					numLi.addClass("active");
				}
				numLi.click(function(){
					toPage(item);
				});
				ul.append(numLi);
			});
			//添加末页和后一页的按钮
			ul.append(nextPageLi).append(lastPageLi);
			
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
		}
		
		//查询部门信息
		function getDepts(ele){
			$("#dept_select").empty();
			$.ajax({
				url:"${APP_PATH }/depts",
				type:"get",
				success:function(result){
					//console.log(result);
					/*
						{code: 100, msg: "处理成功", extend: {depts: [{deptId: 1, deptName: "开发部"}, 
					*/
					//显示部门信息在下拉表中
					//$("#empAddModal select").append("")
					$.each(result.extend.depts,function(){
						var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
						optionEle.appendTo(ele);
					});
				}
			});
		}
		
		//检验表单数据是否合规
		/*function validate_add_form(){
			//1.拿到要校验的数据，使用正则表达式
			var empName = $("#empName_add_input").val();
			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			if (!regName.test(empName)){
				alert("用户名可以是2-5个中文字符或者6-16个英文字符和数字的结合");
				return false;
			}
			return false;
		}*/
		//点击新增按钮弹出模态框并且显示部门信息
		$("#emp_add_modal_btn").click(function(){
			//发送ajax请求查询信息，显示在下拉列表中
			getDepts("#empAddModal select");
			//弹出模态框
			$("#empAddModal").modal({
				
				backdrop:"static"
			});
		});
		
		$("#emp_save_btn").click(function(){
			//1.将填写好的表单内容提交给服务器进行保存
			//提交之前先对数据进行合法性检验
			//validate_add_form();
			//2.发送ajax请求保存员工
			$.ajax({
				url:"${APP_PATH }/emp",
				type:"POST",
				data:$("#empAddModal form").serialize(),
				success:function(result) {
					//alert(result.msg);
					//员工保存成功
					//1.关闭模态板
					$('#empAddModal').modal('hide')
					//2.来到最后一页显示刚才的数据
					//发送ajax请求最后一页的数据
					toPage(totalRecord);
				}
			});
		});
		
		//点击修改按钮弹出模态框并且显示部门信息
		$(document).on("click",".edit_btn",function(){
			//发送ajax请求查询信息，显示在下拉列表中
			getDepts("#empUpdateModal select");
			//查询员工信息，显示
			getEmp($(this).attr("edit-id"));
			//弹出模态框
			$("#empUpdateModal").modal({
				
				backdrop:"static"
			});
		});
		
		function getEmp(id){
			$.ajax({
				url:"${APP_PATH }/emp/" + id,
				type:"get",
				success:function(result){
					//console.log(result);
					
					/*
						{code: 100, msg: "处理成功", extend: {depts: [{deptId: 1, deptName: "开发部"}, 
					*/
					var empData = result.extend.emp;
					$("#empName_update_static").text(empData.empName);
					$("#email_update_input").val(empData.email);
					$("empUpdateModel input[name=gender]").val([empData.gender]);
					$("empUpdateModel select").val([empData.dId]);
				}
			});
		}
		
		/*$("#emp_update_btn").click(function(){
			//1.将填写好的表单内容提交给服务器进行保存
			//提交之前先对数据进行合法性检验
			//validate_add_form();
			//2.发送ajax请求保存员工
			$.ajax({
				url:"${APP_PATH }/emp",
				type:"POST",
				data:$("#empAddModal form").serialize(),
				success:function(result) {
					//alert(result.msg);
					//员工保存成功
					//1.关闭模态板
					$('#empAddModal').modal('hide')
					//2.来到最后一页显示刚才的数据
					//发送ajax请求最后一页的数据
					toPage(totalRecord);
				}
			});
		});*/
	</script>
</body>
</html>