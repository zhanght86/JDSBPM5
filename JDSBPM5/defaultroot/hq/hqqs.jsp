<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="/struts-tags" prefix="ww"%>
<%@ page import="java.util.*" %>
<%
	String path = request.getContextPath();

	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
			String ngsj =(String)request.getAttribute("ngsj");
			String hgsj =(String)request.getAttribute("hgsj");
			String yfsj =(String)request.getAttribute("yfsj");
			String bh =(String)request.getAttribute("bh");
		
%>
<html>
	<head>
		<base href="<%=basePath%>"></base>
		<script>var context='<%=path%>';</script>
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<script type="text/javascript" src="<%=path%>js/extAll.js"></script>
		<script type="text/javascript" src="<%=path%>/js/ext/TabCloseMenu.js"></script>
		<script type="text/javascript"
			src="<%=path%>desktop/js/CreateGrid.js"></script>
		<script src="/js/JDS.js" type="text/javascript"></script>
				<script type="text/javascript">

		</script>
	</head>

    <body>
        ﻿
        <style type="text/css"> .STYLE4 {font-size: 16px}<!-- .STYLE1 {font-size: xx-large} .STYLE2 {font-size: xx-large} --> </style>
        <form id="qs" name="qs" action="HqYewuAction_updahq.action" method="post" >
       
        <input type="hidden" name="yewuuuid" id="yewuuuid" value='<ww:property value="hqy.uuid"></ww:property>' />
		<input type="hidden" name="uuid" id="uuid" value='<ww:property value="hqy.uuid"></ww:property>' />
		
        <table border="0" cellspacing="0" cellpadding="0" width="950" align="center" height="75">
            <tbody>
            <tr>
              <td width="979"><div class="STYLE2" align="center">
                  <p align="center"><strong> 发 文 呈 批 表</strong></p>
              </div></td>
            </tr>
            <tr>
              <td height="25" align="right">办文序号
              <td width="79" class="tdClass"><input name="bwxh" type="text" class="STYLE4" id="bwxh" value='<ww:property value="hqy.bwxh"/>' size="10" readonly="true"></td>
            </tr>
          </tbody>
        </table>
		<div align="center">
          <table border="1" bordercolor="#000000" cellpadding="0" cellspacing="0" width="1004" align="center" height="1203" style="width: 998px; height: 1263px">
            <tbody>
              <tr>
                <td class="tdClass" height="52" width="139" align="center"><strong>拟稿单位</strong></td>
				
                <td class="tdClass" width="157" style="text-align: left"><input name="ngdw" type="text" class="STYLE4" id="ngdw" value='<ww:property value="hqy.ngdw"/>' size="20" readonly="true"></td>
                  <td class="tdClass" width="114" align="center"><strong>拟稿人</strong></td>
                <td class="tdClass" width="166" style="text-align: left"><input name="ngr" type="text" class="STYLE4" id="ngr" value='<ww:property value="hqy.ngr"/>' size="20" readonly="true"></td>
                  <td class="tdClass" width="127" align="center">
                <p><strong>拟稿时间</strong></p>                  </td>
                  <td class="tdClass" colspan="3"><input name="ngsj" type="text" class="STYLE4" id="ngsj" value="<%=ngsj%>" size="20" readonly="true"></td>
              </tr>
              <tr>
                <td class="tdClass" height="52" align="center"><strong>核稿单位</strong></td>
                  <td class="tdClass" style="text-align: left"><input name="hgdw" type="text" class="STYLE4" id="hgdw" value='<ww:property value="hqy.hgdw"/>' size="20" readonly="true"></td>
                  <td class="tdClass" align="center"><strong>核稿人</strong></td>
                  <td class="tdClass" style="text-align: left"><input name="hgr" type="text" class="STYLE4" id="hgr" value='<ww:property value="hqy.hgr"/>' size="20" readonly="true"></td>
                  <td class="tdClass" align="center"><strong>核稿时间</strong></td>
               <td class="tdClass" colspan="3"><input name="hgsj" type="text" class="STYLE4" id="hgsj" value="<%=hgsj%>" size="20" readonly="true"></td>
              </tr>
              <tr>
                <td class="tdClass" height="52" align="center"><strong>文件类型</strong></td>
                  <td class="tdClass"><input name="wjlx" type="text" class="STYLE4" id="wjlx" value='<ww:property value="hqy.wjlx"/>' size="20" readonly="true"></td>
                  <td class="tdClass" align="center"><strong>密级</strong></td>
                    <td class="tdClass" style="text-align: center">&nbsp;明&nbsp; 文</td>
                    <td class="tdClass" align="center"><strong>紧急程度</strong></td>
                    <td class="tdClass" colspan="3" align="left">&nbsp;<select name="jjcd" class="STYLE4" id="jjcd">
			
							<option value="平急">平急</option>
							<option value="加急">加急</option>
							<option value="特急">特急</option>
							<option value="特提">特提</option>
						</select>
						<script type="text/javascript">
							
							document.getElementById('jjcd').value = '<ww:property value="hqy.jjcd"></ww:property>';
						</script>				</td>
                  
              </tr>
              <tr>
                <td class="tdClass" height="52" align="center"><strong>文件编号</strong></td>
                  <td class="tdClass" colspan="3" align="left"><input name="wjbh" type="text" class="STYLE4" id="wjbh" value="<%=bh%>" size="40" readonly="true"></td>
                  <td class="tdClass" align="center"><strong>公开方式</strong></td>
                  <td class="tdClass" colspan="3" align="left"> <input name="gkfs" type="text" class="STYLE4" id="gkfs" value='<ww:property value="hqy.gkfs"/>' size="20" readonly="true"></td>
              </tr>
              <tr>
                <td class="tdClass" height="52" align="center"><strong>文件标题</strong></td>
                  <td class="tdClass" height="54" colspan="7"><textarea name="bt" cols="70" rows="2" class="STYLE4" readonly="true"><ww:property value="hqy.bt"></ww:property></textarea></td>
              </tr>
              <tr>
                <td class="tdClass" height="52" align="center"><strong>主送</strong></td>
                  <td class="tdClass" height="51" colspan="2"><input name="zs" type="text" class="STYLE4" id="zs" value='<ww:property value="hqy.zs"/>' size="20" readonly="true"></td>
                  <td class="tdClass" height="51" align="center"><strong>抄送</strong></td>
                  <td class="tdClass" height="51" colspan="4"><input name="cs" type="text" class="STYLE4" id="cs" value='<ww:property value="hqy.cs"/>' size="20" readonly="true"></td>
              </tr>
              <tr>
                <td  class="tdClass" height="250" align="center">
                  <p>&nbsp;</p>
                  <p><strong>拟</strong></p><br>
                  <p><strong>办</strong></p><br>
                  <p><strong>意</strong></p><br>
                  <p><strong>见</strong></p><br>

                  <p>&nbsp;</p>                  </td>
                  <td class="tdClass" height="250" valign="top" colspan="7">&nbsp;<textarea name="nbyj" cols="70" rows="15" class="STYLE4" readonly="true"><ww:property value="hqy.nbyj"></ww:property></textarea><br>
                  </td>
              </tr>
              <tr>
                <td class="tdClass" height="200" align="center">
                  <p><strong>审</strong></p><br>
                  <p><strong>核</strong></p><br>
                  <p><strong>意</strong></p><br>
                  <p><strong>见</strong></p><br>
                   <p>&nbsp;</p>
              </td>
                  <td class="tdClass" height="183" valign="top" colspan="7">
                  <ww:iterator value="shyj" status="status">
                  	 <ww:property value="shyj[#status.index]"/><br>
                  </ww:iterator>
                  </td>
              </tr>
              <tr>
                <td class="tdClass" height="300" align="center">
                  <p><strong>领</strong></p><br>
                  <p><strong>导</strong></p><br>
                  <p><strong>审</strong></p><br>
                  <p><strong>签</strong></p><br>
                   <p>&nbsp;</p>
                </td>
                  <td class="tdClass" height="183" valign="top" colspan="3">
                  <ww:iterator value="ldsq" status="status">
                  	 <ww:property value="ldsq[#status.index]"/><br>
                  </ww:iterator></td>
                  <td class="tdClass" height="183" align="center">
                    <p><strong>签</strong></p><br>
                    <p><strong>发</strong></p><br>
                     <p>&nbsp;</p></td>
                  <td class="tdClass" height="183" valign="top" colspan="3">
                   <ww:iterator value="hqyj" status="status">
                  	 <ww:property value="hqyj[#status.index]"/><br>
                  </ww:iterator></td>
              </tr>
              <tr>
                <td class="tdClass" height="45" colspan="2" align="center"><strong>印发份数：<input name="yffs" type="text" class="STYLE4" id="yffs" value='<ww:property value="hqy.yffs"/>' size="10">份</strong></td>
                  <td class="tdClass" height="45" colspan="2"><strong>印发时间：<input name="yfsj" type="text" class="STYLE4" id="yfsj" value="<%=yfsj%>" size="10"></strong></td>
                  <td class="tdClass" height="45" align="center"><strong>校对</strong></td>
                <td width="99" class="tdClass"><input name="xd" type="text" class="STYLE4" id="xd" value='<ww:property value="hqy.xd"/>' size="10"></td>
                  <td class="tdClass" height="45" width="66" align="center"><strong>打字</strong></td>
                <td width="112" class="tdClass"><input name="dz" type="text" class="STYLE4" id="dz" value='<ww:property value="hqy.dz"/>' size="10"></td>
              </tr>
              <tr>
					<td height="150" align="center" class="tdClass" >
						<div align="center">
							<p class="STYLE4">
								正					</p>
							<p class="STYLE4">
								文					 </p>
						<p>&nbsp;</p></div></td>
					<td colspan="7" style="width:50px" class="tdClass">
						
						<ww:action name="zhengwen" executeResult="true"></ww:action>			
					</td>
			  </tr>
				
                  <tr>
					<td height="150" align="center" class="tdClass" >
						<div align="center">
							<p class="STYLE4">
								附							</p>
							<p class="STYLE4">
								件							</p>
						 <p>&nbsp;</p></div></td>
					<td colspan="7" style="width:50px" class="tdClass">
						
						<ww:action name="hqdocexchangefileinclude" executeResult="true"></ww:action>			
					</td>
				</tr>
                
            </tbody>
          </table>
        </div>
       
    </body>
</html>




	<c:forEach items="${menuList}" var="menu">
				<c:if test="${menu.moduleId == module.id }">
				 	<div class="nav-item">
				 		<img src="${menu.menuPA}"/><a href="${menu.resourceContent}" class="ziTi1" target="mainFrame">${menu.menuName}</a>
				 	</div>
			 	</c:if>
		 	</c:forEach>
