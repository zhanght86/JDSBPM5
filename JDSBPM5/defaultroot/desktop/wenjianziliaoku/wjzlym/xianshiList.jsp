﻿<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="ww"%>
<%
	String path = request.getContextPath();
 	String personId =session.getAttribute("personId").toString();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	request.setCharacterEncoding("UTF-8");

	String catalogUuid = request.getParameter("catalogUuid");
	 
	

%>
<html>
	<head>
		<title>文件资料列表</title>
		<base href="<%=basePath%>">
		<script>var context='<%=path%>';</script>


		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />

		<script type="text/javascript" src="<%=path%>js/extAll.js"></script>
		<script type="text/javascript" src="<%=path%>/js/ext/TabCloseMenu.js"></script>
	
	</head>
	
	<body>
		<div id="grid"></div>
		<div id="form"></div>
	</body>
</html>

<script type="text/javascript">
	//链接（）
		var proxy = new Ext.data.HttpProxy({
			url : 'wjzlMeteriaAction_showList.action?catalogUuid=<%=catalogUuid%>'
		});
		
		var store = new Ext.data.Store({
			proxy : proxy,
			reader : new Ext.data.JsonReader({
				totalProperty : 'totalProperty',
				root : 'root'
			}, [{
				name : 'meterialWenhao'
			},{
				name : 'meterialTitle'
			}, {
				name : 'creatorName'
			}, {
				name : 'createDate'
			},  {
				name : 'meterailzhxgsj'
			}, {
				name : 'meterialBianhao'
			}, {
				name : 'uuid'
			}, {
				name : 'creatorUuid'
			}])
		});
		
		Ext.onReady(function() {
		   // 复选框
			var sm = new Ext.grid.CheckboxSelectionModel ({
	              dataIndex : 'index',
	              renderer:function(value,cellmeta,record){                              
	               if(record.get("creatorUuid")== '<%=personId%>'){   
	                     return "<div class=\"x-grid3-row-checker\">&#160;</div>";      
	               }
	               else{
	                      return " ";
	               }
                },  
                
         // 不允许使用点击表格形式修改选择  
              handleMouseDown:Ext.emptyFn                        
			});
		
			// 列名称
			var cm = new Ext.grid.ColumnModel([sm,{
				header : 'uuid',
				dataIndex : 'uuid',
				width : 100,
				hidden:true
			},{
				header : '标题',
				dataIndex : 'meterialTitle',
				width : 550,
				sortable : true
			},{
				header : '文号',
				dataIndex : 'meterialWenhao',
				width : 140,
				sortable : true
			}, {
				header : '编号',
				dataIndex : 'meterialBianhao',
				width : 120,
				sortable : true
			},{
				header : 'creatorUuid',
				dataIndex : 'creatorUuid',
				width : 120,
				hidden:true
			}, {
				header : '登记人',
				dataIndex : 'creatorName',
				width : 80,
				sortable : true
			}, {
				header : '登记时间',
				dataIndex : 'createDate',
				width : 120,
				sortable : true
			},  {
				header : '最后修改时间',
				dataIndex : 'meterailzhxgsj',
				width : 120,
				sortable : true
			}]);
		
			var pgsize = 20;
			
			var docname = new Ext.form.TextField({
				width : 100,
				name : 'title',
				allowBlank : true
			});
			var wh = new Ext.form.TextField({
				width : 50,
				name : 'wh',
				allowBlank : true
			});
			var bh = new Ext.form.TextField({
				width : 50,
				name : 'bh',
				allowBlank : true
			});
			var djr = new Ext.form.TextField({
				width : 50,
				name : 'djr',
				allowBlank : true
			});
			var zhutici = new Ext.form.TextField({
				width : 50,
				name : 'zhutici',
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
	
			// 面板
			var grid = new Ext.grid.GridPanel({
				title : '',
				layout : 'fit',
				id : 'grid',
				bodyStyle : 'width:100%',
				autoHeight : true,
				loadMask : true,
				renderTo : 'grid',
				store : store,
				cm : cm,
				sm : sm,
				bbar : new Ext.PagingToolbar({
					pageSize : pgsize,
					store : store,
					displayInfo : true,
					displayMsg : '显示第{0}条到{1}条记录,一共{2}条',
					emptyMsg : "没有记录"
				}),
				tbar : new Ext.Toolbar(
				['标题:', docname,'-','主题词：', zhutici,'-', '文号：', wh,'-','编号：', bh,'-','登记人：', djr,'-','从 开始日期：',
					rdata, '至 结束日期:', tdata,{
						id : 'newModelButton',
						icon : "/usm/img/search.png",
						text : '查询',
						cls : "x-btn-text-icon",
						handler : queryZL
					},'-',{
						icon : '/usm/img/depart.gif',
						text : '重置',
						cls : "x-btn-text-icon",
						handler : requery
					},'->',{
					text : '登记',
					icon : '/usm/img/add.gif',
					cls : "x-btn-text-icon",
					handler : function(){
						if ('<%=catalogUuid%>' == 'null' || '<%=catalogUuid%>'=='0') {
							alert('请选择需要添加资料的目录');
							return;
						}
						if ('<ww:property value="isRoot"/>' == '1') {
							alert('请选择需要添加资料的子目录');
							return;
						}
						
						
						var _width = 960;
						var _height = Ext.getBody().getHeight()-10;
						
						var addwin = new Ext.Window({
						title : '添加文件资料信息',
						layout : 'fit',
						width : _width,
						minWidth : 450,
						height : _height,
						minHeight : 260,
						y:0,
						html:"<iframe id='addiframe' name='addiframe' width='" + (_width-20)  + "' height='" + (_height - 70) + "' src='wjzlMeteriaAction_addWjzl.action?catalogUuid=<%=catalogUuid%>'></iframe>",
						tbar:[{
							id : 'rjsave',
							icon : "/usm/img/save.gif",
							text : '保存',
							cls : "x-btn-text-icon",
							handler : function(){
								var fn = Ext.get('addiframe').dom.contentWindow.document.getElementById("add");
								
								//判断标题不能为空
								var biaoti = Ext.get('addiframe').dom.contentWindow.document.getElementById("wjzl.meterialTitle");
								if(biaoti.value == ""){
									//alert(biaoti.value);
									alert("标题不允许为空，请填写标题");
									return;
								}
								
								//附件不能为空
								var temp = document.getElementById('addiframe');
								//var formid = temp.contentWindow.getActiveFormId();
								
								//********************************************************************
								var count = temp.contentWindow.getCount();
								//var temp1 = Ext.get('addiframe');
								//var obj = temp1.down(formid);
					          	if(count==0){
						           	alert("附件不能为空");
						            return;
					           	}
					           	
								fn.submit();
								alert('保存成功');
								store.reload();
								addwin.close();
							}
						},{
							id : 'rjreset',
							icon : "/usm/img/depart.gif",
							text : '重 置',
							cls : "x-btn-text-icon",
							handler : function(){
								var fn = Ext.get('addiframe').dom.contentWindow.document.getElementById("add");
								fn.reset();
							}
						}
					]
				});
				
				addwin.show();
						
			}
		
			},'-',{
				text : '删除',
				icon : '/usm/img/delete.gif',
				cls : "x-btn-text-icon",
				handler : function() {
				    var st=store;
					var deluuid = new Array();
					var selections = grid.getSelectionModel().getSelections();
					if (selections.length == 0) {
						alert('请选择需要删除的文件');
						return;
					}
	
					var delAllList = new Array();
					for (var i = 0; i < selections.length; i++) {
						if (selections[i].get('uuid').length > 0) {
							delAllList[delAllList.length] = selections[i].get('uuid');
						} else {
							grid.getSelectionModel().deselectRow(selections[i].get('index'));
						}
					}
					
					deluuid = delAllList.join();
					
					Ext.Ajax.request({
						url : 'wjzlMeteriaAction_deleteWjzl.action',
						params : {
							uuid : deluuid
						},
						success : function(resp, opts) {
							Ext.Msg.alert('信息', '删除成功!');
							store.load({
								params : {
									start : 0,
									limit : pgsize
								}
							});
	                             
						},
						failure : function(resp, opts) {
							Ext.Msg.alert('信息', '删除失败!');
						}
					});
				}
			}
			/*,'-',{
				text : '归档',
				icon : '/usm/img/save.gif',
				cls : "x-btn-text-icon",
				handler : function() {
				    var st=store;
					var deluuid = new Array();
					var selections = grid.getSelectionModel().getSelections();
					if (selections.length == 0) {
						alert('请选择需要归档的文件');
						return;
					}
	
					var delAllList = new Array();
					for (var i = 0; i < selections.length; i++) {
						if (selections[i].get('uuid').length > 0) {
							delAllList[delAllList.length] = selections[i].get('uuid');
						} else {
							grid.getSelectionModel().deselectRow(selections[i].get('index'));
						}
					}
					
					deluuid = delAllList.join();
					
					Ext.Ajax.request({
						url : 'wjzlMeteriaAction_addGuidang.action',
						params : {
							uuid : deluuid
						},
						success : function(resp, opts) {
							var textstr = resp.responseText;
							if(textstr == "false"){
								Ext.Msg.alert('信息','您选中的资料中有已经归档过的资料，部门或全部归档失败！');
							} else {
								Ext.Msg.alert('信息', '归档成功!');
							}
					    
						},
						failure : function(resp, opts) {
							Ext.Msg.alert('信息', '归档失败!');
						}
					});
				}
			}*/
			])
		});
	
		store.load({
			params : {
				start : 0,
				limit : pgsize
			
			}
		});
		
		//模糊查询
		function queryZL() {
			if ('<%=catalogUuid%>' == 'null' || '<%=catalogUuid%>'=='0') {
				alert('请选择要查询的资料所在的目录');
				return;
			}
			
			var ks = Ext.get('from').dom.value;
			var js = Ext.get('to').dom.value;
			
			store.load({
				params : {
					start : 0,
					limit : pgsize,
					biaoti : Ext.get('title').dom.value,
					zhutici : Ext.get('zhutici').dom.value,
					wh : Ext.get('wh').dom.value,
					bh : Ext.get('bh').dom.value,
					djr : Ext.get('djr').dom.value,
					from : ks,
					to : js
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
	
		// 查询条件重置
		function requery() {
			Ext.get('title').dom.value = '';
			Ext.get('from').dom.value = '';
			Ext.get('to').dom.value = '';
			Ext.get('zhutici').dom.value = '';
			Ext.get('wh').dom.value = '';
			Ext.get('bh').dom.value = '';
			Ext.get('djr').dom.value = '';
			
		}
		
	});
	
	//显示修改数据页面的方法
		function updatepage(){
			var records = Ext.getCmp('grid').getSelectionModel().getSelections();
			if (records.length == 0) {
				alert("请选择需要修改的资料");
				return;
			} else if (records.length > 1) {
				alert("请进行单项选择");
				return;
			}
			var _record = Ext.getCmp('grid').getSelectionModel().getSelected();
			
			//调用修改方法
		    showupdatewin(_record.get("uuid"));
		}
	
		function showupdatewin(uuid){
			var _width = 900;
			var _height = 580;
			
			var updatewin = new Ext.Window({
					title : '修改文件资料信息',
					layout : 'fit',
					width : _width,
					minWidth : 350,
					height : _height,
					minHeight : 200,
					y:0,
					html:"<iframe id='updateiframe' name='zbiframe' width='" + (_width-30)  + "' height='" + (_height - 70) + "' src='wjzlMeteriaAction_updateWjzl.action?uuid="+uuid+"'></iframe>",
					tbar:[{
						id : 'rjsave',
						icon : "/usm/img/save.gif",
						text : '修  改',
						cls : "x-btn-text-icon",
						handler : function(){
							var fn = Ext.get('updateiframe').dom.contentWindow.document.getElementById("update");
							fn.submit();
							store.reload();
							updatewin.close();
						}
					}]
			});
			updatewin.show();
		}
			//显示数据页面的方法
		function viewpage(uuid){
			//调用修改方法
		    showwin(uuid);
		}
		function showwin(uuid){
			var _width = 900;
			var _height = 580;
			
			var updatewin = new Ext.Window({
					title : '查看文件资料信息',
					layout : 'fit',
					width : _width,
					minWidth : 350,
					height : _height,
					minHeight : 200,
					y:0,
					html:"<iframe id='updateiframe' name='zbiframe' width='" + (_width-30)  + "' height='" + (_height - 70) + "' src='wjzlMeteriaAction_viewWjzl.action?uuid="+uuid+"'></iframe>"
			});
			updatewin.show();
		}	
</script>