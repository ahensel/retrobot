
<%@ page import="retrobot.ActionItem" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'actionItem.label', default: 'ActionItem')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-actionItem" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-actionItem" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list actionItem">
			
				<g:if test="${actionItemInstance?.content}">
				<li class="fieldcontain">
					<span id="content-label" class="property-label"><g:message code="actionItem.content.label" default="Content" /></span>
					
						<span class="property-value" aria-labelledby="content-label"><g:fieldValue bean="${actionItemInstance}" field="content"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${actionItemInstance?.discussionItem}">
				<li class="fieldcontain">
					<span id="discussionItem-label" class="property-label"><g:message code="actionItem.discussionItem.label" default="Discussion Item" /></span>
					
						<span class="property-value" aria-labelledby="discussionItem-label"><g:link controller="discussionItem" action="show" id="${actionItemInstance?.discussionItem?.id}">${actionItemInstance?.discussionItem?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${actionItemInstance?.owners}">
				<li class="fieldcontain">
					<span id="owners-label" class="property-label"><g:message code="actionItem.owners.label" default="Owners" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${actionItemInstance?.retrospective}">
				<li class="fieldcontain">
					<span id="retrospective-label" class="property-label"><g:message code="actionItem.retrospective.label" default="Retrospective" /></span>
					
						<span class="property-value" aria-labelledby="retrospective-label"><g:link controller="retrospective" action="show" id="${actionItemInstance?.retrospective?.id}">${actionItemInstance?.retrospective?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${actionItemInstance?.id}" />
					<g:link class="edit" action="edit" id="${actionItemInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
