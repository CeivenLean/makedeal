package cn.taobao.entity;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

public class PagingTag extends TagSupport {

	private static final long serialVersionUID = -2327623296908382985L;
	
	private String actionName;
	private String pageSize;
	private String pageIndex;
	private String recordCount;
	private int[] pageNums=new int[0];
	private String pagelinkstyle;
	private String pagelinkstyle1;
	private String pointstyle;
	private String currentpagestyle;
	@Override
	public int doAfterBody() throws JspException {
		return super.doAfterBody();
	}
	@Override
	public int doEndTag() throws JspException {
		return super.doEndTag();
	}
	@Override
	public int doStartTag() throws JspException {
		try {
			JspWriter w=this.pageContext.getOut();
			int size=Integer.parseInt(pageSize);
			int index=Integer.parseInt(pageIndex);
			int recordCounts=Integer.parseInt(recordCount);
			int pages=recordCounts/size;
			if(recordCounts%size!=0) {
				pages++;
			}
			w.print("<div class='page-container'>");
			w.print("<table width='450px' align='center' class='mypage'>");
			w.print("<tr>");
			w.print("<form action='"+actionName+"'");
			w.print("<td height='25' align='center'>");
			w.print("<a class='pagelinkstyle1' href='"+actionName+"?pageIndex=1'>首页</a>");
			w.print("<a class='pagelinkstyle1' href='"+actionName+"?pageIndex="+(index-1)+"'>上一页</a>");
			for(int i=0;i<pageNums.length;i++) {
				if(index==pageNums[i]) {
					w.print("<span class='currentpagestyle'>"+pageNums[i]+"</span>");
				}else {
					w.print("<a class='pagelinkstyle' href='"+ actionName +"?pageIndex="+pageNums[i]+"'>"+pageNums[i]+"</a>");
				}
			}
			w.print("<a class='pagelinkstyle1' href='"+actionName+"?pageIndex="+(index+1)+"'>下一页</a>");
			w.print("<a class='pagelinkstyle1' href='"+actionName+"?pageIndex="+pages+"'>尾页</a>");
			w.print("<input type='text' name='pageIndex' style='width:20px' value='"+pageIndex+"'>");
			w.print("<input type='submit' value='GO'>");
			w.print("</td>");
			w.print("</form>");
			w.print("</tr>");
			w.print("</table>");
			w.print("</div>");
		}catch(Exception e) {
			e.printStackTrace();
		}
		return SKIP_BODY;
	}
	public String getActionName() {
		return actionName;
	}
	public void setActionName(String actionName) {
		this.actionName = actionName;
	}
	public String getPageSize() {
		return pageSize;
	}
	public void setPageSize(String pageSize) {
		this.pageSize = pageSize;
	}
	public String getPageIndex() {
		return pageIndex;
	}
	public void setPageIndex(String pageIndex) {
		this.pageIndex = pageIndex;
	}
	public String getRecordCount() {
		return recordCount;
	}
	public void setRecordCount(String recordCount) {
		this.recordCount = recordCount;
	}
	public int[] getPageNums() {
		return pageNums;
	}
	public void setPageNums(int[] pageNums) {
		this.pageNums = pageNums;
	}
	public String getPagelinkstyle() {
		return pagelinkstyle;
	}
	public void setPagelinkstyle(String pagelinkstyle) {
		this.pagelinkstyle = pagelinkstyle;
	}
	public String getPagelinkstyle1() {
		return pagelinkstyle1;
	}
	public void setPagelinkstyle1(String pagelinkstyle1) {
		this.pagelinkstyle1 = pagelinkstyle1;
	}
	public String getPointstyle() {
		return pointstyle;
	}
	public void setPointstyle(String pointstyle) {
		this.pointstyle = pointstyle;
	}
	public String getCurrentpagestyle() {
		return currentpagestyle;
	}
	public void setCurrentpagestyle(String currentpagestyle) {
		this.currentpagestyle = currentpagestyle;
	}
	
	
	

}
