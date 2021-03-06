<%@ page contentType="text/html;charset=UTF-8" import="retrobot.Project" %>
<!DOCTYPE html>
<html ng-app>
<head>
    <title>Retrobot Retrospective Projects</title>
    <link href='http://fonts.googleapis.com/css?family=Maven+Pro:400,700' rel='stylesheet' type='text/css'>
    <style type="text/css">
        body {
            margin: 20px;
            font-family: Arial, sans-serif;
        }
        div#projectSelection {
            font-family: 'Maven Pro', Arial, sans-serif;
        }
    </style>
</head>

<html>
<body>
    Projects:
    <br/><br/>
    <div id="projectSelection">
        <g:each in="${projects}" var="project">
            <a href="${createLink(controller: 'retrospective', action: 'show')}?project=${project.id}">${project.name}</a>
            <br/>
        </g:each>
    </div>
</body>
</html>