<%@ page contentType="text/html;charset=UTF-8" import="retrobot.Project" %>
<!DOCTYPE html>
<html ng-app>
<head>
    <title>Retrobot Retrospective Projects</title>
</head>

<html>
<body>
    <g:each in="${projects}" var="project">
        <a href="${createLink(controller: 'retrospective', action: 'show')}?project=${project.id}">${project.name}</a>
        <br/>
    </g:each>
</body>
</html>