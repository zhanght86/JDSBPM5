<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String contextpath = request.getContextPath() + "/";
String inceptid = request.getParameter("uuid");
String sendid = request.getParameter("id");

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'wynotice.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
    
    <link rel="stylesheet" type="text/css" href="<%=contextpath%>js/ext/resources/css/ext-all.css" />
    <script src="<%=contextpath%>js/ext/adapter/ext/ext-base.js"></script>
    <script src='<%=contextpath%>js/ext/ext-all.js'></script>
    <!--  <script src="/desktop/widgets/gwjh/js/sendysreplylist.js"></script>-->
    <script text="text/javascript">
      var inceptid='<%=inceptid%>';
      var sendid = '<%=sendid%>';
    </script>
  </head>
  
  <body>
      <div id="grid"> 
       </div>
  </body>
   <script text="text/javascript">
      
		Ext.onReady(function() {

	// 复选框
	var sm = new Ext.grid.CheckboxSelectionModel({
				dataIndex : 'index'
			});

	// 列名称
	var cm = new Ext.grid.ColumnModel([{
				header : '回执人',
				dataIndex : 'replyperson',
				width : 100,
				sortable : true
			}, {
				header : '回执人单位',
				dataIndex : 'replydept',
				width : 100,
				sortable : true
			}, {
				header : '回执时间',
				dataIndex : 'replytime',
				width : 100,
				sortable : true
			}, {
				header : '回执内容',
				dataIndex : 'replycontent',
				width : 100,
				renderer:function(value){
				 return String.format("<input type=\"button\" value=\"查看\" onclick=\"showreplycontent('{0}')\" />",value);
				}
				
			}]);

	var proxy = new Ext.data.HttpProxy({
		url : 'nbgwjhAction_findyssendreplylist.action?uuid='+inceptid
	});

	// 链接
	var store = new Ext.data.Store({
				proxy : proxy,
				reader : new Ext.data.JsonReader({
							totalProperty : 'totalProperty',
							root : 'root'
						}, [{
									name : 'replyperson'
								}, {
									name:'replydept'
								}, {
									name:'replytime'
								}, {
									name:'replycontent'
								}])
			             });


	var pgsize = 15;
	store.load({
				params : {
					start : 0,
					limit : pgsize
				
				}
			});
	// 面板
	var grid = new Ext.grid.GridPanel({
		title : '回执列表',
		id : 'grid',
		layout : 'fit',
		bodyStyle : 'width:100%',
		autoHeight : true,
		loadMask : true,
		renderTo : 'grid',
		store : store,
		cm : cm,
		tbar : new Ext.Toolbar([
				{
					id : 'newModelButton',
					icon : "/usm/img/search.png",
					text : '返回',
					cls : "x-btn-text-icon",
					handler :function(){
					 var id = sendid;
					 window.location.href="/desktop/widgets/nbgwjh/sendreceivelist.jsp?uuid="+id;
					}
				}, {
					icon : '/usm/img/depart.gif',
					text : '刷新',
					cls : "x-btn-text-icon",
					handler : refresh
				}
				
				]),
		bbar : new Ext.PagingToolbar({
					pageSize : pgsize,
					store : store,
					displayInfo : true,
					displayMsg : '显示第{0}条到{1}条记录,一共{2}条',
					emptyMsg : "没有记录"
				})
				
	});
	
	// 刷新
	function refresh() {
		store.load({
					params : {
						start : 0,
						limit : pgsize
			
					}
				});
	}
	
	
	});
	  function showreplycontent(uuid){
        var _width = 900;
		var _height = Ext.getBody().getHeight()-40;
		var addwin = new Ext.Window({
					title : '回执信息',
					layout : 'fit',
					width : _width,
					minWidth : 350,
					height : _height,
					minHeight : 200,
					y:0,
					html:"<iframe id='djiframe' name='djiframe' width='" + (_width-10)  + "' height='" + (_height - 50) + "' src='nbgwjhAction_findsendreplyContent.action?uuid="+uuid+"'></iframe>"
				
			});
			addwin.show();
  
  }



	
    </script>
</html>
