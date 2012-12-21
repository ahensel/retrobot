<%@ page import="retrobot.ActionItem" %>

<div class="discussionItemFormDisplay">
    %{--<g:textArea readonly= "readonly" name="discussionContent" value="${discussionItem.content}"/>--}%
    ${discussionItem.content}
</div>

<div class="fieldcontain ${hasErrors(bean: actionItemInstance, field: 'content', 'error')} ">
	<label for="content">
		<g:message code="actionItem.content.label" default="Content" />
		
	</label>
	<g:textArea name="content" value="${actionItemInstance?.content}"/>
</div>



<div class="fieldcontain ${hasErrors(bean: actionItemInstance, field: 'owners', 'error')} required">
	<label for="owners">
		<g:message code="actionItem.owners.label" default="Owners" />
		<span class="required-indicator">*</span>
	</label>
    <g:textField name="owners" value="${actionItemInstance?.content}"/>
</div>
<g:hiddenField name="discussionItemId" value="${discussionItem.id}"/>
%{--<g:hiddenField name="retroId" value="${retro.id}"/>--}%


