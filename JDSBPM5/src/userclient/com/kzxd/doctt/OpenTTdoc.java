package com.kzxd.doctt;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Properties;

import javax.servlet.http.HttpServletResponse;

import net.itjds.common.CommonConfig;
import net.itjds.common.database.DBBeanBase;
import net.itjds.j2ee.dao.DAOFactory;
import net.itjds.userclient.document.BpmDocumentDAO;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.Action;

public class OpenTTdoc implements Action{
	public String uuid;
	public String downloadDir ;
	public String downloadFile ;
	public String fileName;
	public InputStream inputStream;
	public String downloadFileName;
	public String rootpath ;
	private int sta;
	private String formID;
	
	public String getFormID() {
		return formID;
	}

	public void setFormID(String formID) {
		this.formID = formID;
	}

	public int getSta() {
		return sta;
	}

	public void setSta(int sta) {
		this.sta = sta;
	}

	public InputStream getInputStream() throws Exception { 

//		 ͨ�� ServletContext��Ҳ����application ����ȡ���� 
//		ServletActionContext.getResponse().setHeader("Content-Disposition","attachment;filename=" + fileName);
		return new BufferedInputStream(new FileInputStream(downloadFile));
		} 

	public String execute() throws Exception {
		
		rootpath= CommonConfig.getValue("bpm.filePath");
		getFileAttribute();//�ȸ���IDȡ�ļ�����
		downloadFile = this.downloadFile.substring(0,downloadFile.lastIndexOf("."))+"_ht.doc";
		java.io.File file = new java.io.File(downloadFile);
		downloadFile = file.getCanonicalPath();// ��ʵ�ļ�·��,ȥ�������..����Ϣ 
		//writeResponse();
//		 ������ͼ���ز��� /download �µ��ļ�, ����ʾ������ 
		if(!file.isFile()) 
		{
			fileName="�ļ�����";
			file.getParentFile().mkdirs();
			file.createNewFile();
		}
		return "success"; 
	}
	
	private void writeResponse() {

		OutputStream os = null;
		InputStream inputStream = null;
		//OgnlValueStack stack = (OgnlValueStack)Request.get("struts.valueStack");
		//response = (HttpServletResponse)stack.getContext().get(StrutsStatics.HTTP_RESPONSE);
		HttpServletResponse response = ServletActionContext.getResponse();
		try {
			os = response.getOutputStream();
			String name = "";
			
			inputStream = new BufferedInputStream(new FileInputStream(downloadFile));
			byte[] buff = new byte[1024];
			int n = 0;
			
			while((n = inputStream.read(buff)) > 0){
				os.write(buff, 0, n);
			}
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			
			if(os != null){
				try {
					os.flush();
				} catch (IOException e) {
					e.printStackTrace();
				}
				
				try {
					os.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
				os = null;
			}
			
			if(inputStream != null){
				try {
					inputStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
				inputStream = null;
			}
		}
	}


	
	//�����ݿ���ȡ���ļ��������
	
	public void getFileAttribute(){
	         		            
		
		 Connection conn = null;
			DAOFactory factory = null;
			try {
			DBBeanBase dbbase = new DBBeanBase("bpm",true);
	    	conn = dbbase.getConn();
	    	BpmDocumentDAO  attdao = new BpmDocumentDAO();
	    	attdao.setUuid(uuid);
	    	
	    	factory = new DAOFactory(conn,attdao);
	    	List dbfiles = factory.find();
	    	if(dbfiles!=null)
	    	for(int i=0;i<dbfiles.size();i++){  //ʵ��ֻ��һ��
 		   BpmDocumentDAO  ba = (BpmDocumentDAO)dbfiles.get(i);//�ļ�����Ŀ¼·�� 
     	   this.downloadDir = rootpath + ba.getFilepath(); 
     	   this.downloadFile =  rootpath+ba.getFilepath()+ba.getProcessinstid()+"."+ba.getFiletype();
	    	   this.fileName = ba.getFilename()+".pdf";
	    	}
         }catch (Exception e) {
				
				e.printStackTrace();
			}finally{
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		   }
	}

		


		

	
	/** �ṩת�������Ĺ������õ��ļ��� */ 

	public String getDownloadFileName() { 

	String downFileName = fileName; 

	try { 

	downFileName = new String(downFileName.getBytes(), "ISO8859-1"); 

	} catch (UnsupportedEncodingException e) { 

	e.printStackTrace(); 

	} 

	return downFileName; 

	} 


	/**
	 * @return the uuid
	 */
	public String getUuid() {
		return uuid;
	}
	/**
	 * @param uuid the uuid to set
	 */
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	/**
	 * @param downloadFileName the downloadFileName to set
	 */
	public void setDownloadFileName(String downloadFileName) {
		this.downloadFileName = downloadFileName;
	}

	/**
	 * @param inputStream the inputStream to set
	 */
	public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}

	public String getDownloadFile() {
		return downloadFile;
	}

	public void setDownloadFile(String downloadFile) {
		this.downloadFile = downloadFile;
	}
	
	
}