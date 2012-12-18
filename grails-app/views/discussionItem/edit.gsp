<%@ page import="retrobot.DiscussionItem" %>
<!DOCTYPE html>
<html>
	<head>
		%{--<meta name="layout" content="main">--}%
        <link rel="stylesheet" href="<g:createLinkTo dir='css' file='retro.css'/>"/>
        <r:layoutResources/>

        <g:set var="entityName" value="${message(code: 'discussionItem.label', default: 'DiscussionItem')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="edit-discussionItem" class="content scaffold-edit" role="main">
			<h1><g:message code="default.edit.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${discussionItem}">
			<ul class="errors" role="alert">
				<g:eachError bean="${discussionItem}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form method="post" >
				<g:hiddenField name="id" value="${discussionItem?.id}" />
				<g:hiddenField name="version" value="${discussionItem?.version}" />
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					<g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" formnovalidate="" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Delete this discussion Item?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
