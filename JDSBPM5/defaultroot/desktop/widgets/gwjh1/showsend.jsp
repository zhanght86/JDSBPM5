<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="ww"%>
<%@page import="net.itjds.j2ee.util.UUID" %>
<%
String contextpath = request.getContextPath() + "/";
String sendid = request.getParameter("uuid");
 %>
<HTML>
<HEAD>

<TITLE>新建通知</TITLE>
<style type="text/css">
		<!--
body {font-family: "宋体", "Arial"; font-size: 9pt;background-color:#dfe8f6}
td {font-family: "宋体", "Arial"; font-size: 9pt} 
-->
		</style>
<script type="text/javascript">
	var context="/";
</script>
 
<script type="text/javascript" src="/js/extAll.js"></script>

<script type="text/javascript" src="/desktop/widgets/gwjh/js/bufadeparttree.js" defer="defer"></script>
<script type="text/javascript" src="<%=contextpath %>desktop/js/CreateGrid.js"></script>
<script  src="/js/JDS.js" type="text/javascript"></script>
<script type="text/javascript">
var processid = '<ww:property value="mettingbean.processdefid"/>';
var bsta = '<ww:property value="mettingbean.blstatus"/>';
var id = '<ww:property value="mettingbean.tid"/>';  
var sendid = '<%= sendid%>';
Ext.onReady(function(){
    	var mj = [['pt', '普通'], ['jm', '机密'], ['juem', '绝密']];

		var jjcd = [['pt', '普通'], ['jj', '紧急'], ['tj', '特急']];

		var mjstore = new Ext.data.SimpleStore({
					fields : ['value', 'text'],
					data : mj
				});

		var jjcdstore = new Ext.data.SimpleStore({
					fields : ['value', 'text'],
					data : jjcd
				});

		var combo = new Ext.form.ComboBox({
					store : mjstore,
					fieldLabel : '密 级',
					name : 'sendbean.sendMj',
					emptyText : '普通',
					mode : 'local',
					valueField : 'value',
					displayField : 'text',
					triggerAction : 'all',
					readOnly:true,
					value:'<ww:property value="dao.sendMj"/>'
				});

		var jjcdcombo = new Ext.form.ComboBox({
					store : jjcdstore,
					fieldLabel : '紧急程度',
					name : 'sendbean.sendJjcd',
					emptyText : '普通',
					mode : 'local',
					valueField : 'value',
					displayField : 'text',
					triggerAction : 'all',
					readOnly:true,
					value:'<ww:property value="dao.sendJjcd"/>'
				});
				
		var addForm = new Ext.form.FormPanel({
			labelAlign : 'left',
			labelWidth : 80,
			width:800,
			frame : true,
			url : '',
			items : [ {
			    layout:'column',
			    items:[{
			       columnWidth:.5,
			       layout:'form',
			       defaultType:'textfield',
			       items:[ 
			       {fieldLabel:'密级',readOnly:true,width:180,name:'sendbean.sendMj',value:'<ww:property value="dao.sendMj"/>'},
			       {fieldLabel:'发送人',readOnly:true,name:'sendbean.sendor',width:180,value:'<ww:property value="$currPerson.name"/>'},
			       {fieldLabel:'发送时间',width:180,readOnly:true,name:'sendbean.sendtime',value:'<ww:property value="dao.sendtime"/>'},
			       {fieldLabel:'签发时间',readOnly:true,width:180,name:'sendbean.sendSignTime',value:'<ww:property value="dao.sendSignTime"/>'},
			       {fieldLabel:'文号',readOnly:true,width:180,name:'sendbean.sendWh',value:'<ww:property value="dao.sendWh"/>'},
			       {fieldLabel:'联系人',readOnly:true,width:180,name:'sendbean.sendLxr',value:'<ww:property value="dao.sendLxr"/>'}
			
			       ]
			    },{
			       columnWidth:.5,
			       layout:'form',
			       defaultType:'textfield',
			       items:[  
			         {fieldLabel:'紧急程度',readOnly:true,width:180,name:'sendbean.sendJjcd',value:'<ww:property value="dao.sendJjcd"/>'},
			         {fieldLabel:'发送单位',readOnly:true,width:180,name:'sendbean.senddept',value:'<ww:property value="$currPerson.orgList[0].name"/>'},
			         {fieldLabel:'签发人',readOnly:true,width:180,name:'sendbean.sendSigner',value:'<ww:property value="dao.sendSigner"/>'},
			         {fieldLabel:'签发单位',readOnly:true,width:180,name:'sendbean.sendSigndept',value:'<ww:property value="dao.sendSigndept"/>'},
			         {fieldLabel:'份数',readOnly:true,width:180,name:'sendbean.sendCopy',value:'<ww:property value="dao.sendCopy"/>'},
			         {fieldLabel:'联系单位',readOnly:true,width:180,name:'sendbean.sendLxdw',value:'<ww:property value="dao.sendLxdw"/>'}
			       
			      ]}]
			},{
			  width:570,
			  height:40,
			  xtype:'textarea',
			  fieldLabel:'标题',
			  readOnly:true,
			  name:'sendbean.sendTitle',
			  value:'<ww:property value="dao.sendTitle"/>'
			},{
			  width:570,
			  height:50,
			  xtype:'textarea',
			  fieldLabel:'副标题',
			  readOnly:true,
			 name:'sendbean.sendTitle1',
			  value:'<ww:property value="dao.sendTitle1"/>'
			},{
			  width:570,
			  height:40,
			  xtype:'textarea',
			  fieldLabel:'主题词',
			  readOnly:true,
			  name:'sendbean.sendKeyWord',
			  value:'<ww:property value="dao.sendKeyWord"/>'
			
			},{
			  width:570,
			  height:40,
			  xtype:'textarea',
			  fieldLabel:'发送范围',
			  readOnly:true,
			  name:'sendbean.sendType',
			  value:'<ww:property value="dao.sendScope"/>'
			}]
	
		});
		
		addForm.render('form2');
	
});

     function save(){
			 Ext.Ajax.request({
			 	url:'gwjhAction_extrasave.action',
			 	method:'post',
			 	params:{
			 	'uuid':sendid
			 	},
			 	form:'addSend',
			 	success:function(){
			 		alert("发送成功");
			 	},failure:function(){
			 	   alert("发送失败");
			 	}
			 })
	}
	
	function goback(){
	   window.location.href="/desktop/widgets/gwjh/hassentlist.jsp";
	   
	
	}
	
	function winClose(){
		window.close();
	}
</script>

</HEAD>
<BODY>

<center>
<div id="form2"></div>
<form name="addSend" id="addSend">
<table width="800" height="227" align="center" bgcolor="#dfe8f6" style="border:1px solid #99bbe8;line-height:30px;">
<input type="hidden" name="parentid" id="parentid" value='<%=request.getParameter("parentid") %>'/>
<input type="hidden" name="tid" id="tid" value='<%=sendid %>'/><input type="hidden" name="optionnum" id="optionnum" value='1'/>

<input type="hidden" name="mettinguuid" id="mettinguuid" value='<%=request.getParameter("mettinguuid") %>'/>
<input type="hidden" name="adddirection" id="adddirection" value='2'/>
<input type="hidden" name="liststatus" id="liststatus" value='<%=request.getParameter("liststatus")%>'/>

  <tr>
    <td align="left" width="184">已发单位:&nbsp;&nbsp;&nbsp;&nbsp;</td>
    <td colspan="3"><input size="70" name="deptnames" value='<ww:property value="sandrange"/>' type="text" id="deptnames" onkeydown="return false;"  size="50"/>
    <input type="hidden" name="sentid" id="sentid" value='<ww:property value="sandrange"/>'/>
  </tr>
    <tr>
    <td align="left" width="184">补发:&nbsp;&nbsp;&nbsp;&nbsp;</td>
    <td colspan="3"><input size="70" name="bufadeptnames"  type="text" id="bufadeptnames" onkeydown="return false;"  size="50"/>
    <input type="hidden" name="id" id="id"/>
    <input type="hidden" name="yfid" id="yfid" value='<ww:property value="yfid"/>'/>
    <input name="choice" size="70" type="button" id="choice" value="选择" onclick="createPersonPositionWindow('5015','')" />&nbsp;&nbsp;
    <input type="button" name="savematter" onclick="save()" value="发送"/>&nbsp;&nbsp;
    <input type="button" name="savematter" onclick="goback()" value="返回"/>
    </tr>
  <tr>
    <td valign="top" align="left">附&nbsp;&nbsp;件:&nbsp;&nbsp;&nbsp;&nbsp;</td>
    <td>
     <ww:action name="sdocexchangefileinclude" executeResult="true"></ww:action>
    </td>
  </tr>

</table>
</form>
</center>
</BODY>
 
</HTML>