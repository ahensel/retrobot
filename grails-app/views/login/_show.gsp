<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>Retrobot Login</title>
  <link href='http://fonts.googleapis.com/css?family=Maven+Pro:400,700' rel='stylesheet' type='text/css'>
  <style type="text/css">
      body {
          font-family: 'Maven Pro', sans-serif;
          margin: 20px;
      }
  </style>
</head>
<body>
    <g:form method="POST" action="login">
        Please enter your Rally Username and Password:
        <br/><br/>
        <label for="username"><b>Username</b></label>
        <br/>
        <g:textField name="username" autofocus="autofocus" />
        <br/>
        <label for="password"><b>Password</b></label>
        <br/>
        <g:passwordField name="password" />
        <br/><br/>
        <g:submitButton name="loginBtn" value="Login"/>
    </g:form>
</body>
</html>