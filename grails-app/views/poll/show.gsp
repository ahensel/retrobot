
<%@ page import="retrobot.Poll" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'poll.label', default: 'Poll')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-poll" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-poll" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list poll">
			
				<g:if test="${pollInstance?.content}">
				<li class="fieldcontain">
					<span id="content-label" class="property-label"><g:message code="poll.content.label" default="Content" /></span>
					
						<span class="property-value" aria-labelledby="content-label"><g:fieldValue bean="${pollInstance}" field="content"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${pollInstance?.pollItems}">
				<li class="fieldcontain">
					<span id="pollItems-label" class="property-label"><g:message code="poll.pollItems.label" default="Poll Items" /></span>
					
						<g:each in="${pollInstance.pollItems}" var="p">
						<span class="property-value" aria-labelledby="pollItems-label"><g:link controller="pollItem" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${pollInstance?.retrospective}">
				<li class="fieldcontain">
					<span id="retrospective-label" class="property-label"><g:message code="poll.retrospective.label" default="Retrospective" /></span>
					
						<span class="property-value" aria-labelledby="retrospective-label"><g:link controller="retrospective" action="show" id="${pollInstance?.retrospective?.id}">${pollInstance?.retrospective?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${pollInstance?.id}" />
					<g:link class="edit" action="edit" id="${pollInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
