
<%@ page import="retrobot.ActionItem" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'actionItem.label', default: 'ActionItem')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-actionItem" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-actionItem" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="content" title="${message(code: 'actionItem.content.label', default: 'Content')}" />
					
						<th><g:message code="actionItem.discussionItem.label" default="Discussion Item" /></th>
					
						<g:sortableColumn property="owners" title="${message(code: 'actionItem.owners.label', default: 'Owners')}" />
					
						<th><g:message code="actionItem.retrospective.label" default="Retrospective" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${actionItemInstanceList}" status="i" var="actionItemInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${actionItemInstance.id}">${fieldValue(bean: actionItemInstance, field: "content")}</g:link></td>
					
						<td>${fieldValue(bean: actionItemInstance, field: "discussionItem")}</td>
					
						<td>${fieldValue(bean: actionItemInstance, field: "owners")}</td>
					
						<td>${fieldValue(bean: actionItemInstance, field: "retrospective")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${actionItemInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
