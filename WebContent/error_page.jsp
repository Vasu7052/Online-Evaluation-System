<%@ page isErrorPage = "true" %>

<% 

String message = "" ;

if(request.getParameter("message") != null){
	message = request.getParameter("message") ;
}else{
	message = "Something Went Wrong !! Please Try Again Later" ;
}

%>

<!DOCTYPE html>
<html>
<head>
<title>404 - Not Found</title>
<style>

body{

background-image: url(error_image.png);
background-repeat: no-repeat;
background-size: cover; 

}

#manipulate {
    position:absolute;
    width:700px;
    height:auto;
    background:transparent;
    bottom:20px;
    right:25%;
    left:50%;
    margin-left:-300px;
    text-align: center;
}

</style>
</head>
<body>


        <div id="manipulate">
            <h1 style="color: #eee "><%= message %></h1>
            <a href="index.jsp" style="color : white">Go Back to Home</a>
        </div>

</body>
</html>