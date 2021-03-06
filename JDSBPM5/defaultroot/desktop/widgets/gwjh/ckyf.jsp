<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String contextpath = request.getContextPath() + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>公文交换--已发列表</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">

		<link rel="stylesheet" type="text/css"
			href="<%=contextpath%>js/ext/resources/css/ext-all.css" />
		<script src="<%=contextpath%>js/ext/adapter/ext/ext-base.js"></script>
		<script src='<%=contextpath%>js/ext/ext-all.js'></script>
		<!-- <script src="/desktop/widgets/gwjh/js/hassentlist.js"></script> -->
		<script text="text/javascript">
    </script>
	</head>

	<body>
		<div id="grid" style="width:100%;height:100%">
		</div>
	</body>
	<script text="text/javascript">
   Ext.onReady(function() {

	// 复选框
	var sm = new Ext.grid.CheckboxSelectionModel({
				dataIndex : 'index'
			});

	// 列名称
	var cm = new Ext.grid.ColumnModel([ sm,
			 {
				header : 'uuid',
				dataIndex : 'uuid',
				width : 100,
				hidden:true
				
			},{
				header : 'count',
				dataIndex : 'count',
				width : 100,
				hidden:true
			},{
				header : '标题',
				dataIndex : 'title',
				width : 350,
				sortable : true
			}, {
				header : '编号',
				dataIndex : 'fdbh',
				width : 170,
				sortable : true
			}, {
				header : '文号',
				dataIndex : 'wh',
				width : 170,
				sortable : true
			}, {
				header : '等级',
				dataIndex : 'jjcd',
				width : 40,
				sortable : true
			}, {
				header : '发送单位',
				dataIndex : 'senddept',
				width : 110,
				sortable : true
			}, {
				header : '发送时间',
				dataIndex : 'sendtime',
				width : 150,
				sortable : true
			}, {
				header : '发送单位数',
				dataIndex : 'copy',
				width : 80,
				sortable : true
			}, {
				header : '未收单位',
				dataIndex : 'unreceive',
				width : 80
				
			}, {
				header : '已收单位',
				dataIndex : 'receive',
				width : 80
				
			}, {
				header : '拒签单位',
				dataIndex : 'back',
				width : 80
				
			}, {
				header : '公文催收',
				dataIndex : 'sendunreceive',
				width : 75
				
			}]);

	var proxy = new Ext.data.HttpProxy({
		url : 'gwjhAction_findBydeptId.action'
	});

	// 链接
	var store = new Ext.data.Store({
				proxy : proxy,
				reader : new Ext.data.JsonReader({
							totalProperty : 'totalProperty',
							root : 'root'
						}, [    
						        {
									name : 'uuid'
								},{
									name : 'count'
								},{
									name : 'title'
									
								}, {
									name:'fdbh'
								}, {
									name:'sendor'
								}, {
									name:'wh'
								}, {
									name : 'senddept'
								}, {
									name : 'sendtime'
								}, {
									name : 'mj'
								}, {
									name : 'jjcd'
								}, {
									name : 'copy'
								}, {
									name : 'unreceive'
								}, {
									name : 'receive'
								}, {
									name : 'back'
								}, {
									name : 'sendunreceive'
								}])
			});

	var docname = new Ext.form.TextField({
				width : 100,
				name : 'title',
				allowBlank : true
			});
	var wh = new Ext.form.TextField({
				width : 100,
				name : 'wh',
				allowBlank : true
			});
	var fdbh = new Ext.form.TextField({
				width : 100,
				name : 'fdbh',
				allowBlank : true
			});
	var rdata = new Ext.form.DateField({
				width : 100,
				name : 'from',
				format : 'Y-m-d',
				cls : "x-btn-text-icon"
			});
			
	var tdata = new Ext.form.DateField({
				width : 100,
				name:'to',
				format : 'Y-m-d',
				cls : "x-btn-text-icon"
	});
	var pgsize = 30;
	// 面板
	var grid = new Ext.grid.GridPanel({
		title : '已发公文列表',
		id : 'grid',
		layout : 'fit',
		bodyStyle : 'width:100%',
		width : '1400',
		autoHeight : true,
		loadMask : true,
		renderTo : 'grid',
		store : store,
		cm : cm,
		sm:sm,
		bbar : new Ext.PagingToolbar({
					pageSize : pgsize,
					store : store,
					displayInfo : true,
					displayMsg : '显示第{0}条到{1}条记录,一共{2}条',
					emptyMsg : "没有记录"
				}),
		tbar : new Ext.Toolbar(['标题：', docname,'文号：', wh, '编号：', fdbh,'从 开始日期：',
				rdata, '至 结束时间:', tdata,
				{
					id : 'newModelButton',
					icon : "/usm/img/search.png",
					text : '查  询',
					cls : "x-btn-text-icon",
					handler : queryDj
				}, {
					icon : '/usm/img/depart.gif',
					text : '重  置',
					cls : "x-btn-text-icon",
					handler : requery
				}, {
					icon : '/usm/img/depart.gif',
					text : '刷新',
					cls : "x-btn-text-icon",
					handler : refresh
				}
				
				/*,{
					id : 'newModelButton',
					icon : "/usm/img/search.png",
					text : '删除公文',
					cls : "x-btn-text-icon",
						handler : function() {
							sendFile(Ext.getCmp('grid'));
								}
				}*/
				
				])
				
	});

	store.on('beforeload', function() {
				this.baseParams = {
					title : Ext.get('title').dom.value,
                     from : Ext.get('from').dom.value,
                      to : Ext.get('to').dom.value,
                      wh:Ext.get('wh').dom.value,
                        fdbh:Ext.get('fdbh').dom.value
					
				};
			});

	store.load({
				params : {
					start : 0,
					limit : pgsize,
					title : Ext.get('title').dom.value,
                    from : Ext.get('from').dom.value,
                    to : Ext.get('to').dom.value,
                    wh:Ext.get('wh').dom.value,
                    fdbh:Ext.get('fdbh').dom.value
				}
			});

	// 登记查询
	function queryDj() {
		store.load({
					params : {
						start : 0,
						limit : pgsize,
						title:Ext.get('title').dom.value,
                        from:Ext.get('from').dom.value,
                        to:Ext.get('to').dom.value,
                        wh:Ext.get('wh').dom.value,
                        fdbh:Ext.get('fdbh').dom.value
					}
				});
	}
	
	// 刷新
	function refresh() {
		store.load({
					params : {
						start : 0,
						limit : pgsize
			
					}
				});
	}
	

	function successload() {
		store.load({
					params : {
						start : 0,
						limit : pgsize
					}
				});
	}

	// 登记条件重置
	function requery() {
		Ext.get('title').dom.value = '';
		Ext.get('from').dom.value = '';
		Ext.get('to').dom.value = '';
		Ext.get('wh').dom.value = '';
		Ext.get('fdbh').dom.value = ''
	}
});
	
	function winOpen(uuid){
	
      var _width = 900;
		var _height = Ext.getBody().getHeight()-40;
		var addwin = new Ext.Window({
					title : '已发公文信息',
					layout : 'fit',
					width : _width,
					minWidth : 350,
					height : _height,
					minHeight : 200,
					y:0,
					html:"<iframe id='nbwjhframe' name='nbwjhframe' width='" + (_width-10)  + "' height='" + (_height - 50) + "' src='gwjhAction_findByUuid.action?uuid="+uuid+"'></iframe>"
			});
			addwin.show();
		 

	}
	
      function sendFile(grid){
  
	var selections=grid.getSelections();
	   if (selections.length==0){
	          alert('请选择需要删除的单位');
	   return;
	   }
 
	var delAllList=new Array();
	  for(var i=0;i<selections.length;i++){
	 
	   if (selections[i].get('uuid').length>0 ){  
	   
	     		  delAllList[delAllList.length]= selections[i].get('uuid');  
	     
	   }else{
		   alert("error");
	   }
	  };
	  
	   var fileList=delAllList.join();
	    Ext.Ajax.request({
	    
			  url:'gwjhAction_delete.action',
			  params:{
			  'uuids':fileList
			  },
			  method:'post',
			  success:function(){
			   alert("删除成功");
			    grid.getStore().reload();
				
			
			  },failure:function(){
	             alert("删除失败");
	           }
		  });
		  
}
		
    </script>
</html>
