<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<base href="${href}">
<title>后台管理</title>
<link rel="stylesheet" href="css/pintuer.css">
<link rel="stylesheet" href="css/dialog-min.css">
<link rel="stylesheet" href="css/admin.css">

<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/dialog-min.js"></script>
<script src="js/pintuer.js"></script>
</head>
<body>
<form method="post" action="" id="listform">
  <div class="panel admin-panel">
    <div class="panel-head"><strong class="icon-reorder"> 内容列表</strong> <a href="" style="float:right; display:none;">添加字段</a></div>
    <div class="padding border-bottom">
      <ul class="search" style="padding-left:10px;">
        <li> <a class="button border-main icon-plus-square-o" href="add.html"> 添加内容</a> </li>
        <li>搜索：</li>
        <li>首页
          <select name="s_ishome" class="input" onchange="changesearch()" style="width:60px; line-height:17px; display:inline-block">
            <option value="">选择</option>
            <option value="1">是</option>
            <option value="0">否</option>
          </select>
          &nbsp;&nbsp;
          推荐
          <select name="s_isvouch" class="input" onchange="changesearch()"  style="width:60px; line-height:17px;display:inline-block">
            <option value="">选择</option>
            <option value="1">是</option>
            <option value="0">否</option>
          </select>
          &nbsp;&nbsp;
          置顶
          <select name="s_istop" class="input" onchange="changesearch()"  style="width:60px; line-height:17px;display:inline-block">
            <option value="">选择</option>
            <option value="1">是</option>
            <option value="0">否</option>
          </select>
        </li>
        <if condition="$iscid eq 1">
          <li>
            <select name="cid" class="input" style="width:200px; line-height:17px;" onchange="changesearch()">
              <option value="">请选择分类</option>
              <option value="">产品分类</option>
              <option value="">产品分类</option>
              <option value="">产品分类</option>
              <option value="">产品分类</option>
            </select>
          </li>
        </if>
        <li>
          <input type="text" placeholder="请输入搜索关键字" value="${ keywords }" id="kw" name="keywords" class="input" style="width:250px; line-height:17px;display:inline-block" />
          <a href="javascript:void(0)" class="button border-main icon-search" onclick="changesearch()" > 搜索</a>
          <c:if test="${ keywords != null }">
	          <button type="button" class="button border-yellow" onclick="doExport()"><span class="icon-download"></span> 导出Excel</button>
          </c:if>
          </li>
      </ul>
      
    </div>
    <table class="table table-hover text-center">
      <tr>
        <th width="100" style="text-align:left; padding-left:20px;">商品ID</th>
        <th width="10%">商品类别</th>
        <th>商品名称</th>
        <th>规格型号</th>
        <th>价格</th>
        <th>库存数量</th>
        <th width="10%">生产日期</th>
        <th width="10%">已推送</th>
        <th width="310">操作</th>
      </tr>
      
      <c:forEach items="${ model.data }" var="o" >
      	<tr>
          <td style="text-align:left; padding-left:20px;"><input type="checkbox" name="gid" value="${ o.goodsid }" />
          	${o.goodsid}
          </td>
          <td class="type">${o.type.name}</td>
          <td width="10%">${o.name}</td>
          <td>${ o.spec }</td>
          <td><font color="#00CC99">￥${o.price}</font></td>
          <td>${o.amount}</td>
          <td>
          	<f:formatDate value="${ o.makedate }" />
          </td>
          <td>
          	<c:if test="${ o.push }">
          		已推送
          	</c:if>
          	<c:if test="${ !o.push }">
          		<a class="button border-main" href="javascript:void(0)" onclick="doPush(${o.goodsid}, this)">
					<span class="icon-tint"></span> 推送</a>
          	</c:if>
          </td>
          <td>
          	<div class="button-group">
				<a class="button border-main" href="javascript:void(0)" onclick="xiugai(this)">
					<span class="icon-edit"></span> 修改</a>
				<a style="display: none" class="button border-main" href="javascript:void(0)" onclick="baochun(this)">
					<span class="icon-save"></span> 保存</a>
				<a class="button border-red" href="javascript:void(0)" onclick="deldata(this)">
					<span class="icon-trash-o"></span> 删除</a>
			</div>
		  </td>
        </tr>
      </c:forEach>
      
      
      
   		 
      <tr>
        <td style="text-align:left; padding:19px 0;padding-left:20px;"><input type="checkbox" id="checkall"/>
          全选 </td>
        <td colspan="8" style="text-align:left;padding-left:20px;"><a href="javascript:void(0)" class="button border-red icon-trash-o" style="padding:5px 15px;" onclick="DelSelect()"> 删除</a> <a href="javascript:void(0)" style="padding:5px 15px; margin:0 10px;" class="button border-blue icon-edit" onclick="sorts()"> 排序</a> 操作：
          <select name="ishome" style="padding:5px 15px; border:1px solid #ddd;" onchange="changeishome(this)">
            <option value="">首页</option>
            <option value="1">是</option>
            <option value="0">否</option>
          </select>
          <select name="isvouch" style="padding:5px 15px; border:1px solid #ddd;" onchange="changeisvouch(this)">
            <option value="">推荐</option>
            <option value="1">是</option>
            <option value="0">否</option>
          </select>
          <select name="istop" style="padding:5px 15px; border:1px solid #ddd;" onchange="changeistop(this)">
            <option value="">置顶</option>
            <option value="1">是</option>
            <option value="0">否</option>
          </select>
          &nbsp;&nbsp;&nbsp;
          
          移动到：
          <select name="movecid" style="padding:5px 15px; border:1px solid #ddd;" onchange="changecate(this)">
            <option value="">请选择分类</option>
            <option value="">产品分类</option>
            <option value="">产品分类</option>
            <option value="">产品分类</option>
            <option value="">产品分类</option>
          </select>
          <select name="copynum" style="padding:5px 15px; border:1px solid #ddd;" onchange="changecopy(this)">
            <option value="">请选择复制</option>
            <option value="5">复制5条</option>
            <option value="10">复制10条</option>
            <option value="15">复制15条</option>
            <option value="20">复制20条</option>
          </select></td>
      </tr>
      <tr>
        <td colspan="9">
        	<div class="pagelist">
        		共 ${ model.total } 页
        		<c:if test="${ model.current == 1 }">
        			<a>首页</a>
        		</c:if>
	        	<c:if test="${ model.current != 1 }">
        			<a href="admin/goods/list.php">首页</a>
        		</c:if>
        		
				${model.nav}
				
				<c:if test="${ model.current == model.total }">
        			<a>尾页</a>
        		</c:if>
	        	<c:if test="${ model.current != model.total }">
        			<a href="admin/goods/list.php?pn=${model.total}">尾页</a>
        		</c:if>
			</div>
		</td>
      </tr>
    </table>
  </div>
  
  <input type="hidden" name="pn" value="1" id="pn">
