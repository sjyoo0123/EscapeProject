<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%request.setCharacterEncoding("utf-8"); %>
<%@page import="com.esc.write.*"%>
<%@page import ="com.esc.userinfo.*" %>
<jsp:useBean id="userdao" class="com.esc.userinfo.UserinfoDAO" scope = "session"></jsp:useBean>

<%
String write_title = request.getParameter("write_title");
String write_ref = request.getParameter("write_ref");
String write_lev = request.getParameter("write_lev");
String write_step = request.getParameter("write_step");
String write_content = request.getParameter("write_content");

int user_idx = session.getAttribute("user_idx")==null||session.getAttribute("user_idx").equals("")?0:(int)session.getAttribute("user_idx");
int manager = session.getAttribute("manager")==null||session.getAttribute("manager").equals("")?0:(int)session.getAttribute("manager");
int write_notice = 0;

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/seesc/css/mainLayout.css">
<style>
a {
	text-decoration: none;
}

ul {
	list-style: none;
}

.write_title {
	text-align: center;
	font-size: 25px;
	font-weight: bold;
}

.write_table {
	margin: 0px auto;
}
</style>
</head>
<body>
	<%@include file="/header.jsp"%>
<%
sid= (String) session.getAttribute("sid");
UserinfoDTO dto = userdao.userInfo(sid);
%>
	<section>
		<article>
			<form name="qna_repWrite" action="qna_repWrite_ok.jsp" method="post"
				enctype="multipart/form-data">
					<input type="hidden" name="user_idx" value="<%=user_idx%>">
					<input type ="hidden" name = "write_ref" value = "<%=write_ref%>">
					<input type = "hidden" name = "write_step" value = "<%=write_step%>">
					<input type = "hidden" name = "write_lev" value = "<%=write_lev%>">
				<h2 class="write_title">답글쓰기</h2>
				<fieldset>
				<table class="write_table">
					<tr>
						<th>작성자</th>
							<td><input type="text" name="write_writer"
								required="required" value="<%
								String value = user_idx==0?"":dto.getUser_nic();
								out.println(value);
								%>"
								<%
								String readonly =user_idx==0?"":"readonly";
								out.println(readonly);
								%>
								></td>
					</tr>
					<tr>
						<th>글제목</th>
						<td><input type="text" name="write_title" required="required" value = "Re:)<%=write_title%>"></td>
					</tr>
					<tr>
						<th>공개여부</th>
						<td><input type="radio" name="write_open" value="0" checked>비밀글
							<input type="radio" name="write_open" value="1">공개글</td>
					</tr>
					<tr>
						<th>파일첨부</th>
						<td><input type="file" name="write_filename"></td>
					</tr>
					<tr>
						<th>글내용</th>
						<td><textarea name="write_content" rows="10" cols="50"
								required="required"></textarea></td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td><input type="password" name="write_pwd"
							required="required"></td>
					</tr>
					<tr>
						<td colspan="2" align="center"><input type="submit"
							value="등록"> <input type="reset" value="다시 작성"> <input
							type="button" value="목록"
							onclick="location.href ='/seesc/community/qna_list.jsp'"></td>
					</tr>
				</table>
			</fieldset>
			</form>
		</article>
	</section>
	<%@include file="/footer.jsp"%>
</body>
</html>