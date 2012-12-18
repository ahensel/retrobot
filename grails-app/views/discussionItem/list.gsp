
<%@ page import="retrobot.DiscussionItem" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'discussionItem.label', default: 'DiscussionItem')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-discussionItem" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-discussionItem" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="content" title="${message(code: 'discussionItem.content.label', default: 'Content')}" />
					
						<th><g:message code="discussionItem.retrospective.label" default="Retrospective" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${discussionItemInstanceList}" status="i" var="discussionItemInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${discussionItemInstance.id}">${fieldValue(bean: discussionItemInstance, field: "content")}</g:link></td>
					
						<td>${fieldValue(bean: discussionItemInstance, field: "retrospective")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${discussionItemInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