</form>
<script type="text/javascript">

$(document).ready(function(){
	$(".type").dblclick(function(){
		var txt = $(this).text();
		var $select = $("<select>");
		
		$(this).html($select);
		
		$.ajax({
			url : "admin/goods/type/list.php",
			type:"get",
			data:{},
			success:function(r){
				var j = eval(r);
				var list = j.list;
				for ( var i = 0 ; i < list.length ; i++){
					//console.log(" name=" + list[i].name + " decs="+list[i].description);
					var $option = $("<option>").text(list[i].name).val(list[i].gtid);
					$select.append($option);
				}
				$select.change(function(){
					var v = $(this).val();
					var t = $(this).find("option[value='"+v+"']").text();
					//alert("你选中的是：" + t + " gtid=" + v);
					updateGtid(v,$select);
				})
			}
		})
	});
});

function updateGtid(gtid,$select){
	//获取商品的id
	var $td = $select.parent();
	
	var goodsid = $select.parent().prev("td").children("input").val();
	alert("要修改的商品ID=" + goodsid + "  类别ID=" + gtid);
	
	$.ajax({
		
		url :"rest/hongyan/goods/update/type",
		type: "post",
		data:JSON.stringify({"goodsid":goodsid, "gtid":gtid}),
		contentType:"application/json",
		success : function(r){
			var j = eval(r);
			console.log(j);
			$select.remove().hide();
			$td.text($select.find("option[value= '"+ j.gtid+"']").text());
		}
	});
}

function doExport(){
	$("#listform").attr("action", "admin/goods/search.php");	// 为表单指定提交地址
	$("#listform").submit();
}


function doPush(goodsid, a){
	alert("要推送的商品id=" + goodsid);
	$.ajax({
		
		url	: "admin/goods/push.php",
		type: "POST",
		data: {"goodsid" : goodsid},
		success : function(result){
			var json = eval(result);
			if ( json.data.code == 0 ){
				$(a).parent().text("已推送");  // 页面的按钮就成已推送
			}
			qipao(json.data.message);
		}
		
	});
}
//保存
function baochun(a){
	var $q = dialog({
		title:"确认修改",
		content:"你确定要修改吗？",
		okValue:"确定",
		ok:function(){
			baocun(a);
			doxiugai();
		},
		cancelValue:"取消",
		cancel:function(){
			console.log("取消修改了");
		}
	});
	$q.showModal().width(300);
}

