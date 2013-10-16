<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>用Delphi写ASP组件实现快速多文件WEB上传演示</title>
</head>
<body>
<p align="center">用Delphi写ASP组件实现快速多文件WEB上传演示</p>
<%
dim ob
dim fsize
set ob=server.createobject("ASPComponent.CoIFileUpload")
path=server.mappath(".")
fsize=ob.savefile(path,true)
response.write "<br>文本框值：" & ob.request("text1")
response.write "<br>文本域值:" & ob.request("textarea1")
response.write "<br>编码数据大小: " & fsize 
response.write "<br>文件保存路径: " & path
response.write "<br>文件1: 文件名：" & ob.Request("file1")  & ",   文件类型：" & ob.FileType("file1")  & ",   文件大小：" & ob.FileSize("file1") 
response.write "<br>文件1: 文件名：" & ob.Request("file2")  & ",   文件类型：" & ob.FileType("file2")  & ",   文件大小：" & ob.FileSize("file2") 
%>

</body>
</html>
