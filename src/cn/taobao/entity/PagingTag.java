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
//			
			w.print("<div class='page-container'>");
			w.print("<nav aria-label=\"Page navigation\">");
			w.print("<ul class=\"pagination\">");
			
			if(index==1) {
				//如果当前页是第一页，则将 "<<" 绘制成不可点击状态
				w.print("<li class=\"disabled\"><span aria-hidden=\"true\">&laquo;</span></li>");
			}else {
				w.print("<li>");
				w.print("<a href='"+actionName+"?pageIndex="+(index-1)+"' aria-label=\"Previous\">");
				w.print("<span aria-hidden=\"true\">&laquo;</span>");
				w.print("</a></li>");
			}
			
			for(int i=0;i<pageNums.length;i++) {
				if(index==pageNums[i]) {
					w.print("<li  class=\"active\"><span>"+pageNums[i]+"</span><li>");
				}else {
					w.print("<li><a href='"+ actionName +"?pageIndex="+pageNums[i]+"'>"+pageNums[i]+"</a><li>");
				}
			}
			
			if(index==pageNums.length) {
				//如果当前页是最后一页，则将 ">>" 绘制成不可点击状态
				w.print("<li class=\"disabled\"><span aria-hidden=\"true\">&raquo;</span></li>");
			}else {
				w.print("<li><a href='"+actionName+"?pageIndex="+(index+1)+"'><span aria-hidden=\"true\">&raquo;</span></a></li>");
			}
			w.print("</ul>");
			w.print("<p style=\"text-align:center;\">第 "+index+" / "+pageNums.length+" 页</p>");
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
	
	

}