function baocun(a){
	
	//获取填写的内容
	var $tr = $(a).parents("tr");
	
	var $input1 = $tr.children("td:eq(2)").children("input");//获取第1个文本框
	var $input2 = $tr.children("td:eq(3)").children("input");//获取第2个文本框
	var $input3 = $tr.children("td:eq(4)").children("input");//获取第3个文本框
	var $input4 = $tr.children("td:eq(5)").children("input");//获取第4个文本框
	var goodsid = $tr.children("td:eq(0)").children("input").val();
	
	var data = {"goodsid":goodsid,"name" : $input1.val(), "spec" : $input2.val(),
			"price" : $input3.val(), "amount" : $input4.val() };
	
	$.ajax({
		url : "admin/goods/update.php",
		type: "post",
		data: data,
		success : function(r){
			$tr.children("td:eq(2)").text($input1.val());
			$tr.children("td:eq(3)").text($input2.val());
			$tr.children("td:eq(4)").text($input3.val());
			$tr.children("td:eq(5)").text($input4.val());
			
			$(a).hide();		  //自己隐藏
			$(a).prev("a").show();//删除链接出现
		}
	
	});
}
//修改
function xiugai(a){
	var $tr = $(a).parent().parent().parent();
	//对tr中中间的几个可以修改的单元格进行文本框替换
	var $td3 = $tr.children("td:eq(2)");	//取得第3个单元格
	var $td4 = $tr.children("td:eq(3)");	//取得第4个单元格
	var $td5 = $tr.children("td:eq(4)");	//取得第5个单元格
	var $td6 = $tr.children("td:eq(5)");	//取得第6个单元格
	
	editTd($td3);	//调用函数修改单元格变成文本框
	editTd($td4);
	editTd($td5);
	editTd($td6);
	
	$(a).hide();		  //自己隐藏
	$(a).next("a").show();//保存链接出现
}

function editTd($td){
	var v = $td.text();
	var $input = $("<input>").val(v);
	$input.css("width","80px").css("height","25px");
	$td.html($input);
}

function doxiugai(){
	//
	var $q = dialog({
		content: "修改成功",
		quickClose: true
	});
	$q.show();
	setTimeout(function(){ $q.close().remove()},3000);
}

//删除
function deldata(t){
	var $t = $(t);
	queren("你确定要删除此记录吗？", $t.parent().parent().parent());
}

//搜索
function changesearch(i){
	if ( i ){
		$("#pn").val(i);  // 页码就有了
	}
	$("#listform").attr("action", "admin/goods/list.php");	// 为表单指定提交地址
	$("#listform").submit();
}

//单个删除
function del(id,mid,iscid){
	if(confirm("您确定要删除吗?")){
		
	}
}

//全选
$("#checkall").click(function(){ 
  $("input[name='gid']").each(function(){
		this.checked = !this.checked;
  });
})

//批量删除
function DelSelect(){
	$("#listform").attr("action", "admin/goods/delete.php");	// 为表单指定提交地址
	$("#listform").submit();
}

//批量排序
function sorts(){
	var Checkbox=false;
	 $("input[name='id[]']").each(function(){
	  if (this.checked==true) {		
		Checkbox=true;	
	  }
	});
	if (Checkbox){	
		
		$("#listform").submit();		
	}
	else{
		alert("请选择要操作的内容!");
		return false;
	}
}


//批量首页显示
function changeishome(o){
	var Checkbox=false;
	 $("input[name='id[]']").each(function(){
	  if (this.checked==true) {		
		Checkbox=true;	
	  }
	});
	if (Checkbox){
		
		$("#listform").submit();	
	}
	else{
		alert("请选择要操作的内容!");		
	
		return false;
	}
}

//批量推荐
function changeisvouch(o){
	var Checkbox=false;
	 $("input[name='id[]']").each(function(){
	  if (this.checked==true) {		
		Checkbox=true;	
	  }
	});
	if (Checkbox){
		
		
		$("#listform").submit();	
	}
	else{
		alert("请选择要操作的内容!");	
		
		return false;
	}
}

//批量置顶
function changeistop(o){
	var Checkbox=false;
	 $("input[name='id[]']").each(function(){
	  if (this.checked==true) {		
		Checkbox=true;	
	  }
	});
	if (Checkbox){		
		
		$("#listform").submit();	
	}
	else{
		alert("请选择要操作的内容!");		
	
		return false;
	}
}


//批量移动
function changecate(o){
	var Checkbox=false;
	 $("input[name='id[]']").each(function(){
	  if (this.checked==true) {		
		Checkbox=true;	
	  }
	});
	if (Checkbox){		
		
		$("#listform").submit();		
	}
	else{
		alert("请选择要操作的内容!");
		
		return false;
	}
}

//批量复制
function changecopy(o){
	var Checkbox=false;
	 $("input[name='id[]']").each(function(){
	  if (this.checked==true) {		
		Checkbox=true;	
	  }
	});
	if (Checkbox){	
		var i = 0;
	    $("input[name='id[]']").each(function(){
	  		if (this.checked==true) {
				i++;
			}		
	    });
		if(i>1){ 
	    	alert("只能选择一条信息!");
			$(o).find("option:first").prop("selected","selected");
		}else{
		
			$("#listform").submit();		
		}	
	}
	else{
		alert("请选择要复制的内容!");
		$(o).find("option:first").prop("selected","selected");
		return false;
	}
}

</script>
</body>
</html>