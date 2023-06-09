<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../common/head.jspf"%>
<%@ page import="org.json.JSONObject"%>
<%@ page import="org.json.JSONArray"%>

<c:set var="pageTitle" value="weather"></c:set>


<head>
<meta charset="UTF-8">
<title>API Test Page</title>
</head>
<body>
		<h1>API Test Result</h1>
		<table border="1">
				<tr>
						<th>ftype_nm</th>
				</tr>
				<%
				String responseBody = (String) request.getAttribute("responseBody");

				if (responseBody == null) {
					 out.println("API 호출에 실패하였습니다. 잠시 후 다시 시도해주세요.");
					    return;
				} else {
					JSONObject jsonObject = new JSONObject(responseBody);
					// jsonObject를 사용하여 처리할 코드 작성
				}
				JSONObject responseJson = new JSONObject(responseBody);
				JSONObject items = responseJson.getJSONObject("response").getJSONObject("body").getJSONObject("items");
				JSONArray itemArray = items.getJSONArray("item");

				for (int i = 0; i < itemArray.length(); i++) {
					JSONObject item = itemArray.getJSONObject(i);
				%>
				<tr>
						<td><%=item.getString("ftype_nm")%></td>

				</tr>
				<%
				}
				%>
		</table>

		<%@ include file="../common/foot.jspf"%>